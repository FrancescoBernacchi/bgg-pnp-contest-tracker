"""Genera il dashboard Markdown dei contest a partire dal database SQLite locale."""

from __future__ import annotations

import argparse
import sqlite3
from datetime import datetime
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DATABASE = ROOT / "database" / "pnp_collection.sqlite3"
DEFAULT_OUTPUT = ROOT / "outputs" / "contest-monitoring-dashboard.md"


def markdown(value: object | None) -> str:
    if value is None or value == "":
        return "—"
    return str(value).replace("|", "\\|").replace("\n", " ")


def metric_value(row: sqlite3.Row) -> str:
    if row["numeric_value"] is not None:
        number = row["numeric_value"]
        rendered = str(int(number)) if float(number).is_integer() else str(number)
        return f"{rendered} {row['unit'] or ''}".strip()
    return markdown(row["text_value"])


def contest_table(rows: list[sqlite3.Row]) -> list[str]:
    lines = [
        "| Contest | Stato | Profilo | Entry | Ritirate | Prossima fase | Scadenza | Verificato |",
        "|---|---|---|---:|---:|---|---|---|",
    ]
    for row in rows:
        name = f"[{markdown(row['contest_name'])}]({row['source_url']})"
        lines.append(
            "| "
            + " | ".join(
                [
                    name,
                    markdown(row["status_normalized"]),
                    markdown(row["treatment_profile"]),
                    str(row["entry_count"]),
                    str(row["withdrawn_entry_count"]),
                    markdown(row["next_phase_label"]),
                    markdown(row["next_deadline"]),
                    markdown(row["last_verified_at"]),
                ]
            )
            + " |"
        )
    return lines


def fetch_contests(connection: sqlite3.Connection, view: str) -> list[sqlite3.Row]:
    allowed = {"v_contests_pnp_core", "v_contests_adjacent"}
    if view not in allowed:
        raise ValueError(f"Vista non ammessa: {view}")
    return connection.execute(
        f"SELECT * FROM {view} ORDER BY year DESC, julianday(starts_at) DESC, contest_id DESC"
    ).fetchall()


def comparable_checks(connection: sqlite3.Connection) -> list[sqlite3.Row]:
    """Restituisce l'ultimo controllo periodico e il precedente snapshot utile."""
    return connection.execute(
        """
        WITH monitoring AS (
            SELECT cc.*,
                   ROW_NUMBER() OVER (
                       PARTITION BY cc.contest_id
                       ORDER BY datetime(cc.checked_at) DESC, cc.id DESC
                   ) AS sequence
            FROM contest_checks cc
            WHERE (
                lower(cc.check_kind) LIKE '%monitor%'
                OR lower(cc.check_kind) LIKE '%scheduled%'
                OR lower(cc.check_kind) LIKE '%deadline%'
                OR lower(cc.check_kind) LIKE '%follow_up%'
            )
              AND lower(cc.check_kind) NOT LIKE '%baseline%'
              AND lower(cc.check_kind) NOT LIKE '%consistency%'
        )
        SELECT c.id AS contest_id, c.name AS contest_name, c.source_url,
               current.id AS current_check_id, current.checked_at AS current_checked_at,
               current.outcome AS current_outcome,
               previous.id AS previous_check_id, previous.checked_at AS previous_checked_at
        FROM monitoring current
        JOIN contests c ON c.id=current.contest_id
        LEFT JOIN contest_checks previous ON previous.id = (
            SELECT p.id FROM contest_checks p
            WHERE p.contest_id=current.contest_id
              AND datetime(p.checked_at) < datetime(current.checked_at)
              AND lower(p.check_kind) NOT LIKE '%consistency%'
            ORDER BY datetime(p.checked_at) DESC, p.id DESC LIMIT 1
        )
        WHERE current.sequence=1
        ORDER BY datetime(current.checked_at) DESC, current.id DESC
        """
    ).fetchall()


def keyed_snapshot(
    connection: sqlite3.Connection, table: str, check_id: int
) -> dict[object, tuple[object, ...]]:
    if table == "contest_metric_observations":
        rows = connection.execute(
            """SELECT metric_key, numeric_value, text_value, unit
               FROM contest_metric_observations WHERE check_id=?""",
            (check_id,),
        )
        return {
            row["metric_key"]: (row["numeric_value"], row["text_value"], row["unit"])
            for row in rows
        }
    if table == "contest_phase_history":
        rows = connection.execute(
            """SELECT phase_id, starts_at, ends_at, status_normalized
               FROM contest_phase_history WHERE check_id=?""",
            (check_id,),
        )
        return {
            row["phase_id"]: (row["starts_at"], row["ends_at"], row["status_normalized"])
            for row in rows
        }
    raise ValueError(f"Snapshot non supportato: {table}")


def change_rows(connection: sqlite3.Connection) -> list[dict[str, object]]:
    changes: list[dict[str, object]] = []
    for check in comparable_checks(connection):
        previous_id = check["previous_check_id"]
        if previous_id is None:
            continue

        previous_status = connection.execute(
            "SELECT status_normalized FROM contest_status_history WHERE check_id=? ORDER BY id DESC LIMIT 1",
            (previous_id,),
        ).fetchone()
        current_status = connection.execute(
            "SELECT status_normalized FROM contest_status_history WHERE check_id=? ORDER BY id DESC LIMIT 1",
            (check["current_check_id"],),
        ).fetchone()

        def entries(check_id: int) -> dict[int, tuple[str, str]]:
            rows = connection.execute(
                """SELECT entry_id, status_normalized, materials_status_normalized
                   FROM entry_status_history WHERE check_id=?""",
                (check_id,),
            )
            return {
                row["entry_id"]: (row["status_normalized"], row["materials_status_normalized"])
                for row in rows
            }

        old_entries = entries(previous_id)
        new_entries = entries(check["current_check_id"])
        shared = old_entries.keys() & new_entries.keys()
        transitioned = sum(old_entries[key] != new_entries[key] for key in shared)
        old_metrics = keyed_snapshot(connection, "contest_metric_observations", previous_id)
        new_metrics = keyed_snapshot(connection, "contest_metric_observations", check["current_check_id"])
        old_phases = keyed_snapshot(connection, "contest_phase_history", previous_id)
        new_phases = keyed_snapshot(connection, "contest_phase_history", check["current_check_id"])

        changes.append(
            {
                "contest_name": check["contest_name"],
                "source_url": check["source_url"],
                "previous_checked_at": check["previous_checked_at"],
                "current_checked_at": check["current_checked_at"],
                "status_change": (
                    f"{previous_status[0]} → {current_status[0]}"
                    if previous_status and current_status and previous_status[0] != current_status[0]
                    else "—"
                ),
                "new_entries": len(new_entries.keys() - old_entries.keys()) if old_entries and new_entries else 0,
                "removed_entries": len(old_entries.keys() - new_entries.keys()) if old_entries and new_entries else 0,
                "entry_transitions": transitioned,
                "metric_changes": sum(old_metrics.get(key) != value for key, value in new_metrics.items()),
                "phase_changes": (
                    sum(old_phases.get(key) != value for key, value in new_phases.items())
                    if old_phases and new_phases
                    else 0
                ),
                "outcome": check["current_outcome"],
            }
        )
    return changes


def build_report(connection: sqlite3.Connection) -> str:
    core = fetch_contests(connection, "v_contests_pnp_core")
    adjacent = fetch_contests(connection, "v_contests_adjacent")
    all_contests = core + adjacent
    deadlines = connection.execute(
        """
        SELECT * FROM v_contests_monitoring_all
        WHERE next_deadline IS NOT NULL
        ORDER BY julianday(next_deadline), contest_id
        """
    ).fetchall()
    standalone = connection.execute("SELECT COUNT(*) FROM v_entries_standalone").fetchone()[0]
    dependent = connection.execute("SELECT COUNT(*) FROM v_entries_dependent_variants").fetchone()[0]

    lines = [
        "# Dashboard monitoraggio contest BGG",
        "",
        f"Generato: {datetime.now().astimezone().isoformat(timespec='seconds')}.",
        "",
        "Il report usa esclusivamente il database locale e non apre né scarica materiali di gioco.",
        "",
        "## Riepilogo",
        "",
        f"- Contest monitorati: {len(all_contests)} ({len(core)} PnP principali, {len(adjacent)} adiacenti).",
        f"- Entry autonome: {standalone}.",
        f"- Varianti dipendenti da un gioco base: {dependent}.",
        "",
        "## Cambiamenti dall'ultimo rilevamento",
        "",
    ]

    changes = change_rows(connection)
    if changes:
        lines.extend(
            [
                "| Contest | Intervallo | Stato | Nuove | Rimosse | Transizioni entry | Metriche | Fasi/scadenze | Esito |",
                "|---|---|---|---:|---:|---:|---:|---:|---|",
            ]
        )
        for change in changes:
            contest = f"[{markdown(change['contest_name'])}]({change['source_url']})"
            interval = f"{markdown(change['previous_checked_at'])} → {markdown(change['current_checked_at'])}"
            lines.append(
                f"| {contest} | {interval} | {markdown(change['status_change'])} | "
                f"{change['new_entries']} | {change['removed_entries']} | {change['entry_transitions']} | "
                f"{change['metric_changes']} | {change['phase_changes']} | {markdown(change['outcome'])} |"
            )
    else:
        lines.extend(
            [
                "Nessun confronto periodico è ancora disponibile: i dati correnti costituiscono la baseline iniziale.",
                "I completamenti del censimento e le verifiche tecniche dello stesso giorno non vengono conteggiati come rilevamenti successivi.",
            ]
        )

    lines.extend([
        "",
        "## Prossime scadenze",
        "",
        "| Scadenza | Contest | Fase | Perimetro |",
        "|---|---|---|---|",
    ])
    for row in deadlines:
        lines.append(
            f"| {markdown(row['next_deadline'])} | "
            f"[{markdown(row['contest_name'])}]({row['source_url']}) | "
            f"{markdown(row['next_phase_label'])} | {markdown(row['scope_type'])} |"
        )
    if not deadlines:
        lines.append("| — | Nessuna scadenza futura registrata | — | — |")

    lines.extend(["", "## Contest PnP principali", "", *contest_table(core)])
    lines.extend(["", "## Contest adiacenti", "", *contest_table(adjacent)])

    lines.extend(["", "## Stati delle entry", ""])
    status_rows = connection.execute(
        """
        SELECT c.name AS contest_name, e.status_normalized, COUNT(*) AS entry_count
        FROM entries e JOIN contests c ON c.id=e.contest_id
        GROUP BY e.contest_id, e.status_normalized
        ORDER BY c.year DESC, julianday(c.starts_at) DESC, c.id DESC, e.status_normalized
        """
    ).fetchall()
    lines.extend(["| Contest | Stato entry | Numero |", "|---|---|---:|"])
    for row in status_rows:
        lines.append(
            f"| {markdown(row['contest_name'])} | {markdown(row['status_normalized'])} | {row['entry_count']} |"
        )

    lines.extend(["", "## Statistiche più recenti", ""])
    metric_rows = connection.execute(
        """
        WITH latest AS (
            SELECT contest_id, metric_key, MAX(observed_at) AS observed_at
            FROM contest_metric_observations
            GROUP BY contest_id, metric_key
        )
        SELECT c.name AS contest_name, m.metric_key, m.metric_label_raw,
               m.numeric_value, m.text_value, m.unit, m.is_official,
               m.observed_at, m.source_url
        FROM latest l
        JOIN contest_metric_observations m
          ON m.contest_id=l.contest_id AND m.metric_key=l.metric_key AND m.observed_at=l.observed_at
        JOIN contests c ON c.id=m.contest_id
        ORDER BY c.year DESC, julianday(c.starts_at) DESC, c.id DESC, m.metric_key
        """
    ).fetchall()
    lines.extend(
        [
            "| Contest | Metrica | Valore | Ufficiale | Osservata |",
            "|---|---|---:|---|---|",
        ]
    )
    for row in metric_rows:
        label = row["metric_label_raw"] or row["metric_key"]
        source_label = f"[{markdown(label)}]({row['source_url']})"
        lines.append(
            f"| {markdown(row['contest_name'])} | {source_label} | {metric_value(row)} | "
            f"{'sì' if row['is_official'] else 'no'} | {markdown(row['observed_at'])} |"
        )

    lines.append("")
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=DEFAULT_DATABASE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if not args.database.is_file():
        raise SystemExit(f"Database non trovato: {args.database}")
    connection = sqlite3.connect(f"file:{args.database.resolve()}?mode=ro", uri=True)
    connection.row_factory = sqlite3.Row
    try:
        report = build_report(connection)
    finally:
        connection.close()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(report, encoding="utf-8")
    print(args.output.resolve())


if __name__ == "__main__":
    main()
