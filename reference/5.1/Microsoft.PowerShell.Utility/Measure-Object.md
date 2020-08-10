---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 5/10/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/measure-object?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Measure-Object
---
# Measure-Object

## SYNOPSIS
Calculates the numeric properties of objects, and the characters, words, and lines in string
objects, such as files of text.

## SYNTAX

### GenericMeasure (Default)

```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Sum] [-Average] [-Maximum] [-Minimum]
 [<CommonParameters>]
```

### TextMeasure

```
Measure-Object [-InputObject <PSObject>] [[-Property] <String[]>] [-Line] [-Word] [-Character]
 [-IgnoreWhiteSpace] [<CommonParameters>]
```

## DESCRIPTION

The `Measure-Object` cmdlet calculates the property values of certain types of object.
`Measure-Object` performs three types of measurements, depending on the parameters in the command.

The `Measure-Object` cmdlet performs calculations on the property values of objects. You can use
`Measure-Object` to count objects or count objects with a specified **Property**. You can also use
`Measure-Object` to calculate the **Minimum**, **Maximum**, **Sum**, **StandardDeviation** and
**Average** of numeric values. For **String** objects, you can also use `Measure-Object` to
count the number of lines, words, and characters.

## EXAMPLES

### Example 1: Count the files and folders in a directory

This command counts the files and folders in the current directory.

```powershell
Get-ChildItem | Measure-Object
```

### Example 2: Measure the files in a directory

This command displays the **Minimum**, **Maximum**, and **Sum** of the sizes of all files in the
current directory, and the average size of a file in the directory.

```powershell
Get-ChildItem | Measure-Object -Property length -Minimum -Maximum -Average
```

### Example 3: Measure text in a text file

This command displays the number of characters, words, and lines in the Text.txt file.
Without the **Raw** parameter, `Get-Content` outputs the file as an array of lines.

The first command uses `Set-Content` to add some default text to a file.

```powershell
"One", "Two", "Three", "Four" | Set-Content -Path C:\Temp\tmp.txt
Get-Content C:\Temp\tmp.txt | Measure-Object -Character -Line -Word
```

```Output
Lines Words Characters Property
----- ----- ---------- --------
    4     4         15
```

### Example 4: Measure objects containing a specified Property

This example counts the number of objects that have a **DisplayName** property. The first two
commands retrieve all the services and processes on the local machine. The third command counts the
combined number of services and processes. The last command combines the two collections and pipes
the result to `Measure-Object`.

The **System.Diagnostics.Process** object does not have a **DisplayName** property, and is left out
of the final count.

```powershell
$services = Get-Service
$processes = Get-Process
$services + $processes | Measure-Object
$services + $processes | Measure-Object -Property DisplayName
```

```Output
Count    : 682
Average  :
Sum      :
Maximum  :
Minimum  :
Property :

Count    : 290
Average  :
Sum      :
Maximum  :
Minimum  :
Property : DisplayName
```

### Example 5: Measure the contents of a CSV file

This command calculates the average years of service of the employees of a company.

The `ServiceYrs.csv` file is a CSV file that contains the employee number and years of service of
each employee. The first row in the table is a header row of **EmpNo**, **Years**.

When you use `Import-Csv` to import the file, the result is a **PSCustomObject** with note
properties of **EmpNo** and **Years**.
You can use `Measure-Object` to calculate the values of these properties, just like any other
property of an object.

```powershell
Import-Csv d:\test\serviceyrs.csv | Measure-Object -Property years -Minimum -Maximum -Average
```

### Example 6: Measure Boolean values

This example demonstrates how the `Measure-Object` can measure Boolean values.
In this case, it uses the **PSIsContainer** **Boolean** property to measure the incidence of
folders (vs. files) in the current directory.

```powershell
Get-ChildItem | Measure-Object -Property psiscontainer -Maximum -Sum -Minimum -Average
```

```Output
Count             : 126
Average           : 0.0634920634920635
Sum               : 8
Maximum           : 1
Minimum           : 0
StandardDeviation :
Property          : PSIsContainer
```

### Example 7: Measure strings

The following example measures the number of lines, first a single string, then across several
strings. The newline character <code>`n</code> separates strings into multiple lines.

```powershell
# The newline character `n separates the string into separate lines, as shown in the output.
"One`nTwo`nThree"
"One`nTwo`nThree" | Measure-Object -Line
```

```Output
One
Two
Three


Lines Words Characters Property
----- ----- ---------- --------
    3
```

```powershell
# The first string counts as a single line.
# The second string is separated into two lines by the newline character.
"One", "Two`nThree" | Measure-Object -Line
```

```Output
Lines Words Characters Property
----- ----- ---------- --------
    3
```

```powershell
# The Word switch counts the number of words in each InputObject
# Each InputObject is treated as a single line.
"One, Two", "Three", "Four Five" | Measure-Object -Word -Line
```

```Output
Lines Words Characters Property
----- ----- ---------- --------
    3     5
```

## PARAMETERS

### -Average

Indicates that the cmdlet displays the average value of the specified properties.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Character

Indicates that the cmdlet counts the number of characters in the input objects.

> [!NOTE]
> The **Word**, **Char** and **Line** switches count *inside* each input object, as well as *across*
> input objects. See Example 7.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: TextMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreWhiteSpace

Indicates that the cmdlet ignores white space in character counts.
By default, white space is not ignored.

```yaml
Type: System.Management.Automation.SwitchParameter
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

When you use the **InputObject** parameter with `Measure-Object`, instead of piping command results
to `Measure-Object`, the **InputObject** value is treated as a single object.

It is recommended that you use `Measure-Object` in the pipeline if you want to measure a
collection of objects based on whether the objects have specific values in defined properties.

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

### -Line

Indicates that the cmdlet counts the number of lines in the input objects.

> [!NOTE]
> The **Word**, **Char** and **Line** switches count *inside* each input object, as well as *across*
> input objects. See Example 7.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Specifies one or more properties to measure. If you do not specify any other measures,
`Measure-Object` counts the objects that have the properties you specify.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Sum

Indicates that the cmdlet displays the sum of the values of the specified properties.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: GenericMeasure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Word

Indicates that the cmdlet counts the number of words in the input objects.

> [!NOTE]
> The **Word**, **Char** and **Line** switches count *inside* each input object, as well as *across*
> input objects. See Example 7.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: TextMeasure
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

You can pipe objects to `Measure-Object`.

## OUTPUTS

### Microsoft.PowerShell.Commands.GenericMeasureInfo

### Microsoft.PowerShell.Commands.TextMeasureInfo

If you use the **Word** parameter, `Measure-Object` returns a **TextMeasureInfo** object.
Otherwise, it returns a **GenericMeasureInfo** object.

## NOTES

## RELATED LINKS

[Compare-Object](Compare-Object.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)
