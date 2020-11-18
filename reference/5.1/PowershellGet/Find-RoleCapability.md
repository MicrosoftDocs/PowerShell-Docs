---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 06/05/2019
online version: https://docs.microsoft.com/powershell/module/powershellget/find-rolecapability?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Find-RoleCapability
---

# Find-RoleCapability

## SYNOPSIS
Finds role capabilities in modules.

## SYNTAX

### All

```
Find-RoleCapability [[-Name] <String[]>] [-ModuleName <String>] [-MinimumVersion <String>]
[-MaximumVersion <String>] [-RequiredVersion <String>] [-AllVersions] [-AllowPrerelease]
[-Tag <String[]>] [-Filter <String>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>]
[-Repository <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Find-RoleCapability` cmdlet searches registered repositories to find PowerShell role
capabilities and modules.

For each role capability found by `Find-RoleCapability`, a **PSGetRoleCapabilityInfo** object is
returned. **PSGetRoleCapabilityInfo** objects can be sent down the pipeline to the `Install-Module`
or `Save-Module` cmdlets.

PowerShell role capabilities define which commands and applications are available to a user at a
Just Enough Administration (JEA) endpoint. Role capabilities are defined by files with a `.psrc`
extension.

## EXAMPLES

### Example 1: Find role capabilities

`Find-RoleCapability` finds role capabilities in each registered repository. To search a specific
repository, use the **Repository** parameter.

```powershell
Find-RoleCapability
```

```output
Name             Version    ModuleName     Repository
----             -------    ----------     ----------
General-Lev1     1.0        JeaExamples    PSGallery
General-Lev2     1.0        JeaExamples    PSGallery
IIS-Lev1         1.0        JeaExamples    PSGallery
IIS-Lev2         1.0        JeaExamples    PSGallery
```

### Example 2: Find role capabilities by name

`Find-RoleCapability` finds role capabilities by name. Use commas to separate an array of names.

```powershell
Find-RoleCapability -Name General-Lev1, IIS-Lev2
```

```output
Name             Version    ModuleName     Repository
----             -------    ----------     ----------
General-Lev1     1.0        JeaExamples    PSGallery
IIS-Lev2         1.0        JeaExamples    PSGallery
```

### Example 3: Find and save a role capability's module

The `Find-RoleCapability` cmdlet finds a role capability and sends the object down the pipeline.
`Save-Module` saves the role capability's module to a file system. `Get-ChildItem` displays the
contents of the module's directory.

```
PS> Find-RoleCapability -Name General-Lev1 | Save-Module -Path C:\Test\Modules

PS> Get-ChildItem -Path C:\Test\Modules\JeaExamples\1.0\

    Directory: C:\Test\Modules\JeaExamples\1.0

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----          6/4/2019    16:37                RoleCapabilities
-a----          2/5/2019    18:46           1702 CreateRegisterPSSC.ps1
-a----          2/5/2019    18:46           7656 JeaExamples.psd1
-a----         10/1/2018    08:16            595 JeaExamples.psm1
```

`Find-RoleCapability` uses the **Name** parameter to specify the **General-Lev1** role capability.
The object is sent down the pipeline. `Save-Module` uses the **Path** parameter for the file system
location to save the module. After the module is saved, `Get-ChildItem` specifies the module's
**Path** and displays the contents of the **JeaExamples** module's directory.

### Example 4: Find and install a role capability's module

`Find-RoleCapability` finds the module and sends the object down the pipeline. `Install-Module`
installs the module. After the installation, use `Get-InstalledModule` to see the results.

```
PS> Find-RoleCapability -Name General-Lev1 | Install-Module -Verbose

VERBOSE: Downloading 'https://www.powershellgallery.com/api/v2/package/JeaExamples/1.0.0'.
VERBOSE: Completed downloading 'https://www.powershellgallery.com/api/v2/package/JeaExamples/1.0.0'.
VERBOSE: Completed downloading 'JeaExamples'.
VERBOSE: InstallPackageLocal' - name='JeaExamples', version='1.0',
VERBOSE: Validating the 'JeaExamples' module contents
VERBOSE: Test-ModuleManifest successfully validated the module manifest file
VERBOSE: Module 'JeaExamples' was installed successfully to path

PS> Get-InstalledModule

Version    Name            Repository     Description
-------    ----            ----------     -----------
1.0        JeaExamples     PSGallery      Some example Jea roles for general server maintenance...
```

`Find-RoleCapability` uses the **Name** parameter to specify the **General-Lev1** role capability.
The object is sent down the pipeline. `Install-Module` uses the **Verbose** parameter to display
status messages during the installation. After the install is finished, the `Get-InstalledModule`
output confirms that the **JeaExamples** module was installed.

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

Indicates that this cmdlet gets all versions of a module. The **AllVersions** parameter displays
each of a module's available versions.

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

Specifies the maximum version of the module to include in results. The **MaximumVersion** and the
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

Specifies the minimum version of the module to include in results. The **MinimumVersion** and the
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

Specifies the name of the module in which to search for role capabilities. The default is all
modules.

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

Specifies the name of a role capability. The default is all role capabilities. Use commas to
separate an array of resource names.

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

Specifies a repository to search for role capabilities. Use commas to separate an array of
repository names.

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

### PSGetRoleCapabilityInfo

The `Find-RoleCapability` cmdlet returns a **PSGetRoleCapabilityInfo** object.

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

[Get-ChildItem](../Microsoft.PowerShell.Management/Get-ChildItem.md)

[Get-InstalledModule](Get-InstalledModule.md)

[Install-Module](Install-Module.md)

[New-PSRoleCapabilityFile](../Microsoft.PowerShell.Core/New-PSRoleCapabilityFile.md)

[Save-Module](Save-Module.md)
