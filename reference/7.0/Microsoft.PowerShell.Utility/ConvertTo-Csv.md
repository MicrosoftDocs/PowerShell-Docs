---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/08/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertto-csv?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertTo-Csv
---

# ConvertTo-Csv

## SYNOPSIS
Converts .NET objects into a series of character-separated value (CSV) strings.

## SYNTAX

### Delimiter (Default)

```
ConvertTo-Csv [-InputObject] <PSObject> [[-Delimiter] <Char>] [-IncludeTypeInformation]
 [-NoTypeInformation] [-QuoteFields <String[]>] [-UseQuotes <QuoteKind>] [<CommonParameters>]
```

### UseCulture

```
ConvertTo-Csv [-InputObject] <PSObject> [-UseCulture] [-IncludeTypeInformation] [-NoTypeInformation]
 [-QuoteFields <String[]>] [-UseQuotes <QuoteKind>] [<CommonParameters>]
```

## DESCRIPTION

The `ConvertTo-CSV` cmdlet returns a series of comma-separated value (CSV) strings that represent
the objects that you submit. You can then use the `ConvertFrom-Csv` cmdlet to recreate objects from
the CSV strings. The objects converted from CSV are string values of the original objects that
contain property values and no methods.

You can use the `Export-Csv` cmdlet to convert objects to CSV strings. `Export-CSV` is similar to
`ConvertTo-CSV`, except that it saves the CSV strings to a file.

The `ConvertTo-CSV` cmdlet has parameters to specify a delimiter other than a comma or use the
current culture as the delimiter.

## EXAMPLES

### Example 1: Convert an object to CSV

This example converts a **Process** object to a CSV string.

```powershell
Get-Process -Name pwsh | ConvertTo-Csv -NoTypeInformation
```

```Output
"Name","SI","Handles","VM","WS","PM","NPM","Path","Parent","Company","CPU","FileVersion", ...
"pwsh","8","950","2204001161216","100925440","59686912","67104", ...
```

The `Get-Process` cmdlet gets the **Process** object and uses the **Name** parameter to specify the
PowerShell process. The process object is sent down the pipeline to the `ConvertTo-CSV` cmdlet. The
`ConvertTo-CSV` cmdlet converts the object to CSV strings. The **NoTypeInformation** parameter
removes the **#TYPE** information header from the CSV output and is not required in PowerShell 6.

### Example 2: Convert a DateTime object to CSV

This example converts a **DateTime** object to a CSV string.

```powershell
$Date = Get-Date
ConvertTo-Csv -InputObject $Date -Delimiter ';' -NoTypeInformation
```

```Output
"DisplayHint";"DateTime";"Date";"Day";"DayOfWeek";"DayOfYear";"Hour";"Kind";"Millisecond";"Minute";"Month";"Second";"Ticks";"TimeOfDay";"Year"
"DateTime";"Friday, January 4, 2019 14:40:51";"1/4/2019 00:00:00";"4";"Friday";"4";"14";"Local";"711";"40";"1";"51";"636822096517114991";"14:40:51.7114991";"2019"
```

The `Get-Date` cmdlet gets the **DateTime** object and saves it in the `$Date` variable. The
`ConvertTo-Csv` cmdlet converts the **DateTime** object to strings. The **InputObject** parameter
uses the **DateTime** object stored in the `$Date` variable. The **Delimiter** parameter specifies
a semicolon to separate the string values. The **NoTypeInformation** parameter removes the
**#TYPE** information header from the CSV output and is not required in PowerShell 6.

### Example 3: Convert the PowerShell event log to CSV

This example converts the Windows event log for PowerShell to a series of CSV strings.

```powershell
(Get-Culture).TextInfo.ListSeparator
Get-WinEvent -LogName 'PowerShellCore/Operational' | ConvertTo-Csv -UseCulture -NoTypeInformation
```

```Output
,
"Message","Id","Version","Qualifiers","Level","Task","Opcode","Keywords","RecordId", ...
"Error Message = System error""4100","1",,"3","106","19","0","31716","PowerShellCore", ...
```

The `Get-Culture` cmdlet uses the nested properties **TextInfo** and **ListSeparator** and displays
the current culture's default list separator. The `Get-WinEvent` cmdlet gets the event log objects
and uses the **LogName** parameter to specify the log file name. The event log objects are sent
down the pipeline to the `ConvertTo-Csv` cmdlet. The `ConvertTo-Csv` cmdlet converts the event log
objects to a series of CSV strings. The **UseCulture** parameter uses the current culture's default
list separator as the delimiter. The **NoTypeInformation** parameter removes the **#TYPE**
information header from the CSV output and is not required in PowerShell 6.

### Example 4: Convert to CSV with quotes around two columns

This example converts a **DateTime** object to a CSV string.

```powershell
Get-Date | ConvertTo-Csv -QuoteFields "DateTime","Date"
```

```Output
DisplayHint,"DateTime","Date",Day,DayOfWeek,DayOfYear,Hour,Kind,Millisecond,Minute,Month,Second,Ticks,TimeOfDay,Year
DateTime,"Thursday, August 22, 2019 11:27:34 AM","8/22/2019 12:00:00 AM",22,Thursday,234,11,Local,569,27,8,34,637020700545699784,11:27:34.5699784,2019
```

### Example 4: Convert to CSV with quotes only when needed

This example converts a **DateTime** object to a CSV string.

```powershell
Get-Date | ConvertTo-Csv -UseQuotes AsNeeded
```

```Output
DisplayHint,DateTime,Date,Day,DayOfWeek,DayOfYear,Hour,Kind,Millisecond,Minute,Month,Second,Ticks,TimeOfDay,Year
DateTime,"Thursday, August 22, 2019 11:31:00 AM",8/22/2019 12:00:00 AM,22,Thursday,234,11,Local,713,31,8,0,637020702607132640,11:31:00.7132640,2019
```

## PARAMETERS

### -Delimiter

Specifies the delimiter to separate the property values in CSV strings. The default is a comma
(`,`). Enter a character, such as a colon (`:`). To specify a semicolon (`;`) enclose it in single
quotation marks.

```yaml
Type: System.Char
Parameter Sets: Delimiter
Aliases:

Required: False
Position: 1
Default value: comma (,)
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTypeInformation

When this parameter is used the first line of the output contains **#TYPE** followed by the fully
qualified name of the object type. For example, **#TYPE System.Diagnostics.Process**.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: ITI

Required: False
Position: Named
Default value: #TYPE <Object>
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects that are converted to CSV strings. Enter a variable that contains the objects
or type a command or expression that gets the objects. You can also pipe objects to
`ConvertTo-CSV`.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NoTypeInformation

Removes the **#TYPE** information header from the output. This parameter became the default in
PowerShell 6.0 and is included for backwards compatibility.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: NTI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCulture

Uses the list separator for the current culture as the item delimiter. To find the list separator
for a culture, use the following command: `(Get-Culture).TextInfo.ListSeparator`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: UseCulture
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuoteFields

Specifies the names of the columns that should be quoted. When this parameter is used only the
specified columns are quoted. This parameter was added in PowerShell 7.0.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: QF

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseQuotes

Specifies when quotes are used in the CSV files. Possible values are:

- Never - don't quote anything
- Always - quote everything (default behavior)
- AsNeeded - only quote fields that contain a delimiter character

This parameter was added in PowerShell 7.0.

```yaml
Type: Microsoft.PowerShell.Commands.BaseCsvWritingCommand+QuoteKind
Parameter Sets: (All)
Aliases: UQ

Required: False
Position: Named
Default value: Always
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object that has an Extended Type System (ETS) adapter to `ConvertTo-CSV`.

## OUTPUTS

### System.String

The CSV output is returned as a collection of strings.

## NOTES

In CSV format, each object is represented by a comma-separated list of its property value. The
property values are converted to strings using the object's **ToString()** method. The strings are
represented by the property value name. `ConvertTo-CSV` does not export the object's methods.

The CSV strings are output as follows:

- If **IncludeTypeInformation** is used, the first string consists of **#TYPE** followed by the
  object type's fully qualified name. For example, **#TYPE System.Diagnostics.Process**.
- If **IncludeTypeInformation** is not used the first string includes the column headers. The
  headers contain the first object's property names as a comma-separated list.
- The remaining strings contain comma-separated lists of each object's property values.

Beginning with PowerShell 6.0 the default behavior of `ConvertTo-CSV` is to not include the
**#TYPE** information in the CSV and **NoTypeInformation** is implied. **IncludeTypeInformation**
can be used to include the **#TYPE** information and emulate the default behavior of
`ConvertTo-CSV` prior to PowerShell 6.0.

When you submit multiple objects to `ConvertTo-CSV`, `ConvertTo-CSV` orders the strings based on
the properties of the first object that you submit. If the remaining objects do not have one of the
specified properties, the property value of that object is Null, as represented by two consecutive
commas. If the remaining objects have additional properties, those property values are ignored.

## RELATED LINKS

[ConvertFrom-Csv](ConvertFrom-Csv.md)

[Export-Csv](Export-Csv.md)

[Import-Csv](Import-Csv.md)
