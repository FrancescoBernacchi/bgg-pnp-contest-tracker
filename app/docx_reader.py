"""Bounded OOXML to passive JSON. Never fetch relationships or emit HTML."""
import base64
import io
import posixpath
import re
import struct
import zipfile
import zlib
from xml.etree import ElementTree as ET
from pdf_files import PDFError

W = '{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
R = '{http://schemas.openxmlformats.org/officeDocument/2006/relationships}'
A = '{http://schemas.openxmlformats.org/drawingml/2006/main}'
WP = '{http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing}'
MC = '{http://schemas.openxmlformats.org/markup-compatibility/2006}'


def validate_jpeg(data):
    """Bound JPEG dimensions before handing passive bytes to the browser."""
    offset = 2
    while offset + 4 <= len(data):
        if data[offset] != 255:
            raise ValueError('JPEG marker')
        while offset < len(data) and data[offset] == 255:
            offset += 1
        if offset >= len(data): break
        marker = data[offset]; offset += 1
        if marker in (0xD8, 0x01) or 0xD0 <= marker <= 0xD7: continue
        if marker in (0xD9, 0xDA): break
        length = struct.unpack('>H', data[offset:offset+2])[0]
        if length < 2 or offset + length > len(data): raise ValueError('JPEG length')
        if marker in (0xC0, 0xC1, 0xC2):
            if length < 8: raise ValueError('JPEG frame')
            height, width = struct.unpack('>HH', data[offset+3:offset+7])
            if not width or not height or width*height > 40_000_000 or max(width,height) > 16000:
                raise ValueError('JPEG dimensions')
            return
        offset += length
    raise ValueError('JPEG frame absent')

def val(node, name, attr='val', default=None):
    child = node.find(W+name) if node is not None else None
    return child.get(W+attr, default) if child is not None else default

def number(value, scale=1, low=-1000, high=2000):
    try:
        result = float(value)/scale
        return max(low, min(high, result))
    except (ValueError, TypeError):
        return None

def properties(node):
    result = {}
    if node is None:
        return result
    for tag, key, on, off in [('b','fontWeight','bold','normal'), ('i','fontStyle','italic','normal')]:
        if node.find(W+tag) is not None:
            result[key] = off if val(node,tag) in ('0','false','off') else on
    if node.find(W+'u') is not None:
        result['textDecoration'] = 'none' if val(node,'u') == 'none' else 'underline'
    if node.find(W+'strike') is not None and val(node,'strike') not in ('0','false','off'):
        result['textDecoration'] = 'line-through'
    size = number(val(node,'sz'),2,4,96)
    if size is not None: result['fontSize'] = f'{size:g}pt'
    font = val(node,'rFonts','ascii') or val(node,'rFonts','hAnsi')
    if font and re.fullmatch(r'[\w .-]{1,80}',font): result['fontFamily'] = font
    for tag, attr, key in [('color','val','color'),('shd','fill','backgroundColor')]:
        color = val(node,tag,attr)
        if color and re.fullmatch('[0-9a-fA-F]{6}',color): result[key] = '#'+color
    align = val(node,'jc')
    if align in ('left','right','center','both','start','end'):
        result['textAlign'] = {'both':'justify','start':'left','end':'right'}.get(align,align)
    for attr,key in [('before','marginTop'),('after','marginBottom')]:
        n=number(val(node,'spacing',attr),20,0,200)
        if n is not None: result[key]=f'{n:g}pt'
    line=number(val(node,'spacing','line'),240,.5,5)
    if line is not None:
        if val(node,'spacing','lineRule') in ('exact','atLeast'):
            result['lineHeight']=f"{number(val(node,'spacing','line'),20,1,200):g}pt"
        else: result['lineHeight']=str(line)
    for attr,key in [('left','marginLeft'),('right','marginRight'),('firstLine','textIndent')]:
        n=number(val(node,'ind',attr),20)
        if n is not None: result[key]=f'{n:g}pt'
    hanging=number(val(node,'ind','hanging'),20,0,200)
    if hanging is not None: result['textIndent']=f'{-hanging:g}pt'
    vertical=val(node,'vertAlign')
    if vertical in ('subscript','superscript'): result['verticalAlign']='sub' if vertical=='subscript' else 'super'
    return result


def read_blocks(handle):
    try:
        with zipfile.ZipFile(handle) as archive:
            entries=archive.infolist()
            names=[x.filename for x in entries]
            if len(entries)>2000 or len(set(names))!=len(names) or sum(x.file_size for x in entries)>128*1024*1024:
                raise ValueError('Package limits')
            def xml(name):
                if name not in names: return None
                info=archive.getinfo(name)
                if info.file_size>8*1024*1024 or info.flag_bits&1: raise ValueError('XML limits')
                data=archive.read(name)
                if b'<!DOCTYPE' in data.upper() or b'<!ENTITY' in data.upper() or b'\x00' in data: raise ValueError('Unsafe XML')
                root=ET.fromstring(data)
                def normalize(node,depth=0):
                    if depth>100: raise ValueError('XML depth')
                    for child in list(node):
                        if child.tag==MC+'AlternateContent':
                            chosen=child.find(MC+'Fallback')
                            if chosen is None: chosen=child.find(MC+'Choice')
                            index=list(node).index(child);node.remove(child)
                            if chosen is not None:
                                normalize(chosen,depth+1)
                                for offset,replacement in enumerate(list(chosen)):node.insert(index+offset,replacement)
                        else: normalize(child,depth+1)
                normalize(root)
                return root
            tree=xml('word/document.xml')
            body=tree.find(W+'body') if tree is not None else None
            if body is None: raise ValueError('Missing body')
            styles=xml('word/styles.xml')
            style_map={s.get(W+'styleId'):s for s in styles.findall(W+'style')} if styles is not None else {}
            defaults=styles.find(W+'docDefaults') if styles is not None else None
            default_p=properties(defaults.find(W+'pPrDefault/'+W+'pPr')) if defaults is not None else {}
            default_r=properties(defaults.find(W+'rPrDefault/'+W+'rPr')) if defaults is not None else {}
            def style_chain(sid):
                chain=[];seen=set()
                while sid in style_map and sid not in seen:
                    seen.add(sid);style=style_map[sid];chain.insert(0,style);sid=val(style,'basedOn')
                return chain
            rels=xml('word/_rels/document.xml.rels')
            relationships={r.get('Id'):r for r in rels} if rels is not None else {}
            numbering=xml('word/numbering.xml')
            abstracts={n.get(W+'abstractNumId'):n for n in numbering.findall(W+'abstractNum')} if numbering is not None else {}
            nums={n.get(W+'numId'):n for n in numbering.findall(W+'num')} if numbering is not None else {}
            counters={}
            image_cache={}; image_total=0; emitted_images=0
            def image(node):
                nonlocal image_total, emitted_images
                blip=node.find('.//'+A+'blip')
                rid=blip.get(R+'embed') if blip is not None else None
                if rid is None:
                    v=node.find('.//{urn:schemas-microsoft-com:vml}imagedata')
                    rid=v.get(R+'id') if v is not None else None
                rel=relationships.get(rid)
                if rel is None or rel.get('TargetMode')=='External':return {'kind':'text','text':'[Immagine non disponibile]'}
                path=posixpath.normpath(posixpath.join('word',rel.get('Target','')))
                if not path.startswith('word/media/') or path not in names:return {'kind':'text','text':'[Immagine non supportata]'}
                if path not in image_cache:
                    info=archive.getinfo(path)
                    if info.file_size>8*1024*1024 or image_total+info.file_size>32*1024*1024:raise ValueError('Image limits')
                    data=archive.read(path);image_total+=len(data)
                    if data.startswith(b'\x89PNG\r\n\x1a\n'):
                        from material_files import validate_png
                        validate_png(io.BytesIO(data),len(data));mime='image/png'
                    elif data.startswith(b'\xff\xd8\xff'):
                        validate_jpeg(data)
                        mime='image/jpeg'
                    else:return {'kind':'text','text':'[Immagine non supportata]'}
                    image_cache[path]='data:'+mime+';base64,'+base64.b64encode(data).decode('ascii')
                extent=node.find('.//'+WP+'extent')
                width=number(extent.get('cx'),12700,1,1200) if extent is not None else None
                emitted_images += len(image_cache[path])
                if emitted_images > 48*1024*1024: raise ValueError('Repeated image payload limit')
                return {'kind':'image','src':image_cache[path],'width':width,'alt':'Immagine del documento'}
            def paragraph(node):
                ppr=node.find(W+'pPr');sid=val(ppr,'pStyle','val','Normal')
                ps=dict(default_p);rs=dict(default_r);level=None;numpr=None
                for style in style_chain(sid):
                    sp=style.find(W+'pPr');ps.update(properties(sp));rs.update(properties(style.find(W+'rPr')))
                    if val(sp,'outlineLvl') is not None:level=number(val(sp,'outlineLvl'),1,0,9)
                    if sp is not None and sp.find(W+'numPr') is not None:numpr=sp.find(W+'numPr')
                ps.update(properties(ppr))
                if val(ppr,'outlineLvl') is not None:level=number(val(ppr,'outlineLvl'),1,0,9)
                if ppr is not None and ppr.find(W+'numPr') is not None:numpr=ppr.find(W+'numPr')
                runs=[];nested=[]
                def walk(n,formatting):
                    if n.tag==W+'del':return
                    if n.tag==W+'r':
                        formatting=dict(formatting)
                        rp=n.find(W+'rPr')
                        for s in style_chain(val(rp,'rStyle')):formatting.update(properties(s.find(W+'rPr')))
                        formatting.update(properties(rp))
                    if n.tag==W+'txbxContent':
                        nested.extend(blocks(n));return
                    if n.tag in (W+'drawing',W+'pict'):
                        if n.find('.//'+W+'txbxContent') is not None:
                            for box in n.iter(W+'txbxContent'):nested.extend(blocks(box))
                        elif n.find('.//'+A+'blip') is not None or n.find('.//{urn:schemas-microsoft-com:vml}imagedata') is not None:runs.append(image(n))
                        return
                    if n.tag==W+'t':runs.append({'kind':'text','text':n.text or '', 'style':formatting});return
                    if n.tag in (W+'br',W+'cr',W+'tab'):
                        runs.append({'kind':'text','text':'\t' if n.tag==W+'tab' else '\n','style':formatting});return
                    if n.tag in (W+'pPr',W+'rPr'):return
                    for child in n:walk(child,formatting)
                walk(node,rs)
                result={'kind':'paragraph','text':''.join(r.get('text','') for r in runs),'runs':runs,'style':{**rs,**ps}}
                if level is not None and level<6:result['heading']=int(level)+1
                if numpr is not None:
                    numid=val(numpr,'numId');ilvl=val(numpr,'ilvl','val','0');num=nums.get(numid)
                    abstract=abstracts.get(val(num,'abstractNumId'))
                    lvl=next((n for n in abstract.findall(W+'lvl') if n.get(W+'ilvl')==ilvl),None) if abstract is not None else None
                    if lvl is not None:
                        fmt=val(lvl,'numFmt');key=(numid,ilvl)
                        counters[key]=counters.get(key,int(val(lvl,'start','val','1'))-1)+1
                        marker=val(lvl,'lvlText','val','%1.')
                        for i in range(1,10):marker=marker.replace('%'+str(i),str(counters.get((numid,str(i-1)),1)))
                        if fmt=='bullet' and marker not in ('-', '–', '—', '•', '○', '▪'):marker='•'
                        result['list']={'id':numid,'level':int(ilvl),'ordered':fmt!='bullet','marker':marker}
                return [result]+nested
            def blocks(parent):
                result=[]
                for node in parent:
                    if node.tag==W+'p':result.extend(paragraph(node))
                    elif node.tag==W+'tbl':
                        rows=[];cells=[]
                        for row in node.findall(W+'tr'):
                            parsed=[]
                            for cell in row.findall(W+'tc'):
                                content=blocks(cell);cp=cell.find(W+'tcPr')
                                parsed.append({'blocks':content,'span':int(number(val(cp,'gridSpan','val','1'),1,1,100)), 'style':properties(cp)})
                            cells.append(parsed)
                            rows.append(['\n'.join(b.get('text','') for b in c['blocks']) for c in parsed])
                        result.append({'kind':'table','rows':rows,'cells':cells})
                    elif node.tag in (W+'sdt',W+'sdtContent',W+'ins',W+'customXml'):result.extend(blocks(node))
                return result
            return blocks(body)
    except (ValueError, TypeError, ET.ParseError, zipfile.BadZipFile, KeyError, RuntimeError, RecursionError, NotImplementedError, EOFError, zlib.error, OSError) as error:
        raise PDFError(422,'corrupt','DOCX non leggibile, protetto o oltre i limiti.') from error
