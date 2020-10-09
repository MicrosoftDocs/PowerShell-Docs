---
description:  Explains how to use local and remote variables in remote commands. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 03/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_variables?view=powershell-7.1&WT.mc_id=ps-gethelp
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

A variable reference such as `$using:var` expands to the value of variable `$var`
from the caller's context. You do not get access to the caller's variable object.
The `Using` scope modifier cannot be used to modify a local variable within the
**PSSession**. For example, the following code does not work:

```powershell
$s = New-PSSession -ComputerName S1
$ps = "*PowerShell*"
Invoke-Command -Session $s -ScriptBlock {$Using:ps = 'Cannot assign new value'}
```

For more information about `Using`, see [about_Scopes](./about_Scopes.md)

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

### Other situations where the 'Using' scope modifier is needed

For any script or command that executes out of session, you need the `Using`
scope modifier to embed variable values from the calling session scope, so that
out of session code can access them. The `Using` scope modifier is supported in
the following contexts:

- Remotely executed commands, started with `Invoke-Command` using the
  **ComputerName**, **HostName**, **SSHConnection** or **Session** parameters
  (remote session)
- Background jobs, started with `Start-Job` (out-of-process session)
- Thread jobs, started via `Start-ThreadJob` or `ForEach-Object -Parallel`
  (separate thread session)

Depending on the context, embedded variable values are either independent
copies of the data in the caller's scope or references to it. In remote and
out-of-process sessions, they are always independent copies. In thread
sessions, they are passed by reference.

## Serialization of variable values

Remotely executed commands and background jobs run out-of-process.
Out-of-process sessions use XML-based serialization and deserialization to make
the values of variables available across the process boundaries. The
serialization process converts objects to a **PSObject** that contains the
original objects properties but not its methods.

For a limited set of types, deserialization rehydrates objects back to the
original type. The rehydrated object is a copy of the original object instance.
It has the type properties and methods. For simple types, such as
**System.Version**, the copy is exact. For complex types, the copy is
imperfect. For example, rehydrated certificate objects do not include the
private key.

Instances of all other types are **PSObject** instances. The **PSTypeNames**
property contains the original type name prefixed with **Deserialized**, for
example, **Deserialized.System.Data.DataTable**

## Using local variables with **ArgumentList** parameter

You can use local variables in a remote command by defining parameters for the
remote command and using the **ArgumentList** parameter of the `Invoke-Command`
cmdlet to specify the local variable as the parameter value.

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

[about_Variables](about_Variables.md)

[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

[Start-ThreadJob](xref:ThreadJob.Start-ThreadJob)

@Microsoft.PowerShell.Core.ForEach-Object

