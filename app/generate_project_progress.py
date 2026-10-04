#!/usr/bin/env python3
"""Aggiorna le viste annuali generate in PROJECT_PROGRESS.md dal database locale."""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
from collections import defaultdict
from pathlib import Path
from work_progress import enrich_work_progress


START_MARKER = "<!-- BEGIN GENERATED ANNUAL PROGRESS -->"
END_MARKER = "<!-- END GENERATED ANNUAL PROGRESS -->"
EMPTY_CELL = "\u00a0"
GLOBAL_CENSUS_FIRST_YEAR = 2008
GLOBAL_CENSUS_LAST_YEAR = 2026
SUMMARY_YEAR_BLOCK_SIZE = 4
DETAIL_CONTEST_BLOCK_SIZE = 6


def challenge_titles() -> dict[int, list[str]]:
    months = ["January", "February", "March", "April", "May", "June",
              "July", "August", "September", "October", "November", "December"]
    result = {
        2012: [f"{month} 2012 — 24 Hour Game Design Contest"
               for month in ("June", "July", "August", "October", "November", "December")],
        2013: [f"{month} 2013 — 24 Hour Game Design Contest" for month in months],
        2014: [f"{month} 2014 — 24 Hour Game Design Contest" for month in months],
        2015: [f"{month} 2015 — 24 Hour Game Design Contest" for month in months],
    }
    themes = {
        2016: "food beverages attention Atlantis six kitten moon-landing wedding divorce pasta music charcoal",
        2017: "discipline honey march puns gold nightfall book procrastination island toy solo reindeer",
        2018: "hope technique rune egg delay queen heat clown bunny eight leaf rod",
        2019: "pitchfork bureaucracy mask electronics bug miniature sun tag school spirit parody frost",
        2020: "eccentric palindrome crown home heart beaver dam hoover orc family advent",
    }
    for year, values in themes.items():
        used_months = months if year != 2020 else [month for month in months if month != "September"]
        result[year] = [f"{month} {year} — 24 Hour Game Design Contest ({theme.replace('-', ' ')})"
                        for month, theme in zip(used_months, values.split())]
    result[2023] = [
        "January 2023 — 24 Hour Design Challenge (Temperature)", "February 2023 — 24 Hour Design Challenge (Outfit)",
        "March 2023 — 24 Hour Design Challenge (Fence)", "April 2023 — 24 Hour Design Challenge (Terminal)",
        "May 2023 — 24 Hour Design Challenge (Leftover)", "June 2023 — 24 Hour Design Challenge (Lobby)",
        "July 2023 — 24 Hour Design Challenge (Host)", "September–October 2023 — 24 Hour Design Challenge (Scatter)",
        "November–December 2023 — 24 Hour Design Challenge (Order)",
    ]
    result[2024] = [f"{period} 2024 — 24 Hour Design Challenge ({theme})" for period, theme in
                    [("January–February", "Jam"), ("March–April", "Three"), ("May–June", "Party"),
                     ("July–August", "Rome"), ("September–October", "Trick"), ("November–December", "Letter")]]
    result[2025] = [f"{period} 2025 — 24 Hour Design Challenge ({theme})" for period, theme in
                    [("January–February", "GUARD"), ("March–April", "REVEAL"), ("May–June", "GREEN"),
                     ("July–August", "PAD"), ("September–October", "PATCH"), ("November–December", "_ _ _ ANKS")]]
    result[2026] = [f"{period} 2026 — 24 Hour Design Challenge ({theme})" for period, theme in
                    [("January–February", "CULTURE"), ("March–April", "CLASSIC"), ("May–June", "STICK"),
                     ("July–August", "DRAW"), ("September–October", "NINE")]]
    return result


def normalized_contest_name(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", re.sub(r"\b20\d{2}\b", "", value.casefold()))


def escape_cell(value: object) -> str:
    return str(value).replace("|", "\\|").replace("\r", " ").replace("\n", " ")


def markdown_link(label: object, url: object) -> str:
    text = escape_cell(label).replace("[", "\\[").replace("]", "\\]")
    target = str(url or "").strip().replace(" ", "%20").replace("(", "%28").replace(")", "%29")
    return f"[{text}]({target})" if target else text


def short_entry_title(value: object) -> str:
    """Riduce un titolo WIP descrittivo a un nome breve per la sola visualizzazione."""
    original = str(value).strip()
    descriptive = bool(re.search(
        r"(?:\bwip\b|20\d{2}.*contest|components?\s+(?:available|ready)|playtest\s+ready)",
        original, flags=re.IGNORECASE,
    ))
    title = original
    title = re.sub(r"^\s*(?:\[[^\]]+\]\s*)+", "", title)
    title = re.sub(
        r"^\s*\((?:[^)]*(?:wip|playtest|component|contest|ready)[^)]*)\)\s*",
        "", title, flags=re.IGNORECASE,
    )
    title = re.sub(r"^\s*wip\s*[:}\]-]*\s*", "", title, flags=re.IGNORECASE)
    title = re.sub(r"\s*\[[^\]]+\]\s*", " ", title)
    title = re.split(r"\s+\|\s+|\s+--+\s+", title, maxsplit=1)[0]
    title = re.sub(r"\s+[-–—]\s+.*$", "", title)
    title = re.sub(
        r"\s+\((?:[^)]*(?:20\d{2}|contest|submission|component|ready)[^)]*)\).*$",
        "", title, flags=re.IGNORECASE,
    )
    if descriptive:
        title = re.sub(r"\s*\(.*$", "", title)
        title = re.sub(r"\s+20\d{2}\s+.*$", "", title, flags=re.IGNORECASE)
        title = re.sub(r",\s+(?:an?\b|the\b|solo\b|entry\b|revised\b|\d).*$", "", title,
                       flags=re.IGNORECASE)
        title = re.sub(
            r":\s+(?=[^:]*\b(?:abstract|card|dice|game|puzzle|roll|solo|strategy|wargame)\b).*$",
            "", title, flags=re.IGNORECASE,
        )
        title = re.sub(r"\s+(?:components?|rules?)\s+(?:available|ready).*$", "", title,
                       flags=re.IGNORECASE)
    title = re.sub(r"\s+", " ", title).strip(" -–—:[]")
    return title or original


def short_status(value: str) -> str:
    labels = {
        "idea": "Idea", "wip": "WIP", "components_available": "Components",
        "playtest_ready": "Playtest", "contest_ready": "Ready",
        "withdrawn": "Withdrawn", "incomplete": "Incomplete",
        "disqualified": "Disqualified",
    }
    return labels.get(value, "")


def choose_main_category(categories: list[tuple[str, int]]) -> str | None:
    """Sceglie una classifica generale riproducibile, privilegiando i piazzamenti."""
    if not categories:
        return None

    def score(item: tuple[str, int]) -> tuple[int, int, str]:
        category, ranked_count = item
        name = category.casefold()
        excluded = ("art", "theme", "rule", "playtest", "designer", "jury")
        if "overall" in name:
            priority = 0
        elif name in {"best game", "main", "grand prize"}:
            priority = 1
        elif "best game" in name:
            priority = 2
        elif any(token in name for token in excluded):
            priority = 5
        else:
            priority = 3
        return priority, -ranked_count, name

    return min(categories, key=score)[0]


def bullet(done: int, total: int, partial: int = 0) -> str:
    if total > 0 and done >= total:
        return "🟢"
    if done > 0 or partial > 0:
        return "🟡"
    return "🔴"


def build_generated_section(db: sqlite3.Connection) -> str:
    db.row_factory = sqlite3.Row
    census_path = Path(__file__).resolve().parents[1] / "catalog" / "bgg_contest_census_titles.json"
    census_titles = {int(year): titles for year, titles in
                     json.loads(census_path.read_text(encoding="utf-8")).items()}
    for year, titles in challenge_titles().items():
        census_titles.setdefault(year, []).extend(titles)
    contests = db.execute(
        """SELECT c.id,c.year,c.name,c.status_normalized,c.source_url,
                  cs.canonical_name,COUNT(e.id) entry_count
           FROM contests c JOIN contest_series cs ON cs.id=c.series_id
           LEFT JOIN entries e ON e.contest_id=c.id GROUP BY c.id
           ORDER BY cs.canonical_name COLLATE NOCASE,c.year"""
    ).fetchall()
    database_years = sorted({r["year"] for r in contests if r["year"] is not None}, reverse=True)
    years = list(range(GLOBAL_CENSUS_LAST_YEAR, GLOBAL_CENSUS_FIRST_YEAR - 1, -1))
    contest_count_by_year = {
        year: sum(1 for contest in contests if contest["year"] == year) for year in years
    }
    series = sorted({r["canonical_name"] for r in contests}, key=str.casefold)
    contest_by_series_year = {(r["canonical_name"], r["year"]): r for r in contests}
    latest_contest_by_series = {
        series_name: max((r for r in contests if r["canonical_name"] == series_name),
                         key=lambda r: (r["year"] or 0, r["id"]))
        for series_name in series
    }

    category_counts: dict[int, list[tuple[str, int]]] = defaultdict(list)
    for row in db.execute(
        """SELECT contest_id,category,SUM(CASE WHEN rank IS NOT NULL THEN 1 ELSE 0 END) ranked
           FROM rankings GROUP BY contest_id,category"""
    ):
        category_counts[row["contest_id"]].append((row["category"], row["ranked"]))

    work = enrich_work_progress(db, [dict(contest_id=c['id'], entry_count=c['entry_count']) for c in contests])
    work_by_id = {c['contest_id']: c for c in work}
    summary: dict[int, dict[str, int | str | None]] = {}
    for contest in contests:
        cid, total = contest["id"], contest["entry_count"]
        full_reads = db.execute(
            """SELECT COUNT(DISTINCT entry_id) FROM entry_material_scans
               WHERE entry_id IN (SELECT id FROM entries WHERE contest_id=?)
               AND coverage_scope='rules_integrated'""", (cid,)
        ).fetchone()[0]
        any_reads = db.execute(
            """SELECT COUNT(DISTINCT entry_id) FROM entry_material_scans
               WHERE entry_id IN (SELECT id FROM entries WHERE contest_id=?)""", (cid,)
        ).fetchone()[0]
        ranking_categories = db.execute(
            "SELECT COUNT(DISTINCT category) FROM rankings WHERE contest_id=?", (cid,)
        ).fetchone()[0]
        downloaded = db.execute(
            """SELECT COUNT(DISTINCT e.id) FROM entries e
               JOIN acquisitions a ON a.game_id=e.game_id
               JOIN acquired_files af ON af.acquisition_id=a.id WHERE e.contest_id=?""", (cid,)
        ).fetchone()[0]
        status_rows = db.execute(
            """SELECT status_normalized,COUNT(*) count FROM entries
               WHERE contest_id=? GROUP BY status_normalized
               ORDER BY count DESC,status_normalized COLLATE NOCASE""", (cid,)
        ).fetchall()
        known_statuses = sum(row["count"] for row in status_rows if row["status_normalized"] != "unknown")
        entry_statuses = ", ".join(f"{row['status_normalized']} {row['count']}" for row in status_rows)
        summary[cid] = dict(total=total, full_reads=full_reads, any_reads=any_reads,
                            ranking_categories=ranking_categories, downloaded=downloaded,
                            known_statuses=known_statuses, entry_statuses=entry_statuses,
                            main_category=choose_main_category(category_counts[cid]))

    lines = [
        START_MARKER,
        "## A. Sintesi immediata per anno",
        "",
        "Le metriche di lavoro coincidono con l'app, separate dagli indicatori di presenza. Censimento entry: contest con roster completo attestato / contest registrati. Classifica: entry con tutte le categorie verificate, incluse assenze esplicite / entry applicabili. Materiali: primo post censito con esito osservabile secondo contratto MAT, regole integrabili successivamente / entry applicabili; acquisizione: tutte le risorse dichiarate acquisite / entry applicabili. Gli esiti non applicabili escono dal denominatore; ignoti e blocchi non completano la fase. Zero entry non significa 100%. Immagini rappresentative: 0%, funzione non implementata. Le sezioni di dettaglio L/D mostrano invece la presenza storica di scansioni/file e non il completamento del lavoro.",
        "",
    ]
    year_blocks = [years[index:index + SUMMARY_YEAR_BLOCK_SIZE]
                   for index in range(0, len(years), SUMMARY_YEAR_BLOCK_SIZE)]
    for block_number, block_years in enumerate(year_blocks, start=1):
        lines.extend([
            f"### Gruppo anni {block_number} di {len(year_blocks)}",
            "",
            "| N. | Tipologia e indicatore | " + " | ".join(map(str, block_years)) + " |",
            "|---:|:---|" + ":---|" * len(block_years),
            f"| {EMPTY_CELL} | {EMPTY_CELL} | "
            + " | ".join(f"**{contest_count_by_year.get(year, 0)} contest nel database**"
                         for year in block_years) + " |",
        ])
        for contest_number, series_name in enumerate(series, start=1):
            if not any((series_name, year) in contest_by_series_year for year in block_years):
                continue
            metrics = {"Stati entry": [], "Censimento entry": [], "Censimento classifica": [],
                       "Censimento materiali": [], "Acquisizione materiali": [], "Acquisizione immagini": []}
            for year in block_years:
                contest = contest_by_series_year.get((series_name, year))
                if contest is None:
                    for cells in metrics.values():
                        cells.append("—")
                    continue
                values = summary[contest["id"]]
                total = int(values["total"])
                is_closed = contest["status_normalized"] in {"complete", "cancelled"}
                entry_icon = "🔴" if total == 0 else ("🟢" if is_closed else "🟡")
                ranking_count = int(values["ranking_categories"])
                reading_icon = bullet(int(values["any_reads"]), total)
                downloaded = int(values["downloaded"])
                known_statuses = int(values["known_statuses"])
                status_icon = "🔴" if known_statuses == 0 else ("🟢" if known_statuses == total else "🟡")
                metrics["Stati entry"].append(f"{status_icon} {escape_cell(values['entry_statuses'])}")
                work_values = work_by_id[contest['id']]
                metrics['Censimento entry'].append(f"{work_values['census_complete_count']}/1 contest attestati · {total} entry")
                for phase, title in [('ranking','Censimento classifica'),('materials','Censimento materiali'),('acquisition','Acquisizione materiali')]:
                    done, denominator = work_values[phase+'_complete_count'], work_values[phase+'_total']
                    ratio = f"{done}/{denominator} · {round(done*100/denominator)}%" if denominator else '— denominatore non disponibile / non applicabile'
                    metrics[title].append(ratio + f" · {work_values[phase+'_not_applicable_count']} N/A · {work_values[phase+'_blocked_count']} bloccate")
                    if work_values[phase+'_partial_count']:
                        metrics[title][-1] += f" · {work_values[phase+'_partial_count']} verifiche parziali"
                    if phase == 'ranking':
                        metrics[title][-1] += f" · {work_values['ranked_entry_count']} entry classificate · {ranking_count} categorie"
                metrics['Acquisizione immagini'].append('0% · non implementata')
            latest_contest = latest_contest_by_series[series_name]
            series_link = markdown_link(series_name, latest_contest["source_url"])
            lines.append(f"| {contest_number} | **{series_link}** | "
                         + " | ".join(EMPTY_CELL for _ in block_years) + " |")
            for metric, cells in metrics.items():
                label = "\u00a0\u00a0\u00a0\u00a0" + metric
                lines.append(f"| {EMPTY_CELL} | {label} | " + " | ".join(cells) + " |")
        lines.append("")

    lines.extend(["", "## B. Dettaglio delle entry per anno", "",
                  "Per ogni entry: **L** = lettura dei materiali dichiarati (`🟢` scansione registrata, `🔴` non iniziata); **D** = download (`🟢` tutte le risorse dichiarate associate a file acquisiti, `🟡` solo una parte, `🔴` nessun file). Le entry sono ordinate per la classifica principale scelta; quelle senza posizione seguono in ordine alfabetico. Se non esiste una classifica adatta, l'intero contest è alfabetico. La classifica usata è indicata sotto la tabella.", ""])

    detail_years = years
    for year in detail_years:
        year_contests = sorted((r for r in contests if r["year"] == year), key=lambda r: r["name"].casefold())
        lines.extend([f"### {year}", ""])
        imported_names = {normalized_contest_name(r["name"]) for r in year_contests}
        pending_names = [name for name in census_titles.get(year, [])
                         if normalized_contest_name(name) not in imported_names]
        if not year_contests:
            blocks = [pending_names[index:index + DETAIL_CONTEST_BLOCK_SIZE]
                      for index in range(0, len(pending_names), DETAIL_CONTEST_BLOCK_SIZE)]
            for block_number, block in enumerate(blocks, start=1):
                if len(blocks) > 1:
                    lines.extend([f"#### Gruppo {block_number} di {len(blocks)}", ""])
                lines.extend(["| N. | " + " | ".join(escape_cell(name) for name in block) + " |",
                              "|---:|" + ":---|" * len(block), ""])
            continue
        entries_by_contest: dict[int, list[tuple[str, str]]] = {}
        category_by_contest: dict[int, str] = {}
        for contest in year_contests:
            cid = contest["id"]
            main_category = summary[cid]["main_category"]
            rows = db.execute(
                """SELECT e.id,e.game_id,e.status_normalized,e.wip_thread_url,e.entry_url,
                          g.canonical_title,
                   (SELECT MAX(CASE s.coverage_scope WHEN 'rules_integrated' THEN 2 ELSE 1 END)
                    FROM entry_material_scans s WHERE s.entry_id=e.id) read_level,
                   (SELECT COUNT(DISTINCT rr.id) FROM entry_resource_mentions erm
                    JOIN remote_resources rr ON rr.id=erm.remote_resource_id WHERE erm.entry_id=e.id) resource_count,
                   (SELECT COUNT(DISTINCT af.remote_resource_id) FROM acquisitions a
                    JOIN acquired_files af ON af.acquisition_id=a.id
                    WHERE a.game_id=e.game_id AND af.remote_resource_id IS NOT NULL) downloaded_resources,
                   (SELECT COUNT(*) FROM acquisitions a JOIN acquired_files af ON af.acquisition_id=a.id
                    WHERE a.game_id=e.game_id) file_count,
                   (SELECT MIN(r.rank) FROM rankings r WHERE r.contest_id=e.contest_id
                    AND r.game_id=e.game_id AND r.category=?) main_rank
                   FROM entries e JOIN games g ON g.id=e.game_id WHERE e.contest_id=?
                   ORDER BY main_rank IS NULL,main_rank,g.canonical_title COLLATE NOCASE,e.id""",
                (main_category, cid),
            ).fetchall()
            entry_cells = []
            for entry in rows:
                read_icon = "🟢" if entry["read_level"] is not None else "🔴"
                if entry["file_count"] == 0:
                    download_icon = "🔴"
                elif entry["resource_count"] > 0 and entry["downloaded_resources"] >= entry["resource_count"]:
                    download_icon = "🟢"
                else:
                    download_icon = "🟡"
                rank = f"#{entry['main_rank']} " if entry["main_rank"] is not None else ""
                status_label = short_status(entry["status_normalized"])
                status_suffix = f" — {status_label}" if status_label else ""
                entry_link = markdown_link(
                    short_entry_title(entry["canonical_title"]),
                    entry["wip_thread_url"] or entry["entry_url"],
                )
                entry_cells.append((
                    f"{rank}{entry_link}{status_suffix}",
                    f"L {read_icon} · D {download_icon}",
                ))
            entries_by_contest[cid] = entry_cells
            category_note = escape_cell(main_category) if main_category else "ordine alfabetico"
            category_by_contest[cid] = category_note
        blocks = [year_contests[index:index + DETAIL_CONTEST_BLOCK_SIZE]
                  for index in range(0, len(year_contests), DETAIL_CONTEST_BLOCK_SIZE)]
        pending_blocks = [pending_names[index:index + DETAIL_CONTEST_BLOCK_SIZE]
                          for index in range(0, len(pending_names), DETAIL_CONTEST_BLOCK_SIZE)]
        total_blocks = len(blocks) + len(pending_blocks)
        for block_number, block in enumerate(blocks, start=1):
            if total_blocks > 1:
                lines.extend([f"#### Gruppo {block_number} di {total_blocks}", ""])
            lines.extend([
                "| N. | " + " | ".join(markdown_link(r["name"], r["source_url"]) for r in block) + " |",
                "|---:|" + ":---|" * len(block),
            ])
            max_entries = max((len(entries_by_contest[c["id"]]) for c in block), default=0)
            if max_entries:
                lines.append("| **Classifica utilizzata per l'ordinamento delle Entry** | "
                             + " | ".join(f"**{category_by_contest[contest['id']]}**" for contest in block)
                             + " |")
            for index in range(max_entries):
                name_cells = [entries_by_contest[contest["id"]][index][0]
                              if index < len(entries_by_contest[contest["id"]]) else EMPTY_CELL
                              for contest in block]
                status_cells = [entries_by_contest[contest["id"]][index][1]
                                if index < len(entries_by_contest[contest["id"]]) else EMPTY_CELL
                                for contest in block]
                lines.append(f"| {index + 1} | " + " | ".join(name_cells) + " |")
                lines.append(f"| {EMPTY_CELL} | " + " | ".join(status_cells) + " |")
            lines.append("")
        for pending_number, block in enumerate(pending_blocks, start=len(blocks) + 1):
            if total_blocks > 1:
                lines.extend([f"#### Gruppo {pending_number} di {total_blocks}", ""])
            lines.extend(["| N. | " + " | ".join(escape_cell(name) for name in block) + " |",
                          "|---:|" + ":---|" * len(block), ""])
        lines.append("")
    lines.append(END_MARKER)
    return "\n".join(lines)


def update_document(document: Path, generated: str) -> None:
    text = document.read_text(encoding="utf-8")
    if START_MARKER in text and END_MARKER in text:
        before, remainder = text.split(START_MARKER, 1)
        _, after = remainder.split(END_MARKER, 1)
        updated = before.rstrip() + "\n\n" + generated + after
    else:
        anchor = "\n## Legenda\n"
        if anchor not in text:
            raise ValueError("Sezione 'Legenda' non trovata nel documento")
        before, after = text.split(anchor, 1)
        updated = before.rstrip() + "\n\n" + generated + "\n\n## Legenda\n" + after
    document.write_text(updated, encoding="utf-8", newline="\n")


def main() -> None:
    project_root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser()
    parser.add_argument("--database", type=Path, default=project_root / "database" / "pnp_collection.sqlite3")
    parser.add_argument("--output", type=Path, default=project_root / "PROJECT_PROGRESS.md")
    args = parser.parse_args()
    uri = f"file:{args.database.resolve().as_posix()}?mode=ro"
    with sqlite3.connect(uri, uri=True) as db:
        generated = build_generated_section(db)
    update_document(args.output, generated)


if __name__ == "__main__":
    main()
