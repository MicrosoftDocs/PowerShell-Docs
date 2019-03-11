---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821751
schema: 2.0.0
title: Compare-Object
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

The `Compare-Object` cmdlet compares two sets of objects.
One set of objects is the "reference set," and the other set is the "difference set."

The result of the comparison indicates whether a property value appeared only in the object from the reference set (indicated by the \<= symbol), only in the object from the difference set (indicated by the `=>` symbol) or, if the `IncludeEqual` parameter is specified, in both objects (indicated by the `==` symbol).

If the reference set or the difference set is null ($null), this cmdlet generates a terminating error.

## EXAMPLES

### Example 1: Compare the content of two text files

```powershell
Compare-Object -ReferenceObject $(Get-Content C:\test\testfile1.txt) -DifferenceObject $(Get-Content C:\test\testfile2.txt)
```

This command compares the contents of two text files.
It displays only the lines that appear in one file or in the other file, not lines that appear in both files.

### Example 2: Compare each line of content in two text files

```powershell
Compare-Object -ReferenceObject $(Get-Content C:\Test\testfile1.txt) -DifferenceObject $(Get-Content C:\Test\testfile2.txt) -IncludeEqual
```

This command compares each line of content in two text files.
It displays all lines of content from both files, indicating whether each line appears in only Textfile1.txt or Textfile2.txt or whether each line appears in both files.

### Example 3: Compare two sets of process objects

```powershell
$Processes_Before = Get-Process
notepad
$Processes_After = Get-Process
Compare-Object -ReferenceObject $Processes_Before -DifferenceObject $Processes_After
```

```output
InputObject                          SideIndicator
-----------                          -------------
System.Diagnostics.Process (notepad) =>
```

These commands compare two sets of process objects.

The first command uses the `Get-Process` cmdlet to get the processes on the computer.
It stores them in the `$processes_before` variable.

The second command starts Notepad.

The third command uses the `Get-Process` cmdlet again and stores the resulting processes in the `$processes_after` variable.

The fourth command uses the `Compare-Object` cmdlet to compare the two sets of process objects.
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

When you use the **PassThru** parameter, `Compare-Object` omits the `PSCustomObject` wrapper around the compared objects and returns the differing objects, unchanged.

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
The default value is `[Int32]::MaxValue`, which means that this cmdlet examines the entire object collection.

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

### None

If the objects are the same, nothing is returned.

### System.Management.Automation.PSCustomObject

If the objects are different, `Compare-Object` wraps the differing objects in a `PSCustomObject` wrapper with a **SideIndicator** property to reference the differences. When you use the **PassThru** parameter, `Compare-Object` omits the `PSCustomObject` wrapper around the compared objects and returns the differing objects, unchanged.

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