---
document type: cmdlet
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
HelpUri: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/new-temporarydirectory?view=powershell-7.7&WT.mc_id=ps-gethelp
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 09/01/2026
PlatyPS schema version: 2024-05-01
title: New-TemporaryDirectory
---

# New-TemporaryDirectory

## SYNOPSIS

Creates a new temporary directory.

## SYNTAX

### __AllParameterSets

```
New-TemporaryDirectory [-Prefix <string>] [-WhatIf] [-Confirm] [CommonParameters]
```

## ALIASES

## DESCRIPTION

This command creates a new temporary directory in the system's temporary folder and returns a
`DirectoryInfo` object representing the newly created directory. The name of the temporary directory
is generated using a unique identifier, and you can optionally specify a prefix for the directory
name.

## EXAMPLES

### Example 1 - Create a temporary directory with a prefix

```powershell
New-TemporaryDirectory -Prefix sdw
```

```Output
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----            9/1/2026  9:11 AM                sdwyckmvjd0.mkh
```

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet. The command uses low confirmation impact.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Prefix

Allows you to specify a prefix for the directory name, which can help in identifying the purpose of
the temporary directory.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.DirectoryInfo

## NOTES

## RELATED LINKS

- [New-TemporaryFile](New-TemporaryFile.md)
