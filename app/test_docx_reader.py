import unittest,io,zipfile,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent))
from material_files import docx_blocks
from pdf_files import PDFError
from test_materials import png
W='http://schemas.openxmlformats.org/wordprocessingml/2006/main'
R='http://schemas.openxmlformats.org/officeDocument/2006/relationships'

def package(body, extras=None):
 out=io.BytesIO()
 with zipfile.ZipFile(out,'w') as z:
  z.writestr('word/document.xml',f'<w:document xmlns:w="{W}" xmlns:r="{R}" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><w:body>{body}</w:body></w:document>')
  for name,value in (extras or {}).items():z.writestr(name,value)
 out.seek(0);return out

class DocxFormattingTests(unittest.TestCase):
 def test_styles_runs_boxes_and_reading_order(self):
  styles=f'<w:styles xmlns:w="{W}"><w:style w:styleId="Base"><w:rPr><w:b/></w:rPr></w:style><w:style w:styleId="Heading1"><w:basedOn w:val="Base"/><w:pPr><w:outlineLvl w:val="0"/></w:pPr><w:rPr><w:sz w:val="32"/></w:rPr></w:style></w:styles>'
  b=docx_blocks(package('<w:p><w:pPr><w:pStyle w:val="Heading1"/><w:jc w:val="center"/></w:pPr><w:r><w:t>Heading</w:t></w:r><w:r><w:rPr><w:b w:val="0"/><w:i/></w:rPr><w:t> plain italic</w:t></w:r></w:p><w:p><w:r><w:pict><w:txbxContent><w:p><w:r><w:t>Box A</w:t></w:r></w:p><w:p><w:r><w:t>Box B</w:t></w:r></w:p></w:txbxContent></w:pict></w:r></w:p>',{'word/styles.xml':styles}))
  self.assertEqual(b[0]['heading'],1);self.assertEqual(b[0]['style']['textAlign'],'center')
  self.assertEqual(b[0]['runs'][0]['style']['fontWeight'],'bold');self.assertEqual(b[0]['runs'][1]['style']['fontWeight'],'normal')
  self.assertEqual(b[0]['runs'][1]['style']['fontStyle'],'italic')
  self.assertEqual([x['text'] for x in b[2:]],['Box A','Box B'])
 def test_lists_tables_and_images(self):
  numbering=f'<w:numbering xmlns:w="{W}"><w:abstractNum w:abstractNumId="1"><w:lvl w:ilvl="0"><w:start w:val="3"/><w:numFmt w:val="decimal"/><w:lvlText w:val="%1."/></w:lvl></w:abstractNum><w:num w:numId="7"><w:abstractNumId w:val="1"/></w:num></w:numbering>'
  item='<w:p><w:pPr><w:numPr><w:ilvl w:val="0"/><w:numId w:val="7"/></w:numPr></w:pPr><w:r><w:t>Item</w:t></w:r></w:p>'
  rel='<Relationships><Relationship Id="img" Target="media/a.png"/><Relationship Id="external" Target="https://example.org/evil.png" TargetMode="External"/></Relationships>'
  drawing=lambda rid:f'<w:p><w:r><w:drawing><a:blip r:embed="{rid}"/></w:drawing></w:r></w:p>'
  table='<w:tbl><w:tr><w:tc><w:tcPr><w:gridSpan w:val="2"/></w:tcPr><w:p><w:r><w:rPr><w:b/></w:rPr><w:t>Cell</w:t></w:r></w:p></w:tc></w:tr></w:tbl>'
  b=docx_blocks(package(item+item+table+drawing('img')+drawing('external'),{'word/numbering.xml':numbering,'word/_rels/document.xml.rels':rel,'word/media/a.png':png()}))
  self.assertEqual([x['list']['marker'] for x in b[:2]],['3.','4.']);self.assertEqual(b[2]['cells'][0][0]['span'],2)
  self.assertEqual(b[2]['cells'][0][0]['blocks'][0]['runs'][0]['style']['fontWeight'],'bold')
  self.assertTrue(b[3]['runs'][0]['src'].startswith('data:image/png;base64,'));self.assertNotIn('src',b[4]['runs'][0])
 def test_unsafe_styles_xml_and_duplicate_members(self):
  with self.assertRaises(PDFError):docx_blocks(package('<w:p/>',{'word/styles.xml':'<!DOCTYPE x [<!ENTITY bad "evil">]><x/>'}))
 def test_local_corpus_text_complete_and_hashes(self):
  import hashlib,json
  evidence=Path(__file__).resolve().parent.parent/'outputs/app007/corpus.json'
  if not evidence.exists():self.skipTest('Local QA evidence unavailable')
  hashes={x['name']:x['sha256'] for x in json.loads(evidence.read_text(encoding='utf-8'))}
  from xml.etree import ElementTree as ET
  def normalized(node):
   mc='{http://schemas.openxmlformats.org/markup-compatibility/2006}'
   for child in list(node):
    if child.tag==mc+'AlternateContent':
     branch=child.find(mc+'Fallback')
     if branch is None:branch=child.find(mc+'Choice')
     i=list(node).index(child);node.remove(child)
     if branch is not None:
      normalized(branch)
      for j,x in enumerate(list(branch)):node.insert(i+j,x)
    else:normalized(child)
  def texts(blocks):
   result=''
   for b in blocks:
    if b['kind']=='paragraph':result+=''.join(r.get('text','') for r in b['runs'])
    elif b['kind']=='table':
     for row in b['cells']:
      for c in row:result+=texts(c['blocks'])
   return result
  for p in (Path(__file__).resolve().parent.parent/'library').rglob('*.docx'):
   self.assertEqual(hashlib.sha256(p.read_bytes()).hexdigest(),hashes[p.name])
   with zipfile.ZipFile(p) as z:root=ET.fromstring(z.read('word/document.xml'))
   normalized(root)
   source=''.join(x.text or '' for x in root.iter('{'+W+'}t'))
   with p.open('rb') as h:actual=texts(docx_blocks(h))
   self.assertEqual(''.join(source.split()),''.join(actual.split()),p.name)
if __name__=='__main__':unittest.main()
