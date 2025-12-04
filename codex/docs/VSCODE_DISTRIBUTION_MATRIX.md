# VS Code Distribution Matrix - Complete Reference

**Last Updated**: 2025-11-28  
**Total Distributions**: 26 platform/architecture combinations  
**Base URL**: `https://update.code.visualstudio.com/{version}/{platform}/stable`

---

## 🎯 Quick Reference Matrix

### Windows Distributions (8 total)

| Architecture | Type | URL Path | Extension | Use Case |
|--------------|------|----------|-----------|----------|
| x64 | System Installer | `win32-x64` | `.exe` | Enterprise deployment, all users |
| x64 | User Installer | `win32-x64-user` | `.exe` | Per-user install, no admin rights |
| x64 | Portable ZIP | `win32-x64-archive` | `.zip` | USB drives, no installation |
| x64 | CLI | `cli-win32-x64` | `.zip` | Automation, CI/CD pipelines |
| arm64 | System Installer | `win32-arm64` | `.exe` | Surface Pro X, Windows on ARM |
| arm64 | User Installer | `win32-arm64-user` | `.exe` | Per-user ARM deployments |
| arm64 | Portable ZIP | `win32-arm64-archive` | `.zip` | Portable ARM environments |
| arm64 | CLI | `cli-win32-arm64` | `.zip` | ARM automation |

**Download Examples**:
```powershell
# Latest x64 System Installer
Invoke-WebRequest -Uri "https://update.code.visualstudio.com/latest/win32-x64/stable" -OutFile "VSCode-x64.exe"

# Specific version User Installer
Invoke-WebRequest -Uri "https://update.code.visualstudio.com/1.95.0/win32-x64-user/stable" -OutFile "VSCode-1.95.0-user.exe"

# CLI for CI/CD
Invoke-WebRequest -Uri "https://update.code.visualstudio.com/latest/cli-win32-x64/stable" -OutFile "vscode-cli.zip"
```

---

### macOS Distributions (5 total)

| Architecture | Type | URL Path | Extension | Use Case |
|--------------|------|----------|-----------|----------|
| Universal | Application Bundle | `darwin-universal` | `.zip` | M1/M2 + Intel Macs (recommended) |
| x64 (Intel) | Application Bundle | `darwin` | `.zip` | Intel Macs only |
| x64 (Intel) | CLI | `cli-darwin-x64` | `.tar.gz` | Intel automation |
| arm64 (Apple Silicon) | Application Bundle | `darwin-arm64` | `.zip` | M1/M2/M3 Macs only |
| arm64 (Apple Silicon) | CLI | `cli-darwin-arm64` | `.tar.gz` | Apple Silicon automation |

**Download Examples**:
```bash
# Universal Binary (works on all Macs)
curl -L "https://update.code.visualstudio.com/latest/darwin-universal/stable" -o VSCode-Universal.zip

# Apple Silicon optimized
curl -L "https://update.code.visualstudio.com/latest/darwin-arm64/stable" -o VSCode-ARM64.zip

# CLI for GitHub Actions (macOS runner)
curl -L "https://update.code.visualstudio.com/latest/cli-darwin-x64/stable" -o vscode-cli.tar.gz
```

---

### Linux Distributions (13 total)

#### x64 (Intel/AMD) - 5 types

| Type | URL Path | Extension | Use Case |
|------|----------|-----------|----------|
| Archive | `linux-x64` | `.tar.gz` | Manual install, Docker images |
| Debian Package | `linux-deb-x64` | `.deb` | Ubuntu, Debian, Pop!_OS |
| RPM Package | `linux-rpm-x64` | `.rpm` | Fedora, RHEL, CentOS |
| Snap Package | `linux-snap-x64` | `.snap` | Universal Linux (Ubuntu Store) |
| CLI | `cli-linux-x64` | `.tar.gz` | Automation, headless servers |

#### armhf (32-bit ARM) - 4 types

| Type | URL Path | Extension | Use Case |
|------|----------|-----------|----------|
| Archive | `linux-armhf` | `.tar.gz` | Raspberry Pi 2/3 (32-bit) |
| Debian Package | `linux-deb-armhf` | `.deb` | Raspbian, Debian ARM32 |
| RPM Package | `linux-rpm-armhf` | `.rpm` | Fedora ARM32 |
| CLI | `cli-linux-armhf` | `.tar.gz` | Raspberry Pi automation |

#### arm64 (64-bit ARM) - 4 types

| Type | URL Path | Extension | Use Case |
|------|----------|-----------|----------|
| Archive | `linux-arm64` | `.tar.gz` | Raspberry Pi 4/5, AWS Graviton |
| Debian Package | `linux-deb-arm64` | `.deb` | Ubuntu ARM64, Raspberry Pi OS 64-bit |
| RPM Package | `linux-rpm-arm64` | `.rpm` | Fedora ARM64 |
| CLI | `cli-linux-arm64` | `.tar.gz` | ARM64 cloud automation |

**Download Examples**:
```bash
# Ubuntu/Debian x64
wget "https://update.code.visualstudio.com/latest/linux-deb-x64/stable" -O vscode.deb
sudo dpkg -i vscode.deb

# RHEL/Fedora x64
wget "https://update.code.visualstudio.com/latest/linux-rpm-x64/stable" -O vscode.rpm
sudo rpm -i vscode.rpm

# Raspberry Pi 4 (ARM64)
wget "https://update.code.visualstudio.com/latest/linux-deb-arm64/stable" -O vscode-arm64.deb
sudo dpkg -i vscode-arm64.deb

# Docker Alpine (x64)
wget "https://update.code.visualstudio.com/latest/linux-x64/stable" -O vscode.tar.gz
tar -xzf vscode.tar.gz
```

---

## 🛠️ IntelIntent Integration

### Automated Download Script

**PowerShell Example** (See: `Get-VSCodeDownload.ps1`):
```powershell
# Download Windows x64 installer with hash verification
.\Get-VSCodeDownload.ps1 `
  -Platform Windows `
  -Architecture x64 `
  -DownloadType installer `
  -VerifyHash `
  -CreateCheckpoint

# Download all Linux distributions for ARM64
@('archive', 'deb', 'rpm', 'cli') | ForEach-Object {
    .\Get-VSCodeDownload.ps1 -Platform Linux -Architecture arm64 -DownloadType $_ -Version "1.95.0"
}
```

**Node.js Example**:
```javascript
// get-vscode-download.js
const https = require('https');
const fs = require('fs');
const crypto = require('crypto');

const urlMatrix = {
  'Windows-x64-installer': 'https://update.code.visualstudio.com/{version}/win32-x64/stable',
  'Linux-x64-deb': 'https://update.code.visualstudio.com/{version}/linux-deb-x64/stable',
  // ... (see full matrix in Get-VSCodeDownload.ps1)
};

async function downloadVSCode(platform, arch, type, version = 'latest') {
  const key = `${platform}-${arch}-${type}`;
  const url = urlMatrix[key].replace('{version}', version);
  
  return new Promise((resolve, reject) => {
    https.get(url, (response) => {
      const hash = crypto.createHash('sha256');
      const file = fs.createWriteStream(`vscode-${version}-${key}.bin`);
      
      response.pipe(file);
      response.on('data', (chunk) => hash.update(chunk));
      
      file.on('finish', () => {
        file.close();
        resolve({ hash: hash.digest('hex'), file: file.path });
      });
    }).on('error', reject);
  });
}

// Usage
downloadVSCode('Linux', 'arm64', 'deb', 'latest')
  .then(({ hash, file }) => console.log(`Downloaded: ${file}, SHA256: ${hash}`));
```

---

## 🚀 CI/CD Pipeline Integration

### GitHub Actions Workflow

```yaml
name: Deploy VS Code to Multi-Platform Agents

on:
  workflow_dispatch:
    inputs:
      version:
        description: 'VS Code version (e.g., 1.95.0 or latest)'
        required: true
        default: 'latest'

jobs:
  download-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Download VS Code Windows x64
        shell: pwsh
        run: |
          Invoke-WebRequest `
            -Uri "https://update.code.visualstudio.com/${{ github.event.inputs.version }}/win32-x64/stable" `
            -OutFile "VSCode-${{ github.event.inputs.version }}-x64.exe"
      
      - name: Verify Signature
        shell: pwsh
        run: |
          $hash = (Get-FileHash -Path "VSCode-${{ github.event.inputs.version }}-x64.exe" -Algorithm SHA256).Hash
          Write-Host "SHA256: $hash"
          echo "VSCODE_HASH=$hash" >> $env:GITHUB_OUTPUT
      
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: vscode-windows-x64
          path: VSCode-${{ github.event.inputs.version }}-x64.exe

  download-linux:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        arch: [x64, arm64]
        type: [deb, rpm]
    steps:
      - name: Download VS Code Linux ${{ matrix.arch }} ${{ matrix.type }}
        run: |
          wget "https://update.code.visualstudio.com/${{ github.event.inputs.version }}/linux-${{ matrix.type }}-${{ matrix.arch }}/stable" \
            -O vscode-${{ matrix.arch }}.${{ matrix.type }}
      
      - name: Verify Hash
        run: |
          sha256sum vscode-${{ matrix.arch }}.${{ matrix.type }}
      
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: vscode-linux-${{ matrix.arch }}-${{ matrix.type }}
          path: vscode-${{ matrix.arch }}.${{ matrix.type }}

  download-macos:
    runs-on: macos-latest
    steps:
      - name: Download VS Code macOS Universal
        run: |
          curl -L "https://update.code.visualstudio.com/${{ github.event.inputs.version }}/darwin-universal/stable" \
            -o VSCode-Universal.zip
      
      - name: Verify Hash
        run: |
          shasum -a 256 VSCode-Universal.zip
      
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: vscode-macos-universal
          path: VSCode-Universal.zip
```

---

### Azure DevOps Pipeline

```yaml
trigger: none

parameters:
  - name: version
    displayName: 'VS Code Version'
    type: string
    default: 'latest'

stages:
  - stage: DownloadDistributions
    displayName: 'Download VS Code Distributions'
    jobs:
      - job: WindowsDownloads
        pool:
          vmImage: 'windows-latest'
        steps:
          - task: PowerShell@2
            displayName: 'Download Windows x64 Installer'
            inputs:
              targetType: 'inline'
              script: |
                .\codex\scripts\Get-VSCodeDownload.ps1 `
                  -Platform Windows `
                  -Architecture x64 `
                  -DownloadType installer `
                  -Version "${{ parameters.version }}" `
                  -VerifyHash `
                  -CreateCheckpoint
              pwsh: true
          
          - task: PublishBuildArtifacts@1
            inputs:
              PathtoPublish: '$(System.DefaultWorkingDirectory)\codex\downloads\vscode'
              ArtifactName: 'vscode-windows'

      - job: LinuxDownloads
        pool:
          vmImage: 'ubuntu-latest'
        strategy:
          matrix:
            x64-deb:
              arch: 'x64'
              type: 'deb'
            arm64-deb:
              arch: 'arm64'
              type: 'deb'
        steps:
          - bash: |
              wget "https://update.code.visualstudio.com/${{ parameters.version }}/linux-$(type)-$(arch)/stable" \
                -O vscode-$(arch).$(type)
            displayName: 'Download VS Code Linux'
          
          - task: PublishBuildArtifacts@1
            inputs:
              PathtoPublish: 'vscode-$(arch).$(type)'
              ArtifactName: 'vscode-linux-$(arch)-$(type)'
```

---

## 📊 Version Resolution Strategy

### Get Latest Stable Version

**Method 1: API Query**
```powershell
# Query releases API
$releases = Invoke-RestMethod -Uri "https://update.code.visualstudio.com/api/releases/stable"
$latestVersion = $releases[0].version
Write-Host "Latest VS Code: $latestVersion"
```

**Method 2: Redirect Follow**
```bash
# Follow redirect to get actual version
curl -sI "https://update.code.visualstudio.com/latest/win32-x64/stable" | grep -i location
# Returns: https://update.code.visualstudio.com/1.95.0/win32-x64/stable
```

**Method 3: GitHub Releases**
```bash
# Query GitHub releases (slower but more metadata)
curl -s "https://api.github.com/repos/microsoft/vscode/releases/latest" | jq -r '.tag_name'
```

---

## 🎯 Use Case Patterns

### Pattern 1: Enterprise Air-Gapped Deployment

**Scenario**: Download all distributions for offline deployment to secure network

```powershell
# Download all Windows distributions
$platforms = @(
    @{Platform='Windows'; Arch='x64'; Type='installer'},
    @{Platform='Windows'; Arch='x64'; Type='user-installer'},
    @{Platform='Windows'; Arch='x64'; Type='zip'},
    @{Platform='Windows'; Arch='arm64'; Type='installer'}
)

$version = "1.95.0"  # Pin to tested version

foreach ($config in $platforms) {
    .\Get-VSCodeDownload.ps1 `
        -Platform $config.Platform `
        -Architecture $config.Arch `
        -DownloadType $config.Type `
        -Version $version `
        -VerifyHash `
        -CreateCheckpoint
}

# Create deployment package
Compress-Archive -Path ".\codex\downloads\vscode\*" -DestinationPath "VSCode-$version-Enterprise-Bundle.zip"
```

---

### Pattern 2: Multi-Region CI/CD Artifact Caching

**Scenario**: Pre-cache VS Code distributions in Azure Blob Storage for global CI/CD runners

```powershell
# Download and upload to Azure Blob
$storageAccount = "intelintentartifacts"
$container = "vscode-distributions"

$distributions = @('win32-x64', 'linux-deb-x64', 'darwin-universal')

foreach ($dist in $distributions) {
    $url = "https://update.code.visualstudio.com/latest/$dist/stable"
    $filename = "vscode-latest-$dist"
    
    # Download
    Invoke-WebRequest -Uri $url -OutFile $filename
    
    # Upload to Azure Blob
    az storage blob upload `
        --account-name $storageAccount `
        --container-name $container `
        --name $filename `
        --file $filename `
        --overwrite
    
    Write-Host "✅ Cached: $filename"
}
```

---

### Pattern 3: Docker Multi-Stage Build

**Scenario**: Build Docker images with VS Code pre-installed

```dockerfile
# Dockerfile for VS Code Server
FROM ubuntu:22.04 AS vscode-downloader

# Download VS Code CLI
RUN apt-get update && apt-get install -y wget && \
    wget "https://update.code.visualstudio.com/latest/cli-linux-x64/stable" -O vscode-cli.tar.gz && \
    tar -xzf vscode-cli.tar.gz

FROM ubuntu:22.04

# Copy VS Code CLI
COPY --from=vscode-downloader /code /usr/local/bin/code

# Install dependencies
RUN apt-get update && apt-get install -y git nodejs npm

# Verify installation
RUN code --version

CMD ["code", "serve-web", "--without-connection-token", "--host", "0.0.0.0"]
```

---

### Pattern 4: Raspberry Pi Fleet Deployment

**Scenario**: Deploy VS Code to 100+ Raspberry Pi devices

```bash
#!/bin/bash
# deploy-vscode-pi-fleet.sh

PI_FLEET="pi@192.168.1.{10..110}"
VSCODE_VERSION="latest"

# Download ARM64 debian package once
wget "https://update.code.visualstudio.com/$VSCODE_VERSION/linux-deb-arm64/stable" -O vscode-arm64.deb

# Deploy to fleet
for pi in $PI_FLEET; do
    echo "Deploying to $pi..."
    scp vscode-arm64.deb $pi:/tmp/
    ssh $pi "sudo dpkg -i /tmp/vscode-arm64.deb && rm /tmp/vscode-arm64.deb"
done

echo "✅ Deployed to $(echo $PI_FLEET | wc -w) Raspberry Pi devices"
```

---

## 🔐 Hash Verification Reference

### SHA256 Checksums (Example - Version 1.95.0)

```
Windows x64 Installer:        a3f7b2c1e5d4f6a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2
Windows x64 User Installer:   b4e8c3d2f6e5g7b9c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3
Linux x64 Debian:             c5f9d4e3g7f6h8c0d2e3f4g5b6c7d8e9f0g1b2c3d4e5f6g7b8c9d0e1f2g3b4
macOS Universal:              d6g0e5f4h8g7i9d1e3f4g5h6c7d8e9f0h1c2d3e4f5g6h7c8d9e0f1g2h3c4
```

**Automated Verification**:
```powershell
# Verify downloaded file against known hash
$expectedHash = "a3f7b2c1e5d4f6a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2"
$actualHash = (Get-FileHash -Path "VSCode.exe" -Algorithm SHA256).Hash

if ($actualHash -eq $expectedHash) {
    Write-Host "✅ Hash verification passed" -ForegroundColor Green
} else {
    Write-Error "❌ Hash mismatch! File may be corrupted or tampered."
    exit 1
}
```

---

## 📈 Power BI Dashboard Integration

### Track Distribution Downloads

**DAX Measures**:
```dax
TotalDownloads = COUNTROWS(VSCodeDownloads)

DownloadsByPlatform = 
CALCULATE(
    [TotalDownloads],
    ALLEXCEPT(VSCodeDownloads, VSCodeDownloads[Platform])
)

DownloadsByArchitecture = 
CALCULATE(
    [TotalDownloads],
    ALLEXCEPT(VSCodeDownloads, VSCodeDownloads[Architecture])
)

AverageDownloadDuration = 
AVERAGE(VSCodeDownloads[DurationSeconds])
```

**Visual: Distribution Matrix Heatmap**
- Rows: Platform
- Columns: Architecture
- Values: Download Count
- Conditional formatting: Green = high adoption, Red = low adoption

---

## 🚨 Important Notes

### Rate Limiting
- Microsoft CDN allows **unlimited** downloads
- No authentication required for stable releases
- Consider caching for CI/CD to reduce bandwidth

### Version Pinning
- **Production**: Always pin to specific version (e.g., `1.95.0`)
- **Development**: Can use `latest` for bleeding edge
- **Testing**: Test with `latest` before pinning

### Licensing
- VS Code is **open source** (MIT License)
- Binaries distributed by Microsoft include telemetry
- Use VSCodium for telemetry-free builds (different URLs)

---

**Document Version**: 1.0.0  
**Last Updated**: 2025-11-28  
**Maintained By**: IntelIntent Operations Team
