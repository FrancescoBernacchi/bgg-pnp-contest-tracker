-- Baseline completa del 2026 Solomode Contest, incluso come contest adiacente.
-- Verifica: 2026-09-05. Solo metadati BGG; nessun regolamento o componente aperto/scaricato.

BEGIN IMMEDIATE;

INSERT INTO contest_series
 (id,canonical_name,description,scope_notes,first_seen_at,last_verified_at)
VALUES
 (11,'Solomode Contest','Contest BGG per modalità solitarie fan-made di giochi già esistenti.','Contest adiacente: le entry sono varianti dipendenti da un gioco base; componenti PnP personalizzati ammessi ma non obbligatori. Trattamento differenziabile in futuro.','2026-09-05','2026-09-05');

INSERT INTO contests
 (id,series_id,bgg_thread_id,name,year,edition_label,language,geographic_scope,status_raw,status_normalized,organizer,entries_url,results_url,starts_at,submissions_close_at,voting_opens_at,voting_closes_at,source_url,first_seen_at,last_verified_at)
VALUES
 (11,11,3670686,'2026 Solomode Contest',2026,'6th installment','English','international','Results are in','complete','Edin Mujadzevic (@edvinus)','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-03-01','2026-05-15','2026-06-10','2026-06-30','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05');

UPDATE contests SET scope_type='adjacent', treatment_profile='dependent_variants' WHERE id=11;

INSERT INTO contest_sources
 (contest_id,kind,url,label,bgg_object_type,bgg_object_id,is_official,first_seen_at,last_verified_at)
VALUES
 (11,'main_thread','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','Official rules and entry list','thread',3670686,1,'2026-09-05','2026-09-05'),
 (11,'results_post','https://boardgamegeek.com/thread/3670686/article/47872399#47872399','Official results and voting statistics','article',47872399,1,'2026-09-05','2026-09-05');

INSERT INTO contest_phases
 (contest_id,phase_type,label_raw,sequence_number,status_raw,status_normalized,starts_at,ends_at,timezone,date_precision,source_url,first_seen_at,last_verified_at,notes)
VALUES
 (11,'submissions','Submissions',1,'March 1 to May 15, 2026 (midnight PST)','complete','2026-03-01','2026-05-15T23:59:59-08:00','PST','second','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05',NULL),
 (11,'feedback','Deadline for mandatory feedback',2,'May 25, 2026 (midnight PST)','complete',NULL,'2026-05-25T23:59:59-08:00','PST','second','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05','Un feedback significativo richiesto per ciascuna entry.'),
 (11,'development','Development deadline',3,'May 31, 2026 (midnight PST)','complete','2026-05-16','2026-05-31T23:59:59-08:00','PST','second','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05','Da questa scadenza regole e file dovevano restare invariati.'),
 (11,'voting','Voting',4,'June 10 to June 30, 2026 (midnight PST)','complete','2026-06-10','2026-06-30T23:59:59-08:00','PST','second','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05',NULL),
 (11,'results','Results',5,'Results published July 1, 2026','complete','2026-07-01','2026-07-01','PST','day','https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05','2026-09-05',NULL);

INSERT INTO contest_checks
 (id,contest_id,checked_at,source_url,check_kind,outcome,notes)
VALUES
 (21,11,'2026-09-05','https://boardgamegeek.com/thread/3670686/2026-solomode-contest','adjacent_inclusion_full_baseline','complete','Inclusione autorizzata come contest adiacente: 21 entry e risultati ufficiali censiti. Le entry dipendono normalmente dal gioco base; componenti PnP opzionali e non verificati.');

INSERT INTO contest_status_history
 (contest_id,check_id,status_raw,status_normalized,observed_at,source_url,confidence,notes)
VALUES
 (11,21,'Results are in','complete','2026-09-05','https://boardgamegeek.com/thread/3670686/article/47872399#47872399','high','Contest concluso il 1 luglio 2026.');

CREATE TEMP TABLE solomode_import (
 position INTEGER PRIMARY KEY,title TEXT NOT NULL,designer TEXT NOT NULL
);

INSERT INTO solomode_import VALUES
 (1,'SOLO MODE - GENPAI WAR','thierry2015'),
 (2,'SECOND WAVE - THE LOST EMPIRES SOLO MODE WITH CDG SOLO CONQUEST','thierry2015'),
 (3,'Play-I, a solo mode for Compile','Christopher Pütz'),
 (4,'Hobbit There and Back Again - Unofficial Solo Automa','Dukefanblue2005'),
 (5,'Torchlit - Unofficial Solo Automa','Dukefanblue2005'),
 (6,'The Blind Watchmaker, a solo mode for Take Time','Tom Scutt'),
 (7,'Pocket Piquet','Karen Robinson'),
 (8,'Solo mode for Humans!!!','Juan BV'),
 (9,'Onoda Solitude','Carlos'),
 (10,'R-Eco Solo Variant','Cabbage King'),
 (11,'Free Ride Fanmade Solo Mode','Eric Picard'),
 (12,'Skull King solomode','Karen Robinson'),
 (13,'Cosmotrons','Adam Prentis'),
 (14,'Betting Bots for Solo Play! (WIN)','John'),
 (15,'Infamy: The Syndicate','John Barklam'),
 (16,'Two Trips to Japan, please!','Daniel Behnke'),
 (17,'Solodraftus','Daniel Behnke'),
 (18,'Automa SWars','Adrian Gutierrez'),
 (19,'Mobilis in Mobili','Jordan Kalt'),
 (20,'Castle Solo','Edin Mujadžević'),
 (21,'Lord High and Master Lowe','Edin Mujadžević');

INSERT INTO games
 (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at)
SELECT 344+position,title,'Listed in final Best Solo Mode entry list','contest_ready',
 'Modalità solitaria fan-made dipendente da un gioco base; non rappresenta necessariamente un gioco PnP autonomo.',
 'https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05','2026-09-05'
FROM solomode_import;

INSERT INTO people (id,display_name)
SELECT 9000+row_number() OVER (ORDER BY lower(designer)),designer FROM (SELECT DISTINCT designer FROM solomode_import);

INSERT INTO game_credits (game_id,person_id,role,credit_raw)
SELECT 344+s.position,p.id,'designer',s.designer
FROM solomode_import s JOIN people p ON p.id>=9001 AND lower(p.display_name)=lower(s.designer);

INSERT INTO entries
 (id,contest_id,game_id,position,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_raw,materials_status_normalized,first_seen_at,last_verified_at)
SELECT 344+position,11,344+position,position,
 'https://boardgamegeek.com/thread/3670686/2026-solomode-contest',
 title||' by '||designer||'; classification=dependent_solo_variant; base_game_required=normally; custom_pnp_components=optional_unknown',
 'Listed in final Best Solo Mode entry list','contest_ready',
 'Solo-mode rules required; custom PnP components optional and not checked','unknown',
 '2026-09-05','2026-09-05'
FROM solomode_import;

UPDATE entries SET entry_kind='dependent_variant', base_game_dependency='required' WHERE contest_id=11;

INSERT INTO entry_status_history
 (entry_id,check_id,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,observed_at,source_url,confidence,notes)
SELECT id,21,status_raw,status_normalized,materials_status_raw,materials_status_normalized,position,
 '2026-09-05',entry_url,'high','Prima osservazione; variante dipendente dal gioco base. Nessun regolamento o componente aperto.'
FROM entries WHERE contest_id=11;

CREATE TEMP TABLE solomode_results (category TEXT NOT NULL,rank INTEGER NOT NULL,title TEXT NOT NULL);
INSERT INTO solomode_results VALUES
 ('Best Solo Mode',1,'Solo mode for Humans!!!'),('Best Solo Mode',2,'The Blind Watchmaker, a solo mode for Take Time'),('Best Solo Mode',3,'Onoda Solitude'),('Best Solo Mode',4,'Infamy: The Syndicate'),('Best Solo Mode',5,'R-Eco Solo Variant'),('Best Solo Mode',6,'Skull King solomode'),('Best Solo Mode',7,'Mobilis in Mobili'),('Best Solo Mode',8,'Cosmotrons'),('Best Solo Mode',9,'Pocket Piquet'),('Best Solo Mode',10,'Free Ride Fanmade Solo Mode'),
 ('Best Rulebook',1,'SOLO MODE - GENPAI WAR'),('Best Rulebook',2,'Hobbit There and Back Again - Unofficial Solo Automa'),('Best Rulebook',3,'Cosmotrons'),('Best Rulebook',4,'Free Ride Fanmade Solo Mode'),('Best Rulebook',5,'Play-I, a solo mode for Compile'),('Best Rulebook',6,'Lord High and Master Lowe'),('Best Rulebook',7,'Mobilis in Mobili'),('Best Rulebook',8,'Solo mode for Humans!!!'),('Best Rulebook',9,'Solodraftus'),('Best Rulebook',10,'Infamy: The Syndicate'),
 ('Best Replacement for Official Solo Mode',1,'Onoda Solitude'),('Best Replacement for Official Solo Mode',2,'Mobilis in Mobili'),('Best Replacement for Official Solo Mode',3,'Free Ride Fanmade Solo Mode'),('Best Replacement for Official Solo Mode',4,'Hobbit There and Back Again - Unofficial Solo Automa'),('Best Replacement for Official Solo Mode',5,'SECOND WAVE - THE LOST EMPIRES SOLO MODE WITH CDG SOLO CONQUEST'),
 ('Best Light Game Solo Mode',1,'Solo mode for Humans!!!'),('Best Light Game Solo Mode',2,'The Blind Watchmaker, a solo mode for Take Time'),('Best Light Game Solo Mode',3,'Onoda Solitude'),('Best Light Game Solo Mode',4,'R-Eco Solo Variant'),('Best Light Game Solo Mode',5,'Skull King solomode'),('Best Light Game Solo Mode',6,'Pocket Piquet'),('Best Light Game Solo Mode',7,'Solodraftus'),('Best Light Game Solo Mode',8,'Castle Solo'),('Best Light Game Solo Mode',9,'Hobbit There and Back Again - Unofficial Solo Automa'),('Best Light Game Solo Mode',10,'SOLO MODE - GENPAI WAR'),
 ('Best Medium/Heavy Game Solo Mode',1,'Infamy: The Syndicate'),('Best Medium/Heavy Game Solo Mode',2,'Mobilis in Mobili'),('Best Medium/Heavy Game Solo Mode',3,'Cosmotrons'),('Best Medium/Heavy Game Solo Mode',4,'Free Ride Fanmade Solo Mode'),('Best Medium/Heavy Game Solo Mode',5,'Play-I, a solo mode for Compile'),
 ('Best Artificial Opponent',1,'Castle Solo'),('Best Artificial Opponent',2,'Lord High and Master Lowe'),('Best Artificial Opponent',3,'Free Ride Fanmade Solo Mode'),('Best Artificial Opponent',4,'Cosmotrons'),('Best Artificial Opponent',5,'Hobbit There and Back Again - Unofficial Solo Automa'),('Best Artificial Opponent',6,'SOLO MODE - GENPAI WAR'),('Best Artificial Opponent',7,'Play-I, a solo mode for Compile'),('Best Artificial Opponent',8,'Infamy: The Syndicate'),('Best Artificial Opponent',9,'Torchlit - Unofficial Solo Automa'),('Best Artificial Opponent',10,'R-Eco Solo Variant'),
 ('Best First Time Solo Mode Designer',1,'Solo mode for Humans!!!'),('Best First Time Solo Mode Designer',2,'Mobilis in Mobili'),('Best First Time Solo Mode Designer',3,'Betting Bots for Solo Play! (WIN)'),
 ('Best Name',1,'The Blind Watchmaker, a solo mode for Take Time'),('Best Name',2,'Lord High and Master Lowe'),('Best Name',3,'Pocket Piquet'),('Best Name',4,'Infamy: The Syndicate'),('Best Name',5,'Play-I, a solo mode for Compile'),('Best Name',6,'Two Trips to Japan, please!'),('Best Name',7,'Mobilis in Mobili'),('Best Name',8,'Solodraftus'),('Best Name',8,'SOLO MODE - GENPAI WAR'),('Best Name',8,'Cosmotrons');

INSERT INTO rankings
 (contest_id,game_id,category,rank,is_official,evidence_url,verified_at)
SELECT 11,g.id,r.category,r.rank,1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05'
FROM solomode_results r JOIN games g ON g.id BETWEEN 345 AND 365 AND lower(g.canonical_title)=lower(r.title);

INSERT INTO contest_metric_observations
 (contest_id,check_id,metric_key,metric_label_raw,numeric_value,text_value,unit,method,is_official,source_url,observed_at,notes)
VALUES
 (11,21,'entries_best_solo_mode','Best Solo Mode',21,NULL,'entries','reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/2026-solomode-contest','2026-09-05',NULL),
 (11,21,'published_game_placements','Published game placements',63,NULL,'placements','counted_from_official_results',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05','Include tre giochi ex aequo all''ottavo posto in Best Name.'),
 (11,21,'main_poll_votes','Main voting poll',40,NULL,'votes','reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL),
 (11,21,'main_poll_voters','Main voting poll voters',17,NULL,'voters','reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL),
 (11,21,'average_modes_per_voter','Average solo modes voted per voter',2.35,NULL,'entries_per_voter','reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL),
 (11,21,'mvp_rank_1','Most Valuable Playtester #1',NULL,'John Barklam (@barklam)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL),
 (11,21,'mvp_rank_2','Most Valuable Playtester #2',NULL,'Karen Robinson (@KarenSDR)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL),
 (11,21,'mvp_rank_3','Most Valuable Playtester #3',NULL,'Tomasz Miernowski (@tomaszek)',NULL,'reported_by_organizer',1,'https://boardgamegeek.com/thread/3670686/article/47872399#47872399','2026-09-05',NULL);

DROP TABLE solomode_results;
DROP TABLE solomode_import;
COMMIT;
