---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293947
schema: 2.0.0
---

# ConvertFrom-Json
## SYNOPSIS
Converts a JSON-formatted string to a custom object.

## SYNTAX

```
ConvertFrom-Json [-InputObject] <String> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The ConvertFrom-Json cmdlet converts a JSON-formatted string to a custom object (PSCustomObject) that has a property for each field in the JSON string.
JSON is commonly used by web sites to provide a textual representation of objects.

To generate a JSON string from any object, use the ConvertTo-Json cmdlet.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1
```
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

TimeOfDay   : @{Ticks=723914009002; Days=0; Hours=20; Milliseconds=400; Minutes=6; Seconds=31; TotalDays=0.83786343634490734; TotalHours=20.108722472277776; TotalMilliseconds=72391400.900200009; TotalMinutes=1206.5233483366667;TotalSeconds=72391.4009002}

Year        : 2012
```

This command uses the ConvertTo-Json and ConvertFrom-Json cmdlets to convert a DateTime object from the Get-Date cmdlet to a JSON object.

The command uses the Select-Object cmdlet to get all of the properties of the DateTime object.
It uses the ConvertTo-Json cmdlet to convert the DateTime object to a JSON-formatted string and the ConvertFrom-Json cmdlet to convert the JSON-formatted string to a JSON object..

### Example 2
```
PS C:\>$j = Invoke-WebRequest -Uri http://search.twitter.com/search.json?q=PowerShell | ConvertFrom-Json
```

This command uses the Invoke-WebRequest cmdlet to get JSON strings from a web service and then it uses the ConvertFrom-Json cmdlet to convert JSON content to objects that can be  managed in Windows PowerShell.

You can also use the Invoke-RestMethod cmdlet, which automatically converts JSON content to objects.

### Example 3
```
PS C:\>(Get-Content JsonFile.JSON) -join "`n" | ConvertFrom-Json
```

This example shows how to use the ConvertFrom-Json cmdlet to convert a JSON file to a Windows PowerShell custom object.

The command uses Get-Content cmdlet to get the strings in a JSON file.
It uses the Join operator to join the strings in the file into a single string that is delimited by newline characters (\`n).
Then it uses the pipeline operator to send the delimited string to the ConvertFrom-Json cmdlet, which converts it to a custom object.

The Join operator is required, because the ConvertFrom-Json cmdlet expects a single string.

## PARAMETERS

### -InformationAction
The InputObject parameter is required, but its value can be an empty string.
When the input object is an empty string, ConvertFrom-Json does not generate any output.
The InputObject value cannot be null ($null).

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
The InputObject parameter is required, but its value can be an empty string.
When the input object is an empty string, ConvertFrom-Json does not generate any output.
The InputObject value cannot be null ($null).

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
Specifies the JSON strings to convert to JSON objects.
Enter a variable that contains the string, or type a command or expression that gets the string.
You can also pipe a string to ConvertFrom-Json.

The InputObject parameter is required, but its value can be an empty string.
When the input object is an empty string, ConvertFrom-Json does not generate any output.
The InputObject value cannot be null ($null).

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a JSON string to ConvertFrom-Json.

## OUTPUTS

### PSCustomObject

## NOTES
The ConvertFrom-Json cmdlet is implemented by using the JavaScriptSerializer class (http://msdn.microsoft.com/en-us/library/system.web.script.serialization.javascriptserializer(VS.100).aspx).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET]()

[ConvertTo-Json]()

[Invoke-WebRequest]()

[Invoke-RestMethod]()

