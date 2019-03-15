---
ms.date:  10/10/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  n/a
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Test-Json
---

# Test-Json

## SYNOPSIS
Tests whether a string is a valid JSON document

## SYNTAX

```
Test-Json [-Json] <string> [[-Schema] <string>] [<CommonParameters>]
```

## DESCRIPTION
The Test-Json cmdlet tests whether a string is a valid JavaScript Object Notation (JSON) document and can optionally very that JSON document against a provided schema.

The verified string can then be used with the ConvertFrom-Json cmdlet convert a JSON-formatted string to a JSON object, which is easily managed in PowerShell or sent to another program or web service that access JSON input.

Many web sites use JSON instead of XML to serialize data for communication between servers and web-based apps.

This cmdlet was introduced in Windows PowerShell 6.1

## EXAMPLES

### Example 1: Test if an object is valid JSON
```
PS C:\> "{'name': 'Ashley', 'age': 25}" | Test-Json
True
```
This command tests whether the input string is a valid JSON document, returning True since the string is valid JSON.

### Example 2: Test an object against a provided schema
```powershell
PS C:\> $schema = '{
>>   "definitions": {},
>>   "$schema": "http://json-schema.org/draft-07/schema#",
>>   "$id": "http://example.com/root.json",
>>   "type": "object",
>>   "title": "The Root Schema",
>>   "required": [
>>     "name",
>>     "age"
>>   ],
>>   "properties": {
>>     "name": {
>>       "$id": "#/properties/name",
>>       "type": "string",
>>       "title": "The Name Schema",
>>       "default": "",
>>       "examples": [
>>         "Ashley"
>>       ],
>>       "pattern": "^(.*)$"
>>     },
>>     "age": {
>>       "$id": "#/properties/age",
>>       "type": "integer",
>>       "title": "The Age Schema",
>>       "default": 0,
>>       "examples": [
>>         25
>>       ]
>>     }
>>   }
>> }'
PS C:\> "{'name': 'Ashley', 'age': 25}" | Test-Json -schema $schema
True
```

This Command takes a string containing a JSON schema and compares it to an input string.  Since the input string conforms to the schema described in the -schema argument the cmdlet returns `$True`.

For more information, see [JSON Schema](https://json-schema.org/)

## PARAMETERS

### -Json

Specifies the JSON string to test for validity. Enter a variable that contains the string, or type a command or expression that gets the string. You can also pipe a string to `Test-Json`

The `Json` parameter is required.

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

### -Schema

Specifies a Schema to validate the JSON input against.  If passed `Test-Json` will validate that the Json input conforms to the spec specified by the `-Schema` parameter and return `$True` only if the input conforms to the provided Schema.

For more information, see [JSON Schema](https://json-schema.org/)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction,
-InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and
-WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a JSON string to `Test-Json`.

## OUTPUTS

### Boolean

## NOTES

The `Test-Json` cmdlet is implemented by using the [NJsonSchema Class](https://github.com/RSuter/NJsonSchema)

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](https://msdn.microsoft.com/en-us/library/bb299886.aspx)

[Additional JSON Schema Details](https://json-schema.org/)

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)