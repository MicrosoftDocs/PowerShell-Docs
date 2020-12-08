---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/08/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Export-Csv
---
# Export-Csv

## SYNOPSIS
Converts objects into a series of comma-separated value (CSV) strings and saves the strings to a
file.

## SYNTAX

### Delimiter (Default)

```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <Encoding>] [-Append] [[-Delimiter] <Char>] [-IncludeTypeInformation]
 [-NoTypeInformation] [-QuoteFields <String[]>] [-UseQuotes <QuoteKind>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### UseCulture

```
Export-Csv -InputObject <PSObject> [[-Path] <String>] [-LiteralPath <String>] [-Force] [-NoClobber]
 [-Encoding <Encoding>] [-Append] [-UseCulture] [-IncludeTypeInformation] [-NoTypeInformation]
 [-QuoteFields <String[]>] [-UseQuotes <QuoteKind>] [-WhatIf] [-Confirm]  [<CommonParameters>]
```

## DESCRIPTION

The `Export-CSV` cmdlet creates a CSV file of the objects that you submit. Each object is a row
that includes a comma-separated list of the object's property values. You can use the `Export-CSV`
cmdlet to create spreadsheets and share data with programs that accept CSV files as input.

Do not format objects before sending them to the `Export-CSV` cmdlet. If `Export-CSV` receives
formatted objects the CSV file contains the format properties rather than the object properties. To
export only selected properties of an object, use the `Select-Object` cmdlet.

## EXAMPLES

### Example 1: Export process properties to a CSV file

This example selects **Process** objects with specific properties, exports the objects to a CSV
file.

```powershell
Get-Process -Name WmiPrvSE | Select-Object -Property BasePriority,Id,SessionId,WorkingSet |
  Export-Csv -Path .\WmiData.csv -NoTypeInformation
Import-Csv -Path .\WmiData.csv
```

```Output
BasePriority Id    SessionId WorkingSet
------------ --    --------- ----------
8            976   0         20267008
8            2292  0         36786176
8            3816  0         30351360
8            8604  0         15011840
8            10008 0         8830976
8            11764 0         14237696
8            54632 0         9502720
```

The `Get-Process` cmdlet gets the **Process** objects. The **Name** parameter filters the output to
include only the WmiPrvSE process objects. The process objects are sent down the pipeline to the
`Select-Object` cmdlet. `Select-Object` uses the **Property** parameter to select a subset of
process object properties. The process objects are sent down the pipeline to the `Export-Csv`
cmdlet. `Export-Csv` converts the process objects to a series of CSV strings. The **Path**
parameter specifies that the WmiData.csv file is saved in the current directory. The
**NoTypeInformation** parameter removes the **#TYPE** information header from the CSV output and is
not required in PowerShell 6. The `Import-Csv` cmdlet uses the **Path** parameter to display the
file located in the current directory.

### Example 2: Export processes to a comma-delimited file

This example gets **Process** objects and exports the objects to a CSV file.

```powershell
Get-Process | Export-Csv -Path .\Processes.csv -NoTypeInformation
Get-Content -Path .\Processes.csv
```

```Output
"Name","SI","Handles","VM","WS","PM","NPM","Path","Parent","Company","CPU","FileVersion", ...
"ApplicationFrameHost","4","511","2203597099008","35364864","21979136","30048", ...
```

The `Get-Process` cmdlet gets **Process** objects. The process objects are sent down the pipeline
to the `Export-Csv` cmdlet. `Export-Csv` converts the process objects to a series of CSV strings.
The **Path** parameter specifies that the Processes.csv file is saved in the current directory. The
**NoTypeInformation** parameter removes the **#TYPE** information header from the CSV output and is
not required in PowerShell 6. The `Get-Content` cmdlet uses the **Path** parameter to display the
file located in the current directory.

### Example 3: Export processes to a semicolon delimited file

This example gets **Process** objects and exports the objects to a file with a semicolon delimiter.

```powershell
Get-Process | Export-Csv -Path .\Processes.csv -Delimiter ';' -NoTypeInformation
Get-Content -Path .\Processes.csv
```

```Output
"Name";"SI";"Handles";"VM";"WS";"PM";"NPM";"Path";"Parent";"Company";"CPU";"FileVersion"; ...
"ApplicationFrameHost";"4";"509";"2203595321344";"34807808";"21770240";"29504"; ...
```

The `Get-Process` cmdlet gets **Process** objects. The process objects are sent down the pipeline
to the `Export-Csv` cmdlet. `Export-Csv` converts the process objects to a series of CSV strings.
The **Path** parameter specifies that the Processes.csv file is saved in the current directory. The
**Delimiter** parameter specifies a semicolon to separate the string values. The
**NoTypeInformation** parameter removes the **#TYPE** information header from the CSV output and is
not required in PowerShell 6. The `Get-Content` cmdlet uses the **Path** parameter to display the
file located in the current directory.

### Example 4: Export processes using the current culture's list separator

This example gets **Process** objects and exports the objects to a file. The delimiter is the
current culture's list separator.

```powershell
(Get-Culture).TextInfo.ListSeparator
Get-Process | Export-Csv -Path .\Processes.csv -UseCulture -NoTypeInformation
Get-Content -Path .\Processes.csv
```

```Output
"Name","SI","Handles","VM","WS","PM","NPM","Path","Parent","Company","CPU","FileVersion", ...
"ApplicationFrameHost","4","511","2203597099008","35364864","21979136","30048", ...
```

The `Get-Culture` cmdlet uses the nested properties **TextInfo** and **ListSeparator** and displays
the current culture's default list separator. The `Get-Process` cmdlet gets **Process** objects.
The process objects are sent down the pipeline to the `Export-Csv` cmdlet. `Export-Csv` converts
the process objects to a series of CSV strings. The **Path** parameter specifies that the
Processes.csv file is saved in the current directory. The **UseCulture** parameter uses the current
culture's default list separator as the delimiter. The **NoTypeInformation** parameter removes the
**#TYPE** information header from the CSV output and is not required in PowerShell 6. The
`Get-Content` cmdlet uses the **Path** parameter to display the file located in the current
directory.

### Example 5: Export processes with type information

This example explains how to include the **#TYPE** header information in a CSV file. The **#TYPE**
header is the default in versions prior to PowerShell 6.0.

```powershell
Get-Process | Export-Csv -Path .\Processes.csv -IncludeTypeInformation
Get-Content -Path .\Processes.csv
```

```Output
#TYPE System.Diagnostics.Process
"Name","SI","Handles","VM","WS","PM","NPM","Path","Company","CPU","FileVersion", ...
"ApplicationFrameHost","4","507","2203595001856","35139584","20934656","29504", ...
```

The `Get-Process` cmdlet gets **Process** objects. The process objects are sent down the pipeline
to the `Export-Csv` cmdlet. `Export-Csv` converts the process objects to a series of CSV strings.
The **Path** parameter specifies that the Processes.csv file is saved in the current directory. The
**IncludeTypeInformation** includes the **#TYPE** information header in the CSV output. The
`Get-Content` cmdlet uses the **Path** parameter to display the file located in the current
directory.

### Example 6: Export and append objects to a CSV file

This example describes how to export objects to a CSV file and use the **Append** parameter to add
objects to an existing file.

```powershell
$AppService = (Get-Service -DisplayName *Application* | Select-Object -Property DisplayName, Status)
$AppService | Export-Csv -Path .\Services.Csv -NoTypeInformation
Get-Content -Path .\Services.Csv
$WinService = (Get-Service -DisplayName *Windows* | Select-Object -Property DisplayName, Status)
$WinService | Export-Csv -Path ./Services.csv -NoTypeInformation -Append
Get-Content -Path .\Services.Csv
```

```Output
"DisplayName","Status"
"Application Layer Gateway Service","Stopped"
"Application Identity","Running"
"Windows Audio Endpoint Builder","Running"
"Windows Audio","Running"
"Windows Event Log","Running"
```

The `Get-Service` cmdlet gets service objects. The **DisplayName** parameter returns services that
contain the word Application. The service objects are sent down the pipeline to the `Select-Object`
cmdlet. `Select-Object` uses the **Property** parameter to specify the **DisplayName** and
**Status** properties. The `$AppService` variable stores the objects.

The `$AppService` objects are sent down the pipeline to the `Export-Csv` cmdlet. `Export-Csv`
converts the service objects to a series of CSV strings. The **Path** parameter specifies that the
Services.csv file is saved in the current directory. The **NoTypeInformation** parameter removes
the **#TYPE** information header from the CSV output and is not required in PowerShell 6. The
`Get-Content` cmdlet uses the **Path** parameter to display the file located in the current
directory.

The `Get-Service` and `Select-Object` cmdlets are repeated for services that contain the word
Windows. The `$WinService` variable stores the service objects. The `Export-Csv` cmdlet uses the
**Append** parameter to specify that the `$WinService` objects are added to the existing
Services.csv file. The `Get-Content` cmdlet is repeated to display the updated file that includes
the appended data.

### Example 7: Format cmdlet within a pipeline creates unexpected results

This example shows why it is important not to use a format cmdlet within a pipeline. When
unexpected output is received, troubleshoot the pipeline syntax.

```powershell
Get-Date | Select-Object -Property DateTime, Day, DayOfWeek, DayOfYear |
 Export-Csv -Path .\DateTime.csv -NoTypeInformation
Get-Content -Path .\DateTime.csv
```

```Output
"DateTime","Day","DayOfWeek","DayOfYear"
"Wednesday, January 2, 2019 14:59:34","2","Wednesday","2"
```

```powershell
Get-Date | Format-Table -Property DateTime, Day, DayOfWeek, DayOfYear |
 Export-Csv -Path .\FTDateTime.csv -NoTypeInformation
Get-Content -Path .\FTDateTime.csv
```

```Output
"ClassId2e4f51ef21dd47e99d3c952918aff9cd","pageHeaderEntry","pageFooterEntry","autosizeInfo", ...
"033ecb2bc07a4d43b5ef94ed5a35d280",,,,"Microsoft.PowerShell.Commands.Internal.Format. ...
"9e210fe47d09416682b841769c78b8a3",,,,,
"27c87ef9bbda4f709f6b4002fa4af63c",,,,,
"4ec4f0187cb04f4cb6973460dfe252df",,,,,
"cf522b78d86c486691226b40aa69e95c",,,,,
```

The `Get-Date` cmdlet gets the **DateTime** object. The object is sent down the pipeline to the
`Select-Object` cmdlet. `Select-Object` uses the **Property** parameter to select a subset of
object properties. The object is sent down the pipeline to the `Export-Csv` cmdlet. `Export-Csv`
converts the object to a CSV format. The **Path** parameter specifies that the DateTime.csv file is
saved in the current directory. The **NoTypeInformation** parameter removes the **#TYPE**
information header from the CSV output and is not required in PowerShell 6. The `Get-Content`
cmdlet uses the **Path** parameter to display the CSV file located in the current directory.

When the `Format-Table` cmdlet is used within the pipeline to select properties unexpected results
are received. `Format-Table` sends table format objects down the pipeline to the `Export-Csv`
cmdlet rather than the **DateTime** object. `Export-Csv` converts the table format objects to a
series of CSV strings. The `Get-Content` cmdlet displays the CSV file which contains the table
format objects.

### Example 8: Using the Force parameter to overwrite read-only files

This example creates an empty, read-only file and uses the **Force** parameter to update the file.

```powershell
New-Item -Path .\ReadOnly.csv -ItemType File
Set-ItemProperty -Path .\ReadOnly.csv -Name IsReadOnly -Value $true
Get-Process | Export-Csv -Path .\ReadOnly.csv -NoTypeInformation
```

```Output
Export-Csv : Access to the path 'C:\ReadOnly.csv' is denied.
At line:1 char:15
+ Get-Process | Export-Csv -Path .\ReadOnly.csv -NoTypeInformation
+               ~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : OpenError: (:) [Export-Csv], UnauthorizedAccessException
+ FullyQualifiedErrorId : FileOpenFailure,Microsoft.PowerShell.Commands.ExportCsvCommand
```

```powershell
Get-Process | Export-Csv -Path .\ReadOnly.csv -NoTypeInformation -Force
Get-Content -Path .\ReadOnly.csv
```

```Output
"Name";"SI";"Handles";"VM";"WS";"PM";"NPM";"Path";"Parent";"Company";"CPU";"FileVersion"; ...
"ApplicationFrameHost";"4";"509";"2203595321344";"34807808";"21770240";"29504"; ...
```

The `New-Item` cmdlet uses the **Path** and **ItemType** parameters to create the ReadOnly.csv file
in the current directory. The `Set-ItemProperty` cmdlet uses the **Name** and **Value** parameters
to change the file's **IsReadOnly** property to true. The `Get-Process` cmdlet gets **Process**
objects. The process objects are sent down the pipeline to the `Export-Csv` cmdlet. `Export-Csv`
converts the process objects to a series of CSV strings. The **Path** parameter specifies that the
ReadOnly.csv file is saved in the current directory. The **NoTypeInformation** parameter removes
the **#TYPE** information header from the CSV output and is not required in PowerShell 6. The
output shows that the file is not written because access is denied.

The **Force** parameter is added to the `Export-Csv` cmdlet to force the export to write to the
file. The `Get-Content` cmdlet uses the **Path** parameter to display the file located in the
current directory.

### Example 9: Using the Force parameter with Append

This example shows how to use the **Force** and **Append** parameters. When these parameters are
combined, mismatched object properties can be written to a CSV file.

```powershell
$Content = [PSCustomObject]@{Name = 'PowerShell Core'; Version = '6.0'}
$Content | Export-Csv -Path .\ParmFile.csv -NoTypeInformation
$AdditionalContent = [PSCustomObject]@{Name = 'Windows PowerShell'; Edition = 'Desktop'}
$AdditionalContent | Export-Csv -Path .\ParmFile.csv -NoTypeInformation -Append
```

```Output
Export-Csv : Cannot append CSV content to the following file: ParmFile.csv.
The appended object does not have a property that corresponds to the following column:
Version. To continue with mismatched properties, add the -Force parameter, and then retry
 the command.
At line:1 char:22
+ $AdditionalContent | Export-Csv -Path .\ParmFile.csv -NoTypeInformation -Append
+                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : InvalidData: (Version:String) [Export-Csv], InvalidOperationException
+ FullyQualifiedErrorId : CannotAppendCsvWithMismatchedPropertyNames,Microsoft.PowerShell. ...
```

```powershell
$AdditionalContent | Export-Csv -Path .\ParmFile.csv -NoTypeInformation -Append -Force
Import-Csv -Path .\ParmFile.csv
```

```Output
Name               Version
----               -------
PowerShell Core    6.0
Windows PowerShell
```

An expression creates the **PSCustomObject** with **Name** and **Version** properties. The values
are stored in the `$Content` variable. The `$Content` variable is sent down the pipeline to the
`Export-Csv` cmdlet. `Export-Csv` uses the **Path** parameter and saves the ParmFile.csv file in
the current directory. The **NoTypeInformation** parameter removes the **#TYPE** information header
from the CSV output and is not required in PowerShell 6.

Another expression creates a **PSCustomObject** with the **Name** and **Edition** properties. The
values are stored in the `$AdditionalContent` variable. The `$AdditionalContent` variable is sent
down the pipeline to the `Export-Csv` cmdlet. The **Append** parameter is used to add the data to
the file. The append fails because there is a property name mismatch between **Version** and
**Edition**.

The `Export-Csv` cmdlet **Force** parameter is used to force the export to write to the file. The
**Edition** property is discarded. The `Import-Csv` cmdlet uses the **Path** parameter to display
the file located in the current directory.

### Example 10: Export to CSV with quotes around two columns

This example converts a **DateTime** object to a CSV string.

```powershell
Get-Date | Export-Csv  -QuoteFields "DateTime","Date" -Path .\FTDateTime.csv
Get-Content -Path .\FTDateTime.csv
```

```Output
DisplayHint,"DateTime","Date",Day,DayOfWeek,DayOfYear,Hour,Kind,Millisecond,Minute,Month,Second,Ticks,TimeOfDay,Year
DateTime,"Thursday, August 22, 2019 11:27:34 AM","8/22/2019 12:00:00 AM",22,Thursday,234,11,Local,569,27,8,34,637020700545699784,11:27:34.5699784,2019
```

### Example 11: Export to CSV with quotes only when needed

This example converts a **DateTime** object to a CSV string.

```powershell
Get-Date | Export-Csv  -UseQuotes AsNeeded -Path .\FTDateTime.csv
Get-Content -Path .\FTDateTime.csv
```

```Output
DisplayHint,DateTime,Date,Day,DayOfWeek,DayOfYear,Hour,Kind,Millisecond,Minute,Month,Second,Ticks,TimeOfDay,Year
DateTime,"Thursday, August 22, 2019 11:31:00 AM",8/22/2019 12:00:00 AM,22,Thursday,234,11,Local,713,31,8,0,637020702607132640,11:31:00.7132640,2019
```

## PARAMETERS

### -Append

Use this parameter so that `Export-CSV` adds CSV output to the end of the specified file. Without
this parameter, `Export-CSV` replaces the file contents without warning.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter

Specifies a delimiter to separate the property values. The default is a comma (`,`). Enter a
character, such as a colon (`:`). To specify a semicolon (`;`), enclose it in quotation marks.

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

### -Encoding

Specifies the encoding for the exported CSV file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `bigendianutf32`: Encodes in UTF-32 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format.
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

> [!NOTE]
> **UTF-7*** is no longer recommended to use. In PowerShell 7.1, a warning is written if you
> specify `utf7` for the **Encoding** parameter.

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

This parameter allows `Export-Csv` to overwrite files with the **Read Only** attribute.

When **Force** and **Append** parameters are combined, objects that contain mismatched properties
can be written to a CSV file. Only the properties that match are written to the file. The
mismatched properties are discarded.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTypeInformation

When this parameter is used the first line of the CSV output contains **#TYPE** followed by the
fully qualified name of the object type. For example, **#TYPE System.Diagnostics.Process**.

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

Specifies the objects to export as CSV strings. Enter a variable that contains the objects or type
a command or expression that gets the objects. You can also pipe objects to `Export-CSV`.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the CSV output file. Unlike **Path**, the value of the **LiteralPath**
parameter is used exactly as it is typed. No characters are interpreted as wildcards. If the path
includes escape characters, use single quotation marks. Single quotation marks tell
PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PSPath, LP

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber

Use this parameter so that `Export-CSV` does not overwrite an existing file. By default, if the
file exists in the specified path, `Export-CSV` overwrites the file without warning.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -Path

A required parameter that specifies the location to save the CSV output file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Prevents the cmdlet from being processed or making changes. The output shows what would happen if
the cmdlet were run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuoteFields

Specifies the names of the columns that should be quoted. When this parameter is used, only the
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

You can pipe any object with an Extended Type System (ETS) adapter to `Export-CSV`.

## OUTPUTS

### System.String

The CSV list is sent to the file designated in the Path parameter.

## NOTES

The `Export-CSV` cmdlet converts the objects that you submit into a series of CSV strings and saves
them in the specified text file. You can use `Export-CSV -IncludeTypeInformation` to save objects
in a CSV file and then use the `Import-Csv` cmdlet to create objects from the text in the CSV file.

In the CSV file, each object is represented by a comma-separated list of the property values of the
object. The property values are converted to strings using the **ToString()** method. The strings
are represented by the property value name. `Export-CSV -IncludeTypeInformation` does not export
the methods of the object.

The CSV strings are output as follows:

- If **IncludeTypeInformation** is used, the first string contains the **#TYPE** information header
  followed by the object type's fully qualified name.
  For example, **#TYPE System.Diagnostics.Process**.
- If **IncludeTypeInformation** is not used the first string includes the column headers. The
  headers contain the first object's property names as a comma-separated list.
- The remaining strings contain comma-separated lists of each object's property values.

Beginning with PowerShell 6.0 the default behavior of `Export-CSV` is to not include the **#TYPE**
information in the CSV and **NoTypeInformation** is implied. **IncludeTypeInformation** can be used
to include the **#TYPE** Information and emulate the default behavior of `Export-CSV` prior to
PowerShell 6.0.

When you submit multiple objects to `Export-CSV`, `Export-CSV` organizes the file based on the
properties of the first object that you submit. If the remaining objects do not have one of the
specified properties, the property value of that object is null, as represented by two consecutive
commas. If the remaining objects have additional properties, those property values are not included
in the file.

You can use the `Import-Csv` cmdlet to recreate objects from the CSV strings in the files. The
resulting objects are CSV versions of the original objects that consist of string representations
of the property values and no methods.

The `ConvertTo-Csv` and `ConvertFrom-Csv` cmdlets convert objects to CSV strings and from CSV
strings. `Export-CSV` is the same as `ConvertTo-CSV`, except that it saves the CSV strings in a
file.

## RELATED LINKS

[ConvertFrom-Csv](ConvertFrom-Csv.md)

[ConvertTo-Csv](ConvertTo-Csv.md)

[Format-Table](Format-Table.md)

[Import-Csv](Import-Csv.md)

[Select-Object](Select-Object.md)
