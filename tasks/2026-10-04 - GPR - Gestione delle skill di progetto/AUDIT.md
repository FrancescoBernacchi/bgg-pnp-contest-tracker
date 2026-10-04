# Audit delle competenze — 2026-10-04

Riorganizzazione offline TSK-0048; nessuna nuova verifica delle fonti esterne. Le date seguenti sono quelle delle prove originarie, non nuovi rilevamenti. Inventario operativo: [SKILL_INVENTORY.md](../../sources/SKILL_INVENTORY.md).

| Competenza | Evidenza locale | Grado e limiti | Destinazione |
|---|---|---|---|
| Fonti roster; link dinamici | Playbook, Roll & Write 2025, 2026-09-10: 37/37 WIP risolti contro 18 da ricerca sostitutiva | Verificata per struttura osservata; non usare lettura DOM iniziale come prova di assenza | Base condivisa |
| GeekList progressiva | Playbook e TSK-0012, 2026-09-16: 166/166 item | Verificata; salto in fondo perde intermedi | Base e contest-census |
| Nuove edizioni | TSK-0026/playbook, 2026-10-02: Roll & Write 2026 assente dalla GeekList, trovato nel forum Recent | Verificata; Active non ordina per creazione | contest-census |
| Identità globale e stati | TSK-0012; catalog/build_global_contest_census.py e verificatori globali | Procedura verificata; chiavi testuali e stati da anno/titolo nel generatore sono euristiche storiche, non prove correnti | contest-census |
| Roster annuale | TSK-0005, TSK-0015, TSK-0017; sources/2024-CORE-ROSTER-COMPLETION.md | Riconciliazione verificata, due titoli 9-Card non osservabili; challenge mancanti restano lacune | Procedura annuale nella base |
| Classifiche | TSK-0045 VERIFICA_2026-10-04.md: 11/11 fonti, 247/464 entry in lista; TSK-0046: 869 righe, 239/409 entry in lista | Verificata; completezza del confronto non prova classifica integrale; spoiler, immagini d10, ex aequo, GeekGold distinti | ranking-census |
| Primo post e risorse | Playbook e TSK-0009: Black Market non osservabile; Lucky Words immagine esplicitamente stampabile; Solomode aggiuntivi | Verificata nel primo post; tassonomia provvisoria e regole non integrate | material-census |
| Acquisizione e cartelle | TSK-0030: Proton 2/2; 146 hash/formati verificati; manifest/verificatore Roll & Write | Verificata nel lotto; enumeration universale di host futuri non dimostrata | material-acquisition |
| Restrizioni/esclusioni | TSK-0029: file Itch parziali, 404, Cloudflare, PT-BR escluse; TSK-0043 sospeso prima di approvazione | Blocchi ed esiti documentati, non assenza certa; nessuna ripresa implicita Wargame | material-acquisition |
| Fonti candidate | TSK-0037/0039; MULTISOURCE-CANDIDATE-SOURCES e MULTISOURCE-SOURCE-RANKING, 2026-10-03 | Metodo v1 verificato localmente; quantità spesso dichiarate, simulatori non collaudati; priorità baseline sostituite | potential-source-discovery |
| Preanalisi fonte | TSK-0018 Kanare, 2026-09-20; schema 009, TSK-0022 e censimento Kanare successivi | Gioco/prodotto/record distinti su fonte reale; mapping ad altri host e costi futuri sono proposte non collaudate | source-preanalysis |
| Metriche e prove storiche | Migrazione 012, app/work_progress.py; TSK-0047/HISTORY_AUDIT.md | Riconciliazione locale verificata; file o piazzamenti da soli non provano completamento | Skill classifiche/roster/acquisizione |

## Esperimenti ed inferenze da non promuovere

- La ricerca sostitutiva iniziale 18 WIP è un tentativo insufficiente, sostituito dalla risoluzione dei componenti; conservarne il limite nel playbook.
- Etichetta `restricted` respinta dallo schema nel lotto Roll & Write, sostituita con `access_restricted`: incidente corretto, non nuovo enum da introdurre.
- Generatori/importatori storici contengono ID, date e percorsi fissi, e alcuni script fanno rete o scritture all'avvio. Sono esempi di implementazione, non helper generici né autorizzazione a eseguirli.
- Stati normalizzati per anno/sezione/titolo, somiglianze testuali, gratuità di un intero marketplace, stabilità futura e costi di integrazione restano inferenze da esplicitare.

## Lacune e proposte

Nessuna nuova modifica contrattuale EPR adottata. Roster annuale identificabile nel riferimento dedicato: una settima skill ora duplichererebbe una procedura breve; riesaminare se cresce. Monitoraggio conserva calendario, contratto e base; nessuna settima skill di monitoraggio introdotta senza bisogno ricorrente dimostrato.

Restano da collaudare la preanalisi su una fonte diversa da Kanare, procedure di enumerazione su nuovi host e gestione degli identificativi di nuove fonti. Tassonomia risorse ancora provvisoria; IMG richiede contratto EPR distinto. Le sei skill sono verificate staticamente e su casi locali, non attraverso nuove esecuzioni dei workflow.

## Promozione e manutenzione

La richiesta autorizza questa promozione organizzativa delle prove esistenti; nessun fatto esterno è aggiornato. Conservati nome/percorso della base e playbook per compatibilità con task storici. Inventario mantiene stato e verifica datata; una nuova esperienza richiede task sorgente, metodo riuscito, verifica e limiti prima della promozione. Se cambia contratto o architettura, formulare proposta EPR separata e richiedere decisione solo per essa.
