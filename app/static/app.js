'use strict';
const $ = (selector) => document.querySelector(selector);
const esc = (value) => String(value ?? '—').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const labels = {pnp_core:'PnP principali',adjacent:'Adiacenti',standard:'Gioco PnP autonomo',format_adjacent:'Formato adiacente',selective_entries:'Entry selezionate',dependent_variants:'Varianti dipendenti',standalone_game:'Gioco autonomo',dependent_variant:'Variante dipendente',none:'Nessuna',required:'Gioco base richiesto',unknown:'Non noto',entries_open:'Entry aperte',development:'In sviluppo',freeze:'Freeze',voting:'Votazione',awaiting_results:'In attesa dei risultati',complete:'Concluso',announced:'Annunciato',suspended:'Sospeso',cancelled:'Annullato',idea:'Idea',wip:'In lavorazione',components_available:'Componenti disponibili',playtest_ready:'Pronto al playtest',contest_ready:'Pronto al contest',withdrawn:'Ritirata',incomplete:'Incompleta',disqualified:'Squalificata',available:'Disponibili',unavailable:'Non disponibili',no_change:'Nessuna variazione dichiarata',partial:'Parziale',status_raw:'Stato originale',status_normalized:'Stato normalizzato',materials_status_raw:'Materiali · originale',materials_status_normalized:'Materiali · normalizzato',position:'Posizione nella lista',numeric_value:'Valore numerico',text_value:'Valore testuale',unit:'Unità',method:'Metodo',is_official:'Ufficiale (1=sì, 0=no)',starts_at:'Inizio',ends_at:'Fine'};
const label = value => labels[value] || value || 'Non noto';
labels.playtest='Playtest';
labels.active='In corso';
labels.planned='Pianificata';
const day = value => {
  if (!value) return 'Non registrata';
  const parts = String(value).match(/^(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}:\d{2})(?::\d{2})?(Z|[+-]\d{2}:\d{2})?)?$/);
  if (!parts) return value;
  return `${parts[3]}/${parts[2]}/${parts[1]}${parts[4]?` · ${parts[4]}${parts[5]?` UTC${parts[5]==='Z'?'':parts[5]}`:''}`:''}`;
};
const badge = value => `<span class="badge ${['entries_open','development','playtest_ready','contest_ready'].includes(value)?'open':['voting','awaiting_results'].includes(value)?'voting':value==='complete'?'done':['withdrawn','cancelled','partial'].includes(value)?'warn':''}">${esc(label(value))}</span>`;
function source(url, date) {
  let link = '';
  try {
    const parsed = new URL(url);
    // Solo pagine BGG di metadati. File, download, host esterni e schemi attivi non diventano link.
    if (parsed.protocol === 'https:' && ['boardgamegeek.com','www.boardgamegeek.com'].includes(parsed.hostname) && !parsed.port && !parsed.username && !parsed.password && /^\/(thread|geeklist|boardgame|boardgameexpansion|guild|forum)\/\d+(\/|$)/.test(parsed.pathname)) {
      link = `<a href="${esc(parsed.href)}" target="_blank" rel="noopener noreferrer">Fonte BGG ↗</a>`;
    }
  } catch (_) { /* URL mancante o non navigabile */ }
  if (!link && url) link = `<span>Fonte registrata: ${esc(url)}</span>`;
  return `<div class="source">${link || 'Fonte non registrata'}${date ? `<br>Verificato: ${esc(day(date))}` : ''}</div>`;
}
const fact = (title, value) => `<div class="fact"><small>${esc(title)}</small><span>${esc(value ?? 'Non registrato')}</span></div>`;
const table = (headers, body) => body.length ? `<div class="table-wrap"><table><thead><tr>${headers.map(h=>`<th scope="col">${esc(h)}</th>`).join('')}</tr></thead><tbody>${body.join('')}</tbody></table></div>` : '<div class="empty">Nessun dato registrato per questa sezione.</div>';
const heading = (eyebrow, title, subtitle) => `<div class="page-heading"><div><p class="eyebrow">${esc(eyebrow)}</p><h1>${esc(title)}</h1><p class="subtitle">${esc(subtitle)}</p></div><span class="stamp">● Sola lettura</span></div>`;
const options = (values, first) => `<option value="">${esc(first)}</option>` + [...new Set(values.filter(v=>v!==null && v!==undefined))].sort().map(v=>`<option value="${esc(v)}">${esc(label(v))}</option>`).join('');
let data = null, routeVersion = 0;
const filters = {scope:'',contestState:'',year:'',query:'',entryQuery:'',entryState:'',entryKind:'',entryScope:'',entryContest:'',entrySort:'title',page:1};
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
    $('#freshness').textContent = `Letto il ${day(data.generated_at)}`;
    await route();
  } catch(error) { errorPanel(error); }
  finally { $('#refresh').disabled = false; }
}
function stats() {
  const core = data.contests.filter(c=>c.scope_type==='pnp_core').length;
  const dependent = data.entries.filter(e=>e.entry_kind==='dependent_variant').length;
  return `<div class="stats"><div class="stat"><span>Contest nell’archivio</span><strong>${data.contests.length}</strong><small>Edizioni catalogate</small></div><div class="stat"><span>PnP principali</span><strong>${core}</strong><small>${data.contests.length-core} contest adiacenti separati</small></div><div class="stat"><span>Entry censite</span><strong>${data.entries.length}</strong><small>Include le entry ritirate</small></div><div class="stat"><span>Varianti dipendenti</span><strong>${dependent}</strong><small>Da un gioco base</small></div></div>`;
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
  return `<div class="filters"><label class="field grow">Cerca entry o autore<input type="search" id="entry-search" placeholder="Titolo, nome o autore…" value="${esc(filters.entryQuery)}"></label><label class="field">Stato entry<select id="entry-state">${options(entries.map(e=>e.status_normalized),'Tutti gli stati')}</select></label><label class="field">Tipologia<select id="entry-kind">${options(entries.map(e=>e.entry_kind),'Tutte le tipologie')}</select></label>${contestId?'':`<label class="field">Perimetro<select id="entry-scope">${options(['pnp_core','adjacent'],'Tutti')}</select></label><label class="field">Contest<select id="entry-contest"><option value="">Tutti i contest</option>${data.contests.map(c=>`<option value="${c.contest_id}">${esc(c.contest_name)}</option>`).join('')}</select></label>`}<label class="field">Ordina<select id="entry-sort"><option value="title">Titolo A–Z</option><option value="position">Posizione nella lista</option><option value="verified">Verifica più recente</option></select></label></div><div id="entry-results" aria-live="polite"></div>`;
}
function bindEntryFilters(contestId=null) {
  for (const [id,key] of [['entry-state','entryState'],['entry-kind','entryKind'],['entry-scope','entryScope'],['entry-contest','entryContest'],['entry-sort','entrySort']]) {
    if (!$('#'+id)) continue;
    if (![...$('#'+id).options].some(o=>o.value===filters[key])) filters[key]='';
    $('#'+id).value=filters[key];
    $('#'+id).onchange=event=>{filters[key]=event.target.value;filters.page=1;entryResults(contestId);};
  }
  $('#entry-search').oninput=event=>{filters.entryQuery=event.target.value;filters.page=1;entryResults(contestId);};
  entryResults(contestId);
}
function entryResults(contestId=null) {
  let entries=data.entries.filter(e=>(!contestId||e.contest_id===contestId)&&(!filters.entryState||e.status_normalized===filters.entryState)&&(!filters.entryKind||e.entry_kind===filters.entryKind)&&(contestId||!filters.entryScope||e.scope_type===filters.entryScope)&&(contestId||!filters.entryContest||String(e.contest_id)===filters.entryContest)&&`${e.canonical_title} ${e.credits||''}`.toLocaleLowerCase().includes(filters.entryQuery.toLocaleLowerCase().trim()));
  entries.sort((a,b)=>filters.entrySort==='position'?(a.position??Infinity)-(b.position??Infinity)||a.id-b.id:filters.entrySort==='verified'?String(b.last_verified_at).localeCompare(String(a.last_verified_at))||a.id-b.id:a.canonical_title.localeCompare(b.canonical_title,'it')||a.id-b.id);
  const pages=Math.max(1,Math.ceil(entries.length/30)); filters.page=Math.min(filters.page,pages);
  const shown=entries.slice((filters.page-1)*30,filters.page*30);
  $('#entry-results').innerHTML=`<div class="section-heading"><h2>${entries.length} entry</h2><span>Stati registrati, senza verifica dei file</span></div>`+table(['Entry','Contest','Stato','Tipologia','Verifica'],shown.map(e=>`<tr><td><a href="#entry/${e.id}">${esc(e.canonical_title)}</a><small>${e.position==null?'':`#${e.position} · `}${esc(e.credits||'Autore non registrato')}</small></td><td><a href="#contest/${e.contest_id}">${esc(e.contest_name)}</a><small>${esc(label(e.scope_type))}</small></td><td>${badge(e.status_normalized)}<small>${esc(e.status_raw)}</small></td><td>${esc(label(e.entry_kind))}<small>${e.base_game_dependency!=='none'?esc(label(e.base_game_dependency)):''}</small></td><td>${esc(day(e.last_verified_at))}</td></tr>`))+`<div class="pager"><span>Pagina ${filters.page} di ${pages} · fino a 30 entry per pagina</span><div><button id="prev" class="quiet" ${filters.page===1?'disabled':''}>← Precedente</button><button id="next" class="quiet" ${filters.page===pages?'disabled':''}>Successiva →</button></div></div>`;
  $('#prev').onclick=()=>{filters.page--;entryResults(contestId);};
  $('#next').onclick=()=>{filters.page++;entryResults(contestId);};
}
function rankingTable(rankings, titles=false) {
  return table(titles?['Entry','Categoria','Piazzamento / punteggio','Natura e fonte']:['Categoria','Piazzamento / punteggio','Natura e fonte'],rankings.map(r=>`<tr>${titles?`<td>${r.entry_id?`<a href="#entry/${r.entry_id}">${esc(r.canonical_title)}</a>`:esc(r.canonical_title)}</td>`:''}<td>${esc(r.category)}</td><td>${r.rank==null?'—':`#${r.rank}`}<small>Punteggio: ${esc(r.score)} · Voti: ${esc(r.vote_count)}</small></td><td>${r.is_official?'Risultato ufficiale':'Segnale sostitutivo · non ufficiale'}${source(r.evidence_url,r.verified_at)}</td></tr>`));
}
function metricsTable(metrics) {
  return table(['Metrica','Valore','Metodo / natura','Provenienza'],metrics.map(m=>`<tr><td>${esc(m.metric_label_raw||m.metric_key)}<small>${esc(m.metric_key)} · ${m.latest?'Più recente':'Storica'}</small></td><td>${esc(m.numeric_value??m.text_value)} ${esc(m.unit||'')}</td><td>${esc(m.method)}<small>${m.is_official?'Ufficiale':'Non ufficiale · segnale sostitutivo'}</small>${m.notes?`<small>${esc(m.notes)}</small>`:''}</td><td>${source(m.source_url,m.observed_at)}</td></tr>`));
}
function renderContest(detail) {
  const c=detail.contest, entries=data.entries.filter(e=>e.contest_id===c.contest_id), counts={};
  entries.forEach(e=>counts[e.status_normalized]=(counts[e.status_normalized]||0)+1);
  $('#main').innerHTML=`<a class="back" href="#contests">← Tutti i contest</a>`+heading(`${label(c.scope_type)} / ${c.year??'Anno non registrato'}`,c.contest_name,label(c.treatment_profile))+`
    <div class="detail-grid"><section class="panel"><h2>Il contest, oggi nel catalogo</h2>${badge(c.status_normalized)}<div class="facts">${fact('Stato originale dichiarato',c.status_raw)}${fact('Stato normalizzato',c.status_normalized)}${fact('Organizzatore',c.organizer)}${fact('Ultima verifica della fonte',day(c.last_verified_at))}</div>${source(c.source_url,c.last_verified_at)}</section><section class="panel"><h2>${c.entry_count} entry censite</h2><p class="subtitle">${c.withdrawn_entry_count} ritirate · ${c.dependent_variant_count} varianti dipendenti</p><div class="distribution">${Object.entries(counts).map(([k,v])=>`<span>${esc(label(k))}<b>${v}</b></span>`).join('')}</div></section></div>
    <div class="segmented" aria-label="Sezioni del contest">${[['entries','Entry'],['schedule','Fasi e scadenze'],['statistics','Statistiche e risultati'],['history','Rilevamenti e cambiamenti']].map(([v,t],i)=>`<button data-section="${v}" class="${i===0?'selected':''}" aria-pressed="${i===0}">${t}</button>`).join('')}</div><section id="contest-section"></section>`;
  function section(name) {
    document.querySelectorAll('[data-section]').forEach(b=>{b.classList.toggle('selected',b.dataset.section===name);b.setAttribute('aria-pressed',String(b.dataset.section===name));});
    const target=$('#contest-section');
    if(name==='entries'){ target.innerHTML=entryFilters(c.contest_id);bindEntryFilters(c.contest_id); }
    if(name==='schedule') target.innerHTML=`<h2>Calendario registrato</h2><p class="subtitle">Le date e i fusi orari mantengono la precisione della fonte. Il superamento di una data non cambia automaticamente lo stato del contest.</p><div class="panel facts">${fact('Chiusura entry',day(c.schedule.submissions_close_at))}${fact('Apertura voto',day(c.schedule.voting_opens_at))}${fact('Chiusura voto',day(c.schedule.voting_closes_at))}</div>`+table(['Fase','Stato dichiarato','Intervallo','Precisione e fonte'],detail.phases.map(p=>`<tr><td>${esc(p.label_raw)}<small>${esc(p.phase_type)}</small>${p.notes?`<small>${esc(p.notes)}</small>`:''}</td><td>${badge(p.status_normalized)}<small>${esc(p.status_raw)}</small></td><td>${esc(day(p.starts_at))}<br>→ ${esc(day(p.ends_at))}</td><td>${esc(p.date_precision)} · ${esc(p.timezone||'Fuso non registrato')}${source(p.source_url,p.last_verified_at)}</td></tr>`));
    if(name==='statistics') target.innerHTML=`<h2>Statistiche più recenti</h2><p class="subtitle">Una sola osservazione per metrica, ordinata per data e identificativo. Eventuali correzioni restano nello storico.</p>${metricsTable(detail.metrics.filter(m=>m.latest))}<details><summary>Tutte le osservazioni delle metriche (${detail.metrics.length})</summary>${metricsTable(detail.metrics)}</details><h2>Classifiche e votazioni</h2>${rankingTable(detail.rankings,true)}`;
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
function renderEntry(detail) {
  const e=detail.entry;
  $('#main').innerHTML=`<a class="back" href="#contest/${e.contest_id}">← ${esc(e.contest_name)}</a>`+heading(label(e.scope_type),e.canonical_title,label(e.entry_kind))+`${e.base_game_dependency==='required'?'<div class="notice">Questa entry richiede un gioco base. La disponibilità di componenti PnP aggiuntivi non è presunta.</div>':''}<section class="panel"><h2>Identità e stato</h2>${badge(e.status_normalized)}<div class="facts">${fact('Stato originale',e.status_raw)}${fact('Stato normalizzato',e.status_normalized)}${fact('Materiali · dichiarazione registrata',e.materials_status_raw)}${fact('Materiali · stato normalizzato',e.materials_status_normalized)}${fact('Dipendenza dal gioco base',label(e.base_game_dependency))}${fact('Posizione nella lista (non classifica)',e.position)}${fact('Prima osservazione',day(e.first_seen_at))}${fact('Ultima verifica',day(e.last_verified_at))}</div>${source(e.entry_url,e.last_verified_at)}${e.wip_thread_url?source(e.wip_thread_url):''}<p class="source">Gli stati dei materiali sono metadati registrati: nessun file è verificato o aperto dall’applicazione.</p>${e.summary?`<p>${esc(e.summary)}</p>`:''}</section><h2>Autori e crediti</h2>${table(['Nome','Ruolo','Credito originale'],detail.credits.map(c=>`<tr><td>${esc(c.display_name)}<small>${esc(c.bgg_username)}</small></td><td>${esc(c.role)}</td><td>${esc(c.credit_raw)}</td></tr>`))}<h2>Classifiche di questa entry</h2>${rankingTable(detail.rankings)}<h2>Cronologia degli stati</h2>${table(['Osservazione','Stato','Materiali','Provenienza'],detail.history.map(h=>`<tr><td>${esc(day(h.observed_at))}<small>#${esc(h.check_id)} · ${esc(h.check_kind)}</small></td><td>${badge(h.status_normalized)}<small>${esc(h.status_raw)}</small></td><td>${esc(label(h.materials_status_normalized))}<small>${esc(h.materials_status_raw)}</small></td><td>${source(h.source_url,h.observed_at)}${h.notes?`<small>${esc(h.notes)}</small>`:''}</td></tr>`))}<details><summary>Nomi e titoli storici (${detail.names.length})</summary>${table(['Nome','Osservato','Stato / provenienza'],detail.names.map(n=>`<tr><td>${esc(n.name)}</td><td>${esc(day(n.observed_at))}</td><td>${n.is_current?'Corrente':'Storico'}<small>${esc(n.observed_from)}</small></td></tr>`))}</details>${e.entry_text_raw?`<details><summary>Testo originale registrato</summary><div class="raw">${esc(e.entry_text_raw)}</div></details>`:''}`;
}
function renderDeadlines() {
  const upcoming=data.contests.filter(c=>c.next_deadline).sort((a,b)=>new Date(a.next_deadline)-new Date(b.next_deadline));
  $('#main').innerHTML=heading('CALENDARIO','Le prossime tappe.','La prima fase non trascorsa di ogni contest, calcolata dalle viste SQLite al momento della lettura.')+`<div class="notice">Queste sono scadenze dei contest, non appuntamenti di monitoraggio. Il taccuino operativo resta in sources/MONITORING_CALENDAR.md. Per vedere anche le fasi passate, apri il calendario del contest.</div>`+table(['Scadenza','Contest','Fase','Perimetro','Ultima verifica'],upcoming.map(c=>`<tr><td><strong>${esc(day(c.next_deadline))}</strong></td><td><a href="#contest/${c.contest_id}">${esc(c.contest_name)}</a></td><td>${esc(c.next_phase_label)}</td><td>${esc(label(c.scope_type))}</td><td>${source(c.source_url,c.last_verified_at)}</td></tr>`));
}
async function route() {
  if(!data) return;
  const version=++routeVersion;
  const hash=location.hash.slice(1)||'contests';
  document.querySelectorAll('[data-nav]').forEach(a=>{const active=a.dataset.nav===hash||(hash.startsWith('contest/')&&a.dataset.nav==='contests')||(hash.startsWith('entry/')&&a.dataset.nav==='entries');a.classList.toggle('active',active);if(active)a.setAttribute('aria-current','page');else a.removeAttribute('aria-current');});
  $('#breadcrumb').textContent=hash==='entries'?'Tutte le entry':hash==='deadlines'?'Scadenze':'Contest di design';
  try {
    if(hash==='contests') renderContests();
    else if(hash==='entries') {$('#main').innerHTML=heading('IL CATALOGO','Ogni gioco, una nuova idea.','Cerca fra tutte le entry, comprese quelle ritirate e le varianti dipendenti.')+entryFilters();bindEntryFilters();}
    else if(hash==='deadlines') renderDeadlines();
    else if(/^contest\/[1-9]\d*$/.test(hash)||/^entry\/[1-9]\d*$/.test(hash)) {
      const [kind,id]=hash.split('/');
      $('#main').innerHTML='<div class="empty" role="status">Lettura del dettaglio…</div>';
      const detail=await api(`/api/${kind==='contest'?'contests':'entries'}/${id}`);
      if(version!==routeVersion)return;
      (kind==='contest'?renderContest:renderEntry)(detail);
    } else $('#main').innerHTML='<div class="empty">Pagina non trovata. <a href="#contests">Torna ai contest</a></div>';
    document.title=`${$('#main h1')?.textContent||'Archivio'} · PnP Collection`;
    window.scrollTo(0,0);
  } catch(error) {if(version===routeVersion)errorPanel(error);}
}
$('#refresh').onclick=load;
$('.skip').onclick=event=>{event.preventDefault();$('#main').focus();$('#main').scrollIntoView();};
window.addEventListener('hashchange',()=>{route();$('#main').focus({preventScroll:true});});
load();
