from collections import Counter
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parents[1]
DATE = "2026-09-11"
CONTEST_ID = 14

ENTRIES = [
    (487, "Good Breeding", "3431880", "observed"),
    (488, "Pirate Treasures", "3435409", "none_declared"),
    (489, "Pets Rescue", "3441653", "none_declared"),
    (490, "Swirls", "3387063", "observed"),
    (491, "The Robots are Multiplying", "3442172", "observed"),
    (492, "Potions Master Tournament", None, "not_checked"),
    (493, "Isles of Odd", "3441309", "observed"),
    (494, "Peng Wins!", "3449433", "observed"),
    (495, "Hex Hive: Skirmish", "3449448", "none_declared"),
    (496, "Slowpoke", "3451616", "observed"),
    (497, "Origami Champions", "3451743", "observed"),
    (498, "Sorry! That's My Dungeon", "3442526", "observed"),
    (499, "Ice Cream Heist", "3462311", "observed"),
    (500, "Poker Face", "3465191", "observed"),
    (501, "Squirelly", "3465485", "observed"),
    (502, "Head In The Clouds", "3469238", "none_declared"),
    (503, "Submarine Adventure", "3473660", "observed"),
    (504, "Island of Peril", "3482193", "observed"),
    (505, "Mermaids vs Dinosaurs", "3484120", "observed"),
    (506, "Allmende", "3487174", "observed"),
    (507, "ICBRG", "3493395", "observed"),
    (508, "Bon-Bon", "3493740", "observed"),
    (509, "Zoo Rush", "3495361", "observed"),
    (510, "Crab Boil", "3495781", "observed"),
    (511, "Panic Picasso!", "3496634", "observed"),
    (512, "Guesstrictions", "3496460", "none_declared"),
    (513, "Amusement park - Clashes", "3496296", "observed"),
]

RESOURCES = []


def add(entry_id, role, access_type, context, *pairs):
    for url, label in pairs:
        RESOURCES.append((entry_id, url, role, access_type, label, context))


add(487, "game_files", "folder", "Folder dichiarata per componenti, tessere punteggio e regolamento.",
    ("https://drive.google.com/drive/folders/1HTjtBloUic_1z3ZxLjHZXqyQN0RItHW0", "CLICK HERE FOR LINK TO COMPONENTS"))
add(487, "video", "video", "Video incorporato del gioco; canale YouTube automatico escluso.",
    ("https://youtube.com/watch?v=nyD5Lf5yK4I", "Good Breeding"))
add(490, "project_page", "download_page", "Thread BGG dichiarato come pagina di presentazione, file PnP e collegamenti.",
    ("https://boardgamegeek.com/thread/3388261/official-game-presentation-plus-pnp-files-plus-lin", "PnP files + Links"))
add(491, "game_files", "folder", "Cartella dei file di gioco.",
    ("https://drive.google.com/drive/folders/1U-jwn9MmxArfXS0AIxniqI4YrvODVSMI?usp=sharing", "game files"))
add(491, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3414780892", "Robots are MULTIPLYING on TTS"))
add(493, "rules", "document", "Regolamento dichiarato nel primo post.",
    ("https://www.canva.com/design/DAGTfqleqFM/SxYu95Fk4CYd4ysiaIp4XA/view?utm_content=DAGTfqleqFM&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h0bb8437dcc", "RULEBOOK"))
add(493, "video", "video", "Video delle regole.",
    ("https://www.youtube.com/watch?v=btrWcvyDdd4", "RULES VIDEO!"))
add(493, "game_files", "folder", "Cartella Print and Play.",
    ("https://drive.google.com/drive/folders/1kAb6ps0BxrFo8lwEMrDMmSPUiw0DQAHU?usp=drive_link", "PRINT AND PLAY!"))
add(493, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3383183358", "TABLETOP SIMULATOR!"))
add(494, "game_files", "file", "File unico dichiarato per componenti e regolamento.",
    ("https://drive.google.com/file/d/1bRMFKYviShqv89N87QyNnt7lRdQ-8W-_/view?usp=sharing", "[Components and Rules]"))
add(496, "project_page", "download_page", "Pagina aggregatrice del gioco.",
    ("https://linktr.ee/slowpokegame", "https://linktr.ee/slowpokegame"))
add(496, "rules", "document", "Regolamento Google document.",
    ("https://docs.google.com/document/d/1_FmmwcxoPLaWpXbDO3aYw6E3HKSgiaE9sLTw3y7LcEg/edit?usp=sharing", "https://docs.google.com/document/d/1_FmmwcxoPLaWpXbDO3aYw6E3..."))
add(496, "game_files", "file", "File di gioco.",
    ("https://drive.google.com/file/d/12AXUphcMbo-hvtUcZoINTq5XCzDWC_jR/view?usp=sharing", "https://drive.google.com/file/d/12AXUphcMbo-hvtUcZoINTq5XCzD..."))
add(497, "game_files", "download_page", "Download Itch.io dichiarato nel primo post.",
    ("https://romab.itch.io/origami-champions/download/svnyZKTYODY1ygzXw1qLZ4zbdh_2TgcJTYMd8bG6", "DOWNLOAD"))
add(498, "game_files", "download_page", "Pagina Itch.io dei file Print and Play.",
    ("https://alexandrecamargo.itch.io/sorry-thats-my-dungeon", "https://alexandrecamargo.itch.io/sorry-thats-my-dungeon"))
add(499, "game_files", "folder", "Cartella dei materiali del gioco.",
    ("https://drive.google.com/drive/folders/1wwt9avcEXb89YQdJImyHXqvnaXqg_IY7?usp=drive_link", "https://drive.google.com/drive/folders/1wwt9avcEXb89YQdJImyH..."))
add(500, "component", "file", "Carte versione 0.1.",
    ("https://drive.google.com/file/d/1Qj7zr1IJVQeR8zsvkRhlZzry5e5QA1ZU/view?usp=drive_link", "Ver. 0.1 Cards"))
add(500, "rules", "file", "Regolamento versione 0.1.",
    ("https://drive.google.com/file/d/1wTMUUwAJsTuvdoPhRyUFv3uhjf1Z0kCW/view?usp=drive_link", "Ver. 0.1 Rulebook"))
add(501, "game_files", "folder", "Cartella Google Drive dei file correnti.",
    ("https://drive.google.com/drive/folders/1LGdbkZj3mrqKiAkhXjFldlG6tCJZueF4?usp=sharing", "Here!"))
add(501, "online_play", "workshop_module", "Playtest digitale su Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3431578623", "here!"))
add(503, "rules", "file", "Regolamento.",
    ("https://drive.google.com/file/d/1lZPFrQDFS3If4WwXilJzEGLMyvP-zb1l/view?usp=sharing", "[Rules]"))
add(503, "component", "file", "Componenti.",
    ("https://drive.google.com/file/d/1dw99YPj1fTMPgv0goPQhog1k4cEREwVS/view?usp=sharing", "[Components]"))
add(503, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3440131938", "[Tabletop Simulator Mod]"))
add(504, "game_files", "folder", "Cartella di download del gioco.",
    ("https://drive.google.com/drive/folders/1XhMiXjWg6244O21QTQN7mFfk9fTTP_a7?usp=sharing", "Google drive"))
add(505, "game_files", "folder", "Cartella dei file di gioco.",
    ("https://drive.google.com/drive/folders/1zGPcGn3RqjxIoeSYFUSMms_lsTHQpeHH?usp=sharing", "Game Files"))
add(505, "rules", "document", "Bozza del regolamento.",
    ("https://docs.google.com/document/d/1c6fbzo61Ytm4uhcFQ5e6CdDhjreeG6WAw2qWq7-C8dI/edit?usp=sharing", "Rulebook Draft Doc"))
add(505, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3451271982", "TTS Module"))
add(505, "video", "video", "Video incorporato how-to-play; canale automatico escluso.",
    ("https://youtube.com/watch?v=rn8Ua0MW_KE", "How to play Mermaids vs Dinosaur"))
add(506, "game_files", "folder", "URL Google Drive conservato esattamente come dichiarato; forma sintattica anomala non verificata.",
    ("https://drive.google.com/drive/folders/https://drive.google.com/drive/folders/1SPvqNnKXTlV3Y3YI04zA-Ydpmwyr4ied?usp=sharing", "Download from google drive"))
add(506, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3456867447", "Tabletop Simulator"))
add(506, "video", "video", "Manuale digitale su YouTube; riferimento incorporato duplicato accorpato.",
    ("https://www.youtube.com/watch?v=3n7VVfHGXL4", "on Youtube"))
add(507, "component", "file", "PnP versione 2.1.",
    ("https://drive.google.com/file/d/1fFHUf2LiuHYpH2lDG6UcTZpLU1Egykug/view?usp=drive_link", "ICBRG PnP Version 2.1 (Last updated 4/30/25)"))
add(507, "rules", "file", "Regolamento versione 2.0.",
    ("https://drive.google.com/file/d/1E39KA-RsPZHBL4yOfBh_KBopZC0VEfJB/view?usp=drive_link", "ICBRG Rulebook Version 2.0 (Last updated 4/30/25)"))
add(508, "game_files", "download_page", "Pagina dichiarata per regole e componenti PnP.",
    ("https://rollingolem.wordpress.com/197-2/", "game files"))
add(508, "online_play", "web_app", "Versione digitale su Tabletopia.",
    ("https://tabletopia.com/games/bonbon", "tabletopia"))
add(509, "game_files", "file", "PDF a colori con regole e componenti.",
    ("https://c.gmx.net/@327464636691519389/YOeFrQLGl7b_8fshNOMquA", "Download color version"))
add(509, "game_files", "file", "PDF in scala di grigi con regole e componenti.",
    ("https://c.gmx.net/@327464636691519389/codVtkSgl0lg96tFnH0QmA", "Download printer-friendly (grayscale) version"))
add(510, "game_files", "download_page", "Pagina Itch.io del Print and Play.",
    ("https://scobblehog-press.itch.io/crab-boil-a-print-play-crab-battle-boardgame", "Itch.io Crab Boil Link"))
add(511, "component", "file", "Carte prompt e gettoni punti.",
    ("https://drive.google.com/file/d/1HHJbCYuzNm1oHWrc4CWZ5TujdowJ-J5A/view?usp=drive_link", "Prompt Cards and Points Tokens"))
add(511, "rules", "file", "Regolamento di due pagine.",
    ("https://drive.google.com/file/d/1TGqPBrOt_SQp5kUGPQTyePEWfowrfh4j/view?usp=drive_link", "2 Page Rule book"))
add(513, "rules", "document", "Regolamento Google document.",
    ("https://docs.google.com/document/d/1hEfypoqizHyDm_A7EMcFqt48qQaH1PgfhrYPjpGJ_x4/edit?usp=sharing", "https://docs.google.com/document/d/1hEfypoqizHyDm_A7EMcFqt48..."))
add(513, "game_files", "folder", "Cartella dei componenti.",
    ("https://drive.google.com/drive/folders/1GZelx-0nKt2PlI8JFyRhgWWSj0D03oB5?usp=sharing", "https://drive.google.com/drive/folders/1GZelx-0nKt2PlI8JFyRh..."))
add(513, "online_play", "workshop_module", "Modulo Tabletop Simulator.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3464395035&result=8", "https://steamcommunity.com/sharedfiles/filedetails/?id=34643..."))

assert len(ENTRIES) == 27
assert sum(1 for _, _, wip, _ in ENTRIES if wip) == 26
assert len(RESOURCES) == 43, len(RESOURCES)
assert len({(entry_id, url) for entry_id, url, *_ in RESOURCES}) == 43
assert Counter(status for *_, status in ENTRIES) == Counter(observed=21, none_declared=5, not_checked=1)


def q(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


sql = [
    "-- Full first-post resource census for 2025 Children & Family. External destinations were not opened.",
    "PRAGMA foreign_keys = ON;", "BEGIN IMMEDIATE;",
    "CREATE TEMP TABLE cf_entry(entry_id INTEGER PRIMARY KEY,title TEXT NOT NULL,wip_url TEXT,listing_status TEXT NOT NULL);",
    "CREATE TEMP TABLE cf_resource(entry_id INTEGER,url TEXT,role TEXT,access_type TEXT,label TEXT,context TEXT,PRIMARY KEY(entry_id,url));",
]
for entry_id, title, thread_id, status in ENTRIES:
    wip = f"https://boardgamegeek.com/thread/{thread_id}" if thread_id else None
    sql.append(f"INSERT INTO cf_entry VALUES({entry_id},{q(title)},{q(wip)},{q(status)});")
for row in RESOURCES:
    sql.append("INSERT INTO cf_resource VALUES(" + ",".join(q(v) for v in row) + ");")
sql += [
    f"UPDATE entries SET wip_thread_url=(SELECT wip_url FROM cf_entry i WHERE i.entry_id=entries.id) WHERE contest_id={CONTEST_ID};",
    f"DELETE FROM entry_resource_scans WHERE checked_at={q(DATE)} AND entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
    f"INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) SELECT entry_id,{q(DATE)},COALESCE(wip_url,'https://boardgamegeek.com/geeklist/351008/2025-children-and-family-game-design-contest'),CASE WHEN wip_url IS NULL THEN 'not_found' ELSE 'found' END,listing_status,CASE listing_status WHEN 'observed' THEN 'Primo post renderizzato: anchor, link dinamici e media incorporati censiti; destinazioni non aperte.' WHEN 'none_declared' THEN 'Primo post renderizzato integralmente: nessun collegamento pertinente dichiarato osservato.' ELSE 'La voce GeekList espone risorse ma nessun WIP: risorse della lista non attribuite al censimento WIP.' END FROM cf_entry;",
    "INSERT OR IGNORE INTO remote_resources(game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at) SELECT e.game_id,r.role,r.access_type,r.url,CASE WHEN instr(substr(r.url,instr(r.url,'//')+2),'/')>0 THEN substr(substr(r.url,instr(r.url,'//')+2),1,instr(substr(r.url,instr(r.url,'//')+2),'/')-1) ELSE substr(r.url,instr(r.url,'//')+2) END,r.label,NULL,'unknown','2026-09-11','2026-09-11' FROM cf_resource r JOIN entries e ON e.id=r.entry_id;",
    "UPDATE remote_resources SET kind=(SELECT r.role FROM cf_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),access_type=(SELECT r.access_type FROM cf_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),label=(SELECT r.label FROM cf_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),last_verified_at='2026-09-11' WHERE EXISTS(SELECT 1 FROM cf_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url);",
    f"DELETE FROM entry_resource_mentions WHERE entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
    "INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) SELECT r.entry_id,rr.id,i.wip_url,r.label,r.role,CASE WHEN r.role='game_files' THEN 1 ELSE 0 END,'2026-09-11','2026-09-11' FROM cf_resource r JOIN cf_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url;",
    "INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT rr.id,'2026-09-11',i.wip_url,'declared_in_wip','not_checked',NULL,'Dichiarata nel primo post BGG; destinazione non aperta. Contesto: '||r.context||' Classificazione funzionale e tecnica provvisoria fino alla revisione completa del 2025.' FROM cf_resource r JOIN cf_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url WHERE NOT EXISTS(SELECT 1 FROM remote_resource_observations o WHERE o.remote_resource_id=rr.id AND o.observed_at='2026-09-11' AND o.evidence_url=i.wip_url AND o.observation_kind='declared_in_wip');",
    "DROP TABLE cf_resource;", "DROP TABLE cf_entry;", "COMMIT;",
]
(ROOT / "catalog" / "2025-children-family-wips-resources.sql").write_text("\n".join(sql) + "\n", encoding="utf-8")

counts = Counter(entry_id for entry_id, *_ in RESOURCES)
entry_by_id = {entry_id: (title, thread_id, status) for entry_id, title, thread_id, status in ENTRIES}
md = [
    "# WIP e risorse dichiarate — Children & Family 2025", "",
    "Verifica dell’11 settembre 2026 sui primi post renderizzati dei 26 WIP individuati. Anchor ordinari, `gg-item-link` e media incorporati sono stati censiti senza aprire le destinazioni esterne. La classificazione resta provvisoria fino al confronto di tutti i contest 2025.", "",
    "| # | Entry | Stato WIP/risorse | Risorse distinte |", "|---:|---|---|---:|",
]
labels = {"observed": "risorse osservate", "none_declared": "nessuna risorsa dichiarata", "not_checked": "WIP non individuato"}
for index, (entry_id, title, _, status) in enumerate(ENTRIES, 1):
    md.append(f"| {index} | {title} | {labels[status]} | {counts[entry_id]} |")
md += ["", "## Risorse", "", "| Entry | Etichetta originale | Contesto osservato | Funzione provvisoria | Forma tecnica | Dominio | URL |", "|---|---|---|---|---|---|---|"]
for entry_id, url, role, form, label, context in RESOURCES:
    clean = lambda text: text.replace("|", "/").replace("\n", " ")
    md.append(f"| {clean(entry_by_id[entry_id][0])} | {clean(label)} | {clean(context)} | `{role}` | `{form}` | `{urlparse(url).netloc}` | {url} |")
md += ["", "## Esclusioni e casistiche", "",
       "- Esclusi navigazione, profili, immagini decorative, riferimenti al contest e pagine BGG del gioco non presentate come risorse.",
       "- Esclusi i collegamenti automatici ai canali YouTube; conservati i singoli video incorporati.",
       "- URL duplicati nella stessa entry accorpati; per Allmende il link testuale e l’incorporamento indicavano lo stesso video.",
       "- I `gg-item-link` sono stati portati nel viewport e attesi prima della lettura; destinazioni vuote o cancellate non sono state inventate.",
       "- `Potions Master Tournament` non ha un WIP. Le tre risorse presenti nella voce GeekList restano evidenza separata e non sono attribuite al primo post di un WIP.",
       "- L’URL Google Drive di `Allmende` contiene due prefissi concatenati: è conservato esattamente come dichiarato e non verificato.",
       "", "## Totali", "",
       "- 27 entry coperte: 26 WIP individuati e aperti direttamente, 1 entry senza WIP (`Potions Master Tournament`).",
       "- 21 WIP con almeno una risorsa dichiarata.",
       "- 5 WIP senza collegamenti pertinenti osservati nel primo post.",
       "- 43 risorse remote distinte.",
       "- Disponibilità esterna non verificata e nessun file scaricato."]
(ROOT / "sources" / "2025-CHILDREN-FAMILY-WIPS-RESOURCES.md").write_text("\n".join(md) + "\n", encoding="utf-8")
print(f"generated {len(RESOURCES)} resources for {len(ENTRIES)} entries")
