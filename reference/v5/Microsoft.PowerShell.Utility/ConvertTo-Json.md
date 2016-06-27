---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293951
schema: 2.0.0
---

# ConvertTo-Json
## SYNOPSIS
Converts an object to a JSON-formatted string

## SYNTAX

```
ConvertTo-Json [-InputObject] <Object> [-Depth <Int32>] [-Compress] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The ConvertTo-Json cmdlet converts any object to a string in JavaScript Object Notation (JSON) format.
The properties are converted to field names, the field values are converted to property values, and the methods are removed.

You can then use the ConvertFrom-Json cmdlet to convert a JSON-formatted string to a JSON object, which is easily managed in Windows PowerShell.

Many web sites use JSON instead of XML to serialize data for communication between servers and web-based apps.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1
```
PS C:\>(Get-UICulture).Calendar | ConvertTo-Json

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

This command uses the ConvertTo-Json cmdlet to convert a GregorianCalendar object to a JSON-formatted string.

### Example 2
```
PS C:\>@{Account="User01";Domain="Domain01";Admin="True"} | ConvertTo-Json - Compress
{"Admin":"True","Account":"User01","Domain":"Domain01"}
```

This command shows the effect of using the Compress parameter of ConvertTo-Json.
The compression affects only the appearance of the string, not its validity.

### Example 3
```
The first command uses the ConvertTo-Json cmdlet to convert a System.DateTime object from the Get-Date cmdlet to a JSON-formatted string. The command uses the Select-Object cmdlet to get all (*) of the properties of the DateTime object.The output shows the JSON string that ConvertTo-Json returned.
PS C:\>Get-Date | Select-Object -Property * | ConvertTo-Json

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

The second command uses ConvertFrom-Json to convert the JSON string to a JSON object. 
PS C:\>Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json

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

TimeOfDay   : @{Ticks=723914009002; Days=0; Hours=20; Milliseconds=400;

 Minutes=6; Seconds=31; TotalDays=0.83786343634490734;
               TotalHours=20.108722472277776; TotalMilliseconds=72391400.900200009;
 TotalMinutes=1206.5233483366667;

              TotalSeconds=72391.4009002}

Year        : 2012
```

This command shows how to use the ConvertTo-Json and ConvertFrom-Json cmdlet to convert an object to a JSON string and a JSON object.

### Example 4
```
PS C:\>$JsonSecurityHelp = Get-Content $pshome\Modules\Microsoft.PowerShell.Security\en-US\Microsoft.PowerShell.Security.dll-Help.xml | ConvertTo-Json
```

This command uses the ConvertTo-Json cmdlet to convert a Windows PowerShell help file from XML format to JSON format.
You can use a command like this to use the help topic content in a web service application.

## PARAMETERS

### -Compress
Omits white space and indented formatting in the output string.

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

### -Depth
Specifies how many levels of contained objects are included in the JSON representation.
The default value is 2.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

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
@{Text=}

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
Specifies the objects to convert to JSON format.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe an object to ConvertTo-Json.

The InputObject parameter is required, but its value can be null ($null) or an empty string.
When the input object is $null, ConvertTo-Json does not generate any output.
When the input object is an empty string, ConvertTo-Json returns an empty string.

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

## INPUTS

### System.Object
You can pipe any object to ConvertTo-Json.

## OUTPUTS

### System.String

## NOTES
The ConvertTo-Json cmdlet is implemented by using the JavaScriptSerializer class (http://msdn.microsoft.com/en-us/library/system.web.script.serialization.javascriptserializer(VS.100).aspx).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET]()

[ConvertFrom-Json]()

[Invoke-WebRequest]()

[Invoke-RestMethod]()

