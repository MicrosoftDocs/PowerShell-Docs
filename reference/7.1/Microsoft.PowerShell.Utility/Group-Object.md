---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/group-object?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Group-Object
---

# Group-Object

## SYNOPSIS
Groups objects that contain the same value for specified properties.

## SYNTAX

### HashTable

```
Group-Object [-NoElement] [-AsHashTable] [-AsString] [-InputObject <PSObject>]
 [[-Property] <Object[]>] [-Culture <String>] [-CaseSensitive] [<CommonParameters>]
```

## DESCRIPTION

The `Group-Object` cmdlet displays objects in groups based on the value of a specified property.
`Group-Object` returns a table with one row for each property value and a column that displays the
number of items with that value.

If you specify more than one property, `Group-Object` first groups them by the values of the first
property, and then, within each property group, it groups by the value of the next property.

Beginning in PowerShell 7, `Group-Object` can combine the **CaseSensitive** and **AsHashtable**
parameters to create a case-sensitive hash table. The hash table keys use case-sensitive comparisons
and output a **System.Collections.Hashtable** object.

## EXAMPLES

### Example 1: Group files by extension

This example recursively gets the files under `$PSHOME` and groups them by file name extension. The
output is sent to the `Sort-Object` cmdlet, which sorts them by the count files found for the given
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

This example shows how to use script blocks as the value of the **Property** parameter. This command
displays the integers from 1 to 20, grouped by odds and even.

```powershell
1..20 | Group-Object -Property {$_ % 2}
```

```Output
Count Name                      Group
----- ----                      -----
   10 0                         {2, 4, 6, 8...}
   10 1                         {1, 3, 5, 7...}
```

### Example 3: Group event log events by EntryType

This example displays the 1,000 most recent entries in the System event log, grouped by
**EntryType**.

In the output, the **Count** column represents the number of entries in each group. The **Name**
column represents the **EventType** values that define a group. The **Group** column represents the
objects in each group.

```powershell
Get-WinEvent -LogName System -MaxEvents 1000 | Group-Object -Property LevelDisplayName
```

```Output
Count Name          Group
----- ----          -----
  153 Error         {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics...}
  722 Information   {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics...}
  125 Warning       {System.Diagnostics.Eventing.Reader.EventLogRecord, System.Diagnostics...}
```

### Example 4: Group processes by priority class

This example demonstrates the effect of the **NoElement** parameter. These commands group the
processes on the computer by priority class.

The first command uses the `Get-Process` cmdlet to get the processes on the computer and sends the
objects down the pipeline. `Group-Object`groups the objects by the value of the **PriorityClass**
property of the process.

The second example uses the **NoElement** parameter to eliminate the members of the group from the
output. The result is a table with only the **Count** and **Name** property value.

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

The following example uses `Group-Object` to group multiple instances of processes running on the
local computer. `Where-Object` displays processes with more than one instance.

```powershell
Get-Process | Group-Object -Property Name -NoElement | Where-Object {$_.Count -gt 1}
```

```Output
Count Name
----- ----
2     csrss
5     svchost
2     winlogon
2     wmiprvse
```

### Example 6: Group objects in a hash table

This example uses the **AsHashTable** and **AsString** parameters to return the groups in a hash
table, as a collection of key-value pairs.

In the resulting hash table, each property value is a key, and the group elements are the values.
Because each key is a property of the hash table object, you can use dot notation to display the
values.

The first command gets the `Get` and `Set` cmdlets in the session, groups them by verb, returns the
groups as a hash table, and saves the hash table in the `$A` variable.

The second command displays the hash table in `$A`. There are two key-value pairs, one for the `Get`
cmdlets and one for the `Set` cmdlets.

The third command uses dot notation, `$A.Get` to display the values of the **Get** key in `$A`. The
values are **CmdletInfo** object. The **AsString** parameter doesn't convert the objects in the
groups to strings.

```powershell
$A = Get-Command Get-*, Set-* -CommandType cmdlet | Group-Object -Property Verb -AsHashTable -AsString
$A
```

```Output
Name     Value
----     -----
Get      {Get-Acl, Get-Alias, Get-AppLockerFileInformation, Get-AppLockerPolicy...}
Set      {Set-Acl, Set-Alias, Set-AppBackgroundTaskResourcePolicy, Set-AppLockerPolicy...}
```

```powershell
$A.Get
```

```Output
CommandType     Name                                Version    Source
-----------     ----                                -------    ------
Cmdlet          Get-Acl                             7.0.0.0    Microsoft.PowerShell.Security
Cmdlet          Get-Alias                           7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-AppLockerFileInformation        2.0.0.0    AppLocker
Cmdlet          Get-AppLockerPolicy                 2.0.0.0    AppLocker
...
```

### Example 7: Create a case-sensitive hash table

This example combines the **CaseSensitive** and **AsHashTable** parameters to create a
case-sensitive hash table. The files in the example have extensions of `.txt` and `.TXT`.

```powershell
$hash = Get-ChildItem -Path C:\Files | Group-Object -Property Extension -CaseSensitive -AsHashTable
$hash
```

```Output
Name           Value
----           -----
.TXT           {C:\Files\File7.TXT, C:\Files\File8.TXT, C:\Files\File9.TXT}
.txt           {C:\Files\file1.txt, C:\Files\file2.txt, C:\Files\file3.txt}
```

The `$hash` variable stores the **System.Collections.Hashtable** object. `Get-ChildItem` gets the
file names from the `C:\Files` directory and sends the **System.IO.FileInfo** objects down the
pipeline. `Group-Object` groups the objects using the **Property** value **Extension**. The
**CaseSensitive** and **AsHashTable** parameters create the hash table and the keys are grouped
using the case-sensitive keys `.txt` and `.TXT`.

## PARAMETERS

### -AsHashTable

Indicates that this cmdlet returns the group as a hash table. The keys of the hash table are the
property values by which the objects are grouped. The values of the hash table are the objects that
have that property value.

By itself, the **AsHashTable** parameter returns each hash table in which each key is an instance of
the grouped object. When used with the **AsString** parameter, the keys in the hash table are
strings.

Beginning in PowerShell 7, to create case-sensitive hash tables, include **CaseSensitive** and
**AsHashtable** in your command.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: AHT

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsString

Indicates that this cmdlet converts the hash table keys to strings. By default, the hash table keys
are instances of the grouped object. This parameter is valid only when used with the **AsHashTable**
parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaseSensitive

Indicates that this cmdlet makes the grouping case-sensitive. Without this parameter, the property
values of objects in a group might have different cases.

Beginning in PowerShell 7, to create case-sensitive hash tables, include **CaseSensitive** and
**AsHashtable** in your command.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Culture

Specifies the culture to use when comparing strings.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to group. Enter a variable that contains the objects, or type a command or
expression that gets the objects.

When you use the **InputObject** parameter to submit a collection of objects to `Group-Object`,
`Group-Object` receives one object that represents the collection. As a result, it creates a single
group with that object as its member.

To group the objects in a collection, pipe the objects to `Group-Object`.

```yaml
Type: System.Management.Automation.PSObject
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies the properties for grouping. The objects are arranged into groups based on the value of
the specified property.

The value of the **Property** parameter can be a new calculated property. The calculated property
can be a script block or a hash table. Valid key-value pairs are:

- Expression - `<string>` or `<script block>`

For more information, see
[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md).

```yaml
Type: System.Object[]
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Group-Object`.

## OUTPUTS

### Microsoft.PowerShell.Commands.GroupInfo or System.Collections.Hashtable

When you use the **AsHashTable** parameter, `Group-Object` returns a **Hashtable** object.
Otherwise, it returns a **GroupInfo** object.

## NOTES

You can use the **GroupBy** parameter of the formatting cmdlets, such as `Format-Table` and
`Format-List`, to group objects. Unlike `Group-Object`, which creates a single table with a row for
each property value, the **GroupBy** parameters create a table for each property value with a row
for each item that has the property value.

`Group-Object` doesn't require that the objects being grouped are of the same Microsoft .NET Core
type. When grouping objects of different .NET Core types, `Group-Object` uses the following rules:

- Same Property Names and Types.

  If the objects have a property with the specified name, and the property values have the same .NET
  Core type, the property values are grouped by using the same rules that would be used for objects
  of the same type.

- Same Property Names, Different Types.

  If the objects have a property with the specified name, but the property values have a different
  .NET Core type in different objects, `Group-Object` uses the .NET Core type of the first
  occurrence of the property as the .NET Core type for that property group. When an object has a
  property with a different type, the property value is converted to the type for that group. If the
  type conversion fails, the object isn't included in the group.

- Missing Properties.

  Objects that don't have a specified property can't be grouped. Objects that aren't grouped appear
  in the final **GroupInfo** object output in a group named `AutomationNull.Value`.

## RELATED LINKS

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md)

[Compare-Object](Compare-Object.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)
