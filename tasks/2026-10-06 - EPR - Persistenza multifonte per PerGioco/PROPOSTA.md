# Decisione proposta B-v1 — TSK-0076

Stato corrente: B-v1 e piano identità confermati esplicitamente il 2026-10-06, registrazione in [DECISIONE.md](DECISIONE.md). Il testo seguente conserva la proposta e le domande originarie prima della conferma; non descrive uno stato decisionale ancora pendente. Nessuna implementazione autorizzata dalla conferma EPR.

2026-10-06. **Da deliberare, non adottata.** Preparazione autorizzata dal prompt utente; TSK-0075 predecessore concluso, TSK-0073 decisione di perimetro, TSK-0074 fonte delle evidenze. Nessuna nuova osservazione esterna.

## Decisione concreta

Adottare come direzione architetturale un'estensione additiva e generica del nucleo multifonte 009: identità canoniche e record fonte esistenti rimangono distinti; introdurre osservazioni immutabili con provenienza, esiti di ammissione/completezza, classificazioni native, cronologia URL, menzioni contestuali, condizioni/accessi per ambito, istanze e asserzioni di relazione/credito. Conservare il payload CAT come baseline tracciata; i campi interrogabili hanno responsabilità definite nel MODELLO_LOGICO, senza un catalogo PerGioco parallelo.

Approvare per una futura importazione separata il piano di dodici record fonte: otto nuove identità canoniche conservative, Abande solo matching candidato a 993 e Azul/Blockade (1975)/Blockade (2001) solo record fonte con requisito non dimostrato. Nove esiti CAT ammissibili restano indipendenti dagli otto collegamenti canonici confermabili. Nessuna fusione per titolo, nessuna nuova identità Abande duplicata, nessuna proiezione canonica Abande Libre→993 finché il matching base non viene deliberato.

Itinera è un solo sistema: due istanze datate, una menzione di soluzioni distinta con accesso login osservato e costo ignoto; zero associazioni soluzione–schema. Le alternative interne di tavoliere e l'esempio in scheda non aumentano il conteggio. Mapping comune delle classificazioni inizialmente vuoto. La decisione di architettura e il piano identità si possono confermare insieme o separatamente; nessuna delle due autorizza esecuzione.

## Motivazione e confini

Il modello 009 copre già fonte, record, giochi, matching, nomi canonici/alias, prodotti, destinazioni URL, implementazioni e crediti risolti. Non copre la storia completa del record e degli esiti, percorsi nativi osservati, menzioni senza URL, accessi contestuali o istanze. Il payload JSON conserva queste informazioni ma non impone relazioni e vincoli sufficienti per consultarli uniformemente. La B rende esplicite tali differenze senza spostare gli stati CAT nei campi di sviluppo o nei matching.

Il minimo comprende anche storia delle decisioni di matching e crediti non risolti: la sola tabella credit_assertions richiede person_id e non basta per editori organizzazione o nomi ambigui. Il nuovo livello conserva l'asserzione prima della risoluzione; non crea persone fittizie. Non si costruisce ora un'anagrafe generale delle organizzazioni.

La B è un contratto logico, non DDL approvato riga per riga. Il DAT dovrà dimostrarne l'implementazione senza alterare semantica/cardinalità. Se emergono cambiamenti materiali, tornare in EPR prima di applicarli. I nomi logici possono essere tradotti in nomi fisici documentati senza cambiare responsabilità. Le enumerazioni native restano aperte e attribuite; i piccoli stati tecnici sono vincolati e versionati.

## Alternative e tradeoff

| Alternativa | Vantaggio | Costo/limite | Esito proposto |
|---|---|---|---|
| A: solo modello corrente + JSON | Nessuna migrazione, conserva payload | Query dipendenti da contratti JSON; storia, NULL e contesto più difficili da validare | Baseline utile, insufficiente come contratto interrogabile |
| B: estensione generica additiva | Evidenze contestuali, storia e vincoli comuni; legacy preservato | Più entità e join; importer e proiezioni richiedono collaudo | Raccomandata |
| Sottocatalogo PerGioco | Semplicità locale iniziale | Duplica identità, risorse e app; futura riconciliazione onerosa | Respinta |
| Dodici games automatici | Conteggio apparentemente uniforme | Ammissioni e identità confuse; tre lacune promosse | Respinta |
| Ristrutturazione universale BGG/Kanare immediata | Un unico contratto fisico | Backfill, rischio storico e ampliamento non autorizzato | Rinviata |

La duplicazione deliberata è soltanto baseline di audit più proiezione relazionale: stessa provenienza, hash e versione di mapping rendono rilevabile la divergenza. Il JSON è la testimonianza dell'input; gli esiti e attributi strutturati sono la proiezione consultabile, mai una seconda fonte indipendente. Un cambiamento di mapper crea una formalizzazione esplicita della stessa evidenza, non una nuova visita del sito.

## Estensioni rinviate

Tassonomia comune popolata, albero globale PerGioco, entità organizzazioni/autorità nominali, requisiti materiali multifonte dettagliati, inventario personale/possesso, proiezioni di metriche e layout APP, deduplicazione contenuti scaricati, verifica piattaforme e soluzione–istanza senza prove. Componenti dichiarati restano sintesi nel payload; condizioni/costi che li riguardano sono invece strutturati nel minimo B. Nessun prodotto o implementazione creato nel pilota per una mera menzione.

## Domande necessarie alla deliberazione

1. Confermare B-v1 con responsabilità, vincoli e compatibilità descritti, mantenendo gli interventi pregressi solo su autorizzazione futura?
2. Confermare il piano otto nuove identità / Abande candidato 993 / tre source-only, mantenendo irrisolto Abande e le sue relazioni canoniche?

Non serve decidere ora il matching Abande, popolare categorie comuni, scegliere strumenti APP o autorizzare acquisizioni. Conservare Abande irrisolto è una scelta completa del piano, non un blocco per la B. Le otto identità sono conservative locali: l'assenza di match esatto registrata da TSK-0075 non prova unicità mondiale.

## Formulazione da confermare

«Confermo B-v1 di TSK-0076 come architettura logica multifonte e il piano delle dodici candidate: otto nuove identità, Abande candidato a 993, tre record fonte con requisito non dimostrato; Itinera un gioco/due istanze e relazioni canoniche Abande rinviate. Nessun backfill o riesame implicito. Autorizzo la registrazione della decisione e l'aggiornamento dei riferimenti autorevoli, senza avviare migrazione DAT, importazione PerGioco, VER, APP o acquisizioni.»

Riferimenti: [modello e dizionario](MODELLO_LOGICO.md), [compatibilità e controlli](COMPATIBILITA_E_VALIDAZIONE.md), [casi offline](CASI_PILOTA.json), [verifiche](VERIFICHE.json). Le fonti dirette e i crediti di ogni candidato sono nella matrice, con date originarie e limiti CAT preservati.
