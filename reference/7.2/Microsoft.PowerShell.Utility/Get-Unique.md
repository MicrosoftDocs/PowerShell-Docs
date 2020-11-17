---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 03/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-unique?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Unique
---
# Get-Unique

## SYNOPSIS
Returns unique items from a sorted list.

## SYNTAX

### AsString (Default)

```
Get-Unique [-InputObject <PSObject>] [-AsString] [<CommonParameters>]
```

### UniqueByType

```
Get-Unique [-InputObject <PSObject>] [-OnType] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Unique` cmdlet compares each item in a sorted list to the next item, eliminates duplicates,
and returns only one instance of each item. The list must be sorted for the cmdlet to work properly.

`Get-Unique` is case-sensitive. As a result, strings that differ only in character casing are
considered to be unique.

## EXAMPLES

### Example 1: Get unique words in a text file

These commands find the number of unique words in a text file.

```powershell
$A = $( foreach ($line in Get-Content C:\Test1\File1.txt) {
    $line.tolower().split(" ")
  }) | Sort-Object | Get-Unique
$A.count
```

The first command gets the content of the File.txt file. It converts each line of text to lowercase
letters and then splits each word onto a separate line at the space (" "). Then, it sorts the
resulting list alphabetically (the default) and uses the `Get-Unique` cmdlet to eliminate any
duplicate words. The results are stored in the `$A` variable.

The second command uses the **Count** property of the collection of strings in `$A` to determine how
many items are in `$A`.

### Example 2: Get unique integers in an array

This command finds the unique members of the set of integers.

```powershell
1,1,1,1,12,23,4,5,4643,5,3,3,3,3,3,3,3 | Sort-Object | Get-Unique
```

```Output
1
3
4
5
12
23
4643
```

The first command takes an array of integers typed at the command line, pipes them to the
`Sort-Object` cmdlet to be sorted, and then pipes them to `Get-Unique`, which eliminates duplicate
entries.

### Example 3: Get unique object types in a directory

This command uses the `Get-ChildItem` cmdlet to retrieve the contents of the local directory, which
includes files and directories.

```powershell
Get-ChildItem | Sort-Object {$_.GetType()} | Get-Unique -OnType
```

The pipeline operator (|) sends the results to the `Sort-Object` cmdlet. The `$_.GetType()`
statement applies the **GetType** method to each file or directory. Then, `Sort-Object` sorts the
items by type. Another pipeline operator sends the results to `Get-Unique`. The **OnType** parameter
directs `Get-Unique` to return only one object of each type.

### Example 4: Get unique processes

This command gets the names of processes running on the computer with duplicates eliminated.

```powershell
Get-Process | Sort-Object | Select-Object processname | Get-Unique -AsString
```

The `Get-Process` command gets all of the processes on the computer. The pipeline operator (|)
passes the result to `Sort-Object`, which, by default, sorts the processes alphabetically by
ProcessName. The results are piped to the `Select-Object` cmdlet, which selects only the values of
the ProcessName property of each object. The results are then piped to `Get-Unique` to eliminate
duplicates.

The **AsString** parameter tells `Get-Unique` to treat the **ProcessName** values as strings.
Without this parameter, `Get-Unique` treats the **ProcessName** values as objects and returns only
one instance of the object, that is, the first process name in the list.

## PARAMETERS

### -AsString

Indicates that this cmdlet uses the data as a string. Without this parameter, data is treated as an
object, so when you submit a collection of objects of the same type to `Get-Unique`, such as a
collection of files, it returns just one (the first). You can use this parameter to find the unique
values of object properties, such as the file names.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AsString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies input for `Get-Unique`. Enter a variable that contains the objects or type a command or
expression that gets the objects.

This cmdlet treats the input submitted by using **InputObject** as a collection. it does not
enumerate individual items in the collection. Because the collection is a single item, input
submitted by using **InputObject** is always returned unchanged.

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

### -OnType

Indicates that this cmdlet returns only one object of each type.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: UniqueByType
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any type of object to `Get-Unique`.

## OUTPUTS

### System.Management.Automation.PSObject

The type of object that `Get-Unique` returns is determined by the input.

## NOTES

You can also refer to `Get-Unique` by its built-in alias, `gu`. For more information, see [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

To sort a list, use Sort-Object. You can also use the **Unique** parameter of `Sort-Object` to find
the unique items in a list.

## RELATED LINKS

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

