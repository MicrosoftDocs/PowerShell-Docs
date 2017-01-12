---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Compare Object
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821751
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Compare-Object

## SYNOPSIS
Compares two sets of objects.

## SYNTAX

```
Compare-Object [-ReferenceObject] <PSObject[]> [-DifferenceObject] <PSObject[]> [-SyncWindow <Int32>]
 [-Property <Object[]>] [-ExcludeDifferent] [-IncludeEqual] [-PassThru] [-Culture <String>] [-CaseSensitive]
 [<CommonParameters>]
```

## DESCRIPTION
The **Compare-Object** cmdlet compares two sets of objects.
One set of objects is the reference set, and the other set is the difference set.

The result of the comparison indicates whether a property value appeared only in the object from the reference set (indicated by the \<= symbol), only in the object from the difference set (indicated by the =\> symbol) or, if the *IncludeEqual* parameter is specified, in both objects (indicated by the == symbol).

If the reference set or the difference set is null, this cmdlet generates a terminating error.

## EXAMPLES

### Example 1: Compare the content of two text files
```
PS C:\> Compare-Object -ReferenceObject $(Get-Content C:\test\testfile1.txt) -DifferenceObject $(Get-Content C:\test\testfile2.txt)
```

This command compares the contents of two text files.
It displays only the lines that appear in one file or in the other file, not lines that appear in both files.

### Example 2: Compare each line of content in two text files
```
PS C:\> Compare-Object -ReferenceObject $(Get-Content C:\Test\testfile1.txt) -DifferenceObject $(Get-Content C:\Test\testfile2.txt) -IncludeEqual
```

This command compares each line of content in two text files.
It displays all lines of content from both files, indicating whether each line appears in only Textfile1.txt or Textfile2.txt or whether each line appears in both files.

### Example 3: Compare two sets of process objects
```
PS C:\> $Processes_Before = Get-Process
PS C:\> notepad
PS C:\> $Processes_After = Get-Process
PS C:\> Compare-Object -ReferenceObject $Processes_Before -DifferenceObject $Processes_After
```

These commands compare two sets of process objects.

The first command uses the **Get-Process** cmdlet to get the processes on the computer.
The cmdlet stores the processes in the $Processes_Before variable.

The second command launches Notepad.

The third command uses the **Get-Process** cmdlet again and stores the resulting processes in the $Processes_After variable.

The fourth command uses the **Compare-Object** cmdlet to compare the two sets of process objects.
It displays the differences between them, which include the new instance of Notepad.

## PARAMETERS

### -CaseSensitive
Indicates that comparisons should be case-sensitive.

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
Specifies the culture to use for comparisons.

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

### -DifferenceObject
Specifies the objects that are compared to the reference objects.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ExcludeDifferent
Indicates that this cmdlet displays only the characteristics of compared objects that are equal.

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

### -IncludeEqual
Indicates that this cmdlet displays characteristics of compared objects that are equal.
By default, only characteristics that differ between the reference and difference objects are displayed.

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

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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
Specifies an array of properties of the reference and difference objects to compare.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferenceObject
Specifies an array of objects used as a reference for comparison.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncWindow
Specifies the number of adjacent objects that this cmdlet inspects while looking for a match in a collection of objects.
This cmdlet examines adjacent objects when it does not find the object in the same position in a collection.
The default value is \[Int32\]::MaxValue, which means that this cmdlet examines the entire object collection.

```yaml
Type: Int32
Parameter Sets: (All)
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
You can pipe a **DifferenceObject** object to this cmdlet.

## OUTPUTS

### None, or the objects that are different
When you use the *PassThru* parameter, **Compare-Object** returns the objects that differed.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

[Get-Process](../Microsoft.PowerShell.Management/Get-Process.md)

