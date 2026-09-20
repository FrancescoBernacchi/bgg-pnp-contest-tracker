-- Completamento del censimento annuale 2026: 1-Card e cinque 24 Hour Challenge.
-- Fonti BGG ufficiali verificate il 2026-09-20. Nessun file o host esterno aperto.

BEGIN IMMEDIATE;

CREATE TEMP TABLE census_entry (
  contest_id INTEGER NOT NULL,
  position INTEGER NOT NULL,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  username TEXT,
  wip_url TEXT,
  entry_url TEXT NOT NULL,
  geeklist_id INTEGER,
  geeklist_item_id INTEGER,
  status_raw TEXT NOT NULL,
  status_normalized TEXT NOT NULL,
  PRIMARY KEY (contest_id, position)
);

INSERT INTO census_entry VALUES
  (300,1,'The Boy in the Cornfield','Daniel Holding','T3RM1N4T0R','https://boardgamegeek.com/thread/3663168/wip-the-boy-in-the-cornfield-2p-hidden-movement-ga','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12713829#12713829',376073,12713829,'Official final entry','contest_ready'),
  (300,2,'Emmet and the Zombie Ant','Margie Lester','Quirkies3','https://boardgamegeek.com/thread/3687680/emmet-and-the-zombie-ant-entry-into-the-2026-1-car','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12715639#12715639',376073,12715639,'Official final entry','contest_ready'),
  (300,3,'3 Dice on Mount Olympus','Birgit Röscheisen','bhr_79','https://boardgamegeek.com/thread/3691866/wip-3-dice-on-mount-olympus-2026-1-card-print-and','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12737986#12737986',376073,12737986,'Official final entry','contest_ready'),
  (300,4,'Colorfill','Fernando Marecos','ecoabismo','https://boardgamegeek.com/thread/3695473/wip-colorfill-2026-1-card-print-and-play-contest-c','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12754050#12754050',376073,12754050,'Official final entry','contest_ready'),
  (300,5,'CR!S!S','Dominic Boomhower','Cozilla88','https://boardgamegeek.com/thread/3696427/wip-crss-a-2-player-superhero-game-submission-to-t','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12758475#12758475',376073,12758475,'Official final entry','contest_ready'),
  (300,6,'Cardboat Legend','Tobias W','Puazz','https://boardgamegeek.com/thread/3700003/wip-cardboat-legend-2026-1-card-pnp-contest-contes','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12773494#12773494',376073,12773494,'Official final entry','contest_ready'),
  (300,7,'Time Looper','Stuart Jantzen','Stwert','https://boardgamegeek.com/thread/3702446/wip-time-looper-2026-1-card-print-and-play-contest','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12791780#12791780',376073,12791780,'Official final entry','contest_ready'),
  (300,8,'Dice Volley','Lucca Luna','L_Luna','https://boardgamegeek.com/thread/3703035/wip-dice-volley-2p-abstract-strategy-game-2026-1-c','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12792160#12792160',376073,12792160,'Official final entry','contest_ready'),
  (300,9,'hoop.exe','Wanshun Wong','wanshunwong','https://boardgamegeek.com/thread/3703841/wip-hoopexe-2-player-tactical-programming-game-202','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12796847#12796847',376073,12796847,'Official final entry','contest_ready'),
  (300,10,'Kaos Karts','Grids','Grids','https://boardgamegeek.com/thread/3706052/wip-kaos-karts-drive-through-portals-and-release-b','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12810718#12810718',376073,12810718,'Official final entry','contest_ready'),
  (300,11,'One Card Hacker','Matthew Peven','pevenm','https://boardgamegeek.com/thread/3706845/wip-one-card-hacker-2026-1-card-print-and-play-con','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12815928#12815928',376073,12815928,'Official final entry','contest_ready'),
  (300,12,'Slapstick','Iffix Y Santaph','XendoBreckett','https://boardgamegeek.com/thread/3707495/wipslapstickdual-entry-24-hour-and-1-card-design-c','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12819512#12819512',376073,12819512,'Official final entry','contest_ready'),
  (300,13,'Flippin'' Bomber','J-P Kurikka','MrKuricat','https://boardgamegeek.com/thread/3707964/wip-flippin-bomber-chaotic-1-card-maze-bomber-for','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12820919#12820919',376073,12820919,'Official final entry','contest_ready'),
  (300,14,'LÜMEN: Eternal Night','Okan Akdoğan','LeonidasPHX','https://boardgamegeek.com/thread/3708298/wip-lumen-eternal-night-solo-game-2026-1-card-prin','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12822916#12822916',376073,12822916,'Official final entry','contest_ready'),
  (300,15,'Trials and Tribulations','Dominic Boomhower','Cozilla88','https://boardgamegeek.com/thread/3708498/wip-trials-and-tribulations-a-lotr-adventure-on-on','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12823603#12823603',376073,12823603,'Official final entry','contest_ready'),
  (300,16,'Bump it!','Fatih Gençkal','fatiguita','https://boardgamegeek.com/thread/3709500/bump-it-2026-1-card-print-and-play-pnp-design-cont','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12827643#12827643',376073,12827643,'Official final entry','contest_ready'),
  (300,17,'Snake','Agustín Atencio Andrioli','Agraskar','https://boardgamegeek.com/thread/3709948/wip-snake-1-card-print-and-play-contest-2026-compo','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12829835#12829835',376073,12829835,'Official final entry','contest_ready'),
  (300,18,'Node Links','Stuart Jantzen','Stwert','https://boardgamegeek.com/thread/3710606/wip-node-links-2026-1-card-print-and-play-contest','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12833519#12833519',376073,12833519,'Official final entry','contest_ready'),
  (300,19,'Tic-Tac-Finger','thisiscat','thisiscat','https://boardgamegeek.com/thread/3713002/wip-tic-tac-finger-2026-1-card-print-and-play-cont','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12846520#12846520',376073,12846520,'Official final entry','contest_ready'),
  (300,20,'Archeologist vs Temple','J_Torg','J_Torg','https://boardgamegeek.com/thread/3713118/archeologist-vs-temple-2026-1-card-print-and-play','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12847278#12847278',376073,12847278,'Official final entry','contest_ready'),
  (300,21,'Ripples','Scott','NotSaussure','https://boardgamegeek.com/thread/3713561/wip-ripples-2026-1-card-print-and-play-contest-con','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12849766#12849766',376073,12849766,'Official final entry','contest_ready'),
  (300,22,'Space Shooter 1C','Grids','Grids','https://boardgamegeek.com/thread/3713304/wip-space-shooter-1c-2026-1-card-print-and-play-co','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12853172#12853172',376073,12853172,'Official final entry','contest_ready'),
  (300,23,'ALT','Iffix Y Santaph','XendoBreckett','https://boardgamegeek.com/thread/3715534/wipalt2026-1-card-game-design-contestcomponents-av','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12858521#12858521',376073,12858521,'Official final entry','contest_ready'),
  (300,24,'Teseliatron','Felipe Llanos','kironcentauro','https://boardgamegeek.com/thread/3715614/wip-teseliatron-2026-1-card-print-and-play-contest','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12859149#12859149',376073,12859149,'Official final entry','contest_ready'),
  (300,25,'Branch Line','Felipe Llanos','kironcentauro','https://boardgamegeek.com/thread/3715617/wip-branch-line-2026-1-card-print-and-play-contest','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12859164#12859164',376073,12859164,'Official final entry','contest_ready'),
  (300,26,'BeltDashCzar','CMarkJ','CMarkJ','https://boardgamegeek.com/thread/3716313/wip-beltdashczar-2026-1-card-print-and-play-contes','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12862855#12862855',376073,12862855,'Official final entry','contest_ready'),
  (300,27,'Hitman Leaderboard','Maf','mafman6','https://boardgamegeek.com/thread/3716965/wip-hitman-leaderboard-1-card-design-contest-2026','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12865894#12865894',376073,12865894,'Official final entry','contest_ready'),
  (300,28,'Sword To Table','GoldenSloth','GoldenSloth','https://boardgamegeek.com/thread/3717003/wip-sword-to-table-a-monster-cooking-dungeon-crawl','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12866091#12866091',376073,12866091,'Official final entry','contest_ready'),
  (300,29,'Sugar and Splice','Bridey K','l3ridey','https://boardgamegeek.com/thread/3717072/sugar-and-splice-entry-for-the-2026-one-card-conte','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12866591#12866591',376073,12866591,'Official final entry','contest_ready'),
  (300,30,'Dauntless Squad','Onur Tosun',NULL,'https://boardgamegeek.com/thread/3716261/wip-dauntless-squad-2026-1-card-print-and-play-con','https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants?itemid=12960328#12960328',376073,12960328,'Official final entry','contest_ready'),

  (301,1,'MUTT','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Withdrawn','withdrawn'),
  (301,2,'Minutes to Majesty','Hep Sosing',NULL,NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,3,'Uncultured Swine','Jesse Hickle',NULL,NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,4,'Cozy Harvest','Coblin King',NULL,NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,5,'Cloudbound Kingdon','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Withdrawn','withdrawn'),
  (301,6,'Random Traces','David Stewart',NULL,NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,7,'SEWN','David McDougal','davidmcdougal',NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,8,'Get the Play on the Stage!','J-P Kurikka','MrKuricat',NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (301,9,'Poser','David Stewart',NULL,NULL,'https://boardgamegeek.com/thread/3642254/article/47134017#47134017',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,1,'Quirlen','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,2,'Clincher','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,3,'Classic Car Show','David Stewart',NULL,NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,4,'Boneyard Gin','Jamie Thul',NULL,NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,5,'Starward Shield','J_Torg','J_Torg',NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (303,6,'Closing the Gap','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3675743/article/47408545#47408545',NULL,NULL,'Official challenge entry','contest_ready'),
  (304,1,'Kindling','David McDougal','davidmcdougal',NULL,'https://boardgamegeek.com/thread/3706306/article/47659966#47659966',NULL,NULL,'Official challenge entry','contest_ready'),
  (304,2,'Slapstick','Iffix Y Santaph','XendoBreckett','https://boardgamegeek.com/thread/3707495/wipslapstickdual-entry-24-hour-and-1-card-design-c','https://boardgamegeek.com/thread/3706306/article/47659966#47659966',NULL,NULL,'Official challenge entry','contest_ready'),
  (304,3,'Stick''em Up','David Stewart',NULL,NULL,'https://boardgamegeek.com/thread/3706306/article/47659966#47659966',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,1,'Neon Divide','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,2,'Desperados Duel','Coblin King',NULL,NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,3,'The Fastest Gun in the West','J-P Kurikka','MrKuricat',NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,4,'Umbrella','Stephen Stetelman',NULL,NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,5,'Pip Draw','David McDougal','davidmcdougal',NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,6,'Connectrons','Julian Anstey',NULL,NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,7,'Drawing from Memory','Joe T',NULL,NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,8,'Obfuscation','Isaac Haller',NULL,NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (302,9,'Communal Comics','Joli1217','Joli1217',NULL,'https://boardgamegeek.com/thread/3734535/article/47901801#47901801',NULL,NULL,'Official challenge entry','contest_ready'),
  (305,1,'Pittas','Iffix Y Santaph','XendoBreckett',NULL,'https://boardgamegeek.com/thread/3765638/article/48154812#48154812',NULL,NULL,'Current challenge entry; challenge active','contest_ready'),
  (305,2,'Naoi','David McDougal','davidmcdougal',NULL,'https://boardgamegeek.com/thread/3765638/article/48154812#48154812',NULL,NULL,'Current challenge entry; challenge active','contest_ready'),
  (305,3,'Dressed to the Nines','Joli1217','Joli1217',NULL,'https://boardgamegeek.com/thread/3765638/article/48154812#48154812',NULL,NULL,'Current challenge entry; challenge active','contest_ready');

UPDATE contests SET entries_url=CASE id
  WHEN 300 THEN 'https://boardgamegeek.com/geeklist/376073/2026-1-card-print-and-play-contest-entrants'
  WHEN 301 THEN 'https://boardgamegeek.com/thread/3642254/article/47134017#47134017'
  WHEN 302 THEN 'https://boardgamegeek.com/thread/3734535/article/47901801#47901801'
  WHEN 303 THEN 'https://boardgamegeek.com/thread/3675743/article/47408545#47408545'
  WHEN 304 THEN 'https://boardgamegeek.com/thread/3706306/article/47659966#47659966'
  WHEN 305 THEN 'https://boardgamegeek.com/thread/3765638/article/48154812#48154812' END,
  source_url=CASE id
  WHEN 300 THEN 'https://boardgamegeek.com/thread/3686290/2026-1-card-print-and-play-contest'
  WHEN 304 THEN 'https://boardgamegeek.com/thread/3706306/may-june-2026-bi-monthly-24-hour-design-challenge'
  WHEN 305 THEN 'https://boardgamegeek.com/thread/3765638/september-october-2026-bi-monthly-24-hour-design-c'
  ELSE source_url END,
  last_verified_at='2026-09-20'
WHERE id BETWEEN 300 AND 305;

INSERT INTO contest_sources (contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
SELECT id,'entries',entries_url,'Official entry roster',CASE WHEN id=300 THEN 'geeklist' ELSE 'article' END,
       CASE id WHEN 300 THEN 376073 WHEN 301 THEN 47134017 WHEN 302 THEN 47901801 WHEN 303 THEN 47408545 WHEN 304 THEN 47659966 WHEN 305 THEN 48154812 END,
       1,'2026-09-20','2026-09-20'
FROM contests WHERE id BETWEEN 300 AND 305;

INSERT INTO contest_checks (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
SELECT 51+(id-300),id,'2026-09-20T12:00:00+02:00',entries_url,'manual_entry_census','complete',
       CASE WHEN id=305 THEN 'Snapshot completo del roster ufficiale corrente; challenge ancora aperto.' ELSE 'Roster ufficiale completo censito; nessun materiale aperto.' END
FROM contests WHERE id BETWEEN 300 AND 305;

INSERT INTO games (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 886+row_number() OVER (ORDER BY contest_id,position),title,status_raw,
       CASE WHEN status_normalized='withdrawn' THEN 'withdrawn' WHEN contest_id=305 THEN 'contest_ready' ELSE 'contest_complete' END,
       'Presenza e stato rilevati nel roster BGG ufficiale del contest.',COALESCE(wip_url,entry_url),'2026-09-20','2026-09-20'
FROM census_entry;

CREATE TEMP TABLE census_game AS
SELECT c.*,886+row_number() OVER (ORDER BY contest_id,position) AS game_id
FROM census_entry c;

CREATE TEMP TABLE census_author AS
SELECT author,username,row_number() OVER (ORDER BY lower(author)) AS n
FROM (SELECT author,max(username) AS username FROM census_entry GROUP BY lower(author));

INSERT INTO people (id,display_name,bgg_username,profile_url)
SELECT 9100+n,author,username,CASE WHEN username IS NOT NULL THEN 'https://boardgamegeek.com/profile/'||username END
FROM census_author a
WHERE NOT EXISTS (SELECT 1 FROM people p WHERE lower(p.display_name)=lower(a.author));

INSERT INTO game_credits (game_id,person_id,role,credit_raw)
SELECT g.game_id,p.id,'designer',g.author
FROM census_game g JOIN people p ON lower(p.display_name)=lower(g.author)
GROUP BY g.game_id;

INSERT INTO entries (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_normalized,first_seen_at,last_verified_at,withdrawn_at)
SELECT game_id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_url,entry_url,title||' by '||author,status_raw,status_normalized,'unknown','2026-09-20','2026-09-20',
       CASE WHEN status_normalized='withdrawn' THEN '2026-03-11' END
FROM census_game;

INSERT INTO entry_status_history (entry_id,check_id,status_raw,status_normalized,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT game_id,51+(contest_id-300),status_raw,status_normalized,'unknown',position,'2026-09-20T12:00:00+02:00',entry_url,'high',
       CASE WHEN contest_id=305 THEN 'Snapshot completo del roster corrente; non è una rosa finale.' ELSE 'Snapshot completo del roster ufficiale.' END
FROM census_game;

INSERT INTO contest_metric_observations (contest_id,check_id,metric_key,metric_label_raw,numeric_value,unit,method,is_official,source_url,observed_at,notes)
SELECT contest_id,51+(contest_id-300),'entries_total','Official roster entries',count(*),'entries','counted_from_official_roster',1,min(entry_url),'2026-09-20T12:00:00+02:00',
       CASE WHEN contest_id=305 THEN 'Conteggio corrente; challenge ancora aperto.' END
FROM census_entry GROUP BY contest_id;

DROP TABLE census_author;
DROP TABLE census_game;
DROP TABLE census_entry;

COMMIT;
