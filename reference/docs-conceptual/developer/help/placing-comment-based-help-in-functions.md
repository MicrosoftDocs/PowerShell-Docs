---
ms.date: 09/12/2016
ms.topic: reference
title: Placing Comment-Based Help in Functions
description: Placing Comment-Based Help in Functions
---
# Placing Comment-Based Help in Functions

This topic explains where to place comment-based help for a function so that the `Get-Help` cmdlet
associates the comment-based help topic with the correct function.

## Where to Place Comment-Based Help for a Function

- At the beginning of the function body.

- At the end of the function body.

- Before the `Function` keyword. When the function is in a script or script module, there cannot be
  more than one blank line between the last line of the comment-based help and the `Function`
  keyword. Otherwise, `Get-Help` associates the help with the script, not with the function.

## Examples of Help Placement in a Function

The following examples show each of the three placement options for comment-based help for a
function.

### Help at the Beginning of a Function Body

The following example shows comment-based at the beginning of a function body.

```powershell
function MyProcess
{
    <#
       .Description
       The MyProcess function gets the Windows PowerShell process.
    #>

    Get-Process powershell
}
```

### Help at the End of a Function Body

 The following example shows comment-based at the end of a function body.

```powershell
function MyFunction
{
    Get-Process powershell

    <#
       .Description
       The MyProcess function gets the Windows PowerShell process.
    #>
}
```

### Help Before the Function Keyword

 The following examples shows comment-based on the line before the function keyword.

```powershell
<#
    .Description
    The MyProcess function gets the Windows PowerShell process.
#>
function MyFunction { Get-Process powershell}
```
