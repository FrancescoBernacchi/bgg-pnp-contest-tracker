-- Entry e risultati del 2026 Two-Player Print and Play Game Design Contest.
-- Verifica: 2026-09-04. Solo metadati BGG; nessun materiale aperto o scaricato.

BEGIN IMMEDIATE;

CREATE TEMP TABLE two_player_import (
  position INTEGER PRIMARY KEY, title_raw TEXT NOT NULL, author_display TEXT NOT NULL,
  bgg_username TEXT, wip_thread_url TEXT NOT NULL, status_line TEXT
);

INSERT INTO two_player_import VALUES
  (1, '[WIP] Pocket Zoo — A Gateway Euro for 2-5 Players (2026 Two-Player Game Design Contest) [Components Available]', 'Corin Elliott', '@turncoatgames', 'https://boardgamegeek.com/thread/3609939/wip-pocket-zoo-a-gateway-euro-for-2-5-players-2026', 'Status: Components Available'),
  (2, '[WIP] PRISMA - Components Ready', 'Tracey', '@StrangeAcre', 'https://boardgamegeek.com/thread/3620996/wip-prisma-components-ready', NULL),
  (3, '[WIP] Gran Tavola - 2026 Two Player Print and Play Design Contest (Components Available)', 'Peter Ratzloff', '@Ratzloff', 'https://boardgamegeek.com/thread/3627701/wip-gran-tavola-2026-two-player-print-and-play-des', 'Status: Components Available'),
  (4, '[WIP] Hidden Village - 2026 Two Player Print and Play Design Contest (Components + Screentop.gg available)', 'Chris McMillion', '@PickItUpChris', 'https://boardgamegeek.com/thread/3616011/wip-hidden-village-2026-two-player-print-and-play', 'Status: Components Available, Screentop.gg Available'),
  (5, '[WIP] DRY CHICAGO, a 60 minutes wargame-like boardgame for 2 players [2026 Two-Player Print and Play Game Design Contest] COMPONENT AVAILABLE', 'Raphaël Rochedix', '@kalkaoual', 'https://boardgamegeek.com/thread/3630771/wip-dry-chicago-a-60-minutes-wargame-like-boardgam', 'Status: Rules available'),
  (6, '[WIP] Baju - 2026 Two Player Print and Play Design Contest (Components Available)', 'Adam Obren', '@adamobren', 'https://boardgamegeek.com/thread/3633058/wip-baju-2026-two-player-print-and-play-design-con', 'Status: Components available'),
  (7, '[WIP] Frutas: Abstract strategy game for 2 players, ages 8+ (2026 BGG Two-Player Game Design Contest) [Components Available]', 'Ryan Moylan', '@RPMgamer', 'https://boardgamegeek.com/thread/3634290/wip-frutas-abstract-strategy-game-for-2-players-ag', NULL),
  (8, 'WIP - Countess Bathory''s Beasts - 2026 Two Player Print and Play Design Contest - Components Ready', 'Tracey', '@StrangeAcre', 'https://boardgamegeek.com/thread/3635652/wip-countess-bathorys-beasts-2026-two-player-print', NULL),
  (9, '[WIP] fourmidable - 2026 Two Player Print and Play Design Contest (Rules, Components, Digital Ver. Available)', '@UberDante', NULL, 'https://boardgamegeek.com/thread/3636227/wip-fourmidable-2026-two-player-print-and-play-des', NULL),
  (10, '[WIP] DiceStrike - An Arcade inspired Dice Fighter - 2026 Two Player Print and Play Design Contest (PnP and Prototype available)', 'Thomas Surles', '@Thomas_surles', 'https://boardgamegeek.com/thread/3636028/wip-dicestrike-an-arcade-inspired-dice-fighter-202', NULL),
  (11, '[WIP] Uftro Wilds - 2026 Two Player Print and Play Design Contest (Prototype)', 'Nguyễn Trường Giang', '@ngiang1995', 'https://boardgamegeek.com/thread/3638150/wip-uftro-wilds-2026-two-player-print-and-play-des', NULL),
  (12, 'Peak Duel - COMPLETED', 'lazarus liew', '@lazarusliew', 'https://boardgamegeek.com/thread/3638844/peak-duel-completed', 'Status: Ready to Play'),
  (13, '[WIP] Gourmet Duel - 2026 Two Player Print and Play Design Contest (components available)', 'Felipe Llanos', '@kironcentauro', 'https://boardgamegeek.com/thread/3637879/wip-gourmet-duel-2026-two-player-print-and-play-de', NULL),
  (14, '[WIP] Sazon Criollo - 2026 Two Player Print and Play Design Contest (components available)', 'Felipe Llanos', '@kironcentauro', 'https://boardgamegeek.com/thread/3637910/wip-sazon-criollo-2026-two-player-print-and-play-d', NULL),
  (15, '[WIP] TECTONIC - 2026 Two Player Print and Play Design Contest (components available)', 'Harry-Pekka Kuusela', '@hakuus', 'https://boardgamegeek.com/thread/3639481/wip-tectonic-2026-two-player-print-and-play-design', NULL),
  (16, '[WIP] Scrapyard Tinkers - 2026 Two Player Print and Play Design Contest - Components Ready', 'Raul Portales', '@sh41', 'https://boardgamegeek.com/thread/3264080/wip-scrapyard-tinkers-2026-two-player-print-and-pl', NULL),
  (17, '[WIP] Unlucky Spirits, Revised Edition (1-4 players, 60-90 min, Ages 16+, cooperative game) - 2026 Two-Player Game Design Contest entry (Contest Complete)', 'Rachel Carpenter', '@Herald Selenay', 'https://boardgamegeek.com/thread/3640989/wip-unlucky-spirits-revised-edition-1-4-players-60', NULL),
  (18, '[WIP] Flip to Talk- 2026 Two Player Print and Play Design Contest (Components Ready waiting playtests)', 'Chris Workman', '@archer152', 'https://boardgamegeek.com/thread/3641834/wip-flip-to-talk-2026-two-player-print-and-play-de', 'Status: 1.0 Components Available'),
  (19, '[WIP] Hextract - 2026 Two Player Print and Play Design Contest (Components Avaliable)', 'Simon Povey', '@thepov', 'https://boardgamegeek.com/thread/3641938/wip-hextract-2026-two-player-print-and-play-design', NULL),
  (20, '[WIP] Cookmates - 2026 Two Player Print and Play Design Contest [Contest Ready].', 'Nguyen Hoang Quoc Quyen', '@miraclelambda72', 'https://boardgamegeek.com/thread/3644212/wip-cookmates-2026-two-player-print-and-play-desig', 'Status: Component Available'),
  (21, '[WIP] Pyramids - 2026 Two Player Print and Play Design Contest (Contest Ready)', 'Arif Nezih Savi', '@ibiliss', 'https://boardgamegeek.com/thread/3645589/wip-pyramids-2026-two-player-print-and-play-design', 'Status: Components Available'),
  (22, '[WIP] Shadow Convoy - 2026 Two Player Print and Play Design Contest (Components Available)', 'RK Hall', '@rkmaymay', 'https://boardgamegeek.com/thread/3646369/wip-shadow-convoy-2026-two-player-print-and-play-d', NULL),
  (23, '[WIP] Taxi 375 - 2026 Two Player Print and Play Design Contest (Components ready)', 'Dmytro Bespalov', '@dimabespalov', 'https://boardgamegeek.com/thread/3649812/wip-taxi-375-2026-two-player-print-and-play-design', NULL),
  (24, '[WIP] Last Donut in the Breakroom - 2026 Two Player Print and Play Design Contest (Withdrawn)', 'Kevin Privalle', '@kevinplaysgames', 'https://boardgamegeek.com/thread/3648989/wip-last-donut-in-the-breakroom-2026-two-player-pr', NULL),
  (25, '[WIP] Superhero Smash - 2026 Two Player Print and Play Design Contest (Components Available)', 'Sam Robinson', '@Lemoncurd', 'https://boardgamegeek.com/thread/3650079/wip-superhero-smash-2026-two-player-print-and-play', 'Status: Some Components Ready'),
  (26, '[WIP] Grimoire War - 2026 Two Player Print and Play Design Contest (PnP Ready + Learn-to-Play Guide)', 'Afrizal Adiputra', '@afrizaladiputra', 'https://boardgamegeek.com/thread/3651871/wip-grimoire-war-2026-two-player-print-and-play-de', NULL),
  (27, '[WIP] Patently Absurd (set collection + spatial puzzle; 1–5p, 30min) [COMPONENTS AVAILABLE]', 'Dan U', '@everthus', 'https://boardgamegeek.com/thread/3655760/wip-patently-absurd-set-collection-plus-spatial-pu', NULL),
  (28, '[WIP] Breach - 2026 Two Player Print and Play Design Contest (Components Ready)', 'Amit Reuveni', '@BurnEmDown', 'https://boardgamegeek.com/thread/3657193/wip-breach-2026-two-player-print-and-play-design-c', 'Status: Components Available'),
  (29, '[WIP] The Inner Circle - 2026 Two Player Print and Play Design Contest (Ready To Play!)', 'lazarus liew', '@lazarusliew', 'https://boardgamegeek.com/thread/3657264/wip-the-inner-circle-2026-two-player-print-and-pla', 'Status: Ready to Play'),
  (30, '[WIP] Migoyugo - 2026 Two Player Print and Play Design Contest (Ready to play - online)', 'The Nightfly', '@Migoyugo', 'https://boardgamegeek.com/thread/3655964/wip-migoyugo-2026-two-player-print-and-play-design', 'Status: Live online / Build your own'),
  (31, '[WIP] Katapultoj - 2026 Two Player Print and Play Design Contest (rules and components available)', 'Barcelona Biker', '@barcelonabiker1973', 'https://boardgamegeek.com/thread/3657835/wip-katapultoj-2026-two-player-print-and-play-desi', NULL),
  (32, '[WIP] Everyday Ramen -- 2026 Two Player Print and Play Design Contest -- (Components ready)', 'Grayson Savoie', '@TheTopDrog', 'https://boardgamegeek.com/thread/3658093/wip-everyday-ramen-2026-two-player-print-and-play', NULL),
  (33, '[WIP] Ra-Duel - 2026 Two Player Print and Play Design Contest (18 cards, PnP Available)', 'Adi', '@PaganPasta', 'https://boardgamegeek.com/thread/3609272/wip-ra-duel-2026-two-player-print-and-play-design', 'Status: Components available'),
  (34, '[WIP] HELLHAND /2 PLAYER/ COOPERATIVE/ 15 MIN/ [Components Ready][2026 Two-Player Print and Play Game Design Contest]', 'camilo leiva cardenas', '@luckycard', 'https://boardgamegeek.com/thread/3657579/wip-hellhand-2-player-cooperative-15-min-component', 'Status: Component ready'),
  (35, '[WIP] Jewel eXchange - 2026 Two Player Print and Play Design Contest (CONTEST READY)', 'J-P Kurikka', '@MrKuricat', 'https://boardgamegeek.com/thread/3531550/wip-jewel-exchange-2026-two-player-print-and-play', NULL),
  (36, '[WIP] Mint Souls - 2026 Two Player Print and Play Design Contest (Components Available)', '@eagle3zio', NULL, 'https://boardgamegeek.com/thread/3622663/wip-mint-souls-2026-two-player-print-and-play-desi', 'Status: TTS & Components Available'),
  (37, '[WIP] Let''s Take Over the HOA - 2026 Two Player Print and Play Design Contest - Finished Game', 'Eric Ledger', '@compster', 'https://boardgamegeek.com/thread/3661285/wip-lets-take-over-the-hoa-2026-two-player-print-a', 'Status: Entered, components available'),
  (38, '[WIP] ''Mancer: Gems of Power - 2026 Two Player Print and Play Design Contest - Components Ready', '@smccollu', NULL, 'https://boardgamegeek.com/thread/3642734/wip-mancer-gems-of-power-2026-two-player-print-and', 'Status: Entered, components available'),
  (39, '[WIP] Jin - 2026 Two Player Print and Play Design Contest (Components Ready)', '@Carterjoe', NULL, 'https://boardgamegeek.com/thread/3661741/wip-jin-2026-two-player-print-and-play-design-cont', 'Status: entered, components ready'),
  (40, '[WIP] Khagan - 2026 Two Player Print and Play Design Contest (Components Ready)', 'Amit Reuveni', '@BurnEmDown', 'https://boardgamegeek.com/thread/3661791/wip-khagan-2026-two-player-print-and-play-design-c', 'Status: Components Available'),
  (41, '[WIP] Infirmarium - 2026 Two Player Print and Play Design Contest (Contest Ready)', 'Billy Brooke', '@WicingesFela', 'https://boardgamegeek.com/thread/3661821/wip-infirmarium-2026-two-player-print-and-play-des', NULL),
  (42, '[WIP] Vigilante Mansion - 2026 Two Player Print and Play Design Contest (Components Ready)', 'Cameron', '@GameTortoise', 'https://boardgamegeek.com/thread/3662089/wip-vigilante-mansion-2026-two-player-print-and-pl', NULL),
  (43, '[WIP] Fishing With Fishes - 2026 Two Player Print and Play Design Contest (Components Ready)', 'Filip Kowalski', '@Voycawojka', 'https://boardgamegeek.com/thread/3662353/wip-fishing-with-fishes-2026-two-player-print-and', NULL),
  (44, '[WIP] Room For Dessert - 2026 Two Player Print and Play Design Contest (Components available)', 'Maple Nguyen', '@ArceStarwalker', 'https://boardgamegeek.com/thread/3662608/wip-room-for-dessert-2026-two-player-print-and-pla', NULL),
  (45, '[WIP] Tic TacTics - Cats vs Dogs - 2026 Two Player Print and Play Design Contest (Components Available)', '@CreakyTableGames', NULL, 'https://boardgamegeek.com/thread/3662621/wip-tic-tactics-cats-vs-dogs-2026-two-player-print', NULL);

UPDATE contests SET status_raw = 'Voting ended May 31, 2026; results and winners published', status_normalized = 'complete', results_url = 'https://boardgamegeek.com/thread/3620917/article/46964104#46964104', starts_at = '2025-12-01', submissions_close_at = '2026-02-14', voting_opens_at = '2026-04-14', voting_closes_at = '2026-05-31', last_verified_at = '2026-09-04' WHERE id = 7;

INSERT OR IGNORE INTO contest_sources (contest_id, kind, url, label, bgg_object_type, bgg_object_id, is_official, first_seen_at, last_verified_at) VALUES
  (7, 'results_post', 'https://boardgamegeek.com/thread/3620917/article/46964104#46964104', 'Official results and winners', 'article', 46964104, 1, '2026-09-04', '2026-09-04');

INSERT INTO contest_phases (contest_id, phase_type, label_raw, sequence_number, status_raw, status_normalized, starts_at, ends_at, timezone, date_precision, source_url, first_seen_at, last_verified_at, notes) VALUES
  (7, 'submissions', 'Submissions', 1, 'December 1, 2025 to February 14, 2026', 'complete', '2025-12-01', '2026-02-14', 'CT UTC-5', 'day', 'https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest', '2026-09-04', '2026-09-04', NULL),
  (7, 'playtest', 'Playtesting and feedback', 2, 'December 1, 2025 to March 14, 2026', 'complete', '2025-12-01', '2026-03-14', 'CT UTC-5', 'day', 'https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest', '2026-09-04', '2026-09-04', 'Feedback su almeno tre giochi obbligatorio per ogni entry.'),
  (7, 'corrections', 'Corrections', 3, 'Corrections end April 14, 2026', 'complete', '2026-03-15', '2026-04-14', 'CT UTC-5', 'day', 'https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest', '2026-09-04', '2026-09-04', NULL),
  (7, 'voting', 'Voting', 4, 'April 14 to May 31, 2026', 'complete', '2026-04-14', '2026-05-31', 'CT UTC-5', 'day', 'https://boardgamegeek.com/thread/3620917/2026-two-player-print-and-play-game-design-contest', '2026-09-04', '2026-09-04', NULL),
  (7, 'results', 'Results and Winners', 5, 'Results published', 'complete', NULL, NULL, 'CT UTC-5', 'unknown', 'https://boardgamegeek.com/thread/3620917/article/46964104#46964104', '2026-09-04', '2026-09-04', NULL);

INSERT INTO contest_checks (id, contest_id, checked_at, source_url, check_kind, outcome, notes) VALUES (15, 7, '2026-09-04T23:45:00+02:00', 'https://boardgamegeek.com/geeklist/368300/entries-for-the-2026-two-player-pnp-game-design-co', 'manual_entry_and_results_census', 'complete', '45 entry effettive piu un item-intestazione; classifiche ufficiali verificate. Nessun materiale aperto.');
INSERT INTO contest_status_history (contest_id, check_id, status_raw, status_normalized, observed_at, source_url, confidence, notes) VALUES (7, 15, 'Voting ended May 31, 2026; results and winners published', 'complete', '2026-09-04T23:45:00+02:00', 'https://boardgamegeek.com/thread/3620917/article/46964104#46964104', 'high', NULL);

INSERT INTO games (id, canonical_title, status_raw, status_normalized, status_evidence, source_url, first_seen_at, last_verified_at)
SELECT 167 + position, title_raw, COALESCE(status_line,title_raw),
 CASE WHEN lower(title_raw) LIKE '%withdrawn%' THEN 'withdrawn' WHEN lower(title_raw) LIKE '%contest ready%' OR lower(title_raw) LIKE '%contest complete%' OR lower(title_raw) LIKE '%completed%' OR lower(title_raw) LIKE '%finished game%' THEN 'contest_ready' WHEN lower(COALESCE(status_line,title_raw)) LIKE '%ready to play%' OR lower(title_raw) LIKE '%prototype%' OR lower(title_raw) LIKE '%pnp ready%' THEN 'playtest_ready' WHEN lower(COALESCE(status_line,title_raw)) LIKE '%component%' OR lower(COALESCE(status_line,title_raw)) LIKE '%rules available%' OR lower(title_raw) LIKE '%pnp available%' THEN 'components_available' ELSE 'wip' END,
 'Stato derivato dal titolo e dalla riga Status della GeekList ufficiale.', wip_thread_url, '2026-09-04', '2026-09-04' FROM two_player_import;

INSERT INTO people (id, display_name, bgg_username, profile_url)
SELECT 6000 + row_number() OVER (ORDER BY identity_key), MAX(author_display), NULLIF(MAX(bgg_username), ''), CASE WHEN NULLIF(MAX(bgg_username), '') IS NOT NULL THEN 'https://boardgamegeek.com/profile/' || ltrim(MAX(bgg_username), '@') END
FROM (SELECT *,COALESCE(NULLIF(lower(bgg_username),''),lower(author_display)) identity_key FROM two_player_import) GROUP BY identity_key;
INSERT INTO game_credits (game_id, person_id, role, credit_raw)
SELECT 167+s.position,p.id,'designer',s.author_display || CASE WHEN s.bgg_username IS NOT NULL THEN ' '||s.bgg_username ELSE '' END FROM two_player_import s JOIN people p ON COALESCE(NULLIF(lower(p.bgg_username),''),lower(p.display_name))=COALESCE(NULLIF(lower(s.bgg_username),''),lower(s.author_display));

INSERT INTO entries (id,contest_id,game_id,geeklist_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at,withdrawn_at)
SELECT 167+position,7,167+position,368300,position,wip_thread_url,'https://boardgamegeek.com/geeklist/368300/entries-for-the-2026-two-player-pnp-game-design-co',title_raw,COALESCE(status_line,title_raw),
 CASE WHEN lower(title_raw) LIKE '%withdrawn%' THEN 'withdrawn' WHEN lower(title_raw) LIKE '%contest ready%' OR lower(title_raw) LIKE '%contest complete%' OR lower(title_raw) LIKE '%completed%' OR lower(title_raw) LIKE '%finished game%' THEN 'contest_ready' WHEN lower(COALESCE(status_line,title_raw)) LIKE '%ready to play%' OR lower(title_raw) LIKE '%prototype%' OR lower(title_raw) LIKE '%pnp ready%' THEN 'playtest_ready' WHEN lower(COALESCE(status_line,title_raw)) LIKE '%component%' OR lower(COALESCE(status_line,title_raw)) LIKE '%rules available%' OR lower(title_raw) LIKE '%pnp available%' THEN 'components_available' ELSE 'wip' END,
 CASE WHEN lower(title_raw) LIKE '%withdrawn%' THEN NULL WHEN lower(COALESCE(status_line,title_raw)) LIKE '%component%' OR lower(COALESCE(status_line,title_raw)) LIKE '%rules available%' OR lower(title_raw) LIKE '%pnp%' OR lower(title_raw) LIKE '%prototype%' OR lower(title_raw) LIKE '%completed%' THEN 'Availability declared in GeekList metadata' END,
 CASE WHEN lower(title_raw) LIKE '%withdrawn%' THEN 'unknown' WHEN lower(COALESCE(status_line,title_raw)) LIKE '%component%' OR lower(COALESCE(status_line,title_raw)) LIKE '%rules available%' OR lower(title_raw) LIKE '%pnp%' OR lower(title_raw) LIKE '%prototype%' OR lower(title_raw) LIKE '%completed%' THEN 'available_declared' ELSE 'unknown' END,
 '2026-09-04','2026-09-04',CASE WHEN lower(title_raw) LIKE '%withdrawn%' THEN '2026-02-18' END FROM two_player_import;

INSERT INTO entry_status_history (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,15,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,'2026-09-04T23:45:00+02:00',entry_url,'high','Prima osservazione completa dalla GeekList; nessun materiale aperto.' FROM entries WHERE contest_id=7;

WITH podium(category,rank,title_key) AS (VALUES
 ('Best Game',1,'Migoyugo'),('Best Game',2,'Baju'),('Best Game',3,'fourmidable'),
 ('Best Use of Theme',1,'Shadow Convoy'),('Best Use of Theme',2,'Cookmates'),('Best Use of Theme',3,'Room For Dessert'),
 ('Best Looking Game',1,'Cookmates'),('Best Looking Game',2,'Countess Bathory''s Beasts'),('Best Looking Game',3,'Room For Dessert'),
 ('Best Rule Book',1,'Baju'),('Best Rule Book',2,'fourmidable'),('Best Rule Book',3,'Migoyugo'),
 ('Best Gamer''s Game',1,'Migoyugo'),('Best Gamer''s Game',2,'Baju'),('Best Gamer''s Game',3,'Infirmarium'),
 ('Best Gateway Game',1,'fourmidable'),('Best Gateway Game',2,'Fishing With Fishes'),('Best Gateway Game',3,'Pyramids'),
 ('Best Low-Ink / No-Ink Game',1,'Baju'),('Best Low-Ink / No-Ink Game',2,'Fishing With Fishes'),('Best Low-Ink / No-Ink Game',3,'TECTONIC'),
 ('Best Game to Play Remotely',1,'Migoyugo'),('Best Game to Play Remotely',2,'Baju'),('Best Game to Play Remotely',3,'Gourmet Duel'))
INSERT INTO rankings (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 7,g.id,p.category,p.rank,1,'https://boardgamegeek.com/thread/3620917/article/46964104#46964104','2026-09-04' FROM podium p JOIN games g ON g.id BETWEEN 168 AND 212 AND lower(g.canonical_title) LIKE '%'||lower(p.title_key)||'%';

INSERT INTO contest_metric_observations (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes) VALUES
 (7,15,'geeklist_items_total','46 Items',46,NULL,'items','reported_by_geeklist',1,'https://boardgamegeek.com/geeklist/368300/entries-for-the-2026-two-player-pnp-game-design-co','2026-09-04T23:45:00+02:00','Include un item-intestazione non corrispondente a un gioco.'),
 (7,15,'entries_total','Actual game entries',45,NULL,'entries','counted_excluding_header',0,'https://boardgamegeek.com/geeklist/368300/entries-for-the-2026-two-player-pnp-game-design-co','2026-09-04T23:45:00+02:00',NULL),
 (7,15,'entries_withdrawn','Withdrawn entries still visible',1,NULL,'entries','derived_from_entry_metadata',0,'https://boardgamegeek.com/geeklist/368300/entries-for-the-2026-two-player-pnp-game-design-co','2026-09-04T23:45:00+02:00',NULL),
 (7,15,'best_playtester_winner','Best Playtester #1',NULL,'Billy Brooke',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3620917/article/46964104#46964104','2026-09-04T23:45:00+02:00','Secondo Adam Obren; terzo CreakyTableGames.');

DROP TABLE two_player_import;
COMMIT;
