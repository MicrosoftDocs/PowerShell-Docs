---
ms.date:  11/22/2019
keywords:  powershell,cmdlet
title:  Using Format Commands to Change Output View
description: PowerShell has a extensible formatting system that allows you to present output in lists, tables, or custom layouts.
---
# Using Format Commands to Change Output View

PowerShell has a set of cmdlets that allow you to control how properties are displayed for
particular objects. The names of all the cmdlets begin with the verb `Format`. They let you select
which properties you want to show.

```powershell
Get-Command -Verb Format -Module Microsoft.PowerShell.Utility
```

```Output
CommandType     Name               Version    Source
-----------     ----               -------    ------
Cmdlet          Format-Custom      6.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-Hex         6.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-List        6.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-Table       6.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-Wide        6.1.0.0    Microsoft.PowerShell.Utility
```

This article describes the `Format-Wide`, `Format-List`, and `Format-Table` cmdlets.

Each object type in PowerShell has default properties that are used when you don't specify which
properties to display. Each cmdlet also uses the same **Property** parameter to specify which
properties you want to display. Because `Format-Wide` only shows a single property, its **Property**
parameter only takes a single value, but the property parameters of `Format-List` and `Format-Table`
accept a list of property names.

In this example, the default output of `Get-Process` cmdlet shows that we have two instances of
Internet Explorer running.

```powershell
Get-Process -Name iexplore
```

The default format for **Process** objects displays the properties shown here:

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     32    25.52      10.25      13.11   12808   1 iexplore
     52    11.46      26.46       3.55   21748   1 iexplore
```

## Using Format-Wide for Single-Item Output

The `Format-Wide` cmdlet, by default, displays only the default property of an object. The
information associated with each object is displayed in a single column:

```powershell
Get-Command -Verb Format | Format-Wide
```

```Output
Format-Custom          Format-Hex
Format-List            Format-Table
Format-Wide
```

You can also specify a non-default property:

```powershell
Get-Command -Verb Format | Format-Wide -Property Noun
```

```Output
Custom                 Hex
List                   Table
Wide
```

### Controlling Format-Wide Display with Column

With the `Format-Wide` cmdlet, you can only display a single property at a time. This makes it
useful for displaying large lists in multiple columns.

```powershell
Get-Command -Verb Format | Format-Wide -Property Noun -Column 3
```

```Output
Custom                 Hex                  List
Table                  Wide

```

## Using Format-List for a List View

The `Format-List` cmdlet displays an object in the form of a listing, with each property labeled
and displayed on a separate line:

```powershell
Get-Process -Name iexplore | Format-List
```

```Output
Id      : 12808
Handles : 578
CPU     : 13.140625
SI      : 1
Name    : iexplore

Id      : 21748
Handles : 641
CPU     : 3.59375
SI      : 1
Name    : iexplore
```

You can specify as many properties as you want:

```powershell
Get-Process -Name iexplore | Format-List -Property ProcessName,FileVersion,StartTime,Id
```

```Output
ProcessName : iexplore
FileVersion : 11.00.18362.1 (WinBuild.160101.0800)
StartTime   : 10/22/2019 11:23:58 AM
Id          : 12808

ProcessName : iexplore
FileVersion : 11.00.18362.1 (WinBuild.160101.0800)
StartTime   : 10/22/2019 11:23:57 AM
Id          : 21748
```

### Getting Detailed Information by Using Format-List with Wildcards

The `Format-List` cmdlet lets you use a wildcard as the value of its **Property** parameter. This
lets you display detailed information. Often, objects include more information than you need, which
is why PowerShell doesn't show all property values by default. To show all of properties of
an object, use the `Format-List -Property *` command. The following command generates over 60
lines of output for a single process:

```powershell
Get-Process -Name iexplore | Format-List -Property *
```

Although the `Format-List` command is useful for showing detail, if you want an overview of output
that includes many items, a simpler tabular view is often more useful.

## Using Format-Table for Tabular Output

If you use the `Format-Table` cmdlet with no property names specified to format the output of the
`Get-Process` command, you get exactly the same output as you do without a `Format` cmdlet. By
default, PowerShell displays **Process** objects in a tabular format.

```powershell
Get-Service -Name win* | Format-Table
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  WinDefend          Windows Defender Antivirus Service
Running  WinHttpAutoProx... WinHTTP Web Proxy Auto-Discovery Se...
Running  Winmgmt            Windows Management Instrumentation
Running  WinRM              Windows Remote Management (WS-Manag...
```

### Improving Format-Table Output (AutoSize)

Although a tabular view is useful for displaying lots of information, it may be difficult to
interpret if the display is too narrow for the data. In the previous example, the output is
truncated. If you specify the **AutoSize** parameter when you run the `Format-Table` command,
PowerShell calculates column widths based on the actual data displayed. This makes the columns
readable.

```powershell
Get-Service -Name win* | Format-Table -AutoSize
```

```Output
Status  Name                DisplayName
------  ----                -----------
Running WinDefend           Windows Defender Antivirus Service
Running WinHttpAutoProxySvc WinHTTP Web Proxy Auto-Discovery Service
Running Winmgmt             Windows Management Instrumentation
Running WinRM               Windows Remote Management (WS-Management)
```

The `Format-Table` cmdlet might still truncate data, but it only truncates at the end of the
screen. Properties, other than the last one displayed, are given as much size as they need for their
longest data element to display correctly.

```powershell
Get-Service -Name win* | Format-Table -Property Name,Status,StartType,DisplayName,DependentServices -AutoSize
```

```Output
Name                 Status StartType DisplayName                               DependentServi
                                                                                ces
----                 ------ --------- -----------                               --------------
WinDefend           Running Automatic Windows Defender Antivirus Service        {}
WinHttpAutoProxySvc Running    Manual WinHTTP Web Proxy Auto-Discovery Service  {NcaSvc, iphl…
Winmgmt             Running Automatic Windows Management Instrumentation        {vmms, TPHKLO…
WinRM               Running Automatic Windows Remote Management (WS-Management) {}
```

The `Format-Table` command assumes that properties are listed in order of importance. So it attempts
to fully display the properties nearest the beginning. If the `Format-Table` command can't display
all the properties, it removes some columns from the display. You can see this behavior in the
**DependentServices** property previous example.

### Wrapping Format-Table Output in Columns (Wrap)

You can force lengthy `Format-Table` data to wrap within its display column by using the **Wrap**
parameter. Using the **Wrap** parameter may not do what you expect, since it uses
default settings if you don't also specify **AutoSize**:

```powershell
Get-Service -Name win* | Format-Table -Property Name,Status,StartType,DisplayName,DependentServices -Wrap
```

```Output
Name                 Status StartType DisplayName                               DependentServi
                                                                                ces
----                 ------ --------- -----------                               --------------
WinDefend           Running Automatic Windows Defender Antivirus Service        {}
WinHttpAutoProxySvc Running    Manual WinHTTP Web Proxy Auto-Discovery Service  {NcaSvc,
                                                                                iphlpsvc}
Winmgmt             Running Automatic Windows Management Instrumentation        {vmms,
                                                                                TPHKLOAD,
                                                                                SUService,
                                                                                smstsmgr…}
WinRM               Running Automatic Windows Remote Management (WS-Management) {}
```

Using the **Wrap** parameter by itself doesn't slow down processing very much. However, using
**AutoSize** to format a recursive file listing of a large directory structure can take a long time
and use lots of memory before displaying the first output items.

If you aren't concerned about system load, then **AutoSize** works well with the **Wrap** parameter.
The initial columns still use as much width as needed to display items on one line, but the final
column is wrapped, if necessary.

> [!NOTE]
> Some columns may not be displayed when you specify the widest columns first. For best results,
> specify the smallest data elements first.

In the following example, we specify the widest properties first.

```powershell
Get-Process -Name iexplore | Format-Table -Wrap -AutoSize -Property FileVersion,Path,Name,Id
```

Even with wrapping, the final **Id** column is omitted:

```Output
FileVersion                          Path                                                  Nam
                                                                                           e
-----------                          ----                                                  ---
11.00.18362.1 (WinBuild.160101.0800) C:\Program Files (x86)\Internet Explorer\IEXPLORE.EXE iex
                                                                                           plo
                                                                                           re
11.00.18362.1 (WinBuild.160101.0800) C:\Program Files\Internet Explorer\iexplore.exe       iex
                                                                                           plo
                                                                                           re
```

### Organizing Table Output (-GroupBy)

Another useful parameter for tabular output control is **GroupBy**. Longer tabular listings in
particular may be hard to compare. The **GroupBy** parameter groups output based on a property
value. For example, we can group services by **StartType** for easier inspection, omitting the
**StartType** value from the property listing:

```powershell
Get-Service -Name win* | Sort-Object StartType | Format-Table -GroupBy StartType
```

```Output
   StartType: Automatic
Status   Name               DisplayName
------   ----               -----------
Running  WinDefend          Windows Defender Antivirus Service
Running  Winmgmt            Windows Management Instrumentation
Running  WinRM              Windows Remote Management (WS-Managem…

   StartType: Manual
Status   Name               DisplayName
------   ----               -----------
Running  WinHttpAutoProxyS… WinHTTP Web Proxy Auto-Discovery Serv…
```
