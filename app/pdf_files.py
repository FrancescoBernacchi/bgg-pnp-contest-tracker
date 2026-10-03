"""Apertura PDF registrati: handle stabile e nessun percorso pubblico."""
from contextlib import contextmanager
import ctypes
import os
from pathlib import Path, PureWindowsPath
import stat

MAX_PDF_BYTES = 128 * 1024 * 1024


class PDFError(Exception):
    def __init__(self, status, code, message):
        self.status, self.code, self.message = status, code, message


def reject(code='invalid_path'):
    raise PDFError(403, code, 'Percorso locale non autorizzato.')


def confined_path(root, relative):
    normalized = relative.replace('\\', '/') if isinstance(relative, str) else ''
    win = PureWindowsPath(normalized)
    if (not normalized or '\x00' in normalized or win.drive or win.root or ':' in normalized
            or '..' in normalized.split('/')
            or any(part not in ('', '.') and part != part.rstrip(' .') for part in normalized.split('/'))):
        reject()
    root = Path(root).absolute()
    current = root
    # All links/reparse points, including ones staying inside library, are excluded.
    for part in [None, *normalized.split('/')]:
        if part is not None:
            current /= part
        try:
            info = current.lstat()
        except FileNotFoundError:
            raise PDFError(404, 'missing', 'Il file locale non è più presente.') from None
        if stat.S_ISLNK(info.st_mode) or getattr(info, 'st_file_attributes', 0) & 0x400:
            reject()
    root = root.resolve()
    target = current.resolve()
    if not stat.S_ISREG(info.st_mode):
        reject()
    if not target.is_relative_to(root) or target == root:
        reject()
    return root, target


def check_handle(handle, root, expected):
    if os.name == 'nt':
        import msvcrt
        function = ctypes.windll.kernel32.GetFinalPathNameByHandleW
        function.argtypes = [ctypes.c_void_p, ctypes.c_wchar_p, ctypes.c_uint32, ctypes.c_uint32]
        function.restype = ctypes.c_uint32
        buffer = ctypes.create_unicode_buffer(32768)
        length = function(msvcrt.get_osfhandle(handle.fileno()), buffer, len(buffer), 0)
        if not length or length >= len(buffer):
            reject()
        actual = Path(buffer.value.removeprefix('\\\\?\\')).resolve()
        if actual != expected or not actual.is_relative_to(root):
            reject()
    else:
        # Linux descriptor verification catches directory-link swaps after validation.
        descriptor = Path(f'/proc/self/fd/{handle.fileno()}')
        if descriptor.exists() and descriptor.resolve() != expected:
            reject()
        if os.stat(expected, follow_symlinks=False).st_ino != os.fstat(handle.fileno()).st_ino:
            reject()


@contextmanager
def open_pdf(root, relative_path, media_type, acquisition_status='acquired'):
    if media_type != 'application/pdf' or acquisition_status != 'acquired':
        raise PDFError(415, 'unsupported', 'Formato non supportato dal visualizzatore PDF.')
    root, path = confined_path(root, relative_path)
    try:
        descriptor = os.open(path, os.O_RDONLY | getattr(os, 'O_BINARY', 0) | getattr(os, 'O_NOFOLLOW', 0))
    except FileNotFoundError:
        raise PDFError(404, 'missing', 'Il file locale non è più presente.') from None
    with os.fdopen(descriptor, 'rb') as handle:
        check_handle(handle, root, path)
        info = os.fstat(handle.fileno())
        if not stat.S_ISREG(info.st_mode):
            reject()
        if info.st_size > MAX_PDF_BYTES:
            raise PDFError(413, 'too_large', 'PDF oltre il limite di visualizzazione di 128 MiB.')
        if not handle.read(8).startswith(b'%PDF-'):
            raise PDFError(415, 'not_pdf', 'Il contenuto locale non è riconosciuto come PDF.')
        handle.seek(max(0, info.st_size - 1024))
        if b'%%EOF' not in handle.read(1024):
            raise PDFError(422, 'corrupt', 'PDF incompleto o danneggiato.')
        handle.seek(0)
        yield handle, info.st_size


def preview_status(root, relative, media_type, acquisition_status):
    try:
        with open_pdf(root, relative, media_type, acquisition_status):
            return 'ready'
    except PDFError as error:
        return error.code
    except OSError:
        return 'unverifiable'
