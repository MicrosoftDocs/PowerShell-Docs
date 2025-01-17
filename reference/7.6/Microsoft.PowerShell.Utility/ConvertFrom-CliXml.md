---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/19/2024
online version: https://go.microsoft.com/fwlink/?LinkID=2280770
schema: 2.0.0
title: ConvertFrom-CliXml
---

# ConvertFrom-CliXml

## SYNOPSIS
Converts a CliXml-formatted string to a custom **PSObject**.

## SYNTAX

```
ConvertFrom-CliXml [-InputObject] <String> [<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-CliXml` cmdlet converts strings that are formatted as Common Language
Infrastructure (CLI) XML to a custom **PSObject**. This command is similar to `Import-Clixml`, but
it doesn't read from a file. Instead, it takes a string as input.

The newly deserialized objects aren't live objects. They're a snapshot of the objects at the time of
serialization. The deserialized objects include properties but no methods. The **PSTypeNames**
property contains the original type name prefixed with `Deserialized`.

This cmdlet was introduced in PowerShell 7.5-preview.4.

## EXAMPLES

### Example 1 - Convert a process object to CliXml and back

This example shows the result of converting a process object to CliXml and back. First, the current
process is stored in the variable `$process`. The **PSTypeNames** property of the process object
shows that the object is of type **System.Diagnostics.Process**. The next command displays the count
for each type of member in the process object.

```powershell
$process = Get-Process -Id $PID
$process.PSTypeNames
```

```Output
System.Diagnostics.Process
System.ComponentModel.Component
System.MarshalByRefObject
System.Object
```

```powershell
$process | Get-Member | Group-Object MemberType | Select-Object Name, Count
```

```Output
Name           Count
----           -----
AliasProperty      7
CodeProperty       1
Property          52
NoteProperty       1
ScriptProperty     8
PropertySet        2
Method            19
Event              4
```

```powershell
$xml = $process | ConvertTo-CliXml
$fromXML = ConvertFrom-CliXml $xml
$fromXML.PSTypeNames
```

```Output
Deserialized.System.Diagnostics.Process
Deserialized.System.ComponentModel.Component
Deserialized.System.MarshalByRefObject
Deserialized.System.Object
```

```powershell
$fromXML | Get-Member | Group-Object MemberType | Select-Object Name, Count
```

```Output
Name         Count
----         -----
Property        46
NoteProperty    17
PropertySet      2
Method           2
```

Next, the process object is converted to CliXml and back. The type of the new object is prefixed
with `Deserialized`. The count of members in the new object is different from the original object.

## PARAMETERS

### -InputObject

The object containing a CliXml-formatted string to be converted.

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
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[ConvertTo-CliXml](ConvertTo-CliXml.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[Export-Clixml](Export-Clixml.md)

[Import-Clixml](Import-Clixml.md)
