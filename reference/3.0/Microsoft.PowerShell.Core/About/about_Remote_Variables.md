---
keywords: powershell,cmdlet
locale: en-us
ms.date: 07/23/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_variables?view=powershell-3.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Variables
---

# About Remote Variables

## Short description

Explains how to use local and remote variables in remote commands.

## Long description

You can use variables in commands that you run on remote computers. Assign a
value to the variable and then use the variable in place of the value.

By default, the variables in remote commands are assumed to be defined in the
session that runs the command. Variables that are defined in a local session,
must be identified as local variables in the command.

## Using remote variables

PowerShell assumes that the variables used in remote commands are defined in
the session in which the command runs.

In this example, the `$ps` variable is defined in the temporary session in
which the `Get-WinEvent` command runs.

```powershell
Invoke-Command -ComputerName S1 -ScriptBlock {
  $ps = "*PowerShell*"; Get-WinEvent -LogName $ps
}
```

When the command runs in a persistent session, **PSSession**, the remote
variable must be defined in that session.

```powershell
$s = New-PSSession -ComputerName S1
Invoke-Command -Session $s -ScriptBlock {$ps = "*PowerShell*"}
Invoke-Command -Session $s -ScriptBlock {Get-WinEvent -LogName $ps}
```

## Using local variables

You can use local variables in remote commands, but the variable must be
defined in the local session.

Beginning in PowerShell 3.0, you can use the `Using` scope modifier to identify
a local variable in a remote command.

The syntax of `Using` is as follows:

```
$Using:<VariableName>
```

In the following example, the `$ps` variable is created in the local session,
but is used in the session in which the command runs. The `Using` scope
modifier identifies `$ps` as a local variable.

```powershell
$ps = "*PowerShell*"
Invoke-Command -ComputerName S1 -ScriptBlock {
  Get-WinEvent -LogName $Using:ps
}
```

The `Using` scope modifier can be used in a **PSSession**.

```powershell
$s = New-PSSession -ComputerName S1
$ps = "*PowerShell*"
Invoke-Command -Session $s -ScriptBlock {Get-WinEvent -LogName $Using:ps}
```

### Using splatting

PowerShell splatting passes a collection of parameter names and values to a
command. For more information, see [about_Splatting](about_Splatting.md).

In this example, the splatting variable, `$Splat` is a hash table that is set
up on the local computer. The `Invoke-Command` connects to a remote computer
session. The **ScriptBlock** uses the `Using` scope modifier with the At (`@`)
symbol to represent the splatted variable.

```powershell
$Splat = @{ Name = "Win*"; Include = "WinRM" }
Invoke-Command -Session $s -ScriptBlock { Get-Service @Using:Splat }
```

## Using local variables in PowerShell 2.0

You can use local variables in a remote command by defining parameters for the
remote command and using the **ArgumentList** parameter of the `Invoke-Command`
cmdlet to specify the local variable as the parameter value.

The following command format is valid on PowerShell 2.0 and later versions:

- Use the `param` keyword to define parameters for the remote command. The
  parameter names are placeholders that don't need to match the local
  variable's name.

- Use the parameters defined by the `param` keyword in the command.

- Use the **ArgumentList** parameter of the `Invoke-Command` cmdlet to specify
  the local variable as the parameter value.

For example, the following commands define the `$ps` variable in the local
session and then use it in a remote command. The command uses `$log` as the
parameter name and the local variable, `$ps`, as its value.

```powershell
$ps = "*PowerShell*"
Invoke-Command -ComputerName S1 -ScriptBlock {
  param($log)
  Get-WinEvent -LogName $log
} -ArgumentList $ps
```

## See also

[about_PSSessions](about_PSSessions.md)

[about_Remote](about_Remote.md)

[about_Scopes](about_Scopes.md)

[about_Splatting](about_Splatting.md)

[Enter-PSSession](../Enter-PSSession.md)

[Invoke-Command](../Invoke-Command.md)

[New-PSSession](../New-PSSession.md)
