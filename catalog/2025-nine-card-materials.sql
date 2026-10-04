PRAGMA foreign_keys=ON;
BEGIN;
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479228' WHERE id=393 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('393','2026-10-04','https://boardgamegeek.com/thread/3479228','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('393','2026-10-04','https://boardgamegeek.com/thread/3479228','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('393','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479228','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('393','rules','https://1drv.ms/w/c/4e3a50fc4a975050/EU3PjiuwHIJFiU1wMlX3JIoBbtMuaYZ2Jti5QpKWM-j83A?e=0zC0KM','1drv.ms','Final Game Rules v2.1 - 4/1/25','v2.1','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (393,(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EU3PjiuwHIJFiU1wMlX3JIoBbtMuaYZ2Jti5QpKWM-j83A?e=0zC0KM'),'https://boardgamegeek.com/thread/3479228','Final Game Rules v2.1 - 4/1/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=393 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EU3PjiuwHIJFiU1wMlX3JIoBbtMuaYZ2Jti5QpKWM-j83A?e=0zC0KM'),'2026-10-04','https://boardgamegeek.com/thread/3479228','declared_in_wip','not_checked','v2.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EU3PjiuwHIJFiU1wMlX3JIoBbtMuaYZ2Jti5QpKWM-j83A?e=0zC0KM') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479228' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('393','rules','https://docs.google.com/document/d/11PiUnm4Ik1XOOgdN0HxVuq2U2R3ysPcj/edit','docs.google.com','Old Game Rules v1.1 - 3/16/25','v1.1','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (393,(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://docs.google.com/document/d/11PiUnm4Ik1XOOgdN0HxVuq2U2R3ysPcj/edit'),'https://boardgamegeek.com/thread/3479228','Old Game Rules v1.1 - 3/16/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=393 AND url='https://docs.google.com/document/d/11PiUnm4Ik1XOOgdN0HxVuq2U2R3ysPcj/edit'),'2026-10-04','https://boardgamegeek.com/thread/3479228','declared_in_wip','not_checked','v1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://docs.google.com/document/d/11PiUnm4Ik1XOOgdN0HxVuq2U2R3ysPcj/edit') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479228' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('393','component','https://drive.google.com/file/d/1BoPScv1PC8p-EWMw7YEj7qn3F5gxguYb/view?usp=sharing','drive.google.com','Old Cards v1.1 - 3/30/25','v1.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (393,(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1BoPScv1PC8p-EWMw7YEj7qn3F5gxguYb/view?usp=sharing'),'https://boardgamegeek.com/thread/3479228','Old Cards v1.1 - 3/30/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1BoPScv1PC8p-EWMw7YEj7qn3F5gxguYb/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479228','declared_in_wip','not_checked','v1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1BoPScv1PC8p-EWMw7YEj7qn3F5gxguYb/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479228' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('393','component','https://drive.google.com/file/d/1IJyfr0KnA_bUTxrPVWTGxJsyssj5qHsJ/view?usp=sharing','drive.google.com','Final Cards v2.1 - 4/14/2025','v2.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (393,(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1IJyfr0KnA_bUTxrPVWTGxJsyssj5qHsJ/view?usp=sharing'),'https://boardgamegeek.com/thread/3479228','Final Cards v2.1 - 4/14/2025','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1IJyfr0KnA_bUTxrPVWTGxJsyssj5qHsJ/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479228','declared_in_wip','not_checked','v2.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=393 AND url='https://drive.google.com/file/d/1IJyfr0KnA_bUTxrPVWTGxJsyssj5qHsJ/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479228' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '393','randomizer','dadi: Dice (any color combination)','20 Dice (any color combination)','20','required','common','-20 Dice (any color combination)
-9 Cards (In the near FuTuRe)
-Pen or pencil','https://boardgamegeek.com/thread/3479228','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '393' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Dice (any color combination)' AND quantity_raw IS '20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479228');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '393','printable_component','carte: Cards (In the near FuTuRe)','9 Cards (In the near FuTuRe)','9','required','printable','-20 Dice (any color combination)
-9 Cards (In the near FuTuRe)
-Pen or pencil','https://boardgamegeek.com/thread/3479228','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '393' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards (In the near FuTuRe)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479228');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '393','writing_tool','strumento scrittura: Pen or pencil','Pen or pencil',NULL,'required','common','-20 Dice (any color combination)
-9 Cards (In the near FuTuRe)
-Pen or pencil','https://boardgamegeek.com/thread/3479228','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '393' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: Pen or pencil' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479228');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '393','rules','regolamento dichiarato nei link','Final Game Rules v2.1 - 4/1/25 | Old Game Rules v1.1 - 3/16/25',NULL,'unclear','printable','Final Game Rules v2.1 - 4/1/25 | Old Game Rules v1.1 - 3/16/25','https://boardgamegeek.com/thread/3479228','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '393' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479228');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477202' WHERE id=394 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('394','2026-10-04','https://boardgamegeek.com/thread/3477202','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('394','2026-10-04','https://boardgamegeek.com/thread/3477202','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('394','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477202','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('394','rules','https://drive.google.com/file/d/1EcNI6yE0JEuAPmjfj_2YObZUOaS9ks9Y/view?usp=sharing','drive.google.com','7 Pioneers- Rules (Last update: April 14, 2025)',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (394,(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1EcNI6yE0JEuAPmjfj_2YObZUOaS9ks9Y/view?usp=sharing'),'https://boardgamegeek.com/thread/3477202','7 Pioneers- Rules (Last update: April 14, 2025)','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1EcNI6yE0JEuAPmjfj_2YObZUOaS9ks9Y/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477202','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1EcNI6yE0JEuAPmjfj_2YObZUOaS9ks9Y/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477202' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('394','component','https://drive.google.com/file/d/1Kh5qszxeC8O_e07OamdZtSTcGunMFJca/view?usp=sharing','drive.google.com','7 Pioneers- CARDS Printable PDF',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (394,(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1Kh5qszxeC8O_e07OamdZtSTcGunMFJca/view?usp=sharing'),'https://boardgamegeek.com/thread/3477202','7 Pioneers- CARDS Printable PDF','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1Kh5qszxeC8O_e07OamdZtSTcGunMFJca/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477202','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://drive.google.com/file/d/1Kh5qszxeC8O_e07OamdZtSTcGunMFJca/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477202' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('394','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3449600870','steamcommunity.com','https://steamcommunity.com/sharedfiles/filedetails/?id=34496...',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (394,(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3449600870'),'https://boardgamegeek.com/thread/3477202','https://steamcommunity.com/sharedfiles/filedetails/?id=34496...','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=394 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3449600870'),'2026-10-04','https://boardgamegeek.com/thread/3477202','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=394 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3449600870') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477202' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '394','printable_component','carte: cards','9 cards','9','required','printable','9 cards
RULES
14 pioneer tokens; 7 per player in 2 colours
4 small stones
2 D6 dice','https://boardgamegeek.com/thread/3477202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '394' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '394','rules','regolamento: RULES','RULES',NULL,'required','printable','9 cards
RULES
14 pioneer tokens; 7 per player in 2 colours
4 small stones
2 D6 dice','https://boardgamegeek.com/thread/3477202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '394' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '394','token_marker','segnalini: pioneer tokens; 7 per player in 2 colours','14 pioneer tokens; 7 per player in 2 colours','14','required','common','9 cards
RULES
14 pioneer tokens; 7 per player in 2 colours
4 small stones
2 D6 dice','https://boardgamegeek.com/thread/3477202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '394' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: pioneer tokens; 7 per player in 2 colours' AND quantity_raw IS '14' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '394','token_marker','segnalini: small stones','4 small stones','4','required','common','9 cards
RULES
14 pioneer tokens; 7 per player in 2 colours
4 small stones
2 D6 dice','https://boardgamegeek.com/thread/3477202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '394' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: small stones' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '394','randomizer','dadi: D6 dice','2 D6 dice','2','required','common','9 cards
RULES
14 pioneer tokens; 7 per player in 2 colours
4 small stones
2 D6 dice','https://boardgamegeek.com/thread/3477202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '394' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: D6 dice' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477202');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3446532' WHERE id=395 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('395','2026-10-04','https://boardgamegeek.com/thread/3446532','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('395','2026-10-04','https://boardgamegeek.com/thread/3446532','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('395','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3446532','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('395','rules','https://www.dropbox.com/scl/fi/enxgc1vnobc9y2m6dvotu/9-Days-of-Kyiv-1.0.pdf?rlkey=6hufwdjyw2wf8o9x6mq7olbb2&st=mrh4gv32&dl=0','www.dropbox.com','English Rules 1.0',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (395,(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/enxgc1vnobc9y2m6dvotu/9-Days-of-Kyiv-1.0.pdf?rlkey=6hufwdjyw2wf8o9x6mq7olbb2&st=mrh4gv32&dl=0'),'https://boardgamegeek.com/thread/3446532','English Rules 1.0','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/enxgc1vnobc9y2m6dvotu/9-Days-of-Kyiv-1.0.pdf?rlkey=6hufwdjyw2wf8o9x6mq7olbb2&st=mrh4gv32&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3446532','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/enxgc1vnobc9y2m6dvotu/9-Days-of-Kyiv-1.0.pdf?rlkey=6hufwdjyw2wf8o9x6mq7olbb2&st=mrh4gv32&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446532' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('395','rules','https://www.dropbox.com/scl/fi/gdpj1z282qjzdthxzhi1b/9-Tage-von-Kiew-1.0.pdf?rlkey=t7h21t9ppeokzn8s1u4agswt0&st=m321jxym&dl=0','www.dropbox.com','German Rules 1.0',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (395,(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gdpj1z282qjzdthxzhi1b/9-Tage-von-Kiew-1.0.pdf?rlkey=t7h21t9ppeokzn8s1u4agswt0&st=m321jxym&dl=0'),'https://boardgamegeek.com/thread/3446532','German Rules 1.0','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gdpj1z282qjzdthxzhi1b/9-Tage-von-Kiew-1.0.pdf?rlkey=t7h21t9ppeokzn8s1u4agswt0&st=m321jxym&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3446532','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gdpj1z282qjzdthxzhi1b/9-Tage-von-Kiew-1.0.pdf?rlkey=t7h21t9ppeokzn8s1u4agswt0&st=m321jxym&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446532' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('395','component','https://www.dropbox.com/scl/fi/gtkysx1mtulxc8bwjj8bk/9-Days-Cards-1.0.pdf?rlkey=bh6b4ubj7kpn6lky52qdzqfts&st=t43hddrs&dl=0','www.dropbox.com','Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (395,(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gtkysx1mtulxc8bwjj8bk/9-Days-Cards-1.0.pdf?rlkey=bh6b4ubj7kpn6lky52qdzqfts&st=t43hddrs&dl=0'),'https://boardgamegeek.com/thread/3446532','Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gtkysx1mtulxc8bwjj8bk/9-Days-Cards-1.0.pdf?rlkey=bh6b4ubj7kpn6lky52qdzqfts&st=t43hddrs&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3446532','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fi/gtkysx1mtulxc8bwjj8bk/9-Days-Cards-1.0.pdf?rlkey=bh6b4ubj7kpn6lky52qdzqfts&st=t43hddrs&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446532' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('395','game_files','https://www.dropbox.com/scl/fo/e6u52g973ykhrdlhcvkxo/AHuOlT1Ow57-JgnsMxDfUKI?rlkey=j509khantg55xrpcj7aqw729g&st=18m38y8r&dl=0','www.dropbox.com','The whole folder',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (395,(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fo/e6u52g973ykhrdlhcvkxo/AHuOlT1Ow57-JgnsMxDfUKI?rlkey=j509khantg55xrpcj7aqw729g&st=18m38y8r&dl=0'),'https://boardgamegeek.com/thread/3446532','The whole folder','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fo/e6u52g973ykhrdlhcvkxo/AHuOlT1Ow57-JgnsMxDfUKI?rlkey=j509khantg55xrpcj7aqw729g&st=18m38y8r&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3446532','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=395 AND url='https://www.dropbox.com/scl/fo/e6u52g973ykhrdlhcvkxo/AHuOlT1Ow57-JgnsMxDfUKI?rlkey=j509khantg55xrpcj7aqw729g&st=18m38y8r&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446532' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '395','printable_component','carte: cards] - on [1] A4 letter size double sided PDF sheet','[9 cards] - on [1] A4 letter size double sided PDF sheet','9','required','printable','[9 cards] - on [1] A4 letter size double sided PDF sheet
[1] - RULES - 6 Pages A4 Letter size double-sided PDF
[16] - game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blue cubes, 2 red coins ...]
[1] - pencil or non-permanent marker (optional)','https://boardgamegeek.com/thread/3446532','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '395' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] A4 letter size double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446532');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '395','rules','regolamento: RULES - 6 Pages A4 Letter size double-sided PDF','[1] - RULES - 6 Pages A4 Letter size double-sided PDF','1','required','printable','[9 cards] - on [1] A4 letter size double sided PDF sheet
[1] - RULES - 6 Pages A4 Letter size double-sided PDF
[16] - game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blue cubes, 2 red coins ...]
[1] - pencil or non-permanent marker (optional)','https://boardgamegeek.com/thread/3446532','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '395' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 6 Pages A4 Letter size double-sided PDF' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446532');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '395','token_marker','segnalini: game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blu','[16] - game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blue cubes, 2 red coins ...]','16','required','common','[9 cards] - on [1] A4 letter size double sided PDF sheet
[1] - RULES - 6 Pages A4 Letter size double-sided PDF
[16] - game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blue cubes, 2 red coins ...]
[1] - pencil or non-permanent marker (optional)','https://boardgamegeek.com/thread/3446532','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '395' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blu' AND quantity_raw IS '16' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446532');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '395','writing_tool','strumento scrittura: pencil or non-permanent marker (optional)','[1] - pencil or non-permanent marker (optional)','1','optional','common','[9 cards] - on [1] A4 letter size double sided PDF sheet
[1] - RULES - 6 Pages A4 Letter size double-sided PDF
[16] - game token pairs of different shape, 4 pairs in blue and 4 pairs in red - [e.g. 2 red meeples, 2 blue cubes, 2 red coins ...]
[1] - pencil or non-permanent marker (optional)','https://boardgamegeek.com/thread/3446532','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '395' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: pencil or non-permanent marker (optional)' AND quantity_raw IS '1' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3446532');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3454676' WHERE id=396 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('396','2026-10-04','https://boardgamegeek.com/thread/3454676','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('396','2026-10-04','https://boardgamegeek.com/thread/3454676','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('396','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3454676','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','rules','https://docs.google.com/document/d/1PdFHrttoqVY1SZPAfBGZi0KKZ7nDWX1UiddzpRGiSXk/edit?usp=drive_link','docs.google.com','Rules contest version',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1PdFHrttoqVY1SZPAfBGZi0KKZ7nDWX1UiddzpRGiSXk/edit?usp=drive_link'),'https://boardgamegeek.com/thread/3454676','Rules contest version','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1PdFHrttoqVY1SZPAfBGZi0KKZ7nDWX1UiddzpRGiSXk/edit?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1PdFHrttoqVY1SZPAfBGZi0KKZ7nDWX1UiddzpRGiSXk/edit?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','rules','https://docs.google.com/document/d/1tykZBVIVCy5IIBafx956VPudIIfA0_hXJZHXfQd50Rw/edit?usp=drive_link','docs.google.com','Rules 3.0',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1tykZBVIVCy5IIBafx956VPudIIfA0_hXJZHXfQd50Rw/edit?usp=drive_link'),'https://boardgamegeek.com/thread/3454676','Rules 3.0','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1tykZBVIVCy5IIBafx956VPudIIfA0_hXJZHXfQd50Rw/edit?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://docs.google.com/document/d/1tykZBVIVCy5IIBafx956VPudIIfA0_hXJZHXfQd50Rw/edit?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','game_files','https://drive.google.com/drive/folders/1kg0jUgD8QszQC6w3FFNEaVQKEyWQmLxC','drive.google.com','All files',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/drive/folders/1kg0jUgD8QszQC6w3FFNEaVQKEyWQmLxC'),'https://boardgamegeek.com/thread/3454676','All files','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/drive/folders/1kg0jUgD8QszQC6w3FFNEaVQKEyWQmLxC'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/drive/folders/1kg0jUgD8QszQC6w3FFNEaVQKEyWQmLxC') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','component','https://drive.google.com/file/d/10A1MCg0QHFFh2YKGtbMwXSz-YDU8fHxH/view?usp=drive_link','drive.google.com','Box',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/10A1MCg0QHFFh2YKGtbMwXSz-YDU8fHxH/view?usp=drive_link'),'https://boardgamegeek.com/thread/3454676','Box','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/10A1MCg0QHFFh2YKGtbMwXSz-YDU8fHxH/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/10A1MCg0QHFFh2YKGtbMwXSz-YDU8fHxH/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','component','https://drive.google.com/file/d/1EZB8Ewr8JvdeFFLUMXphU03m__pc1OlM/view?usp=drive_link','drive.google.com','PnP files cards 4.0',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1EZB8Ewr8JvdeFFLUMXphU03m__pc1OlM/view?usp=drive_link'),'https://boardgamegeek.com/thread/3454676','PnP files cards 4.0','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1EZB8Ewr8JvdeFFLUMXphU03m__pc1OlM/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1EZB8Ewr8JvdeFFLUMXphU03m__pc1OlM/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','component','https://drive.google.com/file/d/1NN_PoTJw9DE9FUqcy1bkcQlwGcON83Or/view?usp=drive_link','drive.google.com','contest version cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1NN_PoTJw9DE9FUqcy1bkcQlwGcON83Or/view?usp=drive_link'),'https://boardgamegeek.com/thread/3454676','contest version cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1NN_PoTJw9DE9FUqcy1bkcQlwGcON83Or/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://drive.google.com/file/d/1NN_PoTJw9DE9FUqcy1bkcQlwGcON83Or/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3454941481','steamcommunity.com','TTS mode',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3454941481'),'https://boardgamegeek.com/thread/3454676','TTS mode','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3454941481'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3454941481') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('396','video','https://youtube.com/watch?v=d9zFiDZGdyM','youtube.com','Огляд гри для контесту 9 карт. 9RIP - дуельна гра про мафію',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (396,(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://youtube.com/watch?v=d9zFiDZGdyM'),'https://boardgamegeek.com/thread/3454676','Огляд гри для контесту 9 карт. 9RIP - дуельна гра про мафію','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=396 AND url='https://youtube.com/watch?v=d9zFiDZGdyM'),'2026-10-04','https://boardgamegeek.com/thread/3454676','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=396 AND url='https://youtube.com/watch?v=d9zFiDZGdyM') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3454676' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '396','printable_component','carte: location cards (numbered from 1 to 9), each with a unique action.','9 location cards (numbered from 1 to 9), each with a unique action.','9','required','printable','9 location cards (numbered from 1 to 9), each with a unique action.
18 control cubes (9 for each player, colors: red and blue).
1 blocking cube.
3 dice: two player dices and one neutral die (blocking).','https://boardgamegeek.com/thread/3454676','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '396' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: location cards (numbered from 1 to 9), each with a unique action.' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3454676');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '396','token_marker','segnalini: control cubes (9 for each player, colors: red and blue).','18 control cubes (9 for each player, colors: red and blue).','18','required','common','9 location cards (numbered from 1 to 9), each with a unique action.
18 control cubes (9 for each player, colors: red and blue).
1 blocking cube.
3 dice: two player dices and one neutral die (blocking).','https://boardgamegeek.com/thread/3454676','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '396' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: control cubes (9 for each player, colors: red and blue).' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3454676');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '396','token_marker','segnalini: blocking cube.','1 blocking cube.','1','required','common','9 location cards (numbered from 1 to 9), each with a unique action.
18 control cubes (9 for each player, colors: red and blue).
1 blocking cube.
3 dice: two player dices and one neutral die (blocking).','https://boardgamegeek.com/thread/3454676','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '396' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: blocking cube.' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3454676');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '396','randomizer','dadi: dice: two player dices and one neutral die (blocking).','3 dice: two player dices and one neutral die (blocking).','3','required','common','9 location cards (numbered from 1 to 9), each with a unique action.
18 control cubes (9 for each player, colors: red and blue).
1 blocking cube.
3 dice: two player dices and one neutral die (blocking).','https://boardgamegeek.com/thread/3454676','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '396' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice: two player dices and one neutral die (blocking).' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3454676');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '396','rules','regolamento dichiarato nei link','Rules contest version | Rules 3.0',NULL,'unclear','printable','Rules contest version | Rules 3.0','https://boardgamegeek.com/thread/3454676','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '396' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3454676');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3438996' WHERE id=397 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('397','2026-10-04','https://boardgamegeek.com/thread/3438996','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('397','2026-10-04','https://boardgamegeek.com/thread/3438996','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('397','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3438996','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('397','game_files','https://drive.proton.me/urls/KV13MGKK0G#ZYoOvKPHSGes','drive.proton.me','Download link',NULL,'unknown','2026-10-04','2026-10-04','download_page');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (397,(SELECT id FROM remote_resources WHERE game_id=397 AND url='https://drive.proton.me/urls/KV13MGKK0G#ZYoOvKPHSGes'),'https://boardgamegeek.com/thread/3438996','Download link','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=397 AND url='https://drive.proton.me/urls/KV13MGKK0G#ZYoOvKPHSGes'),'2026-10-04','https://boardgamegeek.com/thread/3438996','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=397 AND url='https://drive.proton.me/urls/KV13MGKK0G#ZYoOvKPHSGes') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3438996' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('397','online_play','https://screentop.gg/@kaqukal/9thMaze','screentop.gg','screentop.gg',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (397,(SELECT id FROM remote_resources WHERE game_id=397 AND url='https://screentop.gg/@kaqukal/9thMaze'),'https://boardgamegeek.com/thread/3438996','screentop.gg','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=397 AND url='https://screentop.gg/@kaqukal/9thMaze'),'2026-10-04','https://boardgamegeek.com/thread/3438996','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=397 AND url='https://screentop.gg/@kaqukal/9thMaze') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3438996' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '397','printable_component','carte: double-sided cards','9 double-sided cards','9','required','printable','9 double-sided cards','https://boardgamegeek.com/thread/3438996','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '397' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3438996');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3469230' WHERE id=398 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('398','2026-10-04','https://boardgamegeek.com/thread/3469230','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('398','2026-10-04','https://boardgamegeek.com/thread/3469230','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('398','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3469230','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('398','game_files','https://drive.google.com/drive/folders/1WpLzt-5Zx6uIb-sSjwi0G7db1ak6ubxP?usp=drive_link','drive.google.com','Google Drive Link',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (398,(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/drive/folders/1WpLzt-5Zx6uIb-sSjwi0G7db1ak6ubxP?usp=drive_link'),'https://boardgamegeek.com/thread/3469230','Google Drive Link','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/drive/folders/1WpLzt-5Zx6uIb-sSjwi0G7db1ak6ubxP?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3469230','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/drive/folders/1WpLzt-5Zx6uIb-sSjwi0G7db1ak6ubxP?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469230' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('398','rules','https://drive.google.com/file/d/19wevJkh1XEyphqRxoHuekp5goRoix_G4/view?usp=sharing','drive.google.com','Rules (v1.0)','v1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (398,(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/19wevJkh1XEyphqRxoHuekp5goRoix_G4/view?usp=sharing'),'https://boardgamegeek.com/thread/3469230','Rules (v1.0)','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/19wevJkh1XEyphqRxoHuekp5goRoix_G4/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3469230','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/19wevJkh1XEyphqRxoHuekp5goRoix_G4/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469230' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('398','component','https://drive.google.com/file/d/1Ok6rCjHoQR_FOZkIpvwfF-W2UMM2F7g1/view?usp=drive_link','drive.google.com','Playingcards.io export file (v0.3) ','v0.3','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (398,(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1Ok6rCjHoQR_FOZkIpvwfF-W2UMM2F7g1/view?usp=drive_link'),'https://boardgamegeek.com/thread/3469230','Playingcards.io export file (v0.3) ','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1Ok6rCjHoQR_FOZkIpvwfF-W2UMM2F7g1/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3469230','declared_in_wip','not_checked','v0.3','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1Ok6rCjHoQR_FOZkIpvwfF-W2UMM2F7g1/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469230' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('398','component','https://drive.google.com/file/d/1k4vJDO8fMMGd5E9XoSjao2eOZ9qlqHcg/view?usp=drive_link','drive.google.com','Component (v1.0)','v1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (398,(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1k4vJDO8fMMGd5E9XoSjao2eOZ9qlqHcg/view?usp=drive_link'),'https://boardgamegeek.com/thread/3469230','Component (v1.0)','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1k4vJDO8fMMGd5E9XoSjao2eOZ9qlqHcg/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3469230','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://drive.google.com/file/d/1k4vJDO8fMMGd5E9XoSjao2eOZ9qlqHcg/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469230' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('398','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3441679491','steamcommunity.com','Tabletop Simulator mod',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (398,(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3441679491'),'https://boardgamegeek.com/thread/3469230','Tabletop Simulator mod','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=398 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3441679491'),'2026-10-04','https://boardgamegeek.com/thread/3469230','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=398 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3441679491') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469230' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '398','printable_component','carte: Intel cards','7 - Intel cards','7','required','printable','7 - Intel cards
2 - Role and Reference cards
1 - Rulebook','https://boardgamegeek.com/thread/3469230','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '398' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Intel cards' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469230');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '398','printable_component','carte: Role and Reference cards','2 - Role and Reference cards','2','required','printable','7 - Intel cards
2 - Role and Reference cards
1 - Rulebook','https://boardgamegeek.com/thread/3469230','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '398' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Role and Reference cards' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469230');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '398','rules','regolamento: Rulebook','1 - Rulebook','1','required','printable','7 - Intel cards
2 - Role and Reference cards
1 - Rulebook','https://boardgamegeek.com/thread/3469230','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '398' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469230');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3449122' WHERE id=399 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('399','2026-10-04','https://boardgamegeek.com/thread/3449122','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('399','2026-10-04','https://boardgamegeek.com/thread/3449122','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('399','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3449122','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('399','component','https://drive.google.com/file/d/16EmZIXhtaAbFD9vhud06VoXh_pnL4jZ8/view?usp=sharing','drive.google.com','v1.4 03/22/25','v1.4','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (399,(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/16EmZIXhtaAbFD9vhud06VoXh_pnL4jZ8/view?usp=sharing'),'https://boardgamegeek.com/thread/3449122','v1.4 03/22/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/16EmZIXhtaAbFD9vhud06VoXh_pnL4jZ8/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449122','declared_in_wip','not_checked','v1.4','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/16EmZIXhtaAbFD9vhud06VoXh_pnL4jZ8/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449122' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('399','rules','https://drive.google.com/file/d/1MwLReMQeHcbBB489uzsVKqCnLa7NugBT/view?usp=sharing','drive.google.com','v1.4 03/29/25','v1.4','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (399,(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1MwLReMQeHcbBB489uzsVKqCnLa7NugBT/view?usp=sharing'),'https://boardgamegeek.com/thread/3449122','v1.4 03/29/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1MwLReMQeHcbBB489uzsVKqCnLa7NugBT/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449122','declared_in_wip','not_checked','v1.4','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1MwLReMQeHcbBB489uzsVKqCnLa7NugBT/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449122' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('399','component','https://drive.google.com/file/d/1_G2Od-zRrjYbS5Ut1BBXWJis7AvXmVaD/view?usp=drive_link','drive.google.com','v1.4 03/22/25','v1.4','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (399,(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1_G2Od-zRrjYbS5Ut1BBXWJis7AvXmVaD/view?usp=drive_link'),'https://boardgamegeek.com/thread/3449122','v1.4 03/22/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1_G2Od-zRrjYbS5Ut1BBXWJis7AvXmVaD/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3449122','declared_in_wip','not_checked','v1.4','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://drive.google.com/file/d/1_G2Od-zRrjYbS5Ut1BBXWJis7AvXmVaD/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449122' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('399','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3418530474','steamcommunity.com','Full Art Version with updated rulebook, v1.4 - 03/29/2025','v1.4','unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (399,(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3418530474'),'https://boardgamegeek.com/thread/3449122','Full Art Version with updated rulebook, v1.4 - 03/29/2025','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=399 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3418530474'),'2026-10-04','https://boardgamegeek.com/thread/3449122','declared_in_wip','not_checked','v1.4','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=399 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3418530474') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449122' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '399','printable_component','carte: single-sided cards','9 single-sided cards','9','required','printable','9 single-sided cards
20 d6 dice (four each of five different colors - specific amount and combinations vary by player count)
Rules (4 pp.)','https://boardgamegeek.com/thread/3449122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '399' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: single-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449122');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '399','randomizer','dadi: d6 dice (four each of five different colors - specific amount and combinations vary by player count)','20 d6 dice (four each of five different colors - specific amount and combinations vary by player count)','20','required','common','9 single-sided cards
20 d6 dice (four each of five different colors - specific amount and combinations vary by player count)
Rules (4 pp.)','https://boardgamegeek.com/thread/3449122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '399' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice (four each of five different colors - specific amount and combinations vary by player count)' AND quantity_raw IS '20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449122');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '399','rules','regolamento: Rules (4 pp.)','Rules (4 pp.)',NULL,'required','printable','9 single-sided cards
20 d6 dice (four each of five different colors - specific amount and combinations vary by player count)
Rules (4 pp.)','https://boardgamegeek.com/thread/3449122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '399' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules (4 pp.)' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449122');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3441992' WHERE id=400 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('400','2026-10-04','https://boardgamegeek.com/thread/3441992','found','TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('400','2026-10-04','https://boardgamegeek.com/thread/3441992','found','TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('400','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3441992','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('400','game_files','https://drive.google.com/file/d/13LpoD9hlsRG2gK0xoQg6iep9pF7BnCoP/view?usp=sharing','drive.google.com','Download link',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (400,(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/13LpoD9hlsRG2gK0xoQg6iep9pF7BnCoP/view?usp=sharing'),'https://boardgamegeek.com/thread/3441992','Download link','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/13LpoD9hlsRG2gK0xoQg6iep9pF7BnCoP/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3441992','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/13LpoD9hlsRG2gK0xoQg6iep9pF7BnCoP/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441992' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('400','rules','https://drive.google.com/file/d/1_9neaPWNsLPA3SmFiG4PoHdXlU_AnfSM/view?usp=sharing','drive.google.com','Rules Layout',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (400,(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1_9neaPWNsLPA3SmFiG4PoHdXlU_AnfSM/view?usp=sharing'),'https://boardgamegeek.com/thread/3441992','Rules Layout','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1_9neaPWNsLPA3SmFiG4PoHdXlU_AnfSM/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3441992','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1_9neaPWNsLPA3SmFiG4PoHdXlU_AnfSM/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441992' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('400','rules','https://drive.google.com/file/d/1c_jfdV2QYFjEq_EHmkixoyY_rKSa0HQx/view?usp=sharing','drive.google.com','Rules 2.0',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (400,(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1c_jfdV2QYFjEq_EHmkixoyY_rKSa0HQx/view?usp=sharing'),'https://boardgamegeek.com/thread/3441992','Rules 2.0','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1c_jfdV2QYFjEq_EHmkixoyY_rKSa0HQx/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3441992','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1c_jfdV2QYFjEq_EHmkixoyY_rKSa0HQx/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441992' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('400','game_files','https://drive.google.com/file/d/1j73qBmUFXoqWP0uuGu5Ji7IMvIm5JgIR/view?usp=sharing','drive.google.com','Low Ink Version',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (400,(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1j73qBmUFXoqWP0uuGu5Ji7IMvIm5JgIR/view?usp=sharing'),'https://boardgamegeek.com/thread/3441992','Low Ink Version','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1j73qBmUFXoqWP0uuGu5Ji7IMvIm5JgIR/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3441992','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://drive.google.com/file/d/1j73qBmUFXoqWP0uuGu5Ji7IMvIm5JgIR/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441992' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('400','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3411480175','steamcommunity.com','Table Top Simulator',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (400,(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3411480175'),'https://boardgamegeek.com/thread/3441992','Table Top Simulator','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=400 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3411480175'),'2026-10-04','https://boardgamegeek.com/thread/3441992','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Non richiesti i due colori dei dadi; i 12 dadi restano richiesti. Dischi solo nello scenario opzionale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=400 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3411480175') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441992' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','printable_component','carte: cards] - on US letter size Double sided PDF sheet','[9 cards] - on US letter size Double sided PDF sheet','9','required','printable','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on US letter size Double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','rules','regolamento: Rules','[1] - Rules','1','required','printable','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','randomizer','dadi: d6 dice (6 for each player, can be two different colors – not required)','[12] - d6 dice (6 for each player, can be two different colors – not required)','12','required','common','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice (6 for each player, can be two different colors – not required)' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','token_marker','segnalini: bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube','[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube','4','required','common','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','token_marker','segnalini: – small wooden cubes - 2 x 2 colors – for victory point and action tracking','[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking','4','required','common','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: – small wooden cubes - 2 x 2 colors – for victory point and action tracking' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '400','token_marker','segnalini: disks or small coins – to locate pits and portal, (optional scenario)','[2] - disks or small coins – to locate pits and portal, (optional scenario)','2','optional','common','[9 cards] - on US letter size Double sided PDF sheet
[1] - Rules
[12] - d6 dice (6 for each player, can be two different colors – not required)
[4] - bug meepeles - 2 x 2 colors, can be any meeple token or medium wooden cube
[4] – small wooden cubes - 2 x 2 colors – for victory point and action tracking
[2] - disks or small coins – to locate pits and portal, (optional scenario)
22 components total','https://boardgamegeek.com/thread/3441992','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '400' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: disks or small coins – to locate pits and portal, (optional scenario)' AND quantity_raw IS '2' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3441992');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3450478' WHERE id=401 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('401','2026-10-04','https://boardgamegeek.com/thread/3450478','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('401','2026-10-04','https://boardgamegeek.com/thread/3450478','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('401','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3450478','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('401','component','https://drive.google.com/file/d/1GYFMMknfGr9yzRpjQKEhuwLhJflG9aML/view?usp=drive_link','drive.google.com','Bullet Run Double Sided 9-Card Sheet',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (401,(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1GYFMMknfGr9yzRpjQKEhuwLhJflG9aML/view?usp=drive_link'),'https://boardgamegeek.com/thread/3450478','Bullet Run Double Sided 9-Card Sheet','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1GYFMMknfGr9yzRpjQKEhuwLhJflG9aML/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3450478','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1GYFMMknfGr9yzRpjQKEhuwLhJflG9aML/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3450478' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('401','rules','https://drive.google.com/file/d/1U_AwzqstYtyJBDBRnkrCosWbUjqiuNs4/view?usp=drive_link','drive.google.com','Bullet Run Rules',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (401,(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1U_AwzqstYtyJBDBRnkrCosWbUjqiuNs4/view?usp=drive_link'),'https://boardgamegeek.com/thread/3450478','Bullet Run Rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1U_AwzqstYtyJBDBRnkrCosWbUjqiuNs4/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3450478','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1U_AwzqstYtyJBDBRnkrCosWbUjqiuNs4/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3450478' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('401','game_files','https://drive.google.com/file/d/1_N8WEsbP-bi_QVvSPy1I14GxmuvX78O-/view?usp=drive_link','drive.google.com','Bullet Run Low Ink Printout',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (401,(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1_N8WEsbP-bi_QVvSPy1I14GxmuvX78O-/view?usp=drive_link'),'https://boardgamegeek.com/thread/3450478','Bullet Run Low Ink Printout','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1_N8WEsbP-bi_QVvSPy1I14GxmuvX78O-/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3450478','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=401 AND url='https://drive.google.com/file/d/1_N8WEsbP-bi_QVvSPy1I14GxmuvX78O-/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3450478' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '401','printable_component','carte: Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.','9 Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.','9','required','printable','9 Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.
5 d6 dice: One should be a different color, preferably red
15 cubes: (or beans, or beads)
•9 red Hit tokens
•3 blue Miss tokens
•1 Damage token
•1 Valor Star token
•1 Medal of Valor token','https://boardgamegeek.com/thread/3450478','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '401' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3450478');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '401','randomizer','dadi: d6 dice: One should be a different color, preferably red','5 d6 dice: One should be a different color, preferably red','5','required','common','9 Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.
5 d6 dice: One should be a different color, preferably red
15 cubes: (or beans, or beads)
•9 red Hit tokens
•3 blue Miss tokens
•1 Damage token
•1 Valor Star token
•1 Medal of Valor token','https://boardgamegeek.com/thread/3450478','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '401' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice: One should be a different color, preferably red' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3450478');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '401','token_marker','segnalini: cubes: (or beans, or beads)','15 cubes: (or beans, or beads)','15','required','common','9 Bullet Run PnP Double Sided Cards: 3 cockpit cards and 6 window cards.
5 d6 dice: One should be a different color, preferably red
15 cubes: (or beans, or beads)
•9 red Hit tokens
•3 blue Miss tokens
•1 Damage token
•1 Valor Star token
•1 Medal of Valor token','https://boardgamegeek.com/thread/3450478','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '401' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes: (or beans, or beads)' AND quantity_raw IS '15' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3450478');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '401','rules','regolamento dichiarato nei link','Bullet Run Rules',NULL,'unclear','printable','Bullet Run Rules','https://boardgamegeek.com/thread/3450478','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '401' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3450478');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3475937' WHERE id=402 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('402','2026-10-04','https://boardgamegeek.com/thread/3475937','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('402','2026-10-04','https://boardgamegeek.com/thread/3475937','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('402','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3475937','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('402','component','https://jestemzbychu.itch.io/calling-card-warriors','jestemzbychu.itch.io','GRAB THE PnP VERSION ON ITCH.IO',NULL,'unknown','2026-10-04','2026-10-04','download_page');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (402,(SELECT id FROM remote_resources WHERE game_id=402 AND url='https://jestemzbychu.itch.io/calling-card-warriors'),'https://boardgamegeek.com/thread/3475937','GRAB THE PnP VERSION ON ITCH.IO','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=402 AND url='https://jestemzbychu.itch.io/calling-card-warriors'),'2026-10-04','https://boardgamegeek.com/thread/3475937','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=402 AND url='https://jestemzbychu.itch.io/calling-card-warriors') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475937' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('402','online_play','https://tabletopia.com/games/calling-card-warriors-888t7h/play-now','tabletopia.com','TRY THE GAME OUT ON TABLETOPIA HERE!',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (402,(SELECT id FROM remote_resources WHERE game_id=402 AND url='https://tabletopia.com/games/calling-card-warriors-888t7h/play-now'),'https://boardgamegeek.com/thread/3475937','TRY THE GAME OUT ON TABLETOPIA HERE!','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=402 AND url='https://tabletopia.com/games/calling-card-warriors-888t7h/play-now'),'2026-10-04','https://boardgamegeek.com/thread/3475937','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=402 AND url='https://tabletopia.com/games/calling-card-warriors-888t7h/play-now') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475937' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '402','rules','regolamento: instruction','1 - instruction','1','required','printable','1 - instruction
9 - cards:
a) 3 - board/help cards
b) 5 - unit action cards
c) 1 - unit token card (15 components)','https://boardgamegeek.com/thread/3475937','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '402' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: instruction' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475937');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '402','printable_component','carte: cards:','9 - cards:','9','required','printable','1 - instruction
9 - cards:
a) 3 - board/help cards
b) 5 - unit action cards
c) 1 - unit token card (15 components)','https://boardgamegeek.com/thread/3475937','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '402' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards:' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475937');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '402','printable_component','unit token card, ritagliare 15 componenti dalla carta inclusa','1 - instruction
9 - cards:
a) 3 - board/help cards
b) 5 - unit action cards
c) 1 - unit token card (15 components)','15','required','printable','1 - instruction
9 - cards:
a) 3 - board/help cards
b) 5 - unit action cards
c) 1 - unit token card (15 components)','https://boardgamegeek.com/thread/3475937','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '402' AND material_kind IS 'printable_component' AND name_normalized IS 'unit token card, ritagliare 15 componenti dalla carta inclusa' AND quantity_raw IS '15' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475937');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3439500' WHERE id=403 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('403','2026-10-04','https://boardgamegeek.com/thread/3439500','found','TSK-0051; primo post originale soltanto; host non verificati. Meeple, tre dadi e 18 cubi soltanto nella campagna. Quantità del dado non specificata.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('403','2026-10-04','https://boardgamegeek.com/thread/3439500','found','TSK-0051; primo post originale soltanto; host non verificati. Meeple, tre dadi e 18 cubi soltanto nella campagna. Quantità del dado non specificata.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('403','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3439500','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Meeple, tre dadi e 18 cubi soltanto nella campagna. Quantità del dado non specificata.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('403','game_files','https://drive.google.com/drive/folders/1TB6idujyUqp32GEFPu_MeEawCyaM0k0Y?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (403,(SELECT id FROM remote_resources WHERE game_id=403 AND url='https://drive.google.com/drive/folders/1TB6idujyUqp32GEFPu_MeEawCyaM0k0Y?usp=sharing'),'https://boardgamegeek.com/thread/3439500','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=403 AND url='https://drive.google.com/drive/folders/1TB6idujyUqp32GEFPu_MeEawCyaM0k0Y?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3439500','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Meeple, tre dadi e 18 cubi soltanto nella campagna. Quantità del dado non specificata.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=403 AND url='https://drive.google.com/drive/folders/1TB6idujyUqp32GEFPu_MeEawCyaM0k0Y?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3439500' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','printable_component','carte: cards - on 1 Letter size Double sided PDF sheet','8 cards - on 1 Letter size Double sided PDF sheet','8','required','printable','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards - on 1 Letter size Double sided PDF sheet' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','rules','regolamento: RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a ','RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.',NULL,'required','printable','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a ' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','printable_component','carte: Half sized cards on the same card sheet','2 Half sized cards on the same card sheet','2','required','printable','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Half sized cards on the same card sheet' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','token_marker','segnalini: Dragon Meeple','1 Dragon Meeple','1','optional','common','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Dragon Meeple' AND quantity_raw IS '1' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','randomizer','dadi: dice - One of which is used if you are “marked for death.”','3 dice - One of which is used if you are “marked for death.”','3','optional','common','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice - One of which is used if you are “marked for death.”' AND quantity_raw IS '3' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '403','token_marker','segnalini: Cubes','18 Cubes','18','optional','common','8 cards - on 1 Letter size Double sided PDF sheet
RULES - 2 pages for the base game, 1 for the expansion, and one double sided reference sheet with a campaign mode.
2 Half sized cards on the same card sheet
If using the campaign mode only:
1 Dragon Meeple
3 dice - One of which is used if you are “marked for death.”
18 Cubes','https://boardgamegeek.com/thread/3439500','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '403' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Cubes' AND quantity_raw IS '18' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3439500');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3453315' WHERE id=404 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('404','2026-10-04','https://boardgamegeek.com/thread/3453315','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('404','2026-10-04','https://boardgamegeek.com/thread/3453315','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('404','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3453315','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('404','rules','https://docs.google.com/document/d/1dLZjKY_oEt3KM2Rpp8uovDH2eoGo-sc9NOY1r9EDf1w/edit?usp=sharing','docs.google.com','Rules 2.2 - English',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (404,(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://docs.google.com/document/d/1dLZjKY_oEt3KM2Rpp8uovDH2eoGo-sc9NOY1r9EDf1w/edit?usp=sharing'),'https://boardgamegeek.com/thread/3453315','Rules 2.2 - English','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=404 AND url='https://docs.google.com/document/d/1dLZjKY_oEt3KM2Rpp8uovDH2eoGo-sc9NOY1r9EDf1w/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3453315','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://docs.google.com/document/d/1dLZjKY_oEt3KM2Rpp8uovDH2eoGo-sc9NOY1r9EDf1w/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453315' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('404','game_files','https://drive.google.com/file/d/1zstpTFxlYnSfhcjoKQ7_rIjA842t_riM/view?usp=sharing','drive.google.com','Print and Play - Full Color',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (404,(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://drive.google.com/file/d/1zstpTFxlYnSfhcjoKQ7_rIjA842t_riM/view?usp=sharing'),'https://boardgamegeek.com/thread/3453315','Print and Play - Full Color','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=404 AND url='https://drive.google.com/file/d/1zstpTFxlYnSfhcjoKQ7_rIjA842t_riM/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3453315','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://drive.google.com/file/d/1zstpTFxlYnSfhcjoKQ7_rIjA842t_riM/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453315' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('404','online_play','https://tabletopia.com/games/dung-beetle-5zamsi/play-now','tabletopia.com','Dung beetle solo modes',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (404,(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://tabletopia.com/games/dung-beetle-5zamsi/play-now'),'https://boardgamegeek.com/thread/3453315','Dung beetle solo modes','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=404 AND url='https://tabletopia.com/games/dung-beetle-5zamsi/play-now'),'2026-10-04','https://boardgamegeek.com/thread/3453315','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=404 AND url='https://tabletopia.com/games/dung-beetle-5zamsi/play-now') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453315' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '404','printable_component','carte','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','9','required','printable','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','https://boardgamegeek.com/thread/3453315','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '404' AND material_kind IS 'printable_component' AND name_normalized IS 'carte' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453315');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '404','token_marker','dischi, uno per colore','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','2','required','common','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','https://boardgamegeek.com/thread/3453315','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '404' AND material_kind IS 'token_marker' AND name_normalized IS 'dischi, uno per colore' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453315');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '404','token_marker','cubi, dieci per colore','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','20','required','common','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','https://boardgamegeek.com/thread/3453315','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '404' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi, dieci per colore' AND quantity_raw IS '20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453315');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '404','randomizer','dado per solo module 2','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','1','optional','common','9 double sided cards (PnP ready!).
1 disc and 10 cubes of one color.
1 disc and 10 cubes of a different color.
1 die (for solo module 2)','https://boardgamegeek.com/thread/3453315','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '404' AND material_kind IS 'randomizer' AND name_normalized IS 'dado per solo module 2' AND quantity_raw IS '1' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3453315');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '404','rules','regolamento dichiarato nei link','Rules 2.2 - English',NULL,'unclear','printable','Rules 2.2 - English','https://boardgamegeek.com/thread/3453315','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '404' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3453315');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3449028' WHERE id=405 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('405','2026-10-04','https://boardgamegeek.com/thread/3449028','found','TSK-0051; primo post originale soltanto; host non verificati. Due menzioni dello stesso URL, accorpate senza perdere la molteplicità.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('405','2026-10-04','https://boardgamegeek.com/thread/3449028','found','TSK-0051; primo post originale soltanto; host non verificati. Due menzioni dello stesso URL, accorpate senza perdere la molteplicità.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('405','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3449028','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Due menzioni dello stesso URL, accorpate senza perdere la molteplicità.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('405','game_files','https://www.dropbox.com/scl/fo/xgq5ftc115dxlkde2mcyd/AOW3x4D2TVPFGs0ktX0JbMY?rlkey=jkndzymdfw27avqoqlegqfb4x&st=zuhm9qlt&dl=0','www.dropbox.com','here',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (405,(SELECT id FROM remote_resources WHERE game_id=405 AND url='https://www.dropbox.com/scl/fo/xgq5ftc115dxlkde2mcyd/AOW3x4D2TVPFGs0ktX0JbMY?rlkey=jkndzymdfw27avqoqlegqfb4x&st=zuhm9qlt&dl=0'),'https://boardgamegeek.com/thread/3449028','here | here','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=405 AND url='https://www.dropbox.com/scl/fo/xgq5ftc115dxlkde2mcyd/AOW3x4D2TVPFGs0ktX0JbMY?rlkey=jkndzymdfw27avqoqlegqfb4x&st=zuhm9qlt&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3449028','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Due menzioni dello stesso URL, accorpate senza perdere la molteplicità.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=405 AND url='https://www.dropbox.com/scl/fo/xgq5ftc115dxlkde2mcyd/AOW3x4D2TVPFGs0ktX0JbMY?rlkey=jkndzymdfw27avqoqlegqfb4x&st=zuhm9qlt&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449028' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '405','printable_component','carte: cards - A letter-size double-sided PDF sheet','[9] cards - A letter-size double-sided PDF sheet','9','required','printable',':
[9] cards - A letter-size double-sided PDF sheet
[6] - d6 dice
[18] - Wood cubes - [same color, preferably red]
[1] - RULES - 5 Pages Letter size','https://boardgamegeek.com/thread/3449028','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '405' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards - A letter-size double-sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449028');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '405','randomizer','dadi: d6 dice','[6] - d6 dice','6','required','common',':
[9] cards - A letter-size double-sided PDF sheet
[6] - d6 dice
[18] - Wood cubes - [same color, preferably red]
[1] - RULES - 5 Pages Letter size','https://boardgamegeek.com/thread/3449028','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '405' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449028');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '405','token_marker','segnalini: Wood cubes - [same color, preferably red]','[18] - Wood cubes - [same color, preferably red]','18','required','common',':
[9] cards - A letter-size double-sided PDF sheet
[6] - d6 dice
[18] - Wood cubes - [same color, preferably red]
[1] - RULES - 5 Pages Letter size','https://boardgamegeek.com/thread/3449028','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '405' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wood cubes - [same color, preferably red]' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449028');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '405','rules','regolamento: RULES - 5 Pages Letter size','[1] - RULES - 5 Pages Letter size','1','required','printable',':
[9] cards - A letter-size double-sided PDF sheet
[6] - d6 dice
[18] - Wood cubes - [same color, preferably red]
[1] - RULES - 5 Pages Letter size','https://boardgamegeek.com/thread/3449028','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '405' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 5 Pages Letter size' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449028');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3463372' WHERE id=406 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('406','2026-10-04','https://boardgamegeek.com/thread/3463372','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('406','2026-10-04','https://boardgamegeek.com/thread/3463372','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('406','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3463372','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('406','rules','https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNLoiptCyqVT_S_IwlxwvI/edit?usp=sharing','docs.google.com','https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNL...',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (406,(SELECT id FROM remote_resources WHERE game_id=406 AND url='https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNLoiptCyqVT_S_IwlxwvI/edit?usp=sharing'),'https://boardgamegeek.com/thread/3463372','https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNL...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=406 AND url='https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNLoiptCyqVT_S_IwlxwvI/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3463372','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=406 AND url='https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNLoiptCyqVT_S_IwlxwvI/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3463372' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('406','component','https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNRuCWmE/view?usp=sharing','drive.google.com','pnp available here | https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNR...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (406,(SELECT id FROM remote_resources WHERE game_id=406 AND url='https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNRuCWmE/view?usp=sharing'),'https://boardgamegeek.com/thread/3463372','pnp available here | https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNR...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=406 AND url='https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNRuCWmE/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3463372','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=406 AND url='https://drive.google.com/file/d/1tuD2dHvwlyo8Eks4nWhC5ekdKNRuCWmE/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3463372' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','printable_component','carte: cards (pnp available here)','9 cards (pnp available here)','9','required','printable','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards (pnp available here)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','randomizer','dadi: sided dice (any colour)','7 6-sided dice (any colour)','7','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: sided dice (any colour)' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','token_marker','segnalini: mm cubes (6 blue, 6 red)','12 8mm cubes (6 blue, 6 red)','12','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: mm cubes (6 blue, 6 red)' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','token_marker','segnalini: Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)','2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)','2','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','token_marker','segnalini: Barbarian meeple (any colour)','1 Barbarian meeple (any colour)','1','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Barbarian meeple (any colour)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','token_marker','segnalini: Debate token (meeple, cube, or similar - any colour)','1 Debate token (meeple, cube, or similar - any colour)','1','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Debate token (meeple, cube, or similar - any colour)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','token_marker','segnalini: Castle token (meeple, cube, or similar - any colour)','1 Castle token (meeple, cube, or similar - any colour)','1','required','common','- 9 cards (pnp available here)
- 7 6-sided dice (any colour)
- 12 8mm cubes (6 blue, 6 red)
- 2 Reputation tracker (meeple, cube, or similar - 1 red, 1 blue)
- 1 Barbarian meeple (any colour)
- 1 Debate token (meeple, cube, or similar - any colour)
- 1 Castle token (meeple, cube, or similar - any colour)','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Castle token (meeple, cube, or similar - any colour)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '406','rules','regolamento dichiarato nei link','https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNL...',NULL,'unclear','printable','https://docs.google.com/document/d/1GgrwJ8Hm__EALgu85Qz7zxNL...','https://boardgamegeek.com/thread/3463372','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '406' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3463372');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479370' WHERE id=407 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('407','2026-10-04','https://boardgamegeek.com/thread/3479370','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('407','2026-10-04','https://boardgamegeek.com/thread/3479370','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('407','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479370','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('407','game_files','https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQhpjZ7fF5CDVo?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQ...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (407,(SELECT id FROM remote_resources WHERE game_id=407 AND url='https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQhpjZ7fF5CDVo?usp=sharing'),'https://boardgamegeek.com/thread/3479370','https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQ...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=407 AND url='https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQhpjZ7fF5CDVo?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479370','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=407 AND url='https://drive.google.com/drive/folders/18WJbo0tSqi05bKvX6MnQhpjZ7fF5CDVo?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479370' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '407','randomizer','dadi: Dice (3 red, 3 green, 3 blue and 1 any color dice)','10 Dice (3 red, 3 green, 3 blue and 1 any color dice)','10','required','common','10 Dice (3 red, 3 green, 3 blue and 1 any color dice)
7 Tokens
9 Cards','https://boardgamegeek.com/thread/3479370','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '407' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Dice (3 red, 3 green, 3 blue and 1 any color dice)' AND quantity_raw IS '10' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479370');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '407','token_marker','segnalini: Tokens','7 Tokens','7','required','common','10 Dice (3 red, 3 green, 3 blue and 1 any color dice)
7 Tokens
9 Cards','https://boardgamegeek.com/thread/3479370','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '407' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Tokens' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479370');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '407','printable_component','carte: Cards','9 Cards','9','required','printable','10 Dice (3 red, 3 green, 3 blue and 1 any color dice)
7 Tokens
9 Cards','https://boardgamegeek.com/thread/3479370','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '407' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479370');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3449728' WHERE id=408 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('408','2026-10-04','https://boardgamegeek.com/thread/3449728','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('408','2026-10-04','https://boardgamegeek.com/thread/3449728','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('408','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3449728','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('408','component','https://drive.google.com/file/d/1L6eP9fUsuHpLlquY7z730BdthMFEwxVC/view','drive.google.com','FOR9E cards v 1.1','v 1.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (408,(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1L6eP9fUsuHpLlquY7z730BdthMFEwxVC/view'),'https://boardgamegeek.com/thread/3449728','FOR9E cards v 1.1','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1L6eP9fUsuHpLlquY7z730BdthMFEwxVC/view'),'2026-10-04','https://boardgamegeek.com/thread/3449728','declared_in_wip','not_checked','v 1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1L6eP9fUsuHpLlquY7z730BdthMFEwxVC/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449728' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('408','rules','https://drive.google.com/file/d/1rpAu8R7T5iszaBdT2Ty6J8Iw5CVC5l-x/view','drive.google.com','FOR9E rules v 1.1','v 1.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (408,(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1rpAu8R7T5iszaBdT2Ty6J8Iw5CVC5l-x/view'),'https://boardgamegeek.com/thread/3449728','FOR9E rules v 1.1','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1rpAu8R7T5iszaBdT2Ty6J8Iw5CVC5l-x/view'),'2026-10-04','https://boardgamegeek.com/thread/3449728','declared_in_wip','not_checked','v 1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://drive.google.com/file/d/1rpAu8R7T5iszaBdT2Ty6J8Iw5CVC5l-x/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449728' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('408','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3428245774','steamcommunity.com','FOR9E TTS Mod',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (408,(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3428245774'),'https://boardgamegeek.com/thread/3449728','FOR9E TTS Mod','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=408 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3428245774'),'2026-10-04','https://boardgamegeek.com/thread/3449728','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=408 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3428245774') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449728' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','printable_component','carte: cards','9 cards','9','required','printable','* 9 cards
* 2 meeples
* 15 simple ore dice (5 red, 5 yellow, 5 blue)
* 6 alloy dice (2 orange, 2 green, 2 purple)
* 1 advice token','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','token_marker','segnalini: meeples','2 meeples','2','required','common','* 9 cards
* 2 meeples
* 15 simple ore dice (5 red, 5 yellow, 5 blue)
* 6 alloy dice (2 orange, 2 green, 2 purple)
* 1 advice token','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: meeples' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','randomizer','dadi: simple ore dice (5 red, 5 yellow, 5 blue)','15 simple ore dice (5 red, 5 yellow, 5 blue)','15','required','common','* 9 cards
* 2 meeples
* 15 simple ore dice (5 red, 5 yellow, 5 blue)
* 6 alloy dice (2 orange, 2 green, 2 purple)
* 1 advice token','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: simple ore dice (5 red, 5 yellow, 5 blue)' AND quantity_raw IS '15' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','randomizer','dadi: alloy dice (2 orange, 2 green, 2 purple)','6 alloy dice (2 orange, 2 green, 2 purple)','6','required','common','* 9 cards
* 2 meeples
* 15 simple ore dice (5 red, 5 yellow, 5 blue)
* 6 alloy dice (2 orange, 2 green, 2 purple)
* 1 advice token','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: alloy dice (2 orange, 2 green, 2 purple)' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','token_marker','segnalini: advice token','1 advice token','1','required','common','* 9 cards
* 2 meeples
* 15 simple ore dice (5 red, 5 yellow, 5 blue)
* 6 alloy dice (2 orange, 2 green, 2 purple)
* 1 advice token','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: advice token' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '408','rules','regolamento dichiarato nei link','FOR9E rules v 1.1',NULL,'unclear','printable','FOR9E rules v 1.1','https://boardgamegeek.com/thread/3449728','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '408' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3449728');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477855' WHERE id=409 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('409','2026-10-04','https://boardgamegeek.com/thread/3477855','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('409','2026-10-04','https://boardgamegeek.com/thread/3477855','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('409','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477855','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('409','game_files','https://drive.google.com/drive/folders/12cmd_FFwIoY5vx26ntuOOZwMyUvtcEaQ?usp=drive_link','drive.google.com','Links',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (409,(SELECT id FROM remote_resources WHERE game_id=409 AND url='https://drive.google.com/drive/folders/12cmd_FFwIoY5vx26ntuOOZwMyUvtcEaQ?usp=drive_link'),'https://boardgamegeek.com/thread/3477855','Links','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=409 AND url='https://drive.google.com/drive/folders/12cmd_FFwIoY5vx26ntuOOZwMyUvtcEaQ?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477855','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=409 AND url='https://drive.google.com/drive/folders/12cmd_FFwIoY5vx26ntuOOZwMyUvtcEaQ?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477855' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','rules','regolamento: Rulebook','1 Rulebook','1','required','printable','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','printable_component','carte: Map Cards (forms the game board)','8 Map Cards (forms the game board)','8','required','printable','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Map Cards (forms the game board)' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','printable_component','carte: Turn Recording Card','1 Turn Recording Card','1','required','printable','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Turn Recording Card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','token_marker','segnalini: Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)','2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)','2 (2-player) / 4 (3-4 player)','required','common','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)' AND quantity_raw IS '2 (2-player) / 4 (3-4 player)' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','token_marker','segnalini: Turn Marker','1 Turn Marker','1','required','common','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Turn Marker' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','randomizer','dadi: Six-Sided Die (or more if preferred)','1 Six-Sided Die (or more if preferred)','1','required','common','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Six-Sided Die (or more if preferred)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '409','timer','timer: Timer (optional for 3-4 player mode)','Timer (optional for 3-4 player mode)',NULL,'optional','household','1 Rulebook
8 Map Cards (forms the game board)
1 Turn Recording Card
2 Player MEEPLES (for 2-player) / 4 Player MEEPLES (for 3-4 player modes)
1 Turn Marker
1 Six-Sided Die (or more if preferred)
Timer (optional for 3-4 player mode)','https://boardgamegeek.com/thread/3477855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '409' AND material_kind IS 'timer' AND name_normalized IS 'timer: Timer (optional for 3-4 player mode)' AND quantity_raw IS NULL AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3477855');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479222' WHERE id=410 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('410','2026-10-04','https://boardgamegeek.com/thread/3479222','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('410','2026-10-04','https://boardgamegeek.com/thread/3479222','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('410','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479222','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','rules','https://1drv.ms/w/c/4e3a50fc4a975050/EQin9nGlJGpFgRRPqehrBu4BxtcEX3P2aC43ERH3VzvfOQ?e=mvDr9f','1drv.ms','Final Game Rules v2.4 - 4/3/25','v2.4','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EQin9nGlJGpFgRRPqehrBu4BxtcEX3P2aC43ERH3VzvfOQ?e=mvDr9f'),'https://boardgamegeek.com/thread/3479222','Final Game Rules v2.4 - 4/3/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EQin9nGlJGpFgRRPqehrBu4BxtcEX3P2aC43ERH3VzvfOQ?e=mvDr9f'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.4','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EQin9nGlJGpFgRRPqehrBu4BxtcEX3P2aC43ERH3VzvfOQ?e=mvDr9f') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','rules','https://1drv.ms/w/c/4e3a50fc4a975050/Ec8VgIOXPBFLuWvGHnTICbIBLK6KuvBUtiETW7No_Z3AfQ?e=uahZfG','1drv.ms','Old Game Rules v2.2 - 3/30/25','v2.2','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/Ec8VgIOXPBFLuWvGHnTICbIBLK6KuvBUtiETW7No_Z3AfQ?e=uahZfG'),'https://boardgamegeek.com/thread/3479222','Old Game Rules v2.2 - 3/30/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/Ec8VgIOXPBFLuWvGHnTICbIBLK6KuvBUtiETW7No_Z3AfQ?e=uahZfG'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/Ec8VgIOXPBFLuWvGHnTICbIBLK6KuvBUtiETW7No_Z3AfQ?e=uahZfG') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','rules','https://1drv.ms/w/c/4e3a50fc4a975050/EcoopZZk8XxOgnGCYf-_J3MB6X8cF0BltChCni7xe5vmnA?e=s6lENQ','1drv.ms','Old Game Rules v2.3 - 3/31/25','v2.3','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EcoopZZk8XxOgnGCYf-_J3MB6X8cF0BltChCni7xe5vmnA?e=s6lENQ'),'https://boardgamegeek.com/thread/3479222','Old Game Rules v2.3 - 3/31/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EcoopZZk8XxOgnGCYf-_J3MB6X8cF0BltChCni7xe5vmnA?e=s6lENQ'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.3','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://1drv.ms/w/c/4e3a50fc4a975050/EcoopZZk8XxOgnGCYf-_J3MB6X8cF0BltChCni7xe5vmnA?e=s6lENQ') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','rules','https://docs.google.com/document/d/16l9Pq3GJ7x8UERWleNO0eNuj_LTkIrjc/edit','docs.google.com','Old Game Rules v1.1 - 3/16/25','v1.1','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/16l9Pq3GJ7x8UERWleNO0eNuj_LTkIrjc/edit'),'https://boardgamegeek.com/thread/3479222','Old Game Rules v1.1 - 3/16/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/16l9Pq3GJ7x8UERWleNO0eNuj_LTkIrjc/edit'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/16l9Pq3GJ7x8UERWleNO0eNuj_LTkIrjc/edit') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','rules','https://docs.google.com/document/d/17tMBl0vDEA3h_pT8zqWKUSqYKbDI3j_f/edit?usp=sharing&ouid=109837450797380285615&rtpof=true&sd=true','docs.google.com','Old Game Rules v2.1 - 3/20/25','v2.1','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/17tMBl0vDEA3h_pT8zqWKUSqYKbDI3j_f/edit?usp=sharing&ouid=109837450797380285615&rtpof=true&sd=true'),'https://boardgamegeek.com/thread/3479222','Old Game Rules v2.1 - 3/20/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/17tMBl0vDEA3h_pT8zqWKUSqYKbDI3j_f/edit?usp=sharing&ouid=109837450797380285615&rtpof=true&sd=true'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://docs.google.com/document/d/17tMBl0vDEA3h_pT8zqWKUSqYKbDI3j_f/edit?usp=sharing&ouid=109837450797380285615&rtpof=true&sd=true') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','component','https://drive.google.com/file/d/16x5osNY7e3RSoYvCUslI0iqjZgJ4sQvU/view?usp=sharing','drive.google.com','Old Double-sided Produce Cards v1.1 - 3/16/25','v1.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/16x5osNY7e3RSoYvCUslI0iqjZgJ4sQvU/view?usp=sharing'),'https://boardgamegeek.com/thread/3479222','Old Double-sided Produce Cards v1.1 - 3/16/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/16x5osNY7e3RSoYvCUslI0iqjZgJ4sQvU/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/16x5osNY7e3RSoYvCUslI0iqjZgJ4sQvU/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','component','https://drive.google.com/file/d/18LipPlWmVTpVud2-L0z0n9guBlsUoOIf/view?usp=sharing','drive.google.com','Old Double-sided Produce Cards v2.1 - 3/20/25','v2.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18LipPlWmVTpVud2-L0z0n9guBlsUoOIf/view?usp=sharing'),'https://boardgamegeek.com/thread/3479222','Old Double-sided Produce Cards v2.1 - 3/20/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18LipPlWmVTpVud2-L0z0n9guBlsUoOIf/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18LipPlWmVTpVud2-L0z0n9guBlsUoOIf/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','component','https://drive.google.com/file/d/18RV_uL5LNPiEH0QQj_SHez3NQmU7PWir/view?usp=sharing','drive.google.com','Old Double-sided Produce Cards Low-Ink v2.1 - 3/20/25','v2.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18RV_uL5LNPiEH0QQj_SHez3NQmU7PWir/view?usp=sharing'),'https://boardgamegeek.com/thread/3479222','Old Double-sided Produce Cards Low-Ink v2.1 - 3/20/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18RV_uL5LNPiEH0QQj_SHez3NQmU7PWir/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/18RV_uL5LNPiEH0QQj_SHez3NQmU7PWir/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','component','https://drive.google.com/file/d/1BDoG2mo93v6gnwmG6mKKf3CcOrHzg58G/view?usp=sharing','drive.google.com','Final Double-sided Produce Cards v2.2 - 3/29/25','v2.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BDoG2mo93v6gnwmG6mKKf3CcOrHzg58G/view?usp=sharing'),'https://boardgamegeek.com/thread/3479222','Final Double-sided Produce Cards v2.2 - 3/29/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BDoG2mo93v6gnwmG6mKKf3CcOrHzg58G/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BDoG2mo93v6gnwmG6mKKf3CcOrHzg58G/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','component','https://drive.google.com/file/d/1BJvGZWRgAcMQsen0OYQpzJfEwFaCVWcX/view?usp=sharing','drive.google.com','Final Double-sided Produce Cards Low-Ink v2.2 - 3/29/25','v2.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BJvGZWRgAcMQsen0OYQpzJfEwFaCVWcX/view?usp=sharing'),'https://boardgamegeek.com/thread/3479222','Final Double-sided Produce Cards Low-Ink v2.2 - 3/29/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BJvGZWRgAcMQsen0OYQpzJfEwFaCVWcX/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked','v2.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://drive.google.com/file/d/1BJvGZWRgAcMQsen0OYQpzJfEwFaCVWcX/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','online_play','https://playingcards.io/4nb538','playingcards.io','https://playingcards.io/4nb538',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/4nb538'),'https://boardgamegeek.com/thread/3479222','https://playingcards.io/4nb538','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/4nb538'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/4nb538') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('410','online_play','https://playingcards.io/7t4n4c','playingcards.io','https://playingcards.io/7t4n4c',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (410,(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/7t4n4c'),'https://boardgamegeek.com/thread/3479222','https://playingcards.io/7t4n4c','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/7t4n4c'),'2026-10-04','https://boardgamegeek.com/thread/3479222','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=410 AND url='https://playingcards.io/7t4n4c') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479222' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '410','randomizer','dadi: Dice (20d6 and 4d10)','24 Dice (20d6 and 4d10)','24','required','common','-24 Dice (20d6 and 4d10)
-9 Double-sided Produce Cards
-A pen or pencil for 1 Player','https://boardgamegeek.com/thread/3479222','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '410' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Dice (20d6 and 4d10)' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479222');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '410','printable_component','carte: Double-sided Produce Cards','9 Double-sided Produce Cards','9','required','printable','-24 Dice (20d6 and 4d10)
-9 Double-sided Produce Cards
-A pen or pencil for 1 Player','https://boardgamegeek.com/thread/3479222','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '410' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Double-sided Produce Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479222');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '410','writing_tool','strumento scrittura: A pen or pencil for 1 Player','A pen or pencil for 1 Player',NULL,'required','common','-24 Dice (20d6 and 4d10)
-9 Double-sided Produce Cards
-A pen or pencil for 1 Player','https://boardgamegeek.com/thread/3479222','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '410' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: A pen or pencil for 1 Player' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479222');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '410','rules','regolamento dichiarato nei link','Final Game Rules v2.4 - 4/3/25 | Old Game Rules v2.3 - 3/31/25 | Old Game Rules v2.2 - 3/30/25 | Old Game Rules v2.1 - 3/20/25 | Old Game Rules v1.1 - 3/16/25',NULL,'unclear','printable','Final Game Rules v2.4 - 4/3/25 | Old Game Rules v2.3 - 3/31/25 | Old Game Rules v2.2 - 3/30/25 | Old Game Rules v2.1 - 3/20/25 | Old Game Rules v1.1 - 3/16/25','https://boardgamegeek.com/thread/3479222','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '410' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479222');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3473847' WHERE id=411 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('411','2026-10-04','https://boardgamegeek.com/thread/3473847','found','TSK-0051; primo post originale soltanto; host non verificati. Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('411','2026-10-04','https://boardgamegeek.com/thread/3473847','found','TSK-0051; primo post originale soltanto; host non verificati. Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('411','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3473847','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('411','game_files','https://www.dropbox.com/scl/fo/0qqcpi03ej790clexzq2z/ANsZ1FAMZtl7vju95RoFK-Y?rlkey=hcsvbr0t50li8xs3i5hwycgr1&st=eqzlfopv&dl=0','www.dropbox.com','HERE',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (411,(SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/0qqcpi03ej790clexzq2z/ANsZ1FAMZtl7vju95RoFK-Y?rlkey=hcsvbr0t50li8xs3i5hwycgr1&st=eqzlfopv&dl=0'),'https://boardgamegeek.com/thread/3473847','HERE','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/0qqcpi03ej790clexzq2z/ANsZ1FAMZtl7vju95RoFK-Y?rlkey=hcsvbr0t50li8xs3i5hwycgr1&st=eqzlfopv&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3473847','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/0qqcpi03ej790clexzq2z/ANsZ1FAMZtl7vju95RoFK-Y?rlkey=hcsvbr0t50li8xs3i5hwycgr1&st=eqzlfopv&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3473847' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('411','game_files','https://www.dropbox.com/scl/fo/4bnxcc0w7flnyu9enq38y/ANXVUGPVpYBxh-y1nfVUKAY?rlkey=3rlsjo494pm3xy065bwhvaj74&st=oc37i8vw&dl=0','www.dropbox.com','HIER',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (411,(SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/4bnxcc0w7flnyu9enq38y/ANXVUGPVpYBxh-y1nfVUKAY?rlkey=3rlsjo494pm3xy065bwhvaj74&st=oc37i8vw&dl=0'),'https://boardgamegeek.com/thread/3473847','HIER','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/4bnxcc0w7flnyu9enq38y/ANXVUGPVpYBxh-y1nfVUKAY?rlkey=3rlsjo494pm3xy065bwhvaj74&st=oc37i8vw&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3473847','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Requisiti per giocatore distinti da quelli globali; custodia dichiarata nei file, non obbligatorietà.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=411 AND url='https://www.dropbox.com/scl/fo/4bnxcc0w7flnyu9enq38y/ANXVUGPVpYBxh-y1nfVUKAY?rlkey=3rlsjo494pm3xy065bwhvaj74&st=oc37i8vw&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3473847' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','printable_component','carte: double sided cards [PDF A4/letter size]','9 double sided cards [PDF A4/letter size]','9','required','printable','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided cards [PDF A4/letter size]' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','rules','regolamento: Rules - 4 Pages [PDF A4/letter size]','Rules - 4 Pages [PDF A4/letter size]',NULL,'required','printable','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules - 4 Pages [PDF A4/letter size]' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','randomizer','dadi: d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]','9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]','9','required','common','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','container','contenitore: bag','1 bag','1','required','household','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'container' AND name_normalized IS 'contenitore: bag' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','writing_tool','strumento scrittura: pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]','1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]','1 per player','required','common','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]' AND quantity_raw IS '1 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','token_marker','segnalini: pawn in player colour [or anything that works for you ]','1 pawn in player colour [or anything that works for you ]','1 per player','required','common','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: pawn in player colour [or anything that works for you ]' AND quantity_raw IS '1 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '411','randomizer','dadi: score dice in player colour [1 per player, for score-keeping]','1 score dice in player colour [1 per player, for score-keeping]','1 per player','required','common','9 double sided cards [PDF A4/letter size]
Rules - 4 Pages [PDF A4/letter size]
9 d6 dice [preferably 3 blue, 3 red, 3 yellow, but any color you can provide will do]
1 bag
per player:
1 pencil [if you don’t like writing on the cards: cards sleeving & dry erase markers are recommended]
1 pawn in player colour [or anything that works for you ]
1 score dice in player colour [1 per player, for score-keeping]','https://boardgamegeek.com/thread/3473847','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '411' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: score dice in player colour [1 per player, for score-keeping]' AND quantity_raw IS '1 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473847');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3459079' WHERE id=412 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('412','2026-10-04','https://boardgamegeek.com/thread/3459079','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('412','2026-10-04','https://boardgamegeek.com/thread/3459079','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('412','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3459079','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('412','rules','https://drive.google.com/file/d/1VUvPHOvBreaCYIgXP-xjX15ork28SJMP/view?usp=drive_link','drive.google.com','Grate Sword! v1.09 rules','v1.09','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (412,(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1VUvPHOvBreaCYIgXP-xjX15ork28SJMP/view?usp=drive_link'),'https://boardgamegeek.com/thread/3459079','Grate Sword! v1.09 rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1VUvPHOvBreaCYIgXP-xjX15ork28SJMP/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3459079','declared_in_wip','not_checked','v1.09','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1VUvPHOvBreaCYIgXP-xjX15ork28SJMP/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3459079' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('412','component','https://drive.google.com/file/d/1kyf9jHuuOWcCH4N9k-68twtLUjqa4_V3/view?usp=drive_link','drive.google.com','Grate Sword! v1.09 cards','v1.09','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (412,(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1kyf9jHuuOWcCH4N9k-68twtLUjqa4_V3/view?usp=drive_link'),'https://boardgamegeek.com/thread/3459079','Grate Sword! v1.09 cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1kyf9jHuuOWcCH4N9k-68twtLUjqa4_V3/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3459079','declared_in_wip','not_checked','v1.09','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://drive.google.com/file/d/1kyf9jHuuOWcCH4N9k-68twtLUjqa4_V3/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3459079' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('412','video','https://youtu.be/ZWK6M9xhFF4','youtu.be','Grate Sword (Formerly Veggie Knight Fight) Overview and Playthrough',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (412,(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://youtu.be/ZWK6M9xhFF4'),'https://boardgamegeek.com/thread/3459079','Grate Sword (Formerly Veggie Knight Fight) Overview and Playthrough','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=412 AND url='https://youtu.be/ZWK6M9xhFF4'),'2026-10-04','https://boardgamegeek.com/thread/3459079','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=412 AND url='https://youtu.be/ZWK6M9xhFF4') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3459079' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '412','printable_component','carte: double-sided fighter cards','8 double-sided fighter cards','8','required','printable','8 double-sided fighter cards
1 double sided pot/reference card','https://boardgamegeek.com/thread/3459079','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '412' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided fighter cards' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3459079');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '412','printable_component','carte: double sided pot/reference card','1 double sided pot/reference card','1','required','printable','8 double-sided fighter cards
1 double sided pot/reference card','https://boardgamegeek.com/thread/3459079','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '412' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided pot/reference card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3459079');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '412','rules','regolamento dichiarato nei link','Grate Sword! v1.09 rules',NULL,'unclear','printable','Grate Sword! v1.09 rules','https://boardgamegeek.com/thread/3459079','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '412' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3459079');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3475192' WHERE id=413 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('413','2026-10-04','https://boardgamegeek.com/thread/3475192','found','TSK-0051; primo post originale soltanto; host non verificati. Totali e sottogruppi non sommati due volte; dadi senza numero di facce dichiarato.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('413','2026-10-04','https://boardgamegeek.com/thread/3475192','found','TSK-0051; primo post originale soltanto; host non verificati. Totali e sottogruppi non sommati due volte; dadi senza numero di facce dichiarato.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('413','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3475192','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Totali e sottogruppi non sommati due volte; dadi senza numero di facce dichiarato.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('413','game_files','https://drive.google.com/drive/folders/1U2fNPbNWUDYCfwlTrx4-e7ZdtNpD8gFo?usp=drive_link','drive.google.com','Rulebook and PNP Cards',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (413,(SELECT id FROM remote_resources WHERE game_id=413 AND url='https://drive.google.com/drive/folders/1U2fNPbNWUDYCfwlTrx4-e7ZdtNpD8gFo?usp=drive_link'),'https://boardgamegeek.com/thread/3475192','Rulebook and PNP Cards','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=413 AND url='https://drive.google.com/drive/folders/1U2fNPbNWUDYCfwlTrx4-e7ZdtNpD8gFo?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3475192','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Totali e sottogruppi non sommati due volte; dadi senza numero di facce dichiarato.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=413 AND url='https://drive.google.com/drive/folders/1U2fNPbNWUDYCfwlTrx4-e7ZdtNpD8gFo?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475192' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','printable_component','carte principali','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','8','required','printable','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'printable_component' AND name_normalized IS 'carte principali' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','printable_component','carte helper mezzo formato','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','2','required','printable','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'printable_component' AND name_normalized IS 'carte helper mezzo formato' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','randomizer','dadi giocatore 12mm','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','4','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi giocatore 12mm' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','token_marker','meeple giocatore','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','3','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple giocatore' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','token_marker','cubi giocatore 8mm','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','2','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi giocatore 8mm' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','randomizer','dadi mostri 12mm','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','4','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi mostri 12mm' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','token_marker','meeple mostri','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','3','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple mostri' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','token_marker','cubi mostri 8mm','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','3','required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi mostri 8mm' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '413','writing_tool','pennarello cancellabile','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

',NULL,'required','common','The Cards - 8 Double Sided Cards (3.5 x 2.5)
1 Hero Card
1 Pouch/Crafting Card
1 Quest/Icon Reference Card
5 Monster/Map Cards

Components List (22)
2 Double Sided Cards (1.75 X 1.25)
2 Helper Cards

Player Components
4 12mm Dice
Red (Attack)
Blue (Defense)
Yellow (Speed)
Clear (Skill)
3 Person Meeple
Green (Hero)
Blue (Helper)
White (Summoned Ex Helper)
2 8mm Plastic Cubes
Green (Hero Hp Tracker)
Blue (Helper Hp Tracker)

Monster Components
4 12mm Dice (Preferably color black)
3 Person Meeple
Black
Red
Purple
3 8mm Plastic Cubes
Black
Red
Purple
Dry Board Marker (Preferably Green)

','https://boardgamegeek.com/thread/3475192','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '413' AND material_kind IS 'writing_tool' AND name_normalized IS 'pennarello cancellabile' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475192');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3439122' WHERE id=414 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('414','2026-10-04','https://boardgamegeek.com/thread/3439122','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('414','2026-10-04','https://boardgamegeek.com/thread/3439122','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('414','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3439122','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('414','rules','https://docs.google.com/presentation/d/1UytpJ7kJsp_nob8wyQej668vazurp_hBs2IF793y9ds/edit?usp=sharing','docs.google.com','Hydra Wrangler v2.01 rules','v2.01','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (414,(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://docs.google.com/presentation/d/1UytpJ7kJsp_nob8wyQej668vazurp_hBs2IF793y9ds/edit?usp=sharing'),'https://boardgamegeek.com/thread/3439122','Hydra Wrangler v2.01 rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=414 AND url='https://docs.google.com/presentation/d/1UytpJ7kJsp_nob8wyQej668vazurp_hBs2IF793y9ds/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3439122','declared_in_wip','not_checked','v2.01','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://docs.google.com/presentation/d/1UytpJ7kJsp_nob8wyQej668vazurp_hBs2IF793y9ds/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3439122' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('414','component','https://drive.google.com/file/d/1dQvDloDt3HqbblfDPrDfYjJ2_gHiSsqq/view?usp=drive_link','drive.google.com','Hydra Wrangler v2.01 Full Color cards','v2.01','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (414,(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://drive.google.com/file/d/1dQvDloDt3HqbblfDPrDfYjJ2_gHiSsqq/view?usp=drive_link'),'https://boardgamegeek.com/thread/3439122','Hydra Wrangler v2.01 Full Color cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=414 AND url='https://drive.google.com/file/d/1dQvDloDt3HqbblfDPrDfYjJ2_gHiSsqq/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3439122','declared_in_wip','not_checked','v2.01','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://drive.google.com/file/d/1dQvDloDt3HqbblfDPrDfYjJ2_gHiSsqq/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3439122' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('414','video','https://youtu.be/UI6qm7Mq2NQ','youtu.be','Video Overview and Playthrough for v1.07','v1.07','unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (414,(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://youtu.be/UI6qm7Mq2NQ'),'https://boardgamegeek.com/thread/3439122','Video Overview and Playthrough for v1.07','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=414 AND url='https://youtu.be/UI6qm7Mq2NQ'),'2026-10-04','https://boardgamegeek.com/thread/3439122','declared_in_wip','not_checked','v1.07','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=414 AND url='https://youtu.be/UI6qm7Mq2NQ') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3439122' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '414','printable_component','carte: double-sided poker-sized cards (Defiant and Tamed Side)','9 double-sided poker-sized cards (Defiant and Tamed Side)','9','required','printable','9 double-sided poker-sized cards (Defiant and Tamed Side)
. 11 coins for tracking','https://boardgamegeek.com/thread/3439122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '414' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided poker-sized cards (Defiant and Tamed Side)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3439122');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '414','token_marker','segnalini: . 11 coins for tracking','. 11 coins for tracking','11','required','common','9 double-sided poker-sized cards (Defiant and Tamed Side)
. 11 coins for tracking','https://boardgamegeek.com/thread/3439122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '414' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: . 11 coins for tracking' AND quantity_raw IS '11' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3439122');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '414','rules','regolamento dichiarato nei link','Hydra Wrangler v2.01 rules',NULL,'unclear','printable','Hydra Wrangler v2.01 rules','https://boardgamegeek.com/thread/3439122','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '414' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3439122');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477927' WHERE id=415 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('415','2026-10-04','https://boardgamegeek.com/thread/3477927','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('415','2026-10-04','https://boardgamegeek.com/thread/3477927','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('415','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477927','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('415','game_files','https://drive.google.com/drive/folders/1qpiAfD3PKcHygDVcHUXW9tQuz5RUzrY7?usp=sharing','drive.google.com','Rulebook and Files_If Only Fireflies Exist...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (415,(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://drive.google.com/drive/folders/1qpiAfD3PKcHygDVcHUXW9tQuz5RUzrY7?usp=sharing'),'https://boardgamegeek.com/thread/3477927','Rulebook and Files_If Only Fireflies Exist...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=415 AND url='https://drive.google.com/drive/folders/1qpiAfD3PKcHygDVcHUXW9tQuz5RUzrY7?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477927','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://drive.google.com/drive/folders/1qpiAfD3PKcHygDVcHUXW9tQuz5RUzrY7?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477927' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('415','online_play','https://playingcards.io/2ug9eq','playingcards.io','Public Room 01',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (415,(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/2ug9eq'),'https://boardgamegeek.com/thread/3477927','Public Room 01','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/2ug9eq'),'2026-10-04','https://boardgamegeek.com/thread/3477927','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/2ug9eq') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477927' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('415','online_play','https://playingcards.io/9zx7st','playingcards.io','Public Room 02',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (415,(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/9zx7st'),'https://boardgamegeek.com/thread/3477927','Public Room 02','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/9zx7st'),'2026-10-04','https://boardgamegeek.com/thread/3477927','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://playingcards.io/9zx7st') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477927' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('415','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3460378190','steamcommunity.com','Tabletop Simulator mod ',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (415,(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3460378190'),'https://boardgamegeek.com/thread/3477927','Tabletop Simulator mod ','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=415 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3460378190'),'2026-10-04','https://boardgamegeek.com/thread/3477927','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=415 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3460378190') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477927' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '415','printable_component','carte: Journal Cards','[2] Journal Cards','2','required','printable','[2] Journal Cards
[7] Forest Cards
[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)
[1] Pouch Bag or anything similar
[1] Pencil or any writing utensil','https://boardgamegeek.com/thread/3477927','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '415' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Journal Cards' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477927');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '415','printable_component','carte: Forest Cards','[7] Forest Cards','7','required','printable','[2] Journal Cards
[7] Forest Cards
[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)
[1] Pouch Bag or anything similar
[1] Pencil or any writing utensil','https://boardgamegeek.com/thread/3477927','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '415' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Forest Cards' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477927');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '415','token_marker','segnalini: Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green a','[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)','24','required','common','[2] Journal Cards
[7] Forest Cards
[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)
[1] Pouch Bag or anything similar
[1] Pencil or any writing utensil','https://boardgamegeek.com/thread/3477927','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '415' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green a' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477927');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '415','container','contenitore: Pouch Bag or anything similar','[1] Pouch Bag or anything similar','1','required','household','[2] Journal Cards
[7] Forest Cards
[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)
[1] Pouch Bag or anything similar
[1] Pencil or any writing utensil','https://boardgamegeek.com/thread/3477927','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '415' AND material_kind IS 'container' AND name_normalized IS 'contenitore: Pouch Bag or anything similar' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477927');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '415','writing_tool','strumento scrittura: Pencil or any writing utensil','[1] Pencil or any writing utensil','1','required','common','[2] Journal Cards
[7] Forest Cards
[24] Cubes in 4 different colors (8 yellow as fireflies, 5 black as cicadas, 5 red as ladybugs, 6 green as caterpillars)
[1] Pouch Bag or anything similar
[1] Pencil or any writing utensil','https://boardgamegeek.com/thread/3477927','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '415' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: Pencil or any writing utensil' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477927');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3440248' WHERE id=416 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('416','2026-10-04','https://boardgamegeek.com/thread/3440248','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('416','2026-10-04','https://boardgamegeek.com/thread/3440248','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('416','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3440248','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('416','rules','https://drive.google.com/file/d/1IeaM5PoEG7XkVphxYsIrJ6tpbxfb4yDP/view?usp=sharing','drive.google.com','Rules (Full Color), Version 1.2','Version 1.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (416,(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1IeaM5PoEG7XkVphxYsIrJ6tpbxfb4yDP/view?usp=sharing'),'https://boardgamegeek.com/thread/3440248','Rules (Full Color), Version 1.2','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1IeaM5PoEG7XkVphxYsIrJ6tpbxfb4yDP/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440248','declared_in_wip','not_checked','Version 1.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1IeaM5PoEG7XkVphxYsIrJ6tpbxfb4yDP/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440248' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('416','component','https://drive.google.com/file/d/1KZzS7oGcaPozUYt-e0XF23_lPP41ikQa/view?usp=sharing','drive.google.com','Cards (Full Color), Version 1.2','Version 1.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (416,(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1KZzS7oGcaPozUYt-e0XF23_lPP41ikQa/view?usp=sharing'),'https://boardgamegeek.com/thread/3440248','Cards (Full Color), Version 1.2','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1KZzS7oGcaPozUYt-e0XF23_lPP41ikQa/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440248','declared_in_wip','not_checked','Version 1.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1KZzS7oGcaPozUYt-e0XF23_lPP41ikQa/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440248' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('416','component','https://drive.google.com/file/d/1W9aPdddh2CcmLlj76xP9yxgeqeNK0veN/view?usp=sharing','drive.google.com','Cards (Low Ink), Version 1.2','Version 1.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (416,(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1W9aPdddh2CcmLlj76xP9yxgeqeNK0veN/view?usp=sharing'),'https://boardgamegeek.com/thread/3440248','Cards (Low Ink), Version 1.2','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1W9aPdddh2CcmLlj76xP9yxgeqeNK0veN/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440248','declared_in_wip','not_checked','Version 1.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1W9aPdddh2CcmLlj76xP9yxgeqeNK0veN/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440248' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('416','rules','https://drive.google.com/file/d/1ejPkiKu-KNKbE1AisxE13NtLROKjy6GX/view?usp=sharing','drive.google.com','Rules (Low Ink), Version 1.2','Version 1.2','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (416,(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1ejPkiKu-KNKbE1AisxE13NtLROKjy6GX/view?usp=sharing'),'https://boardgamegeek.com/thread/3440248','Rules (Low Ink), Version 1.2','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1ejPkiKu-KNKbE1AisxE13NtLROKjy6GX/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440248','declared_in_wip','not_checked','Version 1.2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=416 AND url='https://drive.google.com/file/d/1ejPkiKu-KNKbE1AisxE13NtLROKjy6GX/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440248' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '416','randomizer','dadi: six-sided dice (any color)','6 six-sided dice (any color)','6','required','common',':
 6 six-sided dice (any color)
 9 double-sided cards (1 double-sided Letter page)
 1 Rulebook (11 double-side Letter pages)
 6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)
 5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','https://boardgamegeek.com/thread/3440248','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '416' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: six-sided dice (any color)' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440248');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '416','printable_component','carte: double-sided cards (1 double-sided Letter page)','9 double-sided cards (1 double-sided Letter page)','9','required','printable',':
 6 six-sided dice (any color)
 9 double-sided cards (1 double-sided Letter page)
 1 Rulebook (11 double-side Letter pages)
 6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)
 5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','https://boardgamegeek.com/thread/3440248','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '416' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards (1 double-sided Letter page)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440248');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '416','rules','regolamento: Rulebook (11 double-side Letter pages)','1 Rulebook (11 double-side Letter pages)','1','required','printable',':
 6 six-sided dice (any color)
 9 double-sided cards (1 double-sided Letter page)
 1 Rulebook (11 double-side Letter pages)
 6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)
 5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','https://boardgamegeek.com/thread/3440248','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '416' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook (11 double-side Letter pages)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440248');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '416','token_marker','segnalini: Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coin','6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)','6','required','common',':
 6 six-sided dice (any color)
 9 double-sided cards (1 double-sided Letter page)
 1 Rulebook (11 double-side Letter pages)
 6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)
 5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','https://boardgamegeek.com/thread/3440248','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '416' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coin' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440248');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '416','token_marker','segnalini: cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is r','5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','5','required','common',':
 6 six-sided dice (any color)
 9 double-sided cards (1 double-sided Letter page)
 1 Rulebook (11 double-side Letter pages)
 6 Activation Tokens (you can use coins, beads, discs, or any small token or item; I''m using metal coins)
 5 cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is recommended, but any will do; I''m using another black cube)','https://boardgamegeek.com/thread/3440248','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '416' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes in the following colors: red, yellow, blue, black, and one other cube of any color (clear is r' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440248');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3447990' WHERE id=417 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('417','2026-10-04','https://boardgamegeek.com/thread/3447990','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('417','2026-10-04','https://boardgamegeek.com/thread/3447990','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('417','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3447990','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('417','game_files','https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgjDarOhLwdApuO_XT7','drive.google.com','https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgj...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (417,(SELECT id FROM remote_resources WHERE game_id=417 AND url='https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgjDarOhLwdApuO_XT7'),'https://boardgamegeek.com/thread/3447990','https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgj...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=417 AND url='https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgjDarOhLwdApuO_XT7'),'2026-10-04','https://boardgamegeek.com/thread/3447990','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=417 AND url='https://drive.google.com/drive/u/0/folders/1bKnkJJh2C4hfCcgjDarOhLwdApuO_XT7') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3447990' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','printable_component','carte: cards','8 cards','8','required','printable','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','printable_component','carte: cut cards','3 cut cards','3','required','printable','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cut cards' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','randomizer','dadi: White D10','1 White D10','1','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: White D10' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','randomizer','dadi: Black D10','1 Black D10','1','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Black D10' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','randomizer','dadi: Gray D12','1 Gray D12','1','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Gray D12' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','token_marker','segnalini: White Meeple','1 White Meeple','1','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: White Meeple' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','token_marker','segnalini: Black Meeple','1 Black Meeple','1','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Black Meeple' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','token_marker','segnalini: White Cubes','7 White Cubes','7','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: White Cubes' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '417','token_marker','segnalini: Black Cubes','7 Black Cubes','7','required','common','8 cards
3 cut cards
1 White D10
1 Black D10
1 Gray D12
1 White Meeple
1 Black Meeple
7 White Cubes
7 Black Cubes
(8 cards and 22 components total)','https://boardgamegeek.com/thread/3447990','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '417' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Black Cubes' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447990');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477894' WHERE id=418 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('418','2026-10-04','https://boardgamegeek.com/thread/3477894','found','TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('418','2026-10-04','https://boardgamegeek.com/thread/3477894','found','TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('418','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477894','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('418','game_files','https://drive.google.com/file/d/16V9tFMWo-3Yovi_R26PSt0KBZxFB0aJI/view?usp=sharing','drive.google.com','Grayscale Version',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (418,(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/16V9tFMWo-3Yovi_R26PSt0KBZxFB0aJI/view?usp=sharing'),'https://boardgamegeek.com/thread/3477894','Grayscale Version','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/16V9tFMWo-3Yovi_R26PSt0KBZxFB0aJI/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477894','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/16V9tFMWo-3Yovi_R26PSt0KBZxFB0aJI/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477894' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('418','component','https://drive.google.com/file/d/1IjthopDA8iVJ6EH5osxbxGhfS_vkGtkT/view?usp=sharing','drive.google.com','Cards on [1] A4 letter size double-sided PDF sheet',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (418,(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1IjthopDA8iVJ6EH5osxbxGhfS_vkGtkT/view?usp=sharing'),'https://boardgamegeek.com/thread/3477894','Cards on [1] A4 letter size double-sided PDF sheet','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1IjthopDA8iVJ6EH5osxbxGhfS_vkGtkT/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477894','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1IjthopDA8iVJ6EH5osxbxGhfS_vkGtkT/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477894' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('418','rules','https://drive.google.com/file/d/1auO5wIxH5NYcf9K80T7RYGqNHSHlrp__/view?usp=sharing','drive.google.com','RULES - 3 Pages A4 Letter size double-sided PDF',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (418,(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1auO5wIxH5NYcf9K80T7RYGqNHSHlrp__/view?usp=sharing'),'https://boardgamegeek.com/thread/3477894','RULES - 3 Pages A4 Letter size double-sided PDF','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1auO5wIxH5NYcf9K80T7RYGqNHSHlrp__/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477894','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. La sinossi dichiara 10d6 per giocatore mentre la lista componenti dichiara 5d6: conflitto non risolto.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=418 AND url='https://drive.google.com/file/d/1auO5wIxH5NYcf9K80T7RYGqNHSHlrp__/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477894' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '418','printable_component','carte: Cards on [1] A4 letter size double-sided PDF sheet','[9] - Cards on [1] A4 letter size double-sided PDF sheet','9','required','printable','[9] - Cards on [1] A4 letter size double-sided PDF sheet
- Grayscale Version
[1] - RULES - 3 Pages A4 Letter size double-sided PDF.
[5] - d6 dice
[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]
[1] - ring/paper clip unfolded and made into a ring','https://boardgamegeek.com/thread/3477894','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '418' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards on [1] A4 letter size double-sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477894');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '418','rules','regolamento: RULES - 3 Pages A4 Letter size double-sided PDF.','[1] - RULES - 3 Pages A4 Letter size double-sided PDF.','1','required','printable','[9] - Cards on [1] A4 letter size double-sided PDF sheet
- Grayscale Version
[1] - RULES - 3 Pages A4 Letter size double-sided PDF.
[5] - d6 dice
[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]
[1] - ring/paper clip unfolded and made into a ring','https://boardgamegeek.com/thread/3477894','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '418' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 3 Pages A4 Letter size double-sided PDF.' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477894');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '418','randomizer','dadi: d6 dice','[5] - d6 dice','5','required','common','[9] - Cards on [1] A4 letter size double-sided PDF sheet
- Grayscale Version
[1] - RULES - 3 Pages A4 Letter size double-sided PDF.
[5] - d6 dice
[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]
[1] - ring/paper clip unfolded and made into a ring','https://boardgamegeek.com/thread/3477894','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '418' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477894');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '418','token_marker','segnalini: discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]','[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]','16','required','common','[9] - Cards on [1] A4 letter size double-sided PDF sheet
- Grayscale Version
[1] - RULES - 3 Pages A4 Letter size double-sided PDF.
[5] - d6 dice
[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]
[1] - ring/paper clip unfolded and made into a ring','https://boardgamegeek.com/thread/3477894','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '418' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]' AND quantity_raw IS '16' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477894');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '418','token_marker','segnalini: ring/paper clip unfolded and made into a ring','[1] - ring/paper clip unfolded and made into a ring','1','required','common','[9] - Cards on [1] A4 letter size double-sided PDF sheet
- Grayscale Version
[1] - RULES - 3 Pages A4 Letter size double-sided PDF.
[5] - d6 dice
[16] - discs/chips/blocks of different colors - [4 White, 4 Blue, 4 Red, and 4 Green]
[1] - ring/paper clip unfolded and made into a ring','https://boardgamegeek.com/thread/3477894','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '418' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: ring/paper clip unfolded and made into a ring' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477894');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3455234' WHERE id=419 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('419','2026-10-04','https://boardgamegeek.com/thread/3455234','found','TSK-0051; primo post originale soltanto; host non verificati. 14 cubi, due set da 6 e due neutrali: preservata la formulazione originale senza sommare i due neutrali al totale.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('419','2026-10-04','https://boardgamegeek.com/thread/3455234','found','TSK-0051; primo post originale soltanto; host non verificati. 14 cubi, due set da 6 e due neutrali: preservata la formulazione originale senza sommare i due neutrali al totale.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('419','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3455234','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. 14 cubi, due set da 6 e due neutrali: preservata la formulazione originale senza sommare i due neutrali al totale.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('419','game_files','https://alexandrecamargo.itch.io/little-ruins-of-arnakiny','alexandrecamargo.itch.io','Little Ruins of Arnakiny on itch.io',NULL,'unknown','2026-10-04','2026-10-04','download_page');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (419,(SELECT id FROM remote_resources WHERE game_id=419 AND url='https://alexandrecamargo.itch.io/little-ruins-of-arnakiny'),'https://boardgamegeek.com/thread/3455234','Little Ruins of Arnakiny on itch.io','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=419 AND url='https://alexandrecamargo.itch.io/little-ruins-of-arnakiny'),'2026-10-04','https://boardgamegeek.com/thread/3455234','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 14 cubi, due set da 6 e due neutrali: preservata la formulazione originale senza sommare i due neutrali al totale.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=419 AND url='https://alexandrecamargo.itch.io/little-ruins-of-arnakiny') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3455234' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '419','rules','regolamento: This rule book','This rule book',NULL,'required','printable','- This rule book
- 9 double-sided cards
- 8 dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (Amethyst), blue (Sapphire) and red (Rubies)
- 14 cubes in 2 different colors, one set of 6 per player.
- - 2 cubes of a different color (neutral color) from the players'' colors, one to mark the turn and the other to mark available actions','https://boardgamegeek.com/thread/3455234','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '419' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: This rule book' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3455234');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '419','printable_component','carte: double-sided cards','9 double-sided cards','9','required','printable','- This rule book
- 9 double-sided cards
- 8 dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (Amethyst), blue (Sapphire) and red (Rubies)
- 14 cubes in 2 different colors, one set of 6 per player.
- - 2 cubes of a different color (neutral color) from the players'' colors, one to mark the turn and the other to mark available actions','https://boardgamegeek.com/thread/3455234','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '419' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3455234');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '419','randomizer','dadi: dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (','8 dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (Amethyst), blue (Sapphire) and red (Rubies)','8','required','common','- This rule book
- 9 double-sided cards
- 8 dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (Amethyst), blue (Sapphire) and red (Rubies)
- 14 cubes in 2 different colors, one set of 6 per player.
- - 2 cubes of a different color (neutral color) from the players'' colors, one to mark the turn and the other to mark available actions','https://boardgamegeek.com/thread/3455234','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '419' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3455234');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '419','token_marker','segnalini: cubes in 2 different colors, one set of 6 per player.','14 cubes in 2 different colors, one set of 6 per player.','14','required','common','- This rule book
- 9 double-sided cards
- 8 dice for supply, 4 per player. Preferably in the same color of the resources yellow (Gold), purple (Amethyst), blue (Sapphire) and red (Rubies)
- 14 cubes in 2 different colors, one set of 6 per player.
- - 2 cubes of a different color (neutral color) from the players'' colors, one to mark the turn and the other to mark available actions','https://boardgamegeek.com/thread/3455234','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '419' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes in 2 different colors, one set of 6 per player.' AND quantity_raw IS '14' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3455234');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3456714' WHERE id=420 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('420','2026-10-04','https://boardgamegeek.com/thread/3456714','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('420','2026-10-04','https://boardgamegeek.com/thread/3456714','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('420','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3456714','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('420','rules','https://boardgamegeek.com/thread/3456714/article/45619543#45619543','boardgamegeek.com','How to Play',NULL,'unknown','2026-10-04','2026-10-04','bgg_article');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (420,(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://boardgamegeek.com/thread/3456714/article/45619543#45619543'),'https://boardgamegeek.com/thread/3456714','How to Play','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=420 AND url='https://boardgamegeek.com/thread/3456714/article/45619543#45619543'),'2026-10-04','https://boardgamegeek.com/thread/3456714','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://boardgamegeek.com/thread/3456714/article/45619543#45619543') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3456714' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('420','game_files','https://drive.google.com/drive/folders/1BbddWznHuD3IDVmP2zE9XydR5BYiaR50?usp=sharing','drive.google.com','Cards (full colour and low ink) & Rules',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (420,(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://drive.google.com/drive/folders/1BbddWznHuD3IDVmP2zE9XydR5BYiaR50?usp=sharing'),'https://boardgamegeek.com/thread/3456714','Cards (full colour and low ink) & Rules','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=420 AND url='https://drive.google.com/drive/folders/1BbddWznHuD3IDVmP2zE9XydR5BYiaR50?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3456714','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://drive.google.com/drive/folders/1BbddWznHuD3IDVmP2zE9XydR5BYiaR50?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3456714' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('420','online_play','https://playingcards.io/rxpjyz','playingcards.io','Play in your Browser on PlayingCardsIO',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (420,(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://playingcards.io/rxpjyz'),'https://boardgamegeek.com/thread/3456714','Play in your Browser on PlayingCardsIO','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=420 AND url='https://playingcards.io/rxpjyz'),'2026-10-04','https://boardgamegeek.com/thread/3456714','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=420 AND url='https://playingcards.io/rxpjyz') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3456714' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '420','printable_component','carte: Cards','9 Cards','9','required','printable','9 Cards
20 Cubes / Glas Beads in two colours','https://boardgamegeek.com/thread/3456714','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '420' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3456714');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '420','token_marker','segnalini: Cubes / Glas Beads in two colours','20 Cubes / Glas Beads in two colours','20','required','common','9 Cards
20 Cubes / Glas Beads in two colours','https://boardgamegeek.com/thread/3456714','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '420' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Cubes / Glas Beads in two colours' AND quantity_raw IS '20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3456714');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '420','rules','regolamento dichiarato nei link','How to Play',NULL,'unclear','printable','How to Play','https://boardgamegeek.com/thread/3456714','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '420' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3456714');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3436938' WHERE id=421 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('421','2026-10-04','https://boardgamegeek.com/thread/3436938','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('421','2026-10-04','https://boardgamegeek.com/thread/3436938','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('421','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3436938','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('421','game_files','https://drive.google.com/drive/folders/1RYJnM3J2wDkxYfngWIenI8lEONBxkzdd?usp=sharing','drive.google.com','here',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (421,(SELECT id FROM remote_resources WHERE game_id=421 AND url='https://drive.google.com/drive/folders/1RYJnM3J2wDkxYfngWIenI8lEONBxkzdd?usp=sharing'),'https://boardgamegeek.com/thread/3436938','here','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=421 AND url='https://drive.google.com/drive/folders/1RYJnM3J2wDkxYfngWIenI8lEONBxkzdd?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3436938','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=421 AND url='https://drive.google.com/drive/folders/1RYJnM3J2wDkxYfngWIenI8lEONBxkzdd?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3436938' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('421','video','https://youtube.com/watch?v=NoP1MyV-kAg','youtube.com','Math Knight v2 How-to and Play-through','v2','unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (421,(SELECT id FROM remote_resources WHERE game_id=421 AND url='https://youtube.com/watch?v=NoP1MyV-kAg'),'https://boardgamegeek.com/thread/3436938','Math Knight v2 How-to and Play-through','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=421 AND url='https://youtube.com/watch?v=NoP1MyV-kAg'),'2026-10-04','https://boardgamegeek.com/thread/3436938','declared_in_wip','not_checked','v2','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=421 AND url='https://youtube.com/watch?v=NoP1MyV-kAg') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3436938' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','printable_component','carte: double sided player card - Player 1 (hard) & Player 2 (easy)','1 double sided player card - Player 1 (hard) & Player 2 (easy)','1','required','printable','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided player card - Player 1 (hard) & Player 2 (easy)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','printable_component','carte: double sided enemy cards - Star (hard) No star (easy)','8 double sided enemy cards - Star (hard) No star (easy)','8','required','printable','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided enemy cards - Star (hard) No star (easy)' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','token_marker','segnalini: Blue Life Tracker cube','1 Blue Life Tracker cube','1','required','common','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Blue Life Tracker cube' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','token_marker','segnalini: Yellow Action Cubes','5 Yellow Action Cubes','5','required','common','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Yellow Action Cubes' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','token_marker','segnalini: Red Cubes','8 Red Cubes','8','required','common','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Red Cubes' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','randomizer','dadi: Player dice (4 white and 2 black)','6 Player dice (4 white and 2 black)','6','required','common','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Player dice (4 white and 2 black)' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '421','randomizer','dadi: Red Enemy Dice','2 Red Enemy Dice','2','required','common','- 1 double sided player card - Player 1 (hard) & Player 2 (easy)
- 8 double sided enemy cards - Star (hard) No star (easy)
- 1 Blue Life Tracker cube
- 5 Yellow Action Cubes
- 8 Red Cubes
- 6 Player dice (4 white and 2 black)
- 2 Red Enemy Dice','https://boardgamegeek.com/thread/3436938','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '421' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Red Enemy Dice' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436938');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477856' WHERE id=422 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('422','2026-10-04','https://boardgamegeek.com/thread/3477856','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('422','2026-10-04','https://boardgamegeek.com/thread/3477856','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('422','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477856','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('422','component','https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcFyuKjI/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcF...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (422,(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcFyuKjI/view?usp=sharing'),'https://boardgamegeek.com/thread/3477856','https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcF...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcFyuKjI/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477856','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/12EFYrPWLLwclU8i-xWRSiSmppcFyuKjI/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477856' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('422','rules','https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf_2Au1/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (422,(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf_2Au1/view?usp=sharing'),'https://boardgamegeek.com/thread/3477856','https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf_2Au1/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477856','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://drive.google.com/file/d/1esuchwy32Ke55ba3oV-TAm28dgf_2Au1/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477856' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('422','online_play','https://playingcards.io/7qjhgh','playingcards.io','Room 1',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (422,(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/7qjhgh'),'https://boardgamegeek.com/thread/3477856','Room 1','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/7qjhgh'),'2026-10-04','https://boardgamegeek.com/thread/3477856','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/7qjhgh') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477856' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('422','online_play','https://playingcards.io/z9kxv8','playingcards.io','Room 2',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (422,(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/z9kxv8'),'https://boardgamegeek.com/thread/3477856','Room 2','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/z9kxv8'),'2026-10-04','https://boardgamegeek.com/thread/3477856','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://playingcards.io/z9kxv8') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477856' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('422','video','https://youtube.com/watch?v=m81DyUR9LTE','youtube.com','Mutineer (Digital Playthrough)',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (422,(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://youtube.com/watch?v=m81DyUR9LTE'),'https://boardgamegeek.com/thread/3477856','Mutineer (Digital Playthrough)','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=422 AND url='https://youtube.com/watch?v=m81DyUR9LTE'),'2026-10-04','https://boardgamegeek.com/thread/3477856','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=422 AND url='https://youtube.com/watch?v=m81DyUR9LTE') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477856' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '422','printable_component','carte: cards] - on [1] A4 letter size Double sided PDF sheet','[9 cards] - on [1] A4 letter size Double sided PDF sheet','9','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 3 Pages A4 Letter size PDF
[9] - d6 dice [4 Black, 5 White]
[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]
[1] - Wood cube [1 Red]','https://boardgamegeek.com/thread/3477856','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '422' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] A4 letter size Double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477856');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '422','rules','regolamento: RULES - 3 Pages A4 Letter size PDF','[1] - RULES - 3 Pages A4 Letter size PDF','1','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 3 Pages A4 Letter size PDF
[9] - d6 dice [4 Black, 5 White]
[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]
[1] - Wood cube [1 Red]','https://boardgamegeek.com/thread/3477856','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '422' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 3 Pages A4 Letter size PDF' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477856');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '422','randomizer','dadi: d6 dice [4 Black, 5 White]','[9] - d6 dice [4 Black, 5 White]','9','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 3 Pages A4 Letter size PDF
[9] - d6 dice [4 Black, 5 White]
[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]
[1] - Wood cube [1 Red]','https://boardgamegeek.com/thread/3477856','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '422' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice [4 Black, 5 White]' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477856');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '422','token_marker','segnalini: – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]','[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]','8','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 3 Pages A4 Letter size PDF
[9] - d6 dice [4 Black, 5 White]
[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]
[1] - Wood cube [1 Red]','https://boardgamegeek.com/thread/3477856','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '422' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477856');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '422','token_marker','segnalini: Wood cube [1 Red]','[1] - Wood cube [1 Red]','1','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 3 Pages A4 Letter size PDF
[9] - d6 dice [4 Black, 5 White]
[8] – Plastic discs [4 Gold/Yellow, 4 Silver/Grey]
[1] - Wood cube [1 Red]','https://boardgamegeek.com/thread/3477856','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '422' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wood cube [1 Red]' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477856');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3457895' WHERE id=423 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('423','2026-10-04','https://boardgamegeek.com/thread/3457895','found','TSK-0051; primo post originale soltanto; host non verificati. Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('423','2026-10-04','https://boardgamegeek.com/thread/3457895','found','TSK-0051; primo post originale soltanto; host non verificati. Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('423','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3457895','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('423','game_files','https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg9hJygqHfk6qE?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (423,(SELECT id FROM remote_resources WHERE game_id=423 AND url='https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg9hJygqHfk6qE?usp=sharing'),'https://boardgamegeek.com/thread/3457895','https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=423 AND url='https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg9hJygqHfk6qE?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3457895','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=423 AND url='https://drive.google.com/drive/folders/1MYZowfUKAP3Org3Wjrzg9hJygqHfk6qE?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3457895' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('423','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3407128788','steamcommunity.com','Here!',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (423,(SELECT id FROM remote_resources WHERE game_id=423 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3407128788'),'https://boardgamegeek.com/thread/3457895','Here!','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=423 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3407128788'),'2026-10-04','https://boardgamegeek.com/thread/3457895','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Autrice: ora Nine Tails: A Solitaire Game; file gratuiti rimossi da Google Drive per uscita Game Crafter; modulo TTS dichiarato ancora disponibile con arte originale. Nessuna verifica host. Introduzione 10 carte/5 token e lista 9 carte/6 token preservate come versioni discordanti.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=423 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3407128788') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3457895' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '423','printable_component','carte: double-sided cards','9 double-sided cards','9','required','printable',':
9 double-sided cards
6 Rest Tokens
1 Direction Arrow
Rulebook
Tuckbox (optional)','https://boardgamegeek.com/thread/3457895','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '423' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457895');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '423','token_marker','segnalini: Rest Tokens','6 Rest Tokens','6','required','common',':
9 double-sided cards
6 Rest Tokens
1 Direction Arrow
Rulebook
Tuckbox (optional)','https://boardgamegeek.com/thread/3457895','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '423' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Rest Tokens' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457895');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '423','token_marker','segnalini: Direction Arrow','1 Direction Arrow','1','required','common',':
9 double-sided cards
6 Rest Tokens
1 Direction Arrow
Rulebook
Tuckbox (optional)','https://boardgamegeek.com/thread/3457895','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '423' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Direction Arrow' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457895');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '423','rules','regolamento: Rulebook','Rulebook',NULL,'required','printable',':
9 double-sided cards
6 Rest Tokens
1 Direction Arrow
Rulebook
Tuckbox (optional)','https://boardgamegeek.com/thread/3457895','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '423' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457895');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '423','printable_component','scatola: Tuckbox (optional)','Tuckbox (optional)',NULL,'optional','printable',':
9 double-sided cards
6 Rest Tokens
1 Direction Arrow
Rulebook
Tuckbox (optional)','https://boardgamegeek.com/thread/3457895','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '423' AND material_kind IS 'printable_component' AND name_normalized IS 'scatola: Tuckbox (optional)' AND quantity_raw IS NULL AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3457895');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3446445' WHERE id=424 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('424','2026-10-04','https://boardgamegeek.com/thread/3446445','found','TSK-0051; primo post originale soltanto; host non verificati. Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('424','2026-10-04','https://boardgamegeek.com/thread/3446445','found','TSK-0051; primo post originale soltanto; host non verificati. Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('424','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3446445','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('424','component','https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8KzeTJg/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8K...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (424,(SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8KzeTJg/view?usp=sharing'),'https://boardgamegeek.com/thread/3446445','https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8K...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8KzeTJg/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3446445','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1DFdVa9BQfenjFYBiAetLX_Huf8KzeTJg/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446445' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('424','rules','https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89balSKj_/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89ba...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (424,(SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89balSKj_/view?usp=sharing'),'https://boardgamegeek.com/thread/3446445','https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89ba...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89balSKj_/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3446445','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Download links Version 4.2. Penna o alternativa pennarello cancellabile su carte imbustate.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=424 AND url='https://drive.google.com/file/d/1JZXLkDlTpLSK1fZdN4udrdx89balSKj_/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3446445' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '424','printable_component','carte: double-sided cards','9 double-sided cards','9','required','printable','9 double-sided cards
1 pen (player can alternatively use a dry erase marker on sleeved cards)
1 rules document','https://boardgamegeek.com/thread/3446445','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '424' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446445');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '424','writing_tool','strumento scrittura: pen (player can alternatively use a dry erase marker on sleeved cards)','1 pen (player can alternatively use a dry erase marker on sleeved cards)','1','required','common','9 double-sided cards
1 pen (player can alternatively use a dry erase marker on sleeved cards)
1 rules document','https://boardgamegeek.com/thread/3446445','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '424' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: pen (player can alternatively use a dry erase marker on sleeved cards)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446445');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '424','rules','regolamento: rules document','1 rules document','1','required','printable','9 double-sided cards
1 pen (player can alternatively use a dry erase marker on sleeved cards)
1 rules document','https://boardgamegeek.com/thread/3446445','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '424' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: rules document' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3446445');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479007' WHERE id=425 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('425','2026-10-04','https://boardgamegeek.com/thread/3479007','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('425','2026-10-04','https://boardgamegeek.com/thread/3479007','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('425','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479007','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('425','game_files','https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUWLj0wOxxEnhu4?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUW...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (425,(SELECT id FROM remote_resources WHERE game_id=425 AND url='https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUWLj0wOxxEnhu4?usp=sharing'),'https://boardgamegeek.com/thread/3479007','https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUW... | https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUW... | https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUW...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=425 AND url='https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUWLj0wOxxEnhu4?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479007','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=425 AND url='https://drive.google.com/drive/folders/1RVVxLy7rmEZCNZz9WMUWLj0wOxxEnhu4?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479007' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('425','online_play','https://tabletopia.com/games/obscurum-nusu6a/play-now','tabletopia.com','https://tabletopia.com/games/obscurum-nusu6a/play-now',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (425,(SELECT id FROM remote_resources WHERE game_id=425 AND url='https://tabletopia.com/games/obscurum-nusu6a/play-now'),'https://boardgamegeek.com/thread/3479007','https://tabletopia.com/games/obscurum-nusu6a/play-now','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=425 AND url='https://tabletopia.com/games/obscurum-nusu6a/play-now'),'2026-10-04','https://boardgamegeek.com/thread/3479007','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=425 AND url='https://tabletopia.com/games/obscurum-nusu6a/play-now') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479007' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','printable_component','carte: double-sided dungeon cards.','7 double-sided dungeon cards.','7','required','printable','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided dungeon cards.' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','printable_component','carte: player cards.','2 player cards.','2','required','printable','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: player cards.' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','randomizer','dadi: dice','2 dice','2','required','common','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','token_marker','segnalini: Up to 20 coloured cubes for tracking a variety of stats and found runes.','Up to 20 coloured cubes for tracking a variety of stats and found runes.','Up to 20','required','common','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Up to 20 coloured cubes for tracking a variety of stats and found runes.' AND quantity_raw IS 'Up to 20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','token_marker','segnalini: tokens of different colour to represent the wizards.','2 tokens of different colour to represent the wizards.','2','required','common','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: tokens of different colour to represent the wizards.' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','rules','regolamento: Rulebook','Rulebook',NULL,'required','printable','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '425','player_aid','foglio riferimento: Reference sheet','Reference sheet',NULL,'required','printable','• 7 double-sided dungeon cards.
• 2 player cards.
• 2 dice
• Up to 20 coloured cubes for tracking a variety of stats and found runes.
• 2 tokens of different colour to represent the wizards.
• Rulebook
• Reference sheet','https://boardgamegeek.com/thread/3479007','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '425' AND material_kind IS 'player_aid' AND name_normalized IS 'foglio riferimento: Reference sheet' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479007');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3442893' WHERE id=426 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('426','2026-10-04','https://boardgamegeek.com/thread/3442893','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('426','2026-10-04','https://boardgamegeek.com/thread/3442893','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('426','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3442893','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('426','rules','https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON9QlMf/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (426,(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON9QlMf/view?usp=sharing'),'https://boardgamegeek.com/thread/3442893','https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON9QlMf/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3442893','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/14x-GZ_uJ-Z7N8XVfP0OmRXElKON9QlMf/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3442893' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('426','component','https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z-fmfT/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (426,(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z-fmfT/view?usp=sharing'),'https://boardgamegeek.com/thread/3442893','https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z-fmfT/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3442893','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1O-XR2p6HvGvPcgxCObcRpBhY96z-fmfT/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3442893' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('426','component','https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7qlc-hnq/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7ql...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (426,(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7qlc-hnq/view?usp=sharing'),'https://boardgamegeek.com/thread/3442893','https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7ql...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7qlc-hnq/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3442893','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1RWUmYkpUsUh0wEFV5h__iepx7qlc-hnq/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3442893' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('426','rules','https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZqrPQlz/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZq...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (426,(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZqrPQlz/view?usp=sharing'),'https://boardgamegeek.com/thread/3442893','https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZq...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZqrPQlz/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3442893','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=426 AND url='https://drive.google.com/file/d/1lMcYsRvWkE4cW4xQrKTFnJpRkZqrPQlz/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3442893' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '426','rules','regolamento: rule book','1 rule book','1','required','printable','1 rule book
9 cards
1 d6 dice
4 turtle tokens
18 tokens: 6 orange, 6 purple, 6 white','https://boardgamegeek.com/thread/3442893','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '426' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: rule book' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3442893');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '426','printable_component','carte: cards','9 cards','9','required','printable','1 rule book
9 cards
1 d6 dice
4 turtle tokens
18 tokens: 6 orange, 6 purple, 6 white','https://boardgamegeek.com/thread/3442893','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '426' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3442893');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '426','randomizer','dadi: d6 dice','1 d6 dice','1','required','common','1 rule book
9 cards
1 d6 dice
4 turtle tokens
18 tokens: 6 orange, 6 purple, 6 white','https://boardgamegeek.com/thread/3442893','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '426' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3442893');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '426','token_marker','segnalini: turtle tokens','4 turtle tokens','4','required','common','1 rule book
9 cards
1 d6 dice
4 turtle tokens
18 tokens: 6 orange, 6 purple, 6 white','https://boardgamegeek.com/thread/3442893','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '426' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: turtle tokens' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3442893');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '426','token_marker','segnalini: tokens: 6 orange, 6 purple, 6 white','18 tokens: 6 orange, 6 purple, 6 white','18','required','common','1 rule book
9 cards
1 d6 dice
4 turtle tokens
18 tokens: 6 orange, 6 purple, 6 white','https://boardgamegeek.com/thread/3442893','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '426' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: tokens: 6 orange, 6 purple, 6 white' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3442893');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3436697' WHERE id=427 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('427','2026-10-04','https://boardgamegeek.com/thread/3436697','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('427','2026-10-04','https://boardgamegeek.com/thread/3436697','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('427','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3436697','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('427','game_files','https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nNuq-2R_sBjax0?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nN...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (427,(SELECT id FROM remote_resources WHERE game_id=427 AND url='https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nNuq-2R_sBjax0?usp=sharing'),'https://boardgamegeek.com/thread/3436697','https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nN...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=427 AND url='https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nNuq-2R_sBjax0?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3436697','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=427 AND url='https://drive.google.com/drive/folders/1lGkPx_sxTHMSpaMfn6nNuq-2R_sBjax0?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3436697' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '427','printable_component','carte mutanti/nemici','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','6','required','printable','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','https://boardgamegeek.com/thread/3436697','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '427' AND material_kind IS 'printable_component' AND name_normalized IS 'carte mutanti/nemici' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436697');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '427','printable_component','carta core','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','1','required','printable','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','https://boardgamegeek.com/thread/3436697','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '427' AND material_kind IS 'printable_component' AND name_normalized IS 'carta core' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436697');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '427','printable_component','carta knight','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','1','required','printable','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','https://boardgamegeek.com/thread/3436697','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '427' AND material_kind IS 'printable_component' AND name_normalized IS 'carta knight' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436697');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '427','printable_component','carta fear','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','1','required','printable','6 Mutant/Enemy Cards, 1 Core Card, 1 Knight Card, 1 Fear Card','https://boardgamegeek.com/thread/3436697','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '427' AND material_kind IS 'printable_component' AND name_normalized IS 'carta fear' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436697');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3475151' WHERE id=428 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('428','2026-10-04','https://boardgamegeek.com/thread/3475151','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('428','2026-10-04','https://boardgamegeek.com/thread/3475151','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('428','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3475151','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('428','rules','https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiexwsKSrX0b84DvnGtZ2_E/edit?usp=sharing','docs.google.com','https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiex...',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (428,(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiexwsKSrX0b84DvnGtZ2_E/edit?usp=sharing'),'https://boardgamegeek.com/thread/3475151','https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiex...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=428 AND url='https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiexwsKSrX0b84DvnGtZ2_E/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3475151','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://docs.google.com/document/d/1vWmhp9WVvCX12pEtNuczpiexwsKSrX0b84DvnGtZ2_E/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475151' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('428','component','https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6SxnmMKvjy/view?usp=drive_link','drive.google.com','https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6Sxnm...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (428,(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6SxnmMKvjy/view?usp=drive_link'),'https://boardgamegeek.com/thread/3475151','https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6Sxnm...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=428 AND url='https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6SxnmMKvjy/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3475151','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://drive.google.com/file/d/1dZl5XBMN2gUyFTJ1f12Gvb6SxnmMKvjy/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475151' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('428','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3439575164','steamcommunity.com','https://steamcommunity.com/sharedfiles/filedetails/?id=34395...',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (428,(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439575164'),'https://boardgamegeek.com/thread/3475151','https://steamcommunity.com/sharedfiles/filedetails/?id=34395...','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=428 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439575164'),'2026-10-04','https://boardgamegeek.com/thread/3475151','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=428 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439575164') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3475151' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '428','printable_component','carte: cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on ','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)','9','required','printable','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)
[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet
[4] – d6 dice [3 Orange, 1 Green]
[2] – Large Meeples or Pawns [1 Blue, 1 Purple]
[18] – Meeples [6 Orange, 12 Green]','https://boardgamegeek.com/thread/3475151','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '428' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on ' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475151');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '428','rules','regolamento: – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet','[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet','1','required','printable','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)
[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet
[4] – d6 dice [3 Orange, 1 Green]
[2] – Large Meeples or Pawns [1 Blue, 1 Purple]
[18] – Meeples [6 Orange, 12 Green]','https://boardgamegeek.com/thread/3475151','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '428' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475151');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '428','randomizer','dadi: – d6 dice [3 Orange, 1 Green]','[4] – d6 dice [3 Orange, 1 Green]','4','required','common','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)
[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet
[4] – d6 dice [3 Orange, 1 Green]
[2] – Large Meeples or Pawns [1 Blue, 1 Purple]
[18] – Meeples [6 Orange, 12 Green]','https://boardgamegeek.com/thread/3475151','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '428' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: – d6 dice [3 Orange, 1 Green]' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475151');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '428','token_marker','segnalini: – Large Meeples or Pawns [1 Blue, 1 Purple]','[2] – Large Meeples or Pawns [1 Blue, 1 Purple]','2','required','common','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)
[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet
[4] – d6 dice [3 Orange, 1 Green]
[2] – Large Meeples or Pawns [1 Blue, 1 Purple]
[18] – Meeples [6 Orange, 12 Green]','https://boardgamegeek.com/thread/3475151','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '428' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: – Large Meeples or Pawns [1 Blue, 1 Purple]' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475151');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '428','token_marker','segnalini: – Meeples [6 Orange, 12 Green]','[18] – Meeples [6 Orange, 12 Green]','18','required','common','[9 cards] – on [1] A4 letter size Double sided PDF Sheet (set-up for inkjet printer, flip and print on long edge)
[1] – Rules – 5 pages A4 Letter size Double-sided PDF with the last page as a reference sheet
[4] – d6 dice [3 Orange, 1 Green]
[2] – Large Meeples or Pawns [1 Blue, 1 Purple]
[18] – Meeples [6 Orange, 12 Green]','https://boardgamegeek.com/thread/3475151','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '428' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: – Meeples [6 Orange, 12 Green]' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475151');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3466979' WHERE id=429 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('429','2026-10-04','https://boardgamegeek.com/thread/3466979','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('429','2026-10-04','https://boardgamegeek.com/thread/3466979','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('429','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3466979','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('429','player_aid','https://docs.google.com/document/d/19aqqmxVA1x5uIK3hwBjmjeUaRnSKGwH5zyw45EFdbFE/edit?usp=sharing','docs.google.com','Front/Back Reference Sheet',NULL,'unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (429,(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/19aqqmxVA1x5uIK3hwBjmjeUaRnSKGwH5zyw45EFdbFE/edit?usp=sharing'),'https://boardgamegeek.com/thread/3466979','Front/Back Reference Sheet','player_aid',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/19aqqmxVA1x5uIK3hwBjmjeUaRnSKGwH5zyw45EFdbFE/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3466979','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/19aqqmxVA1x5uIK3hwBjmjeUaRnSKGwH5zyw45EFdbFE/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3466979' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('429','rules','https://docs.google.com/document/d/1ISZqDaR_sCS3epO39IZpHSR1LDOlIxQYhoGjpwzXs7k/edit?usp=sharing','docs.google.com','Rules - v1.0 Updated 4/15/25','v1.0','unknown','2026-10-04','2026-10-04','document');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (429,(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/1ISZqDaR_sCS3epO39IZpHSR1LDOlIxQYhoGjpwzXs7k/edit?usp=sharing'),'https://boardgamegeek.com/thread/3466979','Rules - v1.0 Updated 4/15/25','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/1ISZqDaR_sCS3epO39IZpHSR1LDOlIxQYhoGjpwzXs7k/edit?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3466979','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://docs.google.com/document/d/1ISZqDaR_sCS3epO39IZpHSR1LDOlIxQYhoGjpwzXs7k/edit?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3466979' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('429','component','https://drive.google.com/file/d/1WaTHl-xvQqjdtoDdjkVo3xJqa4ZBDZDr/view?usp=sharing','drive.google.com','Game Components v1.1 4/15/25','v1.1','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (429,(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://drive.google.com/file/d/1WaTHl-xvQqjdtoDdjkVo3xJqa4ZBDZDr/view?usp=sharing'),'https://boardgamegeek.com/thread/3466979','Game Components v1.1 4/15/25','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=429 AND url='https://drive.google.com/file/d/1WaTHl-xvQqjdtoDdjkVo3xJqa4ZBDZDr/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3466979','declared_in_wip','not_checked','v1.1','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=429 AND url='https://drive.google.com/file/d/1WaTHl-xvQqjdtoDdjkVo3xJqa4ZBDZDr/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3466979' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '429','printable_component','carte: cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)','[8 cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)','8','required','printable','[8 cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)
[1]- RULES- work in progress, linked
[up to 21]- d6 dice, 10 for solo play, 5 per player
[3]- custom tokens/trackers cut from a printed card','https://boardgamegeek.com/thread/3466979','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '429' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3466979');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '429','rules','regolamento: RULES- work in progress, linked','[1]- RULES- work in progress, linked','1','required','printable','[8 cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)
[1]- RULES- work in progress, linked
[up to 21]- d6 dice, 10 for solo play, 5 per player
[3]- custom tokens/trackers cut from a printed card','https://boardgamegeek.com/thread/3466979','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '429' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES- work in progress, linked' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3466979');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '429','randomizer','dadi: up to 21]- d6 dice, 10 for solo play, 5 per player','[up to 21]- d6 dice, 10 for solo play, 5 per player','up to 21; 10 solo; 5 per player','required','common','[8 cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)
[1]- RULES- work in progress, linked
[up to 21]- d6 dice, 10 for solo play, 5 per player
[3]- custom tokens/trackers cut from a printed card','https://boardgamegeek.com/thread/3466979','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '429' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: up to 21]- d6 dice, 10 for solo play, 5 per player' AND quantity_raw IS 'up to 21; 10 solo; 5 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3466979');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '429','printable_component','carte: custom tokens/trackers cut from a printed card','[3]- custom tokens/trackers cut from a printed card','3','required','printable','[8 cards]- on [1] A4 letter size Double sided PDF Sheet (print flipping along long edge)
[1]- RULES- work in progress, linked
[up to 21]- d6 dice, 10 for solo play, 5 per player
[3]- custom tokens/trackers cut from a printed card','https://boardgamegeek.com/thread/3466979','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '429' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: custom tokens/trackers cut from a printed card' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3466979');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3453394' WHERE id=430 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('430','2026-10-04','https://boardgamegeek.com/thread/3453394','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('430','2026-10-04','https://boardgamegeek.com/thread/3453394','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('430','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3453394','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('430','game_files','https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3uO3gAZE5Mnhl?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (430,(SELECT id FROM remote_resources WHERE game_id=430 AND url='https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3uO3gAZE5Mnhl?usp=sharing'),'https://boardgamegeek.com/thread/3453394','https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=430 AND url='https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3uO3gAZE5Mnhl?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3453394','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=430 AND url='https://drive.google.com/drive/folders/1f9SB0roMVcu9A3-18HV3uO3gAZE5Mnhl?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453394' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('430','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3419879219','steamcommunity.com','https://steamcommunity.com/sharedfiles/filedetails/?id=34198...',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (430,(SELECT id FROM remote_resources WHERE game_id=430 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3419879219'),'https://boardgamegeek.com/thread/3453394','https://steamcommunity.com/sharedfiles/filedetails/?id=34198...','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=430 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3419879219'),'2026-10-04','https://boardgamegeek.com/thread/3453394','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=430 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3419879219') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453394' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '430','printable_component','carte: numbered cards (4x “4”, 3x “3”, 2x “2”)','9 numbered cards (4x “4”, 3x “3”, 2x “2”)','9','required','printable','9 numbered cards (4x “4”, 3x “3”, 2x “2”)','https://boardgamegeek.com/thread/3453394','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '430' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: numbered cards (4x “4”, 3x “3”, 2x “2”)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453394');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3461958' WHERE id=431 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('431','2026-10-04','https://boardgamegeek.com/thread/3461958','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('431','2026-10-04','https://boardgamegeek.com/thread/3461958','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('431','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3461958','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('431','component','https://www.bonthron.com/pennyPoltergeist/poltergeistCards.pdf','www.bonthron.com','Cards (pdf)',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (431,(SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistCards.pdf'),'https://boardgamegeek.com/thread/3461958','Cards (pdf)','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistCards.pdf'),'2026-10-04','https://boardgamegeek.com/thread/3461958','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistCards.pdf') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3461958' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('431','rules','https://www.bonthron.com/pennyPoltergeist/poltergeistRules.pdf','www.bonthron.com','Rules (pdf)',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (431,(SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistRules.pdf'),'https://boardgamegeek.com/thread/3461958','Rules (pdf)','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistRules.pdf'),'2026-10-04','https://boardgamegeek.com/thread/3461958','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=431 AND url='https://www.bonthron.com/pennyPoltergeist/poltergeistRules.pdf') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3461958' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '431','printable_component','carte: cards] letter size, PDF','[9 cards] letter size, PDF','9','required','printable','[9 cards] letter size, PDF
[Rules] on 14 pages letter size, PDF
[9 small tokens] your choice','https://boardgamegeek.com/thread/3461958','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '431' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] letter size, PDF' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461958');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '431','rules','regolamento: Rules] on 14 pages letter size, PDF','[Rules] on 14 pages letter size, PDF',NULL,'required','printable','[9 cards] letter size, PDF
[Rules] on 14 pages letter size, PDF
[9 small tokens] your choice','https://boardgamegeek.com/thread/3461958','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '431' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules] on 14 pages letter size, PDF' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461958');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '431','token_marker','segnalini: small tokens] your choice','[9 small tokens] your choice','9','required','common','[9 cards] letter size, PDF
[Rules] on 14 pages letter size, PDF
[9 small tokens] your choice','https://boardgamegeek.com/thread/3461958','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '431' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: small tokens] your choice' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461958');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3461354' WHERE id=432 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('432','2026-10-04','https://boardgamegeek.com/thread/3461354','found','TSK-0051; primo post originale soltanto; host non verificati. 23 token in 6 colori, ma la ripartizione (4,4,4,4,4,4,3) dà 27 in 7 gruppi. Sacchetto esplicitamente richiesto.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('432','2026-10-04','https://boardgamegeek.com/thread/3461354','found','TSK-0051; primo post originale soltanto; host non verificati. 23 token in 6 colori, ma la ripartizione (4,4,4,4,4,4,3) dà 27 in 7 gruppi. Sacchetto esplicitamente richiesto.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('432','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3461354','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. 23 token in 6 colori, ma la ripartizione (4,4,4,4,4,4,3) dà 27 in 7 gruppi. Sacchetto esplicitamente richiesto.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('432','game_files','https://drive.google.com/drive/folders/1PEUXIXNhEI8SANaYFYl0xE3iUCM9EOlx?usp=sharing','drive.google.com','Quick dishes Rules and Cards',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (432,(SELECT id FROM remote_resources WHERE game_id=432 AND url='https://drive.google.com/drive/folders/1PEUXIXNhEI8SANaYFYl0xE3iUCM9EOlx?usp=sharing'),'https://boardgamegeek.com/thread/3461354','Quick dishes Rules and Cards','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=432 AND url='https://drive.google.com/drive/folders/1PEUXIXNhEI8SANaYFYl0xE3iUCM9EOlx?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3461354','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 23 token in 6 colori, ma la ripartizione (4,4,4,4,4,4,3) dà 27 in 7 gruppi. Sacchetto esplicitamente richiesto.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=432 AND url='https://drive.google.com/drive/folders/1PEUXIXNhEI8SANaYFYl0xE3iUCM9EOlx?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3461354' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '432','printable_component','carte: Cards','9 Cards','9','required','printable','9 Cards
1 d6 Die
23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)','https://boardgamegeek.com/thread/3461354','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '432' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461354');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '432','randomizer','dadi: d6 Die','1 d6 Die','1','required','common','9 Cards
1 d6 Die
23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)','https://boardgamegeek.com/thread/3461354','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '432' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 Die' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461354');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '432','token_marker','token, ripartizione discordante','23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)','23','required','common','9 Cards
1 d6 Die
23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)','https://boardgamegeek.com/thread/3461354','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '432' AND material_kind IS 'token_marker' AND name_normalized IS 'token, ripartizione discordante' AND quantity_raw IS '23' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461354');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '432','container','sacchetto','23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)',NULL,'required','household','9 Cards
1 d6 Die
23 Tokens of 6 colours (4,4,4,4,4,4,3) (You will need a bag)','https://boardgamegeek.com/thread/3461354','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '432' AND material_kind IS 'container' AND name_normalized IS 'sacchetto' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461354');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3443351' WHERE id=433 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('433','2026-10-04','https://boardgamegeek.com/thread/3443351','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('433','2026-10-04','https://boardgamegeek.com/thread/3443351','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('433','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3443351','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('433','game_files','https://drive.google.com/drive/folders/1aQTr6vgXex3ktNPhgYN0AFScx2la5_as','drive.google.com','Rapid Words',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (433,(SELECT id FROM remote_resources WHERE game_id=433 AND url='https://drive.google.com/drive/folders/1aQTr6vgXex3ktNPhgYN0AFScx2la5_as'),'https://boardgamegeek.com/thread/3443351','Rapid Words','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=433 AND url='https://drive.google.com/drive/folders/1aQTr6vgXex3ktNPhgYN0AFScx2la5_as'),'2026-10-04','https://boardgamegeek.com/thread/3443351','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=433 AND url='https://drive.google.com/drive/folders/1aQTr6vgXex3ktNPhgYN0AFScx2la5_as') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3443351' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('433','online_play','https://playingcards.io/eysjmm','playingcards.io','Rapid Words',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (433,(SELECT id FROM remote_resources WHERE game_id=433 AND url='https://playingcards.io/eysjmm'),'https://boardgamegeek.com/thread/3443351','Rapid Words','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=433 AND url='https://playingcards.io/eysjmm'),'2026-10-04','https://boardgamegeek.com/thread/3443351','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=433 AND url='https://playingcards.io/eysjmm') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3443351' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '433','printable_component','carte: cards] - on [1] A4 letter size Double sided PDF sheet','[9 cards] - on [1] A4 letter size Double sided PDF sheet','9','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 8 Pages A4 Letter size PDF
[1] - d6 die
[18] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3443351','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '433' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] A4 letter size Double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3443351');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '433','rules','regolamento: RULES - 8 Pages A4 Letter size PDF','[1] - RULES - 8 Pages A4 Letter size PDF','1','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 8 Pages A4 Letter size PDF
[1] - d6 die
[18] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3443351','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '433' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 8 Pages A4 Letter size PDF' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3443351');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '433','randomizer','dadi: d6 die','[1] - d6 die','1','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 8 Pages A4 Letter size PDF
[1] - d6 die
[18] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3443351','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '433' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 die' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3443351');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '433','token_marker','segnalini: Wood cubes - [Any color]','[18] - Wood cubes - [Any color]','18','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - 8 Pages A4 Letter size PDF
[1] - d6 die
[18] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3443351','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '433' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wood cubes - [Any color]' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3443351');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479685' WHERE id=434 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('434','2026-10-04','https://boardgamegeek.com/thread/3479685','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('434','2026-10-04','https://boardgamegeek.com/thread/3479685','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('434','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479685','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('434','game_files','https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGyuGROS/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGy...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (434,(SELECT id FROM remote_resources WHERE game_id=434 AND url='https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGyuGROS/view?usp=sharing'),'https://boardgamegeek.com/thread/3479685','https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGy...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=434 AND url='https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGyuGROS/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479685','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=434 AND url='https://drive.google.com/file/d/1M6on1vgfI3b_j5isL2D5guDTaGyuGROS/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479685' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('434','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3440149660','steamcommunity.com','https://steamcommunity.com/sharedfiles/filedetails/?id=34401...',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (434,(SELECT id FROM remote_resources WHERE game_id=434 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3440149660'),'https://boardgamegeek.com/thread/3479685','https://steamcommunity.com/sharedfiles/filedetails/?id=34401...','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=434 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3440149660'),'2026-10-04','https://boardgamegeek.com/thread/3479685','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=434 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3440149660') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479685' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','printable_component','carte: Cards','9 Cards','9','required','printable','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','randomizer','dadi: D4 Dice','8 D4 Dice','8','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: D4 Dice' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','randomizer','dadi: D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.','8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.','8','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','randomizer','dadi: D6 Dice','2 D6 Dice','2','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: D6 Dice' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','token_marker','segnalini: Meeples [1 Red, 1 Yellow]','2 Meeples [1 Red, 1 Yellow]','2','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Meeples [1 Red, 1 Yellow]' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','token_marker','segnalini: Scoring Cubes [1 Red, 1 Yellow]','2 Scoring Cubes [1 Red, 1 Yellow]','2','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Scoring Cubes [1 Red, 1 Yellow]' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '434','token_marker','segnalini: Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','2','required','common','9 Cards
8 D4 Dice
8 D10 Dice [2 Red, 2 Greed, 2 White/Clear, 2 Brown], Spin-downs are preferable.
2 D6 Dice
2 Meeples [1 Red, 1 Yellow]
2 Scoring Cubes [1 Red, 1 Yellow]
2 Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.','https://boardgamegeek.com/thread/3479685','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '434' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Discs [1 Red, 1 Yellow], These can be replaced with cubes if desired.' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479685');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3436550' WHERE id=435 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('435','2026-10-04','https://boardgamegeek.com/thread/3436550','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('435','2026-10-04','https://boardgamegeek.com/thread/3436550','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('435','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3436550','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('435','game_files','https://drive.google.com/drive/folders/1mgNNVzrf60f4MivHyhZYkjC_fbC8pfN5?usp=sharing','drive.google.com','Royal Courier Folder',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (435,(SELECT id FROM remote_resources WHERE game_id=435 AND url='https://drive.google.com/drive/folders/1mgNNVzrf60f4MivHyhZYkjC_fbC8pfN5?usp=sharing'),'https://boardgamegeek.com/thread/3436550','Royal Courier Folder','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=435 AND url='https://drive.google.com/drive/folders/1mgNNVzrf60f4MivHyhZYkjC_fbC8pfN5?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3436550','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=435 AND url='https://drive.google.com/drive/folders/1mgNNVzrf60f4MivHyhZYkjC_fbC8pfN5?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3436550' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '435','printable_component','carte','Rules and Cards are in the Folder Below',NULL,'required','printable','Rules and Cards are in the Folder Below','https://boardgamegeek.com/thread/3436550','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '435' AND material_kind IS 'printable_component' AND name_normalized IS 'carte' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3436550');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '435','rules','regolamento','Rules and Cards are in the Folder Below',NULL,'unclear','printable','Rules and Cards are in the Folder Below','https://boardgamegeek.com/thread/3436550','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '435' AND material_kind IS 'rules' AND name_normalized IS 'regolamento' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3436550');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3471323' WHERE id=436 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('436','2026-10-04','https://boardgamegeek.com/thread/3471323','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('436','2026-10-04','https://boardgamegeek.com/thread/3471323','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('436','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3471323','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('436','game_files','https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5azmyuzTU-B-Pj','drive.google.com','https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5a...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (436,(SELECT id FROM remote_resources WHERE game_id=436 AND url='https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5azmyuzTU-B-Pj'),'https://boardgamegeek.com/thread/3471323','https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5a...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=436 AND url='https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5azmyuzTU-B-Pj'),'2026-10-04','https://boardgamegeek.com/thread/3471323','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=436 AND url='https://drive.google.com/drive/folders/1ew2vRq_Uo4ZYZz68BO5azmyuzTU-B-Pj') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3471323' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '436','printable_component','carte: cards] - on [1] A4 letter size Double sided sheet.','[9 cards] - on [1] A4 letter size Double sided sheet.','9','required','printable','[9 cards] - on [1] A4 letter size Double sided sheet.
[24] Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.
[1] - RULES - 2 pieces of A4 paper','https://boardgamegeek.com/thread/3471323','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '436' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] A4 letter size Double sided sheet.' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3471323');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '436','token_marker','segnalini: Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.','[24] Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.','24','required','common','[9 cards] - on [1] A4 letter size Double sided sheet.
[24] Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.
[1] - RULES - 2 pieces of A4 paper','https://boardgamegeek.com/thread/3471323','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '436' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3471323');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '436','rules','regolamento: RULES - 2 pieces of A4 paper','[1] - RULES - 2 pieces of A4 paper','1','required','printable','[9 cards] - on [1] A4 letter size Double sided sheet.
[24] Plastic/wooden discs, [8] of each colour: Blue, Green, Yellow.
[1] - RULES - 2 pieces of A4 paper','https://boardgamegeek.com/thread/3471323','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '436' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 2 pieces of A4 paper' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3471323');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3453464' WHERE id=437 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('437','2026-10-04','https://boardgamegeek.com/thread/3453464','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('437','2026-10-04','https://boardgamegeek.com/thread/3453464','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('437','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3453464','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('437','game_files','https://drive.google.com/drive/folders/1buVyoIiu9ENUrTxm01xHJssVwIBESiTs?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (437,(SELECT id FROM remote_resources WHERE game_id=437 AND url='https://drive.google.com/drive/folders/1buVyoIiu9ENUrTxm01xHJssVwIBESiTs?usp=sharing'),'https://boardgamegeek.com/thread/3453464','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=437 AND url='https://drive.google.com/drive/folders/1buVyoIiu9ENUrTxm01xHJssVwIBESiTs?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3453464','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=437 AND url='https://drive.google.com/drive/folders/1buVyoIiu9ENUrTxm01xHJssVwIBESiTs?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3453464' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','token_marker','segnalini: airship meeple','4x airship meeple','4','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: airship meeple' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d6 flight die','4x d6 flight die','4','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 flight die' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d6 pickup die','4x d6 pickup die','4','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 pickup die' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d6 effect die','4x d6 effect die','4','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 effect die' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d6 scoring die','4x d6 scoring die','4','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 scoring die' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d6 challenge die','1x d6 challenge die','1','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 challenge die' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','randomizer','dadi: d10 delivery die','1x d10 delivery die','1','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d10 delivery die' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','token_marker','segnalini: lucky coin','1x lucky coin','1','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: lucky coin' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','token_marker','segnalini: wind token','1x wind token','1','required','common','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: wind token' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','printable_component','carte: location card','8x location card','8','required','printable','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: location card' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','printable_component','carte: hangar card','1x hangar card','1','required','printable','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: hangar card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '437','rules','regolamento: rules','rules',NULL,'required','printable','- 4x airship meeple
- 4x d6 flight die
- 4x d6 pickup die
- 4x d6 effect die
- 4x d6 scoring die
- 1x d6 challenge die
- 1x d10 delivery die
- 1x lucky coin
- 1x wind token

- 8x location card
- 1x hangar card

- rules','https://boardgamegeek.com/thread/3453464','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '437' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: rules' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3453464');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3472477' WHERE id=438 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('438','2026-10-04','https://boardgamegeek.com/thread/3472477','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('438','2026-10-04','https://boardgamegeek.com/thread/3472477','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('438','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3472477','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('438','game_files','https://drive.google.com/drive/folders/1oLIMmXE0YW79dmZgSeMVxsc6v9szljKc?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (438,(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://drive.google.com/drive/folders/1oLIMmXE0YW79dmZgSeMVxsc6v9szljKc?usp=sharing'),'https://boardgamegeek.com/thread/3472477','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=438 AND url='https://drive.google.com/drive/folders/1oLIMmXE0YW79dmZgSeMVxsc6v9szljKc?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3472477','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://drive.google.com/drive/folders/1oLIMmXE0YW79dmZgSeMVxsc6v9szljKc?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3472477' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('438','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3439696608','steamcommunity.com','https://steamcommunity.com/sharedfiles/filedetails/?id=34396...',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (438,(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439696608'),'https://boardgamegeek.com/thread/3472477','https://steamcommunity.com/sharedfiles/filedetails/?id=34396...','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=438 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439696608'),'2026-10-04','https://boardgamegeek.com/thread/3472477','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3439696608') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3472477' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('438','video','https://youtube.com/watch?v=7UWtkwXvl1Q','youtube.com','',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (438,(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=7UWtkwXvl1Q'),'https://boardgamegeek.com/thread/3472477','','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=7UWtkwXvl1Q'),'2026-10-04','https://boardgamegeek.com/thread/3472477','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=7UWtkwXvl1Q') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3472477' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('438','video','https://youtube.com/watch?v=Q_ZfxD4TYkU','youtube.com','SLAYER POCKET EDITION - PROLOGUE #scary #horror #horrorstories',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (438,(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=Q_ZfxD4TYkU'),'https://boardgamegeek.com/thread/3472477','SLAYER POCKET EDITION - PROLOGUE #scary #horror #horrorstories','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=Q_ZfxD4TYkU'),'2026-10-04','https://boardgamegeek.com/thread/3472477','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=438 AND url='https://youtube.com/watch?v=Q_ZfxD4TYkU') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3472477' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','printable_component','carte: Player cards','2 Player cards','2','required','printable','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Player cards' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','printable_component','carte: Killer card','1 Killer card','1','required','printable','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Killer card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','printable_component','carte: Basic scenaries cards','4 Basic scenaries cards','4','required','printable','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Basic scenaries cards' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','printable_component','carte: Escenary "end of act I" cards','2 Escenary "end of act I" cards','2','required','printable','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Escenary "end of act I" cards' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','token_marker','segnalini: Meeple player (different color)','2 Meeple player (different color)','2','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Meeple player (different color)' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','token_marker','segnalini: Meeple killer','1 Meeple killer','1','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Meeple killer' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','token_marker','segnalini: red cubes','11 red cubes','11','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: red cubes' AND quantity_raw IS '11' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','token_marker','segnalini: green cubes','2 green cubes','2','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: green cubes' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','token_marker','segnalini: black cubes','4 black cubes','4','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: black cubes' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '438','randomizer','dadi: dices d4','4 dices d4','4','required','common','- 2 Player cards
- 1 Killer card
- 4 Basic scenaries cards
- 2 Escenary "end of act I" cards
- 2 Meeple player (different color)
- 1 Meeple killer
- 11 red cubes
- 2 green cubes
- 4 black cubes
- 4 dices d4','https://boardgamegeek.com/thread/3472477','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '438' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dices d4' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472477');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3476092' WHERE id=439 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('439','2026-10-04','https://boardgamegeek.com/thread/3476092','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('439','2026-10-04','https://boardgamegeek.com/thread/3476092','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('439','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3476092','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('439','game_files','https://drive.google.com/drive/folders/1XigCelLvY--yS3z2ga3N3G0pAWSoSSCk?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (439,(SELECT id FROM remote_resources WHERE game_id=439 AND url='https://drive.google.com/drive/folders/1XigCelLvY--yS3z2ga3N3G0pAWSoSSCk?usp=sharing'),'https://boardgamegeek.com/thread/3476092','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=439 AND url='https://drive.google.com/drive/folders/1XigCelLvY--yS3z2ga3N3G0pAWSoSSCk?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3476092','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=439 AND url='https://drive.google.com/drive/folders/1XigCelLvY--yS3z2ga3N3G0pAWSoSSCk?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3476092' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '439','printable_component','carte: Mission cards','7 Mission cards','7','required','printable','7 Mission cards
1 Suspicion card
1 Credit card
18 cubes in 3 different colors (6 of each color)
1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','https://boardgamegeek.com/thread/3476092','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '439' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Mission cards' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476092');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '439','printable_component','carte: Suspicion card','1 Suspicion card','1','required','printable','7 Mission cards
1 Suspicion card
1 Credit card
18 cubes in 3 different colors (6 of each color)
1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','https://boardgamegeek.com/thread/3476092','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '439' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Suspicion card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476092');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '439','printable_component','carte: Credit card','1 Credit card','1','required','printable','7 Mission cards
1 Suspicion card
1 Credit card
18 cubes in 3 different colors (6 of each color)
1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','https://boardgamegeek.com/thread/3476092','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '439' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Credit card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476092');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '439','token_marker','segnalini: cubes in 3 different colors (6 of each color)','18 cubes in 3 different colors (6 of each color)','18','required','common','7 Mission cards
1 Suspicion card
1 Credit card
18 cubes in 3 different colors (6 of each color)
1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','https://boardgamegeek.com/thread/3476092','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '439' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes in 3 different colors (6 of each color)' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476092');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '439','container','contenitore: bag or cup (optional) or use your hand for random blind drawing of cargo cubes','1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','1','optional','household','7 Mission cards
1 Suspicion card
1 Credit card
18 cubes in 3 different colors (6 of each color)
1 bag or cup (optional) or use your hand for random blind drawing of cargo cubes','https://boardgamegeek.com/thread/3476092','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '439' AND material_kind IS 'container' AND name_normalized IS 'contenitore: bag or cup (optional) or use your hand for random blind drawing of cargo cubes' AND quantity_raw IS '1' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3476092');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3457687' WHERE id=440 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('440','2026-10-04','https://boardgamegeek.com/thread/3457687','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('440','2026-10-04','https://boardgamegeek.com/thread/3457687','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('440','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3457687','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('440','game_files','https://drive.google.com/drive/folders/1Z0mfbNLgSPX2jirmkAsZfvWkWuELHS3H?usp=sharing','drive.google.com','Rules & Cards',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (440,(SELECT id FROM remote_resources WHERE game_id=440 AND url='https://drive.google.com/drive/folders/1Z0mfbNLgSPX2jirmkAsZfvWkWuELHS3H?usp=sharing'),'https://boardgamegeek.com/thread/3457687','Rules & Cards','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=440 AND url='https://drive.google.com/drive/folders/1Z0mfbNLgSPX2jirmkAsZfvWkWuELHS3H?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3457687','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=440 AND url='https://drive.google.com/drive/folders/1Z0mfbNLgSPX2jirmkAsZfvWkWuELHS3H?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3457687' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '440','printable_component','carte: cards','9 cards','9','required','printable','9 cards
Pens (dry-erase markers if cards are laminated/sleeved)
Rules','https://boardgamegeek.com/thread/3457687','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '440' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457687');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '440','writing_tool','strumento scrittura: Pens (dry-erase markers if cards are laminated/sleeved)','Pens (dry-erase markers if cards are laminated/sleeved)',NULL,'required','common','9 cards
Pens (dry-erase markers if cards are laminated/sleeved)
Rules','https://boardgamegeek.com/thread/3457687','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '440' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: Pens (dry-erase markers if cards are laminated/sleeved)' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457687');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '440','rules','regolamento: Rules','Rules',NULL,'required','printable','9 cards
Pens (dry-erase markers if cards are laminated/sleeved)
Rules','https://boardgamegeek.com/thread/3457687','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '440' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3457687');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3472458' WHERE id=441 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('441','2026-10-04','https://boardgamegeek.com/thread/3472458','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('441','2026-10-04','https://boardgamegeek.com/thread/3472458','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('441','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3472458','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('441','game_files','https://drive.google.com/drive/folders/1CIwTNlNli_LRed03A5cVUr8PcN0mMb_O?usp=sharing','drive.google.com','Squunchies v1.0 Files','v1.0','unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (441,(SELECT id FROM remote_resources WHERE game_id=441 AND url='https://drive.google.com/drive/folders/1CIwTNlNli_LRed03A5cVUr8PcN0mMb_O?usp=sharing'),'https://boardgamegeek.com/thread/3472458','Squunchies v1.0 Files','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=441 AND url='https://drive.google.com/drive/folders/1CIwTNlNli_LRed03A5cVUr8PcN0mMb_O?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3472458','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=441 AND url='https://drive.google.com/drive/folders/1CIwTNlNli_LRed03A5cVUr8PcN0mMb_O?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3472458' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '441','printable_component','carte: Double-sided Cards','9 Double-sided Cards','9','required','printable','- 9 Double-sided Cards
- 18 Dice (6 Red, 6 Blue, and 6 Yellow)
- 4 8mm Cubes','https://boardgamegeek.com/thread/3472458','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '441' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Double-sided Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472458');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '441','randomizer','dadi: Dice (6 Red, 6 Blue, and 6 Yellow)','18 Dice (6 Red, 6 Blue, and 6 Yellow)','18','required','common','- 9 Double-sided Cards
- 18 Dice (6 Red, 6 Blue, and 6 Yellow)
- 4 8mm Cubes','https://boardgamegeek.com/thread/3472458','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '441' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Dice (6 Red, 6 Blue, and 6 Yellow)' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472458');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '441','token_marker','segnalini: mm Cubes','4 8mm Cubes','4','required','common','- 9 Double-sided Cards
- 18 Dice (6 Red, 6 Blue, and 6 Yellow)
- 4 8mm Cubes','https://boardgamegeek.com/thread/3472458','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '441' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: mm Cubes' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3472458');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3449049' WHERE id=442 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('442','2026-10-04','https://boardgamegeek.com/thread/3449049','found','TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('442','2026-10-04','https://boardgamegeek.com/thread/3449049','found','TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('442','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3449049','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('442','component','https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94wFLycx/view?usp=drive_link','drive.google.com','https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94w...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (442,(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94wFLycx/view?usp=drive_link'),'https://boardgamegeek.com/thread/3449049','https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94w...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94wFLycx/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3449049','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1AL7GjRQn2YXBnY0rUg-5viOi94wFLycx/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449049' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('442','rules','https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtWxHk3v/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtW...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (442,(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtWxHk3v/view?usp=sharing'),'https://boardgamegeek.com/thread/3449049','https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtW...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtWxHk3v/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449049','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1gu2z3vWK9v_PZQlKPK2DgHMigtWxHk3v/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449049' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('442','rules','https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5XduimzqZUs/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5Xduim...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (442,(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5XduimzqZUs/view?usp=sharing'),'https://boardgamegeek.com/thread/3449049','https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5Xduim...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5XduimzqZUs/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449049','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Roster Stand of Supremacy; primo post attuale Supremacy Defense. Manuali V4.0 e PnP V3.0 22/3/2025.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=442 AND url='https://drive.google.com/file/d/1xHAhuWa1HC3uiIFTohHRc5XduimzqZUs/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449049' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '442','rules','regolamento: rule book','1 rule book','1','required','printable','1 rule book
9 cards','https://boardgamegeek.com/thread/3449049','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '442' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: rule book' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449049');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '442','printable_component','carte: cards','9 cards','9','required','printable','1 rule book
9 cards','https://boardgamegeek.com/thread/3449049','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '442' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449049');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3478380' WHERE id=443 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('443','2026-10-04','https://boardgamegeek.com/thread/3478380','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('443','2026-10-04','https://boardgamegeek.com/thread/3478380','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('443','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3478380','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('443','game_files','https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ_Y-RpSXsEPP1?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (443,(SELECT id FROM remote_resources WHERE game_id=443 AND url='https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ_Y-RpSXsEPP1?usp=sharing'),'https://boardgamegeek.com/thread/3478380','https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=443 AND url='https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ_Y-RpSXsEPP1?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3478380','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=443 AND url='https://drive.google.com/drive/folders/146bhCQJvAVrSC3XRg3uJ_Y-RpSXsEPP1?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3478380' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '443','printable_component','carte: cards] - on Double sided PDF sheet','[9 cards] - on Double sided PDF sheet','9','required','printable','[9 cards] - on Double sided PDF sheet
[1] - RULES - 6 pages
[3] - Cubes
[6] - d6 dice
[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','https://boardgamegeek.com/thread/3478380','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '443' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on Double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478380');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '443','rules','regolamento: RULES - 6 pages','[1] - RULES - 6 pages','1','required','printable','[9 cards] - on Double sided PDF sheet
[1] - RULES - 6 pages
[3] - Cubes
[6] - d6 dice
[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','https://boardgamegeek.com/thread/3478380','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '443' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 6 pages' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478380');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '443','token_marker','segnalini: Cubes','[3] - Cubes','3','required','common','[9 cards] - on Double sided PDF sheet
[1] - RULES - 6 pages
[3] - Cubes
[6] - d6 dice
[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','https://boardgamegeek.com/thread/3478380','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '443' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Cubes' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478380');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '443','randomizer','dadi: d6 dice','[6] - d6 dice','6','required','common','[9 cards] - on Double sided PDF sheet
[1] - RULES - 6 pages
[3] - Cubes
[6] - d6 dice
[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','https://boardgamegeek.com/thread/3478380','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '443' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478380');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '443','token_marker','segnalini: Meeples [5 of one color, 5 of a second color, and 5 of a third color]','[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','15','required','common','[9 cards] - on Double sided PDF sheet
[1] - RULES - 6 pages
[3] - Cubes
[6] - d6 dice
[15] - Meeples [5 of one color, 5 of a second color, and 5 of a third color]','https://boardgamegeek.com/thread/3478380','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '443' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Meeples [5 of one color, 5 of a second color, and 5 of a third color]' AND quantity_raw IS '15' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478380');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3465605' WHERE id=444 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('444','2026-10-04','https://boardgamegeek.com/thread/3465605','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('444','2026-10-04','https://boardgamegeek.com/thread/3465605','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('444','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3465605','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('444','rules','https://drive.google.com/file/d/1c2y9sX51DF5QxXM6Ku05pFV4491h_rsN/view?usp=sharing','drive.google.com','Rules 3.1',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (444,(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1c2y9sX51DF5QxXM6Ku05pFV4491h_rsN/view?usp=sharing'),'https://boardgamegeek.com/thread/3465605','Rules 3.1','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1c2y9sX51DF5QxXM6Ku05pFV4491h_rsN/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3465605','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1c2y9sX51DF5QxXM6Ku05pFV4491h_rsN/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3465605' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('444','game_files','https://drive.google.com/file/d/1t3u6yL3p5C5AuF7HWwHqsNPevX0QBsyw/view?usp=sharing','drive.google.com','Game 4.1 (Colour Version)',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (444,(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1t3u6yL3p5C5AuF7HWwHqsNPevX0QBsyw/view?usp=sharing'),'https://boardgamegeek.com/thread/3465605','Game 4.1 (Colour Version)','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1t3u6yL3p5C5AuF7HWwHqsNPevX0QBsyw/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3465605','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://drive.google.com/file/d/1t3u6yL3p5C5AuF7HWwHqsNPevX0QBsyw/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3465605' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('444','online_play','https://steamcommunity.com/sharedfiles/filedetails/?id=3437175362&searchtext=the+7th+island','steamcommunity.com','Tabletop Simulator 1.0',NULL,'unknown','2026-10-04','2026-10-04','workshop_module');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (444,(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3437175362&searchtext=the+7th+island'),'https://boardgamegeek.com/thread/3465605','Tabletop Simulator 1.0','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=444 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3437175362&searchtext=the+7th+island'),'2026-10-04','https://boardgamegeek.com/thread/3465605','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://steamcommunity.com/sharedfiles/filedetails/?id=3437175362&searchtext=the+7th+island') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3465605' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('444','video','https://youtube.com/watch?v=IQ7SMfhoHJM','youtube.com','The 7th island - Rules: 2 Players Mode',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (444,(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://youtube.com/watch?v=IQ7SMfhoHJM'),'https://boardgamegeek.com/thread/3465605','The 7th island - Rules: 2 Players Mode','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=444 AND url='https://youtube.com/watch?v=IQ7SMfhoHJM'),'2026-10-04','https://boardgamegeek.com/thread/3465605','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=444 AND url='https://youtube.com/watch?v=IQ7SMfhoHJM') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3465605' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','printable_component','carte','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','9','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'printable_component' AND name_normalized IS 'carte' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','rules','regolamento','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.',NULL,'unclear','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'rules' AND name_normalized IS 'regolamento' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','randomizer','dadi facce non specificate','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','2','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi facce non specificate' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','token_marker','cubi','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','12','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','token_marker','monete','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','5','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'token_marker' AND name_normalized IS 'monete' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','token_marker','meeple navi','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','3','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple navi' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','token_marker','meeple kraken','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','1','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple kraken' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '444','token_marker','meeple sirena','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','1','required','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
Rules - TBC
Other compontents - 2 Dices, 12 Cubes, 5 Coins, 3 Ships Meeples, 1 Kraken Meeple, 1 Marmaid Meeple.','https://boardgamegeek.com/thread/3465605','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '444' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple sirena' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3465605');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3478326' WHERE id=445 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('445','2026-10-04','https://boardgamegeek.com/thread/3478326','found','TSK-0051; primo post originale soltanto; host non verificati. ','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('445','2026-10-04','https://boardgamegeek.com/thread/3478326','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('445','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3478326','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '445','printable_component','carte: double sided cards (PnP ready!).','9 double sided cards (PnP ready!).','9','required','printable','9 double sided cards (PnP ready!).
2 character models
2 different colored 10 sided dice
20 different tokens','https://boardgamegeek.com/thread/3478326','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '445' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided cards (PnP ready!).' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478326');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '445','token_marker','segnalini: character models','2 character models','2','required','common','9 double sided cards (PnP ready!).
2 character models
2 different colored 10 sided dice
20 different tokens','https://boardgamegeek.com/thread/3478326','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '445' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: character models' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478326');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '445','randomizer','dadi: different colored 10 sided dice','2 different colored 10 sided dice','2','required','common','9 double sided cards (PnP ready!).
2 character models
2 different colored 10 sided dice
20 different tokens','https://boardgamegeek.com/thread/3478326','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '445' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: different colored 10 sided dice' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478326');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '445','token_marker','segnalini: different tokens','20 different tokens','20','required','common','9 double sided cards (PnP ready!).
2 character models
2 different colored 10 sided dice
20 different tokens','https://boardgamegeek.com/thread/3478326','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '445' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: different tokens' AND quantity_raw IS '20' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478326');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3440855' WHERE id=446 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('446','2026-10-04','https://boardgamegeek.com/thread/3440855','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('446','2026-10-04','https://boardgamegeek.com/thread/3440855','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('446','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3440855','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('446','component','https://drive.google.com/file/d/1Vl9tHeV8Y2VyqXiJ-EFNOFLWW-EJLowJ/view?usp=drive_link','drive.google.com','Remnant Cards, v7','v7','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (446,(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1Vl9tHeV8Y2VyqXiJ-EFNOFLWW-EJLowJ/view?usp=drive_link'),'https://boardgamegeek.com/thread/3440855','Remnant Cards, v7','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1Vl9tHeV8Y2VyqXiJ-EFNOFLWW-EJLowJ/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3440855','declared_in_wip','not_checked','v7','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1Vl9tHeV8Y2VyqXiJ-EFNOFLWW-EJLowJ/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440855' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('446','rules','https://drive.google.com/file/d/1cxW8UMpC0V4BILSI8wWzvei_pGqmn5dV/view?usp=drive_link','drive.google.com','Remnant Rules, v6','v6','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (446,(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1cxW8UMpC0V4BILSI8wWzvei_pGqmn5dV/view?usp=drive_link'),'https://boardgamegeek.com/thread/3440855','Remnant Rules, v6','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1cxW8UMpC0V4BILSI8wWzvei_pGqmn5dV/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3440855','declared_in_wip','not_checked','v6','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1cxW8UMpC0V4BILSI8wWzvei_pGqmn5dV/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440855' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('446','component','https://drive.google.com/file/d/1l8CeI5jjKZbxKXHCvVp7w3AozEcvhXc7/view?usp=sharing','drive.google.com','Improved Cards by Joachim Emilio Antonio!',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (446,(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1l8CeI5jjKZbxKXHCvVp7w3AozEcvhXc7/view?usp=sharing'),'https://boardgamegeek.com/thread/3440855','Improved Cards by Joachim Emilio Antonio!','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1l8CeI5jjKZbxKXHCvVp7w3AozEcvhXc7/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440855','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=446 AND url='https://drive.google.com/file/d/1l8CeI5jjKZbxKXHCvVp7w3AozEcvhXc7/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440855' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','printable_component','carte: Action Cards','7 Action Cards','7','required','printable','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Action Cards' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','printable_component','carte: Resource Tracker Card','1 Resource Tracker Card','1','required','printable','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Resource Tracker Card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','printable_component','carte: Improvement Card','1 Improvement Card','1','required','printable','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Improvement Card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','randomizer','dadi: d6 Worker Dice -- 3 each of two colors','6d6 Worker Dice -- 3 each of two colors','6','required','common','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 Worker Dice -- 3 each of two colors' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','randomizer','dadi: cubes -- 6 each of two colors (preferably same as dice)','12 cubes -- 6 each of two colors (preferably same as dice)','12','required','common','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: cubes -- 6 each of two colors (preferably same as dice)' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','token_marker','segnalini: coin to keep track of first player','1 coin to keep track of first player','1','required','common','7 Action Cards
1 Resource Tracker Card
1 Improvement Card
6d6 Worker Dice -- 3 each of two colors
12 cubes -- 6 each of two colors (preferably same as dice)
1 coin to keep track of first player','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: coin to keep track of first player' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '446','rules','regolamento dichiarato nei link','Remnant Rules, v6',NULL,'unclear','printable','Remnant Rules, v6','https://boardgamegeek.com/thread/3440855','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '446' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3440855');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3466260' WHERE id=447 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('447','2026-10-04','https://boardgamegeek.com/thread/3466260','found','TSK-0051; primo post originale soltanto; host non verificati. Primo articolo rimasto @AaronMin 3/3/2025 è Update, seguito da feedback 14/4 e risposta 16/4. Post introduttivo originale non osservabile: nessuna assenza di materiali dedotta.','not_observable');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('447','2026-10-04','https://boardgamegeek.com/thread/3466260','found','TSK-0051; primo post originale soltanto; host non verificati. Primo articolo rimasto @AaronMin 3/3/2025 è Update, seguito da feedback 14/4 e risposta 16/4. Post introduttivo originale non osservabile: nessuna assenza di materiali dedotta.','not_observable','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('447','materials','blocked','2026-10-04','https://boardgamegeek.com/thread/3466260','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Primo articolo rimasto @AaronMin 3/3/2025 è Update, seguito da feedback 14/4 e risposta 16/4. Post introduttivo originale non osservabile: nessuna assenza di materiali dedotta.');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3458095' WHERE id=448 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('448','2026-10-04','https://boardgamegeek.com/thread/3458095','found','TSK-0051; primo post originale soltanto; host non verificati. Roster Tiny, Dicey, and Starry; primo post originale @UdaAC3S_ 10/2/2025 è Dicey Railways in fase idea. Requisiti e link si riferiscono a questo post, non attestano la versione rinominata.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('448','2026-10-04','https://boardgamegeek.com/thread/3458095','found','TSK-0051; primo post originale soltanto; host non verificati. Roster Tiny, Dicey, and Starry; primo post originale @UdaAC3S_ 10/2/2025 è Dicey Railways in fase idea. Requisiti e link si riferiscono a questo post, non attestano la versione rinominata.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('448','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3458095','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Roster Tiny, Dicey, and Starry; primo post originale @UdaAC3S_ 10/2/2025 è Dicey Railways in fase idea. Requisiti e link si riferiscono a questo post, non attestano la versione rinominata.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('448','game_files','https://www.dropbox.com/scl/fo/gp19aq759fam6vrkpc3bz/APlR9EPcCZNdMpgZko_oKEg?rlkey=z1ltxqxf3m5c0h3g3yrvn5i7d&st=nnfqls2o&dl=0','www.dropbox.com','here',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (448,(SELECT id FROM remote_resources WHERE game_id=448 AND url='https://www.dropbox.com/scl/fo/gp19aq759fam6vrkpc3bz/APlR9EPcCZNdMpgZko_oKEg?rlkey=z1ltxqxf3m5c0h3g3yrvn5i7d&st=nnfqls2o&dl=0'),'https://boardgamegeek.com/thread/3458095','here','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=448 AND url='https://www.dropbox.com/scl/fo/gp19aq759fam6vrkpc3bz/APlR9EPcCZNdMpgZko_oKEg?rlkey=z1ltxqxf3m5c0h3g3yrvn5i7d&st=nnfqls2o&dl=0'),'2026-10-04','https://boardgamegeek.com/thread/3458095','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Roster Tiny, Dicey, and Starry; primo post originale @UdaAC3S_ 10/2/2025 è Dicey Railways in fase idea. Requisiti e link si riferiscono a questo post, non attestano la versione rinominata.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=448 AND url='https://www.dropbox.com/scl/fo/gp19aq759fam6vrkpc3bz/APlR9EPcCZNdMpgZko_oKEg?rlkey=z1ltxqxf3m5c0h3g3yrvn5i7d&st=nnfqls2o&dl=0') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3458095' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '448','printable_component','carte: game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)','[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)','9','required','printable','-[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)
-[12] dice
-[12] cubes ([4] red, [4] blue & [4] yellow)
-1 bag (doesn''t count towards 24 components)
-Rulebook','https://boardgamegeek.com/thread/3458095','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '448' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458095');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '448','randomizer','dadi: dice','[12] dice','12','required','common','-[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)
-[12] dice
-[12] cubes ([4] red, [4] blue & [4] yellow)
-1 bag (doesn''t count towards 24 components)
-Rulebook','https://boardgamegeek.com/thread/3458095','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '448' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458095');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '448','token_marker','segnalini: cubes ([4] red, [4] blue & [4] yellow)','[12] cubes ([4] red, [4] blue & [4] yellow)','12','required','common','-[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)
-[12] dice
-[12] cubes ([4] red, [4] blue & [4] yellow)
-1 bag (doesn''t count towards 24 components)
-Rulebook','https://boardgamegeek.com/thread/3458095','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '448' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes ([4] red, [4] blue & [4] yellow)' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458095');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '448','container','contenitore: bag (doesn''t count towards 24 components)','1 bag (doesn''t count towards 24 components)','1','required','household','-[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)
-[12] dice
-[12] cubes ([4] red, [4] blue & [4] yellow)
-1 bag (doesn''t count towards 24 components)
-Rulebook','https://boardgamegeek.com/thread/3458095','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '448' AND material_kind IS 'container' AND name_normalized IS 'contenitore: bag (doesn''t count towards 24 components)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458095');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '448','rules','regolamento: Rulebook','Rulebook',NULL,'required','printable','-[9] game cards ([4] map cards, [3] player cards, [1] company card & [1] market card)
-[12] dice
-[12] cubes ([4] red, [4] blue & [4] yellow)
-1 bag (doesn''t count towards 24 components)
-Rulebook','https://boardgamegeek.com/thread/3458095','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '448' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458095');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3474024' WHERE id=449 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('449','2026-10-04','https://boardgamegeek.com/thread/3474024','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('449','2026-10-04','https://boardgamegeek.com/thread/3474024','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('449','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3474024','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','component','https://drive.google.com/file/d/16NNGvEQ3FE-zmvN1SMTQmuZsOz9JIXvP/view?usp=sharing','drive.google.com','Cards (Version 1.0)','Version 1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/16NNGvEQ3FE-zmvN1SMTQmuZsOz9JIXvP/view?usp=sharing'),'https://boardgamegeek.com/thread/3474024','Cards (Version 1.0)','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/16NNGvEQ3FE-zmvN1SMTQmuZsOz9JIXvP/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked','Version 1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/16NNGvEQ3FE-zmvN1SMTQmuZsOz9JIXvP/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','rules','https://drive.google.com/file/d/1DIZj2dKZUrUvhpSuavnnJDnPBfi0VIZN/view?usp=sharing','drive.google.com','Rules (Version 1.0)','Version 1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1DIZj2dKZUrUvhpSuavnnJDnPBfi0VIZN/view?usp=sharing'),'https://boardgamegeek.com/thread/3474024','Rules (Version 1.0)','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1DIZj2dKZUrUvhpSuavnnJDnPBfi0VIZN/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked','Version 1.0','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1DIZj2dKZUrUvhpSuavnnJDnPBfi0VIZN/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','component','https://drive.google.com/file/d/1Dpj2T1ceq7BVA8g4dyRWiY7UpE_6Ig-T/view','drive.google.com','Cards: Low Ink',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Dpj2T1ceq7BVA8g4dyRWiY7UpE_6Ig-T/view'),'https://boardgamegeek.com/thread/3474024','Cards: Low Ink','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Dpj2T1ceq7BVA8g4dyRWiY7UpE_6Ig-T/view'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Dpj2T1ceq7BVA8g4dyRWiY7UpE_6Ig-T/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','rules','https://drive.google.com/file/d/1Yiqgq88HzHOm6GM6OynKv9M_dcIe0fOd/view','drive.google.com','Rules: Low Ink',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Yiqgq88HzHOm6GM6OynKv9M_dcIe0fOd/view'),'https://boardgamegeek.com/thread/3474024','Rules: Low Ink','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Yiqgq88HzHOm6GM6OynKv9M_dcIe0fOd/view'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1Yiqgq88HzHOm6GM6OynKv9M_dcIe0fOd/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','rules','https://drive.google.com/file/d/1cdaUb0gtQdxPLe3NlfgiL-M7BdNJdEL4/view','drive.google.com','Rules: Full Color',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1cdaUb0gtQdxPLe3NlfgiL-M7BdNJdEL4/view'),'https://boardgamegeek.com/thread/3474024','Rules: Full Color','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1cdaUb0gtQdxPLe3NlfgiL-M7BdNJdEL4/view'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1cdaUb0gtQdxPLe3NlfgiL-M7BdNJdEL4/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('449','component','https://drive.google.com/file/d/1r2rvW0P7nlOAurA10EdHKXvopwT7ekjQ/view','drive.google.com','Cards: Full Color',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (449,(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1r2rvW0P7nlOAurA10EdHKXvopwT7ekjQ/view'),'https://boardgamegeek.com/thread/3474024','Cards: Full Color','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1r2rvW0P7nlOAurA10EdHKXvopwT7ekjQ/view'),'2026-10-04','https://boardgamegeek.com/thread/3474024','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=449 AND url='https://drive.google.com/file/d/1r2rvW0P7nlOAurA10EdHKXvopwT7ekjQ/view') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3474024' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '449','printable_component','carte: double-sided cards (1 double-sided Letter page)','9 double-sided cards (1 double-sided Letter page)','9','required','printable','9 double-sided cards (1 double-sided Letter page)
 1 Rulebook
 7 six-sided dice (any color)
 4 Tokens of any type (2 of one color, 2 of another color)
 2 cubes (any color)','https://boardgamegeek.com/thread/3474024','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '449' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards (1 double-sided Letter page)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3474024');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '449','rules','regolamento: Rulebook','1 Rulebook','1','required','printable','9 double-sided cards (1 double-sided Letter page)
 1 Rulebook
 7 six-sided dice (any color)
 4 Tokens of any type (2 of one color, 2 of another color)
 2 cubes (any color)','https://boardgamegeek.com/thread/3474024','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '449' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3474024');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '449','randomizer','dadi: six-sided dice (any color)','7 six-sided dice (any color)','7','required','common','9 double-sided cards (1 double-sided Letter page)
 1 Rulebook
 7 six-sided dice (any color)
 4 Tokens of any type (2 of one color, 2 of another color)
 2 cubes (any color)','https://boardgamegeek.com/thread/3474024','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '449' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: six-sided dice (any color)' AND quantity_raw IS '7' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3474024');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '449','token_marker','segnalini: Tokens of any type (2 of one color, 2 of another color)','4 Tokens of any type (2 of one color, 2 of another color)','4','required','common','9 double-sided cards (1 double-sided Letter page)
 1 Rulebook
 7 six-sided dice (any color)
 4 Tokens of any type (2 of one color, 2 of another color)
 2 cubes (any color)','https://boardgamegeek.com/thread/3474024','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '449' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Tokens of any type (2 of one color, 2 of another color)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3474024');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '449','token_marker','segnalini: cubes (any color)','2 cubes (any color)','2','required','common','9 double-sided cards (1 double-sided Letter page)
 1 Rulebook
 7 six-sided dice (any color)
 4 Tokens of any type (2 of one color, 2 of another color)
 2 cubes (any color)','https://boardgamegeek.com/thread/3474024','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '449' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes (any color)' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3474024');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3468551' WHERE id=450 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('450','2026-10-04','https://boardgamegeek.com/thread/3468551','found','TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('450','2026-10-04','https://boardgamegeek.com/thread/3468551','found','TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('450','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3468551','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('450','component','https://drive.google.com/file/d/11IT3Le61KPnrNi11sDpodeOep75E6n-A/view?usp=sharing','drive.google.com','Low Ink Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (450,(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/11IT3Le61KPnrNi11sDpodeOep75E6n-A/view?usp=sharing'),'https://boardgamegeek.com/thread/3468551','Low Ink Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/11IT3Le61KPnrNi11sDpodeOep75E6n-A/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3468551','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/11IT3Le61KPnrNi11sDpodeOep75E6n-A/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3468551' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('450','component','https://drive.google.com/file/d/152IME5wkcY6o73kST5FT9Fw4j3iH_JO7/view?usp=sharing','drive.google.com','Tralim Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (450,(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/152IME5wkcY6o73kST5FT9Fw4j3iH_JO7/view?usp=sharing'),'https://boardgamegeek.com/thread/3468551','Tralim Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/152IME5wkcY6o73kST5FT9Fw4j3iH_JO7/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3468551','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/152IME5wkcY6o73kST5FT9Fw4j3iH_JO7/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3468551' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('450','rules','https://drive.google.com/file/d/1580-6ce6R4fO-dLb6xoSGz3hxNgGS20w/view?usp=sharing','drive.google.com','Rules',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (450,(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/1580-6ce6R4fO-dLb6xoSGz3hxNgGS20w/view?usp=sharing'),'https://boardgamegeek.com/thread/3468551','Rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/1580-6ce6R4fO-dLb6xoSGz3hxNgGS20w/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3468551','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://drive.google.com/file/d/1580-6ce6R4fO-dLb6xoSGz3hxNgGS20w/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3468551' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('450','video','https://youtube.com/watch?v=I8L5UlWibZU','youtube.com','Tralim Playthrough',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (450,(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://youtube.com/watch?v=I8L5UlWibZU'),'https://boardgamegeek.com/thread/3468551','Tralim Playthrough','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=450 AND url='https://youtube.com/watch?v=I8L5UlWibZU'),'2026-10-04','https://boardgamegeek.com/thread/3468551','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. 23 cubi dichiarati, cinque gruppi da tre più 3/6 tracker non coerenti col totale; quantità conservate senza rettifica.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=450 AND url='https://youtube.com/watch?v=I8L5UlWibZU') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3468551' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','printable_component','carte: Tram Cards (1 blue, 1 yellow) with reverse Application Rating,','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,','2','required','printable','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Tram Cards (1 blue, 1 yellow) with reverse Application Rating,' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','printable_component','carte: Tram Stop Cards (double-sided),','5 Tram Stop Cards (double-sided),','5','required','printable','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Tram Stop Cards (double-sided),' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','printable_component','carte: Route Bonus Card (double sided),','1 Route Bonus Card (double sided),','1','required','printable','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Route Bonus Card (double sided),' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','printable_component','carte: Scorecard (double sided),','1 Scorecard (double sided),','1','required','printable','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Scorecard (double sided),' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','randomizer','dadi: yellow six-sided die,','1 yellow six-sided die,','1','required','common','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: yellow six-sided die,' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','randomizer','dadi: blue six-sided die,','1 blue six-sided die,','1','required','common','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: blue six-sided die,' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','token_marker','segnalini: mm cubes in the following colours and quantities:','23x8mm cubes in the following colours and quantities:','23 dichiarati; dettaglio discordante','required','common','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: mm cubes in the following colours and quantities:' AND quantity_raw IS '23 dichiarati; dettaglio discordante' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','token_marker','segnalini: cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3','3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3','3 solo / 6 pvp','required','common','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3' AND quantity_raw IS '3 solo / 6 pvp' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '450','rules','regolamento: A4 Pdf Rulebook.','A4 Pdf Rulebook.',NULL,'required','printable','2 Tram Cards (1 blue, 1 yellow) with reverse Application Rating,
5 Tram Stop Cards (double-sided),
1 Route Bonus Card (double sided),
1 Scorecard (double sided),
1 yellow six-sided die,
1 blue six-sided die,
23x8mm cubes in the following colours and quantities:
3 white, 3 yellow, 3 blue, 3 red, 3 pink.
3 cubes (solo game) or 6 cubes (2 pvp) of any colour for scoring and passenger cube tracker (3
cubes per player).
A4 Pdf Rulebook.','https://boardgamegeek.com/thread/3468551','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '450' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: A4 Pdf Rulebook.' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468551');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3467451' WHERE id=451 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('451','2026-10-04','https://boardgamegeek.com/thread/3467451','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('451','2026-10-04','https://boardgamegeek.com/thread/3467451','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('451','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3467451','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('451','online_play','https://atanii.itch.io/tunnels-and-treasures-prototype','atanii.itch.io','https://atanii.itch.io/tunnels-and-treasures-prototype',NULL,'unknown','2026-10-04','2026-10-04','download_page');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (451,(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://atanii.itch.io/tunnels-and-treasures-prototype'),'https://boardgamegeek.com/thread/3467451','https://atanii.itch.io/tunnels-and-treasures-prototype','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=451 AND url='https://atanii.itch.io/tunnels-and-treasures-prototype'),'2026-10-04','https://boardgamegeek.com/thread/3467451','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://atanii.itch.io/tunnels-and-treasures-prototype') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3467451' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('451','rules','https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heniuxq1K/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heni...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (451,(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heniuxq1K/view?usp=sharing'),'https://boardgamegeek.com/thread/3467451','https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heni...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heniuxq1K/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3467451','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heniuxq1K/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3467451' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('451','rules','https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqhHqpj9/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqh...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (451,(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqhHqpj9/view?usp=sharing'),'https://boardgamegeek.com/thread/3467451','https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqh...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqhHqpj9/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3467451','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqhHqpj9/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3467451' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('451','component','https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDeQjTOs/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDe...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (451,(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDeQjTOs/view?usp=sharing'),'https://boardgamegeek.com/thread/3467451','https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDe...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDeQjTOs/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3467451','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDeQjTOs/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3467451' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('451','component','https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_VTsEuN/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_V...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (451,(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_VTsEuN/view?usp=sharing'),'https://boardgamegeek.com/thread/3467451','https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_V...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_VTsEuN/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3467451','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=451 AND url='https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_VTsEuN/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3467451' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','token_marker','segnalini gemme','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','5','required','common','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini gemme' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','token_marker','segnalini livelli','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','3','required','common','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini livelli' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','token_marker','segnalino scudi','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','1','required','common','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalino scudi' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','token_marker','segnalini salute','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','5','required','common','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini salute' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','token_marker','segnalini bombe','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','2','required','common','- Tokens of any kinds - I''m using cubes to represent score, loot...
-- 5 for gemstones
-- 3 for game levels
-- 1 for shields
-- 5 for health points
-- 2 for bombs','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini bombe' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','rules','regolamento dichiarato nei link','https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqh... | https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heni...',NULL,'unclear','printable','https://drive.google.com/file/d/1PrXir682e6b5vyst7twOKQJsrqh... | https://drive.google.com/file/d/1JgsWiCSq19YigowJ6HoZ-A0heni...','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '451','printable_component','componenti PnP dichiarati nei link','https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDe... | https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_V...',NULL,'unclear','printable','https://drive.google.com/file/d/1RzWW6z4nbPIgFWWlcbqan7wrHDe... | https://drive.google.com/file/d/1bITSYKfqAkZKAmCNba-5hUVaY_V...','https://boardgamegeek.com/thread/3467451','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '451' AND material_kind IS 'printable_component' AND name_normalized IS 'componenti PnP dichiarati nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3467451');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3452530' WHERE id=452 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('452','2026-10-04','https://boardgamegeek.com/thread/3452530','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('452','2026-10-04','https://boardgamegeek.com/thread/3452530','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('452','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3452530','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('452','game_files','https://drive.google.com/drive/folders/1cvu6QrpanLq-PnuZMaYaRgf9YFv1lG3B?usp=sharing','drive.google.com','Rules/cards',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (452,(SELECT id FROM remote_resources WHERE game_id=452 AND url='https://drive.google.com/drive/folders/1cvu6QrpanLq-PnuZMaYaRgf9YFv1lG3B?usp=sharing'),'https://boardgamegeek.com/thread/3452530','Rules/cards','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=452 AND url='https://drive.google.com/drive/folders/1cvu6QrpanLq-PnuZMaYaRgf9YFv1lG3B?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3452530','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=452 AND url='https://drive.google.com/drive/folders/1cvu6QrpanLq-PnuZMaYaRgf9YFv1lG3B?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3452530' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '452','printable_component','carte: cards','9 cards','9','required','printable','9 cards
12 d6 dice (4 of each of 3 different colours)
3 Tokens or cubes (in different colours)
Rules (1 to 2 pages)','https://boardgamegeek.com/thread/3452530','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '452' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452530');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '452','randomizer','dadi: d6 dice (4 of each of 3 different colours)','12 d6 dice (4 of each of 3 different colours)','12','required','common','9 cards
12 d6 dice (4 of each of 3 different colours)
3 Tokens or cubes (in different colours)
Rules (1 to 2 pages)','https://boardgamegeek.com/thread/3452530','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '452' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice (4 of each of 3 different colours)' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452530');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '452','token_marker','segnalini: Tokens or cubes (in different colours)','3 Tokens or cubes (in different colours)','3','required','common','9 cards
12 d6 dice (4 of each of 3 different colours)
3 Tokens or cubes (in different colours)
Rules (1 to 2 pages)','https://boardgamegeek.com/thread/3452530','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '452' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Tokens or cubes (in different colours)' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452530');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '452','rules','regolamento: Rules (1 to 2 pages)','Rules (1 to 2 pages)',NULL,'required','printable','9 cards
12 d6 dice (4 of each of 3 different colours)
3 Tokens or cubes (in different colours)
Rules (1 to 2 pages)','https://boardgamegeek.com/thread/3452530','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '452' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules (1 to 2 pages)' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452530');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3449763' WHERE id=453 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('453','2026-10-04','https://boardgamegeek.com/thread/3449763','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('453','2026-10-04','https://boardgamegeek.com/thread/3449763','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('453','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3449763','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('453','rules','https://drive.google.com/file/d/198owKYU5ux-mga17boWuB_XZaC6u5NCQ/view?usp=sharing','drive.google.com','Rulebook (v0.6)','v0.6','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (453,(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/198owKYU5ux-mga17boWuB_XZaC6u5NCQ/view?usp=sharing'),'https://boardgamegeek.com/thread/3449763','Rulebook (v0.6)','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/198owKYU5ux-mga17boWuB_XZaC6u5NCQ/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449763','declared_in_wip','not_checked','v0.6','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/198owKYU5ux-mga17boWuB_XZaC6u5NCQ/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449763' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('453','player_aid','https://drive.google.com/file/d/1IZTWKge3PM4fXFetMwURMKCrI1HImzE6/view?usp=sharing','drive.google.com','Reference Sheet (v0.6)','v0.6','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (453,(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1IZTWKge3PM4fXFetMwURMKCrI1HImzE6/view?usp=sharing'),'https://boardgamegeek.com/thread/3449763','Reference Sheet (v0.6)','player_aid',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1IZTWKge3PM4fXFetMwURMKCrI1HImzE6/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449763','declared_in_wip','not_checked','v0.6','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1IZTWKge3PM4fXFetMwURMKCrI1HImzE6/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449763' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('453','component','https://drive.google.com/file/d/1UZRbW0p-RQUclWO0KGMu2JNmgKPpzqP9/view?usp=sharing','drive.google.com','Full-Color Cards (v0.6)','v0.6','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (453,(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1UZRbW0p-RQUclWO0KGMu2JNmgKPpzqP9/view?usp=sharing'),'https://boardgamegeek.com/thread/3449763','Full-Color Cards (v0.6)','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1UZRbW0p-RQUclWO0KGMu2JNmgKPpzqP9/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449763','declared_in_wip','not_checked','v0.6','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1UZRbW0p-RQUclWO0KGMu2JNmgKPpzqP9/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449763' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('453','component','https://drive.google.com/file/d/1gU7Il_ohsZodLUr_wOJw3zqaewp923f_/view?usp=sharing','drive.google.com','Low-Ink Cards (v0.6)','v0.6','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (453,(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1gU7Il_ohsZodLUr_wOJw3zqaewp923f_/view?usp=sharing'),'https://boardgamegeek.com/thread/3449763','Low-Ink Cards (v0.6)','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1gU7Il_ohsZodLUr_wOJw3zqaewp923f_/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3449763','declared_in_wip','not_checked','v0.6','TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=453 AND url='https://drive.google.com/file/d/1gU7Il_ohsZodLUr_wOJw3zqaewp923f_/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3449763' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','rules','regolamento: Rulebook','1 Rulebook','1','required','printable','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','player_aid','foglio riferimento: Reference Sheet (optional)','1 Reference Sheet (optional)','1','optional','printable','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'player_aid' AND name_normalized IS 'foglio riferimento: Reference Sheet (optional)' AND quantity_raw IS '1' AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','printable_component','carte: cards','9 cards','9','required','printable','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','token_marker','segnalini: blue cubes (Water)','9 blue cubes (Water)','9','required','common','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: blue cubes (Water)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','token_marker','segnalini: other cubes (Tracker)','9 other cubes (Tracker)','9','required','common','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: other cubes (Tracker)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','randomizer','dadi: red dice (Population)','3 red dice (Population)','3','required','common','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: red dice (Population)' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','randomizer','dadi: other dice (Event)','2 other dice (Event)','2','required','common','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: other dice (Event)' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','token_marker','segnalini: blue pawn (Caravan)','1 blue pawn (Caravan)','1','required','common','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: blue pawn (Caravan)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '453','timer','timer: timer','1 timer','1','required','household','1 Rulebook
1 Reference Sheet (optional)
9 cards
9 blue cubes (Water)
9 other cubes (Tracker)
3 red dice (Population)
2 other dice (Event)
1 blue pawn (Caravan)
1 timer','https://boardgamegeek.com/thread/3449763','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '453' AND material_kind IS 'timer' AND name_normalized IS 'timer: timer' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3449763');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3451301' WHERE id=454 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('454','2026-10-04','https://boardgamegeek.com/thread/3451301','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('454','2026-10-04','https://boardgamegeek.com/thread/3451301','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('454','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3451301','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('454','game_files','https://drive.google.com/drive/folders/1jaJACgzTeIvGU8TO7ZlWdgjEkyJM67o4?usp=sharing','drive.google.com','WAYGATES DOWNLOAD',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (454,(SELECT id FROM remote_resources WHERE game_id=454 AND url='https://drive.google.com/drive/folders/1jaJACgzTeIvGU8TO7ZlWdgjEkyJM67o4?usp=sharing'),'https://boardgamegeek.com/thread/3451301','WAYGATES DOWNLOAD','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=454 AND url='https://drive.google.com/drive/folders/1jaJACgzTeIvGU8TO7ZlWdgjEkyJM67o4?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3451301','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=454 AND url='https://drive.google.com/drive/folders/1jaJACgzTeIvGU8TO7ZlWdgjEkyJM67o4?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3451301' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '454','printable_component','carte: cards] - on [1 double-sided] A4 PDF sheet','[9 cards] - on [1 double-sided] A4 PDF sheet','9','required','printable','[9 cards] - on [1 double-sided] A4 PDF sheet
[2] - Player tokens - [1 Blue, 1 Red]
[10] - Tokens - [5 Blue, 5 Red]','https://boardgamegeek.com/thread/3451301','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '454' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1 double-sided] A4 PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3451301');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '454','token_marker','segnalini: Player tokens - [1 Blue, 1 Red]','[2] - Player tokens - [1 Blue, 1 Red]','2','required','common','[9 cards] - on [1 double-sided] A4 PDF sheet
[2] - Player tokens - [1 Blue, 1 Red]
[10] - Tokens - [5 Blue, 5 Red]','https://boardgamegeek.com/thread/3451301','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '454' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Player tokens - [1 Blue, 1 Red]' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3451301');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '454','token_marker','segnalini: Tokens - [5 Blue, 5 Red]','[10] - Tokens - [5 Blue, 5 Red]','10','required','common','[9 cards] - on [1 double-sided] A4 PDF sheet
[2] - Player tokens - [1 Blue, 1 Red]
[10] - Tokens - [5 Blue, 5 Red]','https://boardgamegeek.com/thread/3451301','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '454' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Tokens - [5 Blue, 5 Red]' AND quantity_raw IS '10' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3451301');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3473382' WHERE id=455 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('455','2026-10-04','https://boardgamegeek.com/thread/3473382','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('455','2026-10-04','https://boardgamegeek.com/thread/3473382','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('455','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3473382','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('455','game_files','https://drive.google.com/drive/folders/13ogaWs_UZAKOZjIClRd7E4yFZNmeIjtU?usp=sharing','drive.google.com','Full Color Cards ver. 0306
Low Ink Cards ver. 0306
Rule Book ver. 0414',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (455,(SELECT id FROM remote_resources WHERE game_id=455 AND url='https://drive.google.com/drive/folders/13ogaWs_UZAKOZjIClRd7E4yFZNmeIjtU?usp=sharing'),'https://boardgamegeek.com/thread/3473382','Full Color Cards ver. 0306
Low Ink Cards ver. 0306
Rule Book ver. 0414','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=455 AND url='https://drive.google.com/drive/folders/13ogaWs_UZAKOZjIClRd7E4yFZNmeIjtU?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3473382','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=455 AND url='https://drive.google.com/drive/folders/13ogaWs_UZAKOZjIClRd7E4yFZNmeIjtU?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3473382' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('455','online_play','https://playingcards.io/jkr69g','playingcards.io','https://playingcards.io/jkr69g',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (455,(SELECT id FROM remote_resources WHERE game_id=455 AND url='https://playingcards.io/jkr69g'),'https://boardgamegeek.com/thread/3473382','https://playingcards.io/jkr69g','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=455 AND url='https://playingcards.io/jkr69g'),'2026-10-04','https://boardgamegeek.com/thread/3473382','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=455 AND url='https://playingcards.io/jkr69g') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3473382' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '455','printable_component','carte: Flower Cards','6 Flower Cards','6','required','printable','6 Flower Cards
3 Player Cards / Solo Challenge Cards
1 Pencil, Dry-erase Marker, etc. per player
1 Timer','https://boardgamegeek.com/thread/3473382','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '455' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Flower Cards' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473382');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '455','printable_component','carte: Player Cards / Solo Challenge Cards','3 Player Cards / Solo Challenge Cards','3','required','printable','6 Flower Cards
3 Player Cards / Solo Challenge Cards
1 Pencil, Dry-erase Marker, etc. per player
1 Timer','https://boardgamegeek.com/thread/3473382','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '455' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Player Cards / Solo Challenge Cards' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473382');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '455','writing_tool','strumento scrittura: Pencil, Dry-erase Marker, etc. per player','1 Pencil, Dry-erase Marker, etc. per player','1 per player','required','common','6 Flower Cards
3 Player Cards / Solo Challenge Cards
1 Pencil, Dry-erase Marker, etc. per player
1 Timer','https://boardgamegeek.com/thread/3473382','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '455' AND material_kind IS 'writing_tool' AND name_normalized IS 'strumento scrittura: Pencil, Dry-erase Marker, etc. per player' AND quantity_raw IS '1 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473382');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '455','timer','timer: Timer','1 Timer','1','required','household','6 Flower Cards
3 Player Cards / Solo Challenge Cards
1 Pencil, Dry-erase Marker, etc. per player
1 Timer','https://boardgamegeek.com/thread/3473382','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '455' AND material_kind IS 'timer' AND name_normalized IS 'timer: Timer' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3473382');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3443671' WHERE id=456 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('456','2026-10-04','https://boardgamegeek.com/thread/3443671','found','TSK-0051; primo post originale soltanto; host non verificati. Altri componenti TBD: censimento del primo post completo, progetto materiali incompleto.','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('456','2026-10-04','https://boardgamegeek.com/thread/3443671','found','TSK-0051; primo post originale soltanto; host non verificati. Altri componenti TBD: censimento del primo post completo, progetto materiali incompleto.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('456','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3443671','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Altri componenti TBD: censimento del primo post completo, progetto materiali incompleto.');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '456','printable_component','carte: card, other bits still TBD!','9 card, other bits still TBD!','9','unclear','printable','9 card, other bits still TBD!','https://boardgamegeek.com/thread/3443671','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '456' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: card, other bits still TBD!' AND quantity_raw IS '9' AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3443671');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479765' WHERE id=457 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('457','2026-10-04','https://boardgamegeek.com/thread/3479765','found','TSK-0051; primo post originale soltanto; host non verificati. ','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('457','2026-10-04','https://boardgamegeek.com/thread/3479765','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('457','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479765','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '457','printable_component','carte: double sided cards','8 double sided cards','8','required','printable','- 8 double sided cards
- 1 starter card
- 24 dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).','https://boardgamegeek.com/thread/3479765','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '457' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double sided cards' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479765');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '457','printable_component','carte: starter card','1 starter card','1','required','printable','- 8 double sided cards
- 1 starter card
- 24 dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).','https://boardgamegeek.com/thread/3479765','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '457' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: starter card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479765');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '457','randomizer','dadi: dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).','24 dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).','24','required','common','- 8 double sided cards
- 1 starter card
- 24 dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).','https://boardgamegeek.com/thread/3479765','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '457' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: dice in 4 colors, 6 of each color (Yellow, Red, Blue, & Black).' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479765');
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('458','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. N/A, Amo / @zardon; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('458','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. N/A, Amo / @zardon; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('458','materials','blocked','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. N/A, Amo / @zardon; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.');
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('459','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. HMS Ulven, Jörgen Bengtsson / @cabal_se; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('459','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. HMS Ulven, Jörgen Bengtsson / @cabal_se; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('459','materials','blocked','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. HMS Ulven, Jörgen Bengtsson / @cabal_se; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3447052' WHERE id=460 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('460','2026-10-04','https://boardgamegeek.com/thread/3447052','found','TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('460','2026-10-04','https://boardgamegeek.com/thread/3447052','found','TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('460','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3447052','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('460','game_files','https://drive.google.com/drive/folders/1WepaQYt2dRjjzIxt4A95XrNBHfDO-Dmw?usp=sharing','drive.google.com','Labyrinth Nine Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (460,(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://drive.google.com/drive/folders/1WepaQYt2dRjjzIxt4A95XrNBHfDO-Dmw?usp=sharing'),'https://boardgamegeek.com/thread/3447052','Labyrinth Nine Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=460 AND url='https://drive.google.com/drive/folders/1WepaQYt2dRjjzIxt4A95XrNBHfDO-Dmw?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3447052','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://drive.google.com/drive/folders/1WepaQYt2dRjjzIxt4A95XrNBHfDO-Dmw?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3447052' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('460','online_play','https://playingcards.io/afx5u5','playingcards.io','https://playingcards.io/afx5u5',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (460,(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://playingcards.io/afx5u5'),'https://boardgamegeek.com/thread/3447052','https://playingcards.io/afx5u5','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=460 AND url='https://playingcards.io/afx5u5'),'2026-10-04','https://boardgamegeek.com/thread/3447052','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://playingcards.io/afx5u5') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3447052' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('460','video','https://youtube.com/watch?v=c65YJu1iiJ4','youtube.com','Labyrinth Nine Update & 2-Player Rules',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (460,(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=c65YJu1iiJ4'),'https://boardgamegeek.com/thread/3447052','Labyrinth Nine Update & 2-Player Rules','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=c65YJu1iiJ4'),'2026-10-04','https://boardgamegeek.com/thread/3447052','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=c65YJu1iiJ4') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3447052' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('460','video','https://youtube.com/watch?v=kNnvxIoOqVE','youtube.com','Labyrinth Nine (first stages of game development)',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (460,(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=kNnvxIoOqVE'),'https://boardgamegeek.com/thread/3447052','Labyrinth Nine (first stages of game development)','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=kNnvxIoOqVE'),'2026-10-04','https://boardgamegeek.com/thread/3447052','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Taglio delle carte tesoro e alternativa cubi proposti, non scelta definitiva.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=460 AND url='https://youtube.com/watch?v=kNnvxIoOqVE') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3447052' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '460','printable_component','carte labirinto','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.','9','required','printable','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.','https://boardgamegeek.com/thread/3447052','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '460' AND material_kind IS 'printable_component' AND name_normalized IS 'carte labirinto' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3447052');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '460','printable_component','carte tesoro ritagliate','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.',NULL,'alternative','printable','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.','https://boardgamegeek.com/thread/3447052','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '460' AND material_kind IS 'printable_component' AND name_normalized IS 'carte tesoro ritagliate' AND quantity_raw IS NULL AND requirement_level IS 'alternative' AND source_url IS 'https://boardgamegeek.com/thread/3447052');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '460','token_marker','cubi per tesori','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.',NULL,'alternative','common','Currently thinking of having the treasure cards be cut out from the 9 labyrinth cards, but there may be a better way to do it, such as using cubes and associating each treasure with a different cube color. Very interested in getting feedback on this.','https://boardgamegeek.com/thread/3447052','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '460' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi per tesori' AND quantity_raw IS NULL AND requirement_level IS 'alternative' AND source_url IS 'https://boardgamegeek.com/thread/3447052');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479751' WHERE id=461 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('461','2026-10-04','https://boardgamegeek.com/thread/3479751','found','TSK-0051; primo post originale soltanto; host non verificati. ','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('461','2026-10-04','https://boardgamegeek.com/thread/3479751','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('461','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479751','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '461','randomizer','dadi calamità rossi','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','4','required','common','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','https://boardgamegeek.com/thread/3479751','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '461' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi calamità rossi' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479751');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '461','randomizer','dadi lanci bianchi','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','2','required','common','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','https://boardgamegeek.com/thread/3479751','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '461' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi lanci bianchi' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479751');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '461','randomizer','dadi passeggeri altro colore','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','8','required','common','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','https://boardgamegeek.com/thread/3479751','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '461' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi passeggeri altro colore' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479751');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '461','token_marker','cubi tracker','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','8','required','common','Note: In a pinch, you can actually get away with only 2 colors of dice (calamity and others) and 1 color for trackers
    Dice (Red): 4 - Calamity
    Dice (White): 2 - Rolling
    Dice (Other Color): 8 - Passengers
    Tracker cubes: 8
        1 - Player
        2 - Player Score
        2 - Player Spending
        1 - Map
        2 - Food','https://boardgamegeek.com/thread/3479751','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '461' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi tracker' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479751');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479008' WHERE id=462 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('462','2026-10-04','https://boardgamegeek.com/thread/3479008','found','TSK-0051; primo post originale soltanto; host non verificati. Quantità dadi e cubi X/TBD: requisiti osservati, quantità non determinata.','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('462','2026-10-04','https://boardgamegeek.com/thread/3479008','found','TSK-0051; primo post originale soltanto; host non verificati. Quantità dadi e cubi X/TBD: requisiti osservati, quantità non determinata.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('462','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479008','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Quantità dadi e cubi X/TBD: requisiti osservati, quantità non determinata.');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '462','printable_component','carte: cards] - on [1] A4 letter size Double sided PDF sheet','[9 cards] - on [1] A4 letter size Double sided PDF sheet','9','required','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - length TBD
[X] - d6 dice
[X] - Wood cubes','https://boardgamegeek.com/thread/3479008','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '462' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] A4 letter size Double sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479008');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '462','rules','regolamento: RULES - length TBD','[1] - RULES - length TBD','1','unclear','printable','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - length TBD
[X] - d6 dice
[X] - Wood cubes','https://boardgamegeek.com/thread/3479008','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '462' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - length TBD' AND quantity_raw IS '1' AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479008');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '462','randomizer','dadi: X] - d6 dice','[X] - d6 dice','X','unclear','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - length TBD
[X] - d6 dice
[X] - Wood cubes','https://boardgamegeek.com/thread/3479008','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '462' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: X] - d6 dice' AND quantity_raw IS 'X' AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479008');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '462','token_marker','segnalini: X] - Wood cubes','[X] - Wood cubes','X','unclear','common','[9 cards] - on [1] A4 letter size Double sided PDF sheet
[1] - RULES - length TBD
[X] - d6 dice
[X] - Wood cubes','https://boardgamegeek.com/thread/3479008','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '462' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: X] - Wood cubes' AND quantity_raw IS 'X' AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479008');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479778' WHERE id=463 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('463','2026-10-04','https://boardgamegeek.com/thread/3479778','found','TSK-0051; primo post originale soltanto; host non verificati. ','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('463','2026-10-04','https://boardgamegeek.com/thread/3479778','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('463','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479778','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '463','printable_component','carte: The 9 PnP cards','The 9 PnP cards','9','required','printable','The 9 PnP cards
18 tokens
6d6','https://boardgamegeek.com/thread/3479778','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '463' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: The 9 PnP cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479778');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '463','token_marker','segnalini: tokens','18 tokens','18','required','common','The 9 PnP cards
18 tokens
6d6','https://boardgamegeek.com/thread/3479778','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '463' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: tokens' AND quantity_raw IS '18' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479778');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '463','randomizer','dadi: d6','6d6','6','required','common','The 9 PnP cards
18 tokens
6d6','https://boardgamegeek.com/thread/3479778','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '463' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479778');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3452360' WHERE id=464 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('464','2026-10-04','https://boardgamegeek.com/thread/3452360','found','TSK-0051; primo post originale soltanto; host non verificati. Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('464','2026-10-04','https://boardgamegeek.com/thread/3452360','found','TSK-0051; primo post originale soltanto; host non verificati. Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('464','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3452360','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('464','rules','https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHpJ1L1kV3RGGWb?usp=drive_link','drive.google.com','https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHp...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (464,(SELECT id FROM remote_resources WHERE game_id=464 AND url='https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHpJ1L1kV3RGGWb?usp=drive_link'),'https://boardgamegeek.com/thread/3452360','https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHp...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=464 AND url='https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHpJ1L1kV3RGGWb?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3452360','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=464 AND url='https://drive.google.com/drive/folders/1uAg_ayT0o78BeEEhDnHpJ1L1kV3RGGWb?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3452360' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('464','online_play','https://playingcards.io/sgqurf','playingcards.io','https://playingcards.io/sgqurf',NULL,'unknown','2026-10-04','2026-10-04','web_app');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (464,(SELECT id FROM remote_resources WHERE game_id=464 AND url='https://playingcards.io/sgqurf'),'https://boardgamegeek.com/thread/3452360','https://playingcards.io/sgqurf','online_play',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=464 AND url='https://playingcards.io/sgqurf'),'2026-10-04','https://boardgamegeek.com/thread/3452360','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Autore dichiara Not print ready; versione online pronta. Non assimilare link a stampabilità verificata.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=464 AND url='https://playingcards.io/sgqurf') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3452360' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '464','printable_component','carte: cards - on 1 double-sided A4 PDF','9 cards - on 1 double-sided A4 PDF','9','required','printable','Not print ready
9 cards - on 1 double-sided A4 PDF
Rules - 3 Pages A4 PDF
Scenario - 2 Pages A4 PDF','https://boardgamegeek.com/thread/3452360','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '464' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards - on 1 double-sided A4 PDF' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452360');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '464','rules','regolamento: Rules - 3 Pages A4 PDF','Rules - 3 Pages A4 PDF',NULL,'required','printable','Not print ready
9 cards - on 1 double-sided A4 PDF
Rules - 3 Pages A4 PDF
Scenario - 2 Pages A4 PDF','https://boardgamegeek.com/thread/3452360','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '464' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules - 3 Pages A4 PDF' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452360');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '464','printable_component','scenario: Scenario - 2 Pages A4 PDF','Scenario - 2 Pages A4 PDF',NULL,'required','printable','Not print ready
9 cards - on 1 double-sided A4 PDF
Rules - 3 Pages A4 PDF
Scenario - 2 Pages A4 PDF','https://boardgamegeek.com/thread/3452360','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '464' AND material_kind IS 'printable_component' AND name_normalized IS 'scenario: Scenario - 2 Pages A4 PDF' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3452360');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3447498' WHERE id=465 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('465','2026-10-04','https://boardgamegeek.com/thread/3447498','found','TSK-0051; primo post originale soltanto; host non verificati. Components: tbc e Download Links: tbc. Placeholder espliciti; nessun requisito o URL pertinente dichiarato.','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('465','2026-10-04','https://boardgamegeek.com/thread/3447498','found','TSK-0051; primo post originale soltanto; host non verificati. Components: tbc e Download Links: tbc. Placeholder espliciti; nessun requisito o URL pertinente dichiarato.','none_declared','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('465','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3447498','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Components: tbc e Download Links: tbc. Placeholder espliciti; nessun requisito o URL pertinente dichiarato.');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3475750' WHERE id=466 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('466','2026-10-04','https://boardgamegeek.com/thread/3475750','found','TSK-0051; primo post originale soltanto; host non verificati. D10 omesso dalla v1.2; conservato nel testo storico, escluso dai requisiti correnti.','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('466','2026-10-04','https://boardgamegeek.com/thread/3475750','found','TSK-0051; primo post originale soltanto; host non verificati. D10 omesso dalla v1.2; conservato nel testo storico, escluso dai requisiti correnti.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('466','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3475750','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. D10 omesso dalla v1.2; conservato nel testo storico, escluso dai requisiti correnti.');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '466','printable_component','carte: double-sided cards + 1 single-sided card','8 double-sided cards + 1 single-sided card','8 double-sided + 1 single-sided','required','printable','8 double-sided cards + 1 single-sided card
8 player markers (8 different colors) - one per player in the game
16 d6 dice (four each of four different colors - specific amount and combinations vary by player count)
1 d10 die (any color) (omitted as of v1.2)
Rules (4 pp.)','https://boardgamegeek.com/thread/3475750','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '466' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards + 1 single-sided card' AND quantity_raw IS '8 double-sided + 1 single-sided' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475750');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '466','token_marker','segnalini: player markers (8 different colors) - one per player in the game','8 player markers (8 different colors) - one per player in the game','8','required','common','8 double-sided cards + 1 single-sided card
8 player markers (8 different colors) - one per player in the game
16 d6 dice (four each of four different colors - specific amount and combinations vary by player count)
1 d10 die (any color) (omitted as of v1.2)
Rules (4 pp.)','https://boardgamegeek.com/thread/3475750','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '466' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: player markers (8 different colors) - one per player in the game' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475750');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '466','randomizer','dadi: d6 dice (four each of four different colors - specific amount and combinations vary by player count)','16 d6 dice (four each of four different colors - specific amount and combinations vary by player count)','16','required','common','8 double-sided cards + 1 single-sided card
8 player markers (8 different colors) - one per player in the game
16 d6 dice (four each of four different colors - specific amount and combinations vary by player count)
1 d10 die (any color) (omitted as of v1.2)
Rules (4 pp.)','https://boardgamegeek.com/thread/3475750','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '466' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 dice (four each of four different colors - specific amount and combinations vary by player count)' AND quantity_raw IS '16' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475750');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '466','rules','regolamento: Rules (4 pp.)','Rules (4 pp.)',NULL,'required','printable','8 double-sided cards + 1 single-sided card
8 player markers (8 different colors) - one per player in the game
16 d6 dice (four each of four different colors - specific amount and combinations vary by player count)
1 d10 die (any color) (omitted as of v1.2)
Rules (4 pp.)','https://boardgamegeek.com/thread/3475750','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '466' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules (4 pp.)' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475750');
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('467','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. N/A, Ryan Shaffer / @ryanshaffer; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('467','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_found','TSK-0051; primo post originale soltanto; host non verificati. N/A, Ryan Shaffer / @ryanshaffer; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('467','materials','blocked','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. N/A, Ryan Shaffer / @ryanshaffer; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3475125' WHERE id=468 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('468','2026-10-04','https://boardgamegeek.com/thread/3475125','found','TSK-0051; primo post originale soltanto; host non verificati. 5 cubi generici ma quattro impieghi enumerati; dadi Several senza quantità. Non risolto.','none_declared');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('468','2026-10-04','https://boardgamegeek.com/thread/3475125','found','TSK-0051; primo post originale soltanto; host non verificati. 5 cubi generici ma quattro impieghi enumerati; dadi Several senza quantità. Non risolto.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('468','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3475125','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. 5 cubi generici ma quattro impieghi enumerati; dadi Several senza quantità. Non risolto.');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','printable_component','carte','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','9','required','printable','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'printable_component' AND name_normalized IS 'carte' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','token_marker','cubi rossi HP','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','5','required','common','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi rossi HP' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','token_marker','cubi tracker altri colori','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','5','required','common','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'token_marker' AND name_normalized IS 'cubi tracker altri colori' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','randomizer','d6 combattimento','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','1','required','common','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'randomizer' AND name_normalized IS 'd6 combattimento' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','randomizer','d6 nemici','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','Several','required','common','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'randomizer' AND name_normalized IS 'd6 nemici' AND quantity_raw IS 'Several' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '468','randomizer','d6 colori differenti','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','Several','required','common','- 9 cards as per contest rules
--- 4 cards making up the game table, this is the whole area of the facility
--- 4 cards depicting monsters, events and scenarios (rule change)
--- 1 card used as a tracker for credits, turns...
- 5 red cube for HP
- 5 cubes of preferred colors - can be different colors
--- 1 for keeping track of your credits
--- 1 for keeping track of turns
--- 1 to mark the breach zone
--- 1 to mark the escape point of monsters
- 1 D6 die for combat and randomization
- Several D6 marking the enemies
- Several D6 of different colors (green = poison, red = default, blue = chain attack)','https://boardgamegeek.com/thread/3475125','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '468' AND material_kind IS 'randomizer' AND name_normalized IS 'd6 colori differenti' AND quantity_raw IS 'Several' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3475125');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477165' WHERE id=469 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('469','2026-10-04','https://boardgamegeek.com/thread/3477165','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('469','2026-10-04','https://boardgamegeek.com/thread/3477165','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('469','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477165','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','game_files','https://drive.google.com/drive/folders/1ICLTVfbAzNSDNFpdhUayt_xvnJ_Tlrif?usp=drive_link','drive.google.com','Google Drive Folder: 1865: Flying Confederacy and the Guns of Freedom',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/drive/folders/1ICLTVfbAzNSDNFpdhUayt_xvnJ_Tlrif?usp=drive_link'),'https://boardgamegeek.com/thread/3477165','Google Drive Folder: 1865: Flying Confederacy and the Guns of Freedom','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/drive/folders/1ICLTVfbAzNSDNFpdhUayt_xvnJ_Tlrif?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/drive/folders/1ICLTVfbAzNSDNFpdhUayt_xvnJ_Tlrif?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','rules','https://drive.google.com/file/d/19RDt1b7fMvRTGWHcoAY9DBMqR0ysdIlK/view?usp=drive_link','drive.google.com','1865: FCatGoF Rulebook',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/19RDt1b7fMvRTGWHcoAY9DBMqR0ysdIlK/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477165','1865: FCatGoF Rulebook','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/19RDt1b7fMvRTGWHcoAY9DBMqR0ysdIlK/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/19RDt1b7fMvRTGWHcoAY9DBMqR0ysdIlK/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','player_aid','https://drive.google.com/file/d/1AQVBGaQU02g5q1RbdR9RBov-BnhwgBUl/view?usp=drive_link','drive.google.com','1865: FCatGoF Reference Sheet',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1AQVBGaQU02g5q1RbdR9RBov-BnhwgBUl/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477165','1865: FCatGoF Reference Sheet','player_aid',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1AQVBGaQU02g5q1RbdR9RBov-BnhwgBUl/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1AQVBGaQU02g5q1RbdR9RBov-BnhwgBUl/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','component','https://drive.google.com/file/d/1b9xx42n3aiLjZbymY1or-s28pA9l1Azq/view?usp=drive_link','drive.google.com','1865: FCatGoF Cards Back',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1b9xx42n3aiLjZbymY1or-s28pA9l1Azq/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477165','1865: FCatGoF Cards Back','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1b9xx42n3aiLjZbymY1or-s28pA9l1Azq/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1b9xx42n3aiLjZbymY1or-s28pA9l1Azq/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','component','https://drive.google.com/file/d/1w0eVFt6u5FqPzk1oDTT8lRPcsHOSGvMd/view?usp=drive_link','drive.google.com','1865: FCatGoF Cards Front',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1w0eVFt6u5FqPzk1oDTT8lRPcsHOSGvMd/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477165','1865: FCatGoF Cards Front','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1w0eVFt6u5FqPzk1oDTT8lRPcsHOSGvMd/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://drive.google.com/file/d/1w0eVFt6u5FqPzk1oDTT8lRPcsHOSGvMd/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('469','video','https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh','youtu.be','https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (469,(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh'),'https://boardgamegeek.com/thread/3477165','https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=469 AND url='https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh'),'2026-10-04','https://boardgamegeek.com/thread/3477165','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=469 AND url='https://youtu.be/WPj8FTbdXI0?si=a2y-ZaK1Vb6rsCeh') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477165' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','rules','regolamento: Rulebook','1 Rulebook','1','required','printable','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','printable_component','carte: Cards (Bombers)','5 Cards (Bombers)','5','required','printable','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards (Bombers)' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','printable_component','carte: Quarter Cards (16 Components)','4 Quarter Cards (16 Components)','4','required','printable','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Quarter Cards (16 Components)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','token_marker','segnalini: Blue Cube (8-12mm)','1 Blue Cube (8-12mm)','1','required','common','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Blue Cube (8-12mm)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','token_marker','segnalini: Red Cube (8-12mm)','1 Red Cube (8-12mm)','1','required','common','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Red Cube (8-12mm)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','randomizer','dadi: d6 (white - approx. 16mm)','5d6 (white - approx. 16mm)','5','required','common','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 (white - approx. 16mm)' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '469','randomizer','dadi: d6 (red - approx. 16mm)','1d6 (red - approx. 16mm)','1','required','common','1 Rulebook
5 Cards (Bombers)
4 Quarter Cards (16 Components)
1 Blue Cube (8-12mm)
1 Red Cube (8-12mm)
5d6 (white - approx. 16mm)
1d6 (red - approx. 16mm)','https://boardgamegeek.com/thread/3477165','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '469' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 (red - approx. 16mm)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477165');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477933' WHERE id=470 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('470','2026-10-04','https://boardgamegeek.com/thread/3477933','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('470','2026-10-04','https://boardgamegeek.com/thread/3477933','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('470','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477933','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('470','component','https://drive.google.com/file/d/1-Fh8NJEynTdpSrii8I1P5ZkQb8R2SsJo/view?usp=drive_link','drive.google.com','Card Files',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (470,(SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1-Fh8NJEynTdpSrii8I1P5ZkQb8R2SsJo/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477933','Card Files','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1-Fh8NJEynTdpSrii8I1P5ZkQb8R2SsJo/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477933','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1-Fh8NJEynTdpSrii8I1P5ZkQb8R2SsJo/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477933' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('470','game_files','https://drive.google.com/file/d/1IGHbVdN5EbNbs-6lIUsFED1pHU_Wq4er/view?usp=drive_link','drive.google.com','Rule Files',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (470,(SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1IGHbVdN5EbNbs-6lIUsFED1pHU_Wq4er/view?usp=drive_link'),'https://boardgamegeek.com/thread/3477933','Rule Files','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1IGHbVdN5EbNbs-6lIUsFED1pHU_Wq4er/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3477933','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=470 AND url='https://drive.google.com/file/d/1IGHbVdN5EbNbs-6lIUsFED1pHU_Wq4er/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477933' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '470','printable_component','carte: Guest Cards Card Files','9 Guest Cards Card Files','9','required','printable','9 Guest Cards Card Files
1 Rulebook (1 double-sided A4 page) Rule Files
Optional: Scoring tracker (notepad, tokens, etc)','https://boardgamegeek.com/thread/3477933','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '470' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Guest Cards Card Files' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477933');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '470','rules','regolamento: Rulebook (1 double-sided A4 page) Rule Files','1 Rulebook (1 double-sided A4 page) Rule Files','1','required','printable','9 Guest Cards Card Files
1 Rulebook (1 double-sided A4 page) Rule Files
Optional: Scoring tracker (notepad, tokens, etc)','https://boardgamegeek.com/thread/3477933','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '470' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook (1 double-sided A4 page) Rule Files' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477933');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '470','token_marker','segnalini: Optional: Scoring tracker (notepad, tokens, etc)','Optional: Scoring tracker (notepad, tokens, etc)',NULL,'optional','common','9 Guest Cards Card Files
1 Rulebook (1 double-sided A4 page) Rule Files
Optional: Scoring tracker (notepad, tokens, etc)','https://boardgamegeek.com/thread/3477933','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '470' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Optional: Scoring tracker (notepad, tokens, etc)' AND quantity_raw IS NULL AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3477933');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3440581' WHERE id=471 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('471','2026-10-04','https://boardgamegeek.com/thread/3440581','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('471','2026-10-04','https://boardgamegeek.com/thread/3440581','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('471','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3440581','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('471','component','https://drive.google.com/file/d/1QvB-sRFz5oXRm2DugsPAk5F5AoIhnEhW/view?usp=sharing','drive.google.com','Low Ink Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (471,(SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1QvB-sRFz5oXRm2DugsPAk5F5AoIhnEhW/view?usp=sharing'),'https://boardgamegeek.com/thread/3440581','Low Ink Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1QvB-sRFz5oXRm2DugsPAk5F5AoIhnEhW/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440581','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1QvB-sRFz5oXRm2DugsPAk5F5AoIhnEhW/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440581' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('471','rules','https://drive.google.com/file/d/1okVdo-pnnNqnOmD0MlsOB8z9fvnUpz_R/view?usp=sharing','drive.google.com','Rulebook',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (471,(SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1okVdo-pnnNqnOmD0MlsOB8z9fvnUpz_R/view?usp=sharing'),'https://boardgamegeek.com/thread/3440581','Rulebook','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1okVdo-pnnNqnOmD0MlsOB8z9fvnUpz_R/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440581','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=471 AND url='https://drive.google.com/file/d/1okVdo-pnnNqnOmD0MlsOB8z9fvnUpz_R/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440581' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','randomizer','dadi: Red D6 Dice','5 Red D6 Dice','5','required','common','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Red D6 Dice' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','randomizer','dadi: Blue D6 Dice','5 Blue D6 Dice','5','required','common','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: Blue D6 Dice' AND quantity_raw IS '5' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','randomizer','dadi: White D6 Dice','3 White D6 Dice','3','required','common','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: White D6 Dice' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','container','contenitori copridado o mani','2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.','2','alternative','household','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'container' AND name_normalized IS 'contenitori copridado o mani' AND quantity_raw IS '2' AND requirement_level IS 'alternative' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','printable_component','carte: Cards','9 Cards','9','required','printable','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','rules','regolamento: Rulebook','Rulebook',NULL,'required','printable','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '471','token_marker','segnalini: Optional] A coin, token or object that can serve as the first-player marker.','[Optional] A coin, token or object that can serve as the first-player marker.',NULL,'optional','common','5 Red D6 Dice
5 Blue D6 Dice
3 White D6 Dice
(The colors of the dice don''t matter. Use any combination you want as long as you can tell the three kinds of dice apart.)
2 cups, bowls or other containers to cover dice with. You can even use your hands in a pinch.
9 Cards
Rulebook
[Optional] A coin, token or object that can serve as the first-player marker.','https://boardgamegeek.com/thread/3440581','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '471' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Optional] A coin, token or object that can serve as the first-player marker.' AND quantity_raw IS NULL AND requirement_level IS 'optional' AND source_url IS 'https://boardgamegeek.com/thread/3440581');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3468802' WHERE id=472 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('472','2026-10-04','https://boardgamegeek.com/thread/3468802','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('472','2026-10-04','https://boardgamegeek.com/thread/3468802','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('472','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3468802','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('472','game_files','https://drive.google.com/drive/folders/1LlyzN-f0O8wEJ6D83cYVxzAs-qfIpCS9?usp=sharing','drive.google.com','Rules and cards',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (472,(SELECT id FROM remote_resources WHERE game_id=472 AND url='https://drive.google.com/drive/folders/1LlyzN-f0O8wEJ6D83cYVxzAs-qfIpCS9?usp=sharing'),'https://boardgamegeek.com/thread/3468802','Rules and cards','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=472 AND url='https://drive.google.com/drive/folders/1LlyzN-f0O8wEJ6D83cYVxzAs-qfIpCS9?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3468802','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=472 AND url='https://drive.google.com/drive/folders/1LlyzN-f0O8wEJ6D83cYVxzAs-qfIpCS9?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3468802' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '472','rules','regolamento: Rulebook','Rulebook',NULL,'required','printable','- Rulebook
- 9 double-sided cards','https://boardgamegeek.com/thread/3468802','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '472' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook' AND quantity_raw IS NULL AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468802');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '472','printable_component','carte: double-sided cards','9 double-sided cards','9','required','printable','- Rulebook
- 9 double-sided cards','https://boardgamegeek.com/thread/3468802','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '472' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: double-sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3468802');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3476068' WHERE id=473 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('473','2026-10-04','https://boardgamegeek.com/thread/3476068','found','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('473','2026-10-04','https://boardgamegeek.com/thread/3476068','found','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('473','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3476068','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('473','game_files','https://drive.google.com/drive/folders/1DP3vyWz7UI1_zjS77_88kZUJxpyOgXXC?usp=drive_link','drive.google.com','Here | ElementaBrawl Main Folder',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (473,(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/drive/folders/1DP3vyWz7UI1_zjS77_88kZUJxpyOgXXC?usp=drive_link'),'https://boardgamegeek.com/thread/3476068','Here | ElementaBrawl Main Folder','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/drive/folders/1DP3vyWz7UI1_zjS77_88kZUJxpyOgXXC?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3476068','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/drive/folders/1DP3vyWz7UI1_zjS77_88kZUJxpyOgXXC?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3476068' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('473','rules','https://drive.google.com/file/d/1KKgEqY70xHaaFVe0-yqG0ErqawMyxcGJ/view?usp=drive_link','drive.google.com','Rulebook v1.0','v1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (473,(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1KKgEqY70xHaaFVe0-yqG0ErqawMyxcGJ/view?usp=drive_link'),'https://boardgamegeek.com/thread/3476068','Rulebook v1.0','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1KKgEqY70xHaaFVe0-yqG0ErqawMyxcGJ/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3476068','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1KKgEqY70xHaaFVe0-yqG0ErqawMyxcGJ/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3476068' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('473','component','https://drive.google.com/file/d/1PBCDy5CCG-aiqcfCPY8thJy9zhcI_nVB/view?usp=drive_link','drive.google.com','Event Cards - Full Ink v1.0','v1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (473,(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1PBCDy5CCG-aiqcfCPY8thJy9zhcI_nVB/view?usp=drive_link'),'https://boardgamegeek.com/thread/3476068','Event Cards - Full Ink v1.0','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1PBCDy5CCG-aiqcfCPY8thJy9zhcI_nVB/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3476068','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1PBCDy5CCG-aiqcfCPY8thJy9zhcI_nVB/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3476068' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('473','component','https://drive.google.com/file/d/1tNWbs4wHvUJlQp5L1x_gWLVbkEGe7uDs/view?usp=drive_link','drive.google.com','Event Cards - Low Ink v1.0','v1.0','unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (473,(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1tNWbs4wHvUJlQp5L1x_gWLVbkEGe7uDs/view?usp=drive_link'),'https://boardgamegeek.com/thread/3476068','Event Cards - Low Ink v1.0','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1tNWbs4wHvUJlQp5L1x_gWLVbkEGe7uDs/view?usp=drive_link'),'2026-10-04','https://boardgamegeek.com/thread/3476068','declared_in_wip','not_checked','v1.0','TSK-0051; primo post originale soltanto; host non verificati. Un solo ElementaBrawl nel roster ufficiale; baseline locale scissa in 473 Elementa e 474 Brawl. Evidenze collegate soltanto a 473 come corrispondenza provvisoria; 474 bloccato, nessun merge o duplicazione.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=473 AND url='https://drive.google.com/file/d/1tNWbs4wHvUJlQp5L1x_gWLVbkEGe7uDs/view?usp=drive_link') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3476068' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','rules','regolamento: Rulebook (12 pages)','1 Rulebook (12 pages)','1','required','printable','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rulebook (12 pages)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','player_aid','foglio riferimento: Reference Sheet','1 Reference Sheet','1','required','printable','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'player_aid' AND name_normalized IS 'foglio riferimento: Reference Sheet' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','printable_component','carte: Event Cards','9 Event Cards','9','required','printable','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Event Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','randomizer','dadi: d20 (Black - Starting Life Dice)','4 d20 (Black - Starting Life Dice)','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d20 (Black - Starting Life Dice)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','randomizer','dadi: d20 (White - Additional Life Dice)','4 d20 (White - Additional Life Dice)','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d20 (White - Additional Life Dice)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','randomizer','dadi: d6 (Black - Attack Dice)','4 d6 (Black - Attack Dice)','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 (Black - Attack Dice)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','randomizer','dadi: d6 (White - Defense Dice)','4 d6 (White - Defense Dice)','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 (White - Defense Dice)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','randomizer','dadi: d4 (Targeting Dice)','4 d4 (Targeting Dice)','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d4 (Targeting Dice)' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '473','token_marker','segnalini: "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','4','required','common','1 Rulebook (12 pages)
1 Reference Sheet
9 Event Cards
4 d20 (Black - Starting Life Dice)
4 d20 (White - Additional Life Dice)
4 d6 (Black - Attack Dice)
4 d6 (White - Defense Dice)
4 d4 (Targeting Dice)
4 "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube','https://boardgamegeek.com/thread/3476068','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '473' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: "Elemental Essence Markers": 1 Red Cube, 1 Blue Cube, 1 White Cube, 1 Green Cube' AND quantity_raw IS '4' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3476068');
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('474','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_checked','TSK-0051; primo post originale soltanto; host non verificati. Brawl: secondo frammento della scissione locale ElementaBrawl; identità distinta non attestata; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('474','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','not_checked','TSK-0051; primo post originale soltanto; host non verificati. Brawl: secondo frammento della scissione locale ElementaBrawl; identità distinta non attestata; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.','not_checked','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('474','materials','blocked','2026-10-04','https://boardgamegeek.com/thread/3436343/2025-9-card-nanogame-print-and-play-design-contest','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Brawl: secondo frammento della scissione locale ElementaBrawl; identità distinta non attestata; nessun requisito o risorsa inferiti. Roster ufficiale e pagine 2–24 controllati; nessun WIP pertinente individuato.');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3469537' WHERE id=475 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('475','2026-10-04','https://boardgamegeek.com/thread/3469537','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('475','2026-10-04','https://boardgamegeek.com/thread/3469537','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('475','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3469537','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('475','game_files','https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4RiXJ7MlJo0pH?usp=sharing','drive.google.com','https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (475,(SELECT id FROM remote_resources WHERE game_id=475 AND url='https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4RiXJ7MlJo0pH?usp=sharing'),'https://boardgamegeek.com/thread/3469537','https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=475 AND url='https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4RiXJ7MlJo0pH?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3469537','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=475 AND url='https://drive.google.com/drive/folders/1ScH993C4k9SmQPTmVGB4RiXJ7MlJo0pH?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3469537' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','randomizer','d6 blu','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','3','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'randomizer' AND name_normalized IS 'd6 blu' AND quantity_raw IS '3' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','randomizer','d6 bianco','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'randomizer' AND name_normalized IS 'd6 bianco' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','token_marker','meeple kobun per giocatore','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','4 per player','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple kobun per giocatore' AND quantity_raw IS '4 per player' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','token_marker','meeple mafia straniera','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','2','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple mafia straniera' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','token_marker','meeple polizia','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple polizia' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','token_marker','meeple boss','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','common','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'token_marker' AND name_normalized IS 'meeple boss' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','printable_component','carte kinjo','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','6','required','printable','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'printable_component' AND name_normalized IS 'carte kinjo' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','printable_component','carta centrale','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','printable','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'printable_component' AND name_normalized IS 'carta centrale' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','printable_component','carta kaichou/keisatsu/mafia','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','printable','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'printable_component' AND name_normalized IS 'carta kaichou/keisatsu/mafia' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '475','printable_component','carta oyabun','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','1','required','printable','Dice:
• 3 blue dice (D6).
• 1 white die (D6).
Meeples:
• 4 meeples per player in red, green, blue, and yellow (kobun).
• 2 foreign mafia meeples (light and dark pink).
• 1 black meeple (keisatsu - police).
• 1 white meeple (kaichou - supreme mafia boss).
Cards:
• 6 kinjo cards (city neighborhoods).
• 1 central card (contains the prison and temple).
• 1 kaichou / keisatsu / foreign mafia card.
• 1 oyabun card (one for all players, with summarized rules).','https://boardgamegeek.com/thread/3469537','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '475' AND material_kind IS 'printable_component' AND name_normalized IS 'carta oyabun' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3469537');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3461857' WHERE id=476 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('476','2026-10-04','https://boardgamegeek.com/thread/3461857','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('476','2026-10-04','https://boardgamegeek.com/thread/3461857','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('476','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3461857','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('476','game_files','https://drive.google.com/drive/folders/1zMVmyC8WCc6brplrmRYFtPAZrFnfCOO7?usp=sharing','drive.google.com','here',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (476,(SELECT id FROM remote_resources WHERE game_id=476 AND url='https://drive.google.com/drive/folders/1zMVmyC8WCc6brplrmRYFtPAZrFnfCOO7?usp=sharing'),'https://boardgamegeek.com/thread/3461857','here','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=476 AND url='https://drive.google.com/drive/folders/1zMVmyC8WCc6brplrmRYFtPAZrFnfCOO7?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3461857','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=476 AND url='https://drive.google.com/drive/folders/1zMVmyC8WCc6brplrmRYFtPAZrFnfCOO7?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3461857' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('476','video','https://youtu.be/t8C-cuhLsaw','youtu.be','here',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (476,(SELECT id FROM remote_resources WHERE game_id=476 AND url='https://youtu.be/t8C-cuhLsaw'),'https://boardgamegeek.com/thread/3461857','here','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=476 AND url='https://youtu.be/t8C-cuhLsaw'),'2026-10-04','https://boardgamegeek.com/thread/3461857','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=476 AND url='https://youtu.be/t8C-cuhLsaw') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3461857' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '476','printable_component','carte: Cards: 1 A4 PDF','[9] Cards: 1 A4 PDF','9','required','printable','[9] Cards: 1 A4 PDF
[1] Rules: 6 A4 PDF
[24] Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue','https://boardgamegeek.com/thread/3461857','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '476' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards: 1 A4 PDF' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461857');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '476','rules','regolamento: Rules: 6 A4 PDF','[1] Rules: 6 A4 PDF','1','required','printable','[9] Cards: 1 A4 PDF
[1] Rules: 6 A4 PDF
[24] Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue','https://boardgamegeek.com/thread/3461857','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '476' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: Rules: 6 A4 PDF' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461857');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '476','token_marker','segnalini: Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue','[24] Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue','24','required','common','[9] Cards: 1 A4 PDF
[1] Rules: 6 A4 PDF
[24] Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue','https://boardgamegeek.com/thread/3461857','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '476' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Poker chips: 6 White, 6 Red, 6 Yellow, 6 Blue' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3461857');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3478441' WHERE id=477 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('477','2026-10-04','https://boardgamegeek.com/thread/3478441','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('477','2026-10-04','https://boardgamegeek.com/thread/3478441','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('477','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3478441','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('477','game_files','https://drive.google.com/drive/folders/1XLtEA8vhPw_x-9if_zMtZbvunoni1ViD','drive.google.com','Project directory
',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (477,(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/drive/folders/1XLtEA8vhPw_x-9if_zMtZbvunoni1ViD'),'https://boardgamegeek.com/thread/3478441','Project directory
','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/drive/folders/1XLtEA8vhPw_x-9if_zMtZbvunoni1ViD'),'2026-10-04','https://boardgamegeek.com/thread/3478441','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/drive/folders/1XLtEA8vhPw_x-9if_zMtZbvunoni1ViD') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3478441' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('477','rules','https://drive.google.com/file/d/1ikfS6yygYluX7PnIe4lQDfTfw_nh2g97','drive.google.com','Latest Rules',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (477,(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1ikfS6yygYluX7PnIe4lQDfTfw_nh2g97'),'https://boardgamegeek.com/thread/3478441','Latest Rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1ikfS6yygYluX7PnIe4lQDfTfw_nh2g97'),'2026-10-04','https://boardgamegeek.com/thread/3478441','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1ikfS6yygYluX7PnIe4lQDfTfw_nh2g97') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3478441' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('477','component','https://drive.google.com/file/d/1oGgyI34j7Sry-D7Ow3-6fYk4l25KsyqJ','drive.google.com','Latest Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (477,(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1oGgyI34j7Sry-D7Ow3-6fYk4l25KsyqJ'),'https://boardgamegeek.com/thread/3478441','Latest Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1oGgyI34j7Sry-D7Ow3-6fYk4l25KsyqJ'),'2026-10-04','https://boardgamegeek.com/thread/3478441','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=477 AND url='https://drive.google.com/file/d/1oGgyI34j7Sry-D7Ow3-6fYk4l25KsyqJ') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3478441' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '477','printable_component','carte: cards] - on [1] US letter size Double-sided PDF sheet','[9 cards] - on [1] US letter size Double-sided PDF sheet','9','required','printable','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF
[23] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3478441','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '477' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] US letter size Double-sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478441');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '477','rules','regolamento: RULES - 4 Pages US Letter size Double-sided PDF','[1] - RULES - 4 Pages US Letter size Double-sided PDF','1','required','printable','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF
[23] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3478441','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '477' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 4 Pages US Letter size Double-sided PDF' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478441');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '477','token_marker','segnalini: Wood cubes - [Any color]','[23] - Wood cubes - [Any color]','23','required','common','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF
[23] - Wood cubes - [Any color]','https://boardgamegeek.com/thread/3478441','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '477' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wood cubes - [Any color]' AND quantity_raw IS '23' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3478441');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3441059' WHERE id=478 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('478','2026-10-04','https://boardgamegeek.com/thread/3441059','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('478','2026-10-04','https://boardgamegeek.com/thread/3441059','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('478','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3441059','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('478','game_files','https://drive.google.com/drive/folders/1J28pVDToIVKSx5PQRUHbYqwWE4wx3TwH','drive.google.com','Project directory
',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (478,(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/drive/folders/1J28pVDToIVKSx5PQRUHbYqwWE4wx3TwH'),'https://boardgamegeek.com/thread/3441059','Project directory
','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/drive/folders/1J28pVDToIVKSx5PQRUHbYqwWE4wx3TwH'),'2026-10-04','https://boardgamegeek.com/thread/3441059','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/drive/folders/1J28pVDToIVKSx5PQRUHbYqwWE4wx3TwH') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441059' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('478','component','https://drive.google.com/file/d/1Opca5DSR0Yrr9gyFU1JpLhCBwbcw5--K','drive.google.com','Latest Cards',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (478,(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1Opca5DSR0Yrr9gyFU1JpLhCBwbcw5--K'),'https://boardgamegeek.com/thread/3441059','Latest Cards','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1Opca5DSR0Yrr9gyFU1JpLhCBwbcw5--K'),'2026-10-04','https://boardgamegeek.com/thread/3441059','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1Opca5DSR0Yrr9gyFU1JpLhCBwbcw5--K') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441059' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('478','rules','https://drive.google.com/file/d/1qqPE8P2AeQ56kJbz6_CVLcmdesO3-ATW','drive.google.com','Latest Rules',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (478,(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1qqPE8P2AeQ56kJbz6_CVLcmdesO3-ATW'),'https://boardgamegeek.com/thread/3441059','Latest Rules','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1qqPE8P2AeQ56kJbz6_CVLcmdesO3-ATW'),'2026-10-04','https://boardgamegeek.com/thread/3441059','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=478 AND url='https://drive.google.com/file/d/1qqPE8P2AeQ56kJbz6_CVLcmdesO3-ATW') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3441059' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '478','printable_component','carte: cards] - on [1] US letter size Double-sided PDF sheet','[9 cards] - on [1] US letter size Double-sided PDF sheet','9','required','printable','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet
[23] - Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]
[1] - Bag or cup to draw the cubes from','https://boardgamegeek.com/thread/3441059','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '478' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] US letter size Double-sided PDF sheet' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441059');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '478','rules','regolamento: RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet','[1] - RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet','1','required','printable','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet
[23] - Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]
[1] - Bag or cup to draw the cubes from','https://boardgamegeek.com/thread/3441059','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '478' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441059');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '478','token_marker','segnalini: Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]','[23] - Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]','23','required','common','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet
[23] - Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]
[1] - Bag or cup to draw the cubes from','https://boardgamegeek.com/thread/3441059','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '478' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]' AND quantity_raw IS '23' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441059');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '478','container','contenitore: Bag or cup to draw the cubes from','[1] - Bag or cup to draw the cubes from','1','required','household','[9 cards] - on [1] US letter size Double-sided PDF sheet
[1] - RULES - 4 Pages US Letter size Double-sided PDF with the last page as a reference sheet
[23] - Wood cubes - [9 Red, 9 Blue, 5 White (or any other color)]
[1] - Bag or cup to draw the cubes from','https://boardgamegeek.com/thread/3441059','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '478' AND material_kind IS 'container' AND name_normalized IS 'contenitore: Bag or cup to draw the cubes from' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3441059');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479556' WHERE id=479 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('479','2026-10-04','https://boardgamegeek.com/thread/3479556','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('479','2026-10-04','https://boardgamegeek.com/thread/3479556','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('479','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479556','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('479','component','https://drive.google.com/file/d/1lEidsVmBDCH9imeYHZ-PJLjUulk9YYXZ/view?usp=sharing','drive.google.com','Cards - 16 March 2025',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (479,(SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1lEidsVmBDCH9imeYHZ-PJLjUulk9YYXZ/view?usp=sharing'),'https://boardgamegeek.com/thread/3479556','Cards - 16 March 2025','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1lEidsVmBDCH9imeYHZ-PJLjUulk9YYXZ/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479556','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1lEidsVmBDCH9imeYHZ-PJLjUulk9YYXZ/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479556' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('479','rules','https://drive.google.com/file/d/1tD6elXAEpaUYkIbQQAzu69UgrSDfn86_/view?usp=sharing','drive.google.com','Rulebook - 16 March 2025',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (479,(SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1tD6elXAEpaUYkIbQQAzu69UgrSDfn86_/view?usp=sharing'),'https://boardgamegeek.com/thread/3479556','Rulebook - 16 March 2025','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1tD6elXAEpaUYkIbQQAzu69UgrSDfn86_/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479556','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=479 AND url='https://drive.google.com/file/d/1tD6elXAEpaUYkIbQQAzu69UgrSDfn86_/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479556' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','printable_component','carte: cards','9 cards','9','required','printable','9 cards
- 1 Space Exploration Track card
- 4 System cards
- 2 double-sided Spaceship Upgrade/Bounty cards
- 2 double-sided resource tracker cards (1 for each player)

24 Additional Components
- 6 d10s
- 2 Wooden Cubes (1 each in 2 different colours)
- 8 Meeples (4 each in 2 different colours)
- 8 Paperclips (4 each in 2 different colours)','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','randomizer','dadi: d10s','6 d10s','6','required','common','9 cards
- 1 Space Exploration Track card
- 4 System cards
- 2 double-sided Spaceship Upgrade/Bounty cards
- 2 double-sided resource tracker cards (1 for each player)

24 Additional Components
- 6 d10s
- 2 Wooden Cubes (1 each in 2 different colours)
- 8 Meeples (4 each in 2 different colours)
- 8 Paperclips (4 each in 2 different colours)','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d10s' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','token_marker','segnalini: Wooden Cubes (1 each in 2 different colours)','2 Wooden Cubes (1 each in 2 different colours)','2','required','common','9 cards
- 1 Space Exploration Track card
- 4 System cards
- 2 double-sided Spaceship Upgrade/Bounty cards
- 2 double-sided resource tracker cards (1 for each player)

24 Additional Components
- 6 d10s
- 2 Wooden Cubes (1 each in 2 different colours)
- 8 Meeples (4 each in 2 different colours)
- 8 Paperclips (4 each in 2 different colours)','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Wooden Cubes (1 each in 2 different colours)' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','token_marker','segnalini: Meeples (4 each in 2 different colours)','8 Meeples (4 each in 2 different colours)','8','required','common','9 cards
- 1 Space Exploration Track card
- 4 System cards
- 2 double-sided Spaceship Upgrade/Bounty cards
- 2 double-sided resource tracker cards (1 for each player)

24 Additional Components
- 6 d10s
- 2 Wooden Cubes (1 each in 2 different colours)
- 8 Meeples (4 each in 2 different colours)
- 8 Paperclips (4 each in 2 different colours)','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Meeples (4 each in 2 different colours)' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','token_marker','segnalini: Paperclips (4 each in 2 different colours)','8 Paperclips (4 each in 2 different colours)','8','required','common','9 cards
- 1 Space Exploration Track card
- 4 System cards
- 2 double-sided Spaceship Upgrade/Bounty cards
- 2 double-sided resource tracker cards (1 for each player)

24 Additional Components
- 6 d10s
- 2 Wooden Cubes (1 each in 2 different colours)
- 8 Meeples (4 each in 2 different colours)
- 8 Paperclips (4 each in 2 different colours)','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Paperclips (4 each in 2 different colours)' AND quantity_raw IS '8' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '479','rules','regolamento dichiarato nei link','Rulebook - 16 March 2025',NULL,'unclear','printable','Rulebook - 16 March 2025','https://boardgamegeek.com/thread/3479556','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '479' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479556');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479036' WHERE id=480 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('480','2026-10-04','https://boardgamegeek.com/thread/3479036','found','TSK-0051; primo post originale soltanto; host non verificati. Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('480','2026-10-04','https://boardgamegeek.com/thread/3479036','found','TSK-0051; primo post originale soltanto; host non verificati. Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('480','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479036','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('480','component','https://drive.google.com/file/d/1N_GuoBqwT_ybH-Erh5RXR7rtfytHMmur/view?usp=drivesdk','drive.google.com','SPLAT! CARDS',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (480,(SELECT id FROM remote_resources WHERE game_id=480 AND url='https://drive.google.com/file/d/1N_GuoBqwT_ybH-Erh5RXR7rtfytHMmur/view?usp=drivesdk'),'https://boardgamegeek.com/thread/3479036','SPLAT! CARDS','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=480 AND url='https://drive.google.com/file/d/1N_GuoBqwT_ybH-Erh5RXR7rtfytHMmur/view?usp=drivesdk'),'2026-10-04','https://boardgamegeek.com/thread/3479036','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=480 AND url='https://drive.google.com/file/d/1N_GuoBqwT_ybH-Erh5RXR7rtfytHMmur/view?usp=drivesdk') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479036' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('480','video','https://youtube.com/watch?v=JwCFa7n06QM','youtube.com','SPLAT! A Short Fast Paced 2 Player 9-Card PnP',NULL,'unknown','2026-10-04','2026-10-04','video');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (480,(SELECT id FROM remote_resources WHERE game_id=480 AND url='https://youtube.com/watch?v=JwCFa7n06QM'),'https://boardgamegeek.com/thread/3479036','SPLAT! A Short Fast Paced 2 Player 9-Card PnP','video',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=480 AND url='https://youtube.com/watch?v=JwCFa7n06QM'),'2026-10-04','https://boardgamegeek.com/thread/3479036','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Dadi dichiarati nella descrizione di gioco; quantità e facce non dedotte dal risultato 6.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=480 AND url='https://youtube.com/watch?v=JwCFa7n06QM') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479036' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '480','printable_component','carte: cards] - on [1] double sided sheet (PDF)','[9 cards] - on [1] double sided sheet (PDF)','9','required','printable','[9 cards] - on [1] double sided sheet (PDF)
[1 rules] - on [1] double sided sheet (PDF)
The other player rolls dice with the goal of getting a 6','https://boardgamegeek.com/thread/3479036','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '480' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: cards] - on [1] double sided sheet (PDF)' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479036');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '480','rules','regolamento: rules] - on [1] double sided sheet (PDF)','[1 rules] - on [1] double sided sheet (PDF)','1','required','printable','[9 cards] - on [1] double sided sheet (PDF)
[1 rules] - on [1] double sided sheet (PDF)
The other player rolls dice with the goal of getting a 6','https://boardgamegeek.com/thread/3479036','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '480' AND material_kind IS 'rules' AND name_normalized IS 'regolamento: rules] - on [1] double sided sheet (PDF)' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479036');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '480','randomizer','dadi: The other player rolls dice with the goal of getting a 6','The other player rolls dice with the goal of getting a 6',NULL,'unclear','common','[9 cards] - on [1] double sided sheet (PDF)
[1 rules] - on [1] double sided sheet (PDF)
The other player rolls dice with the goal of getting a 6','https://boardgamegeek.com/thread/3479036','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '480' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: The other player rolls dice with the goal of getting a 6' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479036');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3458414' WHERE id=481 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('481','2026-10-04','https://boardgamegeek.com/thread/3458414','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('481','2026-10-04','https://boardgamegeek.com/thread/3458414','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('481','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3458414','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('481','game_files','https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbSc6X2vlXVZwtr','drive.google.com','https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbS...',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (481,(SELECT id FROM remote_resources WHERE game_id=481 AND url='https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbSc6X2vlXVZwtr'),'https://boardgamegeek.com/thread/3458414','https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbS...','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=481 AND url='https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbSc6X2vlXVZwtr'),'2026-10-04','https://boardgamegeek.com/thread/3458414','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=481 AND url='https://drive.google.com/drive/folders/1sk-kq0FE29dtt0_1whbSc6X2vlXVZwtr') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3458414' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '481','printable_component','carte: Double sided cards','9 Double sided cards','9','required','printable','9 Double sided cards','https://boardgamegeek.com/thread/3458414','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '481' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Double sided cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3458414');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479202' WHERE id=482 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('482','2026-10-04','https://boardgamegeek.com/thread/3479202','found','TSK-0051; primo post originale soltanto; host non verificati. Stesso URL per Cards [1.0] e Rules [1.0]: una risorsa, due menzioni funzionali.','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('482','2026-10-04','https://boardgamegeek.com/thread/3479202','found','TSK-0051; primo post originale soltanto; host non verificati. Stesso URL per Cards [1.0] e Rules [1.0]: una risorsa, due menzioni funzionali.','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('482','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479202','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. Stesso URL per Cards [1.0] e Rules [1.0]: una risorsa, due menzioni funzionali.');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('482','game_files','https://drive.google.com/file/d/1d_BEfeUa1tNMdNANULLu7qX2cZDTLcvK/view?usp=sharing','drive.google.com','Cards [1.0] | Rules [1.0]',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (482,(SELECT id FROM remote_resources WHERE game_id=482 AND url='https://drive.google.com/file/d/1d_BEfeUa1tNMdNANULLu7qX2cZDTLcvK/view?usp=sharing'),'https://boardgamegeek.com/thread/3479202','Cards [1.0]','component',1,'2026-10-04','2026-10-04');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (482,(SELECT id FROM remote_resources WHERE game_id=482 AND url='https://drive.google.com/file/d/1d_BEfeUa1tNMdNANULLu7qX2cZDTLcvK/view?usp=sharing'),'https://boardgamegeek.com/thread/3479202','Rules [1.0]','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=482 AND url='https://drive.google.com/file/d/1d_BEfeUa1tNMdNANULLu7qX2cZDTLcvK/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479202','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. Stesso URL per Cards [1.0] e Rules [1.0]: una risorsa, due menzioni funzionali.' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=482 AND url='https://drive.google.com/file/d/1d_BEfeUa1tNMdNANULLu7qX2cZDTLcvK/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479202' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','token_marker','segnalini: Tokens - Each with two unique / identifiable sides','[12] Tokens - Each with two unique / identifiable sides','12','required','common','Components [20]:
[12] Tokens - Each with two unique / identifiable sides
[6] d6
[1] d4
[1] d20','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: Tokens - Each with two unique / identifiable sides' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','randomizer','dadi: d6','[6] d6','6','required','common','Components [20]:
[12] Tokens - Each with two unique / identifiable sides
[6] d6
[1] d4
[1] d20','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','randomizer','dadi: d4','[1] d4','1','required','common','Components [20]:
[12] Tokens - Each with two unique / identifiable sides
[6] d6
[1] d4
[1] d20','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d4' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','randomizer','dadi: d20','[1] d20','1','required','common','Components [20]:
[12] Tokens - Each with two unique / identifiable sides
[6] d6
[1] d4
[1] d20','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d20' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','rules','regolamento dichiarato nei link','Rules [1.0]',NULL,'unclear','printable','Rules [1.0]','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '482','printable_component','componenti PnP dichiarati nei link','Cards [1.0]',NULL,'unclear','printable','Cards [1.0]','https://boardgamegeek.com/thread/3479202','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '482' AND material_kind IS 'printable_component' AND name_normalized IS 'componenti PnP dichiarati nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479202');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3479781' WHERE id=483 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('483','2026-10-04','https://boardgamegeek.com/thread/3479781','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('483','2026-10-04','https://boardgamegeek.com/thread/3479781','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('483','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3479781','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('483','component','https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zGcNsEv/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zG...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (483,(SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zGcNsEv/view?usp=sharing'),'https://boardgamegeek.com/thread/3479781','https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zG...','component',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zGcNsEv/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479781','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GAMffwNu3n5IOvZ47njo2UWy6zGcNsEv/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479781' AND observation_kind='declared_in_wip');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('483','rules','https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrxtOWsi/view?usp=sharing','drive.google.com','https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrx...',NULL,'unknown','2026-10-04','2026-10-04','file');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (483,(SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrxtOWsi/view?usp=sharing'),'https://boardgamegeek.com/thread/3479781','https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrx...','rules',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrxtOWsi/view?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3479781','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=483 AND url='https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrxtOWsi/view?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3479781' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '483','printable_component','carte: The 9 PnP cards','The 9 PnP cards','9','required','printable','The 9 PnP cards
24d6 - 12 each of 2 colors','https://boardgamegeek.com/thread/3479781','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '483' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: The 9 PnP cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479781');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '483','randomizer','dadi: d6 - 12 each of 2 colors','24d6 - 12 each of 2 colors','24','required','common','The 9 PnP cards
24d6 - 12 each of 2 colors','https://boardgamegeek.com/thread/3479781','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '483' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi: d6 - 12 each of 2 colors' AND quantity_raw IS '24' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3479781');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '483','rules','regolamento dichiarato nei link','https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrx...',NULL,'unclear','printable','https://drive.google.com/file/d/1GolkHdqPRwGclRkFY3jbzOIDTrx...','https://boardgamegeek.com/thread/3479781','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '483' AND material_kind IS 'rules' AND name_normalized IS 'regolamento dichiarato nei link' AND quantity_raw IS NULL AND requirement_level IS 'unclear' AND source_url IS 'https://boardgamegeek.com/thread/3479781');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3477928' WHERE id=484 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('484','2026-10-04','https://boardgamegeek.com/thread/3477928','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('484','2026-10-04','https://boardgamegeek.com/thread/3477928','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('484','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3477928','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('484','game_files','https://drive.google.com/drive/folders/1mAAP_A7l7bdkC4A0vx_5PM7pQ-3Lbcds?usp=sharing','drive.google.com','Rulebook and Pnp Files here',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (484,(SELECT id FROM remote_resources WHERE game_id=484 AND url='https://drive.google.com/drive/folders/1mAAP_A7l7bdkC4A0vx_5PM7pQ-3Lbcds?usp=sharing'),'https://boardgamegeek.com/thread/3477928','Rulebook and Pnp Files here','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=484 AND url='https://drive.google.com/drive/folders/1mAAP_A7l7bdkC4A0vx_5PM7pQ-3Lbcds?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3477928','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=484 AND url='https://drive.google.com/drive/folders/1mAAP_A7l7bdkC4A0vx_5PM7pQ-3Lbcds?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3477928' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '484','printable_component','carte: town cards','6 town cards','6','required','printable','6 town cards
1 special town card
2 score cards
2 meeples of different color
22 small cubes, 11 of each color meeple','https://boardgamegeek.com/thread/3477928','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '484' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: town cards' AND quantity_raw IS '6' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477928');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '484','printable_component','carte: special town card','1 special town card','1','required','printable','6 town cards
1 special town card
2 score cards
2 meeples of different color
22 small cubes, 11 of each color meeple','https://boardgamegeek.com/thread/3477928','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '484' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: special town card' AND quantity_raw IS '1' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477928');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '484','printable_component','carte: score cards','2 score cards','2','required','printable','6 town cards
1 special town card
2 score cards
2 meeples of different color
22 small cubes, 11 of each color meeple','https://boardgamegeek.com/thread/3477928','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '484' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: score cards' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477928');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '484','token_marker','segnalini: meeples of different color','2 meeples of different color','2','required','common','6 town cards
1 special town card
2 score cards
2 meeples of different color
22 small cubes, 11 of each color meeple','https://boardgamegeek.com/thread/3477928','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '484' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: meeples of different color' AND quantity_raw IS '2' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477928');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '484','token_marker','segnalini: small cubes, 11 of each color meeple','22 small cubes, 11 of each color meeple','22','required','common','6 town cards
1 special town card
2 score cards
2 meeples of different color
22 small cubes, 11 of each color meeple','https://boardgamegeek.com/thread/3477928','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '484' AND material_kind IS 'token_marker' AND name_normalized IS 'segnalini: small cubes, 11 of each color meeple' AND quantity_raw IS '22' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3477928');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3462494' WHERE id=485 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('485','2026-10-04','https://boardgamegeek.com/thread/3462494','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('485','2026-10-04','https://boardgamegeek.com/thread/3462494','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('485','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3462494','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('485','game_files','https://drive.google.com/drive/folders/1vcssYzESREjeh8lwrGQPRtupVb8wjl_F?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (485,(SELECT id FROM remote_resources WHERE game_id=485 AND url='https://drive.google.com/drive/folders/1vcssYzESREjeh8lwrGQPRtupVb8wjl_F?usp=sharing'),'https://boardgamegeek.com/thread/3462494','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=485 AND url='https://drive.google.com/drive/folders/1vcssYzESREjeh8lwrGQPRtupVb8wjl_F?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3462494','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=485 AND url='https://drive.google.com/drive/folders/1vcssYzESREjeh8lwrGQPRtupVb8wjl_F?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3462494' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '485','printable_component','carte: Cards','9 Cards','9','required','printable','9 Cards','https://boardgamegeek.com/thread/3462494','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '485' AND material_kind IS 'printable_component' AND name_normalized IS 'carte: Cards' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3462494');
UPDATE entries SET wip_thread_url='https://boardgamegeek.com/thread/3440241' WHERE id=486 AND wip_thread_url IS NULL;
INSERT OR IGNORE INTO entry_resource_scans (entry_id,checked_at,source_url,wip_status,notes,resource_listing_status) VALUES ('486','2026-10-04','https://boardgamegeek.com/thread/3440241','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed');
INSERT OR IGNORE INTO entry_material_scans (entry_id,checked_at,source_url,wip_status,notes,material_listing_status,coverage_scope) VALUES ('486','2026-10-04','https://boardgamegeek.com/thread/3440241','found','TSK-0051; primo post originale soltanto; host non verificati. ','observed','first_post_only');
INSERT OR IGNORE INTO entry_work_observations (entry_id,phase,outcome,observed_at,source_url,evidence_path,notes) VALUES ('486','materials','complete','2026-10-04','https://boardgamegeek.com/thread/3440241','tasks/2026-10-04 - MAT - 9-Card Nanogame 2025/EVIDENCE.json','TSK-0051; primo post originale soltanto; host non verificati. ');
INSERT OR IGNORE INTO remote_resources (game_id,kind,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at,access_type) VALUES ('486','game_files','https://drive.google.com/drive/folders/1m-aYRf1gQHDnXgcdA0crrcrUTugB2VyU?usp=sharing','drive.google.com','Google Drive',NULL,'unknown','2026-10-04','2026-10-04','folder');
INSERT OR IGNORE INTO entry_resource_mentions (entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) VALUES (486,(SELECT id FROM remote_resources WHERE game_id=486 AND url='https://drive.google.com/drive/folders/1m-aYRf1gQHDnXgcdA0crrcrUTugB2VyU?usp=sharing'),'https://boardgamegeek.com/thread/3440241','Google Drive','game_files',1,'2026-10-04','2026-10-04');
INSERT INTO remote_resource_observations (remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT (SELECT id FROM remote_resources WHERE game_id=486 AND url='https://drive.google.com/drive/folders/1m-aYRf1gQHDnXgcdA0crrcrUTugB2VyU?usp=sharing'),'2026-10-04','https://boardgamegeek.com/thread/3440241','declared_in_wip','not_checked',NULL,'TSK-0051; primo post originale soltanto; host non verificati. ' WHERE NOT EXISTS (SELECT 1 FROM remote_resource_observations WHERE remote_resource_id=(SELECT id FROM remote_resources WHERE game_id=486 AND url='https://drive.google.com/drive/folders/1m-aYRf1gQHDnXgcdA0crrcrUTugB2VyU?usp=sharing') AND observed_at='2026-10-04' AND evidence_url='https://boardgamegeek.com/thread/3440241' AND observation_kind='declared_in_wip');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '486','printable_component','carte','9 Cards: 1x Fighter, 8x Thugs
12 dice: Recommended
 7x black (combat)
 2x red (health)
 1x blue (skill)
 1x green (stamina)
 1x white (Level)','9','required','printable','9 Cards: 1x Fighter, 8x Thugs
12 dice: Recommended
 7x black (combat)
 2x red (health)
 1x blue (skill)
 1x green (stamina)
 1x white (Level)','https://boardgamegeek.com/thread/3440241','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '486' AND material_kind IS 'printable_component' AND name_normalized IS 'carte' AND quantity_raw IS '9' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440241');
INSERT INTO entry_material_requirements (entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at) SELECT '486','randomizer','dadi facce non specificate','9 Cards: 1x Fighter, 8x Thugs
12 dice: Recommended
 7x black (combat)
 2x red (health)
 1x blue (skill)
 1x green (stamina)
 1x white (Level)','12','required','common','9 Cards: 1x Fighter, 8x Thugs
12 dice: Recommended
 7x black (combat)
 2x red (health)
 1x blue (skill)
 1x green (stamina)
 1x white (Level)','https://boardgamegeek.com/thread/3440241','2026-10-04','2026-10-04' WHERE NOT EXISTS (SELECT 1 FROM entry_material_requirements WHERE entry_id IS '486' AND material_kind IS 'randomizer' AND name_normalized IS 'dadi facce non specificate' AND quantity_raw IS '12' AND requirement_level IS 'required' AND source_url IS 'https://boardgamegeek.com/thread/3440241');
COMMIT;
