---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/24/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/new-guid?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Guid
---
# New-Guid

## SYNOPSIS
Creates a GUID.

## SYNTAX

### Default (Default)

```
New-Guid [<CommonParameters>]
```

### Empty

```
New-Guid [-Empty] [<CommonParameters>]
```

### InputObject

```
New-Guid [-InputObject <String>] [<CommonParameters>]
```

## DESCRIPTION

The `New-Guid` cmdlet creates a random globally unique identifier (GUID). If you need a unique ID in
a script, you can create a GUID, as needed.

## EXAMPLES

### Example 1: Create a new GUID

```powershell
New-Guid
```

This command creates a random GUID. Alternatively, you could store the output of this cmdlet in a
variable to use elsewhere in a script.

### Example 2: Create an empty GUID

```powershell
New-Guid -Empty
```

```Output
Guid
----
00000000-0000-0000-0000-000000000000
```

### Example 3: Create a GUID from a string

This example converts a string that contains a GUID to a GUID object.

```powershell
New-Guid -InputObject "d61bbeca-0186-48fa-90e1-ff7aa5d33e2d"
```

```Output
Guid
----
d61bbeca-0186-48fa-90e1-ff7aa5d33e2d
```

### Example 4: Convert strings from the pipeline to GUIDs

This examples converts strings from the pipeline to GUID objects.

```powershell
$guidStrings = (
'11c43ee8-b9d3-4e51-b73f-bd9dda66e29c',
'0f8fad5bd9cb469fa16570867728950e',
'{0x01234567, 0x89ab, 0xcdef,{0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef}}'
)
$guidStrings | New-Guid
```

```Output
Guid
----
11c43ee8-b9d3-4e51-b73f-bd9dda66e29c
0f8fad5b-d9cb-469f-a165-70867728950e
01234567-89ab-cdef-0123-456789abcdef
```

## PARAMETERS

### -Empty

Indicates that this cmdlet creates an empty GUID. An empty GUID has all zeros in its string.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Empty
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

This parameter accepts a string representing a GUID and converts it to a GUID object.

```yaml
Type: System.String
Parameter Sets: InputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

## OUTPUTS

### System.Guid

This cmdlet returns a GUID.

## NOTES

The cmdlet passes string input to the constructor of the **System.Guid** class. The constructor
support strings in several formats. For more information, see
[System.Guid(String)](/dotnet/api/system.guid.-ctor#system-guid-ctor(system-string)).

When used without string input or the **Empty** parameter, the cmdlet creates a Version 4
Universally Unique Identifier (UUID). For more information, see
[System.Guid.NewGuid](xref:System.Guid.NewGuid).

## RELATED LINKS
