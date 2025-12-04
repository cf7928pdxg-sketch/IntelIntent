<#
.SYNOPSIS
    Universal Creative Profile - Extends IntelIntent with scripture, temple, and art support

.DESCRIPTION
    Adds helper functions for creating and managing scriptures, temple designs, blueprints,
    and other creative works alongside code automation.
#>

# Source the base IntelIntent profile
. "$PSScriptRoot\IntelIntent-Profile.ps1"

# ============================================================
# Universal Creative Functions
# ============================================================

function New-Scripture {
    <#
    .SYNOPSIS
        Create a new scripture file with template

    .PARAMETER Name
        Name of the scripture (e.g., "Genesis", "Psalm23")

    .PARAMETER Author
        Author of the scripture

    .PARAMETER Type
        Type of sacred text (Scripture, Doctrine, Prophecy, Vision, Ritual)

    .EXAMPLE
        New-Scripture -Name "Genesis" -Author "Moses"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [string]$Author = "Unknown",

        [ValidateSet("Scripture", "Doctrine", "Prophecy", "Vision", "Ritual")]
        [string]$Type = "Scripture"
    )

    $extension = $Type.ToLower()
    $directory = ".\Scriptures"

    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $template = @"
# $Type`: $Name
## Author: $Author
## Date: $(Get-Date -Format 'yyyy-MM-dd')
## Status: Draft

---

### Introduction

[Begin your sacred text here...]

---

### Main Content

#### Section 1

[Content...]

---

### Commentary

**Historical Context:**
[Add context...]

**Symbolic Meaning:**
[Add interpretation...]

**Cross-References:**
- See also: [Reference]
- Related to: [Reference]

---

**Tags:** #$($Type.ToLower()) #draft
**Version:** 1.0.0
"@

    $path = Join-Path $directory "$Name.$extension"
    Set-Content -Path $path -Value $template -Encoding UTF8
    Write-Host "✅ Created $Type`: $path" -ForegroundColor Green
    code $path
}
Set-Alias -Name scripture -Value New-Scripture

function New-TempleDesign {
    <#
    .SYNOPSIS
        Create a new temple architecture file

    .PARAMETER Name
        Name of the temple

    .PARAMETER Type
        Type of architecture (Temple, Altar, Sanctuary, Complex)

    .EXAMPLE
        New-TempleDesign -Name "Solomon" -Type "Temple"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [ValidateSet("Temple", "Altar", "Sanctuary", "Complex")]
        [string]$Type = "Temple"
    )

    $directory = ".\Temples"

    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $template = @"
# Temple Architecture: $Name
type: $Type
created: $(Get-Date -Format 'yyyy-MM-dd')
status: Design Phase

---

## Overview
name: "$Name"
classification: "$Type"
purpose: "[Define sacred purpose]"

## Dimensions (cubits)
dimensions:
  length: 0
  width: 0
  height: 0

foundation:
  depth: 0
  material: "stone"
  pattern: "sacred geometry"

## Structural Elements
structure:
  walls:
    material: ""
    thickness: 0
    overlay: ""

  roof:
    material: ""
    design: ""

  chambers:
    - name: "[Chamber 1]"
      dimensions:
        length: 0
        width: 0
        height: 0
      purpose: ""
      features: []

## Sacred Geometry
geometry:
  patterns:
    - type: "golden ratio"
      application: ""
    - type: "vesica piscis"
      application: ""

  orientation:
    direction: "east"
    alignment: "sunrise equinox"

## Symbolism
symbolism:
  materials:
    - material: "gold"
      meaning: "divine glory"
    - material: "cedar"
      meaning: "incorruptibility"
    - material: "bronze"
      meaning: "judgment"

  spatial:
    - element: "Holy Place"
      symbolism: "priestly mediation"
    - element: "Holy of Holies"
      symbolism: "divine presence"

## References
references:
  scriptures: []
  historical: []
  archaeological: []

---

**Tags:** #temple #architecture #sacred-geometry
**Version:** 1.0.0
"@

    $path = Join-Path $directory "$Name.temple"
    Set-Content -Path $path -Value $template -Encoding UTF8
    Write-Host "✅ Created Temple: $path" -ForegroundColor Green
    code $path
}
Set-Alias -Name temple -Value New-TempleDesign

function New-Blueprint {
    <#
    .SYNOPSIS
        Create a new architectural blueprint

    .PARAMETER Name
        Name of the blueprint

    .PARAMETER Scale
        Scale of the blueprint (e.g., "1:100")

    .EXAMPLE
        New-Blueprint -Name "TempleComplex" -Scale "1:50"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [string]$Scale = "1:100"
    )

    $directory = ".\Blueprints"

    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $template = @"
# Blueprint: $Name
scale: "$Scale"
created: $(Get-Date -Format 'yyyy-MM-dd')

---

blueprint:
  project: "$Name"
  scale: "$Scale"
  units: "cubits"

  layers:
    - layer: "Foundation"
      elevation: 0
      elements:
        - type: "platform"
          dimensions: { length: 0, width: 0 }
          material: ""

    - layer: "Structure"
      elevation: 0
      elements:
        - type: "walls"
          thickness: 0
          material: ""

    - layer: "Roof"
      elevation: 0
      elements:
        - type: "covering"
          material: ""

  measurements:
    - name: "Total Length"
      value: 0
      unit: "cubits"
    - name: "Total Width"
      value: 0
      unit: "cubits"

  annotations:
    - location: "entrance"
      note: ""
    - location: "altar"
      note: ""

---

**Tags:** #blueprint #architecture #design
**Version:** 1.0.0
"@

    $path = Join-Path $directory "$Name.blueprint"
    Set-Content -Path $path -Value $template -Encoding UTF8
    Write-Host "✅ Created Blueprint: $path" -ForegroundColor Green
    code $path
}
Set-Alias -Name blueprint -Value New-Blueprint

function New-Doctrine {
    <#
    .SYNOPSIS
        Create a new doctrinal statement

    .PARAMETER Name
        Name of the doctrine

    .PARAMETER Category
        Category (Theology, Ecclesiology, Eschatology, etc.)

    .EXAMPLE
        New-Doctrine -Name "Trinitarian" -Category "Theology"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [string]$Category = "Theology"
    )

    $directory = ".\Doctrines"

    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    $template = @"
# Doctrine: $Name
## Category: $Category
## Date: $(Get-Date -Format 'yyyy-MM-dd')

---

### Statement of Belief

[Core doctrinal statement...]

---

### Biblical Foundation

**Primary Texts:**
- [Reference 1]
- [Reference 2]

**Supporting Texts:**
- [Reference 3]
- [Reference 4]

---

### Historical Development

**Early Church:**
[Historical context...]

**Councils/Creeds:**
[Formal declarations...]

**Modern Understanding:**
[Contemporary interpretation...]

---

### Practical Application

**For Believers:**
[Application...]

**For Community:**
[Community impact...]

---

### Related Doctrines

- [Related Doctrine 1]
- [Related Doctrine 2]

---

**Tags:** #doctrine #$($Category.ToLower())
**Version:** 1.0.0
"@

    $path = Join-Path $directory "$Name.doctrine"
    Set-Content -Path $path -Value $template -Encoding UTF8
    Write-Host "✅ Created Doctrine: $path" -ForegroundColor Green
    code $path
}
Set-Alias -Name doctrine -Value New-Doctrine

function Test-UniversalStructure {
    <#
    .SYNOPSIS
        Validate structure of scripture, temple, or blueprint file

    .PARAMETER Path
        Path to file to validate

    .EXAMPLE
        Test-UniversalStructure -Path ".\Scriptures\Genesis.scripture"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        Write-Host "❌ File not found: $Path" -ForegroundColor Red
        return $false
    }

    $extension = [System.IO.Path]::GetExtension($Path)
    $content = Get-Content $Path -Raw

    Write-Host "`n🔍 Validating $extension file..." -ForegroundColor Cyan

    switch ($extension) {
        ".scripture" {
            $requiredSections = @("Introduction", "Author", "Date")
            $valid = $true

            foreach ($section in $requiredSections) {
                if ($content -notmatch $section) {
                    Write-Host "  ⚠️  Missing section: $section" -ForegroundColor Yellow
                    $valid = $false
                }
            }

            if ($valid) {
                Write-Host "  ✅ Scripture structure valid" -ForegroundColor Green
            }
            return $valid
        }

        ".temple" {
            if ($content -match "temple:" -and $content -match "dimensions:" -and $content -match "structure:") {
                Write-Host "  ✅ Temple structure valid" -ForegroundColor Green
                return $true
            }
            else {
                Write-Host "  ❌ Invalid temple YAML structure" -ForegroundColor Red
                return $false
            }
        }

        ".blueprint" {
            if ($content -match "blueprint:" -and $content -match "layers:" -and $content -match "scale:") {
                Write-Host "  ✅ Blueprint structure valid" -ForegroundColor Green
                return $true
            }
            else {
                Write-Host "  ❌ Invalid blueprint structure" -ForegroundColor Red
                return $false
            }
        }

        ".doctrine" {
            if ($content -match "Statement of Belief" -and $content -match "Biblical Foundation") {
                Write-Host "  ✅ Doctrine structure valid" -ForegroundColor Green
                return $true
            }
            else {
                Write-Host "  ⚠️  Missing required doctrine sections" -ForegroundColor Yellow
                return $false
            }
        }

        default {
            Write-Host "  ⚠️  Unknown file type: $extension" -ForegroundColor Yellow
            return $false
        }
    }
}
Set-Alias -Name validate -Value Test-UniversalStructure

function Get-UniversalSummary {
    <#
    .SYNOPSIS
        Display summary of all creative works in workspace

    .EXAMPLE
        Get-UniversalSummary
    #>

    Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  Universal Creative Workspace Summary" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

    # Scriptures
    $scriptures = Get-ChildItem -Path ".\Scriptures" -Filter "*.scripture" -Recurse -ErrorAction SilentlyContinue
    Write-Host "📜 Scriptures: " -NoNewline -ForegroundColor Yellow
    Write-Host "$($scriptures.Count)" -ForegroundColor Green

    # Temples
    $temples = Get-ChildItem -Path ".\Temples" -Filter "*.temple" -Recurse -ErrorAction SilentlyContinue
    Write-Host "🏛️  Temples: " -NoNewline -ForegroundColor Yellow
    Write-Host "$($temples.Count)" -ForegroundColor Green

    # Blueprints
    $blueprints = Get-ChildItem -Path ".\Blueprints" -Filter "*.blueprint" -Recurse -ErrorAction SilentlyContinue
    Write-Host "📐 Blueprints: " -NoNewline -ForegroundColor Yellow
    Write-Host "$($blueprints.Count)" -ForegroundColor Green

    # Doctrines
    $doctrines = Get-ChildItem -Path ".\Doctrines" -Filter "*.doctrine" -Recurse -ErrorAction SilentlyContinue
    Write-Host "📖 Doctrines: " -NoNewline -ForegroundColor Yellow
    Write-Host "$($doctrines.Count)" -ForegroundColor Green

    # PowerShell Scripts
    $scripts = Get-ChildItem -Path . -Filter "*.ps1" -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch "\\node_modules\\" }
    Write-Host "💻 PowerShell Scripts: " -NoNewline -ForegroundColor Yellow
    Write-Host "$($scripts.Count)" -ForegroundColor Green

    Write-Host ""
}
Set-Alias -Name summary -Value Get-UniversalSummary

# ============================================================
# Universal Startup Banner
# ============================================================

function Show-UniversalBanner {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  IntelIntent Universal Creative Workspace" -ForegroundColor Cyan
    Write-Host "  Code • Scriptures • Architecture • Art" -ForegroundColor DarkCyan
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Universal Commands:" -ForegroundColor Yellow
    Write-Host "  scripture      - Create new scripture" -ForegroundColor Gray
    Write-Host "  temple         - Create new temple design" -ForegroundColor Gray
    Write-Host "  blueprint      - Create new blueprint" -ForegroundColor Gray
    Write-Host "  doctrine       - Create new doctrinal statement" -ForegroundColor Gray
    Write-Host "  validate       - Validate file structure" -ForegroundColor Gray
    Write-Host "  summary        - Show workspace summary" -ForegroundColor Gray
    Write-Host ""
    Write-Host "PowerShell Commands:" -ForegroundColor Yellow
    Write-Host "  iidry          - Run Week1 automation (DryRun)" -ForegroundColor Gray
    Write-Host "  iicp           - View checkpoints" -ForegroundColor Gray
    Write-Host "  iimod          - Check module status" -ForegroundColor Gray
    Write-Host ""
}

# Show banner on profile load (uncomment to enable)
# Show-UniversalBanner
