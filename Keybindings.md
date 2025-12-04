Some keybindings don't go to the terminal by default and are handled by Visual Studio Code - Insiders instead.

@id:terminal.integrated.commandsToSkipShell,terminal.integrated.sendKeybindingsToShell,terminal.integrated.allowChords@id:terminal.integrated.commandsToSkipShell,terminal.integrated.sendKeybindingsToShell,terminal.integrated.allowChords

Terminal › Integrated: Commands To Skip Shell
A set of command IDs whose keybindings will not be sent to the shell but instead always be handled by VS Code. This allows keybindings that would normally be consumed by the shell to act instead the same as when the terminal is not focused, for example Ctrl+P to launch Quick Open.

 

Many commands are skipped by default. To override a default and pass that command's keybinding to the shell instead, add the command prefixed with the - character. For example add -workbench.action.quickOpen to allow Ctrl+P to reach the shell.

 

The following list of default skipped commands is truncated when viewed in Settings Editor. To see the full list, open the default settings JSON and search for the first command from the list below.

 

Default Skipped Commands:

editor.action.accessibilityHelp
editor.action.toggleTabFocusMode
notification.acceptPrimaryAction
notifications.hideList
notifications.hideToasts
runCommands [...]
Terminal › Integrated: Send Keybindings To Shell
Dispatches most keybindings to the terminal instead of the workbench, overriding Terminal › Integrated: Commands To Skip Shell, which can be used alternatively for fine tuning.

Terminal › Integrated: Commands To Skip Shell
A set of command IDs whose keybindings will not be sent to the shell but instead always be handled by VS Code. This allows keybindings that would normally be consumed by the shell to act instead the same as when the terminal is not focused, for example Ctrl+P to launch Quick Open.

 

Many commands are skipped by default. To override a default and pass that command's keybinding to the shell instead, add the command prefixed with the - character. For example add -workbench.action.quickOpen to allow Ctrl+P to reach the shell.

 

The following list of default skipped commands is truncated when viewed in Settings Editor. To see the full list, open the default settings JSON and search for the first command from the list below.

 

Default Skipped Commands:

editor.action.accessibilityHelp
editor.action.toggleTabFocusMode
notification.acceptPrimaryAction
notifications.hideList
notifications.hideToasts
runCommands [...]
Terminal › Integrated: Send Keybindings To Shell
Dispatches most keybindings to the terminal instead of the workbench, overriding Terminal › Integrated: Commands To Skip Shell, which can be used alternatively for fine tuning.


{
    // Code Spell Checker
    // Used to work around bugs in Reference Providers and Rename Providers.
    // Anything matching the provided Regular Expression will be removed from the text
    // before sending it to the Rename Provider.
    // 
    // See: [Markdown: Fixing spelling issues in Header sections changes the entire line · Issue #1987](https://github.com/streetsidesoftware/vscode-spell-checker/issues/1987)
    // 
    // It is unlikely that you would need to edit this setting. If you need to, please open an issue at
    // [Spell Checker Issues](https://github.com/streetsidesoftware/vscode-spell-checker/issues)
    // 
    // This feature is used in connection with `cSpell.advanced.feature.useReferenceProviderWithRename`
    "cSpell.advanced.feature.useReferenceProviderRemove": "",

    // Use the Reference Provider when fixing spelling issues with the Rename Provider.
    // This feature is used in connection with `cSpell.fixSpellingWithRenameProvider`
    "cSpell.advanced.feature.useReferenceProviderWithRename": false,

    // Enable / Disable allowing word compounds.
    // - `true` means `arraylength` would be ok
    // - `false` means it would not pass.
    // 
    // Note: this can also cause many misspelled words to seem correct.
    "cSpell.allowCompoundWords": false,

    // - Use `cSpell.enabledSchemes` instead.
    // Control which file schemes will be checked for spelling (VS Code must be restarted for this setting to take effect).
    // 
    // 
    // Some schemes have special meaning like:
    // - `untitled` - Used for new documents that have not yet been saved
    // - `vscode-notebook-cell` - Used for validating segments of a Notebook.
    // - `vscode-userdata` - Needed to spell check `.code-snippets`
    // - `vscode-scm` - Needed to spell check Source Control commit messages.
    // - `comment` - Used for new comment editors.
    "cSpell.allowedSchemas": [],

    // Enable / Disable autocorrect while typing.
    "cSpell.autocorrect": false,

    // If a `cspell` configuration file is updated, format the configuration file
    // using the VS Code Format Document Provider. This will cause the configuration
    // file to be saved prior to being updated.
    "cSpell.autoFormatConfigFile": false,

    // The maximum average length of chunks of text without word breaks.
    // 
    // 
    // A chunk is the characters between absolute word breaks.
    // Absolute word breaks match: `/[\s,{}[\]]/`
    // 
    // 
    // **Error Message:** _Average word length is too long._
    // 
    // 
    // If you are seeing this message, it means that the file contains mostly long lines
    // without many word breaks.
    // 
    // 
    // Hide this message using `cSpell.enabledNotifications`
    "cSpell.blockCheckingWhenAverageChunkSizeGreaterThan": 200,

    // The maximum line length.
    // 
    // 
    // Block spell checking if lines are longer than the value given.
    // This is used to prevent spell checking generated files.
    // 
    // 
    // **Error Message:** _Lines are too long._
    // 
    // 
    // Hide this message using `cSpell.enabledNotifications`
    "cSpell.blockCheckingWhenLineLengthGreaterThan": 20000,

    // The maximum length of a chunk of text without word breaks.
    // 
    // 
    // It is used to prevent spell checking of generated files.
    // 
    // 
    // A chunk is the characters between absolute word breaks.
    // Absolute word breaks match: `/[\s,{}[\]]/`, i.e. spaces or braces.
    // 
    // 
    // **Error Message:** _Maximum word length exceeded._
    // 
    // 
    // If you are seeing this message, it means that the file contains a very long line
    // without many word breaks.
    // 
    // 
    // Hide this message using `cSpell.enabledNotifications`
    "cSpell.blockCheckingWhenTextChunkSizeGreaterThan": 1000,

    // Determines if words must match case and accent rules.
    // 
    // - `false` - Case is ignored and accents can be missing on the entire word.
    //   Incorrect accents or partially missing accents will be marked as incorrect.
    //   **Note:** Some languages like Portuguese have case sensitivity turned on by default.
    //   You must use `cSpell.languageSettings` to turn it off.
    // - `true` - Case and accents are enforced by default.
    "cSpell.caseSensitive": false,

    // Set the maximum number of blocks of text to check.
    // Each block is 1024 characters.
    "cSpell.checkLimit": 500,

    // By default, the spell checker checks only enabled file types. Use `cSpell.enabledFileTypes`
    // to turn on / off various file types.
    // 
    // When this setting is `false`, all file types are checked except for the ones disabled by `cSpell.enabledFileTypes`.
    // See `cSpell.enabledFileTypes` on how to disable a file type.
    "cSpell.checkOnlyEnabledFileTypes": true,

    // Spell check VS Code system files.
    // These include:
    // - `vscode-userdata:/**/settings.json`
    // - `vscode-userdata:/**/keybindings.json`
    "cSpell.checkVSCodeSystemFiles": false,

    // Define custom dictionaries to be included by default.
    // If `addWords` is `true` words will be added to this dictionary.
    // 
    // 
    // **Example:**
    // 
    // ```js
    // "cSpell.customDictionaries": {
    //   "project-words": {
    //     "name": "project-words",
    //     "path": "${workspaceRoot}/project-words.txt",
    //     "description": "Words used in this project",
    //     "addWords": true
    //   },
    //   "custom": true, // Enable the `custom` dictionary
    //   "internal-terms": false // Disable the `internal-terms` dictionary
    // }
    // ```
    "cSpell.customDictionaries": {},

    // - Use `cSpell.customDictionaries` instead.
    // Define custom dictionaries to be included by default for the folder.
    // If `addWords` is `true` words will be added to this dictionary.
    "cSpell.customFolderDictionaries": [],

    // - Use `cSpell.customDictionaries` instead.
    // Define custom dictionaries to be included by default for the user.
    // If `addWords` is `true` words will be added to this dictionary.
    "cSpell.customUserDictionaries": [],

    // - Use `cSpell.customDictionaries` instead.
    // Define custom dictionaries to be included by default for the workspace.
    // If `addWords` is `true` words will be added to this dictionary.
    "cSpell.customWorkspaceDictionaries": [],

    // Decoration for dark themes.
    // 
    // See:
    // - `cSpell.overviewRulerColor`
    // - `cSpell.textDecoration`
    "cSpell.dark": {},

    // The Diagnostic Severity Level determines how issues are shown in the Problems Pane and within the document.
    // Set the level to `Hint` to hide the issues from the Problems Pane.
    // 
    // Note: `cSpell.useCustomDecorations` must be `false` to use VS Code Diagnostic Severity Levels.
    // 
    // See: [VS Code Diagnostic Severity Level](https://code.visualstudio.com/api/references/vscode-api#DiagnosticSeverity)
    //  - Error: Report Spelling Issues as Errors
    //  - Warning: Report Spelling Issues as Warnings
    //  - Information: Report Spelling Issues as Information
    //  - Hint: Report Spelling Issues as Hints, will not show up in Problems
    "cSpell.diagnosticLevel": "Information",

    // Flagged word issues found by the spell checker are marked with a Diagnostic Severity Level. This affects the color of the squiggle.
    // By default, flagged words will use the same diagnostic level as general issues. Use this setting to customize them.
    // 
    // See: [VS Code Diagnostic Severity Level](https://code.visualstudio.com/api/references/vscode-api#DiagnosticSeverity)
    //  - Error: Report Spelling Issues as Errors
    //  - Warning: Report Spelling Issues as Warnings
    //  - Information: Report Spelling Issues as Information
    //  - Hint: Report Spelling Issues as Hints, will not show up in Problems
    "cSpell.diagnosticLevelFlaggedWords": "",

    // Optional list of dictionaries to use.
    // 
    // Each entry should match the name of the dictionary.
    // 
    // To remove a dictionary from the list add `!` before the name.
    // i.e. `!typescript` will turn off the dictionary with the name `typescript`.
    // 
    // 
    // Example:
    // 
    // ```jsonc
    // // Enable `lorem-ipsum` and disable `typescript`
    // "cSpell.dictionaries": ["lorem-ipsum", "!typescript"]
    // ```
    "cSpell.dictionaries": [],

    // Define custom dictionaries.
    // If `addWords` is `true` words will be added to this dictionary.
    // 
    // This setting is subject to User/Workspace settings precedence rules: [Visual Studio Code User and Workspace Settings](https://code.visualstudio.com/docs/getstarted/settings#_settings-precedence).
    // 
    // It is better to use `cSpell.customDictionaries`
    // 
    // **Example:**
    // 
    // ```js
    // "cSpell.dictionaryDefinitions": [
    //   {
    //     "name": "project-words",
    //     "path": "${workspaceRoot}/project-words.txt",
    //     "description": "Words used in this project",
    //     "addWords": true
    //   }
    // ]
    // ```
    "cSpell.dictionaryDefinitions": [],

    // Use the VS Code Diagnostic Collection to render spelling issues.
    // 
    // With some edit boxes, like the source control message box, the custom decorations do not show up.
    // This setting allows the use of the VS Code Diagnostic Collection to render spelling issues.
    "cSpell.doNotUseCustomDecorationForScheme": {
        "vscode-scm": true
    },

    // Enable / Disable the spell checker.
    "cSpell.enabled": true,

    // Enable / Disable checking file types (languageIds).
    // 
    // This setting replaces: `cSpell.enabledLanguageIds#` and `#cSpell.enableFiletypes`.
    // 
    // A Value of:
    // - `true` - enable checking for the file type
    // - `false` - disable checking for the file type
    // 
    // A file type of `*` is a wildcard that enables all file types.
    // 
    // **Example: enable all file types**
    // 
    // | File Type | Enabled | Comment |
    // | --------- | ------- | ------- |
    // | `*`       | `true`  | Enable all file types. |
    // | `json`    | `false` | Disable checking for json files. |
    "cSpell.enabledFileTypes": {
        "*": true,
        "markdown": true
    },

    // - Use `cSpell.enabledFileTypes` instead.
    // Specify a list of file types to spell check. It is better to use `cSpell.enabledFileTypes` to Enable / Disable checking files types.
    "cSpell.enabledLanguageIds": [],

    // Control which notifications are displayed.
    // 
    // See:
    // - `cSpell.blockCheckingWhenLineLengthGreaterThan`
    // - `cSpell.blockCheckingWhenTextChunkSizeGreaterThan`
    // - `cSpell.blockCheckingWhenAverageChunkSizeGreaterThan`
    "cSpell.enabledNotifications": {
        "Average Word Length too Long": true,
        "Lines too Long": true,
        "Maximum Word Length Exceeded": true
    },

    // Control which file schemes will be checked for spelling (VS Code must be restarted for this setting to take effect).
    // 
    // 
    // Some schemes have special meaning like:
    // - `untitled` - Used for new documents that have not yet been saved
    // - `vscode-notebook-cell` - Used for validating segments of a Notebook.
    // - `vscode-userdata` - Needed to spell check `.code-snippets`
    // - `vscode-scm` - Needed to spell check Source Control commit messages.
    // - `comment` - Used for new comment editors.
    "cSpell.enabledSchemes": {
        "comment": true,
        "file": true,
        "gist": true,
        "repo": true,
        "sftp": true,
        "untitled": true,
        "vscode-notebook-cell": true,
        "vscode-scm": true,
        "vscode-userdata": true,
        "vscode-vfs": true,
        "vsls": true
    },

    // - Use `cSpell.enabledFileTypes` instead.
    // Enable / Disable checking file types (languageIds).
    // 
    // These are in additional to the file types specified by `cSpell.enabledLanguageIds`.
    // To disable a language, prefix with `!` as in `!json`,
    // 
    // 
    // **Example: individual file types**
    // 
    // ```
    // jsonc       // enable checking for jsonc
    // !json       // disable checking for json
    // kotlin      // enable checking for kotlin
    // ```
    // 
    // **Example: enable all file types**
    // 
    // ```
    // *           // enable checking for all file types
    // !json       // except for json
    // ```
    "cSpell.enableFiletypes": [],

    // Show Regular Expression Explorer
    "cSpell.experimental.enableRegexpView": false,

    // Experiment with executeDocumentSymbolProvider.
    // This feature is experimental and will be removed in the future.
    "cSpell.experimental.symbols": false,

    // Glob patterns of files to be checked.
    // Glob patterns are relative to the `cSpell.globRoot` of the configuration file that defines them.
    "cSpell.files": [],

    // Use Rename Provider when fixing spelling issues.
    "cSpell.fixSpellingWithRenameProvider": true,

    // List of words to always be considered incorrect. Words found in `flagWords` override `words`.
    // 
    // Format of `flagWords`
    // - single word entry - `word`
    // - with suggestions - `word:suggestion` or `word->suggestion, suggestions`
    // 
    // Example:
    // ```ts
    // "flagWords": [
    //   "color: colour",
    //   "incase: in case, encase",
    //   "canot->cannot",
    //   "cancelled->canceled"
    // ]
    // ```
    "cSpell.flagWords": [],

    // The root to use for glob patterns found in this configuration.
    // Default: The current workspace folder.
    // Use `globRoot` to define a different location. `globRoot` can be relative to the location of this configuration file.
    // Defining globRoot, does not impact imported configurations.
    // 
    // Special Values:
    // 
    // - `${workspaceFolder}` - Default - globs will be relative to the current workspace folder
    // - `${workspaceFolder:<name>}` - Where `<name>` is the name of the workspace folder.
    "cSpell.globRoot": "",

    // Hide the options to add words to dictionaries or settings.
    "cSpell.hideAddToDictionaryCodeActions": false,

    // Control how spelling issues are displayed while typing.
    // See: `cSpell.revealIssuesAfterDelayMS` to control when issues are revealed.
    //  - Off: Show issues while typing
    //  - Word: Hide issues while typing in the current word
    //  - Line: Hide issues while typing on the line
    //  - Document: Hide all issues while typing in the document
    "cSpell.hideIssuesWhileTyping": "Word",

    // Glob patterns of files to be ignored. The patterns are relative to the `cSpell.globRoot` of the configuration file that defines them.
    "cSpell.ignorePaths": [
        "package-lock.json",
        "node_modules",
        "vscode-extension",
        ".git/{info,lfs,logs,refs,objects}/**",
        ".git/{index,*refs,*HEAD}",
        ".vscode",
        ".vscode-insiders"
    ],

    // Ignore sequences of characters that look like random strings.
    "cSpell.ignoreRandomStrings": true,

    // List of regular expressions or Pattern names (defined in `cSpell.patterns`) to exclude from spell checking.
    // 
    // - When using the VS Code Preferences UI, it is not necessary to escape the `\`, VS Code takes care of that.
    // - When editing the VS Code `settings.json` file,
    //   it is necessary to escape `\`.
    //   Each `\` becomes `\\`.
    // 
    // The default regular expression flags are `gi`. Add `u` (`gui`), to enable Unicode.
    // 
    // | VS Code UI          | settings.json         | Description                                  |
    // | :------------------ | :-------------------- | :------------------------------------------- |
    // | `/\\[a-z]+/gi`      | `/\\\\[a-z]+/gi`      | Exclude LaTeX command like `\mapsto`         |
    // | `/\b[A-Z]{3,5}\b/g` | `/\\b[A-Z]{3,5}\\b/g` | Exclude full-caps acronyms of 3-5 length.    |
    // | `CStyleComment`     | `CStyleComment`       | A built in pattern                           |
    "cSpell.ignoreRegExpList": [],

    // A list of words to be ignored by the spell checker.
    "cSpell.ignoreWords": [],

    // Allows this configuration to inherit configuration for one or more other files.
    // 
    // See [Importing / Extending Configuration](https://cspell.org/configuration/imports/) for more details.
    "cSpell.import": [],

    // List of regular expression patterns or defined pattern names to match for spell checking.
    // 
    // If this property is defined, only text matching the included patterns will be checked.
    "cSpell.includeRegExpList": [],

    // Current active spelling language.
    // 
    // Example: `en-GB` for British English
    // 
    // Example: `en,nl` to enable both English and Dutch
    "cSpell.language": "en",

    // Additional settings for individual programming languages and locales.
    "cSpell.languageSettings": [],

    // Decoration for light themes.
    // 
    // See:
    // - `cSpell.overviewRulerColor`
    // - `cSpell.textDecoration`
    "cSpell.light": {},

    // Have the logs written to a file instead of to VS Code.
    "cSpell.logFile": "",

    // Set the Debug Level for logging messages.
    //  - None: Do not log
    //  - Error: Log only errors
    //  - Warning: Log errors and warnings
    //  - Information: Log errors, warnings, and info
    //  - Debug: Log everything (noisy)
    "cSpell.logLevel": "Error",

    // The maximum number of times the same word can be flagged as an error in a file.
    "cSpell.maxDuplicateProblems": 20,

    // Controls the maximum number of spelling errors per document.
    "cSpell.maxNumberOfProblems": 100,

    // Specify if fields from `.vscode/settings.json` are passed to the spell checker.
    // This only applies when there is a CSpell configuration file in the workspace.
    // 
    // The purpose of this setting to help provide a consistent result compared to the
    // CSpell spell checker command line tool.
    // 
    // Values:
    // - `true` - all settings will be merged based upon `cSpell.mergeCSpellSettingsFields`.
    // - `false` - only use `.vscode/settings.json` if a CSpell configuration is not found.
    // 
    // Note: this setting is used in conjunction with `cSpell.mergeCSpellSettingsFields`.
    "cSpell.mergeCSpellSettings": true,

    // Specify which fields from `.vscode/settings.json` are passed to the spell checker.
    // This only applies when there is a CSpell configuration file in the workspace and
    // `cSpell.mergeCSpellSettings` is `true`.
    // 
    // Values:
    // - `{ flagWords: true, userWords: false }` - Always allow `flagWords`, but never allow `userWords`.
    // 
    // Example:
    // ```jsonc
    // "cSpell.mergeCSpellSettingsFields": { "userWords": false }
    // ```
    "cSpell.mergeCSpellSettingsFields": {
        "allowCompoundWords": true,
        "caseSensitive": true,
        "dictionaries": true,
        "dictionaryDefinitions": true,
        "enableGlobDot": true,
        "features": true,
        "files": true,
        "flagWords": true,
        "gitignoreRoot": true,
        "globRoot": true,
        "ignorePaths": true,
        "ignoreRegExpList": true,
        "ignoreWords": true,
        "import": true,
        "includeRegExpList": true,
        "language": true,
        "languageId": true,
        "languageSettings": true,
        "loadDefaultConfiguration": true,
        "minWordLength": true,
        "noConfigSearch": true,
        "noSuggestDictionaries": true,
        "numSuggestions": true,
        "overrides": true,
        "patterns": true,
        "pnpFiles": true,
        "reporters": true,
        "suggestWords": true,
        "useGitignore": true,
        "usePnP": true,
        "userWords": true,
        "validateDirectives": true,
        "words": true
    },

    // The minimum length of a random string to be ignored.
    "cSpell.minRandomLength": 40,

    // The minimum length of a word before checking it against a dictionary.
    "cSpell.minWordLength": 4,

    // Prevents searching for local configuration when checking individual documents.
    "cSpell.noConfigSearch": false,

    // Optional list of dictionaries that will not be used for suggestions.
    // Words in these dictionaries are considered correct, but will not be
    // used when making spell correction suggestions.
    // 
    // Note: if a word is suggested by another dictionary, but found in
    // one of these dictionaries, it will be removed from the set of
    // possible suggestions.
    "cSpell.noSuggestDictionaries": [],

    // Controls the number of suggestions shown.
    "cSpell.numSuggestions": 8,

    // Overrides are used to apply settings for specific files in your project.
    // 
    // **Example:**
    // 
    // ```jsonc
    // "cSpell.overrides": [
    //   // Force `*.hrr` and `*.crr` files to be treated as `cpp` files:
    //   {
    //     "filename": "**/{*.hrr,*.crr}",
    //     "languageId": "cpp"
    //   },
    //   // Force `dutch/**/*.txt` to be treated as Dutch (dictionary needs to be installed separately):
    //   {
    //     "filename": "**/dutch/**/*.txt",
    //     "language": "nl"
    //   }
    // ]
    // ```
    "cSpell.overrides": [],

    // The CSS color used to show issues in the ruler.
    // 
    // Depends upon `cSpell.useCustomDecorations`.
    // Disable the ruler by setting `cSpell.showInRuler` to `false`.
    // 
    // See:
    // - [`<color>` CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value)
    // - [CSS Colors, W3C Schools](https://www.w3schools.com/cssref/css_colors.php)
    // - Hex colors
    // 
    // Examples:
    // - `green`
    // - `DarkYellow`
    // - `#ffff0080` - semi-transparent yellow.
    // - `rgb(255 153 0 / 80%)`
    "cSpell.overviewRulerColor": "#348feb80",

    // Defines a list of patterns that can be used with the `cSpell.ignoreRegExpList` and
    // `cSpell.includeRegExpList` options.
    // 
    // **Example:**
    // 
    // ```jsonc
    // "cSpell.patterns": [
    //   {
    //     "name": "comment-single-line",
    //     "pattern": "/#.*/g"
    //   },
    //   {
    //     "name": "comment-multi-line",
    //     "pattern": "/(?:\\/\\*[\\s\\S]*?\\*\\/)/g"
    //   }
    // ]
    // ```
    "cSpell.patterns": [],

    // Use Unknown Words settings instead.
    // By default, the spell checker reports all unknown words as misspelled. This setting allows for a more relaxed spell checking, by only
    // reporting unknown words as suggestions. Common spelling errors are still flagged as misspelled.
    // 
    // - `all` - report all unknown words as misspelled
    // - `simple` - report unknown words with simple fixes and the rest as suggestions
    // - `typos` - report on known typo words and the rest as suggestions
    // - `flagged` - report only flagged words as misspelled
    // 
    // **Note:** This setting is deprecated. Use `cSpell.unknownWords` instead.
    "cSpell.reportUnknownWords": "",

    // Reveal hidden issues related to `cSpell.hideIssuesWhileTyping` after a delay in milliseconds.
    "cSpell.revealIssuesAfterDelayMS": 1500,

    // Show CSpell in-document directives as you type.
    // 
    // **Note:** VS Code must be restarted for this setting to take effect.
    "cSpell.showAutocompleteDirectiveSuggestions": true,

    // Show Spell Checker actions in Editor Context Menu
    "cSpell.showCommandsInEditorContextMenu": true,

    // Show spelling issues in the editor ruler.
    // 
    // Note: This setting is only used when `cSpell.useCustomDecorations` is `true`.
    // 
    // Note: To set the color of the ruler, use `cSpell.overviewRulerColor`.
    "cSpell.showInRuler": true,

    // No longer used.
    // Display the spell checker status on the status bar.
    "cSpell.showStatus": true,

    // No longer supported.
    // The side of the status bar to display the spell checker status.
    //  - Left: Left Side of Statusbar
    //  - Right: Right Side of Statusbar
    "cSpell.showStatusAlignment": "Right",

    // Show Spelling Suggestions link in the top level context menu.
    "cSpell.showSuggestionsLinkInEditorContextMenu": true,

    // Delay in ms after a document has changed before checking it for spelling errors.
    "cSpell.spellCheckDelayMs": 50,

    // Only spell check files that are in the currently open workspace.
    // This same effect can be achieved using the `cSpell.files` setting.
    // 
    // 
    // ```js
    // "cSpell.files": ["/**"]
    // ```
    "cSpell.spellCheckOnlyWorkspaceFiles": false,

    // The type of menu used to display spelling suggestions.
    //  - quickPick: Suggestions will appear as a drop down at the top of the IDE. (Best choice for Vim Key Bindings)
    //  - quickFix: Suggestions will appear inline near the word, inside the text editor.
    "cSpell.suggestionMenuType": "quickPick",

    // The maximum number of changes allowed on a word to be considered a suggestions.
    // 
    // For example, appending an `s` onto `example` -> `examples` is considered 1 change.
    // 
    // Range: between 1 and 5.
    "cSpell.suggestionNumChanges": 3,

    // The maximum amount of time in milliseconds to generate suggestions for a word.
    "cSpell.suggestionsTimeout": 400,

    // A list of suggested replacements for words.
    // Suggested words provide a way to make preferred suggestions on word replacements.
    // To hint at a preferred change, but not to require it.
    // 
    // Format of `suggestWords`
    // - Single suggestion (possible auto fix)
    //     - `word: suggestion`
    //     - `word->suggestion`
    // - Multiple suggestions (not auto fixable)
    //    - `word: first, second, third`
    //    - `word->first, second, third`
    "cSpell.suggestWords": [],

    // The CSS Style used to decorate spelling issues. Depends upon `cSpell.useCustomDecorations`.
    // 
    // This setting is used to manually configure the text decoration. If it is not set, the following settings are used:
    // - `cSpell.textDecorationLine` to pick the line type
    // - `cSpell.textDecorationStyle` to pick the style
    // - `cSpell.textDecorationColor` to set the color
    // - `cSpell.textDecorationThickness` to set the thickness.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // 
    // Format:  `<line> [style] <color> [thickness]`
    // 
    // - line - `underline`, `overline`, see: [text-decoration-line, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line)
    // - style - `solid`, `wavy`, `dotted`, see: [text-decoration-style, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-style)
    // - color - see: [text-decoration-color, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-color)
    // - thickness - see: [text-decoration-thickness, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-thickness)
    // 
    // Examples:
    // - `underline green`
    // - `underline dotted yellow 0.2rem`
    // - `underline wavy #ff0c 1.5px` - Wavy underline with 1.5px thickness in semi-transparent yellow.
    // 
    // To change the ruler color, use `cSpell.overviewRulerColor`.
    "cSpell.textDecoration": "",

    // The decoration color for normal spelling issues.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - color - see: [text-decoration-color, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-color)
    // 
    // To change the ruler color, use `cSpell.overviewRulerColor`.
    // 
    // Examples:
    // - `green`
    // - `yellow`
    // - `#ff0c`
    "cSpell.textDecorationColor": "#348feb",

    // The decoration color for flagged issues.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - color - see: [text-decoration-color, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-color)
    // 
    // Examples:
    // - `green`
    // - `yellow`
    // - `#ff0c`
    "cSpell.textDecorationColorFlagged": "#f44",

    // The decoration color for spelling suggestions.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - color - see: [text-decoration-color, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-color)
    // 
    // Common Format: `#RGBA` or `#RRGGBBAA` or `#RGB` or `#RRGGBB`
    // 
    // Examples:
    // - `green`
    // - `yellow`
    // - `#ff0c`
    "cSpell.textDecorationColorSuggestion": "#cf88",

    // The CSS line type used to decorate issues.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - line - `underline`, `overline`, see: [text-decoration-line, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line)
    "cSpell.textDecorationLine": "underline",

    // The CSS line style used to decorate issues.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - style - `solid`, `wavy`, `dotted`, see: [text-decoration-style, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-style)
    "cSpell.textDecorationStyle": "dashed",

    // The CSS line thickness used to decorate issues.
    // 
    // See: [text-decoration - CSS: Cascading Style Sheets, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration)
    // - thickness - see: [text-decoration-thickness, MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-thickness)
    // 
    // Examples:
    // - `auto`
    // - `from-font`
    // - `0.2rem`
    // - `1.5px`
    // - `10%`
    "cSpell.textDecorationThickness": "auto",

    // Enable loading JavaScript CSpell configuration files.
    // 
    // This setting is automatically set to `true` in a trusted workspace. It is possible to override the setting to `false` in a trusted workspace,
    // but a setting of `true` in an untrusted workspace will be ignored.
    // 
    // See:
    // - [Visual Studio Code Workspace Trust security](https://code.visualstudio.com/docs/editor/workspace-trust)
    // - [Workspace Trust Extension Guide -- Visual Studio Code Extension API](https://code.visualstudio.com/api/extension-guides/workspace-trust)
    "cSpell.trustedWorkspace": true,

    // Controls how unknown words are handled.
    // 
    // - `report-all` - Report all unknown words (default behavior)
    // - `report-simple` - Report unknown words that have simple spelling errors, typos, and flagged words.
    // - `report-common-typos` - Report unknown words that are common typos and flagged words.
    // - `report-flagged` - Report unknown words that are flagged.
    "cSpell.unknownWords": "report-all",

    // Draw custom decorations on Spelling Issues.
    // - `true` - Use custom decorations. - VS Code Diagnostic Severity Levels are not used.
    // - `false` - Use the VS Code Diagnostic Collection to render spelling issues.
    // 
    // Note: This setting overrides the VS Code Diagnostics setting: `cSpell.diagnosticLevel`.
    "cSpell.useCustomDecorations": false,

    // Tells the spell checker to load `.gitignore` files and skip files that match the globs in the `.gitignore` files found.
    "cSpell.useGitignore": true,

    // Search for `@cspell/cspell-bundled-dicts` in the workspace folder and use it if found.
    "cSpell.useLocallyInstalledCSpellDictionaries": true,

    // Packages managers like Yarn 2 use a `.pnp.cjs` file to assist in loading
    // packages stored in the repository.
    // 
    // When true, the spell checker will search up the directory structure for the existence
    // of a PnP file and load it.
    "cSpell.usePnP": false,

    // Words to add to global dictionary -- should only be in the user config file.
    "cSpell.userWords": [],

    // Verify that the in-document directives are correct.
    "cSpell.validateDirectives": false,

    // List of words to be considered correct.
    "cSpell.words": [],

    // Define the path to the workspace root folder in a multi-root workspace.
    // By default it is the first folder.
    // 
    // This is used to find the `cspell.json` file for the workspace.
    // 
    // 
    // **Example: use the `client` folder**
    // ```
    // ${workspaceFolder:client}
    // ```
    "cSpell.workspaceRootPath": "",

    // General
    // Specifies the style of the gravatar default (fallback) images
    //  - identicon: A geometric pattern
    //  - mp: A simple, cartoon-style silhouetted outline of a person (does not vary by email hash)
    //  - monsterid: A monster with different colors, faces, etc
    //  - retro: 8-bit arcade-style pixelated faces
    //  - robohash: A robot with different colors, faces, etc
    //  - wavatar: A face with differing features and backgrounds
    "gitlens.defaultGravatarsStyle": "robohash",

    // Deprecated. Use the pre-release of GitLens instead
    // 
    "gitlens.insiders": null,

    // Specifies how much (if any) output will be sent to the GitLens output channel
    //  - off: Logs nothing
    //  - error: Logs only errors
    //  - warn: Logs errors and warnings
    //  - info: Logs errors, warnings, and messages
    //  - debug: Logs verbose errors, warnings, and messages. Best for issue reporting.
    "gitlens.outputLevel": "warn",

    // Specifies whether to hide or show features that require a trial or GitLens Pro and are not accessible given the opened repositories and current trial or plan
    "gitlens.plusFeatures.enabled": true,

    // Specifies the proxy configuration to use. If not specified, the proxy configuration will be determined based on VS Code or OS settings
    "gitlens.proxy": null,

    // Specifies whether to show the What's New notification after upgrading to new feature releases
    "gitlens.showWhatsNewAfterUpgrades": true,

    // Specifies whether to enable virtual repositories support
    "gitlens.virtualRepositories.enabled": true,

    // Editor
    // Controls whether the editor shows CodeLens.
    "diffEditor.codeLens": false,

    // 
    //  - legacy: Uses the legacy diffing algorithm.
    //  - advanced: Uses the advanced diffing algorithm.
    "diffEditor.diffAlgorithm": "advanced",

    // Controls whether the diff editor shows empty decorations to see where characters got inserted or deleted.
    "diffEditor.experimental.showEmptyDecorations": true,

    // Controls whether the diff editor should show detected code moves.
    "diffEditor.experimental.showMoves": false,

    // If enabled and the editor uses the inline view, word changes are rendered inline.
    "diffEditor.experimental.useTrueInlineView": false,

    // Controls how many lines are used as context when comparing unchanged regions.
    "diffEditor.hideUnchangedRegions.contextLineCount": 3,

    // Controls whether the diff editor shows unchanged regions.
    "diffEditor.hideUnchangedRegions.enabled": false,

    // Controls how many lines are used as a minimum for unchanged regions.
    "diffEditor.hideUnchangedRegions.minimumLineCount": 3,

    // Controls how many lines are used for unchanged regions.
    "diffEditor.hideUnchangedRegions.revealLineCount": 20,

    // When enabled, the diff editor ignores changes in leading or trailing whitespace.
    "diffEditor.ignoreTrimWhitespace": true,

    // Timeout in milliseconds after which diff computation is cancelled. Use 0 for no timeout.
    "diffEditor.maxComputationTime": 5000,

    // Maximum file size in MB for which to compute diffs. Use 0 for no limit.
    "diffEditor.maxFileSize": 50,

    // When enabled, the diff editor shows a special gutter for revert and stage actions.
    "diffEditor.renderGutterMenu": true,

    // Controls whether the diff editor shows +/- indicators for added/removed changes.
    "diffEditor.renderIndicators": true,

    // When enabled, the diff editor shows arrows in its glyph margin to revert changes.
    "diffEditor.renderMarginRevertIcon": true,

    // Controls whether the diff editor shows the diff side by side or inline.
    "diffEditor.renderSideBySide": true,

    // If the diff editor width is smaller than this value, the inline view is used.
    "diffEditor.renderSideBySideInlineBreakpoint": 900,

    // If enabled and the editor width is too small, the inline view is used.
    "diffEditor.useInlineViewWhenSpaceIsLimited": true,

    // 
    //  - off: Lines will never wrap.
    //  - on: Lines will wrap at the viewport width.
    //  - inherit: Lines will wrap according to the `editor.wordWrap` setting.
    "diffEditor.wordWrap": "inherit",

    // Controls whether suggestions should be accepted on commit characters. For example, in JavaScript, the semi-colon (`;`) can be a commit character that accepts a suggestion and types that character.
    "editor.acceptSuggestionOnCommitCharacter": true,

    // Controls whether suggestions should be accepted on `Enter`, in addition to `Tab`. Helps to avoid ambiguity between inserting new lines or accepting suggestions.
    //  - on
    //  - smart: Only accept a suggestion with `Enter` when it makes a textual change.
    //  - off
    "editor.acceptSuggestionOnEnter": "on",

    // Controls the number of lines in the editor that can be read out by a screen reader at once. When we detect a screen reader we automatically set the default to be 500. Warning: this has a performance implication for numbers larger than the default.
    "editor.accessibilityPageSize": 500,

    // Controls if the UI should run in a mode where it is optimized for screen readers.
    //  - auto: Use platform APIs to detect when a Screen Reader is attached.
    //  - on: Optimize for usage with a Screen Reader.
    //  - off: Assume a screen reader is not attached.
    "editor.accessibilitySupport": "auto",

    // Controls whether to allow using variable fonts in the editor.
    "editor.allowVariableFonts": true,

    // Controls whether to allow using variable fonts in the editor in the accessibility mode.
    "editor.allowVariableFontsInAccessibilityMode": false,

    // Controls whether to allow using variable line heights in the editor.
    "editor.allowVariableLineHeights": true,

    // Controls whether the editor should automatically close brackets after the user adds an opening bracket.
    //  - always
    //  - languageDefined: Use language configurations to determine when to autoclose brackets.
    //  - beforeWhitespace: Autoclose brackets only when the cursor is to the left of whitespace.
    //  - never
    "editor.autoClosingBrackets": "languageDefined",

    // Controls whether the editor should automatically close comments after the user adds an opening comment.
    //  - always
    //  - languageDefined: Use language configurations to determine when to autoclose comments.
    //  - beforeWhitespace: Autoclose comments only when the cursor is to the left of whitespace.
    //  - never
    "editor.autoClosingComments": "languageDefined",

    // Controls whether the editor should remove adjacent closing quotes or brackets when deleting.
    //  - always
    //  - auto: Remove adjacent closing quotes or brackets only if they were automatically inserted.
    //  - never
    "editor.autoClosingDelete": "auto",

    // Controls whether the editor should type over closing quotes or brackets.
    //  - always
    //  - auto: Type over closing quotes or brackets only if they were automatically inserted.
    //  - never
    "editor.autoClosingOvertype": "auto",

    // Controls whether the editor should automatically close quotes after the user adds an opening quote.
    //  - always
    //  - languageDefined: Use language configurations to determine when to autoclose quotes.
    //  - beforeWhitespace: Autoclose quotes only when the cursor is to the left of whitespace.
    //  - never
    "editor.autoClosingQuotes": "languageDefined",

    // Controls whether the editor should automatically adjust the indentation when users type, paste, move or indent lines.
    //  - none: The editor will not insert indentation automatically.
    //  - keep: The editor will keep the current line's indentation.
    //  - brackets: The editor will keep the current line's indentation and honor language defined brackets.
    //  - advanced: The editor will keep the current line's indentation, honor language defined brackets and invoke special onEnterRules defined by languages.
    //  - full: The editor will keep the current line's indentation, honor language defined brackets, invoke special onEnterRules defined by languages, and honor indentationRules defined by languages.
    "editor.autoIndent": "full",

    // Controls whether the editor should automatically auto-indent the pasted content.
    "editor.autoIndentOnPaste": false,

    // Controls whether the editor should automatically auto-indent the pasted content when pasted within a string. This takes effect when autoIndentOnPaste is true.
    "editor.autoIndentOnPasteWithinString": true,

    // Controls whether the editor should automatically surround selections when typing quotes or brackets.
    //  - languageDefined: Use language configurations to determine when to automatically surround selections.
    //  - quotes: Surround with quotes but not brackets.
    //  - brackets: Surround with brackets but not quotes.
    //  - never
    "editor.autoSurround": "languageDefined",

    // Controls whether bracket pair colorization is enabled or not. Use `workbench.colorCustomizations` to override the bracket highlight colors.
    "editor.bracketPairColorization.enabled": true,

    // Controls whether each bracket type has its own independent color pool.
    "editor.bracketPairColorization.independentColorPoolPerBracketType": false,

    // Enable triggering `editor.codeActionsOnSave#` when `#files.autoSave` is set to `afterDelay`. Code Actions must be set to `always` to be triggered for window and focus changes.
    "editor.codeActions.triggerOnFocusChange": false,

    // Run Code Actions for the editor on save. Code Actions must be specified and the editor must not be shutting down. When `files.autoSave` is set to `afterDelay`, Code Actions will only be run when the file is saved explicitly. Example: `"source.organizeImports": "explicit" `
    "editor.codeActionsOnSave": {},

    // Enable/disable showing nearest Quick Fix within a line when not currently on a diagnostic.
    "editor.codeActionWidget.includeNearbyQuickFixes": true,

    // Enable/disable showing group headers in the Code Action menu.
    "editor.codeActionWidget.showHeaders": true,

    // Controls whether the editor shows CodeLens.
    "editor.codeLens": true,

    // Controls the font family for CodeLens.
    "editor.codeLensFontFamily": "",

    // Controls the font size in pixels for CodeLens. When set to 0, 90% of `editor.fontSize` is used.
    "editor.codeLensFontSize": 0,

    // Controls whether the editor should render the inline color decorators and color picker.
    "editor.colorDecorators": true,

    // Controls the condition to make a color picker appear from a color decorator.
    //  - clickAndHover: Make the color picker appear both on click and hover of the color decorator
    //  - hover: Make the color picker appear on hover of the color decorator
    //  - click: Make the color picker appear on click of the color decorator
    "editor.colorDecoratorsActivatedOn": "clickAndHover",

    // Controls the max number of color decorators that can be rendered in an editor at once.
    "editor.colorDecoratorsLimit": 500,

    // Enable that the selection with the mouse and keys is doing column selection.
    "editor.columnSelection": false,

    // Controls if empty lines should be ignored with toggle, add or remove actions for line comments.
    "editor.comments.ignoreEmptyLines": true,

    // Controls whether a space character is inserted when commenting.
    "editor.comments.insertSpace": true,

    // Controls whether syntax highlighting should be copied into the clipboard.
    "editor.copyWithSyntaxHighlighting": true,

    // Control the cursor animation style.
    "editor.cursorBlinking": "blink",

    // Controls the height of the cursor when `editor.cursorStyle` is set to `line`. Cursor's max height depends on line height.
    "editor.cursorHeight": 0,

    // Controls whether the smooth caret animation should be enabled.
    //  - off: Smooth caret animation is disabled.
    //  - explicit: Smooth caret animation is enabled only when the user moves the cursor with an explicit gesture.
    //  - on: Smooth caret animation is always enabled.
    "editor.cursorSmoothCaretAnimation": "off",

    // Controls the cursor style in insert input mode.
    "editor.cursorStyle": "line",

    // Controls the minimal number of visible leading lines (minimum 0) and trailing lines (minimum 1) surrounding the cursor. Known as 'scrollOff' or 'scrollOffset' in some other editors.
    "editor.cursorSurroundingLines": 0,

    // Controls when `editor.cursorSurroundingLines` should be enforced.
    //  - default: `cursorSurroundingLines` is enforced only when triggered via the keyboard or API.
    //  - all: `cursorSurroundingLines` is enforced always.
    "editor.cursorSurroundingLinesStyle": "default",

    // Controls the width of the cursor when `editor.cursorStyle` is set to `line`.
    "editor.cursorWidth": 0,

    // Controls whether inline color decorations should be shown using the default document color provider.
    //  - auto: Show default color decorators only when no extension provides colors decorators.
    //  - always: Always show default color decorators.
    //  - never: Never show default color decorators.
    "editor.defaultColorDecorators": "auto",

    // Defines a default folding range provider that takes precedence over all other folding range providers. Must be the identifier of an extension contributing a folding range provider.
    //  - null: All active folding range providers
    //  - ms-vscode.azurecli: Tools for developing and running commands of the Azure CLI.
    //  - msazurermtools.azurerm-vscode-tools: Language server, editing tools and snippets for Azure Resource Manager (ARM) template files.
    //  - GitHub.copilot-chat: AI chat features powered by Copilot
    //  - vscode.css-language-features: Provides rich language support for CSS, LESS and SCSS files.
    //  - vscode.html-language-features: Provides rich language support for HTML and Handlebar files
    //  - vscode.json-language-features: Provides rich language support for JSON files.
    //  - yzhang.markdown-all-in-one: All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more)
    //  - vscode.markdown-language-features: Provides rich language support for Markdown.
    //  - vscode.markdown-math: Adds math support to Markdown in notebooks.
    //  - vscode.php-language-features: Provides rich language support for PHP files.
    //  - jebbs.plantuml: Rich PlantUML support for Visual Studio Code.
    //  - ms-vscode.powershell: Develop PowerShell modules, commands and scripts in Visual Studio Code!
    //  - mechatroner.rainbow-csv: Highlight CSV and TSV files, Run SQL-like queries
    //  - vscode.typescript-language-features: Provides rich language support for JavaScript and TypeScript.
    //  - ms-azuretools.vscode-bicep: Bicep language support for Visual Studio Code
    //  - ms-azuretools.vscode-containers: Makes it easy to create, manage, and debug containerized applications.
    //  - dbaeumer.vscode-eslint: Integrates ESLint JavaScript into VS Code.
    //  - redhat.vscode-yaml: YAML Language Support by Red Hat, with built-in Kubernetes syntax support
    //  - ms-vscode.azure-account: A common Sign In and Subscription management extension for VS Code.
    //  - ms-azuretools.azure-dev: Makes it easy to run, provision, and deploy Azure applications using the Azure Developer CLI
    //  - aaron-bond.better-comments: Improve your code commenting by annotating with alert, informational, TODOs, and more!
    //  - streetsidesoftware.code-spell-checker: Spelling checker for source code
    //  - vscode.configuration-editing: Provides capabilities (advanced IntelliSense, auto-fixing) in configuration files like settings, launch, and extension recommendation files.
    //  - vscode.debug-auto-launch: Helper for auto-attach feature when node-debug extensions are not active.
    //  - vscode.debug-server-ready: Open URI in browser if server under debugging is ready.
    //  - vscode.emmet: Emmet support for VS Code
    //  - vscode.extension-editing: Provides linting capabilities for authoring extensions.
    //  - vscode.git: Git SCM Integration
    //  - vscode.git-base: Git static contributions and pickers.
    //  - donjayamanne.githistory: View git log, file history, compare branches or commits
    //  - vscode.github: GitHub features for VS Code
    //  - vscode.github-authentication: GitHub Authentication Provider
    //  - eamodio.gitlens: Supercharge Git within VS Code — Visualize code authorship at a glance via Git blame annotations and CodeLens, seamlessly navigate and explore Git repositories, gain valuable insights via rich visualizations and powerful comparison commands, and so much more
    //  - vscode.grunt: Extension to add Grunt capabilities to VS Code.
    //  - vscode.gulp: Extension to add Gulp capabilities to VSCode.
    //  - oderwat.indent-rainbow: Makes indentation easier to read
    //  - vscode.ipynb: Provides basic support for opening and reading Jupyter's .ipynb notebook files
    //  - vscode.jake: Extension to add Jake capabilities to VS Code.
    //  - ms-vscode.js-debug: An extension for debugging Node.js programs and Chrome.
    //  - ms-vscode.js-debug-companion: Companion extension to js-debug that provides capability for remote debugging
    //  - ms-vscode.live-server: Hosts a local server in your workspace for you to preview your webpages on.
    //  - bierner.markdown-mermaid: Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview
    //  - vscode.media-preview: Provides VS Code's built-in previews for images, audio, and video
    //  - vscode.merge-conflict: Highlighting and commands for inline merge conflicts.
    //  - vscode.mermaid-chat-features: Adds Mermaid diagram support to built-in chats.
    //  - vscode.microsoft-authentication: Microsoft authentication provider
    //  - vscode.npm: Extension to add task support for npm scripts.
    //  - christian-kohler.npm-intellisense: Visual Studio Code plugin that autocompletes npm modules in import statements
    //  - vscode.references-view: Reference Search results as separate, stable view in the sidebar
    //  - vscode.search-result: Provides syntax highlighting and language features for tabbed search results.
    //  - vscode.simple-browser: A very basic built-in webview for displaying web content.
    //  - vscode.terminal-suggest: Extension to add terminal completions for zsh, bash, and fish terminals.
    //  - ms-vscode.test-adapter-converter: Converter extension from the Test Adapter UI to native VS Code testing
    //  - vscode.tunnel-forwarding: Allows forwarding local ports to be accessible over the internet.
    //  - TeamsDevApp.vscode-ai-foundry: Visual Studio Code extension for Microsoft Foundry
    //  - ms-azuretools.vscode-azure-github-copilot: GitHub Copilot for Azure is the @azure extension. It's designed to help streamline the process of developing for Azure. You can ask @azure questions about Azure services or get help with tasks related to Azure and developing for Azure, all from within Visual Studio Code.
    //  - ms-azuretools.vscode-azure-mcp-server: Provides Model Context Protocol (MCP) integration and tooling for Azure in Visual Studio Code.
    //  - ms-azuretools.vscode-azureappservice: An Azure App Service management extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurecontainerapps: An Azure Container Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurefunctions: An Azure Functions extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azureresourcegroups: An extension for viewing and managing Azure resources.
    //  - ms-azuretools.vscode-azurestaticwebapps: An Azure Static Web Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurestorage: Manage your Azure Storage accounts including Blob Containers, File Shares, Tables and Queues
    //  - ms-azuretools.vscode-azurevirtualmachines: An Azure Virtual Machines extension for Visual Studio Code.
    //  - ms-azuretools.vscode-cosmosdb: Connect Azure CosmosDB databases in Azure, inspect and edit your data and run powerful queries with the visual query editor.
    //  - ms-dotnettools.vscode-dotnet-runtime: This extension installs and manages different versions of the .NET SDK and Runtime.
    //  - hediet.vscode-drawio: This unofficial extension integrates Draw.io into VS Code.
    //  - ms-edgedevtools.vscode-edge-devtools: Use the Microsoft Edge Tools from within VS Code to see your site's runtime HTML structure, alter its layout, fix styling issues as well as see your site's network requests.
    //  - firefox-devtools.vscode-firefox-debug: Debug your web application or browser extension in Firefox
    //  - github.vscode-github-actions: GitHub Actions workflows and runs for github.com hosted repositories in VS Code
    //  - ms-vscode.vscode-js-profile-table: Text visualizer for profiles taken from the JavaScript debugger
    //  - DavidAnson.vscode-markdownlint: Markdown linting and style checking for Visual Studio Code
    //  - GitHub.vscode-pull-request-github: Pull Request and Issue Provider for GitHub
    //  - ms-windows-ai-studio.windows-ai-studio: AI Toolkit for VS Code streamlines generative AI app development by integrating tools and models. Browse and download public and custom models; author, test and evaluate prompts; fine-tune; and use them in your applications.
    "editor.defaultFoldingRangeProvider": null,

    // Defines a default formatter which takes precedence over all other formatter settings. Must be the identifier of an extension contributing a formatter.
    //  - null: None
    //  - vscode.json-language-features: Provides rich language support for JSON files.
    //  - yzhang.markdown-all-in-one: All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more)
    //  - jebbs.plantuml: Rich PlantUML support for Visual Studio Code.
    //  - ms-vscode.powershell: Develop PowerShell modules, commands and scripts in Visual Studio Code!
    //  - DavidAnson.vscode-markdownlint: Markdown linting and style checking for Visual Studio Code
    //  - ms-vscode.azurecli: Tools for developing and running commands of the Azure CLI.
    //  - msazurermtools.azurerm-vscode-tools: Language server, editing tools and snippets for Azure Resource Manager (ARM) template files.
    //  - aaron-bond.better-comments: Improve your code commenting by annotating with alert, informational, TODOs, and more!
    //  - GitHub.copilot-chat: AI chat features powered by Copilot
    //  - vscode.css-language-features: Provides rich language support for CSS, LESS and SCSS files.
    //  - vscode.html-language-features: Provides rich language support for HTML and Handlebar files
    //  - vscode.markdown-language-features: Provides rich language support for Markdown.
    //  - vscode.markdown-math: Adds math support to Markdown in notebooks.
    //  - vscode.php-language-features: Provides rich language support for PHP files.
    //  - mechatroner.rainbow-csv: Highlight CSV and TSV files, Run SQL-like queries
    //  - vscode.typescript-language-features: Provides rich language support for JavaScript and TypeScript.
    //  - ms-azuretools.vscode-bicep: Bicep language support for Visual Studio Code
    //  - ms-azuretools.vscode-containers: Makes it easy to create, manage, and debug containerized applications.
    //  - dbaeumer.vscode-eslint: Integrates ESLint JavaScript into VS Code.
    //  - redhat.vscode-yaml: YAML Language Support by Red Hat, with built-in Kubernetes syntax support
    //  - ms-vscode.azure-account: A common Sign In and Subscription management extension for VS Code.
    //  - ms-azuretools.azure-dev: Makes it easy to run, provision, and deploy Azure applications using the Azure Developer CLI
    //  - streetsidesoftware.code-spell-checker: Spelling checker for source code
    //  - vscode.configuration-editing: Provides capabilities (advanced IntelliSense, auto-fixing) in configuration files like settings, launch, and extension recommendation files.
    //  - vscode.debug-auto-launch: Helper for auto-attach feature when node-debug extensions are not active.
    //  - vscode.debug-server-ready: Open URI in browser if server under debugging is ready.
    //  - vscode.emmet: Emmet support for VS Code
    //  - vscode.extension-editing: Provides linting capabilities for authoring extensions.
    //  - vscode.git: Git SCM Integration
    //  - vscode.git-base: Git static contributions and pickers.
    //  - donjayamanne.githistory: View git log, file history, compare branches or commits
    //  - vscode.github: GitHub features for VS Code
    //  - vscode.github-authentication: GitHub Authentication Provider
    //  - eamodio.gitlens: Supercharge Git within VS Code — Visualize code authorship at a glance via Git blame annotations and CodeLens, seamlessly navigate and explore Git repositories, gain valuable insights via rich visualizations and powerful comparison commands, and so much more
    //  - vscode.grunt: Extension to add Grunt capabilities to VS Code.
    //  - vscode.gulp: Extension to add Gulp capabilities to VSCode.
    //  - oderwat.indent-rainbow: Makes indentation easier to read
    //  - vscode.ipynb: Provides basic support for opening and reading Jupyter's .ipynb notebook files
    //  - vscode.jake: Extension to add Jake capabilities to VS Code.
    //  - ms-vscode.js-debug: An extension for debugging Node.js programs and Chrome.
    //  - ms-vscode.js-debug-companion: Companion extension to js-debug that provides capability for remote debugging
    //  - ms-vscode.live-server: Hosts a local server in your workspace for you to preview your webpages on.
    //  - bierner.markdown-mermaid: Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview
    //  - vscode.media-preview: Provides VS Code's built-in previews for images, audio, and video
    //  - vscode.merge-conflict: Highlighting and commands for inline merge conflicts.
    //  - vscode.mermaid-chat-features: Adds Mermaid diagram support to built-in chats.
    //  - vscode.microsoft-authentication: Microsoft authentication provider
    //  - vscode.npm: Extension to add task support for npm scripts.
    //  - christian-kohler.npm-intellisense: Visual Studio Code plugin that autocompletes npm modules in import statements
    //  - vscode.references-view: Reference Search results as separate, stable view in the sidebar
    //  - vscode.search-result: Provides syntax highlighting and language features for tabbed search results.
    //  - vscode.simple-browser: A very basic built-in webview for displaying web content.
    //  - vscode.terminal-suggest: Extension to add terminal completions for zsh, bash, and fish terminals.
    //  - ms-vscode.test-adapter-converter: Converter extension from the Test Adapter UI to native VS Code testing
    //  - vscode.tunnel-forwarding: Allows forwarding local ports to be accessible over the internet.
    //  - TeamsDevApp.vscode-ai-foundry: Visual Studio Code extension for Microsoft Foundry
    //  - ms-azuretools.vscode-azure-github-copilot: GitHub Copilot for Azure is the @azure extension. It's designed to help streamline the process of developing for Azure. You can ask @azure questions about Azure services or get help with tasks related to Azure and developing for Azure, all from within Visual Studio Code.
    //  - ms-azuretools.vscode-azure-mcp-server: Provides Model Context Protocol (MCP) integration and tooling for Azure in Visual Studio Code.
    //  - ms-azuretools.vscode-azureappservice: An Azure App Service management extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurecontainerapps: An Azure Container Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurefunctions: An Azure Functions extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azureresourcegroups: An extension for viewing and managing Azure resources.
    //  - ms-azuretools.vscode-azurestaticwebapps: An Azure Static Web Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurestorage: Manage your Azure Storage accounts including Blob Containers, File Shares, Tables and Queues
    //  - ms-azuretools.vscode-azurevirtualmachines: An Azure Virtual Machines extension for Visual Studio Code.
    //  - ms-azuretools.vscode-cosmosdb: Connect Azure CosmosDB databases in Azure, inspect and edit your data and run powerful queries with the visual query editor.
    //  - ms-dotnettools.vscode-dotnet-runtime: This extension installs and manages different versions of the .NET SDK and Runtime.
    //  - hediet.vscode-drawio: This unofficial extension integrates Draw.io into VS Code.
    //  - ms-edgedevtools.vscode-edge-devtools: Use the Microsoft Edge Tools from within VS Code to see your site's runtime HTML structure, alter its layout, fix styling issues as well as see your site's network requests.
    //  - firefox-devtools.vscode-firefox-debug: Debug your web application or browser extension in Firefox
    //  - github.vscode-github-actions: GitHub Actions workflows and runs for github.com hosted repositories in VS Code
    //  - ms-vscode.vscode-js-profile-table: Text visualizer for profiles taken from the JavaScript debugger
    //  - GitHub.vscode-pull-request-github: Pull Request and Issue Provider for GitHub
    //  - ms-windows-ai-studio.windows-ai-studio: AI Toolkit for VS Code streamlines generative AI app development by integrating tools and models. Browse and download public and custom models; author, test and evaluate prompts; fine-tune; and use them in your applications.
    "editor.defaultFormatter": null,

    // Controls whether the Go to Definition mouse gesture always opens the peek widget.
    "editor.definitionLinkOpensInPeek": false,

    // Controls whether `editor.tabSize#` and `#editor.insertSpaces` will be automatically detected when a file is opened based on the file contents.
    "editor.detectIndentation": true,

    // Controls whether the editor should allow moving selections via drag and drop.
    "editor.dragAndDrop": true,

    // Controls whether you can drag and drop a file into a text editor by holding down the `Shift` key (instead of opening the file in an editor).
    "editor.dropIntoEditor.enabled": true,

    // Configures the preferred type of edit to use when dropping content.
    // 
    // This is an ordered list of edit kinds. The first available edit of a preferred kind will be used.
    "editor.dropIntoEditor.preferences": [],

    // Controls if a widget is shown when dropping files into the editor. This widget lets you control how the file is dropped.
    //  - afterDrop: Show the drop selector widget after a file is dropped into the editor.
    //  - never: Never show the drop selector widget. Instead the default drop provider is always used.
    "editor.dropIntoEditor.showDropSelector": "afterDrop",

    // Sets whether the EditContext API should be used instead of the text area to power input in the editor.
    "editor.editContext": true,

    // Controls whether copying without a selection copies the current line.
    "editor.emptySelectionClipboard": true,

    // Controls whether the tokenization should happen asynchronously on a web worker.
    "editor.experimental.asyncTokenization": true,

    // Controls whether async tokenization should be logged. For debugging only.
    "editor.experimental.asyncTokenizationLogging": false,

    // Controls whether async tokenization should be verified against legacy background tokenization. Might slow down tokenization. For debugging only.
    "editor.experimental.asyncTokenizationVerification": false,

    // Controls whether tree sitter parsing should be turned on for css. This will take precedence over `editor.experimental.treeSitterTelemetry` for css.
    "editor.experimental.preferTreeSitter.css": false,

    // Controls whether tree sitter parsing should be turned on for ini. This will take precedence over `editor.experimental.treeSitterTelemetry` for ini.
    "editor.experimental.preferTreeSitter.ini": false,

    // Controls whether tree sitter parsing should be turned on for regex. This will take precedence over `editor.experimental.treeSitterTelemetry` for regex.
    "editor.experimental.preferTreeSitter.regex": false,

    // Controls whether tree sitter parsing should be turned on for typescript. This will take precedence over `editor.experimental.treeSitterTelemetry` for typescript.
    "editor.experimental.preferTreeSitter.typescript": false,

    // Controls whether tree sitter parsing should be turned on and telemetry collected. Setting `editor.experimental.preferTreeSitter` for specific languages will take precedence.
    "editor.experimental.treeSitterTelemetry": false,

    // Controls whether to use the experimental GPU acceleration to render the editor.
    //  - off: Use regular DOM-based rendering.
    //  - on: Use GPU acceleration.
    "editor.experimentalGpuAcceleration": "off",

    // Controls whether whitespace is rendered with a new, experimental method.
    //  - svg: Use a new rendering method with svgs.
    //  - font: Use a new rendering method with font characters.
    //  - off: Use the stable rendering method.
    "editor.experimentalWhitespaceRendering": "svg",

    // Scrolling speed multiplier when pressing `Alt`.
    "editor.fastScrollSensitivity": 5,

    // Controls whether the Find Widget should add extra lines on top of the editor. When true, you can scroll beyond the first line when the Find Widget is visible.
    "editor.find.addExtraSpaceOnTop": true,

    // Controls the condition for turning on Find in Selection automatically.
    //  - never: Never turn on Find in Selection automatically (default).
    //  - always: Always turn on Find in Selection automatically.
    //  - multiline: Turn on Find in Selection automatically when multiple lines of content are selected.
    "editor.find.autoFindInSelection": "never",

    // Controls whether the cursor should jump to find matches while typing.
    "editor.find.cursorMoveOnType": true,

    // Controls whether the Find Widget should search as you type.
    "editor.find.findOnType": true,

    // Controls how the find widget history should be stored
    //  - never: Do not store search history from the find widget.
    //  - workspace: Store search history across the active workspace
    "editor.find.history": "workspace",

    // Controls whether the search automatically restarts from the beginning (or the end) when no further matches can be found.
    "editor.find.loop": true,

    // Controls how the replace widget history should be stored
    //  - never: Do not store history from the replace widget.
    //  - workspace: Store replace history across the active workspace
    "editor.find.replaceHistory": "workspace",

    // Controls whether the search string in the Find Widget is seeded from the editor selection.
    //  - never: Never seed search string from the editor selection.
    //  - always: Always seed search string from the editor selection, including word at cursor position.
    //  - selection: Only seed search string from the editor selection.
    "editor.find.seedSearchStringFromSelection": "always",

    // Controls whether the editor has code folding enabled.
    "editor.folding": true,

    // Controls whether the editor should highlight folded ranges.
    "editor.foldingHighlight": true,

    // Controls whether the editor automatically collapses import ranges.
    "editor.foldingImportsByDefault": false,

    // The maximum number of foldable regions. Increasing this value may result in the editor becoming less responsive when the current source has a large number of foldable regions.
    "editor.foldingMaximumRegions": 5000,

    // Controls the strategy for computing folding ranges.
    //  - auto: Use a language-specific folding strategy if available, else the indentation-based one.
    //  - indentation: Use the indentation-based folding strategy.
    "editor.foldingStrategy": "auto",

    // Controls the font family.
    "editor.fontFamily": "Consolas, 'Courier New', monospace",

    // Configures font ligatures or font features. Can be either a boolean to enable/disable ligatures or a string for the value of the CSS 'font-feature-settings' property.
    "editor.fontLigatures": false,

    // Controls the font size in pixels.
    "editor.fontSize": 14,

    // Configures font variations. Can be either a boolean to enable/disable the translation from font-weight to font-variation-settings or a string for the value of the CSS 'font-variation-settings' property.
    "editor.fontVariations": false,

    // Controls the font weight. Accepts "normal" and "bold" keywords or numbers between 1 and 1000.
    "editor.fontWeight": "normal",

    // Controls whether the editor should automatically format the pasted content. A formatter must be available and the formatter should be able to format a range in a document.
    "editor.formatOnPaste": false,

    // Format a file on save. A formatter must be available and the editor must not be shutting down. When `files.autoSave` is set to `afterDelay`, the file will only be formatted when saved explicitly.
    "editor.formatOnSave": false,

    // Controls if format on save formats the whole file or only modifications. Only applies when `editor.formatOnSave` is enabled.
    //  - file: Format the whole file.
    //  - modifications: Format modifications (requires source control).
    //  - modificationsIfAvailable: Will attempt to format modifications only (requires source control). If source control can't be used, then the whole file will be formatted.
    "editor.formatOnSaveMode": "file",

    // Controls whether the editor should automatically format the line after typing.
    "editor.formatOnType": false,

    // Controls whether the editor should render the vertical glyph margin. Glyph margin is mostly used for debugging.
    "editor.glyphMargin": true,

    // Alternative command id that is being executed when the result of 'Go to Declaration' is the current location.
    "editor.gotoLocation.alternativeDeclarationCommand": "editor.action.goToReferences",

    // Alternative command id that is being executed when the result of 'Go to Definition' is the current location.
    "editor.gotoLocation.alternativeDefinitionCommand": "editor.action.goToReferences",

    // Alternative command id that is being executed when the result of 'Go to Implementation' is the current location.
    "editor.gotoLocation.alternativeImplementationCommand": "",

    // Alternative command id that is being executed when the result of 'Go to Reference' is the current location.
    "editor.gotoLocation.alternativeReferenceCommand": "",

    // Alternative command id that is being executed when the result of 'Go to Type Definition' is the current location.
    "editor.gotoLocation.alternativeTypeDefinitionCommand": "editor.action.goToReferences",

    // This setting is deprecated, please use separate settings like 'editor.editor.gotoLocation.multipleDefinitions' or 'editor.editor.gotoLocation.multipleImplementations' instead.
    // 
    "editor.gotoLocation.multiple": null,

    // Controls the behavior the 'Go to Declaration'-command when multiple target locations exist.
    //  - peek: Show Peek view of the results (default)
    //  - gotoAndPeek: Go to the primary result and show a Peek view
    //  - goto: Go to the primary result and enable Peek-less navigation to others
    "editor.gotoLocation.multipleDeclarations": "peek",

    // Controls the behavior the 'Go to Definition'-command when multiple target locations exist.
    //  - peek: Show Peek view of the results (default)
    //  - gotoAndPeek: Go to the primary result and show a Peek view
    //  - goto: Go to the primary result and enable Peek-less navigation to others
    "editor.gotoLocation.multipleDefinitions": "peek",

    // Controls the behavior the 'Go to Implementations'-command when multiple target locations exist.
    //  - peek: Show Peek view of the results (default)
    //  - gotoAndPeek: Go to the primary result and show a Peek view
    //  - goto: Go to the primary result and enable Peek-less navigation to others
    "editor.gotoLocation.multipleImplementations": "peek",

    // Controls the behavior the 'Go to References'-command when multiple target locations exist.
    //  - peek: Show Peek view of the results (default)
    //  - gotoAndPeek: Go to the primary result and show a Peek view
    //  - goto: Go to the primary result and enable Peek-less navigation to others
    "editor.gotoLocation.multipleReferences": "peek",

    // Controls the behavior the 'Go to Type Definition'-command when multiple target locations exist.
    //  - peek: Show Peek view of the results (default)
    //  - gotoAndPeek: Go to the primary result and show a Peek view
    //  - goto: Go to the primary result and enable Peek-less navigation to others
    "editor.gotoLocation.multipleTypeDefinitions": "peek",

    // Controls whether bracket pair guides are enabled or not.
    //  - true: Enables bracket pair guides.
    //  - active: Enables bracket pair guides only for the active bracket pair.
    //  - false: Disables bracket pair guides.
    "editor.guides.bracketPairs": false,

    // Controls whether horizontal bracket pair guides are enabled or not.
    //  - true: Enables horizontal guides as addition to vertical bracket pair guides.
    //  - active: Enables horizontal guides only for the active bracket pair.
    //  - false: Disables horizontal bracket pair guides.
    "editor.guides.bracketPairsHorizontal": "active",

    // Controls whether the editor should highlight the active bracket pair.
    "editor.guides.highlightActiveBracketPair": true,

    // Controls whether the editor should highlight the active indent guide.
    //  - true: Highlights the active indent guide.
    //  - always: Highlights the active indent guide even if bracket guides are highlighted.
    //  - false: Do not highlight the active indent guide.
    "editor.guides.highlightActiveIndentation": true,

    // Controls whether the editor should render indent guides.
    "editor.guides.indentation": true,

    // Controls whether the cursor should be hidden in the overview ruler.
    "editor.hideCursorInOverviewRuler": false,

    // Prefer showing hovers above the line, if there's space.
    "editor.hover.above": true,

    // Controls the delay in milliseconds after which the hover is shown.
    "editor.hover.delay": 300,

    // Controls whether the hover is shown.
    //  - on: Hover is enabled.
    //  - off: Hover is disabled.
    //  - onKeyboardModifier: Hover is shown when holding `Control` or `Alt` (the opposite modifier of `editor.multiCursorModifier`)
    "editor.hover.enabled": "on",

    // Controls the delay in milliseconds after which the hover is hidden. Requires `editor.hover.sticky` to be enabled.
    "editor.hover.hidingDelay": 300,

    // Controls whether the hover should remain visible when mouse is moved over it.
    "editor.hover.sticky": true,

    // The number of spaces used for indentation or `"tabSize"` to use the value from `editor.tabSize#`. This setting is overridden based on the file contents when `#editor.detectIndentation` is on.
    "editor.indentSize": "tabSize",

    // Make scrolling inertial - mostly useful with touchpad on linux.
    "editor.inertialScroll": false,

    // Enables the inlay hints in the editor.
    //  - on: Inlay hints are enabled
    //  - onUnlessPressed: Inlay hints are showing by default and hide when holding Ctrl+Alt
    //  - offUnlessPressed: Inlay hints are hidden by default and show when holding Ctrl+Alt
    //  - off: Inlay hints are disabled
    "editor.inlayHints.enabled": "on",

    // Controls font family of inlay hints in the editor. When set to empty, the `editor.fontFamily` is used.
    "editor.inlayHints.fontFamily": "",

    // Controls font size of inlay hints in the editor. As default the `editor.fontSize` is used when the configured value is less than `5` or greater than the editor font size.
    "editor.inlayHints.fontSize": 0,

    // Maximum overall length of inlay hints, for a single line, before they get truncated by the editor. Set to `0` to never truncate
    "editor.inlayHints.maximumLength": 43,

    // Enables the padding around the inlay hints in the editor.
    "editor.inlayHints.padding": false,

    // Controls whether the accessibility hint should be provided to screen reader users when an inline completion is shown.
    "editor.inlineCompletionsAccessibilityVerbose": false,

    // Controls whether showing a suggestion will shift the code to make space for the suggestion inline.
    "editor.inlineSuggest.edits.allowCodeShifting": "always",

    // Controls whether larger suggestions can be shown side by side.
    //  - auto: Larger suggestions will show side by side if there is enough space, otherwise they will be shown below.
    //  - never: Larger suggestions are never shown side by side and will always be shown below.
    "editor.inlineSuggest.edits.renderSideBySide": "auto",

    // Controls whether the suggestion will show as collapsed until jumping to it.
    "editor.inlineSuggest.edits.showCollapsed": false,

    // Controls whether long distance inline suggestions are shown.
    "editor.inlineSuggest.edits.showLongDistanceHint": true,

    // Controls whether to automatically show inline suggestions in the editor.
    "editor.inlineSuggest.enabled": true,

    // Controls whether to send request information from the inline suggestion provider.
    "editor.inlineSuggest.experimental.emptyResponseInformation": true,

    // Controls whether to show inline suggestions when there is a suggest conflict.
    "editor.inlineSuggest.experimental.showOnSuggestConflict": "never",

    // Suppresses inline completions for specified extension IDs -- comma separated.
    "editor.inlineSuggest.experimental.suppressInlineSuggestions": "",

    // Controls the font family of the inline suggestions.
    "editor.inlineSuggest.fontFamily": "default",

    // Controls the minimal delay in milliseconds after which inline suggestions are shown after typing.
    "editor.inlineSuggest.minShowDelay": 0,

    // Controls when to show the inline suggestion toolbar.
    //  - always: Show the inline suggestion toolbar whenever an inline suggestion is shown.
    //  - onHover: Show the inline suggestion toolbar when hovering over an inline suggestion.
    //  - never: Never show the inline suggestion toolbar.
    "editor.inlineSuggest.showToolbar": "onHover",

    // Controls whether inline suggestions are suppressed when in snippet mode.
    "editor.inlineSuggest.suppressInSnippetMode": true,

    // Controls how inline suggestions interact with the suggest widget. If enabled, the suggest widget is not shown automatically when inline suggestions are available.
    "editor.inlineSuggest.suppressSuggestions": false,

    // Controls whether to show syntax highlighting for inline suggestions in the editor.
    "editor.inlineSuggest.syntaxHighlightingEnabled": true,

    // Controls whether to trigger a command when the inline suggestion provider changes.
    "editor.inlineSuggest.triggerCommandOnProviderChange": false,

    // Insert spaces when pressing `Tab`. This setting is overridden based on the file contents when `editor.detectIndentation` is on.
    "editor.insertSpaces": true,

    // Defines the bracket symbols that increase or decrease the indentation.
    "editor.language.brackets": null,

    // Defines the bracket pairs that are colorized by their nesting level if bracket pair colorization is enabled.
    "editor.language.colorizedBracketPairs": null,

    // Special handling for large files to disable certain memory intensive features.
    "editor.largeFileOptimizations": true,

    // Controls the letter spacing in pixels.
    "editor.letterSpacing": 0,

    // Enables the Code Action lightbulb in the editor.
    //  - off: Disable the code action menu.
    //  - onCode: Show the code action menu when the cursor is on lines with code.
    //  - on: Show the code action menu when the cursor is on lines with code or on empty lines.
    "editor.lightbulb.enabled": "onCode",

    // Controls the line height. 
    //  - Use 0 to automatically compute the line height from the font size.
    //  - Values between 0 and 8 will be used as a multiplier with the font size.
    //  - Values greater than or equal to 8 will be used as effective values.
    "editor.lineHeight": 0,

    // Controls the display of line numbers.
    //  - off: Line numbers are not rendered.
    //  - on: Line numbers are rendered as absolute number.
    //  - relative: Line numbers are rendered as distance in lines to cursor position.
    //  - interval: Line numbers are rendered every 10 lines.
    "editor.lineNumbers": "on",

    // Controls whether the editor has linked editing enabled. Depending on the language, related symbols such as HTML tags, are updated while editing.
    "editor.linkedEditing": false,

    // Controls whether the editor should detect links and make them clickable.
    "editor.links": true,

    // Highlight matching brackets.
    "editor.matchBrackets": "always",

    // Lines above this length will not be tokenized for performance reasons
    "editor.maxTokenizationLineLength": 20000,

    // Controls whether the minimap is hidden automatically.
    //  - none: The minimap is always shown.
    //  - mouseover: The minimap is hidden when mouse is not over the minimap and shown when mouse is over the minimap.
    //  - scroll: The minimap is only shown when the editor is scrolled
    "editor.minimap.autohide": "none",

    // Controls whether the minimap is shown.
    "editor.minimap.enabled": true,

    // Defines the regular expression used to find section headers in comments. The regex must contain a named match group `label` (written as `(?<label>.+)`) that encapsulates the section header, otherwise it will not work. Optionally you can include another match group named `separator`. Use \n in the pattern to match multi-line headers.
    "editor.minimap.markSectionHeaderRegex": "\\bMARK:\\s*(?<separator>-?)\\s*(?<label>.*)$",

    // Limit the width of the minimap to render at most a certain number of columns.
    "editor.minimap.maxColumn": 120,

    // Render the actual characters on a line as opposed to color blocks.
    "editor.minimap.renderCharacters": true,

    // Scale of content drawn in the minimap: 1, 2 or 3.
    "editor.minimap.scale": 1,

    // Controls the font size of section headers in the minimap.
    "editor.minimap.sectionHeaderFontSize": 9,

    // Controls the amount of space (in pixels) between characters of section header. This helps the readability of the header in small font sizes.
    "editor.minimap.sectionHeaderLetterSpacing": 1,

    // Controls whether MARK: comments are shown as section headers in the minimap.
    "editor.minimap.showMarkSectionHeaders": true,

    // Controls whether named regions are shown as section headers in the minimap.
    "editor.minimap.showRegionSectionHeaders": true,

    // Controls when the minimap slider is shown.
    "editor.minimap.showSlider": "mouseover",

    // Controls the side where to render the minimap.
    "editor.minimap.side": "right",

    // Controls the size of the minimap.
    //  - proportional: The minimap has the same size as the editor contents (and might scroll).
    //  - fill: The minimap will stretch or shrink as necessary to fill the height of the editor (no scrolling).
    //  - fit: The minimap will shrink as necessary to never be larger than the editor (no scrolling).
    "editor.minimap.size": "proportional",

    // Controls what happens when middle mouse button is clicked in the editor.
    "editor.mouseMiddleClickAction": "default",

    // A multiplier to be used on the `deltaX` and `deltaY` of mouse wheel scroll events.
    "editor.mouseWheelScrollSensitivity": 1,

    // Zoom the font of the editor when using mouse wheel and holding `Ctrl`.
    "editor.mouseWheelZoom": false,

    // Controls the max number of cursors that can be in an active editor at once.
    "editor.multiCursorLimit": 10000,

    // Merge multiple cursors when they are overlapping.
    "editor.multiCursorMergeOverlapping": true,

    // The modifier to be used to add multiple cursors with the mouse. The Go to Definition and Open Link mouse gestures will adapt such that they do not conflict with the [multicursor modifier](https://code.visualstudio.com/docs/editor/codebasics#_multicursor-modifier).
    //  - ctrlCmd: Maps to `Control` on Windows and Linux and to `Command` on macOS.
    //  - alt: Maps to `Alt` on Windows and Linux and to `Option` on macOS.
    "editor.multiCursorModifier": "alt",

    // Controls pasting when the line count of the pasted text matches the cursor count.
    //  - spread: Each cursor pastes a single line of the text.
    //  - full: Each cursor pastes the full text.
    "editor.multiCursorPaste": "spread",

    // Controls whether occurrences should be highlighted across open files.
    //  - off: Does not highlight occurrences.
    //  - singleFile: Highlights occurrences only in the current file.
    //  - multiFile: Experimental: Highlights occurrences across all valid open files.
    "editor.occurrencesHighlight": "singleFile",

    // Controls the delay in milliseconds after which occurrences are highlighted.
    "editor.occurrencesHighlightDelay": 0,

    // Controls the cursor style in overtype input mode.
    "editor.overtypeCursorStyle": "block",

    // Controls whether pasting should overtype.
    "editor.overtypeOnPaste": true,

    // Controls whether a border should be drawn around the overview ruler.
    "editor.overviewRulerBorder": true,

    // Controls the amount of space between the bottom edge of the editor and the last line.
    "editor.padding.bottom": 0,

    // Controls the amount of space between the top edge of the editor and the first line.
    "editor.padding.top": 0,

    // Controls whether the parameter hints menu cycles or closes when reaching the end of the list.
    "editor.parameterHints.cycle": true,

    // Enables a pop-up that shows parameter documentation and type information as you type.
    "editor.parameterHints.enabled": true,

    // Controls whether you can paste content in different ways.
    "editor.pasteAs.enabled": true,

    // Configures the preferred type of edit to use when pasting content.
    // 
    // This is an ordered list of edit kinds. The first available edit of a preferred kind will be used.
    "editor.pasteAs.preferences": [],

    // Controls if a widget is shown when pasting content in to the editor. This widget lets you control how the file is pasted.
    //  - afterPaste: Show the paste selector widget after content is pasted into the editor.
    //  - never: Never show the paste selector widget. Instead the default pasting behavior is always used.
    "editor.pasteAs.showPasteSelector": "afterPaste",

    // Controls whether to focus the inline editor or the tree in the peek widget.
    //  - tree: Focus the tree when opening peek
    //  - editor: Focus the editor when opening peek
    "editor.peekWidgetDefaultFocus": "tree",

    // Controls whether suggestions should automatically show up while typing. This can be controlled for typing in comments, strings, and other code. Quick suggestion can be configured to show as ghost text or with the suggest widget. Also be aware of the `editor.suggestOnTriggerCharacters`-setting which controls if suggestions are triggered by special characters.
    "editor.quickSuggestions": {
        "other": "on",
        "comments": "off",
        "strings": "off"
    },

    // Controls the delay in milliseconds after which quick suggestions will show up.
    "editor.quickSuggestionsDelay": 10,

    // Enable/disable the ability to preview changes before renaming
    "editor.rename.enablePreview": true,

    // Deprecated, use `editor.linkedEditing` instead.
    // Controls whether the editor auto renames on type.
    "editor.renameOnType": false,

    // Controls whether the editor should render control characters.
    "editor.renderControlCharacters": true,

    // Render last line number when the file ends with a newline.
    "editor.renderFinalNewline": "on",

    // Controls how the editor should render the current line highlight.
    //  - none
    //  - gutter
    //  - line
    //  - all: Highlights both the gutter and the current line.
    "editor.renderLineHighlight": "line",

    // Controls if the editor should render the current line highlight only when the editor is focused.
    "editor.renderLineHighlightOnlyWhenFocus": false,

    // Whether to render rich screen reader content when the `editor.editContext` setting is enabled.
    "editor.renderRichScreenReaderContent": false,

    // Controls how the editor should render whitespace characters.
    //  - none
    //  - boundary: Render whitespace characters except for single spaces between words.
    //  - selection: Render whitespace characters only on selected text.
    //  - trailing: Render only trailing whitespace characters.
    //  - all
    "editor.renderWhitespace": "selection",

    // Controls whether selections should have rounded corners.
    "editor.roundedSelection": true,

    // Render vertical rulers after a certain number of monospace characters. Use multiple values for multiple rulers. No rulers are drawn if array is empty.
    "editor.rulers": [],

    // Control whether inline suggestions are announced by a screen reader.
    "editor.screenReaderAnnounceInlineSuggestion": true,

    // Controls the visibility of the horizontal scrollbar.
    //  - auto: The horizontal scrollbar will be visible only when necessary.
    //  - visible: The horizontal scrollbar will always be visible.
    //  - hidden: The horizontal scrollbar will always be hidden.
    "editor.scrollbar.horizontal": "auto",

    // The height of the horizontal scrollbar.
    "editor.scrollbar.horizontalScrollbarSize": 12,

    // When set, the horizontal scrollbar will not increase the size of the editor's content.
    "editor.scrollbar.ignoreHorizontalScrollbarInContentHeight": false,

    // Controls whether clicks scroll by page or jump to click position.
    "editor.scrollbar.scrollByPage": false,

    // Controls the visibility of the vertical scrollbar.
    //  - auto: The vertical scrollbar will be visible only when necessary.
    //  - visible: The vertical scrollbar will always be visible.
    //  - hidden: The vertical scrollbar will always be hidden.
    "editor.scrollbar.vertical": "auto",

    // The width of the vertical scrollbar.
    "editor.scrollbar.verticalScrollbarSize": 14,

    // Controls the number of extra characters beyond which the editor will scroll horizontally.
    "editor.scrollBeyondLastColumn": 4,

    // Controls whether the editor will scroll beyond the last line.
    "editor.scrollBeyondLastLine": true,

    // Controls whether the editor will scroll when the middle button is pressed.
    "editor.scrollOnMiddleClick": false,

    // Scroll only along the predominant axis when scrolling both vertically and horizontally at the same time. Prevents horizontal drift when scrolling vertically on a trackpad.
    "editor.scrollPredominantAxis": true,

    // Controls whether the editor should highlight matches similar to the selection.
    "editor.selectionHighlight": true,

    // Controls how many characters can be in the selection before similiar matches are not highlighted. Set to zero for unlimited.
    "editor.selectionHighlightMaxLength": 200,

    // Controls whether the editor should highlight selection matches that span multiple lines.
    "editor.selectionHighlightMultiline": false,

    // Controls whether the semanticHighlighting is shown for the languages that support it.
    //  - true: Semantic highlighting enabled for all color themes.
    //  - false: Semantic highlighting disabled for all color themes.
    //  - configuredByTheme: Semantic highlighting is configured by the current color theme's `semanticHighlighting` setting.
    "editor.semanticHighlighting.enabled": "configuredByTheme",

    // Overrides editor semantic token color and styles from the currently selected color theme.
    "editor.semanticTokenColorCustomizations": {},

    // Controls strikethrough deprecated variables.
    "editor.showDeprecated": true,

    // Controls when the folding controls on the gutter are shown.
    //  - always: Always show the folding controls.
    //  - never: Never show the folding controls and reduce the gutter size.
    //  - mouseover: Only show the folding controls when the mouse is over the gutter.
    "editor.showFoldingControls": "mouseover",

    // Controls fading out of unused code.
    "editor.showUnused": true,

    // Whether leading and trailing whitespace should always be selected.
    "editor.smartSelect.selectLeadingAndTrailingWhitespace": true,

    // Whether subwords (like 'foo' in 'fooBar' or 'foo_bar') should be selected.
    "editor.smartSelect.selectSubwords": true,

    // Controls whether the editor will scroll using an animation.
    "editor.smoothScrolling": false,

    // Controls if surround-with-snippets or file template snippets show as Code Actions.
    "editor.snippets.codeActions.enabled": true,

    // Controls whether snippets are shown with other suggestions and how they are sorted.
    //  - top: Show snippet suggestions on top of other suggestions.
    //  - bottom: Show snippet suggestions below other suggestions.
    //  - inline: Show snippets suggestions with other suggestions.
    //  - none: Do not show snippet suggestions.
    "editor.snippetSuggestions": "inline",

    // Keep peek editors open even when double-clicking their content or when hitting `Escape`.
    "editor.stablePeek": false,

    // Defines the model to use for determining which lines to stick. If the outline model does not exist, it will fall back on the folding provider model which falls back on the indentation model. This order is respected in all three cases.
    "editor.stickyScroll.defaultModel": "outlineModel",

    // Shows the nested current scopes during the scroll at the top of the editor.
    "editor.stickyScroll.enabled": true,

    // Defines the maximum number of sticky lines to show.
    "editor.stickyScroll.maxLineCount": 5,

    // Enable scrolling of Sticky Scroll with the editor's horizontal scrollbar.
    "editor.stickyScroll.scrollWithEditor": true,

    // Emulate selection behavior of tab characters when using spaces for indentation. Selection will stick to tab stops.
    "editor.stickyTabStops": false,

    // This setting is deprecated, please use separate settings like 'editor.suggest.showKeywords' or 'editor.suggest.showSnippets' instead.
    // 
    "editor.suggest.filteredTypes": {},

    // Controls whether filtering and sorting suggestions accounts for small typos.
    "editor.suggest.filterGraceful": true,

    // Controls whether words are overwritten when accepting completions. Note that this depends on extensions opting into this feature.
    //  - insert: Insert suggestion without overwriting text right of the cursor.
    //  - replace: Insert suggestion and overwrite text right of the cursor.
    "editor.suggest.insertMode": "insert",

    // Controls whether sorting favors words that appear close to the cursor.
    "editor.suggest.localityBonus": false,

    // When enabled IntelliSense filtering requires that the first character matches on a word start. For example, `c` on `Console` or `WebContext` but _not_ on `description`. When disabled IntelliSense will show more results but still sorts them by match quality.
    "editor.suggest.matchOnWordStartOnly": true,

    // This setting is deprecated. The suggest widget can now be resized.
    // 
    "editor.suggest.maxVisibleSuggestions": 0,

    // Controls whether to preview the suggestion outcome in the editor.
    "editor.suggest.preview": false,

    // Controls whether a suggestion is selected when the widget shows. Note that this only applies to automatically triggered suggestions (`editor.quickSuggestions#` and `#editor.suggestOnTriggerCharacters`) and that a suggestion is always selected when explicitly invoked, e.g via `Ctrl+Space`.
    //  - always: Always select a suggestion when automatically triggering IntelliSense.
    //  - never: Never select a suggestion when automatically triggering IntelliSense.
    //  - whenTriggerCharacter: Select a suggestion only when triggering IntelliSense from a trigger character.
    //  - whenQuickSuggestion: Select a suggestion only when triggering IntelliSense as you type.
    "editor.suggest.selectionMode": "always",

    // Controls whether remembered suggestion selections are shared between multiple workspaces and windows (needs `editor.suggestSelection`).
    "editor.suggest.shareSuggestSelections": false,

    // When enabled IntelliSense shows `class`-suggestions.
    "editor.suggest.showClasses": true,

    // When enabled IntelliSense shows `color`-suggestions.
    "editor.suggest.showColors": true,

    // When enabled IntelliSense shows `constant`-suggestions.
    "editor.suggest.showConstants": true,

    // When enabled IntelliSense shows `constructor`-suggestions.
    "editor.suggest.showConstructors": true,

    // When enabled IntelliSense shows `customcolor`-suggestions.
    "editor.suggest.showCustomcolors": true,

    // When enabled IntelliSense shows `deprecated`-suggestions.
    "editor.suggest.showDeprecated": true,

    // When enabled IntelliSense shows `enumMember`-suggestions.
    "editor.suggest.showEnumMembers": true,

    // When enabled IntelliSense shows `enum`-suggestions.
    "editor.suggest.showEnums": true,

    // When enabled IntelliSense shows `event`-suggestions.
    "editor.suggest.showEvents": true,

    // When enabled IntelliSense shows `field`-suggestions.
    "editor.suggest.showFields": true,

    // When enabled IntelliSense shows `file`-suggestions.
    "editor.suggest.showFiles": true,

    // When enabled IntelliSense shows `folder`-suggestions.
    "editor.suggest.showFolders": true,

    // When enabled IntelliSense shows `function`-suggestions.
    "editor.suggest.showFunctions": true,

    // Controls whether to show or hide icons in suggestions.
    "editor.suggest.showIcons": true,

    // Controls whether suggest details show inline with the label or only in the details widget.
    "editor.suggest.showInlineDetails": true,

    // When enabled IntelliSense shows `interface`-suggestions.
    "editor.suggest.showInterfaces": true,

    // When enabled IntelliSense shows `issues`-suggestions.
    "editor.suggest.showIssues": true,

    // When enabled IntelliSense shows `keyword`-suggestions.
    "editor.suggest.showKeywords": true,

    // When enabled IntelliSense shows `method`-suggestions.
    "editor.suggest.showMethods": true,

    // When enabled IntelliSense shows `module`-suggestions.
    "editor.suggest.showModules": true,

    // When enabled IntelliSense shows `operator`-suggestions.
    "editor.suggest.showOperators": true,

    // When enabled IntelliSense shows `property`-suggestions.
    "editor.suggest.showProperties": true,

    // When enabled IntelliSense shows `reference`-suggestions.
    "editor.suggest.showReferences": true,

    // When enabled IntelliSense shows `snippet`-suggestions.
    "editor.suggest.showSnippets": true,

    // Controls the visibility of the status bar at the bottom of the suggest widget.
    "editor.suggest.showStatusBar": false,

    // When enabled IntelliSense shows `struct`-suggestions.
    "editor.suggest.showStructs": true,

    // When enabled IntelliSense shows `typeParameter`-suggestions.
    "editor.suggest.showTypeParameters": true,

    // When enabled IntelliSense shows `unit`-suggestions.
    "editor.suggest.showUnits": true,

    // When enabled IntelliSense shows `user`-suggestions.
    "editor.suggest.showUsers": true,

    // When enabled IntelliSense shows `value`-suggestions.
    "editor.suggest.showValues": true,

    // When enabled IntelliSense shows `variable`-suggestions.
    "editor.suggest.showVariables": true,

    // When enabled IntelliSense shows `text`-suggestions.
    "editor.suggest.showWords": true,

    // Controls whether an active snippet prevents quick suggestions.
    "editor.suggest.snippetsPreventQuickSuggestions": false,

    // Font size for the suggest widget. When set to `0`, the value of `editor.fontSize` is used.
    "editor.suggestFontSize": 0,

    // Line height for the suggest widget. When set to `0`, the value of `editor.lineHeight` is used. The minimum value is 8.
    "editor.suggestLineHeight": 0,

    // Controls whether suggestions should automatically show up when typing trigger characters.
    "editor.suggestOnTriggerCharacters": true,

    // Controls how suggestions are pre-selected when showing the suggest list.
    //  - first: Always select the first suggestion.
    //  - recentlyUsed: Select recent suggestions unless further typing selects one, e.g. `console.| -> console.log` because `log` has been completed recently.
    //  - recentlyUsedByPrefix: Select suggestions based on previous prefixes that have completed those suggestions, e.g. `co -> console` and `con -> const`.
    "editor.suggestSelection": "first",

    // Enables tab completions.
    //  - on: Tab complete will insert the best matching suggestion when pressing tab.
    //  - off: Disable tab completions.
    //  - onlySnippets: Tab complete snippets when their prefix match. Works best when 'quickSuggestions' aren't enabled.
    "editor.tabCompletion": "off",

    // Controls whether the editor receives tabs or defers them to the workbench for navigation.
    "editor.tabFocusMode": false,

    // The number of spaces a tab is equal to. This setting is overridden based on the file contents when `editor.detectIndentation` is on.
    "editor.tabSize": 4,

    // Overrides editor syntax colors and font style from the currently selected color theme.
    "editor.tokenColorCustomizations": {},

    // Remove trailing auto inserted whitespace.
    "editor.trimAutoWhitespace": true,

    // Controls whether the editor will also delete the next line's indentation whitespace when deleting a newline.
    "editor.trimWhitespaceOnDelete": false,

    // Controls whether clicking on the empty content after a folded line will unfold the line.
    "editor.unfoldOnClickAfterEndOfLine": false,

    // Defines allowed characters that are not being highlighted.
    "editor.unicodeHighlight.allowedCharacters": {},

    // Unicode characters that are common in allowed locales are not being highlighted.
    "editor.unicodeHighlight.allowedLocales": {
        "_os": true,
        "_vscode": true
    },

    // Controls whether characters are highlighted that can be confused with basic ASCII characters, except those that are common in the current user locale.
    "editor.unicodeHighlight.ambiguousCharacters": true,

    // Controls whether characters in comments should also be subject to Unicode highlighting.
    "editor.unicodeHighlight.includeComments": "inUntrustedWorkspace",

    // Controls whether characters in strings should also be subject to Unicode highlighting.
    "editor.unicodeHighlight.includeStrings": true,

    // Controls whether characters that just reserve space or have no width at all are highlighted.
    "editor.unicodeHighlight.invisibleCharacters": true,

    // Controls whether all non-basic ASCII characters are highlighted. Only characters between U+0020 and U+007E, tab, line-feed and carriage-return are considered basic ASCII.
    "editor.unicodeHighlight.nonBasicASCII": "inUntrustedWorkspace",

    // Remove unusual line terminators that might cause problems.
    //  - auto: Unusual line terminators are automatically removed.
    //  - off: Unusual line terminators are ignored.
    //  - prompt: Unusual line terminators prompt to be removed.
    "editor.unusualLineTerminators": "prompt",

    // Spaces and tabs are inserted and deleted in alignment with tab stops.
    "editor.useTabStops": true,

    // Controls whether completions should be computed based on words in the document and from which documents they are computed.
    //  - off: Turn off Word Based Suggestions.
    //  - currentDocument: Only suggest words from the active document.
    //  - matchingDocuments: Suggest words from all open documents of the same language.
    //  - allDocuments: Suggest words from all open documents.
    "editor.wordBasedSuggestions": "matchingDocuments",

    // Controls the word break rules used for Chinese/Japanese/Korean (CJK) text.
    //  - normal: Use the default line break rule.
    //  - keepAll: Word breaks should not be used for Chinese/Japanese/Korean (CJK) text. Non-CJK text behavior is the same as for normal.
    "editor.wordBreak": "normal",

    // Locales to be used for word segmentation when doing word related navigations or operations. Specify the BCP 47 language tag of the word you wish to recognize (e.g., ja, zh-CN, zh-Hant-TW, etc.).
    "editor.wordSegmenterLocales": [],

    // Characters that will be used as word separators when doing word related navigations or operations.
    "editor.wordSeparators": "`~!@#$%^&*()-=+[{]}\\|;:'\",.<>/?",

    // Controls how lines should wrap.
    //  - off: Lines will never wrap.
    //  - on: Lines will wrap at the viewport width.
    //  - wordWrapColumn: Lines will wrap at `editor.wordWrapColumn`.
    //  - bounded: Lines will wrap at the minimum of viewport and `editor.wordWrapColumn`.
    "editor.wordWrap": "off",

    // Controls the wrapping column of the editor when `editor.wordWrap` is `wordWrapColumn` or `bounded`.
    "editor.wordWrapColumn": 80,

    // Controls whether literal `\n` shall trigger a wordWrap when `editor.wordWrap` is enabled.
    // 
    // For example:
    // ```c
    // char* str="hello\nworld"
    // ```
    // will be displayed as
    // ```c
    // char* str="hello\n
    //            world"
    // ```
    "editor.wrapOnEscapedLineFeeds": false,

    // Controls the indentation of wrapped lines.
    //  - none: No indentation. Wrapped lines begin at column 1.
    //  - same: Wrapped lines get the same indentation as the parent.
    //  - indent: Wrapped lines get +1 indentation toward the parent.
    //  - deepIndent: Wrapped lines get +2 indentation toward the parent.
    "editor.wrappingIndent": "same",

    // Controls the algorithm that computes wrapping points. Note that when in accessibility mode, advanced will be used for the best experience.
    //  - simple: Assumes that all characters are of the same width. This is a fast algorithm that works correctly for monospace fonts and certain scripts (like Latin characters) where glyphs are of equal width.
    //  - advanced: Delegates wrapping points computation to the browser. This is a slow algorithm, that might cause freezes for large files, but it works correctly in all cases.
    "editor.wrappingStrategy": "simple",

    // Whether the inline chat also renders an accessible diff viewer for its changes.
    //  - auto: The accessible diff viewer is based on screen reader mode being enabled.
    //  - on: The accessible diff viewer is always enabled.
    //  - off: The accessible diff viewer is never enabled.
    "inlineChat.accessibleDiffView": "auto",

    // Whether to use the next version of inline chat.
    "inlineChat.enableV2": false,

    // Whether to finish an inline chat session when typing outside of changed regions.
    "inlineChat.finishOnType": false,

    // Whether holding the inline chat keybinding will automatically enable speech recognition.
    "inlineChat.holdToSpeech": true,

    // Enable agent-like behavior for inline chat widget in notebooks.
    "inlineChat.notebookAgent": false,

    // Run a series of Code Actions for a notebook on save. Code Actions must be specified and the editor must not be shutting down. When `files.autoSave` is set to `afterDelay`, Code Actions will only be run when the file is saved explicitly. Example: `"notebook.source.organizeImports": "explicit"`
    "notebook.codeActionsOnSave": {},

    // Source Control
    // Controls whether inline actions are always visible in the Source Control view.
    "scm.alwaysShowActions": false,

    // Controls whether repositories should always be visible in the Source Control view.
    "scm.alwaysShowRepositories": false,

    // Controls whether the Source Control view should automatically reveal and select files when opening them.
    "scm.autoReveal": true,

    // Controls whether the Source Control view should render folders in a compact form. In such a form, single child folders will be compressed in a combined tree element.
    "scm.compactFolders": true,

    // Controls the count badge on the Source Control icon on the Activity Bar.
    //  - all: Show the sum of all Source Control Provider count badges.
    //  - focused: Show the count badge of the focused Source Control Provider.
    //  - off: Disable the Source Control count badge.
    "scm.countBadge": "all",

    // Controls the default Source Control repository view mode.
    //  - tree: Show the repository changes as a tree.
    //  - list: Show the repository changes as a list.
    "scm.defaultViewMode": "list",

    // Controls the default Source Control repository changes sort order when viewed as a list.
    //  - name: Sort the repository changes by file name.
    //  - path: Sort the repository changes by path.
    //  - status: Sort the repository changes by Source Control status.
    "scm.defaultViewSortKey": "path",

    // Controls diff decorations in the editor.
    //  - all: Show the diff decorations in all available locations.
    //  - gutter: Show the diff decorations only in the editor gutter.
    //  - overview: Show the diff decorations only in the overview ruler.
    //  - minimap: Show the diff decorations only in the minimap.
    //  - none: Do not show the diff decorations.
    "scm.diffDecorations": "all",

    // Controls the behavior of Source Control diff gutter decorations.
    //  - diff: Show the inline diff Peek view on click.
    //  - none: Do nothing.
    "scm.diffDecorationsGutterAction": "diff",

    // Controls whether a pattern is used for the diff decorations in gutter.
    "scm.diffDecorationsGutterPattern": {
        "added": false,
        "modified": true
    },

    // Controls the visibility of the Source Control diff decorator in the gutter.
    //  - always: Show the diff decorator in the gutter at all times.
    //  - hover: Show the diff decorator in the gutter only on hover.
    "scm.diffDecorationsGutterVisibility": "always",

    // Controls the width(px) of diff decorations in gutter (added & modified).
    "scm.diffDecorationsGutterWidth": 3,

    // Controls whether leading and trailing whitespace is ignored in Source Control diff gutter decorations.
    //  - true: Ignore leading and trailing whitespace.
    //  - false: Do not ignore leading and trailing whitespace.
    //  - inherit: Inherit from `diffEditor.ignoreTrimWhitespace`.
    "scm.diffDecorationsIgnoreTrimWhitespace": "false",

    // Controls which badges are shown in the Source Control Graph view. The badges are shown on the right side of the graph indicating the names of history item groups.
    //  - all: Show badges of all history item groups in the Source Control Graph view.
    //  - filter: Show only the badges of history item groups used as a filter in the Source Control Graph view.
    "scm.graph.badges": "filter",

    // Controls whether the Source Control Graph view will load the next page of items when you scroll to the end of the list.
    "scm.graph.pageOnScroll": true,

    // The number of items to show in the Source Control Graph view by default and when loading more items.
    "scm.graph.pageSize": 50,

    // Controls whether to show incoming changes in the Source Control Graph view.
    "scm.graph.showIncomingChanges": true,

    // Controls whether to show outgoing changes in the Source Control Graph view.
    "scm.graph.showOutgoingChanges": true,

    // Controls the font for the input message. Use `default` for the workbench user interface font family, `editor` for the `editor.fontFamily`'s value, or a custom font family.
    "scm.inputFontFamily": "default",

    // Controls the font size for the input message in pixels.
    "scm.inputFontSize": 13,

    // Controls the maximum number of lines that the input will auto-grow to.
    "scm.inputMaxLineCount": 10,

    // Controls the minimum number of lines that the input will auto-grow from.
    "scm.inputMinLineCount": 1,

    // Controls the count badges on Source Control Provider headers. These headers appear in the Source Control view when there is more than one provider or when the `scm.alwaysShowRepositories` setting is enabled, and in the Source Control Repositories view.
    //  - hidden: Hide Source Control Provider count badges.
    //  - auto: Only show count badge for Source Control Provider when non-zero.
    //  - visible: Show Source Control Provider count badges.
    "scm.providerCountBadge": "hidden",

    // Controls whether to show repository artifacts in the Source Control Repositories view. This feature is experimental and only works when `scm.repositories.selectionMode` is set to `single`.
    "scm.repositories.explorer": false,

    // Controls the selection mode of the repositories in the Source Control Repositories view.
    //  - multiple: Multiple repositories can be selected at the same time.
    //  - single: Only one repository can be selected at a time.
    "scm.repositories.selectionMode": "multiple",

    // Controls the sort order of the repositories in the source control repositories view.
    //  - discovery time: Repositories in the Source Control Repositories view are sorted by discovery time. Repositories in the Source Control view are sorted in the order that they were selected.
    //  - name: Repositories in the Source Control Repositories and Source Control views are sorted by repository name.
    //  - path: Repositories in the Source Control Repositories and Source Control views are sorted by repository path.
    "scm.repositories.sortOrder": "discovery time",

    // Controls how many repositories are visible in the Source Control Repositories section. Set to 0, to be able to manually resize the view.
    "scm.repositories.visible": 10,

    // Controls whether an action button can be shown in the Source Control view.
    "scm.showActionButton": true,

    // Controls whether an action button can be shown in the Source Control input.
    "scm.showInputActionButton": true,

    // Controls the default working set to use when switching to a source control history item group that does not have a working set.
    //  - empty: Use an empty working set when switching to a source control history item group that does not have a working set.
    //  - current: Use the current working set when switching to a source control history item group that does not have a working set.
    "scm.workingSets.default": "current",

    // Controls whether to store editor working sets when switching between source control history item groups.
    "scm.workingSets.enabled": false,

    // Security
    // A set of UNC host names (without leading or trailing backslash, for example `192.168.0.1` or `my-server`) to allow without user confirmation. If a UNC host is being accessed that is not allowed via this setting or has not been acknowledged via user confirmation, an error will occur and the operation stopped. A restart is required when changing this setting. Find out more about this setting at https://aka.ms/vscode-windows-unc.
    "security.allowedUNCHosts": [],

    // If enabled, a dialog will ask for confirmation whenever a local file or workspace is about to open through a protocol handler.
    "security.promptForLocalFileProtocolHandling": true,

    // If enabled, a dialog will ask for confirmation whenever a remote file or workspace is about to open through a protocol handler.
    "security.promptForRemoteFileProtocolHandling": true,

    // If enabled, only allows access to UNC host names that are allowed by the `security.allowedUNCHosts` setting or after user confirmation. Find out more about this setting at https://aka.ms/vscode-windows-unc.
    "security.restrictUNCAccess": true,

    // Controls when the restricted mode banner is shown.
    //  - always: Show the banner every time an untrusted workspace is open.
    //  - untilDismissed: Show the banner when an untrusted workspace is opened until dismissed.
    //  - never: Do not show the banner when an untrusted workspace is open.
    "security.workspace.trust.banner": "untilDismissed",

    // Controls whether or not the empty window is trusted by default within VS Code. When used with `security.workspace.trust.untrustedFiles`, you can enable the full functionality of VS Code without prompting in an empty window.
    "security.workspace.trust.emptyWindow": true,

    // Controls whether or not Workspace Trust is enabled within VS Code.
    "security.workspace.trust.enabled": true,

    // Controls when the startup prompt to trust a workspace is shown.
    //  - always: Ask for trust every time an untrusted workspace is opened.
    //  - once: Ask for trust the first time an untrusted workspace is opened.
    //  - never: Do not ask for trust when an untrusted workspace is opened.
    "security.workspace.trust.startupPrompt": "once",

    // Controls how to handle opening untrusted files in a trusted workspace. This setting also applies to opening files in an empty window which is trusted via `security.workspace.trust.emptyWindow`.
    //  - prompt: Ask how to handle untrusted files for each workspace. Once untrusted files are introduced to a trusted workspace, you will not be prompted again.
    //  - open: Always allow untrusted files to be introduced to a trusted workspace without prompting.
    //  - newWindow: Always open untrusted files in a separate window in restricted mode without prompting.
    "security.workspace.trust.untrustedFiles": "prompt",

    // Workbench
    // Whether to dim unfocused editors and terminals, which makes it more clear where typed input will go to. This works with the majority of editors with the notable exceptions of those that utilize iframes like notebooks and extension webview editors.
    "accessibility.dimUnfocused.enabled": false,

    // The opacity fraction (0.2 to 1.0) to use for unfocused editors and terminals. This will only take effect when `accessibility.dimUnfocused.enabled` is enabled.
    "accessibility.dimUnfocused.opacity": 0.75,

    // Controls whether the Accessible View is hidden.
    "accessibility.hideAccessibleView": false,

    // Controls the height of editor tabs. Also applies to the title control bar when `workbench.editor.showTabs` is not set to `multiple`.
    "window.density.editorTabHeight": "default",

    // Controls the behavior of clicking an Activity Bar icon in the workbench. This value is ignored when `workbench.activityBar.location` is not set to `default`.
    //  - toggle: Hide the Primary Side Bar if the clicked item is already visible.
    //  - focus: Focus the Primary Side Bar if the clicked item is already visible.
    "workbench.activityBar.iconClickBehavior": "toggle",

    // Controls the location of the Activity Bar relative to the Primary and Secondary Side Bars.
    //  - default: Show the Activity Bar on the side of the Primary Side Bar and on top of the Secondary Side Bar.
    //  - top: Show the Activity Bar on top of the Primary and Secondary Side Bars.
    //  - bottom: Show the Activity Bar at the bottom of the Primary and Secondary Side Bars.
    //  - hidden: Hide the Activity Bar in the Primary and Secondary Side Bars.
    "workbench.activityBar.location": "default",

    // Controls whether to automatically resume available working changes stored in the cloud for the current workspace.
    //  - onReload: Automatically resume available working changes from the cloud on window reload.
    //  - off: Never attempt to resume working changes from the cloud.
    "workbench.cloudChanges.autoResume": "onReload",

    // Controls whether to prompt the user to store working changes in the cloud when using Continue Working On.
    //  - prompt: Prompt the user to sign in to store working changes in the cloud with Continue Working On.
    //  - off: Do not store working changes in the cloud with Continue Working On unless the user has already turned on Cloud Changes.
    "workbench.cloudChanges.continueOn": "prompt",

    // Overrides colors from the currently selected color theme.
    "workbench.colorCustomizations": {},

    // Specifies the color theme used in the workbench when `window.autoDetectColorScheme` is not enabled.
    "workbench.colorTheme": "Default Dark Modern",

    // Controls where the command palette should ask chat questions.
    //  - chatView: Ask chat questions in the Chat view.
    //  - quickChat: Ask chat questions in Quick Chat.
    "workbench.commandPalette.experimental.askChatLocation": "chatView",

    // Controls whether the command palette should include similar commands. You must have an extension installed that provides Natural Language support.
    "workbench.commandPalette.experimental.enableNaturalLanguageSearch": true,

    // Controls whether the command palette should have a list of commonly used commands.
    "workbench.commandPalette.experimental.suggestCommands": false,

    // Controls the number of recently used commands to keep in history for the command palette. Set to 0 to disable command history.
    "workbench.commandPalette.history": 50,

    // Controls whether the last typed input to the command palette should be restored when opening it the next time.
    "workbench.commandPalette.preserveInput": false,

    // Controls whether the command palette shows 'Ask in Chat' option at the bottom.
    "workbench.commandPalette.showAskInChat": true,

    // Controls whether to always show the editor actions, even when the editor group is not active.
    "workbench.editor.alwaysShowEditorActions": false,

    // If an editor matching one of the listed types is opened as the first in an editor group and more than one group is open, the group is automatically locked. Locked groups will only be used for opening editors when explicitly chosen by a user gesture (for example drag and drop), but not by default. Consequently, the active editor in a locked group is less likely to be replaced accidentally with a different editor.
    "workbench.editor.autoLockGroups": {
        "default": false,
        "workbench.editor.chatSession": false,
        "workbench.editorinputs.searchEditorInput": false,
        "workbench.editor.processExplorer": true,
        "notebookOutputEditor": false,
        "jupyter-notebook": false,
        "repl": false,
        "workbench.editors.gettingStartedInput": false,
        "terminalEditor": true,
        "imagePreview.previewEditor": false,
        "vscode.audioPreview": false,
        "vscode.videoPreview": false,
        "jsProfileVisualizer.cpuprofile.table": false,
        "jsProfileVisualizer.heapprofile.table": false,
        "jsProfileVisualizer.heapsnapshot.table": false,
        "gitlens.rebase": false,
        "hediet.vscode-drawio": false,
        "hediet.vscode-drawio-text": false,
        "workbench.input.interactive": false,
        "mainThreadWebview-markdown.preview": false,
        "mainThreadWebview-simpleBrowser.view": true,
        "mainThreadWebview-browserPreview": true
    },

    // Controls if the centered layout should automatically resize to maximum width when more than one group is open. Once only one group is open it will resize back to the original centered width.
    "workbench.editor.centeredLayoutAutoResize": true,

    // Controls whether the centered layout tries to maintain constant width when the window is resized.
    "workbench.editor.centeredLayoutFixedWidth": false,

    // Controls the behavior of empty editor groups when the last tab in the group is closed. When enabled, empty groups will automatically close. When disabled, empty groups will remain part of the grid.
    "workbench.editor.closeEmptyGroups": true,

    // Controls whether editors showing a file that was opened during the session should close automatically when getting deleted or renamed by some other process. Disabling this will keep the editor open  on such an event. Note that deleting from within the application will always close the editor and that editors with unsaved changes will never close to preserve your data.
    "workbench.editor.closeOnFileDelete": false,

    // Controls whether the custom workbench editor labels should be applied.
    "workbench.editor.customLabels.enabled": true,

    // Controls the rendering of the editor label. Each __Item__ is a pattern that matches a file path. Both relative and absolute file paths are supported. The relative path must include the WORKSPACE_FOLDER (e.g `WORKSPACE_FOLDER/src/**.tsx` or `*/src/**.tsx`). Absolute patterns must start with a `/`. In case multiple patterns match, the longest matching path will be picked. Each __Value__ is the template for the rendered editor when the __Item__ matches. Variables are substituted based on the context:
    // - `${dirname}`: name of the folder in which the file is located (e.g. `WORKSPACE_FOLDER/folder/file.txt -> folder`).
    // - `${dirname(N)}`: name of the nth parent folder in which the file is located (e.g. `N=2: WORKSPACE_FOLDER/static/folder/file.txt -> WORKSPACE_FOLDER`). Folders can be picked from the start of the path by using negative numbers (e.g. `N=-1: WORKSPACE_FOLDER/folder/file.txt -> WORKSPACE_FOLDER`). If the __Item__ is an absolute pattern path, the first folder (`N=-1`) refers to the first folder in the absolute path, otherwise it corresponds to the workspace folder.
    // - `${filename}`: name of the file without the file extension (e.g. `WORKSPACE_FOLDER/folder/file.txt -> file`).
    // - `${extname}`: the file extension (e.g. `WORKSPACE_FOLDER/folder/file.txt -> txt`).
    // - `${extname(N)}`: the nth extension of the file separated by '.' (e.g. `N=2: WORKSPACE_FOLDER/folder/file.ext1.ext2.ext3 -> ext1`). Extension can be picked from the start of the extension by using negative numbers (e.g. `N=-1: WORKSPACE_FOLDER/folder/file.ext1.ext2.ext3 -> ext2`).
    // 
    // Example: `"**/static/**/*.html": "${filename} - ${dirname} (${extname})"` will render a file `WORKSPACE_FOLDER/static/folder/file.html` as `file - folder (html)`.
    "workbench.editor.customLabels.patterns": {},

    // Controls whether editor file decorations should use badges.
    "workbench.editor.decorations.badges": true,

    // Controls whether editor file decorations should use colors.
    "workbench.editor.decorations.colors": true,

    // The default editor for files detected as binary. If undefined, the user will be presented with a picker.
    "workbench.editor.defaultBinaryEditor": "",

    // Controls how the editor group is resized when double clicking on a tab. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    //  - maximize: All other editor groups are hidden and the current editor group is maximized to take up the entire editor area.
    //  - expand: The editor group takes as much space as possible by making all other editor groups as small as possible.
    //  - off: No editor group is resized when double clicking on a tab.
    "workbench.editor.doubleClickTabToToggleEditorGroupSizes": "expand",

    // Controls if editors can be dragged out of the window to open them in a new window. Press and hold the `Alt` key while dragging to toggle this dynamically.
    "workbench.editor.dragToOpenWindow": true,

    // Controls where the editor actions are shown.
    //  - default: Show editor actions in the window title bar when `workbench.editor.showTabs` is set to `none`. Otherwise, editor actions are shown in the editor tab bar.
    //  - titleBar: Show editor actions in the window title bar. If `window.customTitleBarVisibility` is set to `never`, editor actions are hidden.
    //  - hidden: Editor actions are not shown.
    "workbench.editor.editorActionsLocation": "default",

    // Controls if the empty editor text hint should be visible in the editor.
    "workbench.editor.empty.hint": "text",

    // Controls whether preview mode is used when editors open. There is a maximum of one preview mode editor per editor group. This editor displays its filename in italics on its tab or title label and in the Open Editors view. Its contents will be replaced by the next editor opened in preview mode. Making a change in a preview mode editor will persist it, as will a double-click on its label, or the 'Keep Open' option in its label context menu. Opening a file from Explorer with a double-click persists its editor immediately.
    "workbench.editor.enablePreview": true,

    // Controls whether editors remain in preview when a code navigation is started from them. Preview editors do not stay open, and are reused until explicitly set to be kept open (via double-click or editing). This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.enablePreviewFromCodeNavigation": false,

    // Controls whether editors opened from Quick Open show as preview editors. Preview editors do not stay open, and are reused until explicitly set to be kept open (via double-click or editing). When enabled, hold Ctrl before selection to open an editor as a non-preview. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.enablePreviewFromQuickOpen": false,

    // Controls whether editors are closed in most recently used order or from left to right.
    "workbench.editor.focusRecentEditorAfterClose": true,

    // Controls whether a top border is drawn on tabs for editors that have unsaved changes. This value is ignored when `workbench.editor.showTabs` is not set to multiple.
    "workbench.editor.highlightModifiedTabs": false,

    // Enables use of editor history in language detection. This causes automatic language detection to favor languages that have been recently opened and allows for automatic language detection to operate with smaller inputs.
    "workbench.editor.historyBasedLanguageDetection": true,

    // Controls the format of the label for an editor.
    //  - default: Show the name of the file. When tabs are enabled and two files have the same name in one group the distinguishing sections of each file's path are added. When tabs are disabled, the path relative to the workspace folder is shown if the editor is active.
    //  - short: Show the name of the file followed by its directory name.
    //  - medium: Show the name of the file followed by its path relative to the workspace folder.
    //  - long: Show the name of the file followed by its absolute path.
    "workbench.editor.labelFormat": "default",

    // Controls whether the language in a text editor is automatically detected unless the language has been explicitly set by the language picker. This can also be scoped by language so you can specify which languages you do not want to be switched off of. This is useful for languages like Markdown that often contain other languages that might trick language detection into thinking it's the embedded language and not Markdown.
    "workbench.editor.languageDetection": true,

    // When enabled, shows a status bar Quick Fix when the editor language doesn't match detected content language.
    "workbench.editor.languageDetectionHints": {
        "untitledEditors": true,
        "notebookEditors": true
    },

    // Controls if the number of opened editors should be limited or not. When enabled, less recently used editors will close to make space for newly opening editors.
    "workbench.editor.limit.enabled": false,

    // Controls if the maximum number of opened editors should exclude dirty editors for counting towards the configured limit.
    "workbench.editor.limit.excludeDirty": false,

    // Controls if the limit of maximum opened editors should apply per editor group or across all editor groups.
    "workbench.editor.limit.perEditorGroup": false,

    // Controls the maximum number of opened editors. Use the `workbench.editor.limit.perEditorGroup` setting to control this limit per editor group or across all groups.
    "workbench.editor.limit.value": 10,

    // Enables the use of mouse buttons four and five for commands 'Go Back' and 'Go Forward'.
    "workbench.editor.mouseBackForwardToNavigate": true,

    // Controls the scope of history navigation in editors for commands such as 'Go Back' and 'Go Forward'.
    //  - default: Navigate across all opened editors and editor groups.
    //  - editorGroup: Navigate only in editors of the active editor group.
    //  - editor: Navigate only in the active editor.
    "workbench.editor.navigationScope": "default",

    // Controls where editors open. Select `left` or `right` to open editors to the left or right of the currently active one. Select `first` or `last` to open editors independently from the currently active one.
    "workbench.editor.openPositioning": "right",

    // Controls the default direction of editors that are opened side by side (for example, from the Explorer). By default, editors will open on the right hand side of the currently active one. If changed to `down`, the editors will open below the currently active one. This also impacts the split editor action in the editor toolbar.
    "workbench.editor.openSideBySideDirection": "right",

    // Controls the size of pinned editor tabs. Pinned tabs are sorted to the beginning of all opened tabs and typically do not close until unpinned. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    //  - normal: A pinned tab inherits the look of non pinned tabs.
    //  - compact: A pinned tab will show in a compact form with only icon or first letter of the editor name.
    //  - shrink: A pinned tab shrinks to a compact fixed size showing parts of the editor name.
    "workbench.editor.pinnedTabSizing": "normal",

    // When enabled, displays pinned tabs in a separate row above all other tabs. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.pinnedTabsOnSeparateRow": false,

    // When enabled, a language detection model that takes into account editor history will be given higher precedence.
    "workbench.editor.preferHistoryBasedLanguageDetection": false,

    // Controls whether pinned editors should close when keyboard or middle mouse click is used for closing.
    //  - keyboardAndMouse: Always prevent closing the pinned editor when using mouse middle click or keyboard.
    //  - keyboard: Prevent closing the pinned editor when using the keyboard.
    //  - mouse: Prevent closing the pinned editor when using mouse middle click.
    //  - never: Never prevent closing a pinned editor.
    "workbench.editor.preventPinnedEditorClose": "keyboardAndMouse",

    // Restores the last editor view state (such as scroll position) when re-opening editors after they have been closed. Editor view state is stored per editor group and discarded when a group closes. Use the `workbench.editor.sharedViewState` setting to use the last known view state across all editor groups in case no previous view state was found for a editor group.
    "workbench.editor.restoreViewState": true,

    // Controls whether an editor is revealed in any of the visible groups if opened. If disabled, an editor will prefer to open in the currently active editor group. If enabled, an already opened editor will be revealed instead of opened again in the currently active editor group. Note that there are some cases where this setting is ignored, such as when forcing an editor to open in a specific group or to the side of the currently active group.
    "workbench.editor.revealIfOpen": false,

    // Controls whether scrolling over tabs will open them or not. By default tabs will only reveal upon scrolling, but not open. You can press and hold the Shift-key while scrolling to change this behavior for that duration. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.scrollToSwitchTabs": false,

    // Preserves the most recent editor view state (such as scroll position) across all editor groups and restores that if no specific editor view state is found for the editor group.
    "workbench.editor.sharedViewState": false,

    // Controls whether opened editors should show with an icon or not. This requires a file icon theme to be enabled as well.
    "workbench.editor.showIcons": true,

    // When enabled, will show the tab index. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.showTabIndex": false,

    // Controls whether opened editors should show as individual tabs, one single large tab or if the title area should not be shown.
    //  - multiple: Each editor is displayed as a tab in the editor title area.
    //  - single: The active editor is displayed as a single large tab in the editor title area.
    //  - none: The editor title area is not displayed.
    "workbench.editor.showTabs": "multiple",

    // Controls the layout for when an editor is split in an editor group to be either vertical or horizontal.
    //  - vertical: Editors are positioned from top to bottom.
    //  - horizontal: Editors are positioned from left to right.
    "workbench.editor.splitInGroupLayout": "horizontal",

    // Controls if editor groups can be split from drag and drop operations by dropping an editor or file on the edges of the editor area.
    "workbench.editor.splitOnDragAndDrop": true,

    // Controls the size of editor groups when splitting them.
    //  - auto: Splits the active editor group to equal parts, unless all editor groups are already in equal parts. In that case, splits all the editor groups to equal parts.
    //  - distribute: Splits all the editor groups to equal parts.
    //  - split: Splits the active editor group to equal parts.
    "workbench.editor.splitSizing": "auto",

    // Controls the visibility of the tab close action button.
    "workbench.editor.tabActionCloseVisibility": true,

    // Controls the position of the editor's tabs action buttons (close, unpin). This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    "workbench.editor.tabActionLocation": "right",

    // Controls the visibility of the tab unpin action button.
    "workbench.editor.tabActionUnpinVisibility": true,

    // Controls the size of editor tabs. This value is ignored when `workbench.editor.showTabs` is not set to `multiple`.
    //  - fit: Always keep tabs large enough to show the full editor label.
    //  - shrink: Allow tabs to get smaller when the available space is not enough to show all tabs at once.
    //  - fixed: Make all tabs the same size, while allowing them to get smaller when the available space is not enough to show all tabs at once.
    "workbench.editor.tabSizing": "fit",

    // Controls the maximum width of tabs when `workbench.editor.tabSizing` size is set to `fixed`.
    "workbench.editor.tabSizingFixedMaxWidth": 160,

    // Controls the minimum width of tabs when `workbench.editor.tabSizing` size is set to `fixed`.
    "workbench.editor.tabSizingFixedMinWidth": 50,

    // Controls the height of the scrollbars used for tabs and breadcrumbs in the editor title area.
    //  - default: The default size.
    //  - large: Increases the size, so it can be grabbed more easily with the mouse.
    "workbench.editor.titleScrollbarSizing": "default",

    // Controls the visibility of the scrollbars used for tabs and breadcrumbs in the editor title area.
    //  - auto: The horizontal scrollbar will be visible only when necessary.
    //  - visible: The horizontal scrollbar will always be visible.
    //  - hidden: The horizontal scrollbar will always be hidden.
    "workbench.editor.titleScrollbarVisibility": "auto",

    // Controls the format of the label for an untitled editor.
    //  - content: The name of the untitled file is derived from the contents of its first line unless it has an associated file path. It will fallback to the name in case the line is empty or contains no word characters.
    //  - name: The name of the untitled file is not derived from the contents of the file.
    "workbench.editor.untitled.labelFormat": "content",

    // Controls whether tabs should be wrapped over multiple lines when exceeding available space or whether a scrollbar should appear instead. This value is ignored when `workbench.editor.showTabs` is not set to '`multiple`'.
    "workbench.editor.wrapTabs": false,

    // Configure [glob patterns](https://aka.ms/vscode-glob-patterns) to editors (for example `"*.hex": "hexEditor.hexedit"`). These have precedence over the default behavior.
    "workbench.editorAssociations": {
        "*.copilotmd": "vscode.markdown.preview.editor"
    },

    // Controls the minimum size of a file in MB before asking for confirmation when opening in the editor. Note that this setting may not apply to all editor types and environments.
    "workbench.editorLargeFileConfirmation": 1024,

    // Fetches experiments to run from a Microsoft online service.
    "workbench.enableExperiments": true,

    // Controls whether to automatically store available working changes in the cloud for the current workspace. This setting has no effect in the web.
    //  - onShutdown: Automatically store current working changes in the cloud on window close.
    //  - off: Never attempt to automatically store working changes in the cloud.
    "workbench.experimental.cloudChanges.autoStore": "off",

    // Controls whether to surface cloud changes which partially match the current session.
    "workbench.experimental.cloudChanges.partialMatches.enabled": false,

    // Controls whether to render the Share action next to the command center when `window.commandCenter` is `true`.
    "workbench.experimental.share.enabled": false,

    // Configure the browser to use for opening http or https links externally. This can either be the name of the browser (`edge`, `chrome`, `firefox`) or an absolute path to the browser's executable. Will use the system default if not set.
    "workbench.externalBrowser": "",

    // Configure the opener to use for external URIs (http, https).
    "workbench.externalUriOpeners": {},

    // Controls the delay in milliseconds after which the hover is shown for workbench items (ex. some extension provided tree view items). Already visible items may require a refresh before reflecting this setting change.
    "workbench.hover.delay": 500,

    // Specifies the file icon theme used in the workbench or 'null' to not show any file icons.
    //  - null: No file icons
    //  - vs-minimal
    //  - vs-seti
    "workbench.iconTheme": "vs-seti",

    // Controls whether the layout control is shown in the custom title bar. This setting only has an effect when `window.customTitleBarVisibility` is not set to `never`.
    "workbench.layoutControl.enabled": true,

    // Controls whether the layout control in the custom title bar is displayed as a single menu button or with multiple UI toggles.
    //  - menu: Shows a single button with a dropdown of layout options.
    //  - toggles: Shows several buttons for toggling the visibility of the panels and side bar.
    //  - both: Shows both the dropdown and toggle buttons.
    "workbench.layoutControl.type": "both",

    // Controls the type of matching used when searching lists and trees in the workbench.
    //  - fuzzy: Use fuzzy matching when searching.
    //  - contiguous: Use contiguous matching when searching.
    "workbench.list.defaultFindMatchType": "fuzzy",

    // Controls the default find mode for lists and trees in the workbench.
    //  - highlight: Highlight elements when searching. Further up and down navigation will traverse only the highlighted elements.
    //  - filter: Filter elements when searching.
    "workbench.list.defaultFindMode": "highlight",

    // Scrolling speed multiplier when pressing `Alt`.
    "workbench.list.fastScrollSensitivity": 5,

    // Controls whether lists and trees support horizontal scrolling in the workbench. Warning: turning on this setting has a performance implication.
    "workbench.list.horizontalScrolling": false,

    // Please use 'workbench.list.defaultFindMode' and	'workbench.list.typeNavigationMode' instead.
    // Controls the keyboard navigation style for lists and trees in the workbench. Can be simple, highlight and filter.
    //  - simple: Simple keyboard navigation focuses elements which match the keyboard input. Matching is done only on prefixes.
    //  - highlight: Highlight keyboard navigation highlights elements which match the keyboard input. Further up and down navigation will traverse only the highlighted elements.
    //  - filter: Filter keyboard navigation will filter out and hide all the elements which do not match the keyboard input.
    "workbench.list.keyboardNavigation": "highlight",

    // A multiplier to be used on the `deltaX` and `deltaY` of mouse wheel scroll events.
    "workbench.list.mouseWheelScrollSensitivity": 1,

    // The modifier to be used to add an item in trees and lists to a multi-selection with the mouse (for example in the explorer, open editors and scm view). The 'Open to Side' mouse gestures - if supported - will adapt such that they do not conflict with the multiselect modifier.
    //  - ctrlCmd: Maps to `Control` on Windows and Linux and to `Command` on macOS.
    //  - alt: Maps to `Alt` on Windows and Linux and to `Option` on macOS.
    "workbench.list.multiSelectModifier": "ctrlCmd",

    // Controls how to open items in trees and lists using the mouse (if supported). Note that some trees and lists might choose to ignore this setting if it is not applicable.
    "workbench.list.openMode": "singleClick",

    // Controls whether clicks in the scrollbar scroll page by page.
    "workbench.list.scrollByPage": false,

    // Controls whether lists and trees have smooth scrolling.
    "workbench.list.smoothScrolling": false,

    // Controls how type navigation works in lists and trees in the workbench. When set to `trigger`, type navigation begins once the `list.triggerTypeNavigation` command is run.
    "workbench.list.typeNavigationMode": "automatic",

    // Controls whether local file history is enabled. When enabled, the file contents of an editor that is saved will be stored to a backup location to be able to restore or review the contents later. Changing this setting has no effect on existing local file history entries.
    "workbench.localHistory.enabled": true,

    // Configure paths or [glob patterns](https://aka.ms/vscode-glob-patterns) for excluding files from the local file history. Glob patterns are always evaluated relative to the path of the workspace folder unless they are absolute paths. Changing this setting has no effect on existing local file history entries.
    "workbench.localHistory.exclude": {},

    // Controls the maximum number of local file history entries per file. When the number of local file history entries exceeds this number for a file, the oldest entries will be discarded.
    "workbench.localHistory.maxFileEntries": 50,

    // Controls the maximum size of a file (in KB) to be considered for local file history. Files that are larger will not be added to the local file history. Changing this setting has no effect on existing local file history entries.
    "workbench.localHistory.maxFileSize": 256,

    // Configure an interval in seconds during which the last entry in local file history is replaced with the entry that is being added. This helps reduce the overall number of entries that are added, for example when auto save is enabled. This setting is only applied to entries that have the same source of origin. Changing this setting has no effect on existing local file history entries.
    "workbench.localHistory.mergeWindow": 10,

    // Controls whether the navigation control is shown in the custom title bar. This setting only has an effect when `window.customTitleBarVisibility` is not set to `never`.
    "workbench.navigationControl.enabled": true,

    // Controls the default location of the panel (Terminal, Debug Console, Output, Problems) in a new workspace. It can either show at the bottom, top, right, or left of the editor area.
    "workbench.panel.defaultLocation": "bottom",

    // Controls whether the panel opens maximized. It can either always open maximized, never open maximized, or open to the last state it was in before being closed.
    //  - always: Always maximize the panel when opening it.
    //  - never: Never maximize the panel when opening it.
    //  - preserve: Open the panel to the state that it was in, before it was closed.
    "workbench.panel.opensMaximized": "preserve",

    // Controls whether activity items in the panel title are shown as label or icon.
    "workbench.panel.showLabels": true,

    // Specifies the color theme when system color mode is dark and `window.autoDetectColorScheme` is enabled.
    "workbench.preferredDarkColorTheme": "Default Dark Modern",

    // Specifies the color theme when in high contrast dark mode and `window.autoDetectHighContrast` is enabled.
    "workbench.preferredHighContrastColorTheme": "Default High Contrast",

    // Specifies the color theme when in high contrast light mode and `window.autoDetectHighContrast` is enabled.
    "workbench.preferredHighContrastLightColorTheme": "Default High Contrast Light",

    // Specifies the color theme when system color mode is light and `window.autoDetectColorScheme` is enabled.
    "workbench.preferredLightColorTheme": "Default Light Modern",

    // Specifies the product icon theme used.
    //  - Default: Default
    "workbench.productIconTheme": "Default",

    // Controls whether Quick Open should close automatically once it loses focus.
    "workbench.quickOpen.closeOnFocusLost": true,

    // Controls whether the last typed input to Quick Open should be restored when opening it the next time.
    "workbench.quickOpen.preserveInput": false,

    // Controls whether the workbench should render with fewer animations.
    //  - on: Always render with reduced motion.
    //  - off: Do not render with reduced motion
    //  - auto: Render with reduced motion based on OS configuration.
    "workbench.reduceMotion": "auto",

    // When enabled, remote extensions recommendations will be shown in the Remote Indicator menu.
    "workbench.remoteIndicator.showExtensionRecommendations": true,

    // Controls the hover feedback delay in milliseconds of the dragging area in between views/editors.
    "workbench.sash.hoverDelay": 300,

    // Controls the feedback area size in pixels of the dragging area in between views/editors. Set it to a larger value if you feel it's hard to resize views using the mouse.
    "workbench.sash.size": 4,

    // Controls the default visibility of the secondary side bar in workspaces or empty windows that are opened for the first time.
    //  - hidden: The secondary side bar is hidden by default.
    //  - visibleInWorkspace: The secondary side bar is visible by default if a workspace is opened.
    //  - visible: The secondary side bar is visible by default.
    //  - maximizedInWorkspace: The secondary side bar is visible and maximized by default if a workspace is opened.
    //  - maximized: The secondary side bar is visible and maximized by default.
    "workbench.secondarySideBar.defaultVisibility": "visibleInWorkspace",

    // Enables the default secondary sidebar visibility in older workspaces before we had default visibility support.
    "workbench.secondarySideBar.enableDefaultVisibilityInOldWorkspace": true,

    // Controls whether activity items in the secondary side bar title are shown as label or icon. This setting only has an effect when `workbench.activityBar.location` is not set to `top`.
    "workbench.secondarySideBar.showLabels": true,

    // Configure settings to be applied for all profiles.
    "workbench.settings.applyToAllProfiles": [],

    // Determines which Settings editor to use by default.
    //  - ui: Use the settings UI editor.
    //  - json: Use the JSON file editor.
    "workbench.settings.editor": "ui",

    // Controls whether to enable the natural language search mode for settings. The natural language search is provided by a Microsoft online service.
    "workbench.settings.enableNaturalLanguageSearch": true,

    // Controls whether opening keybinding settings also opens an editor showing all default keybindings.
    "workbench.settings.openDefaultKeybindings": false,

    // Controls whether opening settings also opens an editor showing all default settings.
    "workbench.settings.openDefaultSettings": false,

    // Controls the behavior of the Settings editor Table of Contents while searching. If this setting is being changed in the Settings editor, the setting will take effect after the search query is modified.
    //  - hide: Hide the Table of Contents while searching.
    //  - filter: Filter the Table of Contents to just categories that have matching settings. Clicking on a category will filter the results to that category.
    "workbench.settings.settingsSearchTocBehavior": "filter",

    // Controls whether the AI search results toggle is shown in the search bar in the Settings editor after doing a search and once AI search results are available.
    "workbench.settings.showAISearchToggle": true,

    // Controls whether to use the split JSON editor when editing settings as JSON.
    "workbench.settings.useSplitJSON": false,

    // Controls the location of the primary side bar and activity bar. They can either show on the left or right of the workbench. The secondary side bar will show on the opposite side of the workbench.
    "workbench.sideBar.location": "left",

    // Controls which editor is shown at startup, if none are restored from the previous session.
    //  - none: Start without an editor.
    //  - welcomePage: Open the Welcome page, with content to aid in getting started with VS Code and extensions.
    //  - readme: Open the README when opening a folder that contains one, fallback to 'welcomePage' otherwise. Note: This is only observed as a global configuration, it will be ignored if set in a workspace or folder configuration.
    //  - newUntitledFile: Open a new untitled text file (only applies when opening an empty window).
    //  - welcomePageInEmptyWorkbench: Open the Welcome page when opening an empty workbench.
    //  - terminal: Open a new terminal in the editor area.
    "workbench.startupEditor": "welcomePage",

    // Controls the visibility of the status bar at the bottom of the workbench.
    "workbench.statusBar.visible": true,

    // When enabled, will show the watermark tips when no editor is open.
    "workbench.tips.enabled": true,

    // Controls whether sticky scrolling is enabled in trees.
    "workbench.tree.enableStickyScroll": true,

    // Controls how tree folders are expanded when clicking the folder names. Note that some trees and lists might choose to ignore this setting if it is not applicable.
    "workbench.tree.expandMode": "singleClick",

    // Controls tree indentation in pixels.
    "workbench.tree.indent": 8,

    // Controls whether the tree should render indent guides.
    "workbench.tree.renderIndentGuides": "onHover",

    // Controls the number of sticky elements displayed in the tree when `workbench.tree.enableStickyScroll` is enabled.
    "workbench.tree.stickyScrollMaxItemCount": 7,

    // When enabled, trusted domain prompts will appear when opening links in trusted workspaces.
    "workbench.trustedDomains.promptInTrustedWorkspace": false,

    // Controls the visibility of view header actions. View header actions may either be always visible, or only visible when that view is focused or hovered over.
    "workbench.view.alwaysShowHeaderActions": false,

    // If an extension requests a hidden view to be shown, display a clickable status bar indicator instead.
    "workbench.view.showQuietly": {},

    // Deprecated, use the global `workbench.reduceMotion`.
    // When enabled, reduce motion in welcome page.
    "workbench.welcomePage.preferReducedMotion": false,

    // When enabled, an extension's walkthrough will open upon install of the extension.
    "workbench.welcomePage.walkthroughs.openOnInstall": true,

    // Window
    // If enabled, will automatically select a color theme based on the system color mode. If the system color mode is dark, `workbench.preferredDarkColorTheme#` is used, else `#workbench.preferredLightColorTheme`.
    "window.autoDetectColorScheme": false,

    // If enabled, will automatically change to high contrast theme if the OS is using a high contrast theme. The high contrast theme to use is specified by `workbench.preferredHighContrastColorTheme#` and `#workbench.preferredHighContrastLightColorTheme`.
    "window.autoDetectHighContrast": true,

    // Controls the border color of the window:
    // - `default`: respect color theme settings, fallback to Windows settings
    // - `system`: respect Windows settings only
    // - `off`: disable border colors
    // - `<color>`: specific color in Hex, RGB, RGBA, HSL, HSLA format
    // 
    // Use `workbench.colorCustomizations#` to set different colors for active and inactive windows. This setting is ignored when `#window.titleBarStyle` is set to `native`.
    "window.border": "default",

    // Controls whether closing the last editor should also close the window. This setting only applies for windows that do not show folders.
    "window.closeWhenEmpty": false,

    // Show command launcher together with the window title. This setting only has an effect when `window.customTitleBarVisibility` is not set to `never`.
    "window.commandCenter": true,

    // Controls whether to show a confirmation dialog before closing a window or quitting the application.
    //  - always: Always ask for confirmation.
    //  - keyboardOnly: Only ask for confirmation if a keybinding was used.
    //  - never: Never explicitly ask for confirmation.
    "window.confirmBeforeClose": "never",

    // Controls whether a confirmation dialog shows asking to save or discard an opened untitled workspace in the window when switching to another workspace. Disabling the confirmation dialog will always discard the untitled workspace.
    "window.confirmSaveUntitledWorkspace": true,

    // Adjust the appearance of the window controls to be native by the OS, custom drawn or hidden. Changes require a full restart to apply.
    "window.controlsStyle": "native",

    // Controls whether the menu bar will be focused by pressing the Alt-key. This setting has no effect on toggling the menu bar with the Alt-key.
    "window.customMenuBarAltFocus": true,

    // Adjust when the custom title bar should be shown. The custom title bar can be hidden when in full screen mode with `windowed`. The custom title bar can only be hidden in non full screen mode with `never` when `window.titleBarStyle` is set to `native`.
    //  - auto: Automatically changes custom title bar visibility.
    //  - windowed: Hide custom titlebar in full screen. When not in full screen, automatically change custom title bar visibility.
    //  - never: Hide custom titlebar when `window.titleBarStyle` is set to `native`.
    "window.customTitleBarVisibility": "auto",

    // Adjust the appearance of dialogs to be native by the OS or custom.
    "window.dialogStyle": "native",

    // If enabled, this setting will close the window when the application icon in the title bar is double-clicked. The window will not be able to be dragged by the icon. This setting is effective only if `window.titleBarStyle` is set to `custom`.
    "window.doubleClickIconToClose": false,

    // Controls whether the main menus can be opened via Alt-key shortcuts. Disabling mnemonics allows to bind these Alt-key shortcuts to editor commands instead.
    "window.enableMenuBarMnemonics": true,

    // Control the visibility of the menu bar. A setting of 'toggle' means that the menu bar is hidden and a single press of the Alt key will show it. A setting of 'compact' will move the menu into the side bar.
    //  - classic: Menu is displayed at the top of the window and only hidden in full screen mode.
    //  - visible: Menu is always visible at the top of the window even in full screen mode.
    //  - toggle: Menu is hidden but can be displayed at the top of the window via the Alt key.
    //  - hidden: Menu is always hidden.
    //  - compact: Menu is displayed as a compact button in the side bar. This value is ignored when `window.titleBarStyle#` is `native` and `#window.menuStyle` is either `native` or `inherit`.
    "window.menuBarVisibility": "classic",

    // Adjust the menu style to either be native by the OS, custom, or inherited from the title bar style defined in `window.titleBarStyle`. This also affects the context menu appearance. Changes require a full restart to apply.
    //  - custom: Use the custom menu.
    //  - native: Use the native menu. This is ignored when `window.titleBarStyle` is set to `custom`.
    //  - inherit: Matches the menu style to the title bar style defined in `window.titleBarStyle`.
    "window.menuStyle": "inherit",

    // Controls the dimensions of opening a new window when at least one window is already opened. Note that this setting does not have an impact on the first window that is opened. The first window will always restore the size and location as you left it before closing.
    //  - default: Open new windows in the center of the screen.
    //  - inherit: Open new windows with same dimension as last active one.
    //  - offset: Open new windows with same dimension as last active one with an offset position.
    //  - maximized: Open new windows maximized.
    //  - fullscreen: Open new windows in full screen mode.
    "window.newWindowDimensions": "default",

    // Specifies the profile to use when opening a new window. If a profile name is provided, the new window will use that profile. If no profile name is provided, the new window will use the profile of the active window or the Default profile if no active window exists.
    "window.newWindowProfile": null,

    // Controls whether files should open in a new window when using a command line or file dialog.
    // Note that there can still be cases where this setting is ignored (e.g. when using the `--new-window` or `--reuse-window` command line option).
    //  - on: Files will open in a new window.
    //  - off: Files will open in the window with the files' folder open or the last active window.
    //  - default: Files will open in a new window unless picked from within the application (e.g. via the File menu).
    "window.openFilesInNewWindow": "off",

    // Controls whether folders should open in a new window or replace the last active window.
    // Note that there can still be cases where this setting is ignored (e.g. when using the `--new-window` or `--reuse-window` command line option).
    //  - on: Folders will open in a new window.
    //  - off: Folders will replace the last active window.
    //  - default: Folders will open in a new window unless a folder is picked from within the application (e.g. via the File menu).
    "window.openFoldersInNewWindow": "default",

    // Controls whether a new empty window should open when starting a second instance without arguments or if the last running instance should get focus.
    // Note that there can still be cases where this setting is ignored (e.g. when using the `--new-window` or `--reuse-window` command line option).
    //  - on: Open a new empty window.
    //  - off: Focus the last active running instance.
    "window.openWithoutArgumentsInNewWindow": "on",

    // Controls whether a window should restore to full screen mode if it was exited in full screen mode.
    "window.restoreFullscreen": false,

    // Controls how windows and editors within are being restored when opening.
    //  - preserve: Always reopen all windows. If a folder or workspace is opened (e.g. from the command line) it opens as a new window unless it was opened before. If files are opened they will open in one of the restored windows together with editors that were previously opened.
    //  - all: Reopen all windows unless a folder, workspace or file is opened (e.g. from the command line). If a file is opened, it will replace any of the editors that were previously opened in a window.
    //  - folders: Reopen all windows that had folders or workspaces opened unless a folder, workspace or file is opened (e.g. from the command line). If a file is opened, it will replace any of the editors that were previously opened in a window.
    //  - one: Reopen the last active window unless a folder, workspace or file is opened (e.g. from the command line). If a file is opened, it will replace any of the editors that were previously opened in a window.
    //  - none: Never reopen a window. Unless a folder or workspace is opened (e.g. from the command line), an empty window will appear.
    "window.restoreWindows": "all",

    // Controls the window title based on the current context such as the opened workspace or active editor. Variables are substituted based on the context:
    // - `${activeEditorShort}`: the file name (e.g. myFile.txt).
    // - `${activeEditorMedium}`: the path of the file relative to the workspace folder (e.g. myFolder/myFileFolder/myFile.txt).
    // - `${activeEditorLong}`: the full path of the file (e.g. /Users/Development/myFolder/myFileFolder/myFile.txt).
    // - `${activeFolderShort}`: the name of the folder the file is contained in (e.g. myFileFolder).
    // - `${activeFolderMedium}`: the path of the folder the file is contained in, relative to the workspace folder (e.g. myFolder/myFileFolder).
    // - `${activeFolderLong}`: the full path of the folder the file is contained in (e.g. /Users/Development/myFolder/myFileFolder).
    // - `${folderName}`: name of the workspace folder the file is contained in (e.g. myFolder).
    // - `${folderPath}`: file path of the workspace folder the file is contained in (e.g. /Users/Development/myFolder).
    // - `${rootName}`: name of the workspace with optional remote name and workspace indicator if applicable (e.g. myFolder, myRemoteFolder [SSH] or myWorkspace (Workspace)).
    // - `${rootNameShort}`: shortened name of the workspace without suffixes (e.g. myFolder, myRemoteFolder or myWorkspace).
    // - `${rootPath}`: file path of the opened workspace or folder (e.g. /Users/Development/myWorkspace).
    // - `${profileName}`: name of the profile in which the workspace is opened (e.g. Data Science (Profile)). Ignored if default profile is used.
    // - `${appName}`: e.g. VS Code.
    // - `${remoteName}`: e.g. SSH
    // - `${dirty}`: an indicator for when the active editor has unsaved changes.
    // - `${focusedView}`: the name of the view that is currently focused.
    // - `${activeRepositoryName}`: the name of the active repository (e.g. vscode).
    // - `${activeRepositoryBranchName}`: the name of the active branch in the active repository (e.g. main).
    // - `${activeEditorState}`: provides information about the state of the active editor (e.g. modified). This will be appended by default when in screen reader mode with `accessibility.windowTitleOptimized` enabled.
    // - `${separator}`: a conditional separator (" - ") that only shows when surrounded by variables with values or static text.
    "window.title": "${dirty}${activeEditorShort}${separator}${rootName}${separator}${profileName}${separator}${appName}",

    // Adjust the appearance of the window title bar to be native by the OS or custom. Changes require a full restart to apply.
    "window.titleBarStyle": "custom",

    // Separator used by `window.title`.
    "window.titleSeparator": " - ",

    // Adjust the default zoom level for all windows. Each increment above `0` (e.g. `1`) or below (e.g. `-1`) represents zooming `20%` larger or smaller. You can also enter decimals to adjust the zoom level with a finer granularity. See `window.zoomPerWindow` for configuring if the 'Zoom In' and 'Zoom Out' commands apply the zoom level to all windows or only the active window.
    "window.zoomLevel": 0,

    // Controls if the 'Zoom In' and 'Zoom Out' commands apply the zoom level to all windows or only the active window. See `window.zoomLevel` for configuring a default zoom level for all windows.
    "window.zoomPerWindow": true,

    // Files
    // Configure [glob patterns](https://aka.ms/vscode-glob-patterns) of file associations to languages (for example `"*.extension": "html"`). Patterns will match on the absolute path of a file if they contain a path separator and will match on the name of the file otherwise. These have precedence over the default associations of the languages installed.
    "files.associations": {},

    // When enabled, the editor will attempt to guess the character set encoding when opening files. This setting can also be configured per language. Note, this setting is not respected by text search. Only `files.encoding` is respected.
    "files.autoGuessEncoding": false,

    // Controls [auto save](https://code.visualstudio.com/docs/editor/codebasics#_save-auto-save) of editors that have unsaved changes.
    //  - off: An editor with changes is never automatically saved.
    //  - afterDelay: An editor with changes is automatically saved after the configured `files.autoSaveDelay`.
    //  - onFocusChange: An editor with changes is automatically saved when the editor loses focus.
    //  - onWindowChange: An editor with changes is automatically saved when the window loses focus.
    "files.autoSave": "off",

    // Controls the delay in milliseconds after which an editor with unsaved changes is saved automatically. Only applies when `files.autoSave` is set to `afterDelay`.
    "files.autoSaveDelay": 1000,

    // When enabled, will limit [auto save](https://code.visualstudio.com/docs/editor/codebasics#_save-auto-save) of editors to files that have no errors reported in them at the time the auto save is triggered. Only applies when `files.autoSave` is enabled.
    "files.autoSaveWhenNoErrors": false,

    // When enabled, will limit [auto save](https://code.visualstudio.com/docs/editor/codebasics#_save-auto-save) of editors to files that are inside the opened workspace. Only applies when `files.autoSave` is enabled.
    "files.autoSaveWorkspaceFilesOnly": false,

    // List of character set encodings that the editor should attempt to guess in the order they are listed. In case it cannot be determined, `files.encoding` is respected
    //  - utf8: UTF-8
    //  - utf16le: UTF-16 LE
    //  - utf16be: UTF-16 BE
    //  - windows1252: Western (Windows 1252)
    //  - windows1250: Central European (Windows 1250)
    //  - iso88592: Central European (ISO 8859-2)
    //  - windows1251: Cyrillic (Windows 1251)
    //  - cp866: Cyrillic (CP 866)
    //  - cp1125: Cyrillic (CP 1125)
    //  - iso88595: Cyrillic (ISO 8859-5)
    //  - koi8r: Cyrillic (KOI8-R)
    //  - windows1253: Greek (Windows 1253)
    //  - iso88597: Greek (ISO 8859-7)
    //  - windows1255: Hebrew (Windows 1255)
    //  - iso88598: Hebrew (ISO 8859-8)
    //  - cp950: Traditional Chinese (Big5)
    //  - shiftjis: Japanese (Shift JIS)
    //  - eucjp: Japanese (EUC-JP)
    //  - euckr: Korean (EUC-KR)
    //  - gb2312: Simplified Chinese (GB 2312)
    "files.candidateGuessEncodings": [],

    // The default language identifier that is assigned to new files. If configured to `${activeEditorLanguage}`, will use the language identifier of the currently active text editor if any.
    "files.defaultLanguage": "",

    // Default path for file dialogs, overriding user's home path. Only used in the absence of a context-specific path, such as most recently opened file or folder.
    "files.dialog.defaultPath": "",

    // Moves files/folders to the OS trash (recycle bin on Windows) when deleting. Disabling this will delete files/folders permanently.
    "files.enableTrash": true,

    // The default character set encoding to use when reading and writing files. This setting can also be configured per language.
    //  - utf8: UTF-8
    //  - utf8bom: UTF-8 with BOM
    //  - utf16le: UTF-16 LE
    //  - utf16be: UTF-16 BE
    //  - windows1252: Western (Windows 1252)
    //  - iso88591: Western (ISO 8859-1)
    //  - iso88593: Western (ISO 8859-3)
    //  - iso885915: Western (ISO 8859-15)
    //  - macroman: Western (Mac Roman)
    //  - cp437: DOS (CP 437)
    //  - windows1256: Arabic (Windows 1256)
    //  - iso88596: Arabic (ISO 8859-6)
    //  - windows1257: Baltic (Windows 1257)
    //  - iso88594: Baltic (ISO 8859-4)
    //  - iso885914: Celtic (ISO 8859-14)
    //  - windows1250: Central European (Windows 1250)
    //  - iso88592: Central European (ISO 8859-2)
    //  - cp852: Central European (CP 852)
    //  - windows1251: Cyrillic (Windows 1251)
    //  - cp866: Cyrillic (CP 866)
    //  - cp1125: Cyrillic (CP 1125)
    //  - iso88595: Cyrillic (ISO 8859-5)
    //  - koi8r: Cyrillic (KOI8-R)
    //  - koi8u: Cyrillic (KOI8-U)
    //  - iso885913: Estonian (ISO 8859-13)
    //  - windows1253: Greek (Windows 1253)
    //  - iso88597: Greek (ISO 8859-7)
    //  - windows1255: Hebrew (Windows 1255)
    //  - iso88598: Hebrew (ISO 8859-8)
    //  - iso885910: Nordic (ISO 8859-10)
    //  - iso885916: Romanian (ISO 8859-16)
    //  - windows1254: Turkish (Windows 1254)
    //  - iso88599: Turkish (ISO 8859-9)
    //  - windows1258: Vietnamese (Windows 1258)
    //  - gbk: Simplified Chinese (GBK)
    //  - gb18030: Simplified Chinese (GB18030)
    //  - cp950: Traditional Chinese (Big5)
    //  - big5hkscs: Traditional Chinese (Big5-HKSCS)
    //  - shiftjis: Japanese (Shift JIS)
    //  - eucjp: Japanese (EUC-JP)
    //  - euckr: Korean (EUC-KR)
    //  - windows874: Thai (Windows 874)
    //  - iso885911: Latin/Thai (ISO 8859-11)
    //  - koi8ru: Cyrillic (KOI8-RU)
    //  - koi8t: Tajik (KOI8-T)
    //  - gb2312: Simplified Chinese (GB 2312)
    //  - cp865: Nordic DOS (CP 865)
    //  - cp850: Western European DOS (CP 850)
    "files.encoding": "utf8",

    // The default end of line character.
    //  - \n: LF
    //  - \r\n: CRLF
    //  - auto: Uses operating system specific end of line character.
    "files.eol": "auto",

    // Configure [glob patterns](https://aka.ms/vscode-glob-patterns) for excluding files and folders. For example, the File Explorer decides which files and folders to show or hide based on this setting. Refer to the `search.exclude#` setting to define search-specific excludes. Refer to the `#explorer.excludeGitIgnore` setting for ignoring files based on your `.gitignore`.
    "files.exclude": {
        "**/.git": true,
        "**/.svn": true,
        "**/.hg": true,
        "**/.DS_Store": true,
        "**/Thumbs.db": true
    },

    // [Hot Exit](https://aka.ms/vscode-hot-exit) controls whether unsaved files are remembered between sessions, allowing the save prompt when exiting the editor to be skipped.
    //  - off: Disable hot exit. A prompt will show when attempting to close a window with editors that have unsaved changes.
    //  - onExit: Hot exit will be triggered when the last window is closed on Windows/Linux or when the `workbench.action.quit` command is triggered (command palette, keybinding, menu). All windows without folders opened will be restored upon next launch. A list of previously opened windows with unsaved files can be accessed via `File > Open Recent > More...`
    //  - onExitAndWindowClose: Hot exit will be triggered when the last window is closed on Windows/Linux or when the `workbench.action.quit` command is triggered (command palette, keybinding, menu), and also for any window with a folder opened regardless of whether it's the last window. All windows without folders opened will be restored upon next launch. A list of previously opened windows with unsaved files can be accessed via `File > Open Recent > More...`
    "files.hotExit": "onExit",

    // When enabled, insert a final new line at the end of the file when saving it.
    "files.insertFinalNewline": false,

    // Timeout in milliseconds after which file participants for create, rename, and delete are cancelled. Use `0` to disable participants.
    "files.participants.timeout": 60000,

    // Configure paths or [glob patterns](https://aka.ms/vscode-glob-patterns) to exclude from being marked as read-only if they match as a result of the `files.readonlyInclude` setting. Glob patterns are always evaluated relative to the path of the workspace folder unless they are absolute paths. Files from readonly file system providers will always be read-only independent of this setting.
    "files.readonlyExclude": {},

    // Marks files as read-only when their file permissions indicate as such. This can be overridden via `files.readonlyInclude#` and `#files.readonlyExclude` settings.
    "files.readonlyFromPermissions": false,

    // Configure paths or [glob patterns](https://aka.ms/vscode-glob-patterns) to mark as read-only. Glob patterns are always evaluated relative to the path of the workspace folder unless they are absolute paths. You can exclude matching paths via the `files.readonlyExclude` setting. Files from readonly file system providers will always be read-only independent of this setting.
    "files.readonlyInclude": {},

    // Controls if files that were part of a refactoring are saved automatically
    "files.refactoring.autoSave": true,

    // Restore the undo stack when a file is reopened.
    "files.restoreUndoStack": true,

    // A save conflict can occur when a file is saved to disk that was changed by another program in the meantime. To prevent data loss, the user is asked to compare the changes in the editor with the version on disk. This setting should only be changed if you frequently encounter save conflict errors and may result in data loss if used without caution.
    //  - askUser: Will refuse to save and ask for resolving the save conflict manually.
    //  - overwriteFileOnDisk: Will resolve the save conflict by overwriting the file on disk with the changes in the editor.
    "files.saveConflictResolution": "askUser",

    // Enables the simple file dialog for opening and saving files and folders. The simple file dialog replaces the system file dialog when enabled.
    "files.simpleDialog.enable": false,

    // When enabled, will trim all new lines after the final new line at the end of the file when saving it.
    "files.trimFinalNewlines": false,

    // When enabled, will trim trailing whitespace when saving a file.
    "files.trimTrailingWhitespace": false,

    // When enabled, trailing whitespace will be removed from multiline strings and regexes will be removed on save or when executing 'editor.action.trimTrailingWhitespace'. This can cause whitespace to not be trimmed from lines when there isn't up-to-date token information.
    "files.trimTrailingWhitespaceInRegexAndStrings": true,

    // Configure paths or [glob patterns](https://aka.ms/vscode-glob-patterns) to exclude from file watching. Paths can either be relative to the watched folder or absolute. Glob patterns are matched relative from the watched folder. When you experience the file watcher process consuming a lot of CPU, make sure to exclude large folders that are of less interest (such as build output folders).
    "files.watcherExclude": {
        "**/.git/objects/**": true,
        "**/.git/subtree-cache/**": true,
        "**/.hg/store/**": true
    },

    // Configure extra paths to watch for changes inside the workspace. By default, all workspace folders will be watched recursively, except for folders that are symbolic links. You can explicitly add absolute or relative paths to support watching folders that are symbolic links. Relative paths will be resolved to an absolute path using the currently opened workspace.
    "files.watcherInclude": [],

    // Screencast Mode
    // Controls the font size (in pixels) of the screencast mode keyboard.
    "screencastMode.fontSize": 56,

    // Options for customizing the keyboard overlay in screencast mode.
    "screencastMode.keyboardOptions": {
        "showKeys": true,
        "showKeybindings": true,
        "showCommands": true,
        "showCommandGroups": false,
        "showSingleEditorCursorMoves": true
    },

    // Controls how long (in milliseconds) the keyboard overlay is shown in screencast mode.
    "screencastMode.keyboardOverlayTimeout": 800,

    // Controls the color in hex (#RGB, #RGBA, #RRGGBB or #RRGGBBAA) of the mouse indicator in screencast mode.
    "screencastMode.mouseIndicatorColor": "#FF0000",

    // Controls the size (in pixels) of the mouse indicator in screencast mode.
    "screencastMode.mouseIndicatorSize": 20,

    // Controls the vertical offset of the screencast mode overlay from the bottom as a percentage of the workbench height.
    "screencastMode.verticalOffset": 20,

    // Zen Mode
    // Controls whether turning on Zen Mode also centers the layout.
    "zenMode.centerLayout": true,

    // Controls whether turning on Zen Mode also puts the workbench into full screen mode.
    "zenMode.fullScreen": true,

    // Controls whether turning on Zen Mode also hides the activity bar either at the left or right of the workbench.
    "zenMode.hideActivityBar": true,

    // Controls whether turning on Zen Mode also hides the editor line numbers.
    "zenMode.hideLineNumbers": true,

    // Controls whether turning on Zen Mode also hides the status bar at the bottom of the workbench.
    "zenMode.hideStatusBar": true,

    // Controls whether a window should restore to Zen Mode if it was exited in Zen Mode.
    "zenMode.restore": true,

    // Controls whether turning on Zen Mode should show multiple editor tabs, a single editor tab, or hide the editor title area completely.
    //  - multiple: Each editor is displayed as a tab in the editor title area.
    //  - single: The active editor is displayed as a single large tab in the editor title area.
    //  - none: The editor title area is not displayed.
    "zenMode.showTabs": "multiple",

    // Controls whether notifications do not disturb mode should be enabled while in Zen Mode. If true, only error notifications will pop out.
    "zenMode.silentNotifications": true,

    // File Explorer
    // Controls whether the Explorer should automatically open a file when it is dropped into the explorer
    "explorer.autoOpenDroppedFile": true,

    // Controls whether the Explorer should automatically reveal and select files when opening them.
    //  - true: Files will be revealed and selected.
    //  - false: Files will not be revealed and selected.
    //  - focusNoScroll: Files will not be scrolled into view, but will still be focused.
    "explorer.autoReveal": true,

    // Configure paths or [glob patterns](https://aka.ms/vscode-glob-patterns) for excluding files and folders from being revealed and selected in the Explorer when they are opened. Glob patterns are always evaluated relative to the path of the workspace folder unless they are absolute paths.
    "explorer.autoRevealExclude": {
        "**/node_modules": true,
        "**/bower_components": true
    },

    // Controls whether the Explorer should render folders in a compact form. In such a form, single child folders will be compressed in a combined tree element. Useful for Java package structures, for example.
    "explorer.compactFolders": true,

    // Controls whether the Explorer should ask for confirmation when deleting a file via the trash.
    "explorer.confirmDelete": true,

    // Controls whether the Explorer should ask for confirmation to move files and folders via drag and drop.
    "explorer.confirmDragAndDrop": true,

    // Controls whether the Explorer should ask for confirmation when pasting native files and folders.
    "explorer.confirmPasteNative": true,

    // Controls whether the Explorer should ask for confirmation when undoing.
    //  - verbose: Explorer will prompt before all undo operations.
    //  - default: Explorer will prompt before destructive undo operations.
    //  - light: Explorer will not prompt before undo operations when focused.
    "explorer.confirmUndo": "default",

    // The path separation character used when copying file paths.
    //  - /: Use slash as path separation character.
    //  - \: Use backslash as path separation character.
    //  - auto: Uses operating system specific path separation character.
    "explorer.copyPathSeparator": "auto",

    // The path separation character used when copying relative file paths.
    //  - /: Use slash as path separation character.
    //  - \: Use backslash as path separation character.
    //  - auto: Uses operating system specific path separation character.
    "explorer.copyRelativePathSeparator": "auto",

    // Controls whether file decorations should use badges.
    "explorer.decorations.badges": true,

    // Controls whether file decorations should use colors.
    "explorer.decorations.colors": true,

    // Controls whether the Explorer should allow to move files and folders via drag and drop. This setting only effects drag and drop from inside the Explorer.
    "explorer.enableDragAndDrop": true,

    // Controls whether the Explorer should support undoing file and folder operations.
    "explorer.enableUndo": true,

    // Controls whether entries in .gitignore should be parsed and excluded from the Explorer. Similar to `files.exclude`.
    "explorer.excludeGitIgnore": false,

    // Controls whether the Explorer should expand multi-root workspaces containing only one folder during initialization
    "explorer.expandSingleFolderWorkspaces": true,

    // Controls whether file nesting is enabled in the Explorer. File nesting allows for related files in a directory to be visually grouped together under a single parent file.
    "explorer.fileNesting.enabled": false,

    // Controls whether file nests are automatically expanded. `explorer.fileNesting.enabled` must be set for this to take effect.
    "explorer.fileNesting.expand": true,

    // Controls nesting of files in the Explorer. `explorer.fileNesting.enabled` must be set for this to take effect. Each __Item__ represents a parent pattern and may contain a single `*` character that matches any string. Each __Value__ represents a comma separated list of the child patterns that should be shown nested under a given parent. Child patterns may contain several special tokens:
    // - `${capture}`: Matches the resolved value of the `*` from the parent pattern
    // - `${basename}`: Matches the parent file's basename, the `file` in `file.ts`
    // - `${extname}`: Matches the parent file's extension, the `ts` in `file.ts`
    // - `${dirname}`: Matches the parent file's directory name, the `src` in `src/file.ts`
    // - `*`:  Matches any string, may only be used once per child pattern
    "explorer.fileNesting.patterns": {
        "*.ts": "${capture}.js",
        "*.js": "${capture}.js.map, ${capture}.min.js, ${capture}.d.ts",
        "*.jsx": "${capture}.js",
        "*.tsx": "${capture}.ts",
        "tsconfig.json": "tsconfig.*.json",
        "package.json": "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb, bun.lock"
    },

    // Controls which naming strategy to use when giving a new name to a duplicated Explorer item on paste.
    //  - simple: Appends the word "copy" at the end of the duplicated name potentially followed by a number.
    //  - smart: Adds a number at the end of the duplicated name. If some number is already part of the name, tries to increase that number.
    //  - disabled: Disables incremental naming. If two files with the same name exist you will be prompted to overwrite the existing file.
    "explorer.incrementalNaming": "simple",

    // The minimum number of editor slots pre-allocated in the Open Editors pane. If set to 0 the Open Editors pane will dynamically resize based on the number of editors.
    "explorer.openEditors.minVisible": 0,

    // Controls the sorting order of editors in the Open Editors pane.
    //  - editorOrder: Editors are ordered in the same order editor tabs are shown.
    //  - alphabetical: Editors are ordered alphabetically by tab name inside each editor group.
    //  - fullPath: Editors are ordered alphabetically by full path inside each editor group.
    "explorer.openEditors.sortOrder": "editorOrder",

    // The initial maximum number of editors shown in the Open Editors pane. Exceeding this limit will show a scroll bar and allow resizing the pane to display more items.
    "explorer.openEditors.visible": 9,

    // Controls the property-based sorting of files and folders in the Explorer. When `explorer.fileNesting.enabled` is enabled, also controls sorting of nested files.
    //  - default: Files and folders are sorted by their names. Folders are displayed before files.
    //  - mixed: Files and folders are sorted by their names. Files are interwoven with folders.
    //  - filesFirst: Files and folders are sorted by their names. Files are displayed before folders.
    //  - type: Files and folders are grouped by extension type then sorted by their names. Folders are displayed before files.
    //  - modified: Files and folders are sorted by last modified date in descending order. Folders are displayed before files.
    //  - foldersNestsFiles: Files and folders are sorted by their names. Folders are displayed before files. Files with nested children are displayed before other files.
    "explorer.sortOrder": "default",

    // Controls the lexicographic sorting of file and folder names in the Explorer.
    //  - default: Uppercase and lowercase names are mixed together.
    //  - upper: Uppercase names are grouped together before lowercase names.
    //  - lower: Lowercase names are grouped together before uppercase names.
    //  - unicode: Names are sorted in Unicode order.
    "explorer.sortOrderLexicographicOptions": "default",

    // Controls whether the file and folder sort order, should be reversed.
    "explorer.sortOrderReverse": false,

    // General
    // The appearance to use for the Draw.io editor. Use "automatic" to automatically choose a Draw.io theme that matches your current VS Code theme.
    "hediet.vscode-drawio.appearance": "light",

    // When activated, selecting a node will navigate to an associated code section.
    "hediet.vscode-drawio.codeLinkActivated": false,

    // Names for colors, eg. {‘FFFFFF’: ‘White’, ‘000000’: ‘Black’} that are used as tooltips (uppercase, no leading # for the colour codes)
    "hediet.vscode-drawio.colorNames": {},

    // Available color schemes in the style section at the top of the format panel. See example [here](https://www.diagrams.net/doc/faq/custom-colours-confluence-cloud#default-colour-schemes---format-panel)
    "hediet.vscode-drawio.customColorSchemes": [],

    // Configures the Draw.io editor to use custom fonts.
    "hediet.vscode-drawio.customFonts": [],

    // Configures the Draw.io editor to use custom libraries.
    "hediet.vscode-drawio.customLibraries": [],

    // Default styling of edges.
    "hediet.vscode-drawio.defaultEdgeStyle": {},

    // Default styling of vertices (shapes).
    "hediet.vscode-drawio.defaultVertexStyle": {},

    // Defines global variables for system-wide placeholders using a JSON structure with key, value pairs. Keep the number of global variables small.
    "hediet.vscode-drawio.globalVars": {},

    // List of allowed or denied plugins. The extension will read and write to this list based on what the used decides when loading specific plugins. See [plugins documentation](https://github.com/hediet/vscode-drawio/blob/master/docs/plugins.md).
    "hediet.vscode-drawio.knownPlugins": [],

    // Only change this property if you know what you are doing. Manual changes to this property are not supported!
    "hediet.vscode-drawio.local-storage": {},

    // When enabled, the bundled instance of Draw.io is used.
    "hediet.vscode-drawio.offline": true,

    // The app to use when offline mode is disabled.
    "hediet.vscode-drawio.online-url": "https://embed.diagrams.net/",

    // Loads Draw.io plugins from the local filesystem.  See description of the `file` property. See [plugins documentation](https://github.com/hediet/vscode-drawio/blob/master/docs/plugins.md).
    "hediet.vscode-drawio.plugins": [],

    // Color codes for the upper palette in the color dialog.
    "hediet.vscode-drawio.presetColors": [],

    // If set to true, images are resized automatically on paste. If not defined, the user will be asked to confirm the resize.
    "hediet.vscode-drawio.resizeImages": null,

    // When enabled, no ForeignObjects are used in the svg.
    "hediet.vscode-drawio.simpleLabels": false,

    // Defines an array of objects that contain the colours (fontColor, fillColor, strokeColor and gradientColor) for the Style tab of the format panel if the selection is empty. These objects can have a commonStyle (which is applied to both vertices and edges), vertexStyle (applied to vertices) and edgeStyle (applied to edges), and a graph with background and gridColor. An empty object means apply the default colors
    "hediet.vscode-drawio.styles": [],

    // The theme to use for the Draw.io editor. Use "automatic" to automatically choose a Draw.io theme that matches your current VS Code theme.
    "hediet.vscode-drawio.theme": "kennedy",

    // Defines the zoom factor for mouse wheel and trackpad zoom.
    "hediet.vscode-drawio.zoomFactor": 1.2,

    // Inline Blame
    // Specifies how to format absolute dates (e.g. using the `${date}` token) for the inline blame annotation, when not specified `gitlens.defaultDateFormat` is used. Use `full`, `long`, `medium`, `short`, or a custom format, e.g. `MMMM Do, YYYY h:mma`, similar to [Moment.js formats](https://momentjs.com/docs/#/displaying/format/)
    "gitlens.currentLine.dateFormat": null,

    // Specifies whether to provide an inline blame annotation for the current line, by default. Use the `Toggle Line Blame Annotations` command (`gitlens.toggleLineBlame`) to toggle the annotations on and off for the current window
    "gitlens.currentLine.enabled": true,

    // Specifies the font family of the inline blame annotation
    "gitlens.currentLine.fontFamily": "",

    // Specifies the font size of the inline blame annotation
    "gitlens.currentLine.fontSize": 0,

    // Specifies the font style of the inline blame annotation
    "gitlens.currentLine.fontStyle": "normal",

    // Specifies the font weight of the inline blame annotation
    "gitlens.currentLine.fontWeight": "normal",

    // Specifies the format of the inline blame annotation. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs. Date formatting is controlled by the `gitlens.currentLine.dateFormat` setting
    "gitlens.currentLine.format": "${author, }${agoOrDate}${' via  'pullRequest}${ • message|50?}",

    // Specifies whether to provide information about the Pull Request (if any) that introduced the commit in the inline blame annotation. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.currentLine.pullRequests.enabled": true,

    // Specifies whether the inline blame annotation can be scrolled into view when it is outside the viewport. **NOTE**: Setting this to `false` will inhibit the hovers from showing over the annotation; Set `gitlens.hovers.currentLine.over` to `line` to enable the hovers to show anywhere over the line.
    "gitlens.currentLine.scrollable": true,

    // Specifies the uncommitted changes format of the inline blame annotation. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs. Date formatting is controlled by the `gitlens.currentLine.dateFormat` setting.
    // 
    // **NOTE**: Setting this to an empty string will disable inline blame annotations for uncommitted changes.
    "gitlens.currentLine.uncommittedChangesFormat": null,

    // Git CodeLens
    // Specifies the command to be executed when an _authors_ CodeLens is clicked
    //  - false: Disables click interaction
    //  - gitlens.toggleFileBlame: Toggles file blame
    //  - gitlens.toggleFileHeatmap: Toggles file heatmap
    //  - gitlens.toggleFileChanges: Toggles file changes since before the commit
    //  - gitlens.toggleFileChangesOnly: Toggles file changes from the commit
    //  - gitlens.diffWithPrevious: Compares the current committed file with the previous commit
    //  - gitlens.revealCommitInView: Reveals the commit in the Side Bar
    //  - gitlens.showCommitsInView: Searches for commits within the range
    //  - gitlens.showQuickCommitDetails: Shows an Inspect quick pick menu
    //  - gitlens.showQuickCommitFileDetails: Shows a commit file details quick pick menu
    //  - gitlens.showQuickFileHistory: Shows a file history quick pick menu
    //  - gitlens.showQuickRepoHistory: Shows a branch history quick pick menu
    //  - gitlens.openCommitOnRemote: Opens the commit on the remote service (when available)
    //  - gitlens.copyRemoteCommitUrl: Copies the remote commit URL to the clipboard (when available)
    //  - gitlens.openFileOnRemote: Opens the file revision on the remote service (when available)
    //  - gitlens.copyRemoteFileUrl: Copies the remote file URL to the clipboard (when available)
    "gitlens.codeLens.authors.command": "gitlens.toggleFileBlame",

    // Specifies whether to provide an _authors_ CodeLens, showing number of authors of the file or code block and the most prominent author (if there is more than one)
    "gitlens.codeLens.authors.enabled": true,

    // Specifies how to format absolute dates in the Git CodeLens, when not specified `gitlens.defaultDateFormat` is used. Use `full`, `long`, `medium`, `short`, or a custom format, e.g. `MMMM Do, YYYY h:mma`, similar to [Moment.js formats](https://momentjs.com/docs/#/displaying/format/)
    "gitlens.codeLens.dateFormat": null,

    // Specifies whether to provide any Git CodeLens, by default. Use the `Toggle Git CodeLens` command (`gitlens.toggleCodeLens`) to toggle the Git CodeLens on and off for the current window
    "gitlens.codeLens.enabled": true,

    // Specifies whether to provide any Git CodeLens on symbols that span only a single line
    "gitlens.codeLens.includeSingleLineSymbols": false,

    // Specifies the command to be executed when a _recent change_ CodeLens is clicked
    //  - false: Disables click interaction
    //  - gitlens.toggleFileBlame: Toggles file blame
    //  - gitlens.toggleFileHeatmap: Toggles file heatmap
    //  - gitlens.toggleFileChanges: Toggles file changes since before the commit
    //  - gitlens.toggleFileChangesOnly: Toggles file changes from the commit
    //  - gitlens.diffWithPrevious: Compares the current committed file with the previous commit
    //  - gitlens.revealCommitInView: Reveals the commit in the Side Bar
    //  - gitlens.showCommitsInView: Shows the Inspect
    //  - gitlens.showQuickCommitDetails: Shows an Inspect quick pick menu
    //  - gitlens.showQuickCommitFileDetails: Shows a commit file details quick pick menu
    //  - gitlens.showQuickFileHistory: Shows a file history quick pick menu
    //  - gitlens.showQuickRepoHistory: Shows a branch history quick pick menu
    //  - gitlens.openCommitOnRemote: Opens the commit on the remote service (when available)
    //  - gitlens.copyRemoteCommitUrl: Copies the remote commit URL to the clipboard (when available)
    //  - gitlens.openFileOnRemote: Opens the file revision on the remote service (when available)
    //  - gitlens.copyRemoteFileUrl: Copies the remote file URL to the clipboard (when available)
    "gitlens.codeLens.recentChange.command": "gitlens.showQuickCommitFileDetails",

    // Specifies whether to provide a _recent change_ CodeLens, showing the author and date of the most recent commit for the file or code block
    "gitlens.codeLens.recentChange.enabled": true,

    // Specifies where Git CodeLens will be shown in the document
    //  - document: Adds CodeLens at the top of the document
    //  - containers: Adds CodeLens at the start of container-like symbols (modules, classes, interfaces, etc)
    //  - blocks: Adds CodeLens at the start of block-like symbols (functions, methods, etc) lines
    "gitlens.codeLens.scopes": [
        "document",
        "containers"
    ],

    // Deprecated. Use the per-language `gitlens.codeLens.scopes#` and `#gitlens.codeLens.symbolScopes` settings instead
    // 
    "gitlens.codeLens.scopesByLanguage": null,

    // Specifies a set of document symbols where Git CodeLens will or will not be shown in the document. Prefix with `!` to avoid providing a Git CodeLens for the symbol. Must be a member of `SymbolKind`
    "gitlens.codeLens.symbolScopes": [],

    // Specifies the string to be shown in place of the _authors_ CodeLens when there are unsaved changes
    "gitlens.strings.codeLens.unsavedChanges.authorsOnly": "$(ellipsis)",

    // Specifies the string to be shown in place of both the _recent change_ and _authors_ CodeLens when there are unsaved changes
    "gitlens.strings.codeLens.unsavedChanges.recentChangeAndAuthors": "$(ellipsis)",

    // Specifies the string to be shown in place of the _recent change_ CodeLens when there are unsaved changes
    "gitlens.strings.codeLens.unsavedChanges.recentChangeOnly": "$(ellipsis)",

    // Status Bar Blame
    // Specifies the blame alignment in the status bar
    //  - left: Aligns to the left
    //  - right: Aligns to the right
    "gitlens.statusBar.alignment": "right",

    // Specifies the command to be executed when the blame status bar item is clicked
    //  - gitlens.toggleFileBlame: Toggles file blame
    //  - gitlens.toggleFileHeatmap: Toggles file heatmap
    //  - gitlens.toggleFileChanges: Toggles file changes since before the commit
    //  - gitlens.toggleFileChangesOnly: Toggles file changes from the commit
    //  - gitlens.toggleCodeLens: Toggles Git CodeLens
    //  - gitlens.diffWithPrevious: Compares the current line commit with the previous
    //  - gitlens.diffWithWorking: Compares the current line commit with the working tree
    //  - gitlens.revealCommitInView: Reveals the commit in the Side Bar
    //  - gitlens.showCommitsInView: Shows the Inspect
    //  - gitlens.showQuickCommitDetails: Shows an Inspect quick pick menu
    //  - gitlens.showQuickCommitFileDetails: Shows a commit file details quick pick menu
    //  - gitlens.showQuickFileHistory: Shows a file history quick pick menu
    //  - gitlens.showQuickRepoHistory: Shows a branch history quick pick menu
    //  - gitlens.openCommitOnRemote: Opens the commit on the remote service (when available)
    //  - gitlens.copyRemoteCommitUrl: Copies the remote commit URL to the clipboard (when available)
    //  - gitlens.openFileOnRemote: Opens the file revision on the remote service (when available)
    //  - gitlens.copyRemoteFileUrl: Copies the remote file URL to the clipboard (when available)
    "gitlens.statusBar.command": "gitlens.showQuickCommitDetails",

    // Specifies how to format absolute dates (e.g. using the `${date}` token) in the blame information in the status bar, when not specified `gitlens.defaultDateFormat` is used. Use `full`, `long`, `medium`, `short`, or a custom format, e.g. `MMMM Do, YYYY h:mma`, similar to [Moment.js formats](https://momentjs.com/docs/#/displaying/format/)
    "gitlens.statusBar.dateFormat": null,

    // Specifies whether to provide blame information in the status bar
    "gitlens.statusBar.enabled": true,

    // Specifies the format of the blame information in the status bar. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs. Date formatting is controlled by the `gitlens.statusBar.dateFormat` setting
    "gitlens.statusBar.format": "${author}, ${agoOrDate}${' via  'pullRequest}",

    // Specifies whether to provide information about the Pull Request (if any) that introduced the commit in the status bar. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.statusBar.pullRequests.enabled": true,

    // Specifies whether to avoid clearing the previous blame information when changing lines to reduce status bar "flashing"
    "gitlens.statusBar.reduceFlicker": true,

    // Specifies the format (in markdown) of hover shown over the blame information in the status bar. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.statusBar.tooltipFormat": "${avatar} &nbsp;__${author}__ &nbsp;$(history) ${agoAndDateBothSources}${' via  'pullRequest} ${message}${\n\n---\n\nfootnotes}\n\n${commands}",

    // Hovers
    // Specifies whether to provide a _changes (diff)_ hover for all lines when showing blame annotations
    "gitlens.hovers.annotations.changes": true,

    // Specifies whether to provide a _commit details_ hover for all lines when showing blame annotations
    "gitlens.hovers.annotations.details": true,

    // Specifies whether to provide any hovers when showing blame annotations
    "gitlens.hovers.annotations.enabled": true,

    // Specifies when to trigger hovers when showing blame annotations
    //  - annotation: Only shown when hovering over the line annotation
    //  - line: Shown when hovering anywhere over the line
    "gitlens.hovers.annotations.over": "line",

    // Specifies whether to automatically link external resources in commit messages
    "gitlens.hovers.autolinks.enabled": true,

    // Specifies whether to lookup additional details about automatically link external resources in commit messages. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.hovers.autolinks.enhanced": true,

    // Specifies whether to show avatar images in hovers
    "gitlens.hovers.avatars": true,

    // Specifies the size of the avatar images in hovers
    "gitlens.hovers.avatarSize": 32,

    // Specifies whether to show just the changes to the line or the set of related changes in the _changes (diff)_ hover
    //  - line: Shows only the changes to the line
    //  - hunk: Shows the set of related changes
    "gitlens.hovers.changesDiff": "line",

    // Specifies whether to provide a _changes (diff)_ hover for the current line
    "gitlens.hovers.currentLine.changes": true,

    // Specifies whether to provide a _commit details_ hover for the current line
    "gitlens.hovers.currentLine.details": true,

    // Specifies whether to provide any hovers for the current line
    "gitlens.hovers.currentLine.enabled": true,

    // Specifies when to trigger hovers for the current line
    //  - annotation: Only shown when hovering over the line annotation
    //  - line: Shown when hovering anywhere over the line
    "gitlens.hovers.currentLine.over": "annotation",

    // Specifies the format (in markdown) of the _commit details_ hover. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.hovers.detailsMarkdownFormat": "${avatar} &nbsp;__${author}__ &nbsp;$(history) ${agoAndDateBothSources}${' via  'pullRequest} ${message}${\n\n---\n\nfootnotes}\n\n${commands}",

    // Specifies whether to provide any hovers
    "gitlens.hovers.enabled": true,

    // Specifies whether to provide information about the Pull Request (if any) that introduced the commit in the hovers. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.hovers.pullRequests.enabled": true,

    // Search
    // Controls the positioning of the actionbar on rows in the Search view.
    //  - auto: Position the actionbar to the right when the Search view is narrow, and immediately after the content when the Search view is wide.
    //  - right: Always position the actionbar to the right.
    "search.actionsPosition": "right",

    // Controls whether the search results will be collapsed or expanded.
    //  - auto: Files with less than 10 results are expanded. Others are collapsed.
    //  - alwaysCollapse
    //  - alwaysExpand
    "search.collapseResults": "alwaysExpand",

    // Controls whether search file decorations should use badges.
    "search.decorations.badges": true,

    // Controls whether search file decorations should use colors.
    "search.decorations.colors": true,

    // Controls the default search result view mode.
    //  - tree: Shows search results as a tree.
    //  - list: Shows search results as a list.
    "search.defaultViewMode": "list",

    // Configure [glob patterns](https://code.visualstudio.com/docs/editor/codebasics#_advanced-search-options) for excluding files and folders in fulltext searches and file search in quick open. To exclude files from the recently opened list in quick open, patterns must be absolute (for example `**/node_modules/**`). Inherits all glob patterns from the `files.exclude` setting.
    "search.exclude": {
        "**/node_modules": true,
        "**/bower_components": true,
        "**/*.code-search": true
    },

    // Show notebook editor rich content results for closed notebooks. Please refresh your search results after changing this setting.
    "search.experimental.closedNotebookRichContentResults": false,

    // Controls whether to follow symlinks while searching.
    "search.followSymlinks": true,

    // This setting is deprecated. You can drag the search icon to a new location instead.
    // Controls whether the search will be shown as a view in the sidebar or as a panel in the panel area for more horizontal space.
    "search.location": "sidebar",

    // The search cache is kept in the extension host which never shuts down, so this setting is no longer needed.
    // When enabled, the searchService process will be kept alive instead of being shut down after an hour of inactivity. This will keep the file search cache in memory.
    "search.maintainFileSearchCache": false,

    // Controls the maximum number of search results, this can be set to `null` (empty) to return unlimited results.
    "search.maxResults": 20000,

    // Controls where new `Search: Find in Files` and `Find in Folder` operations occur: either in the Search view, or in a search editor.
    //  - view: Search in the Search view, either in the panel or side bars.
    //  - reuseEditor: Search in an existing search editor if present, otherwise in a new search editor.
    //  - newEditor: Search in a new search editor.
    "search.mode": "view",

    // Controls whether the last typed input to Quick Search should be restored when opening it the next time.
    "search.quickAccess.preserveInput": false,

    // Controls sorting order of editor history in quick open when filtering.
    //  - default: History entries are sorted by relevance based on the filter value used. More relevant entries appear first.
    //  - recency: History entries are sorted by recency. More recently opened entries appear first.
    "search.quickOpen.history.filterSortOrder": "default",

    // Whether to include results from recently opened files in the file results for Quick Open.
    "search.quickOpen.includeHistory": true,

    // Whether to include results from a global symbol search in the file results for Quick Open.
    "search.quickOpen.includeSymbols": false,

    // Number of threads to use for searching. When set to 0, the engine automatically determines this value.
    "search.ripgrep.maxThreads": 0,

    // The default number of surrounding context lines to use when creating new Search Editors. If using `search.searchEditor.reusePriorSearchConfiguration`, this can be set to `null` (empty) to use the prior Search Editor's configuration.
    "search.searchEditor.defaultNumberOfContextLines": 1,

    // Configure effect of double-clicking a result in a search editor.
    //  - selectWord: Double-clicking selects the word under the cursor.
    //  - goToLocation: Double-clicking opens the result in the active editor group.
    //  - openLocationToSide: Double-clicking opens the result in the editor group to the side, creating one if it does not yet exist.
    "search.searchEditor.doubleClickBehaviour": "goToLocation",

    // When a search is triggered, focus the Search Editor results instead of the Search Editor input.
    "search.searchEditor.focusResultsOnSearch": false,

    // When enabled, new Search Editors will reuse the includes, excludes, and flags of the previously opened Search Editor.
    "search.searchEditor.reusePriorSearchConfiguration": false,

    // Configure effect of single-clicking a result in a search editor.
    //  - default: Single-clicking does nothing.
    //  - peekDefinition: Single-clicking opens a Peek Definition window.
    "search.searchEditor.singleClickBehaviour": "default",

    // Search all files as you type.
    "search.searchOnType": true,

    // When `search.searchOnType#` is enabled, controls the timeout in milliseconds between a character being typed and the search starting. Has no effect when `#search.searchOnType` is disabled.
    "search.searchOnTypeDebouncePeriod": 300,

    // Enable keyword suggestions in the Search view.
    "search.searchView.keywordSuggestions": false,

    // Controls the behavior of the semantic search results displayed in the Search view.
    //  - manual: Only request semantic search results manually.
    //  - runOnEmpty: Request semantic results automatically only when text search results are empty.
    //  - auto: Request semantic results automatically with every search.
    "search.searchView.semanticSearchBehavior": "manual",

    // Update the search query to the editor's selected text when focusing the Search view. This happens either on click or when triggering the `workbench.views.search.focus` command.
    "search.seedOnFocus": false,

    // Enable seeding search from the word nearest the cursor when the active editor has no selection.
    "search.seedWithNearestWord": false,

    // Controls whether to show line numbers for search results.
    "search.showLineNumbers": false,

    // Search case-insensitively if the pattern is all lowercase, otherwise, search case-sensitively.
    "search.smartCase": false,

    // Controls sorting order of search results.
    //  - default: Results are sorted by folder and file names, in alphabetical order.
    //  - fileNames: Results are sorted by file names ignoring folder order, in alphabetical order.
    //  - type: Results are sorted by file extensions, in alphabetical order.
    //  - modified: Results are sorted by file last modified date, in descending order.
    //  - countDescending: Results are sorted by count per file, in descending order.
    //  - countAscending: Results are sorted by count per file, in ascending order.
    "search.sortOrder": "default",

    // Controls whether to use your global gitignore file (for example, from `$HOME/.config/git/ignore`) when searching for files. Requires `search.useIgnoreFiles` to be enabled.
    "search.useGlobalIgnoreFiles": false,

    // Controls whether to use `.gitignore` and `.ignore` files when searching for files.
    "search.useIgnoreFiles": true,

    // Controls whether to use `.gitignore` and `.ignore` files in parent directories when searching for files. Requires `search.useIgnoreFiles` to be enabled.
    "search.useParentIgnoreFiles": false,

    // Deprecated. PCRE2 will be used automatically when using regex features that are only supported by PCRE2.
    // Whether to use the PCRE2 regex engine in text search. This enables using some advanced regex features like lookahead and backreferences. However, not all PCRE2 features are supported - only features that are also supported by JavaScript.
    "search.usePCRE2": false,

    // Controls whether to open Replace Preview when selecting or replacing a match.
    "search.useReplacePreview": true,

    // Deprecated. Consider "search.usePCRE2" for advanced regex feature support.
    // This setting is deprecated and now falls back on "search.usePCRE2".
    "search.useRipgrep": true,

    // File Annotations
    // Specifies the time (in milliseconds) to wait before re-blaming an unsaved document after an edit but before it is saved. Use 0 to specify an infinite wait. Only applies if the file is under the `gitlens.advanced.sizeThresholdAfterEdit`
    "gitlens.advanced.blame.delayAfterEdit": 5000,

    // Specifies the maximum document size (in lines) allowed to be re-blamed after an edit while still unsaved. Use 0 to specify no maximum
    "gitlens.advanced.blame.sizeThresholdAfterEdit": 5000,

    // Specifies whether the file annotations button in the editor title shows a menu or immediately toggles the specified file annotations
    //  - null: Shows a menu to choose which file annotations to toggle
    //  - blame: Toggles file blame annotations
    //  - heatmap: Toggles file heatmap annotations
    //  - changes: Toggles file changes annotations
    "gitlens.fileAnnotations.command": null,

    // Specifies whether pressing the `ESC` key dismisses the active file annotations
    "gitlens.fileAnnotations.dismissOnEscape": true,

    // Specifies whether file annotations will be preserved while editing. Use `gitlens.advanced.blame.delayAfterEdit` to control how long to wait before the annotation will update while the file is still dirty
    "gitlens.fileAnnotations.preserveWhileEditing": true,

    // File Blame
    // Specifies whether to show avatar images in the file blame annotations
    "gitlens.blame.avatars": true,

    // Specifies whether to compact (deduplicate) matching adjacent file blame annotations
    "gitlens.blame.compact": true,

    // Specifies how to format absolute dates (e.g. using the `${date}` token) in file blame annotations, when not specified `gitlens.defaultDateFormat` is used. Use `full`, `long`, `medium`, `short`, or a custom format, e.g. `MMMM Do, YYYY h:mma`, similar to [Moment.js formats](https://momentjs.com/docs/#/displaying/format/)
    "gitlens.blame.dateFormat": null,

    // Specifies the font family of the file blame annotations
    "gitlens.blame.fontFamily": "",

    // Specifies the font size of the file blame annotations
    "gitlens.blame.fontSize": 0,

    // Specifies the font style of the file blame annotations
    "gitlens.blame.fontStyle": "normal",

    // Specifies the font weight of the file blame annotations
    "gitlens.blame.fontWeight": "normal",

    // Specifies the format of the file blame annotations. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs. Date formatting is controlled by the `gitlens.blame.dateFormat` setting
    "gitlens.blame.format": "${message|50?} ${agoOrDate|14-}",

    // Specifies whether to provide a heatmap indicator in the file blame annotations
    "gitlens.blame.heatmap.enabled": true,

    // Specifies where the heatmap indicators will be shown in the file blame annotations
    //  - left: Adds a heatmap indicator on the left edge of the file blame annotations
    //  - right: Adds a heatmap indicator on the right edge of the file blame annotations
    "gitlens.blame.heatmap.location": "right",

    // Specifies whether to highlight lines associated with the current line
    "gitlens.blame.highlight.enabled": true,

    // Specifies where the associated line highlights will be shown
    //  - gutter: Adds an indicator to the gutter
    //  - line: Adds a full-line highlight background color
    //  - overview: Adds an indicator to the scroll bar
    "gitlens.blame.highlight.locations": [
        "gutter",
        "line",
        "overview"
    ],

    // Specifies whether file blame annotations will be separated by a small gap
    "gitlens.blame.separateLines": true,

    // Specifies how the file blame annotations will be toggled
    //  - file: Toggles each file individually
    //  - window: Toggles the window, i.e. all files at once
    "gitlens.blame.toggleMode": "file",

    // HTTP
    // Controls whether use of Electron's fetch implementation instead of Node.js' should be enabled. All local extensions will get Electron's fetch implementation for the global fetch API.
    "http.electronFetch": false,

    // Controls the interval in seconds for checking network interface changes to invalidate the proxy cache. Set to -1 to disable. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.experimental.networkInterfaceCheckInterval": 300,

    // Controls whether experimental loading of CA certificates from the OS should be enabled. This uses a more general approach than the default implementation. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.experimental.systemCertificatesV2": false,

    // Controls whether Node.js' fetch implementation should be extended with additional support. Currently proxy support (`http.proxySupport#`) and system certificates (`#http.systemCertificates#`) are added when the corresponding settings are enabled. When during [remote development](https://aka.ms/vscode-remote) the `#http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.fetchAdditionalSupport": true,

    // Specifies domain names for which proxy settings should be ignored for HTTP/HTTPS requests. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.noProxy": [],

    // The proxy setting to use. If not set, will be inherited from the `http_proxy` and `https_proxy` environment variables. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.proxy": "",

    // The value to send as the `Proxy-Authorization` header for every network request. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.proxyAuthorization": null,

    // Overrides the principal service name for Kerberos authentication with the HTTP proxy. A default based on the proxy hostname is used when this is not set. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.proxyKerberosServicePrincipal": "",

    // Controls whether the proxy server certificate should be verified against the list of supplied CAs. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.proxyStrictSSL": true,

    // Use the proxy support for extensions. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    //  - off: Disable proxy support for extensions.
    //  - on: Enable proxy support for extensions.
    //  - fallback: Enable proxy support for extensions, fall back to request options, when no proxy found.
    //  - override: Enable proxy support for extensions, override request options.
    "http.proxySupport": "override",

    // Controls whether CA certificates should be loaded from the OS. On Windows and macOS, a reload of the window is required after turning this off. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.systemCertificates": true,

    // Controls whether system certificates should be loaded using Node.js built-in support. Reload the window after changing this setting. When during [remote development](https://aka.ms/vscode-remote) the `http.useLocalProxyConfiguration` setting is disabled this setting can be configured in the local and the remote settings separately.
    "http.systemCertificatesNode": false,

    // Controls whether in the remote extension host the local proxy configuration should be used. This setting only applies as a remote setting during [remote development](https://aka.ms/vscode-remote).
    "http.useLocalProxyConfiguration": true,

    // Keyboard
    // Controls if the AltGraph+ modifier should be treated as Ctrl+Alt+.
    "keyboard.mapAltGrToCtrlAlt": false,

    // Update
    // This setting is deprecated, please use 'update.mode' instead.
    // Configure whether you receive automatic updates. Requires a restart after change. The updates are fetched from a Microsoft online service.
    "update.channel": "default",

    // Enable to download and install new VS Code versions in the background on Windows.
    "update.enableWindowsBackgroundUpdates": true,

    // Configure whether you receive automatic updates. Requires a restart after change. The updates are fetched from a Microsoft online service.
    //  - none: Disable updates.
    //  - manual: Disable automatic background update checks. Updates will be available if you manually check for updates.
    //  - start: Check for updates only on startup. Disable automatic background update checks.
    //  - default: Enable automatic update checks. Code will check for updates automatically and periodically.
    "update.mode": "default",

    // Show Release Notes after an update. The Release Notes are fetched from a Microsoft online service.
    "update.showReleaseNotes": true,

    // File Changes
    // Specifies where the indicators of the file changes annotations will be shown
    //  - gutter: Adds an indicator to the gutter
    //  - line: Adds a full-line highlight background color
    //  - overview: Adds an indicator to the scroll bar
    "gitlens.changes.locations": [
        "gutter",
        "line",
        "overview"
    ],

    // Specifies how the file changes annotations will be toggled
    //  - file: Toggles each file individually
    //  - window: Toggles the window, i.e. all files at once
    "gitlens.changes.toggleMode": "file",

    // File Heatmap
    // Specifies the age of the most recent change (in days) after which the file heatmap annotations will be cold rather than hot (i.e. will use `gitlens.heatmap.coldColor#` instead of `#gitlens.heatmap.hotColor`)
    "gitlens.heatmap.ageThreshold": 90,

    // Specifies the base color of the file heatmap annotations when the most recent change is older (cold) than the `gitlens.heatmap.ageThreshold` value
    "gitlens.heatmap.coldColor": "#0a60f6",

    // Specifies the whether to fade out older lines
    "gitlens.heatmap.fadeLines": true,

    // Specifies the base color of the file heatmap annotations when the most recent change is newer (hot) than the `gitlens.heatmap.ageThreshold` value
    "gitlens.heatmap.hotColor": "#f66a0a",

    // Specifies where the indicators of the file heatmap annotations will be shown
    //  - gutter: Adds an indicator to the gutter
    //  - line: Adds a full-line highlight background color
    //  - overview: Adds an indicator to the scroll bar
    "gitlens.heatmap.locations": [
        "gutter",
        "overview"
    ],

    // Specifies how the file heatmap annotations will be toggled
    //  - file: Toggles each file individually
    //  - window: Toggles the window, i.e. all files at once
    "gitlens.heatmap.toggleMode": "file",

    // Comments
    // Controls whether the comment thread should collapse when the thread is resolved.
    "comments.collapseOnResolve": true,

    // Controls whether the comments widget scrolls or expands.
    "comments.maxHeight": true,

    // This setting is deprecated in favor of `comments.openView`.
    // Controls when the comments panel should open.
    "comments.openPanel": "openOnSessionStartWithComments",

    // Controls when the comments view should open.
    //  - never: The comments view will never be opened.
    //  - file: The comments view will open when a file with comments is active.
    //  - firstFile: If the comments view has not been opened yet during this session it will open the first time during a session that a file with comments is active.
    //  - firstFileUnresolved: If the comments view has not been opened yet during this session and the comment is not resolved, it will open the first time during a session that a file with comments is active.
    "comments.openView": "firstFile",

    // Controls whether a confirmation dialog is shown when collapsing a comment thread.
    //  - whenHasUnsubmittedComments: Show a confirmation dialog when collapsing a comment thread with unsubmitted comments.
    //  - never: Never show a confirmation dialog when collapsing a comment thread.
    "comments.thread.confirmOnCollapse": "whenHasUnsubmittedComments",

    // Determines if relative time will be used in comment timestamps (ex. '1 day ago').
    "comments.useRelativeTime": true,

    // Controls the visibility of the comments bar and comment threads in editors that have commenting ranges and comments. Comments are still accessible via the Comments view and will cause commenting to be toggled on in the same way running the command "Comments: Toggle Editor Commenting" toggles comments.
    "comments.visible": true,

    // Debug
    // Allow setting breakpoints in any file.
    "debug.allowBreakpointsEverywhere": false,

    // Controls whether variables that are lazily resolved, such as getters, are automatically resolved and expanded by the debugger.
    //  - auto: When in screen reader optimized mode, automatically expand lazy variables.
    //  - on: Always automatically expand lazy variables.
    //  - off: Never automatically expand lazy variables.
    "debug.autoExpandLazyVariables": "auto",

    // At the end of a debug session, all the read-only tabs associated with that session will be closed
    "debug.closeReadonlyTabsOnEnd": false,

    // Controls whether to confirm when the window closes if there are active debug sessions.
    //  - never: Never confirm.
    //  - always: Always confirm if there are debug sessions.
    "debug.confirmOnExit": "never",

    // Controls whether suggestions should be accepted on Enter in the Debug Console. Enter is also used to evaluate whatever is typed in the Debug Console.
    "debug.console.acceptSuggestionOnEnter": "off",

    // Controls if the Debug Console should be automatically closed when the debug session ends.
    "debug.console.closeOnEnd": false,

    // Controls if the Debug Console should collapse identical lines and show a number of occurrences with a badge.
    "debug.console.collapseIdenticalLines": true,

    // Controls the font family in the Debug Console.
    "debug.console.fontFamily": "default",

    // Controls the font size in pixels in the Debug Console.
    "debug.console.fontSize": 14,

    // Controls if the Debug Console should suggest previously typed input.
    "debug.console.historySuggestions": true,

    // Controls the line height in pixels in the Debug Console. Use 0 to compute the line height from the font size.
    "debug.console.lineHeight": 0,

    // Controls the maximum number of lines in the Debug Console.
    "debug.console.maximumLines": 10000,

    // Controls if the lines should wrap in the Debug Console.
    "debug.console.wordWrap": true,

    // Show Source Code in Disassembly View.
    "debug.disassemblyView.showSourceCode": true,

    // Color of the status bar when the debugger is active.
    "debug.enableStatusBarColor": true,

    // Controls whether the editor should be focused when the debugger breaks.
    "debug.focusEditorOnBreak": true,

    // Controls whether the workbench window should be focused when the debugger breaks.
    "debug.focusWindowOnBreak": true,

    // Controls the action to perform when clicking the editor gutter with the middle mouse button.
    //  - logpoint: Add Logpoint.
    //  - conditionalBreakpoint: Add Conditional Breakpoint.
    //  - triggeredBreakpoint: Add Triggered Breakpoint.
    //  - none: Don't perform any action.
    "debug.gutterMiddleClickAction": "logpoint",

    // Hide 'Start Debugging' control in title bar of 'Run and Debug' view while debugging is active. Only relevant when `debug.toolBarLocation` is not `docked`.
    "debug.hideLauncherWhileDebugging": false,

    // Hide the warning shown when a `preLaunchTask` has been running for a while.
    "debug.hideSlowPreLaunchWarning": false,

    // Show variable values inline in editor while debugging.
    //  - on: Always show variable values inline in editor while debugging.
    //  - off: Never show variable values inline in editor while debugging.
    //  - auto: Show variable values inline in editor while debugging when the language supports inline value locations.
    "debug.inlineValues": "auto",

    // Controls when the internal Debug Console should open.
    "debug.internalConsoleOptions": "openOnFirstSessionStart",

    // Controls what to do when errors are encountered after running a preLaunchTask.
    //  - debugAnyway: Ignore task errors and start debugging.
    //  - showErrors: Show the Problems view and do not start debugging.
    //  - prompt: Prompt user.
    //  - abort: Cancel debugging.
    "debug.onTaskErrors": "prompt",

    // Controls when the debug view should open.
    "debug.openDebug": "openOnDebugBreak",

    // Automatically open the explorer view at the end of a debug session.
    "debug.openExplorerOnEnd": false,

    // Controls what editors to save before starting a debug session.
    //  - allEditorsInActiveGroup: Save all editors in the active group before starting a debug session.
    //  - nonUntitledEditorsInActiveGroup: Save all editors in the active group except untitled ones before starting a debug session.
    //  - none: Don't save any editors before starting a debug session.
    "debug.saveBeforeStart": "allEditorsInActiveGroup",

    // Controls whether breakpoints should be shown in the overview ruler.
    "debug.showBreakpointsInOverviewRuler": false,

    // Controls whether inline breakpoints candidate decorations should be shown in the editor while debugging.
    "debug.showInlineBreakpointCandidates": true,

    // Controls when the debug status bar item should be visible.
    //  - never: Never show debug item in status bar
    //  - always: Always show debug item in status bar
    //  - onFirstSessionStart: Show debug item in status bar only after debug was started for the first time
    "debug.showInStatusBar": "onFirstSessionStart",

    // Controls whether the debug sub-sessions are shown in the debug tool bar. When this setting is false the stop command on a sub-session will also stop the parent session.
    "debug.showSubSessionsInToolBar": false,

    // Show variable type in variable pane during debug session
    "debug.showVariableTypes": false,

    // Before starting a new debug session in an integrated or external terminal, clear the terminal.
    "debug.terminal.clearBeforeReusing": false,

    // Controls the location of the debug toolbar. Either `floating` in all views, `docked` in the debug view, `commandCenter` (requires `window.commandCenter`), or `hidden`.
    //  - floating: Show debug toolbar in all views.
    //  - docked: Show debug toolbar only in debug views.
    //  - commandCenter: `(Experimental)` Show debug toolbar in the command center.
    //  - hidden: Do not show debug toolbar.
    "debug.toolBarLocation": "floating",

    // Global debug launch configuration. Should be used as an alternative to 'launch.json' that is shared across workspaces.
    "launch": {
        "configurations": [],
        "compounds": []
    },

    // HTML
    // Enable/disable autoclosing of HTML tags.
    "html.autoClosingTags": true,

    // Enable/disable auto creation of quotes for HTML attribute assignment. The type of quotes can be configured by `html.completion.attributeDefaultValue`.
    "html.autoCreateQuotes": true,

    // Controls the default value for attributes when completion is accepted.
    //  - doublequotes: Attribute value is set to "".
    //  - singlequotes: Attribute value is set to ''.
    //  - empty: Attribute value is not set.
    "html.completion.attributeDefaultValue": "doublequotes",

    // A list of relative file paths pointing to JSON files following the [custom data format](https://github.com/microsoft/vscode-html-languageservice/blob/master/docs/customData.md).
    // 
    // VS Code loads custom data on startup to enhance its HTML support for the custom HTML tags, attributes and attribute values you specify in the JSON files.
    // 
    // The file paths are relative to workspace and only workspace folder settings are considered.
    "html.customData": [],

    // List of tags, comma separated, where the content shouldn't be reformatted. `null` defaults to the `pre` tag.
    "html.format.contentUnformatted": "pre,code,textarea",

    // Enable/disable default HTML formatter.
    "html.format.enable": true,

    // List of tags, comma separated, that should have an extra newline before them. `null` defaults to `"head, body, /html"`.
    "html.format.extraLiners": "head, body, /html",

    // Format and indent `{{#foo}}` and `{{/foo}}`.
    "html.format.indentHandlebars": false,

    // Indent `<head>` and `<body>` sections.
    "html.format.indentInnerHtml": false,

    // Maximum number of line breaks to be preserved in one chunk. Use `null` for unlimited.
    "html.format.maxPreserveNewLines": null,

    // Controls whether existing line breaks before elements should be preserved. Only works before elements, not inside tags or for text.
    "html.format.preserveNewLines": true,

    // Honor django, erb, handlebars and php templating language tags.
    "html.format.templating": false,

    // List of tags, comma separated, that shouldn't be reformatted. `null` defaults to all tags listed at https://www.w3.org/TR/html5/dom.html#phrasing-content.
    "html.format.unformatted": "wbr",

    // Keep text content together between this string.
    "html.format.unformattedContentDelimiter": "",

    // Wrap attributes.
    //  - auto: Wrap attributes only when line length is exceeded.
    //  - force: Wrap each attribute except first.
    //  - force-aligned: Wrap each attribute except first and keep aligned.
    //  - force-expand-multiline: Wrap each attribute.
    //  - aligned-multiple: Wrap when line length is exceeded, align attributes vertically.
    //  - preserve: Preserve wrapping of attributes.
    //  - preserve-aligned: Preserve wrapping of attributes but align.
    "html.format.wrapAttributes": "auto",

    // Indent wrapped attributes to after N characters. Use `null` to use the default indent size. Ignored if `html.format.wrapAttributes` is set to `aligned`.
    "html.format.wrapAttributesIndentSize": null,

    // Maximum amount of characters per line (0 = disable).
    "html.format.wrapLineLength": 120,

    // Show tag and attribute documentation in hover.
    "html.hover.documentation": true,

    // Show references to MDN in hover.
    "html.hover.references": true,

    // Deprecated in favor of `editor.linkedEditing`
    // Enable/disable mirroring cursor on matching HTML tag.
    "html.mirrorCursorOnMatchingTag": false,

    // Controls whether the built-in HTML language support suggests closing tags. When disabled, end tag completions like `</div>` will not be shown.
    "html.suggest.hideEndTagSuggestions": false,

    // Controls whether the built-in HTML language support suggests HTML5 tags, properties and values.
    "html.suggest.html5": true,

    // Traces the communication between VS Code and the HTML language server.
    "html.trace.server": "off",

    // Controls whether the built-in HTML language support validates embedded scripts.
    "html.validate.scripts": true,

    // Controls whether the built-in HTML language support validates embedded styles.
    "html.validate.styles": true,

    // JSON
    // The setting `json.colorDecorators.enable` has been deprecated in favor of `editor.colorDecorators`.
    // Enables or disables color decorators
    "json.colorDecorators.enable": true,

    // Enable/disable default JSON formatter
    "json.format.enable": true,

    // Keep all existing new lines when formatting.
    "json.format.keepLines": false,

    // The maximum number of outline symbols and folding regions computed (limited for performance reasons).
    "json.maxItemsComputed": 5000,

    // When enabled, JSON schemas can be fetched from http and https locations.
    "json.schemaDownload.enable": true,

    // Associate schemas to JSON files in the current project.
    "json.schemas": [],

    // Traces the communication between VS Code and the JSON language server.
    "json.trace.server": "off",

    // Enable/disable JSON validation.
    "json.validate.enable": true,

    // Markdown
    // Configures the path and file name of files created by copy/paste or drag and drop. This is a map of globs that match against a Markdown document path to the destination path where the new file should be created.
    // 
    // The destination path may use the following variables:
    // 
    // - `${documentDirName}` — Absolute parent directory path of the Markdown document, e.g. `/Users/me/myProject/docs`.
    // - `${documentRelativeDirName}` — Relative parent directory path of the Markdown document, e.g. `docs`. This is the same as `${documentDirName}` if the file is not part of a workspace.
    // - `${documentFileName}` — The full filename of the Markdown document, e.g. `README.md`.
    // - `${documentBaseName}` — The basename of the Markdown document, e.g. `README`.
    // - `${documentExtName}` — The extension of the Markdown document, e.g. `md`.
    // - `${documentFilePath}` — Absolute path of the Markdown document, e.g. `/Users/me/myProject/docs/README.md`.
    // - `${documentRelativeFilePath}` — Relative path of the Markdown document, e.g. `docs/README.md`. This is the same as `${documentFilePath}` if the file is not part of a workspace.
    // - `${documentWorkspaceFolder}` — The workspace folder for the Markdown document, e.g. `/Users/me/myProject`. This is the same as `${documentDirName}` if the file is not part of a workspace.
    // - `${fileName}` — The file name of the dropped file, e.g. `image.png`.
    // - `${fileExtName}` — The extension of the dropped file, e.g. `png`.
    // - `${unixTime}` — The current Unix timestamp in milliseconds.
    // - `${isoTime}` — The current time in ISO 8601 format, e.g. '2025-06-06T08:40:32.123Z'.
    "markdown.copyFiles.destination": {},

    // Controls if files created by drop or paste should overwrite existing files.
    //  - nameIncrementally: If a file with the same name already exists, append a number to the file name, for example: `image.png` becomes `image-1.png`.
    //  - overwrite: If a file with the same name already exists, overwrite it.
    "markdown.copyFiles.overwriteBehavior": "nameIncrementally",

    // Controls if files outside of the workspace that are dropped into a Markdown editor should be copied into the workspace.
    // 
    // Use `markdown.copyFiles.destination` to configure where copied dropped files should be created
    //  - mediaFiles: Try to copy external image and video files into the workspace.
    //  - never: Do not copy external files into the workspace.
    "markdown.editor.drop.copyIntoWorkspace": "mediaFiles",

    // Enable dropping files into a Markdown editor while holding Shift. Requires enabling `editor.dropIntoEditor.enabled`.
    //  - always: Always insert Markdown links.
    //  - smart: Smartly create Markdown links by default when not dropping into a code block or other special element. Use the drop widget to switch between pasting as plain text or as Markdown links.
    //  - never: Never create Markdown links.
    "markdown.editor.drop.enabled": "smart",

    // Snippet used when adding audio to Markdown. This snippet can use the following variables:
    // - `${src}` — The resolved path of the audio  file.
    // - `${title}` — The title used for the audio. A snippet placeholder will automatically be created for this variable.
    "markdown.editor.filePaste.audioSnippet": "<audio controls src=\"${src}\" title=\"${title}\"></audio>",

    // Controls if files outside of the workspace that are pasted into a Markdown editor should be copied into the workspace.
    // 
    // Use `markdown.copyFiles.destination` to configure where copied files should be created.
    //  - mediaFiles: Try to copy external image and video files into the workspace.
    //  - never: Do not copy external files into the workspace.
    "markdown.editor.filePaste.copyIntoWorkspace": "mediaFiles",

    // Enable pasting files into a Markdown editor to create Markdown links. Requires enabling `editor.pasteAs.enabled`.
    //  - always: Always insert Markdown links.
    //  - smart: Smartly create Markdown links by default when not pasting into a code block or other special element. Use the paste widget to switch between pasting as plain text or as Markdown links.
    //  - never: Never create Markdown links.
    "markdown.editor.filePaste.enabled": "smart",

    // Snippet used when adding videos to Markdown. This snippet can use the following variables:
    // - `${src}` — The resolved path of the video file.
    // - `${title}` — The title used for the video. A snippet placeholder will automatically be created for this variable.
    "markdown.editor.filePaste.videoSnippet": "<video controls src=\"${src}\" title=\"${title}\"></video>",

    // Controls if Markdown links are created when URLs are pasted into a Markdown editor. Requires enabling `editor.pasteAs.enabled`.
    //  - always: Always insert Markdown links.
    //  - smart: Smartly create Markdown links by default when not pasting into a code block or other special element. Use the paste widget to switch between pasting as plain text or as Markdown links.
    //  - smartWithSelection: Smartly create Markdown links by default when you have selected text and are not pasting into a code block or other special element. Use the paste widget to switch between pasting as plain text or as Markdown links.
    //  - never: Never create Markdown links.
    "markdown.editor.pasteUrlAsFormattedLink.enabled": "smartWithSelection",

    // Enable/disable a paste option that updates links and reference in text that is copied and pasted between Markdown editors.
    // 
    // To use this feature, after pasting text that contains updatable links, just click on the Paste Widget and select `Paste and update pasted links`.
    "markdown.editor.updateLinksOnPaste.enabled": true,

    // Controls where links in Markdown files should be opened.
    //  - currentGroup: Open links in the active editor group.
    //  - beside: Open links beside the active editor.
    "markdown.links.openLocation": "currentGroup",

    // Enable highlighting link occurrences in the current document.
    "markdown.occurrencesHighlight.enabled": false,

    // Controls if file extensions (for example `.md`) are added or not for links to Markdown files. This setting is used when file paths are added by tooling such as path completions or file renames.
    //  - auto: For existing paths, try to maintain the file extension style. For new paths, add file extensions.
    //  - includeExtension: Prefer including the file extension. For example, path completions to a file named `file.md` will insert `file.md`.
    //  - removeExtension: Prefer removing the file extension. For example, path completions to a file named `file.md` will insert `file` without the `.md`.
    "markdown.preferredMdPathExtensionStyle": "auto",

    // Sets how line-breaks are rendered in the Markdown preview. Setting it to `true` creates a `<br>` for newlines inside paragraphs.
    "markdown.preview.breaks": false,

    // Double-click in the Markdown preview to switch to the editor.
    "markdown.preview.doubleClickToSwitchToEditor": true,

    // Controls the font family used in the Markdown preview.
    "markdown.preview.fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe WPC', 'Segoe UI', system-ui, 'Ubuntu', 'Droid Sans', sans-serif",

    // Controls the font size in pixels used in the Markdown preview.
    "markdown.preview.fontSize": 14,

    // Controls the line height used in the Markdown preview. This number is relative to the font size.
    "markdown.preview.lineHeight": 1.6,

    // Convert URL-like text to links in the Markdown preview.
    "markdown.preview.linkify": true,

    // Mark the current editor selection in the Markdown preview.
    "markdown.preview.markEditorSelection": true,

    // Controls how links to other Markdown files in the Markdown preview should be opened.
    //  - inPreview: Try to open links in the Markdown preview.
    //  - inEditor: Try to open links in the editor.
    "markdown.preview.openMarkdownLinks": "inPreview",

    // When a Markdown preview is scrolled, update the view of the editor.
    "markdown.preview.scrollEditorWithPreview": true,

    // When a Markdown editor is scrolled, update the view of the preview.
    "markdown.preview.scrollPreviewWithEditor": true,

    // Enable some language-neutral replacement and quotes beautification in the Markdown preview.
    "markdown.preview.typographer": false,

    // Controls the logging level of the Markdown language server.
    "markdown.server.log": "off",

    // A list of URLs or local paths to CSS style sheets to use from the Markdown preview. Relative paths are interpreted relative to the folder open in the Explorer. If there is no open folder, they are interpreted relative to the location of the Markdown file. All '\' need to be written as '\\'.
    "markdown.styles": [],

    // Enable path suggestions while writing links in Markdown files.
    "markdown.suggest.paths.enabled": true,

    // Enable suggestions for headers in other Markdown files in the current workspace. Accepting one of these suggestions inserts the full path to header in that file, for example: `[link text](/path/to/file.md#header)`.
    //  - never: Disable workspace header suggestions.
    //  - onDoubleHash: Enable workspace header suggestions after typing `#` in a path, for example: `[link text](#`.
    //  - onSingleOrDoubleHash: Enable workspace header suggestions after typing either `#` or `#` in a path, for example: `[link text](#` or `[link text](#`.
    "markdown.suggest.paths.includeWorkspaceHeaderCompletions": "onDoubleHash",

    // Traces the communication between VS Code and the Markdown language server.
    "markdown.trace.server": "off",

    // Try to update links in Markdown files when a file is renamed/moved in the workspace. Use `markdown.updateLinksOnFileMove.include` to configure which files trigger link updates.
    //  - prompt: Prompt on each file move.
    //  - always: Always update links automatically.
    //  - never: Never try to update link and don't prompt.
    "markdown.updateLinksOnFileMove.enabled": "never",

    // Enable updating links when a directory is moved or renamed in the workspace.
    "markdown.updateLinksOnFileMove.enableForDirectories": true,

    // Glob patterns that specifies files that trigger automatic link updates. See `markdown.updateLinksOnFileMove.enabled` for details about this feature.
    "markdown.updateLinksOnFileMove.include": [
        "**/*.{md,mkd,mdwn,mdown,markdown,markdn,mdtxt,mdtext,workbook}",
        "**/*.{jpg,jpe,jpeg,png,bmp,gif,ico,webp,avif,tiff,svg,mp4}"
    ],

    // Validate duplicated definitions in the current file.
    "markdown.validate.duplicateLinkDefinitions.enabled": "warning",

    // Enable all error reporting in Markdown files.
    "markdown.validate.enabled": false,

    // Validate links to other files in Markdown files, for example `[link](/path/to/file.md)`. This checks that the target files exists. Requires enabling `markdown.validate.enabled`.
    "markdown.validate.fileLinks.enabled": "warning",

    // Validate the fragment part of links to headers in other files in Markdown files, for example: `[link](/path/to/file.md#header)`. Inherits the setting value from `markdown.validate.fragmentLinks.enabled` by default.
    "markdown.validate.fileLinks.markdownFragmentLinks": "inherit",

    // Validate fragment links to headers in the current Markdown file, for example: `[link](#header)`. Requires enabling `markdown.validate.enabled`.
    "markdown.validate.fragmentLinks.enabled": "warning",

    // Configure links that should not be validated. For example adding `/about` would not validate the link `[about](/about)`, while the glob `/assets/**/*.svg` would let you skip validation for any link to `.svg` files under the `assets` directory.
    "markdown.validate.ignoredLinks": [],

    // Validate reference links in Markdown files, for example: `[link][ref]`. Requires enabling `markdown.validate.enabled`.
    "markdown.validate.referenceLinks.enabled": "warning",

    // Validate link definitions that are unused in the current file.
    "markdown.validate.unusedLinkDefinitions.enabled": "hint",

    // PHP
    // Controls whether the built-in PHP language suggestions are enabled. The support suggests PHP globals and variables.
    "php.suggest.basic": true,

    // Enable/disable built-in PHP validation.
    "php.validate.enable": true,

    // Points to the PHP executable.
    "php.validate.executablePath": null,

    // Whether the linter is run on save or on type.
    "php.validate.run": "onSave",

    // TypeScript and JavaScript Language Features
    // Enable/disable automatic closing of JSX tags.
    "javascript.autoClosingTags": true,

    // Enable/disable default JavaScript formatter.
    "javascript.format.enable": true,

    // Indent case clauses in switch statements. Requires using TypeScript 5.1+ in the workspace.
    "javascript.format.indentSwitchCase": true,

    // Defines space handling after a comma delimiter.
    "javascript.format.insertSpaceAfterCommaDelimiter": true,

    // Defines space handling after the constructor keyword.
    "javascript.format.insertSpaceAfterConstructor": false,

    // Defines space handling after function keyword for anonymous functions.
    "javascript.format.insertSpaceAfterFunctionKeywordForAnonymousFunctions": true,

    // Defines space handling after keywords in a control flow statement.
    "javascript.format.insertSpaceAfterKeywordsInControlFlowStatements": true,

    // Defines space handling after opening and before closing empty braces.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingEmptyBraces": true,

    // Defines space handling after opening and before closing JSX expression braces.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces": false,

    // Defines space handling after opening and before closing non-empty braces.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": true,

    // Defines space handling after opening and before closing non-empty brackets.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets": false,

    // Defines space handling after opening and before closing non-empty parenthesis.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis": false,

    // Defines space handling after opening and before closing template string braces.
    "javascript.format.insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces": false,

    // Defines space handling after a semicolon in a for statement.
    "javascript.format.insertSpaceAfterSemicolonInForStatements": true,

    // Defines space handling after a binary operator.
    "javascript.format.insertSpaceBeforeAndAfterBinaryOperators": true,

    // Defines space handling before function argument parentheses.
    "javascript.format.insertSpaceBeforeFunctionParenthesis": false,

    // Defines whether an open brace is put onto a new line for control blocks or not.
    "javascript.format.placeOpenBraceOnNewLineForControlBlocks": false,

    // Defines whether an open brace is put onto a new line for functions or not.
    "javascript.format.placeOpenBraceOnNewLineForFunctions": false,

    // Defines handling of optional semicolons.
    //  - ignore: Don't insert or remove any semicolons.
    //  - insert: Insert semicolons at statement ends.
    //  - remove: Remove unnecessary semicolons.
    "javascript.format.semicolons": "ignore",

    // Enable/disable inlay hints for implicit return types on function signatures:
    // ```typescript
    // 
    // function foo() /* :number */ {
    // 	return Date.now();
    // } 
    //  
    // ```
    "javascript.inlayHints.functionLikeReturnTypes.enabled": false,

    // Enable/disable inlay hints for parameter names:
    // ```typescript
    // 
    // parseInt(/* str: */ '123', /* radix: */ 8)
    //  
    // ```
    //  - none: Disable parameter name hints.
    //  - literals: Enable parameter name hints only for literal arguments.
    //  - all: Enable parameter name hints for literal and non-literal arguments.
    "javascript.inlayHints.parameterNames.enabled": "none",

    // Suppress parameter name hints on arguments whose text is identical to the parameter name.
    "javascript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true,

    // Enable/disable inlay hints for implicit parameter types:
    // ```typescript
    // 
    // el.addEventListener('click', e /* :MouseEvent */ => ...)
    //  
    // ```
    "javascript.inlayHints.parameterTypes.enabled": false,

    // Enable/disable inlay hints for implicit types on property declarations:
    // ```typescript
    // 
    // class Foo {
    // 	prop /* :number */ = Date.now();
    // }
    //  
    // ```
    "javascript.inlayHints.propertyDeclarationTypes.enabled": false,

    // Enable/disable inlay hints for implicit variable types:
    // ```typescript
    // 
    // const foo /* :number */ = Date.now();
    //  
    // ```
    "javascript.inlayHints.variableTypes.enabled": false,

    // Suppress type hints on variables whose name is identical to the type name.
    "javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true,

    // Specify glob patterns of files to exclude from auto imports. Relative paths are resolved relative to the workspace root. Patterns are evaluated using tsconfig.json [`exclude`](https://www.typescriptlang.org/tsconfig#exclude) semantics.
    "javascript.preferences.autoImportFileExcludePatterns": [],

    // Specify regular expressions to exclude auto imports with matching import specifiers. Examples:
    // 
    // - `^node:`
    // - `lib/internal` (slashes don't need to be escaped...)
    // - `/lib\/internal/i` (...unless including surrounding slashes for `i` or `u` flags)
    // - `^lodash$` (only allow subpath imports from lodash)
    "javascript.preferences.autoImportSpecifierExcludeRegexes": [],

    // Preferred path style for auto imports.
    //  - shortest: Prefers a non-relative import only if one is available that has fewer path segments than a relative import.
    //  - relative: Prefers a relative path to the imported file location.
    //  - non-relative: Prefers a non-relative import based on the `baseUrl` or `paths` configured in your `jsconfig.json` / `tsconfig.json`.
    //  - project-relative: Prefers a non-relative import only if the relative import path would leave the package or project directory.
    "javascript.preferences.importModuleSpecifier": "shortest",

    // Preferred path ending for auto imports.
    //  - auto: Use project settings to select a default.
    //  - minimal: Shorten `./component/index.js` to `./component`.
    //  - index: Shorten `./component/index.js` to `./component/index`.
    //  - js: Do not shorten path endings; include the `.js` or `.ts` extension.
    "javascript.preferences.importModuleSpecifierEnding": "auto",

    // Preferred style for JSX attribute completions.
    //  - auto: Insert `={}` or `=""` after attribute names based on the prop type. See `javascript.preferences.quoteStyle` to control the type of quotes used for string attributes.
    //  - braces: Insert `={}` after attribute names.
    //  - none: Only insert attribute names.
    "javascript.preferences.jsxAttributeCompletionStyle": "auto",

    // Advanced preferences that control how imports are ordered.
    "javascript.preferences.organizeImports": {},

    // Preferred quote style to use for Quick Fixes.
    //  - auto: Infer quote type from existing code
    //  - single: Always use single quotes: `'`
    //  - double: Always use double quotes: `"`
    "javascript.preferences.quoteStyle": "auto",

    // When on a JSX tag, try to rename the matching tag instead of renaming the symbol. Requires using TypeScript 5.1+ in the workspace.
    "javascript.preferences.renameMatchingJsxTags": true,

    // Enable/disable introducing aliases for object shorthand properties during renames.
    "javascript.preferences.useAliasesForRenames": true,

    // Makes `Go to Definition` avoid type declaration files when possible by triggering `Go to Source Definition` instead. This allows `Go to Source Definition` to be triggered with the mouse gesture.
    "javascript.preferGoToSourceDefinition": false,

    // Enable/disable references CodeLens in JavaScript files.
    "javascript.referencesCodeLens.enabled": false,

    // Enable/disable references CodeLens on all functions in JavaScript files.
    "javascript.referencesCodeLens.showOnAllFunctions": false,

    // Enable/disable auto import suggestions.
    "javascript.suggest.autoImports": true,

    // Enable/disable snippet completions for class members.
    "javascript.suggest.classMemberSnippets.enabled": true,

    // Complete functions with their parameter signature.
    "javascript.suggest.completeFunctionCalls": false,

    // Enable/disable suggestion to complete JSDoc comments.
    "javascript.suggest.completeJSDocs": true,

    // Enable/disable autocomplete suggestions.
    "javascript.suggest.enabled": true,

    // Enable/disable showing completions on potentially undefined values that insert an optional chain call. Requires strict null checks to be enabled.
    "javascript.suggest.includeAutomaticOptionalChainCompletions": true,

    // Enable/disable auto-import-style completions on partially-typed import statements.
    "javascript.suggest.includeCompletionsForImportStatements": true,

    // Enable/disable generating `@returns` annotations for JSDoc templates.
    "javascript.suggest.jsdoc.generateReturns": true,

    // Enable/disable including unique names from the file in JavaScript suggestions. Note that name suggestions are always disabled in JavaScript code that is semantically checked using `@ts-check` or `checkJs`.
    "javascript.suggest.names": true,

    // Enable/disable suggestions for paths in import statements and require calls.
    "javascript.suggest.paths": true,

    // Enable/disable suggestion diagnostics for JavaScript files in the editor.
    "javascript.suggestionActions.enabled": true,

    // Enable/disable automatic updating of import paths when you rename or move a file in VS Code.
    //  - prompt: Prompt on each rename.
    //  - always: Always update paths automatically.
    //  - never: Never rename paths and don't prompt.
    "javascript.updateImportsOnFileMove.enabled": "prompt",

    // Automatically update imports when pasting code. Requires TypeScript 5.6+.
    "javascript.updateImportsOnPaste.enabled": true,

    // Enable/disable JavaScript validation.
    "javascript.validate.enable": true,

    // The maximum number of characters in a hover. If the hover is longer than this, it will be truncated. Requires TypeScript 5.9+.
    "js/ts.hover.maximumLength": 500,

    // Enable/disable semantic checking of JavaScript files. Existing `jsconfig.json` or `tsconfig.json` files override this setting.
    "js/ts.implicitProjectConfig.checkJs": false,

    // Enable/disable `experimentalDecorators` in JavaScript files that are not part of a project. Existing `jsconfig.json` or `tsconfig.json` files override this setting.
    "js/ts.implicitProjectConfig.experimentalDecorators": false,

    // Sets the module system for the program. See more: https://www.typescriptlang.org/tsconfig#module.
    "js/ts.implicitProjectConfig.module": "ESNext",

    // Enable/disable [strict mode](https://www.typescriptlang.org/tsconfig#strict) in JavaScript and TypeScript files that are not part of a project. Existing `jsconfig.json` or `tsconfig.json` files override this setting.
    "js/ts.implicitProjectConfig.strict": true,

    // Enable/disable [strict function types](https://www.typescriptlang.org/tsconfig#strictFunctionTypes) in JavaScript and TypeScript files that are not part of a project. Existing `jsconfig.json` or `tsconfig.json` files override this setting.
    "js/ts.implicitProjectConfig.strictFunctionTypes": true,

    // Enable/disable [strict null checks](https://www.typescriptlang.org/tsconfig#strictNullChecks) in JavaScript and TypeScript files that are not part of a project. Existing `jsconfig.json` or `tsconfig.json` files override this setting.
    "js/ts.implicitProjectConfig.strictNullChecks": true,

    // Set target JavaScript language version for emitted JavaScript and include library declarations. See more: https://www.typescriptlang.org/tsconfig#target.
    "js/ts.implicitProjectConfig.target": "ES2024",

    // Enable/disable automatic closing of JSX tags.
    "typescript.autoClosingTags": true,

    // Check if npm is installed for [Automatic Type Acquisition](https://code.visualstudio.com/docs/nodejs/working-with-javascript#_typings-and-automatic-type-acquisition).
    "typescript.check.npmIsInstalled": true,

    // Disables [automatic type acquisition](https://code.visualstudio.com/docs/nodejs/working-with-javascript#_typings-and-automatic-type-acquisition). Automatic type acquisition fetches `@types` packages from npm to improve IntelliSense for external libraries.
    "typescript.disableAutomaticTypeAcquisition": false,

    // Enables prompting of users to use the TypeScript version configured in the workspace for Intellisense.
    "typescript.enablePromptUseWorkspaceTsdk": false,

    // Disables TypeScript and JavaScript language features to allow usage of the TypeScript Go experimental extension. Requires TypeScript Go to be installed and configured. Requires reloading extensions after changing this setting.
    "typescript.experimental.useTsgo": false,

    // Enable/disable default TypeScript formatter.
    "typescript.format.enable": true,

    // Indent case clauses in switch statements. Requires using TypeScript 5.1+ in the workspace.
    "typescript.format.indentSwitchCase": true,

    // Defines space handling after a comma delimiter.
    "typescript.format.insertSpaceAfterCommaDelimiter": true,

    // Defines space handling after the constructor keyword.
    "typescript.format.insertSpaceAfterConstructor": false,

    // Defines space handling after function keyword for anonymous functions.
    "typescript.format.insertSpaceAfterFunctionKeywordForAnonymousFunctions": true,

    // Defines space handling after keywords in a control flow statement.
    "typescript.format.insertSpaceAfterKeywordsInControlFlowStatements": true,

    // Defines space handling after opening and before closing empty braces.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingEmptyBraces": true,

    // Defines space handling after opening and before closing JSX expression braces.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces": false,

    // Defines space handling after opening and before closing non-empty braces.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": true,

    // Defines space handling after opening and before closing non-empty brackets.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets": false,

    // Defines space handling after opening and before closing non-empty parenthesis.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis": false,

    // Defines space handling after opening and before closing template string braces.
    "typescript.format.insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces": false,

    // Defines space handling after a semicolon in a for statement.
    "typescript.format.insertSpaceAfterSemicolonInForStatements": true,

    // Defines space handling after type assertions in TypeScript.
    "typescript.format.insertSpaceAfterTypeAssertion": false,

    // Defines space handling after a binary operator.
    "typescript.format.insertSpaceBeforeAndAfterBinaryOperators": true,

    // Defines space handling before function argument parentheses.
    "typescript.format.insertSpaceBeforeFunctionParenthesis": false,

    // Defines whether an open brace is put onto a new line for control blocks or not.
    "typescript.format.placeOpenBraceOnNewLineForControlBlocks": false,

    // Defines whether an open brace is put onto a new line for functions or not.
    "typescript.format.placeOpenBraceOnNewLineForFunctions": false,

    // Defines handling of optional semicolons.
    //  - ignore: Don't insert or remove any semicolons.
    //  - insert: Insert semicolons at statement ends.
    //  - remove: Remove unnecessary semicolons.
    "typescript.format.semicolons": "ignore",

    // Enable/disable implementations CodeLens. This CodeLens shows the implementers of an interface.
    "typescript.implementationsCodeLens.enabled": false,

    // Enable/disable showing implementations CodeLens above all class methods instead of only on abstract methods.
    "typescript.implementationsCodeLens.showOnAllClassMethods": false,

    // Enable/disable implementations CodeLens on interface methods.
    "typescript.implementationsCodeLens.showOnInterfaceMethods": false,

    // Enable/disable inlay hints for member values in enum declarations:
    // ```typescript
    // 
    // enum MyValue {
    // 	A /* = 0 */;
    // 	B /* = 1 */;
    // }
    //  
    // ```
    "typescript.inlayHints.enumMemberValues.enabled": false,

    // Enable/disable inlay hints for implicit return types on function signatures:
    // ```typescript
    // 
    // function foo() /* :number */ {
    // 	return Date.now();
    // } 
    //  
    // ```
    "typescript.inlayHints.functionLikeReturnTypes.enabled": false,

    // Enable/disable inlay hints for parameter names:
    // ```typescript
    // 
    // parseInt(/* str: */ '123', /* radix: */ 8)
    //  
    // ```
    //  - none: Disable parameter name hints.
    //  - literals: Enable parameter name hints only for literal arguments.
    //  - all: Enable parameter name hints for literal and non-literal arguments.
    "typescript.inlayHints.parameterNames.enabled": "none",

    // Suppress parameter name hints on arguments whose text is identical to the parameter name.
    "typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true,

    // Enable/disable inlay hints for implicit parameter types:
    // ```typescript
    // 
    // el.addEventListener('click', e /* :MouseEvent */ => ...)
    //  
    // ```
    "typescript.inlayHints.parameterTypes.enabled": false,

    // Enable/disable inlay hints for implicit types on property declarations:
    // ```typescript
    // 
    // class Foo {
    // 	prop /* :number */ = Date.now();
    // }
    //  
    // ```
    "typescript.inlayHints.propertyDeclarationTypes.enabled": false,

    // Enable/disable inlay hints for implicit variable types:
    // ```typescript
    // 
    // const foo /* :number */ = Date.now();
    //  
    // ```
    "typescript.inlayHints.variableTypes.enabled": false,

    // Suppress type hints on variables whose name is identical to the type name.
    "typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true,

    // Sets the locale used to report JavaScript and TypeScript errors. Defaults to use VS Code's locale.
    //  - auto: Use VS Code's configured display language.
    //  - de: Deutsch
    //  - es: español
    //  - en: English
    //  - fr: français
    //  - it: italiano
    //  - ja: 日本語
    //  - ko: 한국어
    //  - ru: русский
    //  - zh-CN: 中文(简体)
    //  - zh-TW: 中文(繁體)
    "typescript.locale": "auto",

    // Specifies the path to the npm executable used for [Automatic Type Acquisition](https://code.visualstudio.com/docs/nodejs/working-with-javascript#_typings-and-automatic-type-acquisition).
    "typescript.npm": "",

    // Specify glob patterns of files to exclude from auto imports. Relative paths are resolved relative to the workspace root. Patterns are evaluated using tsconfig.json [`exclude`](https://www.typescriptlang.org/tsconfig#exclude) semantics.
    "typescript.preferences.autoImportFileExcludePatterns": [],

    // Specify regular expressions to exclude auto imports with matching import specifiers. Examples:
    // 
    // - `^node:`
    // - `lib/internal` (slashes don't need to be escaped...)
    // - `/lib\/internal/i` (...unless including surrounding slashes for `i` or `u` flags)
    // - `^lodash$` (only allow subpath imports from lodash)
    "typescript.preferences.autoImportSpecifierExcludeRegexes": [],

    // Preferred path style for auto imports.
    //  - shortest: Prefers a non-relative import only if one is available that has fewer path segments than a relative import.
    //  - relative: Prefers a relative path to the imported file location.
    //  - non-relative: Prefers a non-relative import based on the `baseUrl` or `paths` configured in your `jsconfig.json` / `tsconfig.json`.
    //  - project-relative: Prefers a non-relative import only if the relative import path would leave the package or project directory.
    "typescript.preferences.importModuleSpecifier": "shortest",

    // Preferred path ending for auto imports.
    //  - auto: Use project settings to select a default.
    //  - minimal: Shorten `./component/index.js` to `./component`.
    //  - index: Shorten `./component/index.js` to `./component/index`.
    //  - js: Do not shorten path endings; include the `.js` or `.ts` extension.
    "typescript.preferences.importModuleSpecifierEnding": "auto",

    // Enable/disable searching `package.json` dependencies for available auto imports.
    //  - auto: Search dependencies based on estimated performance impact.
    //  - on: Always search dependencies.
    //  - off: Never search dependencies.
    "typescript.preferences.includePackageJsonAutoImports": "auto",

    // Preferred style for JSX attribute completions.
    //  - auto: Insert `={}` or `=""` after attribute names based on the prop type. See `typescript.preferences.quoteStyle` to control the type of quotes used for string attributes.
    //  - braces: Insert `={}` after attribute names.
    //  - none: Only insert attribute names.
    "typescript.preferences.jsxAttributeCompletionStyle": "auto",

    // Advanced preferences that control how imports are ordered.
    "typescript.preferences.organizeImports": {},

    // Include the `type` keyword in auto-imports whenever possible. Requires using TypeScript 5.3+ in the workspace.
    "typescript.preferences.preferTypeOnlyAutoImports": false,

    // Preferred quote style to use for Quick Fixes.
    //  - auto: Infer quote type from existing code
    //  - single: Always use single quotes: `'`
    //  - double: Always use double quotes: `"`
    "typescript.preferences.quoteStyle": "auto",

    // When on a JSX tag, try to rename the matching tag instead of renaming the symbol. Requires using TypeScript 5.1+ in the workspace.
    "typescript.preferences.renameMatchingJsxTags": true,

    // Enable/disable introducing aliases for object shorthand properties during renames.
    "typescript.preferences.useAliasesForRenames": true,

    // Makes `Go to Definition` avoid type declaration files when possible by triggering `Go to Source Definition` instead. This allows `Go to Source Definition` to be triggered with the mouse gesture.
    "typescript.preferGoToSourceDefinition": false,

    // Enable/disable references CodeLens in TypeScript files.
    "typescript.referencesCodeLens.enabled": false,

    // Enable/disable references CodeLens on all functions in TypeScript files.
    "typescript.referencesCodeLens.showOnAllFunctions": false,

    // Report style checks as warnings.
    "typescript.reportStyleChecksAsWarnings": true,

    // Enable/disable auto import suggestions.
    "typescript.suggest.autoImports": true,

    // Enable/disable snippet completions for class members.
    "typescript.suggest.classMemberSnippets.enabled": true,

    // Complete functions with their parameter signature.
    "typescript.suggest.completeFunctionCalls": false,

    // Enable/disable suggestion to complete JSDoc comments.
    "typescript.suggest.completeJSDocs": true,

    // Enable/disable autocomplete suggestions.
    "typescript.suggest.enabled": true,

    // Enable/disable showing completions on potentially undefined values that insert an optional chain call. Requires strict null checks to be enabled.
    "typescript.suggest.includeAutomaticOptionalChainCompletions": true,

    // Enable/disable auto-import-style completions on partially-typed import statements.
    "typescript.suggest.includeCompletionsForImportStatements": true,

    // Enable/disable generating `@returns` annotations for JSDoc templates.
    "typescript.suggest.jsdoc.generateReturns": true,

    // Enable/disable snippet completions for methods in object literals.
    "typescript.suggest.objectLiteralMethodSnippets.enabled": true,

    // Enable/disable suggestions for paths in import statements and require calls.
    "typescript.suggest.paths": true,

    // Enable/disable suggestion diagnostics for TypeScript files in the editor.
    "typescript.suggestionActions.enabled": true,

    // Controls auto detection of tsc tasks.
    //  - on: Create both build and watch tasks.
    //  - off: Disable this feature.
    //  - build: Only create single run compile tasks.
    //  - watch: Only create compile and watch tasks.
    "typescript.tsc.autoDetect": "on",

    // Specifies the folder path to the tsserver and `lib*.d.ts` files under a TypeScript install to use for IntelliSense, for example: `./node_modules/typescript/lib`.
    // 
    // - When specified as a user setting, the TypeScript version from `typescript.tsdk` automatically replaces the built-in TypeScript version.
    // - When specified as a workspace setting, `typescript.tsdk` allows you to switch to use that workspace version of TypeScript for IntelliSense with the `TypeScript: Select TypeScript version` command.
    // 
    // See the [TypeScript documentation](https://code.visualstudio.com/docs/typescript/typescript-compiling#_using-newer-typescript-versions) for more detail about managing TypeScript versions.
    "typescript.tsdk": "",

    // Enables region-based diagnostics in TypeScript. Requires using TypeScript 5.6+ in the workspace.
    "typescript.tsserver.enableRegionDiagnostics": true,

    // Enables tracing TS server performance to a directory. These trace files can be used to diagnose TS Server performance issues. The log may contain file paths, source code, and other potentially sensitive information from your project.
    "typescript.tsserver.enableTracing": false,

    // Enables project wide error reporting.
    "typescript.tsserver.experimental.enableProjectDiagnostics": false,

    // Enables logging of the TS server to a file. This log can be used to diagnose TS Server issues. The log may contain file paths, source code, and other potentially sensitive information from your project.
    "typescript.tsserver.log": "off",

    // The maximum amount of memory (in MB) to allocate to the TypeScript server process. To use a memory limit greater than 4 GB, use `typescript.tsserver.nodePath` to run TS Server with a custom Node installation.
    "typescript.tsserver.maxTsServerMemory": 3072,

    // Run TS Server on a custom Node installation. This can be a path to a Node executable, or 'node' if you want VS Code to detect a Node installation.
    "typescript.tsserver.nodePath": "",

    // Additional paths to discover TypeScript Language Service plugins.
    "typescript.tsserver.pluginPaths": [],

    // Controls if TypeScript launches a dedicated server to more quickly handle syntax related operations, such as computing code folding.
    //  - always: Use a lighter weight syntax server to handle all IntelliSense operations. This syntax server can only provide IntelliSense for opened files.
    //  - never: Don't use a dedicated syntax server. Use a single server to handle all IntelliSense operations.
    //  - auto: Spawn both a full server and a lighter weight server dedicated to syntax operations. The syntax server is used to speed up syntax operations and provide IntelliSense while projects are loading.
    "typescript.tsserver.useSyntaxServer": "auto",

    // Configure which watching strategies should be used to keep track of files and directories.
    "typescript.tsserver.watchOptions": "vscode",

    // Enable/disable project-wide IntelliSense on web. Requires that VS Code is running in a trusted context.
    "typescript.tsserver.web.projectWideIntellisense.enabled": true,

    // Suppresses semantic errors on web even when project wide IntelliSense is enabled. This is always on when project wide IntelliSense is not enabled or available. See `typescript.tsserver.web.projectWideIntellisense.enabled`
    "typescript.tsserver.web.projectWideIntellisense.suppressSemanticErrors": false,

    // Enable/disable package acquisition on the web. This enables IntelliSense for imported packages. Requires `typescript.tsserver.web.projectWideIntellisense.enabled`. Currently not supported for Safari.
    "typescript.tsserver.web.typeAcquisition.enabled": true,

    // Enable/disable automatic updating of import paths when you rename or move a file in VS Code.
    //  - prompt: Prompt on each rename.
    //  - always: Always update paths automatically.
    //  - never: Never rename paths and don't prompt.
    "typescript.updateImportsOnFileMove.enabled": "prompt",

    // Automatically update imports when pasting code. Requires TypeScript 5.6+.
    "typescript.updateImportsOnPaste.enabled": true,

    // Enable/disable TypeScript validation.
    "typescript.validate.enable": true,

    // Exclude symbols that come from library files in `Go to Symbol in Workspace` results. Requires using TypeScript 5.3+ in the workspace.
    "typescript.workspaceSymbols.excludeLibrarySymbols": true,

    // Controls which files are searched by [Go to Symbol in Workspace](https://code.visualstudio.com/docs/editor/editingevolved#_open-symbol-by-name).
    //  - allOpenProjects: Search all open JavaScript or TypeScript projects for symbols.
    //  - currentProject: Only search for symbols in the current JavaScript or TypeScript project.
    "typescript.workspaceSymbols.scope": "allOpenProjects",

    // Testing
    // Always reveal the executed test when `testing.followRunningTest` is on. If this setting is turned off, only failed tests will be revealed.
    "testing.alwaysRevealTestOnStateChange": false,

    // Configures when the error Peek view is automatically opened.
    //  - failureAnywhere: Open automatically no matter where the failure is.
    //  - failureInVisibleDocument: Open automatically when a test fails in a visible document.
    //  - never: Never automatically open.
    "testing.automaticallyOpenPeekView": "never",

    // Controls whether to automatically open the Peek view during continuous run mode.
    "testing.automaticallyOpenPeekViewDuringAutoRun": false,

    // Controls when the testing view should open.
    //  - neverOpen: Never automatically open the testing views
    //  - openOnTestStart: Open the test results view when tests start
    //  - openOnTestFailure: Open the test result view on any test failure
    //  - openExplorerOnTestStart: Open the test explorer when tests start
    "testing.automaticallyOpenTestResults": "openOnTestStart",

    // Controls the count badge on the Testing icon on the Activity Bar.
    //  - failed: Show the number of failed tests
    //  - off: Disable the testing count badge
    //  - passed: Show the number of passed tests
    //  - skipped: Show the number of skipped tests
    "testing.countBadge": "failed",

    // Configures the colors used for percentages in test coverage bars.
    "testing.coverageBarThresholds": {
        "red": 0,
        "yellow": 60,
        "green": 90
    },

    // Controls whether the coverage toolbar is shown in the editor.
    "testing.coverageToolbarEnabled": false,

    // Controls the action to take when left-clicking on a test decoration in the gutter.
    //  - run: Run the test.
    //  - debug: Debug the test.
    //  - runWithCoverage: Run the test with coverage.
    //  - contextMenu: Open the context menu for more options.
    "testing.defaultGutterClickAction": "run",

    // Configures what percentage is displayed by default for test coverage.
    //  - totalCoverage: A calculation of the combined statement, function, and branch coverage.
    //  - statement: The statement coverage.
    //  - minimum: The minimum of statement, function, and branch coverage.
    "testing.displayedCoveragePercent": "totalCoverage",

    // Controls whether the running test should be followed in the Test Explorer view.
    "testing.followRunningTest": false,

    // Controls whether test decorations are shown in the editor gutter.
    "testing.gutterEnabled": true,

    // Controls the layout of the Test Results view.
    //  - treeRight: Show the test run tree on the right side with details on the left.
    //  - treeLeft: Show the test run tree on the left side with details on the right.
    "testing.resultsView.layout": "treeRight",

    // Control whether save all dirty editors before running a test.
    "testing.saveBeforeTest": true,

    // Controls whether to show messages from all test runs.
    "testing.showAllMessages": false,

    // Whether test coverage should be down in the File Explorer view.
    "testing.showCoverageInExplorer": true,

    // CSS
    // Insert semicolon at end of line when completing CSS properties.
    "css.completion.completePropertyWithSemicolon": true,

    // By default, VS Code triggers property value completion after selecting a CSS property. Use this setting to disable this behavior.
    "css.completion.triggerPropertyValueCompletion": true,

    // A list of relative file paths pointing to JSON files following the [custom data format](https://github.com/microsoft/vscode-css-languageservice/blob/master/docs/customData.md).
    // 
    // VS Code loads custom data on startup to enhance its CSS support for CSS custom properties (variables), at-rules, pseudo-classes, and pseudo-elements you specify in the JSON files.
    // 
    // The file paths are relative to workspace and only workspace folder settings are considered.
    "css.customData": [],

    // Put braces on the same line as rules (`collapse`) or put braces on own line (`expand`).
    "css.format.braceStyle": "collapse",

    // Enable/disable default CSS formatter.
    "css.format.enable": true,

    // Maximum number of line breaks to be preserved in one chunk, when `css.format.preserveNewLines` is enabled.
    "css.format.maxPreserveNewLines": null,

    // Separate rulesets by a blank line.
    "css.format.newlineBetweenRules": true,

    // Separate selectors with a new line.
    "css.format.newlineBetweenSelectors": true,

    // Whether existing line breaks before rules and declarations should be preserved.
    "css.format.preserveNewLines": true,

    // Ensure a space character around selector separators '>', '+', '~' (e.g. `a > b`).
    "css.format.spaceAroundSelectorSeparator": false,

    // Show property and value documentation in CSS hovers.
    "css.hover.documentation": true,

    // Show references to MDN in CSS hovers.
    "css.hover.references": true,

    // Invalid number of parameters.
    "css.lint.argumentsInColorFunction": "error",

    // Do not use `width` or `height` when using `padding` or `border`.
    "css.lint.boxModel": "ignore",

    // When using a vendor-specific prefix make sure to also include all other vendor-specific properties.
    "css.lint.compatibleVendorPrefixes": "ignore",

    // Do not use duplicate style definitions.
    "css.lint.duplicateProperties": "ignore",

    // Do not use empty rulesets.
    "css.lint.emptyRules": "warning",

    // Avoid using `float`. Floats lead to fragile CSS that is easy to break if one aspect of the layout changes.
    "css.lint.float": "ignore",

    // `@font-face` rule must define `src` and `font-family` properties.
    "css.lint.fontFaceProperties": "warning",

    // Hex colors must consist of 3, 4, 6 or 8 hex numbers.
    "css.lint.hexColorLength": "error",

    // Selectors should not contain IDs because these rules are too tightly coupled with the HTML.
    "css.lint.idSelector": "ignore",

    // IE hacks are only necessary when supporting IE7 and older.
    "css.lint.ieHack": "ignore",

    // Avoid using `!important`. It is an indication that the specificity of the entire CSS has gotten out of control and needs to be refactored.
    "css.lint.important": "ignore",

    // Import statements do not load in parallel.
    "css.lint.importStatement": "ignore",

    // Property is ignored due to the display. E.g. with `display: inline`, the `width`, `height`, `margin-top`, `margin-bottom`, and `float` properties have no effect.
    "css.lint.propertyIgnoredDueToDisplay": "warning",

    // The universal selector (`*`) is known to be slow.
    "css.lint.universalSelector": "ignore",

    // Unknown at-rule.
    "css.lint.unknownAtRules": "warning",

    // Unknown property.
    "css.lint.unknownProperties": "warning",

    // Unknown vendor specific property.
    "css.lint.unknownVendorSpecificProperties": "ignore",

    // A list of properties that are not validated against the `unknownProperties` rule.
    "css.lint.validProperties": [],

    // When using a vendor-specific prefix, also include the standard property.
    "css.lint.vendorPrefix": "warning",

    // No unit for zero needed.
    "css.lint.zeroUnits": "ignore",

    // Traces the communication between VS Code and the CSS language server.
    "css.trace.server": "off",

    // Enables or disables all validations.
    "css.validate": true,

    // LESS
    // Insert semicolon at end of line when completing CSS properties.
    "less.completion.completePropertyWithSemicolon": true,

    // By default, VS Code triggers property value completion after selecting a CSS property. Use this setting to disable this behavior.
    "less.completion.triggerPropertyValueCompletion": true,

    // Put braces on the same line as rules (`collapse`) or put braces on own line (`expand`).
    "less.format.braceStyle": "collapse",

    // Enable/disable default LESS formatter.
    "less.format.enable": true,

    // Maximum number of line breaks to be preserved in one chunk, when `less.format.preserveNewLines` is enabled.
    "less.format.maxPreserveNewLines": null,

    // Separate rulesets by a blank line.
    "less.format.newlineBetweenRules": true,

    // Separate selectors with a new line.
    "less.format.newlineBetweenSelectors": true,

    // Whether existing line breaks before rules and declarations should be preserved.
    "less.format.preserveNewLines": true,

    // Ensure a space character around selector separators '>', '+', '~' (e.g. `a > b`).
    "less.format.spaceAroundSelectorSeparator": false,

    // Show property and value documentation in LESS hovers.
    "less.hover.documentation": true,

    // Show references to MDN in LESS hovers.
    "less.hover.references": true,

    // Invalid number of parameters.
    "less.lint.argumentsInColorFunction": "error",

    // Do not use `width` or `height` when using `padding` or `border`.
    "less.lint.boxModel": "ignore",

    // When using a vendor-specific prefix make sure to also include all other vendor-specific properties.
    "less.lint.compatibleVendorPrefixes": "ignore",

    // Do not use duplicate style definitions.
    "less.lint.duplicateProperties": "ignore",

    // Do not use empty rulesets.
    "less.lint.emptyRules": "warning",

    // Avoid using `float`. Floats lead to fragile CSS that is easy to break if one aspect of the layout changes.
    "less.lint.float": "ignore",

    // `@font-face` rule must define `src` and `font-family` properties.
    "less.lint.fontFaceProperties": "warning",

    // Hex colors must consist of 3, 4, 6 or 8 hex numbers.
    "less.lint.hexColorLength": "error",

    // Selectors should not contain IDs because these rules are too tightly coupled with the HTML.
    "less.lint.idSelector": "ignore",

    // IE hacks are only necessary when supporting IE7 and older.
    "less.lint.ieHack": "ignore",

    // Avoid using `!important`. It is an indication that the specificity of the entire CSS has gotten out of control and needs to be refactored.
    "less.lint.important": "ignore",

    // Import statements do not load in parallel.
    "less.lint.importStatement": "ignore",

    // Property is ignored due to the display. E.g. with `display: inline`, the `width`, `height`, `margin-top`, `margin-bottom`, and `float` properties have no effect.
    "less.lint.propertyIgnoredDueToDisplay": "warning",

    // The universal selector (`*`) is known to be slow.
    "less.lint.universalSelector": "ignore",

    // Unknown at-rule.
    "less.lint.unknownAtRules": "warning",

    // Unknown property.
    "less.lint.unknownProperties": "warning",

    // Unknown vendor specific property.
    "less.lint.unknownVendorSpecificProperties": "ignore",

    // A list of properties that are not validated against the `unknownProperties` rule.
    "less.lint.validProperties": [],

    // When using a vendor-specific prefix, also include the standard property.
    "less.lint.vendorPrefix": "warning",

    // No unit for zero needed.
    "less.lint.zeroUnits": "ignore",

    // Enables or disables all validations.
    "less.validate": true,

    // SCSS (Sass)
    // Insert semicolon at end of line when completing CSS properties.
    "scss.completion.completePropertyWithSemicolon": true,

    // By default, VS Code triggers property value completion after selecting a CSS property. Use this setting to disable this behavior.
    "scss.completion.triggerPropertyValueCompletion": true,

    // Put braces on the same line as rules (`collapse`) or put braces on own line (`expand`).
    "scss.format.braceStyle": "collapse",

    // Enable/disable default SCSS formatter.
    "scss.format.enable": true,

    // Maximum number of line breaks to be preserved in one chunk, when `scss.format.preserveNewLines` is enabled.
    "scss.format.maxPreserveNewLines": null,

    // Separate rulesets by a blank line.
    "scss.format.newlineBetweenRules": true,

    // Separate selectors with a new line.
    "scss.format.newlineBetweenSelectors": true,

    // Whether existing line breaks before rules and declarations should be preserved.
    "scss.format.preserveNewLines": true,

    // Ensure a space character around selector separators '>', '+', '~' (e.g. `a > b`).
    "scss.format.spaceAroundSelectorSeparator": false,

    // Show property and value documentation in SCSS hovers.
    "scss.hover.documentation": true,

    // Show references to MDN in SCSS hovers.
    "scss.hover.references": true,

    // Invalid number of parameters.
    "scss.lint.argumentsInColorFunction": "error",

    // Do not use `width` or `height` when using `padding` or `border`.
    "scss.lint.boxModel": "ignore",

    // When using a vendor-specific prefix make sure to also include all other vendor-specific properties.
    "scss.lint.compatibleVendorPrefixes": "ignore",

    // Do not use duplicate style definitions.
    "scss.lint.duplicateProperties": "ignore",

    // Do not use empty rulesets.
    "scss.lint.emptyRules": "warning",

    // Avoid using `float`. Floats lead to fragile CSS that is easy to break if one aspect of the layout changes.
    "scss.lint.float": "ignore",

    // `@font-face` rule must define `src` and `font-family` properties.
    "scss.lint.fontFaceProperties": "warning",

    // Hex colors must consist of 3, 4, 6 or 8 hex numbers.
    "scss.lint.hexColorLength": "error",

    // Selectors should not contain IDs because these rules are too tightly coupled with the HTML.
    "scss.lint.idSelector": "ignore",

    // IE hacks are only necessary when supporting IE7 and older.
    "scss.lint.ieHack": "ignore",

    // Avoid using `!important`. It is an indication that the specificity of the entire CSS has gotten out of control and needs to be refactored.
    "scss.lint.important": "ignore",

    // Import statements do not load in parallel.
    "scss.lint.importStatement": "ignore",

    // Property is ignored due to the display. E.g. with `display: inline`, the `width`, `height`, `margin-top`, `margin-bottom`, and `float` properties have no effect.
    "scss.lint.propertyIgnoredDueToDisplay": "warning",

    // The universal selector (`*`) is known to be slow.
    "scss.lint.universalSelector": "ignore",

    // Unknown at-rule.
    "scss.lint.unknownAtRules": "warning",

    // Unknown property.
    "scss.lint.unknownProperties": "warning",

    // Unknown vendor specific property.
    "scss.lint.unknownVendorSpecificProperties": "ignore",

    // A list of properties that are not validated against the `unknownProperties` rule.
    "scss.lint.validProperties": [],

    // When using a vendor-specific prefix, also include the standard property.
    "scss.lint.vendorPrefix": "warning",

    // No unit for zero needed.
    "scss.lint.zeroUnits": "ignore",

    // Enables or disables all validations.
    "scss.validate": true,

    // Extensions
    // Specify a list of extensions that are allowed to use. This helps maintain a secure and consistent development environment by restricting the use of unauthorized extensions. For more information on how to configure this setting, please visit the [Configure Allowed Extensions](https://code.visualstudio.com/docs/setup/enterprise#_configure-allowed-extensions) section.
    "extensions.allowed": "*",

    // When enabled, automatically checks extensions for updates. If an extension has an update, it is marked as outdated in the Extensions view. The updates are fetched from a Microsoft online service.
    "extensions.autoCheckUpdates": true,

    // If activated, extensions will automatically restart following an update if the window is not in focus. There can be a data loss if you have open Notebooks or Custom Editors.
    "extensions.autoRestart": false,

    // Controls the automatic update behavior of extensions. The updates are fetched from a Microsoft online service.
    //  - true: Download and install updates automatically for all extensions.
    //  - onlyEnabledExtensions: Download and install updates automatically only for enabled extensions.
    //  - false: Extensions are not automatically updated.
    "extensions.autoUpdate": true,

    // When enabled, editors with extension details will be automatically closed upon navigating away from the Extensions View.
    "extensions.closeExtensionDetailsOnViewChange": false,

    // When an extension is listed here, a confirmation prompt will not be shown when that extension handles a URI.
    "extensions.confirmedUriHandlerExtensionIds": [],

    // Configure an extension to execute in a different extension host process.
    "extensions.experimental.affinity": {},

    // When enabled, extensions which declare the `onStartupFinished` activation event will be activated after a timeout.
    "extensions.experimental.deferredStartupFinishedActivation": false,

    // When enabled, extensions can be searched for via Quick Access and report issues from there.
    "extensions.experimental.issueQuickAccess": true,

    // When enabled, the notifications for extension recommendations will not be shown.
    "extensions.ignoreRecommendations": false,

    // Controls the timeout in milliseconds for HTTP requests made when fetching extensions from the Marketplace
    "extensions.requestTimeout": 60000,

    // This setting is deprecated. Use extensions.ignoreRecommendations setting to control recommendation notifications. Use Extensions view's visibility actions to hide Recommended view by default.
    // 
    "extensions.showRecommendationsOnlyOnDemand": false,

    // When enabled, Node.js navigator object is exposed on the global scope.
    "extensions.supportNodeGlobalNavigator": false,

    // Override the untrusted workspace support of an extension. Extensions using `true` will always be enabled. Extensions using `limited` will always be enabled, and the extension will hide functionality that requires trust. Extensions using `false` will only be enabled only when the workspace is trusted.
    "extensions.supportUntrustedWorkspaces": {},

    // Override the virtual workspaces support of an extension.
    "extensions.supportVirtualWorkspaces": {},

    // When enabled, extensions are verified to be signed before getting installed.
    "extensions.verifySignature": true,

    // Enable web worker extension host.
    //  - true: The Web Worker Extension Host will always be launched.
    //  - false: The Web Worker Extension Host will never be launched.
    //  - auto: The Web Worker Extension Host will be launched when a web extension needs it.
    "extensions.webWorker": "auto",

    // Output
    // Enable/disable the ability of smart scrolling in the output view. Smart scrolling allows you to lock scrolling automatically when you click in the output view and unlocks when you click in the last line.
    "output.smartScroll.enabled": true,

    // Settings Sync
    // List of extensions to be ignored while synchronizing. The identifier of an extension is always `${publisher}.${name}`. For example: `vscode.csharp`.
    "settingsSync.ignoredExtensions": [],

    // Configure settings to be ignored while synchronizing.
    "settingsSync.ignoredSettings": [],

    // Synchronize keybindings for each platform.
    "settingsSync.keybindingsPerPlatform": true,

    // Commit Graph (ᴘʀᴏ)
    // Specifies whether to allow opening multiple instances of the _Commit Graph_ in the editor area
    "gitlens.graph.allowMultiple": true,

    // Specifies whether to show avatar images instead of author initials and remote icons in the _Commit Graph_
    "gitlens.graph.avatars": true,

    // Specifies the visibility of branches on the _Commit Graph_
    //  - all: Shows all branches
    //  - smart: Shows only relevant branches
    //  - current: Shows only the current branch
    //  - favorited: Shows only favorited branches
    "gitlens.graph.branchesVisibility": "all",

    // Specifies the order by which commits will be shown on the _Commit Graph_
    //  - date: Shows commits in reverse chronological order of the commit timestamp
    //  - author-date: Shows commits in reverse chronological order of the author timestamp
    //  - topo: Shows commits in reverse chronological order of the commit timestamp, but avoids intermixing multiple lines of history
    "gitlens.graph.commitOrdering": "date",

    // Specifies how absolute dates will be formatted in the _Commit Graph_, when not specified `gitlens.defaultDateFormat#` is used. Use `full`, `long`, `medium`, `short`, or a custom format, e.g. `MMMM Do, YYYY h:mma`, similar to [Moment.js formats](https://momentjs.com/docs/#/displaying/format/). Only applies when `#gitlens.graph.dateFormat` is set to `absolute`
    "gitlens.graph.dateFormat": null,

    // Specifies how dates will be displayed in the _Commit Graph_, when not specified `gitlens.defaultDateStyle` is used
    //  - null: defaults to `gitlens.defaultDateStyle`
    //  - relative: e.g. 1 day ago
    //  - absolute: e.g. July 25th, 2018 7:18pm
    "gitlens.graph.dateStyle": null,

    // Specifies the default number of items to show in the _Commit Graph_. Use 0 to specify no limit
    "gitlens.graph.defaultItemLimit": 500,

    // Specifies whether to dim (deemphasize) merge commit rows in the _Commit Graph_
    "gitlens.graph.dimMergeCommits": false,

    // Specifies whether to highlight rows associated with the branch / tag when hovering over it in the _Commit Graph_
    "gitlens.graph.highlightRowsOnRefHover": true,

    // Specifies whether to select the "Work in progress" (WIP) row instead of HEAD if there are uncommitted changes in the _Commit Graph_
    //  - wip: Selects the working changes (WIP) row when there are uncommitted changes, otherwise selects the HEAD row
    //  - head: Always selects the HEAD row
    "gitlens.graph.initialRowSelection": "wip",

    // Specifies whether to show associated issues on branches in the _Commit Graph_. Requires a connection to a supported issue service (e.g. GitHub)
    "gitlens.graph.issues.enabled": true,

    // Specifies the preferred layout of the _Commit Graph_
    //  - editor: Prefer showing the Commit Graph in the editor area
    //  - panel: Prefer showing the Commit Graph in the bottom panel
    "gitlens.graph.layout": "panel",

    // Specifies additional markers to show on the minimap in the _Commit Graph_
    //  - localBranches: Marks the location of local branches
    //  - remoteBranches: Marks the location of remote branches
    //  - pullRequests: Marks the location of pull requests
    //  - stashes: Marks the location of stashes
    //  - tags: Marks the location of tags
    "gitlens.graph.minimap.additionalTypes": [
        "localBranches",
        "stashes"
    ],

    // Specifies the data to show on the minimap in the _Commit Graph_
    //  - commits: Shows the number of commits per day in the minimap
    //  - lines: Shows the number of lines changed per day in the minimap
    "gitlens.graph.minimap.dataType": "commits",

    // Specifies whether to show a minimap of commit activity above the _Commit Graph_
    "gitlens.graph.minimap.enabled": true,

    // Specifies whether to allow selecting multiple commits and whether to restrict the selection topologically in the _Commit Graph_
    //  - false: Disallows selecting multiple commits
    //  - true: Allows selecting multiple commits without restriction
    //  - topological: Allows selecting multiple commits topologically
    "gitlens.graph.multiselect": "topological",

    // Specifies whether to only follow the first parent when showing commits on the _Commit Graph_
    "gitlens.graph.onlyFollowFirstParent": false,

    // Specifies the number of additional items to fetch when paginating in the _Commit Graph_. Use 0 to specify no limit
    "gitlens.graph.pageItemLimit": 200,

    // Specifies whether to show associated pull requests on remote branches in the _Commit Graph_. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.graph.pullRequests.enabled": true,

    // Specifies additional markers to show on the scrollbar in the _Commit Graph_
    //  - localBranches: Marks the location of local branches
    //  - remoteBranches: Marks the location of remote branches
    //  - pullRequests: Marks the location of pull requests
    //  - stashes: Marks the location of stashes
    //  - tags: Marks the location of tags
    "gitlens.graph.scrollMarkers.additionalTypes": [
        "localBranches",
        "stashes"
    ],

    // Specifies whether to show markers on the scrollbar in the _Commit Graph_
    "gitlens.graph.scrollMarkers.enabled": true,

    // Specifies the number of rows from the edge at which the graph will scroll when using keyboard or search to change the selected row
    "gitlens.graph.scrollRowPadding": 0,

    // Specifies the number of results to gather when searching in the _Commit Graph_. Use 0 to specify no limit
    "gitlens.graph.searchItemLimit": 0,

    // Specifies when to show the _Commit Details_ view for the selected row in the _Commit Graph_
    //  - false: Never shows the _Commit Details_ view automatically
    //  - open: Shows the _Commit Details_ view automatically only when opening the _Commit Graph_
    //  - selection: Shows the _Commit Details_ view automatically when selection changes in the _Commit Graph_
    "gitlens.graph.showDetailsView": "selection",

    // Specifies whether to show a ghost branch / tag when hovering over or selecting a row in the _Commit Graph_
    "gitlens.graph.showGhostRefsOnRowHover": true,

    // Specifies whether to show remote names on remote branches in the _Commit Graph_
    "gitlens.graph.showRemoteNames": false,

    // Specifies whether to show a local branch's upstream status in the _Commit Graph_
    "gitlens.graph.showUpstreamStatus": true,

    // Specifies whether to show a sidebar on the _Commit Graph_
    "gitlens.graph.sidebar.enabled": true,

    // Specifies whether to show the _Commit Graph_ in the status bar
    "gitlens.graph.statusBar.enabled": true,

    // Specifies whether to show a sticky timeline header that remains visible at the top while scrolling in the _Commit Graph_
    "gitlens.graph.stickyTimeline": true,

    // Home
    // Specifies whether to enable the new home preview
    "gitlens.home.preview.enabled": true,

    // Launchpad (ᴘʀᴏ)
    // Specifies whether to allow opening multiple instances of the _Launchpad_ as an editor tab
    "gitlens.launchpad.allowMultiple": true,

    // (Experimental) Specifies a limit on the number of pull requests to be queried in the _Launchpad_
    "gitlens.launchpad.experimental.queryLimit": 100,

    // Specifies the organizations to ignore in the _Launchpad_
    "gitlens.launchpad.ignoredOrganizations": [],

    // Specifies the repositories to ignore in the _Launchpad_
    "gitlens.launchpad.ignoredRepositories": [],

    // Specifies the organizations to include in the _Launchpad_. If empty, all organizations are included
    "gitlens.launchpad.includedOrganizations": [],

    // Specifies whether to enable status bar indicator for _Launchpad_
    "gitlens.launchpad.indicator.enabled": true,

    // Specifies the groups of pull requests to show on the _Launchpad_ status bar indicator
    //  - mergeable: Shows mergeable pull requests
    //  - blocked: Shows blocked pull requests
    //  - needs-review: Shows pull requests needing your review
    //  - follow-up: Shows pull requests needing follow-up
    "gitlens.launchpad.indicator.groups": [
        "mergeable",
        "blocked",
        "needs-review",
        "follow-up"
    ],

    // Specifies the style of the  _Launchpad_ status bar indicator icon
    //  - default: Shows the Launchpad icon
    //  - group: Shows the icon of the highest priority group
    "gitlens.launchpad.indicator.icon": "default",

    // Specifies the display of the  _Launchpad_ status bar indicator label
    //  - false: Hides the label
    //  - item: Shows the highest priority item which needs your attention
    //  - counts: Shows the status counts of items which need your attention
    "gitlens.launchpad.indicator.label": "item",

    // Specifies whether the status bar indicator will fetch and display pull request data for _Launchpad_
    "gitlens.launchpad.indicator.polling.enabled": true,

    // Specifies the rate (in minutes) at which the status bar indicator will fetch pull request data for _Launchpad_. Use 0 to disable automatic polling
    "gitlens.launchpad.indicator.polling.interval": 30,

    // Specifies whether to use colors on the _Launchpad_ status bar indicator
    "gitlens.launchpad.indicator.useColors": false,

    // Specifies the number of days after which a pull request is considered stale and moved to Other in the _Launchpad_
    "gitlens.launchpad.staleThreshold": null,

    // Cloud Patches (ᴘʀᴇᴠɪᴇᴡ)
    // Specifies whether to enable the preview of _Cloud Patches_, which allow you to privately and securely share code with specific teammates and other developers
    "gitlens.cloudPatches.enabled": true,

    // (Experimental) Specifies the preferred layout of for _Cloud Patches_
    //  - editor: Prefer showing Cloud Patches in the editor area
    //  - view: Prefer showing Cloud Patches in a view
    "gitlens.cloudPatches.experimental.layout": "view",

    // Automatically scroll the interactive window to show the output of the last statement executed. If this value is false, the window will only scroll if the last cell was already the one scrolled to.
    "interactiveWindow.alwaysScrollOnNewCell": true,

    // Execute the Interactive Window (REPL) input box with shift+enter, so that enter can be used to create a newline.
    "interactiveWindow.executeWithShiftEnter": false,

    // Prompt to save the interactive window when it is closed. Only new interactive windows will be affected by this setting change.
    "interactiveWindow.promptToSaveOnClose": false,

    // Display a hint in the Interactive Window (REPL) input box to indicate how to execute code.
    "interactiveWindow.showExecutionHint": true,

    // Application
    // When enabled, slow renderers are automatically profiled.
    "application.experimental.rendererProfiling": false,

    // External Terminal
    // When opening a file from the Explorer in a terminal, determines what kind of terminal will be launched
    //  - integrated: Show the integrated terminal action.
    //  - external: Show the external terminal action.
    //  - both: Show both integrated and external terminal actions.
    "terminal.explorerKind": "integrated",

    // Customizes which terminal to run on Linux.
    "terminal.external.linuxExec": "xterm",

    // Customizes which terminal application to run on macOS.
    "terminal.external.osxExec": "Terminal.app",

    // Customizes which terminal to run on Windows.
    "terminal.external.windowsExec": "C:\\WINDOWS\\System32\\cmd.exe",

    // When opening a repository from the Source Control Repositories view in a terminal, determines what kind of terminal will be launched
    //  - integrated: Show the integrated terminal action.
    //  - external: Show the external terminal action.
    //  - both: Show both integrated and external terminal actions.
    "terminal.sourceControlRepositoriesKind": "integrated",

    // Integrated Terminal
    // Use `chat.tools.terminal.autoApprove` instead
    // 
    "chat.agent.terminal.allowList": null,

    // Use `chat.tools.terminal.autoApprove` instead
    // 
    "chat.agent.terminal.autoApprove": null,

    // Use `chat.tools.terminal.autoApprove` instead
    // 
    "chat.agent.terminal.denyList": null,

    // A list of commands or regular expressions that control whether the run in terminal tool commands require explicit approval. These will be matched against the start of a command. A regular expression can be provided by wrapping the string in `/` characters followed by optional flags such as `i` for case-insensitivity.
    // 
    // Set to `true` to automatically approve commands, `false` to always require explicit approval or `null` to unset the value.
    // 
    // Note that these commands and regular expressions are evaluated for every _sub-command_ within the full _command line_, so `foo && bar` for example will need both `foo` and `bar` to match a `true` entry and must not match a `false` entry in order to auto approve. Inline commands such as `<(foo)` (process substitution) should also be detected.
    // 
    // An object can be used to match against the full command line instead of matching sub-commands and inline commands, for example `{ approve: false, matchCommandLine: true }`. In order to be auto approved _both_ the sub-command and command line must not be explicitly denied, then _either_ all sub-commands or command line needs to be approved.
    // 
    // Note that there's a default set of rules to allow and also deny commands. Consider setting `chat.tools.terminal.ignoreDefaultAutoApproveRules` to `true` to ignore all default rules to ensure there are no conflicts with your own rules. Do this at your own risk, the default denial rules are designed to protect you against running dangerous commands.
    // 
    // Examples:
    // |Value|Description|
    // |---|---|
    // | `"mkdir": true` | Allow all commands starting with `mkdir`
    // | `"npm run build": true` | Allow all commands starting with `npm run build`
    // | `"bin/test.sh": true` | Allow all commands that match the path `bin/test.sh` (`bin\test.sh`, `./bin/test.sh`, etc.)
    // | `"/^git (status\|show\\b.*)$/": true` | Allow `git status` and all commands starting with `git show`
    // | `"/^Get-ChildItem\\b/i": true` | will allow `Get-ChildItem` commands regardless of casing
    // | `"/.*/": true` | Allow all commands (denied commands still require approval)
    // | `"rm": false` | Require explicit approval for all commands starting with `rm`
    // | `"/\\.ps1/i": { approve: false, matchCommandLine: true }` | Require explicit approval for any _command line_ that contains `".ps1"` regardless of casing
    // | `"rm": null` | Unset the default `false` value for `rm`
    "chat.tools.terminal.autoApprove": {
        "cd": true,
        "echo": true,
        "ls": true,
        "pwd": true,
        "cat": true,
        "head": true,
        "tail": true,
        "findstr": true,
        "wc": true,
        "tr": true,
        "cut": true,
        "cmp": true,
        "which": true,
        "basename": true,
        "dirname": true,
        "realpath": true,
        "readlink": true,
        "stat": true,
        "file": true,
        "du": true,
        "df": true,
        "sleep": true,
        "nl": true,
        "grep": true,
        "git status": true,
        "git log": true,
        "git show": true,
        "git diff": true,
        "git grep": true,
        "git branch": true,
        "/^git branch\\b.*-(d|D|m|M|-delete|-force)\\b/": false,
        "Get-ChildItem": true,
        "Get-Content": true,
        "Get-Date": true,
        "Get-Random": true,
        "Get-Location": true,
        "Write-Host": true,
        "Write-Output": true,
        "Split-Path": true,
        "Join-Path": true,
        "Start-Sleep": true,
        "Where-Object": true,
        "/^Select-[a-z0-9]/i": true,
        "/^Measure-[a-z0-9]/i": true,
        "/^Compare-[a-z0-9]/i": true,
        "/^Format-[a-z0-9]/i": true,
        "/^Sort-[a-z0-9]/i": true,
        "column": true,
        "/^column\\b.*-c\\s+[0-9]{4,}/": false,
        "date": true,
        "/^date\\b.*(-s|--set)\\b/": false,
        "find": true,
        "/^find\\b.*-(delete|exec|execdir|fprint|fprintf|fls|ok|okdir)\\b/": false,
        "sort": true,
        "/^sort\\b.*-(o|S)\\b/": false,
        "tree": true,
        "/^tree\\b.*-o\\b/": false,
        "rm": false,
        "rmdir": false,
        "del": false,
        "Remove-Item": false,
        "ri": false,
        "rd": false,
        "erase": false,
        "dd": false,
        "kill": false,
        "ps": false,
        "top": false,
        "Stop-Process": false,
        "spps": false,
        "taskkill": false,
        "taskkill.exe": false,
        "curl": false,
        "wget": false,
        "Invoke-RestMethod": false,
        "Invoke-WebRequest": false,
        "irm": false,
        "iwr": false,
        "chmod": false,
        "chown": false,
        "Set-ItemProperty": false,
        "sp": false,
        "Set-Acl": false,
        "jq": false,
        "xargs": false,
        "eval": false,
        "Invoke-Expression": false,
        "iex": false
    },

    // Whether to automatically respond to prompts in the terminal such as `Confirm? y/n`. This is an experimental feature and may not work in all scenarios.
    "chat.tools.terminal.autoReplyToPrompts": false,

    // Controls whether detected file write operations are blocked in the run in terminal tool. When detected, this will require explicit approval regardless of whether the command would normally be auto approved. Note that this cannot detect all possible methods of writing files, this is what is currently detected:
    // 
    // - File redirection (detected via the bash or PowerShell tree sitter grammar)
    //  - never: Allow all detected file writes.
    //  - outsideWorkspace: Block file writes detected outside the workspace. This depends on the shell integration feature working correctly to determine the current working directory of the terminal.
    //  - all: Block all detected file writes.
    "chat.tools.terminal.blockDetectedFileWrites": "outsideWorkspace",

    // Controls whether to allow auto approval in the run in terminal tool.
    "chat.tools.terminal.enableAutoApprove": true,

    // Whether to ignore the built-in default auto-approve rules used by the run in terminal tool as defined in `chat.tools.terminal.autoApprove`. When this setting is enabled, the run in terminal tool will ignore any rule that comes from the default set but still follow rules defined in the user, remote and workspace settings. Use this setting at your own risk; the default auto-approve rules are designed to protect you against running dangerous commands.
    "chat.tools.terminal.ignoreDefaultAutoApproveRules": false,

    // Where to show the output from the run in terminal tool session.
    //  - terminal: Reveal the terminal when running the command.
    //  - none: Do not reveal the terminal automatically.
    "chat.tools.terminal.outputLocation": "none",

    // Use `terminal.integrated.shellIntegration.timeout` instead
    // Configures the duration in milliseconds to wait for shell integration to be detected when the run in terminal tool launches a new terminal. Set to `0` to wait the minimum time, the default value `-1` means the wait time is variable based on the value of `terminal.integrated.shellIntegration.enabled` and whether it's a remote window. A large value can be useful if your shell starts very slowly and a low value if you're intentionally not using shell integration.
    "chat.tools.terminal.shellIntegrationTimeout": -1,

    // The terminal profile to use on Linux for chat agent's run in terminal tool.
    "chat.tools.terminal.terminalProfile.linux": null,

    // The terminal profile to use on macOS for chat agent's run in terminal tool.
    "chat.tools.terminal.terminalProfile.osx": null,

    // The terminal profile to use on Windows for chat agent's run in terminal tool.
    "chat.tools.terminal.terminalProfile.windows": null,

    // Use `chat.tools.terminal.autoApprove` instead
    // 
    "github.copilot.chat.agent.terminal.allowList": null,

    // Use `chat.tools.terminal.autoApprove` instead
    // 
    "github.copilot.chat.agent.terminal.denyList": null,

    // Focus the terminal accessible view when a command is executed.
    "terminal.integrated.accessibleViewFocusOnCommandExecution": false,

    // Preserve the cursor position on reopen of the terminal's accessible view rather than setting it to the bottom of the buffer.
    "terminal.integrated.accessibleViewPreserveCursorPosition": false,

    // Whether or not to allow chord keybindings in the terminal. Note that when this is true and the keystroke results in a chord it will bypass `terminal.integrated.commandsToSkipShell`, setting this to false is particularly useful when you want ctrl+k to go to your shell (not VS Code).
    "terminal.integrated.allowChords": true,

    // An array of strings containing the URI schemes that the terminal is allowed to open links for. By default, only a small subset of possible schemes are allowed for security reasons.
    "terminal.integrated.allowedLinkSchemes": [
        "file",
        "http",
        "https",
        "mailto",
        "vscode",
        "vscode-insiders"
    ],

    // Whether to allow menubar mnemonics (for example Alt+F) to trigger the open of the menubar. Note that this will cause all alt keystrokes to skip the shell when true. This does nothing on macOS.
    "terminal.integrated.allowMnemonics": false,

    // If enabled, alt/option + click will reposition the prompt cursor to underneath the mouse when `editor.multiCursorModifier` is set to `'alt'` (the default value). This may not work reliably depending on your shell.
    "terminal.integrated.altClickMovesCursor": true,

    // The terminal profile to use on Linux for automation-related terminal usage like tasks and debug.
    "terminal.integrated.automationProfile.linux": null,

    // The terminal profile to use on macOS for automation-related terminal usage like tasks and debug.
    "terminal.integrated.automationProfile.osx": null,

    // The terminal profile to use for automation-related terminal usage like tasks and debug. This setting will currently be ignored if `terminal.integrated.automationShell.windows` (now deprecated) is set.
    "terminal.integrated.automationProfile.windows": null,

    // A set of messages that, when encountered in the terminal, will be automatically responded to. Provided the message is specific enough, this can help automate away common responses.
    // 
    // Remarks:
    // 
    // - Use `"Terminate batch job (Y/N)": "Y\r"` to automatically respond to the terminate batch job prompt on Windows.
    // - The message includes escape sequences so the reply might not happen with styled text.
    // - Each reply can only happen once every second.
    // - Use `"\r"` in the reply to mean the enter key.
    // - To unset a default key, set the value to null.
    // - Restart VS Code if new don't apply.
    "terminal.integrated.autoReplies": {},

    // The number of milliseconds to show the bell within a terminal tab when triggered.
    "terminal.integrated.bellDuration": 1000,

    // A set of command IDs whose keybindings will not be sent to the shell but instead always be handled by VS Code. This allows keybindings that would normally be consumed by the shell to act instead the same as when the terminal is not focused, for example `Ctrl+P` to launch Quick Open.
    // 
    // &nbsp;
    // 
    // Many commands are skipped by default. To override a default and pass that command's keybinding to the shell instead, add the command prefixed with the `-` character. For example add `-workbench.action.quickOpen` to allow `Ctrl+P` to reach the shell.
    // 
    // &nbsp;
    // 
    // The following list of default skipped commands is truncated when viewed in Settings Editor. To see the full list, [open the default settings JSON](command:workbench.action.openRawDefaultSettings 'Open Default Settings (JSON)') and search for the first command from the list below.
    // 
    // &nbsp;
    // 
    // Default Skipped Commands:
    // 
    // - editor.action.accessibilityHelp
    // - editor.action.toggleTabFocusMode
    // - notification.acceptPrimaryAction
    // - notifications.hideList
    // - notifications.hideToasts
    // - runCommands
    // - workbench.action.closeQuickOpen
    // - workbench.action.debug.continue
    // - workbench.action.debug.disconnect
    // - workbench.action.debug.pause
    // - workbench.action.debug.restart
    // - workbench.action.debug.run
    // - workbench.action.debug.start
    // - workbench.action.debug.stepInto
    // - workbench.action.debug.stepOut
    // - workbench.action.debug.stepOver
    // - workbench.action.debug.stop
    // - workbench.action.firstEditorInGroup
    // - workbench.action.focusActiveEditorGroup
    // - workbench.action.focusEighthEditorGroup
    // - workbench.action.focusFifthEditorGroup
    // - workbench.action.focusFirstEditorGroup
    // - workbench.action.focusFourthEditorGroup
    // - workbench.action.focusLastEditorGroup
    // - workbench.action.focusNextPart
    // - workbench.action.focusPreviousPart
    // - workbench.action.focusSecondEditorGroup
    // - workbench.action.focusSeventhEditorGroup
    // - workbench.action.focusSixthEditorGroup
    // - workbench.action.focusThirdEditorGroup
    // - workbench.action.lastEditorInGroup
    // - workbench.action.navigateDown
    // - workbench.action.navigateLeft
    // - workbench.action.navigateRight
    // - workbench.action.navigateUp
    // - workbench.action.nextEditor
    // - workbench.action.nextEditorInGroup
    // - workbench.action.nextPanelView
    // - workbench.action.nextSideBarView
    // - workbench.action.openNextRecentlyUsedEditor
    // - workbench.action.openNextRecentlyUsedEditorInGroup
    // - workbench.action.openPreviousRecentlyUsedEditor
    // - workbench.action.openPreviousRecentlyUsedEditorInGroup
    // - workbench.action.previousEditor
    // - workbench.action.previousEditorInGroup
    // - workbench.action.previousPanelView
    // - workbench.action.previousSideBarView
    // - workbench.action.quickOpen
    // - workbench.action.quickOpenLeastRecentlyUsedEditor
    // - workbench.action.quickOpenLeastRecentlyUsedEditorInGroup
    // - workbench.action.quickOpenPreviousEditor
    // - workbench.action.quickOpenPreviousRecentlyUsedEditor
    // - workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup
    // - workbench.action.quickOpenView
    // - workbench.action.showCommands
    // - workbench.action.tasks.build
    // - workbench.action.tasks.reRunTask
    // - workbench.action.tasks.rerunForActiveTerminal
    // - workbench.action.tasks.restartTask
    // - workbench.action.tasks.runTask
    // - workbench.action.tasks.showLog
    // - workbench.action.tasks.showTasks
    // - workbench.action.tasks.terminate
    // - workbench.action.tasks.test
    // - workbench.action.terminal.acceptSelectedSuggestion
    // - workbench.action.terminal.acceptSelectedSuggestionEnter
    // - workbench.action.terminal.chat.cancel
    // - workbench.action.terminal.chat.close
    // - workbench.action.terminal.chat.discard
    // - workbench.action.terminal.chat.feedbackHelpful
    // - workbench.action.terminal.chat.feedbackReportIssue
    // - workbench.action.terminal.chat.feedbackUnhelpful
    // - workbench.action.terminal.chat.insertCommand
    // - workbench.action.terminal.chat.makeRequest
    // - workbench.action.terminal.chat.runCommand
    // - workbench.action.terminal.chat.start
    // - workbench.action.terminal.chat.viewInChat
    // - workbench.action.terminal.clear
    // - workbench.action.terminal.clearSelection
    // - workbench.action.terminal.copyAndClearSelection
    // - workbench.action.terminal.copyLastCommand
    // - workbench.action.terminal.copyLastCommandAndLastCommandOutput
    // - workbench.action.terminal.copyLastCommandOutput
    // - workbench.action.terminal.copySelection
    // - workbench.action.terminal.copySelectionAsHtml
    // - workbench.action.terminal.deleteToLineStart
    // - workbench.action.terminal.deleteWordLeft
    // - workbench.action.terminal.deleteWordRight
    // - workbench.action.terminal.findNext
    // - workbench.action.terminal.findPrevious
    // - workbench.action.terminal.focus
    // - workbench.action.terminal.focusAccessibleBuffer
    // - workbench.action.terminal.focusAtIndex1
    // - workbench.action.terminal.focusAtIndex2
    // - workbench.action.terminal.focusAtIndex3
    // - workbench.action.terminal.focusAtIndex4
    // - workbench.action.terminal.focusAtIndex5
    // - workbench.action.terminal.focusAtIndex6
    // - workbench.action.terminal.focusAtIndex7
    // - workbench.action.terminal.focusAtIndex8
    // - workbench.action.terminal.focusAtIndex9
    // - workbench.action.terminal.focusFind
    // - workbench.action.terminal.focusHover
    // - workbench.action.terminal.focusNext
    // - workbench.action.terminal.focusNextPane
    // - workbench.action.terminal.focusPrevious
    // - workbench.action.terminal.focusPreviousPane
    // - workbench.action.terminal.goToRecentDirectory
    // - workbench.action.terminal.hideFind
    // - workbench.action.terminal.hideSuggestWidget
    // - workbench.action.terminal.kill
    // - workbench.action.terminal.killEditor
    // - workbench.action.terminal.moveToEditor
    // - workbench.action.terminal.moveToLineEnd
    // - workbench.action.terminal.moveToLineStart
    // - workbench.action.terminal.moveToTerminalPanel
    // - workbench.action.terminal.new
    // - workbench.action.terminal.newInActiveWorkspace
    // - workbench.action.terminal.newInNewWindow
    // - workbench.action.terminal.paste
    // - workbench.action.terminal.pasteSelection
    // - workbench.action.terminal.resizePaneDown
    // - workbench.action.terminal.resizePaneLeft
    // - workbench.action.terminal.resizePaneRight
    // - workbench.action.terminal.resizePaneUp
    // - workbench.action.terminal.runActiveFile
    // - workbench.action.terminal.runRecentCommand
    // - workbench.action.terminal.runSelectedText
    // - workbench.action.terminal.scrollDown
    // - workbench.action.terminal.scrollDownPage
    // - workbench.action.terminal.scrollToBottom
    // - workbench.action.terminal.scrollToNextCommand
    // - workbench.action.terminal.scrollToPreviousCommand
    // - workbench.action.terminal.scrollToTop
    // - workbench.action.terminal.scrollUp
    // - workbench.action.terminal.scrollUpPage
    // - workbench.action.terminal.searchWorkspace
    // - workbench.action.terminal.selectAll
    // - workbench.action.terminal.selectNextPageSuggestion
    // - workbench.action.terminal.selectNextSuggestion
    // - workbench.action.terminal.selectPrevPageSuggestion
    // - workbench.action.terminal.selectPrevSuggestion
    // - workbench.action.terminal.selectToNextCommand
    // - workbench.action.terminal.selectToNextLine
    // - workbench.action.terminal.selectToPreviousCommand
    // - workbench.action.terminal.selectToPreviousLine
    // - workbench.action.terminal.sendSequence
    // - workbench.action.terminal.sizeToContentWidth
    // - workbench.action.terminal.split
    // - workbench.action.terminal.splitInActiveWorkspace
    // - workbench.action.terminal.stopVoice
    // - workbench.action.terminal.suggestToggleDetails
    // - workbench.action.terminal.suggestToggleDetailsFocus
    // - workbench.action.terminal.toggleFindCaseSensitive
    // - workbench.action.terminal.toggleFindRegex
    // - workbench.action.terminal.toggleFindWholeWord
    // - workbench.action.terminal.toggleTerminal
    // - workbench.action.terminal.triggerSuggest
    // - workbench.action.toggleFullScreen
    // - workbench.action.toggleMaximizedPanel
    // - workbench.action.togglePanel
    "terminal.integrated.commandsToSkipShell": [],

    // Controls whether to confirm when the window closes if there are active terminal sessions. Background terminals like those launched by some extensions will not trigger the confirmation.
    //  - never: Never confirm.
    //  - always: Always confirm if there are terminals.
    //  - hasChildProcesses: Confirm if there are any terminals that have child processes.
    "terminal.integrated.confirmOnExit": "never",

    // Controls whether to confirm killing terminals when they have child processes. When set to editor, terminals in the editor area will be marked as changed when they have child processes. Note that child process detection may not work well for shells like Git Bash which don't run their processes as child processes of the shell. Background terminals like those launched by some extensions will not trigger the confirmation.
    //  - never: Never confirm.
    //  - editor: Confirm if the terminal is in the editor.
    //  - panel: Confirm if the terminal is in the panel.
    //  - always: Confirm if the terminal is either in the editor or panel.
    "terminal.integrated.confirmOnKill": "editor",

    // Controls whether text selected in the terminal will be copied to the clipboard.
    "terminal.integrated.copyOnSelection": false,

    // Controls whether the terminal cursor blinks.
    "terminal.integrated.cursorBlinking": false,

    // Controls the style of terminal cursor when the terminal is focused.
    "terminal.integrated.cursorStyle": "block",

    // Controls the style of terminal cursor when the terminal is not focused.
    "terminal.integrated.cursorStyleInactive": "outline",

    // Controls the width of the cursor when `terminal.integrated.cursorStyle` is set to `line`.
    "terminal.integrated.cursorWidth": 1,

    // Whether to draw custom glyphs for block element and box drawing characters instead of using the font, which typically yields better rendering with continuous lines. Note that this doesn't work when `terminal.integrated.gpuAcceleration` is disabled.
    "terminal.integrated.customGlyphs": true,

    // An explicit start path where the terminal will be launched, this is used as the current working directory (cwd) for the shell process. This may be particularly useful in workspace settings if the root directory is not a convenient cwd.
    "terminal.integrated.cwd": "",

    // Controls where newly created terminals will appear.
    //  - editor: Create terminals in the editor
    //  - view: Create terminals in the terminal view
    "terminal.integrated.defaultLocation": "view",

    // The default terminal profile on Linux.
    "terminal.integrated.defaultProfile.linux": null,

    // The default terminal profile on macOS.
    "terminal.integrated.defaultProfile.osx": null,

    // The default terminal profile on Windows.
    //  - null: Automatically detect the default
    //  - PowerShell: $(terminal-powershell) PowerShell
    // - path: C:\Program Files\PowerShell\7\pwsh.exe
    // - args: ['-NoLogo']
    //  - Windows PowerShell: $(terminal-powershell) Windows PowerShell
    // - path: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
    // - args: ['-NoLogo']
    //  - Git Bash: $(terminal-git-bash) Git Bash
    // - path: C:\Program Files\Git\bin\bash.exe
    // - args: ['--login','-i']
    //  - Command Prompt: $(terminal-cmd) Command Prompt
    // - path: C:\WINDOWS\System32\cmd.exe
    // - args: []
    //  - JavaScript Debug Terminal: $($(debug)) JavaScript Debug Terminal
    // - extensionIdentifier: ms-vscode.js-debug
    //  - Azure Cloud Shell (Bash): $($(azure)) Azure Cloud Shell (Bash)
    // - extensionIdentifier: ms-azuretools.vscode-azureresourcegroups
    //  - Azure Cloud Shell (PowerShell): $($(azure)) Azure Cloud Shell (PowerShell)
    // - extensionIdentifier: ms-azuretools.vscode-azureresourcegroups
    //  - Spell Checker REPL: $(terminal) Spell Checker REPL
    // - extensionIdentifier: streetsidesoftware.code-spell-checker
    "terminal.integrated.defaultProfile.windows": null,

    // Controls whether to detect and set the `$LANG` environment variable to a UTF-8 compliant option since VS Code's terminal only supports UTF-8 encoded data coming from the shell.
    //  - auto: Set the `$LANG` environment variable if the existing variable does not exist or it does not end in `'.UTF-8'`.
    //  - off: Do not set the `$LANG` environment variable.
    //  - on: Always set the `$LANG` environment variable.
    "terminal.integrated.detectLocale": "auto",

    // Enable developer mode for the terminal. This shows additional debug information and visualizations for shell integration sequences.
    "terminal.integrated.developer.devMode": false,

    // Simulated latency in milliseconds applied to all calls made to the pty host. This is useful for testing terminal behavior under high latency conditions.
    "terminal.integrated.developer.ptyHost.latency": 0,

    // Simulated startup delay in milliseconds for the pty host process. This is useful for testing terminal initialization under slow startup conditions.
    "terminal.integrated.developer.ptyHost.startupDelay": 0,

    // Controls whether bold text in the terminal will always use the "bright" ANSI color variant.
    "terminal.integrated.drawBoldTextInBrightColors": true,

    // This is now deprecated. Instead use the `terminal.integrated.enableVisualBell` and `accessibility.signals.terminalBell` settings.
    // 
    "terminal.integrated.enableBell": false,

    // Whether to enable file links in terminals. Links can be slow when working on a network drive in particular because each file link is verified against the file system. Changing this will take effect only in new terminals.
    //  - off: Always off.
    //  - on: Always on.
    //  - notRemote: Enable only when not in a remote workspace.
    "terminal.integrated.enableFileLinks": "on",

    // Enables image support in the terminal, this will only work when `terminal.integrated.gpuAcceleration#` is enabled. Both sixel and iTerm's inline image protocol are supported on Linux and macOS. This will only work on Windows for versions of ConPTY >= v2 which is shipped with Windows itself, see also `#terminal.integrated.windowsUseConptyDll`. Images will currently not be restored between window reloads/reconnects.
    "terminal.integrated.enableImages": false,

    // Controls whether to show a warning dialog when pasting multiple lines into the terminal.
    //  - auto: Enable the warning but do not show it when:
    // 
    // - Bracketed paste mode is enabled (the shell supports multi-line paste natively)
    // - The paste is handled by the shell's readline (in the case of pwsh)
    //  - always: Always show the warning if the text contains a new line.
    //  - never: Never show the warning.
    "terminal.integrated.enableMultiLinePasteWarning": "auto",

    // Persist terminal sessions/history for the workspace across window reloads.
    "terminal.integrated.enablePersistentSessions": true,

    // Controls whether the visual terminal bell is enabled. This shows up next to the terminal's name.
    "terminal.integrated.enableVisualBell": false,

    // Object with environment variables that will be added to the VS Code process to be used by the terminal on Linux. Set to `null` to delete the environment variable.
    "terminal.integrated.env.linux": {},

    // Object with environment variables that will be added to the VS Code process to be used by the terminal on macOS. Set to `null` to delete the environment variable.
    "terminal.integrated.env.osx": {},

    // Object with environment variables that will be added to the VS Code process to be used by the terminal on Windows. Set to `null` to delete the environment variable.
    "terminal.integrated.env.windows": {},

    // Whether to relaunch terminals automatically if extensions want to contribute to their environment and have not been interacted with yet.
    "terminal.integrated.environmentChangesRelaunch": true,

    // Scrolling speed multiplier when pressing `Alt`.
    "terminal.integrated.fastScrollSensitivity": 5,

    // Controls whether the terminal, accessible buffer, or neither will be focused after `Terminal: Run Selected Text In Active Terminal` has been run.
    //  - terminal: Always focus the terminal.
    //  - accessible-buffer: Always focus the accessible buffer.
    //  - none: Do nothing.
    "terminal.integrated.focusAfterRun": "none",

    // Controls the font family of the terminal. Defaults to `editor.fontFamily`'s value.
    "terminal.integrated.fontFamily": "",

    // Controls whether font ligatures are enabled in the terminal. Ligatures will only work if the configured `terminal.integrated.fontFamily` supports them.
    "terminal.integrated.fontLigatures.enabled": false,

    // When `terminal.integrated.gpuAcceleration#` is enabled and the particular `#terminal.integrated.fontFamily` cannot be parsed, this is the set of character sequences that will always be drawn together. This allows the use of a fixed set of ligatures even when the font isn't supported.
    "terminal.integrated.fontLigatures.fallbackLigatures": [
        "<--",
        "<---",
        "<<-",
        "<-",
        "->",
        "->>",
        "-->",
        "--->",
        "<==",
        "<===",
        "<<=",
        "<=",
        "=>",
        "=>>",
        "==>",
        "===>",
        ">=",
        ">>=",
        "<->",
        "<-->",
        "<--->",
        "<---->",
        "<=>",
        "<==>",
        "<===>",
        "<====>",
        "::",
        ":::",
        "<~~",
        "</",
        "</>",
        "/>",
        "~~>",
        "==",
        "!=",
        "/=",
        "~=",
        "<>",
        "===",
        "!==",
        "!===",
        "<:",
        ":=",
        "*=",
        "*+",
        "<*",
        "<*>",
        "*>",
        "<|",
        "<|>",
        "|>",
        "+*",
        "=*",
        "=:",
        ":>",
        "/*",
        "*/",
        "+++",
        "<!--",
        "<!---"
    ],

    // Controls what font feature settings are used when ligatures are enabled, in the format of the `font-feature-settings` CSS property. Some examples which may be valid depending on the font:
    // 
    // - `"calt" off, "ss03"`
    // - `"liga" on`
    // - `"calt" off, "dlig" on`
    "terminal.integrated.fontLigatures.featureSettings": "\"calt\" on",

    // Controls the font size in pixels of the terminal.
    "terminal.integrated.fontSize": 14,

    // The font weight to use within the terminal for non-bold text. Accepts "normal" and "bold" keywords or numbers between 1 and 1000.
    "terminal.integrated.fontWeight": "normal",

    // The font weight to use within the terminal for bold text. Accepts "normal" and "bold" keywords or numbers between 1 and 1000.
    "terminal.integrated.fontWeightBold": "bold",

    // Controls whether the terminal will leverage the GPU to do its rendering.
    //  - auto: Let VS Code detect which renderer will give the best experience.
    //  - on: Enable GPU acceleration within the terminal.
    //  - off: Disable GPU acceleration within the terminal. The terminal will render much slower when GPU acceleration is off but it should reliably work on all systems.
    "terminal.integrated.gpuAcceleration": "auto",

    // Whether to hide the terminal view when the last terminal is closed. This will only happen when the terminal is the only visible view in the view container.
    "terminal.integrated.hideOnLastClosed": true,

    // Whether to hide the terminal view on startup, avoiding creating a terminal when there are no persistent sessions.
    //  - never: Never hide the terminal view on startup.
    //  - whenEmpty: Only hide the terminal when there are no persistent sessions restored.
    //  - always: Always hide the terminal, even when there are persistent sessions restored.
    "terminal.integrated.hideOnStartup": "never",

    // Controls whether the terminal will ignore bracketed paste mode even if the terminal was put into the mode, omitting the `\x1b[200~` and `\x1b[201~` sequences when pasting. This is useful when the shell is not respecting the mode which can happen in sub-shells for example.
    "terminal.integrated.ignoreBracketedPasteMode": false,

    // A set of process names to ignore when using the `terminal.integrated.confirmOnKill` setting.
    "terminal.integrated.ignoreProcessNames": [
        "starship",
        "oh-my-posh",
        "bash",
        "zsh"
    ],

    // Whether new shells should inherit their environment from VS Code, which may source a login shell to ensure $PATH and other development variables are initialized. This has no effect on Windows.
    "terminal.integrated.inheritEnv": true,

    // Controls if the first terminal without input will show a hint about available actions when it is focused.
    "terminal.integrated.initialHint": true,

    // Controls the letter spacing of the terminal. This is an integer value which represents the number of additional pixels to add between characters.
    "terminal.integrated.letterSpacing": 0,

    // Controls the line height of the terminal. This number is multiplied by the terminal font size to get the actual line-height in pixels.
    "terminal.integrated.lineHeight": 1,

    // When local echo should be enabled. This will override `terminal.integrated.localEchoLatencyThreshold`
    //  - on: Always enabled
    //  - off: Always disabled
    //  - auto: Enabled only for remote workspaces
    "terminal.integrated.localEchoEnabled": "off",

    // Local echo will be disabled when any of these program names are found in the terminal title.
    "terminal.integrated.localEchoExcludePrograms": [
        "vim",
        "vi",
        "nano",
        "tmux"
    ],

    // Length of network delay, in milliseconds, where local edits will be echoed on the terminal without waiting for server acknowledgement. If '0', local echo will always be on, and if '-1' it will be disabled.
    "terminal.integrated.localEchoLatencyThreshold": 30,

    // Terminal style of locally echoed text; either a font style or an RGB color.
    "terminal.integrated.localEchoStyle": "dim",

    // Controls whether to force selection when using Option+click on macOS. This will force a regular (line) selection and disallow the use of column selection mode. This enables copying and pasting using the regular terminal selection, for example, when mouse mode is enabled in tmux.
    "terminal.integrated.macOptionClickForcesSelection": false,

    // Controls whether to treat the option key as the meta key in the terminal on macOS.
    "terminal.integrated.macOptionIsMeta": false,

    // Controls how terminal reacts to middle click.
    //  - default: The platform default to focus the terminal. On Linux this will also paste the selection.
    //  - paste: Paste on middle click.
    "terminal.integrated.middleClickBehavior": "default",

    // When set, the foreground color of each cell will change to try meet the contrast ratio specified. Note that this will not apply to `powerline` characters per #146406. Example values:
    // 
    // - 1: Do nothing and use the standard theme colors.
    // - 4.5: [WCAG AA compliance (minimum)](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html) (default).
    // - 7: [WCAG AAA compliance (enhanced)](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast7.html).
    // - 21: White on black or black on white.
    "terminal.integrated.minimumContrastRatio": 4.5,

    // A multiplier to be used on the `deltaY` of mouse wheel scroll events.
    "terminal.integrated.mouseWheelScrollSensitivity": 1,

    // Zoom the font of the terminal when using mouse wheel and holding `Ctrl`.
    "terminal.integrated.mouseWheelZoom": false,

    // When the terminal process must be shut down (for example on window or application close), this determines when the previous terminal session contents/history should be restored and processes be recreated when the workspace is next opened.
    // 
    // Caveats:
    // 
    // - Restoring of the process current working directory depends on whether it is supported by the shell.
    // - Time to persist the session during shutdown is limited, so it may be aborted when using high-latency remote connections.
    //  - onExit: Revive the processes after the last window is closed on Windows/Linux or when the `workbench.action.quit` command is triggered (command palette, keybinding, menu).
    //  - onExitAndWindowClose: Revive the processes after the last window is closed on Windows/Linux or when the `workbench.action.quit` command is triggered (command palette, keybinding, menu), or when the window is closed.
    //  - never: Never restore the terminal buffers or recreate the process.
    "terminal.integrated.persistentSessionReviveProcess": "onExit",

    // Controls the maximum amount of lines that will be restored when reconnecting to a persistent terminal session. Increasing this will restore more lines of scrollback at the cost of more memory and increase the time it takes to connect to terminals on start up. This setting requires a restart to take effect and should be set to a value less than or equal to `terminal.integrated.scrollback`.
    "terminal.integrated.persistentSessionScrollback": 100,

    // A set of terminal profile customizations for Linux which allows adding, removing or changing how terminals are launched. Profiles are made up of a mandatory path, optional arguments and other presentation options.
    // 
    // To override an existing profile use its profile name as the key, for example:
    // 
    // ```json
    // "terminal.integrated.profile.linux": {
    //   "bash": null
    // }
    // ```
    // 
    // [Read more about configuring profiles](https://code.visualstudio.com/docs/terminal/profiles).
    "terminal.integrated.profiles.linux": {
        "bash": {
            "path": "bash",
            "icon": "terminal-bash"
        },
        "zsh": {
            "path": "zsh"
        },
        "fish": {
            "path": "fish"
        },
        "tmux": {
            "path": "tmux",
            "icon": "terminal-tmux"
        },
        "pwsh": {
            "path": "pwsh",
            "icon": "terminal-powershell"
        }
    },

    // A set of terminal profile customizations for Mac which allows adding, removing or changing how terminals are launched. Profiles are made up of a mandatory path, optional arguments and other presentation options.
    // 
    // To override an existing profile use its profile name as the key, for example:
    // 
    // ```json
    // "terminal.integrated.profile.osx": {
    //   "bash": null
    // }
    // ```
    // 
    // [Read more about configuring profiles](https://code.visualstudio.com/docs/terminal/profiles).
    "terminal.integrated.profiles.osx": {
        "bash": {
            "path": "bash",
            "args": [
                "-l"
            ],
            "icon": "terminal-bash"
        },
        "zsh": {
            "path": "zsh",
            "args": [
                "-l"
            ]
        },
        "fish": {
            "path": "fish",
            "args": [
                "-l"
            ]
        },
        "tmux": {
            "path": "tmux",
            "icon": "terminal-tmux"
        },
        "pwsh": {
            "path": "pwsh",
            "icon": "terminal-powershell"
        }
    },

    // A set of terminal profile customizations for Windows which allows adding, removing or changing how terminals are launched. Profiles are made up of a mandatory path, optional arguments and other presentation options.
    // 
    // To override an existing profile use its profile name as the key, for example:
    // 
    // ```json
    // "terminal.integrated.profile.windows": {
    //   "bash": null
    // }
    // ```
    // 
    // [Read more about configuring profiles](https://code.visualstudio.com/docs/terminal/profiles).
    "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [],
            "icon": {
                "id": "terminal-cmd"
            }
        },
        "Git Bash": {
            "source": "Git Bash",
            "icon": "terminal-git-bash"
        }
    },

    // Whether to rescale glyphs horizontally that are a single cell wide but have glyphs that would overlap following cell(s). This typically happens for ambiguous width characters (eg. the roman numeral characters U+2160+) which aren't featured in monospace fonts. Emoji glyphs are never rescaled.
    "terminal.integrated.rescaleOverlappingGlyphs": true,

    // Controls how terminal reacts to right click.
    //  - default: Show the context menu.
    //  - copyPaste: Copy when there is a selection, otherwise paste.
    //  - paste: Paste on right click.
    //  - selectWord: Select the word under the cursor and show the context menu.
    //  - nothing: Do nothing and pass event to terminal.
    "terminal.integrated.rightClickBehavior": "copyPaste",

    // Controls the maximum number of lines the terminal keeps in its buffer. We pre-allocate memory based on this value in order to ensure a smooth experience. As such, as the value increases, so will the amount of memory.
    "terminal.integrated.scrollback": 1000,

    // Dispatches most keybindings to the terminal instead of the workbench, overriding `terminal.integrated.commandsToSkipShell`, which can be used alternatively for fine tuning.
    "terminal.integrated.sendKeybindingsToShell": false,

    // When shell integration is enabled, adds a decoration for each command.
    //  - both: Show decorations in the gutter (left) and overview ruler (right)
    //  - gutter: Show gutter decorations to the left of the terminal
    //  - overviewRuler: Show overview ruler decorations to the right of the terminal
    //  - never: Do not show decorations
    "terminal.integrated.shellIntegration.decorationsEnabled": "both",

    // Determines whether or not shell integration is auto-injected to support features like enhanced command tracking and current working directory detection. 
    // 
    // Shell integration works by injecting the shell with a startup script. The script gives VS Code insight into what is happening within the terminal.
    // 
    // Supported shells:
    // 
    // - Linux/macOS: bash, fish, pwsh, zsh
    //  - Windows: pwsh, git bash
    // 
    // This setting applies only when terminals are created, so you will need to restart your terminals for it to take effect.
    // 
    //  Note that the script injection may not work if you have custom arguments defined in the terminal profile, have enabled `editor.accessibilitySupport#`, have a [complex bash `PROMPT_COMMAND`](https://code.visualstudio.com/docs/editor/integrated-terminal#_complex-bash-promptcommand), or other unsupported setup. To disable decorations, see `#terminal.integrated.shellIntegration.decorationsEnabled`
    "terminal.integrated.shellIntegration.enabled": true,

    // Controls whether to report the shell environment, enabling its use in features such as `terminal.integrated.suggest.enabled`. This may cause a slowdown when printing your shell's prompt.
    "terminal.integrated.shellIntegration.environmentReporting": true,

    // Controls the number of recently used commands to keep in the terminal command history. Set to 0 to disable terminal command history.
    "terminal.integrated.shellIntegration.history": 100,

    // When shell integration is enabled, enables quick fixes for terminal commands that appear as a lightbulb or sparkle icon to the left of the prompt.
    "terminal.integrated.shellIntegration.quickFixEnabled": true,

    // Whether to show the command guide when hovering over a command in the terminal.
    "terminal.integrated.shellIntegration.showCommandGuide": true,

    // Configures the duration in milliseconds to wait for shell integration after launch before declaring it's not there. Set to `0` to wait the minimum time (500ms), the default value `-1` means the wait time is variable based on whether shell integration injection is enabled and whether it's a remote window. Consider setting this to a small value if you intentionally disabled shell integration, or a large value if your shell starts very slowly.
    "terminal.integrated.shellIntegration.timeout": -1,

    // Controls whether to show the alert "The terminal process terminated with exit code" when exit code is non-zero.
    "terminal.integrated.showExitAlert": true,

    // Whether to show hovers for links in the terminal output.
    "terminal.integrated.showLinkHover": true,

    // Controls whether the terminal will scroll using an animation.
    "terminal.integrated.smoothScrolling": false,

    // Controls the working directory a split terminal starts with.
    //  - workspaceRoot: A new split terminal will use the workspace root as the working directory. In a multi-root workspace a choice for which root folder to use is offered.
    //  - initial: A new split terminal will use the working directory that the parent terminal started with.
    //  - inherited: On macOS and Linux, a new split terminal will use the working directory of the parent terminal. On Windows, this behaves the same as initial.
    "terminal.integrated.splitCwd": "inherited",

    // Shows the current command at the top of the terminal. This feature requires [shell integration](https://code.visualstudio.com/docs/terminal/shell-integration) to be activated. See `terminal.integrated.shellIntegration.enabled`.
    "terminal.integrated.stickyScroll.enabled": true,

    // Defines the maximum number of sticky lines to show. Sticky scroll lines will never exceed 40% of the viewport regardless of this setting.
    "terminal.integrated.stickyScroll.maxLineCount": 5,

    // Controls whether to enable $CDPATH support which exposes children of the folders in the $CDPATH variable regardless of the current working directory. $CDPATH is expected to be semi colon-separated on Windows and colon-separated on other platforms.
    //  - off: Disable the feature.
    //  - relative: Enable the feature and use relative paths.
    //  - absolute: Enable the feature and use absolute paths. This is useful when the shell doesn't natively support `$CDPATH`.
    "terminal.integrated.suggest.cdPath": "absolute",

    // Enables terminal intellisense suggestions (preview) for supported shells (PowerShell v7+, zsh, bash, fish) when `terminal.integrated.shellIntegration.enabled` is set to `true`.
    "terminal.integrated.suggest.enabled": true,

    // Controls whether the shell's inline suggestion should be detected and how it is scored.
    //  - off: Disable the feature.
    //  - alwaysOnTopExceptExactMatch: Enable the feature and sort the inline suggestion without forcing it to be on top. This means that exact matches will be will be above the inline suggestion.
    //  - alwaysOnTop: Enable the feature and always put the inline suggestion on top.
    "terminal.integrated.suggest.inlineSuggestion": "alwaysOnTop",

    // Controls whether a space is automatically inserted after accepting a suggestion and re-trigger suggestions. Folders and symbolic link folders will never have a trailing space added.
    "terminal.integrated.suggest.insertTrailingSpace": false,

    // Controls whether suggestions should automatically show up while typing. Also be aware of the `terminal.integrated.suggest.suggestOnTriggerCharacters`-setting which controls if suggestions are triggered by special characters.
    "terminal.integrated.suggest.quickSuggestions": {
        "commands": "on",
        "arguments": "on",
        "unknown": "off"
    },

    // Controls whether suggestions should run immediately when `Enter` (not `Tab`) is used to accept the result.
    //  - never: Never run on `Enter`.
    //  - exactMatch: Run on `Enter` when the suggestion is typed in its entirety.
    //  - exactMatchIgnoreExtension: Run on `Enter` when the suggestion is typed in its entirety or when a file is typed without its extension included.
    //  - always: Always run on `Enter`.
    "terminal.integrated.suggest.runOnEnter": "never",

    // Controls how suggestion selection works in the integrated terminal.
    //  - partial: Partially select a suggestion when automatically triggering IntelliSense. `Tab` can be used to accept the first suggestion, only after navigating the suggestions via `Down` will `Enter` also accept the active suggestion.
    //  - always: Always select a suggestion when automatically triggering IntelliSense. `Enter` or `Tab` can be used to accept the first suggestion.
    //  - never: Never select a suggestion when automatically triggering IntelliSense. The list must be navigated via `Down` before `Enter` or `Tab` can be used to accept the active suggestion.
    "terminal.integrated.suggest.selectionMode": "partial",

    // Controls whether the terminal suggestions status bar should be shown.
    "terminal.integrated.suggest.showStatusBar": true,

    // Controls whether suggestions should automatically show up when typing trigger characters.
    "terminal.integrated.suggest.suggestOnTriggerCharacters": true,

    // Determines whether the up arrow key navigates the command history when focus is on the first suggestion and navigation has not yet occurred. When set to false, the up arrow will move focus to the last suggestion instead.
    "terminal.integrated.suggest.upArrowNavigatesHistory": true,

    // A set of windows command executable extensions that will be included as suggestions in the terminal.
    // 
    // Many executables are included by default, listed below:
    // 
    // - bat
    // - cmd
    // - com
    // - exe
    // - jar
    // - js
    // - msi
    // - pl
    // - ps1
    // - py
    // - rb
    // - sh
    // - vbs.
    // 
    // To exclude an extension, set it to `false`
    // 
    // . To include one not in the list, add it and set it to `true`.
    "terminal.integrated.suggest.windowsExecutableExtensions": {},

    // A theme color ID to associate with terminal icons by default.
    "terminal.integrated.tabs.defaultColor": null,

    // A codicon ID to associate with terminal icons by default.
    //  - add: $(add)
    //  - plus: $(plus)
    //  - gist-new: $(gist-new)
    //  - repo-create: $(repo-create)
    //  - lightbulb: $(lightbulb)
    //  - light-bulb: $(light-bulb)
    //  - repo: $(repo)
    //  - repo-delete: $(repo-delete)
    //  - gist-fork: $(gist-fork)
    //  - repo-forked: $(repo-forked)
    //  - git-pull-request: $(git-pull-request)
    //  - git-pull-request-abandoned: $(git-pull-request-abandoned)
    //  - record-keys: $(record-keys)
    //  - keyboard: $(keyboard)
    //  - tag: $(tag)
    //  - git-pull-request-label: $(git-pull-request-label)
    //  - tag-add: $(tag-add)
    //  - tag-remove: $(tag-remove)
    //  - person: $(person)
    //  - person-follow: $(person-follow)
    //  - person-outline: $(person-outline)
    //  - person-filled: $(person-filled)
    //  - source-control: $(source-control)
    //  - mirror: $(mirror)
    //  - mirror-public: $(mirror-public)
    //  - star: $(star)
    //  - star-add: $(star-add)
    //  - star-delete: $(star-delete)
    //  - star-empty: $(star-empty)
    //  - comment: $(comment)
    //  - comment-add: $(comment-add)
    //  - alert: $(alert)
    //  - warning: $(warning)
    //  - search: $(search)
    //  - search-save: $(search-save)
    //  - log-out: $(log-out)
    //  - sign-out: $(sign-out)
    //  - log-in: $(log-in)
    //  - sign-in: $(sign-in)
    //  - eye: $(eye)
    //  - eye-unwatch: $(eye-unwatch)
    //  - eye-watch: $(eye-watch)
    //  - circle-filled: $(circle-filled)
    //  - primitive-dot: $(primitive-dot)
    //  - close-dirty: $(close-dirty)
    //  - debug-breakpoint: $(debug-breakpoint)
    //  - debug-breakpoint-disabled: $(debug-breakpoint-disabled)
    //  - debug-hint: $(debug-hint)
    //  - terminal-decoration-success: $(terminal-decoration-success)
    //  - primitive-square: $(primitive-square)
    //  - edit: $(edit)
    //  - pencil: $(pencil)
    //  - info: $(info)
    //  - issue-opened: $(issue-opened)
    //  - gist-private: $(gist-private)
    //  - git-fork-private: $(git-fork-private)
    //  - lock: $(lock)
    //  - mirror-private: $(mirror-private)
    //  - close: $(close)
    //  - remove-close: $(remove-close)
    //  - x: $(x)
    //  - repo-sync: $(repo-sync)
    //  - sync: $(sync)
    //  - clone: $(clone)
    //  - desktop-download: $(desktop-download)
    //  - beaker: $(beaker)
    //  - microscope: $(microscope)
    //  - vm: $(vm)
    //  - device-desktop: $(device-desktop)
    //  - file: $(file)
    //  - more: $(more)
    //  - ellipsis: $(ellipsis)
    //  - kebab-horizontal: $(kebab-horizontal)
    //  - mail-reply: $(mail-reply)
    //  - reply: $(reply)
    //  - organization: $(organization)
    //  - organization-filled: $(organization-filled)
    //  - organization-outline: $(organization-outline)
    //  - new-file: $(new-file)
    //  - file-add: $(file-add)
    //  - new-folder: $(new-folder)
    //  - file-directory-create: $(file-directory-create)
    //  - trash: $(trash)
    //  - trashcan: $(trashcan)
    //  - history: $(history)
    //  - clock: $(clock)
    //  - folder: $(folder)
    //  - file-directory: $(file-directory)
    //  - symbol-folder: $(symbol-folder)
    //  - logo-github: $(logo-github)
    //  - mark-github: $(mark-github)
    //  - github: $(github)
    //  - terminal: $(terminal)
    //  - console: $(console)
    //  - repl: $(repl)
    //  - zap: $(zap)
    //  - symbol-event: $(symbol-event)
    //  - error: $(error)
    //  - stop: $(stop)
    //  - variable: $(variable)
    //  - symbol-variable: $(symbol-variable)
    //  - array: $(array)
    //  - symbol-array: $(symbol-array)
    //  - symbol-module: $(symbol-module)
    //  - symbol-package: $(symbol-package)
    //  - symbol-namespace: $(symbol-namespace)
    //  - symbol-object: $(symbol-object)
    //  - symbol-method: $(symbol-method)
    //  - symbol-function: $(symbol-function)
    //  - symbol-constructor: $(symbol-constructor)
    //  - symbol-boolean: $(symbol-boolean)
    //  - symbol-null: $(symbol-null)
    //  - symbol-numeric: $(symbol-numeric)
    //  - symbol-number: $(symbol-number)
    //  - symbol-structure: $(symbol-structure)
    //  - symbol-struct: $(symbol-struct)
    //  - symbol-parameter: $(symbol-parameter)
    //  - symbol-type-parameter: $(symbol-type-parameter)
    //  - symbol-key: $(symbol-key)
    //  - symbol-text: $(symbol-text)
    //  - symbol-reference: $(symbol-reference)
    //  - go-to-file: $(go-to-file)
    //  - symbol-enum: $(symbol-enum)
    //  - symbol-value: $(symbol-value)
    //  - symbol-ruler: $(symbol-ruler)
    //  - symbol-unit: $(symbol-unit)
    //  - activate-breakpoints: $(activate-breakpoints)
    //  - archive: $(archive)
    //  - arrow-both: $(arrow-both)
    //  - arrow-down: $(arrow-down)
    //  - arrow-left: $(arrow-left)
    //  - arrow-right: $(arrow-right)
    //  - arrow-small-down: $(arrow-small-down)
    //  - arrow-small-left: $(arrow-small-left)
    //  - arrow-small-right: $(arrow-small-right)
    //  - arrow-small-up: $(arrow-small-up)
    //  - arrow-up: $(arrow-up)
    //  - bell: $(bell)
    //  - bold: $(bold)
    //  - book: $(book)
    //  - bookmark: $(bookmark)
    //  - debug-breakpoint-conditional-unverified: $(debug-breakpoint-conditional-unverified)
    //  - debug-breakpoint-conditional: $(debug-breakpoint-conditional)
    //  - debug-breakpoint-conditional-disabled: $(debug-breakpoint-conditional-disabled)
    //  - debug-breakpoint-data-unverified: $(debug-breakpoint-data-unverified)
    //  - debug-breakpoint-data: $(debug-breakpoint-data)
    //  - debug-breakpoint-data-disabled: $(debug-breakpoint-data-disabled)
    //  - debug-breakpoint-log-unverified: $(debug-breakpoint-log-unverified)
    //  - debug-breakpoint-log: $(debug-breakpoint-log)
    //  - debug-breakpoint-log-disabled: $(debug-breakpoint-log-disabled)
    //  - briefcase: $(briefcase)
    //  - broadcast: $(broadcast)
    //  - browser: $(browser)
    //  - bug: $(bug)
    //  - calendar: $(calendar)
    //  - case-sensitive: $(case-sensitive)
    //  - check: $(check)
    //  - checklist: $(checklist)
    //  - chevron-down: $(chevron-down)
    //  - chevron-left: $(chevron-left)
    //  - chevron-right: $(chevron-right)
    //  - chevron-up: $(chevron-up)
    //  - chrome-close: $(chrome-close)
    //  - chrome-maximize: $(chrome-maximize)
    //  - chrome-minimize: $(chrome-minimize)
    //  - chrome-restore: $(chrome-restore)
    //  - circle-outline: $(circle-outline)
    //  - circle: $(circle)
    //  - debug-breakpoint-unverified: $(debug-breakpoint-unverified)
    //  - terminal-decoration-incomplete: $(terminal-decoration-incomplete)
    //  - circle-slash: $(circle-slash)
    //  - circuit-board: $(circuit-board)
    //  - clear-all: $(clear-all)
    //  - clippy: $(clippy)
    //  - close-all: $(close-all)
    //  - cloud-download: $(cloud-download)
    //  - cloud-upload: $(cloud-upload)
    //  - code: $(code)
    //  - collapse-all: $(collapse-all)
    //  - color-mode: $(color-mode)
    //  - comment-discussion: $(comment-discussion)
    //  - credit-card: $(credit-card)
    //  - dash: $(dash)
    //  - dashboard: $(dashboard)
    //  - database: $(database)
    //  - debug-continue: $(debug-continue)
    //  - debug-disconnect: $(debug-disconnect)
    //  - debug-pause: $(debug-pause)
    //  - debug-restart: $(debug-restart)
    //  - debug-start: $(debug-start)
    //  - debug-step-into: $(debug-step-into)
    //  - debug-step-out: $(debug-step-out)
    //  - debug-step-over: $(debug-step-over)
    //  - debug-stop: $(debug-stop)
    //  - debug: $(debug)
    //  - device-camera-video: $(device-camera-video)
    //  - device-camera: $(device-camera)
    //  - device-mobile: $(device-mobile)
    //  - diff-added: $(diff-added)
    //  - diff-ignored: $(diff-ignored)
    //  - diff-modified: $(diff-modified)
    //  - diff-removed: $(diff-removed)
    //  - diff-renamed: $(diff-renamed)
    //  - diff: $(diff)
    //  - diff-sidebyside: $(diff-sidebyside)
    //  - discard: $(discard)
    //  - editor-layout: $(editor-layout)
    //  - empty-window: $(empty-window)
    //  - exclude: $(exclude)
    //  - extensions: $(extensions)
    //  - eye-closed: $(eye-closed)
    //  - file-binary: $(file-binary)
    //  - file-code: $(file-code)
    //  - file-media: $(file-media)
    //  - file-pdf: $(file-pdf)
    //  - file-submodule: $(file-submodule)
    //  - file-symlink-directory: $(file-symlink-directory)
    //  - file-symlink-file: $(file-symlink-file)
    //  - file-zip: $(file-zip)
    //  - files: $(files)
    //  - filter: $(filter)
    //  - flame: $(flame)
    //  - fold-down: $(fold-down)
    //  - fold-up: $(fold-up)
    //  - fold: $(fold)
    //  - folder-active: $(folder-active)
    //  - folder-opened: $(folder-opened)
    //  - gear: $(gear)
    //  - gift: $(gift)
    //  - gist-secret: $(gist-secret)
    //  - gist: $(gist)
    //  - git-commit: $(git-commit)
    //  - git-compare: $(git-compare)
    //  - compare-changes: $(compare-changes)
    //  - git-merge: $(git-merge)
    //  - github-action: $(github-action)
    //  - github-alt: $(github-alt)
    //  - globe: $(globe)
    //  - grabber: $(grabber)
    //  - graph: $(graph)
    //  - gripper: $(gripper)
    //  - heart: $(heart)
    //  - home: $(home)
    //  - horizontal-rule: $(horizontal-rule)
    //  - hubot: $(hubot)
    //  - inbox: $(inbox)
    //  - issue-reopened: $(issue-reopened)
    //  - issues: $(issues)
    //  - italic: $(italic)
    //  - jersey: $(jersey)
    //  - json: $(json)
    //  - kebab-vertical: $(kebab-vertical)
    //  - key: $(key)
    //  - law: $(law)
    //  - lightbulb-autofix: $(lightbulb-autofix)
    //  - link-external: $(link-external)
    //  - link: $(link)
    //  - list-ordered: $(list-ordered)
    //  - list-unordered: $(list-unordered)
    //  - live-share: $(live-share)
    //  - loading: $(loading)
    //  - location: $(location)
    //  - mail-read: $(mail-read)
    //  - mail: $(mail)
    //  - markdown: $(markdown)
    //  - megaphone: $(megaphone)
    //  - mention: $(mention)
    //  - milestone: $(milestone)
    //  - git-pull-request-milestone: $(git-pull-request-milestone)
    //  - mortar-board: $(mortar-board)
    //  - move: $(move)
    //  - multiple-windows: $(multiple-windows)
    //  - mute: $(mute)
    //  - no-newline: $(no-newline)
    //  - note: $(note)
    //  - octoface: $(octoface)
    //  - open-preview: $(open-preview)
    //  - package: $(package)
    //  - paintcan: $(paintcan)
    //  - pin: $(pin)
    //  - play: $(play)
    //  - run: $(run)
    //  - plug: $(plug)
    //  - preserve-case: $(preserve-case)
    //  - preview: $(preview)
    //  - project: $(project)
    //  - pulse: $(pulse)
    //  - question: $(question)
    //  - quote: $(quote)
    //  - radio-tower: $(radio-tower)
    //  - reactions: $(reactions)
    //  - references: $(references)
    //  - refresh: $(refresh)
    //  - regex: $(regex)
    //  - remote-explorer: $(remote-explorer)
    //  - remote: $(remote)
    //  - remove: $(remove)
    //  - replace-all: $(replace-all)
    //  - replace: $(replace)
    //  - repo-clone: $(repo-clone)
    //  - repo-force-push: $(repo-force-push)
    //  - repo-pull: $(repo-pull)
    //  - repo-push: $(repo-push)
    //  - report: $(report)
    //  - request-changes: $(request-changes)
    //  - rocket: $(rocket)
    //  - root-folder-opened: $(root-folder-opened)
    //  - root-folder: $(root-folder)
    //  - rss: $(rss)
    //  - ruby: $(ruby)
    //  - save-all: $(save-all)
    //  - save-as: $(save-as)
    //  - save: $(save)
    //  - screen-full: $(screen-full)
    //  - screen-normal: $(screen-normal)
    //  - search-stop: $(search-stop)
    //  - server: $(server)
    //  - settings-gear: $(settings-gear)
    //  - settings: $(settings)
    //  - shield: $(shield)
    //  - smiley: $(smiley)
    //  - sort-precedence: $(sort-precedence)
    //  - split-horizontal: $(split-horizontal)
    //  - split-vertical: $(split-vertical)
    //  - squirrel: $(squirrel)
    //  - star-full: $(star-full)
    //  - star-half: $(star-half)
    //  - symbol-class: $(symbol-class)
    //  - symbol-color: $(symbol-color)
    //  - symbol-constant: $(symbol-constant)
    //  - symbol-enum-member: $(symbol-enum-member)
    //  - symbol-field: $(symbol-field)
    //  - symbol-file: $(symbol-file)
    //  - symbol-interface: $(symbol-interface)
    //  - symbol-keyword: $(symbol-keyword)
    //  - symbol-misc: $(symbol-misc)
    //  - symbol-operator: $(symbol-operator)
    //  - symbol-property: $(symbol-property)
    //  - wrench: $(wrench)
    //  - wrench-subaction: $(wrench-subaction)
    //  - symbol-snippet: $(symbol-snippet)
    //  - tasklist: $(tasklist)
    //  - telescope: $(telescope)
    //  - text-size: $(text-size)
    //  - three-bars: $(three-bars)
    //  - thumbsdown: $(thumbsdown)
    //  - thumbsup: $(thumbsup)
    //  - tools: $(tools)
    //  - triangle-down: $(triangle-down)
    //  - triangle-left: $(triangle-left)
    //  - triangle-right: $(triangle-right)
    //  - triangle-up: $(triangle-up)
    //  - twitter: $(twitter)
    //  - unfold: $(unfold)
    //  - unlock: $(unlock)
    //  - unmute: $(unmute)
    //  - unverified: $(unverified)
    //  - verified: $(verified)
    //  - versions: $(versions)
    //  - vm-active: $(vm-active)
    //  - vm-outline: $(vm-outline)
    //  - vm-running: $(vm-running)
    //  - watch: $(watch)
    //  - whitespace: $(whitespace)
    //  - whole-word: $(whole-word)
    //  - window: $(window)
    //  - word-wrap: $(word-wrap)
    //  - zoom-in: $(zoom-in)
    //  - zoom-out: $(zoom-out)
    //  - list-filter: $(list-filter)
    //  - list-flat: $(list-flat)
    //  - list-selection: $(list-selection)
    //  - selection: $(selection)
    //  - list-tree: $(list-tree)
    //  - debug-breakpoint-function-unverified: $(debug-breakpoint-function-unverified)
    //  - debug-breakpoint-function: $(debug-breakpoint-function)
    //  - debug-breakpoint-function-disabled: $(debug-breakpoint-function-disabled)
    //  - debug-stackframe-active: $(debug-stackframe-active)
    //  - circle-small-filled: $(circle-small-filled)
    //  - debug-stackframe-dot: $(debug-stackframe-dot)
    //  - terminal-decoration-mark: $(terminal-decoration-mark)
    //  - debug-stackframe: $(debug-stackframe)
    //  - debug-stackframe-focused: $(debug-stackframe-focused)
    //  - debug-breakpoint-unsupported: $(debug-breakpoint-unsupported)
    //  - symbol-string: $(symbol-string)
    //  - debug-reverse-continue: $(debug-reverse-continue)
    //  - debug-step-back: $(debug-step-back)
    //  - debug-restart-frame: $(debug-restart-frame)
    //  - debug-alt: $(debug-alt)
    //  - call-incoming: $(call-incoming)
    //  - call-outgoing: $(call-outgoing)
    //  - menu: $(menu)
    //  - expand-all: $(expand-all)
    //  - feedback: $(feedback)
    //  - git-pull-request-reviewer: $(git-pull-request-reviewer)
    //  - group-by-ref-type: $(group-by-ref-type)
    //  - ungroup-by-ref-type: $(ungroup-by-ref-type)
    //  - account: $(account)
    //  - git-pull-request-assignee: $(git-pull-request-assignee)
    //  - bell-dot: $(bell-dot)
    //  - debug-console: $(debug-console)
    //  - library: $(library)
    //  - output: $(output)
    //  - run-all: $(run-all)
    //  - sync-ignored: $(sync-ignored)
    //  - pinned: $(pinned)
    //  - github-inverted: $(github-inverted)
    //  - server-process: $(server-process)
    //  - server-environment: $(server-environment)
    //  - pass: $(pass)
    //  - issue-closed: $(issue-closed)
    //  - stop-circle: $(stop-circle)
    //  - play-circle: $(play-circle)
    //  - record: $(record)
    //  - debug-alt-small: $(debug-alt-small)
    //  - vm-connect: $(vm-connect)
    //  - cloud: $(cloud)
    //  - merge: $(merge)
    //  - export: $(export)
    //  - graph-left: $(graph-left)
    //  - magnet: $(magnet)
    //  - notebook: $(notebook)
    //  - redo: $(redo)
    //  - check-all: $(check-all)
    //  - pinned-dirty: $(pinned-dirty)
    //  - pass-filled: $(pass-filled)
    //  - circle-large-filled: $(circle-large-filled)
    //  - circle-large: $(circle-large)
    //  - circle-large-outline: $(circle-large-outline)
    //  - combine: $(combine)
    //  - gather: $(gather)
    //  - table: $(table)
    //  - variable-group: $(variable-group)
    //  - type-hierarchy: $(type-hierarchy)
    //  - type-hierarchy-sub: $(type-hierarchy-sub)
    //  - type-hierarchy-super: $(type-hierarchy-super)
    //  - git-pull-request-create: $(git-pull-request-create)
    //  - run-above: $(run-above)
    //  - run-below: $(run-below)
    //  - notebook-template: $(notebook-template)
    //  - debug-rerun: $(debug-rerun)
    //  - workspace-trusted: $(workspace-trusted)
    //  - workspace-untrusted: $(workspace-untrusted)
    //  - workspace-unknown: $(workspace-unknown)
    //  - terminal-cmd: $(terminal-cmd)
    //  - terminal-debian: $(terminal-debian)
    //  - terminal-linux: $(terminal-linux)
    //  - terminal-powershell: $(terminal-powershell)
    //  - terminal-tmux: $(terminal-tmux)
    //  - terminal-ubuntu: $(terminal-ubuntu)
    //  - terminal-bash: $(terminal-bash)
    //  - arrow-swap: $(arrow-swap)
    //  - copy: $(copy)
    //  - person-add: $(person-add)
    //  - filter-filled: $(filter-filled)
    //  - wand: $(wand)
    //  - debug-line-by-line: $(debug-line-by-line)
    //  - inspect: $(inspect)
    //  - layers: $(layers)
    //  - layers-dot: $(layers-dot)
    //  - layers-active: $(layers-active)
    //  - compass: $(compass)
    //  - compass-dot: $(compass-dot)
    //  - compass-active: $(compass-active)
    //  - azure: $(azure)
    //  - issue-draft: $(issue-draft)
    //  - git-pull-request-closed: $(git-pull-request-closed)
    //  - git-pull-request-draft: $(git-pull-request-draft)
    //  - debug-all: $(debug-all)
    //  - debug-coverage: $(debug-coverage)
    //  - run-errors: $(run-errors)
    //  - folder-library: $(folder-library)
    //  - debug-continue-small: $(debug-continue-small)
    //  - beaker-stop: $(beaker-stop)
    //  - graph-line: $(graph-line)
    //  - graph-scatter: $(graph-scatter)
    //  - pie-chart: $(pie-chart)
    //  - bracket: $(bracket)
    //  - bracket-dot: $(bracket-dot)
    //  - bracket-error: $(bracket-error)
    //  - lock-small: $(lock-small)
    //  - azure-devops: $(azure-devops)
    //  - verified-filled: $(verified-filled)
    //  - newline: $(newline)
    //  - layout: $(layout)
    //  - layout-activitybar-left: $(layout-activitybar-left)
    //  - layout-activitybar-right: $(layout-activitybar-right)
    //  - layout-panel-left: $(layout-panel-left)
    //  - layout-panel-center: $(layout-panel-center)
    //  - layout-panel-justify: $(layout-panel-justify)
    //  - layout-panel-right: $(layout-panel-right)
    //  - layout-panel: $(layout-panel)
    //  - layout-sidebar-left: $(layout-sidebar-left)
    //  - layout-sidebar-right: $(layout-sidebar-right)
    //  - layout-statusbar: $(layout-statusbar)
    //  - layout-menubar: $(layout-menubar)
    //  - layout-centered: $(layout-centered)
    //  - target: $(target)
    //  - indent: $(indent)
    //  - record-small: $(record-small)
    //  - error-small: $(error-small)
    //  - terminal-decoration-error: $(terminal-decoration-error)
    //  - arrow-circle-down: $(arrow-circle-down)
    //  - arrow-circle-left: $(arrow-circle-left)
    //  - arrow-circle-right: $(arrow-circle-right)
    //  - arrow-circle-up: $(arrow-circle-up)
    //  - layout-sidebar-right-off: $(layout-sidebar-right-off)
    //  - layout-panel-off: $(layout-panel-off)
    //  - layout-sidebar-left-off: $(layout-sidebar-left-off)
    //  - blank: $(blank)
    //  - heart-filled: $(heart-filled)
    //  - map: $(map)
    //  - map-horizontal: $(map-horizontal)
    //  - fold-horizontal: $(fold-horizontal)
    //  - map-filled: $(map-filled)
    //  - map-horizontal-filled: $(map-horizontal-filled)
    //  - fold-horizontal-filled: $(fold-horizontal-filled)
    //  - circle-small: $(circle-small)
    //  - bell-slash: $(bell-slash)
    //  - bell-slash-dot: $(bell-slash-dot)
    //  - comment-unresolved: $(comment-unresolved)
    //  - git-pull-request-go-to-changes: $(git-pull-request-go-to-changes)
    //  - git-pull-request-new-changes: $(git-pull-request-new-changes)
    //  - search-fuzzy: $(search-fuzzy)
    //  - comment-draft: $(comment-draft)
    //  - send: $(send)
    //  - sparkle: $(sparkle)
    //  - insert: $(insert)
    //  - mic: $(mic)
    //  - thumbsdown-filled: $(thumbsdown-filled)
    //  - thumbsup-filled: $(thumbsup-filled)
    //  - coffee: $(coffee)
    //  - snake: $(snake)
    //  - game: $(game)
    //  - vr: $(vr)
    //  - chip: $(chip)
    //  - piano: $(piano)
    //  - music: $(music)
    //  - mic-filled: $(mic-filled)
    //  - repo-fetch: $(repo-fetch)
    //  - copilot: $(copilot)
    //  - lightbulb-sparkle: $(lightbulb-sparkle)
    //  - robot: $(robot)
    //  - sparkle-filled: $(sparkle-filled)
    //  - diff-single: $(diff-single)
    //  - diff-multiple: $(diff-multiple)
    //  - surround-with: $(surround-with)
    //  - share: $(share)
    //  - git-stash: $(git-stash)
    //  - git-stash-apply: $(git-stash-apply)
    //  - git-stash-pop: $(git-stash-pop)
    //  - vscode: $(vscode)
    //  - vscode-insiders: $(vscode-insiders)
    //  - code-oss: $(code-oss)
    //  - run-coverage: $(run-coverage)
    //  - run-all-coverage: $(run-all-coverage)
    //  - coverage: $(coverage)
    //  - github-project: $(github-project)
    //  - map-vertical: $(map-vertical)
    //  - fold-vertical: $(fold-vertical)
    //  - map-vertical-filled: $(map-vertical-filled)
    //  - fold-vertical-filled: $(fold-vertical-filled)
    //  - go-to-search: $(go-to-search)
    //  - percentage: $(percentage)
    //  - sort-percentage: $(sort-percentage)
    //  - attach: $(attach)
    //  - go-to-editing-session: $(go-to-editing-session)
    //  - edit-session: $(edit-session)
    //  - code-review: $(code-review)
    //  - copilot-warning: $(copilot-warning)
    //  - python: $(python)
    //  - copilot-large: $(copilot-large)
    //  - copilot-warning-large: $(copilot-warning-large)
    //  - keyboard-tab: $(keyboard-tab)
    //  - copilot-blocked: $(copilot-blocked)
    //  - copilot-not-connected: $(copilot-not-connected)
    //  - flag: $(flag)
    //  - lightbulb-empty: $(lightbulb-empty)
    //  - symbol-method-arrow: $(symbol-method-arrow)
    //  - copilot-unavailable: $(copilot-unavailable)
    //  - repo-pinned: $(repo-pinned)
    //  - keyboard-tab-above: $(keyboard-tab-above)
    //  - keyboard-tab-below: $(keyboard-tab-below)
    //  - git-pull-request-done: $(git-pull-request-done)
    //  - mcp: $(mcp)
    //  - extensions-large: $(extensions-large)
    //  - layout-panel-dock: $(layout-panel-dock)
    //  - layout-sidebar-left-dock: $(layout-sidebar-left-dock)
    //  - layout-sidebar-right-dock: $(layout-sidebar-right-dock)
    //  - copilot-in-progress: $(copilot-in-progress)
    //  - copilot-error: $(copilot-error)
    //  - copilot-success: $(copilot-success)
    //  - chat-sparkle: $(chat-sparkle)
    //  - search-sparkle: $(search-sparkle)
    //  - edit-sparkle: $(edit-sparkle)
    //  - copilot-snooze: $(copilot-snooze)
    //  - send-to-remote-agent: $(send-to-remote-agent)
    //  - comment-discussion-sparkle: $(comment-discussion-sparkle)
    //  - chat-sparkle-warning: $(chat-sparkle-warning)
    //  - chat-sparkle-error: $(chat-sparkle-error)
    //  - collection: $(collection)
    //  - new-collection: $(new-collection)
    //  - thinking: $(thinking)
    //  - build: $(build)
    //  - comment-discussion-quote: $(comment-discussion-quote)
    //  - cursor: $(cursor)
    //  - eraser: $(eraser)
    //  - file-text: $(file-text)
    //  - git-lens: $(git-lens)
    //  - quotes: $(quotes)
    //  - rename: $(rename)
    //  - run-with-deps: $(run-with-deps)
    //  - debug-connected: $(debug-connected)
    //  - strikethrough: $(strikethrough)
    //  - open-in-product: $(open-in-product)
    //  - index-zero: $(index-zero)
    //  - agent: $(agent)
    //  - edit-code: $(edit-code)
    //  - repo-selected: $(repo-selected)
    //  - skip: $(skip)
    //  - merge-into: $(merge-into)
    //  - git-branch-changes: $(git-branch-changes)
    //  - git-branch-staged-changes: $(git-branch-staged-changes)
    //  - git-branch-conflicts: $(git-branch-conflicts)
    //  - git-branch: $(git-branch)
    //  - git-branch-create: $(git-branch-create)
    //  - git-branch-delete: $(git-branch-delete)
    //  - search-large: $(search-large)
    //  - terminal-git-bash: $(terminal-git-bash)
    //  - window-active: $(window-active)
    //  - forward: $(forward)
    //  - download: $(download)
    //  - dialog-error: $(dialog-error)
    //  - dialog-warning: $(dialog-warning)
    //  - dialog-info: $(dialog-info)
    //  - dialog-close: $(dialog-close)
    //  - tree-item-expanded: $(tree-item-expanded)
    //  - tree-filter-on-type-on: $(tree-filter-on-type-on)
    //  - tree-filter-on-type-off: $(tree-filter-on-type-off)
    //  - tree-filter-clear: $(tree-filter-clear)
    //  - tree-item-loading: $(tree-item-loading)
    //  - menu-selection: $(menu-selection)
    //  - menu-submenu: $(menu-submenu)
    //  - menubar-more: $(menubar-more)
    //  - scrollbar-button-left: $(scrollbar-button-left)
    //  - scrollbar-button-right: $(scrollbar-button-right)
    //  - scrollbar-button-up: $(scrollbar-button-up)
    //  - scrollbar-button-down: $(scrollbar-button-down)
    //  - toolbar-more: $(toolbar-more)
    //  - quick-input-back: $(quick-input-back)
    //  - drop-down-button: $(drop-down-button)
    //  - symbol-customcolor: $(symbol-customcolor)
    //  - export: $(export)
    //  - workspace-unspecified: $(workspace-unspecified)
    //  - newline: $(newline)
    //  - thumbsdown-filled: $(thumbsdown-filled)
    //  - thumbsup-filled: $(thumbsup-filled)
    //  - git-fetch: $(git-fetch)
    //  - lightbulb-sparkle-autofix: $(lightbulb-sparkle-autofix)
    //  - debug-breakpoint-pending: $(debug-breakpoint-pending)
    "terminal.integrated.tabs.defaultIcon": "terminal",

    // Controls the terminal description, which appears to the right of the title. Variables are substituted based on the context:
    // - `${cwd}`: the terminal's current working directory.
    // - `${cwdFolder}`: the terminal's current working directory, displayed for multi-root workspaces or in a single root workspace when the value differs from the initial working directory. On Windows, this will only be displayed when shell integration is enabled.
    // - `${workspaceFolder}`: the workspace in which the terminal was launched.
    // - `${workspaceFolderName}`: the `name` of the workspace in which the terminal was launched.
    // - `${local}`: indicates a local terminal in a remote workspace.
    // - `${process}`: the name of the terminal process.
    // - `${progress}`: the progress state as reported by the `OSC 9;4` sequence.
    // - `${separator}`: a conditional separator (` - `) that only shows when it's surrounded by variables with values or static text.
    // - `${sequence}`: the name provided to the terminal by the process.
    // - `${task}`: indicates this terminal is associated with a task.
    // - `${shellType}`: the detected shell type.
    // - `${shellCommand}`: the command being executed according to shell integration. This also requires high confidence in the detected command line, which may not work in some prompt frameworks.
    // - `${shellPromptInput}`: the shell's full prompt input according to shell integration.
    "terminal.integrated.tabs.description": "${task}${separator}${local}${separator}${cwdFolder}",

    // Controls whether terminal tab statuses support animation (eg. in progress tasks).
    "terminal.integrated.tabs.enableAnimation": true,

    // Controls whether terminal tabs display as a list to the side of the terminal. When this is disabled a dropdown will display instead.
    "terminal.integrated.tabs.enabled": true,

    // Controls whether focusing the terminal of a tab happens on double or single click.
    //  - singleClick: Focus the terminal when clicking a terminal tab
    //  - doubleClick: Focus the terminal when double-clicking a terminal tab
    "terminal.integrated.tabs.focusMode": "doubleClick",

    // Controls whether the terminal tabs view will hide under certain conditions.
    //  - never: Never hide the terminal tabs view
    //  - singleTerminal: Hide the terminal tabs view when there is only a single terminal opened
    //  - singleGroup: Hide the terminal tabs view when there is only a single terminal group opened
    "terminal.integrated.tabs.hideCondition": "singleTerminal",

    // Controls the location of the terminal tabs, either to the left or right of the actual terminal(s).
    //  - left: Show the terminal tabs view to the left of the terminal
    //  - right: Show the terminal tabs view to the right of the terminal
    "terminal.integrated.tabs.location": "right",

    // Separator used by `terminal.integrated.tabs.title#` and `#terminal.integrated.tabs.description`.
    "terminal.integrated.tabs.separator": " - ",

    // Controls whether terminal split and kill buttons are displays next to the new terminal button.
    //  - always: Always show the actions
    //  - singleTerminal: Show the actions when it is the only terminal opened
    //  - singleTerminalOrNarrow: Show the actions when it is the only terminal opened or when the tabs view is in its narrow textless state
    //  - never: Never show the actions
    "terminal.integrated.tabs.showActions": "singleTerminalOrNarrow",

    // Shows the active terminal information in the view. This is particularly useful when the title within the tabs aren't visible.
    //  - always: Always show the active terminal
    //  - singleTerminal: Show the active terminal when it is the only terminal opened
    //  - singleTerminalOrNarrow: Show the active terminal when it is the only terminal opened or when the tabs view is in its narrow textless state
    //  - never: Never show the active terminal
    "terminal.integrated.tabs.showActiveTerminal": "singleTerminalOrNarrow",

    // Controls the terminal title. Variables are substituted based on the context:
    // - `${cwd}`: the terminal's current working directory.
    // - `${cwdFolder}`: the terminal's current working directory, displayed for multi-root workspaces or in a single root workspace when the value differs from the initial working directory. On Windows, this will only be displayed when shell integration is enabled.
    // - `${workspaceFolder}`: the workspace in which the terminal was launched.
    // - `${workspaceFolderName}`: the `name` of the workspace in which the terminal was launched.
    // - `${local}`: indicates a local terminal in a remote workspace.
    // - `${process}`: the name of the terminal process.
    // - `${progress}`: the progress state as reported by the `OSC 9;4` sequence.
    // - `${separator}`: a conditional separator (` - `) that only shows when it's surrounded by variables with values or static text.
    // - `${sequence}`: the name provided to the terminal by the process.
    // - `${task}`: indicates this terminal is associated with a task.
    // - `${shellType}`: the detected shell type.
    // - `${shellCommand}`: the command being executed according to shell integration. This also requires high confidence in the detected command line, which may not work in some prompt frameworks.
    // - `${shellPromptInput}`: the shell's full prompt input according to shell integration.
    "terminal.integrated.tabs.title": "${process}",

    // The number of cells in a tab stop.
    "terminal.integrated.tabStopWidth": 8,

    // Controls what version of Unicode to use when evaluating the width of characters in the terminal. If you experience emoji or other wide characters not taking up the right amount of space or backspace either deleting too much or too little then you may want to try tweaking this setting.
    //  - 6: Version 6 of Unicode. This is an older version which should work better on older systems.
    //  - 11: Version 11 of Unicode. This version provides better support on modern systems that use modern versions of Unicode.
    "terminal.integrated.unicodeVersion": "11",

    // Controls whether or not WSL distros are shown in the terminal dropdown
    "terminal.integrated.useWslProfiles": true,

    // Whether to use ConPTY for Windows terminal process communication (requires Windows 10 build number 18309+). Winpty will be used if this is false.
    "terminal.integrated.windowsEnableConpty": true,

    // Whether to use the experimental conpty.dll (v1.22.250204002) shipped with VS Code, instead of the one bundled with Windows.
    "terminal.integrated.windowsUseConptyDll": false,

    // A string containing all characters to be considered word separators when double-clicking to select word and in the fallback 'word' link detection. Since this is used for link detection, including characters such as `:` that are used when detecting links will cause the line and column part of links like `file:10:5` to be ignored.
    "terminal.integrated.wordSeparators": " ()[]{}',\"`─‘’“”|",

    // Controls whether code cells in the interactive window are collapsed by default.
    "interactiveWindow.collapseCellInputCode": "fromEditor",

    // The limit of notebook output size in kilobytes (KB) where notebook files will no longer be backed up for hot reload. Use 0 for unlimited.
    "notebook.backup.sizeLimit": 10000,

    // When enabled, notebook breadcrumbs contain code cells.
    "notebook.breadcrumbs.showCodeCells": true,

    // Controls the verbosity of the cell execution time in the cell status bar.
    //  - default: The cell execution duration is visible, with advanced information in the hover tooltip.
    //  - verbose: The cell last execution timestamp and duration are visible, with advanced information in the hover tooltip.
    "notebook.cellExecutionTimeVerbosity": "default",

    // Show available diagnostics for cell failures.
    "notebook.cellFailureDiagnostics": true,

    // Controls where the focus indicator is rendered, either along the cell borders or on the left gutter.
    "notebook.cellFocusIndicator": "gutter",

    // Where the cell toolbar should be shown, or whether it should be hidden.
    "notebook.cellToolbarLocation": {
        "default": "right"
    },

    // Whether the cell toolbar should appear on hover or click.
    "notebook.cellToolbarVisibility": "click",

    // Control whether the notebook editor should be rendered in a compact form. For example, when turned on, it will decrease the left margin width.
    "notebook.compactView": true,

    // Control whether a confirmation prompt is required to delete a running cell.
    "notebook.confirmDeleteRunningCell": true,

    // Control whether outputs action should be rendered in the output toolbar.
    "notebook.consolidatedOutputButton": true,

    // Control whether extra actions are shown in a dropdown next to the run button.
    "notebook.consolidatedRunButton": false,

    // Defines a default notebook formatter which takes precedence over all other formatter settings. Must be the identifier of an extension contributing a formatter.
    //  - null: None
    //  - vscode.json-language-features: Provides rich language support for JSON files.
    //  - yzhang.markdown-all-in-one: All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more)
    //  - jebbs.plantuml: Rich PlantUML support for Visual Studio Code.
    //  - ms-vscode.powershell: Develop PowerShell modules, commands and scripts in Visual Studio Code!
    //  - DavidAnson.vscode-markdownlint: Markdown linting and style checking for Visual Studio Code
    //  - ms-vscode.azurecli: Tools for developing and running commands of the Azure CLI.
    //  - msazurermtools.azurerm-vscode-tools: Language server, editing tools and snippets for Azure Resource Manager (ARM) template files.
    //  - aaron-bond.better-comments: Improve your code commenting by annotating with alert, informational, TODOs, and more!
    //  - GitHub.copilot-chat: AI chat features powered by Copilot
    //  - vscode.css-language-features: Provides rich language support for CSS, LESS and SCSS files.
    //  - vscode.html-language-features: Provides rich language support for HTML and Handlebar files
    //  - vscode.markdown-language-features: Provides rich language support for Markdown.
    //  - vscode.markdown-math: Adds math support to Markdown in notebooks.
    //  - vscode.php-language-features: Provides rich language support for PHP files.
    //  - mechatroner.rainbow-csv: Highlight CSV and TSV files, Run SQL-like queries
    //  - vscode.typescript-language-features: Provides rich language support for JavaScript and TypeScript.
    //  - ms-azuretools.vscode-bicep: Bicep language support for Visual Studio Code
    //  - ms-azuretools.vscode-containers: Makes it easy to create, manage, and debug containerized applications.
    //  - dbaeumer.vscode-eslint: Integrates ESLint JavaScript into VS Code.
    //  - redhat.vscode-yaml: YAML Language Support by Red Hat, with built-in Kubernetes syntax support
    //  - ms-vscode.azure-account: A common Sign In and Subscription management extension for VS Code.
    //  - ms-azuretools.azure-dev: Makes it easy to run, provision, and deploy Azure applications using the Azure Developer CLI
    //  - streetsidesoftware.code-spell-checker: Spelling checker for source code
    //  - vscode.configuration-editing: Provides capabilities (advanced IntelliSense, auto-fixing) in configuration files like settings, launch, and extension recommendation files.
    //  - vscode.debug-auto-launch: Helper for auto-attach feature when node-debug extensions are not active.
    //  - vscode.debug-server-ready: Open URI in browser if server under debugging is ready.
    //  - vscode.emmet: Emmet support for VS Code
    //  - vscode.extension-editing: Provides linting capabilities for authoring extensions.
    //  - vscode.git: Git SCM Integration
    //  - vscode.git-base: Git static contributions and pickers.
    //  - donjayamanne.githistory: View git log, file history, compare branches or commits
    //  - vscode.github: GitHub features for VS Code
    //  - vscode.github-authentication: GitHub Authentication Provider
    //  - eamodio.gitlens: Supercharge Git within VS Code — Visualize code authorship at a glance via Git blame annotations and CodeLens, seamlessly navigate and explore Git repositories, gain valuable insights via rich visualizations and powerful comparison commands, and so much more
    //  - vscode.grunt: Extension to add Grunt capabilities to VS Code.
    //  - vscode.gulp: Extension to add Gulp capabilities to VSCode.
    //  - oderwat.indent-rainbow: Makes indentation easier to read
    //  - vscode.ipynb: Provides basic support for opening and reading Jupyter's .ipynb notebook files
    //  - vscode.jake: Extension to add Jake capabilities to VS Code.
    //  - ms-vscode.js-debug: An extension for debugging Node.js programs and Chrome.
    //  - ms-vscode.js-debug-companion: Companion extension to js-debug that provides capability for remote debugging
    //  - ms-vscode.live-server: Hosts a local server in your workspace for you to preview your webpages on.
    //  - bierner.markdown-mermaid: Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview
    //  - vscode.media-preview: Provides VS Code's built-in previews for images, audio, and video
    //  - vscode.merge-conflict: Highlighting and commands for inline merge conflicts.
    //  - vscode.mermaid-chat-features: Adds Mermaid diagram support to built-in chats.
    //  - vscode.microsoft-authentication: Microsoft authentication provider
    //  - vscode.npm: Extension to add task support for npm scripts.
    //  - christian-kohler.npm-intellisense: Visual Studio Code plugin that autocompletes npm modules in import statements
    //  - vscode.references-view: Reference Search results as separate, stable view in the sidebar
    //  - vscode.search-result: Provides syntax highlighting and language features for tabbed search results.
    //  - vscode.simple-browser: A very basic built-in webview for displaying web content.
    //  - vscode.terminal-suggest: Extension to add terminal completions for zsh, bash, and fish terminals.
    //  - ms-vscode.test-adapter-converter: Converter extension from the Test Adapter UI to native VS Code testing
    //  - vscode.tunnel-forwarding: Allows forwarding local ports to be accessible over the internet.
    //  - TeamsDevApp.vscode-ai-foundry: Visual Studio Code extension for Microsoft Foundry
    //  - ms-azuretools.vscode-azure-github-copilot: GitHub Copilot for Azure is the @azure extension. It's designed to help streamline the process of developing for Azure. You can ask @azure questions about Azure services or get help with tasks related to Azure and developing for Azure, all from within Visual Studio Code.
    //  - ms-azuretools.vscode-azure-mcp-server: Provides Model Context Protocol (MCP) integration and tooling for Azure in Visual Studio Code.
    //  - ms-azuretools.vscode-azureappservice: An Azure App Service management extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurecontainerapps: An Azure Container Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurefunctions: An Azure Functions extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azureresourcegroups: An extension for viewing and managing Azure resources.
    //  - ms-azuretools.vscode-azurestaticwebapps: An Azure Static Web Apps extension for Visual Studio Code.
    //  - ms-azuretools.vscode-azurestorage: Manage your Azure Storage accounts including Blob Containers, File Shares, Tables and Queues
    //  - ms-azuretools.vscode-azurevirtualmachines: An Azure Virtual Machines extension for Visual Studio Code.
    //  - ms-azuretools.vscode-cosmosdb: Connect Azure CosmosDB databases in Azure, inspect and edit your data and run powerful queries with the visual query editor.
    //  - ms-dotnettools.vscode-dotnet-runtime: This extension installs and manages different versions of the .NET SDK and Runtime.
    //  - hediet.vscode-drawio: This unofficial extension integrates Draw.io into VS Code.
    //  - ms-edgedevtools.vscode-edge-devtools: Use the Microsoft Edge Tools from within VS Code to see your site's runtime HTML structure, alter its layout, fix styling issues as well as see your site's network requests.
    //  - firefox-devtools.vscode-firefox-debug: Debug your web application or browser extension in Firefox
    //  - github.vscode-github-actions: GitHub Actions workflows and runs for github.com hosted repositories in VS Code
    //  - ms-vscode.vscode-js-profile-table: Text visualizer for profiles taken from the JavaScript debugger
    //  - GitHub.vscode-pull-request-github: Pull Request and Issue Provider for GitHub
    //  - ms-windows-ai-studio.windows-ai-studio: AI Toolkit for VS Code streamlines generative AI app development by integrating tools and models. Browse and download public and custom models; author, test and evaluate prompts; fine-tune; and use them in your applications.
    "notebook.defaultFormatter": null,

    // Whether to use the enhanced text diff editor for notebook.
    "notebook.diff.enablePreview": true,

    // Enable the command to toggle the experimental notebook inline diff editor.
    "notebook.diff.experimental.toggleInline": true,

    // Hide Metadata Differences
    "notebook.diff.ignoreMetadata": false,

    // Hide Outputs Differences
    "notebook.diff.ignoreOutputs": false,

    // Whether to render the overview ruler in the diff editor for notebook.
    "notebook.diff.overviewRuler": false,

    // Priority list for output mime types
    "notebook.displayOrder": [],

    // Control whether the notebook editor should allow moving cells through drag and drop.
    "notebook.dragAndDropEnabled": true,

    // Settings for code editors used in notebooks. This can be used to customize most editor.* settings.
    "notebook.editorOptionsCustomizations": {},

    // Enable experimental generate action to create code cell with inline chat enabled.
    "notebook.experimental.generate": true,

    // Enables the incremental saving of notebooks between processes and across Remote connections. When enabled, only the changes to the notebook are sent to the extension host, improving performance for large notebooks and slow network connections.
    "notebook.experimental.remoteSave": true,

    // Customize the Find Widget behavior for searching within notebook cells. When both markup source and markup preview are enabled, the Find Widget will search either the source code or preview based on the current state of the cell.
    "notebook.find.filters": {
        "markupSource": true,
        "markupPreview": true,
        "codeSource": true,
        "codeOutput": true
    },

    // Format a notebook cell upon execution. A formatter must be available.
    "notebook.formatOnCellExecution": false,

    // Format a notebook on save. A formatter must be available and the editor must not be shutting down. When `files.autoSave` is set to `afterDelay`, the file will only be formatted when saved explicitly.
    "notebook.formatOnSave.enabled": false,

    // Control whether to render a global toolbar inside the notebook editor.
    "notebook.globalToolbar": true,

    // Control whether the actions on the notebook toolbar should render label or not.
    "notebook.globalToolbarShowLabel": "always",

    // When enabled, the Go to Symbol Quick Pick will display full code symbols from the notebook, as well as Markdown headers.
    "notebook.gotoSymbols.showAllSymbols": true,

    // Control whether to show inline values within notebook code cells after cell execution. Values will remain until the cell is edited, re-executed, or explicitly cleared via the Clear All Outputs toolbar button or the `Notebook: Clear Inline Values` command.
    //  - on: Always show inline values, with a regex fallback if no inline value provider is registered. Note: There may be a performance impact in larger cells if the fallback is used.
    //  - auto: Show inline values only when an inline value provider is registered.
    //  - off: Never show inline values.
    "notebook.inlineValues": "off",

    // When enabled, insert a final new line into the end of code cells when saving a notebook.
    "notebook.insertFinalNewline": false,

    // Control where the insert cell actions should appear.
    //  - betweenCells: A toolbar that appears on hover between cells.
    //  - notebookToolbar: The toolbar at the top of the notebook editor.
    //  - both: Both toolbars.
    //  - hidden: The insert actions don't appear anywhere.
    "notebook.insertToolbarLocation": "both",

    // Controls the display of line numbers in the cell editor.
    "notebook.lineNumbers": "off",

    // Controls the line height in pixels of markdown cells in notebooks. When set to `0`, `normal` will be used
    "notebook.markdown.lineHeight": 0,

    // Controls the font family of rendered markup in notebooks. When left blank, this will fall back to the default workbench font family.
    "notebook.markup.fontFamily": "",

    // Controls the font size in pixels of rendered markup in notebooks. When set to `0`, 120% of `editor.fontSize` is used.
    "notebook.markup.fontSize": 0,

    // Experimental. Enables a limited set of multi cursor controls across multiple cells in the notebook editor. Currently supported are core editor actions (typing/cut/copy/paste/composition) and a limited subset of editor commands.
    "notebook.multiCursor.enabled": false,

    // When enabled cursor can navigate to the next/previous cell when the current cursor in the cell editor is at the first/last line.
    "notebook.navigation.allowNavigateToSurroundingCells": true,

    // When enabled, notebook outline shows code cells.
    "notebook.outline.showCodeCells": false,

    // When enabled, notebook outline shows code cell symbols. Relies on `notebook.outline.showCodeCells` being enabled.
    "notebook.outline.showCodeCellSymbols": true,

    // When enabled, notebook outline will show only markdown cells containing a header.
    "notebook.outline.showMarkdownHeadersOnly": true,

    // The font family of the output text within notebook cells. When set to empty, the `editor.fontFamily` is used.
    "notebook.output.fontFamily": "",

    // Font size for the output text within notebook cells. When set to 0, `editor.fontSize` is used.
    "notebook.output.fontSize": 0,

    // Line height of the output text within notebook cells.
    //  - When set to 0, editor line height is used.
    //  - Values between 0 and 8 will be used as a multiplier with the font size.
    //  - Values greater than or equal to 8 will be used as effective values.
    "notebook.output.lineHeight": 0,

    // Control whether to disable filepath links in the output of notebook cells.
    "notebook.output.linkifyFilePaths": true,

    // Control whether to render error output in a minimal style.
    "notebook.output.minimalErrorRendering": false,

    // Initially render notebook outputs in a scrollable region when longer than the limit.
    "notebook.output.scrolling": true,

    // Controls how many lines of text are displayed in a text output. If `notebook.output.scrolling` is enabled, this setting is used to determine the scroll height of the output.
    "notebook.output.textLineLimit": 30,

    // Controls whether the lines in output should wrap.
    "notebook.output.wordWrap": false,

    // How far to scroll when revealing the next cell upon running notebook.cell.executeAndSelectBelow.
    //  - fullCell: Scroll to fully reveal the next cell.
    //  - firstLine: Scroll to reveal the first line of the next cell.
    //  - none: Do not scroll.
    "notebook.scrolling.revealNextCellOnExecute": "fullCell",

    // Whether the cell status bar should be shown.
    //  - hidden: The cell status bar is always hidden.
    //  - visible: The cell status bar is always visible.
    //  - visibleAfterExecute: The cell status bar is hidden until the cell has executed. Then it becomes visible to show the execution status.
    "notebook.showCellStatusBar": "visible",

    // Controls when the Markdown header folding arrow is shown.
    //  - always: The folding controls are always visible.
    //  - never: Never show the folding controls and reduce the gutter size.
    //  - mouseover: The folding controls are visible only on mouseover.
    "notebook.showFoldingControls": "mouseover",

    // Experimental. Control whether to render notebook Sticky Scroll headers in the notebook editor.
    "notebook.stickyScroll.enabled": false,

    // Control whether nested sticky lines appear to stack flat or indented.
    //  - flat: Nested sticky lines appear flat.
    //  - indented: Nested sticky lines appear indented.
    "notebook.stickyScroll.mode": "indented",

    // Whether to use separate undo/redo stack for each cell.
    "notebook.undoRedoPerCell": true,

    // Enable the experimental notebook variables view within the debug panel.
    "notebook.variablesView": false,

    // Tasks
    // Controls whether to enable AI statistics in the editor. The gauge represents the average amount of code inserted by AI vs manual typing over a 24 hour period.
    "editor.aiStats.enabled": false,

    // Enable automatic tasks - note that tasks won't run in an untrusted workspace.
    //  - on: Always
    //  - off: Never
    "task.allowAutomaticTasks": "on",

    // Controls enablement of `provideTasks` for all task provider extension. If the Tasks: Run Task command is slow, disabling auto detect for task providers may help. Individual extensions may also provide settings that disable auto detection.
    "task.autoDetect": "on",

    // Controls the minimum task runtime in milliseconds before showing an OS notification when the task finishes while the window is not in focus. Set to -1 to disable notifications. Set to 0 to always show notifications. This includes a window badge as well as notification toast.
    "task.notifyWindowOnTaskCompletion": 60000,

    // Configures whether to show the problem matcher prompt when running a task. Set to `true` to never prompt, or use a dictionary of task types to turn off prompting only for specific task types.
    "task.problemMatchers.neverPrompt": false,

    // Controls whether to show the task detail for tasks that have a detail in task quick picks, such as Run Task.
    "task.quickOpen.detail": true,

    // Controls the number of recent items tracked in task quick open dialog.
    "task.quickOpen.history": 30,

    // Causes the Tasks: Run Task command to use the slower "show all" behavior instead of the faster two level picker where tasks are grouped by provider.
    "task.quickOpen.showAll": false,

    // Controls whether the task quick pick is skipped when there is only one task to pick from.
    "task.quickOpen.skip": false,

    // On window reload, reconnect to tasks that have problem matchers.
    "task.reconnection": true,

    // Save all dirty editors before running a task.
    //  - always: Always saves all editors before running.
    //  - never: Never saves editors before running.
    //  - prompt: Prompts whether to save editors before running.
    "task.saveBeforeRun": "always",

    // Configures whether a warning is shown when a provider is slow
    "task.slowProviderWarning": true,

    // Enable verbose logging for tasks.
    "task.verboseLogging": false,

    // Controls whether to enable telemetry for detailed edit statistics (only sends statistics if general telemetry is enabled).
    "telemetry.editStats.details.enabled": true,

    // Controls whether to enable telemetry for edit statistics (only sends statistics if general telemetry is enabled).
    "telemetry.editStats.enabled": true,

    // Controls whether to show decorations for edit telemetry.
    "telemetry.editStats.showDecorations": false,

    // Controls whether to show the status bar for edit telemetry.
    "telemetry.editStats.showStatusBar": false,

    // Terminal Suggest Providers
    // Controls which suggestions automatically show up while typing. Suggestion providers are enabled by default.
    "terminal.integrated.suggest.providers": {
        "lsp": true,
        "vscode.terminal-suggest": true
    },

    // Views
    // Specifies whether to try to collapse the opened worktrees into a single (common) repository in the views when possible
    "gitlens.views.collapseWorktreesWhenPossible": true,

    // Deprecated. Use `gitlens.views.formats.commits.description` instead
    // 
    "gitlens.views.commitDescriptionFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.description` instead
    // 
    "gitlens.views.commitFileDescriptionFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.label` instead
    // 
    "gitlens.views.commitFileFormat": null,

    // Deprecated. Use `gitlens.views.commits.files.label` instead
    // 
    "gitlens.views.commitFormat": null,

    // Specifies the default number of items to show in a view list. Use 0 to specify no limit
    "gitlens.views.defaultItemLimit": 10,

    // Specifies the description format of commits in the views. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.commits.description": "${author, }${agoOrDate}",

    // Specifies the format of commits in the views. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.commits.label": "${❰ tips|11? ❱➤  }${message}",

    // Specifies the tooltip format (in markdown) of commits in the views. See [_Commit Tokens_](https://github.com/eamodio/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.commits.tooltip": "${avatar} &nbsp;__${author}__ &nbsp;$(history) ${agoAndDateBothSources} \\\n${link}${' via  'pullRequest}${'&nbsp;&nbsp;'changesDetail} ${message}${\n\n---\n\nfootnotes}\n\n${tips}",

    // Specifies the tooltip format (in markdown) of "file" commits in the views. See [_Commit Tokens_](https://github.com/eamodio/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.commits.tooltipWithStatus": "${avatar} &nbsp;__${author}__ &nbsp;$(history) ${agoAndDateBothSources} \\\n${link}${' via  'pullRequest}&nbsp;&nbsp;•&nbsp;&nbsp;{{slot-status}} ${message}${\n\n---\n\nfootnotes}\n\n${tips}",

    // Specifies the description format of a file in the views. See [_File Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#file-tokens) in the GitLens docs
    "gitlens.views.formats.files.description": "${directory}${  ←  originalPath}",

    // Specifies the format of a file in the views. See [_File Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#file-tokens) in the GitLens docs
    "gitlens.views.formats.files.label": "${working  }${file}",

    // Specifies the description format of stashes in the views. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.stashes.description": "${stashOnRef, }${agoOrDate}",

    // Specifies the format of stashes in the views. See [_Commit Tokens_](https://github.com/gitkraken/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.stashes.label": "${message}",

    // Specifies the tooltip format (in markdown) of stashes in the views. See [_Commit Tokens_](https://github.com/eamodio/vscode-gitlens/wiki/Custom-Formatting#commit-tokens) in the GitLens docs
    "gitlens.views.formats.stashes.tooltip": "${link}${' on `'stashOnRef`}${'\\\n&nbsp;&nbsp;'changesDetail} \\\n &nbsp;$(history) ${agoAndDate} ${message}${\n\n---\n\nfootnotes}",

    // Specifies whether to allow selecting multiple items in the views
    "gitlens.views.multiselect": true,

    // Specifies whether to open multiple changes in the multi-diff editor (single tab) or in individual diff editors (multiple tabs)
    "gitlens.views.openChangesInMultiDiffEditor": true,

    // Specifies the number of items to show in a each page when paginating a view list. Use 0 to specify no limit
    "gitlens.views.pageItemLimit": 40,

    // Specifies the default view to show when the _GitLens_ view is opened
    //  - commits: Commits view
    //  - branches: Worktrees view
    //  - remotes: Branches view
    //  - stashes: Remotes view
    //  - tags: Stashes view
    //  - worktrees: Tags view
    //  - contributors: Contributors view
    //  - repositories: Repositories view
    //  - searchAndCompare: File History view
    //  - launchpad: Launchpad view
    //  - fileHistory: Search & Compare view
    "gitlens.views.scm.grouped.default": "commits",

    // Specifies which views will be hidden, when grouped into the _GitLens_ view on the Source Control side bar
    "gitlens.views.scm.grouped.hiddenViews": {
        "commits": false,
        "worktrees": false,
        "branches": false,
        "remotes": false,
        "stashes": false,
        "tags": false,
        "contributors": false,
        "repositories": true,
        "fileHistory": false,
        "launchpad": false,
        "searchAndCompare": false
    },

    // Specifies which views will be grouped into the _GitLens_ view on the Source Control side bar
    "gitlens.views.scm.grouped.views": {
        "commits": true,
        "worktrees": true,
        "branches": true,
        "remotes": true,
        "stashes": true,
        "tags": true,
        "contributors": true,
        "repositories": true,
        "fileHistory": false,
        "launchpad": false,
        "searchAndCompare": false
    },

    // Specifies whether to show a _Contributors_ section on comparison results in the views
    "gitlens.views.showComparisonContributors": true,

    // Specifies whether to show contributor statistics in _Contributors_ sections in the views. This can take a while to compute depending on the repository size
    "gitlens.views.showContributorsStatistics": false,

    // Specifies whether to always show the current branch at the top of the views
    "gitlens.views.showCurrentBranchOnTop": true,

    // Specifies whether to show relative date markers (_Less than a week ago_, _Over a week ago_, _Over a month ago_, etc) on revision (commit) histories in the views
    "gitlens.views.showRelativeDateMarkers": true,

    // Deprecated. Use `gitlens.views.formats.stashes.description` instead
    // 
    "gitlens.views.stashDescriptionFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.description` instead
    // 
    "gitlens.views.stashFileDescriptionFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.label` instead
    // 
    "gitlens.views.stashFileFormat": null,

    // Deprecated. Use `gitlens.views.stashes.files.label` instead
    // 
    "gitlens.views.stashFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.description` instead
    // 
    "gitlens.views.statusFileDescriptionFormat": null,

    // Deprecated. Use `gitlens.views.formats.files.label` instead
    // 
    "gitlens.views.statusFileFormat": null,

    // Breadcrumb Navigation
    // Enable/disable navigation breadcrumbs.
    "breadcrumbs.enabled": true,

    // Controls whether and how file paths are shown in the breadcrumbs view.
    //  - on: Show the file path in the breadcrumbs view.
    //  - off: Do not show the file path in the breadcrumbs view.
    //  - last: Only show the last element of the file path in the breadcrumbs view.
    "breadcrumbs.filePath": "on",

    // Render breadcrumb items with icons.
    "breadcrumbs.icons": true,

    // When enabled breadcrumbs show `array`-symbols.
    "breadcrumbs.showArrays": true,

    // When enabled breadcrumbs show `boolean`-symbols.
    "breadcrumbs.showBooleans": true,

    // When enabled breadcrumbs show `class`-symbols.
    "breadcrumbs.showClasses": true,

    // When enabled breadcrumbs show `constant`-symbols.
    "breadcrumbs.showConstants": true,

    // When enabled breadcrumbs show `constructor`-symbols.
    "breadcrumbs.showConstructors": true,

    // When enabled breadcrumbs show `enumMember`-symbols.
    "breadcrumbs.showEnumMembers": true,

    // When enabled breadcrumbs show `enum`-symbols.
    "breadcrumbs.showEnums": true,

    // When enabled breadcrumbs show `event`-symbols.
    "breadcrumbs.showEvents": true,

    // When enabled breadcrumbs show `field`-symbols.
    "breadcrumbs.showFields": true,

    // When enabled breadcrumbs show `file`-symbols.
    "breadcrumbs.showFiles": true,

    // When enabled breadcrumbs show `function`-symbols.
    "breadcrumbs.showFunctions": true,

    // When enabled breadcrumbs show `interface`-symbols.
    "breadcrumbs.showInterfaces": true,

    // When enabled breadcrumbs show `key`-symbols.
    "breadcrumbs.showKeys": true,

    // When enabled breadcrumbs show `method`-symbols.
    "breadcrumbs.showMethods": true,

    // When enabled breadcrumbs show `module`-symbols.
    "breadcrumbs.showModules": true,

    // When enabled breadcrumbs show `namespace`-symbols.
    "breadcrumbs.showNamespaces": true,

    // When enabled breadcrumbs show `null`-symbols.
    "breadcrumbs.showNull": true,

    // When enabled breadcrumbs show `number`-symbols.
    "breadcrumbs.showNumbers": true,

    // When enabled breadcrumbs show `object`-symbols.
    "breadcrumbs.showObjects": true,

    // When enabled breadcrumbs show `operator`-symbols.
    "breadcrumbs.showOperators": true,

    // When enabled breadcrumbs show `package`-symbols.
    "breadcrumbs.showPackages": true,

    // When enabled breadcrumbs show `property`-symbols.
    "breadcrumbs.showProperties": true,

    // When enabled breadcrumbs show `string`-symbols.
    "breadcrumbs.showStrings": true,

    // When enabled breadcrumbs show `struct`-symbols.
    "breadcrumbs.showStructs": true,

    // When enabled breadcrumbs show `typeParameter`-symbols.
    "breadcrumbs.showTypeParameters": true,

    // When enabled breadcrumbs show `variable`-symbols.
    "breadcrumbs.showVariables": true,

    // Controls whether and how symbols are shown in the breadcrumbs view.
    //  - on: Show all symbols in the breadcrumbs view.
    //  - off: Do not show symbols in the breadcrumbs view.
    //  - last: Only show the current symbol in the breadcrumbs view.
    "breadcrumbs.symbolPath": "on",

    // Controls how symbols are sorted in the breadcrumbs outline view.
    //  - position: Show symbol outline in file position order.
    //  - name: Show symbol outline in alphabetical order.
    //  - type: Show symbol outline in symbol type order.
    "breadcrumbs.symbolSortOrder": "position",

    // Launchpad View (ᴘʀᴏ)
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Launchpad_ view
    "gitlens.views.launchpad.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Launchpad_ view. Only applies when `gitlens.views.launchpad.files.layout` is set to `tree` or `auto`
    "gitlens.views.launchpad.files.compact": true,

    // Specifies how the _Launchpad_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.launchpad.files.icon": "type",

    // Specifies how the _Launchpad_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.launchpad.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.launchpad.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Launchpad_ view. Only applies when `gitlens.views.launchpad.files.layout` is set to `auto`
    "gitlens.views.launchpad.files.threshold": 5,

    // Problems
    // Controls whether Problems view should automatically reveal files when opening them.
    "problems.autoReveal": true,

    // Show Errors & Warnings on files and folder. Overwritten by `problems.visibility` when it is off.
    "problems.decorations.enabled": true,

    // Controls the default view mode of the Problems view.
    "problems.defaultViewMode": "tree",

    // When enabled shows the current problem in the status bar.
    "problems.showCurrentInStatus": false,

    // Controls the order in which problems are navigated.
    //  - severity: Navigate problems ordered by severity
    //  - position: Navigate problems ordered by position
    "problems.sortOrder": "severity",

    // Controls whether the problems are visible throughout the editor and workbench.
    "problems.visibility": true,

    // Commits View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Commits_ view
    "gitlens.views.commits.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Commits_ view. Only applies when `gitlens.views.commits.files.layout` is set to `tree` or `auto`
    "gitlens.views.commits.files.compact": true,

    // Specifies how the _Commits_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.commits.files.icon": "type",

    // Specifies how the _Commits_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.commits.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.commits.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Commits_ view. Only applies when `gitlens.views.commits.files.layout` is set to `auto`
    "gitlens.views.commits.files.threshold": 5,

    // Specifies whether to query for pull requests associated with the current branch and commits in the _Commits_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.commits.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with the current branch in the _Commits_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.commits.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Commits_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.commits.pullRequests.showForCommits": true,

    // Specifies whether to reveal commits in the _Commits_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.commits.reveal": true,

    // Specifies whether to show a comparison of the current branch or the working tree with a user-selected reference (branch, tag, etc) in the _Commits_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the current branch with a user-selected reference
    //  - working: Compares the working tree with a user-selected reference
    "gitlens.views.commits.showBranchComparison": "working",

    // Specifies whether to show stashes in the _Commits_ view
    "gitlens.views.commits.showStashes": false,

    // Telemetry
    // If this setting is false, no telemetry will be sent regardless of the new setting's value. Deprecated due to being combined into the `telemetry.telemetryLevel` setting.
    // Enable crash reports to be collected. This helps us improve stability. 
    // This option requires restart to take effect.
    "telemetry.enableCrashReporter": true,

    // If this setting is false, no telemetry will be sent regardless of the new setting's value. Deprecated in favor of the `telemetry.telemetryLevel` setting.
    // Enable diagnostic data to be collected. This helps us to better understand how Visual Studio Code - Insiders is performing and where improvements need to be made. [Read more](https://go.microsoft.com/fwlink/?LinkId=521839) about what we collect and our privacy statement.
    "telemetry.enableTelemetry": true,

    // Enable feedback mechanisms such as the issue reporter, surveys, and other feedback options.
    "telemetry.feedback.enabled": true,

    // 
    // Controls Visual Studio Code - Insiders telemetry, first-party extension telemetry, and participating third-party extension telemetry. Some third party extensions might not respect this setting. Consult the specific extension's documentation to be sure. Telemetry helps us better understand how Visual Studio Code - Insiders is performing, where improvements need to be made, and how features are being used. Read more about the [data we collect](https://aka.ms/vscode-telemetry) and our [privacy statement](https://go.microsoft.com/fwlink/?LinkId=521839). A full restart of the application is necessary for crash reporting changes to take effect.
    // 
    // &nbsp;
    // 
    // The following table outlines the data sent with each setting:
    // 
    // |       | Crash Reports | Error Telemetry | Usage Data |
    // |:------|:-------------:|:---------------:|:----------:|
    // | all   |       ✓       |        ✓        |     ✓      |
    // | error |       ✓       |        ✓        |     -      |
    // | crash |       ✓       |        -        |     -      |
    // | off   |       -       |        -        |     -      |
    // 
    // 
    // &nbsp;
    // 
    // ****Note:*** If this setting is 'off', no telemetry will be sent regardless of other telemetry settings. If this setting is set to anything except 'off' and telemetry is disabled with deprecated settings, no telemetry will be sent.*
    // 
    //  - all: Sends usage data, errors, and crash reports.
    //  - error: Sends general error telemetry and crash reports.
    //  - crash: Sends OS level crash reports.
    //  - off: Disables all product telemetry.
    "telemetry.telemetryLevel": "all",

    // Outline
    // Controls whether Outline items are collapsed or expanded.
    //  - alwaysCollapse: Collapse all items.
    //  - alwaysExpand: Expand all items.
    "outline.collapseItems": "alwaysExpand",

    // Render Outline elements with icons.
    "outline.icons": true,

    // Use badges for errors and warnings on Outline elements. Overwritten by `problems.visibility` when it is off.
    "outline.problems.badges": true,

    // Use colors for errors and warnings on Outline elements. Overwritten by `problems.visibility` when it is off.
    "outline.problems.colors": true,

    // Show errors and warnings on Outline elements. Overwritten by `problems.visibility` when it is off.
    "outline.problems.enabled": true,

    // When enabled, Outline shows `array`-symbols.
    "outline.showArrays": true,

    // When enabled, Outline shows `boolean`-symbols.
    "outline.showBooleans": true,

    // When enabled, Outline shows `class`-symbols.
    "outline.showClasses": true,

    // When enabled, Outline shows `constant`-symbols.
    "outline.showConstants": true,

    // When enabled, Outline shows `constructor`-symbols.
    "outline.showConstructors": true,

    // When enabled, Outline shows `enumMember`-symbols.
    "outline.showEnumMembers": true,

    // When enabled, Outline shows `enum`-symbols.
    "outline.showEnums": true,

    // When enabled, Outline shows `event`-symbols.
    "outline.showEvents": true,

    // When enabled, Outline shows `field`-symbols.
    "outline.showFields": true,

    // When enabled, Outline shows `file`-symbols.
    "outline.showFiles": true,

    // When enabled, Outline shows `function`-symbols.
    "outline.showFunctions": true,

    // When enabled, Outline shows `interface`-symbols.
    "outline.showInterfaces": true,

    // When enabled, Outline shows `key`-symbols.
    "outline.showKeys": true,

    // When enabled, Outline shows `method`-symbols.
    "outline.showMethods": true,

    // When enabled, Outline shows `module`-symbols.
    "outline.showModules": true,

    // When enabled, Outline shows `namespace`-symbols.
    "outline.showNamespaces": true,

    // When enabled, Outline shows `null`-symbols.
    "outline.showNull": true,

    // When enabled, Outline shows `number`-symbols.
    "outline.showNumbers": true,

    // When enabled, Outline shows `object`-symbols.
    "outline.showObjects": true,

    // When enabled, Outline shows `operator`-symbols.
    "outline.showOperators": true,

    // When enabled, Outline shows `package`-symbols.
    "outline.showPackages": true,

    // When enabled, Outline shows `property`-symbols.
    "outline.showProperties": true,

    // When enabled, Outline shows `string`-symbols.
    "outline.showStrings": true,

    // When enabled, Outline shows `struct`-symbols.
    "outline.showStructs": true,

    // When enabled, Outline shows `typeParameter`-symbols.
    "outline.showTypeParameters": true,

    // When enabled, Outline shows `variable`-symbols.
    "outline.showVariables": true,

    // Inspect View
    // Specifies whether to automatically link external resources in commit messages
    "gitlens.views.commitDetails.autolinks.enabled": true,

    // Specifies whether to lookup additional details about automatically link external resources in commit messages. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.commitDetails.autolinks.enhanced": true,

    // Specifies whether to show avatar images instead of commit (or status) icons in the _Commit Details_ view
    "gitlens.views.commitDetails.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Commit Details_ view. Only applies when `gitlens.views.commitDetails.files.layout` is set to `tree` or `auto`
    "gitlens.views.commitDetails.files.compact": true,

    // Specifies how the _Commit Details_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.commitDetails.files.icon": "type",

    // Specifies how the _Commit Details_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.commitDetails.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.commitDetails.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Commit Details_ view. Only applies when `gitlens.views.commitDetails.files.layout` is set to `auto`
    "gitlens.views.commitDetails.files.threshold": 5,

    // Specifies whether to query for associated pull requests. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.commitDetails.pullRequests.enabled": true,

    // Pull Request View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Pull Request_ view
    "gitlens.views.pullRequest.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Pull Request_ view. Only applies when `gitlens.views.pullRequest.files.layout` is set to `tree` or `auto`
    "gitlens.views.pullRequest.files.compact": true,

    // Specifies how the _Pull Request_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.pullRequest.files.icon": "type",

    // Specifies how the _Pull Request_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.pullRequest.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.pullRequest.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Pull Request_ view. Only applies when `gitlens.views.pullRequest.files.layout` is set to `auto`
    "gitlens.views.pullRequest.files.threshold": 5,

    // Repositories View
    // Specifies whether to automatically refresh the _Repositories_ view when the repository or the file system changes
    "gitlens.views.repositories.autoRefresh": true,

    // Specifies whether to automatically reveal repositories in the _Repositories_ view when opening files
    "gitlens.views.repositories.autoReveal": true,

    // Specifies whether to show avatar images instead of commit (or status) icons in the _Repositories_ view
    "gitlens.views.repositories.avatars": true,

    // Specifies whether to compact (flatten) unnecessary branch and tag nesting in the _Repositories_ view. Only applies when `gitlens.views.repositories.branches.layout` is set to `tree`
    "gitlens.views.repositories.branches.compact": true,

    // Specifies how the _Repositories_ view will display branches and tags
    //  - list: Displays branches and tags as a list
    //  - tree: Displays branches and tags as a tree when names contain slashes `/`
    "gitlens.views.repositories.branches.layout": "tree",

    // Specifies whether to show a comparison of the branch with a user-selected reference (branch, tag, etc) under each branch in the _Repositories_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the branch with a user-selected reference
    "gitlens.views.repositories.branches.showBranchComparison": "branch",

    // Specifies whether to show stashes in the _Commits_ and _Branches_ sections of the _Repositories_ view
    "gitlens.views.repositories.branches.showStashes": false,

    // Specifies whether to show the _Repositories_ view in a compact display density
    "gitlens.views.repositories.compact": false,

    // Deprecated. This setting is no longer used
    // 
    "gitlens.views.repositories.enabled": null,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Repositories_ view. Only applies when `gitlens.views.repositories.files.layout` is set to `tree` or `auto`
    "gitlens.views.repositories.files.compact": true,

    // Specifies how the _Repositories_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.repositories.files.icon": "type",

    // Specifies how the _Repositories_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.repositories.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.repositories.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Repositories_ view. Only applies when `gitlens.views.repositories.files.layout` is set to `auto`
    "gitlens.views.repositories.files.threshold": 5,

    // Specifies whether to include working tree file status for each repository in the _Repositories_ view
    "gitlens.views.repositories.includeWorkingTree": false,

    // Specifies whether to query for pull requests associated with branches and commits in the _Repositories_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.repositories.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with branches in the _Repositories_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.repositories.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Repositories_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.repositories.pullRequests.showForCommits": true,

    // Specifies whether to show a comparison of the current branch or the working tree with a user-selected reference (branch, tag, etc) in the _Repositories_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the current branch with a user-selected reference
    //  - working: Compares the working tree with a user-selected reference
    "gitlens.views.repositories.showBranchComparison": "working",

    // Specifies whether to show the branches for each repository in the _Repositories_ view
    "gitlens.views.repositories.showBranches": true,

    // Specifies whether to show the commits on the current branch for each repository in the _Repositories_ view
    "gitlens.views.repositories.showCommits": true,

    // Specifies whether to show the contributors for each repository in the _Repositories_ view
    "gitlens.views.repositories.showContributors": true,

    // Specifies whether to show the experimental incoming activity for each repository in the _Repositories_ view
    "gitlens.views.repositories.showIncomingActivity": false,

    // Specifies whether to show the remotes for each repository in the _Repositories_ view
    "gitlens.views.repositories.showRemotes": true,

    // Specifies whether to show the stashes for each repository in the _Repositories_ view
    "gitlens.views.repositories.showStashes": false,

    // Specifies whether to show the tags for each repository in the _Repositories_ view
    "gitlens.views.repositories.showTags": true,

    // Specifies whether to show the upstream status of the current branch for each repository in the _Repositories_ view
    "gitlens.views.repositories.showUpstreamStatus": true,

    // Specifies whether to show the worktrees for each repository in the _Repositories_ view
    "gitlens.views.repositories.showWorktrees": true,

    // Specifies how the _Repositories_ view will display worktrees
    //  - name: Displays worktree name
    //  - path: Displays worktree path
    //  - relativePath: Displays worktree relative path
    "gitlens.views.repositories.worktrees.viewAs": "name",

    // File History View
    // Specifies whether file histories will follow renames
    "gitlens.advanced.fileHistoryFollowsRenames": true,

    // Specifies whether file histories will show commits from all branches
    "gitlens.advanced.fileHistoryShowAllBranches": false,

    // Specifies whether file histories will show merge commits
    "gitlens.advanced.fileHistoryShowMergeCommits": false,

    // Specifies whether to show avatar images instead of status icons in the _File History_ view
    "gitlens.views.fileHistory.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _File History_ view. Only applies when `gitlens.views.fileHistory.files.layout` is set to `tree` or `auto`
    "gitlens.views.fileHistory.files.compact": true,

    // Specifies how the _File History_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.fileHistory.files.icon": "type",

    // Specifies how the _File History_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.fileHistory.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.fileHistory.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _File History_ view. Only applies when `gitlens.views.fileHistory.files.layout` is set to `auto`
    "gitlens.views.fileHistory.files.threshold": 5,

    // Specifies the default mode for the _File History_ view
    //  - commits: Displays commits for the selected file or folder
    //  - contributors: Displays contributors for the selected file or folder
    "gitlens.views.fileHistory.mode": "commits",

    // Specifies whether to query for pull requests associated with commits in the _File History_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.fileHistory.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _File History_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.fileHistory.pullRequests.showForCommits": true,

    // Visual File History (ᴘʀᴏ)
    // Specifies whether to allow opening multiple instances of the _Visual File History_ in the editor area
    "gitlens.visualHistory.allowMultiple": true,

    // Specifies the limit on the how many commits can be queried for statistics in the _Visual File History_, because of rate limits. Only applies to virtual workspaces.
    "gitlens.visualHistory.queryLimit": 20,

    // Line History View
    // Specifies whether to show avatar images instead of status icons in the _Line History_ view
    "gitlens.views.lineHistory.avatars": true,

    // Deprecated. This setting is no longer used
    // 
    "gitlens.views.lineHistory.enabled": null,

    // Branches View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Branches_ view
    "gitlens.views.branches.avatars": true,

    // Specifies whether to compact (flatten) unnecessary branch nesting in the _Branches_ view. Only applies when `gitlens.views.branches.branches.layout` is set to `tree`
    "gitlens.views.branches.branches.compact": true,

    // Specifies how the _Branches_ view will display branches
    //  - list: Displays branches as a list
    //  - tree: Displays branches as a tree when names contain slashes `/`
    "gitlens.views.branches.branches.layout": "tree",

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Branches_ view. Only applies when `gitlens.views.branches.files.layout` is set to `tree` or `auto`
    "gitlens.views.branches.files.compact": true,

    // Specifies how the _Branches_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.branches.files.icon": "type",

    // Specifies how the _Branches_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.branches.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.branches.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Branches_ view. Only applies when `gitlens.views.branches.files.layout` is set to `auto`
    "gitlens.views.branches.files.threshold": 5,

    // Specifies whether to query for pull requests associated with each branch and commits in the _Branches_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.branches.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with each branch in the _Branches_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.branches.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Branches_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.branches.pullRequests.showForCommits": true,

    // Specifies whether to reveal branches in the _Branches_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.branches.reveal": true,

    // Specifies whether to show a comparison of the branch with a user-selected reference (branch, tag, etc) in the _Branches_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the branch with a user-selected reference
    "gitlens.views.branches.showBranchComparison": "branch",

    // Specifies whether to show remote branches for the default remote in the _Branches_ view
    "gitlens.views.branches.showRemoteBranches": false,

    // Specifies whether to show stashes in the _Branches_ view
    "gitlens.views.branches.showStashes": false,

    // Remotes View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Remotes_ view
    "gitlens.views.remotes.avatars": true,

    // Specifies whether to compact (flatten) unnecessary branch nesting in the _Remotes_ view. Only applies when `gitlens.views.remotes.branches.layout` is set to `tree`
    "gitlens.views.remotes.branches.compact": true,

    // Specifies how the _Remotes_ view will display branches
    //  - list: Displays branches as a list
    //  - tree: Displays branches as a tree when names contain slashes `/`
    "gitlens.views.remotes.branches.layout": "tree",

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Remotes_ view. Only applies when `gitlens.views.remotes.files.layout` is set to `tree` or `auto`
    "gitlens.views.remotes.files.compact": true,

    // Specifies how the _Remotes_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.remotes.files.icon": "type",

    // Specifies how the _Remotes_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.remotes.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.remotes.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Remotes_ view. Only applies when `gitlens.views.remotes.files.layout` is set to `auto`
    "gitlens.views.remotes.files.threshold": 5,

    // Specifies whether to query for pull requests associated with each branch and commits in the _Remotes_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.remotes.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with each branch in the _Remotes_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.remotes.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Remotes_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.remotes.pullRequests.showForCommits": true,

    // Specifies whether to reveal remotes in the _Remotes_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.remotes.reveal": true,

    // Stashes View
    // Specifies whether to compact (flatten) unnecessary file nesting in the _Stashes_ view. Only applies when `gitlens.views.stashes.files.layout` is set to `tree` or `auto`
    "gitlens.views.stashes.files.compact": true,

    // Specifies how the _Stashes_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.stashes.files.icon": "type",

    // Specifies how the _Stashes_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.stashes.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.stashes.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Stashes_ view. Only applies when `gitlens.views.stashes.files.layout` is set to `auto`
    "gitlens.views.stashes.files.threshold": 5,

    // Specifies whether to reveal stashes in the _Stashes_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.stashes.reveal": true,

    // Tags View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Tags_ view
    "gitlens.views.tags.avatars": true,

    // Specifies whether to compact (flatten) unnecessary tag nesting in the _Tags_ view. Only applies when `gitlens.views.tags.branches.layout` is set to `tree`
    "gitlens.views.tags.branches.compact": true,

    // Specifies how the _Tags_ view will display tags
    //  - list: Displays tags as a list
    //  - tree: Displays tags as a tree when names contain slashes `/`
    "gitlens.views.tags.branches.layout": "tree",

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Tags_ view. Only applies when `gitlens.views.tags.files.layout` is set to `tree` or `auto`
    "gitlens.views.tags.files.compact": true,

    // Specifies how the _Tags_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.tags.files.icon": "type",

    // Specifies how the _Tags_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.tags.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.tags.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Tags_ view. Only applies when `gitlens.views.tags.files.layout` is set to `auto`
    "gitlens.views.tags.files.threshold": 5,

    // Specifies whether to reveal tags in the _Tags_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.tags.reveal": true,

    // Worktrees View (ᴘʀᴏ)
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Worktrees_ view
    "gitlens.views.worktrees.avatars": true,

    // Specifies whether to compact (flatten) unnecessary branch nesting in the _Worktrees_ view. Only applies when `gitlens.views.worktrees.branches.layout` is set to `tree`
    "gitlens.views.worktrees.branches.compact": true,

    // Specifies how the _Worktrees_ view will display worktree branches
    //  - list: Displays worktree branches as a list
    //  - tree: Displays worktree branches as a tree when names contain slashes `/`
    "gitlens.views.worktrees.branches.layout": "tree",

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Worktrees_ view. Only applies when `gitlens.views.worktrees.files.layout` is set to `tree` or `auto`
    "gitlens.views.worktrees.files.compact": true,

    // Specifies how the _Worktrees_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.worktrees.files.icon": "type",

    // Specifies how the _Worktrees_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.worktrees.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.worktrees.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Worktrees_ view. Only applies when `gitlens.views.worktrees.files.layout` is set to `auto`
    "gitlens.views.worktrees.files.threshold": 5,

    // Specifies whether to query for pull requests associated with the worktree branch and commits in the _Worktrees_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.worktrees.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with the worktree branch in the _Worktrees_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.worktrees.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Worktrees_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.worktrees.pullRequests.showForCommits": true,

    // Specifies whether to reveal worktrees in the _Worktrees_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.worktrees.reveal": true,

    // Specifies whether to show a comparison of the worktree branch with a user-selected reference (branch, tag, etc) in the _Worktrees_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the worktree branch with a user-selected reference
    "gitlens.views.worktrees.showBranchComparison": "working",

    // Specifies whether to show stashes in the _Worktrees_ view
    "gitlens.views.worktrees.showStashes": false,

    // Specifies how the _Worktrees_ view will display worktrees
    //  - name: Displays worktree name
    //  - path: Displays worktree path
    //  - relativePath: Displays worktree relative path
    "gitlens.views.worktrees.worktrees.viewAs": "name",

    // Specifies the default path in which new worktrees will be created
    "gitlens.worktrees.defaultLocation": null,

    // Specifies how and when to open a worktree after it is created
    //  - always: Always open the new worktree in the current window
    //  - alwaysNewWindow: Always open the new worktree in a new window
    //  - onlyWhenEmpty: Only open the new worktree in the current window when no folder is opened
    //  - never: Never open the new worktree
    //  - prompt: Always prompt to open the new worktree
    "gitlens.worktrees.openAfterCreate": "prompt",

    // Specifies whether to prompt for a path when creating new worktrees
    "gitlens.worktrees.promptForLocation": true,

    // Contributors View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Contributors_ view
    "gitlens.views.contributors.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Contributors_ view. Only applies when `gitlens.views.contributors.files.layout` is set to `tree` or `auto`
    "gitlens.views.contributors.files.compact": true,

    // Specifies how the _Contributors_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.contributors.files.icon": "type",

    // Specifies how the _Contributors_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.contributors.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.contributors.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Contributors_ view. Only applies when `gitlens.views.contributors.files.layout` is set to `auto`
    "gitlens.views.contributors.files.threshold": 5,

    // Specifies the maximum amount of time (in seconds) to wait for all contributors to load. Use 0 to wait indefinitely (no timeout)
    "gitlens.views.contributors.maxWait": 10,

    // Specifies whether to query for pull requests associated with branches and commits in the _Contributors_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.contributors.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Contributors_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.contributors.pullRequests.showForCommits": true,

    // Specifies whether to reveal contributors in the _Contributors_ view, otherwise they revealed in the _Repositories_ view
    "gitlens.views.contributors.reveal": true,

    // Specifies whether to show commits from all branches in the _Contributors_ view
    "gitlens.views.contributors.showAllBranches": false,

    // Specifies whether to show contributor statistics in the _Contributors_ view. This can take a while to compute depending on the repository size
    "gitlens.views.contributors.showStatistics": false,

    // Search & Compare View
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Search & Compare_ view
    "gitlens.views.searchAndCompare.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Search & Compare_ view. Only applies when `gitlens.views.searchAndCompare.files.layout` is set to `tree` or `auto`
    "gitlens.views.searchAndCompare.files.compact": true,

    // Specifies how the _Search & Compare_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.searchAndCompare.files.icon": "type",

    // Specifies how the _Search & Compare_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.searchAndCompare.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.searchAndCompare.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Search & Compare_ view. Only applies when `gitlens.views.searchAndCompare.files.layout` is set to `auto`
    "gitlens.views.searchAndCompare.files.threshold": 5,

    // Specifies whether to query for pull requests associated with commits in the _Search & Compare_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.searchAndCompare.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Search & Compare_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.searchAndCompare.pullRequests.showForCommits": true,

    // Cloud Patches View (ᴘʀᴇᴠɪᴇᴡ)
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Cloud Patches_ view
    "gitlens.views.drafts.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Cloud Patches_ view. Only applies when `gitlens.views.drafts.files.layout` is set to `tree` or `auto`
    "gitlens.views.drafts.files.compact": true,

    // Specifies how the _Cloud Patches_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.drafts.files.icon": "type",

    // Specifies how the _Cloud Patches_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.drafts.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.drafts.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Cloud Patches_ view. Only applies when `gitlens.views.drafts.files.layout` is set to `auto`
    "gitlens.views.drafts.files.threshold": 5,

    // Patch Details View (ᴘʀᴇᴠɪᴇᴡ)
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Patch Details_ view
    "gitlens.views.patchDetails.avatars": true,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Patch Details_ view. Only applies when `gitlens.views.patchDetails.files.layout` is set to `tree` or `auto`
    "gitlens.views.patchDetails.files.compact": true,

    // Specifies how the _Patch Details_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.patchDetails.files.icon": "type",

    // Specifies how the _Patch Details_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.patchDetails.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.patchDetails.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Patch Details_ view. Only applies when `gitlens.views.patchDetails.files.layout` is set to `auto`
    "gitlens.views.patchDetails.files.threshold": 5,

    // Cloud Workspaces View (ᴘʀᴇᴠɪᴇᴡ)
    // Specifies whether to show avatar images instead of commit (or status) icons in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.avatars": true,

    // Specifies whether to compact (flatten) unnecessary branch and tag nesting in the _Cloud Workspaces_ view. Only applies when `gitlens.views.workspaces.branches.layout` is set to `tree`
    "gitlens.views.workspaces.branches.compact": true,

    // Specifies how the _Cloud Workspaces_ view will display branches and tags
    //  - list: Displays branches and tags as a list
    //  - tree: Displays branches and tags as a tree when names contain slashes `/`
    "gitlens.views.workspaces.branches.layout": "tree",

    // Specifies whether to show a comparison of the branch with a user-selected reference (branch, tag, etc) under each branch in the _Cloud Workspaces_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the branch with a user-selected reference
    "gitlens.views.workspaces.branches.showBranchComparison": "branch",

    // Specifies whether to show stashes in the _Commits_ and _Branches_ sections of the _Cloud Workspaces_ view
    "gitlens.views.workspaces.branches.showStashes": false,

    // Specifies whether to show the _Cloud Workspaces_ view in a compact display density
    "gitlens.views.workspaces.compact": false,

    // Specifies whether to compact (flatten) unnecessary file nesting in the _Cloud Workspaces_ view. Only applies when `gitlens.views.workspaces.files.layout` is set to `tree` or `auto`
    "gitlens.views.workspaces.files.compact": true,

    // Specifies how the _Cloud Workspaces_ view will display file icons
    //  - status: Shows the file's status as the icon
    //  - type: Shows the file's type (theme icon) as the icon
    "gitlens.views.workspaces.files.icon": "type",

    // Specifies how the _Cloud Workspaces_ view will display files
    //  - auto: Automatically switches between displaying files as a `tree` or `list` based on the `gitlens.views.workspaces.files.threshold` value and the number of files at each nesting level
    //  - list: Displays files as a list
    //  - tree: Displays files as a tree
    "gitlens.views.workspaces.files.layout": "auto",

    // Specifies when to switch between displaying files as a `tree` or `list` based on the number of files in a nesting level in the _Cloud Workspaces_ view. Only applies when `gitlens.views.workspaces.files.layout` is set to `auto`
    "gitlens.views.workspaces.files.threshold": 5,

    // Specifies whether to include working tree file status for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.includeWorkingTree": false,

    // Specifies whether to query for pull requests associated with branches and commits in the _Cloud Workspaces_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.workspaces.pullRequests.enabled": true,

    // Specifies whether to show pull requests (if any) associated with branches in the _Cloud Workspaces_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.workspaces.pullRequests.showForBranches": true,

    // Specifies whether to show pull requests (if any) associated with commits in the _Cloud Workspaces_ view. Requires a connection to a supported remote service (e.g. GitHub)
    "gitlens.views.workspaces.pullRequests.showForCommits": true,

    // Specifies whether to show a comparison of the current branch or the working tree with a user-selected reference (branch, tag, etc) in the _Cloud Workspaces_ view
    //  - false: Hides the branch comparison
    //  - branch: Compares the current branch with a user-selected reference
    //  - working: Compares the working tree with a user-selected reference
    "gitlens.views.workspaces.showBranchComparison": "working",

    // Specifies whether to show the branches for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showBranches": true,

    // Specifies whether to show the commits on the current branch for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showCommits": true,

    // Specifies whether to show the contributors for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showContributors": true,

    // Specifies whether to show the experimental incoming activity for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showIncomingActivity": false,

    // Specifies whether to show the remotes for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showRemotes": true,

    // Specifies whether to show the stashes for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showStashes": false,

    // Specifies whether to show the tags for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showTags": true,

    // Specifies whether to show the upstream status of the current branch for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showUpstreamStatus": true,

    // Specifies whether to show the worktrees for each repository in the _Cloud Workspaces_ view
    "gitlens.views.workspaces.showWorktrees": true,

    // Specifies how the _Cloud Workspaces_ view will display worktrees
    //  - name: Displays worktree name
    //  - path: Displays worktree path
    //  - relativePath: Displays worktree relative path
    "gitlens.views.workspaces.worktrees.viewAs": "name",

    // Interactive Rebase Editor
    // Specifies how Git commits are displayed in the _Interactive Rebase Editor_
    //  - asc: Shows oldest commit first
    //  - desc: Shows newest commit first
    "gitlens.rebaseEditor.ordering": "desc",

    // Specifies when to show the _Commit Details_ view for the selected row in the _Interactive Rebase Editor_
    //  - false: Never shows the _Commit Details_ view automatically
    //  - open: Shows the _Commit Details_ view automatically only when opening the _Interactive Rebase Editor_
    //  - selection: Shows the _Commit Details_ view automatically when selection changes in the _Interactive Rebase Editor_
    "gitlens.rebaseEditor.showDetailsView": "selection",

    // Git Command Palette
    // Specifies whether to show avatar images in quick pick menus when applicable
    "gitlens.gitCommands.avatars": true,

    // Specifies whether to dismiss the _Git Command Palette_ when focus is lost (if not, press `ESC` to dismiss)
    "gitlens.gitCommands.closeOnFocusOut": true,

    // Specifies whether to match all or any commit message search patterns
    "gitlens.gitCommands.search.matchAll": false,

    // Specifies whether to match commit search patterns with or without regard to casing
    "gitlens.gitCommands.search.matchCase": false,

    // Specifies whether to match commit search patterns using regular expressions
    "gitlens.gitCommands.search.matchRegex": true,

    // Specifies whether to show the commit search results directly in the quick pick menu, in the Side Bar, or will be based on the context
    "gitlens.gitCommands.search.showResultsInSideBar": null,

    // Deprecated. This setting has been renamed to `gitlens.gitCommands.search.showResultsInSideBar`
    // 
    "gitlens.gitCommands.search.showResultsInView": null,

    // Specifies which (and when) Git commands will skip the confirmation step, using the format: `git-command-name:(menu|command)`
    //  - branch-create:command: Skips branch create confirmations when run from a command, e.g. a view action
    //  - branch-create:menu: Skips branch create confirmations when run from the Git Command Palette
    //  - co-authors:command: Skips co-author confirmations when run from a command, e.g. a view action
    //  - co-authors:menu: Skips co-author confirmations when run from the Git Command Palette
    //  - fetch:command: Skips fetch confirmations when run from a command, e.g. a view action
    //  - fetch:menu: Skips fetch confirmations when run from the Git Command Palette
    //  - pull:command: Skips pull confirmations when run from a command, e.g. a view action
    //  - pull:menu: Skips pull confirmations when run from the Git Command Palette
    //  - push:command: Skips push confirmations when run from a command, e.g. a view action
    //  - push:menu: Skips push confirmations when run from the Git Command Palette
    //  - stash-apply:command: Skips stash apply confirmations when run from a command, e.g. a view action
    //  - stash-apply:menu: Skips stash apply confirmations when run from the Git Command Palette
    //  - stash-pop:command: Skips stash pop confirmations when run from a command, e.g. a view action
    //  - stash-pop:menu: Skips stash pop confirmations when run from the Git Command Palette
    //  - stash-push:command: Skips stash push confirmations when run from a command, e.g. a view action
    //  - stash-push:menu: Skips stash push confirmations when run from the Git Command Palette
    //  - switch:command: Skips switch confirmations when run from a command, e.g. a view action
    //  - switch:menu: Skips switch confirmations when run from the Git Command Palette
    //  - tag-create:command: Skips tag create confirmations when run from a command, e.g. a view action
    //  - tag-create:menu: Skips tag create confirmations when run from the Git Command Palette
    "gitlens.gitCommands.skipConfirmations": [
        "fetch:command",
        "stash-push:command"
    ],

    // Specifies how Git commands are sorted in the _Git Command Palette_
    //  - name: Sorts commands by name
    //  - usage: Sorts commands by last used date
    "gitlens.gitCommands.sortBy": "usage",

    // Integrations
    // Specifies autolinks to external resources in commit messages. Use `<num>` as the variable for the reference number
    "gitlens.autolinks": null,

    // Specifies whether to use cloud-based integrations when authenticating with GitHub
    "gitlens.cloudIntegrations.enabled": true,

    // Specifies whether to enable rich integrations with any supported remote services
    "gitlens.integrations.enabled": true,

    // Specifies whether to allow guest access to GitLens features when using Visual Studio Live Share
    "gitlens.liveshare.allowGuestAccess": true,

    // Specifies whether to enable integration with Visual Studio Live Share
    "gitlens.liveshare.enabled": true,

    // Specifies the configuration of a partner integration
    "gitlens.partners": null,

    // Specifies custom remote services to be matched with Git remotes to detect custom domains for built-in remote services or provide support for custom remote services
    "gitlens.remotes": null,

    // Terminal
    // Specifies whether to enable experimental integration with the GitKraken CLI
    "gitlens.gitkraken.cli.integration.enabled": false,

    // Specifies whether to automatically install and enable the GitKraken MCP. This only applies to VS Code 1.101 and later.
    "gitlens.gitkraken.mcp.autoEnabled": true,

    // Specifies whether to use VS Code as Git's `core.editor` for Gitlens terminal commands
    "gitlens.terminal.overrideGitEditor": true,

    // Specifies whether to enable terminal links &mdash; autolinks in the integrated terminal to quickly jump to more details for commits, branches, tags, and more
    "gitlens.terminalLinks.enabled": true,

    // Specifies whether to show the _Commit Details_ view when clicking on a commit link in the integrated terminal
    "gitlens.terminalLinks.showDetailsView": true,

    // AI (ᴘʀᴇᴠɪᴇᴡ)
    // Specifies a custom URL to use for access to an Azure OpenAI model. Azure URLs should be in the following format: https://{your-resource-name}.openai.azure.com/openai/deployments/{deployment-id}/chat/completions?api-version={api-version}
    "gitlens.ai.azure.url": null,

    // Specifies whether to enable GitLens' AI-powered features
    "gitlens.ai.enabled": true,

    // Specifies whether to enable the experimental version of the commit composer
    "gitlens.ai.experimental.composer.enabled": false,

    // Specifies custom instructions to provide to the AI provider when generating a summary of changes
    "gitlens.ai.explainChanges.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a changelog from a set of changes
    "gitlens.ai.generateChangelog.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a commit message
    "gitlens.ai.generateCommitMessage.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating commits
    "gitlens.ai.generateCommits.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a cloud patch title and description
    "gitlens.ai.generateCreateCloudPatch.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a code suggest title and description
    "gitlens.ai.generateCreateCodeSuggest.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a pull request title and description
    "gitlens.ai.generateCreatePullRequest.customInstructions": null,

    // Specifies custom instructions to provide to the AI provider when generating a stash message
    "gitlens.ai.generateStashMessage.customInstructions": null,

    // Specifies the GitKraken AI provided model to use for GitLens' AI features, formatted as `provider:model`
    "gitlens.ai.gitkraken.model": null,

    // Specifies the threshold (in tokens) for when to show a warning about the prompt being too large
    "gitlens.ai.largePromptWarningThreshold": 20000,

    // Specifies the AI provider and model to use for GitLens' AI features. Should be formatted as `provider:model` (e.g. `openai:gpt-4o` or `anthropic:claude-3-5-sonnet-latest`), `gitkraken` for GitKraken AI provided models, or `vscode` for models provided by the VS Code extension API (e.g. Copilot)
    "gitlens.ai.model": null,

    // Specifies the temperature, a measure of output randomness, to use for the AI model. Higher values result in more randomness, e.g. creativity, while lower values are more deterministic
    "gitlens.ai.modelOptions.temperature": 0.7,

    // Specifies the Ollama URL to use for access
    "gitlens.ai.ollama.url": null,

    // Specifies a custom URL to use for access to an OpenAI model.
    "gitlens.ai.openai.url": null,

    // Specifies a custom URL to use for access to an OpenAI-compatible model.
    "gitlens.ai.openaicompatible.url": null,

    // Specifies the VS Code provided model to use for GitLens' AI features, formatted as `provider:model`
    "gitlens.ai.vscode.model": null,

    // Timeline
    // Controls whether the Timeline view will load the next page of items when you scroll to the end of the list.
    "timeline.pageOnScroll": true,

    // The number of items to show in the Timeline view by default and when loading more items. Setting to `null` will automatically choose a page size based on the visible area of the Timeline view.
    "timeline.pageSize": 50,

    // Date & Times
    // Specifies how absolute dates will be formatted by default. See the [Moment.js docs](https://momentjs.com/docs/#/displaying/format/) for supported formats
    "gitlens.defaultDateFormat": null,

    // Specifies the locale, a [BCP 47 language tag](https://en.wikipedia.org/wiki/IETF_language_tag#List_of_major_primary_language_subtags), to use for date formatting, defaults to the VS Code locale. Use `system` to follow the current system locale, or choose a specific locale, e.g `en-US` — US English, `en-GB` — British English, `de-DE` — German, `ja-JP` = Japanese, etc.
    "gitlens.defaultDateLocale": null,

    // Specifies how short absolute dates will be formatted by default. See the [Moment.js docs](https://momentjs.com/docs/#/displaying/format/) for supported formats
    "gitlens.defaultDateShortFormat": null,

    // Specifies whether commit dates should use the authored or committed date
    //  - authored: Uses the date when the changes were authored (i.e. originally written)
    //  - committed: Uses the date when the changes were committed
    "gitlens.defaultDateSource": "authored",

    // Specifies how dates will be displayed by default
    //  - relative: e.g. 1 day ago
    //  - absolute: e.g. July 25th, 2018 7:18pm
    "gitlens.defaultDateStyle": "relative",

    // Specifies how times will be formatted by default. See the [Moment.js docs](https://momentjs.com/docs/#/displaying/format/) for supported formats
    "gitlens.defaultTimeFormat": null,

    // Sorting
    // Specifies how branches are sorted in quick pick menus and views
    //  - date:desc: Sorts branches by the most recent commit date in descending order
    //  - date:asc: Sorts branches by the most recent commit date in ascending order
    //  - name:asc: Sorts branches by name in ascending order
    //  - name:desc: Sorts branches by name in descending order
    "gitlens.sortBranchesBy": "date:desc",

    // Specifies how contributors are sorted in quick pick menus and views
    //  - count:desc: Sorts contributors by commit count in descending order
    //  - count:asc: Sorts contributors by commit count in ascending order
    //  - date:desc: Sorts contributors by the most recent commit date in descending order
    //  - date:asc: Sorts contributors by the most recent commit date in ascending order
    //  - name:asc: Sorts contributors by name in ascending order
    //  - name:desc: Sorts contributors by name in descending order
    "gitlens.sortContributorsBy": "count:desc",

    // Specifies how repositories are sorted in quick pick menus and views
    //  - discovered: Sorts repositories by discovery or workspace order
    //  - lastFetched:desc: Sorts repositories by last fetched date in descending order
    //  - lastFetched:asc: Sorts repositories by last fetched date in ascending order
    //  - name:asc: Sorts repositories by name in ascending order
    //  - name:desc: Sorts repositories by name in descending order
    "gitlens.sortRepositoriesBy": "discovered",

    // Specifies how tags are sorted in quick pick menus and views
    //  - date:desc: Sorts tags by date in descending order
    //  - date:asc: Sorts tags by date in ascending order
    //  - name:asc: Sorts tags by name in ascending order
    //  - name:desc: Sorts tags by name in descending order
    "gitlens.sortTagsBy": "date:desc",

    // Specifies how worktrees are sorted in quick pick menus and views
    //  - date:desc: Sorts worktrees by the most recent commit date in descending order
    //  - date:asc: Sorts worktrees by the most recent commit date in ascending order
    //  - name:asc: Sorts worktrees by name in ascending order
    //  - name:desc: Sorts worktrees by name in descending order
    "gitlens.sortWorktreesBy": "date:desc",

    // Menus & Toolbars
    // Specifies which commands will be added to which menus
    "gitlens.menus": {
        "editor": {
            "blame": true,
            "clipboard": true,
            "compare": true,
            "history": true,
            "remote": true
        },
        "editorGroup": {
            "blame": true,
            "compare": true
        },
        "editorGutter": {
            "compare": true,
            "remote": true,
            "share": true
        },
        "editorTab": {
            "clipboard": true,
            "compare": true,
            "history": true,
            "remote": true
        },
        "explorer": {
            "clipboard": true,
            "compare": true,
            "history": true,
            "remote": true
        },
        "ghpr": {
            "worktree": true
        },
        "scm": {
            "graph": true,
            "visualHistory": true
        },
        "scmRepositoryInline": {
            "generateCommitMessage": true,
            "graph": true,
            "stash": true
        },
        "scmRepository": {
            "authors": true,
            "generateCommitMessage": true,
            "graph": true,
            "patch": true,
            "visualHistory": true
        },
        "scmGroupInline": {
            "stash": true
        },
        "scmGroup": {
            "compare": true,
            "openClose": true,
            "patch": true,
            "stash": true
        },
        "scmItemInline": {
            "stash": false
        },
        "scmItem": {
            "clipboard": true,
            "compare": true,
            "history": true,
            "patch": true,
            "remote": true,
            "share": true,
            "stash": true
        }
    },

    // Keyboard Shortcuts
    // Specifies the keymap to use for GitLens shortcut keys
    //  - alternate: Adds an alternate set of shortcut keys that start with `Alt` (⌥ on macOS)
    //  - chorded: Adds a chorded set of shortcut keys that start with `Ctrl+Shift+G` (`⌥⌘G` on macOS)
    //  - none: No shortcut keys will be added
    "gitlens.keymap": "chorded",

    // Modes
    // Specifies the active GitLens mode, if any
    "gitlens.mode.active": "",

    // Specifies the active GitLens mode alignment in the status bar
    //  - left: Aligns to the left
    //  - right: Aligns to the right
    "gitlens.mode.statusBar.alignment": "right",

    // Specifies whether to provide the active GitLens mode in the status bar
    "gitlens.mode.statusBar.enabled": true,

    // Specifies the user-defined GitLens modes
    "gitlens.modes": {
        "zen": {
            "name": "Zen",
            "statusBarItemName": "Zen",
            "description": "for a zen-like experience, disables many visual features",
            "codeLens": false,
            "currentLine": false,
            "hovers": false,
            "statusBar": false
        },
        "review": {
            "name": "Review",
            "statusBarItemName": "Reviewing",
            "description": "for reviewing code, enables many visual features",
            "codeLens": true,
            "currentLine": true,
            "hovers": true
        }
    },

    // GitKraken
    // Specifies the ID of the user's active GitKraken organization in GitLens
    "gitlens.gitkraken.activeOrganizationId": "",

    // Advanced
    // Specifies the length of abbreviated commit SHAs
    "gitlens.advanced.abbreviatedShaLength": 7,

    // Specifies whether to copy full or abbreviated commit SHAs to the clipboard. Abbreviates to the length of `gitlens.advanced.abbreviatedShaLength`.
    "gitlens.advanced.abbreviateShaOnCopy": false,

    // Specifies additional arguments to pass to the `git blame` command
    "gitlens.advanced.blame.customArguments": null,

    // Specifies whether to cache (per-workspace) the path to the Git executable to use for GitLens
    "gitlens.advanced.caching.gitPath": true,

    // Specifies the order by which commits will be shown. If unspecified, commits will be shown in reverse chronological order
    //  - null: Shows commits in reverse chronological order
    //  - date: Shows commits in reverse chronological order of the commit timestamp
    //  - author-date: Shows commits in reverse chronological order of the author timestamp
    //  - topo: Shows commits in reverse chronological order of the commit timestamp, but avoids intermixing multiple lines of history
    "gitlens.advanced.commitOrdering": null,

    // Specifies whether to delay loading commit file details until required. This can improve performance when opening repositories with large histories, but causes more incremental Git calls
    "gitlens.advanced.commits.delayLoadingFileDetails": false,

    // Specifies an optional external diff tool to use when comparing files. Must be a configured [Git difftool](https://git-scm.com/docs/git-config#Documentation/git-config.txt-difftool).
    "gitlens.advanced.externalDiffTool": null,

    // Specifies an optional external diff tool to use when comparing directories. Must be a configured [Git difftool](https://git-scm.com/docs/git-config#Documentation/git-config.txt-difftool).
    "gitlens.advanced.externalDirectoryDiffTool": null,

    // Specifies the maximum number of items to show in a list. Use 0 to specify no maximum
    "gitlens.advanced.maxListItems": 200,

    // Specifies the maximum number of items to show in a search. Use 0 to specify no maximum
    "gitlens.advanced.maxSearchItems": 200,

    // Specifies which messages should be suppressed
    "gitlens.advanced.messages": {
        "suppressBitbucketPRCommitLinksAppNotInstalledWarning": false,
        "suppressCommitHasNoPreviousCommitWarning": false,
        "suppressCommitNotFoundWarning": false,
        "suppressCreatePullRequestPrompt": false,
        "suppressDebugLoggingWarning": false,
        "suppressFileNotUnderSourceControlWarning": false,
        "suppressGitDisabledWarning": false,
        "suppressGitMissingWarning": false,
        "suppressGitVersionWarning": false,
        "suppressLineUncommittedWarning": false,
        "suppressNoRepositoryWarning": false,
        "suppressRebaseSwitchToTextWarning": false,
        "suppressIntegrationDisconnectedTooManyFailedRequestsWarning": false,
        "suppressIntegrationRequestFailed500Warning": false,
        "suppressIntegrationRequestTimedOutWarning": false,
        "suppressBlameInvalidIgnoreRevsFileWarning": false,
        "suppressBlameInvalidIgnoreRevsFileBadRevisionWarning": false
    },

    // Specifies whether to dismiss quick pick menus when focus is lost (if not, press `ESC` to dismiss)
    "gitlens.advanced.quickPick.closeOnFocusOut": true,

    // Specifies how many folders deep to search for repositories. Defaults to `git.repositoryScanMaxDepth`
    "gitlens.advanced.repositorySearchDepth": null,

    // Specifies whether to resolve symbolic links when determining file paths for Git operations
    "gitlens.advanced.resolveSymlinks": false,

    // Specifies the amount (percent) of similarity a deleted and added file pair must have to be considered a rename
    "gitlens.advanced.similarityThreshold": null,

    // Specifies whether to ignore whitespace when comparing revisions during blame operations
    "gitlens.blame.ignoreWhitespace": false,

    // Specifies debug mode
    "gitlens.debug": false,

    // Specifies whether to override the default deep link scheme (vscode://) with the environment value or a specified value
    "gitlens.deepLinks.schemeOverride": false,

    // Specifies whether to attempt to detect nested repositories when opening files
    "gitlens.detectNestedRepositories": false,

    // Specifies whether to allow GitLens to send product usage telemetry.
    // 
    // _**Note:** For GitLens to send any telemetry BOTH this setting and VS Code telemetry must be enabled. If either one is disabled no telemetry will be sent._
    "gitlens.telemetry.enabled": true,

    // Default Language Configuration Overrides
    // Configure settings to be overridden for ansible, azure-pipelines, css, dockerfile, dockercompose, html, json, jsonc, less, postcss, scss, stylus, vue, yaml.
    "[ansible][azure-pipelines][css][dockerfile][dockercompose][html][json][jsonc][less][postcss][scss][stylus][vue][yaml]":  {
        "gitlens.codeLens.scopes": [
                "document"
        ]
    },

    // Configure settings to be overridden for bicep-params.
    "[bicep-params]":  {
        "editor.tabSize": 2,
        "editor.insertSpaces": true,
        "files.insertFinalNewline": true,
        "editor.suggestSelection": "first",
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        "editor.suggest.showWords": false
    },

    // Configure settings to be overridden for bicep.
    "[bicep]":  {
        "editor.tabSize": 2,
        "editor.insertSpaces": true,
        "files.insertFinalNewline": true,
        "editor.suggestSelection": "first",
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        "editor.suggest.showWords": false
    },

    // Configure settings to be overridden for chatagent.
    "[chatagent]":  {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "advanced",
        "editor.unicodeHighlight.ambiguousCharacters": false,
        "editor.unicodeHighlight.invisibleCharacters": false,
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.wordWrap": "on",
        "editor.quickSuggestions": {
                "comments": "off",
                "strings": "on",
                "other": "on"
        },
        "editor.wordBasedSuggestions": "off"
    },

    // Configure settings to be overridden for clojure.
    "[clojure]":  {
        "diffEditor.ignoreTrimWhitespace": false
    },

    // Configure settings to be overridden for coffeescript.
    "[coffeescript]":  {
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.defaultColorDecorators": "never"
    },

    // Configure settings to be overridden for csharp.
    "[csharp]":  {
        "editor.maxTokenizationLineLength": 2500
    },

    // Configure settings to be overridden for css.
    "[css]":  {
        "editor.suggest.insertMode": "replace",
        "cSpell.fixSpellingWithRenameProvider": false
    },

    // Configure settings to be overridden for dockercompose.
    "[dockercompose]":  {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "advanced",
        "editor.quickSuggestions": {
                "other": true,
                "comments": false,
                "strings": true
        }
    },

    // Configure settings to be overridden for dockerfile.
    "[dockerfile]":  {
        "editor.quickSuggestions": {
                "strings": true
        }
    },

    // Configure settings to be overridden for dynamic csv, csv, tsv, csv (semicolon), csv (pipe), csv (whitespace).
    "[dynamic csv][csv][tsv][csv (semicolon)][csv (pipe)][csv (whitespace)]":  {
        "editor.semanticHighlighting.enabled": true
    },

    // Configure settings to be overridden for fsharp.
    "[fsharp]":  {
        "diffEditor.ignoreTrimWhitespace": false
    },

    // Configure settings to be overridden for git-commit.
    "[git-commit]":  {
        "editor.rulers": [
                50,
                72
        ],
        "editor.wordWrap": "off",
        "workbench.editor.restoreViewState": false
    },

    // Configure settings to be overridden for git-rebase.
    "[git-rebase]":  {
        "workbench.editor.restoreViewState": false
    },

    // Configure settings to be overridden for go.
    "[go]":  {
        "editor.insertSpaces": false
    },

    // Configure settings to be overridden for handlebars.
    "[handlebars]":  {
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for html.
    "[html]":  {
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for instructions.
    "[instructions]":  {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "advanced",
        "editor.unicodeHighlight.ambiguousCharacters": false,
        "editor.unicodeHighlight.invisibleCharacters": false,
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.wordWrap": "on",
        "editor.quickSuggestions": {
                "comments": "off",
                "strings": "on",
                "other": "on"
        },
        "editor.wordBasedSuggestions": "off"
    },

    // Configure settings to be overridden for jade.
    "[jade]":  {
        "diffEditor.ignoreTrimWhitespace": false
    },

    // Configure settings to be overridden for javascript.
    "[javascript]":  {
        "editor.maxTokenizationLineLength": 2500
    },

    // Configure settings to be overridden for json.
    "[json]":  {
        "editor.quickSuggestions": {
                "strings": true
        },
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for jsonc.
    "[jsonc]":  {
        "editor.quickSuggestions": {
                "strings": true
        },
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for julia.
    "[julia]":  {
        "editor.defaultColorDecorators": "never"
    },

    // Configure settings to be overridden for less.
    "[less]":  {
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for makefile.
    "[makefile]":  {
        "editor.insertSpaces": false
    },

    // Configure settings to be overridden for markdown.
    "[markdown]":  {
        "editor.unicodeHighlight.ambiguousCharacters": false,
        "editor.unicodeHighlight.invisibleCharacters": false,
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.wordWrap": "on",
        "editor.quickSuggestions": {
                "comments": "off",
                "strings": "off",
                "other": "off"
        },
        "cSpell.fixSpellingWithRenameProvider": true,
        "cSpell.advanced.feature.useReferenceProviderWithRename": true,
        "cSpell.advanced.feature.useReferenceProviderRemove": "/^#+\\s/"
    },

    // Configure settings to be overridden for plaintext.
    "[plaintext]":  {
        "editor.unicodeHighlight.ambiguousCharacters": false,
        "editor.unicodeHighlight.invisibleCharacters": false
    },

    // Configure settings to be overridden for powershell.
    "[powershell]":  {
        "debug.saveBeforeStart": "nonUntitledEditorsInActiveGroup",
        "editor.semanticHighlighting.enabled": false,
        "editor.wordSeparators": "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?"
    },

    // Configure settings to be overridden for prompt.
    "[prompt]":  {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "advanced",
        "editor.unicodeHighlight.ambiguousCharacters": false,
        "editor.unicodeHighlight.invisibleCharacters": false,
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.wordWrap": "on",
        "editor.quickSuggestions": {
                "comments": "off",
                "strings": "on",
                "other": "on"
        },
        "editor.wordBasedSuggestions": "off"
    },

    // Configure settings to be overridden for python.
    "[python]":  {
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.defaultColorDecorators": "never",
        "gitlens.codeLens.symbolScopes": [
                "!Module"
        ]
    },

    // Configure settings to be overridden for ruby.
    "[ruby]":  {
        "editor.defaultColorDecorators": "never"
    },

    // Configure settings to be overridden for scminput.
    "[scminput]":  {
        "cSpell.fixSpellingWithRenameProvider": false
    },

    // Configure settings to be overridden for scss.
    "[scss]":  {
        "editor.suggest.insertMode": "replace",
        "cSpell.fixSpellingWithRenameProvider": false
    },

    // Configure settings to be overridden for search-result.
    "[search-result]":  {
        "editor.lineNumbers": "off"
    },

    // Configure settings to be overridden for shellscript.
    "[shellscript]":  {
        "files.eol": "\n",
        "editor.defaultColorDecorators": "never"
    },

    // Configure settings to be overridden for snippets.
    "[snippets]":  {
        "editor.quickSuggestions": {
                "strings": true
        },
        "editor.suggest.insertMode": "replace"
    },

    // Configure settings to be overridden for yaml.
    "[yaml]":  {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "keep",
        "diffEditor.ignoreTrimWhitespace": false,
        "editor.defaultColorDecorators": "never",
        "editor.quickSuggestions": {
                "strings": true,
                "other": true,
                "comments": false
        }
    },

    // Chat
    // When applying edits, show a progress animation in the code block pill. If disabled, shows the progress percentage instead.
    "chat.agent.codeBlockProgress": true,

    // Enable agent mode for chat. When this is enabled, agent mode can be activated via the dropdown in the view.
    "chat.agent.enabled": true,

    // The maximum number of requests to allow per-turn when using an agent. When the limit is reached, will ask to confirm to continue.
    "chat.agent.maxRequests": 25,

    // Controls how tool calls are displayed in relation to thinking sections.
    //  - off: Tool calls are shown separately, not collapsed into thinking.
    //  - withThinking: Tool calls are collapsed into thinking sections when thinking is present.
    //  - always: Tool calls are always collapsed, even without thinking.
    "chat.agent.thinking.collapsedTools": "always",

    // Controls how thinking is rendered.
    //  - collapsed: Thinking parts will be collapsed by default.
    //  - collapsedPreview: Thinking parts will be expanded first, then collapse once we reach a part that is not thinking.
    //  - fixedScrolling: Show thinking in a fixed-height streaming panel that auto-scrolls; click header to expand to full height.
    "chat.agent.thinkingStyle": "fixedScrolling",

    // Controls where to show the agent sessions menu.
    "chat.agentSessionsViewLocation": "single-view",

    // Controls whether anonymous access is allowed in chat.
    "chat.allowAnonymousAccess": false,

    // Enables checkpoints in chat. Checkpoints allow you to restore the chat to a previous state.
    "chat.checkpoints.enabled": true,

    // Controls whether to show chat checkpoint file changes.
    "chat.checkpoints.showFileChanges": false,

    // Controls whether the command center shows a menu for actions to control chat (requires `window.commandCenter`).
    "chat.commandCenter.enabled": true,

    // Whether the runSubagent tool is able to use custom agents. When enabled, the tool can take the name of a custom agent, but it must be given the exact name of the agent.
    "chat.customAgentInSubagent.enabled": false,

    // Enables chat participant autodetection for panel chat.
    "chat.detectParticipant.enabled": true,

    // Disable and hide built-in AI features provided by GitHub Copilot, including chat and inline suggestions.
    "chat.disableAIFeatures": false,

    // Delay after which changes made by chat are automatically accepted. Values are in seconds, `0` means disabled and `100` seconds is the maximum.
    "chat.editing.autoAcceptDelay": 0,

    // Whether to show a confirmation before removing a request and its associated edits.
    "chat.editing.confirmEditRequestRemoval": true,

    // Whether to show a confirmation before retrying a request and its associated edits.
    "chat.editing.confirmEditRequestRetry": true,

    // Controls the font family in chat codeblocks.
    "chat.editor.fontFamily": "default",

    // Controls the font size in pixels in chat codeblocks.
    "chat.editor.fontSize": 14,

    // Controls the font weight in chat codeblocks.
    "chat.editor.fontWeight": "default",

    // Controls the line height in pixels in chat codeblocks. Use 0 to compute the line height from the font size.
    "chat.editor.lineHeight": 0,

    // Controls whether lines should wrap in chat codeblocks.
    "chat.editor.wordWrap": "off",

    // Enables editing of requests in the chat. This allows you to change the request content and resubmit it to the model.
    "chat.editRequests": "inline",

    // Enable the new Edits mode that is based on tool-calling. When this is enabled, models that don't support tool-calling are unavailable for Edits mode.
    "chat.edits2.enabled": false,

    // Show agent sessions on the empty chat state.
    "chat.emptyState.sessions.enabled": true,

    // This setting is deprecated. Please use `chat.detectParticipant.enabled` instead.
    // Enables chat participant autodetection for panel chat.
    "chat.experimental.detectParticipant.enabled": null,

    // Enable using tools contributed by third-party extensions.
    "chat.extensionTools.enabled": true,

    // Enables the unification of GitHub Copilot extensions. When enabled, all GitHub Copilot functionality is served from the GitHub Copilot Chat extension. When disabled, the GitHub Copilot and GitHub Copilot Chat extensions operate independently.
    "chat.extensionUnification.enabled": true,

    // Controls the font family in chat messages.
    "chat.fontFamily": "default",

    // Controls the font size in pixels in chat messages.
    "chat.fontSize": 13,

    // Enables automatically using the active editor as chat context for specified chat locations.
    "chat.implicitContext.enabled": {
        "panel": "always"
    },

    // Controls whether the new implicit context flow is shown. In Ask and Edit modes, the context will automatically be included. When using an agent, context will be suggested as an attachment. Selections are always included as context.
    "chat.implicitContext.suggestedContext": true,

    // Specify location(s) of instructions files (`*.instructions.md`) that can be attached in Chat sessions. [Learn More](https://aka.ms/vscode-ghcp-custom-instructions).
    // 
    // Relative paths are resolved from the root folder(s) of your workspace.
    "chat.instructionsFilesLocations": {
        ".github/instructions": true
    },

    // Enable math rendering in chat responses using KaTeX.
    "chat.math.enabled": true,

    // Controls access to installed Model Context Protocol servers.
    //  - none: No access to MCP servers.
    //  - registry: Allows access to MCP servers installed from the registry that VS Code is connected to.
    //  - all: Allow access to any installed MCP server.
    "chat.mcp.access": "all",

    // Enables NuGet packages for AI-assisted MCP server installation. Used to install MCP servers by name from the central registry for .NET packages (NuGet.org).
    "chat.mcp.assisted.nuget.enabled": false,

    // Controls whether MCP servers should be automatically started when the chat messages are submitted.
    //  - never: Never automatically start MCP servers.
    //  - onlyNew: Only automatically start new MCP servers that have never been run.
    //  - newAndOutdated: Automatically start new and outdated MCP servers that are not yet running.
    "chat.mcp.autostart": "newAndOutdated",

    // Configures discovery of Model Context Protocol servers from configuration from various other applications.
    "chat.mcp.discovery.enabled": {
        "claude-desktop": false,
        "windsurf": false,
        "cursor-global": false,
        "cursor-workspace": false
    },

    // Configure the MCP Gallery service URL to connect to
    "chat.mcp.gallery.serviceUrl": "",

    // Configures which models are exposed to MCP servers for sampling (making model requests in the background). This setting can be edited in a graphical way under the `MCP: List Servers` command.
    "chat.mcp.serverSampling": {},

    // This setting is deprecated and will be removed in future releases. Chat modes are now called custom agents and are located in `.github/agents`
    // Specify location(s) of custom chat mode files (`*.chatmode.md`). [Learn More](https://aka.ms/vscode-ghcp-custom-chat-modes).
    // 
    // Relative paths are resolved from the root folder(s) of your workspace.
    "chat.modeFilesLocations": {
        ".github/chatmodes": true
    },

    // Controls whether a chat session should present the user with an OS notification when a confirmation is needed while the window is not in focus. This includes a window badge as well as notification toast.
    "chat.notifyWindowOnConfirmation": true,

    // Controls whether a chat session should present the user with an OS notification when a response is received while the window is not in focus. This includes a window badge as well as notification toast.
    "chat.notifyWindowOnResponseReceived": true,

    // Specify location(s) of reusable prompt files (`*.prompt.md`) that can be run in Chat sessions. [Learn More](https://aka.ms/vscode-ghcp-prompt-snippets).
    // 
    // Relative paths are resolved from the root folder(s) of your workspace.
    "chat.promptFilesLocations": {
        ".github/prompts": true
    },

    // Configure which prompt files to recommend in the chat welcome view. Each key is a prompt file name, and the value can be `true` to always recommend, `false` to never recommend, or a [when clause](https://aka.ms/vscode-when-clause) expression like `resourceExtname == .js` or `resourceLangId == markdown`.
    "chat.promptFilesRecommendations": {},

    // Controls whether related files should be rendered in the chat input.
    "chat.renderRelatedFiles": false,

    // Controls whether CSS of the selected element will be added to the chat. `chat.sendElementsToChat.enabled` must be enabled.
    "chat.sendElementsToChat.attachCSS": true,

    // Controls whether a screenshot of the selected element will be added to the chat. `chat.sendElementsToChat.enabled` must be enabled.
    "chat.sendElementsToChat.attachImages": true,

    // Controls whether elements can be sent to chat from the Simple Browser.
    "chat.sendElementsToChat.enabled": true,

    // Controls whether session descriptions are displayed on a second row in the Chat Sessions view.
    "chat.showAgentSessionsViewDescription": true,

    // Controls whether sign-in with alternate scopes is used.
    "chat.signInWithAlternateScopes": true,

    // When enabled, todo items include detailed descriptions for implementation context. This provides more information but uses additional tokens and may slow down responses.
    "chat.todoListTool.descriptionField": true,

    // When enabled, the todo tool operates in write-only mode, requiring the agent to remember todos in context.
    "chat.todoListTool.writeOnly": true,

    // Controls whether edits made by chat are automatically approved. The default is to approve all edits except those made to certain files which have the potential to cause immediate unintended side-effects, such as `**/.vscode/*.json`.
    // 
    // Set to `true` to automatically approve edits to matching files, `false` to always require explicit approval. The last pattern matching a given file will determine whether the edit is automatically approved.
    "chat.tools.edits.autoApprove": {
        "**/*": true,
        "**/.vscode/*.json": false,
        "**/.git/**": false,
        "**/{package.json,package-lock.json,server.xml,build.rs,web.config,.gitattributes,.env}": false,
        "**/*.{code-workspace,csproj,fsproj,vbproj,vcxproj,proj,targets,props}": false
    },

    // Controls which tools are eligible for automatic approval. Tools set to 'false' will always present a confirmation and will never offer the option to auto-approve. The default behavior (or setting a tool to 'true') may result in the tool offering auto-approval options.
    "chat.tools.eligibleForAutoApproval": {},

    // Global auto approve also known as "YOLO mode" disables manual approval completely for _all tools in all workspaces_, allowing the agent to act fully autonomously. This is extremely dangerous and is *never* recommended, even containerized environments like [Codespaces](https://github.com/features/codespaces) and [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) have user keys forwarded into the container that could be compromised.
    // 
    // **This feature disables [critical security protections](https://code.visualstudio.com/docs/copilot/security) and makes it much easier for an attacker to compromise the machine.**
    "chat.tools.global.autoApprove": false,

    // Controls whether to show the todo list widget above the chat input. When enabled, the widget displays todo items created by the agent and updates as progress is made.
    "chat.tools.todos.showWidget": true,

    // Controls which URLs are automatically approved when requested by chat tools. Keys are URL patterns and values can be `true` to approve both requests and responses, `false` to deny, or an object with `approveRequest` and `approveResponse` properties for granular control.
    // 
    // Examples:
    // - `"https://example.com": true` - Approve all requests to example.com
    // - `"https://*.example.com": true` - Approve all requests to any subdomain of example.com
    // - `"https://example.com/api/*": { "approveRequest": true, "approveResponse": false }` - Approve requests but not responses for example.com/api paths
    "chat.tools.urls.autoApprove": {},

    // Controls whether the input of the chat should be restored when an undo request is made. The input will be filled with the text of the request that was restored.
    "chat.undoRequests.restoreInput": true,

    // Controls whether instructions from `AGENTS.MD` file found in a workspace roots are attached to all chat requests.
    "chat.useAgentsMdFile": true,

    // Controls whether Claude skills found in the workspace and user home directories under `.claude/skills` are listed in all chat requests. The language model can load these skills on-demand if the `read` tool is available.
    "chat.useClaudeSkills": false,

    // Controls whether instructions from nested `AGENTS.MD` files found in the workspace are listed in all chat requests. The language model can load these skills on-demand if the `read` tool is available.
    "chat.useNestedAgentsMdFiles": false,

    // 
    //  - legacy: Uses the legacy diffing algorithm.
    //  - advanced: Uses the advanced diffing algorithm.
    "mergeEditor.diffAlgorithm": "advanced",

    // Controls if deletions in base or one of the inputs should be indicated by a vertical bar.
    "mergeEditor.showDeletionMarkers": true,

    // Enable experimental multi diff editor.
    "multiDiffEditor.experimental.enabled": true,

    // Remote
    // When enabled, new running processes are detected and ports that they listen on are automatically forwarded. Disabling this setting will not prevent all ports from being forwarded. Even when disabled, extensions will still be able to cause ports to be forwarded, and opening some URLs will still cause ports to forwarded. Also see `remote.autoForwardPortsSource`.
    "remote.autoForwardPorts": true,

    // The number of auto forwarded ports that will trigger the switch from `process` to `hybrid` when automatically forwarding ports and `remote.autoForwardPortsSource` is set to `process` by default. Set to `0` to disable the fallback. When `remote.autoForwardPortsFallback` hasn't been configured, but `remote.autoForwardPortsSource` has, `remote.autoForwardPortsFallback` will be treated as though it's set to `0`.
    "remote.autoForwardPortsFallback": 20,

    // Sets the source from which ports are automatically forwarded when `remote.autoForwardPorts#` is true. When `#remote.autoForwardPorts#` is false, `#remote.autoForwardPortsSource` will be used to find information about ports that have already been forwarded. On Windows and macOS remotes, the `process` and `hybrid` options have no effect and `output` will be used.
    //  - process: Ports will be automatically forwarded when discovered by watching for processes that are started and include a port.
    //  - output: Ports will be automatically forwarded when discovered by reading terminal and debug output. Not all processes that use ports will print to the integrated terminal or debug console, so some ports will be missed. Ports forwarded based on output will not be "un-forwarded" until reload or until the port is closed by the user in the Ports view.
    //  - hybrid: Ports will be automatically forwarded when discovered by reading terminal and debug output. Not all processes that use ports will print to the integrated terminal or debug console, so some ports will be missed. Ports will be "un-forwarded" by watching for processes that listen on that port to be terminated.
    "remote.autoForwardPortsSource": "process",

    // List of extensions to install upon connection to a remote when already installed locally.
    "remote.defaultExtensionsIfInstalledLocally": [
        "GitHub.copilot",
        "GitHub.copilot-chat",
        "GitHub.vscode-pull-request-github"
    ],

    // When enabled extensions are downloaded locally and installed on remote.
    "remote.downloadExtensionsLocally": false,

    // Override the kind of an extension. `ui` extensions are installed and run on the local machine while `workspace` extensions are run on the remote. By overriding an extension's default kind using this setting, you specify if that extension should be installed and enabled locally or remotely.
    "remote.extensionKind": {
        "pub.name": [
            "ui"
        ]
    },

    // Controls whether local URLs with a port will be forwarded when opened from the terminal and the debug console.
    "remote.forwardOnOpen": true,

    // Specifies the local host name that will be used for port forwarding.
    "remote.localPortHost": "localhost",

    // Set default properties that are applied to all ports that don't get properties from the setting `remote.portsAttributes`. For example:
    // 
    // ```
    // {
    //   "onAutoForward": "ignore"
    // }
    // ```
    "remote.otherPortsAttributes": {},

    // Set properties that are applied when a specific port number is forwarded. For example:
    // 
    // ```
    // "3000": {
    //   "label": "Application"
    // },
    // "40000-55000": {
    //   "onAutoForward": "ignore"
    // },
    // ".+\\/server.js": {
    //  "onAutoForward": "openPreview"
    // }
    // ```
    "remote.portsAttributes": {
        "443": {
            "protocol": "https"
        },
        "8443": {
            "protocol": "https"
        }
    },

    // Restores the ports you forwarded in a workspace.
    "remote.restoreForwardedPorts": true,

    // Accessibility
    // On keypress, close the Accessible View and focus the element from which it was invoked.
    "accessibility.accessibleView.closeOnKeyPress": true,

    // Controls whether variable changes should be announced in the debug watch view.
    "accessibility.debugWatchVariableAnnouncements": true,

    // Controls whether files should be opened when the chat agent has applied edits to them.
    "accessibility.openChatEditedFiles": false,

    // Control whether focus should automatically be sent to the REPL when code is executed.
    "accessibility.replEditor.autoFocusReplExecution": "input",

    // Controls whether the output from an execution in the native REPL will be announced.
    "accessibility.replEditor.readLastExecutionOutput": true,

    // Whether or not position changes should be debounced
    "accessibility.signalOptions.debouncePositionChanges": false,

    // 
    "accessibility.signalOptions.experimental.delays.errorAtPosition": {},

    // Delays for all signals besides error and warning at position
    "accessibility.signalOptions.experimental.delays.general": {},

    // 
    "accessibility.signalOptions.experimental.delays.warningAtPosition": {},

    // The volume of the sounds in percent (0-100).
    "accessibility.signalOptions.volume": 70,

    // Plays a sound / audio cue when revealing a file with changes from chat edits
    "accessibility.signals.chatEditModifiedFile": {
        "sound": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a chat request is made.
    "accessibility.signals.chatRequestSent": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a sound / audio cue when the response has been received.
    "accessibility.signals.chatResponseReceived": {
        "sound": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when user action is required in the chat.
    "accessibility.signals.chatUserActionRequired": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a feature is cleared (for example, the terminal, Debug Console, or Output channel).
    "accessibility.signals.clear": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a sound / audio cue when the code action has been applied.
    "accessibility.signals.codeActionApplied": {
        "sound": "auto"
    },

    // Plays a sound / audio cue - when a code action has been triggered.
    "accessibility.signals.codeActionTriggered": {
        "sound": "auto"
    },

    // Plays a sound / audio cue when the focus moves to an deleted line in Accessible Diff Viewer mode or to the next/previous change.
    "accessibility.signals.diffLineDeleted": {
        "sound": "auto"
    },

    // Plays a sound / audio cue when the focus moves to an inserted line in Accessible Diff Viewer mode or to the next/previous change.
    "accessibility.signals.diffLineInserted": {
        "sound": "auto"
    },

    // Plays a sound / audio cue when the focus moves to an modified line in Accessible Diff Viewer mode or to the next/previous change.
    "accessibility.signals.diffLineModified": {
        "sound": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when edits are kept.
    "accessibility.signals.editsKept": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when edits have been undone.
    "accessibility.signals.editsUndone": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a file or notebook is formatted.
    "accessibility.signals.format": {
        "sound": "never",
        "announcement": "never"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the active line has a breakpoint.
    "accessibility.signals.lineHasBreakpoint": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the active line has an error.
    "accessibility.signals.lineHasError": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - the active line has a folded area that can be unfolded.
    "accessibility.signals.lineHasFoldedArea": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a sound / audio cue when the active line has an inline suggestion.
    "accessibility.signals.lineHasInlineSuggestion": {
        "sound": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the active line has a warning.
    "accessibility.signals.lineHasWarning": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound / audio cue and/or announcement (alert) when there is a next edit suggestion.
    "accessibility.signals.nextEditSuggestion": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when trying to read a line with inlay hints that has no inlay hints.
    "accessibility.signals.noInlayHints": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a notebook cell execution is successfully completed.
    "accessibility.signals.notebookCellCompleted": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a notebook cell execution fails.
    "accessibility.signals.notebookCellFailed": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the debugger stopped on a breakpoint.
    "accessibility.signals.onDebugBreak": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the active line has a warning.
    "accessibility.signals.positionHasError": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the active line has a warning.
    "accessibility.signals.positionHasWarning": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - on loop while progress is occurring.
    "accessibility.signals.progress": {
        "sound": "auto",
        "announcement": "off"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a file is saved.
    "accessibility.signals.save": {
        "sound": "never",
        "announcement": "never"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a task is completed.
    "accessibility.signals.taskCompleted": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a task fails (non-zero exit code).
    "accessibility.signals.taskFailed": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when the terminal bell is ringing.
    "accessibility.signals.terminalBell": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a terminal command fails (non-zero exit code) or when a command with such an exit code is navigated to in the accessible view.
    "accessibility.signals.terminalCommandFailed": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when a terminal command succeeds (zero exit code) or when a command with such an exit code is navigated to in the accessible view.
    "accessibility.signals.terminalCommandSucceeded": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a signal - sound (audio cue) and/or announcement (alert) - when terminal Quick Fixes are available.
    "accessibility.signals.terminalQuickFix": {
        "sound": "auto",
        "announcement": "auto"
    },

    // Plays a sound / audio cue when the voice recording has started.
    "accessibility.signals.voiceRecordingStarted": {
        "sound": "on"
    },

    // Plays a sound / audio cue when the voice recording has stopped.
    "accessibility.signals.voiceRecordingStopped": {
        "sound": "auto"
    },

    // Controls whether links should be underlined in the workbench.
    "accessibility.underlineLinks": false,

    // Controls whether verbose progress announcements should be made when a chat request is in progress, including information like searched text for <search term> with X results, created file <file_name>, or read file <file path>.
    "accessibility.verboseChatProgressUpdates": true,

    // Provide information about actions that can be taken in the comment widget or in a file which contains comments.
    "accessibility.verbosity.comments": true,

    // Provide information about how to access the debug console accessibility help dialog when the debug console or run and debug viewlet is focused. Note that a reload of the window is required for this to take effect.
    "accessibility.verbosity.debug": true,

    // Provide information about how to navigate changes in the diff editor when it is focused.
    "accessibility.verbosity.diffEditor": true,

    // Indicate when a diff editor becomes the active editor.
    "accessibility.verbosity.diffEditorActive": true,

    // Provide information about relevant actions in an empty text editor.
    "accessibility.verbosity.emptyEditorHint": true,

    // Provide information about how to open the hover in an Accessible View.
    "accessibility.verbosity.hover": true,

    // Provide information about how to access the inline editor chat accessibility help menu and alert with hints that describe how to use the feature when the input is focused.
    "accessibility.verbosity.inlineChat": true,

    // Provide information about how to access the inline completions hover and Accessible View.
    "accessibility.verbosity.inlineCompletions": true,

    // Provide information about how to change a keybinding in the keybindings editor when a row is focused.
    "accessibility.verbosity.keybindingsEditor": true,

    // Provide information about how to focus the cell container or inner editor when a notebook cell is focused.
    "accessibility.verbosity.notebook": true,

    // Provide information about how to open the notification in an Accessible View.
    "accessibility.verbosity.notification": true,

    // Provide information about how to access the chat help menu when the chat input is focused.
    "accessibility.verbosity.panelChat": true,

    // Provide information about how to access the REPL editor accessibility help menu when the REPL editor is focused.
    "accessibility.verbosity.replEditor": true,

    // Provide information about how to access the source control accessibility help menu when the input is focused.
    "accessibility.verbosity.sourceControl": true,

    // Provide information about how to access the terminal accessibility help menu when the terminal is focused.
    "accessibility.verbosity.terminal": true,

    // Provide information about how to open the chat terminal output in the Accessible View.
    "accessibility.verbosity.terminalChatOutput": true,

    // Provide information about how to open the walkthrough in an Accessible View.
    "accessibility.verbosity.walkthrough": true,

    // Controls whether the `window.title` should be optimized for screen readers when in screen reader mode. When enabled, the window title will have `activeEditorState` appended to the end.
    "accessibility.windowTitleOptimized": true,

    // Set the color mode for native UI elements such as native dialogs, menus and title bar. Even if your OS is configured in light color mode, you can select a dark system color theme for the window. You can also configure to automatically adjust based on the `workbench.colorTheme` setting.
    // 
    // Note: This setting is ignored when `window.autoDetectColorScheme` is enabled.
    //  - default: Native widget colors match the system colors.
    //  - auto: Use light native widget colors for light color themes and dark for dark color themes.
    //  - light: Use light native widget colors.
    //  - dark: Use dark native widget colors.
    "window.systemColorTheme": "default",

    // The name under which the remote tunnel access is registered. If not set, the host name is used.
    "remote.tunnels.access.hostNameOverride": "",

    // Prevent this computer from sleeping when remote tunnel access is turned on.
    "remote.tunnels.access.preventSleep": false,

    // Emmet
    // An array of languages where Emmet abbreviations should not be expanded.
    "emmet.excludeLanguages": [
        "markdown"
    ],

    // An array of paths, where each path can contain Emmet syntaxProfiles and/or snippet files.
    // In case of conflicts, the profiles/snippets of later paths will override those of earlier paths.
    // See https://code.visualstudio.com/docs/editor/emmet for more information and an example snippet file.
    "emmet.extensionsPath": [],

    // Enable Emmet abbreviations in languages that are not supported by default. Add a mapping here between the language and Emmet supported language.
    //  For example: `{"vue-html": "html", "javascript": "javascriptreact"}`
    "emmet.includeLanguages": {},

    // When set to `false`, the whole file is parsed to determine if current position is valid for expanding Emmet abbreviations. When set to `true`, only the content around the current position in CSS/SCSS/Less files is parsed.
    "emmet.optimizeStylesheetParsing": true,

    // Preferences used to modify behavior of some actions and resolvers of Emmet.
    "emmet.preferences": {},

    // Shows possible Emmet abbreviations as suggestions. Not applicable in stylesheets or when emmet.showExpandedAbbreviation is set to `"never"`.
    "emmet.showAbbreviationSuggestions": true,

    // Shows expanded Emmet abbreviations as suggestions.
    // The option `"inMarkupAndStylesheetFilesOnly"` applies to html, haml, jade, slim, xml, xsl, css, scss, sass, less and stylus.
    // The option `"always"` applies to all parts of the file regardless of markup/css.
    "emmet.showExpandedAbbreviation": "always",

    // If `true`, then Emmet suggestions will show up as snippets allowing you to order them as per `editor.snippetSuggestions` setting.
    "emmet.showSuggestionsAsSnippets": false,

    // Define profile for specified syntax or use your own profile with specific rules.
    "emmet.syntaxProfiles": {},

    // When enabled, Emmet abbreviations are expanded when pressing TAB, even when completions do not show up. When disabled, completions that show up can still be accepted by pressing TAB.
    "emmet.triggerExpansionOnTab": false,

    // If `true`, Emmet will use inline completions to suggest expansions. To prevent the non-inline completion item provider from showing up as often while this setting is `true`, turn `editor.quickSuggestions` to `inline` or `off` for the `other` item.
    "emmet.useInlineCompletions": false,

    // Variables to be used in Emmet snippets.
    "emmet.variables": {},

    // Git
    // Controls whether force push (with or without lease) is enabled.
    "git.allowForcePush": false,

    // Controls whether commits without running pre-commit and commit-msg hooks are allowed.
    "git.allowNoVerifyCommit": false,

    // Always show the Staged Changes resource group.
    "git.alwaysShowStagedChangesResourceGroup": false,

    // Controls the signoff flag for all commits.
    "git.alwaysSignOff": false,

    // When set to true, commits will automatically be fetched from the default remote of the current Git repository. Setting to `all` will fetch from all remotes.
    "git.autofetch": false,

    // Duration in seconds between each automatic git fetch, when `git.autofetch` is enabled.
    "git.autofetchPeriod": 180,

    // Whether auto refreshing is enabled.
    "git.autorefresh": true,

    // Configures when repositories should be automatically detected.
    //  - true: Scan for both subfolders of the current opened folder and parent folders of open files.
    //  - false: Disable automatic repository scanning.
    //  - subFolders: Scan for subfolders of the currently opened folder.
    //  - openEditors: Scan for parent folders of open files.
    "git.autoRepositoryDetection": true,

    // Stash any changes before pulling and restore them after successful pull.
    "git.autoStash": false,

    // Controls whether to show blame information in the editor using editor decorations.
    "git.blame.editorDecoration.enabled": false,

    // Template for the blame information editor decoration. Supported variables:
    // 
    // * `hash`: Commit hash
    // 
    // * `hashShort`: First N characters of the commit hash according to `git.commitShortHashLength`
    // 
    // * `subject`: First line of the commit message
    // 
    // * `authorName`: Author name
    // 
    // * `authorEmail`: Author email
    // 
    // * `authorDate`: Author date
    // 
    // * `authorDateAgo`: Time difference between now and the author date
    // 
    // 
    "git.blame.editorDecoration.template": "${subject}, ${authorName} (${authorDateAgo})",

    // Controls whether to show blame information in the status bar.
    "git.blame.statusBarItem.enabled": true,

    // Template for the blame information status bar item. Supported variables:
    // 
    // * `hash`: Commit hash
    // 
    // * `hashShort`: First N characters of the commit hash according to `git.commitShortHashLength`
    // 
    // * `subject`: First line of the commit message
    // 
    // * `authorName`: Author name
    // 
    // * `authorEmail`: Author email
    // 
    // * `authorDate`: Author date
    // 
    // * `authorDateAgo`: Time difference between now and the author date
    // 
    // 
    "git.blame.statusBarItem.template": "${authorName} (${authorDateAgo})",

    // Prefix used when creating a new branch.
    "git.branchPrefix": "",

    // List of protected branches. By default, a prompt is shown before changes are committed to a protected branch. The prompt can be controlled using the `git.branchProtectionPrompt`  setting.
    "git.branchProtection": [],

    // Controls whether a prompt is being shown before changes are committed to a protected branch.
    //  - alwaysCommit: Always commit changes to the protected branch.
    //  - alwaysCommitToNewBranch: Always commit changes to a new branch.
    //  - alwaysPrompt: Always prompt before changes are committed to a protected branch.
    "git.branchProtectionPrompt": "alwaysPrompt",

    // List of dictionaries used for the randomly generated branch name. Each value represents the dictionary used to generate the segment of the branch name. Supported dictionaries: `adjectives`, `animals`, `colors` and `numbers`.
    //  - adjectives: A random adjective
    //  - animals: A random animal name
    //  - colors: A random color name
    //  - numbers: A random number between 100 and 999
    "git.branchRandomName.dictionary": [
        "adjectives",
        "animals"
    ],

    // Controls whether a random name is generated when creating a new branch.
    "git.branchRandomName.enable": false,

    // Controls the sort order for branches.
    "git.branchSortOrder": "committerdate",

    // A regular expression to validate new branch names.
    "git.branchValidationRegex": "",

    // The character to replace whitespace in new branch names, and to separate segments of a randomly generated branch name.
    "git.branchWhitespaceChar": "-",

    // Controls what type of Git refs are listed when running `Checkout to...`.
    //  - local: Local branches
    //  - tags: Tags
    //  - remote: Remote branches
    "git.checkoutType": [
        "local",
        "remote",
        "tags"
    ],

    // Controls whether the diff editor should be automatically closed when changes are stashed, committed, discarded, staged, or unstaged.
    "git.closeDiffOnOperation": false,

    // List of git commands (ex: commit, push) that would have their `stdout` logged to the [git output](command:git.showOutput). If the git command has a client-side hook configured, the client-side hook's `stdout` will also be logged to the [git output](command:git.showOutput).
    "git.commandsToLog": [],

    // Controls the length of the commit short hash.
    "git.commitShortHashLength": 7,

    // Always confirm the creation of empty commits for the 'Git: Commit Empty' command.
    "git.confirmEmptyCommits": true,

    // Controls whether to ask for confirmation before force-pushing.
    "git.confirmForcePush": true,

    // Controls whether to ask for confirmation before committing without verification.
    "git.confirmNoVerifyCommit": true,

    // Confirm before synchronizing Git repositories.
    "git.confirmSync": true,

    // Controls the Git count badge.
    //  - all: Count all changes.
    //  - tracked: Count only tracked changes.
    //  - off: Turn off counter.
    "git.countBadge": "all",

    // Controls whether Git contributes colors and badges to the Explorer and the Open Editors view.
    "git.decorations.enabled": true,

    // The name of the default branch (example: main, trunk, development) when initializing a new Git repository. When set to empty, the default branch name configured in Git will be used. **Note:** Requires Git version `2.28.0` or later.
    "git.defaultBranchName": "main",

    // The default location to clone a Git repository.
    "git.defaultCloneDirectory": null,

    // Controls whether to automatically detect Git submodules.
    "git.detectSubmodules": true,

    // Controls the limit of Git submodules detected.
    "git.detectSubmodulesLimit": 10,

    // Controls whether to automatically detect Git worktrees.
    "git.detectWorktrees": true,

    // Controls the limit of Git worktrees detected.
    "git.detectWorktreesLimit": 10,

    // Controls whether to check for unresolved diagnostics before committing.
    "git.diagnosticsCommitHook.enabled": false,

    // Controls the list of sources (**Item**) and the minimum severity (**Value**) to be considered before committing. **Note:** To ignore diagnostics from a particular source, add the source to the list and set the minimum severity to `none`.
    "git.diagnosticsCommitHook.sources": {
        "*": "error"
    },

    // Controls whether discarding untracked changes moves the file(s) to the Recycle Bin (Windows), Trash (macOS, Linux) instead of deleting them permanently. **Note:** This setting has no effect when connected to a remote or when running in Linux as a snap package.
    "git.discardUntrackedChangesToTrash": true,

    // Enables commit signing with GPG, X.509, or SSH.
    "git.enableCommitSigning": false,

    // Whether Git is enabled.
    "git.enabled": true,

    // Commit all changes when there are no staged changes.
    "git.enableSmartCommit": false,

    // Controls whether the Git Sync command appears in the status bar.
    "git.enableStatusBarSync": true,

    // When enabled, fetch all branches when pulling. Otherwise, fetch just the current one.
    "git.fetchOnPull": false,

    // Push all annotated tags when running the sync command.
    "git.followTagsWhenSync": false,

    // This setting is now deprecated, please use `github.gitAuthentication` instead.
    // 
    "git.githubAuthentication": null,

    // List of Git repositories to ignore.
    "git.ignoredRepositories": [],

    // Ignores the legacy Git warning.
    "git.ignoreLegacyWarning": false,

    // Ignores the warning when there are too many changes in a repository.
    "git.ignoreLimitWarning": false,

    // Ignores the warning when Git is missing.
    "git.ignoreMissingGitWarning": false,

    // Ignores the warning when it looks like the branch might have been rebased when pulling.
    "git.ignoreRebaseWarning": false,

    // Ignore modifications to submodules in the file tree.
    "git.ignoreSubmodules": false,

    // Ignores the warning when Git 2.25 - 2.26 is installed on Windows.
    "git.ignoreWindowsGit27Warning": false,

    // Controls whether to show commit message input validation diagnostics.
    "git.inputValidation": false,

    // Controls the commit message length threshold for showing a warning.
    "git.inputValidationLength": 72,

    // Controls the commit message subject length threshold for showing a warning. Unset it to inherit the value of `git.inputValidationLength`.
    "git.inputValidationSubjectLength": 50,

    // Open the merge editor for files that are currently under conflict.
    "git.mergeEditor": false,

    // Controls whether to open a repository automatically after cloning.
    //  - always: Always open in current window.
    //  - alwaysNewWindow: Always open in a new window.
    //  - whenNoFolderOpen: Only open in current window when no folder is opened.
    //  - prompt: Always prompt for action.
    "git.openAfterClone": "prompt",

    // Controls whether the diff editor should be opened when clicking a change. Otherwise the regular editor will be opened.
    "git.openDiffOnClick": true,

    // Control whether a repository in parent folders of workspaces or open files should be opened.
    //  - always: Always open a repository in parent folders of workspaces or open files.
    //  - never: Never open a repository in parent folders of workspaces or open files.
    //  - prompt: Prompt before opening a repository the parent folders of workspaces or open files.
    "git.openRepositoryInParentFolders": "prompt",

    // Controls whether to optimistically update the state of the Source Control view after running git commands.
    "git.optimisticUpdate": true,

    // Path and filename of the git executable, e.g. `C:\Program Files\Git\bin\git.exe` (Windows). This can also be an array of string values containing multiple paths to look up.
    "git.path": null,

    // Run a git command after a successful commit.
    //  - none: Don't run any command after a commit.
    //  - push: Run 'git push' after a successful commit.
    //  - sync: Run 'git pull' and 'git push' after a successful commit.
    "git.postCommitCommand": "none",

    // Controls whether Git should check for unsaved files before committing.
    //  - always: Check for any unsaved files.
    //  - staged: Check only for unsaved staged files.
    //  - never: Disable this check.
    "git.promptToSaveFilesBeforeCommit": "always",

    // Controls whether Git should check for unsaved files before stashing changes.
    //  - always: Check for any unsaved files.
    //  - staged: Check only for unsaved staged files.
    //  - never: Disable this check.
    "git.promptToSaveFilesBeforeStash": "always",

    // Prune when fetching.
    "git.pruneOnFetch": false,

    // Controls whether a branch that does not have outgoing commits is fast-forwarded before it is checked out.
    "git.pullBeforeCheckout": false,

    // Fetch all tags when pulling.
    "git.pullTags": true,

    // Force Git to use rebase when running the sync command.
    "git.rebaseWhenSync": false,

    // Remember the last git command that ran after a commit.
    "git.rememberPostCommitCommand": false,

    // Automatically replace the local tags with the remote tags in case of a conflict when running the pull command.
    "git.replaceTagsWhenPull": false,

    // List of folders that are ignored while scanning for Git repositories when `git.autoRepositoryDetection` is set to `true` or `subFolders`.
    "git.repositoryScanIgnoredFolders": [
        "node_modules"
    ],

    // Controls the depth used when scanning workspace folders for Git repositories when `git.autoRepositoryDetection` is set to `true` or `subFolders`. Can be set to `-1` for no limit.
    "git.repositoryScanMaxDepth": 1,

    // Controls whether to require explicit Git user configuration or allow Git to guess if missing.
    "git.requireGitUserConfig": true,

    // List of paths to search for Git repositories in.
    "git.scanRepositories": [],

    // Controls whether an action button is shown in the Source Control view.
    "git.showActionButton": {
        "commit": true,
        "publish": true,
        "sync": true
    },

    // Controls whether to show the commit input in the Git source control panel.
    "git.showCommitInput": true,

    // Controls whether to show an inline Open File action in the Git changes view.
    "git.showInlineOpenFileAction": true,

    // Controls whether Git actions should show progress.
    "git.showProgress": true,

    // Controls whether to show a notification when a push is successful.
    "git.showPushSuccessNotification": false,

    // Controls whether to show the details of the last commit for Git refs in the checkout, branch, and tag pickers.
    "git.showReferenceDetails": true,

    // Controls the threshold of the similarity index (the amount of additions/deletions compared to the file's size) for changes in a pair of added/deleted files to be considered a rename. **Note:** Requires Git version `2.18.0` or later.
    "git.similarityThreshold": 50,

    // Control which changes are automatically staged by Smart Commit.
    //  - all: Automatically stage all changes.
    //  - tracked: Automatically stage tracked changes only.
    "git.smartCommitChanges": "all",

    // Controls how to limit the number of changes that can be parsed from Git status command. Can be set to 0 for no limit.
    "git.statusLimit": 10000,

    // Suggests to enable smart commit (commit all changes when there are no staged changes).
    "git.suggestSmartCommit": true,

    // Controls whether a notification comes up when running the Sync action, which allows the user to cancel the operation.
    "git.supportCancellation": false,

    // Controls whether to enable VS Code to be the authentication handler for Git processes spawned in the Integrated Terminal. Note: Terminals need to be restarted to pick up a change in this setting.
    "git.terminalAuthentication": true,

    // Controls whether to enable VS Code to be the Git editor for Git processes spawned in the integrated terminal. Note: Terminals need to be restarted to pick up a change in this setting.
    "git.terminalGitEditor": false,

    // Controls which date to use for items in the Timeline view.
    //  - committed: Use the committed date
    //  - authored: Use the authored date
    "git.timeline.date": "committed",

    // Controls whether to show the commit author in the Timeline view.
    "git.timeline.showAuthor": true,

    // Controls whether to show uncommitted changes in the Timeline view.
    "git.timeline.showUncommitted": false,

    // Controls how untracked changes behave.
    //  - mixed: All changes, tracked and untracked, appear together and behave equally.
    //  - separate: Untracked changes appear separately in the Source Control view. They are also excluded from several actions.
    //  - hidden: Untracked changes are hidden and excluded from several actions.
    "git.untrackedChanges": "mixed",

    // Controls whether to use the message from the commit input box as the default stash message.
    "git.useCommitInputAsStashMessage": false,

    // Controls whether a full text editor will be used to author commit messages, whenever no message is provided in the commit input box.
    "git.useEditorAsCommitInput": true,

    // Controls whether force pushing uses the safer force-if-includes variant. Note: This setting requires the `git.useForcePushWithLease` setting to be enabled, and Git version `2.30.0` or later.
    "git.useForcePushIfIncludes": true,

    // Controls whether force pushing uses the safer force-with-lease variant.
    "git.useForcePushWithLease": true,

    // Controls whether GIT_ASKPASS should be overwritten to use the integrated version.
    "git.useIntegratedAskPass": true,

    // Enable verbose output when `git.useEditorAsCommitInput` is enabled.
    "git.verboseCommit": false,

    // GitHub
    // Controls whether to query repository rules for GitHub repositories
    "github.branchProtection": true,

    // Controls whether to enable automatic GitHub authentication for git commands within VS Code.
    "github.gitAuthentication": true,

    // Controls which protocol is used to clone a GitHub repository
    "github.gitProtocol": "https",

    // Controls whether to show the GitHub avatar of the commit author in various hovers (ex: Git blame, Timeline, Source Control Graph, etc.)
    "github.showAvatar": true,

    // GHE.com & GitHub Enterprise Server Authentication
    // When true, prioritize the device code flow for authentication instead of other available flows. This is useful for environments like WSL where the local server or URL handler flows may not work as expected.
    "github-authentication.preferDeviceCodeFlow": false,

    // When true, uses Electron's built-in fetch function for HTTP requests. When false, uses the Node.js global fetch function. This setting only applies when running in the Electron environment. **Note:** A restart is required for this setting to take effect.
    "github-authentication.useElectronFetch": true,

    // The URI for your GHE.com or GitHub Enterprise Server instance.
    // 
    // Examples:
    // * GHE.com: `https://octocat.ghe.com`
    // * GitHub Enterprise Server: `https://github.octocat.com`
    // 
    // > **Note:** This should _not_ be set to a GitHub.com URI. If your account exists on GitHub.com or is a GitHub Enterprise Managed User, you do not need any additional configuration and can simply log in to GitHub.
    "github-enterprise.uri": "",

    // Grunt
    // Controls enablement of Grunt task detection. Grunt task detection can cause files in any open workspace to be executed.
    "grunt.autoDetect": "off",

    // Gulp
    // Controls enablement of Gulp task detection. Gulp task detection can cause files in any open workspace to be executed.
    "gulp.autoDetect": "off",

    // .ipynb Support
    // Experimental feature to serialize the Jupyter notebook in a worker thread.
    "ipynb.experimental.serialization": true,

    // Enable/disable pasting of images into Markdown cells in ipynb notebook files. Pasted images are inserted as attachments to the cell.
    "ipynb.pasteImagesAsAttachments.enabled": true,

    // Jake
    // Controls enablement of Jake task detection. Jake task detection can cause files in any open workspace to be executed.
    "jake.autoDetect": "off",

    // Markdown Math
    // Enable/disable rendering math in the built-in Markdown preview.
    "markdown.math.enabled": true,

    // A collection of custom macros. Each macro is a key-value pair where the key is a new command name and the value is the expansion of the macro.
    "markdown.math.macros": {},

    // Media Previewer
    // Start playing videos on mute automatically.
    "mediaPreview.video.autoPlay": false,

    // Loop videos over again automatically.
    "mediaPreview.video.loop": false,

    // Merge Conflict
    // Whether to automatically navigate to the next merge conflict after resolving a merge conflict.
    "merge-conflict.autoNavigateNextConflict.enabled": false,

    // Create a CodeLens for merge conflict blocks within editor.
    "merge-conflict.codeLens.enabled": true,

    // Create decorators for merge conflict blocks within editor.
    "merge-conflict.decorators.enabled": true,

    // Controls where the diff view should be opened when comparing changes in merge conflicts.
    //  - Current: Open the diff view in the current editor group.
    //  - Beside: Open the diff view next to the current editor group.
    //  - Below: Open the diff view below the current editor group.
    "merge-conflict.diffViewPosition": "Current",

    // Mermaid Chat Features
    // Enable a tool for experimental Mermaid diagram rendering in chat responses.
    "mermaid-chat.enabled": false,

    // Microsoft Sovereign Cloud
    // The authentication implementation to use for signing in with a Microsoft account.
    //  - msal: Use the Microsoft Authentication Library (MSAL) to sign in with a Microsoft account.
    //  - msal-no-broker: Use the Microsoft Authentication Library (MSAL) to sign in with a Microsoft account using a browser. This is useful if you are having issues with the native broker.
    "microsoft-authentication.implementation": "msal",

    // The custom configuration for the Sovereign Cloud to use with the Microsoft Sovereign Cloud authentication provider. This along with setting `microsoft-sovereign-cloud.environment` to `custom` is required to use this feature.
    "microsoft-sovereign-cloud.customEnvironment": {},

    // The Sovereign Cloud to use for authentication. If you select `custom`, you must also set the `microsoft-sovereign-cloud.customEnvironment` setting.
    //  - ChinaCloud: Azure China
    //  - USGovernment: Azure US Government
    //  - custom: A custom Microsoft Sovereign Cloud
    "microsoft-sovereign-cloud.environment": "",

    // JavaScript Debugger
    // Configures which processes to automatically attach and debug when `debug.node.autoAttach` is on. A Node process launched with the `--inspect` flag will always be attached to, regardless of this setting.
    //  - always: Auto attach to every Node.js process launched in the terminal.
    //  - smart: Auto attach when running scripts that aren't in a node_modules folder.
    //  - onlyWithFlag: Only auto attach when the `--inspect` is given.
    //  - disabled: Auto attach is disabled and not shown in status bar.
    "debug.javascript.autoAttachFilter": "disabled",

    // Configures glob patterns for determining when to attach in "smart" `debug.javascript.autoAttachFilter` mode. `$KNOWN_TOOLS$` is replaced with a list of names of common test and code runners. [Read more on the VS Code docs](https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_auto-attach-smart-patterns).
    "debug.javascript.autoAttachSmartPattern": [
        "${workspaceFolder}/**",
        "!**/node_modules/**",
        "**/$KNOWN_TOOLS$/**"
    ],

    // When debugging a remote web app, configures whether to automatically tunnel the remote server to your local machine.
    "debug.javascript.automaticallyTunnelRemoteServer": true,

    // Whether to stop when conditional breakpoints throw an error.
    "debug.javascript.breakOnConditionalError": false,

    // Where a "Run" and "Debug" code lens should be shown in your npm scripts. It may be on "all", scripts, on "top" of the script section, or "never".
    "debug.javascript.codelens.npmScripts": "top",

    // Options used when debugging open links clicked from inside the JavaScript Debug Terminal. Can be set to "off" to disable this behavior, or "always" to enable debugging in all terminals.
    "debug.javascript.debugByLinkOptions": "on",

    // The default `runtimeExecutable` used for launch configurations, if unspecified. This can be used to config custom paths to Node.js or browser installations.
    "debug.javascript.defaultRuntimeExecutable": {
        "pwa-node": "node"
    },

    // Enables the experimental network view for targets that support it.
    "debug.javascript.enableNetworkView": true,

    // Default options used when debugging a process through the `Debug: Attach to Node.js Process` command
    "debug.javascript.pickAndAttachOptions": {},

    // Request options to use when loading resources, such as source maps, in the debugger. You may need to configure this if your sourcemaps require authentication or use a self-signed certificate, for instance. Options are used to create a request using the [`got`](https://github.com/sindresorhus/got) library.
    // 
    // A common case to disable certificate verification can be done by passing `{ "https": { "rejectUnauthorized": false } }`.
    "debug.javascript.resourceRequestOptions": {},

    // Default launch options for the JavaScript debug terminal and npm scripts.
    "debug.javascript.terminalOptions": {},

    // Configures whether sourcemapped file where the original file can't be read will automatically be unmapped. If this is false (default), a prompt is shown.
    "debug.javascript.unmapMissingSources": false,

    // Npm
    // Controls whether npm scripts should be automatically detected.
    "npm.autoDetect": "on",

    // Enable running npm scripts contained in a folder from the Explorer context menu.
    "npm.enableRunFromFolder": false,

    // The NPM Script Explorer is now available in 'Views' menu in the Explorer in all folders.
    // Enable an explorer view for npm scripts when there is no top-level 'package.json' file.
    "npm.enableScriptExplorer": false,

    // Configure glob patterns for folders that should be excluded from automatic script detection.
    "npm.exclude": "",

    // Fetch data from https://registry.npmjs.org and https://registry.bower.io to provide auto-completion and information on hover features on npm dependencies.
    "npm.fetchOnlinePackageInfo": true,

    // The package manager used to install dependencies.
    //  - auto: Auto-detect which package manager to use based on lock files and installed package managers.
    //  - npm: Use npm as the package manager.
    //  - yarn: Use yarn as the package manager.
    //  - pnpm: Use pnpm as the package manager.
    //  - bun: Use bun as the package manager.
    "npm.packageManager": "auto",

    // Run npm commands with the `--silent` option.
    "npm.runSilent": false,

    // The default click action used in the NPM Scripts Explorer: `open` or `run`, the default is `open`.
    "npm.scriptExplorerAction": "open",

    // An array of regular expressions that indicate which scripts should be excluded from the NPM Scripts view.
    "npm.scriptExplorerExclude": [],

    // Display hover with 'Run' and 'Debug' commands for scripts.
    "npm.scriptHover": true,

    // The script runner used to run scripts.
    //  - auto: Auto-detect which script runner to use based on lock files and installed package managers.
    //  - npm: Use npm as the script runner.
    //  - yarn: Use yarn as the script runner.
    //  - pnpm: Use pnpm as the script runner.
    //  - bun: Use bun as the script runner.
    //  - node: Use Node.js as the script runner.
    "npm.scriptRunner": "auto",

    // Reference Search View
    // Controls whether 'Peek References' or 'Find References' is invoked when selecting CodeLens references.
    //  - peek: Show references in peek editor.
    //  - view: Show references in separate view.
    "references.preferredLocation": "peek",

    // Simple Browser
    // Enable/disable the floating indicator that shows when focused in the simple browser.
    "simpleBrowser.focusLockIndicator.enabled": true,

    // Better Comments configuration
    // Whether the plaintext comment highlighter should be active
    "better-comments.highlightPlainText": false,

    // Whether the multiline comment highlighter should be active
    "better-comments.multilineComments": true,

    // Tags which are used to color the comments. Changes require a restart of VS Code to take effect
    "better-comments.tags": [
        {
            "tag": "!",
            "color": "#FF2D00",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        },
        {
            "tag": "?",
            "color": "#3498DB",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        },
        {
            "tag": "//",
            "color": "#474747",
            "strikethrough": true,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        },
        {
            "tag": "todo",
            "color": "#FF8C00",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        },
        {
            "tag": "*",
            "color": "#98C379",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        }
    ],

    // Markdown Preview Mermaid Support
    // Default Mermaid theme for dark mode.
    "markdown-mermaid.darkModeTheme": "dark",

    // Default languages in markdown.
    "markdown-mermaid.languages": [
        "mermaid"
    ],

    // Default Mermaid theme for light mode.
    "markdown-mermaid.lightModeTheme": "default",

    // The maximum allowed size of the users text diagram.
    "markdown-mermaid.maxTextSize": 50000,

    // markdownlint
    // markdownlint configuration object
    "markdownlint.config": {},

    // Path to a configuration file that defines the base configuration
    "markdownlint.configFile": null,

    // Array of paths for custom rules to include when linting
    "markdownlint.customRules": [],

    // Makes it easier to focus while typing by hiding issues on or near the current line
    "markdownlint.focusMode": false,

    // Array of glob expressions to include or ignore when linting the workspace
    "markdownlint.lintWorkspaceGlobs": [
        "**/*.{md,mkd,mdwn,mdown,markdown,markdn,mdtxt,mdtext,workbook}",
        "!**/*.code-search",
        "!**/bower_components",
        "!**/node_modules",
        "!**/.git",
        "!**/vendor"
    ],

    // Run the linter on save (onSave) or on type (onType)
    "markdownlint.run": "onType",

    // ESLint
    // The setting is deprecated. Use editor.codeActionsOnSave instead with a source.fixAll.eslint member.
    // Turns auto fix on save on or off.
    "eslint.autoFixOnSave": false,

    // Show disable lint rule in the quick fix menu.
    "eslint.codeAction.disableRuleComment": {
        "enable": true,
        "location": "separateLine",
        "commentStyle": "line"
    },

    // Show open lint rule documentation web page in the quick fix menu.
    "eslint.codeAction.showDocumentation": {
        "enable": true
    },

    // Specifies the code action mode. Possible values are 'all' and 'problems'.
    //  - all: Fixes all possible problems in the file. This option might take some time.
    //  - problems: Fixes only reported problems that have non-overlapping textual edits. This option runs a lot faster.
    "eslint.codeActionsOnSave.mode": "all",

    // The ESLint options object to use on save (see https://eslint.org/docs/developer-guide/nodejs-api#eslint-class). `eslint.codeActionsOnSave.rules`, if specified, will take priority over any rule options here.
    "eslint.codeActionsOnSave.options": {},

    // The rules that should be executed when computing the code actions on save or formatting a file. Defaults to the rules configured via the ESLint configuration
    "eslint.codeActionsOnSave.rules": null,

    // Enables ESLint debug mode (same as `--debug` on the command line)
    "eslint.debug": false,

    // Controls whether eslint is enabled or not.
    "eslint.enable": true,

    // Additional exec argv argument passed to the runtime. This can for example be used to control the maximum heap space using --max_old_space_size
    "eslint.execArgv": null,

    // Use ESLint version 8.57 or later and `eslint.useFlatConfig` instead.
    // Enables support of experimental Flat Config (aka eslint.config.js). Requires ESLint version >= 8.21 < 8.57.0).
    "eslint.experimental.useFlatConfig": false,

    // Enables ESLint as a formatter.
    "eslint.format.enable": false,

    // If true, untitled files won't be validated by ESLint.
    "eslint.ignoreUntitled": false,

    // The command to run the task for linting the whole workspace. Defaults to the found eslint binary for the workspace, or 'eslint' if no binary could be found.
    "eslint.lintTask.command": "eslint",

    // Controls whether a task for linting the whole workspace will be available.
    "eslint.lintTask.enable": false,

    // Command line options applied when running the task for linting the whole workspace (see https://eslint.org/docs/user-guide/command-line-interface).
    "eslint.lintTask.options": ".",

    // Whether ESlint should migrate auto fix on save settings.
    "eslint.migration.2_x": "on",

    // The value of `NODE_ENV` to use when running eslint tasks.
    "eslint.nodeEnv": null,

    // A path added to `NODE_PATH` when resolving the eslint module.
    "eslint.nodePath": null,

    // A special rules customization section for text cells in notebook documents.
    "eslint.notebooks.rules.customizations": [],

    // Whether ESLint should issue a warning on ignored files.
    "eslint.onIgnoredFiles": "off",

    // The eslint options object to provide args normally passed to eslint when executed from a command line (see https://eslint.org/docs/developer-guide/nodejs-api#eslint-class).
    "eslint.options": {},

    // The setting is deprecated. The Package Manager is automatically detected now.
    // The package manager you use to install node modules.
    "eslint.packageManager": "npm",

    // An array of language ids for which the extension should probe if support is installed.
    "eslint.probe": [
        "astro",
        "civet",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "mdx",
        "vue",
        "markdown",
        "json",
        "jsonc",
        "css",
        "glimmer-js",
        "glimmer-ts",
        "svelte"
    ],

    // Shortens the text spans of underlined problems to their first related line.
    "eslint.problems.shortenToSingleLine": false,

    // This option is deprecated. Use eslint.lintTask.enable instead.
    // Controls whether a task for linting the whole workspace will be available.
    "eslint.provideLintTask": false,

    // Turns on quiet mode, which ignores warnings and info diagnostics.
    "eslint.quiet": false,

    // Override the severity of one or more rules reported by this extension, regardless of the project's ESLint config. Use globs to apply default severities for multiple rules.
    "eslint.rules.customizations": [],

    // Run the linter on save (onSave) or on type (onType)
    "eslint.run": "onType",

    // The location of the node binary to run ESLint under.
    "eslint.runtime": null,

    // The time budget in milliseconds to spend on computing fixes before showing a warning or error.
    "eslint.timeBudget.onFixes": {
        "warn": 3000,
        "error": 6000
    },

    // The time budget in milliseconds to spend on validation before showing a warning or error.
    "eslint.timeBudget.onValidation": {
        "warn": 4000,
        "error": 8000
    },

    // Traces the communication between VSCode and the eslint linter service.
    "eslint.trace.server": "off",

    // Since version 7 ESLint offers a new API call ESLint. Use it even if the old CLIEngine is available. From version 8 on forward on ESLint class is available.
    "eslint.useESLintClass": false,

    // Controls whether flat config should be used or not. This setting requires ESLint version 8.57 or later and is interpreted according to the [ESLint Flat Config rollout plan](https://eslint.org/blog/2023/10/flat-config-rollout-plans/). This means:
    // 
    //  - *8.57.0 <= ESLint version < 9.x*: setting is honored and defaults to false
    // - *9.0.0 <= ESLint version < 10.x*: settings is honored and defaults to true
    // - *10.0.0 <= ESLint version*: setting is ignored. Flat configs are the default and can't be turned off.
    "eslint.useFlatConfig": null,

    // Whether ESLint should use real paths when resolving files. This is useful when working with symlinks or when the casing of file paths is inconsistent.
    "eslint.useRealpaths": false,

    // An array of language ids which should be validated by ESLint. If not installed ESLint will show an error.
    "eslint.validate": null,

    // Specifies how the working directories ESLint is using are computed. ESLint resolves configuration files (e.g. `eslintrc`, `.eslintignore`) relative to a working directory so it is important to configure this correctly.
    "eslint.workingDirectories": [],

    // Git History
    // Always prompt with repository picker when running Git History
    "gitHistory.alwaysPromptRepositoryPicker": false,

    // Avatar image cache expiration (0 = cache disabled)
    "gitHistory.avatarCacheExpiration": 60,

    // Prefer to open repository (instead of file) when pressing the editor title button
    "gitHistory.editorTitleButtonOpenRepo": false,

    // Whether to display the commit explorer view
    "gitHistory.hideCommitViewExplorer": false,

    // Include remote branches when opening Git History
    "gitHistory.includeRemoteBranches": false,

    // Output log information
    "gitHistory.logLevel": "Info",

    // Default number of items to be displayed in Git History Viewer
    "gitHistory.pageSize": 100,

    // Whether to display a button in the editor title menu bar
    "gitHistory.showEditorTitleMenuBarIcons": true,

    // Split show file history when file is active.
    "gitHistory.showFileHistorySplit": true,

    // Show commit details in side-by-side view
    "gitHistory.sideBySide": false,

    // Specifies where the 'Git: View History' action appears on the title of SCM Providers.
    //  - Inline: Show the 'Git: View History' action on the title of SCM Providers
    //  - More Actions: Show the 'Git: View History' action in the 'More Actions...' menu on the title of SCM Providers
    "gitHistory.sourceCodeProviderIntegrationLocation": "Inline",

    // Firefox debug
    // Additional arguments passed to Firefox
    "firefox.args": [],

    // Absolute path to the Firefox executable
    "firefox.executable": "",

    // Use the specified profile directly instead of a temporary copy
    "firefox.keepProfileChanges": false,

    // The remote debugging port to use
    "firefox.port": 0,

    // The name of the Firefox profile to use
    "firefox.profile": "",

    // The path of the Firefox profile directory to use
    "firefox.profileDir": "",

    // GitHub Copilot Chat
    // Automatically fix diagnostics for edited files.
    "github.copilot.chat.agent.autoFix": true,

    // When enabled, Copilot will include the name of the current active editor in the context for agent mode.
    "github.copilot.chat.agent.currentEditorContext.enabled": true,

    // When enabled, Copilot will automatically commit and push your pending changes before delegating work to the cloud agent.
    "github.copilot.chat.agent.delegate.autoCommitAndPush": false,

    // Temperature setting for agent mode requests.
    "github.copilot.chat.agent.temperature": 0,

    // Force GPT-4.1 for agent history summarization.
    "github.copilot.chat.agentHistorySummarizationForceGpt41": false,

    // Mode for agent history summarization.
    "github.copilot.chat.agentHistorySummarizationMode": "",

    // Use prompt caching for agent history summarization.
    "github.copilot.chat.agentHistorySummarizationWithPromptCache": false,

    // Enables an experimental alternate prompt for GPT models instead of the default prompt.
    "github.copilot.chat.alternateGptPrompt.enabled": false,

    // Maximum number of tokens to allocate for extended thinking in Anthropic models. Setting this value enables extended thinking. Valid range is 1,024 to 32,000 tokens. Always capped at (max output tokens - 1).
    // 
    // **Note**: This is an experimental feature not yet activated for all users.
    "github.copilot.chat.anthropic.thinking.budgetTokens": 0,

    // List of domains to restrict web search results to (e.g., `["example.com", "docs.example.com"]`). Domains should not include the HTTP/HTTPS scheme. Subdomains are automatically included. Cannot be used together with blocked domains.
    "github.copilot.chat.anthropic.tools.websearch.allowedDomains": [],

    // List of domains to exclude from web search results (e.g., `["untrustedsource.com"]`). Domains should not include the HTTP/HTTPS scheme. Subdomains are automatically excluded. Cannot be used together with allowed domains.
    "github.copilot.chat.anthropic.tools.websearch.blockedDomains": [],

    // Enable Anthropic's native web search tool for BYOK Claude models. When enabled, allows Claude to search the web for current information. 
    // 
    // **Note**: This is an experimental feature only available for BYOK Anthropic Claude models.
    "github.copilot.chat.anthropic.tools.websearch.enabled": false,

    // Maximum number of web searches allowed per request. Valid range is 1 to 20. Prevents excessive API calls within a single interaction. If Claude exceeds this limit, the response returns an error.
    "github.copilot.chat.anthropic.tools.websearch.maxUses": 5,

    // User location for personalizing web search results based on geographic context. All fields (city, region, country, timezone) are optional. Example: `{"city": "San Francisco", "region": "California", "country": "US", "timezone": "America/Los_Angeles"}`
    "github.copilot.chat.anthropic.tools.websearch.userLocation": null,

    // Authentication method for Azure OpenAI models. Entra ID is recommended for enterprise security and uses your Azure credentials.
    //  - entraId: Use Entra ID (Azure AD) authentication with your Microsoft account credentials
    //  - apiKey: Use API key authentication. Not recommended as this is less secure than token based authentication.
    "github.copilot.chat.azureAuthType": "entraId",

    // Configure custom Azure OpenAI models. Each key should be a unique model ID, and the value should be an object with model configuration including name, url, toolCalling, vision, maxInputTokens, and maxOutputTokens properties.
    "github.copilot.chat.azureModels": {},

    // The endpoint to use for the Ollama when accessed via bring your own key. Defaults to localhost.
    "github.copilot.chat.byok.ollamaEndpoint": "http://localhost:11434",

    // Enable debug mode for Claude Code agent.
    "github.copilot.chat.claudeCode.debug": false,

    // Enable Claude Code agent.
    "github.copilot.chat.claudeCode.enabled": false,

    // Enable Custom Agents for CLI.
    "github.copilot.chat.cli.customAgents.enabled": false,

    // Enable CLI isolation for agent sessions.
    "github.copilot.chat.cli.isolation.enabled": false,

    // Enable Model Context Protocol (MCP) server for CLI.
    "github.copilot.chat.cli.mcp.enabled": false,

    // Use instructions files instead. See https://aka.ms/vscode-ghcp-custom-instructions for more information.
    // A set of instructions that will be added to Copilot requests that generate code.
    // Instructions can come from: 
    // - a file in the workspace: `{ "file": "fileName" }`
    // - text in natural language: `{ "text": "Use underscore for field names." }`
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's quality and performance.
    "github.copilot.chat.codeGeneration.instructions": [],

    // Controls whether code instructions from `.github/copilot-instructions.md` are added to Copilot requests.
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's quality and performance. [Learn more](https://aka.ms/github-copilot-custom-instructions) about customizing Copilot.
    "github.copilot.chat.codeGeneration.useInstructionFiles": true,

    // Enable code search capabilities in agent mode.
    "github.copilot.chat.codesearch.agent.enabled": true,

    // Whether to enable agentic codesearch when using `#codebase`.
    "github.copilot.chat.codesearch.enabled": false,

    // A set of instructions that will be added to Copilot requests that generate commit messages.
    // Instructions can come from: 
    // - a file in the workspace: `{ "file": "fileName" }`
    // - text in natural language: `{ "text": "Use conventional commit message format." }`
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's quality and performance.
    "github.copilot.chat.commitMessageGeneration.instructions": [],

    // Sets the fetcher used for the inline completions.
    "github.copilot.chat.completionsFetcher": "",

    // Enable Copilot CLI integration.
    "github.copilot.chat.copilotCLI.enabled": true,

    // Whether the `copilot-debug` command is enabled in the terminal.
    "github.copilot.chat.copilotDebugCommand.enabled": true,

    // Enable custom agents from GitHub Enterprise and Organizations. When disabled, custom agents from your organization or enterprise will not be available in Copilot.
    "github.copilot.chat.customAgents.showOrganizationAndEnterpriseAgents": true,

    // When enabled, custom instructions and mode instructions will be appended to the system message instead of a user message.
    "github.copilot.chat.customInstructionsInSystemMessage": true,

    // Configure custom OpenAI-compatible models. Each key should be a unique model ID, and the value should be an object with model configuration including name, url, toolCalling, vision, maxInputTokens, and maxOutputTokens properties.
    "github.copilot.chat.customOAIModels": {},

    // Override the chat model. This allows you to test with different models.
    // 
    // **Note**: This is an advanced debugging setting and should not be used while self-hosting as it may lead to a different experience compared to end-users.
    "github.copilot.chat.debug.overrideChatEngine": "",

    // Maximum number of entries to keep in the request logger for debugging purposes.
    "github.copilot.chat.debug.requestLogger.maxEntries": 100,

    // A list of commands for which the "Debug Command" quick fix action should be shown in the debug terminal.
    "github.copilot.chat.debugTerminalCommandPatterns": [],

    // Enable edit recording for analysis.
    "github.copilot.chat.editRecording.enabled": false,

    // Enable the modern `multi_replace_string_in_file` edit tool when generating edits with Gemini 3 models.
    "github.copilot.chat.edits.gemini3MultiReplaceString": false,

    // Use only the modern `replace_string_in_file` edit tool when generating edits with Gemini 3 models.
    "github.copilot.chat.edits.gemini3ReplaceStringOnly": true,

    // Whether to suggest source files from test files for the Copilot Edits working set.
    "github.copilot.chat.edits.suggestRelatedFilesForTests": true,

    // Whether to suggest related files from git history for the Copilot Edits working set.
    "github.copilot.chat.edits.suggestRelatedFilesFromGitHistory": true,

    // Enable remembering user preferences in agent mode.
    "github.copilot.chat.enableUserPreferences": false,

    // Enable feedback collection on configuration changes.
    "github.copilot.chat.feedback.onChange": false,

    // Show 'Generate tests' code lens for symbols that are not covered by current test coverage information.
    "github.copilot.chat.generateTests.codeLens": false,

    // Enable built-in support for the GitHub MCP Server.
    "github.copilot.chat.githubMcpServer.enabled": false,

    // Enable lockdown mode for the GitHub MCP Server. When enabled, hides public issue details created by users without push access.
    "github.copilot.chat.githubMcpServer.lockdown": false,

    // Enable read-only mode for the GitHub MCP Server. When enabled, only read tools are available.
    "github.copilot.chat.githubMcpServer.readonly": false,

    // Specify toolsets to use from the GitHub MCP Server.
    "github.copilot.chat.githubMcpServer.toolsets": [
        "default"
    ],

    // Enable GPT-5 alternative patch format.
    "github.copilot.chat.gpt5AlternativePatch": false,

    // Enables the use of image upload URLs in chat requests instead of raw base64 strings.
    "github.copilot.chat.imageUpload.enabled": true,

    // Enable diagnostics context provider for next edit suggestions.
    "github.copilot.chat.inlineEdits.diagnosticsContextProvider.enabled": true,

    // Maximum tokens for current file in next cursor prediction.
    "github.copilot.chat.inlineEdits.nextCursorPrediction.currentFileMaxTokens": 2000,

    // Display predicted cursor line for next edit suggestions.
    "github.copilot.chat.inlineEdits.nextCursorPrediction.displayLine": true,

    // Enable rename symbol suggestions in inline edits.
    "github.copilot.chat.inlineEdits.renameSymbolSuggestions": false,

    // Trigger inline edits after editor has been idle for this many seconds.
    "github.copilot.chat.inlineEdits.triggerOnEditorChangeAfterSeconds": 0,

    // Token limit for short context instant apply.
    "github.copilot.chat.instantApply.shortContextLimit": 8000,

    // Model name for short context instant apply.
    "github.copilot.chat.instantApply.shortContextModelName": "gpt-4o-instant-apply-full-ft-v66-short",

    // Enables the TypeScript language context provider for /fix commands
    "github.copilot.chat.languageContext.fix.typescript.enabled": false,

    // Enables the TypeScript language context provider for inline chats (both generate and edit)
    "github.copilot.chat.languageContext.inline.typescript.enabled": false,

    // The cache population timeout for the TypeScript language context provider in milliseconds. The default is 500 milliseconds.
    "github.copilot.chat.languageContext.typescript.cacheTimeout": 500,

    // Enables the TypeScript language context provider for inline suggestions
    "github.copilot.chat.languageContext.typescript.enabled": true,

    // Controls whether to include documentation comments in the generated code snippets.
    "github.copilot.chat.languageContext.typescript.includeDocumentation": false,

    // Controls which kind of items are included in the TypeScript language context provider.
    "github.copilot.chat.languageContext.typescript.items": "double",

    // Specify a locale that Copilot should respond in, e.g. `en` or `fr`. By default, Copilot will respond using VS Code's configured display language locale.
    //  - auto: Use VS Code's configured display language
    //  - en: English
    //  - fr: français
    //  - it: italiano
    //  - de: Deutsch
    //  - es: español
    //  - ru: русский
    //  - zh-CN: 中文(简体)
    //  - zh-TW: 中文(繁體)
    //  - ja: 日本語
    //  - ko: 한국어
    //  - cs: čeština
    //  - pt-br: português
    //  - tr: Türkçe
    //  - pl: polski
    "github.copilot.chat.localeOverride": "auto",

    // Enable local workspace recording for analysis.
    "github.copilot.chat.localWorkspaceRecording.enabled": false,

    // Sets the fetcher used for the next edit suggestions.
    "github.copilot.chat.nesFetcher": "",

    // Whether to use the [Context7](command:github.copilot.mcp.viewContext7) tools to scaffold project for new workspace creation.
    "github.copilot.chat.newWorkspace.useContext7": false,

    // Whether to enable new agentic workspace creation.
    "github.copilot.chat.newWorkspaceCreation.enabled": true,

    // Alternative document format for notebooks.
    "github.copilot.chat.notebook.alternativeFormat": "xml",

    // Enable alternative format for Next Edit Suggestions in notebooks.
    "github.copilot.chat.notebook.alternativeNESFormat.enabled": false,

    // Controls whether to use an enhanced approach for generating next edit suggestions in notebook cells.
    "github.copilot.chat.notebook.enhancedNextEditSuggestions.enabled": false,

    // Controls whether the currently executing cell is revealed into the viewport upon execution from Copilot.
    "github.copilot.chat.notebook.followCellExecution.enabled": false,

    // Enable the notebook summary experiment.
    "github.copilot.chat.notebook.summaryExperimentEnabled": false,

    // Enable filtering variables by cell document symbols.
    "github.copilot.chat.notebook.variableFilteringEnabled": false,

    // Omit base agent instructions from prompts.
    "github.copilot.chat.omitBaseAgentInstructions": false,

    // Add project labels in chat requests.
    "github.copilot.chat.projectLabels.chat": false,

    // Use the expanded format for project labels in prompts.
    "github.copilot.chat.projectLabels.expanded": false,

    // Add project labels in inline edit requests.
    "github.copilot.chat.projectLabels.inline": false,

    // Enable prompt file context provider.
    "github.copilot.chat.promptFileContextProvider.enabled": true,

    // A set of instructions that will be added to Copilot requests that generate pull request titles and descriptions.
    // Instructions can come from: 
    // - a file in the workspace: `{ "file": "fileName" }`
    // - text in natural language: `{ "text": "Always include a list of key changes." }`
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's quality and performance.
    "github.copilot.chat.pullRequestDescriptionGeneration.instructions": [],

    // Sets the reasoning effort used for the Responses API. Requires `github.copilot.chat.useResponsesApi`.
    "github.copilot.chat.responsesApiReasoningEffort": "default",

    // Sets the reasoning summary style used for the Responses API. Requires `github.copilot.chat.useResponsesApi`.
    "github.copilot.chat.responsesApiReasoningSummary": "detailed",

    // Enable intent detection for code review.
    "github.copilot.chat.review.intent": false,

    // Enables the code review agent.
    "github.copilot.chat.reviewAgent.enabled": true,

    // Enables code review on current selection.
    "github.copilot.chat.reviewSelection.enabled": true,

    // A set of instructions that will be added to Copilot requests that provide code review for the current selection.
    // Instructions can come from: 
    // - a file in the workspace: `{ "file": "fileName" }`
    // - text in natural language: `{ "text": "Use underscore for field names." }`
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's effectiveness.
    "github.copilot.chat.reviewSelection.instructions": [],

    // Whether to prompt the user to select a specific symbol scope if the user uses `/explain` and the active editor has no selection.
    "github.copilot.chat.scopeSelection": false,

    // Enables the `/setupTests` intent and prompting in `/tests` generation.
    "github.copilot.chat.setupTests.enabled": true,

    // Use embeddings to suggest related files from git history.
    "github.copilot.chat.suggestRelatedFilesFromGitHistory.useEmbeddings": false,

    // Whether to auto-summarize agent conversation history once the context window is filled.
    "github.copilot.chat.summarizeAgentConversationHistory.enabled": true,

    // Threshold for summarizing agent conversation history.
    "github.copilot.chat.summarizeAgentConversationHistoryThreshold": 0,

    // Maximum age (in editor changes) for temporal context.
    "github.copilot.chat.temporalContext.maxAge": 100,

    // Prefer same language files in temporal context.
    "github.copilot.chat.temporalContext.preferSameLang": false,

    // Controls where chat queries from the terminal should be opened.
    //  - chatView: Open the chat view.
    //  - quickChat: Open quick chat.
    //  - terminal: Open terminal inline chat
    "github.copilot.chat.terminalChatLocation": "chatView",

    // Use instructions files instead. See https://aka.ms/vscode-ghcp-custom-instructions for more information.
    // A set of instructions that will be added to Copilot requests that generate tests.
    // Instructions can come from: 
    // - a file in the workspace: `{ "file": "fileName" }`
    // - text in natural language: `{ "text": "Use underscore for field names." }`
    // 
    // Note: Keep your instructions short and precise. Poor instructions can degrade Copilot's quality and performance.
    "github.copilot.chat.testGeneration.instructions": [],

    // Group default tools in prompts.
    "github.copilot.chat.tools.defaultToolsGrouped": false,

    // Enable memory tool to allow models to store and retrieve information across conversations. 
    // 
    // **Note**: This is an experimental feature.
    "github.copilot.chat.tools.memory.enabled": false,

    // Use relevant GitHub projects as starter projects when using `/new`
    "github.copilot.chat.useProjectTemplates": true,

    // Use the Responses API instead of the Chat Completions API when supported. Enables reasoning and reasoning summaries.
    // 
    // **Note**: This is an experimental feature that is not yet activated for all users.
    // 
    // **Important**: URL API path resolution for custom OpenAI-compatible and Azure models is independent of this setting and fully determined by `url` property of `github.copilot.chat.customOAIModels#` or `#github.copilot.chat.azureModels` respectively.
    "github.copilot.chat.useResponsesApi": true,

    // Use Responses API for truncation.
    "github.copilot.chat.useResponsesApiTruncation": false,

    // This setting defines the tool count over which virtual tools should be used. Virtual tools group similar sets of tools together and they allow the model to activate them on-demand. Certain tool groups will optimistically be pre-activated. We are actively developing this feature and you experience degraded tool calling once the threshold is hit.
    // 
    // May be set to `0` to disable virtual tools.
    "github.copilot.chat.virtualTools.threshold": 128,

    // Enable code search in workspace context.
    "github.copilot.chat.workspace.enableCodeSearch": true,

    // Enable embeddings-based search in workspace context.
    "github.copilot.chat.workspace.enableEmbeddingsSearch": true,

    // Enable full workspace context analysis.
    "github.copilot.chat.workspace.enableFullWorkspace": true,

    // Maximum size of the local workspace index.
    "github.copilot.chat.workspace.maxLocalIndexSize": 100000,

    // Preferred embeddings model for semantic search.
    "github.copilot.chat.workspace.preferredEmbeddingsModel": "",

    // Override endpoint for Azure DevOps code search prototype.
    "github.copilot.chat.workspace.prototypeAdoCodeSearchEndpointOverride": "",

    // Controls if Copilot commands are shown as Code Actions when available
    "github.copilot.editor.enableCodeActions": true,

    // Enable or disable auto triggering of Copilot completions for specified [languages](https://code.visualstudio.com/docs/languages/identifiers). You can still trigger suggestions manually using `Alt + \`
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "scminput": false
    },

    // Whether to allow whitespace-only changes be proposed by next edit suggestions (NES).
    "github.copilot.nextEditSuggestions.allowWhitespaceOnlyChanges": true,

    // Whether to enable next edit suggestions (NES).
    // 
    // NES can propose a next edit based on your recent changes. [Learn more](https://aka.ms/vscode-nes) about next edit suggestions.
    "github.copilot.nextEditSuggestions.enabled": true,

    // Whether to offer fixes for diagnostics via next edit suggestions (NES).
    "github.copilot.nextEditSuggestions.fixes": true,

    // Controls whether Copilot generates suggestions for renaming
    "github.copilot.renameSuggestions.triggerAutomatically": true,

    // The currently selected completion model ID. To select from a list of available models, use the __"Change Completions Model"__ command or open the model picker (from the Copilot menu in the VS Code title bar, select __"Configure Code Completions"__ then __"Change Completions Model"__. The value must be a valid model ID. An empty value indicates that the default model will be used.
    "github.copilot.selectedCompletionModel": "",

    // GitHub Actions
    // The name of the repository's git remote that points to GitHub
    "github-actions.remote-name": "origin",

    // If this is set to true, use the auth provider for the GitHub Enterprise URL configured in `github-enterprise.uri`
    "github-actions.use-enterprise": false,

    // Auto-refresh pinned workflows. Note: this uses polling and counts against your GitHub API rate limit
    "github-actions.workflows.pinned.refresh.enabled": false,

    // Time to wait between calls to update pinned workflows in seconds
    "github-actions.workflows.pinned.refresh.interval": 30,

    // Workflows to show in the status bar, identified by their paths
    "github-actions.workflows.pinned.workflows": [],

    // GitHub Pull Requests
    // Enabling will always prompt which repository to create an issue in instead of basing off the current open file.
    "githubIssues.alwaysPromptForNewIssueRepo": false,

    // Assigns the issue you're working on to you. Only applies when the issue you're working on is in a repo you currently have open.
    "githubIssues.assignWhenWorking": true,

    // Controls whether an issue number (ex. #1234) or a full url (ex. https://github.com/owner/name/issues/1234) is inserted when the Create Issue code action is run.
    "githubIssues.createInsertFormat": "number",

    // Strings that will cause the 'Create issue from comment' code action to show.
    "githubIssues.createIssueTriggers": [
        "TODO",
        "todo",
        "FIXME",
        "ISSUE",
        "HACK"
    ],

    // Languages that the '#' character should not be used to trigger issue completion suggestions.
    "githubIssues.ignoreCompletionTrigger": [
        "coffeescript",
        "crystal",
        "diff",
        "dockerfile",
        "dockercompose",
        "ignore",
        "ini",
        "julia",
        "makefile",
        "perl",
        "powershell",
        "python",
        "r",
        "ruby",
        "shellscript",
        "yaml"
    ],

    // An array of milestones titles to never show issues from.
    "githubIssues.ignoreMilestones": [],

    // Languages that the '@' character should not be used to trigger user completion suggestions.
    "githubIssues.ignoreUserCompletionTrigger": [],

    // Controls which avatar to display in the issue list.
    //  - author: Show the avatar of the issue creator
    //  - assignee: Show the avatar of the first assignee (show GitHub icon if no assignees)
    "githubIssues.issueAvatarDisplay": "author",

    // Advanced settings for the name of the branch that is created when you start working on an issue. 
    // - `${user}` will be replaced with the currently logged in username 
    // - `${issueNumber}` will be replaced with the current issue number 
    // - `${sanitizedIssueTitle}` will be replaced with the issue title, with all spaces and unsupported characters (https://git-scm.com/docs/git-check-ref-format) removed. For lowercase, use `${sanitizedLowercaseIssueTitle}` 
    "githubIssues.issueBranchTitle": "${user}/issue${issueNumber}",

    // Sets the format of issue completions in the SCM inputbox. 
    // - `${user}` will be replace with the currently logged in username 
    // - `${issueNumber}` will be replaced with the current issue number 
    // - `${issueNumberLabel}` will be replaced with a label formatted as #number or owner/repository#number, depending on whether the issue is in the current repository
    "githubIssues.issueCompletionFormatScm": "${issueTitle}\nFixes ${issueNumberLabel}",

    // Controls whether completion suggestions are shown for issues.
    "githubIssues.issueCompletions.enabled": true,

    // Specifies what queries should be used in the GitHub issues tree using [GitHub search syntax](https://help.github.com/en/articles/understanding-the-search-syntax) with variables. The first query listed will be expanded in the Issues view. The "default" query includes issues assigned to you by Milestone. If you want to preserve these, make sure they are still in the array when you modify the setting.
    "githubIssues.queries": [
        {
            "label": "My Issues",
            "query": "is:open assignee:${user} repo:${owner}/${repository}",
            "groupBy": [
                "milestone"
            ]
        },
        {
            "label": "Created Issues",
            "query": "author:${user} state:open repo:${owner}/${repository} sort:created-desc"
        },
        {
            "label": "Recent Issues",
            "query": "state:open repo:${owner}/${repository} sort:updated-desc"
        }
    ],

    // Determines whether a branch should be checked out when working on an issue. To configure the name of the branch, set `githubIssues.issueBranchTitle`.
    //  - on: A branch will always be checked out when you start working on an issue. If the branch doesn't exist, it will be created.
    //  - off: A branch will not be created when you start working on an issue. If you have worked on an issue before and a branch was created for it, that same branch will be checked out.
    //  - prompt: A prompt will show for setting the name of the branch that will be created and checked out.
    "githubIssues.useBranchForIssues": "on",

    // Controls whether completion suggestions are shown for users.
    "githubIssues.userCompletions.enabled": true,

    // Sets the format of the commit message that is set in the SCM inputbox when you **Start Working on an Issue**. Defaults to `${issueTitle} 
    // Fixes ${issueNumberLabel}`
    "githubIssues.workingIssueFormatScm": "${issueTitle} \nFixes ${issueNumberLabel}",

    // Allows `git fetch` to be run for checked-out pull request branches when checking for updates to the pull request.
    "githubPullRequests.allowFetch": true,

    // All pull requests created with this extension will be assigned to this user. To assign to yourself, use the '${user}' variable.
    "githubPullRequests.assignCreated": "",

    // Maximum time in milliseconds to wait when fetching the list of branches for pull request creation. Repositories with thousands of branches may need a higher value to ensure all branches (including the default branch) are retrieved. Minimum value is 1000 (1 second).
    "githubPullRequests.branchListTimeout": 5000,

    // Allow automatic git operations (commit, push) to be performed when starting a coding agent session
    "githubPullRequests.codingAgent.autoCommitAndPush": true,

    // Show the 'Delegate to agent' CodeLens actions above TODO comments for delegating to coding agent.
    "githubPullRequests.codingAgent.codeLens": true,

    // Enables integration with the asynchronous Copilot coding agent. The '#copilotCodingAgent' tool will be available in agent mode when this setting is enabled.
    "githubPullRequests.codingAgent.enabled": true,

    // Prompt for confirmation before initiating a coding agent session from the UI integration.
    "githubPullRequests.codingAgent.promptForConfirmation": true,

    // Enables UI integration within VS Code to create new coding agent sessions.
    "githubPullRequests.codingAgent.uiIntegration": true,

    // Controls whether comments are expanded when a document with comments is opened. Requires a reload to take effect for comments that have already been added.
    //  - expandUnresolved: All unresolved comments will be expanded.
    //  - collapseAll: All comments will be collapsed
    "githubPullRequests.commentExpandState": "expandUnresolved",

    // Controls what the base branch picker defaults to when creating a pull request
    //  - repositoryDefault: The default branch of the repository
    //  - createdFromBranch: The branch that the current branch was created from, if known
    //  - auto: When the current repository is a fork, this will work like "repositoryDefault". Otherwise, it will work like "createdFromBranch".
    "githubPullRequests.createDefaultBaseBranch": "auto",

    // Use the setting 'githubPullRequests.defaultCreateOption' instead.
    // Whether the "Draft" checkbox will be checked by default when creating a pull request.
    "githubPullRequests.createDraft": false,

    // Create a pull request when a branch is published.
    //  - never: Never create a pull request when a branch is published.
    //  - ask: Ask if you want to create a pull request when a branch is published.
    "githubPullRequests.createOnPublishBranch": "ask",

    // The default comment type to use when submitting a comment and there is no active review
    //  - single: Submits the comment as a single comment that will be immediately visible to other users
    //  - review: Submits the comment as a review comment that will be visible to other users once the review is submitted
    "githubPullRequests.defaultCommentType": "review",

    // The create option that the "Create" button will default to when creating a pull request.
    //  - lastUsed: The most recently used create option.
    //  - create: The pull request will be created.
    //  - createDraft: The pull request will be created as a draft.
    //  - createAutoMerge: The pull request will be created with auto-merge enabled. The merge method selected will be the default for the repo or the value of `githubPullRequests.defaultMergeMethod` if set.
    "githubPullRequests.defaultCreateOption": "lastUsed",

    // When true, the option to delete the local branch will be selected by default when deleting a branch from a pull request.
    "githubPullRequests.defaultDeletionMethod.selectLocalBranch": true,

    // When true, the option to delete the remote will be selected by default when deleting a branch from a pull request.
    "githubPullRequests.defaultDeletionMethod.selectRemote": true,

    // The method to use when merging pull requests.
    "githubPullRequests.defaultMergeMethod": "merge",

    // Enables the `@githubpr` Copilot chat participant in the chat view. `@githubpr` can help search for issues and pull requests, suggest fixes for issues, and summarize issues, pull requests, and notifications.
    "githubPullRequests.experimental.chat": true,

    // Adds an action in the Notifications view to mark pull requests with no non-empty reviews, comments, or commits since you last viewed the pull request as read.
    "githubPullRequests.experimental.notificationsMarkPullRequests": "none",

    // Controls whether the Copilot "Summarize" commands in the Pull Requests, Issues, and Notifications views will use quick chat. Only has an effect if `githubPullRequests.experimental.chat` is enabled.
    "githubPullRequests.experimental.useQuickChat": false,

    // The layout to use when displaying changed files list.
    "githubPullRequests.fileListLayout": "tree",

    // The layout to use when a pull request is checked out. Set to false to prevent layout changes.
    //  - firstDiff: Show the first diff in the pull request. If there are no changes, show the overview.
    //  - overview: Show the overview of the pull request.
    //  - multiDiff: Show all diffs in the pull request. If there are no changes, show the overview.
    //  - false: Do not change the layout.
    "githubPullRequests.focusedMode": "multiDiff",

    // Hide files that have been marked as viewed in the pull request changes tree.
    "githubPullRequests.hideViewedFiles": false,

    // Prevents branches that are associated with a pull request from being automatically detected. This will prevent review mode from being entered on these branches.
    "githubPullRequests.ignoredPullRequestBranches": [],

    // Prevents repositories that are submodules from being managed by the GitHub Pull Requests extension. A window reload is required for changes to this setting to take effect.
    "githubPullRequests.ignoreSubmodules": false,

    // The setting `githubPullRequests.includeRemotes` has been deprecated. Use `githubPullRequests.remotes` to configure what remotes are shown.
    // By default we only support remotes created by users. If you want to see pull requests from remotes this extension created for pull requests, change this setting to 'all'.
    "githubPullRequests.includeRemotes": "default",

    // Group of labels that you want to add to the pull request automatically. Labels that don't exist in the repository won't be added.
    "githubPullRequests.labelCreated": [],

    // Log level is now controlled by the [Developer: Set Log Level...](command:workbench.action.setLogLevel) command. You can set the log level for the current session and also the default log level from there.
    // Logging for GitHub Pull Request extension. The log is emitted to the output channel named as GitHub Pull Request.
    "githubPullRequests.logLevel": "info",

    // Never offer to ignore a pull request associated with the default branch of a repository.
    "githubPullRequests.neverIgnoreDefaultBranch": false,

    // If GitHub notifications should be shown to the user.
    "githubPullRequests.notifications": "off",

    // The default branch for a repository is set on github.com. With this setting, you can override that default with another branch.
    "githubPullRequests.overrideDefaultBranch": "",

    // The action to take after creating a pull request.
    //  - none: No action
    //  - openOverview: Open the overview page of the pull request
    //  - checkoutDefaultBranch: Checkout the default branch of the repository
    //  - checkoutDefaultBranchAndShow: Checkout the default branch of the repository and show the pull request in the Pull Requests view
    //  - checkoutDefaultBranchAndCopy: Checkout the default branch of the repository and copy a link to the pull request to the clipboard
    "githubPullRequests.postCreate": "openOverview",

    // The action to take after using the 'checkout default branch' or 'delete branch' actions on a currently checked out pull request.
    //  - checkoutDefaultBranch: Checkout the default branch of the repository
    //  - checkoutDefaultBranchAndPull: Checkout the default branch of the repository and pull the latest changes
    "githubPullRequests.postDone": "checkoutDefaultBranch",

    // Pull changes from the remote when a pull request branch is checked out locally. Changes are detected when the pull request is manually refreshed and during periodic background updates.
    //  - prompt: Prompt to pull a pull request branch when changes are detected in the pull request.
    //  - never: Never pull a pull request branch when changes are detected in the pull request.
    //  - always: Always pull a pull request branch when changes are detected in the pull request. When `"git.autoStash": true` this will instead `prompt` to prevent unexpected file changes.
    "githubPullRequests.pullBranch": "prompt",

    // Controls whether the pull request branch is pulled before checkout. Can also be set to additionally merge updates from the base branch.
    //  - never: Never pull the pull request branch before checkout.
    //  - pull: Pull the pull request branch before checkout.
    //  - pullAndMergeBase: Pull the pull request branch before checkout, fetch the base branch, and merge the base branch into the pull request branch.
    //  - pullAndUpdateBase: Pull the pull request branch before checkout, fetch the base branch, merge the base branch into the pull request branch, and finally push the pull request branch to the remote.
    "githubPullRequests.pullPullRequestBranchBeforeCheckout": "pull",

    // The description used when creating pull requests.
    //  - template: Use a pull request template and commit description, or just use the commit description if no templates were found
    //  - commit: Use the latest commit message only
    //  - none: Do not have a default description
    //  - Copilot: Generate a pull request title and description from GitHub Copilot. Requires that the GitHub Copilot extension is installed and authenticated. Will fall back to `commit` if Copilot is not set up.
    "githubPullRequests.pullRequestDescription": "template",

    // The pull request title now uses the same defaults as GitHub, and can be edited before create.
    // The title used when creating pull requests.
    //  - commit: Use the latest commit message
    //  - branch: Use the branch name
    //  - custom: Specify a custom title
    //  - ask: Ask which of the above methods to use
    "githubPullRequests.pullRequestTitle": "ask",

    // Push the "from" branch when creating a pull request and the "from" branch is not available on the remote.
    //  - prompt: Prompt to push the branch when creating a pull request and the "from" branch is not available on the remote.
    //  - always: Always push the branch when creating a pull request and the "from" branch is not available on the remote.
    "githubPullRequests.pushBranch": "prompt",

    // Specifies what queries should be used in the GitHub Pull Requests tree. All queries are made against **the currently opened repos**. Each query object has a `label` that will be shown in the tree and a search `query` using [GitHub search syntax](https://help.github.com/en/articles/understanding-the-search-syntax). By default these queries define the categories "Copilot on My Behalf", "Local Pull Request Branches", "Waiting For My Review", "Assigned To Me" and "Created By Me". If you want to preserve these, make sure they are still in the array when you modify the setting. 
    // 
    // **Variables available:**
    //  - `${user}` - currently logged in user 
    //  - `${owner}` - repository owner, ex. `microsoft` in `microsoft/vscode` 
    //  - `${repository}` - repository name, ex. `vscode` in `microsoft/vscode` 
    //  - `${today-Nd}` - date N days ago, ex. `${today-7d}` becomes `2025-01-04`
    // 
    // **Example custom queries:**
    // ```json
    // "githubPullRequests.queries": [
    //   {
    //     "label": "Waiting For My Review",
    //     "query": "is:open review-requested:${user}"
    //   },
    //   {
    //     "label": "Mentioned Me",
    //     "query": "is:open mentions:${user}"
    //   },
    //   {
    //     "label": "Recent Activity",
    //     "query": "is:open updated:>${today-7d}"
    //   }
    // ]
    // ```
    "githubPullRequests.queries": [
        {
            "label": "Copilot on My Behalf",
            "query": "repo:${owner}/${repository} is:open author:copilot involves:${user}"
        },
        {
            "label": "Local Pull Request Branches",
            "query": "default"
        },
        {
            "label": "Waiting For My Review",
            "query": "repo:${owner}/${repository} is:open review-requested:${user}"
        },
        {
            "label": "Created By Me",
            "query": "repo:${owner}/${repository} is:open author:${user}"
        },
        {
            "label": "All Open",
            "query": "default"
        }
    ],

    // Enables quick diff in the editor gutter for checked-out pull requests. Requires a reload to take effect
    "githubPullRequests.quickDiff": false,

    // List of remotes, by name, to fetch pull requests from.
    "githubPullRequests.remotes": [
        "origin",
        "upstream"
    ],

    // Use the setting 'githubPullRequests.defaultCreateOption' instead.
    // Checks the "Auto-merge" checkbox in the "Create Pull Request" view.
    "githubPullRequests.setAutoMerge": false,

    // This setting is deprecated. Views can now be dragged to any location.
    // When true, show GitHub Pull Requests within the SCM viewlet. Otherwise show a separate view container for them.
    "githubPullRequests.showInSCM": false,

    // Shows the pull request number in the tree view.
    "githubPullRequests.showPullRequestNumberInTree": false,

    // Default handler for terminal links.
    //  - github: Create the pull request on GitHub
    //  - vscode: Create the pull request in VS Code
    //  - ask: Ask which method to use
    "githubPullRequests.terminalLinksHandler": "ask",

    // Controls whether an `upstream` remote is automatically added for forks
    //  - add: An `upstream` remote will be automatically added for forks
    //  - never: An `upstream` remote will never be automatically added for forks
    "githubPullRequests.upstreamRemote": "add",

    // Choose which pull request states will use review mode. "Open" pull requests will always use review mode. Setting to "auto" will use review mode for open, closed, and merged pull requests in web, but only open pull requests on desktop.
    "githubPullRequests.useReviewMode": "auto",

    // The interval, in seconds, at which the pull request and issues webviews are refreshed when the webview is the active tab.
    "githubPullRequests.webviewRefreshInterval": 60,

    // PlantUML configuration
    // commandArgs allows you add arguments to java command, such as "-DPLANTUML_LIMIT_SIZE=8192".
    "plantuml.commandArgs": [],

    // Specifies where all diagram files located (relative to workspace folder).
    "plantuml.diagramsRoot": "",

    // Decides concurrency count when export multiple diagrams.
    "plantuml.exportConcurrency": 3,

    // Export format. Leave it blank to pick format everytime you export.
    "plantuml.exportFormat": "",

    // Include folder heiracrchy between the root and the source diagram in the exported file path.
    "plantuml.exportIncludeFolderHeirarchy": true,

    // Determine whether export image map (.cmapx) file when export.
    "plantuml.exportMapFile": false,

    // Exported workspace diagrams will be organized in this directory (relative path to workspace folder).
    "plantuml.exportOutDir": "out",

    // Export diagrams to a folder which has same name with host file.
    "plantuml.exportSubFolder": true,

    // File extensions that find to export. Especially in workspace settings, you may add your own extensions so as to export diagrams in source code files, like ".java".
    "plantuml.fileExtensions": ".wsd,.pu,.puml,.plantuml,.iuml",

    // Specifies the include paths besides source folder and the 'diagramsRoot'.
    "plantuml.includepaths": [],

    // Alternate plantuml.jar location. Leave it blank to use integrated jar.
    "plantuml.jar": "",

    // jarArgs allows you add arguments to plantuml.jar, such as "-config plantuml.config".
    "plantuml.jarArgs": [],

    // Java executable location.
    "plantuml.java": "java",

    // lint when diagram is unamed.
    "plantuml.lintDiagramNoName": true,

    // Decides if automatically update the preview window.
    "plantuml.previewAutoUpdate": true,

    // Decides if to display the snap indicators in the preview window.
    "plantuml.previewSnapIndicators": false,

    // Swaps left and right mouse buttons used for zooming or panning
    "plantuml.previewSwapMouseButtons": false,

    // Select diagram render for both export and preview.
    // Local: Render diagrams locally in traditional way. You need to set up JAVA and GraphViz first.
    // PlantUMLServer: Render diagrams by server which is specified with "plantuml.server". It's much faster, but requires a server.
    // Local is the default configuration.
    "plantuml.render": "",

    // Plantuml server to generate UML diagrams on-the-fly. You may use official server https://www.plantuml.com/plantuml if you feel OK to share data with it.
    "plantuml.server": "",

    // URL format. Leave it blank to pick format everytime you make a URL.
    "plantuml.urlFormat": "",

    // URL result type. Simple URL or ready for MarkDown use.
    "plantuml.urlResult": "MarkDown",

    // Rainbow CSV
    // Enable automatic content-based separator autodetection for the specified list of separators (multicharacter separators are supported).
    "rainbow_csv.autodetect_separators": [
        "TAB",
        ",",
        ";",
        "|"
    ],

    // Minimum number of non-comment lines in file for content-based autodetection.
    "rainbow_csv.autodetection_min_line_count": 10,

    // Comment lines prefix, e.g. "#". Set to empty string to disable.
    "rainbow_csv.comment_prefix": "",

    // CSV Lint: detect leading and trailing whitespaces in fields and show warning.
    "rainbow_csv.csv_lint_detect_trailing_spaces": false,

    // If enabled treat double width unicode chars e.g. Chinese or Japanese chars as double wide when aligning.
    "rainbow_csv.double_width_alignment": true,

    // Automatically run linter for every CSV file.
    "rainbow_csv.enable_auto_csv_lint": true,

    // Enable "Preview CSV head" option in File Explorer context menu for all files.
    "rainbow_csv.enable_context_menu_head": false,

    // Enable "Preview CSV tail" option in File Explorer context menu for all files.
    "rainbow_csv.enable_context_menu_tail": false,

    // Keyboard input text cursor: show info about the cursor CSV column in the status bar.
    "rainbow_csv.enable_cursor_position_info": true,

    // Dev Mode: Enable Debug Logging. Run command [Developer: Show Logs...] -> [rainbow_csv_debug_channel] to see the output.
    "rainbow_csv.enable_debug_logging": false,

    // Enable automatic content based separator autodetection.
    "rainbow_csv.enable_separator_autodetection": true,

    // Enable sticky header line at the top.
    "rainbow_csv.enable_sticky_header": true,

    // Enable column-info tooltip on hover.
    "rainbow_csv.enable_tooltip": true,

    // Show column names in tooltip.
    "rainbow_csv.enable_tooltip_column_names": true,

    // Highlight rows with alternate background colors by default.
    "rainbow_csv.highlight_rows": false,

    // Output directory for RBQL result sets, can be `TMP`, `INPUT` or a custom absolute path. `TMP` - output in system tmp dir(default), `INPUT` - output in the same dir as input file, otherwise use provided path as the output directory e.g. `/path/to/custom/dir`.
    "rainbow_csv.rbql_output_dir": "TMP",

    // RBQL strips (trims) leading and trailing spaces from each field as a preprocessig step.
    "rainbow_csv.rbql_strip_spaces": true,

    // RBQL treats the first line as header by default.
    "rainbow_csv.rbql_with_headers_by_default": false,

    // Virtual alignment character.
    //  - middot: Middle dot
    //  - space: Whitespace
    "rainbow_csv.virtual_alignment_char": "middot",

    // Virtual alignment based on VSCode inlay hints that doesn't change underlying file content.
    //  - disabled: Disabled. Align only when "VirtualAlign" command is executed
    //  - manual: Align when "Align" Status Bar button is clicked
    //  - always: Automatically align all files
    "rainbow_csv.virtual_alignment_mode": "disabled",

    // Show vertical grid in virtual alignment mode.
    "rainbow_csv.virtual_alignment_vertical_grid": false,

    // Durable Task Scheduler
    // Allow the user to select a programming model when creating a new function project.
    "azureFunctions.allowProgrammingModelSelection": false,

    // Create a virtual environment when creating a new Python project.
    "azureFunctions.createPythonVenv": true,

    // The default function app to use when deploying, represented by its full Azure id.  Every subsequent deployment of this workspace will deploy to this function app or slot.
    "azureFunctions.defaultFunctionAppToDeploy": "",

    // The default subpath of a workspace folder to use when deploying. If set, you will not be prompted for the folder path when deploying.
    "azureFunctions.deploySubpath": "",

    // The name of the Durable Task Scheduler emulator image.
    "azureFunctions.durableTaskScheduler.emulatorImage": "dts/dts-emulator",

    // The registry of the Durable Task Scheduler emulator image.
    "azureFunctions.durableTaskScheduler.emulatorRegistry": "mcr.microsoft.com",

    // The tag of the Durable Task Scheduler emulator image.
    "azureFunctions.durableTaskScheduler.emulatorTag": "latest",

    // Enable Durable Task Scheduler preview features
    "azureFunctions.durableTaskScheduler.enablePreviewFeatures": false,

    // Enable remote debugging for Java Functions Apps running on Windows. (experimental)
    "azureFunctions.enableJavaRemoteDebugging": false,

    // Enable download content and setup project feature using handle uri (experimental)
    "azureFunctions.enableOpenFromPortal": false,

    // Prepends each line displayed in the output channel with a timestamp.
    "azureFunctions.enableOutputTimestamps": true,

    // Enable remote debugging for Node.js Function Apps running on Linux App Service plans. Consumption plans are not supported. (experimental)
    "azureFunctions.enableRemoteDebugging": false,

    // Show a warning when creating Function Apps with stacks within 6 months of their end of life.
    "azureFunctions.endOfLifeWarning": true,

    // The path to the 'func' executable to use for debug and deploy tasks. For example, set it to 'node_modules/.bin/func' if using the func cli installed as a local npm package.
    "azureFunctions.funcCliPath": "",

    // The default subpath to create new functions. Currently, this only applies to Node.js programming model v4+.
    "azureFunctions.functionSubpath": "src/functions",

    // The timeout (in seconds) to be used when starting the Azure Functions host.
    "azureFunctions.hostStartTimeout": 60,

    // Build tool for Java Functions project
    "azureFunctions.javaBuildTool": "maven",

    // The type of MCP integration the project uses.
    //  - NoMcpServer: Runs the standard Azure Functions runtime with no MCP integration.
    //  - McpExtensionServer: Runs the Functions host with an embedded MCP server provided by the Azure Functions MCP extension.
    //  - SelfHostedMcpServer: Runs the Functions host in custom-handler mode, forwarding requests to a self-hosted MCP server process.
    "azureFunctions.mcpProjectType": "",

    // The timeout (in seconds) to be used when searching for the Azure Functions host process. Since a build is required every time you F5, you may need to adjust this based on how long your build takes.
    "azureFunctions.pickProcessTimeout": 60,

    // The name of the task to run after zip deployments.
    "azureFunctions.postDeployTask": "",

    // The name of the task to run before zip deployments.
    "azureFunctions.preDeployTask": "",

    // The default language to use when performing operations like "Create New Function".
    //  - C#
    //  - F#
    //  - C#Script: (Preview)
    //  - F#Script: (Preview)
    //  - Java
    //  - JavaScript
    //  - PowerShell
    //  - Python
    //  - TypeScript
    //  - Custom
    //  - undefined
    "azureFunctions.projectLanguage": "",

    // The default language model to use when performing operations like "Create New Function".
    "azureFunctions.projectLanguageModel": 0,

    // The behavior to use after creating a new project. The options are "AddToWorkspace", "OpenInNewWindow", or "OpenInCurrentWindow".
    "azureFunctions.projectOpenBehavior": "",

    // The default version of the Azure Functions runtime to use when performing operations like "Create New Function".
    //  - ~1: Azure Functions v1
    //  - ~2: Azure Functions v2
    //  - ~3: Azure Functions v3
    //  - ~4: Azure Functions v4
    "azureFunctions.projectRuntime": "",

    // The default subpath of a workspace folder to use for project operations. This is only necessary if you have multiple projects in one workspace. See https://aka.ms/AA4nmfy for more information.
    "azureFunctions.projectSubpath": "",

    // A key used to identify which templates to use for this project. In most cases, this will be automatically detected and should not need to be set.
    "azureFunctions.projectTemplateKey": "",

    // The name of the Python virtual environment used for your project. A virtual environment is required to debug and deploy Python functions.
    "azureFunctions.pythonVenv": "",

    // The timeout (in seconds) to be used when making requests, for example getting the latest templates.
    "azureFunctions.requestTimeout": 15,

    // Set to true to build your project on the server. Currently only applicable for Linux Function Apps.
    "azureFunctions.scmDoBuildDuringDeployment": false,

    // Show a warning to install a 64-bit version of the Azure Functions Core Tools when you create a .NET Framework project.
    "azureFunctions.show64BitWarning": true,

    // Show the option to create a Ballerina Function projects when creating a new Function project.
    "azureFunctions.showBallerinaProjectCreation": false,

    // Show a warning if your installed version of Azure Functions Core Tools is out-of-date.
    "azureFunctions.showCoreToolsWarning": true,

    // Ask for confirmation before deploying to a Function App in Azure (deploying will overwrite any previous deployment and cannot be undone).
    "azureFunctions.showDeployConfirmation": true,

    // Show a warning when the "deploySubpath" setting does not match the selected folder for deploying.
    "azureFunctions.showDeploySubpathWarning": true,

    // Show deprecated runtime stacks when creating a Function App in Azure. WARNING: These stacks may be removed at any time and may not be available in all regions.
    "azureFunctions.showDeprecatedStacks": false,

    // Show a warning when an Azure Functions project was detected that has mismatched "extensions.csproj" configuration.
    "azureFunctions.showExtensionsCsprojWarning": true,

    // Show a warning when deploying a Azure Blob Storage Trigger (using Event Grid) to a Flex Consumption Function App.
    "azureFunctions.showFlexEventGridWarning": true,

    // Show hidden runtime stacks when creating a Function App in Azure. WARNING: These stacks may be in preview or may not be available in all regions.
    "azureFunctions.showHiddenStacks": false,

    // Enables showing the markdown preview after creating a new PythonV2 template
    "azureFunctions.showMarkdownPreview": true,

    // Show a warning if multiple installs of Azure Functions Core Tools are detected.
    "azureFunctions.showMultiCoreToolsWarning": true,

    // Show a warning when an Azure Functions project was detected that has not been initialized for use in VS Code.
    "azureFunctions.showProjectWarning": true,

    // Show a warning when an Azure Functions Python project was detected that does not have a virtual environment.
    "azureFunctions.showPythonVenvWarning": true,

    // Show an option to reload templates when creating a function. This will clear the template cache.
    "azureFunctions.showReloadTemplates": false,

    // Show a warning when an Azure Functions .NET project was detected that has mismatched target frameworks.
    "azureFunctions.showTargetFrameworkWarning": true,

    // Automatically stop the task running the Azure Functions host when a debug sessions ends.
    "azureFunctions.stopFuncTaskPostDebug": true,

    // Set to true if this should not be recognized as an Azure Functions project and you want to hide related functionality.
    "azureFunctions.suppressProject": false,

    // Specify the templates to display when creating a new function. The supported values are 'Verified', 'Core', and 'All'. The 'Verified' category is a subset of 'Core' that has been verified to work with the latest VS Code extension.
    "azureFunctions.templateFilter": "Verified",

    // For development purposes only. You must reload your VS Code window for this to take effect.
    //  - : Default behavior using the best source available.
    //  - Staging: Use the very latest templates from the staging template source.
    //  - Backup: Use backup templates included in the extension's vsix. These may not have the latest updates.
    "azureFunctions.templateSource": "",

    // A runtime release version (any runtime) that species which templates will be used rather than the latest templates.  This version will be used for ALL runtimes. (Requires a restart of VS Code to take effect)
    "azureFunctions.templateVersion": "",

    // Validate the Azure Functions Core Tools is installed before debugging.
    "azureFunctions.validateFuncCoreTools": true,

    // Azure
    // Open the Azure Activity panel when an Activity starts
    "azureResourceGroups.autoOpenActivityPanel": true,

    // The behavior to use when confirming delete of a resource group.
    //  - EnterName: Prompts with an input box where you enter the resource group name to delete.
    //  - ClickButton: Prompts with a warning dialog where you click a button to delete.
    "azureResourceGroups.deleteConfirmation": "EnterName",

    // Enable the @azure chat stand-in
    "azureResourceGroups.enableChatStandIn": false,

    // Prepends each line displayed in the output channel with a timestamp.
    "azureResourceGroups.enableOutputTimestamps": true,

    // The setting to control how Azure resources are grouped in the tree view
    "azureResourceGroups.groupBy": "resourceType",

    // Selected Subscriptions
    "azureResourceGroups.selectedSubscriptions": [],

    // Show some ancillary resources that are created/managed by Azure infrastructure. Displaying them is typically useful when you want to clean up your resource groups or subscriptions.
    "azureResourceGroups.showHiddenTypes": false,

    // Suppress Activity notifications
    "azureResourceGroups.suppressActivityNotifications": true,

    // Bicep
    // When completing 'br:' module references, query Azure for all container registries accessible to the user (may be slow). If this option is off, only registries configured under moduleAliases in bicepconfig.json will be listed.
    "bicep.completions.getAllAccessibleAzureContainerRegistries": false,

    // Automatically convert pasted JSON values, JSON ARM templates or resources from a JSON ARM template into Bicep (use Undo to revert)
    "bicep.decompileOnPaste": true,

    // Prepend each line displayed in the Bicep Operations output channel with a timestamp.
    "bicep.enableOutputTimestamps": true,

    // Enable occasional surveys to collect feedback that helps us improve the Bicep extension.
    "bicep.enableSurveys": true,

    // Warnings that are being suppressed because a 'Don't show again' button was pressed. Remove items to reset.
    "bicep.suppressedWarnings": [],

    // Configure tracing of messages sent to the Bicep language server.
    "bicep.trace.server": "Off",

    // Container Tools
    // Command templates for container attach commands.
    "containers.commands.attach": "${containerCommand} exec -it ${containerId} ${shellCommand}",

    // Command template(s) for container build commands.
    "containers.commands.build": "${containerCommand} build --pull --rm -f \"${dockerfile}\" -t ${tag} \"${context}\"",

    // Command templates for compose down commands.
    "containers.commands.composeDown": [
        {
            "label": "Compose Down",
            "template": "${composeCommand} ${configurationFile} down"
        }
    ],

    // Command templates for compose down (subset) commands.
    "containers.commands.composeDownSubset": [
        {
            "label": "Compose Down",
            "template": "${composeCommand} ${profileList} ${configurationFile} down ${serviceList}"
        }
    ],

    // Command templates for compose up commands.
    "containers.commands.composeUp": [
        {
            "label": "Compose Up",
            "template": "${composeCommand} ${configurationFile} up ${detached} ${build}"
        }
    ],

    // Command templates for compose up (subset) commands.
    "containers.commands.composeUpSubset": [
        {
            "label": "Compose Up",
            "template": "${composeCommand} ${profileList} ${configurationFile} up ${detached} ${build} ${serviceList}"
        }
    ],

    // Command templates for container logs commands.
    "containers.commands.logs": "${containerCommand} logs --tail 1000 -f ${containerId}",

    // Command templates for container run commands.
    "containers.commands.run": "${containerCommand} run --rm -d ${exposedPorts} ${tag}",

    // Command templates for container run (interactive) commands.
    "containers.commands.runInteractive": "${containerCommand} run --rm -it ${exposedPorts} ${tag}",

    // Set to true to include --build option when compose command is invoked
    "containers.composeBuild": true,

    // Command to use for compose actions (e.g. `docker-compose`, `docker compose`, etc. command). If the executable path contains whitespace, it needs to be quoted appropriately. If unset, the extension will attempt to auto-detect the command to use.
    "containers.composeCommand": "",

    // Set to true to include --d (detached) option when compose command is invoked
    "containers.composeDetached": true,

    // Which container client to use. If not specified, Docker will be used. Changing requires a restart to take effect.
    "containers.containerClient": "",

    // Command to use for container actions (e.g. `docker` command). If the executable path contains whitespace, it needs to be quoted appropriately. If unset, the extension will attempt to auto-detect the command to use.
    "containers.containerCommand": "",

    // Any secondary properties to display for a container (an array). Possible elements include: ContainerId, ContainerName, CreatedTime, FullTag, ImageId, Networks, Ports, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, State, Status, and Tag
    "containers.containers.description": [
        "ContainerName",
        "Status"
    ],

    // The property to use to group containers in Containers view: ContainerId, ContainerName, CreatedTime, FullTag, ImageId, Networks, Ports, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, State, Status, Tag, or None
    "containers.containers.groupBy": "Compose Project Name",

    // The items will be grouped by the value of this container label (e.g. `com.microsoft.created-by`)
    "containers.containers.groupByLabel": "",

    // The primary property to display for a container: ContainerId, ContainerName, CreatedTime, FullTag, ImageId, Networks, Ports, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, State, Status, or Tag
    "containers.containers.label": "FullTag",

    // The property to use to sort containers in the Containers view: CreatedTime or Label
    "containers.containers.sortBy": "CreatedTime",

    // Any secondary properties to display for a Docker context (an array). Possible elements include: Name, Description and DockerEndpoint
    "containers.contexts.description": [
        "Description"
    ],

    // The primary property to display for a Docker context: Name, Description or DockerEndpoint
    "containers.contexts.label": "Name",

    // Show current Docker context in the status bar
    "containers.contexts.showInStatusBar": false,

    // Whether or not to enable the Compose Language Service. Changing requires a restart to take effect.
    "containers.enableComposeLanguageService": true,

    // Environment variables that will be applied to all VS Code terminals and to all background processes started by the Container Tools extension. Use for variables like `DOCKER_HOST`, etc.
    "containers.environment": {},

    // Build context PATH to pass to container build command.
    "containers.imageBuildContextPath": "",

    // Check for outdated base images once per Visual Studio Code session
    "containers.images.checkForOutdatedImages": true,

    // Any secondary properties to display for a container image (an array). Possible elements include: CreatedTime, FullTag, ImageId, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, Tag, and Size
    "containers.images.description": [
        "CreatedTime"
    ],

    // The property to use to group images in Container Images view: CreatedTime, FullTag, ImageId, None, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, or Tag
    "containers.images.groupBy": "Repository",

    // The primary property to display for a image: CreatedTime, FullTag, ImageId, Registry, RegistryAndPath, Repository, RepositoryName, RepositoryNameShort, RepositoryNameAndTag, Tag, or Size
    "containers.images.label": "Tag",

    // The property to use to sort images in Container Images view: CreatedTime, Label, or Size
    "containers.images.sortBy": "CreatedTime",

    // Any secondary properties to display for a container network (an array). Possible elements include CreatedTime, NetworkDriver, NetworkId, and NetworkName
    "containers.networks.description": [
        "NetworkDriver",
        "CreatedTime"
    ],

    // The property to use to group networks in Container Networks view: CreatedTime, NetworkDriver, NetworkId, NetworkName, or None
    "containers.networks.groupBy": "None",

    // The primary property to display for a container network: CreatedTime, NetworkDriver, NetworkId, or NetworkName
    "containers.networks.label": "NetworkName",

    // Show the built-in networks in the explorer.
    "containers.networks.showBuiltInNetworks": true,

    // The property to use to sort networks in Container Networks view: CreatedTime or Label
    "containers.networks.sortBy": "CreatedTime",

    // Which container orchestrator client to use. If not specified, Docker Compose will be used. Changing requires a restart to take effect.
    "containers.orchestratorClient": "",

    // Prompt for registry selection if the image is not explicitly tagged.
    "containers.promptForRegistryWhenPushingImages": true,

    // The path to use for scaffolding templates.
    "containers.scaffolding.templatePath": "",

    // Set to true to prompt to switch from "UI" extension mode to "Workspace" extension mode if an operation is not supported in UI mode.
    "containers.showRemoteWorkspaceWarning": true,

    // Set to true to truncate long image and container registry paths in Container Images view
    "containers.truncateLongRegistryPaths": false,

    // Maximum length of a registry paths displayed in Container Images view, including ellipsis. The truncateLongRegistryPaths setting must be set to true for truncateMaxLength setting to be effective.
    "containers.truncateMaxLength": 10,

    // Any secondary properties to display for a container volume (an array). Possible values include CreatedTime and VolumeName
    "containers.volumes.description": [
        "CreatedTime"
    ],

    // The property to use to group volumes in Container Volumes view: CreatedTime, VolumeName, or None
    "containers.volumes.groupBy": "None",

    // The primary property to display for a container volume: CreatedTime or VolumeName
    "containers.volumes.label": "VolumeName",

    // The property to use to sort volumes in the Container Volumes view: CreatedTime or Label
    "containers.volumes.sortBy": "CreatedTime",

    // Controls the diagnostic severity for the deprecated MAINTAINER instruction
    "docker.languageserver.diagnostics.deprecatedMaintainer": "warning",

    // Controls the diagnostic severity for parser directives that are not written in lowercase
    "docker.languageserver.diagnostics.directiveCasing": "warning",

    // Controls the diagnostic severity for flagging empty continuation lines found in instructions that span multiple lines
    "docker.languageserver.diagnostics.emptyContinuationLine": "warning",

    // Controls the diagnostic severity for instructions that are not written in uppercase
    "docker.languageserver.diagnostics.instructionCasing": "warning",

    // Controls the diagnostic severity for flagging a Dockerfile with multiple CMD instructions
    "docker.languageserver.diagnostics.instructionCmdMultiple": "warning",

    // Controls the diagnostic severity for flagging a Dockerfile with multiple ENTRYPOINT instructions
    "docker.languageserver.diagnostics.instructionEntrypointMultiple": "warning",

    // Controls the diagnostic severity for flagging a Dockerfile with multiple HEALTHCHECK instructions
    "docker.languageserver.diagnostics.instructionHealthcheckMultiple": "warning",

    // Controls the diagnostic severity for JSON instructions that are written incorrectly with single quotes
    "docker.languageserver.diagnostics.instructionJSONInSingleQuotes": "warning",

    // Controls the diagnostic severity for WORKDIR instructions that do not point to an absolute path
    "docker.languageserver.diagnostics.instructionWorkdirRelative": "warning",

    // Controls whether the Dockerfile formatter should ignore instructions that span multiple lines when formatting
    "docker.languageserver.formatter.ignoreMultilineInstructions": false,

    // .NET Install Tool
    // If you'd like to continue using a .NET path that is not meant to be used for an extension and may cause instability (please read above about the existingDotnetPath setting) then set this to true and restart.
    "dotnetAcquisitionExtension.allowInvalidPaths": false,

    // To improve performance, the results of checking .NET Installations may be cached. If you're facing issues with an install not being detected, try setting this to 0.5, or 0; or increasing the number to improve performance. Restart to change.
    "dotnetAcquisitionExtension.cacheTimeToLiveMultiplier": 1,

    // Enable Preview Features for the Extension. Restart VS Code to apply changes.
    "dotnetAcquisitionExtension.enablePreviewFeatures": false,

    // Enable Telemetry for the .NET Install Tool. Restart VS Code to apply changes.
    "dotnetAcquisitionExtension.enableTelemetry": true,

    // The path to an existing .NET host executable for an extension's code to run under, not for your project to run under.
    // Restart VS Code to apply changes.
    // 
    // ⚠️ This is NOT the .NET Runtime that your project will use to run. Extensions such as `C#`, `C# DevKit`, and more have components written in .NET. This .NET PATH is the `dotnet.exe` that these extensions will use to run their code, not your code.
    // 
    // Using a path value in which .NET does not meet the requirements of a specific extension will cause that extension to fail.
    // 
    // 🚀 The version of .NET that is used for your project is determined by the .NET host, or dotnet.exe. The .NET host picks a runtime based on your project. To use a specific version of .NET for your project, install the .NET SDK using the `.NET Install Tool - Install SDK System-Wide` command, install .NET manually using [our instructions](https://dotnet.microsoft.com/download), or edit your PATH environment variable to point to a `dotnet.exe` that has an `/sdk/` folder with only one SDK.
    "dotnetAcquisitionExtension.existingDotnetPath": [],

    // Enable this to show more detailed output from our extension.
    "dotnetAcquisitionExtension.highVerbosity": false,

    // Timeout for installing .NET in seconds.
    "dotnetAcquisitionExtension.installTimeoutValue": 600,

    // URL to a proxy if you use one, such as: https://proxy:port
    "dotnetAcquisitionExtension.proxyUrl": "",

    // The path of the preexisting .NET Runtime you'd like to use for ALL extensions. Restart VS Code to apply changes.
    "dotnetAcquisitionExtension.sharedExistingDotnetPath": "",

    // Show the command to reset extension data in the command palette. Restart VS Code and remove dependent extensions first.
    "dotnetAcquisitionExtension.showResetDataCommand": false,

    // Hide all messages in the output window from our extension. Error pop-ups from APIs that other extensions request we display will still appear.
    "dotnetAcquisitionExtension.suppressOutput": false,

    // Microsoft Edge Tools
    // Launch Microsoft Edge with specified args. (requires relaunching Visual Studio Code)
    "vscode-edge-devtools.browserArgs": [],

    // 
    //  - Default: Microsoft Edge Tools for VS Code will try to open the Microsoft Edge flavors in the following order: Stable, Beta, Dev and Canary
    //  - Stable: Microsoft Edge Tools for VS Code will use Microsoft Edge Stable version
    //  - Beta: Microsoft Edge Tools for VS Code will use Microsoft Edge Beta version
    //  - Dev: Microsoft Edge Tools for VS Code will use Microsoft Edge Dev version
    //  - Canary: Microsoft Edge Tools for VS Code will use Microsoft Edge Canary version
    "vscode-edge-devtools.browserFlavor": "",

    // The default entrypoint into your webpage. Used to resolve debugging urls without a pathname
    "vscode-edge-devtools.defaultEntrypoint": "index.html",

    // The default url to open when launching the browser without a target
    "vscode-edge-devtools.defaultUrl": "",

    // Launch Microsoft Edge in headless mode. (requires relaunching Visual Studio Code)
    "vscode-edge-devtools.headless": true,

    // The hostname on which to search for remote debuggable instances
    "vscode-edge-devtools.hostname": "localhost",

    // A set of mappings for rewriting the locations of source files from what the sourcemap says, to their locations on disk
    "vscode-edge-devtools.pathMapping": {
        "/": "${workspaceFolder}"
    },

    // The port on which to search for remote debuggable instances
    "vscode-edge-devtools.port": 9222,

    // Show service and shared workers in the target list.
    "vscode-edge-devtools.showWorkers": false,

    // A set of mappings to override the locations of source map files.
    "vscode-edge-devtools.sourceMapPathOverrides": {
        "webpack:///./*": "${webRoot}/*",
        "webpack:///src/*": "${webRoot}/*",
        "webpack:///*": "*",
        "webpack:///./~/*": "${webRoot}/node_modules/*",
        "webpack://*": "${webRoot}/*",
        "meteor://💻app/*": "${webRoot}/*"
    },

    // Use JavaScript source maps (if they exist)
    "vscode-edge-devtools.sourceMaps": true,

    // The number of milliseconds that the Microsoft Edge Tools will keep trying to attach the browser before timing out
    "vscode-edge-devtools.timeout": 10000,

    // Should we request the remote target list using https rather than http
    "vscode-edge-devtools.useHttps": false,

    // By default, Microsoft Edge is launched with a separate user profile in a temp folder. Use this option to override the path. You can also set to false to launch with your default user profile instead.
    "vscode-edge-devtools.userDataDir": true,

    // Enable feedback from webhint on source files to improve accessibility, compatibility, security and more.
    "vscode-edge-devtools.webhint": true,

    // Turn off notification for webhint installation failures.
    "vscode-edge-devtools.webhintInstallNotification": false,

    // The absolute path to the webserver root. Used to resolve paths like `/app.js` to files on disk
    "vscode-edge-devtools.webRoot": "${workspaceFolder}",

    // Azure configuration
    // (Deprecated) The authentication library to use. Note: You must sign out and reload the window after modifying this setting for it to take effect.
    //  - ADAL: Azure Active Directory Authentication Library
    //  - MSAL: Microsoft Authentication Library (Preview)
    "azure.authenticationLibrary": "ADAL",

    // Whether to show the Azure Account status bar item. For use with extensions that aren't updated to use the new built in authentication APIs.
    "azure.azure-account.showStatusBar": false,

    // (Deprecated) The current Azure Cloud to connect to. Note: You must sign out and sign back in after modifying this setting for it to take effect.
    //  - AzureCloud: Azure
    //  - AzureChinaCloud: Azure China
    //  - AzureGermanCloud: Azure Germany
    //  - AzureUSGovernment: Azure US Government
    //  - AzureCustomCloud: Azure Custom Cloud
    "azure.cloud": "AzureCloud",

    // (Deprecated) The management endpoint for your Azure Custom Cloud environment.
    "azure.customCloud.resourceManagerEndpointUrl": "",

    // (Deprecated) Development setting: The PPE environment for testing.
    "azure.ppe": null,

    // (Deprecated) The resource filter, each element is a tenant id and a subscription id separated by a slash.
    "azure.resourceFilter": null,

    // (Deprecated) Whether to show the email address (e.g., in the status bar) of the signed in account.
    "azure.showSignedInEmail": true,

    // (Deprecated) A specific tenant to sign in to. The default is to sign in to the common tenant and use all known tenants. Note: You must sign out and sign back in after modifying this setting for it to take effect.
    "azure.tenant": "",

    // Azure CLI Tools Configuration
    // Override the default continuation character (backtick [`] on Windows otherwise backslash [\]) used for multiline commands
    "azureCLI.lineContinuationCharacter": "",

    // Controls whether showing the result from running an Azure CLI command in an editor should always create a new editor.
    "azureCLI.showResultInNewEditor": false,

    // Live Preview
    // How often to automatically refresh the preview.
    "livePreview.autoRefreshPreview": "On All Changes in Editor",

    // The browser you want to launch when previewing a file in an external browser. Only works for normal preview (non-debug) and only works on desktop.
    "livePreview.customExternalBrowser": "Default",

    // Whether or not to attach the JavaScript debugger on external preview launches.
    "livePreview.debugOnExternalPreview": false,

    // The file to automatically show upon starting the server. Leave blank to open at the index.
    "livePreview.defaultPreviewPath": "",

    // The local IP host address to host your files on.
    "livePreview.hostIP": "127.0.0.1",

    // The extra HTTP headers that should be set in the server's HTTP responses.
    "livePreview.httpHeaders": {
        "Accept-Ranges": "bytes"
    },

    // Whether to notify the user when opening a preview for a file that is not part of the currently opened workspace (or the workspace where the server is hosted).
    "livePreview.notifyOnOpenLooseFile": true,

    // The preferred target for previews.
    "livePreview.openPreviewTarget": "Embedded Preview",

    // Which local port the live preview's server should try initially. If this port number doesn't work, it will increment the port number until it finds a free port.
    "livePreview.portNumber": 3000,

    // How many milliseconds delay to use when debouncing the preview update.
    "livePreview.previewDebounceDelay": 50,

    // How many minutes after closing the embedded preview you want the server to shut off. Set to 0 to have server stay on indefinetely.
    "livePreview.serverKeepAliveAfterEmbeddedPreviewClose": 3,

    // The relative path from the workspace root that the files are served from. Files will be previewed as if the workspace root is at this relative path. If this directory path doesn't exist in your workspace, it will default to the workspace root. This setting only applies if you have a workspace open.
    "livePreview.serverRoot": "",

    // Whether or not to show information messages on server on/off status change.
    "livePreview.showServerStatusNotifications": false,

    // Whether or not to pair external preview instances with the auto-generated server task. When disabled, the server will also not automatically close (until the window is closed).
    "livePreview.tasks.runTaskWithExternalPreview": false,

    // Interface
    // Specifies to search for references only within open documents instead of all workspace files. An alternative to `powershell.enableReferencesCodeLens` that allows large workspaces to support some references without the performance impact.
    "powershell.analyzeOpenDocumentsOnly": false,

    // **Deprecated:** This setting was never meant to be changed!
    // **Deprecated:** Specifies the URL of the GitHub project in which to generate bug reports.
    "powershell.bugReporting.project": "https://github.com/PowerShell/vscode-powershell",

    // Show buttons in the editor's title bar for moving the terminals pane (with the PowerShell Extension Terminal) around.
    "powershell.buttons.showPanelMovementButtons": false,

    // Show the `Run` and `Run Selection` buttons in the editor's title bar.
    "powershell.buttons.showRunButtons": true,

    // Enables syntax based code folding. When disabled, the default indentation based code folding is used.
    "powershell.codeFolding.enable": true,

    // Shows the last line of a folded section similar to the default VS Code folding style. When disabled, the entire folded region is hidden.
    "powershell.codeFolding.showLastLine": true,

    // Adds a space before and after the pipeline operator (`|`) if it is missing.
    "powershell.codeFormatting.addWhitespaceAroundPipe": true,

    // Align assignment statements in a hashtable or a DSC Configuration.
    "powershell.codeFormatting.alignPropertyValuePairs": true,

    // Replaces aliases with their aliased name.
    "powershell.codeFormatting.autoCorrectAliases": false,

    // Removes redundant semicolon(s) at the end of a line where a line terminator is sufficient.
    "powershell.codeFormatting.avoidSemicolonsAsLineTerminators": false,

    // Does not reformat one-line code blocks, such as: `if (...) {...} else {...}`.
    "powershell.codeFormatting.ignoreOneLineBlock": true,

    // Adds a newline (line break) after a closing brace.
    "powershell.codeFormatting.newLineAfterCloseBrace": true,

    // Adds a newline (line break) after an open brace.
    "powershell.codeFormatting.newLineAfterOpenBrace": true,

    // Places open brace on the same line as its associated statement.
    "powershell.codeFormatting.openBraceOnSameLine": true,

    // Whether to increase indentation after a pipeline for multi-line statements. See [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer/blob/a94d9f5666bba9f569cdf9c1bc99556934f2b8f4/docs/Rules/UseConsistentIndentation.md#pipelineindentation-string-default-value-is-increaseindentationforfirstpipeline) for examples. It is suggested to use `IncreaseIndentationForFirstPipeline` instead of the default `NoIndentation`. **This default may change in the future,** please see the [Request For Comment](https://github.com/PowerShell/vscode-powershell/issues/4296).
    //  - IncreaseIndentationForFirstPipeline: Indent once after the first pipeline and keep this indentation.
    //  - IncreaseIndentationAfterEveryPipeline: Indent more after the first pipeline and keep this indentation.
    //  - NoIndentation: Do not increase indentation.
    //  - None: Do not change any existing pipeline indentation (disables feature).
    "powershell.codeFormatting.pipelineIndentationStyle": "NoIndentation",

    // Sets the code formatting options to follow the given indent style in a way that is compatible with PowerShell syntax. Any setting other than `Custom` will configure (and override) the settings:
    // 
    // * `powershell.codeFormatting.openBraceOnSameLine`
    // 
    // * `powershell.codeFormatting.newLineAfterOpenBrace`
    // 
    // * `powershell.codeFormatting.newLineAfterCloseBrace`
    // 
    // For more information about the brace styles, please see [PoshCode's discussion](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81).
    //  - Custom: The three brace settings are respected as-is.
    //  - Allman: Sets `powershell.codeFormatting.openBraceOnSameLine#` to `false`, `#powershell.codeFormatting.newLineAfterOpenBrace#` to `true`, and `#powershell.codeFormatting.newLineAfterCloseBrace` to `true`.
    //  - OTBS: Sets `powershell.codeFormatting.openBraceOnSameLine#` to `true`, `#powershell.codeFormatting.newLineAfterOpenBrace#` to `true`, and `#powershell.codeFormatting.newLineAfterCloseBrace` to `false`.
    //  - Stroustrup: Sets `powershell.codeFormatting.openBraceOnSameLine#` to `true`, `#powershell.codeFormatting.newLineAfterOpenBrace#` to `true`, and `#powershell.codeFormatting.newLineAfterCloseBrace` to `true`.
    "powershell.codeFormatting.preset": "Custom",

    // Trims extraneous whitespace (more than one character) before and after the pipeline operator (`|`).
    "powershell.codeFormatting.trimWhitespaceAroundPipe": false,

    // Use single quotes if a string is not interpolated and its value does not contain a single quote.
    "powershell.codeFormatting.useConstantStrings": false,

    // Use correct casing for cmdlets.
    "powershell.codeFormatting.useCorrectCasing": false,

    // Adds a space after a separator (`,` and `;`).
    "powershell.codeFormatting.whitespaceAfterSeparator": true,

    // Adds spaces before and after an operator (`=`, `+`, `-`, etc.).
    "powershell.codeFormatting.whitespaceAroundOperator": true,

    // **Deprecated:** Please use the `powershell.codeFormatting.addWhitespaceAroundPipe` setting instead. If you've used this setting before, we have moved it for you automatically.
    // **Deprecated:** Please use the `powershell.codeFormatting.addWhitespaceAroundPipe` setting instead. If you've used this setting before, we have moved it for you automatically.
    "powershell.codeFormatting.whitespaceAroundPipe": true,

    // Adds a space between a keyword and its associated script-block expression.
    "powershell.codeFormatting.whitespaceBeforeOpenBrace": true,

    // Adds a space between a keyword (`if`, `elseif`, `while`, `switch`, etc.) and its associated conditional expression.
    "powershell.codeFormatting.whitespaceBeforeOpenParen": true,

    // Removes redundant whitespace between parameters.
    "powershell.codeFormatting.whitespaceBetweenParameters": false,

    // Adds a space after an opening brace (`{`) and before a closing brace (`}`).
    "powershell.codeFormatting.whitespaceInsideBrace": true,

    // A path where the Extension Terminal will be launched. Both the PowerShell process's and the shell's location will be set to this directory. Does not support variables, but does support the use of '~' and paths relative to a single workspace. **For multi-root workspaces, use the name of the folder you wish to have as the cwd.**
    "powershell.cwd": "",

    // Creates a temporary PowerShell Extension Terminal for each debugging session. This is useful for debugging PowerShell classes and binary modules.
    "powershell.debugging.createTemporaryIntegratedConsole": false,

    // Sets the operator used to launch scripts.
    //  - DotSource: Use the Dot-Source operator `.` to launch the script, for example, `. 'C:\Data\MyScript.ps1'`
    //  - Call: Use the Call operator `&` to launch the script, for example, `& 'C:\Data\MyScript.ps1'`
    "powershell.debugging.executeMode": "DotSource",

    // Specifies an alternative path to the folder containing modules that are bundled with the PowerShell extension, that is: PowerShell Editor Services, PSScriptAnalyzer and PSReadLine. **This setting is only meant for extension developers and requires the extension to be run in development mode!**
    "powershell.developer.bundledModulesPath": "../../PowerShellEditorServices/module",

    // Sets the log verbosity for both the extension and its LSP server, PowerShell Editor Services. **Please set to `Trace` when recording logs for a bug report!**
    //  - Trace: Enables all logging possible, please use this setting when submitting logs for bug reports!
    //  - Debug: Enables more detailed logging of the extension
    //  - Information: Logs high-level information about what the extension is doing.
    //  - Warning: Only log warnings and errors. This is the default setting
    //  - Error: Only log errors.
    //  - None: Disable all logging possible. No log files will be written!
    "powershell.developer.editorServicesLogLevel": "Warning",

    // Launches the LSP server with the `/waitForDebugger` flag to force it to wait for a .NET debugger to attach before proceeding, and emit its PID until then. **This setting is only meant for extension developers and requires the extension to be run in development mode!**
    "powershell.developer.editorServicesWaitForDebugger": false,

    // An array of strings that enable experimental features in the PowerShell extension. **No flags are currently available!**
    "powershell.developer.featureFlags": [],

    // On Windows we launch the PowerShell executable with `-ExecutionPolicy Bypass` so that the LSP server (PowerShell Editor Services module) will launch without issue. Some anti-virus programs disallow this command-line argument and this flag can be used to remove it. **Using this setting may require trusting the script manually in order for it to launch!**
    "powershell.developer.setExecutionPolicy": true,

    // Traces the DAP communication between VS Code and the PowerShell Editor Services [DAP Server](https://microsoft.github.io/debug-adapter-protocol/). The output will be logged and also visible in the Output pane, where the verbosity is configurable. **For extension developers and issue troubleshooting only!**
    "powershell.developer.traceDap": false,

    // Specifies how many seconds the extension will wait for the LSP server, PowerShell Editor Services, to connect. The default is four minutes; try increasing this value if your computer is particularly slow (often caused by overactive anti-malware programs).
    "powershell.developer.waitForSessionFileTimeoutSeconds": 240,

    // Specifies whether the extension loads [PowerShell profiles](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles). Note that the extension's "Current Host" profile is `Microsoft.VSCode_profile.ps1`, which will be loaded instead of the default "Current Host" profile of `Microsoft.PowerShell_profile.ps1`. Use the "All Hosts" profile `profile.ps1` for common configuration.
    "powershell.enableProfileLoading": true,

    // Specifies if Code Lenses are displayed above function definitions, used to show the number of times the function is referenced in the workspace and navigate to those references. Large workspaces may want to disable this setting if performance is compromised. See also `powershell.analyzeOpenDocumentsOnly`.
    "powershell.enableReferencesCodeLens": true,

    // Specifies the [comment based help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help) completion style triggered by typing ` ##`.
    //  - Disabled: Disables the feature.
    //  - BlockComment: Inserts a block style help comment, for example:
    // 
    // `<#`
    // 
    // `.<help keyword>`
    // 
    // `<help content>`
    // 
    // `#>`
    //  - LineComment: Inserts a line style help comment, for example:
    // 
    // `# .<help keyword>`
    // 
    // `# <help content>`
    "powershell.helpCompletion": "BlockComment",

    // Switches focus to the console when a script selection is run or a script file is debugged.
    "powershell.integratedConsole.focusConsoleOnExecute": true,

    // Use the VS Code API to clear the terminal since that's the only reliable way to clear the scrollback buffer. Turn this on if you're used to `Clear-Host` clearing scroll history. **This setting is not recommended and likely to be deprecated!**
    "powershell.integratedConsole.forceClearScrollbackBuffer": false,

    // Shows the Extension Terminal when the PowerShell extension is initialized. When disabled, the pane is not opened on startup, but the Extension Terminal is still created in order to power the extension's features.
    "powershell.integratedConsole.showOnStartup": true,

    // Starts the Extension Terminal in the background. **If this is enabled, to access the terminal you must run the [Show Extension Terminal command](command:PowerShell.ShowSessionConsole), and once shown it cannot be put back into the background.** This option completely hides the Extension Terminal from the terminals view. You are probably looking for the `powershell.integratedConsole.showOnStartup` option instead.
    "powershell.integratedConsole.startInBackground": false,

    // Sets the startup location for Extension Terminal.
    //  - Editor: Creates the Extension Terminal in Editor area
    //  - Panel: Creates the Extension Terminal in Panel area
    "powershell.integratedConsole.startLocation": "Panel",

    // Do not show the startup banner in the PowerShell Extension Terminal.
    "powershell.integratedConsole.suppressStartupBanner": false,

    // This will disable the use of PSReadLine in the PowerShell Extension Terminal and use a legacy implementation. **This setting is not recommended and likely to be deprecated!**
    "powershell.integratedConsole.useLegacyReadLine": false,

    // This setting controls the appearance of the `Run Tests` and `Debug Tests` CodeLenses that appears above Pester tests.
    "powershell.pester.codeLens": true,

    // Defines the verbosity of output to be used when debugging a test or a block. For Pester 5 and newer the default value `Diagnostic` will print additional information about discovery, skipped and filtered tests, mocking and more.
    "powershell.pester.debugOutputVerbosity": "Diagnostic",

    // Defines the verbosity of output to be used. For Pester 5 and newer the default value `FromPreference` will use the `Output` settings from the `$PesterPreference` defined in the caller's context, and will default to `Normal` if there is none. For Pester 4 the `FromPreference` and `Normal` options map to `All`, and `Minimal` option maps to `Fails`.
    "powershell.pester.outputVerbosity": "FromPreference",

    // Use a CodeLens that is compatible with Pester 4. Disabling this will show `Run Tests` on all `It`, `Describe` and `Context` blocks, and will correctly work only with Pester 5 and newer.
    "powershell.pester.useLegacyCodeLens": true,

    // Specifies a list of Item / Value pairs where the **Item** is a user-chosen name and the **Value** is an absolute path to a PowerShell executable. The name appears in the [Session Menu Command](command:PowerShell.ShowSessionMenu) and is used to reference this executable in the `powershell.powerShellDefaultVersion` setting.
    "powershell.powerShellAdditionalExePaths": {},

    // Specifies the default PowerShell version started by the extension. The name must match what is displayed in the [Session Menu command](command:PowerShell.ShowSessionMenu), for example, `Windows PowerShell (x86)`. You can specify additional PowerShell executables with the `powershell.powerShellAdditionalExePaths` setting.
    "powershell.powerShellDefaultVersion": "",

    // **Deprecated:** Please use the `powershell.powerShellAdditionalExePaths` setting instead.
    // **Deprecated:** Specifies the path to the PowerShell executable.
    "powershell.powerShellExePath": "",

    // **Deprecated:** This prompt has been removed as it's no longer strictly necessary to upgrade the `PackageManagement` module.
    // **Deprecated:** Specifies whether you should be prompted to update your version of `PackageManagement` if it's under 1.4.6.
    "powershell.promptToUpdatePackageManagement": false,

    // Specifies whether you may be prompted to update your version of PowerShell.
    "powershell.promptToUpdatePowerShell": true,

    // Enables real-time script analysis using [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) that populates the [Problems view](command:workbench.panel.markers.view.focus).
    "powershell.scriptAnalysis.enable": true,

    // Specifies the path to a [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) settings file. **This setting may not work as expected currently!**
    "powershell.scriptAnalysis.settingsPath": "PSScriptAnalyzerSettings.psd1",

    // Specifies an array of modules to exclude from Command Explorer listing.
    "powershell.sideBar.CommandExplorerExcludeFilter": [],

    // Specifies the visibility of the Command Explorer in the side bar.
    "powershell.sideBar.CommandExplorerVisibility": false,

    // Starts the PowerShell extension's underlying PowerShell process as a login shell, if applicable.
    "powershell.startAsLoginShell.linux": false,

    // Starts the PowerShell extension's underlying PowerShell process as a login shell, if applicable.
    "powershell.startAsLoginShell.osx": true,

    // Starts the PowerShell extension automatically when a PowerShell file is opened. If `false`, to start the extension use the [Restart Session command](command:PowerShell.RestartSession). **IntelliSense, code navigation, the Extension Terminal, code formatting, and other features are not enabled until the extension starts.**
    "powershell.startAutomatically": true,

    // Suppresses the warning message when any of `powershell.powerShellAdditionalExePaths` is not found.
    "powershell.suppressAdditionalExeNotFoundWarning": false,

    // Traces the communication between VS Code and the PowerShell Editor Services [LSP Server](https://microsoft.github.io/language-server-protocol/). The output will be logged and also visible in the Output pane, where the verbosity is configurable. **For extension developers and issue troubleshooting only!**
    "powershell.trace.server": "off",

    // **Deprecated:** This setting was removed when the PowerShell installation searcher was added. Please use the `powershell.powerShellAdditionalExePaths` setting instead.
    // **Deprecated:** Uses the 32-bit language service on 64-bit Windows. This setting has no effect on 32-bit Windows or on the PowerShell extension debugger, which has its own architecture configuration.
    "powershell.useX86Host": false,

    // Azure Resource Manager Tools
    // Enables auto-detection of deployment template files with the extension *.json or *.jsonc. If set to true (default), the editor language will automatically be set to Azure Resource Manager Template for any *.json/*.jsonc file which contains an appropriate Azure Resource Manager Template schema.
    "azureResourceManagerTools.autoDetectJsonTemplates": true,

    // Check if the schema for deployment templates is using an out-of-date version and suggest updating
    "azureResourceManagerTools.checkForLatestSchema": true,

    // Check if an opened template file has a matching params file and ask to use it
    "azureResourceManagerTools.checkForMatchingParameterFiles": true,

    // Enables or disables all Code Lens features
    "azureResourceManagerTools.codelens.enable": true,

    // Enables Code Lens for parameter definitions and values
    "azureResourceManagerTools.codelens.parameters": true,

    // Enables Code Lens that displays the parent and children of each resource
    "azureResourceManagerTools.codelens.resourceChildren": true,

    // (Requires restart) If specified, overrides the use of a local version of dotnet core the extension and instead points to another installed version of dotnet.exe (must match the version needed by the extension)
    "azureResourceManagerTools.languageServer.dotnetExePath": "",

    // Override the default location of the language server assembly folder or file path (requires restart)
    "azureResourceManagerTools.languageServer.path": "",

    // Sets the trace (log) level in the Output window for the Azure Template Language Server (requires restart)
    "azureResourceManagerTools.languageServer.traceLevel": "Warning",

    // If set to true, the language server process will wait in startup until a debugger is attached, and then will force a break (requires restart)
    "azureResourceManagerTools.languageServer.waitForDebugger": false,

    // Specifies which parameter file to use for each given template file. Specifying the parameter file allows more thorough validation.
    "azureResourceManagerTools.parameterFiles": {},

    // Indent-Rainbow configuration
    // If error color is disabled, indent colors will be rendered until the length of rendered characters (white spaces, tabs, and other ones) is divisible by tabsize. Turn on this option to render white spaces and tabs only.
    "indentRainbow.colorOnWhiteSpaceOnly": false,

    // An array with color (hex, rgba, rgb) strings which are used as colors, can be any length.
    "indentRainbow.colors": [
        "rgba(255,255,64,0.07)",
        "rgba(127,255,127,0.07)",
        "rgba(255,127,255,0.07)",
        "rgba(79,236,236,0.07)"
    ],

    // Indent color for when there is an error in the indentation, for example if you have your tabs set to 2 spaces but the indent is 3 spaces. Can be any type of web based color format (hex, rgba, rgb).
    "indentRainbow.errorColor": "rgba(128,32,32,0.6)",

    // For which languages indent-rainbow should be deactivated. When left empty will ignore.
    "indentRainbow.excludedLanguages": [
        "plaintext"
    ],

    // For which languages indent-rainbow should skip indent error detection (use '*' to deactivate errors for all languages).
    "indentRainbow.ignoreErrorLanguages": [
        "markdown"
    ],

    // Skip error highlighting for RegEx patterns. Defaults to c/cpp decorated block and full line comments.
    "indentRainbow.ignoreLinePatterns": [
        "/[ \t]* [*]/g",
        "/[ \t]+[/]{2}/g"
    ],

    // For which languages indent-rainbow should be activated. When empty will use for all languages.
    "indentRainbow.includedLanguages": [],

    // Automatically change indent settings for languages (see README.md for details).
    "indentRainbow.indentSetter": {},

    // Classic mode uses a full colored tab to indicate the indendation. Light mode will only display a colored border similar to the default indent guide lines. You can disable the default indicators with `editor.guides.indentation`.
    "indentRainbow.indicatorStyle": "classic",

    // This property defines the indent indicator lineWidth when using light mode.
    "indentRainbow.lightIndicatorStyleLineWidth": 1,

    // Indent color for when there is a mix between spaces and tabs in the indentation. Can be any type of web based color format (hex, rgba, rgb) or a empty string(to be disabled this coloring).
    "indentRainbow.tabmixColor": "rgba(128,32,96,0.6)",

    // The delay in ms until the editor gets updated.
    "indentRainbow.updateDelay": 100,

    // YAML
    // Enable usage data and errors to be sent to Red Hat servers. Read our [privacy statement](https://developers.redhat.com/article/tool-data-collection).
    "redhat.telemetry.enabled": null,

    // Enable/disable completion feature
    "yaml.completion": true,

    // Custom tags for the parser to use
    "yaml.customTags": [],

    // Globally set additionalProperties to false for all objects. So if its true, no extra properties are allowed inside yaml.
    "yaml.disableAdditionalProperties": false,

    // Disable adding not required properties with default values into completion text.
    "yaml.disableDefaultProperties": false,

    // Suggest additional extensions based on YAML usage.
    "yaml.extension.recommendations": "true",

    // Print spaces between brackets in objects
    "yaml.format.bracketSpacing": true,

    // Enable/disable default YAML formatter
    "yaml.format.enable": true,

    // Specify the line length that the printer will wrap on
    "yaml.format.printWidth": 80,

    // Always: wrap prose if it exceeds the print width, Never: never wrap the prose, Preserve: wrap prose as-is
    "yaml.format.proseWrap": "preserve",

    // Use single quotes instead of double quotes
    "yaml.format.singleQuote": false,

    // Specify if trailing commas should be used in JSON-like segments of the YAML
    "yaml.format.trailingComma": true,

    // Enable/disable hover feature
    "yaml.hover": true,

    // Enforces alphabetical ordering of keys in mappings when set to true
    "yaml.keyOrdering": false,

    // The maximum number of outline symbols and folding regions computed (limited for performance reasons).
    "yaml.maxItemsComputed": 5000,

    // Associate schemas to YAML files in the current workspace
    "yaml.schemas": {},

    // Automatically pull available YAML schemas from JSON Schema Store
    "yaml.schemaStore.enable": true,

    // URL of schema store catalog to use
    "yaml.schemaStore.url": "https://www.schemastore.org/api/json/catalog.json",

    // Forbid flow style mappings
    "yaml.style.flowMapping": "allow",

    // Forbid flow style sequences
    "yaml.style.flowSequence": "allow",

    // If true, the user must select some parent skeleton first before autocompletion starts to suggest the rest of the properties. When yaml object is not empty, autocompletion ignores this setting and returns all properties and skeletons
    "yaml.suggest.parentSkeletonSelectedFirst": false,

    // Traces the communication between VSCode and the YAML language service.
    "yaml.trace.server": "off",

    // Enable/disable validation feature
    "yaml.validate": true,

    // Default YAML spec version
    "yaml.yamlVersion": "1.2",

    // Markdown All in One
    // Use `**` or `__` to wrap bold text.
    "markdown.extension.bold.indicator": "**",

    // Whether to enable auto-completion.
    "markdown.extension.completion.enabled": false,

    // Whether to exclude files from auto-completion using VS Code's `search.exclude` setting. (`node_modules`, `bower_components` and `*.code-search` are **always excluded**, not affected by this option.)
    "markdown.extension.completion.respectVscodeSearchExclude": true,

    // The root folder for path auto-completion.
    "markdown.extension.completion.root": "",

    // List of extra supported languages (e.g., rmd, quarto), default [].
    "markdown.extension.extraLangIds": [],

    // Use `*` or `_` to wrap italic text.
    "markdown.extension.italic.indicator": "*",

    // User-defined KaTeX macros.
    "markdown.extension.katex.macros": {},

    // List indentation scheme. (Also affects TOC generation.)
    // 
    // Whether to use different indentation sizes on different list contexts or stick to VS Code's tab size.
    //  - adaptive: Adaptive indentation size according to the context, trying to **left align the sublist with its parent's content**. For example:
    // 
    // ```markdown
    // - Parent
    //   - Sublist
    // 
    // 1. Parent
    //    1. Sublist
    // 
    // 10. Parent with longer marker
    //     1. Sublist
    // ```
    //  - inherit: Use the configured tab size of the current document (see the status bar). For example (with `tabSize: 4`):
    // 
    // ```markdown
    // - Parent
    //     - Sublist
    // 
    // 1. Parent
    //     1. Sublist
    // 
    // 10. Parent with longer marker
    //     1. Sublist
    // ```
    "markdown.extension.list.indentationSize": "adaptive",

    // List candidate markers. It will cycle through those markers
    "markdown.extension.list.toggle.candidate-markers": [
        "-",
        "*",
        "+",
        "1.",
        "1)"
    ],

    // Enable basic math support (Powered by KaTeX).
    "markdown.extension.math.enabled": true,

    // Auto fix ordered list markers.
    "markdown.extension.orderedList.autoRenumber": true,

    // Ordered list marker.
    //  - one: Always use `1.` as ordered list marker.
    //  - ordered: Use increasing numbers as ordered list marker.
    "markdown.extension.orderedList.marker": "ordered",

    // Auto show preview to side.
    "markdown.extension.preview.autoShowPreviewToSide": false,

    // Convert image path to absolute path.
    "markdown.extension.print.absoluteImgPath": true,

    // Convert images to base64 when printing to HTML.
    "markdown.extension.print.imgToBase64": false,

    // Include VS Code's basic Markdown styles so that the exported HTML looks similar as inside VS Code.
    "markdown.extension.print.includeVscodeStylesheets": true,

    // Print current document to HTML when file is saved.
    "markdown.extension.print.onFileSave": false,

    // Print current document to pure HTML (without any stylesheets).
    "markdown.extension.print.pureHtml": false,

    // Theme of the exported HTML. Only affects code blocks.
    "markdown.extension.print.theme": "light",

    // Enable/disable URL validation when printing.
    "markdown.extension.print.validateUrls": true,

    // Show buttons (e.g. toggle bold, italic) on the editor toolbar.
    "markdown.extension.showActionButtons": false,

    // If a file is larger than this size (in byte/B), we won't attempt to render syntax decorations.
    "markdown.extension.syntax.decorationFileSizeLimit": 50000,

    // (**Deprecated**) Use `markdown.extension.theming.decoration.renderCodeSpan` instead. See <https://github.com/yzhang-gh/vscode-markdown/issues/888> for details.
    // 
    "markdown.extension.syntax.decorations": null,

    // (**Experimental**) Report issue at <https://github.com/yzhang-gh/vscode-markdown/issues/185>.
    "markdown.extension.syntax.plainTheme": false,

    // Don't add padding to the delimiter row.
    "markdown.extension.tableFormatter.delimiterRowNoPadding": false,

    // Enable [GitHub Flavored Markdown](https://github.github.com/gfm/) table formatter.
    "markdown.extension.tableFormatter.enabled": true,

    // Normalize table indentation to closest multiple of configured editor tab size.
    "markdown.extension.tableFormatter.normalizeIndentation": false,

    // Apply a border around a [code span](https://spec.commonmark.org/0.29/#code-spans).
    "markdown.extension.theming.decoration.renderCodeSpan": true,

    // (**Experimental**)
    "markdown.extension.theming.decoration.renderHardLineBreak": false,

    // (**Experimental**)
    "markdown.extension.theming.decoration.renderLink": false,

    // (**Experimental**)
    "markdown.extension.theming.decoration.renderParagraph": false,

    // Show a line through the middle of a [strikethrough](https://github.github.com/gfm/#strikethrough-extension-).
    "markdown.extension.theming.decoration.renderStrikethrough": true,

    // Shade the background of trailing space (U+0020) characters on a [line](https://spec.commonmark.org/0.29/#line).
    "markdown.extension.theming.decoration.renderTrailingSpace": false,

    // Range of levels for table of contents. Use `x..y` for level `x` to `y`.
    "markdown.extension.toc.levels": "1..6",

    // Lists of headings to omit by project file.
    // Example:
    // { "README.md": ["# Introduction"] }
    "markdown.extension.toc.omittedFromToc": {},

    // Use ordered list, that is:
    // 1. ...
    // 2. ...
    "markdown.extension.toc.orderedList": false,

    // Just plain text TOC, no links.
    "markdown.extension.toc.plaintext": false,

    // The method to generate heading ID. This affects **links to headings** in **TOC**, **code completion**, and **printing**.
    //  - github: GitHub
    //  - azureDevops: Azure DevOps
    //  - bitbucket-cloud: Bitbucket Cloud
    //  - gitea: Gitea
    //  - gitlab: GitLab
    //  - vscode: Visual Studio Code
    //  - zola: Zola
    "markdown.extension.toc.slugifyMode": "github",

    // Use `-`, `*`, or `+` in the table of contents (for **unordered** list).
    "markdown.extension.toc.unorderedList.marker": "-",

    // Auto update TOC on save.
    "markdown.extension.toc.updateOnSave": true,

    // npm-intellisense
    // For import command. The declaration type used for require()
    "npm-intellisense.importDeclarationType": "const",

    // For import command. Use import statements instead of require()
    "npm-intellisense.importES6": true,

    // For import command. The linebreak used after the snippet
    "npm-intellisense.importLinebreak": ";\r\n",

    // For import command. The type of quotes to use in the snippet
    "npm-intellisense.importQuotes": "'",

    // (experimental) Enables path intellisense in subfolders of modules
    "npm-intellisense.packageSubfoldersIntellisense": false,

    // Look for package.json inside nearest directory instead of workspace root
    "npm-intellisense.recursivePackageJsonLookup": true,

    // Scans devDependencies as well
    "npm-intellisense.scanDevDependencies": false,

    // shows build in node modules like 'path' of 'fs'
    "npm-intellisense.showBuildInLibs": false,

    // Azure Developer CLI
    // Use the VS Code integrated authentication with the Azure Developer CLI, instead of its own authentication. Note: This feature is currently in alpha and active under development, and requires a version of the Azure Development CLI that supports it.
    "azure-dev.auth.useIntegratedAuth": false,

    // Maximum number of Azure Developer CLI apps to display in the Workspace Resource view
    "azure-dev.maximumAppsToDisplay": 5,

    // GitHub Copilot for Azure
    // The ID of the directory (tenant) @azure should use when querying Azure Resource Graph, or looking for/working with resources. If the value is empty or an invalid ID, then one of your home directories will be used.
    "@azure.argTenant": "",

    // Enable deploying LLMs and other models to Azure OpenAI resources. Requires an Azure subscription ID, OpenAI resource name, specific model you intend to deploy and optionally model name you intend to deploy.
    "@azure.deployModel": true,

    // Enable automatically setting the Azure related rules to the GitHub Copilot instructions for better LLM tool results.
    "@azure.enableAutoSetAzureRules": true,

    // Enable searching for Azure Verified Modules when generating Bicep templates. When enabled, @azure will search for and suggest Azure Verified Modules that match your resource type.
    "@azure.enableAzureVerifiedModuleSearch": true,

    // Recommend custom chat modes based on topic and codebase analysis.
    "@azure.enableCustomModeRecommendations": true,

    // The type of query to use when searching for MS Learn documentation.
    "@azure.msLearnQueryType": "hybrid",

    // Azure MCP
    // Service namespaces to enable. Leave empty to enable all. Choose from the list to avoid typing errors. **Note:** Changes require restarting the MCP server if MCP Autostart is not configured (Command Palette → MCP: List Servers → Azure MCP → Start/Restart).
    //  - acr: Azure Container Registry (ACR) — Container registry management.
    //  - aks: Azure Kubernetes Service (AKS) — Container orchestration.
    //  - appconfig: Azure App Configuration — Configuration management.
    //  - azuremanagedlustre: Azure Managed Lustre — Commands for listing and inspecting Azure Managed Lustre filesystems.
    //  - azureterraformbestpractices: Azure Terraform Best Practices — Infrastructure as code guidance.
    //  - bestpractices: Azure Best Practices — Secure, production-grade guidance.
    //  - bicepschema: Bicep — Azure resource templates (schema operations).
    //  - cloudarchitect: Cloud Architecture — Commands for generating Azure architecture diagrams and design guidance.
    //  - cosmos: Cosmos DB operations — Commands for managing and querying Azure Cosmos DB resources.
    //  - datadog: Datadog — Manage and query Datadog resources.
    //  - deploy: Deploy — Commands for deploying applications to Azure, including subcommands for planning and architecture.
    //  - documentation: Official Microsoft/Azure documentation — Find relevant, trustworthy answers.
    //  - eventgrid: Event Grid — Commands for managing and accessing Event Grid topics, domains, and subscriptions.
    //  - extension: Azure CLI (az), Azure Developer CLI (azd), Azure Quick Review CLI (azqr)  — Execute CLI commands in context.
    //  - functionapp: Function App — Commands for managing and accessing Azure Function Apps.
    //  - foundry: Microsoft Foundry — AI model management and deployment.
    //  - grafana: Azure Managed Grafana — Monitoring dashboards.
    //  - group: Azure Resource Groups — Resource organization.
    //  - keyvault: Azure Key Vault — Secrets, keys, and certificates.
    //  - kusto: Azure Data Explorer (Kusto) — Analytics queries and KQL.
    //  - loadtesting: Azure Load Testing — Performance testing.
    //  - marketplace: Azure Marketplace — Product discovery.
    //  - monitor: Azure Monitor — Logging, metrics, and health monitoring.
    //  - mysql: MySQL — Commands for managing Azure Database for MySQL Flexible Server resources.
    //  - postgres: Azure Database for PostgreSQL — PostgreSQL database management.
    //  - quota: Quota — Commands for getting available regions and checking Azure resource usage quotas.
    //  - redis: Azure Redis Cache — In-memory data store.
    //  - resourcehealth: Resource Health — Commands for monitoring and diagnosing Azure resource health status.
    //  - role: Azure RBAC — Access control management.
    //  - search: Azure AI Search — Search engine/vector database operations.
    //  - servicebus: Service Bus operations — Manage queues, topics, and subscriptions.
    //  - sql: Azure SQL operations — Manage databases, elastic pools, and servers.
    //  - storage: Storage operations — Manage blobs, tables, files, and data lake storage.
    //  - subscription: Azure subscription operations — List and manage subscriptions.
    //  - virtualdesktop: Azure Virtual Desktop — Virtual desktop infrastructure.
    //  - workbooks: Azure Workbooks — Custom visualizations.
    "azureMcp.enabledServices": [],

    // Start the Azure MCP server in read-only mode (operations that modify resources will be disabled). **Note:** Changes require restarting the MCP server if MCP Autostart is not configured (Command Palette → MCP: List Servers → Azure MCP → Start/Restart).
    "azureMcp.readOnly": false,

    // Server Mode determines how tools are exposed: `single` collapses every tool (100+) into one (1) single tool that routes internally, `namespace` (default) collapses all tools down into logical Azure service namespace grouping (about 30 tools), while `all` exposes every MCP tool directly to the MCP client. We recommend namespace as the right balance between MCP tool count and tool selection accuracy. **Note:** Changes require restarting the MCP server if MCP Autostart is not configured (Command Palette → MCP: List Servers → Azure MCP → Start/Restart).
    "azureMcp.serverMode": "namespace",

    // Azure App Service
    // Array of web apps with its connections
    "appService.connections": [],

    // The default web app to use when deploying represented by its full Azure id.  Every subsequent deployment of this workspace will deploy to this web app or slot. Can be disabled by setting to "None"
    "appService.defaultWebAppToDeploy": "",

    // The default subpath of a workspace folder to use when deploying.
    "appService.deploySubpath": "",

    // Prepends each line displayed in the Azure App Service output channel with a timestamp
    "appService.enableOutputTimestamps": true,

    // Enable remote debugging for Python web apps (experimental)
    "appService.enablePythonRemoteDebugging": false,

    // The name of the task to run after zip deployments.
    "appService.postDeployTask": "",

    // The name of the task to run before deploying.
    "appService.preDeployTask": "",

    // Show prompt to improve performance of Zip Deploy by excluding build artifacts from the zip file and running a build during deployment.
    "appService.showBuildDuringDeployPrompt": true,

    // Ask for confirmation before deploying to Azure App Service (deploying will overwrite any previous deployment and cannot be undone).
    "appService.showDeployConfirmation": true,

    // Show a warning when the "deploySubpath" setting does not match the selected folder for deploying.
    "appService.showDeploySubpathWarning": true,

    // Show or hide the App Service Explorer
    "appService.showExplorer": true,

    // Show hidden runtime stacks when creating a web app in Azure. WARNING: These stacks may be in preview or may not be available in all regions.
    "appService.showHiddenStacks": false,

    // Shows a warning that performance may drop when creating an app in an App Service Plan that has more than 3 web apps associated to it
    "appService.showPlanPerformanceWarning": true,

    // Shows warning that project is not configured for VS Code deployments
    "appService.showPreDeployWarning": true,

    // Show warning dialog on remote file uploading.
    "appService.showSavePrompt": true,

    // Defines which files in the workspace to deploy. This applies to Zip deploy only, has no effect on other deployment methods.
    "appService.zipGlobPattern": "**/*",

    // Defines which files in the workspace to ignore for Zip deploy. This applies to Zip deploy only, has no effect on other deployment methods.
    "appService.zipIgnorePattern": [],

    // Azure Container Apps
    // The behavior to use when confirming delete of a Container Apps environment.
    //  - EnterName: Prompts with an input box where you enter the Container Apps environment name to delete.
    //  - ClickButton: Prompts with a warning dialog where you click a button to delete.
    "containerApps.deleteConfirmation": "EnterName",

    // A list of saved deployment configurations used for quickly redeploying a workspace project to a container app.
    "containerApps.deploymentConfigurations": [],

    // When deploying from a local workspace project, the name of the target container app to deploy to.
    "containerApps.deployWorkspaceProject.containerAppName": "",

    // When deploying from a local workspace project, the name of the target container app's resource group.
    "containerApps.deployWorkspaceProject.containerAppResourceGroupName": "",

    // When deploying from a local workspace project, the name of the Azure Container Registry to use for storing and building images.
    "containerApps.deployWorkspaceProject.containerRegistryName": "",

    // Prepends each line displayed in the output channel with a timestamp.
    "containerApps.enableOutputTimestamps": true,

    // Prompt to deploy revision draft whenever a draft command is run.
    "containerApps.showDraftCommandDeployPopup": true,

    // Azure Static Web Apps
    // The default value for the location of your Azure Functions code
    "staticWebApps.apiSubpath": "",

    // Deprecated.  Use the staticWebApps.outputSubpath setting instead.
    // The default value for the location of your build output relative to your application code location
    "staticWebApps.appArtifactSubpath": "",

    // The default value for the location of the application code prompt
    "staticWebApps.appSubpath": "",

    // Prepends each line displayed in the output channel with a timestamp.
    "staticWebApps.enableOutputTimestamps": true,

    // The default value for the location of your build output relative to your application code location
    "staticWebApps.outputSubpath": "",

    // Show a warning if the installed version of the Azure Static Web Apps CLI is out-of-date.
    "staticWebApps.showStaticWebAppsCliWarning": true,

    // Azure Storage Accounts
    // Delete all existing blobs before deploying to static website.
    "azureStorage.deleteBeforeDeploy": true,

    // The name of the task to run before deploying.
    "azureStorage.preDeployTask": "",

    // Show or hide the Azure Storage Explorer
    "azureStorage.showExplorer": true,

    // [Mac only] Set to "Path/To/Microsoft Azure Storage Explorer.app" to the location of Storage Explorer. Default is "/Applications/Microsoft Azure Storage Explorer.app".
    "azureStorage.storageExplorerLocation": "/Applications/Microsoft Azure Storage Explorer.app",

    // Azure Virtual Machines
    // Prepends each line displayed in the output channel with a timestamp.
    "azureVirtualMachines.enableOutputTimestamps": true,

    // Prompts for a passphrase when creating a Linux Azure Virtual Machine.
    "azureVirtualMachines.promptForPassphrase": true,

    // Azure Cosmos DB
    // The Client ID of the Managed Identity to use when authenticating with Entra ID using a User-assigned Managed Identity.
    "azureDatabases.authentication.managedIdentity.clientID": null,

    // The batch size to be used when querying Azure Database resources.
    "azureDatabases.batchSize": 50,

    // The behavior to use when confirming operations that cannot be undone, such as deleting resources.
    //  - wordConfirmation: Prompts with an input box where you enter the name of the resource to confirm deletion.
    //  - challengeConfirmation: Prompts with a challenge where you select the correct number among multiple options to confirm deletion.
    //  - buttonConfirmation: Prompts with a warning dialog where you click a button to confirm deletion.
    "azureDatabases.confirmationStyle": "wordConfirmation",

    // Select a preferred authentication method for Cosmos DB accounts.
    //  - auto: Selects the best authentication method based on the account configuration
    //  - accountKey: [LocalAuth](https://learn.microsoft.com/azure/cosmos-db/nosql/security/how-to-disable-key-based-authentication) must be enabled, this is not recommended for production environments
    //  - entraId: Sign in to VS Code using Entra ID
    //  - managedIdentity: Only supported when running in Azure (i.e. a VM), [learn more](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-setup-managed-identity)
    "azureDatabases.cosmosDB.preferredAuthenticationMethod": "auto",

    // Show detailed operation summaries, displaying messages for actions such as database drops, document additions, deletions, or similar events.
    "azureDatabases.showOperationSummaries": true,

    // **Deprecated**: Please use `azureDatabases.cosmosDB.preferredAuthenticationMethod` instead.
    // Always authenticate using Entra ID RBAC when connecting to Cosmos DB NoSQL Accounts. [Enable RBAC and assign Roles](https://aka.ms/cosmos-native-rbac).
    "azureDatabases.useCosmosOAuth": false,

    // The separator to use when exporting data to a CSV file (i.e. `;`, | or `,`).
    "cosmosDB.csvSeparator": ";",

    // The field values to display as labels in the treeview for Cosmos DB and MongoDB documents, in priority order
    "cosmosDB.documentLabelFields": [
        "name",
        "Name",
        "NAME",
        "ID",
        "UUID",
        "Id",
        "id",
        "_id",
        "uuid"
    ],

    // Port to use when connecting to a CosmosDB Mongo Emulator instance
    "cosmosDB.emulator.mongoPort": 10255,

    // Port to use when connecting to a CosmosDB Emulator instance
    "cosmosDB.emulator.port": 8081,

    // Flag to enable/disable automatic redirecting of requests based on read/write operations.
    "cosmosDB.enableEndpointDiscovery": true,

    // Manage LLM assets. Allow the extension to keep LLM-related files updated.
    "cosmosDB.manageLLMAssets": true,

    // Show warning dialog when uploading a document to the cloud.
    "cosmosDB.showSavePrompt": true,

    // Arguments to pass when starting the Mongo shell.
    "mongo.shell.args": [
        "--quiet"
    ],

    // Full path to folder and executable to start the Mongo shell, needed by some Mongo scrapbook commands. The default is to search in the system path for 'mongo'.
    "mongo.shell.path": null,

    // The duration allowed (in seconds) for the Mongo shell to execute a command. Default value is 30 seconds.
    "mongo.shell.timeout": 30,

    // AI Toolkit
    // Enable to run fine-tuning and inference on Azure Container Apps (Reload Visual Studio Code after changing this setting to take effect).
    "windowsaistudio.enableRemoteFine-tuningAndInference": false,

    // Extend GitHub Copilot Chat instructions for better AI Toolkit tool uses.
    "windowsaistudio.extendCopilotInstructions": true,

    // List of external providers to register
    "windowsaistudio.externalOpenAIProviders": [],

    // User accepted datasets in Model Lab
    "windowsaistudio.modelLabAcceptedDatasets": [],

    // If set, use this global shared cache instead of per project in Model Lab
    "windowsaistudio.modelLabGlobalCachePath": null,

    // The Open AI inference http local port
    "windowsaistudio.openAIInferencePort": null,

    // Playground Agent model storage path
    "windowsaistudio.playgroundAgentModelStorage": null,

    // Playground Agent Pipe name
    "windowsaistudio.playgroundAgentPipe": null,

    // List of remote inference endpoints
    "windowsaistudio.remoteInfereneEndpoints": [],

    // Branch to pull from the template repo
    "windowsaistudio.templateRef": null,

    // The port to use for the OpenTelemetry OTLP gRPC receiver
    "windowsaistudio.tracingGrpcPort": 4317,

    // The port to use for the OpenTelemetry OTLP HTTP receiver
    "windowsaistudio.tracingHttpPort": 4318,

    // Workspace Agent Pipe name
    "windowsaistudio.workspaceAgentPipe": null,

    // Microsoft Foundry
    // Specifies the level of logging for the Output panel
    "vscode-ai-foundry.logLevel": "info",

    // Port number for Hosted Agents (1-65535)
    "vscode-ai-foundry.workflowVisualizationPort": 4319,

}
