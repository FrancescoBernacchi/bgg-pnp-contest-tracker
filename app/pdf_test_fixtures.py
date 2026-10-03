"""PDF sintetici originali per i test, generati senza pacchetti aggiuntivi."""
def sample_pdf(active=False):
    objects = [b'<< /Type /Catalog /Pages 2 0 R'+(b' /OpenAction 8 0 R' if active else b'')+b' >>',
               b'<< /Type /Pages /Kids [3 0 R 4 0 R] /Count 2 >>',
               b'<< /Type /Page /Parent 2 0 R /MediaBox [0 0 300 400] /Resources << /Font << /F1 5 0 R >> >> /Contents 6 0 R >>',
               b'<< /Type /Page /Parent 2 0 R /MediaBox [0 0 300 400] /Resources << /Font << /F1 5 0 R >> >> /Contents 7 0 R >>',
               b'<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>']
    for text in (b'PDF fixture page 1', b'PDF fixture page 2 <script>not markup</script>'):
        stream=b'BT /F1 8 Tf 20 350 Td ('+text+b') Tj ET'
        objects.append(b'<< /Length '+str(len(stream)).encode()+b' >>\nstream\n'+stream+b'\nendstream')
    if active:
        objects.append(rb'<< /S /JavaScript /JS (app.alert\(\"MUST NOT RUN\"\); app.launchURL\(\"https://example.invalid/\"\)) >>')
    data=b'%PDF-1.4\n';offsets=[0]
    for index,obj in enumerate(objects,1):
        offsets.append(len(data));data+=str(index).encode()+b' 0 obj\n'+obj+b'\nendobj\n'
    position=len(data)
    data+=b'xref\n0 '+str(len(objects)+1).encode()+b'\n0000000000 65535 f \n'
    data+=b''.join(f'{offset:010d} 00000 n \n'.encode() for offset in offsets[1:])
    data+=b'trailer\n<< /Size '+str(len(objects)+1).encode()+b' /Root 1 0 R >>\nstartxref\n'+str(position).encode()+b'\n%%EOF\n'
    return data
