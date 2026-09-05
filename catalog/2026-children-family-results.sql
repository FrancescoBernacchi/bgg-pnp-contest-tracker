-- Risultati ufficiali del 2026 Children & Family Game Design Contest.
-- Verifica: 2026-09-05. Solo metadati BGG; nessun materiale aperto o scaricato.

BEGIN IMMEDIATE;

UPDATE contests SET
 results_url='https://boardgamegeek.com/thread/3645079/article/47697216#47697216',
 last_verified_at='2026-09-05'
WHERE id=10;

UPDATE contest_phases SET
 status_raw='Children''s results published May 19; remaining categories published May 20, 2026',
 status_normalized='complete', ends_at='2026-05-20', date_precision='day',
 last_verified_at='2026-09-05', notes='Pubblicazione in due passaggi: Best Children''s Game il 19 maggio; Best Art, Best Rulebook, Best Theme e Best Family Game il 20 maggio.'
WHERE contest_id=10 AND phase_type='results';

INSERT INTO contest_sources
 (contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (10,'results_post','https://boardgamegeek.com/thread/3645079/article/47697216#47697216','Official results posts','article',47697216,1,'2026-09-05','2026-09-05');

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (20,10,'2026-09-05','https://boardgamegeek.com/thread/3645079/article/47697216#47697216','results_baseline_completion','complete','Trascritti 43 piazzamenti ufficiali in cinque categorie. Completamento della baseline, non nuovo rilevamento periodico; nessun materiale aperto.');

CREATE TEMP TABLE family_results (category TEXT NOT NULL, rank INTEGER NOT NULL, title TEXT NOT NULL);

INSERT INTO family_results VALUES
 ('Best Children''s Game',1,'Excuse Me, Bear!'),
 ('Best Children''s Game',2,'Fruit Stacks!'),
 ('Best Children''s Game',3,'Colour Collab'),
 ('Best Art',1,'Juicy Fruit Salad'),
 ('Best Art',2,'Oh My Gods!'),
 ('Best Art',3,'Bit and Bob''s SCRAPYARD SHOWCASE'),
 ('Best Art',4,'Cookmates'),
 ('Best Art',5,'RoboRacers'),
 ('Best Rulebook',1,'Excuse Me, Bear!'),
 ('Best Rulebook',2,'Oh My Gods!'),
 ('Best Rulebook',3,'Fruit Stacks!'),
 ('Best Rulebook',4,'Alien Tongue'),
 ('Best Rulebook',5,'Juicy Fruit Salad'),
 ('Best Rulebook',6,'Bee Friendly'),
 ('Best Rulebook',7,'Cookmates'),
 ('Best Rulebook',8,'The Cheese Stands Alone'),
 ('Best Rulebook',9,'The Abyss'),
 ('Best Rulebook',10,'Graffito'),
 ('Best Theme',1,'Alien Tongue'),
 ('Best Theme',2,'The Abyss'),
 ('Best Theme',3,'Daikoro: Elemental Dice Duel'),
 ('Best Theme',4,'Oh My Gods!'),
 ('Best Theme',5,'Storyboard Heroes'),
 ('Best Theme',6,'Bit and Bob''s SCRAPYARD SHOWCASE'),
 ('Best Theme',7,'Size the Cows'),
 ('Best Theme',8,'The Cheese Stands Alone'),
 ('Best Theme',9,'Excuse Me, Bear!'),
 ('Best Theme',10,'Animal Roundup'),
 ('Best Family Game',1,'Oh My Gods!'),
 ('Best Family Game',2,'Daikoro: Elemental Dice Duel'),
 ('Best Family Game',3,'The Cheese Stands Alone'),
 ('Best Family Game',4,'Cookmates'),
 ('Best Family Game',5,'The Abyss'),
 ('Best Family Game',6,'Alien Tongue'),
 ('Best Family Game',7,'Graffito'),
 ('Best Family Game',8,'Animal Roundup'),
 ('Best Family Game',9,'IRANIKA'),
 ('Best Family Game',10,'Juicy Fruit Salad'),
 ('Best Family Game',11,'Cherries'),
 ('Best Family Game',12,'Sandwich Stackers'),
 ('Best Family Game',13,'RoboRacers'),
 ('Best Family Game',14,'Storyboard Heroes'),
 ('Best Family Game',15,'Size the Cows');

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 10,g.id,r.category,r.rank,1,
 'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05'
FROM family_results r
JOIN games g ON g.id BETWEEN 307 AND 344 AND lower(g.canonical_title)=lower(r.title);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (10,20,'result_categories','Published result categories',5,NULL,'categories','counted_from_official_results',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'published_placements','Published game placements',43,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'best_children_winner','Best Children''s Game #1',NULL,'Excuse Me, Bear!',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'best_family_winner','Best Family Game #1',NULL,'Oh My Gods!',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'best_art_winner','Best Art #1',NULL,'Juicy Fruit Salad',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'best_rulebook_winner','Best Rulebook #1',NULL,'Excuse Me, Bear!',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL),
 (10,20,'best_theme_winner','Best Theme #1',NULL,'Alien Tongue',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3645079/article/47697216#47697216','2026-09-05',NULL);

DROP TABLE family_results;
COMMIT;
