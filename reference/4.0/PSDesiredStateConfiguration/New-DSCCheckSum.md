---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=327747
external help file:  PSDesiredStateConfiguration-help.xml
title:  New-DSCCheckSum
---

# New-DSCCheckSum

## SYNOPSIS
Creates checksum files for Desired State Configuration documents and Desired State Configuration resources.

## SYNTAX

```
New-DSCCheckSum [-ConfigurationPath] <String[]> [[-OutPath] <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-DSCCheckSum** cmdlet generates checksum files for Desired State Configuration documents and compressed Desired State Configuration resources.
The cmdlet generates a checksum file for each configuration and resource to be used in pull mode.
The Desired State Configuration service uses the checksums to ensure that the correct configuration and resources exist on the target node.
Place the checksums along with the associated Desired State Configuration documents and compressed Desired State Configuration resources in the Desired State Configuration service store.

## EXAMPLES

### Example 1: Create checksum files for all configurations in a specific path
```
PS C:\> New-DscCheckSum -ConfigurationPath C:\DSC\Configurations\
```

This command creates checksum files for all configurations in the path C:\DSC\Configurations.
Any checksum files that already exist will be skipped.

### Example 2: Create checksum files for all configurations in a specific path and overwrite the existing checksum files
```
PS C:\> New-DscCheckSum -ConfigurationPath C:\DSC\Configurations\ -Force
```

This command creates new checksum files for all configurations in the path C:\DSC\Configurations.
Specifying the Force parameter causes the command to overwrite any checksum files that already exist.

## PARAMETERS

### -ConfigurationPath
Specifies an array of paths to the Desired State Configuration documents or resource archives.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Path

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
Position: 2
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
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
