---
description: PSReadLine provides an improved command-line editing experience in the PowerShell console.
Locale: en-US
ms.date: 07/13/2022
online version: https://docs.microsoft.com/powershell/module/psreadline/about/about_psreadline?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about PSReadLine
---
# about_PSReadLine

## Short Description

PSReadLine provides an improved command-line editing experience in the
PowerShell console.

## Long Description

PowerShell 7.2 ships with PSReadLine 2.1.0. There are newer versions
available. The current version of PSReadLine can be installed and used on
Windows PowerShell 5.1 and newer. For some features, you need to be running
PowerShell 7.2 or higher.

PSReadLine provides a powerful command-line editing experience for the
PowerShell console. It provides:

- Syntax coloring of the command line
- A visual indication of syntax errors
- A better multi-line experience (both editing and history)
- Customizable key bindings
- Cmd and Emacs modes
- Many configuration options
- Bash style completion (optional in Cmd mode, default in Emacs mode)
- Emacs yank/kill-ring
- PowerShell token based "word" movement and deletion
- Predictive IntelliSense
- Dynamic display of Help in the console without losing your place on the
  command line

PSReadLine requires PowerShell 5.1, or newer. PSReadLine works with the default
Windows console host, Window Terminal, and Visual Studio Code. It doesn't work
in the Windows PowerShell ISE.

PSReadLine can be installed from the PowerShell Gallery. To install PSReadLine
in a supported version of PowerShell run the following command.

```powershell
Install-Module -Name PSReadLine -AllowClobber -Force
```

> [!NOTE]
> Beginning with PowerShell 7.0, PowerShell skips autoloading PSReadLine on
> Windows if a screen reader program is detected. Currently, PSReadLine doesn't
> work well with the screen readers. The default rendering and formatting of
> PowerShell 7.0 on Windows works properly. You can manually load the module if
> necessary.

## Predictive IntelliSense

Predictive IntelliSense is an addition to the concept of tab completion that
assists the user in successfully completing commands. It enables users to
discover, edit, and execute full commands based on matching predictions from the
user's history and additional domain specific plugins.

### Enable Predictive IntelliSense

Predictive IntelliSense is disabled by default. To enable predictions, just run
the following command:

```powershell
Set-PSReadLineOption -PredictionSource History
```

The **PredictionSource** parameter can also accept plugins for domain specific
and custom requirements.

To disable Predictive IntelliSense, just run:

```powershell
Set-PSReadLineOption -PredictionSource None
```

> [!NOTE]
> Predictive IntelliSense is enabled by default in PSReadLine 2.2.6. For more
> information see, the [PSReadLine release history](#psreadline-release-history)
> in the **Notes** section below.

## Custom Key Bindings

PSReadLine supports custom key bindings using the `Set-PSReadLineKeyHandler`
cmdlet. Most custom key bindings call one of the
[bindable functions](about_PSReadLine_Functions.md), for example

```powershell
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
```

You can bind a ScriptBlock to a key. The ScriptBlock can do pretty much
anything you want. Some useful examples include

- edit the command line
- opening a new window (for example, help)
- change directories without changing the command line

The ScriptBlock receives two arguments:

- `$key` - A **[ConsoleKeyInfo]** object that is the key that triggered the
  custom binding. If you bind the same ScriptBlock to multiple keys and need to
  perform different actions depending on the key, you can check `$key`. Many
  custom bindings ignore this argument.

- `$arg` - An arbitrary argument. Most often, this would be an integer
  argument that the user passes from the key bindings DigitArgument. If your
  binding doesn't accept arguments, it's reasonable to ignore this argument.

Let's take a look at an example that adds a command line to history without
executing it. This is useful when you realize you forgot to do something, but
don't want to re-enter the command line you've already entered.

```powershell
$parameters = @{
    Key = 'Alt+w'
    BriefDescription = 'SaveInHistory'
    LongDescription = 'Save current line in history but do not execute'
    ScriptBlock = {
      param($key, $arg)   # The arguments are ignored in this example

      # GetBufferState gives us the command line (with the cursor position)
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line,
        [ref]$cursor)

      # AddToHistory saves the line in history, but does not execute it.
      [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)

      # RevertLine is like pressing Escape.
      [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  }
}
Set-PSReadLineKeyHandler @parameters
```

You can see many more examples in the file `SamplePSReadLineProfile.ps1`, which
is installed in the **PSReadLine** module folder.

Most key bindings use some helper functions for editing the command line. Those
APIs are documented in
[about_PSReadLine_Functions](about_PSReadLine_Functions.md).

## Notes

### Command History

PSReadLine maintains a history file containing all the commands and data you've entered from the command line. The history files are a file named
`$($host.Name)_history.txt`. On Windows systems the history file is stored at
`$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine`. On non-Windows systems,
the history files are stored at `$env:XDG_DATA_HOME/powershell/PSReadLine` or
`$env:HOME/.local/share/powershell/PSReadLine`.

The history can contain sensitive data including passwords. PSReadLine attempts
to filter out sensitive information. Any command lines containing the following
strings aren't written to the history file.

- password
- asplaintext
- token
- apikey
- secret

PSReadLine 2.2.0 improves the filtering of sensitive data in the following ways:

- Uses the PowerShell Abstract Syntax Tree (AST) of the parsed command line to
  look for sensitive data.
- Uses an allowlist of safe cmdlets from the **SecretManagement** module to
  allow those commands to be added to the history. The allowlist contains:
  - `Get-Secret`
  - `Get-SecretInfo`
  - `Get-SecretVault`
  - `Register-SecretVault`
  - `Remove-Secret`
  - `Set-SecretInfo`
  - `Set-SecretVaultDefault`
  - `Test-SecretVault`
  - `Unlock-SecretVault`
  - `Unregister-SecretVault`

For example, the following commands are allowed to be written to the history
file:

```powershell
Get-Secret PSGalleryApiKey -AsPlainText # Get-Secret is in the allowlist
$token = Get-Secret -Name github-token -Vault MySecret
[MyType]::CallRestAPI($token, $url, $args)
$template -f $token
```

The following command isn't be written to the history file:

```powershell
$token = 'abcd' # Assign expr-value to sensitive variable name.
Set-Secret abc $mySecret # Set-Secret is not in the allowlist.
ConvertTo-SecureString stringValue -AsPlainText # '-AsPlainText' is an alert.
Invoke-WebRequest -Token xxx # Expr-value as argument to '-Token'.
Get-ResultFromTwo -Secret1 (Get-Secret -Name blah -AsPlainText) -Secret2 sdv87ysdfayf798hfasd8f7ha # '-Secret2' has expr-value argument.
```

### PSReadLine release history

There have been many updates to PSReadLine since the version that ships in
Windows PowerShell 5.1.

- PowerShell 7.3-preview.5 ships with PSReadLine 2.2.5
- PowerShell 7.2.5 ships with PSReadLine 2.1.0
- PowerShell 7.0.11 ships with PSReadLine 2.0.4
- PowerShell 5.1 ships with PSReadLine 2.0.0

For a full list of changes, see the PSReadLine
[ChangeLog](https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/Changes.txt).

- **PSReadLine 2.2.6**

  In this release, the Predictive IntelliSense feature is enabled by default
  depending on the following conditions:

  - If Virtual Terminal (VT) is supported and PSReadLine running in PowerShell
    7.2 or higher, **PredictionSource** is set to `HistoryAndPlugin`
  - If VT is supported and PSReadLine running in PowerShell prior to 7.2,
    **PredictionSource** is set to `History`
  - If VT isn't supported, **PredictionSource** is set to `None`

- **PSReadLine 2.2.5**

  This release rolls up the following enhancements added since the 2.1.0
  release:

  - PSReadLine added two new predictive IntelliSense features:
    - Added the **PredictionViewStyle** parameter to allow for the selection of
      the new `ListView`.
    - Connected PSReadLine to the `CommandPrediction` APIs introduced in
      PowerShell 7.2 to allow a user can import a predictor module that can
      render the suggestions from a custom source.
  - Updated to use the 1.0.0 version of `Microsoft.PowerShell.Pager` for
    dynamic help
  - Improved the scrubbing of sensitive history items
  - Lots of bug fixes and smaller improvements

- **PSReadLine 2.1.0**

  This release rolls up the following enhancements added since the 2.0.4
  release:

  - Add Predictive IntelliSense suggestions from the command history
  - Many bug fixes and API enhancements

- **PSReadLine 2.0.4**

  This release rolls up the following enhancements added since the 2.0.0
  release:

  - Added the `-Chord` parameter to `Get-PSReadLineKeyHandler` to allow
    searching for specific key bindings

### Feedback & contributing to PSReadLine

[PSReadLine on GitHub](https://github.com/PowerShell/PSReadLine)

Feel free to submit a pull request or submit feedback on the GitHub page.

## See Also

- PSReadLine is heavily influenced by the GNU
  [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) library.
