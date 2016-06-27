---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289579
schema: 2.0.0
---

# Exit-PSSession
## SYNOPSIS
Ends an interactive session with a remote computer.

## SYNTAX

```
Exit-PSSession
```

## DESCRIPTION
The Exit-PSSession cmdlet ends interactive sessions that you started by using Enter-PSSession.

You can also use the Exit keyword to end an interactive session.
The effect is the same as using Exit-PSSession.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Enter-PSSession -computername Server01
Server01\PS> Exit-PSSession
PS C:\>
```

These commands start and then stop an interactive session with the Server01 remote computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$s = new-pssession -computername Server01
PS C:\>Enter-PSSession -session $s
Server01\PS> Exit-PSSession
PS C:\>$s
Id Name            ComputerName    State    ConfigurationName
-- ----            ------------    -----    -----------------
1  Session1        Server01        Opened   Microsoft.PowerShell
```

These commands start and stop an interactive session with the Server01 computer that uses a Windows PowerShell session (PSSession).

Because the interactive session was started by using a Windows PowerShell session (PSSession), the PSSession is still available when the interactive session ends.
If you use the ComputerName parameter, Enter-PSSession creates a temporary session that it closes when the interactive session ends.

The first command uses the New-PSSession cmdlet to create a PSSession on the Server01 computer.
The command saves the PSSession in the $s variable.

The second command uses the Enter-PSSession cmdlet to start an interactive session using the PSSession in $s.

The third command uses the Exit-PSSession cmdlet to stop the interactive session.

The final command displays the PSSession in the $s variable.
The State property shows the PSSession is still open and available for use.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Enter-PSSession -computername Server01
Server01\PS> exit
PS C:\>
```

This command uses the Exit keyword to stop an interactive session started by using the Enter-PSSession cmdlet.
The Exit keyword has the same effect as using Exit-PSSession.

## PARAMETERS

## INPUTS

### None
You cannot pipe objects to Exit-PSSession.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
This cmdlet takes only the common parameters.

## RELATED LINKS

[Connect-PSSession]()

[Disconnect-PSSession]()

[Enter-PSSession]()

[Get-PSSession]()

[Invoke-Command]()

[New-PSSession]()

[Receive-PSSession]()

[Remove-PSSession]()

[about_PSSessions]()

[about_Remote]()

