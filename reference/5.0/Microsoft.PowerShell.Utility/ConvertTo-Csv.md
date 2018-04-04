---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821757
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertTo-Csv
---

# ConvertTo-Csv

## SYNOPSIS
Converts objects into a series of comma-separated value (CSV) variable-length strings.

## SYNTAX

### Delimiter (Default)
```
ConvertTo-Csv [-InputObject] <PSObject> [[-Delimiter] <Char>] [-NoTypeInformation] [<CommonParameters>]
```

### UseCulture
```
ConvertTo-Csv [-InputObject] <PSObject> [-UseCulture] [-NoTypeInformation] [<CommonParameters>]
```

## DESCRIPTION
The `ConvertTo-CSV` cmdlet returns a series of comma-separated (CSV) strings that represents the objects that you submit.
You can then use the `ConvertFrom-Csv` cmdlet to re-create objects from the CSV strings.
The resulting objects are CSV versions of the original objects that consist of string representations of the property values and no methods.

You can also use the `Export-Csv` and `Import-Csv` cmdlets to convert objects to CSV strings and back.
`Export-CSV` is the same as `ConvertTo-CSV`, except that it saves the CSV strings to a file.

You can use the parameters of the `ConvertTo-CSV` cmdlet to specify a delimiter other than a comma or to direct `ConvertTo-CSV` to use the default delimiter for the current culture.


## EXAMPLES

### Example 1: Convert an object to CSV
```powershell
Get-Process powershell | ConvertTo-Csv
<#
Result:

#TYPE System.Diagnostics.Process
"__NounName","Name","Handles","VM","WS","PM","NPM","Path","Company","CPU","FileVersion","ProductVersion",...
"Process","powershell","216","597544960","60399616","63197184","21692","C:\WINDOWS\system32\WindowsPowerShell...

#>
```

This command converts a single process object to CSV format.
The command uses the `Get-Process` cmdlet to get the PowerShell process on the local computer.
It uses a pipeline operator (`|`) to send the command to the `ConvertTo-CSV` cmdlet, which converts it to a series of comma-separated strings.

### Example 2: Convert a DateTime object to CSV
```powershell
$Date = Get-Date
ConvertTo-Csv -InputObject $Date -Delimiter ";" -NoTypeInformation
```

This example converts a `DateTime` object to CSV format.

The first command uses the `Get-Date` cmdlet to get the current date.
It saves it in the `$Date` variable.

The second command uses the `ConvertTo-CSV` cmdlet to convert the `DateTime` object in the `$Date` variable to CSV format.
The command uses the `-InputObject` parameter to specify the object to be converted.
It uses the `-Delimiter` parameter to specify the delimiter that separates the object properties.
It uses the `-NoTypeInformation` parameter to suppress the `#TYPE` string.

### Example 3: Convert the PowerShell event log to CSV
```powershell
Get-EventLog -Log "windows powershell" | ConvertTo-Csv -UseCulture
```

This command converts the Windows PowerShell event log on the local computer to a series of CSV strings.

The command uses the `Get-EventLog` cmdlet to get the events in the Windows PowerShell log.
A pipeline operator (`|`) sends the events to the `ConvertTo-CSV` cmdlet, which converts the events to CSV format.
The command uses the `-UseCulture` parameter, which uses the list separator for the current culture as the delimiter.

## PARAMETERS

### -Delimiter
Specifies a delimiter to separate the property values.
The default is a comma (`,`).
Enter a character, such as a colon (`:`).

To specify a semicolon (`;`), enclose it in quotation marks.
Otherwise, it will be interpreted as the command delimiter.

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

### -InputObject
Specifies the objects to export as CSV strings.
Enter a variable that contains the objects or type a command or expression that gets the objects.
You can also pipe objects to `ConvertTo-CSV`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NoTypeInformation
Omits the type information header from the output.
By default, the string in the output contains `#TYPE` followed by the fully-qualified name of the object type.

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

### -UseCulture
Uses the list separator for the current culture as the data delimiter.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object that has an Extended Type System (ETS) adapter to `ConvertTo-CSV`.

## OUTPUTS

### System.String
The CSV output is returned as a collection of strings.

## NOTES
* In CSV format, each object is represented by a comma-separated list of its property value. The property values are converted to strings (by using the `ToString()` method of the object), so they are generally represented by the name of the property value. `ConvertTo-CSV` does not export the methods of the object.

  The format of the resulting CSV strings is as follows:

  - The first string consists of #TYPE followed by the fully-qualified name of the object type, such as `#TYPE System.Diagnostics.Process`.
To suppress this string, use the `-NoTypeInformation` parameter.

  - The next string represents the column headers.
It contains a comma-separated list of the names of all the properties of the first object.

  - The remaining strings consist of comma-separated lists of the property values of each object.

* When you submit multiple objects to `ConvertTo-CSV`, `ConvertTo-CSV` orders the strings based on the properties of the first object that you submit. If the remaining objects do not have one of the specified properties, the property value of that object is Null, as represented by two consecutive commas. If the remaining objects have additional properties, those property values are ignored.


## RELATED LINKS

[ConvertFrom-Csv](ConvertFrom-Csv.md)

[Export-Csv](Export-Csv.md)

[Import-Csv](Import-Csv.md)