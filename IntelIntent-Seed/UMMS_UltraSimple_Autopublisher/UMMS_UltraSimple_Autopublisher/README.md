
# UMMS Ultra‑Simple Autopublisher

**Generated:** 2025-08-16

This package gives you a one‑command experience:

- Post `publish kb` in your Teams channel → **Power Automate** calls GitHub **workflow_dispatch** → **single Action** provisions the SharePoint site (if needed) and publishes pages.

## Files
- `.github/workflows/publish-kb.yml` — single workflow that provisions + publishes.
- `power-automate/teams-ultrasimple.flow.json` — flow template (Teams trigger → GitHub `workflow_dispatch`).

## One‑time setup
1. Create a GitHub repo and add these files. Add secrets: `M365_TENANT`, `M365_APP_ID`, `M365_CERT_B64`, `M365_CERT_PASSPHRASE`.
2. Import the flow JSON. Map the Teams connection and set `GitHubPAT` (PAT with `repo` scope). Update the HTTP URI to your repo and the default `siteUrl`/`siteName` if desired.

## Notes
- The workflow uses **CLI for Microsoft 365** to create sites, libraries, fields, pages and upload files. (See CLI docs.)
- The flow uses the **Teams message trigger** and GitHub’s **Create a workflow dispatch event** API to start the run.

