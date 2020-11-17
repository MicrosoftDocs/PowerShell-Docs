---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 09/19/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/test-json?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Test-Json
---

# Test-Json

## SYNOPSIS
Tests whether a string is a valid JSON document

## SYNTAX

### __AllParameterSets (Default)
```
Test-Json [-Json] <String> [<CommonParameters>]
```

### SchemaString
```
Test-Json [-Json] <String> [[-Schema] <String>] [<CommonParameters>]
```

### SchemaFile
```
Test-Json [-Json] <String> [-SchemaFile <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Test-Json` cmdlet tests whether a string is a valid JavaScript Object Notation (JSON) document
and can optionally verify that JSON document against a provided schema.

The verified string can then be used with the `ConvertFrom-Json` cmdlet convert a JSON-formatted
string to a JSON object, which is easily managed in PowerShell or sent to another program or web
service that access JSON input.

Many web sites use JSON instead of XML to serialize data for communication between servers and
web-based apps.

This cmdlet was introduced in PowerShell 6.1

## EXAMPLES

### Example 1: Test if an object is valid JSON

This example tests whether the input string is a valid JSON document.

```powershell
"{'name': 'Ashley', 'age': 25}" | Test-Json
```

```Output
True
```

### Example 2: Test an object against a provided schema

This example takes a string containing a JSON schema and compares it to an input string.

```powershell
$schema = @'
{
  "definitions": {},
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "http://example.com/root.json",
  "type": "object",
  "title": "The Root Schema",
  "required": [
    "name",
    "age"
  ],
  "properties": {
    "name": {
      "$id": "#/properties/name",
      "type": "string",
      "title": "The Name Schema",
      "default": "",
      "examples": [
        "Ashley"
      ],
      "pattern": "^(.*)$"
    },
    "age": {
      "$id": "#/properties/age",
      "type": "integer",
      "title": "The Age Schema",
      "default": 0,
      "examples": [
        25
      ]
    }
  }
}
'@
"{'name': 'Ashley', 'age': '25'}" | Test-Json -Schema $schema
```

```Output
Test-Json : IntegerExpected: #/age
At line:1 char:37
+ "{'name': 'Ashley', 'age': '25'}" | Test-Json -Schema $schema
+                                     ~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : InvalidData: (:) [Test-Json], Exception
+ FullyQualifiedErrorId : InvalidJsonAgainstSchema,Microsoft.PowerShell.Commands.TestJsonCommand
False
```

In this example, we get an error because the schema expects an integer for **age** but the JSON
input we tested uses a string value instead.

For more information, see [JSON Schema](https://json-schema.org/).

### Example 3: Test an object against a schema from file

JSON schema can reference definitions using `$ref` keyword. The `$ref` can resolve to a URI that
references another file. The `SchemaFile` parameter accepts literal path to the JSON schema file
and allows JSON files to be validated against such schemas.

In this example we have `schema.json` file which references `definitions.json`.

```powershell
PS> Get-Content schema.json

{
  "description":"A person",
  "type":"object",
  "properties":{
    "name":{
      "$ref":"definitions.json#/definitions/name"
    },
    "hobbies":{
      "$ref":"definitions.json#/definitions/hobbies"
    }
  }
}

PS> Get-Content definitions.json

{
  "definitions":{
    "name":{
      "type":"string"
    },
    "hobbies":{
      "type":"array",
      "items":{
        "type":"string"
      }
    }
  }
}

'{"name": "James", "hobbies": [".NET", "Blogging"]}' | Test-Json -SchemaFile 'schema.json'
```

```Output
True
```

For more information, see [Structuring a complex schema](https://json-schema.org/understanding-json-schema/structuring.html).

## PARAMETERS

### -Json

Specifies the JSON string to test for validity. Enter a variable that contains the string, or type a
command or expression that gets the string. You can also pipe a string to `Test-Json`.

The **Json** parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Schema

Specifies a Schema to validate the JSON input against. If passed `Test-Json` will validate that the
Json input conforms to the spec specified by the **Schema** parameter and return `$True` only if the
input conforms to the provided Schema.

For more information, see [JSON Schema](https://json-schema.org/).

```yaml
Type: System.String
Parameter Sets: SchemaString
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaFile

Specifies a schema file used to validate the JSON input. When used, the `Test-Json` returns `$True`
only if the JSON input conforms to the Schema defined in the file specified by the **SchemaFile**
parameter.

For more information, see [JSON Schema](https://json-schema.org/).

```yaml
Type: System.String
Parameter Sets: SchemaFile
Aliases:

Required: False
Position: Named
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

The `Test-Json` cmdlet is implemented by using the [NJsonSchema Class](https://github.com/RSuter/NJsonSchema).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[Additional JSON Schema Details](https://json-schema.org/)

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
