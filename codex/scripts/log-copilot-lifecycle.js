const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

/**
 * Generates ISO 8601 timestamp
 */
function nowIso() {
  return new Date().toISOString();
}

/**
 * Generates RunId in format RUN-YYYYMMDD-HHMMSS
 */
function runId() {
  const d = new Date();
  return `RUN-${d.toISOString().slice(0, 19).replace(/[:T-]/g, '').slice(0, 8)}-${d.toISOString().slice(11, 19).replace(/:/g, '')}`;
}

/**
 * Calculates SHA256 hash of VSIX file if available
 */
function getVsixHash(extensionId, version) {
  const homeDir = require('os').homedir();
  const locations = [
    path.join(homeDir, '.vscode', 'extensions', `${extensionId}-${version}.vsix`),
    path.join(homeDir, '.vscode-insiders', 'extensions', `${extensionId}-${version}.vsix`),
    path.join(__dirname, `${extensionId}-${version}.vsix`)
  ];

  for (const location of locations) {
    if (fs.existsSync(location)) {
      try {
        const fileBuffer = fs.readFileSync(location);
        const hash = crypto.createHash('sha256').update(fileBuffer).digest('hex');
        console.log(`✅ Calculated hash for ${location}`);
        return hash.toUpperCase();
      } catch (err) {
        console.warn(`⚠️ Failed to calculate hash for ${location}`);
      }
    }
  }

  return '[Pending SHA256]';
}

/**
 * Ensures log file exists with valid JSON array
 */
function initializeLogFile(logPath) {
  const dir = path.dirname(logPath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`📁 Created log directory: ${dir}`);
  }

  if (!fs.existsSync(logPath)) {
    fs.writeFileSync(logPath, JSON.stringify([], null, 2), 'utf8');
    console.log(`📄 Initialized log file: ${logPath}`);
  }
}

/**
 * Appends entry to JSON log file
 */
function appendJsonEntry(logPath, entry) {
  initializeLogFile(logPath);

  let logs = [];
  if (fs.existsSync(logPath)) {
    const content = fs.readFileSync(logPath, 'utf8');
    logs = JSON.parse(content);
  }

  logs.push(entry);
  fs.writeFileSync(logPath, JSON.stringify(logs, null, 2), 'utf8');
}

/**
 * Logs Copilot lifecycle event
 */
function logLifecycle({
  Action,
  ExtensionID = 'github.copilot',
  Version,
  Workspace,
  Reason,
  Stage = 'Configuration',
  Result = 'Success',
  LogPath = path.join(__dirname, '..', 'logs', 'CopilotLifecycleLog.json')
}) {
  if (!Action) throw new Error('Action is required');
  if (!Version) throw new Error('Version is required');
  if (!Workspace) throw new Error('Workspace is required');
  if (!Reason) throw new Error('Reason is required');

  const entry = {
    Timestamp: nowIso(),
    RunId: runId(),
    LifecycleAction: Action,
    ExtensionID,
    Version,
    WorkspaceName: Workspace,
    WorkspaceScope: Workspace === 'Global' ? 'Global' : 'Workspace',
    Reason,
    Stage,
    Result,
    Hash: getVsixHash(ExtensionID, Version),
    ExtensionUnification: true,
    SessionID: process.env.VSCODE_PID || crypto.randomUUID()
  };

  appendJsonEntry(LogPath, entry);

  console.log(`✅ Logged lifecycle: ${Action} (${ExtensionID} ${Version})`);
  console.log(`   Workspace: ${Workspace}`);
  console.log(`   Reason: ${Reason}`);
  console.log(`   RunId: ${entry.RunId}`);
  console.log(`   Hash: ${entry.Hash}`);

  return entry;
}

module.exports = { logLifecycle, nowIso, runId, getVsixHash };

// CLI usage
if (require.main === module) {
  const args = process.argv.slice(2);
  const params = {};

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace(/^--/, '');
    params[key] = args[i + 1];
  }

  try {
    logLifecycle(params);
  } catch (err) {
    console.error(`❌ Error: ${err.message}`);
    process.exit(1);
  }
}
