
# UMMS DocFX Package

**Generated:** 2025-08-16

This package turns your recursive `docs/` + `domains/` content into a **professional DocFX catalog**.

## Quick Start
1. Install DocFX (either `choco install docfx` or `dotnet tool install -g docfx`).
2. Run the VS Code task **DocFX: Generate TOCs**.
3. Run **DocFX: Serve** to build and open `http://localhost:8080/`.

> DocFX commands `docfx build` and `--serve` are documented in the official CLI reference.

## Files
- `docfx.json` — DocFX configuration (content inputs, theme, metadata)
- `toc.yml` — Top navigation
- `index.md` — Landing page with front matter
- `docfx_project/make_toc.py` — Generates `domains/<domain>/toc.yml` from `structure.yaml`
- `.github/workflows/publish-docfx.yml` — Build & publish to **GitHub Pages**

## Publish to GitHub Pages
Enable **Pages** in your repo settings, then the workflow will deploy after `main` changes or on manual dispatch.
