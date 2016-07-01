---
external help file: PSITPro5_Core.xml
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
The Exit-PSSession cmdlet ends interactive sessions that you started by using the Enter-PSSession cmdlet.

You can also use the Exit keyword to end an interactive session.
The effect is the same as using Exit-PSSession.

## EXAMPLES

### Example 1: Start and stop an interactive session
```
PS C:\>Enter-PSSession -computername Server01
Server01\PS> Exit-PSSession
PS C:\>
```

These commands start and then stop an interactive session with the Server01 remote computer.

### Example 2: Start and stop an interactive session by using a PSSession object
```
PS C:\>$s = New-PSSession -ComputerName Server01
PS C:\> Enter-PSSession -Session $s
Server01\PS> Exit-PSSession
PS C:\>$s
Id Name            ComputerName    State    ConfigurationName
-- ----            ------------    -----    -----------------
1  Session1        Server01        Opened   Microsoft.PowerShell
```

These commands start and stop an interactive session with the Server01 computer that uses a Windows PowerShell session (PSSession).

Because the interactive session was started by using a Windows PowerShell session, the PSSession is still available when the interactive session ends.
If you use the ComputerName parameter, Enter-PSSession creates a temporary session that it closes when the interactive session ends.

The first command uses the New-PSSession cmdlet to create a PSSession on the Server01 computer.
The command saves the PSSession in the $s variable.

The second command uses Enter-PSSession to start an interactive session using the PSSession in $s.

The third command uses Exit-PSSession to stop the interactive session.

The final command displays the PSSession in the $s variable.
The State property shows the PSSession is still open and available for use.

### Example 3: Use the Exit keyword to stop a session
```
PS C:\>Enter-PSSession -computername Server01
Server01\PS> exit
PS C:\>
```

This example uses the Exit keyword to stop an interactive session started by using Enter-PSSession.
The Exit keyword has the same effect as using Exit-PSSession.

## PARAMETERS

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
This cmdlet takes only the common parameters.

## RELATED LINKS

[Connect-PSSession](b803dd29-f208-4079-80d4-db04d778f060)

[Disconnect-PSSession](f8f95111-612f-4cba-9098-77904b0473d8)

[Enter-PSSession](4e1e012b-51df-4fea-9ff2-dc859eee13fe)

[Get-PSSession](b2b10531-d0df-4746-b877-e75c09955cb6)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[New-PSSession](76f6628c-054c-4eda-ba7a-a6f28daaa26f)

[Receive-PSSession](b8ec9e88-aab5-4db8-a4a3-216338d1c9b6)

[Remove-PSSession](a48e762a-80d9-4545-92e3-745f4e992e22)

[about_PSSessions](7a9b4e0e-fa1b-47b0-92f6-6e2995d70acb)

[about_Remote](9b4a5c87-9162-4adf-bdfe-fbc80b9b8970)

