# Libreria locale

Contiene i materiali originali dei giochi selezionati. Il contenuto è escluso da Git, non deve essere redistribuito e va organizzato senza sovrascrivere versioni precedenti. Ogni file deve essere descritto nel manifest versionabile con provenienza, data di acquisizione, dimensione e SHA-256.

Il task ricorrente di monitoraggio dei contest non popola questa cartella e non apre, analizza o scarica materiali delle entry. Qualunque acquisizione futura richiede un task standard `Acquisizione materiali del contest` dedicato a un solo contest, una selezione esplicita e le verifiche di liceità previste dal progetto. Non sono ammessi download trasversali a più contest o a un'intera annualità nello stesso task.

Per le fonti non-BGG autorizzate da un task multifonte, la struttura adottata è `library/<fonte>/<gioco>/originals/`. Gli originali restano immutabili; eventuali derivati dovranno essere collocati separatamente sotto `derived/`. Il primo lotto Kanare_Abstract usa `library/kanare-abstract/<gioco>/originals/`; il manifest versionabile è `catalog/kanare_abstract_acquisition_batch_2026-09-21.json`.
