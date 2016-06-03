---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Compare-Object
## SYNOPSIS
Compares two sets of objects.

## SYNTAX

```
Compare-Object [-ReferenceObject] <PSObject[]> [-DifferenceObject] <PSObject[]> [-CaseSensitive]
 [-Culture <String>] [-ExcludeDifferent] [-IncludeEqual] [-PassThru] [-Property <Object[]>]
 [-SyncWindow <Int32>]
```

## DESCRIPTION
The Compare-Object cmdlet compares two sets of objects.
One set of objects is the "reference set," and the other set is the "difference set."

The result of the comparison indicates whether a property value appeared only in the object from the reference set \(indicated by the \<= symbol\), only in the object from the difference set \(indicated by the =\> symbol\) or, if the IncludeEqual parameter is specified, in both objects \(indicated by the == symbol\).

NOTE:  If the reference set or the difference set is null \($null\), Compare-Object generates a terminating error.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>compare-object -referenceobject $(get-content C:\test\testfile1.txt) -differenceobject $(get-content C:\test\testfile2.txt)
```

This command compares the contents of two text files.
It displays only the lines that appear in one file or in the other file, not lines that appear in both files.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>compare-object -referenceobject $(get-content C:\Test\testfile1.txt) -differenceobject $(get-content C:\Test\testfile2.txt) -includeequal
```

This command compares each line of content in two text files.
It displays all lines of content from both files, indicating whether each line appears in only Textfile1.txt or Textfile2.txt or whether each line appears in both files.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$processes_before = get-process
PS C:\>notepad
PS C:\>$processes_after  = get-process
PS C:\>compare-object -referenceobject $processes_before -differenceobject $processes_after
```

These commands compare two sets of process objects.

The first command uses the Get-Process cmdlet to get the processes on the computer.
It stores them in the $processes_before variable.

The second command starts Notepad.

The third command uses the Get-Process cmdlet again and stores the resulting processes in the $processes_after variable.

The fourth command uses the Compare-Object cmdlet to compare the two sets of process objects.
It displaysthe differences between them, which include the new instance of Notepad.

## PARAMETERS

### -CaseSensitive
Indicates that comparisons should be case-sensitive.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
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
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -DifferenceObject
Specifies the objects that are compared to the reference objects.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: true (ByValue)
Accept wildcard characters: False
```

### -ExcludeDifferent
Displays only the characteristics of compared objects that are equal.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -IncludeEqual
Displays characteristics of compared objects that are equal.
By default, only characteristics that differ between the reference and difference objects are displayed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -PassThru
Passes the objects that differed to the pipeline.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -Property
Specifies the properties of the reference and difference objects to compare.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -ReferenceObject
Objects used as a reference for comparison.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -SyncWindow
Specifies the number of adjacent objects that Compare-Object inspects while looking for an match in a collection of objects.
Compare-Object examines adjacent objects when it doesn't find the object in the same position in a collection.
The default value is \[Int32\]::MaxValue, which means that Compare-Object examines the entire object collection.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: [Int32]::MaxValue
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe a DifferenceObject object to Compare-Object.

## OUTPUTS

### None, or the objects that are different
When you use the PassThru parameter, Compare-Object returns the objects that differed.
Otherwise, this cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113286)

[ForEach-Object](00000000-0000-0000-0000-000000000000)

[Group-Object](494af40a-1315-420f-8bd6-932006576dac)

[Measure-Object](f40a7de5-95a8-47a8-bb7c-8b2a4cdd2daf)

[New-Object](1d5cac3b-9cd0-4efe-be3e-1ee8d4675f51)

[Select-Object](2f182056-7955-4b77-9c58-64ab4a680074)

[Sort-Object](52c4a447-238d-43b4-8d3f-6aee5864b905)

[Tee-Object](ae5c403c-6a21-430e-a94a-74a1edee149a)

[Where-Object](00000000-0000-0000-0000-000000000000)


