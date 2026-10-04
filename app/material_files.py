"""Lettura confinata PNG/DOCX; dati strutturati senza HTML attivo."""
from contextlib import contextmanager
import os
import struct
import zlib
from pdf_files import PDFError, confined_path, check_handle, open_pdf

DOCX = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
KINDS = {'application/pdf': 'pdf', 'image/png': 'png', DOCX: 'docx'}
MAX_BYTES = 32 * 1024 * 1024
W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'


def docx_blocks(handle):
    from docx_reader import read_blocks
    return read_blocks(handle)


def validate_png(handle, size):
    if handle.read(8) != b'\x89PNG\r\n\x1a\n':
        raise PDFError(415, 'corrupt', 'Contenuto non PNG.')
    first = True
    while handle.tell() < size:
        header = handle.read(8)
        if len(header) != 8:
            break
        length, kind = struct.unpack('>I4s', header)
        if length > MAX_BYTES or length + 4 > size - handle.tell():
            break
        content = handle.read(length)
        crc = handle.read(4)
        if len(crc) != 4 or zlib.crc32(kind + content) & 0xffffffff != struct.unpack('>I', crc)[0]:
            break
        if first:
            if kind != b'IHDR' or length != 13:
                break
            width, height = struct.unpack('>II', content[:8])
            if not width or not height or width * height > 40_000_000 or max(width, height) > 16000:
                raise PDFError(413, 'too_large', 'PNG oltre il limite di 40 milioni di pixel.')
            first = False
        if kind == b'IEND' and not length and handle.tell() == size:
            handle.seek(0)
            return
    raise PDFError(422, 'corrupt', 'PNG incompleto o danneggiato.')


@contextmanager
def open_material(root, relative_path, media_type, acquisition_status='acquired'):
    if media_type == 'application/pdf':
        with open_pdf(root, relative_path, media_type, acquisition_status) as opened:
            yield opened
        return
    if media_type not in KINDS or acquisition_status != 'acquired':
        raise PDFError(415, 'unsupported', 'Formato non visualizzabile.')
    root, path = confined_path(root, relative_path)
    with os.fdopen(os.open(path, os.O_RDONLY | getattr(os, 'O_BINARY', 0) | getattr(os, 'O_NOFOLLOW', 0)), 'rb') as handle:
        check_handle(handle, root, path)
        size = os.fstat(handle.fileno()).st_size
        if size > MAX_BYTES:
            raise PDFError(413, 'too_large', 'Materiale oltre il limite di 32 MiB.')
        if media_type == 'image/png':
            validate_png(handle, size)
        else:
            docx_blocks(handle)
            handle.seek(0)
        yield handle, size


def material_status(root, relative, mime, status):
    try:
        with open_material(root, relative, mime, status):
            return 'ready'
    except PDFError as error:
        return error.code
    except OSError:
        return 'unverifiable'
