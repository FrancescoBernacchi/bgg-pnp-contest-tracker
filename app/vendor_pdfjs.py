"""Acquisisce solo il renderer ufficiale fissato; mai eseguito dal server."""
import base64
import hashlib
import io
import json
from pathlib import Path
import tarfile
import urllib.request

VERSION = '6.3.289'
INTEGRITY = 'ZHjSVpDa3D6izMq8/04lvkhkATUmL9px6ChPaXc1k6nU2Mrhlg1/7F0bdUqCwUjw3NsPTfPZsMDUU6ZIcRaeQw=='
URL = f'https://registry.npmjs.org/pdfjs-dist/-/pdfjs-dist-{VERSION}.tgz'


def main():
    with urllib.request.urlopen(URL, timeout=60) as response:
        archive = response.read()
    if base64.b64encode(hashlib.sha512(archive).digest()).decode() != INTEGRITY:
        raise ValueError('Integrità pacchetto non valida')
    target = Path(__file__).parent / 'static/vendor/pdfjs'
    target.mkdir(parents=True, exist_ok=True)
    files = {}
    with tarfile.open(fileobj=io.BytesIO(archive), mode='r:gz') as package:
        for member in package.getmembers():
            name = member.name.removeprefix('package/')
            if not member.isfile() or '..' in name.split('/'):
                continue
            chosen = (name in ('LICENSE', 'build/pdf.mjs', 'build/pdf.worker.mjs')
                      or name.startswith(('cmaps/', 'standard_fonts/', 'iccs/'))
                      or (name.startswith('wasm/') and not name.split('/')[-1].startswith('quickjs')))
            if not chosen:
                continue
            content = package.extractfile(member).read()
            if name.endswith('.mjs'):
                # Source maps aren't shipped: avoid spurious browser requests.
                content = content.replace(b'//# sourceMappingURL=pdf.mjs.map', b'').replace(b'//# sourceMappingURL=pdf.worker.mjs.map', b'')
            output = target / name
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_bytes(content)
            files[name] = {'bytes': len(content), 'sha256': hashlib.sha256(content).hexdigest()}
    manifest = {'version': VERSION, 'source': URL, 'npm_integrity': 'sha512-'+INTEGRITY,
                'verified_at': '2026-10-03', 'files': dict(sorted(files.items()))}
    (target / 'MANIFEST.json').write_text(json.dumps(manifest, indent=2)+'\n', encoding='utf-8')
    print(f'PDF.js {VERSION}: {len(files)} asset locali, {sum(f["bytes"] for f in files.values())} byte')


if __name__ == '__main__':
    main()
