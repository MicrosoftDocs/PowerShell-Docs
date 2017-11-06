---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=517135
external help file:  Microsoft.PowerShell.PackageManagement.dll-Help.xml
title:  Get-Package
---

# Get-Package

## SYNOPSIS
Returns a list of all software packages that have been installed by using Package Management.

## SYNTAX

### msi
```
Get-Package [[-Name] <String[]>] [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>]
 [-AdditionalArguments <String[]>] [<CommonParameters>]
```

### Programs
```
Get-Package [[-Name] <String[]>] [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>] [-IncludeWindowsInstaller]
 [-IncludeSystemComponent] [<CommonParameters>]
```

### PSModule
```
Get-Package [[-Name] <String[]>] [-RequiredVersion <String>] [-MinimumVersion <String>]
 [-MaximumVersion <String>] [-Force] [-ForceBootstrap] [-ProviderName <String[]>]
 [-PackageManagementProvider <String>] [-Location <String>] [-InstallUpdate] [-InstallationPolicy <String>]
 [-DestinationPath <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Package** cmdlet returns a list of all software packages on the local computer that have been installed by using Package Management.
You can run **Get-Package** on remote computers by running it as part of an Invoke-Command or Enter-PSSession command or script.

## EXAMPLES

### Example 1: Get all installed packages
```
PS C:\> Get-Package
```

This command gets all packages that are installed on the local computer.

### Example 2: Get packages that are installed on a remote computer
```
PS C:\> Invoke-Command -ComputerName "server01" -Credential "CONTOSO\TestUser" -ScriptBlock {Get-Package}
```

This command gets a list of packages that were installed on a remote computer, server01, by using Package Management.
When you run this command, you are prompted to provide credentials for the user CONTOSO\TestUser.

### Example 3: Get packages for a specified provider
```
PS C:\> Get-Package -Provider "ARP"
```

This command gets Add or Remove Programs software packages from the local computer.

### Example 4: Get an exact version of a specific package
```
PS C:\> Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1.2"
```

This command gets version 2.1.2 of a package named DSCAccelerator.
Although only part of the package name has been specified, **Get-Package** should be able to find the DSCAccelerator package if there are no other packages with a name matching that pattern.

### Example 5: Uninstall a package
```
PS C:\> Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1" | Uninstall-Package
```

This command pipes the results of a **Get-Package** command to the Uninstall-Package cmdlet.
In this example, you are uninstalling only version 2.1 of the DSCAccelerator package.
You are prompted to confirm that you want to uninstall the package.

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
{{Fill DestinationPath Description}}

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
Indicates that this cmdlet forces Package Management to automatically install the package provider.

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
{{Fill InstallationPolicy Description}}

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
{{Fill Location Description}}

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
Specifies the maximum allowed version of the package that you want to find.
If you do not add this parameter, **Get-Package** finds the highest available version of the package.

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
Specifies the minimum allowed version of the package that you want to find.
If you do not add this parameter, **Find-Package** finds the highest available version of the package that also satisfies any maximum specified version specified by the *MaximumVersion* parameter.

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
Specifies one or more package names, or package names with wildcard characters.
Separate multiple package names with commas.

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
Specifies the name of the Package Management provider.

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
Specifies one or more package provider names.
Separate multiple package provider names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Provider
Accepted values: msi, Programs, msu, Bootstrap, PSModule, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version of the package to find.
If you do not add this parameter, **Find-Package** finds the highest available version of the provider that also satisfies any maximum version specified by the **MaximumVersion** parameter.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### SoftwareIdentity[]

## NOTES

## RELATED LINKS

[about_PackageManagement](../Microsoft.PowerShell.Core/About/about_packagemanagement.md)

[Find-Package](Find-Package.md)

[Install-Package](Install-Package.md)

[Save-Package](Save-Package.md)

[Uninstall-Package](Uninstall-Package.md)

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[Enter-PSSession](../Microsoft.PowerShell.Core/Enter-PSSession.md)

