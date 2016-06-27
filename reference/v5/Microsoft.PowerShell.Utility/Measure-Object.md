---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293990
schema: 2.0.0
---

# Measure-Object
## SYNOPSIS
Calculates the numeric properties of objects, and the characters, words, and lines in string objects, such as files of text.

## SYNTAX

### GenericMeasure (Default)
```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Sum] [-Average] [-Maximum] [-Minimum]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### TextMeasure
```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Line] [-Word] [-Character]
 [-IgnoreWhiteSpace] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Measure-Object cmdlet calculates the property values of certain types of object.
Measure-Object performs three types of measurements, depending on the parameters in the command.

The Measure-Object cmdlet performs calculations on the property values of objects.
It can count objects and calculate the minimum, maximum, sum, and average of the numeric values.
For text objects, it can count and calculate the number of lines, words, and characters.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-childitem | measure-object
```

This command counts the files and folders in the current directory.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-childitem | measure-object -property length -minimum -maximum -average
```

This command displays the minimum, maximum, and sum of the sizes of all files in the current directory, and the average size of a file in the directory.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-content C:\test.txt | measure-object -character -line -word
```

This command displays the number of characters, words, and lines in the Text.txt file.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-process | measure-object -property workingset -minimum -maximum -average
```

This command displays the minimum, maximum, and average sizes of the working sets of the processes on the computer.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>import-csv d:\test\serviceyrs.csv | measure-object -property years -minimum -maximum -average
```

This command calculates the average years of service of the employees of a company.

The ServiceYrs.csv file is a CSV file that contains the employee number and years of service of each employee.
The first row in the table is a header row of "EmpNo, Years".

When you use Import-Csv to import the file, the result is a PSCustomObject with note properties of EmpNo and Years.
You can use Measure-Object to calculate the values of these properties, just like any other property of an object.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-childitem | measure-object -property psiscontainer -max -sum -min -average

Count    : 126
Average  : 0.0634920634920635
Sum      : 8
Maximum  : 1
Minimum  : 0
Property : PSIsContainer
```

This example demonstrates the Measure-Object can measure Boolean values.
In this case, it uses the PSIsContainer Boolean property to measure the incidence of folders (vs.
files) in the current directory.

## PARAMETERS

### -Average
Displays the average value of the specified properties.

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
Counts the number of characters in the input object.

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
Ignores white space in word counts and character counts.
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

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be measured.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

When you use the InputObject parameter with Measure-Object, instead of piping command results to Measure-Object, the InputObject value-even if the value is a collection that is the result of a command, such as -InputObject (Get-Process)-is treated as a single object.
Because InputObject cannot return individual properties from an array or collection of objects, it is recommended that if you use Measure-Object to measure a collection of objects for those objects that have specific values in defined properties, you use Measure-Object in the pipeline, as shown in the examples in this topic.

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
Counts the number of lines in the input object.

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
Displays the maximum value of the specified properties.

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
Displays the minimum value of the specified properties.

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
The default is the Count (Length) property of the object.

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

### -Sum
Displays the sum of the values of the specified properties.

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
Counts the number of words in the input object.

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects to Measure-Object.

## OUTPUTS

### Microsoft.PowerShell.Commands.GenericMeasureInfo, Microsoft.PowerShell.Commands.TextMeasureInfo, Microsoft.PowerShell.Commands.GenericObjectMeasureInfo
If you use the Word parameter, Measure-Object returns a TextMeasureInfo object.
Otherwise, it returns a GenericMeasureInfo object.

## NOTES

## RELATED LINKS

[Compare-Object]()

[ForEach-Object]()

[Group-Object]()

[New-Object]()

[Select-Object]()

[Sort-Object]()

[Tee-Object]()

[Where-Object]()

