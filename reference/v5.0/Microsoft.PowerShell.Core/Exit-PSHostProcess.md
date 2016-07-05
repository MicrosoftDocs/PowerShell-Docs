---
external help file: PSITPro5_Core.xml
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
The Exit-PSHostProcess cmdlet closes an interactive session with a local process that you have opened by running the Enter-PSHostProcess cmdlet.
You run the Exit-PSHostProcess cmdlet from within the process, when you are finished debugging or troubleshooting a script that is running within a process.

## EXAMPLES

### Example 1: Exit a process
```
PS C:\>[Process:1520]: PS C:\> Exit-PSHostProcess
PS C:\>
```

In this example, you have been working in an active process to debug a script running in a runspace in the process, as described in Enter-PSHostProcess.
After you type the exit command to exit the debugger, run the Exit-PSHostProcess cmdlet to close your interactive session with the process.
The cmdlet closes your session in the process, and returns you to the PS C:\\\> prompt.

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-Process](b30db241-c0f6-40d3-ab3b-ab86342b36c1)

[Enter-PSHostProcess](606c328c-bb4b-4666-aebe-311515c92d59)

[Debug-Runspace](108d65fa-016c-4f80-af83-f2aa7ec000c3)

[Enable-RunspaceDebug](e4b83556-564c-4bc2-9e30-265e5a45a300)

[about_Debuggers](2b2ce8b3-f881-4528-bd30-f453dea06755)

