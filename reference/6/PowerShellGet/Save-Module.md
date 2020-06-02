---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PowerShellGet
ms.date: 11/11/2019
online version: https://docs.microsoft.com/powershell/module/powershellget/save-module?view=powershell-6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Save-Module
---

# Save-Module

## SYNOPSIS
Saves a module and its dependencies on the local computer but doesn't install the module.

## SYNTAX

### NameAndPathParameterSet (Default)

```
Save-Module [-Name] <String[]> [-MinimumVersion <String>] [-MaximumVersion <String>]
 [-RequiredVersion <String>] [-Repository <String[]>] [-Path] <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AllowPrerelease]
 [-AcceptLicense] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameAndLiteralPathParameterSet

```
Save-Module [-Name] <String[]> [-MinimumVersion <String>] [-MaximumVersion <String>]
 [-RequiredVersion <String>] [-Repository <String[]>] -LiteralPath <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AllowPrerelease]
 [-AcceptLicense] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObjectAndLiteralPathParameterSet

```
Save-Module [-InputObject] <PSObject[]> -LiteralPath <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AcceptLicense] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### InputObjectAndPathParameterSet

```
Save-Module [-InputObject] <PSObject[]> [-Path] <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AcceptLicense] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Save-Module` cmdlet downloads a module and any dependencies from a registered repository.
`Save-Module` downloads and saves the most current version of a module. The files are saved to a
specified path on the local computer. The module isn't installed, but the contents are available for
inspection by an administrator. The saved module can then be copied into the appropriate
`$env:PSModulePath` location of the offline machine.

`Get-PSRepository` displays the local computer's registered repositories. You can use the
`Find-Module` cmdlet to search registered repositories.

## EXAMPLES

### Example 1: Save a module

In this example, a module and its dependencies are saved to the local computer.

```powershell
Save-Module -Name PowerShellGet -Path C:\Test\Modules -Repository PSGallery
Get-ChildItem -Path C:\Test\Modules
```

```Output
    Directory: C:\Test\Modules

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         7/1/2019     13:31                PackageManagement
d-----         7/1/2019     13:31                PowerShellGet
```

`Save-Module` uses the **Name** parameter to specify the module, **PowerShellGet**. The **Path**
parameter specifies where to store the downloaded module. The **Repository** parameter specifies a
registered repository, **PSGallery**. After the download is finished, `Get-ChildItem` displays the
contents of **Path** where the files are stored.

### Example 2: Save a specific version of a module

This example shows how to use a parameter such as **MaximumVersion**, or **RequiredVersion** to
specify a module version.

```powershell
Save-Module -Name PowerShellGet -Path C:\Test\Modules -Repository PSGallery -MaximumVersion 2.1.0
Get-ChildItem -Path C:\Test\Modules\PowerShellGet\
```

```Output
    Directory: C:\Test\Modules\PowerShellGet

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         7/1/2019     13:40                2.1.0
```

`Save-Module` uses the **Name** parameter to specify the module, **PowerShellGet**. The **Path**
parameter specifies where to store the downloaded module. The **Repository** parameter specifies a
registered repository, **PSGallery**. **MaximumVersion** specifies that version **2.1.0** is
downloaded and saved. After the download is finished, `Get-ChildItem` displays the contents of
**Path** where the files are stored.

### Example 3: Find and save a specific version of a module

In this example, a required module version is found in the repository and saved to the local
computer.

```powershell
Find-Module -Name PowerShellGet -Repository PSGallery -RequiredVersion 1.6.5 |
  Save-Module -Path C:\Test\Modules
Get-ChildItem -Path C:\Test\Modules\PowerShellGet
```

```Output
    Directory: C:\Test\Modules\PowerShellGet

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         7/1/2019     14:04                1.6.5
```

`Find-Module` uses the **Name** parameter to specify the module, **PowerShellGet**. The
**Repository** parameter specifies a registered repository, **PSGallery**. **RequiredVersion**
specifies version **1.6.5**.

The object is sent down the pipeline to `Save-Module`. The **Path** parameter specifies where to
store the downloaded module. After the download is finished, `Get-ChildItem` displays the contents
of **Path** where the files are stored.

## PARAMETERS

### -AcceptLicense

Automatically accept the license agreement if the package requires it.

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

### -AllowPrerelease

Allows you to save a module marked as a prerelease.

```yaml
Type: SwitchParameter
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the `Save-Module`.

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

Specifies a user account that has rights to save a module.

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

### -Force

Forces `Save-Module` to run without asking for user confirmation.

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

### -InputObject

Accepts a **PSRepositoryItemInfo** object. For example, output `Find-Module` to a variable and use
that variable as the **InputObject** argument.

```yaml
Type: PSObject[]
Parameter Sets: InputObjectAndLiteralPathParameterSet, InputObjectAndPathParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies a path to one or more locations. The value of the **LiteralPath** parameter is used
exactly as entered. No characters are interpreted as wildcards. If the path includes escape
characters, enclose them in single quotation marks. PowerShell does not interpret any characters
enclosed in single quotation marks as escape sequences.

```yaml
Type: String
Parameter Sets: NameAndLiteralPathParameterSet, InputObjectAndLiteralPathParameterSet
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaximumVersion

Specifies the maximum, or newest, version of the module to save. The **MaximumVersion** and
**RequiredVersion** parameters can't be used in the same command.

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion

Specifies the minimum version of a single module to save. You cannot add this parameter if you are
attempting to install multiple modules. The **MinimumVersion** and **RequiredVersion** parameters
can't be used in the same command.

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies an array of names of modules to save.

```yaml
Type: String[]
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the location on the local computer to store a saved module. Accepts wildcard characters.

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, InputObjectAndPathParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Proxy

Specifies a proxy server for the request, rather than connecting directly to the internet resource.

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

Specifies the friendly name of a repository that has been registered by running
`Register-PSRepository`. Use `Get-PSRepository` to display registered repositories.

```yaml
Type: String[]
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion

Specifies the exact version number of the module to save.

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, NameAndLiteralPathParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the `Save-Module` runs. The cmdlet isn't run.

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

### System.String[]

### System.Management.Automation.PSObject[]

### System.String

### System.Uri

### System.Management.Automation.PSCredential

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
