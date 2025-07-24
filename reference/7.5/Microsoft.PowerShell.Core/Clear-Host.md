---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 04/29/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/clear-host?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - clear
  - cls
title: Clear-Host
---

# Clear-Host

## SYNOPSIS

Clears the display in the host program.

## SYNTAX

```
Clear-Host
```

## DESCRIPTION

The `Clear-Host` function removes all text from the current display, including commands and output
that might have accumulated. When complete, it displays the command prompt. You can use the function
name or its alias, `cls`.

`Clear-Host` affects only the current display. It does not delete saved results or remove any items
from the session. Session-specific items, such as variables and functions, are not affected by this
function.

Because the behavior of the `Clear-Host` function is determined by the host program, `Clear-Host`
might work differently in different host programs.

## EXAMPLES

### Example 1

```powershell
PS> Get-Process | Select-Object -First 5

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    843      33    14428      22556    99    17.41   1688 CcmExec
     44       6     2196       4964    52     0.23    692 conhost
    646      12     2332       4896    49     1.12    388 csrss
    189      11     2860       7084   114     0.66   2896 csrss
     78      11     1876       4008    42     0.22   4000 csrss

PS> Clear-Host
```

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

PowerShell includes the following aliases for `Clear-Host`:

- Windows:
  - `clear`
  - `cls`

- Linux and macOS:
  - `cls`

`Clear-Host` is a simple function, not an advanced function. There are no parameters.

## RELATED LINKS

[Get-Host](../Microsoft.PowerShell.Utility/Get-Host.md)

[Out-Host](Out-Host.md)

[Read-Host](../Microsoft.PowerShell.Utility/Read-Host.md)

[Write-Host](../Microsoft.PowerShell.Utility/Write-Host.md)
