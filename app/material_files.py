"""Lettura confinata PNG/DOCX. Il DOCX produce esclusivamente dati testuali."""
from contextlib import contextmanager
import os
import struct
import zipfile
import zlib
from xml.etree import ElementTree as ET
from pdf_files import PDFError, confined_path, check_handle, open_pdf

DOCX = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
KINDS = {'application/pdf': 'pdf', 'image/png': 'png', DOCX: 'docx'}
MAX_BYTES = 32 * 1024 * 1024
W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'


def docx_blocks(handle):
    try:
        with zipfile.ZipFile(handle) as archive:
            entries = archive.infolist()
            if len(entries) > 2000 or sum(x.file_size for x in entries) > 128 * 1024 * 1024:
                raise ValueError('Documento troppo grande')
            matches = [x for x in entries if x.filename == 'word/document.xml']
            if len(matches) != 1 or matches[0].file_size > 8 * 1024 * 1024 or matches[0].flag_bits & 1:
                raise ValueError('Documento non supportato')
            xml = archive.read(matches[0])
        if b'<!DOCTYPE' in xml.upper() or b'<!ENTITY' in xml.upper() or b'\x00' in xml:
            raise ValueError('XML non supportato')
        tree = ET.fromstring(xml)
        # Word stores the same content twice for compatibility. Choose one
        # representation instead of concatenating Choice and Fallback text.
        mc = '{http://schemas.openxmlformats.org/markup-compatibility/2006}'
        def normalize(node):
            for child in list(node):
                if child.tag == mc+'AlternateContent':
                    chosen = child.find(mc+'Fallback')
                    if chosen is None:
                        chosen = child.find(mc+'Choice')
                    index = list(node).index(child)
                    node.remove(child)
                    if chosen is not None:
                        normalize(chosen)
                        for offset, replacement in enumerate(list(chosen)):
                            node.insert(index+offset, replacement)
                else:
                    normalize(child)
        normalize(tree)
        body = tree.find(W + 'body')
        if body is None:
            raise ValueError('Corpo assente')
        def text(node):
            return ''.join((x.text or '') if x.tag == W+'t' else '\t' if x.tag == W+'tab' else '\n' if x.tag in (W+'br', W+'cr') else '' for x in node.iter())
        blocks = []
        for node in body:
            if node.tag == W+'p':
                blocks.append({'kind': 'paragraph', 'text': text(node)})
            elif node.tag == W+'tbl':
                blocks.append({'kind': 'table', 'rows': [[text(cell) for cell in row.findall(W+'tc')] for row in node.findall(W+'tr')]})
        return blocks
    except (ValueError, ET.ParseError, zipfile.BadZipFile, KeyError, RuntimeError, RecursionError, NotImplementedError, EOFError, zlib.error) as error:
        raise PDFError(422, 'corrupt', 'DOCX non leggibile, protetto o oltre i limiti.') from error


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
