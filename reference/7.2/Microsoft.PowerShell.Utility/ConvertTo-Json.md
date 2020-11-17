---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertTo-Json
---
# ConvertTo-Json

## SYNOPSIS
Converts an object to a JSON-formatted string.

## SYNTAX

```
ConvertTo-Json [-InputObject] <Object> [-Depth <Int32>] [-Compress]
[-EnumsAsStrings] [-AsArray] [-EscapeHandling <StringEscapeHandling>]
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
  "MinSupportedDateTime": "0001-01-01T00:00:00",
  "MaxSupportedDateTime": "9999-12-31T23:59:59.9999999",
  "AlgorithmType": 1,
  "CalendarType": 1,
  "Eras": [
    1
  ],
  "TwoDigitYearMax": 2029,
  "IsReadOnly": true
}
```

This command uses the `ConvertTo-Json` cmdlet to convert a GregorianCalendar object to a
JSON-formatted string.

### Example 2

```powershell
Get-Date | ConvertTo-Json; Get-Date | ConvertTo-Json -AsArray
```

```Output
{
  "value": "2018-10-12T23:07:18.8450248-05:00",
  "DisplayHint": 2,
  "DateTime": "October 12, 2018 11:07:18 PM"
}
[
  {
    "value": "2018-10-12T23:07:18.8480668-05:00",
    "DisplayHint": 2,
    "DateTime": "October 12, 2018 11:07:18 PM"
  }
]
```

This example shows the output from `ConvertTo-Json` cmdlet with and without the **AsArray** switch
parameter. You can see the second portion of the output is wrapped in array brackets.

### Example 3

```powershell
@{Account="User01";Domain="Domain01";Admin="True"} | ConvertTo-Json -Compress
```

```Output
{"Domain":"Domain01","Account":"User01","Admin":"True"}
```

This command shows the effect of using the **Compress** parameter of `ConvertTo-Json`. The
compression affects only the appearance of the string, not its validity.

### Example 4

```powershell
Get-Date | Select-Object -Property * | ConvertTo-Json
```

```Output
{
  "DisplayHint": 2,
  "DateTime": "October 12, 2018 10:55:32 PM",
  "Date": "2018-10-12T00:00:00-05:00",
  "Day": 12,
  "DayOfWeek": 5,
  "DayOfYear": 285,
  "Hour": 22,
  "Kind": 2,
  "Millisecond": 639,
  "Minute": 55,
  "Month": 10,
  "Second": 32,
  "Ticks": 636749817326397744,
  "TimeOfDay": {
    "Ticks": 825326397744,
    "Days": 0,
    "Hours": 22,
    "Milliseconds": 639,
    "Minutes": 55,
    "Seconds": 32,
    "TotalDays": 0.95523888627777775,
    "TotalHours": 22.925733270666665,
    "TotalMilliseconds": 82532639.774400011,
    "TotalMinutes": 1375.54399624,
    "TotalSeconds": 82532.6397744
  },
  "Year": 2018
}
```

This example uses the `ConvertTo-Json` cmdlet to convert a **System.DateTime** object from the
`Get-Date` cmdlet to a JSON-formatted string. The command uses the `Select-Object` cmdlet to get all
(`*`) of the properties of the **DateTime** object. The output shows the JSON string that
`ConvertTo-Json` returned.

### Example 5

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

### -AsArray

Outputs the object in array brackets, even if the input is a single object.

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

### -EnumsAsStrings

Provides an alternative serialization option that converts all enumerations to their string representation.

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

### -EscapeHandling

Controls how certain characters are escaped in the resulting JSON output. By default, only control
characters (like newline) are escaped.

Acceptable values are:

- Default - Only control characters are escaped.
- EscapeNonAscii - All non-ASCII and control characters are escaped.
- EscapeHtml - HTML (`<`, `>`, `&`, `'`, `"`) and control characters are escaped.

This parameter was introduced in PowerShell 6.2.

```yaml
Type: Newtonsoft.Json.StringEscapeHandling
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Default
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

The `ConvertTo-Json` cmdlet is implemented using
[Newtonsoft Json.NET](https://www.newtonsoft.com/json).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[ConvertFrom-Json](ConvertFrom-Json.md)

[Get-Content](../Microsoft.PowerShell.Management/Get-Content.md)

[Get-UICulture](Get-UICulture.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)

[NewtonSoft.Json.StringEscapeHandling](https://www.newtonsoft.com/json/help/html/T_Newtonsoft_Json_StringEscapeHandling.htm)
