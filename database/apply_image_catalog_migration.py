"""Migration 014, inspection by default. Explicit --apply/--authorization needed."""
import argparse
import json
from pathlib import Path
from image_catalog import ROOT, apply_migration, installed, open_db, require, validate

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--database',type=Path,required=True)
    p.add_argument('--apply',action='store_true')
    p.add_argument('--authorization',default='')
    p.add_argument('--backup-dir',type=Path,default=ROOT/'outputs/image-catalog-014')
    p.add_argument('--report',type=Path)
    a=p.parse_args()
    if a.report:
        require(a.report.resolve()!=a.database.resolve()
                and not a.report.resolve().is_relative_to((ROOT/'library').resolve()),
                'Report cannot overwrite database or acquired library')
    if a.apply:
        report=apply_migration(a.database,a.backup_dir,a.authorization)
    else:
        with open_db(a.database) as db:
            validate(db)
            report={'outcome':'inspection_only','installed':installed(db)}
    if a.report:
        a.report.parent.mkdir(parents=True,exist_ok=True)
        a.report.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps(report,ensure_ascii=False))

if __name__=='__main__':
    main()
