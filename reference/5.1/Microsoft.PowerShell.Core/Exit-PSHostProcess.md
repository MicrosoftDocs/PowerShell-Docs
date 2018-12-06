---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkID=403737
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
The **Exit-PSHostProcess** cmdlet closes an interactive session with a local process that you have opened by running the Enter-PSHostProcess cmdlet.
You run the **Exit-PSHostProcess** cmdlet from within the process, when you are finished debugging or troubleshooting a script that is running within a process.

## EXAMPLES

### Example 1: Exit a process
```
PS C:\> [Process:1520]: PS C:\>  Exit-PSHostProcess
PS C:\>
```

In this example, you have been working in an active process to debug a script running in a runspace in the process, as described in Enter-PSHostProcess.
After you type the **exit** command to exit the debugger, run the **Exit-PSHostProcess** cmdlet to close your interactive session with the process.
The cmdlet closes your session in the process, and returns you to the PS C:\\\> prompt.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Enter-PSHostProcess](Enter-PSHostProcess.md)