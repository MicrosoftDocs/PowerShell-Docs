---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293957
schema: 2.0.0
---

# Export-Csv
## SYNOPSIS
Converts objects into a series of comma-separated (CSV) strings and saves the strings in a CSV file.

## SYNTAX

### Delimiter (Default)
```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <String>] [-Append] [[-Delimiter] <Char>] [-NoTypeInformation]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### UseCulture
```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <String>] [-Append] [-UseCulture] [-NoTypeInformation] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Export-CSV cmdlet creates a CSV file of the objects that you submit.
Each object is represented as a line or row of the CSV.
The row consists of a comma-separated list of the values of object properties.
You can use this cmdlet to create spreadsheets and share data with programs that take CSV files as input.

NOTE: Do not format objects before sending them to the Export-CSV cmdlet.
If you do, the format properties are represented in the CSV file, instead of the properties of the original objects.
To export only selected properties of an object, use the Select-Object cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-process wmiprvse | select-object basePriority,ID,SessionID,WorkingSet | export-csv -path data.csv
```

This command selects a few properties of the WmiPrvse process and exports them to a CSV file named Data.csv.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-process | export-csv processes.csv
PS C:\>get-process | export-csv processes.csv

# In processes.csv
#TYPE System.Diagnostics.Process
__NounName,Name,Handles,VM,WS,PM,NPM,Path,Company,CPU,FileVersion,... Process,powershell,626,201666560,76058624,61943808,11960,C:\WINDOWS... Process,powershell,257,151920640,38322176,37052416,7836,C:\WINDOWS\...
```

This command exports objects representing the processes on the computer to the Processes.csv file in the current directory.
Because it does not specify a delimiter, a comma (,) is used to separate the fields in the file.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-process | export-csv processes.csv -Delimiter ";"

# In processes.csv
#TYPE System.Diagnostics.Process
__NounName;Name;Handles;VM;WS;PM;NPM;Path;Company;CPU;FileVersion;... Process;powershell;626;201666560;76058624;61943808;11960;C:\WINDOWS... Process;powershell;257;151920640;38322176;37052416;7836;C:\WINDOWS\...
```

This command exports objects representing the processes on the computer to the Processes.csv file in the current directory.
It uses the Delimiter parameter to specify the semicolon (;).
As a result, the fields in the file are separated by semicolons.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-process | export-csv processes.csv -UseCulture
```

This command exports objects representing the processes on the computer to the Processes.csv file in the current directory.
It uses the UseCulture parameter to direct Export-CSV to use the delimiter specified by the ListSeparator property of the current culture.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-process | export-csv processes.csv -NoTypeInformation
PS C:\>get-process | export-csv processes.csv -NoTypeInformation

# In processes.csv
__NounName,Name,Handles,VM,WS,PM,NPM,Path,Company,CPU,FileVersion,... Process,powershell,626,201666560,76058624,61943808,11960,C:\WINDOWS... Process,powershell,257,151920640,38322176,37052416,7836,C:\WINDOWS\...
```

This command exports objects representing the processes on the computer to the Processes.csv file in the current directory.
It uses the NoTypeInformation parameter to suppress the type information in the file.

### -------------------------- EXAMPLE 6 --------------------------
```
The first command uses the Get-ChildItem cmdlet to do a recursive search in the D: drive for files with the .ps1 file name extension. It uses a pipeline operator to sends the results to the Where-Object cmdlet, which gets only files that were created after January 1, 2011, and then saves them in the ScriptFiles variable. 
PS C:\>$scriptFiles = Get-ChildItem D:\* -include *.ps1 -recurse | where-object {$_.creationtime -gt "01/01/2011"}

The second command uses the Select-Object cmdlet to select  the relevant properties of the script files. It saves the revised results in the ScriptFiles variable.
PS C:\>$scriptFiles = $scriptFiles | select-object -property Name, CreationTime, LastWriteTime, IsReadOnly

The third command uses a pipeline operator (|) to send the script file information in the ScriptFiles variable to the Export-CSV cmdlet. The command uses the Path parameter to specify the output file and the Append parameter to add the new script data to the end of the output file, instead of replacing the existing file contents.
PS C:\>$scriptFiles | export-csv -append -path \\Archive01\Scripts\Scripts.csv
```

These commands add information about new Windows PowerShell scripts to a script inventory file.

### -------------------------- EXAMPLE 7 --------------------------
```
The first command shows how to select properties of an object and export them to a CSV file. This command uses the Get-Date cmdlet to get the current date and time. It uses the Select-Object cmdlet to select the desired properties, and the Export-CSV cmdlet to export the object and its properties to the Date.csv file. The output shows the expected content in the Date.csv file.
PS C:\>get-date | select-object -property DateTime, Day, DayOfWeek, DayOfYear | export-csv -path Date.csv

#In Date.csv:"DateTime","Day","DayOfWeek","DayOfYear""Tuesday, October 05, 2010 2:45:13 PM","5","Tuesday","278"

The second command shows that when you use the Format-Table cmdlet to format your data before exporting it, the output is not useful. 
PS C:\>get-date | format-table -property DateTime, Day, DayOfWeek, DayOfYear | export-csv -path Date.csv

#In Date.csv: "ClassId2e4f51ef21dd47e99d3c952918aff9cd","pageHeaderEntry","pageFooterEntry","autosizeInfo","shapeInfo","groupingEntry""033ecb2bc07a4d43b5ef94ed5a35d280",,,,"Microsoft.PowerShell.Commands.Internal.Format.TableHeaderInfo","9e210fe47d09416682b841769c78b8a3",,,,,"27c87ef9bbda4f709f6b4002fa4af63c",,,,,"4ec4f0187cb04f4cb6973460dfe252df",,,,,"cf522b78d86c486691226b40aa69e95c",,,,,
```

This example demonstrates one of most common problems that users encounter when using the Export-CSV cmdlet.
It explains how to recognize and avoid this error.

Because a CSV file has a table format, it might seem natural to use the Format-Table cmdlet to format the  data in a table to prepare it for export as a CSV file.
Also, the Format-Table cmdlet allows you to select object properties easily.

However, when you format the data in a table and then export it, you are exporting a table object, not your original data object.
The resulting CSV file is not useful.

This example shows how to select object properties by using the Select-Object cmdlet, and it shows the Export-CSV formats the data correctly in a CSV file without any preparatory formatting by another cmdlet.

## PARAMETERS

### -Append
Adds the CSV output to the end of the specified file.
Without this parameter, Export-CSV replaces the file contents without warning.

This parameter is introduced in Windows PowerShell 3.0.

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

### -Delimiter
Specifies a delimiter to separate the property values.
The default is a comma (,).
Enter a character, such as a colon (:).
To specify a semicolon (;), enclose it in quotation marks.

```yaml
Type: Char
Parameter Sets: Delimiter
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the encoding for the exported CSV file.
Valid values are Unicode, UTF7, UTF8, ASCII, UTF32, BigEndianUnicode, Default, and OEM.
The default is ASCII.

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
Overwrites the file specified in path without prompting.

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

### -InformationAction
This parameter is introduced in Windows PowerShell 3.0.

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
This parameter is introduced in Windows PowerShell 3.0.

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
Specifies the objects to export as CSV strings.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe objects to Export-CSV.

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

### -NoClobber
Do not overwrite (replace the contents) of an existing file.
By default, if a file exists in the specified path, Export-CSV overwrites the file without warning.

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
Omits the type information from the CSV file.
By default, the first line of the CSV file contains "#TYPE " followed by the fully-qualified name of the type of the object.

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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCulture
Use the list separator for the current culture as the item delimiter.
The default is a comma (,).

This parameter is very useful in scripts that are being distributed to users worldwide.
To find the list separator for a culture, use the following command: (Get-Culture).TextInfo.ListSeparator.

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

### -LiteralPath
Specifies the path to the CSV output file.
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
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

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object with an Extended Type System (ETS) adapter to Export-CSV.

## OUTPUTS

### System.String
The CSV list is sent to the file designated in the Path parameter.

## NOTES
The Export-CSV cmdlet converts the objects that you submit into a series of CSV variable-length strings and saves them in the specified text file.
You can use Export-CSV to save objects in a CSV file and then use the Import-CSV cmdlet to create objects from the text in the CSV file.

In the CSV file, each object is represented by a comma-separated list of the property values of the object.
The property values are converted to strings (by using the ToString() method of the object), so they are generally represented by the name of the property value.
Export-CSV does not export the methods of the object.

The format of an exported file is as follows:

-- The first line of the CSV file contains the string '#TYPE ' followed by the fully qualified name of the object, such as #TYPE System.Diagnostics.Process. To suppress this line, use the NoTypeInformation parameter.
-- The next line of the CSV file represents the column headers. It contains a comma-separated list of the names of all the properties of the first object.
-- Additional lines of the file consist of comma-separated lists of the property values of each object.

When you submit multiple objects to Export-CSV, Export-CSV organizes the file based on the properties of the first object that you submit.
If the remaining objects do not have one of the specified properties, the property value of that object is null, as represented by two consecutive commas.
If the remaining objects have additional properties, those property values are not included in the file.

You can use the Import-Csv cmdlet to re-create objects from the CSV strings in the files.
The resulting objects are CSV versions of the original objects that consist of string representations of the property values and no methods.

The ConvertTo-Csv and ConvertFrom-Csv cmdlets to convert objects to CSV strings (and back).
Export-CSV is the same as ConvertTo-CSV, except that it saves the CSV strings in a file.

## RELATED LINKS

[ConvertFrom-Csv]()

[ConvertTo-Csv]()

[Format-Table]()

[Import-Csv]()

[Select-Object]()

