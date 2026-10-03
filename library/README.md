# Libreria locale

Dal 2026-10-03 i metadati sono consultabili nella vista **Libreria** dell'app e in **Materiali locali** nelle schede gioco. Il server verifica la presenza dei file registrati senza servirli, aprirli o modificarli e senza esporre percorsi assoluti. Un record senza file presente resta visibile come mancante; non prova l'indisponibilità remota. Percorsi non confinati alla radice autorizzata sono rifiutati. Per integrità del contenuto usare i verificatori dei lotti: la vista non ricalcola gli hash.

Contiene i materiali originali dei giochi selezionati. Il contenuto è escluso da Git, non deve essere redistribuito e va organizzato senza sovrascrivere versioni precedenti. Ogni file deve essere descritto nel manifest versionabile con provenienza, data di acquisizione, dimensione e SHA-256.

Il task ricorrente di monitoraggio dei contest non popola questa cartella e non apre, analizza o scarica materiali delle entry. Qualunque acquisizione futura richiede un task standard `Acquisizione materiali del contest` dedicato a un solo contest, una selezione esplicita e le verifiche di liceità previste dal progetto. Non sono ammessi download trasversali a più contest o a un'intera annualità nello stesso task.

Per le fonti non-BGG autorizzate da un task multifonte, la struttura adottata è `library/<fonte>/<gioco>/originals/`. Gli originali restano immutabili; eventuali derivati dovranno essere collocati separatamente sotto `derived/`. Il primo lotto Kanare_Abstract usa `library/kanare-abstract/<gioco>/originals/`; il manifest versionabile è `catalog/kanare_abstract_acquisition_batch_2026-09-21.json`.

I lotti BGG usano `library/bgg/<contest>/<gioco>/originals/`. L'acquisizione Children & Family 2025 del 3 ottobre 2026 comprende 38 PDF originali relativi a 14 giochi: cinque file del primo lotto e 33 del completamento sulle entry residue. I manifest versionabili sono `catalog/2025_children_family_acquisition_batch_2026-10-03.json` e `catalog/2025_children_family_remaining_acquisition_batch_2026-10-03.json`. Link scaduti, accessi ristretti, limiti temporanei dell'host e risorse non osservabili sono registrati senza creare file locali sostitutivi.
