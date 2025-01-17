---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 07/24/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/test-json?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Test-Json
---

# Test-Json

## SYNOPSIS
Tests whether a string is a valid JSON document

## SYNTAX

### JsonString (Default)

```
Test-Json [-Json] <String> [-Options <String[]>] [<CommonParameters>]
```

### JsonStringWithSchemaString

```
Test-Json [-Json] <String> [-Schema] <String> [-Options <String[]>]
 [<CommonParameters>]
```

### JsonStringWithSchemaFile

```
Test-Json [-Json] <String> -SchemaFile <String> [-Options <String[]>]
 [<CommonParameters>]
```

### JsonPath

```
Test-Json -Path <String> [-Options <String[]>] [<CommonParameters>]
```

### JsonPathWithSchemaString

```
Test-Json -Path <String> [-Schema] <String> [-Options <String[]>]
 [<CommonParameters>]
```

### JsonPathWithSchemaFile

```
Test-Json -Path <String> -SchemaFile <String> [-Options <String[]>]
 [<CommonParameters>]
```

### JsonLiteralPath

```
Test-Json -LiteralPath <String> [-Options <String[]>] [<CommonParameters>]
```

### JsonLiteralPathWithSchemaString

```
Test-Json -LiteralPath <String> [-Schema] <String> [-Options <String[]>]
 [<CommonParameters>]
```

### JsonLiteralPathWithSchemaFile

```
Test-Json -LiteralPath <String> -SchemaFile <String> [-Options <String[]>]
 [<CommonParameters>]
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
'{"name": "Ashley", "age": 25}' | Test-Json
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
'{"name": "Ashley", "age": "25"}' | Test-Json -Schema $schema
```

```Output
Test-Json:
Line |
  35 |  '{"name": "Ashley", "age": "25"}' | Test-Json -Schema $schema
     |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~
     | The JSON is not valid with the schema: Value is "string" but should be "integer" at '/age'
False
```

In this example, we get an error because the schema expects an integer for **age** but the JSON
input we tested uses a string value instead.

For more information, see [JSON Schema](https://json-schema.org/).

### Example 3: Test an object against a schema from file

JSON schema can reference definitions using `$ref` keyword. The `$ref` can resolve to a URI that
references another file. The **SchemaFile** parameter accepts literal path to the JSON schema file
and allows JSON files to be validated against such schemas.

In this example the `schema.json` file references `definitions.json`.

```powershell
Get-Content schema.json
```

```Output
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
```

```powershell
Get-Content definitions.json
```

```Output
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
```

```powershell
'{"name": "James", "hobbies": [".NET", "Blogging"]}' | Test-Json -SchemaFile 'schema.json'
```

```Output
True
```

For more information, see
[Structuring a complex schema](https://json-schema.org/understanding-json-schema/structuring.html).

## PARAMETERS

### -Json

Specifies the JSON string to test for validity. Enter a variable that contains the string, or type a
command or expression that gets the string. You can also pipe a string to `Test-Json`.

The **Json** parameter is required.

```yaml
Type: System.String
Parameter Sets: JsonString, JsonStringWithSchemaString, JsonStringWithSchemaFile
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies a path to a JSON file. The value of **LiteralPath** is used exactly as it's typed. No
characters are interpreted as wildcards. If the path includes escape characters, enclose it in
single quotation marks. Single quotation marks tell PowerShell not to interpret any characters as
escape sequences.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.String
Parameter Sets: JsonLiteralPath, JsonLiteralPathWithSchemaString, JsonLiteralPathWithSchemaFile
Aliases: PSPath, LP

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Options

By default, `Test-Json` doesn't support JSON containing comments or trailing commas. This parameter
allows you to specify options to change the default behavior. The following options are available:

- `IgnoreComments`
- `AllowTrailingCommas`

This parameter was added in PowerShell 7.5.0-preview.4.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:
Accepted values: IgnoreComments, AllowTrailingCommas

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to a JSON file. This cmdlet gets the item at the specified location. Wildcard
characters are permitted but the pattern must resolve to a single file.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.String
Parameter Sets: JsonPath, JsonPathWithSchemaString, JsonPathWithSchemaFile
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Schema

Specifies a schema to validate the JSON input against. If passed, `Test-Json` validates that the
JSON input conforms to the spec specified by the **Schema** parameter and return `$true` only if the
input conforms to the provided schema.

For more information, see [JSON Schema](https://json-schema.org/).

```yaml
Type: System.String
Parameter Sets: JsonStringWithSchemaString, JsonLiteralPathWithSchemaString, JsonPathWithSchemaString
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaFile

Specifies a schema file used to validate the JSON input. When used, the `Test-Json` returns `$true`
only if the JSON input conforms to the schema defined in the file specified by the **SchemaFile**
parameter.

For more information, see [JSON Schema](https://json-schema.org/).

```yaml
Type: System.String
Parameter Sets: JsonStringWithSchemaFile, JsonLiteralPathWithSchemaFile, JsonPathWithSchemaFile
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a JSON string to this cmdlet.

## OUTPUTS

### Boolean

This cmdlet returns `$true` if the JSON is valid and otherwise `$false`.

## NOTES

Since PowerShell 6, PowerShell uses the Newtonsoft.Json assemblies for JSON functions. Newtonsoft's
implementation includes several extensions to the JSON standard, such as support for comments and
use of single quotes. For a full list of features, see the Newtonsoft documentation at
[https://www.newtonsoft.com/json](https://www.newtonsoft.com/json).

Beginning in PowerShell 7.4, `Test-Json` uses [System.Text.Json](xref:System.Text.Json) for JSON
parsing and [JsonSchema.NET](https://www.nuget.org/packages/JsonSchema.Net) for schema validation.
With these changes, `Test-Json`:

- No longer supports Draft 4 schemas
- Only supports strictly conformant JSON

For a complete list of differences between Newtonsoft.Json and System.Text.Json, see the
_Table of differences_ in
[Migrate from Newtonsoft.Json to System.Text.Json](/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft?pivots=dotnet-8-0#table-of-differences).

For more information about JSON schema specifications, see the documentation at
[JSON-Schema.org](https://json-schema.org/specification.html).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[Additional JSON Schema Details](https://json-schema.org/)

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
