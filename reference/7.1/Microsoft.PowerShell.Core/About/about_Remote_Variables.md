---
keywords: powershell,cmdlet
locale: en-us
ms.date: 07/23/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_variables?view=powershell-7.x&WT.mc_id=ps-gethelp
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

For anything that executes out-of-runspace, doesn't execute directly in the
caller's runspace, you need the `Using` scope modifier in order to embed
variable values from the caller's scope, so that the out-of-runspace code
can access it. (Conversely, all other contexts neither require nor support the
'Using' scope modifier.) Specifically, this includes the following contexts:

- Remotely executed commands, started with Invoke-Command's `-ComputerName` or
  `-Session` parameter (remote runspace)
- Background jobs, started with Start-Job (out-of-process runspace)
- Thread jobs, started via Start-ThreadJob or ForEach-Object -Parallel
  (separate runspace)

> [!NOTE]
> Note that out-of-runspace code can never modify variables in the caller's
> scope. However, in the case of thread jobs (but not during remoting and not in
> background jobs), if the variable value happens to be an instance of a reference
> type (like a collection type), it is possible to modify that instance in
> another thread, which requires synchronizing the modifications across threads,
> should multiple threads perform modifications.

## Serialization of variable values

Remotely executed commands and background jobs run out-of-process. For values
in variables to cross these process boundaries they undergo XML-based
serialization and deserialization. This typically involves loss of type fidelity
\- both on input and output. --> todo: example needed

Thread jobs, by contrast, because they run in a different runspace (thread) in
the same process receive $using: variable values as their original, live objects
and, similarly, return such objects.

The caveat is that explicit synchronization across runspaces (threads) may be
needed, if they all access a given, mutable object - which is most likely to
happen with ForEach-Object -Parallel.

Generally, though, thread jobs are the better alternative to background jobs in
most cases, due to their significantly better performance, lower resource use,
and type fidelity.

## Using local variables with `-ArgumentList` parameter

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

[Enter-PSSession](../Enter-PSSession.md)

[Invoke-Command](../Invoke-Command.md)

[New-PSSession](../New-PSSession.md)
