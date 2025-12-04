# GitHub Copilot Authentication Guide for IntelIntent

**Date**: November 30, 2025  
**Workspace**: IntelIntent - Universal Creative System  
**Status**: Step-by-Step Authentication Guide

---

## 🔐 Method 1: Authenticate GitHub Copilot in VS Code (Recommended)

### Step 1: Check Current Copilot Status

1. Look at the **bottom-right status bar** in VS Code
2. You should see one of these icons:
   - ✅ **Copilot icon (active)** - Already authenticated
   - ⚠️ **Copilot icon with warning** - Authentication issue
   - ❌ **No icon** - Copilot not installed or not authenticated

### Step 2: Sign In to GitHub Copilot

**Option A: Via Status Bar (Quickest)**
1. Click the **Copilot icon** in the bottom-right status bar
2. Select **"Sign in to GitHub"**
3. VS Code will open a browser window
4. Click **"Authorize Visual Studio Code"**
5. Return to VS Code - you should see "Signed in" notification

**Option B: Via Command Palette**
1. Press `Ctrl+Shift+P` (Windows) or `Cmd+Shift+P` (Mac)
2. Type: **"GitHub Copilot: Sign In"**
3. Select the command
4. Follow browser authentication flow
5. Authorize VS Code application

**Option C: Via Settings**
1. Press `Ctrl+,` to open Settings
2. Search for: **"GitHub Copilot"**
3. Look for **"GitHub Copilot: Enable"** setting
4. Click **"Sign in to GitHub"** if prompted

### Step 3: Verify Authentication

**Check Status Bar:**
- ✅ Copilot icon should be **solid/active** (not grayed out)
- Hover over icon to see status: "GitHub Copilot: Ready"

**Test Copilot:**
1. Open any `.ps1` file in IntelIntent (e.g., `Week1_Automation.ps1`)
2. Create a new line and type: `# Create a function to`
3. Copilot should show **inline suggestions** (gray text)
4. Press `Tab` to accept suggestion

**Open Copilot Chat:**
1. Press `Ctrl+Alt+I` to open Copilot Chat
2. Ask: `@workspace What is IntelIntent?`
3. Copilot should respond with project context

### Step 4: Troubleshooting Authentication Issues

**Issue: "Sign in failed" or "Could not authenticate"**

**Solution A: Clear VS Code Cache**
```powershell
# Close VS Code completely
# Delete VS Code cache (Windows)
Remove-Item -Path "$env:APPDATA\Code\User\globalStorage\github.copilot" -Recurse -Force
Remove-Item -Path "$env:APPDATA\Code\User\globalStorage\github.copilot-chat" -Recurse -Force

# Restart VS Code and try signing in again
```

**Solution B: Use Device Code Flow**
1. `Ctrl+Shift+P` → "GitHub Copilot: Sign In Using Device Code"
2. Copy the device code shown
3. Open: https://github.com/login/device
4. Paste code and authorize
5. Return to VS Code

**Solution C: Check GitHub Token**
1. Go to: https://github.com/settings/tokens
2. Look for token with name "Visual Studio Code"
3. If missing or expired, delete and re-authenticate in VS Code
4. Required scopes: `copilot`, `user:email`, `read:org`

**Issue: "Copilot is not available" or "Subscription required"**

**Check Subscription:**
1. Go to: https://github.com/settings/copilot
2. Verify one of:
   - ✅ **GitHub Copilot Individual** subscription
   - ✅ **GitHub Copilot Business** (via organization)
   - ✅ **Student/Teacher** benefit
   - ✅ **Open Source Maintainer** access
3. If no subscription, click **"Start free trial"** (60 days)

**Issue: "Network error" or "Proxy authentication failed"**

**Solution: Configure Proxy (if behind corporate firewall)**
```powershell
# In VS Code settings.json
"http.proxy": "http://proxy.company.com:8080",
"http.proxyStrictSSL": false,
"github.copilot.advanced": {
    "debug.overrideEngine": "copilot-codex"
}
```

---

## 🔄 Method 2: Multiple GitHub Accounts Setup

### Scenario: Personal + Work GitHub Accounts

**Step 1: Generate SSH Keys for Each Account**

**Personal Account (boopasbagelboy@icloud.com):**
```powershell
# Generate SSH key
ssh-keygen -t ed25519 -C "boopasbagelboy@icloud.com" -f "$HOME\.ssh\id_ed25519_personal"

# Start SSH agent (PowerShell)
Start-Service ssh-agent
Set-Service ssh-agent -StartupType Automatic

# Add key to agent
ssh-add "$HOME\.ssh\id_ed25519_personal"

# Copy public key to clipboard
Get-Content "$HOME\.ssh\id_ed25519_personal.pub" | Set-Clipboard
```

**Add to GitHub:**
1. Go to: https://github.com/settings/keys
2. Click **"New SSH key"**
3. Title: "IntelIntent Personal - Windows"
4. Paste key from clipboard
5. Click **"Add SSH key"**

**Work Account (if applicable):**
```powershell
# Generate work SSH key
ssh-keygen -t ed25519 -C "work@company.com" -f "$HOME\.ssh\id_ed25519_work"

# Add to agent
ssh-add "$HOME\.ssh\id_ed25519_work"

# Copy and add to work GitHub account
Get-Content "$HOME\.ssh\id_ed25519_work.pub" | Set-Clipboard
```

**Step 2: Configure SSH Config File**

```powershell
# Create/edit SSH config
$sshConfig = @"
# Personal GitHub Account
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes

# Work GitHub Account (if needed)
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
  IdentitiesOnly yes

# Default GitHub (uses personal)
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes
"@

# Save config
New-Item -ItemType Directory -Path "$HOME\.ssh" -Force | Out-Null
$sshConfig | Out-File -FilePath "$HOME\.ssh\config" -Encoding UTF8
```

**Step 3: Test SSH Connection**

```powershell
# Test personal account
ssh -T git@github.com-personal
# Should see: "Hi cf7928pdxg-sketch! You've successfully authenticated..."

# Test work account
ssh -T git@github.com-work
# Should see: "Hi <work-username>! You've successfully authenticated..."
```

**Step 4: Configure IntelIntent Repository**

**For Existing Repository:**
```powershell
# Navigate to IntelIntent
cd "C:\Users\BOOPA\OneDrive\IntelIntent!"

# Set personal account for this repo
git config user.name "Boopas Bagel Boy"
git config user.email "boopasbagelboy@icloud.com"

# Update remote URL to use personal SSH host
git remote set-url origin git@github.com-personal:cf7928pdxg-sketch/IntelIntent.git

# Verify
git config user.email
git remote -v
```

**For New Clone:**
```powershell
# Clone using personal account SSH
git clone git@github.com-personal:cf7928pdxg-sketch/IntelIntent.git

cd IntelIntent
git config user.name "Boopas Bagel Boy"
git config user.email "boopasbagelboy@icloud.com"
```

**Step 5: Set Global Defaults (Optional)**

```powershell
# Set default account globally
git config --global user.name "Boopas Bagel Boy"
git config --global user.email "boopasbagelboy@icloud.com"

# Override per-repository as needed
# (already done above for IntelIntent)
```

---

## 🤖 Method 3: GitHub Actions Authentication

### For IntelIntent CI/CD Pipeline

**Step 1: Generate Personal Access Token (PAT)**

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token (classic)"**
3. Name: **"IntelIntent CI/CD Pipeline"**
4. Expiration: **90 days** (or custom)
5. Select scopes:
   - ✅ `repo` (full repository access)
   - ✅ `workflow` (GitHub Actions)
   - ✅ `write:packages` (if using GitHub Packages)
   - ✅ `admin:org` (if org-level actions)
6. Click **"Generate token"**
7. **COPY TOKEN IMMEDIATELY** (you won't see it again)

**Step 2: Add Token to Repository Secrets**

1. Go to: https://github.com/cf7928pdxg-sketch/IntelIntent/settings/secrets/actions
2. Click **"New repository secret"**
3. Name: **`GH_PAT`** or **`GITHUB_TOKEN`**
4. Value: Paste your token
5. Click **"Add secret"**

**Step 3: Add Azure Credentials for Actions**

**Create Azure Service Principal:**
```powershell
# Login to Azure
az login

# Create service principal
$sp = az ad sp create-for-rbac `
    --name "GitHub-Actions-IntelIntent" `
    --role Contributor `
    --scopes /subscriptions/<subscription-id> `
    --sdk-auth | ConvertFrom-Json

# Copy entire JSON output
$sp | ConvertTo-Json
```

**Add to GitHub Secrets:**
1. Go to: https://github.com/cf7928pdxg-sketch/IntelIntent/settings/secrets/actions
2. Add secrets:
   - **`AZURE_CREDENTIALS`**: Full JSON from service principal
   - **`AZURE_SUBSCRIPTION_ID`**: Your subscription ID
   - **`AZURE_TENANT_ID`**: Your tenant ID
   - **`AZURE_CLIENT_ID`**: Service principal app ID
   - **`AZURE_CLIENT_SECRET`**: Service principal password

**Step 4: Update Workflow File**

Your `.github/workflows/copilot-quality-check.yml` is already configured to use these secrets:

```yaml
# Authentication is automatic with GITHUB_TOKEN
# For Azure operations, add:
- name: Azure Login
  uses: azure/login@v1
  with:
    creds: ${{ secrets.AZURE_CREDENTIALS }}

- name: Run Azure CLI Commands
  run: |
    az account show
    az group list --output table
```

**Step 5: Test Workflow**

```powershell
# Make a test commit
git add .
git commit -m "test: Verify GitHub Actions authentication"
git push origin main

# Or trigger manually
# GitHub → Actions → Select workflow → Run workflow
```

---

## 🔧 Method 4: GitHub CLI Authentication

### For Command-Line Operations

**Step 1: Install GitHub CLI (if not installed)**

```powershell
# Via Chocolatey (recommended for Windows)
choco install gh

# Or download from: https://cli.github.com/
```

**Step 2: Authenticate GitHub CLI**

```powershell
# Interactive authentication
gh auth login

# Select options:
# 1. What account do you want to log into? → GitHub.com
# 2. What is your preferred protocol? → SSH
# 3. Upload SSH public key? → Yes (select ~/.ssh/id_ed25519_personal.pub)
# 4. How would you like to authenticate? → Login with web browser
# 5. Copy one-time code and press Enter
# 6. Browser opens → Paste code → Authorize

# Verify authentication
gh auth status
```

**Step 3: Configure for Multiple Accounts**

```powershell
# Login to personal account
gh auth login --hostname github.com --web

# Switch accounts (if needed)
gh auth switch

# Check current account
gh auth status
```

---

## ✅ Verification Checklist

After completing authentication, verify everything works:

### GitHub Copilot
- [ ] Copilot icon in status bar is active (not grayed out)
- [ ] Inline suggestions appear when typing code
- [ ] `Ctrl+Alt+I` opens Copilot Chat
- [ ] `@workspace` queries return IntelIntent-specific responses
- [ ] No authentication errors in Output panel (View → Output → GitHub Copilot)

### Multiple GitHub Accounts
- [ ] SSH connection succeeds: `ssh -T git@github.com-personal`
- [ ] Repository shows correct email: `git config user.email`
- [ ] Remote URL uses correct SSH host: `git remote -v`
- [ ] Can push/pull without password prompt

### GitHub Actions
- [ ] Secrets are visible in repository settings
- [ ] Workflow runs without authentication errors
- [ ] Azure operations succeed (if applicable)
- [ ] Artifacts are uploaded successfully

### GitHub CLI
- [ ] `gh auth status` shows authenticated
- [ ] `gh repo view` shows IntelIntent repository
- [ ] `gh issue list` works (if issues exist)
- [ ] `gh pr list` works (if PRs exist)

---

## 🚨 Common Issues & Solutions

### Issue: "SSH Permission Denied"

**Solution:**
```powershell
# Check SSH agent is running
Get-Service ssh-agent

# Start if stopped
Start-Service ssh-agent

# Re-add key
ssh-add "$HOME\.ssh\id_ed25519_personal"

# Test connection
ssh -Tv git@github.com-personal
```

### Issue: "Copilot Not Responding"

**Solution:**
```powershell
# Check Copilot logs
# View → Output → Select "GitHub Copilot" from dropdown

# Restart Copilot
# Ctrl+Shift+P → "GitHub Copilot: Restart Language Server"

# Check network connectivity
Test-NetConnection github.com -Port 443
```

### Issue: "Two-Factor Authentication Required"

**Solution:**
1. GitHub Settings → Security → Two-factor authentication
2. Add authentication app (Microsoft Authenticator, Authy)
3. Save recovery codes
4. Use app code when prompted during `gh auth login`

### Issue: "Git Push Rejected"

**Solution:**
```powershell
# Verify remote URL uses SSH
git remote get-url origin
# Should be: git@github.com-personal:cf7928pdxg-sketch/IntelIntent.git

# If HTTPS, change to SSH
git remote set-url origin git@github.com-personal:cf7928pdxg-sketch/IntelIntent.git

# Try push again
git push origin main
```

---

## 🎯 Quick Command Reference

```powershell
# GitHub Copilot
Ctrl+Shift+P → "GitHub Copilot: Sign In"
Ctrl+Alt+I   # Open Copilot Chat
Ctrl+I       # Inline Chat

# Git Configuration
git config user.email                                      # Check email
git config user.name "Name"                               # Set name
git config user.email "email@example.com"                 # Set email
git remote -v                                              # Show remotes

# SSH
ssh -T git@github.com-personal                            # Test connection
ssh-add "$HOME\.ssh\id_ed25519_personal"                 # Add key
ssh-add -l                                                 # List keys

# GitHub CLI
gh auth login                                              # Authenticate
gh auth status                                             # Check status
gh repo view                                               # View repo
gh pr create                                               # Create PR

# Azure
az login                                                   # Login to Azure
az account show                                            # Show account
az account list                                            # List subscriptions
```

---

## 📞 Need Help?

**VS Code Copilot Logs:**
```
View → Output → Select "GitHub Copilot" from dropdown
```

**Git Verbose Output:**
```powershell
GIT_TRACE=1 git push origin main
GIT_SSH_COMMAND="ssh -v" git push origin main
```

**Test Network Connectivity:**
```powershell
Test-NetConnection github.com -Port 443
Test-NetConnection api.github.com -Port 443
```

**GitHub Status:**
- Check: https://www.githubstatus.com/

---

**Last Updated**: November 30, 2025  
**IntelIntent Workspace**: Production-Ready Authentication Configuration
