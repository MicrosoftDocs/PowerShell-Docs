---
description: This article lists the modules and cmdlets that are included in various versions of PowerShell.
ms.date: 01/17/2025
title: Release history of modules and cmdlets
---
# Release history of modules and cmdlets

This article lists the modules and cmdlets that are included in various versions of PowerShell. This
is a summary of information found in the release notes. More detailed information can be found in
the release notes:

- [What's new in PowerShell 7.5][32]
- [What's new in PowerShell 7.4][31]
- [What's new in PowerShell 7.3][30]
- [What's new in PowerShell 7.2][29]
- [What's new in PowerShell 7.1][04]
- [What's new in PowerShell 7.0][03]

This is a work in progress. Please help us keep this information fresh.

## Module release history

|             ModuleName / PSVersion              |       5.1       |       7.4       |       7.5       |       7.6       |                    Note                     |
| ----------------------------------------------- | --------------- | --------------- | --------------- | --------------- | ------------------------------------------- |
| [CimCmdlets][05]                                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                                |
| [ISE (introduced in 2.0)][06]                   | ![Included][01] |                 |                 |                 | Windows only                                |
| [Microsoft.PowerShell.Archive][07]              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.PowerShell.Core][08]                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.PowerShell.Diagnostics][09]          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                                |
| [Microsoft.PowerShell.Host][10]                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.PowerShell.LocalAccounts][11]        | ![Included][01] |                 |                 |                 | Windows only (64-bit only)                  |
| [Microsoft.PowerShell.Management][12]           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.PowerShell.ODataUtils][13]           | ![Included][01] |                 |                 |                 | Windows only                                |
| [Microsoft.PowerShell.Operation.Validation][14] | ![Included][01] |                 |                 |                 | Windows only                                |
| [Microsoft.PowerShell.PSResourceGet][15]        |                 | ![Included][01] | ![Included][01] | ![Included][01] | New versions available from the Gallery     |
| [Microsoft.PowerShell.Security][16]             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.PowerShell.Utility][17]              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [Microsoft.WsMan.Management][18]                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                                |
| [PackageManagement][19]                         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                             |
| [PowershellGet 1.1][20]                         | ![Included][01] |                 |                 |                 | Must upgrade to v2.x                        |
| [PowershellGet 2.x][20]                         |                 | ![Included][01] | ![Included][01] | ![Included][01] | New versions available from the Gallery     |
| [PSDesiredStateConfiguration 1.1][21]           | ![Included][01] |                 |                 |                 | Removed in 7.2 - available from the Gallery |
| [PSDesiredStateConfiguration 2.x][22]           |                 |                 |                 |                 | Removed in 7.2 - available from the Gallery |
| [PSDesiredStateConfiguration 3.x][23]           |                 |                 |                 |                 | Preview available from the Gallery          |
| [PSDiagnostics][24]                             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                                |
| [PSReadLine][25]                                | v1.x            | v2.3.4          | v2.3.4          | v2.3.6          | New versions available from the Gallery     |
| [PSScheduledJob][26]                            | ![Included][01] |                 |                 |                 | Windows only                                |
| [PSWorkflow][27]                                | ![Included][01] |                 |                 |                 | Windows only                                |
| [PSWorkflowUtility][27]                         | ![Included][01] |                 |                 |                 | Windows only                                |
| [ThreadJob][28]                                 |                 | ![Included][01] | ![Included][01] | ![Included][01] | Can be installed in PowerShell 5.1          |

## Cmdlet release history

### CimCmdlets

|         Cmdlet name         |       5.1       |       7.4       |       7.5       |       7.6       |     Note     |
| --------------------------- | --------------- | --------------- | --------------- | --------------- | ------------ |
| Export-BinaryMiLog          | ![Included][01] |                 |                 |                 | Windows only |
| Get-CimAssociatedInstance   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-CimClass                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-CimInstance             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-CimSession              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Import-BinaryMiLog          | ![Included][01] |                 |                 |                 | Windows only |
| Invoke-CimMethod            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| New-CimInstance             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| New-CimSession              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| New-CimSessionOption        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Register-CimIndicationEvent | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Remove-CimInstance          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Remove-CimSession           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Set-CimInstance             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |

### ISE (introduced in 2.0)

This modules is only available in Windows PowerShell.

|    Cmdlet name    |       5.1       | Note |
| ----------------- | --------------- | ---- |
| Get-IseSnippet    | ![Included][01] |      |
| Import-IseSnippet | ![Included][01] |      |
| New-IseSnippet    | ![Included][01] |      |

### Microsoft.PowerShell.Archive

|   Cmdlet name    |       5.1       |       7.4       |       7.5       |       7.6       | Note |
| ---------------- | --------------- | --------------- | --------------- | --------------- | ---- |
| Compress-Archive | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Expand-Archive   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |

### Microsoft.PowerShell.Core

|            Cmdlet name            |       5.1       |       7.4       |       7.5       |       7.6       |                    Note                    |
| --------------------------------- | --------------- | --------------- | --------------- | --------------- | ------------------------------------------ |
| Add-History                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Add-PSSnapin                      | ![Included][01] |                 |                 |                 | Windows only                               |
| Clear-History                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Clear-Host                        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Connect-PSSession                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Debug-Job                         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Disable-ExperimentalFeature       |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.2                               |
| Disable-PSRemoting                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Disable-PSSessionConfiguration    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Disconnect-PSSession              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Enable-ExperimentalFeature        |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.2                               |
| Enable-PSRemoting                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Enable-PSSessionConfiguration     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Enter-PSHostProcess               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux support in 6.2                 |
| Enter-PSSession                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Exit-PSHostProcess                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux support in 6.2                 |
| Exit-PSSession                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Export-Console                    | ![Included][01] |                 |                 |                 | Windows only                               |
| Export-ModuleMember               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| ForEach-Object                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-Command                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-ExperimentalFeature           |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.2                               |
| Get-Help                          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-History                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-Job                           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-Module                        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-PSHostProcessInfo             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux support in 6.2                 |
| Get-PSSession                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-PSSessionCapability           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-PSSessionConfiguration        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Get-PSSnapin                      | ![Included][01] |                 |                 |                 | Windows only                               |
| Get-Verb                          | ![Included][01] |                 |                 |                 | Moved to Microsoft.PowerShell.Utility 6.0+ |
| Import-Module                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Invoke-Command                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Invoke-History                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-Module                        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-ModuleManifest                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-PSRoleCapabilityFile          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-PSSession                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-PSSessionConfigurationFile    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux support in 7.3                 |
| New-PSSessionOption               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| New-PSTransportOption             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Out-Default                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Out-Host                          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Out-Null                          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Receive-Job                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Receive-PSSession                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Register-ArgumentCompleter        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Register-PSSessionConfiguration   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Remove-Job                        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Remove-Module                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Remove-PSSession                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Remove-PSSnapin                   | ![Included][01] |                 |                 |                 | Windows only                               |
| Resume-Job                        | ![Included][01] |                 |                 |                 |                                            |
| Save-Help                         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Set-PSDebug                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Set-PSSessionConfiguration        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Set-StrictMode                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Start-Job                         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Stop-Job                          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Switch-Process                    |                 |                 | ![Included][01] | ![Included][01] | Linux and macOS only                       |
| Suspend-Job                       | ![Included][01] |                 |                 |                 | Windows only                               |
| Test-ModuleManifest               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Test-PSSessionConfigurationFile   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Unregister-PSSessionConfiguration | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                               |
| Update-Help                       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Wait-Job                          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |
| Where-Object                      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                            |

### Microsoft.PowerShell.Diagnostics

|  Cmdlet name   |       5.1       |       7.4       |       7.5       |       7.6       |     Note     |
| -------------- | --------------- | --------------- | --------------- | --------------- | ------------ |
| Export-Counter | ![Included][01] |                 |                 |                 | Windows only |
| Get-Counter    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-WinEvent   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Import-Counter | ![Included][01] |                 |                 |                 | Windows only |
| New-WinEvent   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |

### Microsoft.PowerShell.Host

|   Cmdlet name    |       5.1       |       7.4       |       7.5       |       7.6       | Note |
| ---------------- | --------------- | --------------- | --------------- | --------------- | ---- |
| Start-Transcript | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Stop-Transcript  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |

### Microsoft.PowerShell.LocalAccounts (64-bit only)

This modules is only available in Windows PowerShell.

|       Cmdlet name       |       5.1       | Note |
| ----------------------- | --------------- | ---- |
| Add-LocalGroupMember    | ![Included][01] |      |
| Disable-LocalUser       | ![Included][01] |      |
| Enable-LocalUser        | ![Included][01] |      |
| Get-LocalGroup          | ![Included][01] |      |
| Get-LocalGroupMember    | ![Included][01] |      |
| Get-LocalUser           | ![Included][01] |      |
| New-LocalGroup          | ![Included][01] |      |
| New-LocalUser           | ![Included][01] |      |
| Remove-LocalGroup       | ![Included][01] |      |
| Remove-LocalGroupMember | ![Included][01] |      |
| Remove-LocalUser        | ![Included][01] |      |
| Rename-LocalGroup       | ![Included][01] |      |
| Rename-LocalUser        | ![Included][01] |      |
| Set-LocalGroup          | ![Included][01] |      |
| Set-LocalUser           | ![Included][01] |      |

### Microsoft.PowerShell.Management

|          Cmdlet name          |       5.1       |       7.4       |       7.5       |       7.6       |               Note               |
| ----------------------------- | --------------- | --------------- | --------------- | --------------- | -------------------------------- |
| Add-Computer                  | ![Included][01] |                 |                 |                 | Windows only                     |
| Add-Content                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Checkpoint-Computer           | ![Included][01] |                 |                 |                 | Windows only                     |
| Clear-Content                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Clear-EventLog                | ![Included][01] |                 |                 |                 | Windows only                     |
| Clear-Item                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Clear-ItemProperty            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Clear-RecycleBin              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Complete-Transaction          | ![Included][01] |                 |                 |                 | Windows only                     |
| Convert-Path                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Copy-Item                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Copy-ItemProperty             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Debug-Process                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Disable-ComputerRestore       | ![Included][01] |                 |                 |                 | Windows only                     |
| Enable-ComputerRestore        | ![Included][01] |                 |                 |                 | Windows only                     |
| Get-ChildItem                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-Clipboard                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-ComputerInfo              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Get-ComputerRestorePoint      | ![Included][01] |                 |                 |                 | Windows only                     |
| Get-Content                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-ControlPanelItem          | ![Included][01] |                 |                 |                 | Windows only                     |
| Get-EventLog                  | ![Included][01] |                 |                 |                 | Windows only                     |
| Get-HotFix                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Get-Item                      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-ItemProperty              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-ItemPropertyValue         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-Location                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-Process                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-PSDrive                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-PSProvider                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Get-Service                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Get-TimeZone                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Get-Transaction               | ![Included][01] |                 |                 |                 | Windows only                     |
| Get-WmiObject                 | ![Included][01] |                 |                 |                 | Windows only                     |
| Invoke-Item                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Invoke-WmiMethod              | ![Included][01] |                 |                 |                 | Windows only                     |
| Join-Path                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Limit-EventLog                | ![Included][01] |                 |                 |                 | Windows only                     |
| Move-Item                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Move-ItemProperty             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| New-EventLog                  | ![Included][01] |                 |                 |                 | Windows only                     |
| New-Item                      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| New-ItemProperty              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| New-PSDrive                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| New-Service                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| New-WebServiceProxy           | ![Included][01] |                 |                 |                 | Windows only                     |
| Pop-Location                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Push-Location                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Register-WmiEvent             | ![Included][01] |                 |                 |                 | Windows only                     |
| Remove-Computer               | ![Included][01] |                 |                 |                 | Windows only                     |
| Remove-EventLog               | ![Included][01] |                 |                 |                 | Windows only                     |
| Remove-Item                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Remove-ItemProperty           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Remove-PSDrive                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Remove-Service                |                 | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Remove-WmiObject              | ![Included][01] |                 |                 |                 | Windows only                     |
| Rename-Computer               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Rename-Item                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Rename-ItemProperty           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Reset-ComputerMachinePassword | ![Included][01] |                 |                 |                 | Windows only                     |
| Resolve-Path                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Restart-Computer              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux/macOS support in 7.1 |
| Restart-Service               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Restore-Computer              | ![Included][01] |                 |                 |                 | Windows only                     |
| Resume-Service                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Set-Clipboard                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Set-Content                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Set-Item                      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Set-ItemProperty              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Set-Location                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Set-Service                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Set-TimeZone                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Set-WmiInstance               | ![Included][01] |                 |                 |                 | Windows only                     |
| Show-ControlPanelItem         | ![Included][01] |                 |                 |                 | Windows only                     |
| Show-EventLog                 | ![Included][01] |                 |                 |                 | Windows only                     |
| Split-Path                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Start-Process                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Start-Service                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Start-Transaction             | ![Included][01] |                 |                 |                 | Windows only                     |
| Stop-Computer                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added Linux/macOS support in 7.1 |
| Stop-Process                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Stop-Service                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Suspend-Service               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                     |
| Test-ComputerSecureChannel    | ![Included][01] |                 |                 |                 | Windows only                     |
| Test-Connection               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Test-Path                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Undo-Transaction              | ![Included][01] |                 |                 |                 | Windows only                     |
| Use-Transaction               | ![Included][01] |                 |                 |                 | Windows only                     |
| Wait-Process                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                  |
| Write-EventLog                | ![Included][01] |                 |                 |                 | Windows only                     |

### Microsoft.PowerShell.ODataUtils


This modules is only available in Windows PowerShell.

|        Cmdlet name        |       5.1       | Note |
| ------------------------- | --------------- | ---- |
| Export-ODataEndpointProxy | ![Included][01] |      |

### Microsoft.PowerShell.Operation.Validation

This modules is only available in Windows PowerShell.

|        Cmdlet name         |       5.1       | Note |
| -------------------------- | --------------- | ---- |
| Get-OperationValidation    | ![Included][01] |      |
| Invoke-OperationValidation | ![Included][01] |      |

### Microsoft.PowerShell.PSResourceGet

|           Cmdlet name           |       7.4       |       7.5       |       7.6       |             Note              |
| ------------------------------- | --------------- | --------------- | --------------- | ----------------------------- |
| Compress-PSResource             |                 | ![Included][01] | ![Included][01] | Added in v1.1.0 of the module |
| Find-PSResource                 | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Get-InstalledPSResource         | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Get-PSResource                  | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Get-PSResourceRepository        | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Get-PSScriptFileInfo            | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Import-PSGetRepository          | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Install-PSResource              | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| New-PSScriptFileInfo            | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Publish-PSResource              | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Register-PSResourceRepository   | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Save-PSResource                 | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Set-PSResourceRepository        | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Test-PSScriptFileInfo           | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Uninstall-PSResource            | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Unregister-PSResourceRepository | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Update-PSModuleManifest         | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Update-PSResource               | ![Included][01] | ![Included][01] | ![Included][01] |                               |
| Update-PSScriptFileInfo         | ![Included][01] | ![Included][01] | ![Included][01] |                               |

### Microsoft.PowerShell.Security

|        Cmdlet name        |       5.1       |       7.4       |       7.5       |       7.6       |                  Note                   |
| ------------------------- | --------------- | --------------- | --------------- | --------------- | --------------------------------------- |
| ConvertFrom-SecureString  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                         |
| ConvertTo-SecureString    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                         |
| Get-Acl                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Get-AuthenticodeSignature | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Get-CmsMessage            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Support for Linux/macOS added in 7.1    |
| Get-Credential            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                         |
| Get-ExecutionPolicy       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Returns **Unrestricted** on Linux/macOS |
| Get-PfxCertificate        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                         |
| New-FileCatalog           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Protect-CmsMessage        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Support for Linux/macOS added in 7.1    |
| Set-Acl                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Set-AuthenticodeSignature | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Set-ExecutionPolicy       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Does nothing on Linux/macOS             |
| Test-FileCatalog          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                            |
| Unprotect-CmsMessage      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Support for Linux/macOS added in 7.1    |

### Microsoft.PowerShell.Utility

|        Cmdlet name        |       5.1       |       7.4       |       7.5       |       7.6       |                   Note                    |
| ------------------------- | --------------- | --------------- | --------------- | --------------- | ----------------------------------------- |
| Add-Member                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Add-Type                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Clear-Variable            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Compare-Object            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Convert-String            | ![Included][01] |                 |                 |                 |                                           |
| ConvertFrom-CliXml        |                 |                 | ![Included][01] | ![Included][01] | Added in 7.5                              |
| ConvertFrom-Csv           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertFrom-Json          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertFrom-Markdown      |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.1                              |
| ConvertFrom-SddlString    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                              |
| ConvertFrom-String        | ![Included][01] |                 |                 |                 |                                           |
| ConvertFrom-StringData    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertTo-CliXml          |                 |                 | ![Included][01] | ![Included][01] | Added in 7.5                              |
| ConvertTo-Csv             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertTo-Html            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertTo-Json            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| ConvertTo-Xml             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Debug-Runspace            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Disable-PSBreakpoint      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Disable-RunspaceDebug     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Enable-PSBreakpoint       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Enable-RunspaceDebug      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Export-Alias              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Export-Clixml             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Export-Csv                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Export-FormatData         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Export-PSSession          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Format-Custom             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Format-Hex                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Format-List               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Format-Table              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Format-Wide               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Alias                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Culture               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Date                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Error                 |                 | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Event                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | No event sources available on Linux/macOS |
| Get-EventSubscriber       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-FileHash              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-FormatData            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Host                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-MarkdownOption        |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.1                              |
| Get-Member                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-PSBreakpoint          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-PSCallStack           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Random                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Runspace              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-RunspaceDebug         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-SecureRandom          |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 7.4                              |
| Get-TraceSource           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-TypeData              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-UICulture             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Unique                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Uptime                |                 | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Variable              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Get-Verb                  |                 | ![Included][01] | ![Included][01] | ![Included][01] | Moved from Microsoft.PowerShell.Core      |
| Group-Object              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-Alias              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-Clixml             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-Csv                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-LocalizedData      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-PowerShellDataFile | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Import-PSSession          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Invoke-Expression         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Invoke-RestMethod         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Invoke-WebRequest         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Join-String               |                 | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Measure-Command           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Measure-Object            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-Alias                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-Event                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | No event sources available on Linux/macOS |
| New-Guid                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-Object                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-TemporaryFile         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-TimeSpan              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| New-Variable              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Out-File                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Out-GridView              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                              |
| Out-Printer               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                              |
| Out-String                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Read-Host                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Register-EngineEvent      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | No event sources available on Linux/macOS |
| Register-ObjectEvent      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Remove-Alias              |                 | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Remove-Event              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | No event sources available on Linux/macOS |
| Remove-PSBreakpoint       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Remove-TypeData           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Remove-Variable           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Select-Object             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Select-String             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Select-Xml                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Send-MailMessage          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Set-Alias                 | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Set-Date                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Set-MarkdownOption        |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.1                              |
| Set-PSBreakpoint          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Set-TraceSource           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Set-Variable              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Show-Command              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only                              |
| Show-Markdown             |                 | ![Included][01] | ![Included][01] | ![Included][01] | Added in 6.1                              |
| Sort-Object               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Start-Sleep               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Tee-Object                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Test-Json                 |                 | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Trace-Command             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Unblock-File              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Added support for macOS in 7.0            |
| Unregister-Event          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | No event sources available on Linux/macOS |
| Update-FormatData         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Update-List               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Update-TypeData           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Wait-Debugger             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Wait-Event                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Debug               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Error               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Host                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Information         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Output              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Progress            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Verbose             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |
| Write-Warning             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |                                           |

### Microsoft.WsMan.Management

|      Cmdlet name       |       5.1       |       7.4       |       7.5       |       7.6       |     Note     |
| ---------------------- | --------------- | --------------- | --------------- | --------------- | ------------ |
| Connect-WSMan          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Disable-WSManCredSSP   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Disconnect-WSMan       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Enable-WSManCredSSP    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-WSManCredSSP       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-WSManInstance      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Invoke-WSManAction     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| New-WSManInstance      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| New-WSManSessionOption | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Remove-WSManInstance   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Set-WSManInstance      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Set-WSManQuickConfig   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Test-WSMan             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |

### PackageManagement

|       Cmdlet name        |       5.1       |       7.4       |       7.5       |       7.6       | Note |
| ------------------------ | --------------- | --------------- | --------------- | --------------- | ---- |
| Find-Package             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Find-PackageProvider     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-Package              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-PackageProvider      | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-PackageSource        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Import-PackageProvider   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Install-Package          | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Install-PackageProvider  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Register-PackageSource   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Save-Package             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Set-PackageSource        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Uninstall-Package        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Unregister-PackageSource | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |

### PowershellGet 2.x

|           Cmdlet name           |       5.1       |       7.4       |       7.5       |       7.6       | Note |
| ------------------------------- | --------------- | --------------- | --------------- | --------------- | ---- |
| Find-Command                    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Find-DscResource                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Find-Module                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Find-RoleCapability             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Find-Script                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-CredsFromCredentialProvider |                 | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-InstalledModule             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-InstalledScript             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-PSRepository                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Install-Module                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Install-Script                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| New-ScriptFileInfo              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Publish-Module                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Publish-Script                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Register-PSRepository           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Save-Module                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Save-Script                     | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Set-PSRepository                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Test-ScriptFileInfo             | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Uninstall-Module                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Uninstall-Script                | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Unregister-PSRepository         | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Update-Module                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Update-ModuleManifest           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Update-Script                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Update-ScriptFileInfo           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |

### PSDesiredStateConfiguration v1.1

This modules is only available from in Windows PowerShell.

|           Cmdlet name            |       5.1       | Note |
| -------------------------------- | --------------- | ---- |
| Configuration                    | ![Included][01] |      |
| Disable-DscDebug                 | ![Included][01] |      |
| Enable-DscDebug                  | ![Included][01] |      |
| Get-DscConfiguration             | ![Included][01] |      |
| Get-DscConfigurationStatus       | ![Included][01] |      |
| Get-DscLocalConfigurationManager | ![Included][01] |      |
| Get-DscResource                  | ![Included][01] |      |
| Invoke-DscResource               | ![Included][01] |      |
| New-DSCCheckSum                  | ![Included][01] |      |
| Publish-DscConfiguration         | ![Included][01] |      |
| Remove-DscConfigurationDocument  | ![Included][01] |      |
| Restore-DscConfiguration         | ![Included][01] |      |
| Set-DscLocalConfigurationManager | ![Included][01] |      |
| Start-DscConfiguration           | ![Included][01] |      |
| Stop-DscConfiguration            | ![Included][01] |      |
| Test-DscConfiguration            | ![Included][01] |      |
| Update-DscConfiguration          | ![Included][01] |      |

### PSDesiredStateConfiguration v2.0.5

This modules is only available from the PowerShell Gallery.

|    Cmdlet name     |      2.0.5      |     Note     |
| ------------------ | --------------- | ------------ |
| Configuration      | ![Included][01] |              |
| Get-DscResource    | ![Included][01] |              |
| Invoke-DscResource | ![Included][01] | Experimental |
| New-DSCCheckSum    | ![Included][01] |              |

### PSDesiredStateConfiguration v3.x - Preview

This modules is only available from the PowerShell Gallery.

|       Cmdlet name       |  3.0 (preview)  |     Note     |
| ----------------------- | --------------- | ------------ |
| Configuration           | ![Included][01] |              |
| ConvertTo-DscJsonSchema | ![Included][01] |              |
| Get-DscResource         | ![Included][01] |              |
| Invoke-DscResource      | ![Included][01] |              |
| New-DscChecksum         | ![Included][01] |              |

### PSDiagnostics

|         Cmdlet name          |       5.1       |       7.4       |       7.5       |       7.6       |     Note     |
| ---------------------------- | --------------- | --------------- | --------------- | --------------- | ------------ |
| Disable-PSTrace              | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Disable-PSWSManCombinedTrace | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Disable-WSManTrace           | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Enable-PSTrace               | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Enable-PSWSManCombinedTrace  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Enable-WSManTrace            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Get-LogProperties            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Set-LogProperties            | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Start-Trace                  | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |
| Stop-Trace                   | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] | Windows only |

### PSReadLine

|         Cmdlet name         |       5.1       |       7.4       |       7.5       |       7.6       | Note |
| --------------------------- | --------------- | --------------- | --------------- | --------------- | ---- |
| Get-PSReadLineKeyHandler    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Get-PSReadLineOption        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| PSConsoleHostReadLine       | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Remove-PSReadLineKeyHandler | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Set-PSReadLineKeyHandler    | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |
| Set-PSReadLineOption        | ![Included][01] | ![Included][01] | ![Included][01] | ![Included][01] |      |

### PSScheduledJob

This modules is only available in Windows PowerShell.

|       Cmdlet name       |       5.1       | Note |
| ----------------------- | --------------- | ---- |
| Add-JobTrigger          | ![Included][01] |      |
| Disable-JobTrigger      | ![Included][01] |      |
| Disable-ScheduledJob    | ![Included][01] |      |
| Enable-JobTrigger       | ![Included][01] |      |
| Enable-ScheduledJob     | ![Included][01] |      |
| Get-JobTrigger          | ![Included][01] |      |
| Get-ScheduledJob        | ![Included][01] |      |
| Get-ScheduledJobOption  | ![Included][01] |      |
| New-JobTrigger          | ![Included][01] |      |
| New-ScheduledJobOption  | ![Included][01] |      |
| Register-ScheduledJob   | ![Included][01] |      |
| Remove-JobTrigger       | ![Included][01] |      |
| Set-JobTrigger          | ![Included][01] |      |
| Set-ScheduledJob        | ![Included][01] |      |
| Set-ScheduledJobOption  | ![Included][01] |      |
| Unregister-ScheduledJob | ![Included][01] |      |

### PSWorkflow & PSWorkflowUtility

This modules is only available in Windows PowerShell.

|          Cmdlet name          |       5.1       | Note |
| ----------------------------- | --------------- | ---- |
| New-PSWorkflowExecutionOption | ![Included][01] |      |
| New-PSWorkflowSession         | ![Included][01] |      |
| Invoke-AsWorkflow             | ![Included][01] |      |

### ThreadJob

|   Cmdlet name   | 5.1 |       7.4       |       7.5       |       7.6       |                Note                |
| --------------- | --- | --------------- | --------------- | --------------- | ---------------------------------- |
| Start-ThreadJob |     | ![Included][01] | ![Included][01] | ![Included][01] | Can be installed in PowerShell 5.1 |

<!-- link references -->
[01]: ../../media/shared/check-mark-button-2705.svg
[02]: ../../media/shared/cross-mark-274c.svg
[03]: /previous-versions/powershell/scripting/whats-new/what-s-new-in-powershell-70
[04]: /previous-versions/powershell/scripting/whats-new/what-s-new-in-powershell-71
[05]: #cimcmdlets
[06]: #ise-introduced-in-20
[07]: #microsoftpowershellarchive
[08]: #microsoftpowershellcore
[09]: #microsoftpowershelldiagnostics
[10]: #microsoftpowershellhost
[11]: #microsoftpowershelllocalaccounts-64-bit-only
[12]: #microsoftpowershellmanagement
[13]: #microsoftpowershellodatautils
[14]: #microsoftpowershelloperationvalidation
[15]: #microsoftpowershellpsresourceget
[16]: #microsoftpowershellsecurity
[17]: #microsoftpowershellutility
[18]: #microsoftwsmanmanagement
[19]: #packagemanagement
[20]: #powershellget-2x
[21]: #psdesiredstateconfiguration-v11
[22]: #psdesiredstateconfiguration-v205
[23]: #psdesiredstateconfiguration-v3x---preview
[24]: #psdiagnostics
[25]: #psreadline
[26]: #psscheduledjob
[27]: #psworkflow--psworkflowutility
[28]: #threadjob
[29]: what-s-new-in-powershell-72.md
[30]: what-s-new-in-powershell-73.md
[31]: what-s-new-in-powershell-74.md
[32]: what-s-new-in-powershell-75.md
