---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821852
schema: 2.0.0
title: Select-Object
---

# Select-Object

## SYNOPSIS

Selects objects or object properties.

## SYNTAX

### DefaultParameter (Default)
```
Select-Object [-InputObject <PSObject>] [[-Property] <Object[]>] [-ExcludeProperty <String[]>]
 [-ExpandProperty <String>] [-Unique] [-Last <Int32>] [-First <Int32>] [-Skip <Int32>] [-Wait]
 [<CommonParameters>]
```

### SkipLastParameter
```
Select-Object [-InputObject <PSObject>] [[-Property] <Object[]>] [-ExcludeProperty <String[]>]
 [-ExpandProperty <String>] [-Unique] [-SkipLast <Int32>] [<CommonParameters>]
```

### IndexParameter
```
Select-Object [-InputObject <PSObject>] [-Unique] [-Wait] [-Index <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Select-Object` cmdlet selects specified properties of an object or set of objects.
It can also select unique objects, a specified number of objects, or objects in a specified position in an array.

To select objects from a collection, use the **First**, **Last**, **Unique**, **Skip**, and **Index** parameters.
To select object properties, use the **Property** parameter.
When you select properties, `Select-Object` returns new objects that have only the specified properties.

Beginning in Windows PowerShell 3.0, `Select-Object` includes an optimization feature that prevents commands from creating and processing objects that are not used.
When you include a `Select-Object` command with the **First** or **Index** parameters in a command pipeline, PowerShell stops the command that generates the objects as soon as the selected number of objects is generated, even when the command that generates the objects appears before the `Select-Object` command in the pipeline.
To turn off this optimizing behavior, use the **Wait** parameter.

## EXAMPLES

### Example 1: Select objects by property

```powershell
Get-Process | Select-Object -Property ProcessName, Id, WS
```

This command creates objects that have the Name, ID, and working set (WS) properties of process objects.

### Example 2: Select objects by property and format the results

```powershell
Get-Process Explorer | Select-Object -Property ProcessName -ExpandProperty Modules | Format-List
```

```output
ProcessName       : explorer
ModuleName        : explorer.exe
FileName          : C:\WINDOWS\explorer.exe
BaseAddress       : 140697278152704
ModuleMemorySize  : 3919872
EntryPointAddress : 140697278841168
FileVersionInfo   : File:             C:\WINDOWS\explorer.exe
InternalName:     explorer
OriginalFilename: EXPLORER.EXE.MUI
FileVersion:      10.0.17134.1 (WinBuild.160101.0800)
FileDescription:  Windows Explorer
Product:          Microsoft� Windows� Operating System
ProductVersion:   10.0.17134.1
...
```

This command gets information about the modules used by the processes on the computer.
It uses `Get-Process` cmdlet to get the process on the computer.

It uses the `Select-Object` cmdlet to output an array of `[System.Diagnostics.ProcessModule]` instances as contained in the `Modules` property of each `System.Diagnostics.Process` instance output by `Get-Process`.

The command uses the **Property** parameter of the `Select-Object` cmdlet to select the process names. This add a `ProcessName` `NoteProperty` to every `[System.Diagnostics.ProcessModule]` instance and populates it with the value of current processes `ProcessName` property.

The command uses the `Format-List` parameter to display the name and modules in of each process in a list.

### Example 3: Select processes using the most memory

```powershell
Get-Process | Sort-Object -Property WS | Select-Object -Last 5
```

```output
Handles  NPM(K)    PM(K)      WS(K) VS(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
2866     320       33432      45764   203   222.41   1292 svchost
577      17        23676      50516   265    50.58   4388 WINWORD
826      11        75448      76712   188    19.77   3780 Ps
1367     14        73152      88736   216    61.69    676 Ps
1612     44        66080      92780   380   900.59   6132 INFOPATH
```

This command gets the five processes that are using the most memory.
The `Get-Process` cmdlet gets the processes on the computer.
The `Sort-Object` cmdlet sorts the processes according to memory (working set) usage, and the `Select-Object` cmdlet selects only the last five members of the resulting array of objects.

The **Wait** parameter is not required in commands that include the `Sort-Object` cmdlet because `Sort-Object` processes all objects and then returns a collection.
The `Select-Object` optimization is available only for commands that return objects individually as they are processed.

### Example 4: Select the name and start day of processes

```powershell
Get-Process | Select-Object -Property ProcessName,@{Name="Start Day"; Expression = {$_.StartTime.DayOfWeek}}
```

```output
ProcessName  StartDay
----         --------
alg          Wednesday
ati2evxx     Wednesday
ati2evxx     Thursday
...
```

This command gets the name and start day of the processes running on a computer.

The command uses the `Get-Process` cmdlet to get the processes on the computer.
It passes the processes to the `Select-Object` cmdlet, which creates objects that have only the *ProcessName* parameter and a calculated property named Start Day.
The Start Day property is added by using a hash table with Name and Expression keys.
The value of the Expression key is a script blocks that gets the **StartTime** property of each process and the **DayofWeek** property of the StartTime.

### Example 5: Select unique characters from an array

```powershell
"a","b","c","a","a","a" | Select-Object -Unique
```

```output
a
b
c
```

This command uses the Unique parameter of `Select-Object` to get unique characters from an array of characters.

### Example 6: Select newest and oldest events in the event log

```powershell
$a = Get-EventLog -LogName "Windows PowerShell"
$a | Select-Object -Index 0, ($A.count - 1)
```

These commands gets the first (newest) and last (oldest) events in the Windows Powershell event log.

The command uses the `Get-EventLog` cmdlet to get all events in the Windows PowerShell log.
It saves them in the `$a` variable.

The second command uses a pipeline operator (|) to send the events in `$a` to the `Select-Object` cmdlet.
The `Select-Object` command uses the **Index** parameter to select events from the array of events in the `$a` variable.
The index of the first event is 0.
The index of the last event is the number of items in `$a` minus 1.

### Example 7: Select all but the first object

```powershell
New-PSSession -ComputerName (Get-Content Servers.txt | Select-Object -Skip 1)
```

This command creates a new PSSession on each of the computers listed in the Servers.txt files, except for the first one.

This command uses the `Select-Object` cmdlet to select all but the first computer in a list of computer names.
The resulting list of computers is set as the value of the **ComputerName** parameter of the `New-PSSession` cmdlet.

### Example 8: Rename files and select several to review

```powershell
Get-ChildItem *.txt -ReadOnly | Rename-Item -NewName {$_.BaseName + "-ro.txt"} -PassThru | Select-Object -First 5 -Wait
```

This command adds a "-ro" suffix to the base names of text files that have the read-only attribute and then displays the first five files so the user can see a sample of the effect.

The command uses the **ReadOnly** dynamic parameter of the `Get-ChildItem` for FileSystem cmdlet to get read-only files.
It uses a pipeline operator (|) to send the files to the `Rename-Item` cmdlet, which renames the file.
It uses the **Passthru** parameter of `Rename-Item` to send the renamed files to the `Select-Object` cmdlet, which selects the first 5 for display.

The **Wait** parameter of `Select-Object` prevents PowerShell from stopping the `Get-ChildItem` cmdlet after it gets the first five read-only text files.
Without this parameter, only the first five read-only files would be renamed.

### Example 9: Demonstrate the intricacies of the -ExpandProperty parameter

```powershell
# Create a custom object to use for the Select-Object example.
$object = [pscustomobject]@{Name="CustomObject";Expand=@(1,2,3,4,5)}
# Use the ExpandProperty parameter to Expand the property.
$object | Select-Object -ExpandProperty Expand -Property Name
```

```output
1
2
3
4
5
```

```powershell
# The output did not contain the Name property, but it was added successfully.
# Use Get-Member to confirm the Name property was added and populated.
$object | Select-Object -ExpandProperty Expand -Property Name | Get-Member
```

```output
TypeName: System.Int32

Name        MemberType   Definition
----        ----------   ----------
CompareTo   Method       int CompareTo(System.Object value), int CompareTo(int value), int IComparable.CompareTo(System.Object obj)...
Equals      Method       bool Equals(System.Object obj), bool Equals(int obj), bool IEquatable[int].Equals(int other)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
GetTypeCode Method       System.TypeCode GetTypeCode(), System.TypeCode IConvertible.GetTypeCode()
ToBoolean   Method       bool IConvertible.ToBoolean(System.IFormatProvider provider)
ToByte      Method       byte IConvertible.ToByte(System.IFormatProvider provider)
ToChar      Method       char IConvertible.ToChar(System.IFormatProvider provider)
ToDateTime  Method       datetime IConvertible.ToDateTime(System.IFormatProvider provider)
ToDecimal   Method       decimal IConvertible.ToDecimal(System.IFormatProvider provider)
ToDouble    Method       double IConvertible.ToDouble(System.IFormatProvider provider)
ToInt16     Method       int16 IConvertible.ToInt16(System.IFormatProvider provider)
ToInt32     Method       int IConvertible.ToInt32(System.IFormatProvider provider)
ToInt64     Method       long IConvertible.ToInt64(System.IFormatProvider provider)
ToSByte     Method       sbyte IConvertible.ToSByte(System.IFormatProvider provider)
ToSingle    Method       float IConvertible.ToSingle(System.IFormatProvider provider)
ToString    Method       string ToString(), string ToString(string format), string ToString(System.IFormatProvider provider)...
ToType      Method       System.Object IConvertible.ToType(type conversionType, System.IFormatProvider provider)
ToUInt16    Method       uint16 IConvertible.ToUInt16(System.IFormatProvider provider)
ToUInt32    Method       uint32 IConvertible.ToUInt32(System.IFormatProvider provider)
ToUInt64    Method       uint64 IConvertible.ToUInt64(System.IFormatProvider provider)
Name        NoteProperty string Name=CustomObject
```

This example demonstrates the intricacies of the `ExpandProperty` parameter.

Note that the output generated was an array of `[System.Int32]` instances.  The instances conform to standard formatting rules of the **Output View**.
This is true for any *Expanded* properties.  If the outputted objects have a specific standard format, the expanded property might not be visible.

## PARAMETERS

### -ExcludeProperty

Specifies the properties that this cmdlet excludes from the operation.
Wildcards are permitted.
This parameter is effective only when the command also includes the **Property** parameter.

```yaml
Type: String[]
Parameter Sets: DefaultParameter, SkipLastParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpandProperty

Specifies a property to select, and indicates that an attempt should be made to expand that property.

- If the specified property is an array, each value of the array is included in the output.
- If the specified property is an object, the objects properties are expanded for every `InputObject`

In either case, the **Type** of objects output will match the **Type** of the expanded property.

If the `Property` parameter is specified, `Select-Object` will attempt to add each selected property as a `NoteProperty` to every outputted object.

> [!WARNING]
> If you receive the error: Select : Property cannot be processed because property `<PropertyName>` already exists, consider the following.
> Note that when using `-ExpandProperty`, `Select-Object` can not replace an existing property.
> This means:
> - If the expanded object has a property of the same name, an error will occur.
> - If the *Selected* object has a property of the same name as an *Expanded* objects property, an error will occur.

```yaml
Type: String
Parameter Sets: DefaultParameter, SkipLastParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -First

Gets only the specified number of objects.
Enter the number of objects to get.

```yaml
Type: Int32
Parameter Sets: DefaultParameter
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Index

Selects objects from an array based on their index values.
Enter the indexes in a comma-separated list.

Indexes in an array begin with 0, where 0 represents the first value and (n-1) represents the last value.

```yaml
Type: Int32[]
Parameter Sets: IndexParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies objects to send to the cmdlet through the pipeline.
This parameter enables you to pipe objects to `Select-Object`.

When you use the InputObject parameter with `Select-Object`, instead of piping command results to `Select-Object`, the InputObject value-even if the value is a collection that is the result of a command, such as -InputObject (Get-Process)-is treated as a single object.
Because InputObject cannot return individual properties from an array or collection of objects, it is recommended that if you use `Select-Object` to filter a collection of objects for those objects that have specific values in defined properties, you use `Select-Object` in the pipeline, as shown in the examples in this topic.

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

### -Last

Specifies the number of objects to select from the end of an array of input objects.

```yaml
Type: Int32
Parameter Sets: DefaultParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies the properties to select.  These properties are added as `NoteProperty` members to the output objects.
Wildcards are permitted.

The value of the Property parameter can be a new calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

- Name (or Label) \<string\>
- Expression \<string\> or \<script block\>

```yaml
Type: Object[]
Parameter Sets: DefaultParameter, SkipLastParameter
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Skip

Skips (does not select) the specified number of items.
By default, the Skip parameter counts from the beginning of the array or list of objects, but if the command uses the Last parameter, it counts from the end of the list or array.

Unlike the **Index** parameter, which starts counting at 0, the **Skip** parameter begins at 1.

```yaml
Type: Int32
Parameter Sets: DefaultParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipLast

Skips (does not select) the specified number of items from the end of the list or array. Works in the same way as using **Skip** together with **Last** parameter.

Unlike the **Index** parameter, which starts counting at 0, the **SkipLast** parameter begins at 1.

```yaml
Type: Int32
Parameter Sets: SkipLastParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unique

Specifies that if a subset of the input objects has identical properties and values, only a single member of the subset will be selected.

This parameter is case-sensitive.
As a result, strings that differ only in character casing are considered to be unique.

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

### -Wait

Indicates that the cmdlet turns off optimization.
PowerShell runs commands in the order that they appear in the command pipeline and lets them generate all objects.
By default, if you include a `Select-Object` command with the **First** or **Index** parameters in a command pipeline, PowerShell stops the command that generates the objects as soon as the selected number of objects is generated.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: DefaultParameter, IndexParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Select-Object`.

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES

- You can also refer to the `Select-Object` cmdlet by its built-in alias, `select`. For more information, see about_Aliases.
- The optimization feature of `Select-Object` is available only for commands that write objects to the pipeline as they are processed. It has no effect on commands that buffer processed objects and write them as a collection. Writing objects immediately is a cmdlet design best practice. For more information, see Write Single Records to the Pipeline in [Strongly Encouraged Development Guidelines](https://msdn.microsoft.com/library/dd878270) in the MSDN library.

## RELATED LINKS

[Group-Object](Group-Object.md)

[Sort-Object](Sort-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)
