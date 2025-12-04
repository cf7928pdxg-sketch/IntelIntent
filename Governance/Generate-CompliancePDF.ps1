# PDF Generation Script for Compliance_Summary.md
# Purpose: Convert Compliance_Summary.md to professional PDF for sponsor distribution
# Usage: .\Governance\Generate-CompliancePDF.ps1

<#
.SYNOPSIS
    Generates professional PDF from Compliance_Summary.md using multiple fallback methods.

.DESCRIPTION
    Attempts PDF generation using three methods in order:
    1. Pandoc with XeLaTeX (best quality, requires MiKTeX)
    2. Pandoc with wkhtmltopdf (good quality, lightweight)
    3. PowerShell HTML → wkhtmltopdf (fallback, always works)

.PARAMETER OutputPath
    Destination path for generated PDF (default: Governance/License_Compliance_Report.pdf)

.PARAMETER Method
    Force specific conversion method: "pandoc-xelatex", "pandoc-html", "powershell-html"

.EXAMPLE
    .\Governance\Generate-CompliancePDF.ps1
    # Uses automatic fallback method selection

.EXAMPLE
    .\Governance\Generate-CompliancePDF.ps1 -OutputPath "C:\Reports\Compliance_Q4_2025.pdf"

.EXAMPLE
    .\Governance\Generate-CompliancePDF.ps1 -Method "powershell-html" -Verbose
#>

param(
    [string]$OutputPath = ".\Governance\License_Compliance_Report.pdf",
    [ValidateSet("auto", "pandoc-xelatex", "pandoc-html", "powershell-html")]
    [string]$Method = "auto"
)

Write-Host "📄 IntelIntent Compliance PDF Generator" -ForegroundColor Cyan
Write-Host "Started: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host ("-" * 60) -ForegroundColor Gray

$inputMarkdown = ".\Governance\Compliance_Summary.md"

if (-not (Test-Path $inputMarkdown)) {
    Write-Error "❌ Source file not found: $inputMarkdown"
    exit 1
}

# =============================================================================
# METHOD 1: PANDOC WITH XELATEX (BEST QUALITY)
# =============================================================================
function Convert-WithPandocXeLaTeX {
    Write-Host "`n[Method 1] Attempting Pandoc with XeLaTeX..." -ForegroundColor Yellow

    $pandocAvailable = Get-Command pandoc -ErrorAction SilentlyContinue
    if (-not $pandocAvailable) {
        Write-Host "  ⏭️ Pandoc not found (install: winget install Pandoc.Pandoc)" -ForegroundColor Gray
        return $false
    }

    try {
        $metadata = @{
            title = "IntelIntent License Compliance Report"
            author = "Governance Team"
            date = (Get-Date -Format "MMMM yyyy")
            geometry = "margin=1in"
            fontsize = "11pt"
            linkcolor = "blue"
        }

        $metadataArgs = $metadata.GetEnumerator() | ForEach-Object { "-V", "$($_.Key):$($_.Value)" }

        pandoc $inputMarkdown `
            -o $OutputPath `
            --pdf-engine=xelatex `
            @metadataArgs `
            --toc `
            --highlight-style=tango `
            2>&1 | Out-Null

        if ($LASTEXITCODE -eq 0 -and (Test-Path $OutputPath)) {
            Write-Host "  ✅ PDF generated successfully with XeLaTeX" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "  ❌ XeLaTeX conversion failed: $_" -ForegroundColor Red
    }

    return $false
}

# =============================================================================
# METHOD 2: PANDOC WITH WKHTMLTOPDF (GOOD QUALITY)
# =============================================================================
function Convert-WithPandocWkhtml {
    Write-Host "`n[Method 2] Attempting Pandoc with wkhtmltopdf..." -ForegroundColor Yellow

    $pandocAvailable = Get-Command pandoc -ErrorAction SilentlyContinue
    $wkhtmlAvailable = Get-Command wkhtmltopdf -ErrorAction SilentlyContinue

    if (-not $pandocAvailable) {
        Write-Host "  ⏭️ Pandoc not found" -ForegroundColor Gray
        return $false
    }

    if (-not $wkhtmlAvailable) {
        Write-Host "  ⏭️ wkhtmltopdf not found (install: winget install wkhtmltopdf.wkhtmltopdf)" -ForegroundColor Gray
        return $false
    }

    try {
        pandoc $inputMarkdown `
            -o $OutputPath `
            --pdf-engine=wkhtmltopdf `
            --metadata title="IntelIntent License Compliance Report" `
            --metadata date="$(Get-Date -Format 'MMMM yyyy')" `
            2>&1 | Out-Null

        if ($LASTEXITCODE -eq 0 -and (Test-Path $OutputPath)) {
            Write-Host "  ✅ PDF generated successfully with wkhtmltopdf" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "  ❌ wkhtmltopdf conversion failed: $_" -ForegroundColor Red
    }

    return $false
}

# =============================================================================
# METHOD 3: POWERSHELL HTML → WKHTMLTOPDF (FALLBACK)
# =============================================================================
function Convert-WithPowerShellHtml {
    Write-Host "`n[Method 3] Attempting PowerShell HTML → wkhtmltopdf..." -ForegroundColor Yellow

    $wkhtmlAvailable = Get-Command wkhtmltopdf -ErrorAction SilentlyContinue

    if (-not $wkhtmlAvailable) {
        Write-Host "  ⏭️ wkhtmltopdf not found (install: winget install wkhtmltopdf.wkhtmltopdf)" -ForegroundColor Gray
        return $false
    }

    try {
        # Read markdown
        $markdownContent = Get-Content $inputMarkdown -Raw

        # Convert to HTML (basic - PowerShell 7+ has ConvertFrom-Markdown)
        if (Get-Command ConvertFrom-Markdown -ErrorAction SilentlyContinue) {
            $htmlBody = (ConvertFrom-Markdown -InputObject $markdownContent).Html
        } else {
            # Fallback: Basic markdown-to-HTML conversion
            $htmlBody = $markdownContent `
                -replace '### (.*)', '<h3>$1</h3>' `
                -replace '## (.*)', '<h2>$1</h2>' `
                -replace '# (.*)', '<h1>$1</h1>' `
                -replace '\*\*(.*?)\*\*', '<strong>$1</strong>' `
                -replace '\*(.*?)\*', '<em>$1</em>' `
                -replace '`([^`]+)`', '<code>$1</code>' `
                -replace '\n\n', '</p><p>' `
                -replace '\n', '<br>'

            $htmlBody = "<p>$htmlBody</p>"
        }

        # Add Fluent 2 styling
        $styledHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IntelIntent License Compliance Report</title>
    <style>
        body {
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
            color: #323130;
        }
        h1 {
            color: #0078D4;
            border-bottom: 3px solid #0078D4;
            padding-bottom: 10px;
            margin-top: 30px;
        }
        h2 {
            color: #005A9E;
            margin-top: 25px;
            border-left: 4px solid #0078D4;
            padding-left: 15px;
        }
        h3 {
            color: #106EBE;
            margin-top: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #EDEBE9;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #0078D4;
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #F3F2F1;
        }
        code {
            background-color: #F3F2F1;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 0.9em;
        }
        pre {
            background-color: #F3F2F1;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #0078D4;
            overflow-x: auto;
        }
        .emoji {
            font-size: 1.2em;
        }
        a {
            color: #0078D4;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        hr {
            border: none;
            border-top: 2px solid #EDEBE9;
            margin: 30px 0;
        }
        .footer {
            margin-top: 50px;
            padding-top: 20px;
            border-top: 2px solid #EDEBE9;
            font-size: 0.9em;
            color: #605E5C;
        }
    </style>
</head>
<body>
$htmlBody
<div class="footer">
    <p><strong>Document Control:</strong></p>
    <ul>
        <li><strong>Version:</strong> 1.0</li>
        <li><strong>Generated:</strong> $(Get-Date -Format 'MMMM dd, yyyy HH:mm:ss')</li>
        <li><strong>Classification:</strong> Internal Use</li>
        <li><strong>Retention:</strong> 7 years (per compliance requirements)</li>
    </ul>
</div>
</body>
</html>
"@

        $tempHtml = [System.IO.Path]::GetTempFileName() + ".html"
        Set-Content -Path $tempHtml -Value $styledHtml -Encoding UTF8

        wkhtmltopdf --enable-local-file-access `
            --page-size Letter `
            --margin-top 20mm `
            --margin-bottom 20mm `
            --margin-left 20mm `
            --margin-right 20mm `
            --encoding UTF-8 `
            $tempHtml `
            $OutputPath `
            2>&1 | Out-Null

        Remove-Item $tempHtml -Force

        if ($LASTEXITCODE -eq 0 -and (Test-Path $OutputPath)) {
            Write-Host "  ✅ PDF generated successfully with PowerShell HTML" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Host "  ❌ PowerShell HTML conversion failed: $_" -ForegroundColor Red
    }

    return $false
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

$success = $false

if ($Method -eq "pandoc-xelatex") {
    $success = Convert-WithPandocXeLaTeX
} elseif ($Method -eq "pandoc-html") {
    $success = Convert-WithPandocWkhtml
} elseif ($Method -eq "powershell-html") {
    $success = Convert-WithPowerShellHtml
} else {
    # Auto mode - try all methods in order
    $success = Convert-WithPandocXeLaTeX
    if (-not $success) {
        $success = Convert-WithPandocWkhtml
    }
    if (-not $success) {
        $success = Convert-WithPowerShellHtml
    }
}

Write-Host "`n" ("-" * 60) -ForegroundColor Gray

if ($success) {
    $fileInfo = Get-Item $OutputPath
    Write-Host "🎉 PDF GENERATION SUCCESS" -ForegroundColor Green
    Write-Host "Output: $($fileInfo.FullName)" -ForegroundColor Cyan
    Write-Host "Size: $([math]::Round($fileInfo.Length / 1KB, 2)) KB" -ForegroundColor Cyan
    Write-Host "`n✅ Ready for sponsor distribution!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "🚨 PDF GENERATION FAILED" -ForegroundColor Red
    Write-Host "All methods failed. Install dependencies:" -ForegroundColor Yellow
    Write-Host "  winget install Pandoc.Pandoc" -ForegroundColor Yellow
    Write-Host "  winget install wkhtmltopdf.wkhtmltopdf" -ForegroundColor Yellow
    Write-Host "`nAlternative: Use VS Code Markdown PDF extension" -ForegroundColor Yellow
    Write-Host "  code --install-extension yzane.markdown-pdf" -ForegroundColor Yellow
    exit 1
}
