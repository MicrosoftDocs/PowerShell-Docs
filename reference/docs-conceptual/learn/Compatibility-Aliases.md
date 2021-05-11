---
ms.date: 08/03/2020
keywords:  powershell,cmdlet
title:  Appendix 1 Compatibility Aliases
description: PowerShell has several aliases that allow UNIX and cmd.exe users to use familiar commands.
---
# Appendix 1 - Compatibility Aliases

PowerShell has several aliases that allow **UNIX** and **cmd.exe** users to use familiar commands.
The commands and their related PowerShell cmdlet and PowerShell alias are shown in the following
table:

|            cmd.exe command            | UNIX command | PowerShell cmdlet | PowerShell alias |
| ------------------------------------- | ------------ | ----------------- | ---------------- |
| **cd**, **chdir**                     | **cd**       | `Set-Location`    | `sl`             |
| **cls**                               | **clear**    | `Clear-Host`      | `cls`            |
| **copy**                              | **cp**       | `Copy-Item`       | `cpi`            |
| **del**, **erase**, **rd**, **rmdir** | **rm**       | `Remove-Item`     | `ri`             |
| **dir**                               | **ls**       | `Get-ChildItem`   | `gci`            |
| **echo**                              | **echo**     | `Write-Output`    | `write`          |
| **md**                                | **mkdir**    | `New-Item`        | `ni`             |
| **move**                              | **mv**       | `Move-Item`       | `mi`             |
| **popd**                              | **popd**     | `Pop-Location`    | `popd`           |
| **pushd**                             | **pushd**    | `Push-Location`   | `pushd`          |
| **ren**                               | **mv**       | `Rename-Item`     | `rni`            |
| **type**                              | **cat**      | `Get-Content`     | `gc`             |

To find the PowerShell aliases, use the [Get-Alias](xref:Microsoft.PowerShell.Utility.Get-Alias)
cmdlet. To display a cmdlet's aliases, use the **Definition** parameter and specify the cmdlet name.
Or, to find an alias's cmdlet name, use the **Name** parameter and specify the alias.

```powershell
Get-Alias -Definition Get-ChildItem
```

```Output
CommandType     Name
-----------     ----
Alias           dir -> Get-ChildItem
Alias           gci -> Get-ChildItem
Alias           ls -> Get-ChildItem
```

```powershell
Get-Alias -Name gci
```

```Output
CommandType     Name
-----------     ----
Alias           gci -> Get-ChildItem
```
