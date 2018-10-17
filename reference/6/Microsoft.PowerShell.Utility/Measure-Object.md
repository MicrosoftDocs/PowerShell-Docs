---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821829
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Measure-Object
---

# Measure-Object

## SYNOPSIS
Calculates the numeric properties of objects, and the characters, words, and lines in string objects, such as files of text.

## SYNTAX

### GenericMeasure (Default)
```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Sum] [-Average]
 [-Maximum] [-Minimum] [-StandardDeviation] [<CommonParameters>]
```

### TextMeasure
```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Line] [-Word] [-Character]
 [-IgnoreWhiteSpace] [<CommonParameters>]
```

## DESCRIPTION
The **Measure-Object** cmdlet calculates the property values of certain types of object.
**Measure-Object** performs three types of measurements, depending on the parameters in the command.

The **Measure-Object** cmdlet performs calculations on the property values of objects.
It can count objects and calculate the minimum, maximum, sum, standard deviation and average of the numeric values.
For text objects, it can count and calculate the number of lines, words, and characters.

## EXAMPLES

### Example 1: Count the files and folders in a directory
```
PS C:\> Get-ChildItem | Measure-Object
```

This command counts the files and folders in the current directory.

### Example 2: Measure the files in a directory
```
PS C:\> Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Average
```

This command displays the minimum, maximum, and sum of the sizes of all files in the current directory, and the average size of a file in the directory.

### Example 3: Measure text in a text file
```
PS C:\> Get-Content C:\test.txt | Measure-Object -Character -Line -Word
```

This command displays the number of characters, words, and lines in the Text.txt file.

### Example 4: Measure computer processes
```
PS C:\> Get-Process | Measure-Object -Property workingset -Minimum -Maximum -Average
```

This command displays the minimum, maximum, and average sizes of the working sets of the processes on the computer.

### Example 5: Measure the contents of a CSV file
```
PS C:\> Import-Csv d:\test\serviceyrs.csv | Measure-Object -Property years -Minimum -Maximum -Average
```

This command calculates the average years of service of the employees of a company.

The ServiceYrs.csv file is a CSV file that contains the employee number and years of service of each employee.
The first row in the table is a header row of EmpNo, Years.

When you use **Import-Csv** to import the file, the result is a **PSCustomObject** with note properties of EmpNo and Years.
You can use **Measure-Object** to calculate the values of these properties, just like any other property of an object.

### Example 6: Measure Boolean values
```
PS C:\> Get-ChildItem | Measure-Object -Property psiscontainer -Max -Sum -Min -Average
Count             : 126
Average           : 0.0634920634920635
Sum               : 8
Maximum           : 1
Minimum           : 0
StandardDeviation : 
Property          : PSIsContainer
```

This example demonstrates how the **Measure-Object** can measure Boolean values.
In this case, it uses the PSIsContainer Boolean property to measure the incidence of folders (vs.
files) in the current directory.

### Example 7: Measure all the values
```
PS C:\> 1..5 | Measure-Object -AllStats
Count             : 5
Average           : 3
Sum               : 15
Maximum           : 5
Minimum           : 1
StandardDeviation : 1.58113883008419
Property          :
```

This example demonstrates how the **Measure-Object** can measure all the statistics together.

## PARAMETERS

### -Average
Indicates that the cmdlet displays the average value of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Character
Indicates that the cmdlet counts the number of characters in the input object.

```yaml
Type: SwitchParameter
Parameter Sets: TextMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreWhiteSpace
Indicates that the cmdlet ignores white space in word counts and character counts.
By default, white space is not ignored.

```yaml
Type: SwitchParameter
Parameter Sets: TextMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be measured.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

When you use the *InputObject* parameter with **Measure-Object**, instead of piping command results to **Measure-Object**, the *InputObject* value-even if the value is a collection that is the result of a command, such as `-InputObject (Get-Process)`-is treated as a single object.
Because *InputObject* cannot return individual properties from an array or collection of objects, it is recommended that if you use **Measure-Object** to measure a collection of objects for those objects that have specific values in defined properties, you use **Measure-Object** in the pipeline, as shown in the examples in this topic.

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

### -Line
Indicates that the cmdlet counts the number of lines in the input object.

```yaml
Type: SwitchParameter
Parameter Sets: TextMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Maximum
Indicates that the cmdlet displays the maximum value of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minimum
Indicates that the cmdlet displays the minimum value of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
Specifies one or more numeric properties to measure.
The default is the **Count** property of the object.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StandardDeviation
Indicates that the cmdlet displays the standard deviation of the values of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sum
Indicates that the cmdlet displays the sum of the values of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllStats
Indicates that the cmdlet displays all the statitics of the specified properties.

```yaml
Type: SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Word
Indicates that the cmdlet counts the number of words in the input object.

```yaml
Type: SwitchParameter
Parameter Sets: TextMeasure
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
You can pipe objects to **Measure-Object**.

## OUTPUTS

### Microsoft.PowerShell.Commands.GenericMeasureInfo, Microsoft.PowerShell.Commands.TextMeasureInfo, Microsoft.PowerShell.Commands.GenericObjectMeasureInfo
If you use the *Word* parameter, **Measure-Object** returns a **TextMeasureInfo** object.
Otherwise, it returns a **GenericMeasureInfo** object.

## NOTES

## RELATED LINKS

[Compare-Object](Compare-Object.md)

[Group-Object](Group-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)
