---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293951
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
PS C:\> Get-Date | Select-Object -Property * | ConvertTo-Json
```

```output
{
    "DisplayHint":  2,
    "DateTime":  "Saturday, October 13, 2018 2:57:58 AM",
    "Date":  "\/Date(1539388800000)\/",
    "Day":  13,
    "DayOfWeek":  6,
    "DayOfYear":  286,
    "Hour":  2,
    "Kind":  2,
    "Millisecond":  710,
    "Minute":  57,
    "Month":  10,
    "Second":  58,
    "Ticks":  636749962787108331,
    "TimeOfDay":  {
                      "Ticks":  106787108331,
                      "Days":  0,
                      "Hours":  2,
                      "Milliseconds":  710,
                      "Minutes":  57,
                      "Seconds":  58,
                      "TotalDays":  0.12359619019791666,
                      "TotalHours":  2.96630856475,
                      "TotalMilliseconds":  10678710.8331,
                      "TotalMinutes":  177.978513885,
                      "TotalSeconds":  10678.7108331
                  },
    "Year":  2018
}
```

This example uses the **ConvertTo-Json** cmdlet to convert a **System.DateTime** object from the **Get-Date** cmdlet to a JSON-formatted string. The command uses the **Select-Object** cmdlet to get all (`*`) of the properties of the **DateTime** object. The output shows the JSON string that **ConvertTo-Json** returned.

### Example 4

```powershell
PS C:\> Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
```

```output
DisplayHint : 2
DateTime    : Saturday, October 13, 2018 2:58:23 AM
Date        : 10/13/2018 12:00:00 AM
Day         : 13
DayOfWeek   : 6
DayOfYear   : 286
Hour        : 2
Kind        : 2
Millisecond : 148
Minute      : 58
Month       : 10
Second      : 23
Ticks       : 636749963031489637
TimeOfDay   : @{Ticks=107031489637; Days=0; Hours=2; Milliseconds=148; Minutes=58; Seconds=23;
              TotalDays=0.12387903893171295; TotalHours=2.9730969343611111; TotalMilliseconds=10703148.9637;
              TotalMinutes=178.38581606166667; TotalSeconds=10703.1489637}
Year        : 2018
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

* The **ConvertTo-Json** cmdlet is implemented by using the [JavaScriptSerializer class](https://msdn.microsoft.com/library/system.web.script.serialization.javascriptserializer).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](http://msdn.microsoft.com/library/bb299886.aspx)

[ConvertFrom-Json](ConvertFrom-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)