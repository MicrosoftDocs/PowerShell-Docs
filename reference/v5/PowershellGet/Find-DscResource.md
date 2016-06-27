---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Find-DscResource
## SYNOPSIS
Finds a DSC resource.

## SYNTAX

```
Find-DscResource [[-Name] <String[]>] [-moduleName <String>] [-MinimumVersion <Version>]
 [-RequiredVersion <Version>] [-AllVersions] [-Tag <String[]>] [-Filter <String>] [-Repository <String[]>]
```

## DESCRIPTION
The Find-DscResource cmdlet finds Desired State Configuration (DSC) resources contained in modules that match the specified criteria from registered repositories.
For each module that this cmdlet finds, Find-DscResource returns a PSGetDscResourceInfo object that you can pipe to Install-Module to install the modules containing the resources that this cmdlet returns.

## EXAMPLES

### Example 1: Find all DSC resources
```
PS C:\>Find-DscResource
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xJeaEndPoint                        0.2.16.6   xJea                                PSGallery
xJeaToolKit                         0.2.16.6   xJea                                PSGallery
xIisFeatureDelegation               1.7.0.0    xWebAdministration                  PSGallery
xIisHandler                         1.7.0.0    xWebAdministration                  PSGallery
xIisMimeTypeMapping                 1.7.0.0    xWebAdministration                  PSGallery
xIisModule                          1.7.0.0    xWebAdministration                  PSGallery
```

This command returns all DSC resources from all registered galleries.

### Example 2: Find a DSC resource by name
```
PS C:\>Find-DscResource -Name "xWebsite"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xWebsite                            1.7.0.0    xWebAdministration                  PSGallery
```

This command finds the DSC resource named xWebsite.

### Example 3: Find a DSC resource and install it
```
PS C:\>Find-DscResource -Name "MyResource" | Install-Module
```

This command finds the resource named MyResource and passes it to the Install-Module cmdlet by using the pipeline operator.
The Install-Module cmdlet installs the module for the resource.

If you pipe multiple resources to the Install-Module cmdlet from the same module, Install-Module attempts to install the module only once.

### Example 4: Find all DSC resources in a module
```
PS C:\>Find-DscResource -ModuleName "xWebAdministration"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xIisFeatureDelegation               1.7.0.0    xWebAdministration                  PSGallery
xIisHandler                         1.7.0.0    xWebAdministration                  PSGallery
xIisMimeTypeMapping                 1.7.0.0    xWebAdministration                  PSGallery
xIisModule                          1.7.0.0    xWebAdministration                  PSGallery
xWebApplication                     1.7.0.0    xWebAdministration                  PSGallery
xWebAppPool                         1.7.0.0    xWebAdministration                  PSGallery
xWebAppPoolDefaults                 1.7.0.0    xWebAdministration                  PSGallery
xWebConfigKeyValue                  1.7.0.0    xWebAdministration                  PSGallery
xWebsite                            1.7.0.0    xWebAdministration                  PSGallery
xWebSiteDefaults                    1.7.0.0    xWebAdministration                  PSGallery
xWebVirtualDirectory                1.7.0.0    xWebAdministration                  PSGallery
```

This command finds all the DSC resources contained in a specified module by specifying the ModuleName parameter.

### Example 5: Find a DSC resource by tag and required version
```
PS C:\>Find-DscResource -Tag "Credentials" -RequiredVersion "1.5"
```

This command finds a resource by its tag and required version.

### Example 6: Find a resource by using a filter
```
PS C:\>Find-DscResource -Filter "Domain"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
xComputer                           1.3.0      xComputerManagement                 PSGallery
xDisk                               1.0        xDisk                               PSGallery
xWaitForDisk                        1.0        xDisk                               PSGallery
```

This command finds all resources and specifies the Filter parameter to filter the results.
In a NuGet repository, this command searches through the name, description, and tags for the search term.

## PARAMETERS

### -AllVersions
Specifies that you want to include all available versions of a module in results.
You cannot use the AllVersions parameter with the MinimumVersion, MaximumVersion, or RequiredVersion parameters.

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
Specifies the PackageManagement provider-specific search syntax to use to find modules.
For NuGet modules, this is the equivalent of searching by using the Search bar on the PowerShell Gallery (https://www.powershellgallery.com/) web site.

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
Specifies the minimum version of a single resource to find.
Do not specify this parameter if you are attempting to find multiple resources.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies an array of names of one or more DSC resources to discover.
This parameter supports wildcard characters.

If you do not specify wildcard characters, only resources that exactly match the specified names are returned.
If no matches are found, and you have not used any wildcard characters, the command returns an error.
If you use wildcard characters, but do not find matching results, no error is returned.
This follows standard wildcard character matching behavior for Windows PowerShell.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

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
Specifies the exact version number of the module to include in the results.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies an array of tags to find.
Example tags include DesiredStateConfiguration,  DSC,  DSCResourceKit, or PSModule.

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
Specifies the name of the module that contains the DSC resource to find.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

