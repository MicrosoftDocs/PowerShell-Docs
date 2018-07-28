---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821753
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertFrom-Json
---
# ConvertFrom-Json

## SYNOPSIS

Converts a JSON-formatted string to a custom object or a hash table.

## SYNTAX

```
ConvertFrom-Json [-InputObject] <String> [-AsHashtable]
[<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-Json` cmdlet converts a JavaScript Object Notation (JSON) formatted string
to a custom **PSCustomObject** object that has a property for each field in the JSON string.
JSON is commonly used by web sites to provide a textual representation of objects.
The JSON standard does not prohibit usage that is prohibited with a PSCustomObject.
For example, if the JSON string contains duplicate keys, only the last key is used by this cmdlet.
See other examples below.

To generate a JSON string from any object, use the ConvertTo-Json cmdlet.

This cmdlet was introduced in PowerShell 3.0.

## EXAMPLES

### Example 1: Convert a DateTime object to a JSON object

```
PS C:\> Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
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

This command uses the ConvertTo-Json and `ConvertFrom-Json` cmdlets to convert a **DateTime**
object from the Get-Date cmdlet to a JSON object.

The command uses the Select-Object cmdlet to get all of the properties of the **DateTime** object.
It uses the `ConvertTo-Json` cmdlet to convert the **DateTime** object to a JSON-formatted string
and the `ConvertFrom-Json` cmdlet to convert the JSON-formatted string to a JSON object.

### Example 2: Get JSON strings from a web service and convert them to PowerShell objects

```powershell
# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json
```

This command uses the `Invoke-WebRequest` cmdlet to get JSON strings from a web service
and then it uses the `ConvertFrom-Json` cmdlet to convert JSON content to objects
that can be managed in PowerShell.

You can also use the Invoke-RestMethod cmdlet, which automatically converts JSON content to objects.

### Example 3: Convert a JSON string to a custom object

```powershell
(Get-Content JsonFile.JSON) -join "`n" | ConvertFrom-Json
```

This example shows how to use the `ConvertFrom-Json` cmdlet to convert a JSON file to a PowerShell custom object.

The command uses Get-Content cmdlet to get the strings in a JSON file.
It uses the Join operator to join the lines in the file into a single string that is delimited
by newline characters (\`n).
Then it uses the pipeline operator to send the delimited string to the `ConvertFrom-Json` cmdlet,
which converts it to a custom object.

The Join operator is required, because the `ConvertFrom-Json` cmdlet expects a single string.

### Example 4: Convert a JSON string to a hash table

```powershell
'{ "key":"value1", "Key":"value2" }' | ConvertFrom-Json -AsHashtable
```

This command shows an example where the `-AsHashtable` switch can overcome limitations of the command.
The JSON string contains 2 key value pairs with keys that differ only in casing. Without the switch,
the command would have thrown an error.

## PARAMETERS

### -InputObject

Specifies the JSON strings to convert to JSON objects.
Enter a variable that contains the string, or type a command or expression that gets the string.
You can also pipe a string to `ConvertFrom-Json`.

The *InputObject* parameter is required, but its value can be an empty string.
When the input object is an empty string, `ConvertFrom-Json` does not generate any output.
The *InputObject* value cannot be $Null.

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

### -AsHashtable

Converts the JSON to a hash table object. This switch was introduced in PowerShell 6.0.
There are several scenarios where it can overcome some limitations of the `ConvertFrom-Json` cmdlet.

- If the JSON contains a list with keys that only differ in casing. Without the switch, those keys
  would be seen as identical keys and therefore only the last one would get used.
- If the JSON contains a key that is an empty string. Without the switch, the cmdlet would throw an
  error since a `PSCustomObject` does not allow for that but a hash table does. An example use case
 where this can occurs are `project.lock.json` files.
- Hash tables can be processed faster for certain data structures.

```yaml
Type: SwitchParameter
Aliases:

Required: False
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction,
-InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and
-WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a JSON string to `ConvertFrom-Json`.

## OUTPUTS

### PSCustomObject

### System.Collections.Hashtable

## NOTES

The `ConvertFrom-Json` cmdlet is implemented by using the
[JavaScriptSerializer class](https://msdn.microsoft.com/library/system.web.script.serialization.javascriptserializer).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](http://msdn.microsoft.com/en-us/library/bb299886.aspx)

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
