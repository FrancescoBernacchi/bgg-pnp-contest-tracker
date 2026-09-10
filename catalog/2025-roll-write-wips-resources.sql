-- Ricognizione completa dei WIP e delle risorse dichiarate per Roll & Write 2025.
-- Verifica: 2026-09-10. Nessuna risorsa esterna aperta e nessun file scaricato.

PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

CREATE TEMP TABLE roll_write_2025_resource_scan (
    title TEXT PRIMARY KEY,
    wip_thread_url TEXT,
    resource_listing_status TEXT NOT NULL,
    notes TEXT NOT NULL
);

INSERT INTO roll_write_2025_resource_scan VALUES
('Ancient World','https://boardgamegeek.com/thread/3614076','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Compass & Ink',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Dawn Chorus',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Dicease Control: The 4.D-10 Pathogen','https://boardgamegeek.com/thread/3603070','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Doodle Bash!','https://boardgamegeek.com/thread/3606967','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Fortify!','https://boardgamegeek.com/thread/3615315','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Labyrinth of Shadows','https://boardgamegeek.com/thread/3584529','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Lithomacy','https://boardgamegeek.com/thread/3617600','not_observable','WIP BGG individuato con grafia Lithomachy nello slug; risorse non osservabili dalla fonte indicizzata.'),
('Mainframe: System Shutdown',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Master of Thievery',NULL,'not_checked','WIP dedicato non individuato su BGG nella ricognizione; riferimenti esterni non usati come fonte sostitutiva.'),
('Natura','https://boardgamegeek.com/thread/3621278','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('On-LINE Kasino','https://boardgamegeek.com/thread/3619168','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Rolling Fiefdoms','https://boardgamegeek.com/thread/3596654','observed','Il primo post indicizzato dichiara PnP Stash come versione corrente e link distinti a Rulebook, Print Sheet, Solo Challenges e Online Version; soltanto la destinazione PnP Stash è esposta integralmente.'),
('Rolling Parks','https://boardgamegeek.com/thread/3619248','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Spellwrights Codex','https://boardgamegeek.com/thread/3617539','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('Skyfall',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('The Leaning Tower of Pisa','https://boardgamegeek.com/thread/3613315','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('The Legend of Whispervale',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Thieves of Bandervon',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Vanguard Multi Asset Global Command',NULL,'not_checked','WIP dedicato non individuato nella ricognizione.'),
('Word Builders','https://boardgamegeek.com/thread/3620974','not_observable','Il primo post indicizzato dichiara Folder with Files e un video di playthrough, ma non espone integralmente le destinazioni.'),
('1899 - 1907 Black Death Brazil','https://boardgamegeek.com/thread/3600465','not_observable','WIP BGG individuato; le destinazioni dei collegamenti del primo post non sono esposte dalla fonte indicizzata consultabile.'),
('A Dragon''s Die',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('City Lights',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Fortune Script',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('INFRARED',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Necromancy: Roll Them Bones!','https://boardgamegeek.com/thread/3592805','not_observable','Entry ritirata; WIP BGG individuato, risorse non osservabili dalla fonte indicizzata.'),
('On the Trail of Bigfoot','https://boardgamegeek.com/thread/3592032','not_observable','Entry ritirata; WIP BGG individuato, risorse non osservabili dalla fonte indicizzata.'),
('PIXIX',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Ringleader',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Roll & Pose','https://boardgamegeek.com/thread/3620499','not_observable','Entry ritirata; WIP BGG individuato, risorse non osservabili dalla fonte indicizzata.'),
('The Thirteenth Dimension',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Scribe',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('STRATOS',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Wizard''s Tutelage',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('U2: Flights of the Dragon Lady',NULL,'not_checked','Entry ritirata; WIP dedicato non individuato nella ricognizione.'),
('Yadoya','https://boardgamegeek.com/thread/3618848','not_observable','Entry ritirata; WIP BGG individuato, risorse non osservabili dalla fonte indicizzata.');

UPDATE entries
SET wip_thread_url = (
    SELECT s.wip_thread_url
    FROM roll_write_2025_resource_scan s
    JOIN games g ON g.canonical_title = s.title
    WHERE g.id = entries.game_id
)
WHERE contest_id = 22
  AND EXISTS (
    SELECT 1 FROM roll_write_2025_resource_scan s
    JOIN games g ON g.canonical_title = s.title
    WHERE g.id = entries.game_id AND s.wip_thread_url IS NOT NULL
  );

INSERT INTO entry_resource_scans
    (entry_id,checked_at,source_url,wip_status,resource_listing_status,notes)
SELECT e.id,'2026-09-10',COALESCE(s.wip_thread_url,e.entry_url),
       CASE WHEN s.wip_thread_url IS NULL THEN 'not_found' ELSE 'found' END,
       s.resource_listing_status,s.notes
FROM roll_write_2025_resource_scan s
JOIN games g ON g.canonical_title=s.title
JOIN entries e ON e.game_id=g.id AND e.contest_id=22;

INSERT INTO remote_resources
    (game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at)
SELECT g.id,'combined_pnp','landing_page','https://pnpstash.com/product/rolling-fiefdoms/','pnpstash.com',
       'Rolling Fiefdoms on PnP Stash',NULL,'unknown','2026-09-10','2026-09-10'
FROM games g
JOIN entries e ON e.game_id=g.id AND e.contest_id=22
WHERE g.canonical_title='Rolling Fiefdoms';

INSERT INTO entry_resource_mentions
    (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at)
SELECT e.id,r.id,'https://boardgamegeek.com/thread/3596654','latest version on PnP Stash','combined_pnp',1,'2026-09-10','2026-09-10'
FROM entries e
JOIN games g ON g.id=e.game_id
JOIN remote_resources r ON r.game_id=g.id AND r.url='https://pnpstash.com/product/rolling-fiefdoms/'
WHERE e.contest_id=22 AND g.canonical_title='Rolling Fiefdoms';

INSERT INTO remote_resource_observations
    (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes)
SELECT r.id,'2026-09-10','https://boardgamegeek.com/thread/3596654','declared_in_wip','not_checked',NULL,
       'Il WIP dichiara questa pagina come sede della versione più recente; destinazione non aperta durante la ricognizione annuale.'
FROM remote_resources r
JOIN games g ON g.id=r.game_id
WHERE g.canonical_title='Rolling Fiefdoms' AND r.url='https://pnpstash.com/product/rolling-fiefdoms/';

DROP TABLE roll_write_2025_resource_scan;
COMMIT;
