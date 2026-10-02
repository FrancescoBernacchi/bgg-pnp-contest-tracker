-- First-post resource and material census for the 2026 Print and Play Wargame Design Contest.
-- BGG WIP posts observed on 2026-10-02; external destinations were not opened.
PRAGMA foreign_keys=ON;
BEGIN IMMEDIATE;

CREATE TEMP TABLE wr_resource(
  position INTEGER NOT NULL,
  url TEXT NOT NULL,
  role TEXT NOT NULL,
  access_type TEXT NOT NULL,
  label TEXT NOT NULL,
  version_raw TEXT,
  is_primary INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(position,url)
);

INSERT INTO wr_resource VALUES
 (1,'https://boardgamegeek.com/boardgame/460406/hybrid-war','project_page','download_page','Game page where the game files are declared',NULL,1),
 (1,'https://boardgamegeek.com/filepage/313089/game-rules','rules','file','Game Rules',NULL,0),
 (3,'https://drive.google.com/file/d/1U2_zsydGqLtuyr6zOrRkwka1pIhx6kUu/view?usp=sharing','rules','file','Warring States rulebook 1.2','1.2',0),
 (3,'https://drive.google.com/file/d/1-cZfW2PuNFNglgp4YYMCQxzkC5zSoale/view?usp=sharing','component','file','Game board',NULL,1),
 (3,'https://drive.google.com/file/d/1NGCol0SF8TcR2q_f7NZrdS1i4a6T7l-Z/view?usp=sharing','component','file','Game board (low ink)',NULL,0),
 (3,'https://drive.google.com/file/d/1F7WyTHZeHndNwHAG87exPEjg9DaRUlKk/view?usp=sharing','component','file','Cards and tokens',NULL,1),
 (3,'https://drive.google.com/file/d/1LScVQqqKDrsBKuPzD1fjT-9qSTxgoFrA/view?usp=sharing','component','file','Cards and tokens (low ink)',NULL,0),
 (5,'https://drive.google.com/file/d/1QB5MhIfgetFEAPQJqLTbsgbMmZzGuLE4/view?usp=sharing','rules','file','Cocci Wars Rulebook',NULL,0),
 (5,'https://drive.google.com/file/d/1UJwaJIGYLCqiSRsbMREqZryuYs39nsiz/view?usp=sharing','game_files','file','PNP simple MVP for 1-2 players',NULL,1),
 (6,'https://drive.google.com/file/d/1LFec01BlSdtQJtGe15XYqAPpL_Y7rReM/view?usp=drive_link','rules','file','Rulebook version 1','1',0),
 (6,'https://drive.google.com/file/d/1KHd72EVGCA89wfGGei8eID3tXZVWkoAU/view?usp=drive_link','component','file','Cards version 1','1',1),
 (7,'https://steamcommunity.com/sharedfiles/filedetails/?id=3780546521','online_play','workshop_module','TTS Module',NULL,1),
 (7,'https://www.dropbox.com/scl/fi/0xkc1zqcnzqxt7245ipvx/BARDSEA-Manual.pdf?rlkey=37dbu6uddfigq6so7p00gc6zv&dl=0','rules','file','Rulebook',NULL,0),
 (8,'https://drive.google.com/file/d/1gOXqogT_5LNlNPvrSSpfUEb8Gpd6uHqW/view?usp=drive_link','rules','file','Rules v1.01','1.01',0),
 (8,'https://drive.google.com/file/d/1fZMAW8qyehHZRr_S-lMPG4voTXS6FHgZ/view?usp=drive_link','game_files','file','Bundled map, counters, cards and player aid v1.0','1.0',1),
 (10,'https://drive.google.com/file/d/1kmvoE0sdjNbdlexwf9-vm7FuUau2tD4c/view?usp=sharing','rules','file','Battle of Stepney rules',NULL,0),
 (10,'https://drive.google.com/file/d/1VSxDfe_cT8GW2jpZobn7XNA-jj2pa-Y3/view?usp=sharing','component','file','Battle of Stepney game board',NULL,1),
 (10,'https://drive.google.com/file/d/1iDsUuExRSBH4JYlFqhKOsCBGEwGvMn7x/view?usp=sharing','component','file','Battle of Stepney cards (full page)',NULL,1),
 (10,'https://drive.google.com/file/d/1yRgIuoCTnF-zXcSWTVBvukqzfhzmzye6/view?usp=sharing','component','file','Battle of Stepney cards (smaller)',NULL,0),
 (10,'https://drive.google.com/file/d/12oL7RCPsW9FYGnIIzOJ_TzNxsBOwfPyT/view?usp=sharing','component','file','Battle of Stepney counters',NULL,1),
 (11,'https://gitlab.com/pax-game-design/bggdesigncontest/-/blob/main/rules-and-cards.pdf','game_files','file','Rules and cards v2.0','2.0',1),
 (11,'https://gitlab.com/pax-game-design/bggdesigncontest/-/blob/main/cards-bw-wb.pdf','component','file','Cards, black-and-white with light backs',NULL,0),
 (11,'https://gitlab.com/pax-game-design/bggdesigncontest/-/blob/main/cards-colour-wb.pdf','component','file','Cards, colour with dark backs',NULL,0),
 (13,'https://docs.google.com/document/d/1jkNXA1zgIvR_jqNEhme3_2etrr44j34W38ynkdjQU2g/edit?usp=sharing','rules','document','Rules',NULL,1),
 (14,'https://docs.google.com/document/d/1Py65nBUXsIbeaf5aGzLw9UE6','rules','document','Rules; Rulebook (same URL mentioned twice)',NULL,1),
 (14,'https://drive.google.com/drive/folders/1nguHQX05j8arAHzzQLeP5x579b7yk_FA','component','folder','Editable Character Sheets',NULL,0),
 (14,'https://steamcommunity.com/sharedfiles/filedetails/?id=37505','online_play','workshop_module','Tabletop Simulator Mod',NULL,0),
 (15,'https://docs.google.com/document/d/1wUjzewVmRO63hxLTIGP0sdVettfv55jk/edit?usp=share_link&ouid=100893564491187260479&rtpof=true&sd=true','rules','document','Manual',NULL,0),
 (15,'https://drive.google.com/file/d/1qUu8l_LuQjhAsQV7k4k3zkdZW-qFRbqq/view?usp=share_link','component','file','Cards for gladiators, equipment and attack',NULL,1),
 (15,'https://drive.google.com/file/d/1rCYTzTQl6n7YjEPs149N7onYB33QfR9Y/view?usp=share_link','component','file','Hades deck',NULL,1),
 (15,'https://drive.google.com/file/d/1dpg0jzxZ43V7X1c8cRUCk_RLo6oIDMZ1/view?usp=sharing','component','file','Hades deck, low ink',NULL,0),
 (16,'https://drive.google.com/drive/folders/18JO1vgU_pTUSIFBCK3wHa1JKm8kvJJsi?usp=sharing','game_files','folder','Full-Color Game',NULL,1),
 (16,'https://drive.google.com/file/d/1aF6_Uv0my6SfEj9-7seMHeg9-ii_D2JO/view?usp=drive_link','component','file','6x Game Pieces; several Character Play Sheets (same URL)',NULL,1),
 (16,'https://drive.google.com/file/d/1uvBKg3P4mHc1JPpdk26VQWqCHhjhPKHy/view?usp=drive_link','rules','file','1x Rules Sheet',NULL,0),
 (16,'https://drive.google.com/file/d/10nkPBUZl4reXczXqVsk2o3IywAdQoZcd/view?usp=drive_link','component','file','1x Character Campaign Sheet',NULL,0),
 (16,'https://drive.google.com/file/d/1doTmToALOquuAKHTyUxVVgY6yPXCjLVI/view?usp=drive_link','component','file','1x Mission Sheet',NULL,0),
 (16,'https://drive.google.com/file/d/1JL-qNutQPJPH8IAZeazWY9bGyab_9h8s/view?usp=drive_link','component','file','1x Encounters Sheet',NULL,0),
 (18,'https://drive.google.com/drive/folders/1vVR2J8DJwlxIvrBefifGjhsFVMYI0uLM?usp=drive_link','game_files','folder','Rules and PnP',NULL,1),
 (19,'https://www.dropbox.com/scl/fi/9r8mudkx93f6y0uq7l8dq/Rules-of-Gli-res-1944-V-0.5.pdf?rlkey=dicuofgmxm2c5hpw1dt1m9lti&dl=0','rules','file','Rules in English v0.5','0.5',0),
 (19,'https://www.dropbox.com/scl/fi/rjllhfsnm85v6kn3igu5x/R-gles-Gli-res-1944-v0.5.pdf?rlkey=qmfop45utt4dnnbiekxags23u&dl=0','rules','file','Rules in French v0.5','0.5',0),
 (19,'https://www.dropbox.com/scl/fi/lyt0yfrquw3q6kssr1488/PnP-Gli-re-1944-V-0.5.pdf?rlkey=xi6r9yhdsvo7id10yu2saxp9b&dl=0','game_files','file','PnP v0.5','0.5',1),
 (20,'https://drive.google.com/drive/folders/1mLMmeyeJZcjIuDwRN-N1TbXKzPGQnJfU?usp=sharing','game_files','folder','All PDF files on Google Drive',NULL,1),
 (20,'https://drive.google.com/file/d/1IqupAq2re-bp5fU5c9kRbVqzxMJuxRq3/view?usp=drive_link','rules','file','Quick rulebook; also labelled quick',NULL,0),
 (20,'https://drive.google.com/file/d/1rObcYVLT_r0KGpPwu2xHrt4yUE4j80WJ/view?usp=drive_link','rules','file','Complete rulebook',NULL,0),
 (20,'https://drive.google.com/file/d/1bUq_d-CaSceCyw2bFK9ZXiljSDHcBTqi/view?usp=drive_link','player_aid','file','Reference sheet',NULL,0),
 (20,'https://drive.google.com/file/d/1c2r28ObhQaj1lj0Jowwq0NjQfpU9_rHj/view?usp=drive_link','component','file','Player board',NULL,0),
 (20,'https://drive.google.com/file/d/1TeP4m8Rc9xxztVlX_y3ay5qT1DJ02W6B/view?usp=drive_link','component','file','Map',NULL,0),
 (20,'https://drive.google.com/file/d/1vhBDyeAQXwdQsepwJJATONRVBI4m13a6/view?usp=drive_link','component','file','Tokens, cards and coins',NULL,0),
 (20,'https://drive.google.com/file/d/152eyowflPq8C44lQ65rDhuw1lb3JKd9c/view?usp=drive_link','rules','file','Solitaire mode guide',NULL,0),
 (20,'https://drive.google.com/file/d/1DrTchFuDcFp6b-4T8Djp5VinY3lPSmuM/view?usp=drive_link','player_aid','file','Notebook',NULL,0),
 (20,'https://drive.google.com/file/d/14wS4PmmW6oklj7Brgc-qOXEzzVbpcf1T/view?usp=drive_link','expansion','file','Sabotage extension',NULL,0),
 (20,'https://drive.google.com/file/d/1OG7V6AZd7o0M2yuMyMBseZ8C7Sk6FWJA/view?usp=drive_link','player_aid','file','Vassal companion guide',NULL,0),
 (20,'https://youtu.be/cRzXF2LT1xM','video','video','Short English overview video',NULL,0),
 (20,'https://vassalengine.org/library/projects/Sitka-ever-lost','online_play','download_page','Vassal module library page',NULL,0),
 (21,'https://drive.google.com/file/d/1Wx1S3A_0ZyZZZRlQvOrYFXtV8JaRwOJ6/view?usp=drive_link','rules','file','Rules',NULL,0),
 (21,'https://drive.google.com/drive/folders/12Ia9lQAgzUGYsZLlDQ7_3yMOw0V5ROPk?usp=drive_link','game_files','folder','PnP files in A4 and US Letter formats',NULL,1),
 (21,'https://screentop.gg/@Pop/The-Lost-Eagles','online_play','web_app','Screentop digital prototype',NULL,0),
 (22,'https://drive.google.com/drive/folders/1tOZgpKk9qpPMZfcL-Iw5_h9EyhzMh3cF?usp=sharing','game_files','folder','Rules / Google Drive',NULL,1),
 (23,'https://brtrain.wordpress.com/2026/08/16/new-free-game-imposed-cost/','project_page','download_page','Post with commentary and all PnP files; linked as Rules',NULL,1);

CREATE TEMP TABLE wr_material(
  position INTEGER NOT NULL,
  material_kind TEXT NOT NULL,
  name_normalized TEXT NOT NULL,
  name_raw TEXT NOT NULL,
  quantity_raw TEXT,
  requirement_level TEXT NOT NULL,
  supply_mode TEXT NOT NULL,
  context_raw TEXT NOT NULL
);

INSERT INTO wr_material VALUES
 (2,'standard_set','set di domino','a domino set (tiles 4x2cm)','1 set','required','common','What You Need: A domino set (tiles 4x2cm)'),
 (2,'printable_component','griglia OSSA','The OSSA grid (included)','1, 16×22 cm','required','printable','What You Need: The OSSA grid (included); one paper, one domino set'),
 (3,'printable_component','plancia di gioco','1x game board (A4 /letter size)','1','required','printable','PNP Components consist of: 1x game board (A4 /letter size)'),
 (3,'printable_component','carta azione','17 x action cards','17','required','printable','PNP Components consist of: 17 x action cards'),
 (3,'printable_component','segnalini raid e +1 VP','Raid and +1vp tokens (1 of each)','2','required','printable','PNP Components consist of: Raid and +1vp tokens (1 of each)'),
 (3,'token_marker','segnalino','48 counters (20 each in two colours, 8 in a third colour, ideally discs, but cubes will work)','48','required','common','Other Components You''ll Need to Play: 48 counters (20 each in two colours, 8 in a third colour, ideally discs, but cubes will work)'),
 (3,'randomizer','dado','6 dice','6','required','common','Other Components You''ll Need to Play: 6 dice'),
 (8,'printable_component','mappa o plancia','2 sheets of map / board','2 fogli','required','printable','PnP components: 2 sheets of map / board'),
 (8,'printable_component','segnalini unità e tessere terreno','1 sheet of Counters (29 Unit Counters + 12 Terrain Tiles)','1 foglio; 41 pezzi','required','printable','PnP components: 1 sheet of Counters (29 Unit Counters + 12 Terrain Tiles)'),
 (8,'printable_component','carte tattica','1 sheet of Tactic Cards (8 cards)','1 foglio; 8 carte','required','printable','PnP components: 1 sheet of Tactic Cards (8 cards)'),
 (8,'printable_component','carte multigiocatore','1 sheet optional multiplayer cards','1 foglio','optional','printable','PnP components: 1 sheet optional multiplayer cards'),
 (8,'printable_component','aiuto giocatore','1 Player Aid','1','required','printable','PnP components: 1 Player Aid'),
 (8,'randomizer','dado d6','2 D6 dice','2','required','common','Additional components needed: 2 D6 dice'),
 (8,'token_marker','cubetto o segnalino attivazione','7 cubes / token for activation markers','7','required','common','Additional components needed: 7 cubes / token for activation markers'),
 (10,'printable_component','plancia di gioco','Battle of Stepney game board','1','required','printable','First-post resource label: Battle of Stepney game board'),
 (10,'printable_component','carte','Battle of Stepney cards (full page); Battle of Stepney cards (smaller)',NULL,'required','printable','Two alternative-format card files are declared in the first post'),
 (10,'printable_component','segnalini','Battle of Stepney counters',NULL,'required','printable','First-post resource label: Battle of Stepney counters'),
 (11,'printable_component','carta unità','Each player has an army of 9 units (cards)','9 per giocatore','required','printable','Each player has an army of 9 units (cards), chosen before the battle'),
 (14,'printable_component','mappa di battaglia','Printable Battle Maps',NULL,'required','printable','Components: Printable Battle Maps'),
 (14,'printable_component','carta unità','Printable Unit Cards',NULL,'required','printable','Components: Printable Unit Cards'),
 (14,'printable_component','scheda comandante','Printable Commander Sheets',NULL,'required','printable','Components: Printable Commander Sheets'),
 (14,'printable_component','segnalino','Printable Tokens',NULL,'required','printable','Components: Printable Tokens'),
 (14,'randomizer','dado d10 o d100','Two d10 (or one d100)','2 d10 o 1 d100','required','common','Components: Two d10 (or one d100)'),
 (14,'writing_tool','matita','Pencil','1','required','common','Components: Pencil and Eraser'),
 (14,'writing_tool','gomma','Eraser','1','required','common','Components: Pencil and Eraser'),
 (15,'printable_component','mazzi di carte','Cards - Gladiator deck, equipment deck, attack deck and Hades deck','4 mazzi','required','printable','PNP Components consist of: Cards - Gladiator deck, equipment deck, attack deck and Hades deck'),
 (15,'randomizer','dado d6','1d6 die per player','1 per giocatore','required','common','Other Components You''ll Need to Play: 1d6 die per player'),
 (15,'household_item','moneta sacra','1 coin to serve as the Sacred Coin','1','required','household','Other Components You''ll Need to Play: 1 coin to serve as the Sacred Coin'),
 (15,'currency_marker','monete mercato','coins to serve as 5 and 10 for the market',NULL,'alternative','household','coins to serve as 5 and 10 for the market - or print out the denarii cards'),
 (15,'printable_component','carte denari','denarii cards',NULL,'alternative','printable','coins to serve as 5 and 10 for the market - or print out the denarii cards'),
 (16,'randomizer','dado d6','2D6 (different colors recommended)','2','required','common','Components: 2D6 (different colors recommended)'),
 (16,'writing_tool','penna o matita','Pen or Pencil','1','required','common','Components: Pen or Pencil'),
 (16,'printable_component','pezzo di gioco','6x Game Pieces','6','required','printable','Components: 6x Game Pieces'),
 (16,'printable_component','scheda personaggio','(several) Character Play Sheets','diverse','required','printable','Components: (several) Character Play Sheets'),
 (16,'printable_component','scheda campagna personaggio','1x Character Campaign Sheet','1','required','printable','Components: 1x Character Campaign Sheet'),
 (16,'printable_component','scheda missione','1x Mission Sheet','1','required','printable','Components: 1x Mission Sheet'),
 (16,'printable_component','scheda incontri','1x Encounters Sheet','1','required','printable','Components: 1x Encounters Sheet'),
 (18,'printable_component','plancia di gioco','1 Gameboard','1','required','printable','Components MVP: 1 Gameboard'),
 (18,'printable_component','carta','36 cards (21 Command cards, 15 made-up rules)','36','required','printable','Components MVP: 36 cards (21 Command cards, 15 made-up rules)'),
 (18,'token_marker','meeple','7 meeples in 3 colors (3,3,1)','7','required','common','Components MVP: 7 meeples in 3 colors (3,3,1)'),
 (18,'token_marker','segnalino rotondo','14 round tokens (Snowballs!)','14','required','common','Components MVP: 14 round tokens (Snowballs!)'),
 (18,'randomizer','dado d6','2 D6','2','required','common','Components MVP: 2 D6'),
 (20,'printable_component','mappa','PDF file to print map (A3 size)','1 file, formato A3','required','printable','Components: 2 PDF files to print map (A3 size) and tokens/cards/coins'),
 (20,'printable_component','segnalini carte e monete','tokens/cards/coins','1 file','required','printable','Components: 2 PDF files to print map (A3 size) and tokens/cards/coins'),
 (20,'printable_component','plancia giocatore','Player''s board','1','required','printable','Components: rulebooks, Reference sheet and Player''s board'),
 (20,'randomizer','dado d6','1D6','1','required','common','Take 1D6 and you''ll be ready to play'),
 (22,'standard_deck','mazzo standard da 52 carte','a standard 52-card deck','1','required','common','Using a standard 52-card deck across seven tracks'),
 (23,'standard_deck','mazzo ordinario di carte','a deck of ordinary playing cards','1','required','common','You will also need a deck of ordinary playing cards');

DELETE FROM entry_resource_scans
WHERE checked_at='2026-10-02' AND entry_id IN (SELECT id FROM entries WHERE contest_id=4);
INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes)
SELECT e.id,'2026-10-02',e.wip_thread_url,'found',
       CASE WHEN EXISTS(SELECT 1 FROM wr_resource r WHERE r.position=e.position) THEN 'observed' ELSE 'none_declared' END,
       CASE
         WHEN e.position=7 THEN 'Primo post osservato: TTS e regolamento collegati; i file PnP sono dichiarati Coming Soon senza URL. Destinazioni non aperte.'
         WHEN e.position=15 THEN 'Primo post osservato: collegamenti presenti; Denarii sheets dichiarato link TBD. Destinazioni non aperte.'
         WHEN e.position=19 THEN 'Primo post osservato: regole e PnP collegati; TTS version Available dichiarato senza URL. Destinazioni non aperte.'
         WHEN EXISTS(SELECT 1 FROM wr_resource r WHERE r.position=e.position) THEN 'Primo post renderizzato: collegamenti pertinenti censiti e deduplicati; destinazioni non aperte.'
         ELSE 'Primo post renderizzato: nessun collegamento pertinente dichiarato osservato.'
       END
FROM entries e WHERE e.contest_id=4;

INSERT OR IGNORE INTO remote_resources(game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at)
SELECT e.game_id,r.role,r.access_type,r.url,
       CASE WHEN instr(substr(r.url,instr(r.url,'//')+2),'/')>0
            THEN substr(substr(r.url,instr(r.url,'//')+2),1,instr(substr(r.url,instr(r.url,'//')+2),'/')-1)
            ELSE substr(r.url,instr(r.url,'//')+2) END,
       r.label,r.version_raw,'unknown','2026-10-02','2026-10-02'
FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position;

UPDATE remote_resources
SET kind=(SELECT r.role FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),
    access_type=(SELECT r.access_type FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),
    label=(SELECT r.label FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),
    version_raw=(SELECT r.version_raw FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),
    last_verified_at='2026-10-02'
WHERE EXISTS(SELECT 1 FROM wr_resource r JOIN entries e ON e.contest_id=4 AND e.position=r.position WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url);

DELETE FROM entry_resource_mentions WHERE entry_id IN (SELECT id FROM entries WHERE contest_id=4);
INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at)
SELECT e.id,rr.id,e.wip_thread_url,r.label,r.role,r.is_primary,'2026-10-02','2026-10-02'
FROM wr_resource r
JOIN entries e ON e.contest_id=4 AND e.position=r.position
JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url;

INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes)
SELECT rr.id,'2026-10-02',e.wip_thread_url,'declared_in_wip','not_checked',r.version_raw,
       'Dichiarata nel primo post BGG; destinazione non aperta. Funzione e forma tecnica sono provvisorie fino al confronto di tutti i contest 2026.'
FROM wr_resource r
JOIN entries e ON e.contest_id=4 AND e.position=r.position
JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url
WHERE NOT EXISTS(
  SELECT 1 FROM remote_resource_observations o
  WHERE o.remote_resource_id=rr.id AND o.observed_at='2026-10-02'
    AND o.evidence_url=e.wip_thread_url AND o.observation_kind='declared_in_wip'
);

DELETE FROM entry_material_requirements WHERE entry_id IN (SELECT id FROM entries WHERE contest_id=4);
INSERT INTO entry_material_requirements(entry_id,material_kind,name_normalized,name_raw,quantity_raw,requirement_level,supply_mode,context_raw,source_url,first_seen_at,last_seen_at)
SELECT e.id,m.material_kind,m.name_normalized,m.name_raw,m.quantity_raw,m.requirement_level,m.supply_mode,m.context_raw,e.wip_thread_url,'2026-10-02','2026-10-02'
FROM wr_material m JOIN entries e ON e.contest_id=4 AND e.position=m.position;

DELETE FROM entry_material_scans
WHERE checked_at='2026-10-02' AND coverage_scope='first_post_only'
  AND entry_id IN (SELECT id FROM entries WHERE contest_id=4);
INSERT INTO entry_material_scans(entry_id,checked_at,source_url,wip_status,material_listing_status,coverage_scope,notes)
SELECT e.id,'2026-10-02',e.wip_thread_url,'found',
       CASE WHEN EXISTS(SELECT 1 FROM wr_material m WHERE m.position=e.position) THEN 'observed' ELSE 'none_declared' END,
       'first_post_only',
       CASE WHEN EXISTS(SELECT 1 FROM wr_material m WHERE m.position=e.position)
            THEN 'Requisiti materiali esplicitamente dichiarati nel primo post; regole e destinazioni esterne non aperte.'
            ELSE 'Nessun requisito materiale sufficientemente esplicito osservato nel primo post; le regole potranno integrare il censimento.' END
FROM entries e WHERE e.contest_id=4;

DROP TABLE wr_material;
DROP TABLE wr_resource;
COMMIT;
