-- Censimento completo del 2025 Two-Player Print and Play Game Design Contest.
-- Verifica: 2026-09-09. Solo metadati BGG; nessun regolamento o componente aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 entries_url='https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries',
 results_url='https://boardgamegeek.com/thread/3530940/article/46241868#46241868',
 status_raw='The winners published',status_normalized='complete',last_verified_at='2026-09-09'
WHERE id=18;

UPDATE contest_sources SET last_verified_at='2026-09-09' WHERE contest_id=18;

INSERT INTO contest_sources
 (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (43,18,'results_post','https://boardgamegeek.com/thread/3530940/article/46241868#46241868','Official results and winners','article',46241868,1,'2026-09-09','2026-09-09');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (18,'results','The Winners',3,'Results published November 5, 2025','complete','2025-11-05','2025-11-05','CT UTC-5','day','https://boardgamegeek.com/thread/3530940/article/46241868#46241868','2026-09-09','2026-09-09','Risultati pubblicati soltanto per cinque categorie; l’organizzatore segnala voti insufficienti per diverse categorie annunciate.');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (39,18,'2026-09-09','https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries','manual_web_census','complete','La GeekList contiene 41 item: un’intestazione e 40 giochi. Registrati 41 piazzamenti nelle cinque categorie effettivamente pubblicate. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,effective_at,observed_at,source_url,confidence,notes)
VALUES
 (18,39,'The winners','complete','2025-11-05','2026-09-09','https://boardgamegeek.com/thread/3530940/article/46241868#46241868','high','Il post finale spiega che i voti non bastavano a determinare i vincitori di diverse categorie annunciate.');

CREATE TEMP TABLE two_player_2025_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT,bgg_username TEXT,
 geeklist_item_id INTEGER NOT NULL,wip_thread_url TEXT NOT NULL,title_raw TEXT NOT NULL
);

INSERT INTO two_player_2025_import VALUES
 (2,'World Trip','Adi','PaganPasta',11889647,'https://boardgamegeek.com/thread/3531092/playtest-ready-world-trip-2p-18-cardspnp-pcio-avai','[Playtest Ready] World Trip [2P, 18 cards][PnP, PCIO available]'),
 (3,'Constellate','Matthew Gribbins','MGribbins',11893212,'https://boardgamegeek.com/thread/3531905/wip-constellate-1-to-4-players-30-to-45-minutes-ti','[WIP] Constellate (1 to 4 players, 30 to 45 minutes, tile placement, pattern building, secret objectives, push your luck) - 2025 Two-Player Print and Play Game Design Contest [CONTEST READY]'),
 (4,'Heartseekers','Eric Streed','Witchway_Games',11894555,'https://boardgamegeek.com/thread/3532140/wip-heartseekers-2p-print-and-play-contest-2025','(WIP) Heartseekers - 2P Print and Play Contest 2025'),
 (5,'Mush Puppies','Justin Antezana','Oceans4Ransom',11900734,'https://boardgamegeek.com/thread/3532583/wip-mush-puppies-18-cards-2025-2-player-pnp-design','[WIP] Mush Puppies (18 cards) - 2025 2 Player PnP Design Contest - [Rules, Components, PCIO ready]'),
 (6,'Lemonade Stand','Lance Schricke','Lschricke',11901213,'https://boardgamegeek.com/thread/3533425/wip-lemonade-stand-designed-by-lance-schricke-2025','[WIP] Lemonade Stand - designed by Lance Schricke - 2025 2p PnP Game Design Contest'),
 (7,'Goal Rush','Richard B','RIchardSDD',11902476,'https://boardgamegeek.com/thread/3533918/goal-rush-wip','Goal Rush - WIP'),
 (8,'Senjin','Daniel Cluley','dcluley',11905751,'https://boardgamegeek.com/thread/3534862/wip-senjin-2025-two-player-pnp-contest-components','[WIP] Senjin - 2025 Two Player PNP Contest - [COMPONENTS READY] [2 Player Combinatorial Abstract]'),
 (9,'Scissor Wizards','Gregg Jewell','JewellGames',11907932,'https://boardgamegeek.com/thread/3535282/wip-scissor-wizards-2025-two-player-print-and-play','[WIP] Scissor Wizards - 2025 Two Player Print and Play Design Contest (Rules & Components Available)'),
 (10,'Intramural','Luke Parnell','Lukifer10',11915226,'https://boardgamegeek.com/thread/3536316/wip-intramural-the-soccer-trick-taking-poker-game','(WIP) Intramural: The Soccer trick taking poker game - 2025, 2 Player print and play contest'),
 (11,'KORxSOL','Andrew','isjustdrew',11923963,'https://boardgamegeek.com/thread/3537614/wip-korxsol-fantasy-tabletop-pvp-card-and-dice-ski','[WIP] KORxSOL - Fantasy Tabletop PVP Card and Dice Skirmish Game [2-Player 1V1] [4-Player 2V2] [Print and Play] [Component and Rulebook - READY] - 2025 Two Player Print and Play Design Contest'),
 (12,'Cube Wars','Jeffrey Griep','jeffluenza',11930100,'https://boardgamegeek.com/thread/3538610/wip-cube-wars-a-compact-4x-for-the-2025-two-player','[WIP] Cube Wars - A compact 4X for the 2025 Two Player Print and Play Design Contest [Components Ready + Screentop]'),
 (13,'KONSPIRO','watch watch','watch01',11932786,'https://boardgamegeek.com/thread/3538971/wip-konspiro-2025-two-player-pnp-reverse-deck-buil','[WIP] - KONSPIRO - 2025 Two Player PnP - reverse deck building [ready for test]'),
 (14,'Roll and Pull','Clark Anderson','Cnote58',11951691,'https://boardgamegeek.com/thread/3542280/wip-tractor-pull-2025-two-player-print-and-play-de','[WIP] Tractor Pull - 2025 Two Player Print and Play Design Contest (Rules & Components Available)'),
 (15,'Parry','Cam Gilbreath','GiantLeapGames',11954049,'https://boardgamegeek.com/thread/3542787/wip-parry','[WIP] Parry'),
 (16,'Voidsmiths','Next Two You Games','nexttwoyougames',11959928,'https://boardgamegeek.com/thread/3544288/wip-voidsmiths-2025-two-player-print-and-play-desi','[WIP] Voidsmiths - 2025 Two Player Print and Play Design Contest (CONTEST READY)'),
 (17,'Unlucky Spirits','Rachel Carpenter','Herald Selenay',11961482,'https://boardgamegeek.com/thread/3544761/wip-unlucky-spirits-original-edition-1-3-players-6','[WIP] Unlucky Spirits, Original Edition (1-3 players, 60-90 min, Ages 16+, cooperative game) - 2025 Two-Player Game Design Contest entry (Contest Complete)'),
 (18,'Diskochet','Joachim Emilio Antonio','OfficeTurtle',11962650,'https://boardgamegeek.com/thread/3545142/wip-diskochet-a-two-player-paddle-sport-card-game','[WiP] Diskochet: a two-player paddle sport card game {2025 2-Player Print and Play Game Design Contest, CONTEST READY]'),
 (19,'Automon','Kyle Pierce','Slopesofvesuvius',11975716,'https://boardgamegeek.com/thread/3548268/wip-automon-2025-two-player-game-design-contest','[WIP] Automon - 2025 Two Player Game Design Contest'),
 (20,'Collapsi','Mark S. Ball','marksball',11977918,'https://boardgamegeek.com/thread/3548846/wip-collapsi-2025-two-player-print-and-play-design','[WIP] Collapsi - 2025 Two Player Print and Play Design Contest (rules and component ready)'),
 (21,'Word Dungeon Duel','Joe Shimwell','joe_plays_games',11989905,'https://boardgamegeek.com/thread/3551113/wip-word-dungeon-duel-2-player-pnp-contest-compone','[WIP] Word Dungeon Duel [2-Player Pnp Contest] [Components Ready]'),
 (22,'Under One Sky',NULL,'themisplay',11989917,'https://boardgamegeek.com/thread/3436540/wip-under-one-sky','[WIP] Under One Sky'),
 (23,'PAWND','Ryan Moylan','RPMgamer',11990798,'https://boardgamegeek.com/thread/3547608/wip-pawnd-entry-for-2025-bgg-2-player-pnp-game-des','[WIP] PAWND: Entry for 2025 BGG 2 Player PnP Game Design Contest (abstract strategy game, ages 8+, 15-20 min) [Components Available]'),
 (24,'Orbits','Frank','Wildcard Six',11996001,'https://boardgamegeek.com/thread/3552316/orbits-an-entry-into-the-two-player-game-design-co','Orbits - an entry into the two-player game design contest.'),
 (25,'Quickdraw: Battle for Silver City','Ryan Migalla','Knosh0',12001357,'https://boardgamegeek.com/thread/3553161/wip-quickdraw-18-card-wild-west-squad-building-asy','[WIP] Quickdraw - 18-card Wild West squad building asymmetric dueling game - 2025 2-Player PNP Contest (*ready to play!*)'),
 (26,'5 Spells',NULL,'Pistols_at_Dawn',12005576,'https://boardgamegeek.com/thread/3553927/wip-5-spells-2025-two-player-pnp-contest-2-player','[WIP] 5 Spells - 2025 Two Player PnP Contest [2 player | 50 cards | 15 mins | Ages 8+ | Component Ready]'),
 (27,'Bone Machine','Tracey Phillips','StrangeAcre',12019748,'https://boardgamegeek.com/thread/3556560/bone-machine-tile-laying-hand-management-2025-2-pl','Bone Machine - Tile laying, hand management - 2025 2 Player Pnp Competition Entry - Play Ready'),
 (28,'SubMerge','Kevin Newman','KevMakesGames',12022807,'https://boardgamegeek.com/thread/3557308/wip-submerge-pnp-components-available-and-pcio-202','[WiP] SubMerge [ PnP Components Available & PCIO ][ 2025 Two Player PnP Design Contest ]'),
 (29,'WordStorm','Onur Tosun','OnurTosun',12035042,'https://boardgamegeek.com/thread/3560398/wip-wordstorm-2025-two-player-print-and-play-game','[WIP] WordStorm [2025 Two Player Print and Play Game Design Contest] [Contest Winner]'),
 (30,'Pond Pals','Leo Dip','Leodip',12049492,'https://boardgamegeek.com/thread/3563455/wip-pond-pals-2025-two-player-pnp-contest-digital','[WIP] Pond Pals - 2025 Two Player PNP Contest (Digital version also available)'),
 (31,'OiSH!i',NULL,'m_frederic',12062939,'https://boardgamegeek.com/thread/3565566/wip-oishi-a-tasty-card-game-free-pnp','[WIP] OiSH!i - A tasty card game! [Free PnP]'),
 (32,'Hex Barons','Malcolm Sutherland','Animalcolm',12066362,'https://boardgamegeek.com/thread/3566327/hex-barons-a-crunchy-streamlined-old-school-hex-sk','Hex Barons - A crunchy streamlined old-school hex skirmish game'),
 (33,'Momentum',NULL,'m_frederic',12069440,'https://boardgamegeek.com/thread/3566864/wip-momentum-2-players','[WIP] Momentum [2 Players]'),
 (34,'Florentine Towers',NULL,'BeaRes',12072546,'https://boardgamegeek.com/thread/3567502/wip-florentine-towers','[WIP] Florentine Towers'),
 (35,'War Weavers: Vikings','Nascif Abousalh Neto','nascif',12073528,'https://boardgamegeek.com/thread/3567825/wip-war-weavers-vikings-2025-two-player-print-and','[WIP] War Weavers: Vikings [2025 Two Player Print and Play Game Design Contest]'),
 (36,'Narrow Seas','Felix Livni','flivni',12073908,'https://boardgamegeek.com/thread/3567950/wip-narrow-seas-2025-two-player-pnp-contest-2-play','[WIP] Narrow Seas - 2025 Two Player PnP Contest [2 player | 20 mins | Ages 12+ | Component Ready]'),
 (37,'The Greatest Unknown Artist Beneath the Moonlight','Rafael Arias','comodinski',12074122,'https://boardgamegeek.com/thread/3568011/the-greatest-unknown-artist-beneath-the-moonlight','The Greatest Unknown Artist Beneath the Moonlight (Designed for the 2025 Two Player Game Design Contest)'),
 (38,'Perfect Gardens',NULL,'r3_a7',12074559,'https://boardgamegeek.com/thread/3568111/wip-perfect-gardens-2025-2-player-pnp-contest-entr','[WIP] Perfect Gardens - 2025 2-Player PNP Contest Entry [Abstract Strategy | Tile Laying | Bidding] [Components + rule sheet + online version available - PLAYTEST READY]'),
 (39,'Cloud''s Edge','bertez bertez','bertez',12074994,'https://boardgamegeek.com/thread/3568231/wip-clouds-edge-2025-2-player-pnp-contest-entry-pl','[WIP] Cloud''s Edge - 2025 2-Player PNP Contest Entry - Platform Fighter Inspired Fighting Game {Components, Rulesheet and Online version Available}'),
 (40,'GRDNN','Ryan Moylan','RPMgamer',12075585,'https://boardgamegeek.com/thread/3567200/wip-grdnn-entry-for-2025-bgg-2-player-pnp-game-des','[WIP] GRDNN: Entry for 2025 BGG 2 Player PnP Game Design Contest (abstract set collection game, ages 8+, 10-15 min) [Contest Ready]'),
 (41,'Duel of Fates',NULL,'DuelofFates',12149191,'https://boardgamegeek.com/thread/3563553/wip-duel-of-fates-two-player-pnp-contest','[WIP] Duel of Fates Two Player PNP Contest');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 662+position,title,'Present in the official entry GeekList after contest completion','contest_ready',
 'The rules require playable components before submission; withdrawn games must be removed from the GeekList.',wip_thread_url,'2026-09-09','2026-09-09'
FROM two_player_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 662+position,18,662+position,359588,geeklist_item_id,position,wip_thread_url,
 'https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries?itemid='||geeklist_item_id||'#'||geeklist_item_id,
 title_raw||CASE WHEN designer IS NOT NULL THEN ' by '||designer ELSE '' END||' (@'||bgg_username||')',
 'Present in the official entry GeekList after contest completion','contest_ready','Playable components required before the submission deadline; files not individually opened','available_declared','2026-09-09','2026-09-09'
FROM two_player_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 662+position,39,'Present in the official entry GeekList after contest completion','contest_ready','Playable components required before the submission deadline; files not individually opened','available_declared',position,'2026-09-09',
 'https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries?itemid='||geeklist_item_id||'#'||geeklist_item_id,'high','Prima osservazione completa; nessun materiale aperto.'
FROM two_player_2025_import;

INSERT INTO game_names (id,game_id,name,observed_from,observed_at,is_current)
VALUES (4,676,'Tractor Pull','https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries?itemid=11951691#11951691','2026-09-09',0);

CREATE TEMP TABLE two_player_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL);
INSERT INTO two_player_2025_results VALUES
 ('Best Theme',1,25),('Best Theme',2,36),('Best Theme',3,23),('Best Theme',4,9),('Best Theme',5,31),
 ('Best Graphics',1,25),('Best Graphics',2,9),('Best Graphics',3,23),('Best Graphics',3,36),('Best Graphics',5,27),
 ('Best Rule Book',1,25),('Best Rule Book',2,31),('Best Rule Book',3,8),('Best Rule Book',4,29),('Best Rule Book',5,9),
 ('Best Mechanics',1,20),('Best Mechanics',2,25),('Best Mechanics',3,27),('Best Mechanics',4,31),('Best Mechanics',5,9),('Best Mechanics',5,36),
 ('Best Overall',1,9),('Best Overall',1,29),('Best Overall',2,25),('Best Overall',3,36),('Best Overall',4,20),('Best Overall',5,31),
 ('Best Overall',6,35),('Best Overall',6,8),('Best Overall',6,27),('Best Overall',6,33),('Best Overall',6,23),('Best Overall',6,17),('Best Overall',6,2),('Best Overall',6,3),('Best Overall',6,15),('Best Overall',6,21),('Best Overall',6,5),('Best Overall',6,14),('Best Overall',6,19),('Best Overall',6,4);

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 18,662+position,category,rank,1,'https://boardgamegeek.com/thread/3530940/article/46241868#46241868','2026-09-09'
FROM two_player_2025_results;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (18,39,'geeklist_items_total','41 Items',41,NULL,'items','reported_by_geeklist',1,'https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries','2026-09-09','L’item 1 è l’intestazione del contest, non un gioco.'),
 (18,39,'entries_total','Actual game entries',40,NULL,'entries','counted_excluding_header',0,'https://boardgamegeek.com/geeklist/359588/2025-two-player-pnp-game-design-contest-entries','2026-09-09',NULL),
 (18,39,'published_game_placements','Published game placements',41,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3530940/article/46241868#46241868','2026-09-09','Cinque categorie; comprende pari merito in Best Graphics, Best Mechanics e Best Overall.'),
 (18,39,'published_result_categories','Categories with published results',5,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3530940/article/46241868#46241868','2026-09-09','L’organizzatore dichiara che i voti erano insufficienti per determinare i vincitori di diverse altre categorie annunciate.');

DROP TABLE two_player_2025_results;
DROP TABLE two_player_2025_import;
COMMIT;
