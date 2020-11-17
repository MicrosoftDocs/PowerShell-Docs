---
ms.date: 02/03/2020
keywords:  powershell,core
title:  Release history of modules and cmdlets
description: This article lists the modules and cmdlets that are included in various versions of PowerShell.
---
# Release history of modules and cmdlets

This article lists the modules and cmdlets that are included in various versions of PowerShell. This
is a summary of information found in the release notes. More detailed information can be found in
the release notes:

- [What's new in PowerShell 7.0](what-s-new-in-powershell-70.md)

This is a work in progress. Please help us keep this information fresh.

## Module release history

|         Module Name / PS Version          |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| ----------------------------------------- | :-----: | :-----: | :-----: | :-----: | ------------ |
| CimCmdlets                                | &check; | &check; | &check; | &check; | Windows only |
| ISE (introduced in 2.0)                   | &check; |         |         |         | Windows only |
| Microsoft.PowerShell.Archive              | &check; | &check; | &check; | &check; |              |
| Microsoft.PowerShell.Core                 | &check; | &check; | &check; | &check; |              |
| Microsoft.PowerShell.Diagnostics          | &check; | &check; | &check; | &check; | Windows only |
| Microsoft.PowerShell.Host                 | &check; | &check; | &check; | &check; |              |
| Microsoft.PowerShell.LocalAccounts        | &check; |         |         |         | Windows only |
| Microsoft.PowerShell.Management           | &check; | &check; | &check; | &check; |              |
| Microsoft.PowerShell.ODataUtils           | &check; |         |         |         | Windows only |
| Microsoft.PowerShell.Operation.Validation | &check; |         |         |         | Windows only |
| Microsoft.PowerShell.Security             | &check; | &check; | &check; | &check; |              |
| Microsoft.PowerShell.Utility              | &check; | &check; | &check; | &check; |              |
| Microsoft.WsMan.Management                | &check; | &check; | &check; | &check; | Windows only |
| PackageManagement                         | &check; | &check; | &check; | &check; |              |
| PowershellGet                             | &check; | &check; | &check; | &check; |              |
| PSDesiredStateConfiguration               | &check; | &check; | &check; | &check; |              |
| PSDiagnostics                             | &check; | &check; | &check; | &check; | Windows only |
| PSReadline 1.x                            | &check; |         |         |         | Windows only |
| PSReadline 2.0                            |         | &check; | &check; |         |              |
| PSReadline 2.1                            |         |         |         | &check; |              |
| PSScheduledJob                            | &check; |         |         |         | Windows only |
| PSWorkflow                                | &check; |         |         |         | Windows only |
| PSWorkflowUtility                         | &check; |         |         |         | Windows only |
| ThreadJob                                 |         | &check; | &check; | &check; | Can be installed in PowerShell 5.1 |

## Cmdlet release history

### CimCmdlets

|         Cmdlet name         |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| --------------------------- | :-----: | :-----: | :-----: | :-----: | ------------ |
| Export-BinaryMiLog          | &check; | &check; | &check; | &check; | Windows only |
| Get-CimAssociatedInstance   | &check; | &check; | &check; | &check; | Windows only |
| Get-CimClass                | &check; | &check; | &check; | &check; | Windows only |
| Get-CimInstance             | &check; | &check; | &check; | &check; | Windows only |
| Get-CimSession              | &check; | &check; | &check; | &check; | Windows only |
| Import-BinaryMiLog          | &check; | &check; | &check; | &check; | Windows only |
| Invoke-CimMethod            | &check; | &check; | &check; | &check; | Windows only |
| New-CimInstance             | &check; | &check; | &check; | &check; | Windows only |
| New-CimSession              | &check; | &check; | &check; | &check; | Windows only |
| New-CimSessionOption        | &check; | &check; | &check; | &check; | Windows only |
| Register-CimIndicationEvent | &check; | &check; | &check; | &check; | Windows only |
| Remove-CimInstance          | &check; | &check; | &check; | &check; | Windows only |
| Remove-CimSession           | &check; | &check; | &check; | &check; | Windows only |
| Set-CimInstance             | &check; | &check; | &check; | &check; | Windows only |

### ISE (introduced in 2.0)

|    Cmdlet name    |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| ----------------- | :-----: | :--- | :---: | :---: | ------------ |
| Get-IseSnippet    | &check; |      |       |       | Windows only |
| Import-IseSnippet | &check; |      |       |       | Windows only |
| New-IseSnippet    | &check; |      |       |       | Windows only |

### Microsoft.PowerShell.Archive

|   Cmdlet name    |   5.1   |   6.x   |   7.0   |   7.1   | Note |
| ---------------- | :-----: | :-----: | :-----: | :-----: | ---- |
| Compress-Archive | &check; | &check; | &check; | &check; |      |
| Expand-Archive   | &check; | &check; | &check; | &check; |      |

### Microsoft.PowerShell.Core

|            Cmdlet name            |   5.1   |   6.x   |   7.0   |   7.1   |            Note            |
| --------------------------------- | :-----: | :-----: | :-----: | :-----: | -------------------------- |
| Add-History                       | &check; | &check; | &check; | &check; |                            |
| Add-PSSnapin                      | &check; |         |         |         | Windows only               |
| Clear-History                     | &check; | &check; | &check; | &check; |                            |
| Clear-Host                        | &check; | &check; | &check; | &check; |                            |
| Connect-PSSession                 | &check; | &check; | &check; | &check; | Windows only               |
| Debug-Job                         | &check; | &check; | &check; | &check; |                            |
| Disable-ExperimentalFeature       |         |   6.2   | &check; | &check; |                            |
| Disable-PSRemoting                | &check; | &check; | &check; | &check; | Windows only               |
| Disable-PSSessionConfiguration    | &check; | &check; | &check; | &check; | Windows only               |
| Disconnect-PSSession              | &check; | &check; | &check; | &check; | Windows only               |
| Enable-ExperimentalFeature        |         |   6.2   | &check; | &check; |                            |
| Enable-PSRemoting                 | &check; | &check; | &check; | &check; | Windows only               |
| Enable-PSSessionConfiguration     | &check; | &check; | &check; | &check; | Windows only               |
| Enter-PSHostProcess               | &check; | &check; | &check; | &check; | Added Linux support in 6.2 |
| Enter-PSSession                   | &check; | &check; | &check; | &check; |                            |
| Exit-PSHostProcess                | &check; | &check; | &check; | &check; | Added Linux support in 6.2 |
| Exit-PSSession                    | &check; | &check; | &check; | &check; |                            |
| Export-Console                    | &check; |         |         |         | Windows only               |
| Export-ModuleMember               | &check; | &check; | &check; | &check; |                            |
| ForEach-Object                    | &check; | &check; | &check; | &check; |                            |
| Get-Command                       | &check; | &check; | &check; | &check; |                            |
| Get-ExperimentalFeature           |         |   6.2   | &check; | &check; |                            |
| Get-Help                          | &check; | &check; | &check; | &check; |                            |
| Get-History                       | &check; | &check; | &check; | &check; |                            |
| Get-Job                           | &check; | &check; | &check; | &check; |                            |
| Get-Module                        | &check; | &check; | &check; | &check; |                            |
| Get-PSHostProcessInfo             | &check; | &check; | &check; | &check; | Added Linux support in 6.2 |
| Get-PSSession                     | &check; | &check; | &check; | &check; |                            |
| Get-PSSessionCapability           | &check; | &check; | &check; | &check; |                            |
| Get-PSSessionConfiguration        | &check; | &check; | &check; | &check; |                            |
| Get-PSSnapin                      | &check; |         |         |         | Windows only               |
| Get-Verb                          | &check; |         |         |         | Moved to Microsoft.PowerShell.Utility 6.0+ |
| Import-Module                     | &check; | &check; | &check; | &check; |                            |
| Invoke-Command                    | &check; | &check; | &check; | &check; |                            |
| Invoke-History                    | &check; | &check; | &check; | &check; |                            |
| New-Module                        | &check; | &check; | &check; | &check; |                            |
| New-ModuleManifest                | &check; | &check; | &check; | &check; |                            |
| New-PSRoleCapabilityFile          | &check; | &check; | &check; | &check; |                            |
| New-PSSession                     | &check; | &check; | &check; | &check; |                            |
| New-PSSessionConfigurationFile    | &check; | &check; | &check; | &check; | Windows only               |
| New-PSSessionOption               | &check; | &check; | &check; | &check; |                            |
| New-PSTransportOption             | &check; | &check; | &check; | &check; |                            |
| Out-Default                       | &check; | &check; | &check; | &check; |                            |
| Out-Host                          | &check; | &check; | &check; | &check; |                            |
| Out-Null                          | &check; | &check; | &check; | &check; |                            |
| Receive-Job                       | &check; | &check; | &check; | &check; |                            |
| Receive-PSSession                 | &check; | &check; | &check; | &check; | Windows only               |
| Register-ArgumentCompleter        | &check; | &check; | &check; | &check; |                            |
| Register-PSSessionConfiguration   | &check; | &check; | &check; | &check; | Windows only               |
| Remove-Job                        | &check; | &check; | &check; | &check; |                            |
| Remove-Module                     | &check; | &check; | &check; | &check; |                            |
| Remove-PSSession                  | &check; | &check; | &check; | &check; |                            |
| Remove-PSSnapin                   | &check; |         |         |         | Windows only               |
| Resume-Job                        | &check; |         |         |         |                            |
| Save-Help                         | &check; | &check; | &check; | &check; |                            |
| Set-PSDebug                       | &check; | &check; | &check; | &check; |                            |
| Set-PSSessionConfiguration        | &check; | &check; | &check; | &check; | Windows only               |
| Set-StrictMode                    | &check; | &check; | &check; | &check; |                            |
| Start-Job                         | &check; | &check; | &check; | &check; |                            |
| Stop-Job                          | &check; | &check; | &check; | &check; |                            |
| Suspend-Job                       | &check; |         |         |         | Windows only               |
| Test-ModuleManifest               | &check; | &check; | &check; | &check; |                            |
| Test-PSSessionConfigurationFile   | &check; | &check; | &check; | &check; | Windows only               |
| Unregister-PSSessionConfiguration | &check; | &check; | &check; | &check; | Windows only               |
| Update-Help                       | &check; | &check; | &check; | &check; |                            |
| Wait-Job                          | &check; | &check; | &check; | &check; |                            |
| Where-Object                      | &check; | &check; | &check; | &check; |                            |

### Microsoft.PowerShell.Diagnostics

|  Cmdlet name   |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| -------------- | :-----: | :-----: | :-----: | :-----: | ------------ |
| Export-Counter | &check; |         |         |         | Windows only |
| Get-Counter    | &check; |         | &check; | &check; | Windows only |
| Get-WinEvent   | &check; | &check; | &check; | &check; | Windows only |
| Import-Counter | &check; |         |         |         | Windows only |
| New-WinEvent   | &check; | &check; | &check; | &check; | Windows only |

### Microsoft.PowerShell.Host

|   Cmdlet name    |   5.1   |   6.x   |   7.0   |   7.1   | Note |
| ---------------- | :-----: | :-----: | :-----: | :-----: | ---- |
| Start-Transcript | &check; | &check; | &check; | &check; |      |
| Stop-Transcript  | &check; | &check; | &check; | &check; |      |

### Microsoft.PowerShell.LocalAccounts

|       Cmdlet name       |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| ----------------------- | :-----: | :--- | :---: | :---: | ------------ |
| Add-LocalGroupMember    | &check; |      |       |       | Windows only |
| Disable-LocalUser       | &check; |      |       |       | Windows only |
| Enable-LocalUser        | &check; |      |       |       | Windows only |
| Get-LocalGroup          | &check; |      |       |       | Windows only |
| Get-LocalGroupMember    | &check; |      |       |       | Windows only |
| Get-LocalUser           | &check; |      |       |       | Windows only |
| New-LocalGroup          | &check; |      |       |       | Windows only |
| New-LocalUser           | &check; |      |       |       | Windows only |
| Remove-LocalGroup       | &check; |      |       |       | Windows only |
| Remove-LocalGroupMember | &check; |      |       |       | Windows only |
| Remove-LocalUser        | &check; |      |       |       | Windows only |
| Rename-LocalGroup       | &check; |      |       |       | Windows only |
| Rename-LocalUser        | &check; |      |       |       | Windows only |
| Set-LocalGroup          | &check; |      |       |       | Windows only |
| Set-LocalUser           | &check; |      |       |       | Windows only |

### Microsoft.PowerShell.Management

|          Cmdlet name          |   5.1   |   6.x   |   7.0   |   7.1   |               Note               |
| ----------------------------- | :-----: | :-----: | :-----: | :-----: | -------------------------------- |
| Add-Computer                  | &check; |         |         |         | Windows only                     |
| Add-Content                   | &check; | &check; | &check; | &check; |                                  |
| Checkpoint-Computer           | &check; |         |         |         | Windows only                     |
| Clear-Content                 | &check; | &check; | &check; | &check; |                                  |
| Clear-EventLog                | &check; |         |         |         | Windows only                     |
| Clear-Item                    | &check; | &check; | &check; | &check; |                                  |
| Clear-ItemProperty            | &check; | &check; | &check; | &check; |                                  |
| Clear-RecycleBin              | &check; |         | &check; | &check; | Windows only                     |
| Complete-Transaction          | &check; |         |         |         | Windows only                     |
| Convert-Path                  | &check; | &check; | &check; | &check; |                                  |
| Copy-Item                     | &check; | &check; | &check; | &check; |                                  |
| Copy-ItemProperty             | &check; | &check; | &check; | &check; |                                  |
| Debug-Process                 | &check; | &check; | &check; | &check; |                                  |
| Disable-ComputerRestore       | &check; |         |         |         | Windows only                     |
| Enable-ComputerRestore        | &check; |         |         |         | Windows only                     |
| Get-ChildItem                 | &check; | &check; | &check; | &check; |                                  |
| Get-Clipboard                 | &check; |         | &check; | &check; | Not supported on macOS           |
| Get-ComputerInfo              | &check; | &check; | &check; | &check; | Windows only                     |
| Get-ComputerRestorePoint      | &check; |         |         |         | Windows only                     |
| Get-Content                   | &check; | &check; | &check; | &check; |                                  |
| Get-ControlPanelItem          | &check; |         |         |         | Windows only                     |
| Get-EventLog                  | &check; |         |         |         | Windows only                     |
| Get-HotFix                    | &check; |         | &check; | &check; | Windows only                     |
| Get-Item                      | &check; | &check; | &check; | &check; |                                  |
| Get-ItemProperty              | &check; | &check; | &check; | &check; |                                  |
| Get-ItemPropertyValue         | &check; | &check; | &check; | &check; |                                  |
| Get-Location                  | &check; | &check; | &check; | &check; |                                  |
| Get-Process                   | &check; | &check; | &check; | &check; |                                  |
| Get-PSDrive                   | &check; | &check; | &check; | &check; |                                  |
| Get-PSProvider                | &check; | &check; | &check; | &check; |                                  |
| Get-Service                   | &check; | &check; | &check; | &check; | Windows only                     |
| Get-TimeZone                  | &check; | &check; | &check; | &check; | Windows only                     |
| Get-Transaction               | &check; |         |         |         | Windows only                     |
| Get-WmiObject                 | &check; |         |         |         | Windows only                     |
| Invoke-Item                   | &check; | &check; | &check; | &check; |                                  |
| Invoke-WmiMethod              | &check; |         |         |         | Windows only                     |
| Join-Path                     | &check; | &check; | &check; | &check; |                                  |
| Limit-EventLog                | &check; |         |         |         | Windows only                     |
| Move-Item                     | &check; | &check; | &check; | &check; |                                  |
| Move-ItemProperty             | &check; | &check; | &check; | &check; |                                  |
| New-EventLog                  | &check; |         |         |         | Windows only                     |
| New-Item                      | &check; | &check; | &check; | &check; |                                  |
| New-ItemProperty              | &check; | &check; | &check; | &check; |                                  |
| New-PSDrive                   | &check; | &check; | &check; | &check; |                                  |
| New-Service                   | &check; | &check; | &check; | &check; | Windows only                     |
| New-WebServiceProxy           | &check; |         |         |         | Windows only                     |
| Pop-Location                  | &check; | &check; | &check; | &check; |                                  |
| Push-Location                 | &check; | &check; | &check; | &check; |                                  |
| Register-WmiEvent             | &check; |         |         |         | Windows only                     |
| Remove-Computer               | &check; |         |         |         | Windows only                     |
| Remove-EventLog               | &check; |         |         |         | Windows only                     |
| Remove-Item                   | &check; | &check; | &check; | &check; |                                  |
| Remove-ItemProperty           | &check; | &check; | &check; | &check; |                                  |
| Remove-PSDrive                | &check; | &check; | &check; | &check; |                                  |
| Remove-Service                |         | &check; | &check; | &check; | Windows only                     |
| Remove-WmiObject              | &check; |         |         |         | Windows only                     |
| Rename-Computer               | &check; | &check; | &check; | &check; | Windows only                     |
| Rename-Item                   | &check; | &check; | &check; | &check; |                                  |
| Rename-ItemProperty           | &check; | &check; | &check; | &check; |                                  |
| Reset-ComputerMachinePassword | &check; |         |         |         | Windows only                     |
| Resolve-Path                  | &check; | &check; | &check; | &check; |                                  |
| Restart-Computer              | &check; | &check; | &check; | &check; | Added Linux/macOS support in 7.1 |
| Restart-Service               | &check; | &check; | &check; | &check; | Windows only                     |
| Restore-Computer              | &check; |         |         |         | Windows only                     |
| Resume-Service                | &check; | &check; | &check; | &check; | Windows only                     |
| Set-Clipboard                 | &check; |         | &check; | &check; |                                  |
| Set-Content                   | &check; | &check; | &check; | &check; |                                  |
| Set-Item                      | &check; | &check; | &check; | &check; |                                  |
| Set-ItemProperty              | &check; | &check; | &check; | &check; |                                  |
| Set-Location                  | &check; | &check; | &check; | &check; |                                  |
| Set-Service                   | &check; | &check; | &check; | &check; | Windows only                     |
| Set-TimeZone                  | &check; | &check; | &check; | &check; | Windows only                     |
| Set-WmiInstance               | &check; |         |         |         | Windows only                     |
| Show-ControlPanelItem         | &check; |         |         |         | Windows only                     |
| Show-EventLog                 | &check; |         |         |         | Windows only                     |
| Split-Path                    | &check; | &check; | &check; | &check; |                                  |
| Start-Process                 | &check; | &check; | &check; | &check; |                                  |
| Start-Service                 | &check; | &check; | &check; | &check; | Windows only                     |
| Start-Transaction             | &check; |         |         |         | Windows only                     |
| Stop-Computer                 | &check; | &check; | &check; | &check; | Added Linux/macOS support in 7.1 |
| Stop-Process                  | &check; | &check; | &check; | &check; |                                  |
| Stop-Service                  | &check; | &check; | &check; | &check; | Windows only                     |
| Suspend-Service               | &check; | &check; | &check; | &check; | Windows only                     |
| Test-ComputerSecureChannel    | &check; |         |         |         | Windows only                     |
| Test-Connection               | &check; | &check; | &check; | &check; |                                  |
| Test-Path                     | &check; | &check; | &check; | &check; |                                  |
| Undo-Transaction              | &check; |         |         |         | Windows only                     |
| Use-Transaction               | &check; |         |         |         | Windows only                     |
| Wait-Process                  | &check; | &check; | &check; | &check; | Does not work on Linux/macOS     |
| Write-EventLog                | &check; |         |         |         | Windows only                     |

### Microsoft.PowerShell.ODataUtils

|        Cmdlet name        |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| ------------------------- | :-----: | :--- | :---: | :---: | ------------ |
| Export-ODataEndpointProxy | &check; |      |       |       | Windows only |

### Microsoft.PowerShell.Operation.Validation

|        Cmdlet name         |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| -------------------------- | :-----: | :--- | :---: | :---: | ------------ |
| Get-OperationValidation    | &check; |      |       |       | Windows only |
| Invoke-OperationValidation | &check; |      |       |       | Windows only |

### Microsoft.PowerShell.Security

|        Cmdlet name        |   5.1   |   6.x   |   7.0   |   7.1   |                  Note                   |
| ------------------------- | :-----: | :-----: | :-----: | :-----: | --------------------------------------- |
| ConvertFrom-SecureString  | &check; | &check; | &check; | &check; |                                         |
| ConvertTo-SecureString    | &check; | &check; | &check; | &check; |                                         |
| Get-Acl                   | &check; | &check; | &check; | &check; | Windows only                            |
| Get-AuthenticodeSignature | &check; | &check; | &check; | &check; | Windows only                            |
| Get-CmsMessage            | &check; | &check; | &check; | &check; | Support for Linux/macOS added in 7.1    |
| Get-Credential            | &check; | &check; | &check; | &check; |                                         |
| Get-ExecutionPolicy       | &check; | &check; | &check; | &check; | Returns **Unrestricted** on Linux/macOS |
| Get-PfxCertificate        | &check; | &check; | &check; | &check; |                                         |
| New-FileCatalog           | &check; | &check; | &check; | &check; | Windows only                            |
| Protect-CmsMessage        | &check; | &check; | &check; | &check; | Support for Linux/macOS added in 7.1    |
| Set-Acl                   | &check; | &check; | &check; | &check; | Windows only                            |
| Set-AuthenticodeSignature | &check; | &check; | &check; | &check; | Windows only                            |
| Set-ExecutionPolicy       | &check; | &check; | &check; | &check; | Does nothing on Linux/macOS             |
| Test-FileCatalog          | &check; | &check; | &check; | &check; | Windows only                            |
| Unprotect-CmsMessage      | &check; | &check; | &check; | &check; | Support for Linux/macOS added in 7.1    |

### Microsoft.PowerShell.Utility

|        Cmdlet name        |   5.1   |   6.x   |   7.0   |   7.1   |                   Note                    |
| ------------------------- | :-----: | :-----: | :-----: | :-----: | ----------------------------------------- |
| Add-Member                | &check; | &check; | &check; | &check; |                                           |
| Add-Type                  | &check; | &check; | &check; | &check; |                                           |
| Clear-Variable            | &check; | &check; | &check; | &check; |                                           |
| Compare-Object            | &check; | &check; | &check; | &check; |                                           |
| ConvertFrom-Csv           | &check; | &check; | &check; | &check; |                                           |
| ConvertFrom-Json          | &check; | &check; | &check; | &check; |                                           |
| ConvertFrom-Markdown      |         |   6.1   | &check; | &check; |                                           |
| ConvertFrom-SddlString    | &check; | &check; | &check; | &check; | Windows only                              |
| ConvertFrom-String        | &check; |         |         |         |                                           |
| ConvertFrom-StringData    | &check; | &check; | &check; | &check; |                                           |
| Convert-String            | &check; |         |         |         |                                           |
| ConvertTo-Csv             | &check; | &check; | &check; | &check; |                                           |
| ConvertTo-Html            | &check; | &check; | &check; | &check; |                                           |
| ConvertTo-Json            | &check; | &check; | &check; | &check; |                                           |
| ConvertTo-Xml             | &check; | &check; | &check; | &check; |                                           |
| Debug-Runspace            | &check; | &check; | &check; | &check; |                                           |
| Disable-PSBreakpoint      | &check; | &check; | &check; | &check; |                                           |
| Disable-RunspaceDebug     | &check; | &check; | &check; | &check; |                                           |
| Enable-PSBreakpoint       | &check; | &check; | &check; | &check; |                                           |
| Enable-RunspaceDebug      | &check; | &check; | &check; | &check; |                                           |
| Export-Alias              | &check; | &check; | &check; | &check; |                                           |
| Export-Clixml             | &check; | &check; | &check; | &check; |                                           |
| Export-Csv                | &check; | &check; | &check; | &check; |                                           |
| Export-FormatData         | &check; | &check; | &check; | &check; |                                           |
| Export-PSSession          | &check; | &check; | &check; | &check; |                                           |
| Format-Custom             | &check; | &check; | &check; | &check; |                                           |
| Format-Hex                | &check; | &check; | &check; | &check; |                                           |
| Format-List               | &check; | &check; | &check; | &check; |                                           |
| Format-Table              | &check; | &check; | &check; | &check; |                                           |
| Format-Wide               | &check; | &check; | &check; | &check; |                                           |
| Get-Alias                 | &check; | &check; | &check; | &check; |                                           |
| Get-Culture               | &check; | &check; | &check; | &check; |                                           |
| Get-Date                  | &check; | &check; | &check; | &check; |                                           |
| Get-Error                 |         |         | &check; | &check; |                                           |
| Get-Event                 | &check; | &check; | &check; | &check; | No event sources available on Linux/macOS |
| Get-EventSubscriber       | &check; | &check; | &check; | &check; |                                           |
| Get-FileHash              | &check; | &check; | &check; | &check; |                                           |
| Get-FormatData            | &check; | &check; | &check; | &check; |                                           |
| Get-Host                  | &check; | &check; | &check; | &check; |                                           |
| Get-MarkdownOption        |         |   6.1   | &check; | &check; |                                           |
| Get-Member                | &check; | &check; | &check; | &check; |                                           |
| Get-PSBreakpoint          | &check; | &check; | &check; | &check; |                                           |
| Get-PSCallStack           | &check; | &check; | &check; | &check; |                                           |
| Get-Random                | &check; | &check; | &check; | &check; |                                           |
| Get-Runspace              | &check; | &check; | &check; | &check; |                                           |
| Get-RunspaceDebug         | &check; | &check; | &check; | &check; |                                           |
| Get-TraceSource           | &check; | &check; | &check; | &check; |                                           |
| Get-TypeData              | &check; | &check; | &check; | &check; |                                           |
| Get-UICulture             | &check; | &check; | &check; | &check; |                                           |
| Get-Unique                | &check; | &check; | &check; | &check; |                                           |
| Get-Uptime                |         | &check; | &check; | &check; |                                           |
| Get-Variable              | &check; | &check; | &check; | &check; |                                           |
| Get-Verb                  |         | &check; | &check; | &check; | Moved from Microsoft.PowerShelll.Core     |
| Group-Object              | &check; | &check; | &check; | &check; |                                           |
| Import-Alias              | &check; | &check; | &check; | &check; |                                           |
| Import-Clixml             | &check; | &check; | &check; | &check; |                                           |
| Import-Csv                | &check; | &check; | &check; | &check; |                                           |
| Import-LocalizedData      | &check; | &check; | &check; | &check; |                                           |
| Import-PowerShellDataFile | &check; | &check; | &check; | &check; |                                           |
| Import-PSSession          | &check; | &check; | &check; | &check; |                                           |
| Invoke-Expression         | &check; | &check; | &check; | &check; |                                           |
| Invoke-RestMethod         | &check; | &check; | &check; | &check; |                                           |
| Invoke-WebRequest         | &check; | &check; | &check; | &check; |                                           |
| Join-String               |         | &check; | &check; | &check; |                                           |
| Measure-Command           | &check; | &check; | &check; | &check; |                                           |
| Measure-Object            | &check; | &check; | &check; | &check; |                                           |
| New-Alias                 | &check; | &check; | &check; | &check; |                                           |
| New-Event                 | &check; | &check; | &check; | &check; | No event sources available on Linux/macOS |
| New-Guid                  | &check; | &check; | &check; | &check; |                                           |
| New-Object                | &check; | &check; | &check; | &check; |                                           |
| New-TemporaryFile         | &check; | &check; | &check; | &check; |                                           |
| New-TimeSpan              | &check; | &check; | &check; | &check; |                                           |
| New-Variable              | &check; | &check; | &check; | &check; |                                           |
| Out-File                  | &check; | &check; | &check; | &check; |                                           |
| Out-GridView              | &check; |         | &check; | &check; | Windows only                              |
| Out-Printer               | &check; |         | &check; | &check; | Windows only                              |
| Out-String                | &check; | &check; | &check; | &check; |                                           |
| Read-Host                 | &check; | &check; | &check; | &check; |                                           |
| Register-EngineEvent      | &check; | &check; | &check; | &check; | No event sources available on Linux/macOS |
| Register-ObjectEvent      | &check; | &check; | &check; | &check; |                                           |
| Remove-Alias              |         | &check; | &check; | &check; |                                           |
| Remove-Event              | &check; | &check; | &check; | &check; | No event sources available on Linux/macOS |
| Remove-PSBreakpoint       | &check; | &check; | &check; | &check; |                                           |
| Remove-TypeData           | &check; | &check; | &check; | &check; |                                           |
| Remove-Variable           | &check; | &check; | &check; | &check; |                                           |
| Select-Object             | &check; | &check; | &check; | &check; |                                           |
| Select-String             | &check; | &check; | &check; | &check; |                                           |
| Select-Xml                | &check; | &check; | &check; | &check; |                                           |
| Send-MailMessage          | &check; | &check; | &check; | &check; |                                           |
| Set-Alias                 | &check; | &check; | &check; | &check; |                                           |
| Set-Date                  | &check; | &check; | &check; | &check; |                                           |
| Set-MarkdownOption        |         |   6.1   | &check; | &check; |                                           |
| Set-PSBreakpoint          | &check; | &check; | &check; | &check; |                                           |
| Set-TraceSource           | &check; | &check; | &check; | &check; |                                           |
| Set-Variable              | &check; | &check; | &check; | &check; |                                           |
| Show-Command              | &check; |         | &check; | &check; | Windows only                              |
| Show-Markdown             |         |   6.1   | &check; | &check; |                                           |
| Sort-Object               | &check; | &check; | &check; | &check; |                                           |
| Start-Sleep               | &check; | &check; | &check; | &check; |                                           |
| Tee-Object                | &check; | &check; | &check; | &check; |                                           |
| Test-Json                 |         | &check; | &check; | &check; |                                           |
| Trace-Command             | &check; | &check; | &check; | &check; |                                           |
| Unblock-File              | &check; | &check; | &check; | &check; | Added support for macOS in 7.0            |
| Unregister-Event          | &check; | &check; | &check; | &check; | No event sources available on Linux/macOS |
| Update-FormatData         | &check; | &check; | &check; | &check; |                                           |
| Update-List               | &check; |         | &check; | &check; |                                           |
| Update-TypeData           | &check; | &check; | &check; | &check; |                                           |
| Wait-Debugger             | &check; | &check; | &check; | &check; |                                           |
| Wait-Event                | &check; | &check; | &check; | &check; |                                           |
| Write-Debug               | &check; | &check; | &check; | &check; |                                           |
| Write-Error               | &check; | &check; | &check; | &check; |                                           |
| Write-Host                | &check; | &check; | &check; | &check; |                                           |
| Write-Information         | &check; | &check; | &check; | &check; |                                           |
| Write-Output              | &check; | &check; | &check; | &check; |                                           |
| Write-Progress            | &check; | &check; | &check; | &check; |                                           |
| Write-Verbose             | &check; | &check; | &check; | &check; |                                           |
| Write-Warning             | &check; | &check; | &check; | &check; |                                           |

### Microsoft.WsMan.Management

|      Cmdlet name       |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| ---------------------- | :-----: | :-----: | :-----: | :-----: | ------------ |
| Connect-WSMan          | &check; | &check; | &check; | &check; | Windows only |
| Disable-WSManCredSSP   | &check; | &check; | &check; | &check; | Windows only |
| Disconnect-WSMan       | &check; | &check; | &check; | &check; | Windows only |
| Enable-WSManCredSSP    | &check; | &check; | &check; | &check; | Windows only |
| Get-WSManCredSSP       | &check; | &check; | &check; | &check; | Windows only |
| Get-WSManInstance      | &check; | &check; | &check; | &check; | Windows only |
| Invoke-WSManAction     | &check; | &check; | &check; | &check; | Windows only |
| New-WSManInstance      | &check; | &check; | &check; | &check; | Windows only |
| New-WSManSessionOption | &check; | &check; | &check; | &check; | Windows only |
| Remove-WSManInstance   | &check; | &check; | &check; | &check; | Windows only |
| Set-WSManInstance      | &check; | &check; | &check; | &check; | Windows only |
| Set-WSManQuickConfig   | &check; | &check; | &check; | &check; | Windows only |
| Test-WSMan             | &check; | &check; | &check; | &check; | Windows only |

### PackageManagement

|       Cmdlet name        |   5.1   |   6.x   |   7.0   |   7.1   | Note |
| ------------------------ | :-----: | :-----: | :-----: | :-----: | ---- |
| Find-Package             | &check; | &check; | &check; | &check; |      |
| Find-PackageProvider     | &check; | &check; | &check; | &check; |      |
| Get-Package              | &check; | &check; | &check; | &check; |      |
| Get-PackageProvider      | &check; | &check; | &check; | &check; |      |
| Get-PackageSource        | &check; | &check; | &check; | &check; |      |
| Import-PackageProvider   | &check; | &check; | &check; | &check; |      |
| Install-Package          | &check; | &check; | &check; | &check; |      |
| Install-PackageProvider  | &check; | &check; | &check; | &check; |      |
| Register-PackageSource   | &check; | &check; | &check; | &check; |      |
| Save-Package             | &check; | &check; | &check; | &check; |      |
| Set-PackageSource        | &check; | &check; | &check; | &check; |      |
| Uninstall-Package        | &check; | &check; | &check; | &check; |      |
| Unregister-PackageSource | &check; | &check; | &check; | &check; |      |

### PowershellGet

|           Cmdlet name           |   5.1   |   6.x   |   7.0   |   7.1   | Note |
| ------------------------------- | :-----: | :-----: | :-----: | :-----: | ---- |
| Find-Command                    | &check; | &check; | &check; | &check; |      |
| Find-DscResource                | &check; | &check; | &check; | &check; |      |
| Find-Module                     | &check; | &check; | &check; | &check; |      |
| Find-RoleCapability             | &check; | &check; | &check; | &check; |      |
| Find-Script                     | &check; | &check; | &check; | &check; |      |
| Get-CredsFromCredentialProvider |         | &check; | &check; | &check; |      |
| Get-InstalledModule             | &check; | &check; | &check; | &check; |      |
| Get-InstalledScript             | &check; | &check; | &check; | &check; |      |
| Get-PSRepository                | &check; | &check; | &check; | &check; |      |
| Install-Module                  | &check; | &check; | &check; | &check; |      |
| Install-Script                  | &check; | &check; | &check; | &check; |      |
| New-ScriptFileInfo              | &check; | &check; | &check; | &check; |      |
| Publish-Module                  | &check; | &check; | &check; | &check; |      |
| Publish-Script                  | &check; | &check; | &check; | &check; |      |
| Register-PSRepository           | &check; | &check; | &check; | &check; |      |
| Save-Module                     | &check; | &check; | &check; | &check; |      |
| Save-Script                     | &check; | &check; | &check; | &check; |      |
| Set-PSRepository                | &check; | &check; | &check; | &check; |      |
| Test-ScriptFileInfo             | &check; | &check; | &check; | &check; |      |
| Uninstall-Module                | &check; | &check; | &check; | &check; |      |
| Uninstall-Script                | &check; | &check; | &check; | &check; |      |
| Unregister-PSRepository         | &check; | &check; | &check; | &check; |      |
| Update-Module                   | &check; | &check; | &check; | &check; |      |
| Update-ModuleManifest           | &check; | &check; | &check; | &check; |      |
| Update-Script                   | &check; | &check; | &check; | &check; |      |
| Update-ScriptFileInfo           | &check; | &check; | &check; | &check; |      |

### PSDesiredStateConfiguration

|                Cmdlet name                 |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| ------------------------------------------ | :-----: | :-----: | :-----: | :-----: | ------------ |
| Disable-DscDebug                           | &check; |         |         |         | Windows only |
| Enable-DscDebug                            | &check; |         |         |         | Windows only |
| Get-DscConfiguration                       | &check; |         |         |         | Windows only |
| Get-DscConfigurationStatus                 | &check; |         |         |         | Windows only |
| Get-DscLocalConfigurationManager           | &check; |         |         |         | Windows only |
| Get-DscResource                            | &check; | &check; | &check; | &check; |              |
| Invoke-DscResource                         | &check; |         | &check; | &check; |              |
| New-DSCCheckSum                            | &check; | &check; | &check; | &check; |              |
| Publish-DscConfiguration                   | &check; |         |         |         | Windows only |
| Remove-DscConfigurationDocument            | &check; |         |         |         | Windows only |
| Restore-DscConfiguration                   | &check; |         |         |         | Windows only |
| Set-DscLocalConfigurationManager           | &check; |         |         |         | Windows only |
| Start-DscConfiguration                     | &check; |         |         |         | Windows only |
| Stop-DscConfiguration                      | &check; |         |         |         | Windows only |
| Test-DscConfiguration                      | &check; |         |         |         | Windows only |
| Update-DscConfiguration                    | &check; |         |         |         | Windows only |

### PSDiagnostics

|         Cmdlet name          |   5.1   |   6.x   |   7.0   |   7.1   |     Note     |
| ---------------------------- | :-----: | :-----: | :-----: | :-----: | ------------ |
| Disable-PSTrace              | &check; |   6.2   | &check; | &check; | Windows only |
| Disable-PSWSManCombinedTrace | &check; |   6.2   | &check; | &check; | Windows only |
| Disable-WSManTrace           | &check; | &check; | &check; | &check; | Windows only |
| Enable-PSTrace               | &check; | &check; | &check; | &check; | Windows only |
| Enable-PSWSManCombinedTrace  | &check; | &check; | &check; | &check; | Windows only |
| Enable-WSManTrace            | &check; |   6.2   | &check; | &check; | Windows only |
| Get-LogProperties            | &check; |   6.2   | &check; | &check; | Windows only |
| Set-LogProperties            | &check; |   6.2   | &check; | &check; | Windows only |
| Start-Trace                  | &check; |   6.2   | &check; | &check; | Windows only |
| Stop-Trace                   | &check; |   6.2   | &check; | &check; | Windows only |

### PSReadline

|         Cmdlet name         |   5.1   |   6.x   |   7.0   |   7.1   | Note |
| --------------------------- | :-----: | :-----: | :-----: | :-----: | ---- |
| Get-PSReadlineKeyHandler    | &check; | &check; | &check; | &check; |      |
| Get-PSReadlineOption        | &check; | &check; | &check; | &check; |      |
| PSConsoleHostReadline       | &check; | &check; | &check; | &check; |      |
| Remove-PSReadlineKeyHandler | &check; | &check; | &check; | &check; |      |
| Set-PSReadlineKeyHandler    | &check; | &check; | &check; | &check; |      |
| Set-PSReadlineOption        | &check; | &check; | &check; | &check; |      |

### PSScheduledJob

|       Cmdlet name       |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| ----------------------- | :-----: | :--- | :---: | :---: | ------------ |
| Add-JobTrigger          | &check; |      |       |       | Windows only |
| Disable-JobTrigger      | &check; |      |       |       | Windows only |
| Disable-ScheduledJob    | &check; |      |       |       | Windows only |
| Enable-JobTrigger       | &check; |      |       |       | Windows only |
| Enable-ScheduledJob     | &check; |      |       |       | Windows only |
| Get-JobTrigger          | &check; |      |       |       | Windows only |
| Get-ScheduledJob        | &check; |      |       |       | Windows only |
| Get-ScheduledJobOption  | &check; |      |       |       | Windows only |
| New-JobTrigger          | &check; |      |       |       | Windows only |
| New-ScheduledJobOption  | &check; |      |       |       | Windows only |
| Register-ScheduledJob   | &check; |      |       |       | Windows only |
| Remove-JobTrigger       | &check; |      |       |       | Windows only |
| Set-JobTrigger          | &check; |      |       |       | Windows only |
| Set-ScheduledJob        | &check; |      |       |       | Windows only |
| Set-ScheduledJobOption  | &check; |      |       |       | Windows only |
| Unregister-ScheduledJob | &check; |      |       |       | Windows only |

### PSWorkflow & PSWorkflowUtility

|          Cmdlet name          |   5.1   | 6.x  |  7.0  |  7.1  |     Note     |
| ----------------------------- | :-----: | :--- | :---: | :---: | ------------ |
| New-PSWorkflowExecutionOption | &check; |      |       |       | Windows only |
| New-PSWorkflowSession         | &check; |      |       |       | Windows only |
| Invoke-AsWorkflow             | &check; |      |       |       | Windows only |

### ThreadJob

|   Cmdlet name   |  5.1  |   6.x   |   7.0   |   7.1   | Note |
| --------------- | :---: | :-----: | :-----: | :-----: | ---- |
| Start-ThreadJob |       | &check; | &check; | &check; | Can be installed in PowerShell 5.1 |
