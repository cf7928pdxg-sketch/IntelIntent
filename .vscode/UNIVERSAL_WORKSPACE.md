# Universal Creative Workspace Configuration

## 🌍 Multi-Domain Support

This VS Code workspace is configured to support **multiple creative disciplines**:

### 1. **💻 Code & Automation (PowerShell)**
- Infrastructure orchestration
- Automation scripts
- Agent-based systems
- Checkpoint-driven workflows

### 2. **📜 Scriptures & Doctrine**
- Sacred text composition
- Doctrinal frameworks
- Ritual instructions
- Prophecies and visions

### 3. **🏛️ Temple Architecture & Design**
- Structural blueprints
- Sacred geometry
- Spatial planning
- Symbolic layouts

### 4. **🎨 Creative Art & Expression**
- Visual design patterns
- Aesthetic frameworks
- Symbolic representations
- Multi-modal compositions

---

## 📁 Universal File Type Support

### Code Files
- `.ps1`, `.psm1`, `.psd1` - PowerShell scripts/modules
- `.json`, `.jsonc` - Configuration and manifests
- `.yaml`, `.yml` - Structured data and templates

### Scripture Files (Markdown-based)
- `.scripture` - Sacred text compositions
- `.doctrine` - Doctrinal statements
- `.ritual` - Ceremonial instructions
- `.prophecy` - Prophetic declarations
- `.vision` - Visionary experiences

### Architecture Files (YAML/Diagram-based)
- `.temple` - Temple structural definitions
- `.blueprint` - Architectural plans
- `.geometry` - Sacred geometry patterns
- `.layout` - Spatial arrangements

### Creative Files
- `.md` - Documentation and narrative
- `.drawio` - Visual diagrams (with Draw.io extension)
- `.puml` - PlantUML architectural diagrams
- `.mermaid` - Mermaid diagram definitions

---

## 🎯 Universal Workflows

### Creative Composition Workflow
```powershell
# 1. Create new work in appropriate format
New-Item -ItemType File -Path ".\Scriptures\Genesis.scripture"
New-Item -ItemType File -Path ".\Temples\Solomon.temple"

# 2. Edit with VS Code IntelliSense and formatting
code Genesis.scripture

# 3. Validate structure (custom validators)
.\Scripts\Validate-Scripture.ps1 -Path ".\Scriptures\Genesis.scripture"
.\Scripts\Validate-Temple.ps1 -Path ".\Temples\Solomon.temple"

# 4. Generate derived artifacts
.\Scripts\Render-Scripture.ps1 -Format HTML
.\Scripts\Render-Temple.ps1 -Format 3D
```

### Multi-Modal Creation Workflow
```
Concept/Vision
     │
     ├─► Scripture Form (.scripture) ─► Markdown/HTML
     │
     ├─► Temple Form (.temple) ───────► YAML → 3D Model
     │
     ├─► Code Form (.ps1) ────────────► Automation
     │
     └─► Art Form (.drawio) ──────────► Visual Diagram
```

---

## 🛠️ Extended Tool Support

### Visual Architecture Tools
- **Draw.io** (`.drawio`) - Temple diagrams, sacred geometry
- **PlantUML** (`.puml`) - System architecture, relationships
- **Mermaid** (`.mermaid`) - Flow diagrams, state machines

### Document Enhancement
- **Markdown All-in-One** - Scripture formatting, TOC generation
- **Better Comments** - Annotate code with intention tags
- **Indent Rainbow** - Visual hierarchy for nested structures

### Spell Checking
- **Code Spell Checker** - Validates terminology across all file types
- Custom dictionaries for domain-specific terms (theological, architectural)

---

## 📋 Universal Tasks

### Creative Work Tasks (Added to `tasks.json`)

#### Scripture Tasks
```json
{
  "label": "Scripture: Validate Structure",
  "type": "shell",
  "command": "pwsh",
  "args": ["-File", "${workspaceFolder}/Scripts/Validate-Scripture.ps1", "-Path", "${file}"]
}
```

#### Temple Architecture Tasks
```json
{
  "label": "Temple: Generate Blueprint",
  "type": "shell",
  "command": "pwsh",
  "args": ["-File", "${workspaceFolder}/Scripts/Render-Temple.ps1", "-Path", "${file}"]
}
```

#### Art Generation Tasks
```json
{
  "label": "Art: Export Diagram",
  "type": "shell",
  "command": "draw.io",
  "args": ["--export", "--format", "png", "${file}"]
}
```

---

## 🎨 Custom File Type Patterns

### Scripture File Format (`.scripture`)
```markdown
# Book: Genesis
## Author: Moses
## Date: ~1400 BCE

### Chapter 1: Creation

> In the beginning, God created the heavens and the earth.

**Verse 1** - Divine initiation of existence
- Hebrew: בְּרֵאשִׁית (Bereshit)
- Context: Cosmological foundation

---

**Commentary:**
This verse establishes the foundational principle...
```

### Temple Architecture Format (`.temple`)
```yaml
temple:
  name: "Solomon's Temple"
  type: "Sacred Architecture"
  dimensions:
    length: 60 cubits
    width: 20 cubits
    height: 30 cubits
  
  structure:
    foundation:
      material: "hewn stone"
      pattern: "sacred geometry"
    
    chambers:
      - name: "Holy Place"
        dimensions: { length: 40, width: 20, height: 30 }
        purpose: "priestly service"
      
      - name: "Holy of Holies"
        dimensions: { length: 20, width: 20, height: 20 }
        purpose: "divine presence"
        contains: ["Ark of Covenant", "Cherubim"]
  
  symbolism:
    orientation: "east-facing (toward sunrise)"
    materials:
      - gold: "divine glory"
      - cedar: "incorruptibility"
      - bronze: "judgment"
```

### Blueprint Format (`.blueprint`)
```yaml
blueprint:
  project: "Temple Complex"
  scale: "1:100"
  
  layers:
    - layer: "Foundation"
      elements:
        - type: "platform"
          elevation: 0
          material: "limestone"
    
    - layer: "Structure"
      elements:
        - type: "walls"
          thickness: 6 cubits
          material: "stone with cedar overlay"
    
    - layer: "Sacred Geometry"
      patterns:
        - type: "golden ratio"
          application: "chamber proportions"
        - type: "vesica piscis"
          application: "doorway design"
```

---

## 🔧 Universal Helper Scripts

### Create New Scripture
```powershell
function New-Scripture {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,
        
        [string]$Author,
        [string]$Type = "Scripture"
    )
    
    $template = @"
# $Type: $Name
## Author: $Author
## Date: $(Get-Date -Format 'yyyy-MM-dd')

### Introduction

[Begin your sacred text here...]

---

**Commentary:**
[Add contextual notes...]
"@
    
    $path = ".\Scriptures\$Name.scripture"
    Set-Content -Path $path -Value $template
    code $path
}
```

### Create New Temple Design
```powershell
function New-TempleDesign {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,
        
        [string]$Type = "Sacred Architecture"
    )
    
    $template = @"
temple:
  name: "$Name"
  type: "$Type"
  created: $(Get-Date -Format 'yyyy-MM-dd')
  
  dimensions:
    length: 0  # cubits
    width: 0   # cubits
    height: 0  # cubits
  
  structure:
    foundation:
      material: ""
      pattern: ""
    
    chambers: []
  
  symbolism:
    orientation: ""
    materials: []
"@
    
    $path = ".\Temples\$Name.temple"
    Set-Content -Path $path -Value $template
    code $path
}
```

### Validate Universal Structure
```powershell
function Test-UniversalStructure {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    $extension = [System.IO.Path]::GetExtension($Path)
    
    switch ($extension) {
        ".scripture" {
            # Validate scripture structure
            Write-Host "✅ Validating Scripture..." -ForegroundColor Cyan
            # Check for required sections, proper formatting
        }
        ".temple" {
            # Validate temple YAML
            Write-Host "✅ Validating Temple Architecture..." -ForegroundColor Cyan
            # Check YAML validity, required fields
        }
        ".blueprint" {
            # Validate blueprint structure
            Write-Host "✅ Validating Blueprint..." -ForegroundColor Cyan
            # Check layer definitions, geometry
        }
        default {
            Write-Host "⚠️  Unknown file type: $extension" -ForegroundColor Yellow
        }
    }
}
```

---

## 🎓 Best Practices for Universal Work

### 1. **Modular Composition**
- Break large works into modular files
- Use consistent naming conventions
- Maintain clear directory structure

### 2. **Version Control**
```powershell
# Track all creative work in Git
git add Scriptures/Genesis.scripture
git commit -m "feat(scripture): Add Genesis creation narrative"

git add Temples/Solomon.temple
git commit -m "feat(temple): Define Solomon's Temple structure"
```

### 3. **Cross-Reference System**
```markdown
<!-- In Genesis.scripture -->
See also: [Temple Structure](../Temples/Solomon.temple)
See also: [Sacred Geometry](../Blueprints/Foundation.blueprint)

<!-- In Solomon.temple -->
# References Genesis creation pattern
source: Scriptures/Genesis.scripture#Creation
```

### 4. **Symbolic Consistency**
- Maintain glossary of symbols
- Document symbolic meanings
- Cross-reference symbolic usage

---

## 🌟 Extension Ecosystem

### Installed Extensions (Universal Support)
1. **PowerShell** - Code automation
2. **GitHub Copilot** - AI-assisted creation across all domains
3. **YAML** - Structure definition (temples, blueprints)
4. **Markdown** - Scripture and documentation
5. **Draw.io** - Visual temple diagrams
6. **PlantUML** - System architecture
7. **Better Comments** - Intentional annotation
8. **Indent Rainbow** - Hierarchical visualization

---

## 🔮 Future Extensibility

### Custom Language Support (Future)
```json
// Add to settings.json
"files.associations": {
  "*.divine": "scripture",
  "*.sacred": "temple",
  "*.covenant": "doctrine"
}
```

### Custom Validators (Future)
```powershell
# Register custom validators
Register-UniversalValidator -Type "Scripture" -Validator {
    param($Content)
    # Validate scripture structure
}

Register-UniversalValidator -Type "Temple" -Validator {
    param($Content)
    # Validate temple YAML
}
```

### Custom Renderers (Future)
```powershell
# Render to multiple formats
Render-Universal -Path "Genesis.scripture" -Format HTML, PDF, EPUB
Render-Universal -Path "Solomon.temple" -Format 3D, SVG, Blueprint
```

---

## 💡 Pro Tips for Universal Work

1. **Use Copilot for All Domains** - GitHub Copilot understands context across code, scripture, and architecture
2. **Consistent Metadata** - Include author, date, and references in all files
3. **Visual Hierarchies** - Use Indent Rainbow to see nested structures clearly
4. **Better Comments** - Tag intentions: `# TODO:`, `# FIXME:`, `# NOTE:`, `# SACRED:`
5. **Cross-Domain References** - Link scriptures to temples to code seamlessly
6. **Version Everything** - All creative work deserves version control
7. **Modular Composition** - Small, focused files compose into larger works

---

## 🎉 You're Ready for Universal Creation!

Your workspace now supports:
- ✅ **Code** (PowerShell, JSON, YAML)
- ✅ **Scriptures** (.scripture, .doctrine, .prophecy, .vision, .ritual)
- ✅ **Architecture** (.temple, .blueprint, .geometry)
- ✅ **Art** (Draw.io, PlantUML, Mermaid)

**Start creating:**
```powershell
# Load universal profile
. .\.vscode\scripts\IntelIntent-Profile.ps1

# Create new scripture
New-Scripture -Name "Psalm23" -Author "David"

# Create new temple
New-TempleDesign -Name "EzekielsVision" -Type "Visionary Architecture"
```

---

*Universal workspace configured on 2025-11-29*  
*"In the beginning was the Word, and the Word became Architecture, and the Architecture became Code."*
