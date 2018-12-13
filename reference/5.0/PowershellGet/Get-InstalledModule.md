---
ms.date:  06/09/2017
schema:  2.0.0
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821660
external help file:  PSGet-help.xml
title:  Get-InstalledModule
---

# Get-InstalledModule

## SYNOPSIS
Gets installed modules on a computer.

## SYNTAX

```
Get-InstalledModule [[-Name] <String[]>] [-MinimumVersion <Version>] [-RequiredVersion <Version>]
 [-MaximumVersion <Version>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-InstalledModule** cmdlet gets Windows PowerShell modules that are installed on a computer.

## EXAMPLES

### Example 1: Get all installed modules
```
PS C:\> Get-InstalledModule
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.0.0      PSGTEST-UploadMultipleVersionOfP... Module     GalleryINT           Module for DAC functionality
1.3.5      AzureAutomationDebug                Module     PSGallery            Module for debugging Azure Automation runbooks, emulating AA native cmdlets
1.0.1      AzureRM.Automation                  Module     PSGallery            Microsoft Azure PowerShell - Automation service cmdlets for Azure Resource Manager
```

This command gets all installed modules.

### Example 2: Get specific versions of a module
```
PS C:\> Get-InstalledModule -Name "AzureRM.Automation" -MinimumVersion 1.0 -MaximumVersion 2.0
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.0.1      AzureRM.Automation                  Module     PSGallery            Microsoft Azure PowerShell - Automation service cmdlets for Azure Resource Manager
```

This command gets versions of the AzureRM.Automation module from version 1.0 through version 2.0.

## PARAMETERS

### -MaximumVersion
Specifies the maximum, or newest, version of a module to get.
The *MaximumVersion* and *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of a single module to get.
The *MinimumVersion* and *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of modules to get.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version of a module to get.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Windows PowerShellGet Module](PowershellGet.md)