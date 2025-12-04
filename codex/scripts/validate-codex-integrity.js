const fs = require('fs');
const path = require('path');
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

/**
 * Validates JSON file against schema
 */
function validateJsonSchema(filePath, schemaPath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`File not found: ${filePath}`);
  }

  if (!fs.existsSync(schemaPath)) {
    throw new Error(`Schema not found: ${schemaPath}`);
  }

  const ajv = new Ajv({ allErrors: true, verbose: true });
  addFormats(ajv);

  const schema = JSON.parse(fs.readFileSync(schemaPath, 'utf8'));
  const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));

  const validate = ajv.compile(schema);
  const valid = validate(data);

  if (!valid) {
    console.error('❌ Schema validation failed:');
    console.error(JSON.stringify(validate.errors, null, 2));
    return false;
  }

  console.log(`✅ Schema valid for ${filePath}`);
  return true;
}

/**
 * Validates hash integrity in lifecycle events
 */
function validateHashIntegrity(filePath) {
  const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  
  let pending = 0;
  let invalid = 0;
  let valid = 0;

  data.forEach((event, index) => {
    if (event.Hash === '[Pending SHA256]' || !event.Hash) {
      pending++;
    } else if (!/^[a-fA-F0-9]{64}$/.test(event.Hash)) {
      console.warn(`⚠️ Event ${index}: Invalid hash format - ${event.Hash}`);
      invalid++;
    } else {
      valid++;
    }
  });

  const complianceRate = data.length > 0 ? ((valid / data.length) * 100).toFixed(2) : 0;

  const report = {
    TotalEvents: data.length,
    ValidHashes: valid,
    PendingHashes: pending,
    InvalidHashes: invalid,
    ComplianceRate: parseFloat(complianceRate)
  };

  console.log('📊 Hash Integrity Report:');
  console.log(`   Total Events: ${report.TotalEvents}`);
  console.log(`   Valid Hashes: ${report.ValidHashes}`);
  console.log(`   Pending Hashes: ${report.PendingHashes}`);
  console.log(`   Invalid Hashes: ${report.InvalidHashes}`);
  console.log(`   Compliance Rate: ${report.ComplianceRate}%`);

  return report;
}

/**
 * Main integrity test
 */
function testCodexIntegrity({
  lifecycleLog = path.join(__dirname, '..', 'logs', 'CopilotLifecycleLog.json'),
  invocationLog = path.join(__dirname, '..', 'logs', 'CopilotInvocationLog.json'),
  schemaPath = path.join(__dirname, '..', 'schemas', 'copilot-events.schema.json'),
  validateHashes = false
}) {
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('  Codex Integrity Validation');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');

  const summary = {
    ValidationTimestamp: new Date().toISOString(),
    LifecycleLogValid: false,
    InvocationLogValid: false,
    LifecycleCount: 0,
    InvocationCount: 0,
    TotalWarnings: 0,
    TotalErrors: 0,
    Status: 'Pending'
  };

  let errors = 0;
  let warnings = 0;

  // Test lifecycle log
  try {
    if (fs.existsSync(lifecycleLog)) {
      summary.LifecycleLogValid = validateJsonSchema(lifecycleLog, schemaPath);
      const lifecycleData = JSON.parse(fs.readFileSync(lifecycleLog, 'utf8'));
      summary.LifecycleCount = lifecycleData.length;

      if (validateHashes) {
        const hashReport = validateHashIntegrity(lifecycleLog);
        summary.HashComplianceRate = hashReport.ComplianceRate;
        if (hashReport.ComplianceRate < 80) warnings++;
      }
    } else {
      console.warn(`⚠️ Lifecycle log not found: ${lifecycleLog}`);
      warnings++;
    }
  } catch (err) {
    console.error(`❌ Lifecycle log validation failed: ${err.message}`);
    errors++;
  }

  // Test invocation log
  try {
    if (fs.existsSync(invocationLog)) {
      summary.InvocationLogValid = validateJsonSchema(invocationLog, schemaPath);
      const invocationData = JSON.parse(fs.readFileSync(invocationLog, 'utf8'));
      summary.InvocationCount = invocationData.length;
    } else {
      console.warn(`⚠️ Invocation log not found: ${invocationLog}`);
      warnings++;
    }
  } catch (err) {
    console.error(`❌ Invocation log validation failed: ${err.message}`);
    errors++;
  }

  summary.TotalErrors = errors;
  summary.TotalWarnings = warnings;
  summary.Status = errors > 0 ? 'Failed' : warnings > 0 ? 'Warning' : 'Passed';

  console.log('');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('  Validation Summary');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');
  console.log(JSON.stringify(summary, null, 2));

  if (errors > 0) {
    console.error(`❌ Integrity validation failed with ${errors} error(s)`);
    process.exit(1);
  } else if (warnings > 0) {
    console.warn(`⚠️ Integrity validation completed with ${warnings} warning(s)`);
    process.exit(0);
  } else {
    console.log('✅ All integrity checks passed');
    process.exit(0);
  }
}

module.exports = { validateJsonSchema, validateHashIntegrity, testCodexIntegrity };

// CLI usage
if (require.main === module) {
  const args = process.argv.slice(2);
  const params = {};

  for (let i = 0; i < args.length; i++) {
    if (args[i].startsWith('--')) {
      const key = args[i].replace(/^--/, '');
      params[key] = args[i + 1] && !args[i + 1].startsWith('--') ? args[i + 1] : true;
      if (params[key] !== true) i++;
    }
  }

  testCodexIntegrity(params);
}
