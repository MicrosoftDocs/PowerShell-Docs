---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/19/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-Json
---

# ConvertFrom-Json

## SYNOPSIS
Converts a JSON-formatted string to a custom object or a hash table.

## SYNTAX

```
ConvertFrom-Json [-InputObject] <String> [-AsHashtable] [-Depth <Int32>] [-NoEnumerate] [<CommonParameters>]
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
> Beginning with PowerShell 6, this cmdlet supports JSON with comments. Accepted comments are
> started with two forward slashes (`//`). The comment will not be represented in the data and can
> be written in the file without corrupting the data or throwing an error as it did in PowerShell
> 5.1.

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

### Example 4: Convert a JSON string to a hash table

This command shows an example where the `-AsHashtable` switch can overcome limitations of the
command.

```powershell
'{ "key":"value1", "Key":"value2" }' | ConvertFrom-Json -AsHashtable
```

The JSON string contains two key value pairs with keys that differ only in casing. Without the
switch, the command would have thrown an error.

### Example 5: Round-trip a single element array

This command shows an example where the `-NoEnumerate` switch is used to round-trip a single element
JSON array.

```powershell
Write-Output "With -NoEnumerate: $('[1]' | ConvertFrom-Json -NoEnumerate | ConvertTo-Json -Compress)"
Write-Output "Without -NoEnumerate: $('[1]' | ConvertFrom-Json | ConvertTo-Json -Compress)"
```

```Output
With -NoEnumerate: [1]
Without -NoEnumerate: 1
```

The JSON string contains an array with a single element. Without the switch, converting the JSON to
a PSObject and then converting it back with the `ConvertTo-Json` command results in a single
integer.

## PARAMETERS

### -AsHashtable

Converts the JSON to a hash table object. This switch was introduced in PowerShell 6.0. There are
several scenarios where it can overcome some limitations of the `ConvertFrom-Json` cmdlet.

- If the JSON contains a list with keys that only differ in casing. Without the switch, those keys
  would be seen as identical keys and therefore only the last one would get used.
- If the JSON contains a key that is an empty string. Without the switch, the cmdlet would throw an
  error since a `PSCustomObject` does not allow for that but a hash table does. An example use case
  where this can occurs are `project.lock.json` files.
- Hash tables can be processed faster for certain data structures.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

Gets or sets the maximum depth the JSON input is allowed to have. By default, it is 1024.

This parameter was introduced in PowerShell 6.2.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -NoEnumerate

Specifies that output is not enumerated.

Setting this parameter causes arrays to be sent as a single object instead of sending every element
separately. This guarantees that JSON can be round-tripped via `ConvertTo-Json`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

You can pipe a JSON string to `ConvertFrom-Json`.

## OUTPUTS

### PSCustomObject

### System.Collections.Hashtable

## NOTES

This cmdlet is implemented using [Newtonsoft Json.NET](https://www.newtonsoft.com/json).

Beginning in PowerShell 6, `ConvertTo-Json` attempts to convert strings formatted as timestamps to
**DateTime** values. The converted value is a `[datetime]` instance with a `Kind` property set as
follows:

- `Unspecified`, if there is no time zone information in the input string.
- `Utc`, if the time zone information is a trailing `Z`.
- `Local`, if the time zone information is given as a trailing UTC _offset_ like `+02:00`. The
  offset is properly converted to the caller's configured time zone. The default output formatting
  does not indicate the original time zone offset.

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)
