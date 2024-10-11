---
description: >
  This article explains how to use your profile to save preferred PowerShell settings and optimize
  your shell experience.
ms.date: 09/04/2024
title: Customizing your shell environment
---
# Customizing your shell environment

A PowerShell profile is a script that runs when PowerShell starts. You can use the profile to
customize the environment. You can:

- add aliases, functions, and variables
- load modules
- create PowerShell drives
- run arbitrary commands
- and change preference settings

Putting these settings in your profile ensures that they're available whenever you start PowerShell
on your system.

> [!NOTE]
> To run scripts in Windows, the PowerShell execution policy needs to be set to `RemoteSigned` at a
> minimum. Execution policies don't apply to macOS and Linux. For more information, see
> [about_Execution_Policy][1].

## The $PROFILE variable

The `$PROFILE` automatic variable stores the paths to the PowerShell profiles that are available in
the current session.

There are four possible profiles available to support different user scopes and different PowerShell
hosts. The fully qualified paths for each profile script are stored in the following member
properties of `$PROFILE`.

- **AllUsersAllHosts**
- **AllUsersCurrentHost**
- **CurrentUserAllHosts**
- **CurrentUserCurrentHost**

You can create profile scripts that run for all users or just one user, the **CurrentUser**.
**CurrentUser** profiles are stored in the user's home directory.

There are also profiles that run for all PowerShell hosts or specific hosts. The profile script
for each PowerShell host has a name unique for that host. For example, the filename for the standard
Console Host on Windows or the default terminal application on other platforms is
`Microsoft.PowerShell_profile.ps1`. For Visual Studio Code (VS Code), the filename is
`Microsoft.VSCode_profile.ps1`.

For more information, see [about_Profiles][2].

By default, referencing the `$PROFILE` variable returns the path to the "Current User, Current Host"
profile. The other profiles path can be accessed through the properties of the `$PROFILE` variable.
For example:

```powershell
PS> $PROFILE
C:\Users\user1\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
PS> $PROFILE.AllUsersAllHosts
C:\Program Files\PowerShell\7\profile.ps1
```

## How to create your personal profile

When you first install PowerShell on a system, the profile script files and the directories they
belong to don't exist. The following command creates the "Current User, Current Host"
profile script file if it doesn't exist.

```powershell
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}
```

The **Force** parameter of `New-Item` cmdlet creates the necessary folders when they don't exist.
Once you have created the script file, you can use your favorite editor to customize your shell
environment.

## Adding customizations to your profile

The previous articles talked about using [tab completion][3], [command predictors][4], and
[aliases][5]. These articles showed the commands used to load the required modules, create custom
completers, define keybindings, and other settings. These are the kinds of customizations that you
want to have available in every PowerShell interactive session. The profile script is the place for
these settings.

The simplest way to edit your profile script is to open the file in your favorite code editor. For
example, the following command opens the profile in [VS Code][6].

```powershell
code $PROFILE
```

You could also use `notepad.exe` on Windows, `vi` on Linux, or any other text editor.

The following profile script has examples for many of the customizations mentioned in the
previous articles. You can use any of these settings in your own profile.

```powershell
## Map PSDrives to other registry hives
if (!(Test-Path HKCR:)) {
    $null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $null = New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

## Customize the prompt
function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    $prefix = if (Test-Path variable:/PSDebugContext) { '[DBG]: ' } else { '' }
    if ($principal.IsInRole($adminRole)) {
        $prefix = "[ADMIN]:$prefix"
    }
    $body = 'PS ' + $PWD.path
    $suffix = $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
    "${prefix}${body}${suffix}"
}

## Create $PSStyle if running on a version older than 7.2
## - Add other ANSI color definitions as needed

if ($PSVersionTable.PSVersion.ToString() -lt '7.2.0') {
    # define escape char since "`e" may not be supported
    $esc = [char]0x1b
    $PSStyle = [pscustomobject]@{
        Foreground = @{
            Magenta = "${esc}[35m"
            BrightYellow = "${esc}[93m"
        }
        Background = @{
            BrightBlack = "${esc}[100m"
        }
    }
}

## Set PSReadLine options and keybindings
$PSROptions = @{
    ContinuationPrompt = '  '
    Colors             = @{
        Operator         = $PSStyle.Foreground.Magenta
        Parameter        = $PSStyle.Foreground.Magenta
        Selection        = $PSStyle.Background.BrightBlack
        InLinePrediction = $PSStyle.Foreground.BrightYellow + $PSStyle.Background.BrightBlack
    }
}
Set-PSReadLineOption @PSROptions
Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine

## Add argument completer for the dotnet CLI tool
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock
```

This profile script provides examples for the following customization:

- Adds two new [PSDrives][7] for the other root registry hives.
- Creates a [customized prompt][8] that changes if you are running in an elevated session.
- Configures **PSReadLine** and adds keybinding. The color settings use the [$PSStyle][9] feature to
  define the ANSI color settings.
- Adds tab completion for the [dotnet CLI][10] tool. The tool provides parameters to help resolve the
  command-line arguments. The script block for [Register-ArgumentCompleter][11] uses that
  feature to provide the tab completion.

<!-- link references -->

[1]: /powershell/module/microsoft.powershell.core/about/about_execution_policies
[2]: /powershell/module/microsoft.powershell.core/about/about_profiles
[3]: tab-completion.md
[4]: using-predictors.md
[5]: using-aliases.md
[6]: https://code.visualstudio.com/
[7]: /powershell/module/microsoft.powershell.core/about/about_filesystem_provider
[8]: /powershell/module/microsoft.powershell.core/about/about_prompts
[9]: /powershell/module/microsoft.powershell.core/about/about_ansi_terminals
[10]: /dotnet/core/tools/
[11]: /powershell/module/microsoft.powershell.core/register-argumentcompleter
