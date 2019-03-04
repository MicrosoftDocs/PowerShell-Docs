---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821669
schema: 2.0.0
title: Save-Module
---

# Save-Module

## SYNOPSIS
Saves a module locally without installing it.

## SYNTAX

### NameAndPathParameterSet (Default)
```
Save-Module [-Name] <String[]> [-MinimumVersion <String>] [-MaximumVersion <String>]
 [-RequiredVersion <String>] [-Repository <String[]>] [-Path] <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AllowPrerelease] [-AcceptLicense]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameAndLiteralPathParameterSet
```
Save-Module [-Name] <String[]> [-MinimumVersion <String>] [-MaximumVersion <String>]
 [-RequiredVersion <String>] [-Repository <String[]>] -LiteralPath <String> [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-Credential <PSCredential>] [-Force] [-AllowPrerelease] [-AcceptLicense]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputOjectAndLiteralPathParameterSet
```
Save-Module [-InputObject] <PSObject[]> -LiteralPath <String> [-Proxy <Uri>] [-ProxyCredential <PSCredential>]
 [-Credential <PSCredential>] [-Force] [-AcceptLicense] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputOjectAndPathParameterSet
```
Save-Module [-InputObject] <PSObject[]> [-Path] <String> [-Proxy <Uri>] [-ProxyCredential <PSCredential>]
 [-Credential <PSCredential>] [-Force] [-AcceptLicense] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Save-Module** cmdlet saves a module locally from the specified repository for inspection.
The module is not installed.

## EXAMPLES

### Example 1: Find modules and save them locally

```powershell
PS C:\> Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.3.5      AzureAutomationDebug                Module     PSGallery            Module for debugging Azure Automation runbooks, emulating AA native cmdlets

PS C:\> Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery" -IncludeDependencies
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.3.5      AzureAutomationDebug                Module     PSGallery            Module for debugging Azure Automation runbooks, emulating AA native cmdlets
1.0.1      AzureRM.Automation                  Module     PSGallery            Microsoft Azure PowerShell - Automation service cmdlets for Azure Resource Manager
1.0.1      AzureRM.profile                     Module     PSGallery            Microsoft Azure PowerShell - Profile credential management cmdlets for Azure Resource Manager

PS C:\> Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery" | Save-Module -Path "C:\MyLocalModules\"

PS C:\> dir C:\MyLocalModules\
    Directory: C:\MyLocalModules


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       12/14/2015  11:20 AM                AzureAutomationDebug
d-----       12/14/2015  11:20 AM                AzureRM.Automation
d-----       12/14/2015  11:20 AM                AzureRM.profile

PS C:\> Save-Module -LiteralPath "C:\MyLocalModules\" -Name "xPSDesiredStateConfiguration" -Repository "PSGallery" -MinimumVersion 2.0 -MaximumVersion 3.5.0
PS C:\> dir C:\MyLocalModules
   Directory: C:\MyLocalModules


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       12/14/2015  11:22 AM                xPSDesiredStateConfiguration
```

The first command uses the Find-Module cmdlet to find the AzureAutomationDebug module in the PSGallery repository and displays the results.

The second command uses **Find-Module** to find the AzureAutomationDebug module and its dependencies, and displays the results.

The third command uses **Find-Module** to find the AzureAutomationDebug module, and then uses the pipeline operator to pass the module to the **Save-Module** cmdlet, which save the module to the specified folder.

The fourth command displays the contents of the saved module.

The fifth command saves the specified versions of the module xPSDesiredStateConfiguration to C:\MyLocalModules.

The final command displays the contents of the C:\MyLocalModules folder.

## PARAMETERS

### -AcceptLicense
Automatically accept the license agreement during installation if the package requires it.

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

### -Credential

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

### -InputObject
Specifies a package by using the module's SoftwareID object, which is shown in the results of the Find-Module cmdlet.

```yaml
Type: PSObject[]
Parameter Sets: InputOjectAndLiteralPathParameterSet, InputOjectAndPathParameterSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath
Specifies a path to one or more locations.
Unlike the *Path* parameter, the value of the *LiteralPath* parameter is used exactly as entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Windows PowerShell does not interpret any characters that are enclosed in single quotation marks as escape sequences.

```yaml
Type: String
Parameter Sets: NameAndLiteralPathParameterSet, InputOjectAndLiteralPathParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum, or newest, version of the module to save.
The *MaximumVersion* and *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies the minimum version of a single module to save.
You cannot add this parameter if you are attempting to install multiple modules.
The *MinimumVersion* and *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

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
Specifies the path to the module that you want to publish.
This parameter accepts either the path to the folder that contains the module, or the module manifest (.psd1) file.
The parameter accepts piped values from Get-Module.

```yaml
Type: String
Parameter Sets: NameAndPathParameterSet, InputOjectAndPathParameterSet
Aliases:

Required: True
Position: 1
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
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Find-Module](Find-Module.md)

[Publish-Module](Publish-Module.md)

[Uninstall-Module](Uninstall-Module.md)

[Update-Module](Update-Module.md)
