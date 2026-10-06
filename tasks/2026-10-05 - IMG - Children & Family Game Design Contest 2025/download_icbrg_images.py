"""Scarica solo gli URL Original osservati nelle pagine BGG, senza inventare endpoint."""
from pathlib import Path
from urllib.request import Request,urlopen
import hashlib,json
from PIL import Image
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'outputs/tsk0068/icbrg/remote'
URLS=[
'https://cf.geekdo-images.com/0YuhMDLc4HYTEd0fo-LmWw__original/img/zmx_C0QigyFR8vA3WAzORBeGK1o=/0x0/filters:format(jpeg)/pic8819477.jpg',
'https://cf.geekdo-images.com/B5iGXapz32PGSsaue2oe8w__original/img/s-ycfEE5uaN7tHPQTn6ituQX0XY=/0x0/filters:format(jpeg)/pic8895515.jpg',
'https://cf.geekdo-images.com/KY4xTpDFfpitvZGwaT-cZg__original/img/IKfHKc3uZrhNjhozTeztXl-meYU=/0x0/filters:format(jpeg)/pic8895516.jpg',
'https://cf.geekdo-images.com/XLEBD5ifif1LbzbO05EvfQ__original/img/eh1eyUzcUtzbCYelNz2AfMBtywA=/0x0/filters:format(jpeg)/pic8819478.jpg',
'https://cf.geekdo-images.com/zw7dSN4-Bp6-AszjchVuHA__original/img/lR3aeGCrjUKOl4e9-myxEfWbvJs=/0x0/filters:format(jpeg)/pic8819479.jpg',
'https://cf.geekdo-images.com/hIVlzK3wanZbaM3bfuJf-g__original/img/Sc-qXxS3qUCPY3LdVyTiYgMYiPw=/0x0/filters:format(png)/pic8824311.png',
'https://cf.geekdo-images.com/cNfj5LSzjQaY1CpaMnvv7Q__original/img/7FOp5a5w33s7CNXC1DjD_AY1t5w=/0x0/filters:format(png)/pic8825001.png',
'https://cf.geekdo-images.com/oyYcPYn7ErPBoHF_InJAHg__original/img/7UE7cVixdlcVbFRic3RNe0D4ecw=/0x0/filters:format(png)/pic8832313.png',
'https://cf.geekdo-images.com/fbkMr2g4N0jAGP-nBvX3sA__original/img/w1dfIqWeA3blJUN4KEbzwmTwRfo=/0x0/filters:format(png)/pic8855215.png']
def main():
    OUT.mkdir(parents=True,exist_ok=True); rows=[]
    for u in URLS:
        p=OUT/u.split('/')[-1]
        if not p.exists():
            with urlopen(Request(u,headers={'User-Agent':'Mozilla/5.0'}),timeout=45) as r: data=r.read()
            p.write_bytes(data)
        with Image.open(p) as im: im.verify()
        with Image.open(p) as im: w,h=im.size; fmt=im.format
        rows.append(dict(bgg_image_id=int(p.stem[3:]),url=u,path=p.relative_to(ROOT).as_posix(),width=w,height=h,format=fmt,bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
    (OUT/'downloads.json').write_text(json.dumps(rows,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(rows))
if __name__=='__main__':main()
