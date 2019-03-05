---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822321
schema: 2.0.0
title: Find-RoleCapability
---

# Find-RoleCapability

## SYNOPSIS
Finds role capabilities in modules.

## SYNTAX

```
Find-RoleCapability [[-Name] <String[]>] [-ModuleName <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-RequiredVersion <String>] [-AllVersions] [-AllowPrerelease] [-Tag <String[]>]
 [-Filter <String>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-Repository <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Find-RoleCapability** cmdlet finds PowerShell role capabilities in modules.
**Find-RoleCapability** searches modules in registered repositories.

For each role capability that this cmdlet finds, it returns a **PSGetRoleCapabilityInfo** object.
You can pass a **PSGetRoleCapabilityInfo** object to the Install-Module cmdlet to install the module that contains the role capability.

PowerShell role capabilities define which commands, applications, and so on are available to a user at a Just Enough Administration (JEA) endpoint.
Role capabilities are defined by files with a .psrc extension.

## EXAMPLES

### Example 1: Find all role capabilities
```
PS C:\> Find-RoleCapability
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Maintenance                         1.0        Demo_Module                         PSGallery
MyJeaRole                           0.0.3      MyJeaModule                         PSGallery
MyRoleCap                           0.2.0.6    MyRoleCapabilityModule              PSGallery
```

This command finds all role capabilities.

### Example 2: Find role capabilities by name
```
PS C:\> Find-RoleCapability -Name "Maintenance,MyJeaRole"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Maintenance                         1.0        Demo_Module                         PSGallery
MyJeaRole                           0.0.3      MyJeaModule                         PSGallery
```

This command finds the role capabilities named Maintenance and MyJeaRole.

### Example 3: Find role capabilities and save them
```
PS C:\> Find-RoleCapability -Name "Maintenance,MyJeaRole" | Save-Module -Path "C:\MyModulesPath"
PS C:\> Get-ChildItem -Path "C:\MyModulesPath"
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       11/18/2015  11:46 PM                Demo_Module
d-----       10/29/2015   6:32 PM                MyJeaModule
```

The first command finds the role capabilities named Maintenance and MyJeaRole, and uses the pipeline operator to pass them to Save-Module, which saves the modules that contain the role capabilities to a local folder.

The second command uses Get-ChildItem to get the items saved with the prior command.

### Example 4: Find role capabilities and install them
```
PS C:\> Find-RoleCapability -Name "Maintenance,MyJeaRole" | Install-Module
PS C:\> Get-InstalledModule
    Version    Name                                Type       Repository           Description
    -------    ----                                ----       ----------           -----------
    1.0        Demo_Module                         Module     PSGallery            JEA RoleCapabilities
    0.0.3      MyJeaModule                         Module     PSGallery            MyJeaModule description
```

The first command finds the role capabilities named Maintenance and MyJeaRole, and uses the pipeline operator to pass them to Install-Module, which installs the modules.

The second command gets the installed modules.

## PARAMETERS

### -AllowPrerelease
Includes in the results resources marked as a prerelease.


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

### -AllVersions
Indicates that this cmdlet gets all versions of a module.

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
Finds modules based on the PackageManagement provider-specific search syntax.
For NuGet, this is the equivalent of using the search bar on the PowerShell Gallery website.

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

### -MaximumVersion

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
Specifies the minimum version of the module to include in results.
The *MinimumVersion* and the *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

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

### -ModuleName
Specifies the name of the module in which to search for role capabilities.
The default is all modules.

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

### -Name
Specifies an array of names of role capabilities to search for.

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

### -Proxy
Specifies a proxy server for the request, rather than connecting directly to the Internet resource.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyCredential
Specifies a user account that has permission to use the proxy server that is specified by the **Proxy** parameter.

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

### -Repository
Specifies an array of registered repositories in which to search.
The default is all repositories.

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
Specifies the version of the module to include in the results.

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

### -Tag
Specifies an array of tags.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

## RELATED LINKS
