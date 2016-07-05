---
external help file: PSITPro5_OneGet.xml
online version: http://go.microsoft.com/fwlink/?LinkID=517135
schema: 2.0.0
---

# Get-Package
## SYNOPSIS
Returns a list of all software packages that have been installed by using Package Management.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-Package [[-Name] <String[]>] [-AdditionalArguments <String[]>] [-AllVersions] [-Force] [-ForceBootstrap]
 [-MaximumVersion <String>] [-MinimumVersion <String>] [-ProviderName] [-RequiredVersion <String>]
```

### UNNAMED_PARAMETER_SET_2
```
Get-Package [[-Name] <String[]>] [-AllVersions] [-Force] [-ForceBootstrap] [-IncludeSystemComponent]
 [-IncludeWindowsInstaller] [-MaximumVersion <String>] [-MinimumVersion <String>] [-ProviderName]
 [-RequiredVersion <String>]
```

### UNNAMED_PARAMETER_SET_3
```
Get-Package [[-Name] <String[]>] [-AllVersions] [-Force] [-ForceBootstrap] [-InstallUpdate]
 [-MaximumVersion <String>] [-MinimumVersion <String>] [-PackageManagementProvider <String>] [-ProviderName]
 [-RequiredVersion <String>] [-Scope] [-Type]
```

## DESCRIPTION
The Get-Package cmdlet returns a list of all software packages on the local computer that have been installed by using Package Management.
You can run Get-Package on remote computers by running it as part of an Invoke-Command or Enter-PSSession command or script.

## EXAMPLES

### Example 1: Get all installed packages
```
PS C:\>Get-Package
```

This command gets all packages that are installed on the local computer.

### Example 2: Get packages that are installed on a remote computer
```
PS C:\>Invoke-Command -ComputerName "server01" -Credential "CONTOSO\TestUser" -ScriptBlock {Get-Package}
```

This command gets a list of packages that were installed on a remote computer, server01, by using Package Management.
When you run this command, you are prompted to provide credentials for the user CONTOSO\TestUser.

### Example 3: Get packages for a specified provider
```
PS C:\>Get-Package -Provider "ARP"
```

This command gets Add or Remove Programs software packages from the local computer.

### Example 4: Get an exact version of a specific package
```
PS C:\>Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1.2"
```

This command gets version 2.1.2 of a package named DSCAccelerator.
Although only part of the package name has been specified, Get-Package should be able to find the DSCAccelerator package if there are no other packages with a name matching that pattern.

### Example 5: Uninstall a package
```
PS C:\>Get-Package -Name "DSCAccelerator" -RequiredVersion "2.1" | Uninstall-Package
```

This command pipes the results of a Get-Package command to the Uninstall-Package cmdlet.
In this example, you are uninstalling only version 2.1 of the DSCAccelerator package.
You are prompted to confirm that you want to uninstall the package.

## PARAMETERS

### -AdditionalArguments
Specifies additional arguments.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllVersions
Indicates that Get-Package returns all available versions of the package.
By default, Get-Package only returns the newest available version.

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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum allowed version of the package that you want to find.
If you do not add this parameter, Get-Package finds the highest available version of the package.

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
If you do not add this parameter, Find-Package finds the highest available version of the package that also satisfies any maximum specified version specified by the MaximumVersion parameter.

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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider
Specifies the name of the Package Management provider.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Provider
Accepted values: Programs, msi, msu, PowerShellGet, nuget, chocolatey

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version of the package to find.
If you do not add this parameter, Find-Package finds the highest available version of the provider that also satisfies any maximum version specified by the MaximumVersion parameter.

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

### -Scope
Specifies the search scope for the package.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 
Accepted values: CurrentUser, AllUsers

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies whether to search for packages with a module, a script, or either.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 
Accepted values: Module, Script, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### SoftwareIdentity[]

## NOTES

## RELATED LINKS

[about_PackageManagement](http://technet.microsoft.com/library/dn927162.aspx)

[Find-Package](7e47fec3-2b59-4724-989e-e594ce4869d6)

[Install-Package](6fa3aa2c-0817-408a-a7ff-01cd990aa869)

[Save-Package](f8a24112-8d22-49d5-820b-b0095f1a30ec)

[Uninstall-Package](0290e116-7753-4990-a29e-48f8166ef72d)

[Invoke-Command](906b4b41-7da8-4330-9363-e7164e5e6970)

[Enter-PSSession](4e1e012b-51df-4fea-9ff2-dc859eee13fe)

