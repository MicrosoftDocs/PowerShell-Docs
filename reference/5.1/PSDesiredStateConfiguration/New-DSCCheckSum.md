---
external help file: PSDesiredStateConfiguration-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDesiredStateConfiguration
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821459
schema: 2.0.0
title: New-DscChecksum
---

# New-DscChecksum

## SYNOPSIS
Creates checksum files for DSC documents and DSC resources.

## SYNTAX

```
New-DscChecksum [-Path] <String[]> [[-OutPath] <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **New-DSCCheckSum** cmdlet generates checksum files for Windows PowerShell Desired State Configuration (DSC) documents and compressed DSC resources.
This cmdlet generates a checksum file for each configuration and resource to be used in pull mode.
The DSC service uses the checksums to make sure that the correct configuration and resources exist on the target node.
Place the checksums together with the associated DSC documents and compressed DSC resources in the DSC service store.

## EXAMPLES

### Example 1: Create checksum files for all configurations in a specific path
```
PS C:\> New-DscCheckSum -Path "C:\DSC\Configurations\"
```

This command creates checksum files for all configurations in the path C:\DSC\Configurations.
Any checksum files that already exist are skipped.

### Example 2: Create checksum files for all configurations in a specific path and overwrite the existing checksum files
```
PS C:\> New-DscCheckSum -Path "C:\DSC\Configurations\" -Force
```

This command creates new checksum files for all configurations in the path C:\DSC\Configurations.
Specifying the *Force* parameter causes the command to overwrite any checksum files that already exist.

## PARAMETERS

### -Force
Indicates that the cmdlet overwrites the specified output file if it already exists.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutPath
Specifies the path and file name of the output checksum file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path of the input file.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ConfigurationPath

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](http://go.microsoft.com/fwlink/?LinkID=311940)