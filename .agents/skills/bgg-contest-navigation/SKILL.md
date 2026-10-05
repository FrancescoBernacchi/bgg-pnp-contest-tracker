---
name: bgg-contest-navigation
description: Base condivisa per navigare contest, roster, risultati e WIP BGG con pattern tecnici verificati e instradamento ai workflow specialistici. Non autorizza ampliamenti di scope o download.
---

# Navigazione dei contest BGG

Usa questa base per navigazione BGG e leggi soltanto la specializzazione pertinente. Le sezioni tecniche seguenti si applicano esclusivamente alle fasi autorizzate dal contratto, mai come sequenza da eseguire integralmente.

## Specializzazioni e procedure

- Identità, serie e annualità BGG-G: [censimento contest](../bgg-contest-census/SKILL.md).
- Roster di un solo anno BGG-A: [procedura annuale entry](references/annual-entry-census.md), senza lettura WIP o materiali.
- Risultati/votazioni nel contratto autorizzato: [classifiche](../bgg-ranking-census/SKILL.md); estensioni annuali 2024/2025 non trasferibili ad altri anni.
- Primo post e dichiarazioni di un contest MAT: [materiali](../bgg-material-census/SKILL.md).
- Host e materiali selezionati di un contest ACQ: [acquisizione](../bgg-material-acquisition/SKILL.md).
- Immagini IMG di un contest/anno: [immagini dei giochi](../game-image-acquisition/SKILL.md), contratto autonomo in sources/IMAGE_WORKFLOW.md; non estende MAT/ACQ o monitoraggi.
- Monitoraggio BGG-M: PROJECT.md e sources/MONITORING_CALENDAR.md governano cadenza e snapshot; la base supporta navigazione di stato/fasi/roster/metriche senza file di gioco. Non duplicare controlli giornalieri; mantenere snapshot completi collegati tramite check_id e distinguere baseline/census/consistency dai rilevamenti periodici.

Inventario e manutenzione: sources/SKILL_INVENTORY.md, TSK-0048. Il playbook rimane il riferimento unico dei pattern tecnici, con date e limiti originari. La verifica offline delle skill non aggiorna lo stato esterno dei siti.

## Obiettivo operativo

Costruisci una catena verificabile fra contest, fonte del roster, singola entry, WIP BGG e risorse dichiarate. Distingui sempre:

- pagina o elemento che prova l'iscrizione;
- thread WIP della singola entry;
- collegamenti ai materiali dichiarati nel WIP;
- verifica successiva della disponibilità o acquisizione dei materiali.

Non interpretare un collegamento non ancora risolto come assente.

## Instradamento del task

Per IMG applica il contratto autonomo sources/IMAGE_WORKFLOW.md e la skill game-image-acquisition; le fasi tecniche seguenti valgono solo quando pertinenti. Per censimento, materiali e monitoraggio classifica il lavoro secondo uno dei cinque tipi definiti in `PROJECT.md`: censimento globale dei contest, censimento annuale delle entry, analisi materiali di un singolo contest, acquisizione materiali di un singolo contest o monitoraggio di un singolo contest. Applica soltanto le fasi pertinenti al tipo scelto. In particolare, il censimento annuale si ferma al roster delle entry; WIP, risorse e requisiti appartengono all'analisi del singolo contest; verifica degli host e download appartengono all'acquisizione dello stesso singolo contest.

Se la richiesta combina unità diverse o propone analisi o download trasversali a più contest, segnala la deviazione e indica la scomposizione conforme prima di procedere. Usa lo stesso instradamento quando viene chiesto genericamente quale sia il prossimo passo.

## Procedura

1. Identifica la fonte BGG autorevole per il perimetro: post del thread principale, GeekList, Hub, risultati o altra lista mantenuta dall'organizzatore.
2. Comprendi la struttura renderizzata prima di estrarre: sezioni, paginazione, spoiler, entry finali, ritiri e collegamenti dinamici.
3. Usa la fonte autorevole come elenco di controllo e conserva l'ordine e i conteggi pubblicati.
4. Estrai in blocco titolo, autore, stato e URL dai collegamenti renderizzati. Filtra immagini, profili, navigazione e sponsor.
5. Se BGG usa `gg-item-link` con `href="#"`, porta ogni componente nell'area visibile, attendi che BGG ne risolva la destinazione e leggi l'`href` solo dopo il caricamento. Esegui questa operazione sistematicamente sull'intero roster.
6. Confronta il numero di URL risolti con il numero di entry. Verifica identificativi univoci, dominio BGG, tipo di pagina e associazione titolo-autore.
7. Applica fallback soltanto agli scarti residui, nell'ordine più economico indicato nel playbook.
8. Registra fonte, data, metodo, conteggi, anomalie e grado di completezza. Aggiorna database e manifest senza perdere osservazioni storiche valide.

Per strutture già incontrate o fallback, leggi [references/navigation-playbook.md](references/navigation-playbook.md).

## Accumulo della conoscenza

Dopo una struttura nuova o un fallimento istruttivo:

1. documenta nel task l'evidenza specifica e la correzione;
2. aggiungi al playbook soltanto il pattern riutilizzabile;
3. indica contesto, sintomo, strategia riuscita, verifica e limiti;
4. promuovi in questa skill una regola solo quando cambia stabilmente il comportamento dell'agente;
5. correggi o sostituisci strategie superate invece di accumulare istruzioni contraddittorie.

Il compito continuativo dell'agente è migliorare la competenza nella navigazione BGG durante le esplorazioni, mantenendo le procedure rapide, verificabili e adattabili ai formati storici del sito.

## Dettagli specialistici

Le procedure sui collegamenti e sui requisiti del primo post sono mantenute in [bgg-material-census](../bgg-material-census/SKILL.md), con pattern tecnici nel playbook condiviso. La base precedente è conservata in TSK-0048/BASE_SKILL_BEFORE.md; non duplicare qui le istruzioni MAT.
