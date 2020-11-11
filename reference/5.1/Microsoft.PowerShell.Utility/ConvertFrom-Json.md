---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/10/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-Json
---

# ConvertFrom-Json

## SYNOPSIS
Converts a JSON-formatted string to a custom object.

## SYNTAX

```
ConvertFrom-Json [-InputObject] <String> [<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-Json` cmdlet converts a JavaScript Object Notation (JSON) formatted string to a
custom **PSCustomObject** object that has a property for each field in the JSON string. JSON is
commonly used by web sites to provide a textual representation of objects. The JSON standard does
not prohibit usage that is prohibited with a **PSCustomObject**. For example, if the JSON string
contains duplicate keys, only the last key is used by this cmdlet. See other examples below.

To generate a JSON string from any object, use the `ConvertTo-Json` cmdlet.

This cmdlet was introduced in PowerShell 3.0.

> [!NOTE]
> This cmdlet doesn't support JSON with comments.

## EXAMPLES

### Example 1: Convert a DateTime object to a JSON object

This command uses the `ConvertTo-Json` and `ConvertFrom-Json` cmdlets to convert a **DateTime**
object from the `Get-Date` cmdlet to a JSON object then to a **PSCustomObject**.

```powershell
Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
```

```Output
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

The example uses the `Select-Object` cmdlet to get all of the properties of the **DateTime**
object. It uses the `ConvertTo-Json` cmdlet to convert the **DateTime** object to a string
formatted as a JSON object and the `ConvertFrom-Json` cmdlet to convert the JSON-formatted string
to a **PSCustomObject** object.

### Example 2: Get JSON strings from a web service and convert them to PowerShell objects

This command uses the `Invoke-WebRequest` cmdlet to get JSON strings from a web service
and then it uses the `ConvertFrom-Json` cmdlet to convert JSON content to objects
that can be managed in PowerShell.

```powershell
# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json
```

You can also use the `Invoke-RestMethod` cmdlet, which automatically converts JSON content to
objects.

### Example 3: Convert a JSON string to a custom object

This example shows how to use the `ConvertFrom-Json` cmdlet to convert a JSON file to a PowerShell
custom object.

```powershell
Get-Content JsonFile.JSON | ConvertFrom-Json
```

The command uses Get-Content cmdlet to get the strings in a JSON file. Then it uses the pipeline
operator to send the delimited string to the `ConvertFrom-Json` cmdlet, which converts it to a
custom object.

## PARAMETERS

### -InputObject

Specifies the JSON strings to convert to JSON objects. Enter a variable that contains the string,
or type a command or expression that gets the string. You can also pipe a string to
`ConvertFrom-Json`.

The **InputObject** parameter is required, but its value can be an empty string. When the input
object is an empty string, `ConvertFrom-Json` does not generate any output. The **InputObject**
value cannot be `$null`.

```yaml
Type: System.String
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
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a JSON string to `ConvertFrom-Json`.

## OUTPUTS

### PSCustomObject

## NOTES

The `ConvertFrom-Json` cmdlet is implemented using the
[JavaScriptSerializer class](/dotnet/api/system.web.script.serialization.javascriptserializer).

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
