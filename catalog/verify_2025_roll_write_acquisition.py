"""Verifica manifest, file e registrazioni del lotto Roll & Write 2025."""

from __future__ import annotations

import argparse
import hashlib
import json
import sqlite3
import zipfile
from pathlib import Path


def verify(database: Path, manifest_path: Path, library: Path) -> dict:
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    con = sqlite3.connect(f"file:{database.as_posix()}?mode=ro", uri=True)
    errors: list[str] = []
    verified_files = 0
    for item in manifest["items"]:
        item_errors = 0
        local = library / Path(item["relative_path"])
        if not local.is_file():
            errors.append(f"Missing file: {local}")
            continue
        data = local.read_bytes()
        if item['media_type']=='application/pdf' and b'%%EOF' not in data[-4096:]:
            errors.append(f'PDF senza terminatore: {local}')
            item_errors += 1
        if item['media_type'] in ('application/zip','application/vnd.openxmlformats-officedocument.wordprocessingml.document'):
            with zipfile.ZipFile(local) as archive:
                bad=archive.testzip()
                if bad:
                    errors.append(f'CRC archivio non valido: {local}: {bad}')
                    item_errors += 1
                if item['media_type'].endswith('document') and 'word/document.xml' not in archive.namelist():
                    errors.append(f'OOXML Word non valido: {local}')
                    item_errors += 1
        if item.get('archive_parent_sha256'):
            parent=next(x for x in manifest['items'] if x['sha256']==item['archive_parent_sha256'] and x['media_type']=='application/zip')
            with zipfile.ZipFile(library/parent['relative_path']) as archive:
                if archive.read(item['archive_member'])!=data:
                    errors.append(f'Membro archivio non coincidente: {local}')
                    item_errors += 1
        if len(data) != item["byte_size"]:
            errors.append(f"Size mismatch: {local}")
            item_errors += 1
        if hashlib.sha256(data).hexdigest() != item["sha256"]:
            errors.append(f"Hash mismatch: {local}")
            item_errors += 1
        row = con.execute(
            """SELECT af.byte_size,af.sha256,af.acquisition_status
               FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id
               WHERE a.source_snapshot=? AND af.relative_path=?""",
            (manifest["batch_key"], item["relative_path"]),
        ).fetchone()
        if row != (item["byte_size"], item["sha256"], "acquired"):
            errors.append(f"Database mismatch: {item['relative_path']}")
            item_errors += 1
        if item_errors == 0:
            verified_files += 1
    result = {
        "manifest_items": len(manifest["items"]),
        "verified_files": verified_files,
        "batch_acquisitions": con.execute(
            "SELECT count(*) FROM acquisitions WHERE source_snapshot=?", (manifest["batch_key"],)
        ).fetchone()[0],
        "batch_files": con.execute(
            """SELECT count(*) FROM acquired_files af JOIN acquisitions a ON a.id=af.acquisition_id
               WHERE a.source_snapshot=?""", (manifest["batch_key"],)
        ).fetchone()[0],
        "foreign_key_check": con.execute("PRAGMA foreign_key_check").fetchall(),
        "integrity_check": con.execute("PRAGMA integrity_check").fetchone()[0],
        "errors": errors,
    }
    con.close()
    if errors:
        raise SystemExit(json.dumps(result, indent=2))
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=Path)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("library", type=Path)
    args = parser.parse_args()
    print(json.dumps(verify(args.database, args.manifest, args.library), indent=2))


if __name__ == "__main__":
    main()
