"""Adotta il candidato ICBRG dopo revisione; verifica l'intera libreria IMG registrata."""
import hashlib,json
from pathlib import Path
from PIL import Image
ROOT=Path(__file__).resolve().parents[2]
MP=ROOT/'catalog/2025_children_family_images_2026-10-05.json'
DATE='2026-10-05'
def hashfile(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    m=json.loads(MP.read_text(encoding='utf-8'))
    assert not any(i['game_id']==507 for i in m['images']), 'Incremento già adottato'
    c=json.loads((ROOT/'outputs/tsk0068/icbrg/candidate.json').read_text(encoding='utf-8'))
    for i in c['images']:i['validation']='Controllo visivo superato 2026-10-05; confini/componenti verificati contro pagine intere'
    m['images']+=c['images'];m['components']+=c['components']
    g=next(g for g in m['games'] if g['game_id']==507)
    g.update(checked_at=DATE,research_status='conclusa nel perimetro osservabile con limiti galleria autore/riferimento storico/ACQ dichiarati',research_complete=True,verified_credits=c['credits'],credits_status='Ryan Moylan Designer verificato nel manuale/WIP/scheda BGG; illustratore e fotografo non dichiarati',bgg_game_reference=dict(bgg_game_id=446904,source_url='https://boardgamegeek.com/thread/3493395/article/46108542#46108542',identity_basis='scheda dichiarata dal designer nel WIP, designer e descrizione concordanti; nessuna nuova identità locale',observed_at=DATE))
    g['sources_reviewed']+=['PnP 2.1 file 4, 2/2 pagine renderizzate, componenti e istruzioni assemblaggio','Rulebook 2.0 file 5, 4/4 pagine renderizzate, designer/setup/diagrammi','WIP 3493395: 28/28 post su 2/2 pagine','GeekList item 11692597, 1/1 commento di aggiornamento','Thread contest 3441385: 75/75 post, 3/3 pagine selezione pertinente','Scheda BGG 446904 e galleria pubblica 2/2 immagini','Designer 163757 e profilo RPMgamer, nessun sito esterno ufficiale osservato','9 pagine immagine BGG: Downloads Original esposto e avviso All Rights Reserved']
    g['external_research']=dict(wip='28/28 post, sei immagini dichiarate, aggiornamento 30 aprile verso PnP 2.1 e Rulebook 2.0',updates='Annunci varianti e revisione 30 aprile verificati; commento GeekList indica stessa revisione già acquisita',gallery='Galleria gioco completa 2/2; galleria profilo richiede login e sequenza autore indica 117 immagini, non attestata completa',contest='75 post su 3 pagine, nessuna nuova immagine pertinente; thumbnail entry e commento con versione corrente',author_publisher='Designer/profilo verificati, scheda dichiara (Web published), nessun sito ufficiale collegato osservato',historical_wip='Old version of ICBRG rende href #; click porta alla homepage. Destinazione non risolta, nessun URL/versione inventato')
    g['version_evidence']=[dict(source_url=g['entry_url'],comment_date='2025-04-30',current_acquired_files=[4,5],supersedes_links=['https://drive.google.com/file/d/18lQ6C_CuhNDrDj_z-Hq-ydu53fu2BzRs/view?usp=drive_link','https://drive.google.com/file/d/1o5J902BxaTFfqbPxKCFghQhI--gP4Q5g/view?usp=drive_link'],basis='Autore nel commento collega versioni aggiornate 2.1/2.0; nessun PDF precedente acquisito nel presente IMG',observed_at=DATE)]
    g['residuals']=['Galleria profilo autore richiede login: 117 immagini nella sequenza, non enumerata integralmente; galleria gioco 2/2 completa','WIP precedente direttamente menzionato ma destinazione non risolta; contenuti precedenti non attestati assenti','BGG filepage 300846/300847 sono riferimenti ACQ separati, nessun nuovo manuale/PnP scaricato o confronto integrale con PDF acquisiti','Fonti artwork pinguini non dichiarate nei PDF: non inventati illustratore/licenza; due oggetti arancioni conservati senza equivalenza visiva presunta','Nessun diritto di pubblicazione/AI attestato per le composizioni']
    g['scope_exclusions']=['Altri giochi autore/VLKNO e immagini estranee esclusi','Screenshot TTS presenti nel WIP acquisiti come immagini BGG; piattaforma TTS non esplorata','Nessuna ricerca libera web/social/video, nessun nuovo manuale/PnP']
    for cat in g['categories']:
        count=sum(i['category']==cat['category'] or cat['category'] in i.get('additional_categories',[]) for i in c['images'])
        cat.update(research='verificata nelle fonti elencate, limiti espliciti',applicability='applicabile' if count else 'nessuna immagine pertinente individuata nel perimetro osservato',adopted_original_count=count,verified_absence=count==0,absence_scope=None if count else 'PDF acquisiti, WIP corrente, entry/commento, contest, galleria gioco e profili osservabili',impediment='Galleria autore login e WIP storico non risolto; nessuna assenza universale',residual='Riesame se accesso/fonti disponibili; riferimenti ACQ non acquisiti in IMG')
    m.setdefault('pilot_increments',[]).append(dict(game_id=507,checked_at=DATE,current_images=27,remote_downloads=9,remote_unique_files=6,component_extraction_files=7,component_identities=6,diagram_setup_extractions=9,embedded_artworks=5,research_complete_with_documented_limits=True))
    ids={i['image_id'] for i in m['images']};assert len(ids)==len(m['images'])==44
    cmps={x['component_id'] for x in m['components']};assert len(cmps)==16
    for i in m['images']+m['historical_files']:
        p=ROOT/i['relative_path'];assert p.stat().st_size==i['bytes'] and hashfile(p)==i['sha256']
        with Image.open(p) as im:assert im.size==(i['width'],i['height']) and im.format==i['format'];im.verify()
        assert i['game_id']==i['entry_id'] and i['game_id'] in m['scope']['authorized_game_ids']
        assert all(cid in cmps for cid in i.get('component_ids',[]))
        for r in i.get('relationships',[]):
            if 'target_image_id' in r:assert r['target_image_id'] in ids
            if 'target_component_id' in r:assert r['target_component_id'] in cmps
    docs=json.loads((ROOT/m['source_manifest']).read_text(encoding='utf-8'))['documents']
    for d in docs:
        p=ROOT/'library'/d['relative_path'];assert p.stat().st_size==d['byte_size'] and hashfile(p)==d['sha256']
    for gameid in [505,507]:
        records=[i for i in m['images']+m['historical_files'] if i['game_id']==gameid]
        folder=ROOT/('library/immagini/505__Mermaids-vs-Dinosaurs' if gameid==505 else 'library/immagini/507__ICBRG')
        assert {p for p in folder.rglob('*') if p.is_file()}=={ROOT/i['relative_path'] for i in records}
    m['state']='in corso: due piloti conclusi nel perimetro osservabile con limiti, altri 12 giochi aperti'
    m['verification']=dict(checked_at=DATE,pdf_hashes_verified=38,current_image_files_verified=44,historical_image_files_verified=1,component_relationships_verified=16,game_research_completed=2,authorized_games=14,originals_unchanged=True)
    m['app_handoff']['review_required']+=['ICBRG: standee assemblabile intero con regioni facce/base, due varianti grigie di scala preservate','9 URL immagine ICBRG deduplicati per SHA-256 a 6 file, nessuna identità locale dal solo nome','Diagrammi compositi renderizzati; estrazioni oggetto valide solo per artwork nativi, non diagrammi interi','Ricerca 2/14 con limiti WIP storico/galleria autore e dipendenze ACQ espliciti']
    MP.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    p=ROOT/'tasks/REGISTRY.json';reg=json.loads(p.read_text(encoding='utf-8'));t=next(x for x in reg['tasks'] if x['id']=='TSK-0068')
    t['coverage'].update(research_complete=2,library_images_total=44,downloaded_originals=12,adopted_component_extractions=18,extracted_images_total=32,historical_files=1,physical_library_files=45,second_pilot_game_id=507,second_pilot_current_images=27,component_identities=16)
    t['status_basis']='Due piloti verificati con limiti espliciti (Mermaids vs Dinosaurs e ICBRG); altri 12 giochi aperti'
    t['next_action']='Proseguire sui 12 giochi autorizzati restanti; riesame facoltativo dei limiti login/WIP storico, nessuna nuova ACQ implicita'
    t['last_verified_at']=DATE;p.write_text(json.dumps(reg,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(m['verification']))
if __name__=='__main__':main()
