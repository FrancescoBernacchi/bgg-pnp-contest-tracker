'use strict';
class LocalMaterialReader {
  constructor(root){this.root=root;this.abort=new AbortController();this.alive=true;}
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
        for(const block of blocks){
          if(block.kind==='paragraph'){const p=document.createElement('p');p.textContent=block.text;fragment.append(p);}
          else if(block.kind==='table'){const table=document.createElement('table');for(const cells of block.rows){const tr=document.createElement('tr');for(const text of cells){const td=document.createElement('td');td.textContent=text;tr.append(td);}table.append(tr);}const wrapper=document.createElement('div');wrapper.className='table-wrap';wrapper.append(table);fragment.append(wrapper);}
        }
        content.replaceChildren(fragment);
      }
      this.node('[data-material-status]').textContent='Documento pronto.';
    }catch(error){if(this.alive&&error.name!=='AbortError'){const status=this.node('[data-material-status]');status.textContent=error.message||'Documento non leggibile.';status.setAttribute('role','alert');}}
  }
  destroy(){this.alive=false;this.abort.abort();if(this.url)URL.revokeObjectURL(this.url);}
}
window.PnPViewers=Object.assign(window.PnPViewers||{},{material:LocalMaterialReader});
