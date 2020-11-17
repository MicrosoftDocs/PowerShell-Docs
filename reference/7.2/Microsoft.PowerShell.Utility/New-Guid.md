---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-guid?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Guid
---
# New-Guid

## SYNOPSIS
Creates a GUID.

## SYNTAX

```
New-Guid [<CommonParameters>]
```

## DESCRIPTION

The **New-Guid** cmdlet creates a random globally unique identifier (GUID).
If you need a unique ID in a script, you can create a GUID, as needed.

## EXAMPLES

### Example 1: Create a GUID

```
PS C:\> New-Guid
Guid
----
0352cf0f-2e7a-4aee-801d-7f27f8344c77
```

This command creates a random GUID.
Alternatively, you could store the output of this cmdlet in a variable to use elsewhere in a script.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Guid

This cmdlet returns a GUID.

## NOTES

## RELATED LINKS

