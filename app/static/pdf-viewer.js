'use strict';
// Core renderer only: no generic PDF viewer, scripting, annotations or attachments.
let pdfEnginePromise;
const loadPdfEngine=()=>pdfEnginePromise||(pdfEnginePromise=import('/vendor/pdfjs/build/pdf.mjs'));
const pdfMessage=error=>({PasswordException:'PDF cifrato: la lettura con password non è supportata in questo incremento.',InvalidPDFException:'PDF danneggiato o non valido.',MissingPDFException:'Il file locale non è più presente.',UnknownErrorException:'PDF non leggibile o formato non supportato.',RenderingCancelledException:'Rendering annullato.'}[error?.name]||'Impossibile leggere questo PDF. Riapri il documento o torna alla Libreria.');
class LocalPdfReader {
  constructor(root, dependencies={}) {
    this.root=root;
    this.fetch=dependencies.fetch||fetch.bind(window);
    this.engine=dependencies.engine||loadPdfEngine;
    this.abort=new AbortController();
    this.alive=true;this.page=1;this.zoom='fit';this.generation=0;this.renderQueue=Promise.resolve();
  }
  node(selector){return this.root.querySelector(selector);}
  status(text,error=false){if(this.alive){this.node('[data-pdf-status]').textContent=text;this.node('[data-pdf-status]').setAttribute('role',error?'alert':'status');}}
  async response(url,token) {
    const result=await this.fetch(url,{signal:this.abort.signal,cache:'no-store',headers:token?{'X-PnP-Viewer':token}:{}});
    if(!result.ok){let text='Documento non disponibile.';try{text=(await result.json()).error||text;}catch(_){}throw new Error(text);}
    return result;
  }
  async open(id) {
    this.status('Caricamento PDF…');
    try {
      const session=await (await this.response('/api/viewer-session')).json();
      const meta=await (await this.response(`/api/files/${id}`,session.token)).json();
      if(!this.alive)return;
      this.node('[data-pdf-title]').textContent=meta.original_filename;
      this.node('[data-pdf-meta]').textContent=`${meta.canonical_title} · ${meta.source_name||'Fonte non determinabile'} · Versione: ${meta.version_raw||'Non dichiarata'} · Acquisizione #${meta.acquisition_id} · ${meta.acquired_at}`;
      if(meta.viewer_status!=='ready')throw new Error(({missing:'Il file locale non è più presente.',invalid_path:'Percorso locale non autorizzato.',not_pdf:'Il contenuto locale non è un PDF.',corrupt:'PDF incompleto o danneggiato.',too_large:'PDF oltre il limite di visualizzazione di 128 MiB.',unsupported:'Formato non supportato dal visualizzatore PDF.'})[meta.viewer_status]||'File non disponibile o non verificabile.');
      const response=await this.response(`/api/files/${id}/pdf`,session.token);
      const size=Number(response.headers.get('Content-Length'));
      if(size>128*1024*1024)throw new Error('PDF oltre il limite di 128 MiB.');
      const data=new Uint8Array(await response.arrayBuffer());
      if(!this.alive)return;
      const engine=await this.engine();
      if(!this.alive)return;
      engine.GlobalWorkerOptions.workerSrc='/vendor/pdfjs/build/pdf.worker.mjs';
      this.task=engine.getDocument({data,isEvalSupported:false,enableXfa:false,useWasm:false,useWorkerFetch:false,
        cMapUrl:'/vendor/pdfjs/cmaps/',cMapPacked:true,standardFontDataUrl:'/vendor/pdfjs/standard_fonts/',
        iccUrl:'/vendor/pdfjs/iccs/',wasmUrl:'/vendor/pdfjs/wasm/',
        disableRange:true,disableStream:true,disableAutoFetch:true,stopAtErrors:true,maxImageSize:-1,canvasMaxAreaInBytes:67108864});
      this.task.onPassword=()=>{this.encrypted=true;this.status(pdfMessage({name:'PasswordException'}),true);this.task.destroy().catch(()=>{});};
      this.document=await this.task.promise;
      if(!this.alive)return;
      this.node('[data-pdf-count]').textContent=`di ${this.document.numPages}`;
      this.node('[data-pdf-page]').max=this.document.numPages;
      this.bind();await this.render();
    } catch(error) {
      if(this.alive&&error.name!=='AbortError')this.status(this.encrypted?pdfMessage({name:'PasswordException'}):error.name==='Error'?error.message:pdfMessage(error),true);
    }
  }
  bind() {
    this.node('[data-pdf-prev]').onclick=()=>this.setPage(this.page-1);
    this.node('[data-pdf-next]').onclick=()=>this.setPage(this.page+1);
    this.node('[data-pdf-page]').disabled=false;
    this.node('[data-pdf-page]').onchange=event=>this.setPage(Number(event.target.value));
    this.node('[data-pdf-zoom]').disabled=false;
    this.node('[data-pdf-zoom]').onchange=event=>{this.zoom=event.target.value;this.render();};
    this.root.onkeydown=event=>{
      if(['INPUT','SELECT','TEXTAREA'].includes(event.target.tagName)||event.altKey||event.ctrlKey||event.metaKey)return;
      if(event.key==='ArrowRight'||event.key==='PageDown'){event.preventDefault();this.setPage(this.page+1);}
      if(event.key==='ArrowLeft'||event.key==='PageUp'){event.preventDefault();this.setPage(this.page-1);}
    };
    this.observer=typeof ResizeObserver==='function'?new ResizeObserver(()=>{const width=this.node('[data-pdf-surface]').clientWidth;if(width!==this.lastWidth){this.lastWidth=width;if(this.zoom==='fit'&&this.document)this.render();}}):null;
    this.observer?.observe(this.node('[data-pdf-surface]'));
  }
  setPage(page){if(!Number.isInteger(page)||page<1||page>this.document.numPages){this.node('[data-pdf-page]').value=this.page;return;}this.page=page;return this.render();}
  render() {
    if(!this.alive||!this.document)return Promise.resolve();
    const generation=++this.generation,number=this.page;
    this.renderTask?.cancel();
    this.status(`Caricamento pagina ${number}…`);
    this.renderQueue=this.renderQueue.catch(()=>{}).then(async()=>{
      if(!this.alive||generation!==this.generation)return;
      const page=await this.document.getPage(number);
      if(!this.alive||generation!==this.generation)return;
      const base=page.getViewport({scale:1});
      const available=Math.max(100,this.node('[data-pdf-surface]').clientWidth-32);
      const scale=this.zoom==='fit'?Math.min(4,available/base.width):Number(this.zoom);
      const viewport=page.getViewport({scale});
      // One page at a time, bounded pixel budget, including high-DPI screens.
      const ratio=Math.min(window.devicePixelRatio||1,2,Math.sqrt(16777216/(viewport.width*viewport.height)));
      const canvas=this.node('canvas');
      canvas.width=Math.max(1,Math.floor(viewport.width*ratio));canvas.height=Math.max(1,Math.floor(viewport.height*ratio));
      canvas.style.width=`${Math.floor(viewport.width)}px`;canvas.style.height=`${Math.floor(viewport.height)}px`;
      canvas.setAttribute('aria-label',`Pagina ${number} di ${this.document.numPages}`);
      this.renderTask=page.render({canvasContext:canvas.getContext('2d'),viewport,transform:ratio!==1?[ratio,0,0,ratio,0,0]:null,annotationMode:0});
      await this.renderTask.promise;
      if(!this.alive||generation!==this.generation)return;
      this.node('[data-pdf-page]').value=number;
      this.node('[data-pdf-prev]').disabled=number===1;this.node('[data-pdf-next]').disabled=number===this.document.numPages;
      this.status(`Pagina ${number} di ${this.document.numPages} · ${Math.round(scale*100)}%`);
      const text=await page.getTextContent();
      if(!this.alive||generation!==this.generation)return;
      const plain=text.items.map(item=>item.str+(item.hasEOL?'\n':' ')).join('');
      this.node('[data-pdf-text]').textContent=plain?plain.slice(0,250000)+(plain.length>250000?'\n[Testo troncato]':''):'Questa pagina non contiene testo estraibile.';
      page.cleanup();
    }).catch(error=>{if(this.alive&&generation===this.generation&&error.name!=='RenderingCancelledException')this.status(pdfMessage(error),true);});
    return this.renderQueue;
  }
  destroy(){this.alive=false;this.generation++;this.abort.abort();this.renderTask?.cancel();this.observer?.disconnect();this.task?.destroy().catch(()=>{});this.root.onkeydown=null;}
}
window.PnPViewers={pdf:LocalPdfReader};
