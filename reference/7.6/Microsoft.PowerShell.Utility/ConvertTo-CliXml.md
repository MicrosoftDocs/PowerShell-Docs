---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/19/2024
online version: https://go.microsoft.com/fwlink/?LinkID=2280866
schema: 2.0.0
title: ConvertTo-CliXml
---

# ConvertTo-CliXml

## SYNOPSIS
Converts an object to a CliXml-formatted string.

## SYNTAX

```
ConvertTo-CliXml [-InputObject] <PSObject> [-Depth <Int32>] [<CommonParameters>]
```

## DESCRIPTION

The `ConvertTo-CliXml` cmdlet converts objects to strings that are formatted as Common Language
Infrastructure (CLI) XML. This command is similar to `Export-Clixml`, but it doesn't write to a
file. Instead, it outputs a string.

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

### -Depth

Specifies how many levels of contained objects are included in the XML representation. The default
values is 2.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

The object to be converted to a CliXml-formatted string.

```yaml
Type: System.Management.Automation.PSObject
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

### System.Management.Automation.PSObject

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[ConvertFrom-CliXml](ConvertFrom-CliXml.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[Export-Clixml](Export-Clixml.md)

[Import-Clixml](Import-Clixml.md)
