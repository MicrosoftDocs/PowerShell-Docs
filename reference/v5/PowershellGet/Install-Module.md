---
external help file: PSGet.psm1-help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=398573
schema: 2.0.0
---

# Install-Module
## SYNOPSIS
Downloads one or more modules from an online gallery, and installs them on the local computer.

## SYNTAX

### NameParameterSet (Default)
```
Install-Module [-Name] <String[]> [-MinimumVersion <Version>] [-MaximumVersion <Version>]
 [-RequiredVersion <Version>] [-Repository <String[]>] [-Scope <String>] [-Force] [-WhatIf] [-Confirm]
```

### InputObject
```
Install-Module -InputObject <PSObject[]> [-Scope <String>] [-Force] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Install-Module cmdlet gets one or more modules that meet specified criteria from an online gallery, verifies that search results are valid modules, and copies module folders to the installation location.

When no scope is defined, or when the value of the Scope parameter is AllUsers, the module is installed to %systemdrive%:\Program Files\WindowsPowerShell\Modules.
When the value of Scope is CurrentUser, the module is installed to $home\Documents\WindowsPowerShell\Modules.

You can filter your results based on minimum and exact versions of specified modules.

## EXAMPLES

### Example 1: Find a module and install it
```
PS C:\>Find-Module -Name "MyDSC*" | Install-Module
```

In this example, modules with a name that starts with MyDSC that are found by Find-Module in the online gallery are installed to the default folder, C:\ProgramFiles\WindowsPowerShell\Modules.

### Example 2: Install a module by name
```
PS C:\>Install-Module -Name "MyDscModule"
```

In this example, the newest version of the module MyDscModule from the online gallery is installed to the default folder, Program Files.

If no module named MyDscModule exists, an error occurs.

### Example 3: Install a module using its minimum version
```
PS C:\>Install-Module -Name "ContosoServer" -MinimumVersion 1.0
```

In this example, the most current version of the module ContosoServer is installed that matches the specified minimum version.
If the most current version of the module is a lower number than 1.0, the command returns errors.

### Example 4: Install a specific version of a module
```
PS C:\>Install-Module -Name "ContosoServer" -RequiredVersion 1.1.3
```

This example installs version 1.1.3 of the module ContosoServer to the Program Files folder.
If version 1.1.3 is not available, an error occurs.

### Example 5: Install the current version of a module
```
PS C:\>Install-Module -Name "ContosoServer" -Scope "CurrentUser"
```

This example installs the newest version of the module ContosoServer to $home\Documents\WindowsPowerShell\Modules.

## PARAMETERS

### -Force
Forces the installation of modules.
If a module of the same name and version already exists on the computer, this parameter overwrites the existing module with one of the same name that was found by the command.

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
Specifies the maximum version of a single module to install.
You cannot add this parameter if you are attempting to install multiple modules.
The MaximumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of a single module to install.
You cannot add this parameter if you are attempting to install multiple modules.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

If you are installing multiple modules in a single command, and a specified minimum version for a module is not available for installation, the Install-Module command will silently continue without installing the module for which it cannot find the specified minimum version.
For example, if you try to install the ContosoServer module with a minimum version of 2.0, but the newest version of the ContosoServer module is only 1.5, your Install-Module command will not install the ContosoServer module; it will go on to install the next specified module, and Windows PowerShell will display errors when the command is finished.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the exact names of modules to install from the online gallery.
This parameter supports wildcard characters.
If wildcard characters are not specified, only modules that exactly match the specified names are returned.
If no matches are found, and you have not used any wildcard characters, the command returns an error.
If you use wildcard characters, but do not find matching results, no error is returned.
(This follows standard wildcard character matching behavior for Windows PowerShell.)

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version of a single module to install.
You cannot add this parameter if you are attempting to install multiple modules.
The MinimumVersion and the RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: NameParameterSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies the installation scope of the module.
Valid values are: AllUsers and CurrentUser.

The AllUsers scope lets modules be installed in a location that is accessible to all users of the computer, that is, %systemdrive%:\ProgramFiles\WindowsPowerShell\Modules.

The CurrentUser scope lets modules be installed only to $home\Documents\WindowsPowerShell\Modules, so that the module is available only to the current user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

### -InputObject
{{Fill InputObject Description}}

```yaml
Type: PSObject[]
Parameter Sets: InputObject
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

### PSGetItemInfo

## OUTPUTS

## NOTES
This cmdlet runs on Windows PowerShell 3.0 or later releases of Windows PowerShell, on Windows 7 or Windows 2008 R2 and later releases of Windows.

If an installed module cannot be imported (that is, if it does not have a .psm1, .psd1, or .dll of the same name within the folder), installation fails unless you add the Force parameter to your command.

If a version of the module on the computer matches the value specified for the Name parameter, and you have not added the MinimumVersion or RequiredVersion parameter, Install-Module silently continues without installing that module.
If the MinimumVersion or RequiredVersion parameters are specified, and the existing module does not match the values in that parameter, then an error occurs.
To be more specific: if the version of the currently-installed module is either lower than the value of the MinimumVersion parameter, or not equal to the value of the RequiredVersion parameter, an error occurs.
If the version of the installed module is greater than the value of the MinimumVersion parameter, or equal to the value of the RequiredVersion parameter, Install-Module silently continues without installing that module.

Install-Module returns an error if no module exists in the online gallery that matches the specified name.

To install multiple modules, specify an array of the module names, separated by commas.
You cannot add MinimumVersion or RequiredVersion if you specify multiple module names.

By default, modules are installed to the Program Files folder, to prevent confusion when you are installing Windows PowerShell Desired State Configuration (DSC) resources.You can pipe multiple PSGetItemInfo objects to Install-Module; this is another way of specifying multiple modules to install in a single command.

To help prevent running modules that contain malicious code, installed modules are not automatically imported by installation.
As a security best practice, evaluate module code before running any cmdlets or functions in a module for the first time.

## RELATED LINKS

[Find-Module]()

[Publish-Module]()

[Uninstall-Module]()

[Update-Module]()

