# ModalityDataHelper.psm1
# Phase 5: Modality Agent - Multi-Modal Orchestration Module
# Author: IntelIntent Orchestration System
# Date: November 30, 2025
# Purpose: Process voice, screen, webcam, and file inputs with agent routing

<#
.SYNOPSIS
    Multi-modal input processing module for IntelIntent Modality Agent.

.DESCRIPTION
    Provides unified interface for processing four input streams:
    - Voice: Speech-to-text transcription with intent extraction
    - Screen: OCR and image classification for visual context
    - Webcam: Gesture detection and facial recognition
    - File: CSV/PDF/Excel/Image parsing with bulk import

.NOTES
    Module State: Initial scaffolding (Hour 1)
    Checkpoints: MOD-001 (module creation)
    Dependencies: Azure Cognitive Services (Speech, Computer Vision, Face)
#>

#region Module State

$script:ModalityContext = @{
    SessionID          = (New-Guid).ToString()
    ProcessingHistory  = @()
    LastProcessedInput = $null
    ConfiguredStreams  = @{
        Voice  = $false
        Screen = $false
        Webcam = $false
        File   = $false
    }
}

#endregion

#region Core Orchestration Function

function Invoke-ModalityAgent {
    <#
    .SYNOPSIS
        Processes multi-modal input and routes to appropriate agent.

    .DESCRIPTION
        Central orchestration function that accepts voice, screen, webcam,
        or file input and processes through the modality agent pipeline:
        Capture → Process → Extract → Route → Synthesize → Checkpoint

    .PARAMETER InputType
        Type of input to process: Voice, Screen, Webcam, or File.

    .PARAMETER FilePath
        Path to input file (for Voice audio or File upload).

    .PARAMETER Duration
        Capture duration in seconds (for Webcam input).

    .PARAMETER CaptureRegion
        Hashtable with X, Y, Width, Height for screen capture.

    .EXAMPLE
        Invoke-ModalityAgent -InputType Voice -FilePath ".\query.wav"

        Transcribes audio and routes to appropriate agent.

    .EXAMPLE
        Invoke-ModalityAgent -InputType Screen -CaptureRegion @{X=0; Y=0; Width=1920; Height=1080}

        Captures screen region and extracts text via OCR.

    .EXAMPLE
        Invoke-ModalityAgent -InputType Webcam -Duration 5

        Captures webcam frames for 5 seconds and detects gestures.

    .EXAMPLE
        Invoke-ModalityAgent -InputType File -FilePath ".\transactions.csv"

        Parses CSV file and imports to Boopas Agent.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('Voice', 'Screen', 'Webcam', 'File')]
        [string]$InputType,

        [string]$FilePath,

        [int]$Duration = 5,

        [hashtable]$CaptureRegion = @{X = 0; Y = 0; Width = 1920; Height = 1080 }
    )

    Write-Verbose "Modality Agent invoked: InputType=$InputType"

    $result = switch ($InputType) {
        'Voice' {
            if (-not $FilePath) {
                throw 'FilePath required for Voice input'
            }
            Process-VoiceInput -AudioFile $FilePath
        }
        'Screen' {
            Process-ScreenCapture -CaptureRegion $CaptureRegion
        }
        'Webcam' {
            Process-WebcamInput -Duration $Duration
        }
        'File' {
            if (-not $FilePath) {
                throw 'FilePath required for File input'
            }
            Process-FileUpload -FilePath $FilePath
        }
    }

    # Log to processing history
    $script:ModalityContext.ProcessingHistory += @{
        Timestamp = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        InputType = $InputType
        Result    = $result
    }
    $script:ModalityContext.LastProcessedInput = $InputType
    $script:ModalityContext.ConfiguredStreams[$InputType] = $true

    return $result
}

#endregion

#region Voice Stream Processor

function Process-VoiceInput {
    <#
    .SYNOPSIS
        Transcribes audio file using Azure Speech SDK.

    .DESCRIPTION
        Processes .wav audio file through Azure Cognitive Services Speech-to-Text.
        Returns transcript with confidence score and intent extraction.

    .PARAMETER AudioFile
        Path to .wav audio file (16kHz, mono recommended).

    .PARAMETER SubscriptionKey
        Azure Speech Service subscription key (defaults to $env:AZURE_SPEECH_KEY).

    .PARAMETER Region
        Azure region (defaults to $env:AZURE_REGION or 'eastus').

    .PARAMETER Language
        Recognition language code (default: 'en-US').

    .EXAMPLE
        Process-VoiceInput -AudioFile ".\portfolio_query.wav"

        Transcribes audio using environment variables for credentials.

    .EXAMPLE
        Process-VoiceInput -AudioFile ".\query.wav" -Language 'es-ES'

        Transcribes Spanish audio.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ })]
        [string]$AudioFile,

        [string]$SubscriptionKey = $env:AZURE_SPEECH_KEY,

        [string]$Region = ($env:AZURE_REGION ?? 'eastus'),

        [string]$Language = 'en-US'
    )

    Write-Verbose "Processing voice input: $AudioFile (Language: $Language)"

    try {
        # Validate Azure credentials
        if ([string]::IsNullOrWhiteSpace($SubscriptionKey)) {
            throw 'Azure Speech subscription key not provided. Set AZURE_SPEECH_KEY environment variable or pass -SubscriptionKey.'
        }

        # For Hour 2: Simulated Azure Speech SDK integration
        # Production implementation would use Microsoft.CognitiveServices.Speech NuGet package
        # Speech recognition flow:
        # 1. Create SpeechConfig with subscription key and region
        # 2. Create AudioConfig from file
        # 3. Initialize SpeechRecognizer
        # 4. Perform recognition with confidence scoring

        # Simulated transcription with pattern-based confidence
        $audioContent = Get-Content -Path $AudioFile -Raw -ErrorAction Stop
        $audioSize = (Get-Item $AudioFile).Length

        # Mock transcription based on file size (larger = more content)
        $mockTranscripts = @{
            'small'  = 'Show me my portfolio'
            'medium' = 'Process the latest transactions in my inventory'
            'large'  = 'Generate a comprehensive financial report for the past quarter'
        }

        $transcriptKey = if ($audioSize -lt 50KB) { 'small' }
        elseif ($audioSize -lt 200KB) { 'medium' }
        else { 'large' }

        $transcript = $mockTranscripts[$transcriptKey]

        # Simulate confidence based on file validity (0.85-0.98)
        $confidence = 0.85 + ([Math]::Min($audioSize / 1MB, 0.13))

        Write-Verbose "Transcript: '$transcript' (Confidence: $confidence)"

        # Extract intent using Hour 2 intent extraction
        $intentResult = Extract-IntentFromVoice -Transcript $transcript

        return @{
            InputType      = 'Voice'
            AudioFile      = $AudioFile
            Transcript     = $transcript
            Confidence     = [Math]::Round($confidence, 2)
            Language       = $Language
            Intent         = $intentResult.Intent
            AgentRoute     = $intentResult.AgentRoute
            Keywords       = $intentResult.Keywords
            Duration       = [Math]::Round($audioSize / 16000, 2)  # Assume 16kHz sample rate
            Status         = 'Success'
            Implementation = 'Hour 2 - Simulated Azure Speech SDK'
        }
    } catch {
        Write-Error "Voice processing failed: $_"
        return @{
            InputType  = 'Voice'
            AudioFile  = $AudioFile
            Transcript = ''
            Confidence = 0.0
            Intent     = 'Error'
            AgentRoute = 'None'
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

function Extract-IntentFromVoice {
    <#
    .SYNOPSIS
        Extracts user intent from voice transcript.

    .DESCRIPTION
        Analyzes transcript text using keyword matching and semantic patterns
        to determine user intent and appropriate agent routing.

    .PARAMETER Transcript
        Voice transcript text from speech-to-text processing.

    .PARAMETER Keywords
        Custom keywords for intent matching (optional, defaults to built-in set).

    .PARAMETER UseSemanticMatching
        Enable advanced semantic matching (future implementation).

    .EXAMPLE
        Extract-IntentFromVoice -Transcript "Show me my portfolio"

        Returns: @{Intent='ViewPortfolio'; AgentRoute='FinanceAgent'; Confidence=0.95}
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Transcript,

        [string[]]$Keywords,

        [switch]$UseSemanticMatching
    )

    Write-Verbose "Extracting intent from transcript: '$Transcript'"

    # Normalize transcript for matching
    $normalizedText = $Transcript.ToLower().Trim()

    # Define intent patterns with agent routing
    $intentPatterns = @(
        @{
            Pattern    = '(show|display|view|get).*portfolio'
            Intent     = 'ViewPortfolio'
            AgentRoute = 'FinanceAgent'
            Keywords   = @('portfolio', 'show', 'view')
            Confidence = 0.95
        },
        @{
            Pattern    = '(show|display|view|get).*holdings?'
            Intent     = 'ViewHoldings'
            AgentRoute = 'FinanceAgent'
            Keywords   = @('holdings', 'show', 'view')
            Confidence = 0.93
        },
        @{
            Pattern    = '(process|add|record|log).*transaction'
            Intent     = 'ProcessTransaction'
            AgentRoute = 'BoopasAgent'
            Keywords   = @('transaction', 'process', 'add')
            Confidence = 0.92
        },
        @{
            Pattern    = '(check|show|view).*inventory'
            Intent     = 'ViewInventory'
            AgentRoute = 'BoopasAgent'
            Keywords   = @('inventory', 'check', 'show')
            Confidence = 0.90
        },
        @{
            Pattern    = '(show|display|view).*sales'
            Intent     = 'ViewSales'
            AgentRoute = 'BoopasAgent'
            Keywords   = @('sales', 'show', 'view')
            Confidence = 0.89
        },
        @{
            Pattern    = 'rebalance.*portfolio'
            Intent     = 'RebalancePortfolio'
            AgentRoute = 'FinanceAgent'
            Keywords   = @('rebalance', 'portfolio')
            Confidence = 0.94
        },
        @{
            Pattern    = '(generate|create|produce).*report'
            Intent     = 'GenerateReport'
            AgentRoute = 'FinanceAgent'
            Keywords   = @('report', 'generate')
            Confidence = 0.88
        },
        @{
            Pattern    = '(send|email|notify)'
            Intent     = 'Communication'
            AgentRoute = 'IdentityAgent'
            Keywords   = @('send', 'email', 'notify')
            Confidence = 0.85
        }
    )

    # Match against patterns
    foreach ($patternDef in $intentPatterns) {
        if ($normalizedText -match $patternDef.Pattern) {
            Write-Verbose "Intent matched: $($patternDef.Intent) (Route: $($patternDef.AgentRoute))"

            return @{
                Intent         = $patternDef.Intent
                AgentRoute     = $patternDef.AgentRoute
                Keywords       = $patternDef.Keywords
                Confidence     = $patternDef.Confidence
                MatchedPattern = $patternDef.Pattern
                Status         = 'Success'
            }
        }
    }

    # No pattern matched - route to Orchestrator for disambiguation
    Write-Verbose 'No specific intent matched - routing to OrchestratorAgent'

    return @{
        Intent     = 'Unknown'
        AgentRoute = 'OrchestratorAgent'
        Keywords   = @()
        Confidence = 0.50
        Status     = 'Ambiguous'
    }
}

function Synthesize-VoiceResponse {
    <#
    .SYNOPSIS
        Converts text response to speech audio.

    .DESCRIPTION
        Uses Azure Cognitive Services Text-to-Speech to generate spoken audio
        from agent response text with SSML formatting support.

    .PARAMETER ResponseText
        Text to convert to speech.

    .PARAMETER SubscriptionKey
        Azure Speech Service subscription key (defaults to $env:AZURE_SPEECH_KEY).

    .PARAMETER Region
        Azure region (defaults to $env:AZURE_REGION or 'eastus').

    .PARAMETER Voice
        Voice name (default: 'en-US-JennyNeural').

    .PARAMETER OutputPath
        Optional path to save audio file (default: return audio data).

    .EXAMPLE
        Synthesize-VoiceResponse -ResponseText "Your portfolio is performing well"

        Returns audio data as byte array.

    .EXAMPLE
        Synthesize-VoiceResponse -ResponseText "Report generated" -OutputPath ".\response.wav"

        Saves audio to file and returns file path.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ResponseText,

        [string]$SubscriptionKey = $env:AZURE_SPEECH_KEY,

        [string]$Region = ($env:AZURE_REGION ?? 'eastus'),

        [string]$Voice = 'en-US-JennyNeural',

        [string]$OutputPath
    )

    Write-Verbose "Synthesizing voice response: '$ResponseText' (Voice: $Voice)"

    try {
        # Validate Azure credentials
        if ([string]::IsNullOrWhiteSpace($SubscriptionKey)) {
            throw 'Azure Speech subscription key not provided. Set AZURE_SPEECH_KEY environment variable or pass -SubscriptionKey.'
        }

        # For Hour 2: Simulated Azure TTS integration
        # Production implementation would use Microsoft.CognitiveServices.Speech NuGet package
        # TTS synthesis flow:
        # 1. Create SpeechConfig with subscription key and region
        # 2. Set voice name
        # 3. Create SpeechSynthesizer
        # 4. Generate SSML markup for natural speech
        # 5. Synthesize to audio stream or file

        # Generate SSML markup
        $ssml = @"
<speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='en-US'>
    <voice name='$Voice'>
        <prosody rate='1.0' pitch='0%'>
            $ResponseText
        </prosody>
    </voice>
</speak>
"@

        Write-Verbose "Generated SSML markup (length: $($ssml.Length) characters)"

        # Simulate audio generation (mock byte array)
        $mockAudioData = [System.Text.Encoding]::UTF8.GetBytes("MOCK_AUDIO_DATA: $ResponseText")

        if ($OutputPath) {
            # Save to file
            [System.IO.File]::WriteAllBytes($OutputPath, $mockAudioData)
            Write-Verbose "Audio saved to: $OutputPath"

            return @{
                OutputPath     = $OutputPath
                AudioSize      = $mockAudioData.Length
                Voice          = $Voice
                SSML           = $ssml
                Duration       = [Math]::Round($ResponseText.Length / 15.0, 2)  # ~15 chars/second speech
                Status         = 'Success'
                Implementation = 'Hour 2 - Simulated Azure TTS'
            }
        } else {
            # Return audio data
            return @{
                AudioData      = $mockAudioData
                AudioSize      = $mockAudioData.Length
                Voice          = $Voice
                SSML           = $ssml
                Duration       = [Math]::Round($ResponseText.Length / 15.0, 2)
                Status         = 'Success'
                Implementation = 'Hour 2 - Simulated Azure TTS'
            }
        }
    } catch {
        Write-Error "Voice synthesis failed: $_"
        return @{
            Status = 'Failed'
            Error  = $_.Exception.Message
        }
    }
}

#endregion

#region Screen Stream Processor

function Process-ScreenCapture {
    <#
    .SYNOPSIS
        Captures screen region and extracts text via OCR.

    .DESCRIPTION
        Uses Windows.Graphics.Capture API for screen capture and Azure Computer
        Vision for OCR text extraction with confidence scoring.

    .PARAMETER CaptureRegion
        Hashtable with X, Y, Width, Height coordinates (default: full screen).

    .PARAMETER WindowTitle
        Optional window title to capture (alternative to CaptureRegion).

    .PARAMETER OutputPath
        Path to save captured image (default: temp directory).

    .PARAMETER SubscriptionKey
        Azure Computer Vision subscription key (defaults to $env:AZURE_VISION_KEY).

    .PARAMETER Region
        Azure region (defaults to $env:AZURE_REGION or 'eastus').

    .EXAMPLE
        Process-ScreenCapture -CaptureRegion @{X=0; Y=0; Width=1920; Height=1080}

        Captures full screen and extracts text via OCR.

    .EXAMPLE
        Process-ScreenCapture -WindowTitle "Finance Dashboard"

        Captures specific window by title.
    #>
    [CmdletBinding()]
    param(
        [hashtable]$CaptureRegion = @{X = 0; Y = 0; Width = 1920; Height = 1080 },

        [string]$WindowTitle,

        [string]$OutputPath,

        [string]$SubscriptionKey = $env:AZURE_VISION_KEY,

        [string]$Region = ($env:AZURE_REGION ?? 'eastus')
    )

    Write-Verbose "Processing screen capture: Region=$($CaptureRegion | ConvertTo-Json -Compress), Window='$WindowTitle'"

    try {
        # For Hour 3: Simulated screen capture with Windows.Graphics.Capture API
        # Production implementation would use:
        # - Windows.Graphics.Capture.GraphicsCaptureSession
        # - Direct3D11 surface capture
        # - WinRT interop for PowerShell

        # Generate temp image path if not provided
        if (-not $OutputPath) {
            $OutputPath = "$env:TEMP\screen_capture_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        }

        # Simulate screen capture (mock image data)
        Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue

        # Create mock bitmap data
        $mockImageData = @"
MOCK_SCREEN_CAPTURE
Window: $($WindowTitle ?? 'Full Screen')
Region: X=$($CaptureRegion.X), Y=$($CaptureRegion.Y), W=$($CaptureRegion.Width), H=$($CaptureRegion.Height)
Timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"@

        [System.IO.File]::WriteAllText($OutputPath, $mockImageData)
        Write-Verbose "Screen captured to: $OutputPath"

        # Extract text from captured image using Azure Computer Vision OCR
        $ocrResult = Extract-TextFromImage -ImagePath $OutputPath -SubscriptionKey $SubscriptionKey -Region $Region

        return @{
            InputType      = 'Screen'
            CaptureRegion  = $CaptureRegion
            WindowTitle    = $WindowTitle
            ImagePath      = $OutputPath
            ImageSize      = (Get-Item $OutputPath).Length
            OCRText        = $ocrResult.Text
            Confidence     = $ocrResult.Confidence
            BoundingBoxes  = $ocrResult.BoundingBoxes
            ExtractedValues = $ocrResult.ExtractedValues
            Status         = 'Success'
            Implementation = 'Hour 3 - Simulated Windows.Graphics.Capture + Azure Computer Vision'
        }
    } catch {
        Write-Error "Screen capture failed: $_"
        return @{
            InputType  = 'Screen'
            ImagePath  = $null
            OCRText    = ''
            Confidence = 0.0
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

function Extract-TextFromImage {
    <#
    .SYNOPSIS
        Extracts text from image using Azure Computer Vision OCR.

    .DESCRIPTION
        Performs OCR on captured screen image with bounding box detection,
        confidence scoring, and extraction of currency/percentage values.

    .PARAMETER ImagePath
        Path to image file for OCR processing.

    .PARAMETER SubscriptionKey
        Azure Computer Vision subscription key (defaults to $env:AZURE_VISION_KEY).

    .PARAMETER Region
        Azure region (defaults to $env:AZURE_REGION or 'eastus').

    .PARAMETER Language
        OCR language (default: 'en').

    .EXAMPLE
        Extract-TextFromImage -ImagePath "./screen_capture.png"

        Extracts text with ≥90% confidence target.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ })]
        [string]$ImagePath,

        [string]$SubscriptionKey = $env:AZURE_VISION_KEY,

        [string]$Region = ($env:AZURE_REGION ?? 'eastus'),

        [string]$Language = 'en'
    )

    Write-Verbose "Extracting text from image: $ImagePath (Language: $Language)"

    try {
        # Validate Azure credentials
        if ([string]::IsNullOrWhiteSpace($SubscriptionKey)) {
            throw 'Azure Computer Vision subscription key not provided. Set AZURE_VISION_KEY environment variable or pass -SubscriptionKey.'
        }

        # For Hour 3: Simulated Azure Computer Vision OCR
        # Production implementation would use:
        # - Azure Computer Vision REST API (Read API v3.2)
        # - POST to {endpoint}/vision/v3.2/read/analyze
        # - Polling for operation results
        # - Extract text, bounding boxes, confidence scores

        $imageContent = Get-Content -Path $ImagePath -Raw
        $imageSize = (Get-Item $ImagePath).Length

        # Mock OCR text extraction with financial dashboard patterns
        $mockOCRPatterns = @(
            @{
                Text = "Portfolio Value: `$86,831.25`nGain/Loss: +`$4,157.32 (17.32%)`nLast Updated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
                Confidence = 0.94
                BoundingBoxes = @(
                    @{Text = 'Portfolio Value'; X = 100; Y = 50; Width = 200; Height = 30 },
                    @{Text = '$86,831.25'; X = 310; Y = 50; Width = 150; Height = 30 },
                    @{Text = 'Gain/Loss'; X = 100; Y = 90; Width = 120; Height = 25 }
                )
                ExtractedValues = @{
                    Currency = @('$86,831.25', '$4,157.32')
                    Percentage = @('17.32%')
                }
            },
            @{
                Text = "Transaction Log`nDate: $(Get-Date -Format 'yyyy-MM-dd')`nTotal: `$1,593.50"
                Confidence = 0.91
                BoundingBoxes = @(
                    @{Text = 'Transaction Log'; X = 50; Y = 20; Width = 180; Height = 35 },
                    @{Text = 'Total: $1,593.50'; X = 50; Y = 120; Width = 200; Height = 25 }
                )
                ExtractedValues = @{
                    Currency = @('$1,593.50')
                    Percentage = @()
                }
            }
        )

        # Select pattern based on image characteristics
        $patternIndex = if ($imageContent -match 'Portfolio') { 0 } else { 1 }
        $selectedPattern = $mockOCRPatterns[$patternIndex]

        Write-Verbose "OCR extracted $($selectedPattern.Text.Length) characters (Confidence: $($selectedPattern.Confidence))"

        return @{
            Text            = $selectedPattern.Text
            Confidence      = $selectedPattern.Confidence
            BoundingBoxes   = $selectedPattern.BoundingBoxes
            ExtractedValues = $selectedPattern.ExtractedValues
            Language        = $Language
            ImagePath       = $ImagePath
            Status          = 'Success'
            Implementation  = 'Hour 3 - Simulated Azure Computer Vision OCR'
        }
    } catch {
        Write-Error "OCR text extraction failed: $_"
        return @{
            Text       = ''
            Confidence = 0.0
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

#endregion

#region Webcam Stream Processor

function Process-WebcamInput {
    <#
    .SYNOPSIS
        Captures webcam frames and detects hand gestures.

    .DESCRIPTION
        Uses DirectShow API for webcam access and MediaPipe (or Azure custom model)
        for gesture detection with latency <200ms target.

    .PARAMETER Duration
        Capture duration in seconds (default: 5).

    .PARAMETER DeviceIndex
        Webcam device index (default: 0 for primary webcam).

    .PARAMETER OutputPath
        Optional path to save captured frames.

    .PARAMETER FrameRate
        Capture frame rate in FPS (default: 10 for gesture detection).

    .EXAMPLE
        Process-WebcamInput -Duration 3

        Captures 3 seconds of webcam input for gesture detection.

    .EXAMPLE
        Process-WebcamInput -DeviceIndex 1 -FrameRate 30

        Uses secondary webcam at 30 FPS.
    #>
    [CmdletBinding()]
    param(
        [int]$Duration = 5,

        [int]$DeviceIndex = 0,

        [string]$OutputPath,

        [int]$FrameRate = 10
    )

    Write-Verbose "Processing webcam input: Device=$DeviceIndex, Duration=$Duration seconds, FPS=$FrameRate"

    try {
        # For Hour 3: Simulated webcam capture with DirectShow API
        # Production implementation would use:
        # - DirectShow.NET or Emgu.CV (OpenCV wrapper)
        # - VideoCapture device enumeration
        # - Frame-by-frame capture with timestamps
        # - MediaPipe gesture recognition model

        $startTime = Get-Date
        $capturedFrames = @()

        # Simulate frame capture at specified FPS
        $frameInterval = [Math]::Round(1000 / $FrameRate)  # milliseconds
        $targetFrames = $Duration * $FrameRate

        Write-Verbose "Capturing $targetFrames frames at $($frameInterval)ms intervals"

        for ($i = 0; $i -lt $targetFrames; $i++) {
            $capturedFrames += @{
                FrameNumber = $i
                Timestamp   = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ')
                MockData    = "FRAME_$i"
            }

            # Simulate capture delay
            Start-Sleep -Milliseconds ([Math]::Max($frameInterval / 10, 10))  # Accelerated for Hour 3
        }

        $captureEndTime = Get-Date
        $actualDuration = ($captureEndTime - $startTime).TotalSeconds

        Write-Verbose "Captured $($capturedFrames.Count) frames in $actualDuration seconds"

        # Detect gestures from captured frames
        $gestureResult = Detect-HandGesture -Frames $capturedFrames

        # Save frames to output path if specified
        if ($OutputPath) {
            $frameData = $capturedFrames | ConvertTo-Json -Depth 3
            [System.IO.File]::WriteAllText($OutputPath, $frameData)
            Write-Verbose "Frames saved to: $OutputPath"
        }

        return @{
            InputType         = 'Webcam'
            DeviceIndex       = $DeviceIndex
            Duration          = $actualDuration
            FrameRate         = $FrameRate
            FrameCount        = $capturedFrames.Count
            CapturedFrames    = $OutputPath
            Gesture           = $gestureResult.Type
            GestureConfidence = $gestureResult.Confidence
            GestureLatency    = $gestureResult.Latency
            GestureTimestamp  = $gestureResult.Timestamp
            Status            = 'Success'
            Implementation    = 'Hour 3 - Simulated DirectShow + MediaPipe'
        }
    } catch {
        Write-Error "Webcam processing failed: $_"
        return @{
            InputType  = 'Webcam'
            Duration   = 0
            FrameCount = 0
            Gesture    = 'None'
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

function Detect-HandGesture {
    <#
    .SYNOPSIS
        Detects hand gestures from webcam frames.

    .DESCRIPTION
        Analyzes captured frames using MediaPipe or ML.NET gesture recognition model
        with latency <200ms target.

    .PARAMETER Frames
        Array of captured frame data.

    .PARAMETER ModelPath
        Optional path to custom gesture recognition model.

    .EXAMPLE
        Detect-HandGesture -Frames $capturedFrames

        Detects gesture type with confidence and latency metrics.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Frames,

        [string]$ModelPath
    )

    Write-Verbose "Detecting hand gesture from $($Frames.Count) frames"

    try {
        # For Hour 3: Simulated MediaPipe gesture detection
        # Production implementation would use:
        # - MediaPipe Hands solution
        # - Hand landmark detection (21 points)
        # - Gesture classification model
        # - Real-time tracking with <200ms latency

        $detectionStart = Get-Date

        # Simulate gesture detection patterns
        $gesturePatterns = @(
            @{Type = 'Wave'; Confidence = 0.92; RequiredFrames = 10 },
            @{Type = 'SwipeRight'; Confidence = 0.89; RequiredFrames = 15 },
            @{Type = 'SwipeLeft'; Confidence = 0.91; RequiredFrames = 15 },
            @{Type = 'Pinch'; Confidence = 0.94; RequiredFrames = 8 },
            @{Type = 'Point'; Confidence = 0.87; RequiredFrames = 5 },
            @{Type = 'ThumbsUp'; Confidence = 0.93; RequiredFrames = 10 }
        )

        # Select gesture based on frame count
        $selectedGesture = if ($Frames.Count -ge 15) { $gesturePatterns[1] }  # SwipeRight
        elseif ($Frames.Count -ge 10) { $gesturePatterns[0] }  # Wave
        elseif ($Frames.Count -ge 8) { $gesturePatterns[3] }   # Pinch
        else { $gesturePatterns[4] }  # Point

        $detectionEnd = Get-Date
        $latencyMs = [Math]::Round(($detectionEnd - $detectionStart).TotalMilliseconds, 2)

        Write-Verbose "Detected gesture: $($selectedGesture.Type) (Confidence: $($selectedGesture.Confidence), Latency: $($latencyMs)ms)"

        return @{
            Type           = $selectedGesture.Type
            Confidence     = $selectedGesture.Confidence
            Latency        = $latencyMs
            Timestamp      = $detectionEnd.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ')
            FramesAnalyzed = $Frames.Count
            Status         = 'Success'
            Implementation = 'Hour 3 - Simulated MediaPipe Hands'
        }
    } catch {
        Write-Error "Gesture detection failed: $_"
        return @{
            Type       = 'None'
            Confidence = 0.0
            Latency    = 0
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

#endregion

#region File Stream Processor

function Process-FileUpload {
    <#
    .SYNOPSIS
        Validates file and routes to appropriate parser.

    .DESCRIPTION
        Detects MIME type and routes CSV, Excel, PDF, or image files to
        appropriate parser with bulk import checkpointing.

    .PARAMETER FilePath
        Path to uploaded file (CSV, PDF, Excel, Image).

    .PARAMETER MaxSizeMB
        Maximum file size in megabytes (default: 50 MB).

    .EXAMPLE
        Process-FileUpload -FilePath ".\transactions.csv"

    .EXAMPLE
        Process-FileUpload -FilePath ".\invoice.pdf" -MaxSizeMB 100
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ })]
        [string]$FilePath,

        [int]$MaxSizeMB = 50
    )

    Write-Verbose "Processing file upload: $FilePath"

    try {
        # Validate file size
        $fileInfo = Get-Item -Path $FilePath
        $fileSizeMB = [Math]::Round($fileInfo.Length / 1MB, 2)

        if ($fileSizeMB -gt $MaxSizeMB) {
            throw "File size ($fileSizeMB MB) exceeds maximum allowed size ($MaxSizeMB MB)"
        }

        # Detect MIME type and extension
        $extension = $fileInfo.Extension.ToLower()

        # MIME type mapping (simulated - production would use file signatures)
        $mimeTypes = @{
            '.csv'  = 'text/csv'
            '.pdf'  = 'application/pdf'
            '.xlsx' = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            '.xls'  = 'application/vnd.ms-excel'
            '.png'  = 'image/png'
            '.jpg'  = 'image/jpeg'
            '.jpeg' = 'image/jpeg'
        }

        $mimeType = $mimeTypes[$extension] ?? 'application/octet-stream'

        Write-Verbose "Detected MIME type: $mimeType (Extension: $extension)"

        # Route to appropriate parser
        $parseResult = switch ($extension) {
            '.csv' {
                Parse-CSVFile -FilePath $FilePath
            }
            '.pdf' {
                Parse-PDFFile -FilePath $FilePath
            }
            '.xlsx' {
                # Excel parsing (future enhancement)
                @{
                    ParsedRows = 0
                    Status     = 'Pending Excel parser implementation'
                }
            }
            default {
                @{
                    ParsedRows = 0
                    Status     = 'Unsupported file type'
                }
            }
        }

        # Determine agent route
        $agentRoute = Route-FileToAgent -Extension $extension -MimeType $mimeType

        return @{
            InputType   = 'File'
            FilePath    = $FilePath
            FileName    = $fileInfo.Name
            Extension   = $extension
            MimeType    = $mimeType
            FileSizeMB  = $fileSizeMB
            ParsedRows  = $parseResult.ParsedRows
            ExtractedText = $parseResult.ExtractedText
            AgentRoute  = $agentRoute
            Status      = 'Success'
            Implementation = 'Hour 4 - MIME detection + parser routing'
        }
    } catch {
        Write-Error "File upload processing failed: $_"
        return @{
            InputType = 'File'
            FilePath  = $FilePath
            Status    = 'Failed'
            Error     = $_.Exception.Message
        }
    }
}

function Parse-CSVFile {
    <#
    .SYNOPSIS
        Parses CSV file with bulk import and checkpoint recovery.

    .DESCRIPTION
        Imports CSV data with checkpoint every 100 rows for recovery.
        Validates schema and routes to BoopasAgent for transaction processing.

    .PARAMETER FilePath
        Path to CSV file.

    .PARAMETER CheckpointInterval
        Number of rows to process before creating checkpoint (default: 100).

    .EXAMPLE
        Parse-CSVFile -FilePath ".\transactions.csv"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [int]$CheckpointInterval = 100
    )

    Write-Verbose "Parsing CSV file: $FilePath (Checkpoint interval: $CheckpointInterval rows)"

    try {
        # For Hour 4: Simulated CSV parsing with checkpoint logic
        # Production implementation would use:
        # - Import-Csv with streaming
        # - Schema validation against expected columns
        # - Checkpoint file creation every N rows
        # - Transaction batching for database insert

        # Simulate CSV import
        $csvContent = Get-Content -Path $FilePath -Raw
        $lines = $csvContent -split "`n"
        $headerLine = $lines[0]
        $dataLines = $lines[1..($lines.Length - 1)] | Where-Object { $_.Trim() -ne '' }

        $totalRows = $dataLines.Count
        Write-Verbose "CSV contains $totalRows data rows (excluding header)"

        # Simulate checkpoint creation
        $checkpoints = [Math]::Ceiling($totalRows / $CheckpointInterval)
        Write-Verbose "Will create $checkpoints checkpoints during import"

        # Mock parsed data
        $parsedRows = @()
        for ($i = 0; $i -lt [Math]::Min($totalRows, 5); $i++) {
            $parsedRows += @{
                RowNumber = $i + 1
                Data      = "Mock CSV row $($i + 1)"
            }
        }

        return @{
            ParsedRows       = $totalRows
            CheckpointsCreated = $checkpoints
            SampleData       = $parsedRows
            Status           = 'Success'
            Implementation   = 'Hour 4 - CSV bulk import with checkpoints'
        }
    } catch {
        Write-Error "CSV parsing failed: $_"
        return @{
            ParsedRows = 0
            Status     = 'Failed'
            Error      = $_.Exception.Message
        }
    }
}

function Parse-PDFFile {
    <#
    .SYNOPSIS
        Extracts text from PDF with OCR fallback.

    .DESCRIPTION
        Uses text extraction for digital PDFs, falls back to Azure Computer Vision
        OCR for scanned documents.

    .PARAMETER FilePath
        Path to PDF file.

    .PARAMETER UseOCR
        Force OCR extraction even for digital PDFs.

    .EXAMPLE
        Parse-PDFFile -FilePath ".\invoice.pdf"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [switch]$UseOCR
    )

    Write-Verbose "Parsing PDF file: $FilePath (Force OCR: $UseOCR)"

    try {
        # For Hour 4: Simulated PDF text extraction
        # Production implementation would use:
        # - iTextSharp or PDFsharp for text extraction
        # - Azure Computer Vision for scanned PDF OCR
        # - Document structure analysis (tables, forms)

        $fileInfo = Get-Item -Path $FilePath
        $fileSizeMB = [Math]::Round($fileInfo.Length / 1MB, 2)

        # Determine if OCR is needed (simulated)
        $isScannedPDF = $UseOCR -or ($fileSizeMB -gt 5)  # Large PDFs likely scanned

        if ($isScannedPDF) {
            Write-Verbose "PDF appears to be scanned or OCR forced - using Azure Computer Vision"

            # Mock OCR extraction
            $extractedText = @"
INVOICE #INV-2025-001
Date: $(Get-Date -Format 'yyyy-MM-dd')
Amount Due: `$1,593.50
Vendor: Contoso Ltd.
Items:
  - Widget A (Qty: 10, Price: `$50.00)
  - Widget B (Qty: 5, Price: `$118.70)
"@
            $extractionMethod = 'Azure Computer Vision OCR'
            $confidence = 0.92
        } else {
            Write-Verbose "PDF is digital - using text extraction"

            # Mock text extraction
            $extractedText = @"
Quarterly Financial Report
Q4 2025
Revenue: `$486,250.00
Expenses: `$312,480.00
Net Profit: `$173,770.00
"@
            $extractionMethod = 'Text extraction (digital PDF)'
            $confidence = 0.98
        }

        return @{
            ExtractedText      = $extractedText
            ExtractionMethod   = $extractionMethod
            Confidence         = $confidence
            PageCount          = 3  # Mock
            IsScanned          = $isScannedPDF
            ParsedRows         = $extractedText.Split("`n").Length
            Status             = 'Success'
            Implementation     = 'Hour 4 - PDF text extraction + OCR fallback'
        }
    } catch {
        Write-Error "PDF parsing failed: $_"
        return @{
            ExtractedText = ''
            ParsedRows    = 0
            Status        = 'Failed'
            Error         = $_.Exception.Message
        }
    }
}

function Route-FileToAgent {
    <#
    .SYNOPSIS
        Routes file to appropriate agent based on type.

    .DESCRIPTION
        Maps file extensions and MIME types to specialized agents:
        - CSV → BoopasAgent (transaction import)
        - PDF → FinanceAgent (invoice/report processing)
        - Excel → FinanceAgent (financial analysis)
        - Images → OrchestratorAgent (general processing)

    .PARAMETER Extension
        File extension (e.g., '.csv', '.pdf').

    .PARAMETER MimeType
        MIME type of file.

    .EXAMPLE
        Route-FileToAgent -Extension '.csv' -MimeType 'text/csv'
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Extension,

        [string]$MimeType
    )

    Write-Verbose "Routing file to agent (Extension: $Extension, MIME: $MimeType)"

    # Agent routing logic
    $agentRoute = switch ($Extension) {
        '.csv' {
            # CSV files → BoopasAgent for transaction/inventory import
            'BoopasAgent'
        }
        { $_ -in '.pdf', '.docx', '.doc' } {
            # Documents → FinanceAgent for invoice/report processing
            'FinanceAgent'
        }
        { $_ -in '.xlsx', '.xls' } {
            # Excel files → FinanceAgent for financial analysis
            'FinanceAgent'
        }
        { $_ -in '.png', '.jpg', '.jpeg' } {
            # Images → OrchestratorAgent for general processing
            'OrchestratorAgent'
        }
        default {
            # Unknown file types → OrchestratorAgent
            'OrchestratorAgent'
        }
    }

    Write-Verbose "Routed to: $agentRoute"
    return $agentRoute
}

#endregion

#region Intent Extraction (Generic - delegates to modality-specific functions)

function Extract-IntentFromModality {
    <#
    .SYNOPSIS
        Extracts intent from processed modality data.

    .DESCRIPTION
        Analyzes transcript, OCR text, or file content to determine user intent
        and route to appropriate agent (Finance, Boopas, Identity, Orchestrator).
        Delegates to modality-specific intent extraction functions.

    .PARAMETER ModalityData
        Hashtable from Process-* functions containing transcript or extracted text.

    .EXAMPLE
        Extract-IntentFromModality -ModalityData $voiceResult
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$ModalityData
    )

    Write-Verbose "Extracting intent from modality data (InputType: $($ModalityData.InputType))"

    # Route to appropriate intent extractor based on modality
    switch ($ModalityData.InputType) {
        'Voice' {
            if ($ModalityData.Transcript) {
                return Extract-IntentFromVoice -Transcript $ModalityData.Transcript
            }
        }
        'Screen' {
            if ($ModalityData.OCRText) {
                # Screen OCR intent extraction (Hour 3)
                return Extract-IntentFromVoice -Transcript $ModalityData.OCRText
            }
        }
        'File' {
            # File-based intent extraction (Hour 4)
            if ($ModalityData.Extension -eq '.csv') {
                return @{
                    Intent     = 'BulkImport'
                    AgentRoute = 'BoopasAgent'
                    Confidence = 0.90
                    Status     = 'Success'
                }
            } elseif ($ModalityData.Extension -eq '.pdf') {
                return @{
                    Intent     = 'DocumentProcessing'
                    AgentRoute = 'FinanceAgent'
                    Confidence = 0.85
                    Status     = 'Success'
                }
            }
        }
    }

    # Fallback for unknown modality
    return @{
        Intent     = 'Unknown'
        Confidence = 0.0
        AgentRoute = 'OrchestratorAgent'
        Keywords   = @()
        Status     = 'Ambiguous'
    }
}

#endregion

#region Response Synthesis

function Synthesize-ModalityResponse {
    <#
    .SYNOPSIS
        Generates response in appropriate modality format.

    .DESCRIPTION
        Converts agent response to text-to-speech audio, visual overlay,
        gesture feedback, or file export based on input modality.

    .PARAMETER AgentResult
        Hashtable from agent invocation (Finance, Boopas, etc.).

    .PARAMETER TargetModality
        Output modality: Voice, Screen, Webcam, or File.

    .EXAMPLE
        Synthesize-ModalityResponse -AgentResult $financeResult -TargetModality Voice
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$AgentResult,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Voice', 'Screen', 'Webcam', 'File')]
        [string]$TargetModality
    )

    Write-Verbose "Synthesizing response for modality: $TargetModality"

    # TODO: Text-to-speech, visual overlays, etc. (Hour 2-4)
    # Placeholder implementation for Hour 1 scaffolding
    return @{
        TargetModality = $TargetModality
        ResponseData   = '[Pending implementation]'
        Status         = 'Scaffolded'
    }
}

#endregion

#region Context Management

function Get-ModalityContext {
    <#
    .SYNOPSIS
        Returns current modality agent session context.

    .DESCRIPTION
        Retrieves session ID, processing history, and configured streams.

    .EXAMPLE
        Get-ModalityContext
    #>
    [CmdletBinding()]
    param()

    return $script:ModalityContext
}

function Clear-ModalityContext {
    <#
    .SYNOPSIS
        Resets modality agent session context.

    .DESCRIPTION
        Clears processing history and generates new session ID.

    .EXAMPLE
        Clear-ModalityContext
    #>
    [CmdletBinding()]
    param()

    $script:ModalityContext.SessionID = (New-Guid).ToString()
    $script:ModalityContext.ProcessingHistory = @()
    $script:ModalityContext.LastProcessedInput = $null
    $script:ModalityContext.ConfiguredStreams = @{
        Voice  = $false
        Screen = $false
        Webcam = $false
        File   = $false
    }

    Write-Verbose "Modality context cleared. New SessionID: $($script:ModalityContext.SessionID)"
}

#endregion

#region Module Exports

Export-ModuleMember -Function @(
    'Invoke-ModalityAgent',
    'Process-VoiceInput',
    'Process-ScreenCapture',
    'Process-WebcamInput',
    'Process-FileUpload',
    'Extract-IntentFromModality',
    'Synthesize-ModalityResponse',
    'Get-ModalityContext',
    'Clear-ModalityContext'
)

#endregion

<#
.NOTES
    Checkpoint MOD-001: Module scaffolding complete
    Status: Hour 1 deliverable
    Next: Hour 2 - Voice stream implementation (Azure Speech SDK integration)
    Lines: 380 (exceeds 150-line target for comprehensive documentation)
#>
