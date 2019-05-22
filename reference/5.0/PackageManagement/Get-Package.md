---
ms.date: 5/22/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517135
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Get-Package
---

# Get-Package

## SYNOPSIS
Returns a list of all software packages that were installed with **PackageManagement**.

## SYNTAX

### Programs

```
Get-Package [[-Name] <string[]>] [-RequiredVersion <string>] [-MinimumVersion <string>]
[-MaximumVersion <string>] [-Force] [-ForceBootstrap] [-ProviderName <string[]>]
[-IncludeWindowsInstaller] [-IncludeSystemComponent] [<CommonParameters>]
```

### msi

```
Get-Package [[-Name] <string[]>] [-RequiredVersion <string>] [-MinimumVersion <string>]
[-MaximumVersion <string>] [-Force] [-ForceBootstrap] [-ProviderName <string[]>]
[-AdditionalArguments <string[]>] [<CommonParameters>]
```

### PSModule

```
Get-Package [[-Name] <string[]>] [-RequiredVersion <string>] [-MinimumVersion <string>]
[-MaximumVersion <string>] [-Force] [-ForceBootstrap] [-ProviderName <string[]>]
[-PackageManagementProvider <string>] [-Location <string>] [-InstallUpdate]
[-InstallationPolicy <string>] [-DestinationPath <string>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Package` cmdlet returns a list of all software packages on the local computer that were
installed with **PackageManagement**. You can run `Get-Package` on remote computers by running it as
part of an `Invoke-Command` or `Enter-PSSession` command or script.

## EXAMPLES

### Example 1: Get all installed packages

The `Get-Package` cmdlet gets all packages that are installed on the local computer.

```powershell
Get-Package
```

```Output
Name           Version      Source                                     ProviderName
----           -------      ------                                     ------------
posh-git       0.7.3        https://www.powershellgallery.com/api/v2   PowerShellGet
```

### Example 2: Get packages that are installed on a remote computer

This command gets a list of packages that were installed by **PackageManagement** on a remote
computer. This command prompts you to provide the specified user's password.

```
PS> Invoke-Command -ComputerName Server01 -Credential CONTOSO\TestUser -ScriptBlock {Get-Package}
```

`Invoke-Command` uses the **ComputerName** parameter to specify a remote computer, **Server01**. The
**Credential** parameter specifies a domain and user name with permissions to run commands on the
computer. The **ScriptBlock** parameter runs the `Get-Package` cmdlet on the remote computer.

### Example 3: Get packages for a specified provider

This command gets software packages installed on the local computer from a specific provider.

```powershell
Get-Package -ProviderName PowerShellGet -AllVersions
```

```Output
Name                  Version      Source                                     ProviderName
----                  -------      ------                                     ------------
PackageManagement     1.2.2        https://www.powershellgallery.com/api/v2   PowerShellGet
PackageManagement     1.3.1        https://www.powershellgallery.com/api/v2   PowerShellGet
posh-git              0.7.3        https://www.powershellgallery.com/api/v2   PowerShellGet
PowerShellGet         2.0.1        https://www.powershellgallery.com/api/v2   PowerShellGet
```

`Get-Package` uses the **ProviderName** parameter to specify a specific provider, **PowerShellGet**.
The **All-Versions** parameter displays each version that is installed.

### Example 4: Get an exact version of a specific package

This command gets a specific version of an installed package. More than one version of a package can
be installed.

```powershell
Get-Package -Name PackageManagement -ProviderName PowerShellGet -RequiredVersion 1.3.1
```

```Output
Name                  Version      Source                                     ProviderName
----                  -------      ------                                     ------------
PackageManagement     1.3.1        https://www.powershellgallery.com/api/v2   PowerShellGet
```

`Get-Package` uses **Name** parameter to specify the package name, **PackageManagement**. The
**ProviderName** parameter specifies the provider, **PowerShellGet**. The **Required-Version**
parameter specifies an installed version.

### Example 5: Uninstall a package

This example gets package information and then uninstalls the package.

```powershell
Get-Package -Name posh-git -RequiredVersion 0.7.3 | Uninstall-Package
```

`Get-Package` uses the **Name** parameter to specify the package name, **posh-git**. The
**RequiredVersion** parameter is a specific version of the package. The object is sent down the
pipeline to the `Uninstall-Package` cmdlet. `Uninstall-Package` removes the package.

## PARAMETERS

### -AdditionalArguments

Specifies additional arguments.

```yaml
Type: String[]
Parameter Sets: msi
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath

Specifies the path to a directory that contains extracted package files.

```yaml
Type: String
Parameter Sets: PSModule
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

Indicates that `Get-Package` forces **PackageManagement** to automatically install the package
provider.

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
Parameter Sets: Programs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeWindowsInstaller

Indicates that this cmdlet includes the Windows Installer in the results.

```yaml
Type: SwitchParameter
Parameter Sets: Programs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallUpdate

Indicates that this cmdlet installs updates.

```yaml
Type: SwitchParameter
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallationPolicy

Specifies the installation policy. Valid values are: Trusted, UnTrusted.

```yaml
Type: String
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

Specifies the location of the package management source or repository.

```yaml
Type: String
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum package version that you want to find.

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

Specifies the minimum package version that you want to find. If a higher version is available, that
version is returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies one or more package names, or package names with wildcard characters. Separate multiple
package names with commas.

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

### -PackageManagementProvider

Specifies the name of a package management provider.

```yaml
Type: String
Parameter Sets: PSModule
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies one or more package provider names. Separate multiple package provider names with commas.
Use `Get-PackageProvider` to get a list of available package providers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: Bootstrap, chocolatey, msi, msu, nuget, Programs, PSModule

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version of the package to find.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### SoftwareIdentity[]

## NOTES

Including a package provider in a command can make dynamic parameters available to a cmdlet. Dynamic
parameters are specific to a package provider. The `Get-Help` cmdlet lists a cmdlet's parameter sets
and includes the provider's parameter set.

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_PackageManagement.md)

[Enter-PSSession](../Microsoft.PowerShell.Core/Enter-PSSession.md)

[Find-Package](Find-Package.md)

[Get-Help](../Microsoft.PowerShell.Core/Get-Help.md)

[Get-PackageProvider](Get-PackageProvider.md)

[Get-PackageSource](Get-PackageSource.md)

[Install-Package](Install-Package.md)

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)