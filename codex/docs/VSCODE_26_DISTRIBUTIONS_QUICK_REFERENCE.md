# VS Code 26 Distributions - Quick Reference Table

**IntelIntent Phase 4 - Governance Quick Reference**  
**Document Version**: 1.0.0  
**Last Updated**: 2025-11-28  
**Status**: Production-Ready

---

## 📊 One-Page Summary: All 26 VS Code Distributions

### Windows (8 Distributions)

| # | Platform | Architecture | Download Type | URL Identifier | Recommended Use Case | Governance Impact |
|---|----------|--------------|---------------|----------------|---------------------|-------------------|
| 1 | Windows | x64 | System installer | `win32-x64` | **Enterprise deployment** (SCCM/Intune, 1,000+ workstations) | ⭐ **Critical**: System-wide installs, requires admin, hash verification mandatory |
| 2 | Windows | x64 | User installer | `win32-x64-user` | **Per-user installs** (Azure Virtual Desktop, no admin rights) | ⭐ **High Priority**: Roaming profiles, AppData storage |
| 3 | Windows | x64 | Zip archive | `win32-x64-archive` | **Portable/USB** (air-gapped systems, mutation launchpad) | ⭐ **Critical**: Bootable environments, manual extraction |
| 4 | Windows | x64 | CLI | `cli-win32-x64` | **Automation** (CI/CD runners, headless servers, Docker) | ⭐ **High Priority**: Pipeline integrity, no GUI |
| 5 | Windows | Arm64 | System installer | `win32-arm64` | **Surface Pro X/Snapdragon** (enterprise ARM devices) | ⭐ Medium: Emerging platform, track adoption |
| 6 | Windows | Arm64 | User installer | `win32-arm64-user` | **Surface Pro X** (per-user, consumer devices) | ⭐ Medium: Consumer-focused, less critical |
| 7 | Windows | Arm64 | Zip archive | `win32-arm64-archive` | **Surface Pro X** (portable, testing) | ⭐ Low: Niche use case |
| 8 | Windows | Arm64 | CLI | `cli-win32-arm64` | **ARM automation** (future-proofing for ARM servers) | ⭐ Low: Minimal current adoption |

**Governance KPIs**:
- **Platform Coverage Contribution**: 8/26 (30.8%)
- **Hash Compliance Target**: 100% for distributions 1-4, 95%+ for distributions 5-8
- **Version Drift Monitoring**: Windows x64 System installer (distribution 1) is reference version for all platforms

---

### macOS (5 Distributions)

| # | Platform | Architecture | Download Type | URL Identifier | Recommended Use Case | Governance Impact |
|---|----------|--------------|---------------|----------------|---------------------|-------------------|
| 9 | macOS | Universal | Application | `darwin-universal` | **Default for all Macs** (Intel + Apple Silicon, single binary) | ⭐ **Critical**: Universal choice, simplifies deployment |
| 10 | macOS | x64 | Application | `darwin` | **Legacy Intel Macs** (pre-2020 models, optimize performance) | ⭐ Medium: Declining usage, track sunset timeline |
| 11 | macOS | x64 | CLI | `cli-darwin-x64` | **Intel Mac servers** (GitHub Actions, automation) | ⭐ **High Priority**: CI/CD integrity |
| 12 | macOS | arm64 | Application | `darwin-arm64` | **Apple Silicon** (M1/M2/M3/M4, optimize performance) | ⭐ **High Priority**: Growing adoption, native ARM |
| 13 | macOS | arm64 | CLI | `cli-darwin-arm64` | **Apple Silicon servers** (M-series cloud instances) | ⭐ **High Priority**: CI/CD on ARM |

**Governance KPIs**:
- **Platform Coverage Contribution**: 5/26 (19.2%)
- **Hash Compliance Target**: 100% for distribution 9 (universal binary), 95%+ for others
- **Version Drift Monitoring**: macOS Universal (distribution 9) should match Windows x64 System installer version

---

### Linux (13 Distributions)

| # | Platform | Architecture | Download Type | URL Identifier | Recommended Use Case | Governance Impact |
|---|----------|--------------|---------------|----------------|---------------------|-------------------|
| 14 | Linux | x64 | Tarball | `linux-x64` | **Generic Linux** (manual extraction, custom distros) | ⭐ Medium: Flexibility vs standardization trade-off |
| 15 | Linux | x64 | Debian package | `linux-deb-x64` | **Ubuntu/Debian/Mint** (apt install, standard package manager) | ⭐ **Critical**: Most common Linux deployment |
| 16 | Linux | x64 | RPM package | `linux-rpm-x64` | **RHEL/CentOS/Fedora** (yum/dnf install, enterprise Linux) | ⭐ **Critical**: Enterprise server workloads |
| 17 | Linux | x64 | Snap package | `linux-snap-x64` | **Ubuntu Snap Store** (sandboxed, auto-updates) | ⭐ Low: Less governance control, snap auto-updates |
| 18 | Linux | x64 | CLI | `cli-linux-x64` | **Linux servers/containers** (Docker, Kubernetes, CI/CD) | ⭐ **Critical**: Pipeline integrity, DevOps |
| 19 | Linux | armhf | Tarball | `linux-armhf` | **Raspberry Pi 3/4 (32-bit)** (IoT, edge devices) | ⭐ Medium: IoT fleet management |
| 20 | Linux | armhf | Debian package | `linux-deb-armhf` | **Raspberry Pi OS (32-bit)** (standard Pi deployment) | ⭐ **High Priority**: IoT standard package |
| 21 | Linux | armhf | RPM package | `linux-rpm-armhf` | **Fedora on Raspberry Pi** (niche RPM on ARM32) | ⭐ Low: Rare configuration |
| 22 | Linux | armhf | CLI | `cli-linux-armhf` | **Raspberry Pi headless** (no GUI, automation) | ⭐ Medium: IoT automation |
| 23 | Linux | arm64 | Tarball | `linux-arm64` | **Raspberry Pi 4/5 (64-bit), AWS Graviton** (cloud ARM) | ⭐ **High Priority**: Cloud cost optimization |
| 24 | Linux | arm64 | Debian package | `linux-deb-arm64` | **Raspberry Pi OS (64-bit)** (modern Pi deployment) | ⭐ **High Priority**: IoT modernization |
| 25 | Linux | arm64 | RPM package | `linux-rpm-arm64` | **RHEL on ARM servers** (enterprise ARM) | ⭐ Medium: Emerging enterprise ARM |
| 26 | Linux | arm64 | CLI | `cli-linux-arm64` | **AWS Graviton/Azure Dv5** (cloud ARM automation) | ⭐ **Critical**: Cloud-native ARM pipelines |

**Governance KPIs**:
- **Platform Coverage Contribution**: 13/26 (50%)
- **Hash Compliance Target**: 100% for distributions 15, 16, 18, 20, 24, 26 (enterprise/cloud critical), 95%+ for others
- **Version Drift Monitoring**: Linux x64 Debian (distribution 15) should match Windows/macOS versions

---

## 🎯 Governance Priority Matrix

### Critical Distributions (Hash Compliance 100% Required)
**Must-Monitor**: These 9 distributions impact enterprise, cloud, and IoT production environments.

| Distribution # | Platform | Use Case | Why Critical |
|---------------|----------|----------|--------------|
| 1 | Windows x64 System installer | Enterprise SCCM/Intune deployment | 1,000+ workstations, requires admin |
| 3 | Windows x64 Zip archive | Bootable USB, air-gapped systems | IntelIntent mutation launchpad |
| 4 | Windows x64 CLI | CI/CD pipelines, Docker | Automated testing integrity |
| 9 | macOS Universal | Default Mac deployment | Single binary for all Macs |
| 15 | Linux x64 Debian | Ubuntu/Debian servers | Most common Linux deployment |
| 16 | Linux x64 RPM | RHEL/CentOS enterprise | Enterprise server workloads |
| 18 | Linux x64 CLI | Docker/Kubernetes | Container image integrity |
| 20 | Linux Arm32 Debian | Raspberry Pi IoT fleet | IoT edge device standard |
| 26 | Linux Arm64 CLI | AWS Graviton, Azure ARM | Cloud cost optimization |

### High Priority Distributions (Hash Compliance 95%+ Required)
**Track Closely**: These 6 distributions support key workflows but have fallback options.

| Distribution # | Platform | Use Case | Why High Priority |
|---------------|----------|----------|-------------------|
| 2 | Windows x64 User installer | Azure Virtual Desktop | Per-user, no admin required |
| 11 | macOS x64 CLI | GitHub Actions runners | CI/CD on Intel Macs |
| 12 | macOS arm64 | Apple Silicon workstations | Native M-series performance |
| 13 | macOS arm64 CLI | Apple Silicon CI/CD | Growing ARM adoption |
| 23 | Linux Arm64 Tarball | AWS Graviton, custom distros | Cloud flexibility |
| 24 | Linux Arm64 Debian | Raspberry Pi 4/5 (64-bit) | IoT modernization |

### Medium Priority Distributions (Hash Compliance 90%+ Acceptable)
**Monitor Trends**: These 8 distributions have niche use cases or declining adoption.

| Distribution # | Platform | Use Case | Why Medium Priority |
|---------------|----------|----------|---------------------|
| 5 | Windows Arm64 System installer | Surface Pro X enterprise | Emerging platform, low volume |
| 6 | Windows Arm64 User installer | Surface Pro X consumer | Consumer-focused, less critical |
| 10 | macOS x64 Application | Legacy Intel Macs | Declining usage, sunset timeline |
| 14 | Linux x64 Tarball | Generic Linux, custom distros | Flexibility vs standardization |
| 19 | Linux Arm32 Tarball | Raspberry Pi 3 (32-bit) | Legacy IoT devices |
| 21 | Linux Arm32 RPM | Fedora on Raspberry Pi | Rare configuration |
| 22 | Linux Arm32 CLI | Raspberry Pi headless (32-bit) | IoT automation (legacy) |
| 25 | Linux Arm64 RPM | RHEL on ARM servers | Emerging enterprise ARM |

### Low Priority Distributions (Hash Compliance 85%+ Acceptable)
**Track for Completeness**: These 3 distributions are niche or have minimal adoption.

| Distribution # | Platform | Use Case | Why Low Priority |
|---------------|----------|----------|------------------|
| 7 | Windows Arm64 Zip archive | Surface Pro X portable | Niche use case |
| 8 | Windows Arm64 CLI | Future ARM server automation | Minimal current adoption |
| 17 | Linux x64 Snap | Ubuntu Snap Store | Auto-updates reduce governance control |

---

## 🚨 Sponsor Daily Ritual: 2-Minute Governance Check

### Quick Visual Check (Power BI Dashboard)
Open dashboard → Navigate to **Distribution Coverage Map** page → Verify 3 KPIs:

#### ✅ KPI 1: Platform Coverage
**Target**: ≥100% (all 26 distributions)  
**Visual**: Heatmap with 26 cells (GREEN = verified, YELLOW = pending, RED = missing)  
**Action**: If <100%, click RED cell → Drill through to distribution details → Review last download attempt

#### ✅ KPI 2: Hash Compliance Rate
**Target**: ≥95% (critical distributions 100%, others 90-95%)  
**Visual**: Gauge chart showing percentage of distributions with verified SHA256 hashes  
**Action**: If <95%, click gauge → Filter to distributions with `[Pending SHA256]` → Review hash failure alerts

#### ✅ KPI 3: Version Drift Count
**Target**: 0 (all distributions on same version)  
**Visual**: Card showing count of distributions not matching latest version  
**Action**: If >0, click card → View drift table → Identify outdated distributions → Approve update or document exception

### Quick Audit Trail Check (GitHub Repository)
1. Navigate to `codex/downloads/vscode/` directory
2. Verify latest checkpoint file exists: `vscode_download_checkpoint.json`
3. Open checkpoint → Validate 9 required fields present
4. Confirm `SessionID` matches Power BI dashboard session

### Quick Alert Review (Microsoft Teams)
1. Open **IntelIntent Operations - Alerts** channel
2. Review any Adaptive Cards posted in last 24 hours
3. For each alert:
   - Click **📊 View Power BI Dashboard** → Review distribution details
   - Click **🔍 View Checkpoint Details** → Validate lineage
   - Click **✅ Acknowledge Alert** → Add sponsor signature

**Total Time**: 2 minutes (once daily, 8:00 AM)

---

## 🔗 Cross-Reference: IntelIntent Integration Points

### Lab Workbook Integration
This quick reference table supports the following lab sessions:

- **Lab 2 - Artifact Retrieval**: Use this table to select distributions for download testing
  - Try: Windows x64 System installer (distribution 1), macOS Universal (distribution 9), Linux x64 Debian (distribution 15)
  - Advanced: Download all 9 critical distributions in parallel

- **Lab 3 - JSON Manifest & Logging**: Verify checkpoint schema for each distribution type
  - Validate: TaskID format matches distribution number (e.g., `VSCODE-001-WIN-X64-INSTALLER`)
  - Test: Schema validation function catches missing fields across all 26 distributions

- **Lab 5 - Power BI Dashboard**: Build heatmap visual using this table's priority matrix
  - Color-code: Critical (RED background), High Priority (ORANGE), Medium (YELLOW), Low (GREEN)
  - DAX Measure: `PriorityScore = SWITCH([DistributionNumber], 1, 10, 3, 10, 4, 10, ..., 0)`

- **Lab 6 - Escalation Workflow**: Configure Power Automate alerts based on distribution priority
  - Critical distributions (1, 3, 4, 9, 15, 16, 18, 20, 26): Level 3 alerts (auto-escalate to sponsor + GitHub issue)
  - High Priority (2, 11, 12, 13, 23, 24): Level 2 alerts (Teams only)
  - Medium/Low: Level 1 alerts (dashboard notification only)

### Governance Document Integration
This table is referenced in:

- **VSCODE_UNIFIED_GOVERNANCE_ALERT_SYSTEM.md**: Severity tier mapping uses priority matrix
- **VSCODE_DEPLOYMENT_GOVERNANCE_GUIDE.md**: Quick reference table embedded in Appendix A
- **VSCODE_ENGINEER_LAB_WORKBOOK.md**: Custom Scenario 1 (Multi-platform deployment) uses critical distributions list
- **VSCODE_DISTRIBUTION_MATRIX.md**: This table is the condensed version of the full 548-line matrix

### PowerShell Script Integration
Use with `Get-VSCodeDownload.ps1`:

```powershell
# Download all 9 critical distributions
$criticalDistributions = @(
    @{Platform="Windows"; Arch="x64"; Type="installer"; Priority="Critical"},
    @{Platform="Windows"; Arch="x64"; Type="zip"; Priority="Critical"},
    @{Platform="Windows"; Arch="x64"; Type="cli"; Priority="Critical"},
    @{Platform="macOS"; Arch="universal"; Type="darwin"; Priority="Critical"},
    @{Platform="Linux"; Arch="x64"; Type="deb"; Priority="Critical"},
    @{Platform="Linux"; Arch="x64"; Type="rpm"; Priority="Critical"},
    @{Platform="Linux"; Arch="x64"; Type="cli"; Priority="Critical"},
    @{Platform="Linux"; Arch="armhf"; Type="deb"; Priority="Critical"},
    @{Platform="Linux"; Arch="arm64"; Type="cli"; Priority="Critical"}
)

foreach ($dist in $criticalDistributions) {
    Write-Host "📥 Downloading $($dist.Priority) distribution: $($dist.Platform) $($dist.Arch) $($dist.Type)" -ForegroundColor Cyan
    .\Get-VSCodeDownload.ps1 `
        -Platform $dist.Platform `
        -Architecture $dist.Arch `
        -DownloadType $dist.Type `
        -Version latest `
        -VerifyHash `
        -CreateCheckpoint `
        -Verbose
}

# Expected Output:
# - 9 checkpoint JSON files created
# - Power BI dashboard shows 9/26 distributions (34.6% coverage)
# - All 9 critical distributions show GREEN (hash verified)
```

---

## 📋 URL Pattern Reference (All 26)

### Quick Copy-Paste URLs
Replace `{version}` with version number (e.g., `1.95.0`) or `latest`:

```
# Windows (8)
https://update.code.visualstudio.com/{version}/win32-x64/stable
https://update.code.visualstudio.com/{version}/win32-x64-user/stable
https://update.code.visualstudio.com/{version}/win32-x64-archive/stable
https://update.code.visualstudio.com/{version}/cli-win32-x64/stable
https://update.code.visualstudio.com/{version}/win32-arm64/stable
https://update.code.visualstudio.com/{version}/win32-arm64-user/stable
https://update.code.visualstudio.com/{version}/win32-arm64-archive/stable
https://update.code.visualstudio.com/{version}/cli-win32-arm64/stable

# macOS (5)
https://update.code.visualstudio.com/{version}/darwin-universal/stable
https://update.code.visualstudio.com/{version}/darwin/stable
https://update.code.visualstudio.com/{version}/cli-darwin-x64/stable
https://update.code.visualstudio.com/{version}/darwin-arm64/stable
https://update.code.visualstudio.com/{version}/cli-darwin-arm64/stable

# Linux (13)
https://update.code.visualstudio.com/{version}/linux-x64/stable
https://update.code.visualstudio.com/{version}/linux-deb-x64/stable
https://update.code.visualstudio.com/{version}/linux-rpm-x64/stable
https://update.code.visualstudio.com/{version}/linux-snap-x64/stable
https://update.code.visualstudio.com/{version}/cli-linux-x64/stable
https://update.code.visualstudio.com/{version}/linux-armhf/stable
https://update.code.visualstudio.com/{version}/linux-deb-armhf/stable
https://update.code.visualstudio.com/{version}/linux-rpm-armhf/stable
https://update.code.visualstudio.com/{version}/cli-linux-armhf/stable
https://update.code.visualstudio.com/{version}/linux-arm64/stable
https://update.code.visualstudio.com/{version}/linux-deb-arm64/stable
https://update.code.visualstudio.com/{version}/linux-rpm-arm64/stable
https://update.code.visualstudio.com/{version}/cli-linux-arm64/stable
```

---

## ✅ Production Readiness Checklist

### Before First Sponsor Review
- [ ] Download all 9 critical distributions (verify hash for each)
- [ ] Create checkpoint JSON for each distribution (validate schema)
- [ ] Upload to Azure Blob Storage (`intelintentartifacts` container)
- [ ] Insert to SQL Database (`VSCodeDistributions` table, 9 rows)
- [ ] Refresh Power BI dashboard (verify heatmap shows 9 GREEN cells)
- [ ] Test Teams Adaptive Card with simulated hash fail (distribution 1)
- [ ] Generate Codex scroll (Week1_Codex_Scroll.md with distribution lineage)
- [ ] Send email to sponsor with dashboard link + checkpoint summary

### Weekly Governance Review
- [ ] Verify all 26 distributions downloaded (100% coverage)
- [ ] Check version drift (all distributions should match latest stable release)
- [ ] Review hash compliance rate (target: 95%+ across all distributions)
- [ ] Audit checkpoint JSON files (validate all 9 required fields present)
- [ ] Review Teams alerts (acknowledge all Level 2+ alerts from past week)
- [ ] Update distribution priority matrix (adjust based on adoption trends)
- [ ] Export audit trail to JSON (append to governance lineage record)
- [ ] Sponsor signature on weekly governance scroll

### Monthly Compliance Audit
- [ ] Export all 26 checkpoint JSONs (one per distribution)
- [ ] Validate SHA256 hashes against official VS Code release notes
- [ ] Generate compliance report (SOC 2 Type II audit trail)
- [ ] Review platform coverage trends (track adoption by distribution type)
- [ ] Update sunset timeline for legacy distributions (e.g., macOS x64, Linux Arm32)
- [ ] Document version drift exceptions (sponsor-approved deviations)
- [ ] Archive previous month's checkpoints to Azure Blob cold storage
- [ ] Sponsor signature on monthly compliance scroll

---

**Document Status**: ✅ Production-Ready  
**Next Review Date**: 2025-12-28  
**Maintained By**: IntelIntent Operations Team  
**Cross-References**: 
- [VS Code Distribution Matrix](VSCODE_DISTRIBUTION_MATRIX.md) (Full 548-line reference)
- [Unified Governance Alert System](VSCODE_UNIFIED_GOVERNANCE_ALERT_SYSTEM.md) (Mermaid + Adaptive Card + Audit Trail)
- [Engineer Lab Workbook](VSCODE_ENGINEER_LAB_WORKBOOK.md) (Hands-on training, 6 sessions)
- [Deployment Governance Guide](VSCODE_DEPLOYMENT_GOVERNANCE_GUIDE.md) (Master governance, 1,100+ lines)
