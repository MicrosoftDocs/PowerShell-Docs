---
description: This article explains how to read and understand the syntax of a cmdlet as presented by Get-Help.
ms.custom: Contributor-mikefrobbins
ms.date: 11/16/2022
ms.reviewer: mirobb
title: Appendix A - Help Syntax
---
# Appendix A - Help Syntax

The following example shows the **SYNTAX** section of the help for the `Get-EventLog` cmdlet.

```powershell
help Get-EventLog
```

```Output
NAME
    Get-EventLog

SYNOPSIS
    Gets the events in an event log, or a list of the event logs, on the local or remote
    computers.


SYNTAX
    Get-EventLog [-LogName] <String> [[-InstanceId] <Int64[]>] [-After <DateTime>]
    [-AsBaseObject] [-Before <DateTime>] [-ComputerName <String[]>] [-EntryType {Error |
    Information | FailureAudit | SuccessAudit | Warning}] [-Index <Int32[]>] [-Message
    <String>] [-Newest <Int32>] [-Source <String[]>] [-UserName <String[]>]
    [<CommonParameters>]

    Get-EventLog [-AsString] [-ComputerName <String[]>] [-List] [<CommonParameters>]
```

Only the relevant portion of the help is shown in this example.

The syntax is primarily made up of several sets of opening and closing brackets (`[]`). These have
two different meanings depending on how they're used. Anything contained within square brackets is
optional unless they're a set of empty square brackets `[]`. Empty square brackets only appear
after a datatype such as `<string[]>`. This means that particular parameter can accept more than
one value of that type.

The first parameter in the first parameter set of `Get-EventLog` is **LogName**. LogName is
surrounded by square brackets which means that it's a positional parameter. In other words,
specifying the name of the parameter itself is optional as long as it's specified in the correct
position. The information in the angle brackets (`<>`) after the parameter name indicates that it
needs a single **string** value. The entire parameter name and datatype are not surrounded by square
brackets so the **LogName** parameter is required when using this parameter set.

```powershell
Get-EventLog [-LogName] <String>
```

The second parameter is **InstanceId**. Notice that the parameter name and the datatype are both
completely surrounded by square brackets. This means that the **InstanceId** parameter is optional,
not mandatory. Also notice that **InstanceId** is surrounded by its own set of square brackets. As
with the **LogName** parameter, this means the parameter is positional. There's one last set of
square brackets after the datatype. This means that it can accept more than one value in the form of
an array or a comma-separated list.

```
[[-InstanceId] <Int64[]>]
```

The second parameter set has a **List** parameter. It's a switch parameter because there's no
datatype following the parameter name. When the **List** parameter is specified, the value is
**True**. When it's not specified, the value is **False**.

```
[-List]
```

The syntax information for a command can also be retrieved using `Get-Command` using the **Syntax**
parameter. This is a handy shortcut that I use all the time. It allows me to quickly learn how to
use a command without having to sift through multiple pages of help information. If I end up needing
more information, then I'll revert to using the actual help content.

```powershell
Get-Command -Name Get-EventLog -Syntax
```

```Output
Get-EventLog [-LogName] <string> [[-InstanceId] <long[]>] [-ComputerName <string[]>] [-Newest <int>]
 [-After <datetime>] [-Before <datetime>] [-UserName <string[]>] [-Index <int[]> ]
 [-EntryType <string[]>] [-Source <string[]>] [-Message <string>] [-AsBaseObject]
 [<CommonParameters>]

Get-EventLog [-ComputerName <string[]>] [-List] [-AsString] [<CommonParameters>]
```

The more you use the help system in PowerShell, the easier remembering all of the different nuances
becomes. Before you know it, using it becomes second nature.
