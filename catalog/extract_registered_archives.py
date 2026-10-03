"""Estrazione locale offline: --apply autorizza backup, migrazione e registrazione."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import mimetypes
import os
from pathlib import Path, PureWindowsPath
import sqlite3
import stat
import sys
import zipfile
import zlib

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'app'))
from pdf_files import confined_path, check_handle, PDFError
from material_files import DOCX

MAX_ARCHIVE = 128 * 1024 * 1024
MAX_MEMBER = 32 * 1024 * 1024
MAX_TOTAL = 256 * 1024 * 1024
MAX_ENTRIES = 2000


def safe_directory(root, destination):
    root = Path(root).absolute()
    destination = Path(destination).absolute()
    relative = destination.relative_to(root)
    current = root
    for part in [None, *relative.parts]:
        if part is not None:
            current /= part
        if not current.exists():
            current.mkdir()
        info = current.lstat()
        if not stat.S_ISDIR(info.st_mode) or stat.S_ISLNK(info.st_mode) or getattr(info, 'st_file_attributes', 0) & 0x400:
            raise ValueError('Destinazione non confinata')


def validate_entries(entries):
    if len(entries) > MAX_ENTRIES or sum(x.file_size for x in entries) > MAX_TOTAL:
        raise ValueError('Limite numero contenuti o dimensione totale superato')
    seen = set()
    for item in entries:
        # Some acquired ZIPs contain a zero-byte root directory marker. It is
        # metadata only: never materialized, unlike any absolute member path.
        if item.filename == '/' and item.is_dir() and item.file_size == 0:
            continue
        name = item.filename.replace('\\', '/')
        win = PureWindowsPath(name)
        if (not name or '\x00' in item.orig_filename or win.drive or win.root or ':' in name
                or '..' in name.split('/') or any(p != p.rstrip(' .') for p in name.split('/'))):
            raise ValueError('Percorso interno non sicuro')
        if name.casefold() in seen:
            raise ValueError('Nomi interni duplicati o ambigui')
        seen.add(name.casefold())
        mode = item.external_attr >> 16
        if stat.S_ISLNK(mode) or (stat.S_IFMT(mode) not in (0, stat.S_IFREG, stat.S_IFDIR)):
            raise ValueError('Link o contenuto speciale non supportato')
        if item.flag_bits & 1:
            raise ValueError('Archivio protetto da password')
        if item.file_size > MAX_MEMBER or item.file_size > max(1, item.compress_size) * 200:
            raise ValueError('Limite dimensione o rapporto di compressione superato')


def extract_one(db, library, record, apply=True):
    """Valida tutto prima di registrare; i percorsi derivati non usano nomi ZIP."""
    _, path = confined_path(library, record['relative_path'])
    with path.open('rb') as handle:
        check_handle(handle, Path(library).resolve(), path)
        if os.fstat(handle.fileno()).st_size > MAX_ARCHIVE:
            raise ValueError('Archivio oltre 128 MiB')
        digest = hashlib.file_digest(handle, 'sha256').hexdigest()
        if digest != record['sha256']:
            raise ValueError('Hash archivio diverso dal valore registrato')
        handle.seek(0)
        with zipfile.ZipFile(handle) as archive:
            entries = archive.infolist()
            validate_entries(entries)
            contents = []
            for item in entries:
                if item.is_dir():
                    continue
                with archive.open(item) as member:
                    data = member.read(MAX_MEMBER + 1)
                if len(data) != item.file_size or len(data) > MAX_MEMBER:
                    raise ValueError('Dimensione contenuto non valida')
                member_hash = hashlib.sha256(data).hexdigest()
                extension = Path(item.filename).suffix.lower()
                if len(extension) > 12 or not extension[1:].isalnum():
                    extension = '.bin'
                relative = f"_extracted/{record['id']}/{digest}/{hashlib.sha256(item.filename.encode()).hexdigest()}{extension}"
                contents.append((item.filename, relative, member_hash, data))
    results = []
    for name, relative, member_hash, data in contents:
        file_id = None
        if apply:
            destination = Path(library) / relative
            safe_directory(library, destination.parent)
            if destination.exists():
                _, target = confined_path(library, relative)
                with target.open('rb') as existing:
                    check_handle(existing, Path(library).resolve(), target)
                    if hashlib.file_digest(existing, 'sha256').hexdigest() != member_hash:
                        raise ValueError('Contenuto estratto preesistente diverso: nessuna sovrascrittura')
            else:
                with destination.open('xb') as output:
                    check_handle(output, Path(library).resolve(), destination.resolve())
                    output.write(data)
            found = db.execute('SELECT file_id FROM archive_contents WHERE archive_file_id=? AND archive_sha256=? AND member_path=?', (record['id'], digest, name)).fetchone()
            if found:
                file_id = found[0]
                registered = db.execute('SELECT sha256,relative_path FROM acquired_files WHERE id=?', (file_id,)).fetchone()
                if tuple(registered) != (member_hash, relative):
                    raise ValueError('Registrazione precedente incompatibile')
            else:
                mime = DOCX if name.lower().endswith('.docx') else mimetypes.guess_type(name)[0] or 'application/octet-stream'
                fields = ['acquisition_id','remote_resource_id','catalog_resource_id','final_url','language_code','usage_conditions','version_raw']
                values = [record[k] for k in fields]
                fields += ['relative_path','original_filename','media_type','byte_size','sha256','notes']
                values += [relative, Path(name.replace('\\','/')).name, mime, len(data), member_hash, f"Estratto da file #{record['id']}; membro {name}"]
                cursor = db.execute(f"INSERT INTO acquired_files ({','.join(fields)}) VALUES ({','.join('?' for _ in fields)})", values)
                file_id = cursor.lastrowid
                db.execute('INSERT INTO archive_contents VALUES (?,?,?,?,?)', (file_id, record['id'], digest, name, datetime.now(timezone.utc).isoformat()))
        results.append({'file_id': file_id, 'member_path': name, 'relative_path': relative, 'sha256': member_hash, 'bytes': len(data)})
    return results


def run(database, library, apply=False, manifest=None):
    now = datetime.now(timezone.utc).isoformat()
    backup = None
    uri = Path(database).resolve().as_uri() + ('?mode=rw' if apply else '?mode=ro')
    with sqlite3.connect(uri, uri=True) as db:
        db.row_factory = sqlite3.Row
        db.execute('PRAGMA foreign_keys=ON')
        if apply:
            backup = ROOT / 'outputs' / ('app005-before-' + datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f') + '.sqlite3')
            with sqlite3.connect(backup) as target:
                db.backup(target)
                if target.execute('PRAGMA integrity_check').fetchone()[0] != 'ok':
                    raise ValueError('Backup non integro')
            if not db.execute("SELECT 1 FROM sqlite_master WHERE name='archive_contents'").fetchone():
                db.executescript((ROOT/'database/migrations/011_archive_contents.sql').read_text(encoding='utf-8'))
        has_links = bool(db.execute("SELECT 1 FROM sqlite_master WHERE name='archive_contents'").fetchone())
        query = "SELECT * FROM acquired_files WHERE acquisition_status='acquired' AND (media_type IN ('application/zip','application/x-zip-compressed') OR lower(original_filename) LIKE '%.zip')"
        if has_links:
            query += ' AND id NOT IN (SELECT file_id FROM archive_contents)'
        records = list(db.execute(query))
        results = []
        for row in records:
            record = dict(row)
            db.execute('SAVEPOINT archive')
            try:
                contents = extract_one(db, library, record, apply)
                result = {'archive_file_id': record['id'], 'archive_sha256': record['sha256'], 'status': 'extracted', 'message': 'ZIP annidati registrati senza estrazione ricorsiva', 'contents': contents}
                db.execute('RELEASE archive')
            except (PDFError, ValueError, OSError, zipfile.BadZipFile, RuntimeError, NotImplementedError, EOFError, sqlite3.Error, zlib.error) as error:
                db.execute('ROLLBACK TO archive'); db.execute('RELEASE archive')
                result = {'archive_file_id': record['id'], 'archive_sha256': record['sha256'], 'status': 'failed', 'message': getattr(error, 'message', str(error)), 'contents': []}
            if apply:
                db.execute('INSERT OR REPLACE INTO archive_extractions VALUES (?,?,?,?,?)', (record['id'],record['sha256'],now,result['status'],result['message']))
            result['provenance'] = {k: record[k] for k in ('acquisition_id','remote_resource_id','catalog_resource_id','final_url','language_code','usage_conditions','version_raw')}
            result['provenance']['game_id'] = db.execute('SELECT game_id FROM acquisitions WHERE id=?', (record['acquisition_id'],)).fetchone()[0]
            results.append(result)
        if apply:
            db.commit()
        integrity = db.execute('PRAGMA integrity_check').fetchone()[0]
        foreign_keys = list(db.execute('PRAGMA foreign_key_check'))
        if integrity != 'ok' or foreign_keys:
            raise ValueError('Integrità o chiavi esterne non valide')
    report = {'checked_at': now, 'apply': apply, 'backup': str(backup) if backup else None, 'archives': results}
    if manifest:
        Path(manifest).write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT/'database/pnp_collection.sqlite3')
    parser.add_argument('--library', type=Path, default=ROOT/'library')
    parser.add_argument('--apply', action='store_true')
    parser.add_argument('--manifest', type=Path)
    args = parser.parse_args()
    report = run(args.database, args.library, args.apply, args.manifest)
    print(json.dumps({'apply': args.apply, 'archives': len(report['archives']), 'contents': sum(len(a['contents']) for a in report['archives']), 'failures': [a for a in report['archives'] if a['status']=='failed']}, ensure_ascii=False, indent=2))
