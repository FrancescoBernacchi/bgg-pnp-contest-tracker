from collections import Counter
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parents[1]
DATE = "2026-09-11"
CONTEST_ID = 12

ENTRIES = [
    (366, "Crop Rotation", "3378438", "observed"),
    (367, "Hand of Cthulhu", "3379033", "observed"),
    (368, "One Banner", "3379074", "observed"),
    (369, "One for sorrow", "3388854", "observed"),
    (370, "Valley of Gems", "3399221", "observed"),
    (371, "Maze Shift", "3384043", "observed"),
    (372, "Hand-At-Arms", "3402467", "observed"),
    (373, "Office Quest: Data Kraken", "3402030", "observed"),
    (374, "Dive Into The Dungeon", "3408691", "observed"),
    (375, "Publish or Perish", "3413650", "observed"),
    (376, "Songs of the Sea and the Sky", "3419526", "observed"),
    (377, "Smuggler's Sky: Hand of Fate", "3425444", "observed"),
    (378, "Withering Grove", "3425504", "observed"),
    (379, "Spellbooked!", "3430680", "observed"),
    (380, "Librarian’s Cat", "3431954", "observed"),
    (381, "Duel: Clash of Metal", None, "not_checked"),
    (382, "Handicam", "3423424", "observed"),
    (383, "Downtown Las Palmas", "3410393", "observed"),
    (384, "Hellheim In-Hand Duel", "3403303", "none_declared"),
    (385, "Prime Minister - The In-Hand Game", "3378860", "observed"),
    (386, "Starcrossed", "3400721", "observed"),
    (387, "HandMaze", "3423398", "observed"),
    (388, "Dreadspire Keep", "3429956", "none_declared"),
    (389, "Awake until midnight", "3425454", "observed"),
    (390, "On the Trail of the Letter Cutter", "3388256", "observed"),
    (391, "Black Market", "3431335", "not_observable"),
    (392, "Memory Trick", "3388612", "observed"),
]

RESOURCES = []


def add(entry_id, role, access_type, context, *pairs):
    for url, label in pairs:
        RESOURCES.append((entry_id, url, role, access_type, label, context))


add(366, "game_files", "download_page", "Files now hosted in the BGG game-page files section.",
    ("https://boardgamegeek.com/boardgame/446250/crop-rotation/files", "here in the game page's files section"))
add(366, "online_play", "web_app", "Alternative online play without printing cards.",
    ("https://playingcards.io/cw9xhm", "online on pc.io here"))
add(367, "video", "video", "Embedded how-to-play video; automatic channel link excluded.",
    ("https://youtube.com/watch?v=jNZQVbfbphg", "How to Play Hand of Cthulhu"))
add(367, "online_play", "web_app", "PlayingCards.io online version.",
    ("https://playingcards.io/zp6weh", "If you want to play online click here for PlayingCards.io!"))
add(367, "project_page", "download_page", "Page offering the PnP or a physical wallet edition.",
    ("https://onecardmaze.myshopify.com/", "If you want to buy the PnP or the Physical Wallet click here!"))
add(368, "game_files", "download_page", "Game files page.",
    ("https://qu1rrel.itch.io/one-banner", "Game Files"))
add(368, "online_play", "web_app", "PlayingCards.io version declared under 'To try the game'.",
    ("https://playingcards.io/game/standard-deck", "PlayingCards.io"))
add(368, "video", "video", "Embedded playthrough videos; duplicate automatic channel links excluded.",
    ("https://youtube.com/watch?v=k-dOAnbAvRY", "OneBanner Playthrough 241208"),
    ("https://youtube.com/watch?v=m2ABNpXZwxI", "OneBanner Playthrough 250302"))
add(369, "video", "video", "Embedded overview, how-to-play and mini-playthrough; automatic channel link excluded.",
    ("https://youtube.com/watch?v=d-5IMFzZSV4", "One for Sorrow Overview, How to Play and Mini-playthrough"))
add(369, "game_files", "download_page", "Itch.io game-files page; duplicate image link deduplicated.",
    ("https://kevmakesgames.itch.io/one-for-sorrow", "Itch.io"))
add(370, "game_files", "folder", "Rules and cards, version 0.3.0-beta.1.",
    ("https://drive.google.com/drive/folders/1Pvgf0jLD-yO3vgwjj38x7GPpzIFWxBMz?usp=sharing", "Valley of Gems 0.3.0-beta.1 Rules & Cards (Google Drive)"))
add(370, "video", "video", "Video URL declared in the first post.",
    ("https://www.youtube.com/watch?v=m554qdOKeag", "https://www.youtube.com/watch?v=m554qdOKeag"))
add(371, "game_files", "folder", "Folder listing rules and three themed Maze Shift versions.",
    ("https://drive.google.com/drive/folders/1eBlqG5X8X9LZqfXrRZ28yTLLmZMuah4X?usp=drive_link", "Maze Shift Rules 250119 / COLORS 250119 / MYTHICAL CREATURES 241228 / SPACE 250119"))
add(371, "video", "video", "Embedded game and update videos; automatic channel links excluded.",
    ("https://youtube.com/watch?v=GRdC6O7nIuI", "Maze Shift (In-Hand Moving Maze)"),
    ("https://youtube.com/watch?v=SjpPv9qtdgM", "Maze Shift Update"))
add(372, "video", "video", "Embedded how-to-play and printing-instructions videos; automatic channel links excluded.",
    ("https://youtube.com/watch?v=nRPqEnVl68k", "Hand-At-Arms - how to play and play through"),
    ("https://youtube.com/watch?v=suCaOK332QY", "Hand-At-Arms - no gutter fold PnP instructions"))
add(372, "game_files", "folder", "Aggregate folder declared as all files.",
    ("https://drive.google.com/drive/folders/1Bl552FZDNgj9fMm_kwtH6HTiW9j6Xh1z?usp=sharing", "All Files"))
add(372, "rules", "file", "Standalone rulebook.",
    ("https://drive.google.com/file/d/11VDrebuLZ_QbFVucxzKF-hDvBIbYy_2s/view?usp=drive_link", "Rulebook"))
add(372, "rules", "file", "Supplementary tips document.",
    ("https://drive.google.com/file/d/1rd-SFX47EpwOSePvqLoJ7BqPvbbN8GFd/view?usp=drive_link", "Almanac of Tips"))
add(372, "component", "folder", "Print-and-play files folder.",
    ("https://drive.google.com/drive/folders/169A-GEMO57T6X0n5bG73sv4wL1iuWIbo?usp=drive_link", "Print and Play files"))
add(372, "online_play", "web_app", "Three public PlayingCards.io rooms.",
    ("https://playingcards.io/xazgdr", "Public Room 1"),
    ("https://playingcards.io/3tbqvm", "Public Room 2"),
    ("https://playingcards.io/36yhz3", "Public Room 3"))
add(372, "component", "file", "PlayingCards.io setup file.",
    ("https://drive.google.com/file/d/14JE386Mo439DJS3DU_8Cn0erEVY5vZXo/view?usp=sharing", "pcio file"))
add(372, "online_play", "web_app", "PlayingCards.io page declared with the online-play resources.",
    ("https://playingcards.io/game/standard-deck", "PlayingCards.io"))
add(373, "rules", "document", "Rules Google document.",
    ("https://docs.google.com/document/d/1pfducMwkUEdHJl1BDJCjiTD5GIMGuwG8BsjQHHppB8s/edit?usp=sharing", "Rules Google Doc"))
add(373, "component", "file", "Double-sided US Letter build dated 2025-03-07.",
    ("https://drive.google.com/file/d/1zeAPuv00wu2MekPGWf5G_EXI13ZR6vlm/view?usp=drive_link", "US letter size double-sided 3-7-2025"))
add(373, "online_play", "web_app", "PlayingCards.io room URL.",
    ("https://playingcards.io/2pkch6", "https://playingcards.io/2pkch6"))
add(374, "rules", "document", "Rules Google document.",
    ("https://docs.google.com/document/d/1DyBgLmve-fy4rRgW6B3Rivz6j4A9jRoOeNLoUNqT_II/edit?tab=t.0", "Dive Into The Dungeon rules"))
add(374, "component", "file", "Print-and-play file.",
    ("https://drive.google.com/file/d/1bFWimT7jYofxdSAS7OxGU0CjJIuV3YIz/view?usp=sharing", "Dive Into The Dungeon PnP file"))
add(375, "game_files", "folder", "Cards and rules; long-edge duplex instruction.",
    ("https://drive.google.com/drive/folders/1bGIEm890rSfK6bwsloV9QvGLRaJjB81y?usp=drive_link", "Cards and rules"))
add(376, "game_files", "folder", "Rulebook v1.0 and PnP files.",
    ("https://drive.google.com/drive/folders/1pOg7btFgpH9JtfbMexHvib2SF-Hrvmq4?usp=sharing", "RB-v1.0 and PnP files"))
add(377, "video", "video", "Embedded instructional videos; automatic channel links excluded.",
    ("https://youtube.com/watch?v=_fRu1EHbHBw", "Smuggler's Sky: Hand of Fate - How to Play (PnP Solo Card Game) v2025.04"),
    ("https://youtube.com/watch?v=x2W2CJN43-Q", "Smuggler's Sky: Hand of Fate - Items & Black Market v2025.05"),
    ("https://www.youtube.com/watch?v=qEwM74osdCw", "2 minute video showing how to cut and fold the pocketmod rulebook"))
add(377, "game_files", "folder", "Files available to download on Google Drive.",
    ("https://drive.google.com/drive/folders/1tJXjwf6rN9pFUN6N53ct6w2pzdhyirGy?usp=sharing", "Google Drive"))
add(378, "game_files", "download_page", "Game files page.",
    ("https://qu1rrel.itch.io/withering-grove", "Game Files"))
add(378, "online_play", "web_app", "PlayingCards.io version declared under 'To try the game'.",
    ("https://playingcards.io/game/standard-deck", "PlayingCards.io"))
add(378, "video", "video", "Embedded playthrough; automatic channel link excluded.",
    ("https://youtube.com/watch?v=bR0LrSDrAN0", "WitheringGrove Playthrough 250209"))
add(379, "rules", "file", "Files section: rules.",
    ("https://drive.google.com/file/d/1rtoedYznrZETMN_JjfwwnY3t_mwbvn7e/view?usp=sharing", "here — rules"))
add(379, "component", "file", "Files section: colour cards.",
    ("https://drive.google.com/file/d/1SAsm2Cjn1VvojGi9S4lE2nACmQ65K6Uy/view?usp=sharing", "here — cards, colour version"))
add(379, "component", "file", "Files section: low-ink/grayscale cards.",
    ("https://drive.google.com/file/d/10gOHjFBmvM8EzHRXMSiudnX4-dh7zcRP/view?usp=sharing", "here — cards, Low-ink/Grayscale version"))
add(380, "game_files", "folder", "Project folder declared in the first post.",
    ("https://drive.google.com/drive/folders/1DGqAwFqMFnhySxv4ASj5HNhTuinIc-ZZ?usp=drive_link", "Google Drive folder"))
add(380, "online_play", "workshop_module", "Tabletop Simulator workshop version.",
    ("https://steamcommunity.com/sharedfiles/filedetails/?id=3424577600", "Here!"))
add(382, "rules", "document", "Rules Google document.",
    ("https://docs.google.com/document/d/1uJRTCk87gT6nfRoS6FhfvaA-zlVCAYk8a8rVxyq-8y8/edit?usp=share_link", "Rules"))
add(382, "component", "file", "Low-ink WIP build.",
    ("https://drive.google.com/file/d/13u2A0wHSaTMY5U1bKVNhowlEbXMbyK-d/view?usp=share_link", "Low Ink WIP Build"))
add(382, "online_play", "web_app", "PlayingCards.io version.",
    ("https://playingcards.io/dh86ak", "PlayingCards.io"))
add(383, "project_page", "download_page", "Published product page linked from the withdrawn WIP.",
    ("https://buttonshygames.com/products/downtown-las-palmas", "https://buttonshygames.com/products/downtown-las-palmas"))
add(383, "video", "video", "Embedded playthrough; automatic channel link excluded.",
    ("https://youtube.com/watch?v=c42xgdU6yfM", "Downtown Las Palmas Playthrough 11/25/2024"))
add(385, "rules", "file", "A4 rules.",
    ("https://drive.google.com/file/d/1ivohyPSffZzbgYVJwiNCbgUETKTwobE8/view?usp=drive_link", "PMTIHG Rules (A4)"))
add(385, "component", "file", "A4 cards; double-sided long-edge printing.",
    ("https://drive.google.com/file/d/1_5AwYy37qwpGEdTMZwHx4VLvsRTLYXAe/view?usp=drive_link", "PMTIHG Cards (A4 - print double sided, long edge)"))
add(385, "rules", "file", "Letter rules.",
    ("https://drive.google.com/file/d/1L_627gKEFdOcEnk3Jr0P2TLeaha28-tB/view?usp=drive_link", "PMTIHG rules (Letter)"))
add(385, "component", "file", "Letter cards; double-sided long-edge printing.",
    ("https://drive.google.com/file/d/1T4JjJlsaV-st6FQNFAEUKluOwSHITOm3/view?usp=drive_link", "PMTIHG cards (Letter - print double sided, long edge)"))
add(386, "rules", "file", "Rulebook.",
    ("https://drive.google.com/file/d/1rW17Dbw5-V6R1OGzC1Hp4WVdynp6gqzW/view?usp=drive_link", "Rulebook"))
add(386, "component", "file", "Cards.",
    ("https://drive.google.com/file/d/1ba1ANM62IERCIBZFlkLcrkXi3uEL0_Cy/view?usp=drive_link", "Cards"))
add(386, "video", "web_app", "How-to-play song on Suno; provisional instructional-media classification.",
    ("https://suno.com/song/6a0b8090-c473-45e8-baef-31174883f1af", "Starcrossed: How to play song!"))
add(387, "game_files", "folder", "HandMaze files; post notes that the rulebook was not ready.",
    ("https://drive.google.com/drive/folders/1IAvtRX36ViEt6BauY4rm0EVfKsHI5uJH", "HandMaze Files"))
add(389, "game_files", "folder", "Google Drive files folder.",
    ("https://drive.google.com/drive/folders/15i1yvl04FnPzmRTIj24DxBZXtrC3I9kf?usp=sharing", "Google Drive"))
add(390, "component", "folder", "Components folder.",
    ("https://drive.google.com/drive/folders/1ZNqLUWJ4HUH4Q0v1SpduALptfiRp3f1p?usp=sharing", "Components"))
add(392, "rules", "file", "Rulebook PDF.",
    ("https://drive.google.com/file/d/1DALYmtk22W-B5GbKlcqGZHc5ES9i_jht/view?usp=sharing", "PDF — Rulebook"))
add(392, "component", "file", "Cards PDF.",
    ("https://drive.google.com/file/d/1ciEtyCZCv8T6NWSyROuzpJqPgA4s4FjM/view?usp=sharing", "PDF — Cards"))

assert len(ENTRIES) == 27
assert sum(1 for _, _, wip, _ in ENTRIES if wip) == 26
assert len(RESOURCES) == 63, len(RESOURCES)
assert len({(entry_id, url) for entry_id, url, *_ in RESOURCES}) == 63
assert Counter(status for *_, status in ENTRIES) == Counter(observed=23, none_declared=2, not_observable=1, not_checked=1)


def q(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


sql = [
    "-- Full first-post resource census for 2025 In-Hand. External destinations were not opened.",
    "PRAGMA foreign_keys = ON;",
    "BEGIN IMMEDIATE;",
    "CREATE TEMP TABLE ih_entry(entry_id INTEGER PRIMARY KEY,title TEXT NOT NULL,wip_url TEXT,listing_status TEXT NOT NULL);",
    "CREATE TEMP TABLE ih_resource(entry_id INTEGER,url TEXT,role TEXT,access_type TEXT,label TEXT,context TEXT,PRIMARY KEY(entry_id,url));",
]
for entry_id, title, thread_id, status in ENTRIES:
    wip = f"https://boardgamegeek.com/thread/{thread_id}" if thread_id else None
    sql.append(f"INSERT INTO ih_entry VALUES({entry_id},{q(title)},{q(wip)},{q(status)});")
for row in RESOURCES:
    sql.append("INSERT INTO ih_resource VALUES(" + ",".join(q(v) for v in row) + ");")

sql += [
    f"UPDATE entries SET wip_thread_url=(SELECT wip_url FROM ih_entry i WHERE i.entry_id=entries.id) WHERE contest_id={CONTEST_ID};",
    f"DELETE FROM entry_resource_scans WHERE checked_at={q(DATE)} AND entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
    f"INSERT INTO entry_resource_scans(entry_id,checked_at,source_url,wip_status,resource_listing_status,notes) SELECT entry_id,{q(DATE)},COALESCE(wip_url,'https://boardgamegeek.com/thread/3378403/2025-in-hand-game-design-contest'),CASE WHEN wip_url IS NULL THEN 'not_found' ELSE 'found' END,listing_status,CASE listing_status WHEN 'observed' THEN 'Primo post renderizzato: anchor, link dinamici e media incorporati censiti; destinazioni non aperte.' WHEN 'none_declared' THEN 'Primo post renderizzato integralmente: nessun collegamento pertinente dichiarato osservato.' WHEN 'not_observable' THEN 'Post originale non osservabile; il primo messaggio residuo segnala un Google link ristretto senza esporne l’URL.' ELSE 'Nessun WIP effettivo individuato dopo verifica del roster ufficiale.' END FROM ih_entry;",
    "INSERT OR IGNORE INTO remote_resources(game_id,kind,access_type,url,host,label,version_raw,availability_status,first_seen_at,last_verified_at) SELECT e.game_id,r.role,r.access_type,r.url," +
    "CASE WHEN instr(substr(r.url,instr(r.url,'//')+2),'/')>0 THEN substr(substr(r.url,instr(r.url,'//')+2),1,instr(substr(r.url,instr(r.url,'//')+2),'/')-1) ELSE substr(r.url,instr(r.url,'//')+2) END,r.label,NULL,'unknown','2026-09-11','2026-09-11' FROM ih_resource r JOIN entries e ON e.id=r.entry_id;",
    "UPDATE remote_resources SET kind=(SELECT r.role FROM ih_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),access_type=(SELECT r.access_type FROM ih_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),label=(SELECT r.label FROM ih_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url),last_verified_at='2026-09-11' WHERE EXISTS(SELECT 1 FROM ih_resource r JOIN entries e ON e.id=r.entry_id WHERE e.game_id=remote_resources.game_id AND r.url=remote_resources.url);",
    f"DELETE FROM entry_resource_mentions WHERE entry_id IN (SELECT id FROM entries WHERE contest_id={CONTEST_ID});",
    "INSERT INTO entry_resource_mentions(entry_id,remote_resource_id,source_url,label_raw,content_role,is_primary,first_seen_at,last_seen_at) SELECT r.entry_id,rr.id,i.wip_url,r.label,r.role,CASE WHEN r.role='game_files' THEN 1 ELSE 0 END,'2026-09-11','2026-09-11' FROM ih_resource r JOIN ih_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url;",
    "INSERT INTO remote_resource_observations(remote_resource_id,observed_at,evidence_url,observation_kind,availability_status,version_raw,notes) SELECT rr.id,'2026-09-11',i.wip_url,'declared_in_wip','not_checked',NULL,'Dichiarata nel primo post BGG; destinazione non aperta. Contesto: '||r.context||' Classificazione funzionale e tecnica provvisoria fino alla revisione completa del 2025.' FROM ih_resource r JOIN ih_entry i ON i.entry_id=r.entry_id JOIN entries e ON e.id=r.entry_id JOIN remote_resources rr ON rr.game_id=e.game_id AND rr.url=r.url WHERE NOT EXISTS(SELECT 1 FROM remote_resource_observations o WHERE o.remote_resource_id=rr.id AND o.observed_at='2026-09-11' AND o.evidence_url=i.wip_url AND o.observation_kind='declared_in_wip');",
    "DROP TABLE ih_resource;",
    "DROP TABLE ih_entry;",
    "COMMIT;",
]
(ROOT / "catalog" / "2025-in-hand-wips-resources.sql").write_text("\n".join(sql) + "\n", encoding="utf-8")

counts = Counter(entry_id for entry_id, *_ in RESOURCES)
entry_by_id = {entry_id: (title, thread_id, status) for entry_id, title, thread_id, status in ENTRIES}
md = [
    "# WIP e risorse dichiarate — In-Hand 2025",
    "",
    "Verifica dell’11 settembre 2026 sui primi post renderizzati dei 26 WIP individuati. Sono stati estratti anchor ordinari, collegamenti BGG dinamici e media incorporati senza aprire le destinazioni esterne. La classificazione resta provvisoria fino al confronto di tutti i contest 2025.",
    "",
    "| # | Entry | Stato WIP/risorse | Risorse distinte |",
    "|---:|---|---|---:|",
]
for index, (entry_id, title, thread_id, status) in enumerate(ENTRIES, 1):
    label = {"observed": "risorse osservate", "none_declared": "nessuna risorsa dichiarata", "not_observable": "risorse non osservabili", "not_checked": "WIP non individuato"}[status]
    md.append(f"| {index} | {title} | {label} | {counts[entry_id]} |")
md += ["", "## Risorse", "", "| Entry | Etichetta originale | Contesto osservato | Funzione provvisoria | Forma tecnica | Dominio | URL |", "|---|---|---|---|---|---|---|"]
for entry_id, url, role, form, label, context in RESOURCES:
    title = entry_by_id[entry_id][0]
    host = urlparse(url).netloc
    clean = lambda text: text.replace("|", "/").replace("\n", " ")
    md.append(f"| {clean(title)} | {clean(label)} | {clean(context)} | `{role}` | `{form}` | `{host}` | {url} |")
md += [
    "",
    "## Esclusioni e casistiche",
    "",
    "- Esclusi profili, immagini decorative, collegamenti di navigazione, riferimenti ai giochi d’ispirazione e pagine generiche non dichiarate come risorse del gioco.",
    "- Esclusi i collegamenti automatici ai canali YouTube; conservati i singoli video incorporati.",
    "- URL duplicati nella stessa entry accorpati, preservando il significato nell’etichetta e nel contesto.",
    "- I `gg-item-link` con destinazione cancellata, vuoti o relativi al contest/autori/opere citate non sono risorse del gioco.",
    "- `Black Market`: post originale non osservabile; il primo messaggio residuo segnala un Google link ristretto ma non ne espone l’URL. Nessuna assenza o risorsa remota è inventata.",
    "- `Starcrossed`: la canzone didattica su Suno è classificata provvisoriamente come `video`/`web_app`, in attesa del consolidamento tassonomico annuale.",
    "",
    "## Totali",
    "",
    "- 27 entry coperte: 26 WIP individuati e aperti direttamente, 1 entry senza WIP (`Duel: Clash of Metal`).",
    "- 23 WIP con almeno una risorsa dichiarata.",
    "- 2 WIP senza collegamenti pertinenti osservati nel primo post (`Hellheim In-Hand Duel`, `Dreadspire Keep`).",
    "- 1 WIP con risorse non osservabili perché il post originale non è disponibile (`Black Market`).",
    "- 63 risorse remote distinte.",
    "- Disponibilità esterna non verificata e nessun file scaricato.",
]
(ROOT / "sources" / "2025-IN-HAND-WIPS-RESOURCES.md").write_text("\n".join(md) + "\n", encoding="utf-8")

print(f"generated {len(RESOURCES)} resources for {len(ENTRIES)} entries")
