-- Censimento della GeekList ufficiale del 2026 Solitaire Print and Play Contest.
-- Verifica: 2026-09-04. Sono registrati solo metadati BGG; nessun materiale e' stato aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE solitaire_entry_import (
  position INTEGER PRIMARY KEY,
  title_raw TEXT NOT NULL,
  author_display TEXT,
  bgg_username TEXT,
  wip_thread_url TEXT NOT NULL,
  status_line TEXT
);

INSERT INTO solitaire_entry_import VALUES
  (1, '[WIP] Tidepool Teaparty - 10-min cozy card-fishing (solo Cassino), simple PnP build (2026 Solitaire PnP Contest) [COMPONENTS + DIGITAL, BROWSER PLAY + PLAYTHROUGH VIDEO]', '@MGribbins', NULL, 'https://boardgamegeek.com/thread/3709724/wip-tidepool-teaparty-10-min-cozy-card-fishing-sol', NULL),
  (2, 'Omens & Bones: The Curse of Zaryth [1p, 20min, standard playing cards & dice](2026 Solitaire PnP Contest -Components Available)', 'Kendall Woffinden', '@woffpack', 'https://boardgamegeek.com/thread/3716966/omens-and-bones-the-curse-of-zaryth-1p-20min-stand', NULL),
  (3, '[WIP] Legends of Dark Lands (2026 Solitaire Contest Competition Submission, Playtest Ready, TTS, Videos)', 'Janus', '@Janusansoucis', 'https://boardgamegeek.com/thread/3710076/wip-legends-of-dark-lands-2026-solitaire-contest-c', NULL),
  (4, '[WIP] Route Won 2026 Solitaire Print and Play Contest (Components Available)', 'Arthur Wohlwill', '@Arthur Wohlwill', 'https://boardgamegeek.com/thread/3717278/wip-route-won-2026-solitaire-print-and-play-contes', NULL),
  (5, '[WIP] Snip, Snip, BOOM! (a solitaire defuse-the-bomb dice game, components and PCIO available)', 'Drew Bowling', '@Miller4h9', 'https://boardgamegeek.com/thread/3684827/wip-snip-snip-boom-a-solitaire-defuse-the-bomb-dic', NULL),
  (6, '[WIP] Carnage Core - a solo 1v1v1 mech builder and fighter (2026 Solitaire PNP Contest, Components Ready, PCIO and TTS mods available)', '@BlueMaxima', NULL, 'https://boardgamegeek.com/thread/3717549/wip-carnage-core-a-solo-1v1v1-mech-builder-and-fig', 'Status: Components ready - check the thread!'),
  (7, '[WIP]Treasure, in Spades (2026 Solitaire Contest) Traditional Deck, 15 minutes, Rules/Video/Digital Ver. Available', '@UberDante', NULL, 'https://boardgamegeek.com/thread/3717627/wiptreasure-in-spades-2026-solitaire-contest-tradi', NULL),
  (8, '[WIP] RE: Retrieve, Repair, Return (Engine building, polyomino placement entry in 2026 Solitaire PnP Contest - components ready)', 'Dan W', '@swarles', 'https://boardgamegeek.com/thread/3695614/wip-re-retrieve-repair-return-engine-building-poly', 'Status: Components Ready!'),
  (9, '[WIP] Too Many Vikings [2026 Solitaire Print and Play Contest] [Componets available]', '@McThrok', NULL, 'https://boardgamegeek.com/thread/3717939/wip-too-many-vikings-2026-solitaire-print-and-play', NULL),
  (10, '[WIP] Beating Beneath the Boards (1p, Bag Building, Dice Manipulation & Placement) [Components & PCIO Available]', 'Steven Tondeur', '@Stavr0s', 'https://boardgamegeek.com/thread/3708801/wip-beating-beneath-the-boards-1p-bag-building-dic', NULL),
  (11, '[WIP] Fool Mouse [2026 Solitaire Print and Play Contest] Playable - Components Ready - More to come', 'T G Holgate', '@boardekun', 'https://boardgamegeek.com/thread/3718135/wip-fool-mouse-2026-solitaire-print-and-play-conte', NULL),
  (12, '[WIP] Athens Alone - 2026 Solitaire Print and Play Contest [20-40 min]', 'Raphaël Rochedix', '@kalkaoual', 'https://boardgamegeek.com/thread/3717393/wip-athens-alone-2026-solitaire-print-and-play-con', NULL),
  (13, '[WIP]The Most Magnificent, Utterly Important, Highly Official, Absolutely True Chronicle of ... Wilfred the Pink Lion...[2026 Solitaire Game Design Contest][Components/PCIO/TTS available]', 'Iffix Y Santaph', '@XendoBreckett', 'https://boardgamegeek.com/thread/3718644/wipthe-most-magnificent-utterly-important-highly-o', NULL),
  (14, '[WIP] The awakaned 3 - a solo space pnp survival game (2026 Solitaire PnP Contest, Components Available)', 'Pablo Muñoz', '@el_papado', 'https://boardgamegeek.com/thread/3646147/wip-the-awakaned-3-a-solo-space-pnp-survival-game', NULL),
  (15, '[WIP] Lock Pick - 2026 Solitaire Print and Play Contest [Components Ready]', '@Stwert', NULL, 'https://boardgamegeek.com/thread/3719518/wip-lock-pick-2026-solitaire-print-and-play-contes', NULL),
  (16, '[WIP] Vice and Virtue - 2026 Solitaire Print and Play Contest (Components Available)', '@TimeThief', NULL, 'https://boardgamegeek.com/thread/3719862/wip-vice-and-virtue-2026-solitaire-print-and-play', NULL),
  (17, '[WIP] Knights Aberrant - A solitaire game of procedurally generated adventure (Entry in 2026 Solitaire PnP Contest - Components Available)', 'Sam Smith', '@samsmith', 'https://boardgamegeek.com/thread/3720855/wip-knights-aberrant-a-solitaire-game-of-procedura', NULL),
  (18, '[WIP] 13 Came Callin'' - 2026 Solitaire PNP Contest [PnP/PCIO/TTS Ready] You are a living house. Render and consume your visitors to grow.', 'RK Hall', '@rkmaymay', 'https://boardgamegeek.com/thread/3721425/wip-13-came-callin-2026-solitaire-pnp-contest-pnpp', NULL),
  (19, '[WIP] Defense of Helm''s Deep, a "Draw and Draw" Tower Defense set in Middle-Earth (Submission to the 2026 Solitaire Contest) (Components Available)', 'Dominic Boomhower', '@Cozilla88', 'https://boardgamegeek.com/thread/3721903/wip-defense-of-helms-deep-a-draw-and-draw-tower-de', NULL),
  (20, '[WIP] Signal & Noise (2026 Solitaire PnP Contest - components and PCIO available)', 'Ben Morayta', '@bmorayta1', 'https://boardgamegeek.com/thread/3722153/wip-signal-and-noise-2026-solitaire-pnp-contest-co', NULL),
  (21, '[WIP] Corsairs & Krakens - A Micro Solo Game (Entry for the 2026 Solitaire Print and Play Contest) [COMPONENTS AND PCIO AVAILABLE]', 'Damien Kalina', '@HookedbyMagic', 'https://boardgamegeek.com/thread/3722475/wip-corsairs-and-krakens-a-micro-solo-game-entry-f', NULL),
  (22, '[WIP] Upholder - Malta’s Ace - 2026 Solitaire Print and Play Contest [Components Ready]', 'Patrick Millin', '@malawicob', 'https://boardgamegeek.com/thread/3719232/wip-upholder-malta-s-ace-2026-solitaire-print-and', NULL),
  (23, '[WIP] Perpetual - 2026 Solitaire Print and Play Contest', 'Blas Mena', '@BlasMena', 'https://boardgamegeek.com/thread/3722897/wip-perpetual-2026-solitaire-print-and-play-contes', NULL),
  (24, '[WIP] Ring of Rakshasas (2026 Solitaire Contest) - Spatial puzzle with standard deck, 15 min, Rules/PCIO available', 'Roshni Patel', '@schistopatel', 'https://boardgamegeek.com/thread/3722961/wip-ring-of-rakshasas-2026-solitaire-contest-spati', NULL),
  (25, 'Monster Inside Me (2026 Solitaire PnP Contest) [Components available]', 'Dmitry Wigandt', '@wigandt', 'https://boardgamegeek.com/thread/3723673/monster-inside-me-2026-solitaire-pnp-contest-compo', NULL),
  (26, 'Midnight Confessions - The Case of Dr Black | Web App Assisted Deduction Game | 1 P | 2026 Solitaire PNP Contest', 'GamerGirlOnBoard', '@gg_onboard', 'https://boardgamegeek.com/thread/3724336/midnight-confessions-the-case-of-dr-black-web-app', NULL),
  (27, '[WiP] MOW - Solo Roll & Write [Components & Online Play Available] [2026 Solitaire PnP Contest]', 'Kevin Newman', '@KevMakesGames', 'https://boardgamegeek.com/thread/3725071/wip-mow-solo-roll-and-write-components-and-online', NULL),
  (28, '[WIP] Darkness Falls - A Solo Sci-fi Survival Board Game - Pen and Paper Edition (2026 Solitaire Contest Competition Submission)', 'David Zammit', '@projektz', 'https://boardgamegeek.com/thread/3725215/wip-darkness-falls-a-solo-sci-fi-survival-board-ga', NULL),
  (29, '[WIP] Wormhole Report | 2026 Solitaire Print and Play Design Contest [Components Available]', 'Dennis Schmidt', '@Menidas', 'https://boardgamegeek.com/thread/3725222/wip-wormhole-report-2026-solitaire-print-and-play', 'Status: Components available'),
  (30, '[WIP] Pocket Spire: a shrunk version of StS (2026 Solitaire PnP contest—rules available)', 'Raphaël M', '@Ycarax', 'https://boardgamegeek.com/thread/3647926/wip-pocket-spire-a-shrunk-version-of-sts-2026-soli', NULL),
  (31, '[WIP] Survive the Mist - A solitaire game of post-apocalypse survival [2026 Solitaire PnP Design Contest] [Component ready]', 'Shamus Smith', '@Shamus', 'https://boardgamegeek.com/thread/3727500/wip-survive-the-mist-a-solitaire-game-of-post-apoc', 'Status: Components Available'),
  (32, 'Dice Delve - a component light dungeon crawler using dice as the map! (Components availiable) (2026 Solitare Design Contest)', 'Eben Lenehan', '@ebro450', 'https://boardgamegeek.com/thread/3727736/dice-delve-a-component-light-dungeon-crawler-using', NULL),
  (33, '[WIP] A Better Yesterday (Time Travel Solo Card Game) | 2026 Solitaire Print and Play Contest [Components Available]', '@oliviasquier', NULL, 'https://boardgamegeek.com/thread/3728191/wip-a-better-yesterday-time-travel-solo-card-game', 'Status: PnP files and rules under review and coming soon'),
  (34, '[WIP] Captain Crash! (1p, Command Cards, Deduction) [Components and Digital Version Available]', 'Steven Tondeur', '@Stavr0s', 'https://boardgamegeek.com/thread/3723756/wip-captain-crash-1p-command-cards-deduction-compo', NULL),
  (35, '[WIP] Behind The Curtain - worker placement, tableau/engine building - 2026 Solo PnP Game Design Contest (Components Available)', 'Martin Gonzalvez', '@DrHenryArmitage', 'https://boardgamegeek.com/thread/3730152/wip-behind-the-curtain-worker-placement-tableaueng', NULL),
  (36, '[WIP] Cape Cod Visit, a solo tableau builder and optimization puzzle, 20 min, 18 cards, PCIO ready (2026 Solitaire PnP Contest, Components Available)', '@chimbu', NULL, 'https://boardgamegeek.com/thread/3730542/wip-cape-cod-visit-a-solo-tableau-builder-and-opti', NULL),
  (37, '[WIP] Blockhead Adventures - 2026 Solo PnP Contest - Components + PCIO Available', 'Alex Cannon', '@AlexCannon', 'https://boardgamegeek.com/thread/3731556/wip-blockhead-adventures-2026-solo-pnp-contest-com', 'Status: Components Available'),
  (38, '[WIP] Abandon Gamma Sector - 18 card spatial puzzle - [Solo PNP Contest 2026] - [components, video tutorial & PCIO available]', '@sqt_pepper', NULL, 'https://boardgamegeek.com/thread/3731817/wip-abandon-gamma-sector-18-card-spatial-puzzle-so', NULL),
  (39, '[WIP] JOUST - A Solo Jousting Tournament Board Game - Pen and Paper Edition (2026 Solitaire Contest Competition Submission)', 'David Zammit', '@projektz', 'https://boardgamegeek.com/thread/3733326/wip-joust-a-solo-jousting-tournament-board-game-pe', NULL),
  (40, '[WIP] Last Prime Minister [2026 Solitaire Print and Play Contest] Playable, [PCIO/TTS Available]', 'Tihomir Radosavljevic', '@QuietOne', 'https://boardgamegeek.com/thread/3733831/wip-last-prime-minister-2026-solitaire-print-and-p', NULL),
  (41, '[PCIO/TTS available] [WIP] Take her to daycare! [2026 Solitaire PnP contest] [Components available]', 'Teemu Viinikainen', '@AntsOfTheFreeWorld', 'https://boardgamegeek.com/thread/3735336/pciotts-available-wip-take-her-to-daycare-2026-sol', 'Status: Playtesting'),
  (42, '[WIP] WARRING KINGDOMS [2026 Solitaire PnP contest] [PLAYTEST READY]', 'Guilherme Vieira', '@dsfsdfsdfwa', 'https://boardgamegeek.com/thread/3737430/wip-warring-kingdoms-2026-solitaire-pnp-contest-pl', NULL),
  (43, '[WIP] Pivot Pilot - Loop-deck builder - 2026 Solo PnP Game Design Contest (Components ready)', 'Georg Fischer', '@Herr_Goldberg', 'https://boardgamegeek.com/thread/3737333/wip-pivot-pilot-loop-deck-builder-2026-solo-pnp-ga', 'Status: Idea phase'),
  (44, '[WIP] Vertical Overlines Solitaire Snowboarding - Dice rolling, line drawing, push your luck [2026 Solitaire Print and Play Contest] [Components available]', 'Marko Naumanen', '@vizikahn', 'https://boardgamegeek.com/thread/3739127/wip-vertical-overlines-solitaire-snowboarding-dice', NULL),
  (45, '[WIP- RULES AVAILABLE!] We Regret to Inform - Manage six trench sections during brutal shelling in this WW1 bureaucracy survival-horror game (2026 Solitaire PnP Contest)', 'Romet Põhako', '@Rometx', 'https://boardgamegeek.com/thread/3738710/wip-rules-available-we-regret-to-inform-manage-six', 'Status: being balanced and actively worked on. Rules to be published soon.'),
  (46, '[WIP] Don''t Play This Game - 2026 Solitaire PnP Contest (Components Ready)', 'Ronan Stafford', '@NanSolo', 'https://boardgamegeek.com/thread/3740100/wip-dont-play-this-game-2026-solitaire-pnp-contest', NULL),
  (47, '[WIP] Summoning Demons - 2026 Solitaire PnP Contest (Components Ready)', 'Juan Agustín Maiolino', '@MisterThaum', 'https://boardgamegeek.com/thread/3740856/wip-summoning-demons-2026-solitaire-pnp-contest-co', NULL),
  (48, 'Doodle-inks: A Roll''n''Write''n''Play Golf Game (2026 PnP Solitaire Contest)', 'Chris Whittemore', '@witty671', 'https://boardgamegeek.com/thread/3742948/doodle-inks-a-rolln-writen-play-golf-game-2026-pnp', NULL),
  (49, '[WIP] The Hidden World - A Solo Dice Adventure Game [2026 Solitaire Print-n-Play Contest Entry] [Components Ready]', 'Constance Metzinger', '@commanderphipps', 'https://boardgamegeek.com/thread/3743402/wip-the-hidden-world-a-solo-dice-adventure-game-20', NULL),
  (50, '[WIP] Lights Out - 2026 Solo PnP Game Design Contest (Playtest Ready)', 'Uncle Mac', '@UncleMac', 'https://boardgamegeek.com/thread/3744707/wip-lights-out-2026-solo-pnp-game-design-contest-p', NULL),
  (51, '[WIP} Tomb Tin - 2026 Solitaire Print and Play Design Contest', '@Squidosaurus', NULL, 'https://boardgamegeek.com/thread/3744985/wip-tomb-tin-2026-solitaire-print-and-play-design', NULL),
  (52, '[WIP] Final Shift – A Response-Driven Deckbuilder (2026 Solitaire PnP Contest Entry - DIGITAL & PnP Ready)', 'MsRyan', '@MsRyan', 'https://boardgamegeek.com/thread/3745573/wip-final-shift-a-response-driven-deckbuilder-2026', 'Status: Finalizing gameplay rules & completing artwork for fully designed components'),
  (53, 'Ant Farm (An entry into the 2026 Solitaire Game Design Contest)', 'Frank', '@GameCogs', 'https://boardgamegeek.com/thread/3747098/ant-farm-an-entry-into-the-2026-solitaire-game-des', NULL),
  (54, '[WIP] Zerax Clinic - A small 9-card dice-placement solitaire game with injured aliens (2026 Solitaire Print and Play Contest)', 'Giovanni', '@Logarius', 'https://boardgamegeek.com/thread/3749243/wip-zerax-clinic-a-small-9-card-dice-placement-sol', NULL),
  (55, '[WIP]Code of Caligos[2026 Solitaire Game Design Contest][Components and TTS available]', 'Iffix Y Santaph', '@XendoBreckett', 'https://boardgamegeek.com/thread/3749828/wipcode-of-caligos2026-solitaire-game-design-conte', NULL),
  (56, '[WIP] Beaver Dam - Solo PNP Design Contest 2026 entry [Components Ready] [Playtesting Phase]', 'Andy Couch', '@SchoonerTorrent', 'https://boardgamegeek.com/thread/3751892/wip-beaver-dam-solo-pnp-design-contest-2026-entry', NULL),
  (57, '[WIP] Croaking by the Pond - 18 cards [2026 Solitaire PnP contest] [Components available] [PCIO]', 'Rebuzus', '@rebuzus', 'https://boardgamegeek.com/thread/3752465/wip-croaking-by-the-pond-18-cards-2026-solitaire-p', NULL),
  (58, '[WIP] Ankle Breakers', 'A. R. Curry', '@CuRillaGames', 'https://boardgamegeek.com/thread/3753581/wip-ankle-breakers', NULL),
  (59, '[WIP] Please Be Patient (1p, Card Placement, Dice Assignment) [Components & PCIO available]', 'Steven Tondeur', '@Stavr0s', 'https://boardgamegeek.com/thread/3753626/wip-please-be-patient-1p-card-placement-dice-assig', NULL),
  (60, '[WIP] Pecunia Sanguinus: The Lobbyist’s Game - Solo Euro Market-manipulation Simulator (2026 Solitaire PnP Contest) [PCIO + COMPONENTS AVAILABLE]', 'Sterling Stokes', '@boardlemur', 'https://boardgamegeek.com/thread/3753902/wip-pecunia-sanguinus-the-lobbyist-s-game-solo-eur', NULL),
  (61, 'Wuul Farm: Frostbreak (2026 Solitaire Contest Competition Submission, Components Available)', 'Kinga Wroblewska', '@KiniaT', 'https://boardgamegeek.com/thread/3754624/wuul-farm-frostbreak-2026-solitaire-contest-compet', NULL),
  (62, '[WIP] Mugs of Madness (1p, 15-30 min, ages 14+, a 20-card game of chthonic chaos...and coffee!)- 2026 Solitaire Print and Play Contest entry (Components Ready!)', 'Rachel Carpenter', '@Herald Selenay', 'https://boardgamegeek.com/thread/3756311/wip-mugs-of-madness-1p-15-30-min-ages-14-plus-a-20', 'Status: Components Ready!'),
  (63, 'Seventeen!!! 2026 Solitaire Print and Play Contest.', 'Rogelio Pesqueira Sánchez', '@R0GER', 'https://boardgamegeek.com/thread/3757052/seventeen-2026-solitaire-print-and-play-contest', NULL),
  (64, '[WIP] Tales of the Windward Sea (one-page pirate adventure)', 'J Fatula', '@buffalohat', 'https://boardgamegeek.com/thread/3757339/wip-tales-of-the-windward-sea-one-page-pirate-adve', NULL),
  (65, 'Unicellular - A 9 cards Roll ''n'' Write Resource Management entry to the 2026 Solitaire Print and Play Contest [Components Ready]', 'Henry Henri', '@Henry_Henri', 'https://boardgamegeek.com/thread/3757581/unicellular-a-9-cards-roll-n-write-resource-manage', NULL),
  (66, '[WIP] Cursed Bingo - 1-page solo roll-and-write (2026 Solitaire PnP Contest) [COMPONENTS AVAILABLE]', 'Harry Metcalf', '@HarryMetcalf', 'https://boardgamegeek.com/thread/3757640/wip-cursed-bingo-1-page-solo-roll-and-write-2026-s', NULL),
  (67, '[WIP] One More Gear [2026 Solitaire PnP contest] [Components Available]', '@DarkTigerX98', NULL, 'https://boardgamegeek.com/thread/3757916/wip-one-more-gear-2026-solitaire-pnp-contest-compo', 'Status: Rules and Low Ink Components Ready. Art still in progress.'),
  (68, '[WIP] Dream Stone - A 9-card in-hand game that requires no table - (2026 Solitaire PnP Contest) [The rulebook and components are ready]', 'Ge Qin', '@QinGe', 'https://boardgamegeek.com/thread/3758499/wip-dream-stone-a-9-card-in-hand-game-that-require', NULL),
  (69, '[WIP] Strike Twelve - An entry into the 2026 Solitaire Print and Play Contest [Component and Digital Ready]', 'Drew Grgich', '@dgrgich', 'https://boardgamegeek.com/thread/3758945/wip-strike-twelve-an-entry-into-the-2026-solitaire', 'Status: Components Ready and web-app available for download'),
  (70, 'Utopia Express (2026 Solitaire Print and Play Contest) Components available', 'Bill Nickeas', '@nickeas', 'https://boardgamegeek.com/thread/3759385/utopia-express-2026-solitaire-print-and-play-conte', 'Status: Idea Phase'),
  (71, 'WIP: Component Ready - Re-Chronicle, An entry in the 2026 Solitaire Print & Play Contest and the most thematic deckbuilding game ever?', 'Dan Carlson', '@phatticarlson', 'https://boardgamegeek.com/thread/3759763/wip-component-ready-re-chronicle-an-entry-in-the-2', NULL),
  (72, '[WIP]: Not·ro, 54 card solo print-and-play, originally a Balatro boardgame pitch', 'Ross Esmond', '@ross_esmond', 'https://boardgamegeek.com/thread/3694850/wip-notro-54-card-solo-print-and-play-originally-a', NULL),
  (73, 'Hanging Gardens (An entry for the 2026 Solitaire Print and Play Contest)', 'Joe T', '@LanternReefStudios', 'https://boardgamegeek.com/thread/3760494/hanging-gardens-an-entry-for-the-2026-solitaire-pr', NULL),
  (74, '{WIP] Restore the Reef! (2026 Solo PNP Contest Entry)', 'Sam Barton', '@Table_for_two_games', 'https://boardgamegeek.com/thread/3760556/wip-restore-the-reef-2026-solo-pnp-contest-entry', NULL),
  (75, '[WIP] Below Zero - Action Point System, hand & resource management Survival game - 2026 Solo PnP Game Design Contest (Components Available)', 'Adrian Pillai', '@elfboy', 'https://boardgamegeek.com/thread/3760334/wip-below-zero-action-point-system-hand-and-resour', NULL),
  (76, '[WIP] Please Don’t Feed The Bears (2026 pnp solo)', 'Graeme Straw', '@GraemeCracker', 'https://boardgamegeek.com/thread/3760815/wip-please-don-t-feed-the-bears-2026-pnp-solo', NULL),
  (77, '[WIP] Reef Revival Solo', 'Shane Tholen', '@Shano33', 'https://boardgamegeek.com/thread/3760841/wip-reef-revival-solo', 'Status: Work in Progress. Reef Revival Solo has been play-tested and fine-tuned. The current artwork is clip-art and will be replaced by original artwork.'),
  (78, '[WIP] War of the Worlds: The Journey - 2026 Solitaire Print and Play Contest [Components Ready]', '@philgooch', NULL, 'https://boardgamegeek.com/thread/3727954/wip-war-of-the-worlds-the-journey-2026-solitaire-p', NULL),
  (79, '[WIP] Nailhead 24 - 2026 Solo PnP Game Design Contest (Components Available)', 'Jon Clarke', '@Cold_Water_Games', 'https://boardgamegeek.com/thread/3761042/wip-nailhead-24-2026-solo-pnp-game-design-contest', 'Status: Components Available.'),
  (80, '[WIP] Hero of Rome: Usurper - solo, low-ink PnP Ancient Rome political simulator using deck of cards & dice', 'Peter Majewski', '@ThornTrooper', 'https://boardgamegeek.com/thread/3761089/wip-hero-of-rome-usurper-solo-low-ink-pnp-ancient', 'Status: Playable PnP, all files free to download'),
  (81, '[WIP] 638 Squadron - A Solo WWII Aerial Bombing Game (2026 Solitaire Print and Play Contest)', 'Constance Metzinger', '@commanderphipps', 'https://boardgamegeek.com/thread/3761120/wip-638-squadron-a-solo-wwii-aerial-bombing-game-2', NULL),
  (82, '[WIP] Story Quilt - cozy roll & color game - 2026 Solo PnP Game Design Contest (Components Available, playtest ready)', 'Alex M', '@Dinofeatherz', 'https://boardgamegeek.com/thread/3761424/wip-story-quilt-cozy-roll-and-color-game-2026-solo', NULL),
  (83, '[WIP] One More Card?! | Solo push-your-luck with a standard deck | 2026 Solitaire PnP Contest', 'Balazs Rafael', '@Rhemedyl1', 'https://boardgamegeek.com/thread/3761527/wip-one-more-card-solo-push-your-luck-with-a-stand', 'Status: Playtest Ready'),
  (84, '[WIP] Troubled Sands - A solo cozy temple crawler - (2026 Solitaire Print and Play Contest)', '@rkshelton21', NULL, 'https://boardgamegeek.com/thread/3761539/wip-troubled-sands-a-solo-cozy-temple-crawler-2026', NULL),
  (85, '[WIP] Cliff Dwellers - compact tile-layer (2026 Solitaire PnP Contest) [COMPONENTS AVAILABLE]', 'Harry Metcalf', '@HarryMetcalf', 'https://boardgamegeek.com/thread/3761593/wip-cliff-dwellers-compact-tile-layer-2026-solitai', 'Status: components available'),
  (86, '[WIP] The Castle In The Clouds: Solo Stealth-Focused Dungeon Crawl (BGG 2026 Solitaire Print and Play Contest)', 'Ryan Moylan', '@RPMgamer', 'https://boardgamegeek.com/thread/3757894/wip-the-castle-in-the-clouds-solo-stealth-focused', NULL),
  (87, '[WIP] Friend-Ship, a 7 cards dice placement entry to the 2026 solitaire game design contest', 'Henry Henri', '@Henry_Henri', 'https://boardgamegeek.com/thread/3761676/wip-friend-ship-a-7-cards-dice-placement-entry-to', NULL),
  (88, '[WIP] - How The Tides Turn (Fantasy themed Roll and Write with multi-use combat cards) - 2026 Solo PnP Contest entry [Components Ready]', 'Stephen Lambert', '@steevolution', 'https://boardgamegeek.com/thread/3761729/wip-how-the-tides-turn-fantasy-themed-roll-and-wri', NULL),
  (89, '[WIP] Lawman - Solo Card and Dice Game', 'David Stewart', '@davidfstewart', 'https://boardgamegeek.com/thread/3758908/wip-lawman-solo-card-and-dice-game', NULL);

UPDATE contests
SET entries_url = 'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants',
    status_raw = 'SUBMISSIONS ARE CLOSED; games are in development; voting will open soon',
    status_normalized = 'development',
    last_verified_at = '2026-09-04'
WHERE id = 1;

INSERT OR IGNORE INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at)
VALUES (1, 'entries_geeklist', 'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants', 'Official entries GeekList', 'geeklist', 379109, 1, '2026-09-04', '2026-09-04');

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes)
VALUES (10, 1, '2026-09-04T20:00:00+02:00', 'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants', 'manual_entry_census', 'complete', 'Censite tutte le 89 entry visibili su quattro pagine; nessun materiale aperto o scaricato.');

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 5 + position,
       title_raw,
       COALESCE(status_line, title_raw),
       CASE
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%idea phase%' THEN 'idea'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%playtest ready%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playtesting%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playable%' THEN 'playtest_ready'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%component%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%rules available%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%pnp ready%' THEN 'components_available'
         WHEN lower(title_raw) LIKE '%wip%' OR lower(title_raw) LIKE '%{wip]%' THEN 'wip'
         ELSE 'unknown'
       END,
       'Stato derivato esclusivamente dal titolo e dalla riga Status della GeekList ufficiale.',
       wip_thread_url,
       '2026-09-04',
       '2026-09-04'
FROM solitaire_entry_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 1000 + row_number() OVER (ORDER BY identity_key),
       MAX(author_display),
       NULLIF(MAX(bgg_username), ''),
       CASE WHEN NULLIF(MAX(bgg_username), '') IS NOT NULL
         THEN 'https://boardgamegeek.com/user/' || replace(ltrim(MAX(bgg_username), '@'), ' ', '%20')
       END
FROM (
  SELECT *, COALESCE(NULLIF(lower(bgg_username), ''), lower(author_display)) AS identity_key
  FROM solitaire_entry_import
)
GROUP BY identity_key;

INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 5 + s.position, p.id, 'designer', s.author_display || CASE WHEN s.bgg_username IS NOT NULL THEN ' ' || s.bgg_username ELSE '' END
FROM solitaire_entry_import s
JOIN people p ON COALESCE(NULLIF(lower(p.bgg_username), ''), lower(p.display_name)) = COALESCE(NULLIF(lower(s.bgg_username), ''), lower(s.author_display));

INSERT INTO entries (id, contest_id, game_id, geeklist_id, position, wip_thread_url, entry_url, entry_text_raw, status_raw, status_normalized, materials_status_raw, materials_status_normalized, first_seen_at, last_verified_at)
SELECT 5 + position,
       1,
       5 + position,
       379109,
       position,
       wip_thread_url,
       'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants',
       title_raw,
       COALESCE(status_line, title_raw),
       CASE
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%idea phase%' THEN 'idea'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%playtest ready%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playtesting%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playable%' THEN 'playtest_ready'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%component%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%rules available%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%pnp ready%' THEN 'components_available'
         WHEN lower(title_raw) LIKE '%wip%' OR lower(title_raw) LIKE '%{wip]%' THEN 'wip'
         ELSE 'unknown'
       END,
       CASE
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%component%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%rules available%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%pnp ready%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playable pnp%' THEN 'Availability declared in GeekList title/status'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%digital%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%web app%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%online play%' THEN 'Digital availability declared in GeekList title/status'
         ELSE NULL
       END,
       CASE
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%component%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%rules available%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%pnp ready%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%playable pnp%' THEN 'available_declared'
         WHEN lower(COALESCE(status_line, title_raw)) LIKE '%digital%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%web app%'
           OR lower(COALESCE(status_line, title_raw)) LIKE '%online play%' THEN 'digital_available_declared'
         ELSE 'unknown'
       END,
       '2026-09-04',
       '2026-09-04'
FROM solitaire_entry_import;

INSERT INTO entry_status_history (entry_id, check_id, status_raw, status_normalized, materials_status_raw, materials_status_normalized, position, observed_at, source_url, confidence, notes)
SELECT e.id, 10, e.status_raw, e.status_normalized, e.materials_status_raw, e.materials_status_normalized, e.position, '2026-09-04T20:00:00+02:00', e.entry_url, 'medium', 'Prima osservazione dalla GeekList ufficiale; materiali non aperti.'
FROM entries e
WHERE e.contest_id = 1;

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes)
VALUES (1, 10, 'entries_total', '89 Items', 89, 'entries', 'reported_by_geeklist', 1, 'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants', '2026-09-04T20:00:00+02:00', 'Conteggio corrente della GeekList ufficiale; sostituisce operativamente, senza cancellarla, la precedente osservazione di 56 entry dal thread principale.');

INSERT INTO contest_metric_observations (contest_id, check_id, metric_key, metric_label_raw, numeric_value, unit, method, is_official, source_url, observed_at, notes)
SELECT 1, 10, 'entries_status_' || status_normalized, status_normalized, COUNT(*), 'entries', 'derived_from_entry_metadata', 0, 'https://boardgamegeek.com/geeklist/379109/2026-solitaire-print-and-play-contest-entrants', '2026-09-04T20:00:00+02:00', 'Distribuzione derivata da titolo e riga Status della GeekList.'
FROM entries
WHERE contest_id = 1
GROUP BY status_normalized;

DROP TABLE solitaire_entry_import;

COMMIT;
