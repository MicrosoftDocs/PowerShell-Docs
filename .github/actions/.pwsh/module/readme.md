# GHA Module

The GitHub Actions (GHA) module includes helper functions for the scripts used by the actions in
this repository. Those functions are broken up across broad usage:

- API: Functions in the [`api` folder][api-folder] make specific structured calls to GitHub's API
  with the GitHub CLI (`gh`). Each of these functions performs a very specific query and returns
  predictably structured data.
- Utility: Functions in the [`utility` folder][utility-folder] are more general-purpose and are used
  by the API functions and the action scripts alike.

## API Functions

### `Add-PullRequestComment`

This cmdlet adds a comment to a pull request via GitHub CLI by specifying a raw Markdown string or
the path to a Markdown file containing the comment to write.

For more information, review the [source code][api-Add-PullRequestComment].

### `Get-AuthorPermission`

This cmdlet retrieves repository permissions for a user, returning a hashtable that enumerates
whether the user can admin, maintain, push, triage, and/or pull.

For more information, review the [source code][api-Get-AuthorPermission].

### `Get-OpenPRWithoutExpectation`

This cmdlet searches a repository for open pull requests targeting the `main` branch which do not
have an expectations comment on them already. It returns a hashtable with the author and number of
every pull request in the repository matching these criteria.

For more information, review the [source code][api-Get-OpenPRWithoutExpectation]

### `Get-PullRequestChangedFile`

This cmdlet retrieves the list of file changes for a PR, returning an array of relative file paths
and the change type: `added`, `removed`, `modified`, `renamed`, `copied`, `changed`, or `unchanged`.

For more information, review the [source code][api-Get-PullRequestChangedFile]

## Utility Functions

### `Format-ConsoleBoolean`

The cmdlet decorates a boolean value for console viewing and returns it. If the **Value** is
`$true`, it is returned bright blue. If the **Value** is `$false`, it is returned bright magenta.

For more information, review the [source code][utility-Format-ConsoleBoolean]

### `Format-ConsoleStyle`

This cmdlet stylizes input text for viewing in the console.

For more information, review the [source code][utility-Format-ConsoleStyle]

### `Format-GHAConsoleText`

This cmdlet reflows a text string at a specified length for easier console reading. It respects
leading whitespace, keeping the indent for wrapped lines. It converts tabs to four spaces for
consistency in viewing. It breaks lines on whitespace; not complex, but usually fine in console.

Primarily useful for converting error messages into readable lines.

For more information, review the [source code][utility-Format-GHAConsoleText]

### `Get-ActionScriptParameter`

This cmdlet uses parameter handlers to retrieve and validate the inputs from a GitHub Action,
returning a hashtable of parameters to splat on an action script.

For more information, review the [source code][utility-Get-ActionScriptParameter]

### `Get-GHAConsoleError`

This cmdlet returns an alternate view of an error record for the GH CLI. It limits the object
properties to the fully qualified ID, the type of the error, the error message, and the target
object (which for GH CLI errors is always the command-line arguments for the failing command).

It can retrieve errors from the `$error` variable or act on an input object.

For more information, review the [source code][utility-Get-GHAConsoleError]

### `Get-StaleDocument`

This cmdlet searches a specified folder for stale documents as determined by comparing the value of
their `ms.date` metadata key with a specified date. By default, any document not updated in the last
330 days is considered stale.

It returns the list of stale documents with their **RootPath** (the folder searched recursively),
**RelativePath** (the path to the document relative to the **RootPath**), and **MSDate** (the
**System.DateTime** value for their `ms.date` property).

For more information, review the [source code][utility-Get-StaleDocument].

### `Get-VersionedContentStatus`

This cmdlet returns the change status of versioned content for a pull request. This information can
be used to analyze whether a pull request has modified every file it should.

Pull requests for versioned content can be tricky, requiring an author to modify the same file in
multiple folders. This cmdlet helps clarify if changes have been made across all the versions a file
exists in, but does not process the information itself.

The output of this cmdlet is an array of objects with the following properties:

- **VersionRelativePath**: The path to the changed file from the version folder
- **BaseFolder**: The path to the parent folder of multiple versions; the grandparent of the
  **VersionRelativePath**.
- **Versions**: An array of objects representing every version of the content the file exists in.
  Each entry has a **Version** (like `5.1` or `7.2`) and **ChangeType** (whether the file was
  `added`, `removed`, `modified`, `renamed`, `copied`, `changed`, or `unchanged`).

For more information, review the [source code][utility-Get-VersionedContentStatus]

### `New-CliErrorRecord`

This cmdlet generates an error record for a failed `gh` command. It enables the API commands in this
module to write useful error messages.

The exception type is always **System.ApplicationException** and the error category is always
`FromStdErr`.

For more information, review the [source code][utility-New-CliErrorRecord]

### `New-InvalidParameterError`

This cmdlet composes and returns an error record for when a parameter handler determines that the
input for a GitHub Action cannot be validly converted to a parameter for an action script.

It returns the error record but does not throw it or write it to the error stream.

For more information, review the [source code][utility-New-InvalidParameterError]

### `Write-ActionFailureSummary`

Writes a standardized summary entry when a GHA fails due to thrown error. It includes the record
of the error in a Markdown codeblock under the heading "Action Failure."

For more information, review the [source code][utility-Write-ActionFailureSummary]

### `Write-HostParameter`

This cmdlet writes a console log message declaring that a parameter value has been determined,
including the name and colorized value. It uses `Write-Host` to avoid polluting the output stream,
allowing it to be log this information in parameter handler scriptblocks invoked by the
`Get-ActionScriptParameter` cmdlet.

For more information, review the [source code][utility-Write-HostParameter]

<!-- Reference Links -->
[api-folder]:                         ./functions/api/
[api-Add-PullRequestComment]:         ./functions/api/Add-PullRequestComment.ps1
[api-Get-AuthorPermission]:           ./functions/api/Get-AuthorPermission.ps1
[api-Get-OpenPRWithoutExpectation]:   ./functions/api/Get-OpenPRWithoutExpectation.ps1
[api-Get-PullRequestChangedFile]:     ./functions/api/Get-PullRequestChangedFile.ps1
[utility-folder]:                     ./functions/utility/
[utility-Format-ConsoleBoolean]:      ./functions/utility/Format-ConsoleBoolean.ps1
[utility-Format-ConsoleStyle]:        ./functions/utility/Format-ConsoleStyle.ps1
[utility-Format-GHAConsoleText]:      ./functions/utility/Format-GHAConsoleText.ps1
[utility-Get-GHAConsoleError]:        ./functions/utility/Get-GHAConsoleError.ps1
[utility-Get-ActionScriptParameter]:              ./functions/utility/Get-ActionScriptParameter.ps1
[utility-Get-StaleDocument]: ./functions/utility/Get-StaleDocument.ps1
[utility-Get-VersionedContentStatus]: ./functions/utility/Get-VersionedContentStatus.ps1
[utility-New-CliErrorRecord]:         ./functions/utility/New-CliErrorRecord.ps1
[utility-New-InvalidParameterError]:  ./functions/utility/New-InvalidParameterError.ps1
[utility-Write-ActionFailureSummary]: ./functions/utility/Write-ActionFailureSummary.ps1
[utility-Write-HostParameter]:        ./functions/utility/Write-HostParameter.ps1
