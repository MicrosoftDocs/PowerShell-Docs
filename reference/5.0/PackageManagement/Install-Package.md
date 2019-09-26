---
ms.date:  05/23/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=517138
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Install-Package
---

# Install-Package

## SYNOPSIS
Installs one or more software packages.

## SYNTAX

### PackageBySearch (Default)

```
Install-Package [[-Name] <string[]>] [-RequiredVersion <string>] [-MinimumVersion <string>]
 [-MaximumVersion <string>] [-Source <string[]>] [-Credential <pscredential>] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [-ProviderName <string[]>] [<CommonParameters>]
```

### PackageByInputObject

```
Install-Package [-InputObject] <SoftwareIdentity[]> [-Credential <pscredential>] [-Force]
 [-ForceBootstrap] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### msi:PackageBySearch

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <string[]>] [<CommonParameters>]
```

### msi:PackageByInputObject

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-AdditionalArguments <string[]>] [<CommonParameters>]
```

### Programs:PackageBySearch

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-IncludeWindowsInstaller] [-IncludeSystemComponent] [<CommonParameters>]
```

### Programs:PackageByInputObject

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-IncludeWindowsInstaller] [-IncludeSystemComponent] [<CommonParameters>]
```

### PSModule:PackageBySearch

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-PackageManagementProvider <string>] [-Scope <string>] [-PublishLocation <string>] [-AllVersions]
 [-Filter <string>] [-Tag <string[]>] [-Includes <string[]>] [-DscResource <string[]>]
 [-Command <string[]>] [-Location <string>] [-InstallUpdate] [-InstallationPolicy <string>]
 [-DestinationPath <string>] [<CommonParameters>]
```

### PSModule:PackageByInputObject

```
Install-Package [-Credential <pscredential>] [-Force] [-ForceBootstrap] [-WhatIf] [-Confirm]
 [-PackageManagementProvider <string>] [-Scope <string>] [-PublishLocation <string>] [-AllVersions]
 [-Filter <string>] [-Tag <string[]>] [-Includes <string[]>] [-DscResource <string[]>]
 [-Command <string[]>] [-Location <string>] [-InstallUpdate] [-InstallationPolicy <string>]
 [-DestinationPath <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Install-Package` cmdlet installs one or more software packages on the local computer. If you
have multiple software sources, use `Get-PackageProvider` and `Get-PackageSource` to display details
about your providers.

## EXAMPLES

### Example 1: Install a package by package name

The `Install-Package` cmdlet installs a software package and its dependencies.

```
PS> Install-Package -Name NuGet.Core -Source MyNuGet -Credential Contoso\TestUser
```

`Install-Package` uses parameters to specify the packages **Name** and **Source**. The
**Credential** parameter uses a domain user account with permissions to install packages. The
command prompts you for the user account password.

### Example 2: Use Find-Package to install a package

In this example, the object returned by `Find-Package` is sent down the pipeline and installed by
`Install-Package`.

```
PS> Find-Package -Name NuGet.Core -Source MyNuGet | Install-Package
```

`Find-Package` uses the **Name** and **Source** parameters to locate a package. The object is sent
down the pipeline and `Install-Package` installs the package on the local computer.

### Example 3: Install packages by specifying a range of versions

`Install-Package` uses the **MinimumVersion** and **MaximumVersion** parameters to specify a range
of software versions.

```
PS> Install-Package -Name NuGet.Core -Source MyNuGet -MinimumVersion 2.8.0 -MaximumVersion 2.9.0
```

`Install-Package` uses the **Name** and **Source** parameters to find a package. The
**MinimumVersion** and **MaximumVersion** parameters specify a range of software versions. The
highest version in the range is installed.

## PARAMETERS

### -AdditionalArguments

Specifies one or more additional arguments for installation.

```yaml
Type: String[]
Parameter Sets: msi:PackageBySearch, msi:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions

`Install-Package` installs all available versions of the package. By default, only the newest
version is installed.

```yaml
Type: SwitchParameter
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Command

Specifies one or more commands that `Install-Package` searches.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
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

### -Credential

Specifies a user account that has permission to access the computer and run commands. Type a user
name, such as **User01**, **Domain01\User01**, or enter a **PSCredential** object, generated by the
`Get-Credential` cmdlet. If you type a user name, you're prompted for a password.

When the **Credential** parameter isn't specified, `Install-Package` uses the current user.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Destination

Specifies a path to an input object.

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DscResource

Specifies one or more Desired State Configuration (DSC) resources that are searched by
`Install-Package`. Use the `Find-DscResource` cmdlet to find DSC resources.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies terms to search for within the **Name** and **Description** properties.

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation. Overrides restrictions that prevent
`Install-Package` from succeeding, with the exception of security.

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

### -ForceBootstrap

Forces **PackageManagement** to automatically install the package provider for the specified
package.

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

### -IncludeSystemComponent

Indicates that this cmdlet includes system components in the results.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageBySearch, Programs:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeWindowsInstaller

Indicates that this cmdlet includes the Windows installer in the results.

```yaml
Type: SwitchParameter
Parameter Sets: Programs:PackageBySearch, Programs:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Includes

Specifies whether `Install-Package` should find all package types. The acceptable values for this
parameter are as follows:

- Cmdlet
- DscResource
- Function
- Workflow

```yaml
Type: String[]
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:
Accepted values: DscResource, Cmdlet, Function

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Accepts pipeline input. Specifies a package by using the package's **SoftwareIdentity** type.
`Find-Package` outputs a **SoftwareIdentity** object.

```yaml
Type: SoftwareIdentity[]
Parameter Sets: PackageByInputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InstallUpdate

Indicates that `Install-Package` installs updates.

```yaml
Type: SwitchParameter
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallationPolicy

Specifies the installation policy. Valid values are: Trusted, UnTrusted

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Specifies a location for publishing the package.

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum allowed package version that you want to install. If you don't specify this
parameter, `Install-Package` installs the package's newest version.

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumVersion

Specifies the minimum allowed package version that you want to install. If you don't add this
parameter, `Install-Package` installs the package's newest version that satisfies any version
specified by the **MaximumVersion** parameter.

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies one or more package names. Multiple package names must be separated by commas.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider

Specifies the name of the **PackageManagement** provider.

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies one or more package provider names to which to scope your package search. You can get
package provider names by running the `Get-PackageProvider` cmdlet.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases: Provider
Accepted values: msi, Programs, msu, Bootstrap, PSModule, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PublishLocation

Specifies the path to a package's published location.

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact allowed version of the package that you want to install. If you don't add this
parameter, `Install-Package` installs the package's newest version that satisfies any version
specified by the **MaximumVersion** parameter.

```yaml
Type: String
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

Specifies the scope for which to install the package. The acceptable values for this parameter are
as follows:

- CurrentUser
- AllUsers

```yaml
Type: String
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source

Specifies one or more package sources. Multiple package source names must be separated by commas.
You can get package source names by running the `Get-PackageSource` cmdlet.

```yaml
Type: String[]
Parameter Sets: PackageBySearch
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tag

Specifies one or more strings to search for in the package metadata.

```yaml
Type: String[]
Parameter Sets: PSModule:PackageBySearch, PSModule:PackageByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if `Install-Package` cmdlet is run. The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### `Install-Package` accepts input from the pipeline.

## OUTPUTS

### SoftwareIdentity[]

## NOTES

Including a package provider in a command can make dynamic parameters available to a cmdlet. Dynamic
parameters are specific to a package provider. The `Get-Help` cmdlet lists a cmdlet's parameter sets
and includes the provider's parameter set.

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Find-DscResource](../PowershellGet/Find-DscResource)

[Get-Help](../Microsoft.PowerShell.Core/Get-Help.md)

[Get-Package](Get-Package.md)

[Get-PackageProvider](Get-PackageProvider.md)

[Get-PackageSource](Get-PackageSource.md)

[Find-Package](Find-Package.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)
