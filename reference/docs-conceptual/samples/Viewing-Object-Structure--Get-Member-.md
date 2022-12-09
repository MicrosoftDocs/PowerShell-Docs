---
description: Get-Member is a powerful tool that allows to see the type and structure of objects in PowerShell.
ms.date: 12/08/2022
title: Viewing object structure
---
# Viewing object structure

Because objects play such a central role in PowerShell, there are several native commands designed
to work with arbitrary object types. The most important one is the `Get-Member` command.

The simplest technique for analyzing the objects that a command returns is to pipe the output of
that command to the `Get-Member` cmdlet. The `Get-Member` cmdlet shows you the formal name of the
object type and a complete listing of its members. The number of elements that are returned can
sometimes be overwhelming. For example, a process object can have over 100 members.

The following command allows you to see all the members of a **Process** object and page through the
output.

```powershell
Get-Process | Get-Member | Out-Host -Paging
```

```Output
TypeName: System.Diagnostics.Process

Name                           MemberType     Definition
----                           ----------     ----------
Handles                        AliasProperty  Handles = Handlecount
Name                           AliasProperty  Name = ProcessName
NPM                            AliasProperty  NPM = NonpagedSystemMemorySize
PM                             AliasProperty  PM = PagedMemorySize
VM                             AliasProperty  VM = VirtualMemorySize
WS                             AliasProperty  WS = WorkingSet
add_Disposed                   Method         System.Void add_Disposed(Event...
...
```

We can make this long list of information more usable by filtering for elements we want to see. The
`Get-Member` command lets you list only members that are properties. There are several forms of
properties. The cmdlet displays properties of a type using the **MemberType** parameter with the
value `Properties`. The resulting list is still very long, but a more manageable:

```powershell
Get-Process | Get-Member -MemberType Properties
```

```Output
   TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
Name                       AliasProperty  Name = ProcessName
...
ExitCode                   Property       System.Int32 ExitCode {get;}
...
Handle                     Property       System.IntPtr Handle {get;}
...
CPU                        ScriptProperty System.Object CPU {get=$this.Total...
...
Path                       ScriptProperty System.Object Path {get=$this.Main...
...
```

> [!NOTE]
> The allowed values of MemberType are AliasProperty, CodeProperty, Property, NoteProperty,
> ScriptProperty, Properties, PropertySet, Method, CodeMethod, ScriptMethod, Methods,
> ParameterizedProperty, MemberSet, and All.

There are more than 60 properties for a process. By default, PowerShell determines how to display an
object type using information stored in XML files that have names ending in `.format.ps1xml`. The
formatting definition for process objects is stored in `DotNetTypes.format.ps1xml`.

If you need to look at properties other than those that PowerShell displays by default, you can
format the output using the `Format-*` cmdlets.
