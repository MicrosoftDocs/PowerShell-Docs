---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 03/16/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-temporaryfile?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-TemporaryFile
---
# New-TemporaryFile

## SYNOPSIS
Creates a temporary file.

## SYNTAX

```
New-TemporaryFile [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet creates temporary files that you can use in scripts.

The `New-TemporaryFile` cmdlet creates an empty file that has the `.tmp` file name extension.
This cmdlet names the file `tmp<NNNN>.tmp`, where `<NNNN>` is a random hexadecimal number.
The cmdlet creates the file in your **TEMP** folder.

This cmdlet uses the [Path.GetTempPath()](/dotnet/api/system.io.path.gettemppath) method to find
your **TEMP** folder. This method checks for the existence of environment variables in the following
order and uses the first path found:

- On Windows platforms:

  1. The path specified by the TMP environment variable.
  1. The path specified by the TEMP environment variable.
  1. The path specified by the USERPROFILE environment variable.
  1. The Windows directory.

- On non-Windows platforms: Uses the path specified by the TMPDIR environment variable.

## EXAMPLES

### Example 1: Create a temporary file

```powershell
$TempFile = New-TemporaryFile
```

This command generates a `.tmp` file in your temporary folder, and then stores a reference to the file
in the `$TempFile` variable. You can use this file later in your script.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

## OUTPUTS

### System.IO.FileInfo

This cmdlet returns a **FileInfo** object that represents the temporary file.

## NOTES

## RELATED LINKS

