---
title: What's New in PowerShell Core 6.2
description: New features and changes released in PowerShell Core 6.2
ms.date: 03/28/2019
---

# What's New in PowerShell Core 6.2

The PowerShell Core 6.2 release focused on performance improvements, bug fixes, and smaller cmdlet
and language enhancements that improve the quality. To see a full list of improvements, check out
our detailed [changelogs](https://github.com/PowerShell/PowerShell/releases) on GitHub.

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
serialized and `de-serialized` between the client and remote system over the execution of the
pipeline.

With this feature, PowerShell analyzes the pipeline to determine if the command is safe to run and
it exists on the target system. When true, PowerShell executes the entire pipeline remotely and only
serializes and `de-serializes` the results back to the client.

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
feature, you get a [PSDrive][] called `Temp:` that is automatically mapped to the temporary folder
for the operating system you are using.

#### Example

```powershell
PS> "Hello World!" > Temp:/hello.txt
PS> `Get-Content` Temp:/hello.txt
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

- Fix `-NoEnumerate` behavior in `Write-Output` to be consistent with Windows PowerShell. (#9069)
- Make `Join-String -InputObject 1,2,3` result equal to `1,2,3 | Join-String` result (#8611) (Thanks
  @sethvs!)
- Add `-Stable` to `Sort-Object` and related tests (#7862) (Thanks @KirkMunro!)
- Improve `Start-Sleep` cmdlet to accept fractional seconds (#8537) (Thanks @Prototyyppi!)
- Change hashtable to use OrdinalIgnoreCase to be `case-insensitive` in all Cultures (#8566)
- Fix **LiteralPath** in `Import-Csv` to bind to `Get-ChildItem` output (#8277) (Thanks @iSazonov!)
- No longer skips a column without name if double quote delimiter is used in `Import-Csv` (#7899)
  (Thanks @Topping!)
- `Get-ExperimentalFeature` no longer has `-ListAvailable` switch (#8318)
- Debug parameter now sets `$DebugPreference` to **Continue** instead of **Inquire** (#8195) (Thanks
  @KirkMunro!)
- Honor `-OutputFormat` if specified in non-interactive, redirected, encoded command used with pwsh
  (#8115)
- Load assembly from module base path before trying to load from the GAC (#8073)
- Remove tilde from Linux preview packages (#8244)
- Move processing of `-WorkingDirectory` before processing of profiles (#8079)
- Do not add `PATHEXT` environment variable on Unix (#7697) (Thanks @iSazonov!)

## Known Issues

- Remoting on Windows IOT ARM platforms has an issue loading modules. See (#8053)

## General Updates and Fixes

- Enable case-insensitive tab completion for files and folders on case-sensitive filesystem (#8128)
- Make PSVersionInfo.PSVersion and PSVersionInfo.PSEdition public (#8054) (Thanks @KirkMunro!)
- Add Type Inference for `$_` / `$PSItem` in `catch{ }` blocks (#8020) (Thanks @vexx32!)
- Fix static method invocation type inference (#8018) (Thanks @SeeminglyScience!)
- Create inferred types for `Select-Object`, `Group-Object`, **PSObject** and **Hashtable** (#7231)
  (Thanks @powercode!)
- Support calling method with `ByRef-like` type parameters (#7721)
- Handle the case where the Windows PowerShell module path is already in the environment's
  PSModulePath (#7727)
- Enable `SecureString` cmdlets for non-Windows by storing the plain text (#9199)
- Improve error message on non-Windows when importing clixml with securestring (#7997)
- Adding parameter ReplyTo to `Send-MailMessage` (#8727) (Thanks @replicaJunction!)
- Add Obsolete message to `Send-MailMessage` (#9178)
- Fix `Restart-Computer` to work on `localhost` when WinRM is not present (#9160)
- Make `Start-Job` throw terminating error when PowerShell is being hosted (#9128)
- Add C# style type accelerators and suffixes for ushort, uint, ulong, and short literals (#7813)
  (Thanks @vexx32!)
- Added new suffixes for numeric literals - see [about_Numeric_Literals][] (#7901) (Thanks @vexx32!)
- Correctly Report impact level when SupportsShouldProcess is not set to 'true' (#8209) (Thanks
  @vexx32!)
- Fix Request Charset Issues in Web Cmdlets (#8742) (Thanks @markekraus!)
- Fix Expect `100-continue` issue with Web Cmdlets (#8679) (Thanks @markekraus!)
- Fix file blocking issue with web cmdlets (#7676) (Thanks @Claustn!)
- Fix code page parsing issue in `Invoke-RestMethod` (#8694) (Thanks @markekraus!)
- Refactor `ConvertTo-Json` to expose JsonObject.ConvertToJson as a public API (#8682)
- Add configurable maximum depth in `ConvertFrom-Json` with -Depth (#8199) (Thanks @louistio!)
- Add EscapeHandling parameter in `ConvertTo-Json` cmdlet (#7775) (Thanks @iSazonov!)
- Add `-CustomPipeName` to pwsh and `Enter-PSHostProcess` (#8889)
- Enable creating relative symbolic links on Windows with `New-Item` (#8783)
- Allow Windows users in developer mode to create symlinks without elevation (#8534)
- Enable `Write-Information` to accept `$null` (#8774)
- Fix `Get-Help` for advanced functions with MAML help content (#8353)
- Fix `Get-Help` PSTypeName issue with -Parameter when only one parameter is declared (#8754)
  (Thanks @pougetat!)
- Token calculation fix for `Get-Help` executed on ScriptBlock for comment help. (#8238) (Thanks
  @hubuk!)
- Change `Get-Help` cmdlet -Parameter parameter so it accepts string arrays (#8454) (Thanks
  @sethvs!)
- Resolve PAGER if its path contains spaces (#8571) (Thanks @pougetat!)
- Add prompt to the use of `less` in the function 'help' to instruct user how to quit (#7998)
- Add support enum and char types in `Format-Hex` cmdlet (#8191) (Thanks @iSazonov!)
- Remove ShouldProcess from `Format-Hex` (#8178)
- Add new Offset and Count parameters to `Format-Hex` and refactor the cmdlet (#7877) (Thanks
  @iSazonov!)
- Allow 'name' as an alias key for 'label' in `ConvertTo-Html`, allow the 'width' entry to be an
  integer (#8426) (Thanks @mklement0!)
- Make scriptblock based calculated properties work again in `ConvertTo-Html` (#8427) (Thanks
  @mklement0!)
- Add cmdlet `Join-String` for creating text from pipeline input (#7660) (Thanks @powercode!)
- Fix `Join-String` cmdlet FormatString parameter logic (#8449) (Thanks @sethvs!)
- Change `Clear-Host` back to using `$RAWUI` and clear to work over remoting (#8609)
- Change `Clear-Host` to simply called `[console]::clear` and remove clear alias from Unix (#8603)
- Fix LiteralPath in `Import-Csv` to bind to `Get-ChildItem` output (#8277) (Thanks @iSazonov!)
- help function shouldn't use pager for AliasHelpInfo (#8552)
- Add `-UseMinimalHeader` to `Start-Transcript` to minimize transcript header (#8402) (Thanks
  @lukexjeremy!)
- Add `Enable-ExperimentalFeature` and `Disable-ExperimentalFeature` cmdlets (#8318)
- Expose all cmdlets from **PSDiagnostics** if logman.exe is available (#8366)
- Remove **Persist** parameter from `New-PSDrive` on `non-Windows` platform (#8291) (Thanks
  @lukexjeremy!)
- Add support for `cd +` (#7206) (Thanks @bergmeister!)
- Enable `Set-Location -LiteralPath` to work with folders named - and + (#8089)
- `Test-Path` returns `$false` when given an empty or `$null` path value (#8080) (Thanks @vexx32!)
- Allow dynamic parameter to be returned even if path does not match any provider (#7957)
- Support `Get-PSHostProcessInfo` and `Enter-PSHostProcess` on Unix platforms (#8232)
- Reduce allocations in `Get-Content` cmdlet (#8103) (Thanks @iSazonov!)
- Enable `Add-Content` to share read access with other tools while writing content (#8091)
- `Get/Add-Content` throws improved error when targeting a container (#7823) (Thanks @kvprasoon!)
- Add `-Name`, `-NoUserOverrides` and `-ListAvailable` parameters to `Get-Culture` cmdlet (#7702)
  (Thanks @iSazonov!)
- Add unified attribute for completion for **Encoding** parameter. (#7732) (Thanks @ThreeFive-O!)
- Allow numeric Ids and name of registered code pages in **Encoding** parameters (#7636) (Thanks
  @iSazonov!)
- Fix `Rename-Item -Path` with wildcard char (#7398) (Thanks @kwkam!)
- When using `Start-Transcript` and file exists, empty file rather than deleting (#8131) (Thanks
  @paalbra!)
- Make `Add-Type` open source files with **FileAccess.Read** and **FileShare.Read** explicitly
  (#7915) (Thanks @IISResetMe!)
- Fix `Enter-PSSession -ContainerId` for the latest Windows (#7883)
- Ensure **NestedModules** property gets populated by `Test-ModuleManifest` (#7859)
- Add `%F` case to `Get-Date` -UFormat (#7630) (Thanks @britishben!)
- Fix `Set-Service -Status Stopped` to stop services with dependencies (#5525) (Thanks @zhenggu!)

<!-- Link references -->
[about_Numeric_Literals]: /powershell/module/Microsoft.PowerShell.Core/About/about_numeric_literals
[Experimental Features]: /powershell/module/Microsoft.PowerShell.Core/About/about_Experimental_Features
[PSDrive]: /powershell/module/microsoft.powershell.management/new-psdrive
