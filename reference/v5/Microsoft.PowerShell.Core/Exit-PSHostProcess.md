---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=403737
schema: 2.0.0
---

# Exit-PSHostProcess
## SYNOPSIS
Closes an interactive session with a local process.

## SYNTAX

```
Exit-PSHostProcess
```

## DESCRIPTION
Exit-PSHostProcess closes an interactive session with a local process that you have opened by running the Enter-PSHostProcess cmdlet.
You run the Exit-PSHostProcess cmdlet from within the process, when you are finished debugging or troubleshooting a script that is running within a process.

## EXAMPLES

### Example 1: Exit a process
```
PS C:\>[Process:1520]: PS C:\> Exit-PSHostProcess
PS C:\>
```

In this example, you have been working within an active process to debug a script running in a runspace within the process, as described in Enter-PSHostProcess.
After you type the exit command to exit the debugger, run the Exit-PSHostProcess cmdlet to close your interactive session with the process.
The cmdlet closes your session in the process, and returns you to the PS C:\\\> prompt.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Process]()

[Enter-PSHostProcess]()

[Debug-Runspace]()

[Enable-RunspaceDebug]()

[about_Debuggers]()

