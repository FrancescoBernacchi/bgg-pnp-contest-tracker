-- Censimento completo del 2025 1-Card Print and Play Design Contest.
-- Fonti verificate: GeekList ufficiale e post dei risultati BGG, 2026-09-08.
-- Nessun file di gioco aperto o scaricato. Best Playtester è escluso perché classifica persone.

BEGIN IMMEDIATE;

UPDATE contests SET
  entries_url='https://boardgamegeek.com/geeklist/355527/2025-1-card-print-and-play-design-contest-entrants',
  results_url='https://boardgamegeek.com/thread/3487579/article/45882567#45882567',
  last_verified_at='2026-09-08'
WHERE id=15;

INSERT INTO contest_sources (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at) VALUES
  (39,15,'entries','https://boardgamegeek.com/geeklist/355527/2025-1-card-print-and-play-design-contest-entrants','Official entrants GeekList','geeklist',355527,1,'2026-09-08','2026-09-08'),
  (40,15,'results','https://boardgamegeek.com/thread/3487579/article/45882567#45882567','Official results section','article',45882567,1,'2026-09-08','2026-09-08');

INSERT INTO contest_checks (id,contest_id,checked_at,source_url,check_kind,outcome,notes) VALUES
  (36,15,'2026-09-08','https://boardgamegeek.com/geeklist/355527/2025-1-card-print-and-play-design-contest-entrants',
   'manual_web_census','complete','Censimento completo delle 38 entry rimaste nel contest e di 84 piazzamenti di gioco in nove categorie.');

CREATE TEMP TABLE _onecard_entries (
  position INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  item_id INTEGER NOT NULL,
  wip_path TEXT NOT NULL,
  credit_raw TEXT
);

INSERT INTO _onecard_entries (position,title,item_id,wip_path,credit_raw) VALUES
  (1,'Archipelago Rebels',11756596,'/thread/3505950/wip-archipelago-rebels-2025-1-card-print-and-play','Rafael Arias'),
  (2,'BEEP',11774843,'/thread/3508169/wip-beep-a-single-card-anticipation-game-1-card-pr','Nick Federico'),
  (3,'Boom!',11730494,'/thread/3501760/wip-boom-2025-1-card-pnp-design-contest-contest-re','Joe Shimwell'),
  (4,'Breathless Tango',11702651,'/thread/3495445/wip-breathless-tango-2025-1-card-pnp-design-contes','Pockets97'),
  (5,'Cuéntame (Tell me)',11752765,'/thread/3505085/cuentame-tell-me','Is. Ra.'),
  (6,'Deceive to Succeed',11682933,'/thread/3491405/wip-deceive-to-succeed-duel-game-10-minutes-based','Andrea'),
  (7,'Delivery Dash',11698145,'/thread/3494616/wip-delivery-dash-1-card-design-contest-2-or-more','Matthew Peven'),
  (8,'Disturbance at Darkholm Manor',11839189,'/thread/3520521/wip-disturbance-at-darkholm-manor-2025-1-card-pnp','Thomas More'),
  (9,'Don’t Get Snaked!',11656082,'/thread/3487751/wip-dont-get-snaked-a-1-card-background-party-game','Leo Cidner'),
  (10,'Finger Twister',11820600,'/thread/3516506/operation-d-2-2025-1-card-print-and-play-design-co','Fernando Marecos'),
  (11,'Flip Fart',11813805,'/thread/3515359/wip-flip-fart-2025-1-card-print-and-play-design-co','Felipe Llanos'),
  (12,'Going the Difference!',11778551,'/thread/3509254/wip-going-the-difference-a-1-card-1v1-dice-strateg','Sam H'),
  (13,'Honeybee and Dragonfly',11683338,'/thread/3491504/wip-honeybee-and-dragonfly-entry-into-the-2025-1-c','Margie Lester and Mark Kolb'),
  (14,'Hovercraft in a Minefield: Alligator Rescue',11784677,'/thread/3510163/wip-hovercraft-in-a-minefield-alligator-rescue-a-s','Matthew Zymet'),
  (15,'In the Trench',11704176,'/thread/3495777/wip-in-the-trench','Is. Ra.'),
  (16,'Know B4 U Go',11838035,'/thread/3520264/know-b4-u-go-2p-5-10min-cooperative-2025-1-card-pr','Daniel Cowan'),
  (17,'Laced Up',11780103,'/thread/3509555/wip-laced-up-2025-1-card-pnp-design-contest-contes','Joe Shimwell'),
  (18,'Locky Dice',11701670,'/thread/3495217/wip-locky-dice-a-solitaire-dice-manipulation-game','Joachim Emilio Antonio'),
  (19,'Lucky Words',11684918,'/thread/3491766/wip-lucky-words-entry-into-the-2025-1-card-print-a','Mark Kolb'),
  (20,'Matching Socks',11697245,'/thread/3494402/matching-socks-1p-puzzle-5min-1-card-contest','D. Teuber'),
  (21,'The Moving Fortress',11663702,'/thread/3489442/wip-the-moving-fortress-a-1-card-resource-manageme','JSmashSalted'),
  (22,'Nap & Roll',11658876,'/thread/3440820/wip-nap-and-roll-2025-1-card-print-and-play-design','Angel Hidalgo'),
  (23,'One Card Battle',11801505,'/thread/3512843/wip-one-card-battle-2025-1-card-print-and-play-des','drawanyth'),
  (24,'One Card Guard',11662295,'/thread/3489141/wip-one-card-guard-a-solo-dice-driven-boss-battle','Gregg Jewell'),
  (25,'One Intersection',11790347,'/thread/3511086/wip-one-intersection-1p-15-20min-dice-manipulation','Dmytro Bespalov'),
  (26,'Pass the Dice',11694494,'/thread/3493787/wip-pass-the-dice-quick-dice-roller-for-2-4-player','Szabolcs Kukucska'),
  (27,'The Peak',11799200,'/thread/3512510/wip-the-peak-2025-1-card-print-and-play-design-con','Daniel O'),
  (28,'Piece of Cake',11795619,'/thread/3512039/wip-piece-of-cake-2025-1-card-print-and-play-desig','Daniel O'),
  (29,'Rabbit Race',11751482,'/thread/3505789/wip-rabbit-race-1-card-racing-game-1-4-players-202','Mateo Giaccone'),
  (30,'Saltatorial',11821906,'/thread/3517033/wip-saltatorial-a-whimsical-cricket-simulator-2025','Diego Sartorato'),
  (31,'Self Service',11817726,'/thread/3516181/wip-self-service-2-4p-8-10min-worker-placement-dic','Mert Bitmez'),
  (32,'Shadow Heist',11806673,'/thread/3513986/wip-shadow-heist-2025-1-card-print-and-play-design','Felipe Llanos'),
  (33,'Ship Under Sabotage',11658807,'/thread/3488497/wip-ship-under-sabotage-a-1-card-deduction-game-co','Leo Cidner'),
  (34,'Sliminal Pursuit',11806665,'/thread/3513981/wip-sliminal-pursuit-2025-1-card-print-and-play-de','Felipe Llanos'),
  (35,'Some Strings Attached',11795615,'/thread/3512037/wip-some-strings-attached-2025-1-card-print-and-pl','thisiscat'),
  (36,'Way of the Goose',11783266,'/thread/3510065/wip-way-of-the-goose-a-snappy-dexterity-game-for-2','Joachim Emilio Antonio'),
  (37,'Wobbly Bridge',11736030,'/thread/3503056/wip-wobbly-bridge-contest-ready-2025-1-card-pnp-de','Michael Donnelly'),
  (38,'Zombie Apocalypse',11808631,'/thread/3514360/wip-zombie-apocalypse-2025-1-card-pnp-design-conte','Agustín Atencio Andrioli');

INSERT INTO games (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 513+position,title,'Official final entry','contest_complete',
       'Present in the closed official GeekList; main thread states all listed entries remained in the contest.',
       'https://boardgamegeek.com'||wip_path,'2026-09-08','2026-09-08'
FROM _onecard_entries ORDER BY position;

INSERT INTO entries
  (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,
   status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 513+position,15,513+position,355527,item_id,position,
       'https://boardgamegeek.com'||wip_path,
       'https://boardgamegeek.com/geeklist/355527/2025-1-card-print-and-play-design-contest-entrants?itemid='||item_id||'#'||item_id,
       'Entry: '||title||'; designer credit: '||credit_raw,
       'Official final entry','contest_ready',NULL,'unknown','2026-09-08','2026-09-08'
FROM _onecard_entries ORDER BY position;

INSERT INTO game_names (id,game_id,name,observed_from,observed_at,is_current) VALUES
  (2,523,'Operation D-2','Official GeekList heading','2026-09-08',0),
  (3,533,'Shapelink','Official GeekList entry text: former title','2026-09-08',0);

INSERT INTO entry_status_history
  (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,
   position,observed_at,source_url,confidence,notes)
SELECT id,36,status_raw,status_normalized,materials_status_raw,materials_status_normalized,
       position,'2026-09-08','https://boardgamegeek.com/geeklist/355527/2025-1-card-print-and-play-design-contest-entrants','high',
       'Snapshot completo della GeekList ufficiale chiusa; il thread principale conferma che tutte le entry elencate sono rimaste nel contest.'
FROM entries WHERE contest_id=15;

WITH result(category,rank,title) AS (VALUES
  ('Best Overall Game',1,'Locky Dice'),('Best Overall Game',2,'Nap & Roll'),('Best Overall Game',3,'Sliminal Pursuit'),
  ('Best Overall Game',4,'Honeybee and Dragonfly'),('Best Overall Game',5,'Shadow Heist'),('Best Overall Game',6,'Matching Socks'),
  ('Best Overall Game',7,'Self Service'),('Best Overall Game',8,'BEEP'),('Best Overall Game',9,'Delivery Dash'),
  ('Best Overall Game',10,'Ship Under Sabotage'),('Best Overall Game',11,'Way of the Goose'),('Best Overall Game',12,'Lucky Words'),
  ('Best Overall Game',13,'Rabbit Race'),('Best Overall Game',14,'Don’t Get Snaked!'),('Best Overall Game',15,'Boom!'),
  ('Best Solitaire Game',1,'Matching Socks'),('Best Solitaire Game',2,'Locky Dice'),('Best Solitaire Game',3,'Hovercraft in a Minefield: Alligator Rescue'),
  ('Best Solitaire Game',4,'Breathless Tango'),('Best Solitaire Game',5,'Zombie Apocalypse'),('Best Solitaire Game',6,'Cuéntame (Tell me)'),
  ('Best Solitaire Game',7,'One Intersection'),('Best Solitaire Game',8,'Honeybee and Dragonfly'),('Best Solitaire Game',9,'Lucky Words'),
  ('Best Solitaire Game',10,'Disturbance at Darkholm Manor'),
  ('Best Multiplayer Game',1,'Sliminal Pursuit'),('Best Multiplayer Game',2,'Nap & Roll'),('Best Multiplayer Game',3,'BEEP'),
  ('Best Multiplayer Game',4,'Way of the Goose'),('Best Multiplayer Game',5,'Rabbit Race'),('Best Multiplayer Game',6,'Honeybee and Dragonfly'),
  ('Best Multiplayer Game',7,'Boom!'),('Best Multiplayer Game',8,'Flip Fart'),('Best Multiplayer Game',9,'Wobbly Bridge'),
  ('Best Multiplayer Game',10,'Delivery Dash'),
  ('Best Game Name',1,'Matching Socks'),('Best Game Name',2,'Breathless Tango'),('Best Game Name',3,'Ship Under Sabotage'),
  ('Best Game Name',4,'Honeybee and Dragonfly'),('Best Game Name',5,'Delivery Dash'),('Best Game Name',6,'Nap & Roll'),
  ('Best Game Name',7,'Cuéntame (Tell me)'),('Best Game Name',8,'Wobbly Bridge'),('Best Game Name',9,'Sliminal Pursuit'),
  ('Best Game Name',10,'Shadow Heist'),
  ('Most Innovative Mechanic Involving the 1 Card',1,'Delivery Dash'),('Most Innovative Mechanic Involving the 1 Card',2,'Matching Socks'),
  ('Most Innovative Mechanic Involving the 1 Card',3,'Hovercraft in a Minefield: Alligator Rescue'),
  ('Most Innovative Mechanic Involving the 1 Card',4,'Finger Twister'),('Most Innovative Mechanic Involving the 1 Card',5,'Boom!'),
  ('Most Innovative Mechanic Involving the 1 Card',6,'Some Strings Attached'),('Most Innovative Mechanic Involving the 1 Card',7,'Laced Up'),
  ('Most Innovative Mechanic Involving the 1 Card',8,'Breathless Tango'),('Most Innovative Mechanic Involving the 1 Card',9,'Flip Fart'),
  ('Most Innovative Mechanic Involving the 1 Card',10,'Saltatorial'),
  ('Best Rule Book',1,'Matching Socks'),('Best Rule Book',2,'Hovercraft in a Minefield: Alligator Rescue'),('Best Rule Book',3,'Saltatorial'),
  ('Best Rule Book',4,'Sliminal Pursuit'),('Best Rule Book',5,'Nap & Roll'),('Best Rule Book',6,'Locky Dice'),
  ('Best Rule Book',7,'BEEP'),('Best Rule Book',8,'Way of the Goose'),('Best Rule Book',9,'Delivery Dash'),('Best Rule Book',10,'Flip Fart'),
  ('Best Artist',1,'Nap & Roll'),('Best Artist',2,'Archipelago Rebels'),('Best Artist',3,'Piece of Cake'),('Best Artist',4,'Rabbit Race'),
  ('Best Artist',5,'BEEP'),('Best Artist',6,'The Peak'),('Best Artist',7,'In the Trench'),('Best Artist',8,'One Intersection'),
  ('Best Artist',9,'Way of the Goose'),('Best Artist',10,'Some Strings Attached'),
  ('Best New Designer',1,'Nap & Roll'),('Best New Designer',2,'Sliminal Pursuit'),('Best New Designer',3,'Shadow Heist'),
  ('Best New Designer',4,'Self Service'),('Best New Designer',5,'Boom!'),('Best New Designer',6,'Hovercraft in a Minefield: Alligator Rescue'),
  ('Best New Designer',7,'Wobbly Bridge'),
  ('Thematic Challenge: Switching of Roles: Dystopia',1,'Honeybee and Dragonfly'),
  ('Thematic Challenge: Switching of Roles: Dystopia',2,'Don’t Get Snaked!')
)
INSERT INTO rankings (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 15,g.id,result.category,result.rank,1,
       'https://boardgamegeek.com/thread/3487579/article/45882567#45882567','2026-09-08'
FROM result JOIN games g ON g.canonical_title=result.title;

DROP TABLE _onecard_entries;

COMMIT;

-- Attesi dopo l'applicazione: 38 entry e 84 piazzamenti ufficiali per contest_id=15.
