---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 4/26/2019
online version: http://go.microsoft.com/fwlink/?LinkId=821810
schema: 2.0.0
title: Group-Object
---
# Group-Object

## SYNOPSIS
Groups objects that contain the same value for specified properties.

## SYNTAX

```
Group-Object [-NoElement] [-AsHashTable] [-AsString] [-InputObject <PSObject>] [[-Property] <Object[]>]
 [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

## DESCRIPTION

The `Group-Object` cmdlet displays objects in groups based on the value of a specified property.
`Group-Object` returns a table with one row for each property value and a column that displays the
number of items with that value.

If you specify more than one property, `Group-Object` first groups them by the values of the first
property, and then, within each property group, it groups by the value of the next property.

## EXAMPLES

### Example 1: Group files by extension

This example recursively gets the files under `$PSHOME` and groups them by file name extension. The
output is sent to the `Sort-Object` cmdlet which sorts them by the count files found for the given
extension. The empty **Name** represents directories.

This example uses the **NoElement** parameter to omit the members of the group.

```powershell
$files = Get-ChildItem -Path $PSHOME -Recurse
$files | Group-Object -Property extension -NoElement | Sort-Object -Property Count -Descending
```

```Output
Count Name
----- ----
  365 .xml
  231 .cdxml
  197
  169 .ps1xml
  142 .txt
  114 .psd1
   63 .psm1
   49 .xsd
   36 .dll
   15 .mfl
   15 .mof
...
```

### Example 2: Group integers by odds and evens

This example shows how to use script blocks as the value of the **Property** parameter.

This command displays the integers from 1 to 20, grouped by odds and even.

```powershell
1..20 | Group-Object -Property {$_ % 2}
```

```Output
Count Name                      Group
----- ----                      -----
   10 1                         {1, 3, 5, 7, 9, 11, 13, 15, 17, 19}
   10 0                         {2, 4, 6, 8, 10, 12, 14, 16, 18, 20}
```

### Example 3: Group event log events by EntryType

These commands display the 1,000 most recent entries in the System event log, grouped by **EntryType**.

In the output, the **Count** column represents the number of entries in each group, the **Name**
column represents the **EventType** values that define a group, and the **Group** column represents
the objects in each group.

```powershell
Get-WinEvent -LogName System -MaxEvents 1000 | Group-Object -Property LevelDisplayName
```

```Output
Count Name          Group
----- ----          -----
  153 Error         {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics.…
  722 Information   {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics.…
  125 Warning       {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics.…
```

### Example 4: Group processes by priority class

This example demonstrates the effect of the **NoElement** parameter.
These commands group the processes on the computer by priority class.

The first command uses the `Get-Process` cmdlet to get the processes on the computer.
It uses a pipeline operator `|` to send the results to `Group-Object`, which groups the objects by
the value of the **PriorityClass** property of the process.

The second command is identical to the first, except that it uses the **NoElement** parameter to
eliminate the members of the group from the output.
The result is a table with only the count and property value name.

The results are shown in the following sample output.

```powershell
Get-Process | Group-Object -Property PriorityClass
```

```Output
Count Name         Group
----- ----         -----
   55 Normal       {System.Diagnostics.Process (AdtAgent), System.Diagnosti...
    1              {System.Diagnostics.Process (Idle)}
    3 High         {System.Diagnostics.Process (Newproc), System.Diagnostic...
    2 BelowNormal  {System.Diagnostics.Process (winperf),
```

```powershell
Get-Process | Group-Object -Property PriorityClass -NoElement
```

```Output
Count Name
----- ----
   55 Normal
    1
    3 High
    2 BelowNormal
```

### Example 5: Group processes by name

The following example uses `Group-Object` to multiple instances of processes running on the local
computer.

```powershell
Get-Process | Group-Object -Property Name -NoElement | Where {$_.count -gt 1}
```

```Output
Count Name
----- ----
2     csrss
5     svchost
2     winlogon
2     wmiprvse
```

### Example 8: Group objects in a hash table

This example uses the **AsHashTable** and **AsString** parameters to return the groups in a hash
table, that is, as a collection of key-value pairs.

In the resulting hash table, each property value is a key, and the group elements are the values.
Because each key is a property of the hash table object, you can use dot notation to display the
values.

The first command gets the `Get` and `Set` cmdlets in the session, groups them by verb, returns the
groups as a hash table, and saves the hash table in the `$A` variable.

The second command displays the hash table in `$A`.
There are two key-value pairs, one for the `Get` cmdlets and one for the `Set` cmdlets.

The third command uses dot notation to display the values of the **Get** key in `$A`.
The values are **CmdletInfo** object.
The **AsString** parameter does not convert the objects in the groups to strings.

```powershell
$A = Get-Command get-*, set-* -CommandType cmdlet | Group-Object -Property verb -AsHashTable -AsString
$A
```

```Output
Name    Value
----    -----
Get     {Get-PSCallStack, Get-PSBreakpoint, Get-PSDrive, Get-PSSession...}
Set     {Set-Service, Set-StrictMode, Set-PSDebug, Set-PSSessionConfiguration...}
```

```powershell
$A.get
```

```Output
CommandType     Name                 Definition
-----------     ----                 ----------
Cmdlet          Get-PSCallStack      Get-PSCallStack [-Verbose] [-Debug] [-ErrorAction <ActionPrefer...
Cmdlet          Get-PSBreakpoint     Get-PSBreakpoint [[-Id] <Int32[]>] [-Verbose] [-Debug] [-ErrorA...
Cmdlet          Get-PSDrive          Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider...
...
```

## PARAMETERS

### -AsHashTable

Indicates that this cmdlet returns the group as a hash table.
The keys of the hash table are the property values by which the objects are grouped.
The values of the hash table are the objects that have that property value.

By itself, the **AsHashTable** parameter returns each hash table in which each key is an instance of
the grouped object.
When used with the **AsString** parameter, the keys in the hash table are strings.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: AHT

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsString

Indicates that this cmdlet converts the hash table keys to strings.
By default, the hash table keys are instances of the grouped object.
This parameter is valid only when used with the **AsHashTable** parameter.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaseSensitive

Indicates that this cmdlet makes the grouping case-sensitive.
Without this parameter, the property values of objects in a group might have different cases.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Culture

Specifies the culture to use when comparing strings.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to group.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

When you use the **InputObject** parameter to submit a collection of objects to `Group-Object`,
`Group-Object` receives one object that represents the collection.
As a result, it creates a single group with that object as its member.

To group the objects in a collection, pipe the objects to `Group-Object`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoElement

Indicates that this cmdlet omits the members of a group from the results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies the properties for grouping.
The objects are arranged into groups based on the value of the specified property.

The value of the **Property** parameter can be a new calculated property.
To create a calculated, property, create a hash table with an **Expression** key that specifies a string
or script block value.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Group-Object`.

## OUTPUTS

### Microsoft.PowerShell.Commands.GroupInfo or System.Collections.Hashtable

When you use the **AsHashTable** parameter, `Group-Object` returns a hash table.
Otherwise, it returns a **GroupInfo** object.

## NOTES

- You can also use the **GroupBy** parameter of the formatting cmdlets (such as `Format-Table`
  and `Format-List`) to group objects. Unlike `Group-Object`, which creates a single
  table with a row for each property value, the **GroupBy** parameters create a table for each
  property value with a row for each item that has the property value.

  `Group-Object` does not require that the objects being grouped be of the same Microsoft .NET
  Framework type. When grouping objects of different .NET Framework types, `Group-Object` uses the
  following rules:

  - Same Property Names and Types.
    If the objects have a property with the specified name, and the property values have the same .NET
    Framework type, the property values are grouped by using the same rules that would be used for
    objects of the same type.

  - Same Property Names, Different Types.
    If the objects have a property with the specified name, but the property values have a different
    .NET Framework type in different objects, `Group-Object` uses the .NET Framework type of the first
    occurrence of the property as the .NET Framework type for that property group.
    When an object has a property with a different type, the property value is converted to the type for
    that group. If the type conversion fails, the object is not included in the group.

  - Missing Properties.
    Objects that do not have a specified property are considered ungroupable.
    Ungroupable objects appear in the final **GroupInfo** object output in a group named
    `AutomationNull.Value`.

## RELATED LINKS

[Compare-Object](Compare-Object.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)