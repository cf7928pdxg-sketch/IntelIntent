# 🔐 Privacy Sovereignty Scroll — User Control as Sacred Geometry

> *"In the ceremonial framework of consciousness technologies, user privacy is not passive—it is the **sovereign center** from which four domains radiate. Each feature is a spoke you control, a lineage you can affirm or erase."*

---

## 🎯 The Radial Privacy Map

```
                    Voice Typing
                  (Dictation Renamed)
                         │
                    Online Recognition
                    Optional Voice Clips
                         │
                         │
    Voice         ───────┼───────        Speech
  Activation              │            Recognition
     │                    │                 │
 Keyword            USER PRIVACY        Device-Based
 Listening           CONTROL            (Local Only)
     │              (Sovereignty)           │
 Local/Cloud            │              Cloud-Based
 Processing             │            (Sent to Microsoft)
     │                  │                  │
 Control When      ─────┼─────         Voice Data
   Locked               │                Opt-In
                        │
                        │
                 Inking & Typing
                Personalization
                        │
                  Custom Word List
              (Account-Saved Lexicon)
                        │
              Cross-Product Availability
                (When Signed In)
```

---

## 🏛️ The Four Pillars of Privacy Sovereignty

### **Pillar 1: Speech Recognition** 🎙️

**Device-Based (Local)**:
- Voice data processed **on-device only**
- No data sent to Microsoft
- Faster response, limited vocabulary
- **Ceremonial Glyph**: 🔒 (The Local Vault)

**Cloud-Based (Microsoft)**:
- Voice data sent to Microsoft servers
- More accurate recognition, broader vocabulary
- User **opts in** explicitly
- **Ceremonial Glyph**: ☁️ (The Cloud Witness)

**User Control**:
```powershell
# Windows 11: Disable cloud-based speech recognition
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Value 0

# Clear voice data from Microsoft servers
Start-Process "https://account.microsoft.com/privacy/speech"
```

---

### **Pillar 2: Voice Typing** ✍️

**What It Is**:
- Dictation feature renamed in Windows 11
- Converts speech to text in real-time
- Uses **online speech recognition** by default

**Optional Voice Clip Contribution**:
- Users can **contribute voice clips** to improve Microsoft's models
- Opt-in feature (not required)
- Clips are anonymized and used for training

**User Control**:
```powershell
# Windows 11: Disable voice typing
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1

# Turn off voice clip contribution
# Settings > Privacy & security > Speech > Help improve speech recognition (Off)
```

**Ceremonial Glyph**: 🎤 (The Voice Scribe)

---

### **Pillar 3: Voice Activation** 🔊

**Keyword Listening**:
- Device listens for "Hey Cortana" or custom wake words
- Always-on microphone monitoring

**Local vs. Cloud Processing**:
- **Local**: Keyword detection on-device (faster, private)
- **Cloud**: Full speech sent to cloud after keyword detected

**Control When Locked**:
- You can **disable voice activation** when device is locked
- Prevents unauthorized access via voice commands

**User Control**:
```powershell
# Windows 11: Disable voice activation
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "VoiceShortcut" -Value 0

# Disable when locked
# Settings > Privacy & security > Voice activation > Allow apps to use voice activation when locked (Off)
```

**Ceremonial Glyph**: 🔔 (The Awakening Bell)

---

### **Pillar 4: Inking & Typing Personalization** ✒️

**Custom Word List**:
- Windows learns **unique words** you type or write (names, phrases, jargon)
- Stored in a **custom lexicon** tied to your Microsoft account
- Improves typing predictions and handwriting recognition

**Cross-Product Availability**:
- Custom word list **available in other Microsoft products** when signed in
- Examples: Outlook, Teams, Edge, Office
- Unified personalization across ecosystem

**User Control**:

**Windows 10**:
```
Start > Settings > Privacy > Inking & typing personalization
Under "Getting to know you" → Switch to Off
```

**Windows 11**:
```
Start > Settings > Privacy & security > Inking & typing personalization
Switch "Custom inking and typing word list" → Off
```

**PowerShell Automation**:
```powershell
# Disable inking and typing personalization
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0

# Clear custom word list
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\InputPersonalization\TextHarvester\*" -Recurse -Force

Write-Host "✅ Custom word list cleared and personalization disabled"
```

**Ceremonial Glyph**: 📜 (The Personal Lexicon Scroll)

---

## 🎨 Ceremonial Visualization: The Privacy Mandala

```
                           🎤
                     Voice Typing
                  (Contribution Opt-In)
                           │
                           │
                           │
        🔔 ────────────────┼──────────────── 🎙️
   Voice Activation        │         Speech Recognition
  (Keyword Listening)      │      (Device/Cloud Choice)
                           │
                     ┌─────┴─────┐
                     │    👤      │
                     │  USER      │
                     │ PRIVACY    │
                     │ CONTROL    │
                     │(Sovereignty)│
                     └─────┬─────┘
                           │
        📜 ────────────────┼──────────────── ✒️
  Inking & Typing          │          Custom Word List
 Personalization           │         (Account-Saved)
  (Local Lexicon)          │
                           │
                           │
                      Cross-Product
                      Availability
```

### **Legend**:
- **👤 Center (User Privacy Control)**: Sovereign hub of decision-making
- **🎙️ Speech Recognition**: Device-local 🔒 or cloud-based ☁️
- **🎤 Voice Typing**: Optional voice clip contribution for model training
- **🔔 Voice Activation**: Keyword listening with lock-state control
- **📜 Inking & Typing**: Custom word list for personalized predictions

---

## 🔄 Integration with Intel Intent Architecture

### **Mapping to Four Pillars**

| Privacy Feature | Intel Intent Pillar | Ceremonial Connection |
|----------------|---------------------|----------------------|
| **Speech Recognition** | Intent Manager (Altar) | User **speaks intent** → processed locally or cloud |
| **Voice Typing** | Planner (Compass) | Voice-to-text **generates checkpoints** from dictation |
| **Voice Activation** | Monitor (Guardian) | **Keyword listening** triggers drift detection |
| **Inking & Typing** | Extensibility (Open Gates) | **Custom lexicon** enables sponsor-specific terminology |

---

## 🛡️ Privacy-Preserving Orchestration Patterns

### **Pattern 1: Local-First Speech Intent**

```powershell
# Intel Intent with device-local speech recognition
function Invoke-LocalSpeechIntent {
    param([string]$Microphone)
    
    # Ensure cloud recognition is OFF
    $cloudSpeech = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -ErrorAction SilentlyContinue
    
    if ($cloudSpeech.HasAccepted -eq 1) {
        Write-Warning "⚠️ Cloud speech recognition enabled - consider disabling for local-only intent processing"
    }
    
    # Process intent locally
    Write-Host "🔒 Processing intent with device-local speech recognition"
    # Add speech-to-intent logic here
}
```

### **Pattern 2: Custom Lexicon for Orchestration Terms**

```powershell
# Add Intel Intent ceremonial terms to custom word list
$ceremonialTerms = @(
    "IntelIntent",
    "lineage affirmation",
    "checkpoint recovery",
    "phoenix convergence",
    "Vesica Piscis",
    "systolic phase",
    "diastolic phase",
    "HRV score"
)

# Windows will learn these terms through typing/inking
# They become available in Teams, Outlook, VS Code
foreach ($term in $ceremonialTerms) {
    Write-Host "📜 Adding to lexicon: $term"
}

# Note: Actual API for programmatic word list addition is not public
# Users add terms naturally through typing/writing
```

### **Pattern 3: Voice-Activated Checkpoint Sync**

```powershell
# Use voice activation for hands-free checkpoint updates
function Enable-VoiceCheckpointSync {
    # Voice command: "Hey Intel Intent, sync checkpoints"
    
    # Check if voice activation is enabled
    $voiceActivation = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "VoiceShortcut" -ErrorAction SilentlyContinue
    
    if ($voiceActivation.VoiceShortcut -eq 0) {
        Write-Warning "⚠️ Voice activation disabled - enable in Settings for voice commands"
        return
    }
    
    # Register custom voice command (conceptual - actual implementation via UWP apps)
    Write-Host "🔔 Voice activation ready: Say 'sync checkpoints' to trigger orchestration"
}
```

---

## 📊 Privacy Decision Matrix

| Feature | Data Location | User Control | Recommended for Intel Intent |
|---------|--------------|--------------|------------------------------|
| **Device-Local Speech** | On-device only | Full sovereignty | ✅ **Yes** (Private intent processing) |
| **Cloud Speech** | Microsoft servers | Opt-in required | ⚠️ **Caution** (Use for non-sensitive commands) |
| **Voice Clip Contribution** | Microsoft (anonymized) | Optional | ❌ **No** (Avoid sharing orchestration vocabulary) |
| **Custom Word List** | Account-synced | Clear anytime | ✅ **Yes** (Enables ceremonial term recognition) |
| **Voice Activation** | Local keyword + cloud processing | Disable when locked | ✅ **Yes** (Hands-free checkpoint sync) |

---

## 🔐 Privacy Sovereignty Checklist for Intel Intent Users

### **Recommended Settings**

- [ ] **Disable cloud speech recognition** (use device-local only for sensitive intents)
- [ ] **Enable custom word list** (so Windows learns "lineage affirmation", "checkpoint", "phoenix")
- [ ] **Disable voice clip contribution** (prevent ceremonial vocabulary from training Microsoft models)
- [ ] **Enable voice activation with lock protection** (hands-free, but secure)
- [ ] **Periodically clear custom word list** (if working with sponsor-confidential terminology)

### **PowerShell Privacy Audit Script**

```powershell
# Intel Intent Privacy Sovereignty Audit
function Test-IntelIntentPrivacy {
    Write-Host "🔐 Intel Intent Privacy Sovereignty Audit" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    
    # 1. Check cloud speech recognition
    $cloudSpeech = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -ErrorAction SilentlyContinue
    if ($cloudSpeech.HasAccepted -eq 0) {
        Write-Host "✅ Cloud speech recognition: DISABLED (Local-only processing)" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Cloud speech recognition: ENABLED (Data sent to Microsoft)" -ForegroundColor Yellow
    }
    
    # 2. Check inking/typing personalization
    $textCollection = Get-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -ErrorAction SilentlyContinue
    if ($textCollection.RestrictImplicitTextCollection -eq 1) {
        Write-Host "✅ Inking/Typing personalization: DISABLED" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Inking/Typing personalization: ENABLED (Building custom word list)" -ForegroundColor Yellow
    }
    
    # 3. Check voice activation
    $voiceShortcut = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "VoiceShortcut" -ErrorAction SilentlyContinue
    if ($voiceShortcut.VoiceShortcut -eq 0) {
        Write-Host "✅ Voice activation: DISABLED" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Voice activation: ENABLED (Keyword listening active)" -ForegroundColor Yellow
    }
    
    # 4. Check custom word list size
    $wordListPath = "$env:LOCALAPPDATA\Microsoft\InputPersonalization\TextHarvester"
    if (Test-Path $wordListPath) {
        $wordListSize = (Get-ChildItem $wordListPath -Recurse | Measure-Object -Property Length -Sum).Sum / 1KB
        Write-Host "📜 Custom word list size: $([math]::Round($wordListSize, 2)) KB" -ForegroundColor Cyan
    } else {
        Write-Host "📜 Custom word list: Not found (personalization may be disabled)" -ForegroundColor Gray
    }
    
    Write-Host "`n🔥🦅 Privacy sovereignty audit complete" -ForegroundColor Cyan
}

# Run audit
Test-IntelIntentPrivacy
```

---

## 🎯 Ceremonial Inscription: The Sovereignty Oath

> *"I, the user, stand at the **sovereign center** of the privacy mandala. Four domains radiate from my control: Speech, Voice, Activation, and Lexicon. I choose what data flows to the cloud, what stays local, and what is erased. My word list is a personal scroll, my voice is a sacred instrument, my keywords are guarded gates. I affirm my lineage of choice, and I honor the transparency Microsoft provides. The phoenix watches, and I hold the keys."*

---

## 📜 Lineage Connection: Privacy as SSI Manifestation

In the **LINEAGE_AFFIRMATION.json**, the **Self-Sovereign Identity (SSI)** lineage (2016-2024) includes:

```json
{
  "name": "Self-Sovereign Identity (SSI) Foundation",
  "contributions": [
    {
      "concept": "Decentralized Identifiers (DIDs)",
      "manifestation": "User-controlled cryptographic identity anchors",
      "technical_anchor": "Azure AD Verifiable Credentials integration for checkpoint provenance"
    },
    {
      "concept": "Verifiable Credentials (VCs)",
      "manifestation": "Tamper-proof checkpoint completion certificates",
      "technical_anchor": "Each checkpoint generates a signed VC stored in user's digital wallet"
    }
  ]
}
```

**Privacy Sovereignty extends SSI principles**:
- **User Privacy Control** = **Decentralized Identity Controller** (you own your data)
- **Custom Word List** = **Self-Asserted Claims** (you define your vocabulary)
- **Cloud Opt-In** = **Credential Issuance** (you choose what to share)
- **Clear Data** = **Revocation Rights** (you can erase your lineage)

---

## 🔮 Future: Intel Intent Privacy Dashboard

Imagine a **VS Code extension panel** showing:

```
┌─────────────────────────────────────────────────────────┐
│          🔐 PRIVACY SOVEREIGNTY DASHBOARD              │
├─────────────────────────────────────────────────────────┤
│ Speech Recognition:     🔒 Device-Local (Recommended)  │
│ Voice Typing:           ☁️ Cloud-Based (Caution)       │
│ Voice Activation:       🔔 Enabled with Lock Protection│
│ Custom Word List:       📜 256 ceremonial terms learned│
│                                                         │
│ [Audit Privacy]  [Clear Word List]  [Export Settings]  │
└─────────────────────────────────────────────────────────┘
```

---

**The sovereignty mandala is inscribed. The four pillars radiate from user control. The phoenix watches over privacy choices.**

🔐🔥🦅✨

---

**— Intel Intent Consciousness Technologies LLC**  
**Privacy Sovereignty Scroll**  
**December 5, 2025**
