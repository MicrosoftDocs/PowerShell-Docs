---
description: Describes how to interpret and format the output of remote commands. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 12/01/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_output?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Output
---
# About Remote Output

## SHORT DESCRIPTION
Describes how to interpret and format the output of remote commands.

## LONG DESCRIPTION

The output of a command that was run on a remote computer might look
like output of the same command run on a local computer, but there are
some significant differences.

This topic explains how to interpret, format, and display the output
of commands that are run on remote computers.

## DISPLAYING THE COMPUTER NAME

When you use the Invoke-Command cmdlet to run a command on a remote
computer, the command returns an object that includes the name of
the computer that generated the data. The remote computer name is
stored in the PSComputerName property.

For many commands, the PSComputerName is displayed by default. For
example, the following command runs a Get-Culture command on two
remote computers, Server01 and Server02. The output, which appears
below, includes the names of the remote computers on which the command
ran.

```powershell
C:\PS> invoke-command -script {get-culture} -comp Server01, Server02

LCID  Name    DisplayName                PSComputerName
----  ----    -----------                --------------
1033  en-US   English (United States)    Server01
1033  es-AR   Spanish (Argentina)        Server02
```

You can use the HideComputerName parameter of Invoke-Command to hide
the PSComputerName property. This parameter is designed for commands
that collect data from only one remote computer.

The following command runs a Get-Culture command on the Server01
remote computer. It uses the HideComputerName parameter to hide the
PSComputerName property and related properties.

```powershell
C:\PS> invoke-command -scr {get-culture} -comp Server01 -HideComputerName

LCID             Name             DisplayName
----             ----             -----------
1033             en-US            English (United States)
```

You can also display the PSComputerName property if it is not displayed
by default.

For example, the following commands use the Format-Table cmdlet to add
the PSComputerName property to the output of a remote Get-Date command.

```powershell
$dates = invoke-command -script {get-date} -computername Server01, Server02
$dates | format-table DateTime, PSComputerName -auto

DateTime                            PSComputerName
--------                            --------------
Monday, July 21, 2008 7:16:58 PM    Server01
Monday, July 21, 2008 7:16:58 PM    Server02
```

## DISPLAYING THE MACHINENAME PROPERTY

Several cmdlets, including Get-Process, Get-Service, and Get-EventLog,
have a ComputerName parameter that gets the objects on a remote computer.
These cmdlets do not use PowerShell remoting, so you can use them
even on computers that are not configured for remoting in Windows
PowerShell.

The objects that these cmdlets return store the name of the remote computer
in the MachineName property. (These objects do not have a PSComputerName
property.)

For example, this command gets the PowerShell process on the Server01 and
Server02 remote computers. The default display does not include the
MachineName property.

```powershell
C:\PS> get-process PowerShell -computername server01, server02

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
920      38    97524     114504   575     9.66   2648 PowerShell
194       6    24256      32384   142            3020 PowerShell
352      27    63472      63520   577     3.84   4796 PowerShell
```

You can use the Format-Table cmdlet to display the MachineName property
of the process objects.

For example, the following command saves the processes in the $p variable
and then uses a pipeline operator (|) to send the processes in $p to the
Format-Table command. The command uses the Property parameter of
Format-Table to include the MachineName property in the display.

```powershell
C:\PS> $p = get-process PowerShell -comp Server01, Server02
C:\PS> $P | format-table -property ID, ProcessName, MachineName -auto

Id ProcessName MachineName
-- ----------- -----------
2648 PowerShell  Server02
3020 PowerShell  Server01
4796 PowerShell  Server02
```

The following more complex command adds the MachineName property to the
default process display. It uses hash tables to specify calculated
properties. Fortunately, you do not have to understand it to use it.

(Note that the backtick [`] is the continuation character.)

```powershell
C:\PS> $p = get-process PowerShell -comp Server01, Server02

C:\PS> $p | format-table -property Handles, `
@{Label="NPM(K)";Expression={int}}, `
@{Label="PM(K)";Expression={int}}, `
@{Label="WS(K)";Expression={int}}, `
@{Label="VM(M)";Expression={int}}, `
@{Label="CPU(s)";Expression={if ($.CPU -ne $()){ $.CPU.ToString("N")}}}, `
Id, ProcessName, MachineName -auto

Handles NPM(K) PM(K)  WS(K) VM(M) CPU(s)   Id ProcessName MachineName
------- ------ -----  ----- ----- ------   -- ----------- -----------
920     38 97560 114532   576        2648 PowerShell  Server02
192      6 24132  32028   140        3020 PowerShell  Server01
438     26 48436  59132   565        4796 PowerShell  Server02

```

## DESERIALIZED OBJECTS

When you run remote commands that generate output, the command output is
transmitted across the network back to the local computer.

Because most live Microsoft .NET Framework objects (such as the objects
that PowerShell cmdlets return) cannot be transmitted over the
network, the live objects are "serialized". In other words, the live
objects are converted into XML representations of the object and its
properties. Then, the XML-based serialized object is transmitted across
the network.

On the local computer, PowerShell receives the XML-based serialized
object and "deserializes" it by converting the XML-based object into a
standard .NET Framework object.

However, the deserialized object is not a live object. It is a snapshot of
the object at the time that it was serialized, and it includes properties
but no methods. You can use and manage these objects in PowerShell,
including passing them in pipelines, displaying selected properties, and
formatting them.

Most deserialized objects are automatically formatted for display by
entries in the Types.ps1xml or Format.ps1xml files. However, the local
computer might not have formatting files for all of the deserialized
objects that were generated on a remote computer. When objects are
not formatted, all of the properties of each object appear in the console
in a streaming list.

When objects are not formatted automatically, you can use the formatting
cmdlets, such as Format-Table or Format-List, to format and display
selected properties. Or, you can use the Out-GridView cmdlet to display
the objects in a table.

Also, if you run a command on a remote computer that uses cmdlets that you
do not have on your local computer, the objects that the command returns
might not be formatted properly because you do not have the formatting
files for those objects on your computer. To get formatting data from
another computer, use the Get-FormatData and Export-FormatData cmdlets.

Some object types, such as DirectoryInfo objects and GUIDs, are converted
back into live objects when they are received. These objects do not need
any special handling or formatting.

## ORDERING THE RESULTS

The order of the computer names in the ComputerName parameter of cmdlets
determines the order in which PowerShell connects to the remote
computers. However, the results appear in the order in which the local
computer receives them, which might be a different order.

To change the order of the results, use the Sort-Object cmdlet. You can
sort on the PSComputerName or MachineName property. You can also sort on
another property of the object so that the results from different
computers are interspersed.

## SEE ALSO

[about_Remote](about_Remote.md)

[about_Remote_Variables](about_Remote_Variables.md)

[Format-Table](xref:Microsoft.PowerShell.Utility.Format-Table)

[Get-Process](xref:Microsoft.PowerShell.Management.Get-Process)

[Get-Service](xref:Microsoft.PowerShell.Management.Get-Service)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[Select-Object](xref:Microsoft.PowerShell.Utility.Select-Object)
