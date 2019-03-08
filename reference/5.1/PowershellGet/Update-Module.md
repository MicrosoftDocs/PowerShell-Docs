---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821676
schema: 2.0.0
title: Update-Module
---

# Update-Module

## SYNOPSIS
Downloads and installs the newest version of specified modules from an online gallery to the local computer.

## SYNTAX

```
Update-Module [[-Name] <String[]>] [-RequiredVersion <String>] [-MaximumVersion <String>]
 [-Credential <PSCredential>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-Force] [-AllowPrerelease]
 [-AcceptLicense] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Update-Module** cmdlet installs a newer version of a Windows PowerShell module that was installed from the online gallery by running Install-Module on the local computer.

By default, the newest version of the specified module available in online gallery is installed, unless you specify a required version.
You can update an existing, installed module by specifying the name of the module; **Update-Module** searches $env:PSModulePath for the module that you want to update.

Running **Update-Module** without the *Name* parameter updates all modules that can be updated on the local computer.

## EXAMPLES

### Example 1: Update all modules
```
PS C:\> Update-Module
```

This example updates to the newest version all modules in $env:PSModulePath that were installed by Install-Module from the online gallery.

### Example 2: Update a module by name
```
PS C:\> Update-Module -Name "MyDscModule"
```

This example updates to the newest online gallery version the first module named MyDscModule found in $env:PSModulePath.
If the existing MyDscModule is already the newest version, nothing happens.
If **Update-Module** cannot find a module named MyDscModule in $env:PSModulePath, an error occurs.

### Example 3: View what would occur if Update-Module runs
```
PS C:\> Update-Module -WhatIf
What if: Performing the operation "Update-Module" on target "Version '2.0' of module 'xDscDiagnostics', updating to version '2.0'".
What if: Performing the operation "Update-Module" on target "Version '1.1.1' of module 'xDSCResourceDesigner', updating to version '1.1.1.1'".
```

This example shows what modules would be updated, and to which versions, if the **Update-Module** command were actually run.
The command is not run.

### Example 4: Update a module to a specified version
```
PS C:\> Update-Module -Name "ContosoModule" -RequiredVersion 2.1.0.3
```

This example updates ContosoModule to version 2.1.0.3.
If version 2.1.0.3 does not exist in the online gallery, an error occurs.

### Example 5: Update a module regardless of the current version installed
```
PS C:\> Update-Module -Name "ContosoModule" -Force
```

This example installs (or reinstalls) the newest version of ContosoModule from the online gallery, regardless of the current version of the module that is installed on the computer.

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
Allows you to update a module with the newer module marked as a prerelease.

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
Forces the update of each specified module, regardless of the current version of the module installed.

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

### -MaximumVersion
Specifies the maximum version of a single module to update.
You cannot add this parameter if you are attempting to update multiple modules.
The *MaximumVersion* and the *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the names of one or more modules to be updated.
**Update-Module** searches $env:PSModulePath for the modules to update.
Without wildcard characters, the only modules that are updated are those that exactly match specified names.
If no matches are found for the specified modules in $env:PSModulePath, an error occurs.
If you add wildcard characters to the name that you specify, but no matches are found, no error occurs.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -RequiredVersion
Specifies the exact version to which the existing installed module will be updated.
You cannot add this parameter if you are updating more than one module in a single command.
If the online gallery does not have this version of the specified module, an error occurs.

```yaml
Type: String
Parameter Sets: (All)
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
* This cmdlet runs on Windows PowerShell 3.0 or later releases of Windows PowerShell, on Windows 7 or Windows 2008 R2 and later releases of Windows.

  If the module that you specify with the **Name** parameter was not installed by using Install-Module, an error occurs.
You can only run **Update-Module** on modules that you installed from the online gallery by running Install-Module.

  If **Update-Module** attempts to update binaries that are in use, **Update-Module** returns an error that identifies the problem processes, and informs the user to retry **Update-Module** after stopping the processes.

## RELATED LINKS

[Find-Module](Find-Module.md)

[Install-Module](Install-Module.md)

[Publish-Module](Publish-Module.md)

[Uninstall-Module](Uninstall-Module.md)
