---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821852
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Select-Object
---

# Select-Object

## SYNOPSIS
Selects objects or object properties.

## SYNTAX

### DefaultParameter (Default)
```powershell
Select-Object [[-Property] <Object[]>] [-InputObject <PSObject>]
 [-ExcludeProperty <String[]>] [-ExpandProperty <String>] [-Unique]
 [-Last <Int32>] [-First <Int32>] [-Skip <Int32>] [-Wait] [<CommonParameters>]
```

### SkipLastParameter
```powershell
Select-Object [[-Property] <Object[]>] [-InputObject <PSObject>]
 [-ExcludeProperty <String[]>] [-ExpandProperty <String>] [-Unique]
 [-SkipLast <Int32>] [<CommonParameters>]
```

### IndexParameter
```powershell
Select-Object [-InputObject <PSObject>] [-Unique] [-Wait] [-Index <Int32[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Select-Object** cmdlet selects specified properties of an object or set of objects.
It can also select unique objects, a specified number of objects, or objects in a specified position in an array.

To select objects from a collection, use the *First*, *Last*, *Unique*, *Skip*, and *Index* parameters.
To select object properties, use the *Property* parameter.
When you select properties, this cmdlet returns new objects that have only the specified properties.

Beginning in Windows PowerShell 3.0, **Select-Object** includes an optimization feature that prevents commands from creating and processing objects that are not used.
When you include a **Select-Object** command with the *First* or *Index* parameter in a command pipeline, Windows PowerShell stops the command that generates the objects as soon as the selected number of objects is generated, even when the command that generates the objects appears before the **Select-Object** command in the pipeline.
To turn off this optimizing behavior, use the *Wait* parameter.

## EXAMPLES

### Example 1: Select objects by property
```
PS C:\> Get-Process | Select-Object -Property ProcessName, Id, WS
```

This command creates objects that have the Name, ID, and working set (WS) properties of process objects.

### Example 2: Select objects by property and format the results
```
PS C:\> Get-Process Explorer | Select-Object -Property ProcessName -ExpandProperty Modules | Format-List

ProcessName       : 00THotkey
Size              : 256
Company           : TOSHIBA Corporation
FileVersion       : 1, 0, 0, 27
ProductVersion    : 6, 2, 0, 0
Description       : THotkey
Product           : TOSHIBA THotkey
ModuleName        : 00THotkey.exe
FileName          : C:\WINDOWS\system32\00THotkey.exe
BaseAddress       : 4194304
```

This command gets information about the modules used by the processes on the computer.
It uses Get-Process cmdlet to get the process on the computer.
It uses the **Select-Object** cmdlet to create new objects with only the selected properties.
The command uses the *Property* parameter of the **Select-Object** cmdlet to select the process names.
Because the **Modules** property contains a **ModuleProcess** object that has many properties, the command uses the *ExpandProperty* parameter to get the properties of the objects in the **Modules** property of each process.
The command uses the Format-List cmdlet to display the name and modules of each process in a list.

### Example 3: Select processes using the most memory
```
PS C:\> Get-Process | Sort-Object -Property WS | Select-Object -Last 5

Handles  NPM(K)    PM(K)      WS(K) VS(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
2866     320       33432      45764   203   222.41   1292 svchost
577      17        23676      50516   265    50.58   4388 WINWORD
826      11        75448      76712   188    19.77   3780 Ps
1367     14        73152      88736   216    61.69    676 Ps
1612     44        66080      92780   380   900.59   6132 INFOPATH
```

This command gets the five processes that are using the most memory.
The Get-Process cmdlet gets the processes on the computer.
The Sort-Object cmdlet sorts the processes according to memory (working set) usage, and the Select-Object cmdlet selects only the last five members of the resulting array of objects.

The *Wait* parameter is not required in commands that include the **Sort-Object** cmdlet because **Sort-Object** processes all objects and then returns a collection.
The **Select-Object** optimization is available only for commands that return objects individually as they are processed.

### Example 4: Select the name and start day of processes
```
PS C:\> Get-Process | Select-Object -Property ProcessName,@{Name="Start Day"; Expression = {$_.StartTime.DayOfWeek}}

ProcessName  StartDay
----         --------
alg          Wednesday
ati2evxx     Wednesday
ati2evxx     Thursday
...
```

This command gets the name and start day of the processes running on a computer.

The command uses the Get-Process cmdlet to get the processes on the computer.
It passes the processes to the **Select-Object** cmdlet, which creates objects that have only the *ProcessName* parameter and a calculated property named Start Day.
The Start Day property is added by using a hash table with Name and Expression keys.
The value of the Expression key is a script blocks that gets the **StartTime** property of each process and the **DayofWeek** property of the StartTime.

### Example 5: Select unique characters from an array
```
PS C:\> "a","b","c","a","a","a" | Select-Object -Unique

a
b
c
```

This command uses the *Unique* parameter of **Select-Object** to get unique characters from an array of characters.

### Example 6: Select newest and oldest events in the event log
```
PS C:\> $A = Get-Eventlog -Log "Windows PowerShell"
PS C:\> $A | Select-Object -Index 0, ($A.count - 1)
```

These commands gets the first (newest) and last (oldest) events in the Windows PowerShell event log.

The command uses the Get-EventLog cmdlet to get all events in the Windows PowerShell log.
It saves them in the $A variable.

The second command uses a pipeline operator (|) to send the events in $A to the **Select-Object** cmdlet.
The **Select-Object** command uses the *Index* parameter to select events from the array of events in the $A variable.
The index of the first event is 0.
The index of the last event is the number of items in $A minus 1.

### Example 7: Select all but the first object
```
PS C:\> New-PSSession -ComputerName (Get-Content Servers.txt | Select-Object -Skip 1)
```

This command creates a new PSSession on each of the computers listed in the Servers.txt files, except for the first one.

This command uses the **Select-Object** cmdlet to select all but the first computer in a list of computer names.
The resulting list of computers is set as the value of the *ComputerName* parameter of the New-PSSession cmdlet.

### Example 8: Rename files and select several to review
```
PS C:\> Get-ChildItem *.txt -ReadOnly | Rename-Item -NewName {$_.BaseName + "-ro.txt"} -PassThru | Select-Object -First 5 -Wait
```

This command adds a -ro suffix to the base names of text files that have the read-only attribute and then displays the first five files so the user can see a sample of the effect.

The command uses the *ReadOnly* dynamic parameter of the Get-ChildItem for FileSystem cmdlet to get read-only files.
It uses a pipeline operator (|) to send the files to the Rename-Item cmdlet, which renames the file.
It uses the *Passthru* parameter of **Rename-Item** to send the renamed files to the **Select-Object** cmdlet, which selects the first five for display.

The *Wait* parameter of **Select-Object** prevents Windows PowerShell from stopping the **Get-ChildItem** cmdlet after it gets the first five read-only text files.
Without this parameter, only the first five read-only files would be renamed.

## PARAMETERS

### -ExcludeProperty
Specifies the properties that this cmdlet excludes from the operation.
Wildcards are permitted.
This parameter is effective only when the command also includes the *Property* parameter.

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
Wildcards are permitted in the property name.

For example, if the specified property is an array, each value of the array is included in the output.
If the property contains an object, the properties of that object are displayed in the output.

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
Specifies an array of objects based on their index values.
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
This parameter enables you to pipe objects to **Select-Object**.

When you use the *InputObject* parameter with **Select-Object**, instead of piping command results to **Select-Object**, the *InputObject* value-even if the value is a collection that is the result of a command, such as `-InputObject (Get-Process)`-is treated as a single object.
Because *InputObject* cannot return individual properties from an array or collection of objects, it is recommended that if you use **Select-Object** to filter a collection of objects for those objects that have specific values in defined properties, you use **Select-Object** in the pipeline, as shown in the examples in this topic.

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
Specifies the properties to select.
Wildcards are permitted.

The value of the *Property* parameter can be a new calculated property.
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
Ignores the specified number of objects and then gets the remaining objects.
Enter the number of objects to skip.

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

### -SkipLast


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
Windows PowerShell runs commands in the order that they appear in the command pipeline and lets them generate all objects.
By default, if you include a **Select-Object** command with the *First* or *Index* parameters in a command pipeline, Windows PowerShell stops the command that generates the objects as soon as the selected number of objects is generated.

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
You can pipe any object to **Select-Object**.

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES
* You can also refer to the `Select-Object` cmdlet by its built-in alias, `select`. For more information, see about_Aliases.
* The optimization feature of `Select-Object` is available only for commands that write objects to the pipeline as they are processed. It has no effect on commands that buffer processed objects and write them as a collection. Writing objects immediately is a cmdlet design best practice. For more information, see Write Single Records to the Pipeline in [Strongly Encouraged Development Guidelines](https://msdn.microsoft.com/library/dd878270) in the MSDN library.

## RELATED LINKS

[Group-Object](Group-Object.md)

[Sort-Object](Sort-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)