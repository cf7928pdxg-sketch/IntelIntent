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
 * Logs Copilot command invocation
 */
function logInvocation({
  CommandID,
  InvocationType = 'Inline',
  CompletionModel = 'gpt-4-copilot',
  ShortcutUsed = null,
  Workspace,
  Context = '',
  Stage = 'Editing',
  Result = 'Success',
  LogPath = path.join(__dirname, '..', 'logs', 'CopilotInvocationLog.json')
}) {
  if (!CommandID) throw new Error('CommandID is required');
  if (!Workspace) throw new Error('Workspace is required');

  const entry = {
    Timestamp: nowIso(),
    RunId: runId(),
    InvocationType,
    CommandID,
    ShortcutUsed,
    CompletionModel,
    ExtensionID: 'github.copilot',
    WorkspaceName: Workspace,
    WorkspaceScope: `Workspace:${Workspace}`,
    Context,
    Stage,
    Result,
    SessionID: process.env.VSCODE_PID || crypto.randomUUID()
  };

  appendJsonEntry(LogPath, entry);

  console.log(`✅ Logged invocation: ${CommandID} (${InvocationType})`);
  console.log(`   Workspace: ${Workspace}`);
  console.log(`   Model: ${CompletionModel}`);
  console.log(`   RunId: ${entry.RunId}`);
  if (ShortcutUsed) {
    console.log(`   Shortcut: ${ShortcutUsed}`);
  }

  return entry;
}

module.exports = { logInvocation, nowIso, runId };

// CLI usage
if (require.main === module) {
  const args = process.argv.slice(2);
  const params = {};

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace(/^--/, '');
    params[key] = args[i + 1];
  }

  try {
    logInvocation(params);
  } catch (err) {
    console.error(`❌ Error: ${err.message}`);
    process.exit(1);
  }
}
