---
ms.date:  09/09/2019
keywords:  powershell,cmdlet
title:  Appendix 1 Compatibility Aliases
---
# Appendix 1 - Compatibility Aliases

PowerShell has several aliases that allow **UNIX** and **cmd.exe** users to use familiar commands.
The commands and their related PowerShell cmdlet and PowerShell alias are shown in the following
table:

|cmd.exe command|UNIX command|PowerShell cmdlet|PowerShell alias|
|---------------|----------------|--------------|------------|
|**cls**|**clear**|`Clear-Host` (function)|`cls`|
|**copy**|**cp**|`Copy-Item`|`cpi`|
|**dir**|**ls**|`Get-ChildItem`|`gci`|
|**type**|**cat**|`Get-Content`|`gc`|
|**move**|**mv**|`Move-Item`|`mi`|
|**md**|**mkdir**|`New-Item`|`ni`|
|**pushd**|**pushd**|`Push-Location`|`pushd`|
|**popd**|**popd**|`Pop-Location`|`popd`|
|**del**, **erase**, **rd**, **rmdir**|**rm**|`Remove-Item`|`ri`|
|**ren**|**mv**|`Rename-Item`|`rni`|
|**cd**, **chdir**|**cd**|`Set-Location`|`sl`|

To find the PowerShell aliases, use the [Get-Alias](/powershell/module/Microsoft.PowerShell.Utility/Get-Alias)
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
