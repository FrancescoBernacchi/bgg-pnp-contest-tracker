-- Snapshot periodico completo del 2026 Print and Play Wargame Design Contest.
-- Fonti ufficiali verificate il 2026-10-02; nessun materiale di gioco aperto.

BEGIN IMMEDIATE;

CREATE TEMP TABLE wargame_monitor (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_display TEXT NOT NULL,
  bgg_username TEXT NOT NULL,
  wip_thread_url TEXT NOT NULL,
  status_normalized TEXT NOT NULL,
  materials_status_normalized TEXT NOT NULL
);

INSERT INTO wargame_monitor VALUES
  (1,'[Playtest ready] Hybrid War - 2026 Print and Play Wargame Design Contest','Greg Love','@zombiewarrior07','https://boardgamegeek.com/thread/3628081/playtest-ready-hybrid-war-2026-print-and-play-warg','playtest_ready','available_declared'),
  (2,'[Playtest ready] OSSA- bones that decide fate - 2026 Print and Play Wargame Design Contest','Mauricio Cabaleiro Becker','@mcbvix','https://boardgamegeek.com/thread/3631421/playtest-ready-ossa-bones-that-decide-fate-2026-pr','playtest_ready','available_declared'),
  (3,'[WIP] Warring States: West Africa (2026 Wargames PNP competition submission) PLAYTEST READY','Pete Holmes','@Prh657','https://boardgamegeek.com/thread/3638470/wip-warring-states-west-africa-2026-wargames-pnp-c','playtest_ready','available_declared'),
  (4,'[WIP] A silent war at the end of the world (2026 Wargames PNP competition submission) [IDEA PHASE]','Florin Moldoveanu','@Catlamp','https://boardgamegeek.com/thread/3640690/wip-a-silent-war-at-the-end-of-the-world-2026-warg','idea','unknown'),
  (5,'[WIP][Playtest ready] Cocci Wars (emergence simulator) - 2026 Print and Play Wargame Design Contest','@Imposing_hotdog','@Imposing_hotdog','https://boardgamegeek.com/thread/3634677/wipplaytest-ready-cocci-wars-emergence-simulator-2','playtest_ready','available_declared'),
  (6,'[WIP] Valour (2026 Wargames PNP competition submission) PLAYTEST READY','Florin Moldoveanu','@Catlamp','https://boardgamegeek.com/thread/3649727/wip-valour-2026-wargames-pnp-competition-submissio','playtest_ready','available_declared'),
  (7,'[WIP] Operation BARDSEA (2026 Wargames pnp submission) [TTS Available]','RK Hall','@rkmaymay','https://boardgamegeek.com/thread/3649842/wip-operation-bardsea-2026-wargames-pnp-submission','wip','digital_available_declared'),
  (8,'[WIP] The Ground Fortified - 2026 Print and Play Wargame Design Contest [Playtest Ready]','Felix Sonne','@felixdsonne','https://boardgamegeek.com/thread/3655068/wip-the-ground-fortified-2026-print-and-play-warga','playtest_ready','available_declared'),
  (9,'(WIP) Slipstream Raiders - Robbing at Redline – 2026 PnP Wargame Contest','Robin Metz','@Beaverlicious','https://boardgamegeek.com/thread/3668290/wip-slipstream-raiders-robbing-at-redline-2026-pnp','wip','unknown'),
  (10,'[WIP] The Battle of Stepney (2026 Wargames PNP contest submission), solo 20-40 mins.','Pete Holmes','@Prh657','https://boardgamegeek.com/thread/3669635/wip-the-battle-of-stepney-2026-wargames-pnp-contes','wip','unknown'),
  (11,'[WIP] [Playtest Ready] Warhammer 40,000: Battle line','Patrick','@xiaolo','https://boardgamegeek.com/thread/3669693/wip-playtest-ready-warhammer-40000-battle-line','playtest_ready','available_declared'),
  (12,'WIP: Out of the Limelights, entry to 2026 PnP Wargame Design Contest','Pablo Martin','@AgaPablo','https://boardgamegeek.com/thread/3692245/wip-out-of-the-limelights-entry-to-2026-pnp-wargam','wip','unknown'),
  (13,'[WIP] Gilgamesh vs. Enkidu','Brandon Chan','@brandonloveskone','https://boardgamegeek.com/thread/3708703/wip-gilgamesh-vs-enkidu','wip','unknown'),
  (14,'[WIP] WARRING KINGDOMS [2026 Wargame Design Contestt] [PLAYTEST READY]','Guilherme Vieira','@dsfsdfsdfwa','https://boardgamegeek.com/thread/3737758/wip-warring-kingdoms-2026-wargame-design-contestt','playtest_ready','available_declared'),
  (15,'[WIP] Gladiator (2026 Wargames PNP competition submission) MANUAL READY','Italo DeSantis','@desantii','https://boardgamegeek.com/thread/3745494/wip-gladiator-2026-wargames-pnp-competition-submis','components_available','available_declared'),
  (16,'[WIP] CYBERAIDER >PLAYTEST READY< (2026 Wargames PNP Competition Submission)','Patrick Wheeler','@CousinPaddy','https://boardgamegeek.com/thread/3756688/wip-cyberaider-playtest-ready-2026-wargames-pnp-co','playtest_ready','available_declared'),
  (17,'[WIP] Mekamui. - 2026 Print and Play Wargame Design Contest','@Bergenvd','@Bergenvd','https://boardgamegeek.com/thread/3762455/wip-mekamui-2026-print-and-play-wargame-design-con','wip','unknown'),
  (18,'Balled Moves - A Snowball Fight for 2 Players [COMPONENTS READY]','Georg Fischer','@Herr_Goldberg','https://boardgamegeek.com/thread/3763647/balled-moves-a-snowball-fight-for-2-players-compon','components_available','available_declared'),
  (19,'[PLAYTEST READY] 2026 Wargame Contest - Glières 1944','Laurent Journaux','@Laurent36','https://boardgamegeek.com/thread/3766762/playtest-ready-2026-wargame-contest-glieres-1944','playtest_ready','available_declared'),
  (20,'[WIP] Sitka ever lost : Alaska from Russia to America 1784-1867 [2026 PnP Wargame Design Contest] (components, rules, PLAYTESTS READY)','Christophe Leclerc','@Corsaire29','https://boardgamegeek.com/thread/3767955/wip-sitka-ever-lost-alaska-from-russia-to-america','playtest_ready','available_declared'),
  (21,'[Playtest ready] The Lost Eagles - 2026 Print and Play Wargame Design Contest','@pop311','@pop311','https://boardgamegeek.com/thread/3770697/playtest-ready-the-lost-eagles-2026-print-and-play','playtest_ready','available_declared'),
  (22,'[WIP] Garland 1942: A Solo Sabotage Game [Playtests Ready]','Marek Szumny (MARK6)','@lukmarcus','https://boardgamegeek.com/thread/3775769/wip-garland-1942-a-solo-sabotage-game-playtests-re','playtest_ready','available_declared'),
  (23,'Imposed Cost','Brian Train','@ltmurnau','https://boardgamegeek.com/thread/3776117/imposed-cost-a-card-game-of-grey-zone-warfare','unknown','unknown');

INSERT INTO contest_checks (contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES (4,'2026-10-02T23:07:51+02:00','https://boardgamegeek.com/thread/3627732/submissions-closed-2026-print-and-play-wargame-des','scheduled_deadline_monitor','changed','Snapshot completo post-chiusura: 23 entry, stato [SUBMISSIONS CLOSED], sviluppo consentito fino all''apertura del voto; nessun materiale aperto.');

UPDATE contests SET status_raw='[SUBMISSIONS CLOSED]; existing entries may be further developed until voting opens November 11, 2026',status_normalized='development',last_verified_at='2026-10-02' WHERE id=4;
UPDATE contest_phases SET status_normalized='complete',last_verified_at='2026-10-02' WHERE contest_id=4 AND phase_type IN ('earliest_public','submissions');
UPDATE contest_phases SET status_normalized='active',last_verified_at='2026-10-02' WHERE contest_id=4 AND phase_type='development';
UPDATE contest_phases SET status_normalized='planned',last_verified_at='2026-10-02' WHERE contest_id=4 AND phase_type IN ('voting','results');

INSERT INTO contest_status_history (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
SELECT 4,id,'[SUBMISSIONS CLOSED]','development','2026-10-02','2026-10-02T23:07:51+02:00','https://boardgamegeek.com/thread/3627732/submissions-closed-2026-print-and-play-wargame-des','high','Il titolo ufficiale chiude le submission; il primo post conferma che le entry esistenti possono continuare lo sviluppo fino al voto.' FROM contest_checks WHERE contest_id=4 AND checked_at='2026-10-02T23:07:51+02:00';

INSERT INTO contest_phase_history (phase_id,check_id,status_raw,status_normalized,starts_at,ends_at,observed_at,source_url,confidence,notes)
SELECT p.id,c.id,p.status_raw,p.status_normalized,p.starts_at,p.ends_at,c.checked_at,p.source_url,'high','Snapshot completo delle fasi ufficiali disponibili.'
FROM contest_phases p JOIN contest_checks c ON c.contest_id=p.contest_id AND c.checked_at='2026-10-02T23:07:51+02:00' WHERE p.contest_id=4;

INSERT INTO game_names (game_id,name,observed_from,observed_at,is_current,name_type,is_official,verification_status,evidence_url,last_verified_at)
SELECT e.game_id,g.canonical_title,'GeekList 369157','2026-09-04',0,'historical_title',1,'verified','https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries','2026-10-02'
FROM entries e JOIN games g ON g.id=e.game_id JOIN wargame_monitor m ON m.position=e.position
WHERE e.contest_id=4 AND g.canonical_title<>m.title_raw;

UPDATE games SET canonical_title=(SELECT m.title_raw FROM entries e JOIN wargame_monitor m ON m.position=e.position WHERE e.game_id=games.id AND e.contest_id=4),status_raw=(SELECT m.title_raw FROM entries e JOIN wargame_monitor m ON m.position=e.position WHERE e.game_id=games.id AND e.contest_id=4),status_normalized=(SELECT m.status_normalized FROM entries e JOIN wargame_monitor m ON m.position=e.position WHERE e.game_id=games.id AND e.contest_id=4),status_evidence='Stato derivato esclusivamente dal titolo corrente della GeekList ufficiale.',last_verified_at='2026-10-02' WHERE id IN (SELECT game_id FROM entries WHERE contest_id=4);

UPDATE entries SET wip_thread_url=(SELECT m.wip_thread_url FROM wargame_monitor m WHERE m.position=entries.position),entry_text_raw=(SELECT m.title_raw FROM wargame_monitor m WHERE m.position=entries.position),status_raw=(SELECT m.title_raw FROM wargame_monitor m WHERE m.position=entries.position),status_normalized=(SELECT m.status_normalized FROM wargame_monitor m WHERE m.position=entries.position),materials_status_raw=CASE (SELECT m.materials_status_normalized FROM wargame_monitor m WHERE m.position=entries.position) WHEN 'available_declared' THEN 'Readiness declared in GeekList title' WHEN 'digital_available_declared' THEN 'TTS availability declared in GeekList title' END,materials_status_normalized=(SELECT m.materials_status_normalized FROM wargame_monitor m WHERE m.position=entries.position),last_verified_at='2026-10-02' WHERE contest_id=4;

INSERT INTO people (display_name,bgg_username,profile_url)
SELECT m.author_display,m.bgg_username,'https://boardgamegeek.com/profile/'||ltrim(m.bgg_username,'@') FROM wargame_monitor m
WHERE m.position>18 AND NOT EXISTS (SELECT 1 FROM people p WHERE lower(p.bgg_username)=lower(m.bgg_username));

INSERT INTO games (canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT title_raw,title_raw,status_normalized,'Stato derivato esclusivamente dal titolo corrente della GeekList ufficiale.',wip_thread_url,'2026-10-02','2026-10-02' FROM wargame_monitor WHERE position>18;

INSERT INTO game_credits (game_id,person_id,role,credit_raw)
SELECT g.id,p.id,'designer',m.author_display||' '||m.bgg_username FROM wargame_monitor m JOIN games g ON g.source_url=m.wip_thread_url JOIN people p ON lower(p.bgg_username)=lower(m.bgg_username) WHERE m.position>18;

INSERT INTO entries (contest_id,game_id,geeklist_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 4,g.id,369157,m.position,m.wip_thread_url,'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries',m.title_raw,m.title_raw,m.status_normalized,CASE m.materials_status_normalized WHEN 'available_declared' THEN 'Readiness declared in GeekList title' END,m.materials_status_normalized,'2026-10-02','2026-10-02' FROM wargame_monitor m JOIN games g ON g.source_url=m.wip_thread_url WHERE m.position>18;

INSERT INTO game_names (game_id,name,observed_from,observed_at,is_current,name_type,is_official,verification_status,evidence_url,last_verified_at)
SELECT e.game_id,m.title_raw,'GeekList 369157','2026-10-02',1,'source_title',1,'verified','https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries','2026-10-02' FROM entries e JOIN wargame_monitor m ON m.position=e.position WHERE e.contest_id=4;

INSERT INTO entry_status_history (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT e.id,c.id,e.status_raw,e.status_normalized,e.materials_status_raw,e.materials_status_normalized,e.position,c.checked_at,e.entry_url,'high','Snapshot completo della GeekList ufficiale; nessun materiale aperto.' FROM entries e JOIN contest_checks c ON c.contest_id=e.contest_id AND c.checked_at='2026-10-02T23:07:51+02:00' WHERE e.contest_id=4;

INSERT INTO contest_metric_observations (contest_id,check_id,metric_key,metric_label_raw,numeric_value,unit,method,is_official,source_url,observed_at,notes)
SELECT 4,c.id,x.metric_key,x.label,x.value,'entries',x.method,x.official,'https://boardgamegeek.com/geeklist/369157/2026-wargame-design-contest-entries',c.checked_at,x.notes FROM contest_checks c CROSS JOIN (
 SELECT 'entries_total' metric_key,'23 Items' label,23 value,'reported_by_geeklist' method,1 official,NULL notes UNION ALL
 SELECT 'entries_playtest_ready','Playtest Ready titles',13,'derived_from_entry_titles',0,NULL UNION ALL
 SELECT 'entries_components_available','Components/Manual Ready titles',2,'derived_from_entry_titles',0,NULL UNION ALL
 SELECT 'entries_idea','Idea Phase titles',1,'derived_from_entry_titles',0,NULL UNION ALL
 SELECT 'entries_wip','WIP without readiness declaration',6,'derived_from_entry_titles',0,'Una delle sei entry dichiara un modulo TTS disponibile.' UNION ALL
 SELECT 'entries_unknown','Titles without explicit status marker',1,'derived_from_entry_titles',0,'Imposed Cost non espone uno stato nel titolo della GeekList.'
) x WHERE c.contest_id=4 AND c.checked_at='2026-10-02T23:07:51+02:00';

DROP TABLE wargame_monitor;
COMMIT;
