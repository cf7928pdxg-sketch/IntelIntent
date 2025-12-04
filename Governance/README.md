# 📋 IntelIntent Governance Bundle

## Purpose

This directory contains compliance documentation, license summaries, and governance artifacts for IntelIntent sponsors, auditors, and engineering leads.

---

## 📂 Contents

| Document | Purpose | Audience |
|----------|---------|----------|
| **Compliance_Summary.md** | One-page license overview, Do/Don't checklist, risk matrix | Sponsors, Auditors |
| **License_Compliance_Report.pdf** | PDF export of Compliance_Summary.md | Executive review, governance bundles |
| **Extension_Licenses/** | Full license text for all VS Code extensions | Legal, Compliance teams |

---

## 🔄 PDF Generation

### Option 1: VS Code Markdown PDF Extension

```powershell
# 1. Install extension
code --install-extension yzane.markdown-pdf

# 2. Open Compliance_Summary.md in VS Code
code .\Governance\Compliance_Summary.md

# 3. Press Ctrl+Shift+P → "Markdown PDF: Export (pdf)"
# Output: Governance/Compliance_Summary.pdf
```

### Option 2: Pandoc Command Line

```powershell
# 1. Install Pandoc
winget install Pandoc.Pandoc

# 2. Convert to PDF
pandoc .\Governance\Compliance_Summary.md `
    -o .\Governance\License_Compliance_Report.pdf `
    --pdf-engine=wkhtmltopdf `
    --metadata title="IntelIntent License Compliance Report" `
    --metadata date="$(Get-Date -Format 'MMMM yyyy')"

# Alternative with LaTeX engine (requires MiKTeX)
pandoc .\Governance\Compliance_Summary.md `
    -o .\Governance\License_Compliance_Report.pdf `
    --pdf-engine=xelatex `
    -V geometry:margin=1in
```

### Option 3: PowerShell HTML → PDF

```powershell
# Using wkhtmltopdf (lightweight, no LaTeX required)
# 1. Install wkhtmltopdf
winget install wkhtmltopdf.wkhtmltopdf

# 2. Convert Markdown → HTML → PDF
$markdown = Get-Content .\Governance\Compliance_Summary.md -Raw
$html = ConvertFrom-Markdown -InputObject $markdown | Select-Object -ExpandProperty Html

# Add CSS styling
$styledHtml = @"
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 40px; }
        h1 { color: #0078D4; border-bottom: 3px solid #0078D4; }
        h2 { color: #005A9E; margin-top: 30px; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #0078D4; color: white; }
        .emoji { font-size: 1.2em; }
    </style>
</head>
<body>
$html
</body>
</html>
"@

Set-Content -Path .\Governance\Compliance_Summary.html -Value $styledHtml

# Convert HTML to PDF
wkhtmltopdf --enable-local-file-access `
    .\Governance\Compliance_Summary.html `
    .\Governance\License_Compliance_Report.pdf
```

---

## 📅 Maintenance Schedule

- **Monthly:** Review for new extension additions/deprecations
- **Quarterly:** Verify licensing terms for changed extensions
- **Annually:** Audit export compliance and GDPR requirements
- **Ad-hoc:** Update before sponsor presentations or audits

---

## 🔗 Related Documentation

- [Licensing & Compliance Guidelines](../.github/copilot-instructions.md#licensing--compliance-guidelines) - Detailed compliance section in AI agent instructions
- [VS Code Extensions](../.vscode/extensions.json) - Recommended extensions list
- [November 2025 Features](../.vscode/NOVEMBER_2025_FEATURES.md) - VS Code tooling documentation
- [Week 1 Implementation Checklist](../WEEK1_IMPLEMENTATION_CHECKLIST.md) - Deployment compliance requirements

---

## ⚠️ Important Notes

**ARM Tools Maintenance Mode:**
- Version 0.15.15 is in maintenance mode (no new features)
- Recommend migrating to Bicep for new infrastructure work
- Existing ARM templates remain fully supported

**Telemetry & Privacy:**
- .NET Install Tool telemetry enabled by default
- Disable via workspace settings: `"dotnetAcquisitionExtension.enableTelemetry": false`
- GDPR compliance requires user disclosure

**Export Restrictions:**
- EAR/ITAR regulations apply to deployments in: CN, RU, IR, KP, SY
- Verify compliance before Azure resource provisioning in restricted regions

---

**Last Updated:** November 2025  
**Maintained By:** IntelIntent Governance Team  
**Contact:** See [WORKFLOW_MAP.md](../WORKFLOW_MAP.md) for escalation paths
