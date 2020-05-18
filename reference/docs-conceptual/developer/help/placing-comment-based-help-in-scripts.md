---
title: "Placing Comment-Based Help in Scripts | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 49f8267c-d887-4d7d-b9b7-80dc624b1261
caps.latest.revision: 4
---
# Placing Comment-Based Help in Scripts

This topic explains where to place comment-based help for a script so that the `Get-Help` cmdlet associates the comment-based help topic with scripts and not with any functions that might be in the script.

## Where to Place Comment-Based Help for a Script

- At the beginning of the script file. Script Help can be preceded in the script only by comments and blank lines.

- At the end of the script file.

  If the first item in the script body (after the Help) is a function declaration, there must be at least two blank lines between the end of the script Help and the function declaration. Otherwise, the Help is interpreted as being Help for the function, not Help for the script.

## Examples of Help Placement in a Script

 The following examples show each of the placement options for comment-based help for a script.

### Help at the Beginning of a Script

 The following example shows comment-based at the beginning of a script.

```
<#
.Description
This script performs a series of network connection tests.
#>

param [string]$ComputerName
...
```

### Help at the End of a Script

 The following example shows comment-based at the end of a script.

```powershell
...
function Ping { Test-Connection -ComputerName $ComputerName }

<#
.Description
This script performs a series of network connection tests.
#>

```
