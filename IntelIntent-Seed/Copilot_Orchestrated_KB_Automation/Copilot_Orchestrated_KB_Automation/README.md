
# Copilot-Orchestrated Knowledge Publisher (COKP)

**Generated:** 2025-08-16

This repo enables **hands-off** publishing of your recursive docs to **SharePoint**:

- `provision-m365` workflow: creates the site, libraries, columns, and landing page.
- `publish-kb` workflow: uploads Markdown, sets metadata, and creates **Site Pages** from MD → HTML content using **CLI for Microsoft 365**.

## One-time setup (admin)
1. Create an **Entra app** with **certificate** auth and grant:
   - Microsoft Graph **Sites.Selected** (App)
   - SharePoint **Sites.FullControl.All** or use Sites.Selected with resource-specific consent
2. Add secrets in the repo:
   - `M365_TENANT` (contoso.onmicrosoft.com)
   - `M365_APP_ID`
   - `M365_CERT_B64` (base64 of pfx)
   - `M365_CERT_PASSPHRASE`

> After this, publishing is **zero touch**: you can trigger workflows via **Teams** using a webhook or manually from GitHub.

## Use
- Run **provision-m365** with `siteUrl` and `siteName`.
- Run **publish-kb** with `siteUrl`.

## Notes
- Pages are created using `m365 spo page` commands with the MD content injected as HTML in a text web part.
- The workflow infers metadata (Domain/Portfolio/Module) from your folder path and file name.
- Extend to Power Automate later if you prefer flow-driven conversion.
