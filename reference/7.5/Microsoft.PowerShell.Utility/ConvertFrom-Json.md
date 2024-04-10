---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/29/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-Json
---

# ConvertFrom-Json

## SYNOPSIS
Converts a JSON-formatted string to a custom object or a hash table.

## SYNTAX

```
ConvertFrom-Json [-InputObject] <String> [-AsHashtable] [-DateKind <JsonDateKind>] [-Depth <Int32>]
 [-NoEnumerate] [<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-Json` cmdlet converts a JavaScript Object Notation (JSON) formatted string to a
custom **PSObject** or **Hashtable** object that has a property for each field in the JSON string.
JSON is commonly used by web sites to provide a textual representation of objects. The cmdlet adds
the properties to the new object as it processes each line of the JSON string.

The JSON standard allows duplicate key names, which are prohibited in **PSObject** and **Hashtable**
types. For example, if the JSON string contains duplicate keys, only the last key is used by this
cmdlet. See other examples below.

To generate a JSON string from any object, use the `ConvertTo-Json` cmdlet.

This cmdlet was introduced in PowerShell 3.0.

> [!NOTE]
> Beginning with PowerShell 6, the cmdlet supports JSON with comments. JSON comments start with two
> forward slashes (`//`) characters. JSON comments aren't captured in the objects output by the
> cmdlet. Prior to PowerShell 6, `ConvertFrom-Json` would return an error when it encountered a JSON
> comment.

## EXAMPLES

### Example 1: Convert a DateTime object to a JSON object

This command uses the `ConvertTo-Json` and `ConvertFrom-Json` cmdlets to convert a **DateTime**
object from the `Get-Date` cmdlet to a JSON object then to a **PSCustomObject**.

```powershell
Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json
```

```Output
DisplayHint : 2
DateTime    : Monday, January 29, 2024 3:10:26 PM
Date        : 1/29/2024 12:00:00 AM
Day         : 29
DayOfWeek   : 1
DayOfYear   : 29
Hour        : 15
Kind        : 2
Millisecond : 931
Microsecond : 47
Nanosecond  : 600
Minute      : 10
Month       : 1
Second      : 26
Ticks       : 638421378269310476
TimeOfDay   : @{Ticks=546269310476; Days=0; Hours=15; Milliseconds=931; Microseconds=47;
              Nanoseconds=600; Minutes=10; Seconds=26; TotalDays=0.632256146384259;
              TotalHours=15.1741475132222; TotalMilliseconds=54626931.0476;
              TotalMicroseconds=54626931047.6; TotalNanoseconds=54626931047600;
              TotalMinutes=910.448850793333; TotalSeconds=54626.9310476}
Year        : 2024
```

The example uses the `Select-Object` cmdlet to get all of the properties of the **DateTime** object.
It uses the `ConvertTo-Json` cmdlet to convert the **DateTime** object to a string formatted as a
JSON object and the `ConvertFrom-Json` cmdlet to convert the JSON-formatted string to a
**PSCustomObject** object.

### Example 2: Get JSON strings from a web service and convert them to PowerShell objects

This command uses the `Invoke-WebRequest` cmdlet to get JSON strings from a web service and then it
uses the `ConvertFrom-Json` cmdlet to convert JSON content to objects that can be managed in
PowerShell.

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
Get-Content -Raw JsonFile.JSON | ConvertFrom-Json
```

The command uses Get-Content cmdlet to get the strings in a JSON file. The **Raw** parameter returns
the whole file as a single JSON object. Then it uses the pipeline operator to send the delimited
string to the `ConvertFrom-Json` cmdlet, which converts it to a custom object.

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

Converts the JSON to a hash table object. This switch was introduced in PowerShell 6.0. Starting
with PowerShell 7.3, the object is an **OrderedHashtable** and preserves the ordering of the keys
from the JSON. In prior versions, the object is a **Hashtable**.

There are several scenarios where it can overcome some limitations of the `ConvertFrom-Json` cmdlet.

- Without this switch, when two or more keys in a JSON object are case-insensitively identical, they
  are treated as identical keys. In that case, only the last of those case-insensitively identical
  keys is included in the converted object.
- Without this switch, the cmdlet throws an error whenever the JSON contains a key that's an empty
  string. **PSCustomObject** can't have property names that are empty strings. For example, this can
  occur in `project.lock.json` files.
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

### -DateKind

Specifies the method used when parsing date time values in the JSON string. The acceptable values
for this parameter are:

- `Default`
- `Local`
- `Utc`
- `Offset`
- `String`

For information about how these values affect conversion, see the details in the [NOTES](#notes).

This parameter was introduced in PowerShell 7.5.

```yaml
Type: Microsoft.PowerShell.Commands.JsonDateKind
Parameter Sets: (All)
Aliases:
Accepted values: Default, Local, Utc, Offset, String

Required: False
Position: Named
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

Gets or sets the maximum depth the JSON input is allowed to have. The default is 1024.

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
object is an empty string, `ConvertFrom-Json` doesn't generate any output. The **InputObject**
value can't be `$null`.

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

Specifies that output isn't enumerated.

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

### System.Management.Automation.OrderedHashtable

## NOTES

This cmdlet is implemented using [Newtonsoft Json.NET](https://www.newtonsoft.com/json).

Beginning in PowerShell 6, `ConvertTo-Json` attempts to convert strings formatted as timestamps to
**DateTime** values.

PowerShell 7.5 added the **DateKind** parameter, which allows you to control how timestamp string
are converted. The parameter accepts the following values:

- `Default` - Converts the timestamp to a `[datetime]` instance according to the following rules:
  - If there is no time zone information in the input string, the Json.NET serializer converts the
    value as an unspecified time value.
  - If the time zone information is a trailing `Z`, the Json.NET serializer converts the timestamp
    to a _UTC_ value.
  - If the timestamp includes a UTC offset like `+02:00`, the offset is converted to the caller's
    configured time zone. The default output formatting doesn't indicate the original time zone
    offset.
- `Local` - Converts the timestamp to a `[datetime]` instance in the _local_ time. If the timestamp
  includes a UTC offset, the offset is converted to the caller's configured time zone. The default
  output formatting doesn't indicate the original time zone offset.
- `Utc` - Converts the value to a `[datetime]` instance in UTC time.
- `Offset` - Converts the timestamp to a `[DateTimeOffset]` instance with the timezone offset of the
  original string preserved in that instance. If the raw string did not contain a timezone offset,
  the **DateTimeOffset** value will be specified in the local timezone.
- `String` - Preserves the value the `[string]` instance. This ensures that any custom parsing logic
  can be applied to the raw string value.

The **PSObject** type maintains the order of the properties as presented in the JSON string.
Beginning with PowerShell 7.3, The **AsHashtable** parameter creates an **OrderedHashtable**. The
key-value pairs are added in the order presented in the JSON string. The **OrderedHashtable**
preserves that order.

## RELATED LINKS

[An Introduction to JavaScript Object Notation (JSON) in JavaScript and .NET](/previous-versions/dotnet/articles/bb299886(v=msdn.10))

[ConvertTo-Json](ConvertTo-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

[Invoke-RestMethod](Invoke-RestMethod.md)

[DateTime](xref:System.DateTime)

[DateTimeOffset](xref:System.DateTimeOffset)
