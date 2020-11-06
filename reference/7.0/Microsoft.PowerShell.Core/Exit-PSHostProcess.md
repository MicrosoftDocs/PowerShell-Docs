---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 11/06/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/exit-pshostprocess?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Exit-PSHostProcess
---
# Exit-PSHostProcess

## SYNOPSIS
Closes an interactive session with a local process.

## SYNTAX

```
Exit-PSHostProcess [<CommonParameters>]
```

## DESCRIPTION

The `Exit-PSHostProcess` cmdlet closes an interactive session with a local process that you have
opened by running the `Enter-PSHostProcess` cmdlet. You run the `Exit-PSHostProcess` cmdlet from
within the process, when you are finished debugging or troubleshooting a script that is running
within a process. Beginning in PowerShell 6.2, this cmdlet is supported on non-Windows platforms.

## EXAMPLES

### Example 1: Exit a process

```
[Process:1520]: PS>  Exit-PSHostProcess
PS>
```

In this example, you have been working in an active process to debug a script running in a runspace
in the process, as described in `Enter-PSHostProcess`. After you type the `exit` command to exit the
debugger, run the `Exit-PSHostProcess` cmdlet to close your interactive session with the process.
The cmdlet closes your session in the process, and returns you to the `PS C:\>` prompt.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Enter-PSHostProcess](Enter-PSHostProcess.md)
