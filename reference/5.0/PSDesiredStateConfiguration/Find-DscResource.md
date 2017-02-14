---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Find DscResource
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821454
external help file:   PSDesiredStateConfiguration-help.xml
---


# Find-DscResource

## SYNOPSIS
Finds DSC resources that match the specified criteria.

## SYNTAX

```
Find-DscResource [[-Name] <String[]>] [-moduleName <String>] [-MinimumVersion <Version>]
 [-RequiredVersion <Version>] [-AllVersions] [-Tag <String[]>] [-Filter <String>] [-Repository <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Find-DscResource** cmdlet finds Windows PowerShell Desired State Configuration (DSC) resources, contained in modules, that match the specified criteria from registered repositories.
For each module that this cmdlet finds, **Find-DscResource** returns a **PSGetDscResourceInfo** object which can be piped to Install-Module to install the modules containing the resources that this cmdlet returns.

## EXAMPLES

### Example 1: Find all DSC resources
```
PS C:\> Find-DscResource
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xJeaEndPoint                        0.2.16.6   xJea                                PSGallery
xJeaToolKit                         0.2.16.6   xJea                                PSGallery
xIisFeatureDelegation               1.7.0.0    xWebAdministration                  PSGallery
xIisHandler                         1.7.0.0    xWebAdministration                  PSGallery
xIisMimeTypeMapping                 1.7.0.0    xWebAdministration                  PSGallery
xIisModule                          1.7.0.0    xWebAdministration                  PSGallery
```

This command runs **Find-DscResource** without any parameters to return all DSC resources from all registered galleries.

### Example 2: Find DSC modules containing resources with a specified name
```
PS C:\> Find-DscResource -Name "Website01"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Website01                           1.7.0.0    xWebAdministration                  PSGallery
```

This command searches for all modules with the name Website01.
When searching for a specific DSC resource, the name field can be used to find only modules that contain DSC resources with that name.

### Example 3: Install a DSC resource after finding it
```
PS C:\> Find-DscResource -Name "Website01" | Install-Module
```

This commands installs a DSC Resource, together with its module, by piping the output of **Find-DscResource** to **Install-Module**. 
When piping multiple resources from the same module, **Install-Module** only attempts to install the module one time.

### Example 4: Discover all DSC resources in a module
```
PS C:\> Find-DscResource -ModuleName xWebAdministration
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xIisFeatureDelegation               1.7.0.0    WebAdministration                   PSGallery 
xIisHandler                         1.7.0.0    WebAdministration                   PSGallery
xIisMimeTypeMapping                 1.7.0.0    WebAdministration                   PSGallery
xIisModule                          1.7.0.0    WebAdministration                   PSGallery
xWebApplication                     1.7.0.0    WebAdministration                   PSGallery
xWebAppPool                         1.7.0.0    WebAdministration                   PSGallery
xWebAppPoolDefaults                 1.7.0.0    WebAdministration                   PSGallery
xWebConfigKeyValue                  1.7.0.0    WebAdministration                   PSGallery
xWebsite                            1.7.0.0    WebAdministration                   PSGallery
xWebSiteDefaults                    1.7.0.0    WebAdministration                   PSGallery
xWebVirtualDirectory                1.7.0.0    WebAdministration                   PSGallery
```

This command finds all the DSC resources contained in the WebAdministration module, by using the *ModuleName* parameter.

### Example 5: Search by tag or required version
```
PS C:\> Find-DscResource -Tag Credentials -RequiredVersion "1.5"
```

This command searches for a resource based on the tag and required version.
The metadata for tag, minimum version, and required version is shared between the parent module and the DSC resource.

### Example 6: Search by using a filter
```
PS C:\> Find-DscResource -Filter 'Domain'
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xComputer                           1.3.0      xComputerManagement                 PSGallery
xDisk                               1.0        xDisk                               PSGallery
xWaitForDisk                        1.0        xDisk                               PSGallery
```

This command searches for a resource using the *Filter* parameter.
In the case of NuGet-based repositories, this command searches through the name, description, and tags for the search terms specified by *Filter*.

## PARAMETERS

### -AllVersions
Indicates that this cmdlet returns all the module versions that meet the specified criteria.

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

### -Filter
Specifies the filter that is used to search using the specific search language of the provider.
In the case of NuGet repositories, this is the equivalent of searching using the search box on the Gallery webpage.
This includes searches through name, tags, and description.

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

### -MinimumVersion
Specifies the minimum version of the module to be searched in the repository.
The default value is no minimum, which means that all versions are searched.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies an array of the names of the DSC resources to find.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository
Specifies an array of the **PSRepository** names that this cmdlet searches for DSC resources.

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

### -RequiredVersion
Specifies the exact version of the module to be searched.
Because the module version matches the DSC resource version, this equates to the version of the target DSC resource.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Specifies an array of tags that are searched in the repository to find modules.

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

### -moduleName
Specifies the name of the module that should be searched in the repository to find DSC resources.
If this parameter is not specified, this cmdlet searches all modules.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Microsoft.PowerShell.Commands.PSGetDscResourceInfo
This cmdlet returns an object that encapsulates the resource name, module name, repository name and **PSGetModuleInfo** object if the resource module is found.

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](http://go.microsoft.com/fwlink/?LinkID=311940)

[Get-DscResource](Get-DscResource.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[Invoke-DscResource](Invoke-DscResource.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)

