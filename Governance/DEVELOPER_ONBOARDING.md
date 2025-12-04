# 🚀 Developer Onboarding Guide - IntelIntent Governance

**Welcome to IntelIntent!** This guide will get you set up with local compliance checks, PDF generation, and automated workflows in **under 10 minutes**.

---

## 📋 Prerequisites

Before you begin, ensure you have:

- ✅ **PowerShell 7+** - `pwsh --version` (Core, not Windows PowerShell 5.1)
- ✅ **Git** - `git --version`
- ✅ **Azure CLI** - `az --version` (for Azure deployments)
- ✅ **VS Code** - With PowerShell extension installed

**Optional (for PDF generation):**
- **Pandoc** - `pandoc --version` ([winget install Pandoc.Pandoc](https://pandoc.org/installing.html))
- **MiKTeX/TeX Live** - For XeLaTeX PDF engine ([miktex.org](https://miktex.org/download))
- **wkhtmltopdf** - Fallback PDF engine ([winget install wkhtmltopdf.wkhtmltopdf](https://wkhtmltopdf.org/downloads.html))

---

## ⚡ Quick Start (5 Minutes)

### 1. Clone Repository

```powershell
git clone https://github.com/cf7928pdxg-sketch/IntelIntent.git
cd IntelIntent
```

### 2. Verify Development Environment

```powershell
# Check PowerShell version (must be 7.0+)
pwsh --version

# Verify Azure CLI authentication
az account show

# If not logged in:
az login
```

### 3. Run Compliance Verification

```powershell
# First-time check (skips export validation)
.\Governance\Verify-Compliance.ps1 -SkipExportCheck -Verbose

# Expected output:
# ✅ Passed: 4 / 5 (80%)
# ⚠️ Warnings: 1
# ❌ Errors: 0
```

**Common First-Time Issues:**
- ⚠️ `Week1_Checkpoints.json not found` → **Normal** (run `.\Week1_Automation.ps1 -DryRun` to generate)
- ⚠️ `Telemetry enabled` → **Acceptable** (just requires user disclosure for GDPR)
- ❌ `LICENSE file not found` → **Fixed** (already added in repo)

### 4. Test Week 1 Automation (DryRun)

```powershell
# Safe simulation mode (no Azure changes)
.\Week1_Automation.ps1 -DryRun -SkipEmail

# Output: Creates Week1_Checkpoints.json with 26 skipped tasks
```

### 5. Generate Sample PDF

```powershell
# Automatic method selection (tries all 3 fallback methods)
.\Governance\Generate-CompliancePDF.ps1

# Or use VS Code Markdown PDF extension:
code .\Governance\Compliance_Summary.md
# Ctrl+Shift+P → "Markdown PDF: Export (pdf)"
```

---

## 🛠️ Development Workflow

### Pre-Commit Compliance Checks

**Option 1: Manual Pre-Commit Hook (Recommended)**

```powershell
# Create .git/hooks/pre-commit (no extension)
@'
#!/usr/bin/env pwsh
Write-Host "🔒 Running compliance checks..." -ForegroundColor Cyan
pwsh -File Governance/Verify-Compliance.ps1 -SkipExportCheck

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Compliance check failed - fix errors before committing" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Compliance checks passed" -ForegroundColor Green
exit 0
'@ | Set-Content .git/hooks/pre-commit -NoNewline

# Make executable (Git Bash/WSL)
chmod +x .git/hooks/pre-commit
```

**Option 2: Husky (Node.js Projects)**

```powershell
# Install Husky
npm install husky --save-dev
npx husky install

# Add pre-commit hook
npx husky add .husky/pre-commit "pwsh -File Governance/Verify-Compliance.ps1 -SkipExportCheck"
```

**Option 3: Manual Check Before Push**

```powershell
# Run before every git push
.\Governance\Verify-Compliance.ps1 -Verbose

# If passed, commit and push:
git add .
git commit -m "feat: implement SecureSecretsManager.psm1"
git push
```

---

## 📄 PDF Generation (Multiple Methods)

### Method 1: Automated Script (Easiest)

```powershell
# Try all 3 conversion methods automatically
.\Governance\Generate-CompliancePDF.ps1

# Output: Governance/License_Compliance_Report.pdf
```

**What It Does:**
1. **Tries Pandoc + XeLaTeX** (best quality, requires MiKTeX)
2. **Falls back to Pandoc + wkhtmltopdf** (good quality)
3. **Falls back to PowerShell HTML → wkhtmltopdf** (always works)

### Method 2: Pandoc CLI (Professional Quality)

```powershell
# High-quality PDF with table of contents
pandoc .\Governance\Compliance_Summary.md `
    -o .\Governance\Compliance_Summary.pdf `
    --from markdown `
    --pdf-engine=xelatex `
    --toc `
    --metadata title="IntelIntent Governance Compliance Summary" `
    --metadata date="November 2025" `
    --highlight-style tango `
    --number-sections `
    --variable mainfont="Calibri" `
    --variable geometry:margin=1in
```

**Pandoc Options Explained:**
- `--toc` → Table of contents with hyperlinks
- `--highlight-style tango` → Syntax highlighting for code blocks
- `--number-sections` → Numbered headings (1, 1.1, 1.2, etc.)
- `--variable mainfont="Calibri"` → Executive-friendly font
- `--variable geometry:margin=1in` → Professional margins

### Method 3: VS Code Extension (GUI)

```powershell
# Install extension (one-time)
code --install-extension yzane.markdown-pdf

# Open file and export
code .\Governance\Compliance_Summary.md
# Press Ctrl+Shift+P → "Markdown PDF: Export (pdf)"
```

### Method 4: PowerShell HTML Fallback (No Dependencies)

```powershell
# Uses built-in PowerShell ConvertFrom-Markdown
$markdown = Get-Content .\Governance\Compliance_Summary.md -Raw
$html = (ConvertFrom-Markdown -InputObject $markdown).Html

# Add Fluent 2 styling (full script in Generate-CompliancePDF.ps1)
# Then convert with wkhtmltopdf
```

---

## 🧪 Testing Checklist

Before submitting a PR, verify:

### 1. Compliance Verification

```powershell
# Run full compliance check
.\Governance\Verify-Compliance.ps1 -ResourceGroupLocation "centralus"

# Expected: All 5 checks passed
# ✅ License Attribution
# ✅ Usage Scope (ARM Tools)
# ✅ Telemetry Settings
# ✅ Export Compliance
# ✅ Checkpoint Schema
```

### 2. Module Tests (Pester)

```powershell
# Run all Pester tests
Invoke-Pester -Output Detailed

# Run specific module test
Invoke-Pester -Path .\Tests\SecureSecretsManager.Tests.ps1
```

### 3. PowerShell Script Analysis

```powershell
# Analyze current file
Invoke-ScriptAnalyzer -Path .\Week1_Automation.ps1 -Settings .\.vscode\PSScriptAnalyzerSettings.psd1

# Or use VS Code task: Ctrl+Shift+P → "Tasks: Run Task" → "PowerShell: Analyze Current File"
```

### 4. Week 1 Automation Dry Run

```powershell
# Test Week 1 automation without Azure changes
.\Week1_Automation.ps1 -DryRun -SkipEmail

# Verify checkpoint file created
Test-Path .\Week1_Checkpoints.json

# Validate checkpoint structure
$checkpoints = Get-Content .\Week1_Checkpoints.json | ConvertFrom-Json
$checkpoints.Checkpoints.Count  # Should be 26
```

---

## 🔧 Common Development Tasks

### Add New Checkpoint Task

```powershell
# In Week1_Automation.ps1, use this pattern:
Invoke-TaskWithCheckpoint `
    -TaskID "NEW-001" `
    -Description "Your task description" `
    -ScriptBlock {
        # Your implementation here
        return $result
    } `
    -Inputs @{ ParamName = $value } `
    -Artifacts @("ResourceName1", "ResourceName2")
```

### Create New Module

```powershell
# 1. Create module file
New-Item -Path .\IntelIntent_Seeding\MyNewModule.psm1 -ItemType File

# 2. Add module structure (see SecureSecretsManager.psm1 as template)
# 3. Export functions:
Export-ModuleMember -Function @('Function1', 'Function2')

# 4. Import in Week1_Automation.ps1:
Import-Module .\IntelIntent_Seeding\MyNewModule.psm1 -Force -ErrorAction SilentlyContinue
```

### Update Compliance Summary

```powershell
# 1. Edit Governance/Compliance_Summary.md
code .\Governance\Compliance_Summary.md

# 2. Regenerate PDF
.\Governance\Generate-CompliancePDF.ps1

# 3. Commit changes
git add Governance/Compliance_Summary.md Governance/License_Compliance_Report.pdf
git commit -m "docs: update compliance summary for Q4 2025"
```

---

## 🚨 Troubleshooting

### Issue: `Verify-Compliance.ps1` fails with JSON parse error

**Cause:** `.vscode/settings.json` has trailing commas (valid JSONC, invalid JSON)

**Solution:**
```powershell
# The script already handles JSONC with comments - this is expected behavior
# If telemetry check fails, manually verify:
Get-Content .\.vscode\settings.json | Select-String "enableTelemetry"

# Should show: "dotnetAcquisitionExtension.enableTelemetry": false
```

### Issue: PDF generation fails with "pandoc: command not found"

**Solution:**
```powershell
# Install Pandoc
winget install Pandoc.Pandoc

# Verify installation
pandoc --version

# Or use VS Code extension as fallback:
code --install-extension yzane.markdown-pdf
```

### Issue: XeLaTeX engine not found

**Solution:**
```powershell
# Option 1: Install MiKTeX (Windows)
winget install MiKTeX.MiKTeX

# Option 2: Use wkhtmltopdf fallback
.\Governance\Generate-CompliancePDF.ps1 -Method powershell-html

# Option 3: Use Pandoc with HTML engine
pandoc Compliance_Summary.md -o Compliance_Summary.pdf --pdf-engine=wkhtmltopdf
```

### Issue: Azure CLI not authenticated

**Solution:**
```powershell
# Login to Azure
az login

# Set active subscription
az account set --subscription "Your-Subscription-Name"

# Verify
az account show
```

### Issue: Pre-commit hook not executing

**Solution:**
```powershell
# Make hook executable (Git Bash/WSL)
chmod +x .git/hooks/pre-commit

# Test hook manually
pwsh -File .git/hooks/pre-commit

# Or bypass for emergency commits (not recommended):
git commit --no-verify -m "emergency: fix critical bug"
```

---

## 📚 Additional Resources

### Documentation Priority

1. **Start Here:** [WORKFLOW_MAP.md](../WORKFLOW_MAP.md) - Core user journey
2. **Then:** [WEEK1_IMPLEMENTATION_CHECKLIST.md](../WEEK1_IMPLEMENTATION_CHECKLIST.md) - Concrete tasks
3. **Deep Dive:** [PHASE4_ARCHITECTURE_DIAGRAM.md](../PHASE4_ARCHITECTURE_DIAGRAM.md) - Visual architecture
4. **Reference:** [.github/copilot-instructions.md](../.github/copilot-instructions.md) - AI agent guidance (2,803 lines)

### Key Modules

| Module | Lines | Status | Purpose |
|--------|-------|--------|---------|
| **SecureSecretsManager.psm1** | 608 | ✅ Complete | Azure Key Vault integration |
| **CircuitBreaker.psm1** | 530 | ✅ Complete | Retry logic, exponential backoff |
| **CodexRenderer.psm1** | 777 | ✅ Complete | Checkpoint → Markdown/HTML |
| **AgentBridge.psm1** | 447 | ✅ Complete | 6 specialized agents |
| **ManifestReader.ps1** | 323 | ✅ Complete | Manifest parsing |

### VS Code Tasks (Ctrl+Shift+P → "Tasks: Run Task")

- **Week1: Run DryRun Mode** - Safe automation test
- **Orchestrator: Generate Components** - Create components from manifests
- **Pester: Run All Tests** - Execute test suite
- **Module: Check Missing Modules** - Verify implementation status
- **Checkpoint: Validate Structure** - Check Week1_Checkpoints.json

### Essential Commands Reference

```powershell
# Dry run automation
.\Week1_Automation.ps1 -DryRun -SkipEmail

# Test module independently
.\IntelIntent_Launcher.ps1  # Interactive menu (1-9)

# Generate components from manifest
.\IntelIntent_Seeding\Orchestrator.ps1 -Mode GenerateOnly -Category "Identity_Modules"

# Validate checkpoint structure
Get-Content .\Week1_Checkpoints.json | ConvertFrom-Json | Format-Table TaskID, Status, Duration

# Check module implementation status
Get-ChildItem .\IntelIntent_Seeding\*.psm1 | ForEach-Object { 
    [PSCustomObject]@{ 
        Name = $_.Name
        Lines = (Get-Content $_.FullName).Count
    }
}
```

---

## 🎯 Next Steps After Onboarding

### Week 1: Familiarization
- [ ] Run `Week1_Automation.ps1 -DryRun` successfully
- [ ] Generate compliance PDF
- [ ] Review Codex Scroll output (`Sponsors/Week1_Codex_Scroll.html`)
- [ ] Explore agent functions in `AgentBridge.psm1`

### Week 2: First Contribution
- [ ] Implement placeholder module (see `REMAINING_MODULES_ROADMAP.md`)
- [ ] Write Pester tests for new module
- [ ] Run compliance verification
- [ ] Submit PR with checkpoint reference

### Month 1: Deep Integration
- [ ] Set up pre-commit hooks
- [ ] Configure VS Code tasks
- [ ] Run live `Week1_Automation.ps1` (non-DryRun)
- [ ] Review Power BI dashboard (once Phase 5 live)

---

## 🎉 Success Criteria

**You're ready for production development when you can:**

1. ✅ Run `Week1_Automation.ps1 -DryRun` without errors
2. ✅ Generate compliance PDF in under 30 seconds
3. ✅ Pass all 5 compliance verification checks
4. ✅ Create new checkpoint task with proper schema
5. ✅ Import and use `SecureSecretsManager.psm1` functions
6. ✅ Understand agent orchestration flow (see Mermaid diagrams in copilot-instructions.md)

---

## 💬 Getting Help

**Questions? Issues? Ideas?**

- 💬 **GitHub Discussions:** [IntelIntent Discussions](https://github.com/cf7928pdxg-sketch/IntelIntent/discussions)
- 🐛 **Bug Reports:** Use [GitHub Issues](https://github.com/cf7928pdxg-sketch/IntelIntent/issues) → "Bug Report" template
- 🔒 **Compliance Questions:** Use [GitHub Issues](https://github.com/cf7928pdxg-sketch/IntelIntent/issues) → "🔒 Compliance Review Request" template
- 📧 **Governance Team:** governance@intelintent.example.com
- 💬 **Slack:** #intelintent-dev

---

**🚀 Welcome to IntelIntent! Let's build something amazing together.**

*Last Updated: November 30, 2025*  
*Maintained By: IntelIntent Governance Team*
