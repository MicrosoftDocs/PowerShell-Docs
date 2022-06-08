---
description: This article lists the modules and cmdlets that are included in various versions of PowerShell.
ms.date: 05/18/2022
title: Release history of modules and cmdlets
---
# Release history of modules and cmdlets

This article lists the modules and cmdlets that are included in various versions of PowerShell. This
is a summary of information found in the release notes. More detailed information can be found in
the release notes:

- [What's new in PowerShell 7.3](what-s-new-in-powershell-73.md)
- [What's new in PowerShell 7.2](what-s-new-in-powershell-72.md)
- [What's new in PowerShell 7.1](what-s-new-in-powershell-71.md)
- [What's new in PowerShell 7.0](what-s-new-in-powershell-70.md)

This is a work in progress. Please help us keep this information fresh.

## Module release history

|          ModuleName / PSVersion           |   5.1    |   7.0    |   7.2    |   7.3    |                    Note                     |
| ----------------------------------------- | -------- | -------- | -------- | -------- | ------------------------------------------- |
| CimCmdlets                                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                                |
| ISE (introduced in 2.0)                   | &#x2705; |          |          |          | Windows only                                |
| Microsoft.PowerShell.Archive              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.PowerShell.Core                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.PowerShell.Diagnostics          | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                                |
| Microsoft.PowerShell.Host                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.PowerShell.LocalAccounts        | &#x2705; |          |          |          | Windows only (64-bit only)                  |
| Microsoft.PowerShell.Management           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.PowerShell.ODataUtils           | &#x2705; |          |          |          | Windows only                                |
| Microsoft.PowerShell.Operation.Validation | &#x2705; |          |          |          | Windows only                                |
| Microsoft.PowerShell.Security             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.PowerShell.Utility              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| Microsoft.WsMan.Management                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                                |
| PackageManagement                         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                             |
| PowershellGet 2.x                         | v1.1     | &#x2705; | &#x2705; | &#x2705; | New versions available from the Gallery     |
| PowershellGet 3.x                         |          |          |          |          | Available from the Gallery                  |
| PSDesiredStateConfiguration 2.x           | &#x2705; | &#x2705; | &#x274c; |          | Removed in 7.2 - available from the Gallery |
| PSDesiredStateConfiguration 3.x           |          |          |          |          | Preview available from the Gallery          |
| PSDiagnostics                             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                                |
| PSReadLine                                | v1.x     | v2.0     | v2.1     | v2.1     | New versions available from the Gallery     |
| PSScheduledJob                            | &#x2705; |          |          |          | Windows only                                |
| PSWorkflow                                | &#x2705; |          |          |          | Windows only                                |
| PSWorkflowUtility                         | &#x2705; |          |          |          | Windows only                                |
| ThreadJob                                 |          | &#x2705; | &#x2705; | &#x2705; | Can be installed in PowerShell 5.1          |

## Cmdlet release history

### CimCmdlets

|         Cmdlet name         |   5.1    |   7.0    |   7.2    |   7.3    |     Note     |
| --------------------------- | -------- | -------- | -------- | -------- | ------------ |
| Export-BinaryMiLog          | &#x2705; |          |          |          | Windows only |
| Get-CimAssociatedInstance   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-CimClass                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-CimInstance             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-CimSession              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Import-BinaryMiLog          | &#x2705; |          |          |          | Windows only |
| Invoke-CimMethod            | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| New-CimInstance             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| New-CimSession              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| New-CimSessionOption        | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Register-CimIndicationEvent | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Remove-CimInstance          | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Remove-CimSession           | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Set-CimInstance             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |

### ISE (introduced in 2.0)

|    Cmdlet name    |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| ----------------- | -------- | --- | --- | --- | ------------ |
| Get-IseSnippet    | &#x2705; |     |     |     | Windows only |
| Import-IseSnippet | &#x2705; |     |     |     | Windows only |
| New-IseSnippet    | &#x2705; |     |     |     | Windows only |

### Microsoft.PowerShell.Archive

|   Cmdlet name    |   5.1    |   7.0    |   7.2    |   7.3    | Note |
| ---------------- | -------- | -------- | -------- | -------- | ---- |
| Compress-Archive | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Expand-Archive   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |

### Microsoft.PowerShell.Core

|            Cmdlet name            |   5.1    |   7.0    |   7.2    |   7.3    |                    Note                    |
| --------------------------------- | -------- | -------- | -------- | -------- | ------------------------------------------ |
| Add-History                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Add-PSSnapin                      | &#x2705; |          |          |          | Windows only                               |
| Clear-History                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Clear-Host                        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Connect-PSSession                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Debug-Job                         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Disable-ExperimentalFeature       |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.2                               |
| Disable-PSRemoting                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Disable-PSSessionConfiguration    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Disconnect-PSSession              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Enable-ExperimentalFeature        |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.2                               |
| Enable-PSRemoting                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Enable-PSSessionConfiguration     | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Enter-PSHostProcess               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux support in 6.2                 |
| Enter-PSSession                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Exit-PSHostProcess                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux support in 6.2                 |
| Exit-PSSession                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Export-Console                    | &#x2705; |          |          |          | Windows only                               |
| Export-ModuleMember               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| ForEach-Object                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-Command                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-ExperimentalFeature           |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.2                               |
| Get-Help                          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-History                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-Job                           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-Module                        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-PSHostProcessInfo             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux support in 6.2                 |
| Get-PSSession                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-PSSessionCapability           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-PSSessionConfiguration        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Get-PSSnapin                      | &#x2705; |          |          |          | Windows only                               |
| Get-Verb                          | &#x2705; |          |          |          | Moved to Microsoft.PowerShell.Utility 6.0+ |
| Import-Module                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Invoke-Command                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Invoke-History                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-Module                        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-ModuleManifest                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-PSRoleCapabilityFile          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-PSSession                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-PSSessionConfigurationFile    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux support in 7.3                 |
| New-PSSessionOption               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| New-PSTransportOption             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Out-Default                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Out-Host                          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Out-Null                          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Receive-Job                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Receive-PSSession                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Register-ArgumentCompleter        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Register-PSSessionConfiguration   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Remove-Job                        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Remove-Module                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Remove-PSSession                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Remove-PSSnapin                   | &#x2705; |          |          |          | Windows only                               |
| Resume-Job                        | &#x2705; |          |          |          |                                            |
| Save-Help                         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Set-PSDebug                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Set-PSSessionConfiguration        | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Set-StrictMode                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Start-Job                         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Stop-Job                          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Suspend-Job                       | &#x2705; |          |          |          | Windows only                               |
| Test-ModuleManifest               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Test-PSSessionConfigurationFile   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Unregister-PSSessionConfiguration | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                               |
| Update-Help                       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Wait-Job                          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |
| Where-Object                      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                            |

### Microsoft.PowerShell.Diagnostics

|  Cmdlet name   |   5.1    |   7.0    |   7.2    |   7.3    |     Note     |
| -------------- | -------- | -------- | -------- | -------- | ------------ |
| Export-Counter | &#x2705; |          |          |          | Windows only |
| Get-Counter    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-WinEvent   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Import-Counter | &#x2705; |          |          |          | Windows only |
| New-WinEvent   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |

### Microsoft.PowerShell.Host

|   Cmdlet name    |   5.1    |   7.0    |   7.2    |   7.3    | Note |
| ---------------- | -------- | -------- | -------- | -------- | ---- |
| Start-Transcript | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Stop-Transcript  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |

### Microsoft.PowerShell.LocalAccounts (64-bit only)

|       Cmdlet name       |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| ----------------------- | -------- | --- | --- | --- | ------------ |
| Add-LocalGroupMember    | &#x2705; |     |     |     | Windows only |
| Disable-LocalUser       | &#x2705; |     |     |     | Windows only |
| Enable-LocalUser        | &#x2705; |     |     |     | Windows only |
| Get-LocalGroup          | &#x2705; |     |     |     | Windows only |
| Get-LocalGroupMember    | &#x2705; |     |     |     | Windows only |
| Get-LocalUser           | &#x2705; |     |     |     | Windows only |
| New-LocalGroup          | &#x2705; |     |     |     | Windows only |
| New-LocalUser           | &#x2705; |     |     |     | Windows only |
| Remove-LocalGroup       | &#x2705; |     |     |     | Windows only |
| Remove-LocalGroupMember | &#x2705; |     |     |     | Windows only |
| Remove-LocalUser        | &#x2705; |     |     |     | Windows only |
| Rename-LocalGroup       | &#x2705; |     |     |     | Windows only |
| Rename-LocalUser        | &#x2705; |     |     |     | Windows only |
| Set-LocalGroup          | &#x2705; |     |     |     | Windows only |
| Set-LocalUser           | &#x2705; |     |     |     | Windows only |

### Microsoft.PowerShell.Management

|          Cmdlet name          |   5.1    |   7.0    |   7.2    |   7.3    |               Note               |
| ----------------------------- | -------- | -------- | -------- | -------- | -------------------------------- |
| Add-Computer                  | &#x2705; |          |          |          | Windows only                     |
| Add-Content                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Checkpoint-Computer           | &#x2705; |          |          |          | Windows only                     |
| Clear-Content                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Clear-EventLog                | &#x2705; |          |          |          | Windows only                     |
| Clear-Item                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Clear-ItemProperty            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Clear-RecycleBin              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Complete-Transaction          | &#x2705; |          |          |          | Windows only                     |
| Convert-Path                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Copy-Item                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Copy-ItemProperty             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Debug-Process                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Disable-ComputerRestore       | &#x2705; |          |          |          | Windows only                     |
| Enable-ComputerRestore        | &#x2705; |          |          |          | Windows only                     |
| Get-ChildItem                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-Clipboard                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | NotsupportedonmacOS              |
| Get-ComputerInfo              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Get-ComputerRestorePoint      | &#x2705; |          |          |          | Windows only                     |
| Get-Content                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-ControlPanelItem          | &#x2705; |          |          |          | Windows only                     |
| Get-EventLog                  | &#x2705; |          |          |          | Windows only                     |
| Get-HotFix                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Get-Item                      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-ItemProperty              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-ItemPropertyValue         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-Location                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-Process                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-PSDrive                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-PSProvider                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Get-Service                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Get-TimeZone                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Get-Transaction               | &#x2705; |          |          |          | Windows only                     |
| Get-WmiObject                 | &#x2705; |          |          |          | Windows only                     |
| Invoke-Item                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Invoke-WmiMethod              | &#x2705; |          |          |          | Windows only                     |
| Join-Path                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Limit-EventLog                | &#x2705; |          |          |          | Windows only                     |
| Move-Item                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Move-ItemProperty             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| New-EventLog                  | &#x2705; |          |          |          | Windows only                     |
| New-Item                      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| New-ItemProperty              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| New-PSDrive                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| New-Service                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| New-WebServiceProxy           | &#x2705; |          |          |          | Windows only                     |
| Pop-Location                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Push-Location                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Register-WmiEvent             | &#x2705; |          |          |          | Windows only                     |
| Remove-Computer               | &#x2705; |          |          |          | Windows only                     |
| Remove-EventLog               | &#x2705; |          |          |          | Windows only                     |
| Remove-Item                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Remove-ItemProperty           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Remove-PSDrive                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Remove-Service                |          | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Remove-WmiObject              | &#x2705; |          |          |          | Windows only                     |
| Rename-Computer               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Rename-Item                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Rename-ItemProperty           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Reset-ComputerMachinePassword | &#x2705; |          |          |          | Windows only                     |
| Resolve-Path                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Restart-Computer              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux/macOS support in 7.1 |
| Restart-Service               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Restore-Computer              | &#x2705; |          |          |          | Windows only                     |
| Resume-Service                | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Set-Clipboard                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Set-Content                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Set-Item                      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Set-ItemProperty              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Set-Location                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Set-Service                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Set-TimeZone                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Set-WmiInstance               | &#x2705; |          |          |          | Windows only                     |
| Show-ControlPanelItem         | &#x2705; |          |          |          | Windows only                     |
| Show-EventLog                 | &#x2705; |          |          |          | Windows only                     |
| Split-Path                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Start-Process                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Start-Service                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Start-Transaction             | &#x2705; |          |          |          | Windows only                     |
| Stop-Computer                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added Linux/macOS support in 7.1 |
| Stop-Process                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Stop-Service                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Suspend-Service               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                     |
| Test-ComputerSecureChannel    | &#x2705; |          |          |          | Windows only                     |
| Test-Connection               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Test-Path                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                  |
| Undo-Transaction              | &#x2705; |          |          |          | Windows only                     |
| Use-Transaction               | &#x2705; |          |          |          | Windows only                     |
| Wait-Process                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Does not work on Linux/macOS     |
| Write-EventLog                | &#x2705; |          |          |          | Windows only                     |

### Microsoft.PowerShell.ODataUtils

|        Cmdlet name        |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| ------------------------- | -------- | --- | --- | --- | ------------ |
| Export-ODataEndpointProxy | &#x2705; |     |     |     | Windows only |

### Microsoft.PowerShell.Operation.Validation

|        Cmdlet name         |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| -------------------------- | -------- | --- | --- | --- | ------------ |
| Get-OperationValidation    | &#x2705; |     |     |     | Windows only |
| Invoke-OperationValidation | &#x2705; |     |     |     | Windows only |

### Microsoft.PowerShell.Security

|        Cmdlet name        |   5.1    |   7.0    |   7.2    |   7.3    |                  Note                   |
| ------------------------- | -------- | -------- | -------- | -------- | --------------------------------------- |
| ConvertFrom-SecureString  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                         |
| ConvertTo-SecureString    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                         |
| Get-Acl                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Get-AuthenticodeSignature | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Get-CmsMessage            | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Support for Linux/macOS added in 7.1    |
| Get-Credential            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                         |
| Get-ExecutionPolicy       | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Returns **Unrestricted** on Linux/macOS |
| Get-PfxCertificate        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                         |
| New-FileCatalog           | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Protect-CmsMessage        | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Support for Linux/macOS added in 7.1    |
| Set-Acl                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Set-AuthenticodeSignature | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Set-ExecutionPolicy       | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Does nothing on Linux/macOS             |
| Test-FileCatalog          | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                            |
| Unprotect-CmsMessage      | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Support for Linux/macOS added in 7.1    |

### Microsoft.PowerShell.Utility

|        Cmdlet name        |   5.1    |   7.0    |   7.2    |   7.3    |                   Note                    |
| ------------------------- | -------- | -------- | -------- | -------- | ----------------------------------------- |
| Add-Member                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Add-Type                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Clear-Variable            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Compare-Object            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertFrom-Csv           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertFrom-Json          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertFrom-Markdown      |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.1                              |
| ConvertFrom-SddlString    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                              |
| ConvertFrom-String        | &#x2705; |          |          |          |                                           |
| ConvertFrom-StringData    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Convert-String            | &#x2705; |          |          |          |                                           |
| ConvertTo-Csv             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertTo-Html            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertTo-Json            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| ConvertTo-Xml             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Debug-Runspace            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Disable-PSBreakpoint      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Disable-RunspaceDebug     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Enable-PSBreakpoint       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Enable-RunspaceDebug      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Export-Alias              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Export-Clixml             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Export-Csv                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Export-FormatData         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Export-PSSession          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Format-Custom             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Format-Hex                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Format-List               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Format-Table              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Format-Wide               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Alias                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Culture               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Date                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Error                 |          | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Event                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | No event sources available on Linux/macOS |
| Get-EventSubscriber       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-FileHash              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-FormatData            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Host                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-MarkdownOption        |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.1                              |
| Get-Member                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-PSBreakpoint          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-PSCallStack           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Random                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Runspace              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-RunspaceDebug         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-TraceSource           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-TypeData              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-UICulture             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Unique                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Uptime                |          | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Variable              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Get-Verb                  |          | &#x2705; | &#x2705; | &#x2705; | Moved from Microsoft.PowerShell.Core      |
| Group-Object              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-Alias              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-Clixml             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-Csv                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-LocalizedData      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-PowerShellDataFile | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Import-PSSession          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Invoke-Expression         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Invoke-RestMethod         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Invoke-WebRequest         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Join-String               |          | &#x2705; | &#x2705; | &#x2705; |                                           |
| Measure-Command           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Measure-Object            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-Alias                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-Event                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; | No event sources available on Linux/macOS |
| New-Guid                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-Object                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-TemporaryFile         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-TimeSpan              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| New-Variable              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Out-File                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Out-GridView              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                              |
| Out-Printer               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                              |
| Out-String                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Read-Host                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Register-EngineEvent      | &#x2705; | &#x2705; | &#x2705; | &#x2705; | No event sources available on Linux/macOS |
| Register-ObjectEvent      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Remove-Alias              |          | &#x2705; | &#x2705; | &#x2705; |                                           |
| Remove-Event              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | No event sources available on Linux/macOS |
| Remove-PSBreakpoint       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Remove-TypeData           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Remove-Variable           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Select-Object             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Select-String             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Select-Xml                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Send-MailMessage          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Set-Alias                 | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Set-Date                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Set-MarkdownOption        |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.1                              |
| Set-PSBreakpoint          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Set-TraceSource           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Set-Variable              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Show-Command              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only                              |
| Show-Markdown             |          | &#x2705; | &#x2705; | &#x2705; | Added in 6.1                              |
| Sort-Object               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Start-Sleep               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Tee-Object                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Test-Json                 |          | &#x2705; | &#x2705; | &#x2705; |                                           |
| Trace-Command             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Unblock-File              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Added support for macOS in 7.0            |
| Unregister-Event          | &#x2705; | &#x2705; | &#x2705; | &#x2705; | No event sources available on Linux/macOS |
| Update-FormatData         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Update-List               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Update-TypeData           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Wait-Debugger             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Wait-Event                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Debug               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Error               | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Host                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Information         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Output              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Progress            | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Verbose             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |
| Write-Warning             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |                                           |

### Microsoft.WsMan.Management

|      Cmdlet name       |   5.1    |   7.0    |   7.2    |   7.3    |     Note     |
| ---------------------- | -------- | -------- | -------- | -------- | ------------ |
| Connect-WSMan          | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Disable-WSManCredSSP   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Disconnect-WSMan       | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Enable-WSManCredSSP    | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-WSManCredSSP       | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-WSManInstance      | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Invoke-WSManAction     | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| New-WSManInstance      | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| New-WSManSessionOption | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Remove-WSManInstance   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Set-WSManInstance      | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Set-WSManQuickConfig   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Test-WSMan             | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |

### PackageManagement

|       Cmdlet name        |   5.1    |   7.0    |   7.2    |   7.3    | Note |
| ------------------------ | -------- | -------- | -------- | -------- | ---- |
| Find-Package             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Find-PackageProvider     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-Package              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-PackageProvider      | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-PackageSource        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Import-PackageProvider   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Install-Package          | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Install-PackageProvider  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Register-PackageSource   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Save-Package             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Set-PackageSource        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Uninstall-Package        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Unregister-PackageSource | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |

### PowershellGet 2.x

|           Cmdlet name           |   5.1    |   7.0    |   7.2    |   7.3    | Note |
| ------------------------------- | -------- | -------- | -------- | -------- | ---- |
| Find-Command                    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Find-DscResource                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Find-Module                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Find-RoleCapability             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Find-Script                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-CredsFromCredentialProvider |          | &#x2705; | &#x2705; | &#x2705; |      |
| Get-InstalledModule             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-InstalledScript             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-PSRepository                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Install-Module                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Install-Script                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| New-ScriptFileInfo              | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Publish-Module                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Publish-Script                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Register-PSRepository           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Save-Module                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Save-Script                     | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Set-PSRepository                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Test-ScriptFileInfo             | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Uninstall-Module                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Uninstall-Script                | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Unregister-PSRepository         | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Update-Module                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Update-ModuleManifest           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Update-Script                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Update-ScriptFileInfo           | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |

### PowershellGet 3.x - Preview

|              Name               | Note |
| ------------------------------- | ---- |
| Find-PSResource                 |      |
| Get-InstalledPSResource         |      |
| Get-PSResourceRepository        |      |
| Install-PSResource              |      |
| Publish-PSResource              |      |
| Register-PSResourceRepository   |      |
| Save-PSResource                 |      |
| Set-PSResourceRepository        |      |
| Uninstall-PSResource            |      |
| Unregister-PSResourceRepository |      |
| Update-PSResource               |      |

### PSDesiredStateConfiguration v2.x

|           Cmdlet name            |   5.1    |   7.0    | 7.2 | 7.3 |     Note     |
| -------------------------------- | -------- | -------- | --- | --- | ------------ |
| Configuration                    | &#x2705; | &#x2705; |     |     |              |
| Disable-DscDebug                 | &#x2705; |          |     |     | Windows only |
| Enable-DscDebug                  | &#x2705; |          |     |     | Windows only |
| Get-DscConfiguration             | &#x2705; |          |     |     | Windows only |
| Get-DscConfigurationStatus       | &#x2705; |          |     |     | Windows only |
| Get-DscLocalConfigurationManager | &#x2705; |          |     |     | Windows only |
| Get-DscResource                  | &#x2705; | &#x2705; |     |     |              |
| Invoke-DscResource               | &#x2705; | &#x2705; |     |     | Experimental |
| New-DSCCheckSum                  | &#x2705; | &#x2705; |     |     |              |
| Publish-DscConfiguration         | &#x2705; |          |     |     | Windows only |
| Remove-DscConfigurationDocument  | &#x2705; |          |     |     | Windows only |
| Restore-DscConfiguration         | &#x2705; |          |     |     | Windows only |
| Set-DscLocalConfigurationManager | &#x2705; |          |     |     | Windows only |
| Start-DscConfiguration           | &#x2705; |          |     |     | Windows only |
| Stop-DscConfiguration            | &#x2705; |          |     |     | Windows only |
| Test-DscConfiguration            | &#x2705; |          |     |     | Windows only |
| Update-DscConfiguration          | &#x2705; |          |     |     | Windows only |

### PSDesiredStateConfiguration v3.x - Preview

|       Cmdlet name       |     Note     |
| ----------------------- | ------------ |
| Configuration           |              |
| ConvertTo-DscJsonSchema |              |
| Get-DscResource         |              |
| Invoke-DscResource      | Experimental |
| New-DscChecksum         |              |

### PSDiagnostics

| Cmdlet name                  | 5.1      | 7.0      | 7.2      | 7.3      | Note         |
|------------------------------|----------|----------|----------|----------|--------------|
| Disable-PSTrace              | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Disable-PSWSManCombinedTrace | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Disable-WSManTrace           | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Enable-PSTrace               | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Enable-PSWSManCombinedTrace  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Enable-WSManTrace            | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Get-LogProperties            | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Set-LogProperties            | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Start-Trace                  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |
| Stop-Trace                   | &#x2705; | &#x2705; | &#x2705; | &#x2705; | Windows only |

### PSReadLine

|         Cmdlet name         |   5.1    |   7.0    |   7.2    |   7.3    | Note |
| --------------------------- | -------- | -------- | -------- | -------- | ---- |
| Get-PSReadLineKeyHandler    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Get-PSReadLineOption        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| PSConsoleHostReadLine       | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Remove-PSReadLineKeyHandler | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Set-PSReadLineKeyHandler    | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |
| Set-PSReadLineOption        | &#x2705; | &#x2705; | &#x2705; | &#x2705; |      |

### PSScheduledJob

|       Cmdlet name       |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| ----------------------- | -------- | --- | --- | --- | ------------ |
| Add-JobTrigger          | &#x2705; |     |     |     | Windows only |
| Disable-JobTrigger      | &#x2705; |     |     |     | Windows only |
| Disable-ScheduledJob    | &#x2705; |     |     |     | Windows only |
| Enable-JobTrigger       | &#x2705; |     |     |     | Windows only |
| Enable-ScheduledJob     | &#x2705; |     |     |     | Windows only |
| Get-JobTrigger          | &#x2705; |     |     |     | Windows only |
| Get-ScheduledJob        | &#x2705; |     |     |     | Windows only |
| Get-ScheduledJobOption  | &#x2705; |     |     |     | Windows only |
| New-JobTrigger          | &#x2705; |     |     |     | Windows only |
| New-ScheduledJobOption  | &#x2705; |     |     |     | Windows only |
| Register-ScheduledJob   | &#x2705; |     |     |     | Windows only |
| Remove-JobTrigger       | &#x2705; |     |     |     | Windows only |
| Set-JobTrigger          | &#x2705; |     |     |     | Windows only |
| Set-ScheduledJob        | &#x2705; |     |     |     | Windows only |
| Set-ScheduledJobOption  | &#x2705; |     |     |     | Windows only |
| Unregister-ScheduledJob | &#x2705; |     |     |     | Windows only |

### PSWorkflow & PSWorkflowUtility

|          Cmdlet name          |   5.1    | 7.0 | 7.2 | 7.3 |     Note     |
| ----------------------------- | -------- | --- | --- | --- | ------------ |
| New-PSWorkflowExecutionOption | &#x2705; |     |     |     | Windows only |
| New-PSWorkflowSession         | &#x2705; |     |     |     | Windows only |
| Invoke-AsWorkflow             | &#x2705; |     |     |     | Windows only |

### ThreadJob

|   Cmdlet name   | 5.1 |   7.0    |   7.2    |   7.3    |                Note                |
| --------------- | --- | -------- | -------- | -------- | ---------------------------------- |
| Start-ThreadJob |     | &#x2705; | &#x2705; | &#x2705; | Can be installed in PowerShell 5.1 |
