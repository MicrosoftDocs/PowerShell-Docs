---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 08/03/2020
online version: https://docs.microsoft.com/powershell/module/powershellget/install-module?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Install-Module
---
# Install-Module

## SYNOPSIS
Downloads one or more modules from a repository, and installs them on the local computer.

## SYNTAX

### NameParameterSet (Default)

```
Install-Module [-Name] <String[]> [-MinimumVersion <String>] [-MaximumVersion <String>]
 [-RequiredVersion <String>] [-Repository <String[]>] [-Credential <PSCredential>] [-Scope <String>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-AllowClobber] [-SkipPublisherCheck] [-Force]
 [-AllowPrerelease] [-AcceptLicense] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject

```
Install-Module [-InputObject] <PSObject[]> [-Credential <PSCredential>] [-Scope <String>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-AllowClobber] [-SkipPublisherCheck] [-Force]
 [-AcceptLicense] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Install-Module` cmdlet gets one or more modules that meet specified criteria from an online
repository. The cmdlet verifies that search results are valid modules and copies the module folders
to the installation location. Installed modules are not automatically imported after installation.
You can filter which module is installed based on the minimum, maximum, and exact versions of
specified modules.

If the module being installed has the same name or version, or contains commands in an existing
module, warning messages are displayed. After you confirm that you want to install the module and
override the warnings, use the `-Force` and `-AllowClobber` parameters. Dependent upon your
repository settings, you might need to answer a prompt for the module installation to continue.

These examples use the [PowerShell Gallery](https://www.powershellgallery.com/) as the only
registered repository. `Get-PSRepository` displays the registered repositories. If you have multiple
registered repositories, use the `-Repository` parameter to specify the repository's name.

## EXAMPLES

### Example 1: Find and install a module

This example finds a module in the repository and installs the module.

```powershell
Find-Module -Name PowerShellGet | Install-Module
```

The `Find-Module` uses the **Name** parameter to specify the **PowerShellGet** module. By default,
the newest version of the module is downloaded from the repository. The object is sent down the
pipeline to the `Install-Module` cmdlet. `Install-Module` installs the module for all users in
`$env:ProgramFiles\PowerShell\Modules`.

### Example 2: Install a module by name

In this example, the newest version of the **PowerShellGet** module is installed.

```powershell
Install-Module -Name PowerShellGet
```

The `Install-Module` uses the **Name** parameter to specify the **PowerShellGet** module. By
default, the newest version of the module is downloaded from the repository and installed.

### Example 3: Install a module using its minimum version

In this example, the minimum version of the **PowerShellGet** module is installed. The
**MinimumVersion** parameter specifies the lowest version of the module that should be installed. If
a newer version of the module is available, that version is downloaded and installed for all users.

```powershell
Install-Module -Name PowerShellGet -MinimumVersion 2.0.1
```

The `Install-Module` uses the **Name** parameter to specify the **PowerShellGet** module. The
**MinimumVersion** parameter specifies that version **2.0.1** is downloaded from the repository and
installed. Because version **2.0.4** is available, that version is downloaded and installed for all
users.

### Example 4: Install a specific version of a module

In this example, a specific version of the **PowerShellGet** module is installed.

```powershell
Install-Module -Name PowerShellGet -RequiredVersion 2.0.0
```

The `Install-Module` uses the **Name** parameter to specify the **PowerShellGet** module. The
**RequiredVersion** parameter specifies that version **2.0.0** is downloaded and installed for all
users.

### Example 5: Install a module only for the current user

This example downloads and installs the newest version of a module, only for the current user.

```powershell
Install-Module -Name PowerShellGet -Scope CurrentUser
```

The `Install-Module` uses the **Name** parameter to specify the **PowerShellGet** module.
`Install-Module` downloads and installs the newest version of **PowerShellGet** into the current
user's directory, `$home\Documents\PowerShell\Modules`.

## PARAMETERS

### -AcceptLicense

For modules that require a license, **AcceptLicense** automatically accepts the license agreement
during installation. For more information, see [Modules Requiring License Acceptance](/powershell/scripting/gallery/concepts/module-license-acceptance).

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

### -AllowClobber

Overrides warning messages about installation conflicts about existing commands on a computer.
Overwrites existing commands that have the same name as commands being installed by a module.
**AllowClobber** and **Force** can be used together in an `Install-Module` command.

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

### -AllowPrerelease

Allows you to install a module marked as a pre-release.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the `Install-Module` cmdlet.

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

Specifies a user account that has rights to install a module for a specified package provider or
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

### -Force

Installs a module and overrides warning messages about module installation conflicts. If a module
with the same name already exists on the computer, **Force** allows for multiple versions to be
installed. If there is an existing module with the same name and version, **Force** overwrites that
version. **Force** and **AllowClobber** can be used together in an `Install-Module` command.

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

### -InputObject

Used for pipeline input.

```yaml
Type: System.Management.Automation.PSObject[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum version of a single module to install. The version installed must be less than
or equal to **MaximumVersion**. If you want to install multiple modules, you cannot use
**MaximumVersion**. **MaximumVersion** and **RequiredVersion** cannot be used in the same
`Install-Module` command.

```yaml
Type: System.String
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion

Specifies the minimum version of a single module to install. The version installed must be greater than
or equal to **MinimumVersion**. If there is a newer version of the module available, the newer
version is installed. If you want to install multiple modules, you cannot use **MinimumVersion**.
**MinimumVersion** and **RequiredVersion** cannot be used in the same `Install-Module` command.

```yaml
Type: System.String
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the exact names of modules to install from the online gallery. A comma-separated list of
module names is accepted. The module name must match the module name in the repository. Use
`Find-Module` to get a list of module names.

```yaml
Type: System.String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

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

### -Proxy

Specifies a proxy server for the request, rather than connecting directly to the Internet resource.

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

Specifies a user account that has permission to use the proxy server that is specified by the
**Proxy** parameter.

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

Use the **Repository** parameter to specify which repository is used to download and install a
module. Used when multiple repositories are registered. Specifies the name of a registered
repository in the `Install-Module` command. To register a repository, use `Register-PSRepository`.
To display registered repositories, use `Get-PSRepository`.

```yaml
Type: System.String[]
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version of a single module to install. If there is no match in the repository
for the specified version, an error is displayed. If you want to install multiple modules, you
cannot use **RequiredVersion**. **RequiredVersion** cannot be used in the same `Install-Module`
command as **MinimumVersion** or **MaximumVersion**.

```yaml
Type: System.String
Parameter Sets: NameParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope

Specifies the installation scope of the module. The acceptable values for this parameter are
**AllUsers** and **CurrentUser**.

The **AllUsers** scope installs modules in a location that is accessible to all users of the
computer:

`$env:ProgramFiles\PowerShell\Modules`

The **CurrentUser** installs modules in a location that is accessible only to the current user of
the computer. For example:

`$home\Documents\PowerShell\Modules`

When no **Scope** is defined, the default is set based on the PowerShellGet version.

- In PowerShellGet versions 2.0.0 and above, the default is **CurrentUser**, which does not require
  elevation for install.
- In PowerShellGet 1.x versions, the default is **AllUsers**, which requires elevation for install.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipPublisherCheck

Allows you to install a newer version of a module that already exists on your computer. For example,
when an existing module is digitally signed by a trusted publisher but the new version is not
digitally signed by a trusted publisher.

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

### -WhatIf

Shows what would happen if an `Install-Module` command was run. The cmdlet is not run.

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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PSRepositoryItemInfo

`Find-Module` creates **PSRepositoryItemInfo** objects that can be sent down the pipeline to
`Install-Module`.

### System.String[]

### System.Management.Automation.PSObject[]

### System.String

### System.Management.Automation.PSCredential

### System.Uri

## OUTPUTS

### Microsoft.PowerShell.Commands.PSRepositoryItemInfo

When using the **PassThru** parameter, `Install-Module` outputs a **PSRepositoryItemInfo** object
for the module. This is the same information that you get from the `Find-Module` cmdlet.

## NOTES

`Install-Module` runs on PowerShell 5.0 or later releases, on Windows 7 or Windows 2008 R2 and later
releases of Windows.

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

As a security best practice, evaluate a module's code before running any cmdlets or functions for
the first time. To prevent running modules that contain malicious code, installed modules are not
automatically imported after installation.

If the module name specified by the **Name** parameter does not exist in the repository,
`Install-Module` returns an error.

To install multiple modules, use the **Name** parameter and specify a comma-separated array of
module names. If you specify multiple module names, you cannot use **MinimumVersion**,
**MaximumVersion**, or **RequiredVersion**. `Find-Module` creates **PSRepositoryItemInfo** objects
that can be sent down the pipeline to `Install-Module`. The pipeline is another way to specify
multiple modules to install in a single command.

By default, modules for the scope of **AllUsers** are installed in
`$env:ProgramFiles\PowerShell\Modules`. The default prevents confusion when you install PowerShell
Desired State Configuration (DSC) resources.

A module installation fails and cannot be imported if it does not have a `.psm1`, `.psd1`, or `.dll`
of the same name within the folder. Use the **Force** parameter to install the module.

If an existing module's version matches the name specified by the **Name** parameter, and the
**MinimumVersion** or **RequiredVersion** parameter are not used, `Install-Module` silently
continues but does not install the module.

If an existing module's version is greater than the value of the **MinimumVersion** parameter, or
equal to the value of the **RequiredVersion** parameter, `Install-Module` silently continues but
does not install the module.

If the existing module does not match the values specified by the **MinimumVersion** or
**RequiredVersion** parameters, an error occurs in the `Install-Module` command. For example, if the
version of the existing installed module is lower than the **MinimumVersion** value or not equal to
the **RequiredVersion** value.

A module installation will also install any dependent modules specified as required by the module publisher.
The publisher will specify the required modules and their versions in the module manifest.

## RELATED LINKS

[Find-Module](Find-Module.md)

[Get-PSRepository](Get-PSRepository.md)

[Import-Module](../Microsoft.PowerShell.Core/Import-Module.md)

[Publish-Module](Publish-Module.md)

[Register-PSRepository](Register-PSRepository.md)

[Uninstall-Module](Uninstall-Module.md)

[Update-Module](Update-Module.md)

[about_Module](../Microsoft.PowerShell.Core/About/about_Modules.md)
