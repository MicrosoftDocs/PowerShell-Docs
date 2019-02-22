---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821836
external help file:  Microsoft.PowerShell.Utility-help.xml
title:  New-TemporaryFile
---
# New-TemporaryFile

## SYNOPSIS
Creates a temporary file.

## SYNTAX

```
New-TemporaryFile [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **New-TemporaryFile** cmdlet creates an empty file that has the .tmp file name extension.
This cmdlet names the file `tmp`NNNN`.tmp`, where NNNN is a random hexadecimal number.
The cmdlet creates the file in your $Env:Temp folder.

This cmdlet creates temporary files that you can use in scripts.

## EXAMPLES

### Example 1: Create a temporary file

```
PS C:\> $TempFile = New-TemporaryFile
```

This command generates a .tmp file in your temporary folder, and then stores a reference to the file in the $TempFile variable.
You can use this file later in your script.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo

This cmdlet returns a **FileInfo** object that represents the temporary file.

## NOTES

## RELATED LINKS

[about_Environment_Variables](../Microsoft.PowerShell.Core/About/about_Environment_Variables.md)