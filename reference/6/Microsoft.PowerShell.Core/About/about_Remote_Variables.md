---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Remote_Variables
---
# About Remote Variables

## SHORT DESCRIPTION
Explains how to use local and remote variables in remote commands.

## LONG DESCRIPTION

You can use variables in commands that you run on remote computers. Simply
assign a value to the variable and then use the variable in place of the
value.

By default, the variables in remote commands are assumed to be defined in the
session in which the command runs. You can also use variables that are defined
in the local session, but you must identify them as local variables in the
command.

## USING REMOTE VARIABLES

PowerShell assumes that the variables used in remote commands are
defined in the session in which the command runs.

In the following example, the \$ps variable is defined in the temporary session
in which the Get-WinEvent command runs.

```powershell
Invoke-Command -ComputerName S1 -ScriptBlock {
  $ps = "Windows PowerShell"; Get-WinEvent -LogName $ps
}
```

Similarly, when the command runs in a persistent session (PSSession), the
remote variable must be defined in the same PSSession.

```powershell
$s = New-PSSession -ComputerName S1
Invoke-Command -ComputerName S1 -ScriptBlock {$ps = "Windows PowerShell"}
Invoke-Command -Session $s -ScriptBlock {Get-WinEvent -LogName $ps}
```

## USING LOCAL VARIABLES

You can also use local variables in remote commands, but you must indicate
that the variable is defined in the local session.

Beginning in Windows PowerShell 3.0, you can use the Using scope modifier to
identify a local variable in a remote command.

The syntax of Using is as follows:

```
$Using:<VariableName>
```

In the following example, the $ps variable is created in the local session,
but is used in the session in which the command runs. The Using scope modifier
identifies $ps as a local variable.

```powershell
$ps = "Windows PowerShell"
Invoke-Command -ComputerName S1 -ScriptBlock {
  Get-WinEvent -LogName $Using:ps
}
```

You can also use the Using scope modifier in PSSessions.

```powershell
$s = New-PSSession -ComputerName S1
$ps = "Windows PowerShell"
Invoke-Command -Session $s -ScriptBlock {Get-WinEvent -LogName $Using:ps}
```

## USING LOCAL VARIABLES IN WINDOWS POWERSHELL 2.0

You can use local variables in a remote command by defining parameters for the
remote command and using the ArgumentList parameter of the Invoke-Command
cmdlet to specify the local variable as the parameter value.

This command format is valid on Windows PowerShell 2.0 and later versions of
Windows PowerShell and PowerShell Core.

- Use the param keyword to define parameters for the remote command. The
  parameter names are placeholders that do not need to match the name of the
  local variable.

- Use the parameters defined by the param keyword in the command.

- Use the ArgumentList parameter of the Invoke-Command cmdlet to specify the
  local variable as the parameter value.

For example, the following commands define the $ps variable in the local
session and then use it in a remote command. The command uses $log as the
parameter name and the local variable, $ps, as its value.

```powershell
$ps = "Windows PowerShell"
Invoke-Command -ComputerName S1 -ScriptBlock {
  param($log)
  Get-WinEvent -logname $log
} -ArgumentList $ps
```

## SEE ALSO

[about_Remote](about_Remote.md)

[about_PSSessions](about_PSSessions.md)

[about_Scopes](about_Scopes.md)

[Invoke-Command](../Invoke-Command.md)

[Enter-PSSession](../Enter-PSSession.md)

[New-PSSession](../New-PSSession.md)