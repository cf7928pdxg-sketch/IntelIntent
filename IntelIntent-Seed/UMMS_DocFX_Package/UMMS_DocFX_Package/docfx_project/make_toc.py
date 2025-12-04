#!/usr/bin/env python3
"""
Generate DocFX TOCs from structure.yaml
- Creates toc.yml at repo root (navbar) if missing
- Creates toc.yml under each domain folder to list portfolios/modules

Usage:
  python docfx_project/make_toc.py --structure docs/00-foundations/structure.yaml
"""
import argparse, yaml, os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def write(p: Path, text: str):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(text.rstrip()+"\n", encoding='utf-8')


def make_domain_toc(domain: str, portfolios):
    lines = [f"- name: {domain.title()}\n  items:"]
    for p in portfolios:
        if isinstance(p, dict):
            pname = list(p.keys())[0]
            modules = p[pname].get('modules', [])
        else:
            continue
        lines.append(f"  - name: {pname} \n    items:")
        for m in modules:
            lines.append(f"      - name: {m}\n        href: {m}/")
    return "\n".join(lines)+"\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--structure', default='docs/00-foundations/structure.yaml')
    args = ap.parse_args()
    struct = yaml.safe_load((ROOT / args.structure).read_text(encoding='utf-8'))
    # Root TOC is provided separately; here we focus on domain TOCs
    for d in struct.get('domains', []):
        dname = d.get('name')
        portfolios = d.get('portfolios') or struct.get('portfolio_templates', [])
        toc_text = make_domain_toc(dname, portfolios)
        write(ROOT / 'domains' / dname / 'toc.yml', toc_text)
    print('Domain TOCs generated.')

if __name__ == '__main__':
    main()
