'use strict';
// Only local registered IDs are fetched. Decisions are displayed, never written.
window.PnPImages=class {
  constructor(root,game){
    this.root=root;this.game=game;this.abort=new AbortController();this.alive=true;this.urls=new Map();this.loading=new Map();this.queue=[];this.workers=0;
    root.innerHTML='<h2>Immagini</h2><p role="status">Lettura del catalogo immagini…</p>';this.open();
  }
  esc(value){return String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
  names={adopted:'Adottata',superseded:'Superata',not_adopted:'Non adottata',not_required:'Originale',pending:'Da valutare',approved:'Approvata',rejected:'Scartata',original:'Originale',ai_generated:'AI generata',ai_reworked:'AI rielaborata',derived:'Derivata',unknown:'Da chiarire',applicable:'Applicabile',desired:'Desiderata',not_applicable:'Non applicabile'};
  label(value){return this.names[value]||value||'Non dichiarato';}
  async response(url,guard=false){
    if(guard&&!this.token)this.token=(await(await this.response('/api/viewer-session')).json()).token;
    const r=await fetch(url,{signal:this.abort.signal,cache:'no-store',headers:guard?{'X-PnP-Viewer':this.token}:{}});
    if(!r.ok){let message='Immagine non disponibile.';try{message=(await r.json()).error||message;}catch(_){}throw Error(message);}return r;
  }
  async open(){
    try{this.data=await(await this.response(`/api/games/${this.game}/images`)).json();if(!this.alive)return;this.render();}
    catch(e){if(this.alive&&e.name!=='AbortError')this.root.innerHTML=`<h2>Immagini</h2><p role="alert">${this.esc(e.message)}</p>`;}
  }
  groups(){
    const files=this.data.files;
    return {adopted:files.filter(f=>f.is_current&&f.current_use==='adopted'&&f.validation_state!=='rejected'),
      ai:files.filter(f=>f.is_current&&f.origin_kind.startsWith('ai_')&&f.current_use!=='adopted'&&f.validation_state!=='rejected'),
      history:files.filter(f=>!f.is_current||f.current_use==='superseded'||f.validation_state==='rejected'||(f.current_use==='not_adopted'&&!f.origin_kind.startsWith('ai_')))};
  }
  card(f,side=''){
    const ready=f.local_status==='ready';
    return `<article class="img-card"><button type="button" data-image-open="${f.id}" aria-label="Apri ${this.esc(f.title)}"><span class="img-preview" data-image-thumb="${f.id}">${ready?'Miniatura in caricamento…':this.esc(f.local_status==='unsupported'?'Formato senza anteprima':'File locale non disponibile')}</span><strong>${this.esc(side?side+' · '+f.title:f.title)}</strong></button><p>${this.esc(f.categories.join(' · '))}</p><small>${this.esc(this.label(f.origin_kind))} · ${f.validation_state==='not_required'?'':this.esc(this.label(f.validation_state))+' · '}${this.esc(this.label(f.current_use))}${!f.is_current?' · Versione storica':''}</small><small>Immagine ${this.esc(f.version_raw)} · Materiale ${this.esc(f.material_version_raw||'non dichiarato')}${f.is_current&&this.data.principal?.image_id===f.image_id?' · Principale scelta':''}</small></article>`;
  }
  render(){
    if(!this.data.available){this.root.innerHTML='<h2>Immagini</h2><p>Catalogo immagini non ancora disponibile in questo database.</p>';return;}
    const e=v=>this.esc(v),g=this.groups(),cats=[...new Set([...this.data.files.flatMap(f=>f.categories),...(this.data.coverage||[]).map(c=>c.category)])].sort();
    this.root.innerHTML=`<h2>Immagini</h2><p class="subtitle">${g.adopted.length} adottate · ${g.ai.length} risultati AI fuori dalla raccolta adottata · ${g.history.length} file nello storico</p><p class="img-research">${this.data.research.length?this.data.research.map(r=>`${r.complete?'Ricerca conclusa':'Ricerca non conclusa'} · ${e(r.status)} · ${e(r.observed_at)}`).join('<br>'):'Ricerca immagini non ancora esplorata; nessuna assenza attestata.'}</p><div class="filters"><label class="field">Categoria<select data-image-category><option value="">Tutte le categorie</option>${cats.map(c=>`<option value="${e(c)}">${e(c)}</option>`).join('')}</select></label><label class="field">Provenienza<select data-image-origin><option value="">Tutte</option><option value="original">Originali e derivati</option><option value="ai">AI</option></select></label></div><div data-image-gallery></div><details class="img-components"><summary>Componenti e lati (${this.data.components.length})</summary><div data-image-components></div></details><details class="img-ai"><summary>Risultati AI da valutare o non adottati (${g.ai.length})</summary><p>Le valutazioni sono registrate tramite Codex dopo conferma dell’utente.</p><div data-image-ai></div></details><details class="img-history"><summary>Storico: immagini superate e scartate (${g.history.length})</summary><div data-image-history></div></details><details><summary>Ricerca e applicabilità per categoria</summary><div class="img-research-details"></div></details>`;
    this.root.querySelectorAll('select').forEach(n=>n.onchange=()=>this.renderLists());
    const typeFilter=document.createElement('label');typeFilter.className='field';
    typeFilter.innerHTML=`Sottotipo componente<select data-image-component-type><option value="">Tutti i sottotipi</option>${[...new Set(this.data.components.map(c=>c.type||'Non dichiarato'))].sort().map(t=>`<option value="${e(t)}">${e(t)}</option>`).join('')}</select>`;
    this.root.querySelector('.img-components > summary').after(typeFilter);
    typeFilter.querySelector('select').onchange=()=>this.renderLists();
    const main=this.data.main||{},file=this.data.files.find(f=>f.id===main.file_id);
    const representative=document.createElement('div');representative.className='img-main';
    representative.innerHTML=`<h3>${main.provisional?'Principale provvisoria':'Principale scelta'}</h3>${main.problem?'<p role="status">Il file della scelta esplicita non è disponibile per la visualizzazione. La scelta resta registrata; il fallback è temporaneo.</p>':''}${file?this.card(file):'<p>Segnaposto: nessuna Copertina o Setup adottata disponibile.</p>'}`;
    this.root.querySelector('.img-research').after(representative);
    const coverage=document.createElement('div');coverage.className='img-coverage table-wrap';
    coverage.innerHTML=`<h3>Copertura per categoria</h3><table><thead><tr><th>Categoria</th><th>Applicabilità</th><th>Ricerca</th><th>Originali</th><th>AI adottate</th><th>AI da valutare</th></tr></thead><tbody>${(this.data.coverage||[]).map(c=>`<tr><td><button data-image-cover="${e(c.category)}">${e(c.category)}</button></td><td>${e(this.label(c.applicability))}</td><td>${e(c.research_raw)}${c.verified_absence?' · Assenza originali verificata':''}</td><td>${c.original_count}</td><td>${c.ai_count}</td><td>${c.pending_count}</td></tr>`).join('')}</tbody></table>`;
    representative.after(coverage);
    coverage.onclick=event=>{const b=event.target.closest('[data-image-cover]');if(b){this.root.querySelector('[data-image-category]').value=b.dataset.imageCover;this.renderLists();}};
    this.root.addEventListener('click',this.click=event=>{const button=event.target.closest('[data-image-open]');if(button)this.zoom(Number(button.dataset.imageOpen));});
    const d=this.root.querySelector('.img-research-details');
    for(const r of this.data.research){
      const p=document.createElement('p');p.textContent=r.status+' · '+r.observed_at;d.append(p);
      const ul=document.createElement('ul');
      for(const c of r.categories){const li=document.createElement('li');li.textContent=`${c.category}: ${this.label(c.applicability)} · ${c.research_raw} · Originali ${c.original_count}; AI approvate ${c.ai_count}; AI da valutare ${c.pending_count}${c.verified_absence?' · Assenza originali verificata':''}`;ul.append(li);}d.append(ul);
      this.objectDetails(d,r.details.limits,'Limiti della ricerca');
    }
    this.observer=new IntersectionObserver(entries=>{for(const entry of entries)if(entry.isIntersecting){this.observer.unobserve(entry.target);this.enqueue(entry.target);}},{rootMargin:'160px'});
    this.renderLists();
  }
  renderLists(){
    this.observer?.disconnect();const cat=this.root.querySelector('[data-image-category]').value,origin=this.root.querySelector('[data-image-origin]').value;
    const matches=f=>(!cat||f.categories.includes(cat))&&(!origin||(origin==='ai')===f.origin_kind.startsWith('ai_'));
    this.shown=this.groups().adopted.filter(matches);
    for(const [selector,files] of [['[data-image-gallery]',this.shown],['[data-image-ai]',this.groups().ai.filter(matches)],['[data-image-history]',this.groups().history.filter(matches)]]){
      this.root.querySelector(selector).innerHTML=files.length?`<div class="img-grid">${files.map(f=>this.card(f)).join('')}</div>`:'<p class="empty">Nessuna immagine in questa sezione con i filtri selezionati.</p>';
    }
    const current=new Map(this.data.files.filter(f=>f.is_current).map(f=>[f.image_id,f]));
    const type=this.root.querySelector('[data-image-component-type]').value,groups=new Map();
    for(const c of this.data.components){const subtype=c.type||'Non dichiarato';if(type&&type!==subtype)continue;if(!groups.has(subtype))groups.set(subtype,[]);groups.get(subtype).push(c);}
    this.root.querySelector('[data-image-components]').innerHTML=[...groups].sort(([a],[b])=>a.localeCompare(b,'it')).map(([subtype,components])=>`<section class="img-component-group"><h3>${this.esc(subtype)} (${components.length})</h3>${components.map(c=>`<section class="img-component"><h4>${this.esc(c.label)}</h4><p>Revisione ${this.esc(c.material_revision||'non dichiarata')} · Occorrenze fisiche ${c.physical_count??'non dichiarate'}</p><div class="img-grid">${[...new Set(c.links.map(l=>l.image_id))].map(id=>current.get(id)).filter(f=>f&&matches(f)).map(f=>this.card(f,c.links.filter(l=>l.image_id===f.image_id).map(l=>l.side==='whole'?'Intero':l.side).join(' / '))).join('')}</div></section>`).join('')}</section>`).join('')||'<p>Nessun componente corrisponde al sottotipo selezionato.</p>';
    for(const node of this.root.querySelectorAll('[data-image-thumb]')){
      if(this.urls.has(Number(node.dataset.imageThumb)))this.setThumbnail(node,this.urls.get(Number(node.dataset.imageThumb)));
      else this.observer.observe(node);
    }
  }
  enqueue(node){const id=Number(node.dataset.imageThumb),f=this.data.files.find(f=>f.id===id);if(f.local_status!=='ready')return;this.queue.push(node);this.pump();}
  pump(){while(this.alive&&this.workers<2&&this.queue.length){const node=this.queue.shift();if(!node.isConnected)continue;this.workers++;this.thumbnail(node).finally(()=>{this.workers--;this.pump();});}}
  setThumbnail(node,url){if(!this.alive||!node.isConnected)return;const img=document.createElement('img');img.src=url;img.alt='';img.decoding='async';node.replaceChildren(img);}
  async thumbnail(node){
    const id=Number(node.dataset.imageThumb);
    try{
      if(!this.urls.has(id)){
        if(!this.loading.has(id))this.loading.set(id,(async()=>{
          const blob=await(await this.response(`/api/image-files/${id}/thumbnail`,true)).blob();if(this.alive&&!this.urls.has(id))this.urls.set(id,URL.createObjectURL(blob));
        })());
        try{await this.loading.get(id);}finally{this.loading.delete(id);}
      }
      if(!this.alive)return;
      for(const target of this.root.querySelectorAll(`[data-image-thumb="${id}"]`))this.setThumbnail(target,this.urls.get(id));
    }catch(e){if(this.alive&&e.name!=='AbortError'&&node.isConnected)node.textContent=e.message;}
  }
  objectDetails(parent,value,title){
    if(value===undefined||value===null)return;
    const block=document.createElement('details'),summary=document.createElement('summary');summary.textContent=title;block.append(summary);
    const render=(v,node)=>{if(v&&typeof v==='object'){const list=document.createElement('ul');for(const [key,item] of Object.entries(v)){const li=document.createElement('li');if(!Array.isArray(v)){const name=document.createElement('strong');name.textContent=key.replace(/_/g,' ')+': ';li.append(name);}render(item,li);list.append(li);}node.append(list);}else node.append(document.createTextNode(String(v??'Non dichiarato')));};
    render(value,block);parent.append(block);
  }
  details(parent,f){
    parent.replaceChildren();const info=document.createElement('p');info.textContent=`${f.title} · ${this.label(f.origin_kind)} · ${this.label(f.validation_state)} · ${this.label(f.current_use)} · Immagine ${f.version_raw} · Materiale ${f.material_version_raw||'non dichiarato'} · ${f.width} × ${f.height} · ${f.format}`;parent.append(info);
    if(f.material_revision?.status==='previous'){
      const notice=document.createElement('p');notice.className='img-revision-notice';notice.textContent='Estratta da una revisione precedente del materiale.';parent.append(notice);
      this.objectDetails(parent,f.material_revision.evidence,'Evidenza della successione dei materiali');
    }else if(f.extraction&&Object.keys(f.extraction).length&&f.material_revision?.status==='unknown'){
      const notice=document.createElement('p');notice.textContent='Ordine delle revisioni del materiale non attestato; la data di acquisizione non dimostra quale sia la revisione più recente.';parent.append(notice);
    }
    this.objectDetails(parent,f.credits,'Crediti dichiarati e ruoli');
    if(!f.credits.length){const p=document.createElement('p');p.textContent='Crediti dell’immagine non registrati.';parent.append(p);}
    const sources=document.createElement('details'),heading=document.createElement('summary');heading.textContent='Provenienze e originali';sources.append(heading);
    for(const p of f.provenances){const row=document.createElement('p');row.textContent=`${p.label||'Fonte'} · ${p.observed_at||f.observed_at} `;
      try{const u=new URL(p.source_url);if(['http:','https:'].includes(u.protocol)&&!u.username&&!u.password){const a=document.createElement('a');a.href=u.href;a.target='_blank';a.rel='noopener noreferrer';a.textContent='Apri fonte ↗';row.append(a);}}catch(_){}
      const id=p.acquired_file_id??p.document_id??p.source_document_id;if(Number.isSafeInteger(id)&&id>0){const a=document.createElement('a');a.href=`#pdf/${id}/game/${this.game}`;a.textContent=` · Documento originale #${id}`;row.append(a);}sources.append(row);
    }parent.append(sources);
    this.objectDetails(parent,f.conditions,'Condizioni e limiti d’uso');this.objectDetails(parent,f.contexts,'Contesti e revisione materiale');
    this.objectDetails(parent,f.regions,'Regioni fronte / retro / base e assemblaggio');this.objectDetails(parent,f.occurrences,'Occorrenze nei materiali');
    this.objectDetails(parent,f.relations,'Collegamenti e sostituzioni');this.objectDetails(parent,f.decisions,'Cronologia valutazioni AI');
    if(f.origin_kind.startsWith('ai_'))this.objectDetails(parent,f.generation,'Generazione dichiarata');
    this.objectDetails(parent,f.history,'Cronologia uso e revisione');
    const hash=document.createElement('p');hash.className='file-hash';hash.textContent='SHA-256: '+f.sha256;parent.append(hash);
  }
  zoom(id){
    this.dialog?.close();const f=this.data.files.find(f=>f.id===id);if(!f)return;
    const dialog=document.createElement('dialog');dialog.className='img-dialog';this.dialog=dialog;
    dialog.innerHTML='<div class="img-toolbar"><button data-image-close>Chiudi</button><button data-image-prev>← Precedente</button><button data-image-next>Successiva →</button><label>Zoom <select data-image-zoom><option value="fit">Adatta</option><option value="1">100%</option><option value="1.5">150%</option><option value="2">200%</option></select></label></div><p role="status" aria-live="polite" data-image-status></p><div class="img-zoom-surface" tabindex="0" role="region" aria-label="Immagine ingrandita"></div><div class="img-metadata"></div>';
    this.root.append(dialog);dialog.setAttribute('aria-label','Immagine e provenienze');dialog.showModal();
    dialog.querySelector('[data-image-close]').onclick=()=>dialog.close();
    let originalUrl=null;
    dialog.addEventListener('close',()=>{if(this.dialog===dialog)this.zoomVersion=(this.zoomVersion||0)+1;if(originalUrl)URL.revokeObjectURL(originalUrl);dialog.remove();});
    const peers=this.shown?.some(x=>x.id===id)?this.shown:this.data.files;
    let index=peers.findIndex(x=>x.id===id);
    const show=async()=>{
      const f=peers[index],version=this.zoomVersion=(this.zoomVersion||0)+1,status=dialog.querySelector('[data-image-status]'),surface=dialog.querySelector('.img-zoom-surface');
      status.textContent=`${index+1}/${peers.length} · ${f.title} · Caricamento…`;surface.replaceChildren();this.details(dialog.querySelector('.img-metadata'),f);
      dialog.querySelector('[data-image-prev]').disabled=index===0;dialog.querySelector('[data-image-next]').disabled=index===peers.length-1;
      try{const blob=await(await this.response(`/api/image-files/${f.id}/original`,true)).blob();if(!this.alive||version!==this.zoomVersion||!dialog.open)return;
        if(originalUrl)URL.revokeObjectURL(originalUrl);originalUrl=URL.createObjectURL(blob);
        const img=document.createElement('img');img.alt=f.title;img.src=originalUrl;await img.decode();if(version!==this.zoomVersion||!dialog.open)return;surface.replaceChildren(img);
        const zoom=dialog.querySelector('[data-image-zoom]');zoom.value='fit';zoom.onchange=()=>{surface.classList.toggle('img-actual',zoom.value!=='fit');img.style.width=zoom.value==='fit'?'':`${img.naturalWidth*Number(zoom.value)}px`;};
        status.textContent=`${index+1}/${peers.length} · ${f.title}`;
      }catch(e){if(this.alive&&version===this.zoomVersion&&e.name!=='AbortError')status.textContent=e.message;}
    };
    const move=delta=>{if(index+delta>=0&&index+delta<peers.length){index+=delta;show();}};
    dialog.querySelector('[data-image-prev]').onclick=()=>move(-1);dialog.querySelector('[data-image-next]').onclick=()=>move(1);
    dialog.onkeydown=e=>{if(e.target.tagName==='SELECT')return;if(e.key==='ArrowLeft'||e.key==='ArrowRight'){e.preventDefault();move(e.key==='ArrowLeft'?-1:1);}};show();
  }
  destroy(){this.alive=false;this.abort.abort();this.observer?.disconnect();this.queue=[];this.dialog?.close();for(const url of this.urls.values())URL.revokeObjectURL(url);this.urls.clear();this.root.removeEventListener('click',this.click);}
};
window.PnPListImages=class {
  constructor(root){
    this.root=root;this.abort=new AbortController();this.alive=true;this.urls=new Map();this.loading=new Map();this.queue=[];this.workers=0;
    this.data={files:[...new Set([...root.querySelectorAll('[data-image-thumb]')].map(n=>Number(n.dataset.imageThumb)))].map(id=>({id,local_status:'ready'}))};
    this.observer=new IntersectionObserver(entries=>{for(const e of entries)if(e.isIntersecting){this.observer.unobserve(e.target);this.enqueue(e.target);}},{rootMargin:'160px'});
    for(const n of root.querySelectorAll('[data-image-thumb]'))this.observer.observe(n);
  }
};
for(const method of ['response','enqueue','pump','setThumbnail','thumbnail','destroy'])window.PnPListImages.prototype[method]=window.PnPImages.prototype[method];
