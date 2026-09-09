-- Censimento completo del 2025 Solitaire Print and Play Contest.
-- Verifica: 2026-09-09. Solo metadati BGG; nessun regolamento o componente aperto/scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 entries_url='https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants',
 results_url='https://boardgamegeek.com/thread/3520713/article/46153954#46153954',
 status_raw='ALL Results are IN!!',status_normalized='complete',last_verified_at='2026-09-09'
WHERE id=17;

UPDATE contest_sources SET last_verified_at='2026-09-09' WHERE contest_id=17;

UPDATE contest_phases SET sequence_number=5 WHERE contest_id=17 AND phase_type='voting';

INSERT INTO contest_sources
 (id,contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (42,17,'results_post','https://boardgamegeek.com/thread/3520713/article/46153954#46153954','Official results and winners','article',46153954,1,'2026-09-09','2026-09-09');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (17,'typo_corrections','Typo Corrections',3,'Until October 20th, 2025','complete','2025-10-16','2025-10-20T23:59:59-06:00','MT','second','https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest','2026-09-09','2026-09-09',NULL),
 (17,'freeze','Freeze (Changes Locked)',4,'October 21st, 2025 until the End of Contest','complete','2025-10-21','2025-11-15T23:59:59-07:00','MT','second','https://boardgamegeek.com/thread/3520713/2025-solitaire-print-and-play-contest','2026-09-09','2026-09-09',NULL),
 (17,'results','Results and Winners',6,'Results published by November 22, 2025','complete',NULL,'2025-11-22','MT','day','https://boardgamegeek.com/thread/3520713/article/46153954#46153954','2026-09-09','2026-09-09','Il 22 novembre è un limite superiore attestato dall’ultima modifica della GeekList chiusa; il post risultati riservato conserva la data originaria di creazione del thread, non quella di pubblicazione dei risultati.');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (38,17,'2026-09-09','https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants','manual_web_census','complete','Snapshot completo delle 74 entry ancora presenti nelle tre pagine della GeekList ufficiale e dei 167 piazzamenti di gioco pubblicati in 16 categorie. Nessun materiale aperto.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
VALUES
 (17,38,'ALL Results are IN!!','complete','2026-09-09','https://boardgamegeek.com/thread/3520713/article/46153954#46153954','high','Il thread principale dichiara inoltre che tutte le entry sono ancora nella GeekList del contest.');

CREATE TEMP TABLE solitaire_2025_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT,bgg_username TEXT,
 geeklist_item_id INTEGER NOT NULL,wip_thread_url TEXT NOT NULL,title_raw TEXT NOT NULL,status_line TEXT
);

INSERT INTO solitaire_2025_import VALUES
 (1,'Only Diced Words','sam sam','sam_sam',11840030,'https://boardgamegeek.com/thread/3519694/wip-only-diced-words-solo-pnp-contest-25contest-re','[WIP] Only Diced Words-(Solo PnP Contest 25)[CONTEST READY]','Status: Components Available'),
 (2,'It''s Not Rocket Science','Drew Bowling','Miller4h9',11840032,'https://boardgamegeek.com/thread/3520767/wip-its-not-rocket-science-a-solitaire-game-of-dic','[WIP] It''s Not Rocket Science (a solitaire game of dice-powered rocket propulsion, 2025 Solitaire PnP contest, Components + PCIO Available)','Status: Components Available'),
 (3,'Delve in Your Pocket: The Folded Depths Await','Kendall Woffinden','woffpack',11840305,'https://boardgamegeek.com/thread/3519938/wip-delve-in-your-pocket-the-folded-depths-await-1','[WIP] Delve in Your Pocket: The Folded Depths Await [1p, 60min, PocketFold dungeon crawl anywhere - even without dice, Video] (2025 Solitaire PnP Design Contest -Components Available)',NULL),
 (4,'Tron: Origin','Daegan Lente','DagelBagel',11840747,'https://boardgamegeek.com/thread/3520697/wip-tron-origin-2025-solitaire-contest-contest-rea','[WIP] Tron: Origin - 2025 Solitaire Contest [CONTEST READY + VIDEO]','Status: Idea phase'),
 (5,'Johnny Appleseed','Arthur Wohlwill','Arthur Wohlwill',11841579,'https://boardgamegeek.com/thread/3521035/wip-johnny-appleseed-contest-ready-2025-solo-pnp-c','[WIP] Johnny Appleseed Contest Ready (2025 Solo PNP Contest)',NULL),
 (6,'Toborochi','Iffix Y Santaph','XendoBreckett',11841640,'https://boardgamegeek.com/thread/3521022/wiptoborochi2025-solitaire-game-design-contesttest','[WIP]Toborochi[2025 Solitaire Game Design Contest][Testing Components Available]',NULL),
 (7,'Tightrope Terror','Steven Tondeur','Stavr0s',11844319,'https://boardgamegeek.com/thread/3507873/wip-tightrope-terror-1p-set-collection-balance-mgm','[WIP] Tightrope Terror (1p, set collection, balance mgmt) - 2025 Solitaire PnP Design Contest [CONTEST READY]','Status: Components Available'),
 (8,'ROME','Diego Sartorato','Sartorato_ato',11845076,'https://boardgamegeek.com/thread/3521436/wip-rome-a-solitaire-game-for-bored-citizens-2025','[WIP] ROME -- A solitaire game for bored citizens [2025 Solitaire PnP Design Contest] [Component ready]',NULL),
 (9,'Covert Tricks','Matthew Gribbins','MGribbins',11845121,'https://boardgamegeek.com/thread/3521431/wip-covert-tricks-a-solo-trick-taking-game-1-playe','[WIP] Covert Tricks - A Solo Trick-Taking Game (1 player, 15-30 mins, trick-taking, variable objectives, hand management) - 2025 Solitaire PnP Contest Entry [CONTEST READY]',NULL),
 (10,'Abydos','Rachel Carpenter','Herald Selenay',11849930,'https://boardgamegeek.com/thread/3522182/wip-abydos-1p-30-min-real-time-puzzle-game-2025-so','[WIP] Abydos (1p, 30 min, real-time puzzle game)- 2025 Solitaire Print and Play Game Design Contest entry (Contest Complete)','Status: Contest Ready!'),
 (11,'Never Ending West','Kevin Taylor','multigraingames',11854716,'https://boardgamegeek.com/thread/3523039/wip-never-ending-west-1-page-procedurally-generate','WIP - Never Ending West - 1 page procedurally generated western sandbox / diceless roll n'' write - ‘25 solo contest {contest ready, folks}',NULL),
 (12,'Run Time Zombie','Shamus Smith','Shamus',11855112,'https://boardgamegeek.com/thread/3523083/wip-run-time-zombie-a-solitaire-game-of-zombie-apo','[WIP] Run Time Zombie - A solitaire game of zombie apocalypse survival [2025 Solitaire PnP Design Contest] [Component ready]','Status: Components Available'),
 (13,'Eighteen Eggs','Rachel Carpenter','Herald Selenay',11857382,'https://boardgamegeek.com/thread/3523615/wip-eighteen-eggs-1p-10-min-memory-matching-puzzle','[WIP] Eighteen Eggs (1p, 10 min, memory, matching, puzzle game)- 2025 Solitaire Print and Play Game Design Contest entry (Contest Complete!)','Status: Contest Ready!'),
 (14,'Miskatonic Confidential','David Llort','DonDepre',11859452,'https://boardgamegeek.com/thread/3486464/wip-miskatonic-confidential-2025-solitaire-print-a','[WIP] Miskatonic Confidential- 2025 Solitaire Print and Play Game Design Contest (Components Ready)','Status: Component Ready'),
 (15,'South Shore Vibes','Scott K','sdkabel',11860785,'https://boardgamegeek.com/thread/3524180/wip-2025-solitaire-pnp-contest-south-shore-vibes','[WIP] 2025 Solitaire PNP Contest - South Shore Vibes',NULL),
 (16,'Advance The Ranch',NULL,'SilentIsleGames',11861613,'https://boardgamegeek.com/thread/3524433/wip-advance-the-ranch-2025-solo-pnp-contest-compon','[WIP] Advance The Ranch (2025 Solo PNP Contest, components ready)','Status: Components Available'),
 (17,'SNAP',NULL,'Timmy14',11863867,'https://boardgamegeek.com/thread/3524851/components-ready-open-for-playtests-snap-2025-solo','[Components ready - open for playtests] SNAP (2025 solo PnP Contest)','Status: Components + rules Available'),
 (18,'D6 Alchemist','Michael Sewall','thecrazyscotsman',11866560,'https://boardgamegeek.com/thread/3525435/wip-d6-alchemist-2025-solitaire-print-and-play-con','[WIP] D6 Alchemist - 2025 Solitaire Print & Play Contest [Easy Build, Components Available]','Status: Components Available'),
 (19,'Lasercut','Daniel Young','iiiDaNiii',11869437,'https://boardgamegeek.com/thread/3526117/wip-lasercut-2025-solo-pnp-contest-contest-ready','[WIP] LASERCUT | 2025 Solo PNP Contest | Contest Ready','Status: Components Ready'),
 (20,'Vicinity','Koen Diels','koendiels',11870695,'https://boardgamegeek.com/thread/3459416/wip-vicinity-a-simple-solo-tile-placement-game-con','[WIP] Vicinity - A simple solo tile placement game [Contest Ready]','Status: Components available'),
 (21,'Count Poitiers: Murder at Harmax Hall','Die Scholle','Scholle80',11871255,'https://boardgamegeek.com/thread/3526641/wip-count-poitiers-murder-at-harmax-hall-2025-soli','[WIP] Count Poitiers: Murder at Harmax Hall [2025 Solitaire P&P Design Contest] [Components Available]','Status: Components Available'),
 (22,'Courtful of Tricks','Andy D','virabhadara',11872056,'https://boardgamegeek.com/thread/3526900/wip-courtful-of-tricks-solo-pnp-design-contest-tri','[WIP] Courtful of Tricks - Solo PNP Design Contest - Trick Taking (Components Available)','Status: Online Components Available'),
 (23,'Word Dungeon','Joe Shimwell','joe_plays_games',11873287,'https://boardgamegeek.com/thread/3527240/wip-word-dungeon-2025-solitaire-p-and-p-design-con','[WIP] Word Dungeon [2025 Solitaire P&P Design Contest] [Components Available]',NULL),
 (24,'Urban Planner','Wayne Koenig','Orwe11',11873394,'https://boardgamegeek.com/thread/3526943/wip-urban-planner-component-ready-2025-solitaire-p','[WIP] Urban Planner - Component Ready - [2025 Solitaire Print and Play Contest]',NULL),
 (25,'Calculated Risk','Joachim Emilio Antonio','OfficeTurtle',11875082,'https://boardgamegeek.com/thread/3527694/wip-calculated-risk-1p-15min-tableau-building-puzz','[WiP] Calculated Risk [1p, 15min. tableau building puzzle, 2025 Solitaire Print and Play Design Contest] [CONTEST READY]',NULL),
 (26,'Underdice Kingdom','KaQu Kal','kaqu',11877419,'https://boardgamegeek.com/thread/3528152/wip-underdice-kingdom-2025-solitaire-print-and-pla','[WIP] Underdice Kingdom [2025 Solitaire Print and Play Contest]',NULL),
 (27,'Contubernium: Rome at War','Dennis Schmidt','Menidas',11877520,'https://boardgamegeek.com/thread/3528184/complete-contubernium-rome-at-war-2025-solitaire-p','[COMPLETE] Contubernium: Rome at War | 2025 Solitaire Print and Play Design Contest [Components & Rules available]','Status: Components Available'),
 (28,'Super Robo JetKaiser Z','Martin Gonzalvez','DrHenryArmitage',11880175,'https://boardgamegeek.com/thread/3528637/wip-super-robo-jetkaiser-z-3rd-place-2025-solo-pnp','[WIP] Super Robo JetKaiser Z! -- 3rd Place, 2025 Solo PnP Contest -- [Deck Builder, Boss Battler] (Contest Ready)','Status: Components Available!'),
 (29,'Jacobites 1745','David Storey','davidpanik',11881362,'https://boardgamegeek.com/thread/3528153/wip-jacobites-1745-solo-pnp-roll-and-write','[WIP] Jacobites 1745 - Solo PNP roll and write',NULL),
 (30,'Here they come... AGAIN!','Rafael Arias','comodinski',11886312,'https://boardgamegeek.com/thread/3530072/wip-here-they-come-again-2025-solitaire-print-and','[WIP] Here they come... AGAIN! - 2025 Solitaire Print and Play Contest [COMPONENTS READY]',NULL),
 (31,'Oregon Trail','Grayson Savoie','TheTopDrog',11887013,'https://boardgamegeek.com/thread/3530234/wip-oregon-trail-2025-solitaire-print-and-play-con','[WIP] Oregon Trail -- 2025 Solitaire Print and Play Contest -- (Contest ready)',NULL),
 (32,'Plague Vector','Clark Anderson','Cnote58',11887672,'https://boardgamegeek.com/thread/3530383/wip-plague-vector-2025-solitaire-print-and-play-co','[WIP] Plague Vector - 2025 Solitaire Print & Play Contest [CONTEST READY]',NULL),
 (33,'Alea’s Garden','Brave James','imbravejames',11888246,'https://boardgamegeek.com/thread/3530593/aleas-garden-cosy-polyomino-deckbuilding-game-winn','alea''s garden - cosy polyomino deckbuilding game (winner of 2025 BGG Solitaire PnP Design Contest!)',NULL),
 (34,'Bread & Circuits','Steven Tondeur','Stavr0s',11888320,'https://boardgamegeek.com/thread/3530627/wip-bread-and-circuits-1p-investment-bag-building','[WIP] Bread & Circuits (1p, investment, bag building) - 2025 Solitaire PnP Design Contest [CONTEST READY, PCIO AND PLAYTHROUGH VIDEO AVAILABLE]','Status: Components Available'),
 (35,'Four-Armed Robot Blaster: Hunt for the Arqu','Dominic Boomhower','Cozilla88',11901531,'https://boardgamegeek.com/thread/3533740/wip-four-armed-robot-blaster-hunt-for-the-arqu-a-s','[WIP] Four-Armed Robot Blaster: Hunt for the Arqu, a solo game where...well, where you blast robots (A second submission to the 2025 Solitaire Contest) [Second Version Components Available]',NULL),
 (36,'Landscapes','Shaun Elliot','dunmharu',11902984,'https://boardgamegeek.com/thread/3534010/wip-landscapes-solo-set-collection-card-game-5-min','[WIP] Landscapes - Solo set collection card game - 5 mins | 2025 Solo PNP Contest | Components and Rules Available',NULL),
 (37,'DonJon Defense','Victor Camacho','Vicc Camacho',11903959,'https://boardgamegeek.com/thread/3534318/wip-donjon-defense-a-solo-tower-defense-card-game','[WIP] DONJON DEFENSE - A solo ''tower defense'' card game | 2025 Solitaire PnP Contest',NULL),
 (38,'Aqua Fluens',NULL,'thisiscat',11905225,'https://boardgamegeek.com/thread/3534737/wip-aqua-fluens-2025-solitaire-p-and-p-design-cont','[WIP] Aqua Fluens [2025 Solitaire P&P Design Contest] [Contest Ready]',NULL),
 (39,'Diemon',NULL,'TimeThief',11907497,'https://boardgamegeek.com/thread/3535235/wip-diemon-2025-solitaire-pnp-contest-components-a','[WIP] Diemon (2025 Solitaire PNP Contest) [Components Available]','Status: Idea Phase'),
 (40,'Pocket Submarine','Lukas Beran','Houp',11911059,'https://boardgamegeek.com/thread/3535810/wip-pocket-submarine-2025-solitaire-p-and-p-design','[WIP] Pocket Submarine [2025 Solitaire P&P Design Contest] [Components Available][Online prototype]','Status: Playable (personally tested 50+ times)'),
 (41,'X-Stream Squatters','Frank','Wildcard Six',11918176,'https://boardgamegeek.com/thread/3536789/x-stream-squatters-contest-ready','X-Stream Squatters - (Contest Ready)',NULL),
 (42,'Yokocho','Adayu','Adayu',11956883,'https://boardgamegeek.com/thread/3543546/wip-yokocho-2025-solitaire-game-design-contest-con','[WIP] Yokocho [2025 Solitaire Game Design Contest] [Contest Ready, TSS, Video]',NULL),
 (43,'He Watches With No Eyes','Dominic Boomhower','Cozilla88',11961197,'https://boardgamegeek.com/thread/3544732/wip-he-watches-with-no-eyes-a-mournington-game-sub','[WIP] He Watches With No Eyes - A Mournington Game (Submission to the 2025 Solitaire Contest) [Components Avilable]',NULL),
 (44,'Server Breach','Sterling Stokes','boardlemur',11964053,'https://boardgamegeek.com/thread/3545479/wip-server-breach-fast-solo-card-game-of-strategic','[WIP] Server Breach - Fast, Solo Card Game of Strategic Planning and Control (2025 Solitaire Print and Play Contest) [CONTEST READY]',NULL),
 (45,'Pilzgrim','Peter Bonte','Kill_that_bird',11965364,'https://boardgamegeek.com/thread/3545369/wip-pilzgrim-solo-36-cards-map-maze-components-and','[WIP] PILZGRIM - solo / 36 cards / map / maze / - components and art ready - 2025 Solitaire PNP Contest','Status: Component ready, manual ready'),
 (46,'Going Knowhere','Gregg Jewell','JewellGames',11967992,'https://boardgamegeek.com/thread/3546467/wip-2042026-update-going-knowhere-solo-fantasy-rog','[WIP - 2/04/2026 Update] Going Knowhere - Solo Fantasy Roguelite Playing Card Game (Free PnP Files Available)',NULL),
 (47,'Nan''s Heroes','Tony Camilleri','stonesoupgames',11970935,'https://boardgamegeek.com/thread/3547246/nans-heroes-pnp','Nan''s Heroes (PnP)',NULL),
 (48,'Rourke''s Relics: Jungle Quest','Constance Metzinger','commanderphipps',11977486,'https://boardgamegeek.com/thread/3548740/rourkes-relics-jungle-quest-a-solo-adventure-card','Rourke''s Relics: Jungle Quest - A Solo Adventure Card Game [2025 Solitaire Print and Play Contest Entry] CONTEST READY',NULL),
 (49,'null_pr0xy','Shaun Elliot','dunmharu',11979249,'https://boardgamegeek.com/thread/3549054/wip-null-pr0xy-solo-dice-manipulation-push-your-lu','[WIP] - null_pr0xy - Solo, dice-manipulation, push your luck, netrunner-esque game - 2025 Solitaire PNP Contest','Status: Online version Available. Components available in the coming days.'),
 (50,'Thru The Thicket','GamerGirlOnBoard','gg_onboard',11991904,'https://boardgamegeek.com/thread/3551597/wip-thru-the-thicket-a-cozy-solo-exploration-game','WIP- Thru The Thicket- A Cozy Solo Exploration Game - 2025 Solitaire PNP Game Contest - [COMPONENTS READY]','Status : Components Ready'),
 (51,'Flipping Fortune','Georg Fischer','Herr_Goldberg',11996993,'https://boardgamegeek.com/thread/3552470/wip-flipping-fortune-push-your-luck-deckbuilding-2','[WIP] FLIPPING FORTUNE - Push-your-luck / Deckbuilding - 2025 Solitaire PnP Contest (Contest Ready))',NULL),
 (52,'Brothers in Arms','Vincenzo Giambusso','ziotempa',12004915,'https://boardgamegeek.com/thread/3545944/wip-brothers-in-arms-solo-pnp-contest-25','[WIP] Brothers in Arms (Solo PnP Contest 25)','Status: Link to rulebook (Ita/Eng), Cards (Eng only) and playthrough available in the WIP thread.'),
 (53,'Cupid Boards A Train','Ronan Stafford','NanSolo',12012471,'https://boardgamegeek.com/thread/3555269/wip-cupid-boards-a-train-2025-solitaire-pnp-contes','[WIP] Cupid Boards A Train - 2025 Solitaire PnP Contest (CONTEST READY) - 1p, Dice Rolling, Instruction Programming','Status: Components Available'),
 (54,'Micro-Cosmic Confrontation','Mikołaj','Mik00',12015016,'https://boardgamegeek.com/thread/3555735/wip-micro-cosmic-confrontation-solitaire-pnp-game','[WIP] Micro-Cosmic Confrontation - Solitaire PnP Game Contest 2025','Status: Version 1.0 - Playable, Tested, Components available'),
 (55,'Drone Workshop','Ben Parbury','Abraham',12017872,'https://boardgamegeek.com/thread/3556332/wip-drone-workshop-2025-solitaire-print-and-play-c','[WIP] Drone Workshop - 2025 Solitaire Print and Play Contest',NULL),
 (56,'Arachnacrisis','Patrick Wheeler','CousinPaddy',12028066,'https://boardgamegeek.com/thread/3554850/wip-arachnacrisis-1p-dice-pool-team-management-202','[WIP] Arachnacrisis (1P, Dice Pool, Team Management) - 2025 Solitare PnP Design Contest [Ready to Playtest!]',NULL),
 (57,'Vesuvius 79','Romain Bourdoncle','CroixOregon99',12028397,'https://boardgamegeek.com/thread/3558753/vesuvius-79-2025-solitaire-p-and-p-design-contest','Vesuvius 79 [2025 Solitaire P&P Design Contest] [Components available]',NULL),
 (58,'Island Stranding','Jeremiah Brammer','jeremiahbrammer',12033163,'https://boardgamegeek.com/thread/3559890/wip-island-stranding-hand-management-18-cards-puzz','[WIP] Island Stranding (Hand Management, 18 Cards, Puzzly] [Pcio & Low-Ink Components Available] [2025 Solo Contest]',NULL),
 (59,'Poker''s Rogue Reckoning',NULL,'DamianReloaded',12037978,'https://boardgamegeek.com/thread/3560847/wip-pokers-rogue-reckoning','[WIP] Poker''s Rogue Reckoning',NULL),
 (60,'Carthago Servanda Est',NULL,'ForgetMeTomorrow',12052295,'https://boardgamegeek.com/thread/3563889/wip-carthago-servanda-est','[WIP] CARTHAGO SERVANDA EST',NULL),
 (61,'Moonsail','Marko Naumanen','vizikahn',12052930,'https://boardgamegeek.com/thread/3563993/wip-moonsail-a-solitaire-roll-and-write-pirate-adv','[WIP] Moonsail - A Solitaire Roll & Write Pirate Adventure Game [2025 Solitaire Print and Play Contest ] [Contest Ready]',NULL),
 (62,'Jelly','Juan Agustín Maiolino','MisterThaum',12053167,'https://boardgamegeek.com/thread/3564034/wip-jelly-a-puzzle-book-2025-solitaire-pnp-game-co','WIP- Jelly - A Puzzle Book - 2025 Solitaire PNP Game Contest - [COMPONENTS READY]','Status: Components Ready (version 0.3)'),
 (63,'Dominate - Machines and Trees','Henry Henri','Henry_Henri',12063819,'https://boardgamegeek.com/thread/3565711/dominate-machines-and-trees-2025-solitaire-p-and-p','Dominate - Machines and Trees [2025 Solitaire P&P Design Contest] [Contest Ready]',NULL),
 (64,'Charming the Belle','Tobias W','Puazz',12067500,'https://boardgamegeek.com/thread/3566520/charming-the-belle-2025-solitaire-print-and-play-c','Charming the Belle (2025 Solitaire Print and Play Contest)','Status: Components Available'),
 (65,'Of Memories and Decay','Budi Suma-Suma','kentangarab',12068991,'https://boardgamegeek.com/thread/3566728/wip-of-memories-and-decay-a-solo-dungeon-crawl-gam','[WIP] Of Memories and Decay - A Solo Dungeon Crawl Game (2025 Solitaire PnP Design Contest) [Components Available]','Status: Components Available'),
 (66,'Lost in Spaceship','D. Teuber','UberDante',12071053,'https://boardgamegeek.com/thread/3567188/lost-in-spaceship-2025-solitaire-contest-puzzle-1','Lost in Spaceship (2025 Solitaire Contest, Puzzle, 1 Page, Digital Ver., Rules Video)','Status: Components Available'),
 (67,'Bletchley Park',NULL,'Tribe7',12072408,'https://boardgamegeek.com/thread/3567447/bletchley-park-join-the-select-group-of-codebreake','Bletchley Park - join the select group of codebreakers at Bletchley during World War 2 in this solo dice manipulation game about cracking the Enigma cyphers...before time runs out.',NULL),
 (68,'Crikey!','Frank','Wildcard Six',12075251,'https://boardgamegeek.com/thread/3568329/crikey-contest-ready','Crikey! (Contest Ready)',NULL),
 (69,'The Wretch','Scott Nicely','Houdin',12075870,'https://boardgamegeek.com/thread/3568463/wip-the-wretch-a-2025-solitaire-pnp-contest-entry','[WIP] The Wretch a 2025 Solitaire PnP contest entry [Roll & Write]','Status: Components Available'),
 (70,'Fairway Fantasy','El Flamenco','Air Flamingo',12075901,'https://boardgamegeek.com/thread/3568475/wip-fairway-fantasy-an-entry-in-the-2025-solitaire','[WIP] Fairway Fantasy - An entry in the 2025 Solitaire Print and Play Contest',NULL),
 (71,'Coup de Jarnac','Michael Erceg','Merceg1199',12077818,'https://boardgamegeek.com/thread/3568785/wip-coup-de-jarnac-2025-solo-pnp-contest-contest-r','[WIP] Coup de Jarnac (2025 Solo PNP Contest) (Contest Ready)','Status: Components Available'),
 (72,'My Journal','Edin Mujadzevic','edvinus',12078247,'https://boardgamegeek.com/thread/3568823/wip-my-journal-2025-solitaire-p-and-p-design-conte','[WIP] My Journal [2025 Solitaire P&P Design Contest] [Components Available]','Status: Components Available'),
 (73,'Have some Cheese',NULL,'ooiixx',12078475,'https://boardgamegeek.com/thread/3568849/wip-have-some-cheese-solo-spatial-puzzle-10-mins-2','[WIP] Have some Cheese - solo spatial puzzle - 10 mins | 2025 Solitaire Print and Play Contest | Contest Ready | PnP & PCIO available','Status: Prototype Phase'),
 (74,'Overstep: Balance or Collapse','Stephen Lambert','steevolution',12079425,'https://boardgamegeek.com/thread/3569021/wip-overstep-balance-or-collapse-2025-solitaire-pr','[WIP] Overstep: Balance or Collapse ( 2025 Solitaire Print and Play ) - Contest Ready',NULL);

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 589+position,title,'Retained in the closed official GeekList','contest_ready',
 'The organizer states that all entries remain in the contest GeekList and that non-withdrawn entries at the development deadline are Contest Ready.',
 wip_thread_url,'2026-09-09','2026-09-09' FROM solitaire_2025_import;

INSERT INTO entries
 (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 589+position,17,589+position,358652,geeklist_item_id,position,wip_thread_url,
 'https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants?itemid='||geeklist_item_id||'#'||geeklist_item_id,
 title_raw||CASE WHEN designer IS NOT NULL THEN ' by '||designer ELSE '' END||' (@'||bgg_username||')'||CASE WHEN status_line IS NOT NULL THEN '; '||status_line ELSE '' END,
 'Retained in the closed official GeekList','contest_ready','Components and rules required for Contest Ready entries; files not individually opened','available_declared','2026-09-09','2026-09-09'
FROM solitaire_2025_import;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT 589+position,38,'Retained in the closed official GeekList','contest_ready','Components and rules required for Contest Ready entries; files not individually opened','available_declared',position,'2026-09-09',
 'https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants?itemid='||geeklist_item_id||'#'||geeklist_item_id,
 'high','Prima osservazione completa dalla GeekList ufficiale chiusa; nessun materiale aperto.' FROM solitaire_2025_import;

CREATE TEMP TABLE solitaire_2025_results (category TEXT NOT NULL,rank INTEGER NOT NULL,position INTEGER NOT NULL);
INSERT INTO solitaire_2025_results VALUES
 ('Best Overall Game',1,33),('Best Overall Game',2,44),('Best Overall Game',3,28),('Best Overall Game',4,23),('Best Overall Game',5,7),('Best Overall Game',6,21),('Best Overall Game',7,51),('Best Overall Game',8,53),('Best Overall Game',9,19),('Best Overall Game',10,26),('Best Overall Game',11,36),('Best Overall Game',12,72),('Best Overall Game',13,9),('Best Overall Game',14,2),('Best Overall Game',15,66),('Best Overall Game',16,11),('Best Overall Game',17,38),('Best Overall Game',18,71),('Best Overall Game',19,55),('Best Overall Game',20,5),('Best Overall Game',21,14),('Best Overall Game',22,34),('Best Overall Game',23,52),('Best Overall Game',24,24),('Best Overall Game',25,73),
 ('Best Game Name',1,23),('Best Game Name',2,7),('Best Game Name',3,51),('Best Game Name',4,2),('Best Game Name',5,44),('Best Game Name',6,66),('Best Game Name',7,26),('Best Game Name',8,33),('Best Game Name',9,28),('Best Game Name',10,53),('Best Game Name',11,18),('Best Game Name',12,71),('Best Game Name',13,38),('Best Game Name',14,14),('Best Game Name',15,19),
 ('Best Graphic Design',1,33),('Best Graphic Design',2,44),('Best Graphic Design',3,28),('Best Graphic Design',4,51),('Best Graphic Design',5,53),('Best Graphic Design',6,19),('Best Graphic Design',7,71),('Best Graphic Design',8,66),('Best Graphic Design',9,62),('Best Graphic Design',10,23),
 ('Best Rule Book',1,44),('Best Rule Book',2,19),('Best Rule Book',3,33),('Best Rule Book',4,7),('Best Rule Book',5,38),('Best Rule Book',6,23),('Best Rule Book',7,53),('Best Rule Book',8,28),('Best Rule Book',9,66),('Best Rule Book',10,20),
 ('Best Game Designed in the Contest Timeframe',1,28),('Best Game Designed in the Contest Timeframe',2,53),('Best Game Designed in the Contest Timeframe',3,26),('Best Game Designed in the Contest Timeframe',4,36),('Best Game Designed in the Contest Timeframe',5,71),('Best Game Designed in the Contest Timeframe',6,34),('Best Game Designed in the Contest Timeframe',7,73),('Best Game Designed in the Contest Timeframe',8,58),('Best Game Designed in the Contest Timeframe',9,18),('Best Game Designed in the Contest Timeframe',10,49),
 ('Best Use of Theme',1,7),('Best Use of Theme',2,28),('Best Use of Theme',3,33),('Best Use of Theme',4,19),('Best Use of Theme',5,21),('Best Use of Theme',6,53),('Best Use of Theme',7,44),('Best Use of Theme',8,71),('Best Use of Theme',9,51),('Best Use of Theme',10,2),('Best Use of Theme',11,14),('Best Use of Theme',12,55),('Best Use of Theme',13,52),('Best Use of Theme',14,74),('Best Use of Theme',15,66),
 ('Most Original Theme',1,53),('Most Original Theme',2,7),('Most Original Theme',3,19),('Most Original Theme',4,51),('Most Original Theme',5,28),('Most Original Theme',6,33),('Most Original Theme',7,42),('Most Original Theme',8,29),('Most Original Theme',9,71),('Most Original Theme',10,2),
 ('Most Innovative Mechanic',1,33),('Most Innovative Mechanic',2,24),('Most Innovative Mechanic',3,11),('Most Innovative Mechanic',4,7),('Most Innovative Mechanic',5,52),('Most Innovative Mechanic',6,66),('Most Innovative Mechanic',7,23),('Most Innovative Mechanic',8,28),('Most Innovative Mechanic',9,72),('Most Innovative Mechanic',10,74),('Most Innovative Mechanic',11,68),('Most Innovative Mechanic',12,4),('Most Innovative Mechanic',13,6),('Most Innovative Mechanic',14,71),('Most Innovative Mechanic',15,42),
 ('Best AI System in a Game',1,33),('Best AI System in a Game',2,44),('Best AI System in a Game',3,28),('Best AI System in a Game',4,52),('Best AI System in a Game',5,34),('Best AI System in a Game',6,71),('Best AI System in a Game',7,17),('Best AI System in a Game',8,2),('Best AI System in a Game',9,37),('Best AI System in a Game',10,29),
 ('Best PnP',1,19),('Best PnP',2,33),('Best PnP',3,53),('Best PnP',4,28),('Best PnP',5,23),('Best PnP',6,29),('Best PnP',7,51),('Best PnP',8,11),('Best PnP',9,7),('Best PnP',10,66),
 ('Best Low Ink Printing',1,23),('Best Low Ink Printing',2,52),('Best Low Ink Printing',3,71),('Best Low Ink Printing',4,29),('Best Low Ink Printing',5,26),('Best Low Ink Printing',6,55),('Best Low Ink Printing',7,38),('Best Low Ink Printing',8,9),('Best Low Ink Printing',9,33),('Best Low Ink Printing',10,37),
 ('Best New Solo Designer',1,44),('Best New Solo Designer',2,55),('Best New Solo Designer',3,73),('Best New Solo Designer',4,45),('Best New Solo Designer',5,37),('Best New Solo Designer',6,40),('Best New Solo Designer',7,47),('Best New Solo Designer',8,60),('Best New Solo Designer',9,65),('Best New Solo Designer',10,54),
 ('Best Artist',1,33),('Best Artist',2,45),('Best Artist',3,57),('Best Artist',4,62),('Best Artist',5,19),('Best Artist',6,56),('Best Artist',7,58),('Best Artist',8,20),('Best Artist',9,4),('Best Artist',10,41),
 ('Best New Artist',1,62),
 ('Thematic Challenge: Technology Gone Nuts: Ancient Rome',1,34),('Thematic Challenge: Technology Gone Nuts: Ancient Rome',2,38),('Thematic Challenge: Technology Gone Nuts: Ancient Rome',3,57),('Thematic Challenge: Technology Gone Nuts: Ancient Rome',4,60),('Thematic Challenge: Technology Gone Nuts: Ancient Rome',5,63),
 ('Mechanic Challenge: Investment',1,34);

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 17,589+position,category,rank,1,'https://boardgamegeek.com/thread/3520713/article/46153954#46153954','2026-09-09'
FROM solitaire_2025_results;

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (17,38,'entries_total','74 Items',74,NULL,'entries','reported_by_geeklist',1,'https://boardgamegeek.com/geeklist/358652/2025-solitaire-print-and-play-contest-entrants','2026-09-09','Tre pagine; il thread dichiara che tutte le entry sono ancora nella GeekList.'),
 (17,38,'published_game_placements','Published game placements',167,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3520713/article/46153954#46153954','2026-09-09','Sedici categorie associate a giochi; Best Playtester è esclusa.'),
 (17,38,'results_game_categories','Game-associated result categories',16,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3520713/article/46153954#46153954','2026-09-09',NULL),
 (17,38,'best_playtester_results','Best Playtester',NULL,'15 published ranks; ties at #9, #11 and #13','people_ranking','reported_by_organizer',1,'https://boardgamegeek.com/thread/3520713/article/46153954#46153954','2026-09-09','Classifica di persone non inserita in rankings.');

DROP TABLE solitaire_2025_results;
DROP TABLE solitaire_2025_import;
COMMIT;
