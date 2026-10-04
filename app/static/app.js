'use strict';
const $ = (selector) => document.querySelector(selector);
const esc = (value) => String(value ?? '—').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const labels = {pnp_core:'PnP principali',adjacent:'Adiacenti',standard:'Gioco PnP autonomo',format_adjacent:'Formato adiacente',selective_entries:'Entry selezionate',dependent_variants:'Varianti dipendenti',standalone_game:'Gioco autonomo',dependent_variant:'Variante dipendente',none:'Nessuna',required:'Gioco base richiesto',unknown:'Non noto',entries_open:'Entry aperte',development:'In sviluppo',freeze:'Freeze',voting:'Votazione',awaiting_results:'In attesa dei risultati',complete:'Concluso',announced:'Annunciato',suspended:'Sospeso',cancelled:'Annullato',idea:'Idea',wip:'In lavorazione',components_available:'Componenti disponibili',playtest_ready:'Pronto al playtest',contest_ready:'Pronto al contest',withdrawn:'Ritirata',incomplete:'Incompleta',disqualified:'Squalificata',available:'Disponibili',unavailable:'Non disponibili',no_change:'Nessuna variazione dichiarata',partial:'Parziale',status_raw:'Stato originale',status_normalized:'Stato normalizzato',materials_status_raw:'Materiali · originale',materials_status_normalized:'Materiali · normalizzato',position:'Posizione nella lista',numeric_value:'Valore numerico',text_value:'Valore testuale',unit:'Unità',method:'Metodo',is_official:'Ufficiale (1=sì, 0=no)',starts_at:'Inizio',ends_at:'Fine'};
const label = value => labels[value] || value || 'Non noto';
labels.playtest='Playtest';
labels.active='In corso';
labels.planned='Pianificata';
Object.assign(labels,{candidate:'Corrispondenza da valutare',confirmed:'Corrispondenza confermata',rejected:'Corrispondenza respinta',declared:'Dichiarata dalla fonte',verified:'Verificata',uncertain:'Incerta',not_checked:'Non verificata',boardgamegeek:'BoardGameGeek',kanare_abstract:'Kanare_Abstract'});
const day = value => {
  if (!value) return 'Non registrata';
  const parts = String(value).match(/^(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}:\d{2})(?::\d{2})?(Z|[+-]\d{2}:\d{2})?)?$/);
  if (!parts) return value;
  return `${parts[3]}/${parts[2]}/${parts[1]}${parts[4]?` · ${parts[4]}${parts[5]?` UTC${parts[5]==='Z'?'':parts[5]}`:''}`:''}`;
};
const badge = value => `<span class="badge ${['entries_open','development','playtest_ready','contest_ready'].includes(value)?'open':['voting','awaiting_results'].includes(value)?'voting':value==='complete'?'done':['withdrawn','cancelled','partial'].includes(value)?'warn':''}">${esc(label(value))}</span>`;
function source(url, date, linkLabel='Fonte BGG ↗') {
  let link = '';
  try {
    const parsed = new URL(url);
    // Solo pagine BGG di metadati. File, download, host esterni e schemi attivi non diventano link.
    if (parsed.protocol === 'https:' && ['boardgamegeek.com','www.boardgamegeek.com'].includes(parsed.hostname) && !parsed.port && !parsed.username && !parsed.password && /^\/(thread|geeklist|boardgame|boardgameexpansion|guild|forum)\/\d+(\/|$)/.test(parsed.pathname)) {
      link = `<a href="${esc(parsed.href)}" target="_blank" rel="noopener noreferrer">${esc(linkLabel)}</a>`;
    }
  } catch (_) { /* URL mancante o non navigabile */ }
  if (!link && url) link = `<span>Fonte registrata: ${esc(url)}</span>`;
  return `<div class="source">${link || 'Fonte non registrata'}${date ? `<br>Verificato: ${esc(day(date))}` : ''}</div>`;
}
function externalLink(url, text) {
  try {
    const parsed=new URL(url);
    if(parsed.protocol==='https:'&&!parsed.username&&!parsed.password)
      return `<a href="${esc(parsed.href)}" target="_blank" rel="noopener noreferrer">${esc(text)} ↗</a>`;
  } catch (_) { /* URL non apribile */ }
  return `<span>${esc(text)} · URL non apribile</span>`;
}
const fact = (title, value) => `<div class="fact"><small>${esc(title)}</small><span>${esc(value ?? 'Non registrato')}</span></div>`;
const table = (headers, body) => body.length ? `<div class="table-wrap" tabindex="0" role="region" aria-label="Tabella scorrevole"><table><thead><tr>${headers.map(h=>`<th scope="col">${esc(h)}</th>`).join('')}</tr></thead><tbody>${body.join('')}</tbody></table></div>` : '<div class="empty">Nessun dato registrato per questa sezione.</div>';
const heading = (eyebrow, title, subtitle) => `<div class="page-heading"><div><p class="eyebrow">${esc(eyebrow)}</p><h1>${esc(title)}</h1><p class="subtitle">${esc(subtitle)}</p></div><span class="stamp">● Sola lettura</span></div>`;
const options = (values, first) => `<option value="">${esc(first)}</option>` + [...new Set(values.filter(v=>v!==null && v!==undefined))].sort().map(v=>`<option value="${esc(v)}">${esc(label(v))}</option>`).join('');
let data = null, routeVersion = 0;
const filters = {scope:'',contestState:'',year:'',query:'',entryQuery:'',entryState:'',entryKind:'',entryScope:'',entryContest:'',entryYear:'',entryMaterials:'',entrySort:'title',page:1};
const gameFilters={query:'',source:'',ambiguity:'',kind:'all'};
let libraryData=null, activePdfReader=null;
const libraryFilters={query:'',game:'',contest:'',source:'',year:'',language:'',type:'',status:'',presence:'',sort:'title',page:1};
const libraryLabels={present:'File acquisito e presente',missing:'File acquisito ma mancante localmente',invalid_path:'Percorso rifiutato',unverifiable:'Presenza non verificabile',acquired:'Acquisito (completezza non determinabile)',failed:'Acquisizione fallita',partial:'Acquisizione parziale',unavailable:'Risorsa remota indisponibile',not_observable:'Risorsa non osservabile',access_restricted:'Accesso ristretto',excluded:'Materiale escluso',none_declared:'Nessuna risorsa dichiarata',unknown:'Stato non determinabile'};
const libraryLabel=value=>value==='available'?'Disponibile (dato registrato)':libraryLabels[value]||value||'Non registrato';
function bytes(value) {return value==null?'Non registrata':value<1024?`${value} B`:value<1048576?`${(value/1024).toFixed(1)} KiB`:`${(value/1048576).toFixed(1)} MiB`;}
function matchingLibrary() {
  const f=libraryFilters,q=f.query.trim().toLocaleLowerCase();
  const files=libraryData.files.filter(x=>(!q||[x.canonical_title,x.original_filename,x.version_raw,x.sha256,x.source_name].join(' ').toLocaleLowerCase().includes(q))&&(!f.game||String(x.game_id)===f.game)&&(!f.contest||x.contests.some(c=>String(c.id)===f.contest))&&(!f.source||x.source_key===f.source)&&(!f.year||x.contests.some(c=>String(c.year)===f.year))&&(!f.language||(x.language_code||'Non registrato')===f.language)&&(!f.type||(x.media_type||'Non registrato')===f.type)&&(!f.status||x.acquisition_status===f.status||x.batch_status===f.status)&&(!f.presence||x.local_status===f.presence));
  const field={title:'canonical_title',date:'acquired_at',size:'byte_size',name:'original_filename'}[f.sort]||'canonical_title';
  return files.sort((a,b)=>(field==='byte_size'?b[field]-a[field]:field==='acquired_at'?String(b[field]).localeCompare(String(a[field])):String(a[field]||'').localeCompare(String(b[field]||''),'it'))||a.id-b.id);
}
function viewerLink(file, origin='library') {
  if(['pdf','png','docx'].includes(file.viewer_kind)&&file.viewer_status==='ready')return `<a class="pdf-open" href="#${file.viewer_kind}/${file.id}/${origin}">Visualizza ${esc(file.viewer_kind.toUpperCase())}</a>`;
  const messages={unsupported:'Formato non visualizzabile',too_large:'File oltre il limite di visualizzazione',not_pdf:'Contenuto non PDF',corrupt:'File incompleto o danneggiato',invalid_path:'Percorso rifiutato',missing:'File mancante'};
  return `<small>${esc(messages[file.viewer_status]||'Visualizzazione non disponibile')}</small>`;
}
function groupedLibrary(files) {
  const games=new Map();
  for(const file of files){if(!games.has(file.game_id))games.set(file.game_id,{id:file.game_id,title:file.canonical_title,files:[]});games.get(file.game_id).files.push(file);}
  const groups=[...games.values()],sort=libraryFilters.sort;
  return groups.sort((a,b)=>(sort==='size'?b.files.reduce((n,f)=>n+f.byte_size,0)-a.files.reduce((n,f)=>n+f.byte_size,0):sort==='date'?b.files.map(f=>f.acquired_at).sort().at(-1).localeCompare(a.files.map(f=>f.acquired_at).sort().at(-1)):sort==='name'?a.files[0].original_filename.localeCompare(b.files[0].original_filename,'it'):a.title.localeCompare(b.title,'it'))||a.id-b.id);
}
function materialPresentation(file) {
  const name=file.original_filename||'', stem=name.replace(/\.[^.]+$/,'');
  const text=stem.toLowerCase().replace(/[_-]+/g,' '), categories=[];
  const add=(label,icon,pattern)=>{if(pattern.test(text))categories.push({label,icon});};
  add('Regolamento','📖',/rule\s*book|rules|regolamento|regras|manual/);
  add('Carte','🃏',/cards?|cartas|carte/);
  const player=/player\s*boards?|plancia/.test(text);
  if(player)categories.push({label:'Plancia giocatore',icon:'▦'});
  else add('Tabellone','▧',/board|tabellone|gameboard|mainboard|\bmaps?\b/);
  add('Schede di gioco','▤',/sheets?|playsheet|folha/);
  add('Segnalini','●',/tokens?|scoring tiles|segnalini/);
  add('Scatola','□',/tuckbox/);
  add('Istruzioni di stampa','🖨',/printing instructions/);
  const variants=[], evidence=[];
  if(file.language_code && file.language_code!=='unknown' && file.language_code!=='und') {
    variants.push(file.language_code.toUpperCase());evidence.push('Lingua: metadato registrato');
  } else {
    const language=/\bpt br\b|portugu[eê]s/.test(text)?'PT-BR':/\b(en|eng|english)\b/.test(text)?'EN':/\b(it|italian|italiano)\b/.test(text)?'IT':null;
    if(language){variants.push(language+'?');evidence.push('Lingua: inferita dal nome originale');}
  }
  const flags=[[/\bcolou?r\b/,'COL'],[/black white|gray scale|greyscale|grayscale|bianco.*nero/,'B/N'],[/low\s*ink/,'LOW INK'],[/printer friendly/,'PF'],[/\ba4\b/,'A4'],[/\b(ltr|letter)\b/,'LTR']];
  for(const [pattern,label] of flags)if(pattern.test(text)){variants.push(label+'?');evidence.push(label+': dichiarazione nel nome, contenuto non verificato');}
  const dpi=text.match(/\b(\d+)\s*dpi\b/),pixels=text.match(/\b(\d{3,5})\s*[x×]\s*(\d{3,5})\s*px\b/);
  if(dpi){variants.push(dpi[1]+'dpi?');evidence.push('DPI: dichiarati nel nome, non misurati');}
  if(pixels){variants.push(pixels[1]+'×'+pixels[2]+'px?');evidence.push('Pixel: dichiarati nel nome, non misurati');}
  const quality=text.match(/\b(high|low)\s*(resolution|quality)\b/);
  if(quality){variants.push((quality[1]==='high'?'HQ':'LQ')+'?');evidence.push('Qualità: dichiarata nel nome, non misurata');}
  const category=categories.length>1?'Misto: '+categories.map(c=>c.label).join(' + '):categories[0]?.label||'Altro / contenuto non determinato';
  return {icon:categories.length>1?'◈':categories[0]?.icon||'◇',category,
    description:category+(variants.length?' ['+variants.join(' · ')+']':''),
    evidence:[categories.length?'Contenuto: inferito dal nome originale':'Contenuto: non determinabile dal nome',...evidence],stem};
}
function libraryFileIcon(file) {
  const presentation=materialPresentation(file);
  const title=`${file.original_filename} · File #${file.id}${file.archive_origin?' · '+file.archive_origin.member_path:''} · ${file.media_type||'Formato non registrato'} · ${bytes(file.byte_size)} · Versione ${file.version_raw||'non dichiarata'} · Acquisizione #${file.acquisition_id} · ${file.source_name}`;
  const icon=presentation.icon;
  const ready=['pdf','png','docx'].includes(file.viewer_kind)&&file.viewer_status==='ready';
  return `<div class="library-file"><div class="library-file-main">${ready?`<a class="file-icon" href="#${file.viewer_kind}/${file.id}/library" title="${esc(title)}" aria-label="Apri ${esc(title)}"><span aria-hidden="true">${icon}</span></a>`:`<button class="file-icon unavailable" type="button" data-file-details="${file.id}" title="${esc(title)}; visualizzazione non disponibile" aria-label="Dettagli ${esc(title)}; visualizzazione non disponibile"><span aria-hidden="true">${icon}</span></button>`}<span>${esc(bytes(file.byte_size))}</span><span class="material-description">${esc(presentation.description)}<small>${esc(presentation.stem)}</small></span></div><details id="file-details-${file.id}"><summary aria-label="Dettagli ${esc(title)}">Dettagli</summary><p>${esc(file.original_filename)} · File #${file.id}</p><p>${esc(presentation.evidence.join("; "))}. Attributi omessi: non determinati.</p><p>${esc(file.media_type||'Formato non registrato')} · Lingua: ${esc(file.language_code||'non registrata')} · Versione: ${esc(file.version_raw||'non dichiarata')}</p><p>Acquisizione #${file.acquisition_id} · ${esc(day(file.acquired_at))} · ${esc(libraryLabel(file.acquisition_status))} · ${esc(libraryLabel(file.local_status))}</p><p>Lotto: ${esc(libraryLabel(file.batch_status))} · Remoto: ${esc(libraryLabel(file.remote_status))}</p><p>${esc(file.source_name)}${file.contests?.map(c=>` · ${esc(c.name)} (${esc(c.year)})`).join('')||''} ${file.source_url?externalLink(file.source_url,'Fonte'):''}</p><p>${esc(file.usage_conditions||'Condizioni non registrate')}</p><p class="file-hash">SHA-256: ${esc(file.sha256)}</p>${file.archive_origin?`<p>Archivio #${file.archive_origin.archive_file_id} · Membro: ${esc(file.archive_origin.member_path)} · Estratto: ${esc(day(file.archive_origin.extracted_at))}</p><p class="file-hash">Hash archivio: ${esc(file.archive_origin.archive_sha256)}</p>`:''}${file.extraction?`<p>Estrazione: ${esc(file.extraction.status)} · ${esc(file.extraction.message)}</p>`:file.original_filename.toLowerCase().endsWith('.zip')?'<p>Archivio non ancora estratto; elaborazione offline richiesta.</p>':''}${ready?'':viewerLink(file)}</details></div>`;
}
function libraryGameRows(groups) {
  return `<details class="material-legend"><summary>Legenda contenuti e varianti</summary><p>📖 Regolamento · 🃏 Carte · ▧ Tabellone · ▦ Plancia giocatore · ▤ Schede di gioco · ● Segnalini · □ Scatola · 🖨 Istruzioni di stampa · ◈ Misto · ◇ Altro / non determinato.</p><p>EN/IT/PT-BR: lingua · COL: colore · B/N: bianco e nero o scala di grigi · LOW INK: poco inchiostro · PF: adatto alla stampa · A4/LTR: carta · dpi: risoluzione di stampa · px: dimensioni pixel · HQ/LQ: qualità dichiarata alta/bassa. ?: attributo inferito dal nome, non verificato nel contenuto. Gli attributi ignoti sono omessi. Nome originale e versioni nei dettagli.</p></details>`+table(['Gioco','Materiali corrispondenti'],groups.map(g=>`<tr><td><a href="#game/${g.id}">${esc(g.title)}</a><small>${g.files.length} file corrispondenti</small></td><td><div class="library-files">${g.files.map(libraryFileIcon).join('')}</div></td></tr>`));
}
function localFileRows(files,origin='library') {
  return table(['Gioco / provenienza','File / versione','Acquisizione / presenza','Metadati'],files.map(x=>`<tr><td><a href="#game/${x.game_id}">${esc(x.canonical_title)}</a><small>${esc(x.source_name)}${x.contests.map(c=>` · ${esc(c.name)} (${esc(c.year)})`).join('')}</small></td><td>${esc(x.original_filename)}${viewerLink(x,origin)}<small>MIME: ${esc(x.media_type||'Non registrato')} · Lingua: ${esc(x.language_code||'Non registrata')}</small><small>Versione: ${esc(x.version_raw||'Non dichiarata')} · ${esc(bytes(x.byte_size))}</small></td><td>${esc(day(x.acquired_at))}<small>Acquisizione #${x.acquisition_id}: ${esc(libraryLabel(x.acquisition_status))}</small><span class="badge ${x.local_present?'':'warn'}">${esc(libraryLabel(x.local_status))}</span><small>Lotto: ${esc(libraryLabel(x.batch_status||'unknown'))}</small><small>Remoto: ${esc(libraryLabel(x.remote_status))}</small></td><td><details><summary>Hash, fonte e condizioni</summary><p class="file-hash">SHA-256: ${esc(x.sha256||'Non registrato')}</p>${x.archive_origin?`<p>Archivio #${x.archive_origin.archive_file_id} · Membro: ${esc(x.archive_origin.member_path)} · File #${x.id}</p>`:''}<p>${x.source_url?externalLink(x.source_url,'Risorsa di provenienza'):'URL non registrato o non sicuro'}</p><p>Condizioni d’uso: ${esc(x.usage_conditions||'Non registrate')}</p></details></td></tr>`));
}
function localMaterials(library) {
  if(!library)return '<h2>Materiali locali</h2><p>Dati non disponibili.</p>';
  return '<h2>Materiali locali</h2><p class="subtitle">Acquisizioni distinte per ID e data. Completezza non determinabile dal solo numero di file; lo stato remoto è indipendente dalla presenza locale.</p>'+(library.acquisitions.length?library.acquisitions.map(a=>`<details><summary>Acquisizione #${a.id} · ${esc(day(a.acquired_at))} · ${a.files.length} file · ${esc(libraryLabel(a.status||'unknown'))} · completezza non determinabile</summary>${localFileRows(a.files,`game/${a.game_id}`)}</details>`).join(''):'<div class="empty">Nessuna acquisizione registrata per questo gioco.</div>');
}
function libraryResults() {
  const files=matchingLibrary(),groups=groupedLibrary(files),pages=Math.max(1,Math.ceil(groups.length/50));
  libraryFilters.page=Math.min(libraryFilters.page,pages);
  $('#library-results').innerHTML=`<p>${groups.length} giochi · ${files.length} file corrispondenti · pagina ${libraryFilters.page} di ${pages}</p><p class="subtitle">Ogni gioco mostra soltanto i file corrispondenti ai filtri. 50 giochi per pagina; dimensione = somma dei file filtrati, data = acquisizione più recente, nome = primo file nell'ordine alfabetico.</p>`+libraryGameRows(groups.slice((libraryFilters.page-1)*50,libraryFilters.page*50))+`<div class="filters"><button id="library-prev" ${libraryFilters.page===1?'disabled':''}>Precedente</button><button id="library-next" ${libraryFilters.page===pages?'disabled':''}>Successiva</button></div>`;
  document.querySelectorAll('[data-file-details]').forEach(button=>button.onclick=()=>{const details=document.getElementById(`file-details-${button.dataset.fileDetails}`);details.open=true;details.querySelector('summary').focus();});
  $('#library-prev').onclick=()=>{libraryFilters.page--;libraryResults();};
  $('#library-next').onclick=()=>{libraryFilters.page++;libraryResults();};
}
function renderLibrary(library) {
  libraryData=library;
  const s=library.summary;
  const select=(key,title,values)=>`<label class="field">${esc(title)}<select id="library-${key}"><option value="">Tutti</option>${[...new Map(values.map(v=>[String(v[0]),v])).values()].map(v=>`<option value="${esc(v[0])}">${esc(v[1])}</option>`).join('')}</select></label>`;
  const values=key=>library.files.map(x=>[x[key]||'Non registrato',x[key]||'Non registrato']);
  $('#main').innerHTML=heading('MATERIALI ACQUISITI','Libreria','Metadati registrati e presenza verificata sotto library/. Nessuna anteprima o apertura automatica.')+(!library.library_available?'<div class="notice">Libreria locale assente o non disponibile. I record restano consultabili.</div>':'')+`<div class="facts">${fact('Giochi con file',s.games)}${fact('Acquisizioni',s.acquisitions)}${fact('File',s.files)}${fact('Dimensione registrata',bytes(s.bytes))}${fact('Presenti',s.present)}${fact('Mancanti',s.missing)}${fact('Rifiutati / non verificabili',s.unverifiable)}</div><details><summary>Distribuzione dei file per contest, fonte, lingua e tipo</summary>${['contests','sources','languages','types'].map(k=>table([({contests:'Contest',sources:'Fonte',languages:'Lingua',types:'MIME'})[k],'File'],s[k].map(r=>`<tr><td>${esc(r.value)}</td><td>${r.files}</td></tr>`))).join('')}</details><div class="filters"><label class="field grow">Testo<input id="library-query" type="search" value="${esc(libraryFilters.query)}"></label>${select('game','Gioco',library.files.map(x=>[x.game_id,x.canonical_title]))}${select('contest','Contest',library.files.flatMap(x=>x.contests.map(c=>[c.id,c.name])))}${select('source','Fonte',library.files.map(x=>[x.source_key,x.source_name]))}${select('year','Anno contest',library.files.flatMap(x=>x.contests.map(c=>[c.year,c.year])))}${select('language','Lingua',values('language_code'))}${select('type','Tipo MIME',values('media_type'))}${select('status','Stato acquisizione',[...values('acquisition_status'),...values('batch_status')].map(v=>[v[0],libraryLabel(v[0])]))}${select('presence','Presenza locale',['present','missing','invalid_path','unverifiable'].map(v=>[v,libraryLabel(v)]))}${select('sort','Ordina per',[['title','Titolo del gioco'],['date','Data più recente'],['size','Dimensione decrescente'],['name','Nome del file']])}</div><div id="library-results" aria-live="polite"></div>`+`<details><summary>Acquisizioni senza file (${library.acquisitions.filter(a=>!a.files.length).length})</summary>${localMaterials({acquisitions:library.acquisitions.filter(a=>!a.files.length)})}</details>`;
  for(const key of Object.keys(libraryFilters).filter(k=>k!=='page')) {
    const el=$(`#library-${key}`);el.value=libraryFilters[key];
    el[key==='query'?'oninput':'onchange']=()=>{libraryFilters[key]=el.value;libraryFilters.page=1;libraryResults();};
  }
  libraryResults();
}
async function api(path) {
  const response = await fetch(path, {cache:'no-store'});
  const result = await response.json();
  if (!response.ok) throw new Error(result.error || 'Lettura non riuscita.');
  return result;
}
function errorPanel(error) {
  $('#main').innerHTML = `${heading('ARCHIVIO LOCALE','Catalogo non disponibile','Non è stato possibile completare la lettura.')}<div class="notice" role="alert">${esc(error.message)}</div><button class="primary" id="retry">Riprova</button>`;
  $('#retry').onclick = load;
}
async function load() {
  $('#refresh').disabled = true;
  try {
    data = await api('/api/catalog');
    $('#contest-count').textContent = data.contests.length;
    $('#entry-count').textContent = data.entries.length;
    $('#game-count').textContent = data.games.length;
    $('#kanare-count').textContent = data.games.filter(game=>game.source_keys.includes('kanare_abstract')).length;
    $('#freshness').textContent = `Letto il ${day(data.generated_at)}`;
    await route();
  } catch(error) { errorPanel(error); }
  finally { $('#refresh').disabled = false; }
}
const sourceBadges=game=>game.source_keys.length?game.source_keys.map(key=>`<span class="badge">${esc(label(key))}</span>`).join(' '):'<span class="badge">Fonte canonica legacy</span>';
function matchingGames(sourceKey='') {
  const query=gameFilters.query.toLocaleLowerCase().trim();
  return data.games.filter(game=>(!sourceKey||game.source_keys.includes(sourceKey))&&(!gameFilters.source||game.source_keys.includes(gameFilters.source))&&(!gameFilters.ambiguity||(gameFilters.ambiguity==='candidate'?game.candidate_count>0:game.candidate_count===0))&&(!query||`${game.canonical_title} ${game.aliases.join(' ')}`.toLocaleLowerCase().includes(query)));
}
function gameFiltersHtml(lockSource='') {
  return `<div class="filters"><label class="field grow">Cerca titolo o alias<input id="game-search" type="search" placeholder="Titolo canonico, alias, grafia alternativa…" value="${esc(gameFilters.query)}"></label>${lockSource?'':`<label class="field">Fonte<select id="game-source"><option value="">Tutte le fonti</option>${data.sources.map(s=>`<option value="${esc(s.source_key)}">${esc(s.display_name)}</option>`).join('')}</select></label>`}<label class="field">Riconciliazione<select id="game-ambiguity"><option value="">Tutte</option><option value="candidate">Con candidati da valutare</option><option value="resolved">Senza candidati aperti</option></select></label></div><div id="game-results" aria-live="polite"></div>`;
}
function bindGameFilters(sourceKey='') {
  const search=$('#game-search'), ambiguity=$('#game-ambiguity'), sourceSelect=$('#game-source');
  if(sourceSelect)sourceSelect.value=gameFilters.source;
  ambiguity.value=gameFilters.ambiguity;
  const update=()=>{gameFilters.query=search.value;gameFilters.ambiguity=ambiguity.value;if(sourceSelect)gameFilters.source=sourceSelect.value;renderGameResults(sourceKey);};
  search.oninput=update;ambiguity.onchange=update;if(sourceSelect)sourceSelect.onchange=update;renderGameResults(sourceKey);
}
function renderGameResults(sourceKey='') {
  const games=matchingGames(sourceKey);
  $('#game-results').innerHTML=`<div class="section-heading"><h2>${games.length} giochi canonici</h2><span>Prodotti e record di fonte non sono conteggiati come giochi</span></div>`+table(['Gioco','Fonti','Dati collegati','Riconciliazione'],games.map(game=>`<tr><td><a href="#game/${game.id}">${esc(game.canonical_title)}</a>${game.aliases.length?`<small>Alias: ${esc(game.aliases.join(' · '))}</small>`:''}</td><td>${sourceBadges(game)}</td><td>${game.product_count} prodotti · ${game.implementation_count} implementazioni</td><td>${game.candidate_count?`<span class="badge warn">${game.candidate_count} da valutare</span>`:'Nessun candidato aperto'}</td></tr>`));
}
function applySpecializedSource(sourceKey='') {
  if(sourceKey)gameFilters.source='';
}
function renderGames(sourceKey='') {
  const kanare=sourceKey==='kanare_abstract';
  // Una vista specializzata impone la propria fonte: non deve ereditare un filtro
  // nascosto selezionato in precedenza nella vista comune Giochi.
  applySpecializedSource(sourceKey);
  $('#main').innerHTML=heading(kanare?'FONTE SPECIALIZZATA':'CATALOGO COMUNE',kanare?'Kanare_Abstract':'Giochi',kanare?'I giochi collegati ai record Kanare, con prodotti, implementazioni e ambiguità conservati separatamente.':'Identità canoniche ricercabili attraverso tutte le fonti e gli alias registrati.')+(kanare?'<div class="notice">Questa vista non apre Kanare né le destinazioni dichiarate. Mostra soltanto dati già presenti nel database locale.</div>':'<div class="notice">Un gioco non coincide con un prodotto, una confezione, una pagina di fonte o una risorsa. I matching candidati restano visibili e non producono fusioni implicite.</div>')+gameFiltersHtml(sourceKey);
  bindGameFilters(sourceKey);
}
function renderGameDetail(detail) {
  const g=detail.game;
  $('#main').innerHTML=`<a class="back" href="#games">← Tutti i giochi</a>`+heading('GIOCO CANONICO',g.canonical_title,g.summary||'Descrizione non registrata')+`<div class="facts">${fact('Stato originale',g.status_raw)}${fact('Stato normalizzato',g.status_normalized)}${fact('Giocatori',g.min_players||g.max_players?`${g.min_players??'?'}–${g.max_players??'?'}`:'Non registrati')}${fact('Durata',g.min_play_minutes||g.max_play_minutes?`${g.min_play_minutes??'?'}–${g.max_play_minutes??'?'} min`:'Non registrata')}</div><h2>Record di fonte e riconciliazione</h2><p class="subtitle">Ogni riga è un’osservazione nativa della fonte, non un secondo gioco. Anche corrispondenze candidate o respinte restano documentate.</p>${table(['Fonte / record','Titolo osservato','Matching','Verifica / provenienza'],detail.source_records.map(r=>`<tr><td>${esc(r.source_name)}<small>${esc(r.record_type)} · #${r.id}</small></td><td>${esc(r.title_raw)}</td><td>${esc(label(r.match_status))}<small>${esc(r.match_method)}${r.evidence?` · ${esc(r.evidence)}`:''}</small></td><td>${esc(label(r.verification_status))}<small>${externalLink(r.canonical_url,'Apri la pagina registrata')} · ${esc(day(r.last_verified_at))}</small></td></tr>`))}<h2>Prodotti e confezioni</h2>${table(['Prodotto','Relazione','Stato / provenienza'],detail.products.map(p=>`<tr><td>${esc(p.canonical_name)}<small>${esc(p.product_kind)}</small></td><td>${esc(p.relationship_type)}${p.is_primary?' · principale':''}</td><td>${esc(label(p.verification_status))}<small>${esc(p.source_names||'Fonte non collegata')}</small></td></tr>`))}<h2>Implementazioni online</h2>${table(['Piattaforma','Titolo / disponibilità','Provenienza'],detail.implementations.map(i=>`<tr><td>${esc(i.platform_name)}</td><td>${i.implementation_url?externalLink(i.implementation_url,i.title_raw||g.canonical_title):esc(i.title_raw||g.canonical_title)}<small>${esc(label(i.availability_status))} · ${esc(label(i.verification_status))}</small></td><td>${esc(i.declared_by_source||'Non attribuita')}<small>${esc(i.declared_by_title)}</small></td></tr>`))}<h2>Risorse attribuite al gioco</h2>${table(['Tipo','Risorsa','Stato / attribuzione'],detail.resources.map(r=>`<tr><td>${esc(r.resource_kind)}<small>${esc(r.link_role)}</small></td><td>${externalLink(r.url,r.label_raw||r.url)}</td><td>${esc(label(r.verification_status))}<small>${esc(label(r.availability_status))} · via ${esc(r.attributed_via)}</small></td></tr>`))}<h2>Presenze nei contest BGG</h2>${table(['Entry','Contest','Stato'],detail.entries.map(e=>`<tr><td><a href="#entry/${e.id}">Entry #${e.id}</a></td><td><a href="#contest/${e.contest_id}">${esc(e.contest_name)}</a><small>${esc(e.year)}</small></td><td>${esc(label(e.status_normalized))}<small>${esc(e.status_raw)}</small></td></tr>`))}<details><summary>Nomi e alias (${detail.names.length})</summary>${table(['Nome','Tipo / lingua','Fonte e verifica'],detail.names.map(n=>`<tr><td>${esc(n.name)}</td><td>${esc(n.name_type)}<small>${esc(n.language_code)} · ${n.is_official?'ufficiale':'non ufficiale'}</small></td><td>${esc(n.source_name||n.observed_from)}<small>${esc(label(n.verification_status))}</small></td></tr>`))}</details>`;
  $('#main').innerHTML += localMaterials(detail.local_materials);
}
function stats() {
  const core = data.contests.filter(c=>c.scope_type==='pnp_core').length;
  const dependent = data.entries.filter(e=>e.entry_kind==='dependent_variant').length;
  return `<div class="stats"><div class="stat"><span>Contest nell’archivio</span><strong>${data.contests.length}</strong><small>Edizioni catalogate</small></div><div class="stat"><span>PnP principali</span><strong>${core}</strong><small>${data.contests.length-core} contest adiacenti separati</small></div><div class="stat"><span>Entry censite</span><strong>${data.entries.length}</strong><small>Include le entry ritirate</small></div><div class="stat"><span>Varianti dipendenti</span><strong>${dependent}</strong><small>Da un gioco base</small></div></div>`;
}
const progressState={year:''};
const progressMark=(value,total,kind='count')=>{
  const missing=value===null||value===undefined;
  const tone=missing?'unavailable':total>0&&value>=total?'done':value>0?'partial':'zero';
  const text=missing?'Non disponibile':kind==='ratio'?`${value}/${total===null||total===undefined?'—':total}`:value;
  return `<span class="progress-mark ${tone}"><i aria-hidden="true"></i>${esc(text)}</span>`;
};
const progressPercent=(value,total)=>total?Math.round(value*100/total):0;
const pipelineRow=(labelText,value,total,tone='green')=>`<div class="pipeline-row"><div><span>${esc(labelText)}</span><strong>${value}/${total} · ${progressPercent(value,total)}%</strong></div><progress class="pipeline-progress ${tone}" aria-label="${esc(labelText)}" value="${value}" max="${total||1}">${progressPercent(value,total)}%</progress></div>`;
const scopePipeline=(scope,labelText,tone='green')=>`<section class="pipeline-scope"><div class="pipeline-scope-title"><strong>${esc(labelText)}</strong><span>${scope.entry_count} entry · ${scope.contest_count} contest</span></div>${pipelineRow('Contest con entry censite',scope.contests_with_entries_count,scope.contest_count,tone)}${pipelineRow('Entry in classifica',scope.ranked_entry_count,scope.entry_count,'blue')}${pipelineRow('Lettura materiali',scope.materials_read_count,scope.entry_count,'amber')}${pipelineRow('File acquisiti',scope.downloaded_entry_count,scope.entry_count,tone)}</section>`;
const scopeSummary=(year,scopeType)=>{
  if(year[scopeType]) return year[scopeType];
  const contests=(data?.progress?.contests||[]).filter(c=>c.year===year.year&&c.scope_type===scopeType);
  return {
    contest_count:contests.length,
    contests_with_entries_count:contests.filter(c=>c.entry_count>0).length,
    entry_count:contests.reduce((sum,c)=>sum+c.entry_count,0),
    ranked_entry_count:contests.reduce((sum,c)=>sum+c.ranked_entry_count,0),
    materials_read_count:contests.reduce((sum,c)=>sum+c.materials_read_count,0),
    downloaded_entry_count:contests.reduce((sum,c)=>sum+c.downloaded_entry_count,0),
  };
};
function renderProgress() {
  const years=data.progress.years;
  const selected=progressState.year||String(years.find(y=>y.contest_count)?.year||years[0]?.year||'');
  progressState.year=selected;
  const activeYears=years.filter(y=>y.contest_count);
  const emptyYears=years.filter(y=>!y.contest_count);
  const annual=activeYears.map(y=>`<button class="year-pipeline ${String(y.year)===selected?'selected':''}" data-progress-year="${y.year}" aria-pressed="${String(y.year)===selected}"><div class="pipeline-title"><span><strong>${y.year}</strong><small>Avanzamento separato per perimetro</small></span><b>${y.entry_count}<small> entry complessive</small></b></div>${scopePipeline(scopeSummary(y,'pnp_core'),'PnP principali')}${scopePipeline(scopeSummary(y,'adjacent'),'Adiacenti','violet')}</button>`).join('');
  const pending=emptyYears.map(y=>`<button class="year-pending ${String(y.year)===selected?'selected':''}" data-progress-year="${y.year}" aria-pressed="${String(y.year)===selected}"><strong>${y.year}</strong><span>Non importato</span></button>`).join('');
  const contests=data.progress.contests.filter(c=>String(c.year)===selected);
  const detail=contests.length?table(['Contest','Entry','Stati noti','Classifiche','Lettura materiali','Download'],contests.map(c=>`<tr><td><a href="#contest/${c.contest_id}">${esc(c.contest_name)}</a><small>${esc(label(c.scope_type))} · ${esc(label(c.status_normalized))}</small></td><td><a href="#entries/contest/${c.contest_id}">${progressMark(c.entry_count,c.entry_count)}</a></td><td>${progressMark(c.known_status_count,c.entry_count,'ratio')}</td><td><a href="#rankings/${c.contest_id}">${progressMark(c.ranking_category_count,1)}</a><small>categorie</small></td><td><a href="#entries/contest/${c.contest_id}/read">${progressMark(c.materials_read_count,c.entry_count,'ratio')}</a></td><td><a href="#entries/contest/${c.contest_id}/downloaded">${progressMark(c.downloaded_entry_count,c.entry_count,'ratio')}</a></td></tr>`)):`<div class="empty">L’annualità ${esc(selected)} non è ancora importata nel database operativo.</div>`;
  $('#main').innerHTML=heading('CRUSCOTTO','Avanzamento per anno.','Una seconda via di accesso a contest, entry, classifiche e materiali, calcolata direttamente dal catalogo locale.')+`<div class="notice">PnP principali e contest adiacenti hanno conteggi e indicatori indipendenti. Le challenge da 24 ore appartengono agli adiacenti e non alterano più l’avanzamento dei PnP principali.</div><div class="year-pipeline-grid" aria-label="Annualità presenti nel database">${annual}</div><details class="pending-years"><summary>Annualità non ancora importate (${emptyYears.length})</summary><div class="year-pending-grid">${pending}</div></details><div class="section-heading"><h2>${esc(selected)}</h2><span>${contests.length} contest nel database · <a href="#entries/year/${esc(selected)}">Apri tutte le entry dell’anno →</a></span></div>${detail}`;
  document.querySelectorAll('[data-progress-year]').forEach(button=>button.onclick=()=>{progressState.year=button.dataset.progressYear;renderProgress();});
}
function renderContests() {
  $('#main').innerHTML = heading('SCOPRI · CONSULTA · SEGUI','Dalle idee al tavolo.','Esplora i contest di design BGG, segui le scadenze e ritrova ogni entry nel tuo archivio.') + stats() + `
    <div class="filters"><label class="field grow">Cerca un contest<input id="search" type="search" placeholder="Nome del contest…" value="${esc(filters.query)}"></label><label class="field">Stato<select id="state">${options(data.contests.map(c=>c.status_normalized),'Tutti gli stati')}</select></label><label class="field">Edizione<select id="year">${options(data.contests.map(c=>c.year),'Tutti gli anni')}</select></label></div>
    <div class="segmented" aria-label="Perimetro contest">${[['','Tutti i contest'],['pnp_core','PnP principali'],['adjacent','Adiacenti']].map(([v,t])=>`<button data-scope="${v}" aria-pressed="${filters.scope===v}" class="${filters.scope===v?'selected':''}">${t}</button>`).join('')}</div><div id="contest-results" aria-live="polite"></div>`;
  $('#state').value = filters.contestState; $('#year').value = filters.year;
  $('#search').oninput = event => {filters.query=event.target.value;contestResults();};
  $('#state').onchange = event => {filters.contestState=event.target.value;contestResults();};
  $('#year').onchange = event => {filters.year=event.target.value;contestResults();};
  document.querySelectorAll('[data-scope]').forEach(button=>button.onclick=()=>{
    filters.scope=button.dataset.scope;
    document.querySelectorAll('[data-scope]').forEach(b=>{b.classList.toggle('selected',b===button);b.setAttribute('aria-pressed',String(b===button));});
    contestResults();
  });
  contestResults();
}
function contestResults() {
  const results = data.contests.filter(c=>(!filters.scope||c.scope_type===filters.scope)&&(!filters.contestState||c.status_normalized===filters.contestState)&&(!filters.year||String(c.year)===filters.year)&&c.contest_name.toLocaleLowerCase().includes(filters.query.toLocaleLowerCase().trim()));
  $('#contest-results').innerHTML = !results.length ? '<div class="empty">Nessun contest corrisponde ai filtri. Prova un altro nome o amplia il perimetro.</div>' : ['pnp_core','adjacent'].map(scope=>{
    const group = results.filter(c=>c.scope_type===scope);
    return group.length ? `<div class="section-heading"><h2>${label(scope)}</h2><span>${group.length} contest · ${scope==='pnp_core'?'Giochi PnP autonomi':'Formati affini e varianti'}</span></div><div class="cards">${group.map(c=>`<article class="card"><div class="card-top">${badge(c.status_normalized)}<span class="year">${esc(c.year)}</span></div><h3><a href="#contest/${c.contest_id}">${esc(c.contest_name)}</a></h3><p class="profile">${esc(label(c.treatment_profile))}</p><div class="card-date">${c.next_deadline ? `${esc(c.next_phase_label)}<strong>${esc(day(c.next_deadline))}</strong>` : 'Nessuna scadenza futura registrata'}</div><div class="card-bottom"><span><strong>${c.entry_count}</strong> entry · ${c.withdrawn_entry_count} ritirate</span><a href="#contest/${c.contest_id}" aria-label="Esplora ${esc(c.contest_name)}">Esplora →</a></div><small class="source">Verificato: ${esc(day(c.last_verified_at))}</small></article>`).join('')}</div>` : '';
  }).join('');
}
function entryFilters(contestId=null) {
  const entries = contestId ? data.entries.filter(e=>e.contest_id===contestId) : data.entries;
  return `<div class="filters"><label class="field grow">Cerca entry o autore<input type="search" id="entry-search" placeholder="Titolo, nome o autore…" value="${esc(filters.entryQuery)}"></label><label class="field">Stato entry<select id="entry-state">${options(entries.map(e=>e.status_normalized),'Tutti gli stati')}</select></label><label class="field">Tipologia<select id="entry-kind">${options(entries.map(e=>e.entry_kind),'Tutte le tipologie')}</select></label>${contestId?'':`<label class="field">Anno<select id="entry-year">${options(data.entries.map(e=>e.year),'Tutti gli anni')}</select></label><label class="field">Perimetro<select id="entry-scope">${options(['pnp_core','adjacent'],'Tutti')}</select></label><label class="field">Contest<select id="entry-contest"><option value="">Tutti i contest</option>${data.contests.map(c=>`<option value="${c.contest_id}">${esc(c.contest_name)}</option>`).join('')}</select></label>`}<label class="field">Materiali<select id="entry-materials"><option value="">Tutti</option><option value="read">Lettura registrata</option><option value="unread">Lettura non iniziata</option><option value="downloaded">File acquisiti</option></select></label><label class="field">Ordina<select id="entry-sort"><option value="title">Titolo A–Z</option><option value="position">Posizione nella lista</option><option value="verified">Verifica più recente</option></select></label></div><div id="entry-results" aria-live="polite"></div>`;
}
function bindEntryFilters(contestId=null) {
  for (const [id,key] of [['entry-state','entryState'],['entry-kind','entryKind'],['entry-year','entryYear'],['entry-scope','entryScope'],['entry-contest','entryContest'],['entry-materials','entryMaterials'],['entry-sort','entrySort']]) {
    if (!$('#'+id)) continue;
    if (![...$('#'+id).options].some(o=>o.value===filters[key])) filters[key]='';
    $('#'+id).value=filters[key];
    $('#'+id).onchange=event=>{filters[key]=event.target.value;filters.page=1;entryResults(contestId);};
  }
  $('#entry-search').oninput=event=>{filters.entryQuery=event.target.value;filters.page=1;entryResults(contestId);};
  entryResults(contestId);
}
function entryResults(contestId=null) {
  let entries=data.entries.filter(e=>(!contestId||e.contest_id===contestId)&&(!filters.entryState||e.status_normalized===filters.entryState)&&(!filters.entryKind||e.entry_kind===filters.entryKind)&&(contestId||!filters.entryYear||String(e.year)===filters.entryYear)&&(contestId||!filters.entryScope||e.scope_type===filters.entryScope)&&(contestId||!filters.entryContest||String(e.contest_id)===filters.entryContest)&&(!filters.entryMaterials||(filters.entryMaterials==='read'?e.materials_read===1:filters.entryMaterials==='unread'?e.materials_read===0:e.materials_downloaded===1))&&`${e.canonical_title} ${e.credits||''}`.toLocaleLowerCase().includes(filters.entryQuery.toLocaleLowerCase().trim()));
  entries.sort((a,b)=>filters.entrySort==='position'?(a.position??Infinity)-(b.position??Infinity)||a.id-b.id:filters.entrySort==='verified'?String(b.last_verified_at).localeCompare(String(a.last_verified_at))||a.id-b.id:a.canonical_title.localeCompare(b.canonical_title,'it')||a.id-b.id);
  const pages=Math.max(1,Math.ceil(entries.length/30)); filters.page=Math.min(filters.page,pages);
  const shown=entries.slice((filters.page-1)*30,filters.page*30);
  $('#entry-results').innerHTML=`<div class="section-heading"><h2>${entries.length} entry</h2><span>L = lettura registrata · D = file acquisiti</span></div>`+table(['Entry','Contest','Stato','Materiali','Verifica'],shown.map(e=>`<tr><td><a href="#entry/${e.id}">${esc(e.canonical_title)}</a><small>${e.position==null?'':`#${e.position} · `}${esc(e.credits||'Autore non registrato')}</small></td><td><a href="#contest/${e.contest_id}">${esc(e.contest_name)}</a><small>${esc(e.year)} · ${esc(label(e.scope_type))}</small></td><td>${badge(e.status_normalized)}<small>${esc(e.status_raw)}</small></td><td>${e.materials_read?'L 🟢':'L 🔴'} · ${e.materials_downloaded?'D 🟢':'D 🔴'}<small>${esc(label(e.entry_kind))}</small></td><td>${esc(day(e.last_verified_at))}</td></tr>`))+`<div class="pager"><span>Pagina ${filters.page} di ${pages} · fino a 30 entry per pagina</span><div><button id="prev" class="quiet" ${filters.page===1?'disabled':''}>← Precedente</button><button id="next" class="quiet" ${filters.page===pages?'disabled':''}>Successiva →</button></div></div>`;
  $('#prev').onclick=()=>{filters.page--;entryResults(contestId);};
  $('#next').onclick=()=>{filters.page++;entryResults(contestId);};
}
function renderEntriesRoute(hash) {
  let contestId=null;
  const parts=hash.split('/');
  if(parts[1]==='year'&&/^\d{4}$/.test(parts[2]||'')) {
    filters.entryYear=parts[2]; filters.entryContest=''; filters.entryMaterials='';
  } else if(parts[1]==='contest'&&/^[1-9]\d*$/.test(parts[2]||'')) {
    contestId=Number(parts[2]); filters.entryYear=''; filters.entryContest='';
    filters.entryMaterials=['read','unread','downloaded'].includes(parts[3])?parts[3]:'';
  } else if(parts.length===1) {
    filters.entryYear=''; filters.entryContest=''; filters.entryMaterials='';
  }
  filters.page=1;
  const context=contestId?data.contests.find(c=>c.contest_id===contestId):null;
  $('#main').innerHTML=heading('IL CATALOGO',context?context.contest_name:'Ogni gioco, una nuova idea.',context?'Entry del contest con accesso diretto allo stato dei materiali.':'Cerca fra tutte le entry, comprese quelle ritirate e le varianti dipendenti.')+entryFilters(contestId);
  bindEntryFilters(contestId);
}
const rankingFilters={query:'',contest:'',year:'',scope:'',category:'',official:'',position:'',sort:'category',page:1};
const rankingCategoryKey=value=>value.trim().toLocaleLowerCase('it');
const isOverallCategory=value=>/\boverall\b/.test(rankingCategoryKey(value));
const compareRankingCategories=(a,b)=>(isOverallCategory(a)?0:1)-(isOverallCategory(b)?0:1)||rankingCategoryKey(a).localeCompare(rankingCategoryKey(b),'it')||a.localeCompare(b,'it');
function rankingCategories(all,contest) {
  return [...new Set(all.filter(r=>!contest||String(r.contest_id)===contest).map(r=>r.category))].sort(compareRankingCategories);
}
function reconcileRankingCategory(categories,filters) {
  if(filters.category&&!categories.includes(filters.category))filters.category='';
  if(!filters.category)filters.category=categories.find(c=>isOverallCategory(c))||'';
}
const rankingGroupKey=r=>JSON.stringify([r.contest_id,r.category,r.is_official,r.evidence_url,r.verified_at]);
const rankingNature=r=>r.is_official===1?'Risultato ufficiale':'Segnale sostitutivo · non ufficiale';
const rankingLink=r=>r.entry_id?`<a href="#entry/${r.entry_id}">${esc(r.canonical_title)}</a>`:`${esc(r.canonical_title)}<small>Entry non collegata</small>`;
function selectRankings(all,f) {
  const q=f.query.trim().toLocaleLowerCase('it');
  const selected=all.filter(r=>(!f.contest||String(r.contest_id)===f.contest)&&(!f.year||String(r.year)===f.year)&&(!f.scope||r.scope_type===f.scope)&&(!f.category||r.category===f.category)&&(f.official===''||String(r.is_official)===f.official)&&(!f.position||(f.position==='missing'?r.rank==null:f.position==='podium'?r.rank!=null&&r.rank>=1&&r.rank<=3:String(r.rank)===f.position))&&`${r.canonical_title} ${r.credits||''}`.toLocaleLowerCase('it').includes(q));
  const position=(a,b)=>a.rank==null?(b.rank==null?0:1):b.rank==null?-1:(f.sort==='rank-desc'?b.rank-a.rank:a.rank-b.rank);
  return selected.sort((a,b)=>{
    const group=String(b.year??'').localeCompare(String(a.year??''))||a.contest_name.localeCompare(b.contest_name,'it')||compareRankingCategories(a.category,b.category)||b.is_official-a.is_official||String(b.verified_at).localeCompare(String(a.verified_at))||a.evidence_url.localeCompare(b.evidence_url);
    return (f.sort.startsWith('rank')?position(a,b)||group:f.sort==='title'?a.canonical_title.localeCompare(b.canonical_title,'it')||group:group||position(a,b))||a.id-b.id;
  });
}
function rankingTable(rankings, titles=false, universe=rankings) {
  const ties=new Map();
  universe.forEach(r=>{if(r.rank!=null){const k=rankingGroupKey(r)+'/'+r.rank;if(!ties.has(k))ties.set(k,new Set());ties.get(k).add(r.game_id);}});
  return table([...(titles?['Entry / autore','Contest']:[]),'Categoria','Posizione','Punteggio','Voti','Natura e provenienza'],rankings.map(r=>`<tr>${titles?`<td>${rankingLink(r)}<small>${esc(r.credits||'Autore non registrato')}</small></td><td><a href="#contest/${r.contest_id}">${esc(r.contest_name)}</a><small>${esc(r.year)} · ${esc(label(r.scope_type))}</small></td>`:''}<td>${esc(r.category)}</td><td>${r.rank==null?'Non registrata':`#${esc(r.rank)}${ties.get(rankingGroupKey(r)+'/'+r.rank)?.size>1?'<small>Ex aequo registrato</small>':''}`}</td><td>${esc(r.score??'Non registrato')}</td><td>${esc(r.vote_count??'Non registrati')}</td><td>${rankingNature(r)}${source(r.evidence_url,r.verified_at)}<small>Osservazione #${r.id}</small></td></tr>`));
}
function renderRankings(contestId='') {
  if(contestId) {
    if(!data.contests.some(c=>String(c.contest_id)===contestId))throw new Error('Contest non trovato.');
    Object.assign(rankingFilters,{query:'',contest:contestId,year:'',scope:'',category:'',official:'',position:'',sort:'category',page:1});
  }
  const all=data.rankings;
  const categories=rankingCategories(all,rankingFilters.contest);
  reconcileRankingCategory(categories,rankingFilters);
  const select=(key,title,content)=>`<label class="field">${title}<select id="ranking-${key}">${content}</select></label>`;
  $('#main').innerHTML=heading('RISULTATI BGG','Classifiche dei contest','Piazzamenti registrati, categorie originali e provenienza delle osservazioni.')+`<p class="notice">Posizione, punteggio e voti sono dati distinti. I valori mancanti non equivalgono a zero. L’ordine per posizione non è un confronto di merito fra categorie o contest.</p><div class="filters"><label class="field grow">Cerca titolo o autore<input id="ranking-query" type="search" value="${esc(rankingFilters.query)}"></label>${select('contest','Contest','<option value="">Tutti i contest</option>'+data.contests.map(c=>`<option value="${c.contest_id}">${esc(c.contest_name)}</option>`).join(''))}${select('year','Anno',options(all.map(r=>r.year),'Tutti gli anni'))}${select('scope','Perimetro',options(['pnp_core','adjacent'],'Tutti'))}${select('category','Categoria','<option value="">Tutte le categorie</option>'+categories.map(c=>`<option value="${esc(c)}">${esc(c)}</option>`).join(''))}${select('official','Natura','<option value="">Tutte</option><option value="1">Ufficiali</option><option value="0">Non ufficiali / sostitutivi</option>')}${select('position','Posizione','<option value="">Tutte</option><option value="podium">Da 1 a 3</option><option value="missing">Non registrata</option>'+[...new Set(all.map(r=>r.rank).filter(r=>r!=null))].sort((a,b)=>a-b).map(r=>`<option value="${r}">#${r}</option>`).join(''))}${select('sort','Ordina','<option value="category">Contest e categoria</option><option value="rank-asc">Posizione crescente</option><option value="rank-desc">Posizione decrescente</option><option value="title">Titolo A–Z</option>')}<button class="quiet" id="ranking-reset">Azzera filtri</button></div><div id="ranking-results" tabindex="-1" aria-live="polite"></div>`;
  for(const key of ['contest','year','scope','category','official','position','sort']) {
    const element=$('#ranking-'+key);
    if(![...element.options].some(o=>o.value===rankingFilters[key]))rankingFilters[key]=key==='sort'?'category':'';
    element.value=rankingFilters[key];
    element.onchange=()=>{rankingFilters[key]=element.value;rankingFilters.page=1;if(key==='contest')renderRankings();else rankingResults();};
  }
  $('#ranking-query').oninput=e=>{rankingFilters.query=e.target.value;rankingFilters.page=1;rankingResults();};
  $('#ranking-reset').onclick=()=>{Object.assign(rankingFilters,{query:'',contest:'',year:'',scope:'',category:'',official:'',position:'',sort:'category',page:1});renderRankings();};
  rankingResults();
}
function rankingResults() {
  const results=selectRankings(data.rankings,rankingFilters),pages=Math.max(1,Math.ceil(results.length/30));
  rankingFilters.page=Math.min(rankingFilters.page,pages);
  const c=data.contests.find(c=>String(c.contest_id)===rankingFilters.contest);
  $('#ranking-results').innerHTML=`<div class="section-heading"><h2>${results.length} risultati</h2>${c?`<a href="#results/${c.contest_id}">Sintesi risultati del contest →</a>`:''}</div>`+rankingTable(results.slice((rankingFilters.page-1)*30,rankingFilters.page*30),true,data.rankings)+`<div class="pager"><span>Pagina ${rankingFilters.page} di ${pages} · 30 risultati per pagina</span><div><button id="ranking-prev" class="quiet" ${rankingFilters.page===1?'disabled':''}>← Precedente</button><button id="ranking-next" class="quiet" ${rankingFilters.page===pages?'disabled':''}>Successiva →</button></div></div>`;
  for(const [id,delta] of [['ranking-prev',-1],['ranking-next',1]]) $('#'+id).onclick=()=>{rankingFilters.page+=delta;rankingResults();$('#ranking-results').focus({preventScroll:true});$('#ranking-results').scrollIntoView({block:'start'});};
}
function rankingSummary(rankings) {
  const groups=new Map();
  rankings.forEach(r=>{const k=rankingGroupKey(r);if(!groups.has(k))groups.set(k,[]);groups.get(k).push(r);});
  return `<p class="notice">Sintesi delle sole osservazioni registrate, separate per categoria, ufficialità, fonte e data. Vincitori solo con posizione esplicita #1; nessun vincitore dedotto da punteggi o dalla prima posizione disponibile. La distribuzione conta osservazioni, non certifica una classifica completa. Nessun totale dei punteggi tra categorie.</p>`+(groups.size?[...groups.values()].map(group=>{
    const r=group[0],winners=group.filter(r=>r.rank===1),counts=new Map();
    group.forEach(r=>counts.set(r.rank,(counts.get(r.rank)||0)+1));
    return `<section class="panel"><h2>${esc(r.category)}</h2><p>${rankingNature(r)}</p>${source(r.evidence_url,r.verified_at)}<h3>${r.is_official===1?'Vincitori registrati':'Primi posti non ufficiali'}</h3>${winners.length?`<ul>${winners.map(w=>`<li>${rankingLink(w)}</li>`).join('')}</ul>`:'<p>Nessuna posizione #1 registrata.</p>'}<h3>Distribuzione dei piazzamenti</h3><div class="distribution">${[...counts].sort(([a],[b])=>a==null?1:b==null?-1:a-b).map(([rank,n])=>`<span>${rank==null?'Posizione non registrata':'#'+esc(rank)}<b>${n}</b></span>`).join('')}</div><details><summary>Tutti i risultati della categoria (${group.length})</summary>${rankingTable(group,true)}</details></section>`;
  }).join(''):'<div class="empty">Nessun risultato registrato per questo contest.</div>');
}
function renderContestResults(id) {
  const c=data.contests.find(c=>c.contest_id===Number(id));
  if(!c)throw new Error('Contest non trovato.');
  $('#main').innerHTML=`<a class="back" href="#contest/${c.contest_id}">← Scheda contest</a>`+heading('SINTESI RISULTATI',c.contest_name,'Vincitori per categoria e distribuzione dei piazzamenti registrati.')+`<a href="#rankings/${c.contest_id}">Consulta e filtra le classifiche →</a>`+rankingSummary(data.rankings.filter(r=>r.contest_id===c.contest_id));
}
function metricsTable(metrics) {
  return table(['Metrica','Valore','Metodo / natura','Provenienza'],metrics.map(m=>`<tr><td>${esc(m.metric_label_raw||m.metric_key)}<small>${esc(m.metric_key)} · ${m.latest?'Più recente':'Storica'}</small></td><td>${esc(m.numeric_value??m.text_value)} ${esc(m.unit||'')}</td><td>${esc(m.method)}<small>${m.is_official?'Ufficiale':'Non ufficiale · segnale sostitutivo'}</small>${m.notes?`<small>${esc(m.notes)}</small>`:''}</td><td>${source(m.source_url,m.observed_at)}</td></tr>`));
}
function renderContest(detail) {
  const c=detail.contest, entries=data.entries.filter(e=>e.contest_id===c.contest_id), counts={};
  entries.forEach(e=>counts[e.status_normalized]=(counts[e.status_normalized]||0)+1);
  $('#main').innerHTML=`<a class="back" href="#contests">← Tutti i contest</a>`+heading(`${label(c.scope_type)} / ${c.year??'Anno non registrato'}`,c.contest_name,label(c.treatment_profile))+`
    <div class="detail-grid"><section class="panel"><h2>Il contest, oggi nel catalogo</h2>${badge(c.status_normalized)}<div class="facts">${fact('Stato originale dichiarato',c.status_raw)}${fact('Stato normalizzato',c.status_normalized)}${fact('Organizzatore',c.organizer)}${fact('Ultima verifica della fonte',day(c.last_verified_at))}</div>${source(c.source_url,c.last_verified_at,'Apri la pagina del contest su BGG ↗')}</section><section class="panel"><h2>${c.entry_count} entry censite</h2><p class="subtitle">${c.withdrawn_entry_count} ritirate · ${c.dependent_variant_count} varianti dipendenti</p><div class="distribution">${Object.entries(counts).map(([k,v])=>`<span>${esc(label(k))}<b>${v}</b></span>`).join('')}</div></section></div>
    <div class="segmented" aria-label="Sezioni del contest">${[['entries','Entry'],['schedule','Fasi e scadenze'],['statistics','Statistiche e risultati'],['history','Rilevamenti e cambiamenti']].map(([v,t],i)=>`<button data-section="${v}" class="${i===0?'selected':''}" aria-pressed="${i===0}">${t}</button>`).join('')}</div><section id="contest-section"></section>`;
  function section(name) {
    document.querySelectorAll('[data-section]').forEach(b=>{b.classList.toggle('selected',b.dataset.section===name);b.setAttribute('aria-pressed',String(b.dataset.section===name));});
    const target=$('#contest-section');
    if(name==='entries'){ target.innerHTML=entryFilters(c.contest_id);bindEntryFilters(c.contest_id); }
    if(name==='schedule') target.innerHTML=`<h2>Calendario registrato</h2><p class="subtitle">Le date e i fusi orari mantengono la precisione della fonte. Il superamento di una data non cambia automaticamente lo stato del contest.</p><div class="panel facts">${fact('Chiusura entry',day(c.schedule.submissions_close_at))}${fact('Apertura voto',day(c.schedule.voting_opens_at))}${fact('Chiusura voto',day(c.schedule.voting_closes_at))}</div>`+table(['Fase','Stato dichiarato','Intervallo','Precisione e fonte'],detail.phases.map(p=>`<tr><td>${esc(p.label_raw)}<small>${esc(p.phase_type)}</small>${p.notes?`<small>${esc(p.notes)}</small>`:''}</td><td>${badge(p.status_normalized)}<small>${esc(p.status_raw)}</small></td><td>${esc(day(p.starts_at))}<br>→ ${esc(day(p.ends_at))}</td><td>${esc(p.date_precision)} · ${esc(p.timezone||'Fuso non registrato')}${source(p.source_url,p.last_verified_at)}</td></tr>`));
    if(name==='statistics') target.innerHTML=`<h2>Statistiche più recenti</h2><p class="subtitle">Una sola osservazione per metrica, ordinata per data e identificativo. Eventuali correzioni restano nello storico.</p>${metricsTable(detail.metrics.filter(m=>m.latest))}<details><summary>Tutte le osservazioni delle metriche (${detail.metrics.length})</summary>${metricsTable(detail.metrics)}</details><h2>Classifiche e votazioni</h2><p><a href="#results/${c.contest_id}">Sintesi dei vincitori e piazzamenti →</a> · <a href="#rankings/${c.contest_id}">Filtra i risultati →</a></p>${rankingTable(detail.rankings,true)}`;
    if(name==='history') renderHistory(detail);
  }
  document.querySelectorAll('[data-section]').forEach(b=>b.onclick=()=>section(b.dataset.section));
  section('entries');
}
function renderHistory(detail) {
  const periodic=detail.checks.filter(c=>c.periodic).slice().reverse();
  $('#contest-section').innerHTML=`<h2>Cambiamenti fra rilevamenti</h2>${periodic.length<2?'<div class="empty"><h2>Il confronto periodico non è ancora disponibile.</h2>Servono almeno due rilevamenti periodici dello stesso contest. Baseline, censimenti e verifiche tecniche restano consultabili nello storico.</div>':`<div class="filters"><label class="field grow">Rilevamento precedente<select id="before">${periodic.map(c=>`<option value="${c.id}">${esc(day(c.checked_at))} · #${c.id} · ${esc(c.check_kind)}</option>`).join('')}</select></label><label class="field grow">Rilevamento successivo<select id="after">${periodic.map(c=>`<option value="${c.id}">${esc(day(c.checked_at))} · #${c.id} · ${esc(c.check_kind)}</option>`).join('')}</select></label><button id="compare" class="primary">Confronta</button></div><div id="comparison" aria-live="polite"></div>`}
    <h2>Tutti i controlli registrati</h2>${table(['Data / tipo','Esito','Note','Provenienza'],detail.checks.map(c=>`<tr><td>${esc(day(c.checked_at))}<small>#${c.id} · ${esc(c.check_kind)}</small><small>${c.periodic?'Rilevamento periodico':'Baseline / censimento / controllo non periodico'}</small></td><td>${esc(c.outcome)}</td><td>${esc(c.notes)}</td><td>${source(c.source_url,c.checked_at)}</td></tr>`))}<details><summary>Storico degli stati del contest</summary>${table(['Osservato','Stato originale','Stato normalizzato','Fonte'],detail.status_history.map(h=>`<tr><td>${esc(day(h.observed_at))}<small>Controllo #${esc(h.check_id)}</small></td><td>${esc(h.status_raw)}</td><td>${badge(h.status_normalized)}</td><td>${source(h.source_url,h.observed_at)}</td></tr>`))}</details>`;
  if(periodic.length>=2){
    $('#before').value=periodic.at(-2).id;$('#after').value=periodic.at(-1).id;
    $('#compare').onclick=async()=>{
      const container=$('#comparison'), button=$('#compare');button.disabled=true;
      container.innerHTML='<div class="empty">Confronto in corso…</div>';
      try { const result=await api(`/api/contests/${detail.contest.contest_id}/compare?before=${$('#before').value}&after=${$('#after').value}`); if(container.isConnected) container.innerHTML=renderComparison(result); }
      catch(error){if(container.isConnected) container.innerHTML=`<div class="notice" role="alert">${esc(error.message)}</div>`;}
      finally{button.disabled=false;}
    };
    $('#compare').click();
  }
}
function renderComparison(result) {
  return `<div class="notice">${esc(result.notice)}<br>Esiti dichiarati: ${esc(result.before.outcome)} → ${esc(result.after.outcome)}.</div>`+Object.entries(result.sections).map(([key,s])=>`<section class="panel"><h3>${esc({contest:'Stato del contest',entries:'Entry',metrics:'Metriche',phases:'Fasi e scadenze'}[key])}</h3><p class="compare-counts">${s.before_count} osservazioni precedenti · ${s.after_count} successive · ${s.shared_count} entità comuni</p>${!s.shared_count?'<p class="text-muted">Dati insufficienti per confrontare i valori. Uno snapshot vuoto non certifica zero entità.</p>':!s.changes.length?'<p>Nessuna variazione nei campi delle entità comuni osservate.</p>':table(['Entità','Campo','Prima','Dopo','Fonti dei controlli'],s.changes.flatMap(c=>c.fields.map(f=>`<tr><td>${key==='entries'?`<a href="#entry/${c.entity_id}">${esc(c.label)}</a>`:esc(c.label)}</td><td>${esc(label(f.field))}</td><td class="delta-old">${esc(f.before)}</td><td class="delta-new">${esc(f.after)}</td><td>${source(c.before_source,result.before.checked_at)}${source(c.after_source,result.after.checked_at)}</td></tr>`)))}${[['only_before','Osservate solo nel precedente'],['only_after','Osservate solo nel successivo']].map(([field,title])=>s[field].length?`<details><summary>${title}: ${s[field].length} (nessuna rimozione/aggiunta dedotta)</summary><ul>${s[field].map(e=>`<li>${esc(e.label)}</li>`).join('')}</ul></details>`:'').join('')}</section>`).join('');
}
const resourceLabels={game_files:'Materiali di gioco',rules:'Regolamento',component:'Componente',online_play:'Versione giocabile online',project_page:'Pagina del progetto',video:'Video',tool:'Strumento',file:'File',folder:'Cartella',document:'Documento',download_page:'Pagina di download',web_app:'Applicazione web',available:'Disponibile',unavailable:'Non disponibile',access_restricted:'Accesso limitato',unknown:'Non verificata',not_checked:'Non verificata',not_observable:'Non osservabile',none_declared:'Nessuna risorsa dichiarata',observed:'Risorse osservate',declared_in_wip:'Dichiarata nel WIP',availability_check:'Verifica disponibilità'};
const resourceLabel=value=>resourceLabels[value]||label(value);
const materialLabels={randomizer:'Randomizzatore',writing_tool:'Strumento di scrittura',standard_deck:'Mazzo standard',token_marker:'Pedina / segnalino',household_item:'Oggetto domestico',printable_component:'Componente stampabile',crafted_component:'Componente da costruire',assembly_material:'Materiale di montaggio',assembly_tool:'Strumento di montaggio',digital_device:'Dispositivo digitale',accessory:'Accessorio',timer:'Timer',scoring_tool:'Strumento segnapunti',required:'Richiesto',optional:'Opzionale',alternative:'Alternativa',unclear:'Non chiaro',printable:'Stampabile',common:'Comune',household:'Domestico',specialized:'Specialistico',supplied_or_printable:'Fornito o stampabile',unspecified:'Non specificato',first_post_only:'Solo primo post',rules_integrated:'Integrato dalle regole'};
const materialLabel=value=>materialLabels[value]||label(value);
function resourceSection(detail) {
  const scan=detail.resource_scans[0];
  const status=scan?.resource_listing_status;
  let intro='Nessuna scansione delle risorse registrata per questa entry.';
  if(status==='observed') intro=`${detail.resources.length} risorse dichiarate osservate nel WIP.`;
  if(status==='none_declared') intro='La scansione registrata non ha rilevato risorse dichiarate nel WIP.';
  if(status==='not_observable') intro='Il contenuto originale non era osservabile: l’assenza di link non prova l’assenza di risorse.';
  if(status==='not_checked') intro='Le risorse di questa entry non sono ancora state controllate.';
  const provenance=scan?`${source(scan.source_url,scan.checked_at,'Fonte della scansione BGG ↗')}${scan.notes?`<small>${esc(scan.notes)}</small>`:''}`:'';
  if(!detail.resources.length) return `<div class="empty"><p>${esc(intro)}</p>${provenance}</div>`;
  return `<p class="subtitle">${esc(intro)} Ogni destinazione è quella registrata nel database; disponibilità “non verificata” significa che il collegamento non è stato aperto durante il censimento.</p>${table(['Risorsa','Tipo','Accesso / stato','Provenienza'],detail.resources.map(r=>{
    const observation=r.observations[0], availability=observation?.availability_status||r.availability_status;
    const title=r.label_raw||r.label||resourceLabel(r.content_role||r.kind);
    return `<tr><td>${externalLink(r.url,title)}${r.version_raw?`<small>Versione: ${esc(r.version_raw)}</small>`:''}<small>${esc(r.host||'Host non registrato')}</small></td><td>${esc(resourceLabel(r.content_role||r.kind))}${r.is_primary?'<small>Risorsa principale dichiarata</small>':''}</td><td>${esc(resourceLabel(r.access_type))}<small>${esc(resourceLabel(availability))}</small></td><td>${source(r.mention_source_url,r.mention_last_seen_at,'Fonte BGG della risorsa ↗')}<small>Osservata: ${esc(day(r.mention_first_seen_at))}</small>${observation?`<small>Ultimo controllo destinazione: ${esc(day(observation.observed_at))} · ${esc(resourceLabel(observation.observation_kind))}</small>`:''}</td></tr>`;
  }))}${provenance}`;
}
function materialSection(detail) {
  const scan=detail.material_scans?.[0], status=scan?.material_listing_status;
  const coverage=scan?.coverage_scope, integrated=coverage==='rules_integrated';
  const origin=integrated?'nelle fonti censite, incluse le regole':'nel primo post';
  let intro='Nessuna scansione dei requisiti materiali registrata per questa entry.';
  if(status==='observed') intro=`${detail.materials.length} requisiti materiali dichiarati ${origin}.`;
  if(status==='none_declared') intro=integrated?'Le fonti censite non espongono requisiti materiali sufficientemente espliciti.':'Il primo post non espone requisiti materiali sufficientemente espliciti; le regole potranno integrare il dato.';
  if(status==='not_observable') intro=integrated?'Le fonti previste non erano osservabili: nessun requisito materiale è stato inventato.':'Il primo post originale non era osservabile: nessun requisito materiale è stato inventato.';
  if(status==='not_checked') intro='Il WIP non è disponibile o i requisiti materiali non sono stati controllati.';
  const provenance=scan?`<div class="material-provenance">${source(scan.source_url,scan.checked_at,'Fonte della rilevazione BGG ↗')}<small>Copertura: ${esc(materialLabel(coverage))}${scan.notes?` · ${esc(scan.notes)}`:''}</small></div>`:'';
  if(!detail.materials?.length) return `<div class="empty"><p>${esc(intro)}</p>${provenance}</div>`;
  const limit=integrated?'La copertura include le regole indicate dalla rilevazione.':'L’elenco è limitato al primo post e potrà essere integrato quando le regole saranno censite.';
  return `<p class="subtitle">${esc(intro)} ${esc(limit)} Quantità non specificata non significa quantità zero.</p>${table(['Materiale dichiarato','Tipo / approvvigionamento','Quantità / necessità','Evidenza e provenienza'],detail.materials.map(m=>`<tr><td><strong>${esc(m.name_raw)}</strong>${m.name_normalized!==m.name_raw?`<small>Normalizzato: ${esc(m.name_normalized)}</small>`:''}</td><td>${esc(materialLabel(m.material_kind))}<small>${esc(materialLabel(m.supply_mode))}</small></td><td>${esc(m.quantity_raw||'Non specificata')}<small>${esc(materialLabel(m.requirement_level))}</small></td><td>${esc(m.context_raw)}${source(m.source_url,m.last_seen_at,'Fonte BGG del requisito ↗')}<small>Osservato: ${esc(day(m.first_seen_at))}${m.last_seen_at!==m.first_seen_at?` · ultimo riscontro: ${esc(day(m.last_seen_at))}`:''}</small></td></tr>`))}${provenance}`;
}
function renderEntry(detail) {
  const e=detail.entry;
  $('#main').innerHTML=`<a class="back" href="#contest/${e.contest_id}">← ${esc(e.contest_name)}</a>`+heading(label(e.scope_type),e.canonical_title,label(e.entry_kind))+`${e.base_game_dependency==='required'?'<div class="notice">Questa entry richiede un gioco base. La disponibilità di componenti PnP aggiuntivi non è presunta.</div>':''}<section class="panel"><h2>Identità e stato</h2>${badge(e.status_normalized)}<div class="facts">${fact('Stato originale',e.status_raw)}${fact('Stato normalizzato',e.status_normalized)}${fact('Materiali · dichiarazione registrata',e.materials_status_raw)}${fact('Materiali · stato normalizzato',e.materials_status_normalized)}${fact('Dipendenza dal gioco base',label(e.base_game_dependency))}${fact('Posizione nella lista (non classifica)',e.position)}${fact('Prima osservazione',day(e.first_seen_at))}${fact('Ultima verifica',day(e.last_verified_at))}</div><div class="page-links">${source(e.entry_url,e.last_verified_at,'Apri la pagina dell’entry su BGG ↗')}${e.wip_thread_url?source(e.wip_thread_url,e.last_verified_at,'Apri il WIP su BGG ↗'):''}</div><p class="source">Le pagine e le risorse vengono aperte soltanto su click in una nuova scheda. L’app non verifica né scarica automaticamente i materiali.</p>${e.summary?`<p>${esc(e.summary)}</p>`:''}</section><h2>Risorse dichiarate</h2>${resourceSection(detail)}<h2>Materiali richiesti</h2>${materialSection(detail)}<h2>Autori e crediti</h2>${table(['Nome','Ruolo','Credito originale'],detail.credits.map(c=>`<tr><td>${esc(c.display_name)}<small>${esc(c.bgg_username)}</small></td><td>${esc(c.role)}</td><td>${esc(c.credit_raw)}</td></tr>`))}<h2>Classifiche di questa entry</h2><p><a href="#rankings/${e.contest_id}">Tutte le classifiche del contest →</a></p>${rankingTable(detail.rankings,false,data.rankings)}<h2>Cronologia degli stati</h2>${table(['Osservazione','Stato','Materiali','Provenienza'],detail.history.map(h=>`<tr><td>${esc(day(h.observed_at))}<small>#${esc(h.check_id)} · ${esc(h.check_kind)}</small></td><td>${badge(h.status_normalized)}<small>${esc(h.status_raw)}</small></td><td>${esc(label(h.materials_status_normalized))}<small>${esc(h.materials_status_raw)}</small></td><td>${source(h.source_url,h.observed_at)}${h.notes?`<small>${esc(h.notes)}</small>`:''}</td></tr>`))}<details><summary>Nomi e titoli storici (${detail.names.length})</summary>${table(['Nome','Osservato','Stato / provenienza'],detail.names.map(n=>`<tr><td>${esc(n.name)}</td><td>${esc(day(n.observed_at))}</td><td>${n.is_current?'Corrente':'Storico'}<small>${esc(n.observed_from)}</small></td></tr>`))}</details>${e.entry_text_raw?`<details><summary>Testo originale registrato</summary><div class="raw">${esc(e.entry_text_raw)}</div></details>`:''}`;
}
function renderDeadlines() {
  const upcoming=data.contests.filter(c=>c.next_deadline).sort((a,b)=>new Date(a.next_deadline)-new Date(b.next_deadline));
  $('#main').innerHTML=heading('CALENDARIO','Le prossime tappe.','La prima fase non trascorsa di ogni contest, calcolata dalle viste SQLite al momento della lettura.')+`<div class="notice">Queste sono scadenze dei contest, non appuntamenti di monitoraggio. Il taccuino operativo resta in sources/MONITORING_CALENDAR.md. Per vedere anche le fasi passate, apri il calendario del contest.</div>`+table(['Scadenza','Contest','Fase','Perimetro','Ultima verifica'],upcoming.map(c=>`<tr><td><strong>${esc(day(c.next_deadline))}</strong></td><td><a href="#contest/${c.contest_id}">${esc(c.contest_name)}</a></td><td>${esc(c.next_phase_label)}</td><td>${esc(label(c.scope_type))}</td><td>${source(c.source_url,c.last_verified_at)}</td></tr>`));
}

function renderPdf(hash) {
  const parts=hash.split('/'),id=parts[1],back=parts[2]==='game'?`game/${parts[3]}`:'library';
  $('#main').innerHTML=`<a class="back" href="#${back}">← ${back==='library'?'Torna alla Libreria':'Torna al gioco'}</a>`+`<section id="pdf-reader" aria-label="Lettore PDF"><div class="pdf-controls"><h2 data-pdf-title>Documento</h2><p class="subtitle" data-pdf-meta></p><div class="filters pdf-toolbar"><button data-pdf-prev disabled>Pagina precedente</button><label class="field">Pagina<input data-pdf-page type="number" min="1" value="1" disabled></label><span data-pdf-count></span><button data-pdf-next disabled>Pagina successiva</button><label class="field">Zoom<select data-pdf-zoom disabled><option value="fit">Adatta alla finestra</option><option value="0.5">50%</option><option value="0.75">75%</option><option value="1">100%</option><option value="1.25">125%</option><option value="1.5">150%</option><option value="2">200%</option><option value="3">300%</option></select></label></div><p data-pdf-status role="status" aria-live="polite">Caricamento PDF…</p></div><div class="pdf-surface" data-pdf-surface tabindex="0" role="region" aria-label="Pagina PDF, frecce sinistra e destra per cambiare pagina"><canvas role="img" aria-label="Documento in caricamento"></canvas></div><details class="pdf-text-details"><summary>Testo della pagina</summary><pre class="pdf-page-text" data-pdf-text></pre></details></section>`;
  activePdfReader=new window.PnPViewers.pdf($('#pdf-reader'));
  activePdfReader.open(id);
}

function renderMaterial(hash) {
  const [kind,id,origin,game]=hash.split('/'),back=origin==='game'?`game/${game}`:'library';
  $('#main').innerHTML=`<a class="back" href="#${back}">← ${back==='library'?'Torna alla Libreria':'Torna al gioco'}</a><section id="material-reader" class="material-reader" aria-label="Lettore ${kind.toUpperCase()}"><div class="material-controls"><h2 data-material-title>Documento</h2><p data-material-meta class="subtitle"></p><p data-material-status role="status" aria-live="polite">Caricamento…</p>${kind==='png'?'<label class="field">Zoom<select data-material-zoom><option value="fit">Adatta alla finestra</option><option value="actual">Dimensione originale</option></select></label>':'<p class="subtitle">Testo formattato, elenchi, tabelle e immagini supportate. Resa adattata: impaginazione, forme, note, intestazioni e revisioni Word non riprodotte integralmente.</p>'}</div><div class="material-surface" data-material-content tabindex="0" role="region" aria-label="Contenuto documento"></div></section>`;
  activePdfReader=new window.PnPViewers.material($('#material-reader'));
  activePdfReader.open(id,kind);
}

async function route() {
  if(!data) return;
  activePdfReader?.destroy();activePdfReader=null;
  const version=++routeVersion;
  const hash=location.hash.slice(1)||'games';
  document.querySelectorAll('[data-nav]').forEach(a=>{const active=a.dataset.nav===hash||(/^(pdf|png|docx)\//.test(hash)&&a.dataset.nav==='library')||(hash.startsWith('game/')&&a.dataset.nav==='games')||((hash.startsWith('rankings')||hash.startsWith('results/'))&&a.dataset.nav==='rankings')||(hash.startsWith('contest/')&&a.dataset.nav==='contests')||((hash.startsWith('entry/')||hash.startsWith('entries/'))&&a.dataset.nav==='entries');a.classList.toggle('active',active);if(active)a.setAttribute('aria-current','page');else a.removeAttribute('aria-current');});
  $('#breadcrumb').textContent=hash==='games'||hash.startsWith('game/')?'Giochi':(hash==='library'||/^(pdf|png|docx)\//.test(hash))?'Libreria':hash==='kanare'?'Kanare_Abstract':hash==='progress'?'Avanzamento BGG':(hash.startsWith('rankings')||hash.startsWith('results/'))?'Risultati BGG':hash.startsWith('entries')?'Entry BGG':hash==='deadlines'?'Scadenze BGG':'Contest BGG';
  try {
    if(hash==='games') renderGames();
    else if(/^pdf\/[1-9]\d*(?:\/(?:library|game\/[1-9]\d*))?$/.test(hash)) {
      renderPdf(hash);
    }
    else if(/^(png|docx)\/[1-9]\d*(?:\/(?:library|game\/[1-9]\d*))?$/.test(hash)) {
      renderMaterial(hash);
    }
    else if(hash==='library') {
      const library=await api('/api/library');
      if(version!==routeVersion)return;
      renderLibrary(library);
    }
    else if(hash==='kanare') renderGames('kanare_abstract');
    else if(/^game\/[1-9]\d*$/.test(hash)) {
      $('#main').innerHTML='<div class="empty" role="status">Lettura del gioco canonico…</div>';
      const detail=await api(`/api/games/${hash.split('/')[1]}`);
      if(version!==routeVersion)return;
      renderGameDetail(detail);
    }
    else if(hash==='progress') renderProgress();
    else if(hash==='contests') renderContests();
    else if(/^entries(?:\/year\/\d{4}|\/contest\/[1-9]\d*(?:\/(?:read|unread|downloaded))?)?$/.test(hash)) renderEntriesRoute(hash);
    else if(hash==='deadlines') renderDeadlines();
    else if(/^rankings(?:\/[1-9]\d*)?$/.test(hash)) renderRankings(hash.split('/')[1]||'');
    else if(/^results\/[1-9]\d*$/.test(hash)) renderContestResults(hash.split('/')[1]);
    else if(/^contest\/[1-9]\d*$/.test(hash)||/^entry\/[1-9]\d*$/.test(hash)) {
      const [kind,id]=hash.split('/');
      $('#main').innerHTML='<div class="empty" role="status">Lettura del dettaglio…</div>';
      const detail=await api(`/api/${kind==='contest'?'contests':'entries'}/${id}`);
      if(version!==routeVersion)return;
      (kind==='contest'?renderContest:renderEntry)(detail);
    } else $('#main').innerHTML='<div class="empty">Pagina non trovata. <a href="#games">Torna ai giochi</a></div>';
    document.title=`${$('#main h1')?.textContent||'Archivio'} · PnP Collection`;
    window.scrollTo(0,0);
  } catch(error) {if(version===routeVersion)errorPanel(error);}
}
$('#refresh').onclick=load;
$('.skip').onclick=event=>{event.preventDefault();$('#main').focus();$('#main').scrollIntoView();};
window.addEventListener('hashchange',()=>{route();$('#main').focus({preventScroll:true});});
load();
