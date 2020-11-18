---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 06/04/2019
online version: https://docs.microsoft.com/powershell/module/powershellget/find-dscresource?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Find-DscResource
---

# Find-DscResource

## SYNOPSIS
Finds Desired State Configuration (DSC) resources.

## SYNTAX

### All

```
Find-DscResource [[-Name] <String[]>] [-ModuleName <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-RequiredVersion <String>] [-AllVersions] [-AllowPrerelease]
 [-Tag <String[]>] [-Filter <String>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>]
 [-Repository <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Find-DscResource` cmdlet searches registered repositories to find DSC resources contained in
modules. By default `Find-DscResource` searches all registered repositories.

For each module found by `Find-DscResource`, a **PSGetDscResourceInfo** object is returned.
**PSGetDscResourceInfo** objects can be sent down the pipeline to the `Install-Module` cmdlet.
`Install-Module` installs the module.

## EXAMPLES

### Example 1: Find all DSC resources

`Find-DscResource` returns DSC resources from registered repositories. To search a specific
repository, use the **Repository** parameter.

```powershell
Find-DscResource
```

```Output
Name                           Version    ModuleName                     Repository
----                           -------    ----------                     ----------
Carbon_Privilege               2.8.1      Carbon                         PSGallery
Carbon_ScheduledTask           2.8.1      Carbon                         PSGallery
Carbon_Service                 2.8.1      Carbon                         PSGallery
PackageManagement              1.4        PackageManagement              PSGallery
PackageManagementSource        1.4        PackageManagement              PSGallery
PSModule                       2.1.4      PowerShellGet                  PSGallery
PSRepository                   2.1.4      PowerShellGet                  PSGallery
xArchive                       8.7.0.0    xPSDesiredStateConfiguration   PSGallery
xDSCWebService                 8.7.0.0    xPSDesiredStateConfiguration   PSGallery
xEnvironment                   8.7.0.0    xPSDesiredStateConfiguration   PSGallery
```

### Example 2: Find a DSC resource by name

`Find-DscResource` locates DSC resources by name. Use commas to separate an array of resource names.

```powershell
Find-DscResource -Name xWebsite, xWebApplication, xWebSiteDefaults
```

```Output
Name               Version    ModuleName            Repository
----               -------    ----------            ----------
xWebApplication    2.6.0.0    xWebAdministration    PSGallery
xWebsite           2.6.0.0    xWebAdministration    PSGallery
xWebSiteDefaults   2.6.0.0    xWebAdministration    PSGallery
```

`Find-DscResource` uses the **Name** parameter to find the specified array of DSC resources.

### Example 3: Find a DSC resource and install it

`Find-DscResource` locates a DSC resource and sends the object down the pipeline to be installed.
After the installation, use `Get-InstalledModule` to view the results.

Multiple resources from the same module can be sent down the pipeline to the `Install-Module`.
`Install-Module` attempts to only install the module once.

```powershell
Find-DscResource -Name xWebsite | Install-Module
```

`Find-DscResource` uses the **Name** parameter to find the resource named **xWebsite**. The object
is sent down the pipeline to the `Install-Module` cmdlet. `Install-Module` installs the
**xWebAdministration** module for the resource.

### Example 4: Find all DSC resources in a module

`Find-DscResource` finds all the DSC resources contained in a specified module. By default, the
current version is displayed. To display other versions, use the **AllVersions** or
**RequiredVersions** parameters.

```powershell
Find-DscResource -ModuleName xWebAdministration
```

```Output
Name                                Version    ModuleName              Repository
----                                -------    ----------              ----------
WebApplicationHandler               2.6.0.0    xWebAdministration      PSGallery
xIisFeatureDelegation               2.6.0.0    xWebAdministration      PSGallery
xIisHandler                         2.6.0.0    xWebAdministration      PSGallery
xIisLogging                         2.6.0.0    xWebAdministration      PSGallery
```

`Find-DscResource` uses the **ModuleName** parameter to specify the **xWebAdministration** and find
the DSC resources contained in the module. The current version of each resource is displayed.

### Example 5: Find a DSC resource by tag and required version

DSC resources can be located using the parameters **Tag** and **RequiredVersion**. **Tag** displays
the current version of every resource that contains the specified tag in the repository.
**RequiredVersion** needs the **ModuleName** parameter and the **Name** parameter is optional. The
**Name** and **ModuleName** parameters limit the output. Use the **AllVersions** parameter to
display a DSC resource's available versions.

```powershell
Find-DscResource -ModuleName xWebAdministration -Tag DSC -RequiredVersion 1.20
```

```output
Name                    Version    ModuleName             Repository
----                    -------    ----------             ----------
xIisFeatureDelegation   1.20.0.0   xWebAdministration     PSGallery
xIisHandler             1.20.0.0   xWebAdministration     PSGallery
xIisLogging             1.20.0.0   xWebAdministration     PSGallery
xIisMimeTypeMapping     1.20.0.0   xWebAdministration     PSGallery
```

### Example 6: Find a resource by using a filter

`Find-DscResource` finds all resources and uses the **Filter** parameter to specify the results by
**Domain**. The **Filter** parameter finds the filter value in the object's description or module
name. Use the `Select-Object` cmdlet to view an object's properties.

```powershell
Find-DscResource -Filter Domain
```

```output
Name                    Version    ModuleName                 Repository
----                    -------    ----------                 ---------
xComputer               4.1.0.0    xComputerManagement        PSGallery
Computer                6.4.0.0    ComputerManagementDsc      PSGallery
xDSCDomainjoin          1.1        xDSCDomainjoin             PSGallery
xDisk                   1.0        xDisk                      PSGallery
xDSCFirewall            1.6.21     xDSCFirewall               PSGallery
dmAwsTagInstance        1.0.1      domainAwsDSCResources      PSGallery
```

## PARAMETERS

### -AllowPrerelease

Includes resources marked as a prerelease in the results.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions

The **AllVersions** parameter displays each of a DSC resource's available versions. You can't use
the **AllVersions** parameter with the **MinimumVersion**, **MaximumVersion**, or
**RequiredVersion** parameters.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Finds resources based on the **PackageManagement** provider's search syntax. For example, specify
words to search for within the **ModuleName** and **Description** properties.

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

### -MaximumVersion

Specifies the maximum version of the resource to include in results. The **MaximumVersion** and the
**RequiredVersion** parameters can't be used in the same command.

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

### -MinimumVersion

Specifies the minimum version of the resource to include in results. The **MinimumVersion** and the
**RequiredVersion** parameters can't be used in the same command.

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

### -ModuleName

Specifies a module that contains the DSC resource.

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

### -Name

Specifies the name of a resource. The default is all resources. Use commas to separate an array of
resource names.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy

Specifies a proxy server for the request, rather than a direct connection to the internet resource.

```yaml
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyCredential

Specifies a user account with permission to use the proxy server specified in the **Proxy**
parameter.

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

### -Repository

Specifies a repository to search for resources. Use commas to separate an array of repository names.

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

### -RequiredVersion

Specifies the module's exact version number to include in the results. The **RequiredVersion** and
the **MinimumVersion** parameters can't be used in the same command.

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

### -Tag

Specifies tags that categorize modules in a repository. Use commas to separate an array of tags.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSGetDscResourceInfo

`Find-DscResource` returns a **PSGetDscResourceInfo** object.

## NOTES

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

## RELATED LINKS

[Get-InstalledModule](Get-InstalledModule.md)

[Install-Module](Install-Module.md)

[Register-PSRepository](Register-PSRepository.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Uninstall-Module](Uninstall-Module.md)
