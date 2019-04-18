---
title: What's New in PowerShell Core 6.2
description: New features and changes released in PowerShell Core 6.2
ms.date: 03/28/2019
---

# What's New in PowerShell Core 6.2

The PowerShell Core 6.2 release focused on performance improvements, bug fixes, and smaller cmdlet
and language enhancements that improve the quality. To see a full list of improvements, check out
our detailed [changelogs](https://github.com/PowerShell/PowerShell/releases) on GitHub.

## General Cmdlet Updates and Fixes

- Enable `SecureString` cmdlets for non-Windows by storing the plain text ([#9199][])
- Add Obsolete message to `Send-MailMessage` ([#9178][])
- Fix `Restart-Computer` to work on `localhost` when WinRM is not present ([#9160][])
- Make `Start-Job` throw terminating error when PowerShell is being hosted ([#9128][])
- Added new suffixes for numeric literals - see [about_Numeric_Literals][]

## Experimental Features

Previously, we enabled support for [Experimental Features][]. In the 6.2 release, we have four
experimental features to try out. Please provide feedback so we can make improvements and to decide
whether the feature is worth promoting to mainstream status.

Use `Get-ExperimentalFeature` to get a list of available experimental features. You can enable
or disable these features with `Enable-ExperimentalFeature` and `Disable-ExperimentalFeature`.

### Command Not Found Suggestions

This feature uses fuzzy matching to find suggestions for commands or cmdlets you may have mistyped.

```powershell
Enable-ExperimentalFeature -Name PSCommandNotFoundSuggestion
```

#### Example

In this example, the misspelled cmdlet name is fuzzy matched to several suggestions from most likely
to least likely.

```powershell
Get-Commnd
```

```Output
Get-Commnd : The term 'Get-Commnd' is not recognized as the name of a cmdlet, function, script file, or operable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
At line:1 char:1
+ Get-Commnd
+ ~~~~~~~~~~
+ CategoryInfo          : ObjectNotFound: (Get-Commnd:String) [], CommandNotFoundException
+ FullyQualifiedErrorId : CommandNotFoundException


Suggestion [4,General]: The most similar commands are: Get-Command, Get-Content, Get-Job, Get-Module, Get-Event, Get-Host, Get-Member, Get-Item, Set-Content.
```

### Implicit Remoting Batching

When using [implicit remoting](https://devblogs.microsoft.com/scripting/remoting-the-implicit-way/)
in a pipeline, PowerShell treats each command in the pipeline independently. Objects are repeatedly
serialized and de-serialized between the client and remote system over the execution of the
pipeline.

With this feature, PowerShell analyzes the pipeline to determine if the command is safe to run and
it exists on the target system. When true, PowerShell executes the entire pipeline remotely and only
serializes and de-serializes the results back to the client.

```powershell
Enable-ExperimentalFeature -Name PSImplicitRemotingBatching
```

A real-world test of `Get-Process | Sort-Object` over localhost decreases from 10-15 seconds to
20-30 **milliseconds**. The feature only needs to be enabled on the client. No changes are required
on the server.

### Temp Drive

```powershell
Enable-ExperimentalFeature -Name PSTempDrive
```

If you're using PowerShell Core on different operating systems, you'll discover that the environment
variable for finding the temporary directory is different on Windows, macOS, and Linux! With this
feature, you get a [PSDrive][] called `Temp:` that is automatically mapped to the temporary
folder for the operating system you are using.

#### Example

```powershell
PS> "Hello World!" > Temp:/hello.txt
PS> Get-Content Temp:/hello.txt
Hello World!
```

Be aware that native file commands (like `ls` on Linux) are not aware of PSDrives and won't see this
`Temp:` drive.

### Abbreviation Expansion

PowerShell cmdlets are expected to have descriptive nouns. This results in long names that are more
difficult to type. This feature allows you to just type the uppercase characters of the cmdlet and
use tab-completion to find a match.

```powershell
Enable-ExperimentalFeature -Name PSUseAbbreviationExpansion
```

#### Example

```powershell
PS> i-arsavsf
```

If you hit tab, and have the Azure PowerShell [Az](https://www.powershellgallery.com/packages/Az)
module installed, it will autocomplete to:

```Output
PS> Import-AzRecoveryServicesAsrVaultSettingsFile
```

> [!NOTE]
> This feature is intended to be used interactively. Abbreviated forms of cmdlets can't be executed.
> This feature is not a replacement for aliases.

## Breaking Changes

- Fix `-NoEnumerate` behavior in `Write-Output` to be consistent with Windows PowerShell. ([#9069][])
  (Thanks @vexx32!)

<!-- Link references -->
[#9069]: https://github.com/PowerShell/PowerShell/pull/9069
[#9128]: https://github.com/PowerShell/PowerShell/pull/9128
[#9160]: https://github.com/PowerShell/PowerShell/pull/9160
[#9178]: https://github.com/PowerShell/PowerShell/pull/9178
[#9199]: https://github.com/PowerShell/PowerShell/pull/9199
[about_Numeric_Literals]: /powershell/module/Microsoft.PowerShell.Core/About/about_numeric_literals
[Experimental Features]: /powershell/module/Microsoft.PowerShell.Core/About/about_Experimental_Features
[PSDrive]: /powershell/module/microsoft.powershell.management/new-psdrive
