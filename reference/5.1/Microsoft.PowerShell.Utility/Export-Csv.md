---
ms.date:  12/04/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821769
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Export-Csv
---

# Export-Csv

## SYNOPSIS
Converts objects into a series of comma-separated (CSV) strings and saves the strings in a CSV file.

## SYNTAX

### Delimiter (Default)
```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <String>] [-Append] [[-Delimiter] <Char>] [-NoTypeInformation] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### UseCulture
```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <String>] [-Append] [-UseCulture] [-NoTypeInformation] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The `Export-CSV` cmdlet creates a CSV file of the objects that you submit.
Each object is represented as a line or row of the CSV.
The row consists of a comma-separated list of the values of object properties.
You can use this cmdlet to create spreadsheets and share data with programs that take CSV files as input.

Do not format objects before sending them to the `Export-CSV` cmdlet.
If you do, the format properties are represented in the CSV file, instead of the properties of the original objects.
To export only selected properties of an object, use the `Select-Object` cmdlet.

## EXAMPLES

### Example 1: Export process properties
```powershell
Get-Process wmiprvse | Select-Object basePriority,ID,SessionID,WorkingSet | Export-Csv -Path "data.csv"
```

This command selects a few properties of the WmiPrvse process and exports them to a CSV file named `data.csv`.

### Example 2: Export processes to a comma-delimited file
```powershell
Get-Process | Export-Csv -Path "processes.csv"
Get-Content -Path "processes.csv"
```

```Output
#TYPE System.Diagnostics.Process
__NounName,Name,Handles,VM,WS,PM,NPM,Path,Company,CPU,FileVersion,...
Process,powershell,626,201666560,76058624,61943808,11960,C:\WINDOWS...
Process,powershell,257,151920640,38322176,37052416,7836,C:\WINDOWS\...
```

This command exports objects representing the processes on the computer to the `processes.csv` file in the current directory.
Because it does not specify a delimiter, a comma (`,`) is used to separate the fields in the file.

### Example 3: Export processes to a semicolon-delimited file
```powershell
Get-Process | Export-Csv -Path "processes.csv" -Delimiter ";"
Get-Content -Path "processes.csv"
```

```Output
#TYPE System.Diagnostics.Process
__NounName;Name;Handles;VM;WS;PM;NPM;Path;Company;CPU;FileVersion;...
Process;powershell;626;201666560;76058624;61943808;11960;C:\WINDOWS...
Process;powershell;257;151920640;38322176;37052416;7836;C:\WINDOWS\...

```

This command exports objects representing the processes on the computer to the `processes.csv` file in the current directory.
It uses the **-Delimiter** parameter to specify the semicolon (`;`).
As a result, the fields in the file are separated by semicolons.

### Example 4: Export using the list separator of the current culture
```powershell
Get-Process | Export-Csv -Path "processes.csv" -UseCulture
```

This command exports objects representing the processes on the computer to the `processes.csv` file in the current directory.
It uses the `-UseCulture` parameter to direct `Export-CSV` to use the delimiter specified by the **ListSeparator** property of the current culture.

### Example 5: Export processes without type information
```powershell
Get-Process | Export-Csv -Path "processes.csv" -NoTypeInformation
Get-Content -Path "processes.csv"
```

```Output
__NounName,Name,Handles,VM,WS,PM,NPM,Path,Company,CPU,FileVersion,...
Process,powershell,626,201666560,76058624,61943808,11960,C:\WINDOWS...
Process,powershell,257,151920640,38322176,37052416,7836,C:\WINDOWS\...
```

This command exports objects representing the processes on the computer to the `processes.csv` file in the current directory.
It uses the **-NoTypeInformation** parameter to suppress the type information in the file.

### Example 6: Export and append script properties
```powershell
$ScriptFiles = Get-ChildItem D:\* -Include *.ps1 -Recurse | Where-Object {$_.creationtime -gt "01/01/2011"}
$ScriptFiles = $ScriptFiles | Select-Object -Property Name, CreationTime, LastWriteTime, IsReadOnly
$ScriptFiles | Export-Csv -Append -Path "\\Archive01\Scripts\Scripts.csv"
```

The second command uses the `Select-Object` cmdlet to select the relevant properties of the script files. It saves the revised results in the `$ScriptFiles` variable.

The third command uses a pipeline operator (`|`) to send the script file information in the `$ScriptFiles` variable to the `Export-CSV` cmdlet. The command uses the `-Path` parameter to specify the output file and the `-Append` parameter to add the new script data to the end of the output file, instead of replacing the existing file contents.

These commands add information about new PowerShell scripts to a script inventory file.

The first command uses the `Get-ChildItem` cmdlet to do a recursive search in the `D:` drive for files with the `.ps1` file name extension.
It uses a pipeline operator to sends the results to the `Where-Object` cmdlet, which gets only files that were created after January 1, 2011, and then saves them in the `$ScriptFiles` variable.

### Example 7: Select properties to export
```powershell
Get-Date | Select-Object -Property DateTime, Day, DayOfWeek, DayOfYear | Export-Csv -Path Date.csv -NoTypeInformation
Get-Content -Path "Date.csv"
```

```Output
"DateTime","Day","DayOfWeek","DayOfYear"
"Tuesday, October 05, 2010 2:45:13 PM","5","Tuesday","278"
```

```powershell
Get-Date | Format-Table -Property DateTime, Day, DayOfWeek, DayOfYear | Export-Csv -Path Date.csv -NoTypeInformation
Get-Content -Path "Date.csv"
```

```Output
"ClassId2e4f51ef21dd47e99d3c952918aff9cd","pageHeaderEntry","pageFooterEntry","autosizeInfo","shapeInfo","groupingEntry"
"033ecb2bc07a4d43b5ef94ed5a35d280",,,,"Microsoft.PowerShell.Commands.Internal.Format.TableHeaderInfo",
"9e210fe47d09416682b841769c78b8a3",,,,,
"27c87ef9bbda4f709f6b4002fa4af63c",,,,,
"4ec4f0187cb04f4cb6973460dfe252df",,,,,
"cf522b78d86c486691226b40aa69e95c",,,,,
```

The first command shows how to select properties of an object and export them to a CSV file. This command uses the `Get-Date` cmdlet to get the current date and time. It uses the `Select-Object` cmdlet to select the desired properties, and the `Export-CSV` cmdlet to export the object and its properties to the `Date.csv` file. The output shows the expected content in the `Date.csv` file.

The second command shows that when you use the `Format-Table` cmdlet to format your data before exporting it, the output is not useful.

This example demonstrates one of most common problems that users encounter when using the `Export-CSV` cmdlet.
It explains how to recognize and avoid this error.

Because a CSV file has a table format, it might seem natural to use the Format-Table cmdlet to format the data in a table to prepare it for export as a CSV file.
Also, the `Format-Table` cmdlet allows you to select object properties easily.

However, when you format the data in a table and then export it, you are exporting a table object, not your original data object.
The resulting CSV file is not useful.

## PARAMETERS

### -Append
Indicates that this cmdlet adds the CSV output to the end of the specified file.
Without this parameter, `Export-CSV` replaces the file contents without warning.

This parameter was introduced in Windows PowerShell 3.0.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Specifies a delimiter to separate the property values.
The default is a comma (`,`).
Enter a character, such as a colon (`:`).
To specify a semicolon (`;`), enclose it in quotation marks.

```yaml
Type: Char
Parameter Sets: Delimiter
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the encoding for the exported CSV file.
The acceptable values for this parameter are:

- Unicode
- UTF7
- UTF8
- ASCII
- UTF32
- BigEndianUnicode
- Default
- OEM

The default value is ASCII.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Unicode, UTF7, UTF8, ASCII, UTF32, BigEndianUnicode, Default, OEM

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

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

### -InputObject
Specifies the objects to export as CSV strings.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe objects to `Export-CSV`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to the CSV output file.
Unlike `-Path`, the value of the `-LiteralPath` parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber
Indicates that this cmdlet does not overwrite of an existing file.
By default, if a file exists in the specified path, `Export-CSV` overwrites the file without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoTypeInformation
Indicates that this cmdlet omits the type information from the CSV file.
This is the default behavior beginning with PowerShell 6.0.
This parameter is included for backwards compatibility.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NTI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to the CSV output file.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCulture
Indicates that this cmdlet uses the list separator for the current culture as the item delimiter.
The default is a comma (`,`).

This parameter is very useful in scripts that are being distributed to users worldwide.
To find the list separator for a culture, use the following command: `(Get-Culture).TextInfo.ListSeparator`.

```yaml
Type: SwitchParameter
Parameter Sets: UseCulture
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object with an Extended Type System (ETS) adapter to `Export-CSV`.

## OUTPUTS

### System.String
The CSV list is sent to the file designated in the Path parameter.

## NOTES
* The `Export-CSV` cmdlet converts the objects that you submit into a series of CSV variable-length strings and saves them in the specified text file.
  You can use `Export-CSV` to save objects in a CSV file and then use the Import-Csv cmdlet to create objects from the text in the CSV file.

  In the CSV file, each object is represented by a comma-separated list of the property values of the object.
The property values are converted to strings (by using the `ToString()` method of the object), so they are generally represented by the name of the property value.
`Export-CSV` does not export the methods of the object.

  The format of an exported file is as follows:

  - The first line of the CSV file contains the string #TYPE followed by the fully qualified name of the object, such as `#TYPE System.Diagnostics.Process`.
This line will not be included by default. You must specify `-IncludeTypeInformation` to include type information.

  - The next line of the CSV file represents the column headers.
It contains a comma-separated list of the names of all the properties of the first object.

  - Additional lines of the file consist of comma-separated lists of the property values of each object.

* When you submit multiple objects to `Export-CSV`, `Export-CSV` organizes the file based on the properties of the first object that you submit. If the remaining objects do not have one of the specified properties, the property value of that object is null, as represented by two consecutive commas. If the remaining objects have additional properties, those property values are not included in the file.
* You can use the `Import-Csv` cmdlet to re-create objects from the CSV strings in the files. The resulting objects are CSV versions of the original objects that consist of string representations of the property values and no methods.
* The `ConvertTo-Csv` and `ConvertFrom-Csv` cmdlets to convert objects to CSV strings (and back). `Export-CSV` is the same as `ConvertTo-CSV`, except that it saves the CSV strings in a file.

## RELATED LINKS

[ConvertFrom-Csv](ConvertFrom-Csv.md)

[ConvertTo-Csv](ConvertTo-Csv.md)

[Format-Table](Format-Table.md)

[Import-Csv](Import-Csv.md)

[Select-Object](Select-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)