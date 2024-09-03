---
description: Describes how to interpret and format the output of remote commands.
Locale: en-US
ms.date: 01/31/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_output?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Output
---

# about_Remote_Output

## Short description

Describes how to interpret and format the output of remote commands.

## Long description

The output of a command that was run on a remote computer might look like
output of the same command run on a local computer, but there are some
significant differences.

This topic explains how to interpret, format, and display the output of
commands that are run on remote computers.

## Displaying the computer name

When you use the `Invoke-Command` cmdlet to run a command on a remote computer,
the command returns an object that includes the name of the computer that
generated the data. The **PSComputerName** property contains the remote
computer name.

For many commands, **PSComputerName** is displayed by default. For example, the
following command runs a `Get-Culture` command on two remote computers,
Server01 and Server02. The output, which appears below, includes the names of
the remote computers on which the command ran.

```powershell
Invoke-Command -ScriptBlock {Get-Culture} -ComputerName Server01, Server02
```

```Output
LCID  Name    DisplayName                PSComputerName
----  ----    -----------                --------------
1033  en-US   English (United States)    Server01
1033  es-AR   Spanish (Argentina)        Server02
```

You can use the **HideComputerName** parameter of `Invoke-Command` to hide the
**PSComputerName** property. This parameter is designed for commands that
collect data from only one remote computer.

The following command runs a `Get-Culture` command on the Server01 remote
computer. It uses the **HideComputerName** parameter to hide the
**PSComputerName** property and related properties.

```powershell
$invokeCommandSplat = @{
    ScriptBlock = {Get-Culture}
    ComputerName = 'Server01'
    HideComputerName = $true
}
Invoke-Command @invokeCommandSplat
```

```Output
LCID             Name             DisplayName
----             ----             -----------
1033             en-US            English (United States)
```

You can also display the **PSComputerName** property if it's not displayed
by default.

For example, the following commands use the `Format-Table` cmdlet to add
the **PSComputerName** property to the output of a remote `Get-Date` command.

```powershell
$invokeCommandSplat = @{
    ScriptBlock = {Get-Date}
    ComputerName = 'Server01', 'Server02'
}
Invoke-Command @invokeCommandSplat |
    Format-Table DateTime, PSComputerName -AutoSize
```

```Output
DateTime                            PSComputerName
--------                            --------------
Monday, July 21, 2008 7:16:58 PM    Server01
Monday, July 21, 2008 7:16:58 PM    Server02
```

## Deserialized objects

When you run remote commands that generate output, the command output is
transmitted across the network back to the local computer.

Since live .NET objects can't be transmitted over the network, the live objects
are _serialized_ or converted into XML representations of the object and its
properties. PowerShell transmits the serialized object across the
network.

On the local computer, PowerShell receives the serialized object and
_deserializes_ it by converting the serialized object into a standard .NET
object.

However, the deserialized object isn't a live object. It's a snapshot of the
object at the time of serialization. The deserialized object includes
properties but no methods. You can use and manage these objects in PowerShell,
including passing them in pipelines, displaying selected properties, and
formatting them.

Most deserialized objects are automatically formatted for display by entries in
the `Types.ps1xml` or `Format.ps1xml` files. However, the local computer might
not have formatting files for all objects that were generated on a remote
computer. When objects are not formatted, all of the properties of each object
appear in the console in a streaming list.

When objects aren't formatted automatically, you can use the formatting
cmdlets, such as `Format-Table` or `Format-List`, to format and display
selected properties. Or, you can use the `Out-GridView` cmdlet to display
the objects in a table.

When you run a command on a remote computer that uses cmdlets that you don't
have on your local computer, the objects that the command returns may not be
formatted as expected if you don't have the formatting files for those object
types on your computer. You use the `Get-FormatData` and `Export-FormatData`
cmdlets to get formatting data from another computer.

Some object types, such as **DirectoryInfo** objects and GUIDs, are converted
back into live objects when they're received. These objects don't need any
special handling or formatting.

## Ordering the results

The order of the computer names in the **ComputerName** parameter of cmdlets
determines the order in which PowerShell connects to the remote computers.
However, the results appear in the order that the data is received from the
remote computers.

You can use the `Sort-Object` cmdlet to sort the results on the
**PSComputerName**. When you any other property of the object, the results from
different computers are interspersed interleaved in the output

## See also

- [about_Remote][02]
- [about_Remote_Variables][01]
- [Invoke-Command][03]
- [Get-EventLog][04]
- [Out-GridView][09]
- [Select-Object][10]
- [Get-Process][05]
- [Get-Service][06]
- [Format-Table][08]
- [Get-WmiObject][07]

<!-- link references -->
[01]: about_Remote_Variables.md
[02]: about_Remote.md
[03]: xref:Microsoft.PowerShell.Core.Invoke-Command
[04]: xref:Microsoft.PowerShell.Management.Get-EventLog
[05]: xref:Microsoft.PowerShell.Management.Get-Process
[06]: xref:Microsoft.PowerShell.Management.Get-Service
[07]: xref:Microsoft.PowerShell.Management.Get-WmiObject
[08]: xref:Microsoft.PowerShell.Utility.Format-Table
[09]: xref:Microsoft.PowerShell.Utility.Out-GridView
[10]: xref:Microsoft.PowerShell.Utility.Select-Object
