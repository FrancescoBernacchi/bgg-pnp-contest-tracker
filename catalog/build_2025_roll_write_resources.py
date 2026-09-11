from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATE = "2026-09-10"
CONTEST_ID = 22

entries = [
    ("Ancient World",2,"folder, video"),("Compass & Ink",1,"folder"),("Dawn Chorus",1,"folder"),
    ("Dicease Control: The 4.D-10 Pathogen",3,"folder, online play, video"),("Doodle Bash!",1,"file"),
    ("Fortify!",1,"folder"),("Labyrinth of Shadows",3,"rules, distribution page, video"),("Lithomacy",0,"none declared"),
    ("Mainframe: System Shutdown",2,"combined file, helper card"),("Master of Thievery",8,"download pages, components, TTS"),
    ("Natura",3,"rules, player sheet, cards"),("On-LINE Kasino",1,"folder"),("Rolling Fiefdoms",5,"distribution page, rules, sheets, solo challenges, online play"),
    ("Rolling Parks",1,"folder"),("Spellwrights Codex",4,"player sheets, cards, rules"),("Skyfall",3,"folder, generator, video"),
    ("The Leaning Tower of Pisa",3,"folder, two embedded videos"),("The Legend of Whispervale",7,"components, rules, TTS"),
    ("Thieves of Bandervon",8,"video, sheets, low-ink sheets, rules"),("Vanguard Multi Asset Global Command",2,"map, rules"),
    ("Word Builders",2,"folder, video"),("1899 - 1907 Black Death Brazil",3,"folder, two videos"),("A Dragon's Die",0,"none declared"),
    ("City Lights",4,"combined file, three online tables"),("Fortune Script",2,"folder, TTS"),("INFRARED",0,"none declared"),
    ("Necromancy: Roll Them Bones!",0,"none declared"),("On the Trail of Bigfoot",2,"rules, PnP files"),("PIXIX",1,"folder"),
    ("Ringleader",1,"folder"),("Roll & Pose",1,"folder"),("The Thirteenth Dimension",0,"none declared"),("Scribe",4,"rules, video, folder, TTS"),
    ("STRATOS",0,"none declared"),("Wizard's Tutelage",0,"none declared"),("U2: Flights of the Dragon Lady",2,"rules, gameboard"),("Yadoya",1,"project folder")]

# title, url, functional role, technical form, source label
R = []
def add(t, role, form, *pairs):
    for url, label in pairs: R.append((t,url,role,form,label))

add("Ancient World","video","video",("https://youtu.be/SSfnGiL8l4U?si=kcSUWZ9H0OxN3O6D","VIDEO (5 MIN.)"))
add("Ancient World","game_files","folder",("https://drive.google.com/drive/folders/1LT2NuygvjFM4TK2PpVEjfimda-PeUsUv?usp=sharing","DRIVE FOLDER"))
add("Compass & Ink","game_files","folder",("https://drive.google.com/drive/folders/1icJtKE9s9PUFTcqbd9oPQAIpqqMEaOeo?usp=sharing","Google Drive folder: rulebook, maps/reference sheet and adventure packs"))
add("Dawn Chorus","game_files","folder",("https://drive.google.com/drive/folders/1wfUVeCDBbDqYSdhvJXCyLMX14vwhbwRs?usp=drive_link","Download the files here to start playing"))
add("Dicease Control: The 4.D-10 Pathogen","game_files","folder",("https://drive.google.com/drive/folders/1O6w9MmXsEKVJVnCQXTeV2cx4sRSifx5e?usp=sharing","DICEASE CONTROL PnP"))
add("Dicease Control: The 4.D-10 Pathogen","online_play","web_app",("https://screentop.gg/@ComplianceBG/DICEASECONTROL","Digital Implementation on screentop.gg"))
add("Dicease Control: The 4.D-10 Pathogen","video","video",("https://youtu.be/7JwTLza_vRY","How to play Video"))
add("Doodle Bash!","game_files","file",("https://drive.google.com/file/d/1fi_7pHijJFd8W6UNCCZz3x2KYOEmzxXU/view?usp=sharing","Doodle Bash Rules and Game Sheets 1.1"))
add("Fortify!","game_files","folder",("https://www.dropbox.com/scl/fo/cq9s96o8bb6bl0e8782b9/AFDI9UKqth0eXLo6fv6FABg?rlkey=i7o5u9nw9449zon124kvzrqfn&st=6vt3dvb9&dl=0","Rules and player sheets"))
add("Labyrinth of Shadows","rules","document",("https://docs.google.com/document/d/1O9kkAPNDsoiOCSiQelxjMt1U621_NQWIQyy-gsIK0yI/edit?tab=t.0#heading=h.l2qc3xnbycgp","Rules (google doc)"))
add("Labyrinth of Shadows","project_page","download_page",("https://otherwisegames.substack.com/p/links","US Letter or A4 game sheets and maze sheets"))
add("Labyrinth of Shadows","video","video",("https://www.youtube.com/watch?v=L7i_du2iqKM","Overview Video"))
add("Mainframe: System Shutdown","game_files","file",("https://drive.google.com/file/d/1ijWnAQ8O7UbpfbhreAuvF9BEG6IkveRQ/view?usp=sharing","Complete game and rules"))
add("Mainframe: System Shutdown","component","file",("https://www.dropbox.com/scl/fi/pf42he958j6q922q5qrow/Mainframe6.pdf?rlkey=uoloz2i3hcu2xvraeuhoqfxsp&st=djltkdfk&dl=0","Helper card"))
add("Master of Thievery","project_page","download_page",("https://wannabeboardgamedesigner.com/board-games/master-of-thievery/","Download site with instructions on file content"),("https://wannabeboardgamedesigner.com/board-games/master-of-thievery/master-of-thievery-full-color-downloads/","Full color download site"),("https://wannabeboardgamedesigner.com/board-games/master-of-thievery/master-of-thievery-low-ink-downloads/","Low ink download site"))
add("Master of Thievery","rules","file",("https://wannabeboardgamedesigner.com/?sdm_process_download=1&download_id=614","Rulebook"))
add("Master of Thievery","component","file",("https://wannabeboardgamedesigner.com/?sdm_process_download=1&download_id=622","Thief sheets"),("https://wannabeboardgamedesigner.com/?sdm_process_download=1&download_id=624","Thievery opportunity cards"),("https://wannabeboardgamedesigner.com/?sdm_process_download=1&download_id=626","Marker tokens"))
add("Master of Thievery","online_play","workshop_module",("https://steamcommunity.com/sharedfiles/filedetails/?id=3624575400","Unlisted Tabletop Simulator module"))
add("Natura","rules","file",("https://drive.google.com/file/d/1Uqx2nCFXGQbchsb-ziamMvWpd-wjafHW/view?usp=drive_link","Rules"))
add("Natura","component","file",("https://drive.google.com/file/d/1ziL6k4ADeBZcIGLi7LZo8n6Qudae9lw7/view?usp=drive_link","Player sheet"),("https://drive.google.com/file/d/1lewGSVxHj2OjCQ7yvixCb_yKYpvcD1Ck/view?usp=drive_link","Goal cards"))
add("On-LINE Kasino","game_files","folder",("https://drive.google.com/drive/folders/1OwFeoKoQhDkRlW3fdvD3BZDae0y4XjDK?usp=drive_link","RULE & SHEET"))
add("Rolling Fiefdoms","project_page","download_page",("https://pnpstash.com/product/rolling-fiefdoms/","Latest version on PnP Stash"))
add("Rolling Fiefdoms","rules","file",("https://drive.google.com/file/d/1uNVAlpQyDdZB5h6m7oe5Jk63wIFA1i1m/view","Rulebook"))
add("Rolling Fiefdoms","component","folder",("https://drive.google.com/drive/folders/12LFRdiDYX3YPq_QMl4JbCRk5JcG5dSNw","Print Sheet: A4/US Letter, color/low ink"),("https://drive.google.com/file/d/1HkYNoAXEncwHN2H8Out1KNG8IFpO_XP8/view","Solo Challenges"))
add("Rolling Fiefdoms","online_play","web_app",("https://rolling-fiefdoms.edno.io/","Online Version"))
add("Rolling Parks","game_files","folder",("https://drive.google.com/drive/folders/16v7VTo5twgoR7vqxphBPwZzgKzwatlS4?usp=sharing","PnP files and rules"))
add("Spellwrights Codex","component","file",("https://drive.google.com/file/d/1Id7717KvewORCzAQwAaeKcmp2Eix6dZ3/view?usp=drive_link","Player sheets 2.0"),("https://drive.google.com/file/d/1bs67oFp8FZcuJoyKzsQooV4ialp5O7oG/view?usp=drive_link","54 word cards original"),("https://drive.google.com/file/d/1JBe884ojsF674bq--1aQXP3LAS1EG-UJ/view?usp=drive_link","54 word cards wizard themed"))
add("Spellwrights Codex","rules","file",("https://drive.google.com/file/d/1c1lIjSTEv6XqG64kFFdFqvJz7gBTx76M/view?usp=drive_link","Rules 2.0"))
add("Skyfall","game_files","folder",("https://drive.google.com/drive/folders/1Px7jxTJUpDScf550HS8SErdUt4ocrgTs","Game Rules and PNP Files; also repeated as Current game files"))
add("Skyfall","tool","web_app",("https://clarkander-hash.github.io/SkyfallLevelGenerator/Level%20Generator.html","Skyfall Level Generator"))
add("Skyfall","video","video",("https://youtube.com/watch?v=SMdtOxxhCgY","Skyfall Playthrough"))
add("The Leaning Tower of Pisa","game_files","folder",("https://www.dropbox.com/scl/fo/4emb93d1osif1acs29n1q/AD_R0dTRVa_O8D57ryXOW98?rlkey=ja4fvc417fa6qpk9i4slpmjza&st=hdpsr7k2&dl=0","Fan-made Christmas Tree version"))
add("The Leaning Tower of Pisa","video","video",("https://player.vimeo.com/video/1091452176?title=0&byline=0&portrait=0&dnt=1","Embedded Vimeo video 1091452176"),("https://player.vimeo.com/video/743773116?title=0&byline=0&portrait=0&dnt=1","Embedded Vimeo video 743773116"))
add("The Legend of Whispervale","component","file",("https://www.dropbox.com/scl/fi/a2617gy6dbiv6b17uybd7/Starter_Cards.pdf?rlkey=5osj435xky12crrtkcvb1gr2a&e=1&dl=0","Starter Cards"),("https://www.dropbox.com/scl/fi/0bbwg1hacp88t2e4c8mla/Upgraded_Experience_Cards.pdf?rlkey=mdbg4lbohgxbexic0hsqpufdz&e=1&dl=0","Upgraded Cards"),("https://www.dropbox.com/scl/fi/4q0h6vr2wml8zkbo0rkkp/Bachelor_Sheets.pdf?rlkey=rsnjtm7eh0z7gq78h7y9jkc5t&e=1&dl=0as","Bachelor Sheets"),("https://www.dropbox.com/scl/fi/ew4wia81ck5829klkusjp/Protagonist_Sheets.pdf?rlkey=8lg7g3t3rs38hnsrs5qr3znfv&e=1&dl=0","Protagonist Sheets"),("https://www.dropbox.com/scl/fi/pa3q63o5w8xwnappocijx/Objective-and-Encounter-Cards.pdf?rlkey=jawuie91n7k2e5tm9wk3jq32d&e=1&dl=0","Objective and Encounter Cards"))
add("The Legend of Whispervale","rules","file",("https://www.dropbox.com/scl/fi/lcnc4pgxf1yzdyku2ffbd/Legend-of-Whispervale-Rulebook.pdf?rlkey=vud6o3cfqyjdtyqy7j9s1reic&e=1&dl=0","Rulebook"))
add("The Legend of Whispervale","online_play","workshop_module",("https://steamcommunity.com/sharedfiles/filedetails/?id=3613719264","TTS build"))
add("Thieves of Bandervon","video","video",("https://drive.google.com/file/d/1OB1SbvQRsOCVylqVN5yP1xJ3-Doz7_RU/view?usp=drivesdk","How To Play Solo 2.1 Video; also labelled How To Play 2-4P 2.1 Video"))
add("Thieves of Bandervon","component","file",("https://drive.google.com/file/d/1IfcnfCqsKiBdPGKHP6ScXqZwqi0-CUUB/view?usp=drivesdk","Color Print Solo: Page 1"),("https://drive.google.com/file/d/1AdEsQzL8LDPoBG0ABpahQMObszwWD73J/view?usp=drivesdk","Color Print 2-4 Player: Page 2"),("https://drive.google.com/file/d/1VqXbtxgDy1xbddipv3AIxP6RfW-0tUWP/view?usp=drivesdk","Color Print 2-4 Player: Page 3"),("https://drive.google.com/file/d/1vH818mzHyd8-NlJDNA-F3rVmcWnhNogy/view?usp=drivesdk","Color Print 2-4 Player: Page 4"),("https://drive.google.com/file/d/1xjrDTGLHnmmXg3FotkdWvNi1-VQDDTmY/view?usp=drivesdk","Low Ink Page 1"),("https://drive.google.com/file/d/1ORqNfg0QHR87Tci93utVortP-qyLuvSW/view?usp=drivesdk","Low Ink Page 2"))
add("Thieves of Bandervon","rules","file",("https://drive.google.com/file/d/1o7CH-39FfMEXBSj4c9qDbHR5TELCNjvR/view?usp=drivesdk","Rules v2.2"))
add("Vanguard Multi Asset Global Command","component","file",("https://drive.google.com/file/d/1tMKdthSjCSzsjx0rrQnc9BbivVVeEUCx/view?usp=sharing","Map"))
add("Vanguard Multi Asset Global Command","rules","file",("https://drive.google.com/file/d/1TKzlPMNyurFMRjBYvoa9y7dUwZKiVX4m/view?usp=sharing","Rules"))
add("Word Builders","video","video",("https://youtube.com/watch?v=cLO06-8h8AQ","Half game playthrough (8 mins)"))
add("Word Builders","game_files","folder",("https://drive.google.com/drive/folders/1tK3jz8ZSrt6tntLVFALqkWUU8EU9iajS?usp=sharing","Folder with Files"))
add("1899 - 1907 Black Death Brazil","game_files","folder",("https://drive.google.com/drive/folders/16P6w2n3rmFJcMQZ-2X7g_fndjbs8BAD0?usp=sharing","Components and rules in Portuguese and English"))
add("1899 - 1907 Black Death Brazil","video","video",("https://www.youtube.com/watch?v=3uRoX0PhvWs&t=1607s","Instructional video/full game in Portuguese"),("https://www.youtube.com/watch?v=I-qKT57L6ZQ","Second video declared in WIP"))
add("City Lights","game_files","file",("https://drive.google.com/file/d/1yTFZPFPNMEPDbr34J8nzLc_ldEFjTc6Q/view?usp=sharing","Rules & Sheet v1.4"))
add("City Lights","online_play","web_app",("https://playingcards.io/4df8jf","PlayingCards.io Table 1"),("https://playingcards.io/dyv83d","PlayingCards.io Table 2"),("https://playingcards.io/vapbhq","PlayingCards.io Table 3"))
add("Fortune Script","game_files","folder",("https://drive.google.com/drive/folders/1MD9Xfr2LPEfX-g2f2ScBpIBBDNvSvSoX?usp=drive_link","PnP Files"))
add("Fortune Script","online_play","workshop_module",("https://steamcommunity.com/sharedfiles/filedetails/?id=3616294299","TTS mod"))
add("On the Trail of Bigfoot","rules","file",("https://drive.google.com/file/d/1rR_yhkN3wN6K2fW9laBfJodqgM10A41h/view?usp=drive_link","ENG Rulebook"))
add("On the Trail of Bigfoot","game_files","file",("https://drive.google.com/file/d/1aF2rC_ieFxC0vALVG1wQHgkbfljIwY0P/view?usp=drive_link","P&P files"))
add("PIXIX","game_files","folder",("https://drive.google.com/drive/folders/1xZGWAgmjVLudHdxFVTCI_j-rky5O5Jow?usp=sharing","PIXIX Rules and Files"))
add("Ringleader","game_files","folder",("https://drive.google.com/drive/folders/1d0N0N-dS7UOyqc6vhie0PnvdShEy1DeD?usp=drive_link","Playtest Files"))
add("Roll & Pose","game_files","folder",("https://drive.google.com/drive/folders/12etbmJRyHHCBx_6PhYJtoOSymWijLuzh?usp=sharing","Roll and Pose files"))
add("Scribe","rules","file",("https://drive.google.com/file/d/1VBpCjnHAU15VUcGJK1dioHW8BtigDzvL/view?usp=drive_link","Rules"))
add("Scribe","video","video",("https://youtu.be/lnFXsEHMNyc","Video Rules"))
add("Scribe","game_files","folder",("https://drive.google.com/drive/folders/1eJVGpcnRZM-xleAPtdflkRq2lVlCf80k?usp=drive_link","PnP files"))
add("Scribe","online_play","workshop_module",("https://steamcommunity.com/sharedfiles/filedetails/?id=3571308098","TTS Mod"))
add("U2: Flights of the Dragon Lady","rules","file",("https://drive.google.com/file/d/1xeXUwyj2mRCD8KbvJ1b8ICOIR7m1wX4n/view?usp=sharing","PDF v1015 rules"))
add("U2: Flights of the Dragon Lady","component","file",("https://drive.google.com/file/d/1CWeZiqywGpwObBCNP9dgElA90MIrmm_q/view?usp=sharing","18x18 Gameboard"))
add("Yadoya","game_files","folder",("https://drive.proton.me/urls/8YHBB1NZ88#E3aEkB65vNxw","Project folder: first draft rules and sheet"))

assert len(entries) == 37
assert len(R) == 82, len(R)
assert len({(t,u) for t,u,_,_,_ in R}) == 82

WIPS = {'Ancient World': '3614076', 'Compass & Ink': '3593066', 'Dawn Chorus': '3618849', 'Dicease Control: The 4.D-10 Pathogen': '3603070', 'Doodle Bash!': '3606967', 'Fortify!': '3615315', 'Labyrinth of Shadows': '3584529', 'Lithomacy': '3617600', 'Mainframe: System Shutdown': '3617159', 'Master of Thievery': '3620403', 'Natura': '3621278', 'On-LINE Kasino': '3619168', 'Rolling Fiefdoms': '3596654', 'Rolling Parks': '3619248', 'Spellwrights Codex': '3617539', 'Skyfall': '3600730', 'The Leaning Tower of Pisa': '3613315', 'The Legend of Whispervale': '3621367', 'Thieves of Bandervon': '3596433', 'Vanguard Multi Asset Global Command': '3619638', 'Word Builders': '3620974', '1899 - 1907 Black Death Brazil': '3600465', "A Dragon's Die": '3607359', 'City Lights': '3621048', 'Fortune Script': '3621017', 'INFRARED': '3593194', 'Necromancy: Roll Them Bones!': '3592805', 'On the Trail of Bigfoot': '3592032', 'PIXIX': '3620811', 'Ringleader': '3617946', 'Roll & Pose': '3620499', 'The Thirteenth Dimension': '3595192', 'Scribe': '3592781', 'STRATOS': '3592669', "Wizard's Tutelage": '3592976', 'U2: Flights of the Dragon Lady': '3585469', 'Yadoya': '3618848'}
assert len(WIPS) == 37

def q(s): return "'" + s.replace("'", "''") + "'"
sql = ["-- Full first-post resource census for 2025 Roll & Write. Destinations were not opened.","PRAGMA foreign_keys = ON;","BEGIN IMMEDIATE;",
"CREATE TEMP TABLE rw_wip(title TEXT PRIMARY KEY,url TEXT NOT NULL);",
"CREATE TEMP TABLE rw_resource(title TEXT,url TEXT,role TEXT,access_type TEXT,label TEXT,PRIMARY KEY(title,url));"]
sql += ["INSERT INTO rw_wip VALUES("+q(t)+","+q("https://boardgamegeek.com/thread/"+thread)+");" for t,thread in WIPS.items()]
sql += ["INSERT INTO rw_resource VALUES("+",".join(map(q,row))+");" for row in R]
none = [q(t) for t,c,_ in entries if c == 0]
sql += [f"UPDATE entries SET wip_thread_url=(SELECT w.url FROM rw_wip w JOIN games g ON g.canonical_title=w.title WHERE g.id=entries.game_id) WHERE contest_id={CONTEST_ID};",
f"DELETE FROM entry_resource_scans WHERE checked_at={q(DATE)} AND entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
f"INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) SELECT e.id,{q(DATE)},e.wip_thread_url,'found',CASE WHEN g.canonical_title IN ({','.join(none)}) THEN 'none_declared' ELSE 'observed' END,CASE WHEN g.canonical_title IN ({','.join(none)}) THEN 'Primo post renderizzato: nessun collegamento pertinente dichiarato osservato.' ELSE 'Primo post renderizzato: anchor, link dinamici e media incorporati censiti; destinazioni non aperte.' END FROM entries e JOIN games g ON g.id=e.game_id WHERE e.contest_id={CONTEST_ID};",
"INSERT OR IGNORE INTO remote_resources(game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at) SELECT g.id,r.role,r.access_type,r.url,substr(substr(r.url,instr(r.url,'//')+2),1,instr(substr(r.url,instr(r.url,'//')+2),'/')-1),r.label,NULL,'unknown','2026-09-10','2026-09-10' FROM rw_resource r JOIN games g ON g.canonical_title=r.title;",
"UPDATE remote_resources SET kind=(SELECT r.role FROM rw_resource r JOIN games g ON g.canonical_title=r.title WHERE g.id=remote_resources.game_id AND r.url=remote_resources.url), access_type=(SELECT r.access_type FROM rw_resource r JOIN games g ON g.canonical_title=r.title WHERE g.id=remote_resources.game_id AND r.url=remote_resources.url), label=(SELECT r.label FROM rw_resource r JOIN games g ON g.canonical_title=r.title WHERE g.id=remote_resources.game_id AND r.url=remote_resources.url), last_verified_at='2026-09-10' WHERE EXISTS(SELECT 1 FROM rw_resource r JOIN games g ON g.canonical_title=r.title WHERE g.id=remote_resources.game_id AND r.url=remote_resources.url);",
f"DELETE FROM entry_resource_mentions WHERE entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
f"INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) SELECT e.id,rr.id,e.wip_thread_url,r.label,r.role,CASE WHEN r.role='game_files' THEN 1 ELSE 0 END,{q(DATE)},{q(DATE)} FROM rw_resource r JOIN games g ON g.canonical_title=r.title JOIN entries e ON e.game_id=g.id AND e.contest_id={CONTEST_ID} JOIN remote_resources rr ON rr.game_id=g.id AND rr.url=r.url;",
"INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT rr.id,'2026-09-10',e.wip_thread_url,'declared_in_wip','not_checked',NULL,'Dichiarata nel primo post BGG; destinazione non aperta. Classificazione funzionale e tecnica provvisoria fino alla revisione completa del 2025.' FROM rw_resource r JOIN games g ON g.canonical_title=r.title JOIN entries e ON e.game_id=g.id AND e.contest_id=22 JOIN remote_resources rr ON rr.game_id=g.id AND rr.url=r.url WHERE NOT EXISTS(SELECT 1 FROM remote_resource_observations o WHERE o.remote_resource_id=rr.id AND o.observed_at='2026-09-10' AND o.evidence_url=e.wip_thread_url AND o.observation_kind='declared_in_wip');",
"DROP TABLE rw_resource;","DROP TABLE rw_wip;","COMMIT;"]
(ROOT/"catalog"/"2025-roll-write-wips-resources.sql").write_text("\n".join(sql)+"\n",encoding="utf-8")

md=["# WIP e risorse dichiarate — Roll & Write 2025","","Verifica del 10 settembre 2026 sui primi post renderizzati delle 37 WIP. Sono stati estratti anchor ordinari, collegamenti BGG dinamici e media incorporati senza aprire le destinazioni esterne. La classificazione è provvisoria fino al confronto di tutti i contest 2025.","","| # | Entry | Risorse distinte | Tipologie osservate |","|---:|---|---:|---|"]
for i,(t,c,k) in enumerate(entries,1): md.append(f"| {i} | {t} | {c} | {k} |")
md += ["","## Risorse","","| Entry | Descrizione BGG | Funzione provvisoria | Forma tecnica | URL |","|---|---|---|---|---|"]
for t,u,role,form,label in R: md.append(f"| {t} | {label.replace('|','/')} | `{role}` | `{form}` | {u} |")
md += ["","## Totali","","- 37 WIP individuati e scansionati.","- 30 WIP con almeno una risorsa dichiarata.","- 7 WIP senza collegamenti pertinenti osservati nel primo post.","- 82 risorse remote distinte.","- Disponibilità esterna non verificata e nessun file scaricato.","","La deduplicazione accorpa lo stesso URL ma conserva nel campo descrittivo le menzioni differenti. I collegamenti automatici ai canali YouTube sono esclusi; i video Vimeo incorporati sono inclusi."]
(ROOT/"sources"/"2025-ROLL-WRITE-WIPS-RESOURCES.md").write_text("\n".join(md)+"\n",encoding="utf-8")

def append_once(path, marker, text):
    p=ROOT/path; old=p.read_text(encoding="utf-8")
    if marker not in old: p.write_text(old.rstrip()+"\n\n"+text.strip()+"\n",encoding="utf-8")

append_once(Path("AGENTS.md"),"La tassonomia dei collegamenti resta provvisoria",'''## Tassonomia evolutiva dei collegamenti

La tassonomia dei collegamenti resta provvisoria durante l'esplorazione annuale. Conservare separatamente funzione dichiarata, forma tecnica ed evidenza; accorpare URL identici senza perdere le diverse menzioni. Chiudere categorie ed enumerazioni soltanto dopo il confronto di tutti i contest dell'anno.''')
append_once(Path("PROJECT.md"),"La classificazione dei collegamenti dichiarati nei WIP evolve",'''## Classificazione evolutiva delle risorse dichiarate

La classificazione dei collegamenti dichiarati nei WIP evolve per osservazione. Funzione, forma tecnica e stato dell'evidenza restano dimensioni separate. I valori usati durante il censimento sono provvisori e saranno consolidati soltanto dopo la scansione trasversale di tutti i contest 2025; testo e contesto originali restano preservati.''')
append_once(Path(".agents/skills/bgg-contest-navigation/SKILL.md"),"## Collegamenti dichiarati nel WIP",'''## Collegamenti dichiarati nel WIP

1. Limita l'osservazione al primo `article.post` e al relativo `.post-body` renderizzato.
2. Attiva gli eventuali `gg-item-link` nel corpo del post.
3. Estrai `a[href]`, `iframe[src]`, `video[src]` e `source[src]`.
4. Escludi navigazione, profili, immagini decorative, canali aggiunti dai player e duplicati tecnici.
5. Conserva URL, dominio, testo e contesto senza aprire la destinazione.
6. Assegna separatamente funzione e forma tecnica provvisorie.
7. Accorpa URL identici conservando tutte le descrizioni sorgente.
8. Registra l'assenza soltanto dopo questi controlli.

Non chiudere la tassonomia prima del confronto di tutti i contest dell'anno.''')
append_once(Path(".agents/skills/bgg-contest-navigation/references/navigation-playbook.md"),"## Pattern: risorse nel primo post",'''## Pattern: risorse nel primo post

**Osservato:** Roll & Write 2025, 10 settembre 2026.

I WIP combinano anchor ordinari, `gg-item-link`, video incorporati, cartelle, file, pagine di distribuzione, piattaforme giocabili e strumenti. Estrarre dal primo post renderizzato e non dalla sola indicizzazione. Skyfall ripete la stessa cartella; Thieves of Bandervon usa lo stesso URL video con due descrizioni; Leaning Tower contiene Vimeo in `iframe`; i player YouTube aggiungono collegamenti tecnici al canale da escludere. Funzione e forma tecnica restano provvisorie fino alla revisione completa del 2025.''')
append_once(Path("tasks/2026-09-07 - Esplorazione contest BGG 2025/TASK.md"),"### Censimento completo delle risorse dichiarate Roll & Write",'''### Censimento completo delle risorse dichiarate Roll & Write

Il 10 settembre 2026 sono stati analizzati i primi post renderizzati di tutte le 37 WIP, senza seguire destinazioni esterne. Il censimento registra 82 risorse distinte in 30 entry; 7 WIP non dichiarano collegamenti pertinenti osservabili. Sono stati considerati anchor ordinari, link dinamici e media incorporati, con deduplicazione degli URL e conservazione delle descrizioni. La tassonomia funzionale e tecnica rimane provvisoria fino alla scansione di tutti i contest 2025.''')

(ROOT/".workspace"/"fs-write-probe.tmp").unlink(missing_ok=True)
print(f"generated {len(R)} resources for {len(entries)} entries")
