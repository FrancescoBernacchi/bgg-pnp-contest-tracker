---
name: bgg-material-acquisition
description: Verifica host e acquisisce materiali selezionati di un singolo contest BGG con condizioni, enumerazione, manifest, hash e versioni. Richiede il perimetro ACQ autorizzato; esclude acquisizioni annuali e nuovi censimenti.
---

# Acquisizione materiali BGG

## Input e confini

Contratto ACQ di un singolo contest, selezione approvata, scansioni MAT, manifest/file preesistenti, PROJECT.md, library/README.md e [base BGG](../bgg-contest-navigation/SKILL.md). La skill non costituisce autorizzazione a selezionare giochi o aprire host fuori dal contratto. TSK-0043 Wargame è sospeso e richiede nuova approvazione esplicita alla ripresa: non riattivarlo per analogia con altri lotti.

## Procedura

1. Rendi espliciti selezione, lingue, tipi di risorsa e condizioni applicabili. Verifica offerta dell'autore/host e limiti d'uso; accessibilità pubblica non prova licenza aperta o diritto di redistribuire.
2. Segui la destinazione dichiarata e verifica identità del gioco/versione, accessi e redirect. Un token che conduce a un progetto diverso non prova corrispondenza. Non aggirare login, Cloudflare, limiti di download o host.
3. Per cartelle/pagine di distribuzione enumera tutti i file osservabili nel perimetro prima di attestare completezza: pagine, sottocartelle, lingue, nomi e conteggi. Distingui enumerazione parziale da completa. Un primo file riuscito non completa una cartella.
4. Registra per ogni risorsa inclusa acquisito, assenza esplicitamente verificata, indisponibilità, restrizione o limite tecnico. Registra esclusioni motivate (video, implementazioni, strumenti, promozioni, lingue escluse dal contratto) senza richiedere file per esse. Un 404 prova indisponibilità di quel riferimento a quella data, non assenza di ogni materiale.
5. Trasferisci gli originali senza modifiche; verifica formato effettivo, dimensione e SHA-256. Conserva URL dichiarato e di trasferimento, data, nome originale, MIME, lingua, versione e condizioni nel manifest. Non sovrascrivere un percorso con hash diverso; preserva tutte le versioni. Non eliminare download dell'utente dopo copia.
6. Derivati/estrazioni restano separati e riconducibili all'originale: hash archivio padre e membro; nessuna conversione implicita. Usa il comando offline `catalog/extract_registered_archives.py` solo nel perimetro autorizzato e dopo ispezione della guida, non il server app.
7. Riconcilia manifest, file e database; applicazione soltanto se autorizzata, dopo prova idempotente su copia, backup verificato, controllo integrità e chiavi esterne. Aggiorna attestazioni di lavoro dal manifest senza trasformare quantità parziali in completezza; rigenera A/B se cambiano acquisizioni/file.

## Deliverable e successo

Manifest con selezione/esclusioni/esiti, originali con hash/versioni, rapporto di enumerazione, limiti e residui. Successo del ciclo: ogni oggetto nel perimetro ha esito documentato e ogni file acquisito supera verifica; il ciclo può concludersi con blocchi senza dichiarare acquisizione completa. Tenere distinti ciclo concluso, quantità raccolta e copertura effettiva.

Precedenti: TSK-0029 Children & Family (restrizioni Itch, 404 e lingue escluse), TSK-0030 Roll & Write (cartella Proton 2/2, PDF/PNG/DOCX/ZIP), manifest `catalog/2025_roll_write_acquisition_batch_2026-10-03.json` e verificatore omonimo. Script di acquisizione storici possono eseguire rete e mutazioni subito: non lanciarli per esaminarli; adattare ID/date/path e selezione. Interrompi tentativi ripetuti al medesimo limite e registra il residuo; recuperi remoti in nuovo incremento esplicito. Promuovi solo procedure riuscite con evidenze nel riferimento condiviso pertinente, aggiorna inventario TSK-0048.
