"""Genera il manifest verificabile del secondo lotto Children & Family 2025."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LIBRARY = ROOT / "library"
OUTPUT = ROOT / "catalog" / "2025_children_family_remaining_acquisition_batch_2026-10-03.json"

FILES = {
    "the-robots-are-multiplying": ("The Robots are Multiplying", 149, {
        "Printing Instructions (Google Docs export).pdf": "https://docs.google.com/document/d/1fvVp14-oqpjID3SazOYlaVxjibXO7m2P_nrkuxjegvI/export?format=pdf",
        "The Robots are Multiplying - Low Ink Cards - v3.pdf": "https://drive.usercontent.google.com/download?id=12wQonbwND4T2S0kTPk--Xd5hyxKbQYG9&export=download",
        "The Robots are Multiplying - optional player boards.pdf": "https://drive.usercontent.google.com/download?id=1ZlRicQ2lEbP-PhjEDza7Cji595BGsX4X&export=download",
        "The Robots are Multiplying - Rules v3.pdf": "https://drive.usercontent.google.com/download?id=1V4yWqjrGOjCrmNz7IlOwNQZlta0Vi6D4&export=download",
        "The Robots are Multiplying v3 - Cards.pdf": "https://drive.usercontent.google.com/download?id=1IkiDJUFqTKbxOtlKbUhY685pxQ8kmwxY&export=download",
    }),
    "isles-of-odd": ("Isles of Odd", 153, {"printandplaydecember1.pdf": "https://drive.usercontent.google.com/download?id=1QV67KqnJyp19SDXqTODdKsEqYcKjhu_9&export=download"}),
    "peng-wins": ("Peng Wins!", 155, {"Peng Wins!.pdf": "https://drive.usercontent.google.com/download?id=1bRMFKYviShqv89N87QyNnt7lRdQ-8W-&export=download"}),
    "slowpoke": ("Slowpoke", 158, {
        "Print and Play Draft 1.pdf": "https://drive.usercontent.google.com/download?id=12AXUphcMbo-hvtUcZoINTq5XCzDWC_jR&export=download",
        "Slowpoke Rulebook Draft 5.0 (Google Docs export).pdf": "https://docs.google.com/document/d/1_FmmwcxoPLaWpXbDO3aYw6E3HKSgiaE9sLTw3y7LcEg/export?format=pdf",
    }),
    "sorry-thats-my-dungeon": ("Sorry! That's My Dungeon", 160, {"Sorry! That's my Dungeon! - EN - Board letter.pdf": "https://alexandrecamargo.itch.io/sorry-thats-my-dungeon/file/12047983"}),
    "ice-cream-heist": ("Ice Cream Heist", 161, {"Ice Cream Heist v0.1 150425.pdf": "https://drive.usercontent.google.com/download?id=1GSt_M8-XqkeBxKNrlGLkpjXe1PcROe6q&export=download"}),
    "poker-face": ("Poker Face", None, {
        "Ver. 1.0 - Cards - Poker Face.pdf": (162, "https://drive.usercontent.google.com/download?id=1Qj7zr1IJVQeR8zsvkRhlZzry5e5QA1ZU&export=download"),
        "Ver. 1.0 - Rulebook - Poker Face.pdf": (163, "https://drive.usercontent.google.com/download?id=1wTMUUwAJsTuvdoPhRyUFv3uhjf1Z0kCW&export=download"),
    }),
    "squirelly": ("Squirelly", 164, {
        "Even More Squirrelly, Tuckbox, v1- 2025.6.10.pdf": "https://drive.usercontent.google.com/download?id=14EMwzN6RsQr0loMFHRCWOIm-veowH80j&export=download",
        "More Squirrelly, Tuckbox, v1- 2025.6.10.pdf": "https://drive.usercontent.google.com/download?id=1VhAhSsxaZKiwx26cD47Lz0V7fPT9dBjq&export=download",
        "Squirrelly- Even More Squirrelly Mini Expansion- 6th Player and New Critters- 2025.6.9.pdf": "https://drive.usercontent.google.com/download?id=1V80dzuMdg_d6Cj4MAKmVKxqqEp-dEFBs&export=download",
        "Squirrelly- More Squirrelly Mini Expansion- 5th Player and Wild Squirrels- 2025.6.9.pdf": "https://drive.usercontent.google.com/download?id=1P4o6m0zd81bjyAxI3EIRBLY_YD0et8jC&export=download",
        "Squirrelly- Tuckbox, v4- 2025.6.12.pdf": "https://drive.usercontent.google.com/download?id=13zI3ZOM-_yydnK5zt1tsUJDW2TcxDC6G&export=download",
        "Squirrelly, v3- 54 Card PNP- 2025.4.26.pdf": "https://drive.usercontent.google.com/download?id=1H2kQY35XDLLumboiSKP96Zc86s5FW1p2&export=download",
        "Squirrelly, v3- PNP- 2025.2.20.pdf": "https://drive.usercontent.google.com/download?id=11GRND7KawqhPa_warXyRjriE5QY5GjfY&export=download",
        "Squirrelly, v7- PC-Rulebook- 2025.6.9.pdf": "https://drive.usercontent.google.com/download?id=1bZGb29Nn8Rnx1CXSQ87m_9m32g_V047B&export=download",
    }),
    "submarine-adventure": ("Submarine Adventure", None, {
        "Submarine Adventure Rules.pdf": (166, "https://drive.usercontent.google.com/download?id=1lZPFrQDFS3If4WwXilJzEGLMyvP-zb1l&export=download"),
        "Submarine Adventure Components.pdf": (167, "https://drive.usercontent.google.com/download?id=1dw99YPj1fTMPgv0goPQhog1k4cEREwVS&export=download"),
    }),
    "mermaids-vs-dinosaurs": ("Mermaids vs Dinosaurs", None, {
        "Mermaids vs Dinosaur cards.pdf": (170, "https://drive.usercontent.google.com/download?id=1-6Q7-8iOmt-aCuZGhxWCgjrkLiEFTnyI&export=download"),
        "Mermaids v Dinosaur board.pdf": (170, "https://drive.usercontent.google.com/download?id=1zHxkguwZgtUnMb9008wHiKWwf0Hn4bv6&export=download"),
        "Mermaids vs Dinosaur (Google Docs export).pdf": (171, "https://docs.google.com/document/d/1c6fbzo61Ytm4uhcFQ5e6CdDhjreeG6WAw2qWq7-C8dI/export?format=pdf"),
    }),
    "allmende": ("Allmende", 174, {
        "Allmende manual.pdf": "https://drive.usercontent.google.com/download?id=1mXig1ugQ4sQRdzErb9BcBNVMu_36vOJv&export=download",
        "Allmende -hidden roles color.pdf": "https://drive.usercontent.google.com/download?id=1PaJCLQt1teReWnfRL0THsfPqQWY6roSN&export=download",
        "Allmende 1.0 color.pdf": "https://drive.usercontent.google.com/download?id=1lx1qL7zYysRGWqwWRmD69rgxKdx7xS3I&export=download",
        "Allmende 1.0 printer friendly.pdf": "https://drive.usercontent.google.com/download?id=1HAn6lP5jBHfdqhwVS75GEv4XXsl5N9rp&export=download",
        "Allmende -hidden roles printer friendly.pdf": "https://drive.usercontent.google.com/download?id=1g3R7hGe7oZAJM4UQAlIEaMlYGSLkZcFV&export=download",
    }),
    "panic-picasso": ("Panic Picasso!", None, {
        "Panic Picasso Prompt Cards and Points Tokens.pdf": (184, "https://drive.usercontent.google.com/download?id=1HHJbCYuzNm1oHWrc4CWZ5TujdowJ-J5A&export=download"),
        "Panic Picasso Rulebook.pdf": (185, "https://drive.usercontent.google.com/download?id=1TGqPBrOt_SQp5kUGPQTyePEWfowrfh4j&export=download"),
    }),
}

RESOURCE_URLS = {
    148: "https://boardgamegeek.com/thread/3388261/official-game-presentation-plus-pnp-files-plus-lin",
    149: "https://drive.google.com/drive/folders/1U-jwn9MmxArfXS0AIxniqI4YrvODVSMI?usp=sharing",
    151: "https://www.canva.com/design/DAGTfqleqFM/SxYu95Fk4CYd4ysiaIp4XA/view",
    153: "https://drive.google.com/drive/folders/1kAb6ps0BxrFo8lwEMrDMmSPUiw0DQAHU?usp=drive_link",
    155: "https://drive.google.com/file/d/1bRMFKYviShqv89N87QyNnt7lRdQ-8W-_/view?usp=sharing",
    156: "https://linktr.ee/slowpokegame", 157: "https://docs.google.com/document/d/1_FmmwcxoPLaWpXbDO3aYw6E3HKSgiaE9sLTw3y7LcEg/edit?usp=sharing",
    158: "https://drive.google.com/file/d/12AXUphcMbo-hvtUcZoINTq5XCzDWC_jR/view?usp=sharing",
    159: "https://romab.itch.io/origami-champions/download/svnyZKTYODY1ygzXw1qLZ4zbdh_2TgcJTYMd8bG6",
    160: "https://alexandrecamargo.itch.io/sorry-thats-my-dungeon", 161: "https://drive.google.com/drive/folders/1wwt9avcEXb89YQdJImyHXqvnaXqg_IY7?usp=drive_link",
    162: "https://drive.google.com/file/d/1Qj7zr1IJVQeR8zsvkRhlZzry5e5QA1ZU/view?usp=drive_link", 163: "https://drive.google.com/file/d/1wTMUUwAJsTuvdoPhRyUFv3uhjf1Z0kCW/view?usp=drive_link",
    164: "https://drive.google.com/drive/folders/1LGdbkZj3mrqKiAkhXjFldlG6tCJZueF4?usp=sharing", 166: "https://drive.google.com/file/d/1lZPFrQDFS3If4WwXilJzEGLMyvP-zb1l/view?usp=sharing",
    167: "https://drive.google.com/file/d/1dw99YPj1fTMPgv0goPQhog1k4cEREwVS/view?usp=sharing", 169: "https://drive.google.com/drive/folders/1XhMiXjWg6244O21QTQN7mFfk9fTTP_a7?usp=sharing",
    170: "https://drive.google.com/drive/folders/1zGPcGn3RqjxIoeSYFUSMms_lsTHQpeHH?usp=sharing", 171: "https://docs.google.com/document/d/1c6fbzo61Ytm4uhcFQ5e6CdDhjreeG6WAw2qWq7-C8dI/edit?usp=sharing",
    174: "https://drive.google.com/drive/folders/https://drive.google.com/drive/folders/1SPvqNnKXTlV3Y3YI04zA-Ydpmwyr4ied?usp=sharing", 179: "https://rollingolem.wordpress.com/197-2/",
    183: "https://scobblehog-press.itch.io/crab-boil-a-print-play-crab-battle-boardgame", 184: "https://drive.google.com/file/d/1HHJbCYuzNm1oHWrc4CWZ5TujdowJ-J5A/view?usp=drive_link",
    185: "https://drive.google.com/file/d/1TGqPBrOt_SQp5kUGPQTyePEWfowrfh4j/view?usp=drive_link", 186: "https://docs.google.com/document/d/1hEfypoqizHyDm_A7EMcFqt48qQaH1PgfhrYPjpGJ_x4/edit?usp=sharing",
    187: "https://drive.google.com/drive/folders/1GZelx-0nKt2PlI8JFyRhgWWSj0D03oB5?usp=sharing",
}

OBS = {
    148: ("unknown", "Il WIP BGG non era osservabile per la verifica Cloudflare; nessun file acquisito."),
    149: ("available", "Cartella pubblica accessibile; acquisiti quattro PDF e le istruzioni di stampa esportate in PDF."),
    151: ("available", "Regolamento Canva osservabile in sola lettura; nessun originale scaricabile esposto."), 153: ("available", "Cartella pubblica accessibile; acquisito il PDF PnP."),
    155: ("available", "PDF pubblico di componenti e regole acquisito."), 156: ("available", "Pagina Linktree osservata; nessun ulteriore materiale scaricabile oltre ai collegamenti già censiti."),
    157: ("available", "Regolamento Google Docs esportato in PDF."), 158: ("available", "PDF PnP pubblico acquisito."),
    159: ("access_restricted", "Il token dichiarato reindirizza a un login Itch e a un progetto differente; nessun login effettuato."),
    160: ("available", "Pagina e download gratuiti osservabili; acquisito un PDF inglese, altri tre download inglesi bloccati dal limite tecnico Itch della sessione."),
    161: ("available", "Cartella pubblica accessibile; acquisito il PDF corrente."), 162: ("available", "PDF carte acquisito."), 163: ("available", "PDF regolamento acquisito."),
    164: ("available", "Cartella pubblica accessibile; acquisiti otto PDF correnti, esclusi archivio, sell sheet e TTS."),
    166: ("available", "PDF regolamento acquisito."), 167: ("available", "PDF componenti acquisito."), 169: ("unavailable", "La cartella Google Drive restituisce 404."),
    170: ("available", "Cartella pubblica accessibile; acquisiti carte e tabellone."), 171: ("available", "Regolamento Google Docs esportato in PDF."),
    174: ("available", "URL BGG malformato corretto isolando il secondo URL Drive; acquisiti cinque PDF correnti."),
    179: ("available", "Pagina progetto osservabile; i due collegamenti Drive esposti restituiscono 404 al download."),
    183: ("available", "Pagina Itch e quattro file gratuiti osservabili; download non avviabile per limite tecnico Itch della sessione."),
    184: ("available", "PDF carte e segnalini acquisito."), 185: ("available", "PDF regolamento acquisito."),
    186: ("unavailable", "Il documento Google risulta eliminato."), 187: ("unavailable", "La cartella Google Drive restituisce 404."),
}

OUTCOMES = [
    ("Pets Rescue", "no_resource_declared"), ("Swirls", "not_observable"), ("The Robots are Multiplying", "acquired"),
    ("Potions Master Tournament", "not_observable"), ("Isles of Odd", "acquired_partial_view_only_rulebook"), ("Peng Wins!", "acquired"),
    ("Hex Hive: Skirmish", "no_resource_declared"), ("Slowpoke", "acquired"), ("Origami Champions", "access_restricted"),
    ("Sorry! That's My Dungeon", "acquired_partial_host_limit"), ("Ice Cream Heist", "acquired"), ("Poker Face", "acquired"),
    ("Squirelly", "acquired"), ("Head In The Clouds", "no_resource_declared"), ("Submarine Adventure", "acquired"),
    ("Island of Peril", "unavailable"), ("Mermaids vs Dinosaurs", "acquired"), ("Allmende", "acquired"),
    ("Bon-Bon", "unavailable_downloads"), ("Crab Boil", "host_limit"), ("Panic Picasso!", "acquired"),
    ("Guesstrictions", "no_resource_declared"), ("Amusement park - Clashes", "unavailable"),
]


def build() -> dict:
    items = []
    for slug, (title, default_resource, names) in FILES.items():
        for name, destination in names.items():
            resource_id, final_url = destination if isinstance(destination, tuple) else (default_resource, destination)
            path = Path("bgg") / "2025-children-family" / slug / "originals" / name
            data = (LIBRARY / path).read_bytes()
            if not data.startswith(b"%PDF-"):
                raise ValueError(f"Not a PDF: {path}")
            items.append({
                "game_title": title, "remote_resource_id": resource_id, "resource_url": RESOURCE_URLS[resource_id],
                "final_url": final_url, "original_filename": name, "relative_path": path.as_posix(),
                "media_type": "application/pdf", "language_code": "en", "byte_size": len(data),
                "sha256": hashlib.sha256(data).hexdigest(), "version_raw": "current file observed 2026-10-03",
                "selection_reason": "Completamento dell'acquisizione per tutte le altre entry del contest",
                "usage_conditions": "Risorsa pubblica dichiarata nel contesto BGG; copia locale per uso personale esclusivo; nessuna redistribuzione",
                "status": "acquired",
            })
    return {
        "batch_key": "bgg-2025-children-family-2026-10-03-02", "contest": "2025 Children & Family Game Design Contest",
        "approved_at": "2026-10-03", "acquired_at": "2026-10-03", "purpose": "Uso personale esclusivo; nessuna redistribuzione o derivato",
        "selection": "Tutte le 23 entry non comprese nel primo lotto dei vincitori", "items": items,
        "resource_observations": [{"remote_resource_id": rid, "evidence_url": RESOURCE_URLS[rid], "availability_status": status, "version_raw": None, "notes": notes} for rid, (status, notes) in OBS.items()],
        "entry_outcomes": [{"game_title": title, "outcome": outcome} for title, outcome in OUTCOMES],
        "excluded_materials": ["Tabletop Simulator, Tabletopia e altre implementazioni online", "video", "archivi storici e sell sheet", "varianti PT-BR di Sorry! That's My Dungeon"],
    }


if __name__ == "__main__":
    OUTPUT.write_text(json.dumps(build(), ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(OUTPUT)
