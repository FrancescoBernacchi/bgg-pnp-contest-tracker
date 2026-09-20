from pathlib import Path


SOURCE = "https://boardgamegeek.com/geeklist/332839/2024-solomode-design-contest-submissions"
OUT = Path(__file__).with_name("2024-solomode-entries.sql")

# position, item id, canonical variant title, raw heading, submitter, WIP URL
ROWS = [
    (1,10562052,"Medina (Second Edition) Solomode","[2024 solomode] Medina (Second Edition) solomode","KarenSDR","https://boardgamegeek.com/thread/3257849/2024-solomode-medina-second-edition-solomode"),
    (2,10574444,"Coffee Rush Solo Mode","[2024 Solomode] SOLO MODE for Coffee Rush","RioMusicShow","https://boardgamegeek.com/thread/3244337/2024-solomode-solo-mode-for-coffee-rush"),
    (3,10596502,"Adventurous Indiana","[2024 Solomode] \"Adventurous Indiana\" for Artifacts Inc","theodoreh","https://boardgamegeek.com/thread/3264548/2024-solomode-adventurous-indiana-for-artifacts-in"),
    (4,10608244,"The Council of Naqala","[2024 Solomode] Five Tribes The Council of Naqala v1","Senno","https://boardgamegeek.com/thread/3267665/2024-solomode-five-tribes-the-council-of-naqala-v1"),
    (5,10615966,"Autopirate","[2024 Solomode] Autopirate: Solomode for Ahoy","RPMgamer","https://boardgamegeek.com/thread/3269468/2024-solomode-autopirate-solomode-for-ahoy"),
    (6,10626794,"Ragtag Rescuers","[2024 Solomode] Ragtag Rescuers - A MLEM: Space Agency Solo Mode","gastricsparrow","https://boardgamegeek.com/thread/3272588/2024-solomode-ragtag-rescuers-a-mlem-space-agency"),
    (7,10649936,"Keyforge Adventures: Escape from Selva Oscura","[2024 Solomode] Keyforge Adventures: Escape from Selva Oscura - Work in Progress","KintsugiGames","https://boardgamegeek.com/thread/3278092/2024-solomode-keyforge-adventures-escape-from-selv"),
    (8,10679123,"Tritone Solo Mode","[2024 Solomode] Tritone Solo Mode","boardgame_snowman","https://boardgamegeek.com/thread/3283558/2024-solomode-tritone-solo-mode"),
    (9,10680913,"Cat Factor and Bee Market","[2024 Solomode] Cat Factor and Bee Market Variant for Herbaceous","Zooburbia","https://boardgamegeek.com/thread/3283876/2024-solomode-cat-factor-and-bee-market-variant-fo"),
    (10,10683341,"Frankly Simple Vikings SoloBot","Frankly Simple Vikings SoloBot","cabbagekingaf","https://boardgamegeek.com/thread/3284241/frankly-simple-vikings-solobot"),
    (11,10696638,"STARDUST","[Mode solo 2024] STARDUST - INVADERS SOLO MODE WITH CDG SOLO SYSTEM & AUTOMATON - V1","thierry2015","https://boardgamegeek.com/thread/3287913/mode-solo-2024-stardust-invaders-solo-mode-with-cd"),
    (12,10698197,"Non-Player Racers","[2024 Solomode] Non-Player Racers","barklam","https://boardgamegeek.com/thread/3288299/2024-solomode-non-player-racers"),
    (13,10698644,"Autosaurs!","[2024 Solomode] Autosaurs! Add automated players to EVO for solo play","barklam","https://boardgamegeek.com/thread/3288438/2024-solomode-autosaurs-add-automated-players-to-e"),
    (14,10700511,"Carcassonne against Jacques","[2024 Solomode] Carcassonne against Jacques","anke1","https://boardgamegeek.com/thread/3288753/2024-solomode-carcassonne-against-jacques"),
    (15,10705791,"Simple Six","Simple Six Solomode for Rainforest City","cabbagekingaf","https://boardgamegeek.com/thread/3123687/simple-six-solomode-for-rainforest-city"),
    (16,10707632,"Capek","[2024 Solomode] Capek","kukn","https://boardgamegeek.com/thread/3290545/2024-solomode-capek"),
    (17,10708094,"Sea Salt and Solo","[2024 Solomode] Sea Salt and Solo","bysshe","https://boardgamegeek.com/thread/3171959/2024-solomode-sea-salt-and-solo"),
    (18,10708399,"Compact Mahjong Solo Variant","[2024 Solomode] Compact Mahjong solo variant, only 50 tiles needed!","JB78NJ","https://boardgamegeek.com/thread/3290793/2024-solomode-compact-mahjong-solo-variant-only-50"),
    (19,10714337,"Harmonies: Solo Scenarios","[2024 Solomode] Harmonies - solo scenarios","lovelace","https://boardgamegeek.com/thread/3286220/2024-solomode-harmonies-solo-scenarios"),
    (20,10727419,"Solo Shuffle","[2024 Solomode] Solo Shuffle - A scenario based Solomode for a Boardgame I love","Fluegelschlaegerin","https://boardgamegeek.com/thread/3294885/2024-solomode-solo-shuffle-a-scenario-based-solomo"),
    (21,10757162,"Forest Shuffle Automa","[2024 Solomode] Unofficial Solo Mode Contest Entry","dukefanblue2005","https://boardgamegeek.com/thread/3299926/2024-solomode-unofficial-solo-mode-contest-entry"),
    (22,10757170,"Harmonies: Steve Automa","[2024 Solomode] Unofficial Solo Mode Contest Entry","dukefanblue2005","https://boardgamegeek.com/thread/3299923/2024-solomode-unofficial-solo-mode-contest-entry"),
    (23,10758225,"Captain Blackwhisker","[2024 Solomode] Captain Blackwhisker - the pirat bot","Angelcollector","https://boardgamegeek.com/thread/3244422/2024-solomode-captain-blackwhisker-the-pirat-bot"),
    (24,10760185,"Neobot","Neotopia - Unofficial Solo Mode against the Neobot","Billard4ever","https://boardgamegeek.com/thread/3300684/neotopia-unofficial-solo-mode-against-the-neobot"),
    (25,10760561,"Breeze","[2024 Solomode] Breeze","michieldewit","https://boardgamegeek.com/thread/3282756/2024-solomode-breeze"),
    (26,10762079,"My Octobot Teacher","[2024 Solomode] My Octobot Teacher: Unofficial Solomode for Kelp","RPMgamer","https://boardgamegeek.com/thread/3301073/2024-solomode-my-octobot-teacher-unofficial-solomo"),
    (27,10763611,"Borgo Automa","[2024 Solomode] Borgo automa for The New Era solo play","OlegKlishin","https://boardgamegeek.com/thread/3301392/2024-solomode-borgo-automa-for-the-new-era-solo-pl"),
    (28,10764341,"Autohunters","[2024 Solomode] Autohunters - a lightweight solo mode for Beast","edvinus","https://boardgamegeek.com/thread/3301580/2024-solomode-autohunters-a-lightweight-solo-mode"),
]


def q(value):
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


lines = [
    "-- Censimento annuale 2024: Solomode Design Contest.",
    "-- Fonte: GeekList ufficiale 332839, 28 entry su due pagine.",
    "-- Verifica 2026-09-19; nessuna analisi di WIP, risorse o materiali.",
    "BEGIN IMMEDIATE;",
    "UPDATE contests SET treatment_profile='dependent_variants', entries_url=" + q(SOURCE) + ", last_verified_at='2026-09-19' WHERE id=290;",
    "INSERT INTO contest_checks (id,contest_id,checked_at,source_url,check_kind,outcome,notes) VALUES (50,290,'2026-09-19'," + q(SOURCE) + ",'manual_web_census','complete','Snapshot completo delle 28 entry numerate nella GeekList ufficiale, pagine 1 e 2.');",
    "INSERT INTO games (id,canonical_title,status_raw,status_normalized,status_evidence,source_url,first_seen_at,last_verified_at) VALUES",
]

game_values = []
entry_values = []
for offset, (position, item_id, title, raw, username, wip) in enumerate(ROWS):
    game_id = 859 + offset
    game_values.append(
        f"  ({game_id},{q(title)},'Listed in official roster','contest_complete','Official GeekList roster',{q(wip)},'2026-09-19','2026-09-19')"
    )
    entry_url = f"{SOURCE}?itemid={item_id}#{item_id}"
    entry_values.append(
        f"  ({game_id},290,{game_id},332839,{item_id},{position},{q(wip)},{q(entry_url)},{q(raw + '; submitter: ' + username)},"
        "'Listed in official roster','contest_complete','unknown','dependent_variant','required','2026-09-19','2026-09-19')"
    )

lines.append(",\n".join(game_values) + ";")
lines.extend([
    "INSERT INTO entries (id,contest_id,game_id,geeklist_id,geeklist_item_id,position,wip_thread_url,entry_url,entry_text_raw,status_raw,status_normalized,materials_status_normalized,entry_kind,base_game_dependency,first_seen_at,last_verified_at) VALUES",
    ",\n".join(entry_values) + ";",
    "INSERT INTO entry_status_history (entry_id,check_id,status_raw,status_normalized,materials_status_normalized,position,observed_at,source_url,confidence,notes)",
    "SELECT id,50,status_raw,status_normalized,'unknown',position,'2026-09-19'," + q(SOURCE) + ",'high','Snapshot completo della GeekList ufficiale; nessuna analisi di WIP, risorse o materiali.' FROM entries WHERE contest_id=290;",
    "COMMIT;",
    "",
])

OUT.write_text("\n".join(lines), encoding="utf-8")
print(f"Generated {OUT} with {len(ROWS)} entries")
