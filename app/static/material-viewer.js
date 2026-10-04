'use strict';
class LocalMaterialReader {
  constructor(root){this.root=root;this.abort=new AbortController();this.alive=true;this.imageUrls=new Map();}
  node(selector){return this.root.querySelector(selector);}
  async response(url,token){const response=await fetch(url,{signal:this.abort.signal,cache:'no-store',headers:token?{'X-PnP-Viewer':token}:{}});if(!response.ok){let message='File non disponibile.';try{message=(await response.json()).error||message;}catch(_){}throw new Error(message);}return response;}
  async open(id,kind){
    try{
      const {token}=await(await this.response('/api/viewer-session')).json();
      const meta=await(await this.response(`/api/files/${id}`,token)).json();
      if(!this.alive)return;
      this.node('[data-material-title]').textContent=meta.original_filename;
      this.node('[data-material-meta]').textContent=`${meta.canonical_title} · ${meta.source_name} · Versione ${meta.version_raw||'non dichiarata'} · Acquisizione #${meta.acquisition_id}`;
      if(meta.viewer_kind!==kind||meta.viewer_status!=='ready')throw new Error('File non disponibile o formato non visualizzabile.');
      const response=await this.response(`/api/files/${id}/${kind}`,token);
      const content=this.node('[data-material-content]');
      if(kind==='png'){
        const blob=await response.blob();if(!this.alive)return;
        this.url=URL.createObjectURL(blob);
        const img=document.createElement('img');img.alt=meta.original_filename;img.src=this.url;
        await img.decode();if(!this.alive)return;
        this.root.classList.toggle('material-portrait',img.naturalHeight>=img.naturalWidth);
        content.replaceChildren(img);
        this.node('[data-material-zoom]').onchange=event=>content.classList.toggle('material-actual',event.target.value==='actual');
      }else{
        const {blocks}=await response.json();if(!this.alive)return;
        const fragment=document.createDocumentFragment();
        content.classList.add('docx-document');
        this.renderBlocks(blocks,fragment);
        content.replaceChildren(fragment);
      }
      this.node('[data-material-status]').textContent='Documento pronto.';
    }catch(error){if(this.alive&&error.name!=='AbortError'){const status=this.node('[data-material-status]');status.textContent=error.message||'Documento non leggibile.';status.setAttribute('role','alert');}}
  }
  style(node,values){
    const allowed=new Set(['fontWeight','fontStyle','fontSize','fontFamily','color','backgroundColor','textAlign','marginTop','marginBottom','marginLeft','marginRight','textIndent','lineHeight','verticalAlign','textDecoration']);
    for(const [key,value] of Object.entries(values||{}))if(allowed.has(key)&&typeof value==='string')node.style[key]=key==='fontFamily'?`${value}, Arial, sans-serif`:value;
  }
  renderBlocks(blocks,parent){
    let list=null,listId=null;
    for(const block of blocks){
      if(block.kind==='paragraph'){
        let p;
        if(block.list){
          const id=JSON.stringify([block.list.id,block.list.level,block.list.ordered]);
          if(id!==listId){list=document.createElement(block.list.ordered?'ol':'ul');list.className='docx-list';list.style.paddingLeft=`${Math.min(8,block.list.level+1)*1.5}em`;parent.append(list);listId=id;}
          p=document.createElement('li');list.append(p);
          const marker=document.createElement('span');marker.className='docx-marker';marker.setAttribute('aria-hidden','true');marker.textContent=block.list.marker+' ';p.append(marker);
        }else{list=null;listId=null;p=document.createElement(block.heading>=1&&block.heading<=6?`h${block.heading}`:'p');parent.append(p);}
        this.style(p,block.style);
        if(!block.runs){p.append(document.createTextNode(block.text||''));continue;}
        for(const run of block.runs){
          if(run.kind==='image'&&/^data:image\/(png|jpeg);base64,[A-Za-z0-9+/=]+$/.test(run.src||'')){
            if(!this.imageUrls.has(run.src)){
              const [header,data]=run.src.split(',');const bytes=Uint8Array.from(atob(data),c=>c.charCodeAt(0));
              this.imageUrls.set(run.src,URL.createObjectURL(new Blob([bytes],{type:header.includes('png')?'image/png':'image/jpeg'})));
            }
            const img=document.createElement('img');img.src=this.imageUrls.get(run.src);img.alt=run.alt||'Immagine del documento';img.className='docx-image';
            if(Number.isFinite(run.width))img.style.width=`${Math.max(1,Math.min(1200,run.width))}pt`;p.append(img);
          }else{const span=document.createElement('span');span.textContent=run.text||'';this.style(span,run.style);p.append(span);}
        }
        if(!p.textContent&&!p.querySelector('img'))p.append(document.createElement('br'));
      }else if(block.kind==='table'){
        list=null;listId=null;
        const table=document.createElement('table');
        for(const cells of block.cells||block.rows){const tr=document.createElement('tr');for(const cell of cells){const td=document.createElement('td');if(typeof cell==='string')td.textContent=cell;else{td.colSpan=Math.max(1,Math.min(100,cell.span||1));this.style(td,cell.style);this.renderBlocks(cell.blocks,td);}tr.append(td);}table.append(tr);}
        const wrapper=document.createElement('div');wrapper.className='table-wrap';wrapper.tabIndex=0;wrapper.setAttribute('role','region');wrapper.setAttribute('aria-label','Tabella del documento');wrapper.append(table);parent.append(wrapper);
      }
    }
  }
  destroy(){this.alive=false;this.abort.abort();if(this.url)URL.revokeObjectURL(this.url);for(const url of this.imageUrls.values())URL.revokeObjectURL(url);this.imageUrls.clear();}
}
window.PnPViewers=Object.assign(window.PnPViewers||{},{material:LocalMaterialReader});
