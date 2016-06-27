---
external help file: PSGet.psm1-help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=398574
schema: 2.0.0
---

# Find-Module
## SYNOPSIS
Finds modules from an online gallery that match specified criteria.

## SYNTAX

```
Find-Module [[-Name] <String[]>] [-MinimumVersion <Version>] [-MaximumVersion <Version>]
 [-RequiredVersion <Version>] [-AllVersions] [-IncludeDependencies] [-Filter <String>] [-Tag <String[]>]
 [-Includes <String[]>] [-DscResource <String[]>] [-Command <String[]>] [-Repository <String[]>]
```

## DESCRIPTION
The Find-Module cmdlet finds modules from the online gallery that match specified criteria.
For each module found, Find-Module returns a PSGetItemInfo object, which optionally can be piped to Install-Module to install the resulting modules.

If the RequiredVersion parameter is not specified, Find-Module returns the latest version of the module that is equal to or greater than the minimum version specified, or the newest version of the module if no minimum version is specified.
If the RequiredVersion parameter is specified, Find-Module only returns the version of the module that exactly matches the specified version.
Find-Module searches through all available modules, because name conflicts between sources can occur.

## EXAMPLES

### Example 1: Find a module by name
```
PS C:\>Find-Module -Name "ContosoServer"
Version       DateUpdated        Name          Description
-------       -----------        ----          -----------
2.0.0.0       5/8/2014 10:30 AM  ContosoServer Cmdlets and DSC resources for managing Contoso Server products.
```

This command returns a PSGetItemInfo object that represents the ContosoServer module from the online gallery.

### Example 2: Find similarly named modules
```
PS C:\>Find-Module -Name "Contoso*"
```

This example returns two PSGetItemInfo objects that represent the ContosoServer and ContosoClient modules from the online gallery.

### Example 3: Find a module by minimum version
```
PS C:\>Find-Module -Name ContosoClient -MinimumVersion 3.0.0.0
```

This example returns a PSGetItemInfo object that represents the newest version of the ContosoClient module that has a minimum version of at least 3.0.0.0.
For example, if there is a version 4.0.0.0 ContosoClient module, that is included in the results of this command.

### Example 4: Find a module by specific version
```
PS C:\>Find-Module -Name "ContosoClient" -RequiredVersion 4.5.6.7
```

This example returns a PSGetItemInfo object that represents version 4.5.6.7 of the ContosoClient module.
If the specified version 4.5.6.7 isn't found, an error is returned.

### Example 5: Find a module in a specific repository
```
PS C:\>Find-Module -Name "Contoso" -Repository "myNuGetRepo"
```

This command returns a PSGetItemInfo object that represents the Contoso module from the myNuGetRepo module source.
If the myNuGetRepo source wasn't registered using the Register-PSRepository cmdlet, an error is returned.

### Example 6: Find a module in multiple repositories
```
PS C:\>Register-PSRepository -Name "MySource" -SourceLocation "https://www.myget.org/F/powershellgetdemo/"
PS C:\> Find-Module -Name "Contoso" -Repository "PSGallery","MySource"
Repository    Version   Name                 Description
----------    -------   ----                 -----------
PSGallery     2.0.0.0   ContosoServer        Cmdlets and DSC resources for managing Contoso Server products. 
MySource      1.2.0.0   ContosoClient        Cmdlets and DSC resources for managing Contoso Client products.
```

This command returns PSGetItemInfo objects that represent modules named Contoso found in the PSGallery and the NuGet repository located at https://www.myget.org/F/powershellgetdemo/.

### Example 7: Find a module that contains a DSC resource
```
PS C:\>Find-Module -Includes "DscResource"
```

This command returns PSGetItemInfo objects that represent modules that contain DSC resources.

### Example 8: Find a module using a filter
```
PS C:\>Find-Module -Filter "App Domain" -Includes "DscResource"
Repository                Version      Name                                     Description                                                 
----------                -------      ----                                     -----------                                                 
PSGallery                 1.0.0.0      AppDomainConfig                          Manipulate AppDomain configuration...
```

This command returns PSGetItemInfo objects that represent modules that contain DSC resources and that match the filter App Domain.
Because this example is operating against a NuGet-based repository, the Filter parameter searches through the name, description, and tags for the argument.

## PARAMETERS

### -AllVersions
Specifies that you want to include all available versions of a module in results.
The AllVersions parameter cannot be used with the MinimumVersion, MaximumVersion, or RequiredVersion parameters.

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

### -Command
@{Text=}

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

### -DscResource
Specifies the name (or part of the name) of modules that contain DSC resources.
Per Windows PowerShell conventions, performs an "OR" search when you provide multiple arguments.

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

### -Filter
Finds modules based on the PackageManagement provider-specific search syntax.
For NuGet modules, this is the equivalent of searching by using the Search bar on the PowerShell Gallery website.

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

### -IncludeDependencies
Add this parameter to include all modules that are dependent upon the module specified in the Name parameter.

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

### -Includes
Returns only those modules that include specific kinds of Windows PowerShell functionality.
For example, you might only want to find modules that include DSCResource.
Valid values are: DscResource, Cmdlet, or Function.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: DscResource, Cmdlet, Function, RoleCapability

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum, or newest version of the module to include in results.
The MaximumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies the minimum version of the module to include in results.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the names of one or more modules to discover.
This parameter supports wildcard characters.
If wildcard characters are not specified, only modules that exactly match the specified names are returned.
If no matches are found, and you have not used any wildcard characters, the command returns an error.
If you use wildcard characters, but do not find matching results, no error is returned.
(This follows standard wildcard character matching behavior for Windows PowerShell.)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Repository
The friendly name of a repository that has been registered by running Register-PSRepository.

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tag
Finds modules that have a specified tag.
Example tags include DesiredStateConfiguration, DSC, DSCResourceKit, or PSModule.

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

## INPUTS

## OUTPUTS

### PSGetItemInfo

## NOTES
This cmdlet runs on Windows PowerShell 3.0 or later releases of Windows PowerShell, on Windows 7 or Windows 2008 R2 and later releases of Windows.

## RELATED LINKS

[Install-Module]()

[Save-Module]()

[Uninstall-Module]()

[Update-Module]()

