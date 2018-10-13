---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=217032
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertTo-Json
---

# ConvertTo-Json

## SYNOPSIS

Converts an object to a JSON-formatted string

## SYNTAX

```
ConvertTo-Json [-InputObject] <Object> [-Depth <Int32>] [-Compress] [<CommonParameters>]
```

## DESCRIPTION

The **ConvertTo-Json** cmdlet converts any object to a string in JavaScript Object Notation (JSON) format.
The properties are converted to field names, the field values are converted to property values, and the methods are removed.

You can then use the **ConvertTo-Json** cmdlet to convert a JSON-formatted string to a JSON object, which is easily managed in Windows PowerShell.

Many web sites use JSON instead of XML to serialize data for communication between servers and web-based apps.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> (Get-UICulture).Calendar | ConvertTo-Json
```

```output
{
    "MinSupportedDateTime":  "\/Date(-62135568000000)\/",
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

This example uses the **ConvertTo-Json** cmdlet to convert a GregorianCalendar object to a JSON-formatted string.

### Example 2

```powershell
PS C:\> @{Account="User01";Domain="Domain01";Admin="True"} | ConvertTo-Json -Compress
```

```output
{"Admin":"True","Account":"User01","Domain":"Domain01"}
```

This example shows the effect of using the `-Compress` parameter of **ConvertTo-Json**.
The compression affects only the appearance of the string, not its validity.

### Example 3

```powershell
PS> Get-Date | Select-Object -Property * | ConvertTo-Json
```

```output
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

This example uses the **ConvertTo-Json** cmdlet to convert a **System.DateTime** object from the **Get-Date** cmdlet to a JSON-formatted string. The command uses the **Select-Object** cmdlet to get all (`*`) of the properties of the **DateTime** object. The output shows the JSON string that **ConvertTo-Json** returned.

### Example 4

```powershell
PS C:\> Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
```

```output
DisplayHint : 2
DateTime    : Friday, January 13, 2012 8:06:31 PM
Date        : 1/13/2012 8:00:00 AM
Day         : 13
DayOfWeek   : 5
DayOfYear   : 13
Hour        : 20
Kind        : 2
Millisecond : 400
Minute      : 6
Month       : 1
Second      : 31
Ticks       : 634620819914009002
TimeOfDay   : @{Ticks=723914009002; Days=0; Hours=20; Milliseconds=400; Minutes=6; Seconds=31; TotalDays=0.83786343634490734; TotalHours=20.108722472277776; TotalMilliseconds=72391400.900200009; TotalMinutes=1206.5233483366667; TotalSeconds=72391.4009002}
Year        : 2012
```

This example shows how to use the **ConvertTo-Json** and **ConvertFrom-Json** cmdlet to convert an object to a JSON string and a JSON object.

## PARAMETERS

### -Compress

Omits white space and indented formatting in the output string.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

Specifies how many levels of contained objects are included in the JSON representation.
The default value is 2.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to convert to JSON format.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe an object to **ConvertTo-Json**.

The *InputObject* parameter is required, but its value can be null (`$null`) or an empty string.
When the input object is `$null`, **ConvertTo-Json** does not generate any output.
When the input object is an empty string, **ConvertTo-Json** returns an empty string.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe any object to **ConvertTo-Json**.

## OUTPUTS

### System.String

## NOTES

- The **ConvertTo-Json** cmdlet is implemented by using the [JavaScriptSerializer class](https://msdn.microsoft.com/library/system.web.script.serialization.javascriptserializer).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](http://msdn.microsoft.com/library/bb299886.aspx)

[ConvertFrom-Json](ConvertFrom-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)