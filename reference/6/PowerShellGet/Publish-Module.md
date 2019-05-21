---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821666
schema: 2.0.0
title: Publish-Module
---
# Publish-Module

## SYNOPSIS
Publishes a specified module from the local computer to an online gallery.

## SYNTAX

### ModuleNameParameterSet (Default)

```
Publish-Module -Name <String> [-RequiredVersion <String>] [-NuGetApiKey <String>] [-Repository <String>]
 [-Credential <PSCredential>] [-FormatVersion <Version>] [-ReleaseNotes <String[]>] [-Tags <String[]>]
 [-LicenseUri <Uri>] [-IconUri <Uri>] [-ProjectUri <Uri>] [-Force] [-AllowPrerelease] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ModulePathParameterSet

```
Publish-Module -Path <String> [-NuGetApiKey <String>] [-Repository <String>] [-Credential <PSCredential>]
 [-FormatVersion <Version>] [-ReleaseNotes <String[]>] [-Tags <String[]>] [-LicenseUri <Uri>] [-IconUri <Uri>]
 [-ProjectUri <Uri>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Publish-Module` cmdlet publishes a module to an online NuGet-based gallery by using an API key, stored as part of a user's profile in the gallery.
You can specify the module to publish either by the module's name, or by the path to the folder containing the module.

When you specify a module by name, `Publish-Module` publishes the first module that would be found by running `Get-Module -ListAvailable <Name>`.
If you specify a minimum version of a module to publish, `Publish-Module` publishes the first module with a version that is greater than or equal to the minimum version that you have specified.

Publishing a module requires metadata that is displayed on the gallery page for the module.
Required metadata includes the module name, version, description, and author.
Although most metadata is taken from the module manifest, some metadata must be specified in `Publish-Module` parameters, such as **Tag**, **ReleaseNote**, **IconUri**, **ProjectUri**, and **LicenseUri**, because these parameters match fields in a NuGet-based gallery.

## EXAMPLES

### Example 1: Publish a module

```powershell
Publish-Module -Name "MyDscModule" -NuGetApiKey "11e4b435-6cb4-4bf7-8611-5162ed75eb73"
```

In this example, MyDscModule is published to the online gallery by using the API key to indicate the module owner's online gallery account.
If MyDscModule is not a valid manifest module that specifies a name, version, description, and author, an error occurs.

### Example 2: Publish a module with gallery metadata

```powershell
Publish-Module -Name "MyDscModule" -NuGetApiKey "11e4b435-6cb4-4bf7-8611-5162ed75eb73" -LicenseUri "http://contoso.com/license" -Tag "Active Directory","DSC" -ReleaseNote "Updated the ActiveDirectory DSC Resources to support adding users."
```

In this example, MyDscModule is published to the online gallery by using the API key to indicate the module owner's gallery account.
The additional metadata provided is displayed on the webpage for the module in the gallery.
The owner adds two search tags for the module, relating it to Active Directory; a brief release note is also added.
If MyDscModule is not a valid manifest module that specifies a name, version, description, and author, an error occurs.

## PARAMETERS

### -AllowPrerelease

Allows modules marked as prerelease to be published.

```yaml
Type: SwitchParameter
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

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

### -FormatVersion

```yaml
Type: Version
Parameter Sets: (All)
Aliases:
Accepted values: 2.0

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconUri

Specifies the URL of an icon for the module.
The specified icon is displayed on the gallery webpage for the module.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenseUri

Specifies the URL of licensing terms for the module you want to publish.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the module that you want to publish.
`Publish-Module` searches for the specified module name in $Env:PSModulePath.

```yaml
Type: String
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NuGetApiKey

Specifies the API key that you want to use to publish a module to the online gallery.
The API key is part of your profile in the online gallery, and can be found on your user account page in the gallery.
The API key is NuGet-specific functionality.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the module that you want to publish.
This parameter accepts the path to the folder that contains the module.

```yaml
Type: String
Parameter Sets: ModulePathParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProjectUri

Specifies the URL of a webpage about this project.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseNotes

Specifies a string containing release notes or comments that you want to be available to users of this version of the module.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository

Specifies the friendly name of a repository that has been registered by running `Register-PSRepository`.
The repository must have a PublishLocation, which is a valid NuGet URI.
The PublishLocation can be set by running `Set-PSRepository`.
The default value of this parameter is PSGallery.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version of a single module to publish.

```yaml
Type: String
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Adds one or more tags to the module that you are publishing.
Example tags include DesiredStateConfiguration, DSC, DSCResourceKit, or PSModule.
Separate multiple tags with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

### PSModuleInfo

## OUTPUTS

## NOTES

* This cmdlet runs on Windows PowerShell 3.0 or later releases of PowerShell, on Windows 7 or Windows 2008 R2 and later releases of Windows.

  `Publish-Module` shows no output if a module is published successfully.

## RELATED LINKS

[Find-Module](Find-Module.md)

[Install-Module](Install-Module.md)

[Uninstall-Module](Uninstall-Module.md)

[Update-Module](Update-Module.md)