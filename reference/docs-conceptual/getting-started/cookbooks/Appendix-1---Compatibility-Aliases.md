---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Appendix 1 Compatibility Aliases
ms.assetid:  96ad921e-1a57-463e-8e60-424faf8b6ef8
---
# Appendix 1 - Compatibility Aliases

Windows PowerShell has several transition aliases that allow UNIX and Cmd users to use familiar command names in Windows PowerShell. The most common aliases are shown in the table below, along with the Windows PowerShell command behind the alias and the standard Windows PowerShell alias if one exists.

You can find the Windows PowerShell command that any alias points to from within Windows PowerShell by using the Get-Alias cmdlet. For example, type **get-alias cls**.

```
CommandType     Name                            Definition
-----------     ----                            ----------
Alias           cls                             Clear-Host
```

|CMD Command|UNIX Command|PS Command|PS Alias|
|---------------|----------------|--------------|------------|
|**dir**|**ls**|**Get-ChildItem**|**gci**|
|**cls**|**clear**|**Clear-Host** (function)|**cls**|
|**del, erase, rmdir**|**rm**|**Remove-Item**|**ri**|
|**copy**|**cp**|**Copy-Item**|**ci**|
|**move**|**mv**|**Move-Item**|**mi**|
|**rename**|**mv**|**Rename-Item**|**rni**|
|**type**|**cat**|**Get-Content**|**gc**|
|**cd**|**cd**|**Set-Location**|**sl**|
|**md**|**mkdir**|**New-Item**|**ni**|
|**pushd**|**pushd**|**Push-Location**|**pushd**|
|**popd**|**popd**|**Pop-Location**|**popd**|