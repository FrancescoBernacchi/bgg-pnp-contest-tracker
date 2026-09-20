-- Chiusura del censimento globale dei soli contest BGG.
-- Verifica: 2026-09-18. Nessun roster o contenuto di entry consultato.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

CREATE TEMP TABLE global_status_finalization (
    theme TEXT PRIMARY KEY,
    status_raw TEXT NOT NULL,
    source_url TEXT NOT NULL,
    confidence TEXT NOT NULL,
    notes TEXT NOT NULL
);

INSERT INTO global_status_finalization VALUES
('CULTURE','Results published','https://boardgamegeek.com/thread/3642254/january-february-2026-bi-monthly-24-hour-design-ch','high','Il thread pubblica esplicitamente i risultati e i vincitori.'),
('CLASSIC','Voting closed May 10, 2026','https://boardgamegeek.com/thread/3675743/march-april-2026-bi-monthly-24-hour-design-challen','medium','La finestra di voto dichiarata è terminata il 10 maggio 2026.'),
('STICK','Challenge and voting cycle elapsed by September 18, 2026','https://boardgamegeek.com/thread/3642251/2026-bi-monthly-24-hour-design-challenges-discussi','medium','Il meta-thread definisce il ciclo bimestrale; il thread del contest risulta chiuso dopo giugno e aggiornato l’8 luglio.'),
('DRAW','Voting closed September 11, 2026','https://boardgamegeek.com/thread/3734535/july-august-2026-bi-monthly-24-hour-design-challen','medium','La finestra di voto dichiarata è terminata l’11 settembre 2026.');

INSERT INTO contest_checks(contest_id,checked_at,source_url,check_kind,outcome,notes)
SELECT c.id,'2026-09-18',f.source_url,'global_census_finalization','complete',f.notes
FROM contests c JOIN global_status_finalization f ON instr(c.name,'(' || f.theme || ')') > 0
WHERE c.year=2026
  AND NOT EXISTS (
      SELECT 1 FROM contest_checks cc
      WHERE cc.contest_id=c.id AND cc.checked_at='2026-09-18' AND cc.source_url=f.source_url
  );

UPDATE contests
SET status_raw=(SELECT f.status_raw FROM global_status_finalization f WHERE instr(contests.name,'(' || f.theme || ')') > 0),
    status_normalized='complete',
    source_url=(SELECT f.source_url FROM global_status_finalization f WHERE instr(contests.name,'(' || f.theme || ')') > 0),
    last_verified_at='2026-09-18'
WHERE year=2026
  AND EXISTS (SELECT 1 FROM global_status_finalization f WHERE instr(contests.name,'(' || f.theme || ')') > 0);

INSERT INTO contest_sources(contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
SELECT c.id,'main_thread',f.source_url,'24 Hour Design Challenge source','thread',
       CAST(substr(f.source_url,length('https://boardgamegeek.com/thread/')+1,
            instr(substr(f.source_url,length('https://boardgamegeek.com/thread/')+1),'/')-1) AS INTEGER),
       1,'2026-09-18','2026-09-18'
FROM contests c JOIN global_status_finalization f ON instr(c.name,'(' || f.theme || ')') > 0
WHERE c.year=2026
  AND NOT EXISTS (SELECT 1 FROM contest_sources s WHERE s.contest_id=c.id AND s.url=f.source_url);

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
SELECT c.id,
       (SELECT cc.id FROM contest_checks cc WHERE cc.contest_id=c.id AND cc.checked_at='2026-09-18' AND cc.source_url=f.source_url ORDER BY cc.id DESC LIMIT 1),
       f.status_raw,'complete','2026-09-18',f.source_url,f.confidence,f.notes
FROM contests c JOIN global_status_finalization f ON instr(c.name,'(' || f.theme || ')') > 0
WHERE c.year=2026
  AND NOT EXISTS (
      SELECT 1 FROM contest_status_history h
      WHERE h.contest_id=c.id AND h.observed_at='2026-09-18' AND h.source_url=f.source_url
  );

INSERT INTO contest_checks(contest_id,checked_at,source_url,check_kind,outcome,notes)
SELECT id,'2026-09-18',source_url,'global_census_finalization','uncertain',
       'La fonte storica prova l’esistenza del contest ma non consente di distinguere con affidabilità conclusione e cancellazione.'
FROM contests
WHERE year=2018 AND name='League of Designers Workshop and Contest'
  AND NOT EXISTS (
      SELECT 1 FROM contest_checks cc
      WHERE cc.contest_id=contests.id AND cc.checked_at='2026-09-18' AND cc.source_url=contests.source_url
  );

UPDATE contests
SET status_raw='Historical index confirms the contest; final outcome remains unproven',
    status_normalized='unknown',
    last_verified_at='2026-09-18'
WHERE year=2018 AND name='League of Designers Workshop and Contest';

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
SELECT c.id,
       (SELECT cc.id FROM contest_checks cc WHERE cc.contest_id=c.id AND cc.checked_at='2026-09-18' AND cc.source_url=c.source_url ORDER BY cc.id DESC LIMIT 1),
       c.status_raw,'unknown','2026-09-18',c.source_url,'low',
       'Esito incerto confermato come limite documentato; non si inferisce una cancellazione da una ricerca negativa.'
FROM contests c
WHERE c.year=2018 AND c.name='League of Designers Workshop and Contest'
  AND NOT EXISTS (
      SELECT 1 FROM contest_status_history h
      WHERE h.contest_id=c.id AND h.observed_at='2026-09-18' AND h.source_url=c.source_url
  );

DROP TABLE global_status_finalization;
COMMIT;
