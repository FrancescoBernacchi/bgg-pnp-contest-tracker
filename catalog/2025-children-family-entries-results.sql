-- Censimento completo del 2025 Children & Family Game Design Contest.
-- Fonti verificate: GeekList ufficiale e post dei risultati BGG, 2026-09-07.
-- Nessun file di gioco aperto o scaricato.

BEGIN IMMEDIATE;

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes) VALUES
  (35, 14, '2026-09-07', 'https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest',
   'manual_web_census', 'complete', 'Censimento completo delle 27 entry ufficiali e dei 36 piazzamenti pubblicati nel post dei risultati.');

INSERT INTO games
  (id, canonical_title, min_players, max_players, minimum_age, source_url, first_seen_at, last_verified_at,
   status_raw, status_normalized, status_evidence)
VALUES
  (487,'Good Breeding',2,4,10,'https://boardgamegeek.com/thread/3431880/wip-good-breeding-2025-children-and-family-game-de','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (488,'Pirate Treasures',2,2,6,'https://boardgamegeek.com/thread/3435409/wip-pirate-treasures-2025-children-and-family-game','2026-09-07','2026-09-07','Listed in final Children''s Game roster','contest_complete','Official final roster and results thread'),
  (489,'Pets Rescue',2,4,10,'https://boardgamegeek.com/thread/3441653/wip-pets-rescue-2025-children-and-family-game-desi','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (490,'Swirls',2,6,5,'https://boardgamegeek.com/thread/3387063/wip-swirls-2025-children-and-family-game-design-co','2026-09-07','2026-09-07','Listed in final Children''s Game roster','contest_complete','Official final roster and results thread'),
  (491,'The Robots are Multiplying',2,4,8,'https://boardgamegeek.com/thread/3442172/wip-the-robots-are-multiplying-2025-children-and-f','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (492,'Potions Master Tournament',2,4,7,'https://boardgamegeek.com/boardgame/437537/potions-master-tournament','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (493,'Isles of Odd',2,4,10,'https://boardgamegeek.com/thread/3441309/wip-isles-of-odd-2025-children-and-family-game-des','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (494,'Peng Wins!',2,4,6,'https://boardgamegeek.com/thread/3449433/wip-peng-wins-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (495,'Hex Hive: Skirmish',2,2,NULL,'https://boardgamegeek.com/thread/3449448/wip-hex-hive-skirmish-2025-children-and-family-gam','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (496,'Slowpoke',1,6,12,'https://boardgamegeek.com/thread/3451616/wip-slowpoke-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (497,'Origami Champions',2,6,10,'https://boardgamegeek.com/thread/3451743/wip-origami-champions-2025-children-and-family-gam','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (498,'Sorry! That''s My Dungeon',2,4,8,'https://boardgamegeek.com/thread/3442526/wip-sorry-thats-my-dungeon-2025-children-and-famil','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (499,'Ice Cream Heist',2,6,6,'https://boardgamegeek.com/thread/3462311/wip-ice-cream-heist-2025-children-and-family-game','2026-09-07','2026-09-07','Listed in final Children''s Game roster','contest_complete','Official final roster and results thread'),
  (500,'Poker Face',2,6,6,'https://boardgamegeek.com/thread/3465191/wip-poker-face-2025-children-and-family-game-desig','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (501,'Squirelly',2,4,8,'https://boardgamegeek.com/thread/3465485/wip-squirrelly-2025-children-and-family-game-desig','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (502,'Head In The Clouds',3,5,5,'https://boardgamegeek.com/thread/3469238/wip-head-in-the-clouds-2025-children-and-family-ga','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (503,'Submarine Adventure',1,4,NULL,'https://boardgamegeek.com/thread/3473660/wip-submarine-adventure-2025-children-and-family-g','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (504,'Island of Peril',2,6,8,'https://boardgamegeek.com/thread/3482193/wip-island-of-peril-2025-children-and-family-game','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (505,'Mermaids vs Dinosaurs',2,4,5,'https://boardgamegeek.com/thread/3484120/wip-mermaids-vs-dinosaurs-2025-children-and-family','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (506,'Allmende',2,4,8,'https://boardgamegeek.com/thread/3487174/wip-allmende-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (507,'ICBRG',2,2,8,'https://boardgamegeek.com/thread/3493395/wip-icbrg-2025-children-and-family-game-design-con','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (508,'Bon-Bon',2,6,8,'https://boardgamegeek.com/thread/3493740/wip-bon-bon-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (509,'Zoo Rush',2,4,4,'https://boardgamegeek.com/thread/3495361/wip-zoo-rush-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Children''s Game roster','contest_complete','Official final roster and results thread'),
  (510,'Crab Boil',2,6,6,'https://boardgamegeek.com/thread/3495781/wip-crab-boil-2025-children-and-family-game-design','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (511,'Panic Picasso!',3,NULL,8,'https://boardgamegeek.com/thread/3496634/wip-panic-picasso-2025-children-and-family-game-de','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (512,'Guesstrictions',3,16,12,'https://boardgamegeek.com/thread/3496460/wip-guesstrictions-2025-children-and-family-game-d','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread'),
  (513,'Amusement park - Clashes',2,4,NULL,'https://boardgamegeek.com/thread/3496296/wip-amusement-park-clashes-2025-children-and-famil','2026-09-07','2026-09-07','Listed in final Family Game roster','contest_complete','Official final roster and results thread');

INSERT INTO game_names (id, game_id, name, observed_from, observed_at, is_current) VALUES
  (1,501,'Squirrelly','GeekList WIP heading','2026-09-07',0);

INSERT INTO entries
  (id, contest_id, game_id, geeklist_id, geeklist_item_id, position, wip_thread_url, entry_url, entry_text_raw,
   status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at)
VALUES
  (487,14,487,351008,11435948,1,'https://boardgamegeek.com/thread/3431880/wip-good-breeding-2025-children-and-family-game-de','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11435948#11435948','Family Game; designer: Dani Ungar','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (488,14,488,351008,11436974,2,'https://boardgamegeek.com/thread/3435409/wip-pirate-treasures-2025-children-and-family-game','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11436974#11436974','Children''s Game; designer: Frank','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (489,14,489,351008,11437485,3,'https://boardgamegeek.com/thread/3441653/wip-pets-rescue-2025-children-and-family-game-desi','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11437485#11437485','Family Game; designer: Leonardo Kammer','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (490,14,490,351008,11440324,4,'https://boardgamegeek.com/thread/3387063/wip-swirls-2025-children-and-family-game-design-co','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11440324#11440324','Children''s Game; designer: Janusz Kuśnierek','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (491,14,491,351008,11441186,5,'https://boardgamegeek.com/thread/3442172/wip-the-robots-are-multiplying-2025-children-and-f','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11441186#11441186','Family Game; designer: mle_','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (492,14,492,351008,11448984,6,NULL,'https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11448984#11448984','Family Game; designer: Simone Muggeo','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (493,14,493,351008,11460630,7,'https://boardgamegeek.com/thread/3441309/wip-isles-of-odd-2025-children-and-family-game-des','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11460630#11460630','Family Game; designers: Nicolas Cid Delgado and Eli Protas','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (494,14,494,351008,11477979,8,'https://boardgamegeek.com/thread/3449433/wip-peng-wins-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11477979#11477979','Family Game; designer: Iffix Y Santaph','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (495,14,495,351008,11478107,9,'https://boardgamegeek.com/thread/3449448/wip-hex-hive-skirmish-2025-children-and-family-gam','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11478107#11478107','Family Game; designer: Kyle Pierce','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (496,14,496,351008,11488820,10,'https://boardgamegeek.com/thread/3451616/wip-slowpoke-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11488820#11488820','Family Game; designer: David Ugarte','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (497,14,497,351008,11489352,11,'https://boardgamegeek.com/thread/3451743/wip-origami-champions-2025-children-and-family-gam','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11489352#11489352','Family Game; designer: Roman B.','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (498,14,498,351008,11493339,12,'https://boardgamegeek.com/thread/3442526/wip-sorry-thats-my-dungeon-2025-children-and-famil','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11493339#11493339','Family Game; designer: Alexandre Camargo','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (499,14,499,351008,11544174,13,'https://boardgamegeek.com/thread/3462311/wip-ice-cream-heist-2025-children-and-family-game','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11544174#11544174','Children''s Game; designer: L S Rose','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (500,14,500,351008,11555188,14,'https://boardgamegeek.com/thread/3465191/wip-poker-face-2025-children-and-family-game-desig','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11555188#11555188','Family Game; designer: Istivano','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (501,14,501,351008,11556104,15,'https://boardgamegeek.com/thread/3465485/wip-squirrelly-2025-children-and-family-game-desig','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11556104#11556104','Family Game; designer: Rachel Carpenter; WIP heading: Squirrelly','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (502,14,502,351008,11569733,16,'https://boardgamegeek.com/thread/3469238/wip-head-in-the-clouds-2025-children-and-family-ga','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11569733#11569733','Family Game; designer: Mark Holmes','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (503,14,503,351008,11593133,17,'https://boardgamegeek.com/thread/3473660/wip-submarine-adventure-2025-children-and-family-g','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11593133#11593133','Family Game; designer: Iffix Y Santaph','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (504,14,504,351008,11632038,18,'https://boardgamegeek.com/thread/3482193/wip-island-of-peril-2025-children-and-family-game','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11632038#11632038','Family Game; designer: Michael Donelly','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (505,14,505,351008,11638759,19,'https://boardgamegeek.com/thread/3484120/wip-mermaids-vs-dinosaurs-2025-children-and-family','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11638759#11638759','Family Game; designer: Nico Valdez','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (506,14,506,351008,11655852,20,'https://boardgamegeek.com/thread/3487174/wip-allmende-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11655852#11655852','Family Game; designer: Markus H','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (507,14,507,351008,11692597,21,'https://boardgamegeek.com/thread/3493395/wip-icbrg-2025-children-and-family-game-design-con','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11692597#11692597','Family Game; designer: Ryan Moylan','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (508,14,508,351008,11694293,22,'https://boardgamegeek.com/thread/3493740/wip-bon-bon-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11694293#11694293','Family Game; designer: RollinGolem','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (509,14,509,351008,11702424,23,'https://boardgamegeek.com/thread/3495361/wip-zoo-rush-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11702424#11702424','Children''s Game; designer: thisiscat','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (510,14,510,351008,11704211,24,'https://boardgamegeek.com/thread/3495781/wip-crab-boil-2025-children-and-family-game-design','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11704211#11704211','Family Game; designer: Scobblehogs','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (511,14,511,351008,11707511,25,'https://boardgamegeek.com/thread/3496634/wip-panic-picasso-2025-children-and-family-game-de','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11707511#11707511','Family Game; designer: Suruchi Soren','Official final entry','contest_ready',NULL,'unknown','2026-09-07','2026-09-07'),
  (512,14,512,351008,11707573,26,'https://boardgamegeek.com/thread/3496460/wip-guesstrictions-2025-children-and-family-game-d','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11707573#11707573','Family Game; designer: Corey Chu','Official final entry','contest_ready','Components Available','available','2026-09-07','2026-09-07'),
  (513,14,513,351008,11709387,27,'https://boardgamegeek.com/thread/3496296/wip-amusement-park-clashes-2025-children-and-famil','https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest?itemid=11709387#11709387','Family Game; designers: Camilo Leiva and Jorge Gallardo','Official final entry','contest_ready','Components Available','available','2026-09-07','2026-09-07');

INSERT INTO entry_status_history
  (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized,
   position, observed_at, source_url, confidence, notes)
SELECT id, 35, status_raw, status_normalized, materials_status_raw, materials_status_normalized,
       position, '2026-09-07', 'https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest', 'high',
       'Snapshot completo della GeekList ufficiale; appartenenza alla rosa finale verificata nel thread del contest.'
FROM entries WHERE contest_id=14;

INSERT INTO rankings (contest_id, game_id, category, rank, is_official, evidence_url, verified_at) VALUES
  (14,488,'Best Children''s Game',1,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,509,'Best Children''s Game',2,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,499,'Best Children''s Game',3,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,507,'Best Family Game',1,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,491,'Best Family Game',2,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,500,'Best Family Game',3,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,487,'Best Family Game',4,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,508,'Best Family Game',5,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,503,'Best Family Game',6,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,506,'Best Family Game',7,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,505,'Best Family Game',8,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,494,'Best Family Game',9,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,495,'Best Family Game',10,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,507,'Best Rulebook',1,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,487,'Best Rulebook',2,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,488,'Best Rulebook',3,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,506,'Best Rulebook',4,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,494,'Best Rulebook',5,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,491,'Best Rulebook',6,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,508,'Best Rulebook',7,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,503,'Best Rulebook',8,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,512,'Best Rulebook',9,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,505,'Best Rulebook',10,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,487,'Best Theme',1,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,488,'Best Theme',2,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,513,'Best Theme',3,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,508,'Best Theme',4,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,503,'Best Theme',5,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,507,'Best Theme',6,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,491,'Best Theme',7,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,509,'Best Theme',8,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,505,'Best Theme',9,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,495,'Best Theme',10,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,509,'Best Art',1,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,499,'Best Art',2,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07'),
  (14,501,'Best Art',3,1,'https://boardgamegeek.com/thread/3441385/article/46099911#46099911','2026-09-07');

COMMIT;

-- Attesi dopo l'applicazione: 27 entry e 36 piazzamenti ufficiali per contest_id=14.
