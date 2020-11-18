---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 10/03/2019
online version: https://docs.microsoft.com/powershell/module/powershellget/publish-module?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Publish-Module
---

# Publish-Module

## SYNOPSIS
Publishes a specified module from the local computer to an online gallery.

## SYNTAX

### ModuleNameParameterSet (Default)

```
Publish-Module -Name <String> [-RequiredVersion <String>] [-NuGetApiKey <String>]
 [-Repository <String>] [-Credential <PSCredential>] [-FormatVersion <Version>]
 [-ReleaseNotes <String[]>] [-Tags <String[]>] [-LicenseUri <Uri>] [-IconUri <Uri>]
 [-ProjectUri <Uri>] [-Exclude <String[]>] [-Force] [-AllowPrerelease] [-SkipAutomaticTags]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ModulePathParameterSet

```
Publish-Module -Path <String> [-NuGetApiKey <String>] [-Repository <String>]
 [-Credential <PSCredential>] [-FormatVersion <Version>] [-ReleaseNotes <String[]>]
 [-Tags <String[]>] [-LicenseUri <Uri>] [-IconUri <Uri>] [-ProjectUri <Uri>] [-Force]
 [-SkipAutomaticTags] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Publish-Module` cmdlet publishes a module to an online NuGet-based gallery by using an API key,
stored as part of a user's profile in the gallery. You can specify the module to publish either by
the module's name, or by the path to the folder containing the module.

When you specify a module by name, `Publish-Module` publishes the first module that would be found
by running `Get-Module -ListAvailable <Name>`. If you specify a minimum version of a module to
publish, `Publish-Module` publishes the first module with a version that is greater than or equal to
the minimum version that you have specified.

Publishing a module requires metadata that is displayed on the gallery page for the module. Required
metadata includes the module name, version, description, and author. Although most metadata is taken
from the module manifest, some metadata must be specified in `Publish-Module` parameters, such as
**Tag**, **ReleaseNote**, **IconUri**, **ProjectUri**, and **LicenseUri**, because these parameters
match fields in a NuGet-based gallery.

## EXAMPLES

### Example 1: Publish a module

In this example, MyDscModule is published to the online gallery by using the API key to indicate the
module owner's online gallery account. If MyDscModule is not a valid manifest module that specifies
a name, version, description, and author, an error occurs.

```powershell
Publish-Module -Name "MyDscModule" -NuGetApiKey "11e4b435-6cb4-4bf7-8611-5162ed75eb73"
```

### Example 2: Publish a module with gallery metadata

In this example, MyDscModule is published to the online gallery by using the API key to indicate the
module owner's gallery account. The additional metadata provided is displayed on the webpage for the
module in the gallery. The owner adds two search tags for the module, relating it to Active
Directory; a brief release note is added. If MyDscModule is not a valid manifest module that
specifies a name, version, description, and author, an error occurs.

```powershell
Publish-Module -Name "MyDscModule" -NuGetApiKey "11e4b435-6cb4-4bf7-8611-5162ed75eb73" -LicenseUri "http://contoso.com/license" -Tag "Active Directory","DSC" -ReleaseNote "Updated the ActiveDirectory DSC Resources to support adding users."
```

## PARAMETERS

### -AllowPrerelease

Allows modules marked as prerelease to be published.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the `Publish-Module`.

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

### -Credential

Specifies a user account that has rights to publish a module for a specified package provider or
source.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude

Defines files to exclude from the published module.

```yaml
Type: System.String[]
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatVersion

Accepts only valid values specified by the **ValidateSet** attribute.

For more information, see [ValidateSet Attribute Declaration](/powershell/scripting/developer/cmdlet/validateset-attribute-declaration)
and [ValidateSetAttribute](/dotnet/api/system.management.automation.validatesetattribute).

```yaml
Type: System.Version
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

Specifies the URL of an icon for the module. The specified icon is displayed on the gallery webpage
for the module.

```yaml
Type: System.Uri
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
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the module that you want to publish. `Publish-Module` searches for the
specified module name in `$Env:PSModulePath`.

```yaml
Type: System.String
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NuGetApiKey

Specifies the API key that you want to use to publish a module to the online gallery. The API key is
part of your profile in the online gallery, and can be found on your user account page in the
gallery. The API key is NuGet-specific functionality.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the module that you want to publish. This parameter accepts the path to the
folder that contains the module.

```yaml
Type: System.String
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
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseNotes

Specifies a string containing release notes or comments that you want to be available to users of
this version of the module.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository

Specifies the friendly name of a repository that has been registered by running
`Register-PSRepository`. The repository must have a **PublishLocation**, which is a valid NuGet URI.
The **PublishLocation** can be set by running `Set-PSRepository`.

```yaml
Type: System.String
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
Type: System.String
Parameter Sets: ModuleNameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipAutomaticTags

Removes commands and resources from being included as tags. Skips automatically adding tags to a
module.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Adds one or more tags to the module that you are publishing. Example tags include
DesiredStateConfiguration, DSC, DSCResourceKit, or PSModule. Separate multiple tags with commas.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the `Publish-Module` runs. The cmdlet is not run.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Management.Automation.PSCredential

## OUTPUTS

### System.Object

## NOTES

`Publish-Module` runs on PowerShell 3.0 or later releases of PowerShell, on Windows 7 or Windows
2008 R2 and later releases of Windows.

> [!IMPORTANT]
> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS)
> versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when
> trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS
> 1.2:
>
> `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
>
> For more information, see the
> [announcement](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/) in the
> PowerShell blog.

Publishing a module requires metadata that is displayed on the gallery page for the module. Required
metadata includes the module name, version, description, and author. Most metadata is taken from the
module manifest, but some metadata can be specified in `Publish-Module` parameters, such as **Tag**,
**ReleaseNote**, **IconUri**, **ProjectUri**, and **LicenseUri**. For more information, see
[Package manifest values that impact the PowerShell Gallery UI](/powershell/scripting/gallery/concepts/package-manifest-affecting-ui).

## RELATED LINKS

[Find-Module](Find-Module.md)

[Install-Module](Install-Module.md)

[Register-PSRepository](Register-PSRepository.md)

[Set-PSRepository](Set-PSRepository.md)

[Uninstall-Module](Uninstall-Module.md)

[Update-Module](Update-Module.md)
