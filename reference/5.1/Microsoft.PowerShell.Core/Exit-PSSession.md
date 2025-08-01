---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 12/09/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/exit-pssession?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - exsn
title: Exit-PSSession
---

# Exit-PSSession

## SYNOPSIS
Ends an interactive session with a remote computer.

## SYNTAX

```
Exit-PSSession [<CommonParameters>]
```

## DESCRIPTION

The `Exit-PSSession` cmdlet ends interactive sessions that you started by using the
`Enter-PSSession` cmdlet.

You can also use the `exit` keyword to end an interactive session. The effect is the same as using
`Exit-PSSession`.

## EXAMPLES

### Example 1: Start and stop an interactive session

```powershell
PS C:\> Enter-PSSession -ComputerName Server01
Server01\PS> Exit-PSSession
PS C:\>
```

These commands start and then stop an interactive session with the Server01 remote computer.

### Example 2: Start and stop an interactive session by using a PSSession object

```powershell
PS C:\> $s = New-PSSession -ComputerName Server01
PS C:\> Enter-PSSession -Session $s
Server01\PS> Exit-PSSession
PS C:\> $s
Id Name            ComputerName    State    ConfigurationName
-- ----            ------------    -----    -----------------
1  Session1        Server01        Opened   Microsoft.PowerShell
```

These commands start and stop an interactive session with the Server01 computer that uses a Windows
PowerShell session (**PSSession**).

Because the interactive session was started by using a Windows PowerShell session, the **PSSession**
is still available when the interactive session ends. If you use the _ComputerName_ parameter,
`Enter-PSSession` creates a temporary session that it closes when the interactive session ends.

The first command uses the `New-PSSession` cmdlet to create a **PSSession** on the Server01
computer. The command saves the **PSSession** in the `$s` variable.

The second command uses `Enter-PSSession` to start an interactive session using the **PSSession** in
`$s`.

The third command uses `Exit-PSSession` to stop the interactive session.

The final command displays the **PSSession** in the `$s` variable. The **State** property shows the
**PSSession** is still open and available for use.

### Example 3: Use the `exit` keyword to stop a session

```powershell
PS C:\> Enter-PSSession -ComputerName Server01
Server01\PS> exit
PS C:\>
```

This example uses the `exit` keyword to stop an interactive session started by using
`Enter-PSSession`. The `exit` keyword has the same effect as using `Exit-PSSession`.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

Windows PowerShell includes the following aliases for `Exit-PSSession`:

- `exsn`

This cmdlet takes only the common parameters.

## RELATED LINKS

[Connect-PSSession](Connect-PSSession.md)

[Disconnect-PSSession](Disconnect-PSSession.md)

[Enter-PSSession](Enter-PSSession.md)

[Get-PSSession](Get-PSSession.md)

[Invoke-Command](Invoke-Command.md)

[New-PSSession](New-PSSession.md)

[Receive-PSSession](Receive-PSSession.md)

[Remove-PSSession](Remove-PSSession.md)
