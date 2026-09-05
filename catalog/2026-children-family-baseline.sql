-- Baseline del 2026 Children & Family Game Design Contest.
-- Verifica: 2026-09-05. Solo metadati BGG; nessun materiale aperto o scaricato.

BEGIN IMMEDIATE;

INSERT INTO contest_series
 (id,canonical_name,description,scope_notes,first_seen_at,last_verified_at)
VALUES
 (10,'Children & Family Game Design Contest','Serie nata come Children''s Game Print & Play Game Design Contest; richiede componenti stampabili gratuiti.','Incluso: formato PnP obbligatorio e comunità esplicitamente descritta come PnP.','2026-09-05','2026-09-05');

INSERT INTO contests
 (id,series_id,bgg_thread_id,name,year,edition_label,language,geographic_scope,status_raw,status_normalized,organizer,entries_url,results_url,starts_at,submissions_close_at,voting_opens_at,voting_closes_at,source_url,first_seen_at,last_verified_at)
VALUES
 (10,10,3645079,'2026 Children & Family Game Design Contest',2026,'11th edition','English','international','Results published','complete','Edin Mujadzevic (@edvinus)','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-01-15','2026-04-15','2026-05-01','2026-05-15','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05');

INSERT INTO contest_sources
 (contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (10,'main_thread','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','Official rules, entry list and results link','thread',3645079,1,'2026-09-05','2026-09-05');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (10,'submissions','Game submission',1,'January 15 to April 15, 2026','complete','2026-01-15','2026-04-15','BGG time','day','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05',NULL),
 (10,'corrections','Edits/tweaks',2,'Allowed until May 1, 2026','complete','2026-04-16','2026-05-01','BGG time','day','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05',NULL),
 (10,'voting','Voting',3,'May 1 to May 15, 2026','complete','2026-05-01','2026-05-15','BGG time','day','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05',NULL),
 (10,'results','Results',4,'Results published','complete',NULL,NULL,'BGG time','unknown','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05','Classifiche da dettagliare in un incremento successivo.');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (19,10,'2026-09-05','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','discovery_and_entry_census','complete','Contest PnP aggiuntivo identificato; censite 36 entry finali e 2 ritirate dalla lista ufficiale. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
VALUES
 (10,19,'Results published','complete','2026-09-05','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','high',NULL);

CREATE TEMP TABLE family_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT NOT NULL,players TEXT,age TEXT,main_category TEXT NOT NULL,status_normalized TEXT NOT NULL
);

INSERT INTO family_import VALUES
 (1,'Uftro Tomb','Nguyễn Trường Giang','1-3p','8+','Children''s Game','contest_ready'),
 (2,'Math for Ladybugs!','Giampiero Randazzo','1-4p','6+','Children''s Game','contest_ready'),
 (3,'Fruit Stacks!','Jesse Hickle','2-4p','5+','Children''s Game','contest_ready'),
 (4,'Colour Collab','Thomas James','3-8p','6+','Children''s Game','contest_ready'),
 (5,'Excuse Me, Bear!','Keith DeViere Donaldson','2-4p','4+','Children''s Game','contest_ready'),
 (6,'The Cheese Stands Alone','Jesse Hickle','2p','8+','Family Game','contest_ready'),
 (7,'RoboBots: Kaiju Hunters','Dani Ungar','2-4p','10+','Family Game','contest_ready'),
 (8,'Bit and Bob''s SCRAPYARD SHOWCASE','Lisa Reinke','2-6p','7+','Family Game','contest_ready'),
 (9,'Cookmates','QUYEN Nguyen Hoang Quoc','2p','8+','Family Game','contest_ready'),
 (10,'Animal Roundup','Thomas James','2-4p','8+','Family Game','contest_ready'),
 (11,'Gold Rush: Unplugged','Ho Tram Tri','2-6p','6+','Family Game','contest_ready'),
 (12,'Storyboard Heroes','Simone Muggeo','2-4p','8+','Family Game','contest_ready'),
 (13,'Bag Drop','Jessica Kinttala','1-4p','8+','Family Game','contest_ready'),
 (14,'Alien Tongue','Istivano','2-6p','8+','Family Game','contest_ready'),
 (15,'Patently Absurd','Dani Ungar','1-5p','10+','Family Game','contest_ready'),
 (16,'Invisible words','Dmytro Bespalov','2-5p','8+','Family Game','contest_ready'),
 (17,'IRANIKA','Seyed Amin Hosseini','2-6p','10+','Family Game','contest_ready'),
 (18,'Seven Stones','Seyed Amin Hosseini','2-6p','10+','Family Game','contest_ready'),
 (19,'Cash Grab','Aiden Newman-Brown','2-4p','8+','Family Game','contest_ready'),
 (20,'Juicy Fruit Salad','Charles Ward','2-6p','8+','Family Game','contest_ready'),
 (21,'FLOWER FEAST','Dinda shifa maulana putri','3-7p','8+','Family Game','contest_ready'),
 (22,'Size the Cows','Evan Aditya Pratama','2-5p','8+','Family Game','contest_ready'),
 (23,'Creative City Blocks','Gita Dwi P.','2-5p','8+','Family Game','contest_ready'),
 (24,'Battle of the Mouse King','Hanke Wang','3-4p','8+','Family Game','contest_ready'),
 (25,'Bee Friendly','Marcus Skillern','1-6p','8+','Family Game','contest_ready'),
 (26,'Pivot','Marcus Skillern','3-4p','10+','Family Game','contest_ready'),
 (27,'The Abyss','OxMarco','2-4p','8+','Family Game','contest_ready'),
 (28,'RoboRacers','Damien Kalina','2-6p','8+','Family Game','contest_ready'),
 (29,'Cherries','Dmytro Bespalov','2-4p','8+','Family Game','contest_ready'),
 (30,'Desire FOR Mods','Umutcan_Erkmen','1-4p','8+','Family Game','contest_ready'),
 (31,'Daikoro: Elemental Dice Duel','Thomas and Mika','2p','8+','Family Game','contest_ready'),
 (32,'Oh My Gods!','The Ramarana Family','2-6p','7+','Family Game','contest_ready'),
 (33,'Arctic Rush','Nishna','2-4p','8+','Family Game','contest_ready'),
 (34,'Sandwich Stackers','Arvind Iyer','2-8p','10+','Family Game','contest_ready'),
 (35,'Survival of the Middlest','Scott R. Kelly and Bill Murphy','2-6p','8+','Family Game','contest_ready'),
 (36,'Graffito','Ryan Moylan','2p','8+','Family Game','contest_ready'),
 (37,'The Travel Bug Card Game','DominoTracks','2-4p','8+','Withdrawn','withdrawn'),
 (38,'Terra Incognita','Tatiana Kurbatova, Ilya Kurbatov','2-4p','8+','Withdrawn','withdrawn');

-- Il titolo del thread dichiara 36 entries, ma la lista corrente espone 36 finaliste più 2 ritirate.
-- Le posizioni sono quindi 38 record osservabili; la metrica conserva entrambi i conteggi.
INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 306+position,title,CASE WHEN status_normalized='withdrawn' THEN 'Withdrawn' ELSE 'Listed in final entry list' END,status_normalized,
 'Separazione Entry list / Withdrawn entries nel post ufficiale.','https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','2026-09-05'
FROM family_import;

INSERT INTO people (id,display_name)
SELECT 8000+row_number() OVER (ORDER BY lower(designer)),designer FROM (SELECT DISTINCT designer FROM family_import);

INSERT INTO game_credits (game_id,person_id,role,credit_raw)
SELECT 306+f.position,p.id,'designer',f.designer FROM family_import f JOIN people p ON p.id>=8001 AND lower(p.display_name)=lower(f.designer);

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at,withdrawn_at)
SELECT 306+position,10,306+position,position,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest',
 title||' by '||designer||' ('||players||', age '||age||'; '||main_category||')',
 CASE WHEN status_normalized='withdrawn' THEN 'Withdrawn' ELSE 'Listed in final entry list' END,status_normalized,
 CASE WHEN status_normalized='contest_ready' THEN 'Free printable files required by contest rules' END,
 CASE WHEN status_normalized='contest_ready' THEN 'available_declared' ELSE 'unknown' END,
 '2026-09-05','2026-09-05',CASE WHEN status_normalized='withdrawn' THEN '2026-05-01' END
FROM family_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,19,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,'2026-09-05',entry_url,'high','Prima osservazione; nessun materiale aperto.'
FROM entries WHERE contest_id=10;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (10,19,'entry_heading_reported','36 entries',36,NULL,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05','Il titolo della sezione non include coerentemente le due ritirate.'),
 (10,19,'entries_final_list','Current active list',36,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05',NULL),
 (10,19,'entries_withdrawn','Withdrawn entries',2,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05',NULL),
 (10,19,'entries_children','Children''s Game',5,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05',NULL),
 (10,19,'entries_family','Family Game',31,NULL,'entries','counted_from_official_list',1,'https://boardgamegeek.com/thread/3645079/2026-children-and-family-game-design-contest','2026-09-05',NULL);

DROP TABLE family_import;
COMMIT;
