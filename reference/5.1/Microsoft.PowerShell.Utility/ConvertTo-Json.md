---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertTo-Json
---
# ConvertTo-Json

## SYNOPSIS
Converts an object to a JSON-formatted string.

## SYNTAX

```
ConvertTo-Json [-InputObject] <Object> [-Depth <Int32>] [-Compress]
 [<CommonParameters>]
```

## DESCRIPTION

The `ConvertTo-Json` cmdlet converts any .NET object to a string in JavaScript Object Notation (JSON)
format. The properties are converted to field names, the field values are converted to property
values, and the methods are removed.

You can then use the `ConvertFrom-Json` cmdlet to convert a JSON-formatted string to a JSON
object, which is easily managed in PowerShell.

Many web sites use JSON instead of XML to serialize data for communication between servers and
web-based apps.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1

```powershell
(Get-UICulture).Calendar | ConvertTo-Json
```

```Output
{
    "MinSupportedDateTime":  "\/Date(-62135596800000)\/",
    "MaxSupportedDateTime":  "\/Date(253402300799999)\/",
    "AlgorithmType":  1,
    "CalendarType":  1,
    "Eras":  [
                 1
             ],
    "TwoDigitYearMax":  2029,
    "IsReadOnly":  false
}
```

This command uses the `ConvertTo-Json` cmdlet to convert a GregorianCalendar object to a
JSON-formatted string.

### Example 2

```powershell
@{Account="User01";Domain="Domain01";Admin="True"} | ConvertTo-Json -Compress
```

```Output
{"Domain":"Domain01","Account":"User01","Admin":"True"}
```

This command shows the effect of using the **Compress** parameter of `ConvertTo-Json`. The
compression affects only the appearance of the string, not its validity.

### Example 3

```powershell
Get-Date | Select-Object -Property * | ConvertTo-Json
```

```Output
{
    "DisplayHint":  2,
    "DateTime":  "Friday, January 13, 2012 8:06:16 PM",
    "Date":  "\/Date(1326441600000)\/",
    "Day":  13,
    "DayOfWeek":  5,
    "DayOfYear":  13,
    "Hour":  20,
    "Kind":  2,
    "Millisecond":  221,
    "Minute":  6,
    "Month":  1,
    "Second":  16,
    "Ticks":  634620819762218083,
    "TimeOfDay":  {
                      "Ticks":  723762218083,
                      "Days":  0,
                      "Hours":  20,
                      "Milliseconds":  221,
                      "Minutes":  6,
                      "Seconds":  16,
                      "TotalDays":  0.83768775241087956,
                      "TotalHours":  20.104506057861109,
                      "TotalMilliseconds":  72376221.8083,
                      "TotalMinutes":  1206.2703634716668,
                      "TotalSeconds":  72376.22180829999
                  },
    "Year":  2012
}
```

This example uses the `ConvertTo-Json` cmdlet to convert a **System.DateTime** object from the
`Get-Date` cmdlet to a JSON-formatted string. The command uses the `Select-Object` cmdlet to get all
(`*`) of the properties of the **DateTime** object. The output shows the JSON string that
`ConvertTo-Json` returned.

### Example 4

```powershell
Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
```

```Output
DisplayHint : 2
DateTime    : October 12, 2018 10:55:52 PM
Date        : 2018-10-12 12:00:00 AM
Day         : 12
DayOfWeek   : 5
DayOfYear   : 285
Hour        : 22
Kind        : 2
Millisecond : 768
Minute      : 55
Month       : 10
Second      : 52
Ticks       : 636749817527683372
TimeOfDay   : @{Ticks=825527683372; Days=0; Hours=22; Milliseconds=768; Minutes=55; Seconds=52;
              TotalDays=0.95547185575463; TotalHours=22.9313245381111; TotalMilliseconds=82552768.3372;
              TotalMinutes=1375.87947228667; TotalSeconds=82552.7683372}
Year        : 2018
```

This example shows how to use the `ConvertTo-Json` and `ConvertFrom-Json` cmdlets to convert an
object to a JSON string and a JSON object.

## PARAMETERS

### -Compress

Omits white space and indented formatting in the output string.

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

### -Depth

Specifies how many levels of contained objects are included in the JSON representation. The default
value is 2.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to convert to JSON format. Enter a variable that contains the objects, or type
a command or expression that gets the objects. You can also pipe an object to `ConvertTo-Json`.

The **InputObject** parameter is required, but its value can be null (`$null`) or an empty string.
When the input object is `$null`, `ConvertTo-Json` does not generate any output. When the input
object is an empty string, `ConvertTo-Json` returns an empty string.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Object

You can pipe any object to `ConvertTo-Json`.

## OUTPUTS

### System.String

## NOTES

The `ConvertTo-Json` cmdlet is implemented using the
[JavaScriptSerializer class](/dotnet/api/system.web.script.serialization.javascriptserializer).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[ConvertFrom-Json](ConvertFrom-Json.md)

[Get-Content](../Microsoft.PowerShell.Management/Get-Content.md)

[Get-UICulture](Get-UICulture.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
