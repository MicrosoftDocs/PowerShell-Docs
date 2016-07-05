---
external help file: PSITPro5_PSGet.xml
online version: ba918f1e-1606-4cfd-b0ff-2c2eb821f586
schema: 2.0.0
---

# Install-Script
## SYNOPSIS
Installs a script.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Install-Script [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-NoPathUpdate] [-Repository <String[]>] [-RequiredVersion <Version>] [-Scope] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Install-Script [-Force] [-NoPathUpdate] [-Scope] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Install-Script cmdlet acquires a script payload from a repository, verifies that the payload is a valid PowerShell script, and copies the script file to a specified installation location.

The default repositories Install-Script operates against are configurable through the Register-PSRepository, Set-PSRepository, Unregister-PSRepository, and Get-PSRepository cmdlets.
When operating against multiple repositories, Install-Script installs the first script that matches the specified search criteria (Name, MinimumVersion, or MaximumVersion) from the first repository without any error.

## EXAMPLES

### Example 1: Find a script and install it
```
PS C:\>Find-Script -Repository "Local1" -Name "Required-Script2"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script PS C:\>Find-Script -Repository "Local1" -Name "Required-Script2" | Install-Script
PS C:\> Get-Command -Name "Required-Script2"
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
ExternalScript  Required-Script2.ps1                                2.0       C:\Users\pattif\Documents\WindowsPowerShell\Scripts\Required-Script2.ps1 PS C:\>Get-InstalledScript -Name "Required-Script2"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script PS C:\>Get-InstalledScript -Name "Required-Script2" | Format-List * 
Name                       : Required-Script2
Version                    : 2.5
Type                       : Script
Description                : Description for the Required-Script2 script
Author                     : pattif
CompanyName                : 
Copyright                  : © 2015 Microsoft Corporation. All rights reserved. 
PublishedDate              : 8/15/2015 12:42:39 AM
LicenseUri                 : http://required-script2.com/license
ProjectUri                 : http://required-script2.com/
IconUri                    : http://required-script2.com/icon
Tags                       : {Tag1, Tag2, Tag-Required-Script2-2.5, PSScript...} 
Includes                   : {Function, DscResource, Cmdlet, Command}
PowerShellGetFormatVersion : 
ReleaseNotes               : Required-Script2 release notes
Dependencies               : {}
RepositorySourceLocation   : http://pattif-dev:8765/api/v2/
Repository                 : local1
PackageManagementProvider  : NuGet
InstalledLocation          : C:\Users\pattif\Documents\WindowsPowerShell\Scripts
```

The first command finds the script named Required-Script2 from the Local1 repository and displays the results.

The second command finds the Required-Script2 script, and then uses the pipeline operator to pass it to the Install-Script cmdlet to install it.

The third command uses the Get-Command cmdlet to get Required-Script2, and then displays the results.

The fourth command uses the Get-InstalledScript cmdlet to get Required-Script2 and display the results.

The fifth command gets RequiredScript2 and uses the pipeline operator to pass it to the Format-List cmdlet to format the output.

### Example 2: Install a script with AllUsers scope
```
PS C:\>Install-Script -Repository "Local1" -Name "Required-Script3" -Scope "AllUsers"
PS C:\> Get-InstalledScript -Name "Required-Script3"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script3                    Script     local1               Description for the Required-Script3 script PS C:\>Get-InstalledScript -Name "Required-Script3" | Format-List * 
Name                       : Required-Script3
Version                    : 2.5
Type                       : Script
Description                : Description for the Required-Script3 script
Author                     : pattif
CompanyName                : 
Copyright                  : © 2015 Microsoft Corporation. All rights reserved. 
PublishedDate              : 8/15/2015 12:42:45 AM
LicenseUri                 : http://required-script3.com/license
ProjectUri                 : http://required-script3.com/
IconUri                    : http://required-script3.com/icon
Tags                       : {Tag1, Tag2, Tag-Required-Script3-2.5, PSScript...} 
Includes                   : {Function, DscResource, Cmdlet, Command}
PowerShellGetFormatVersion : 
ReleaseNotes               : Required-Script3 release notes
Dependencies               : {}
RepositorySourceLocation   : http://pattif-dev:8765/api/v2/
Repository                 : local1
PackageManagementProvider  : NuGet
InstalledLocation          : C:\Program Files\WindowsPowerShell\Scripts
```

The first command installs the script named Required-Script3 and assigns it AllUsers scope.

The second command gets the installed script Required-Script3 and displays information about it.

The third command gets Required-Script3 and uses the pipeline operator to pass it to the Format-List cmdlet to format the output.

### Example 3: Install a script with its dependent scripts and modules
```
PS C:\>Find-Script -Repository "Local1" -Name "Script-WithDependencies2" -IncludeDependencies
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.0        Script-WithDependencies2            Script     local1               Description for the Script-WithDependencies2 script
2.5        RequiredModule1                     Module     local1               RequiredModule1 module
2.5        RequiredModule2                     Module     local1               RequiredModule2 module
2.5        RequiredModule3                     Module     local1               RequiredModule3 module
2.5        Required-Script1                    Script     local1               Description for the Required-Script1 script
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script
2.5        Required-Script3                    Script     local1               Description for the Required-Script3 script PS C:\>Install-Script -Repository "Local1" -Name "Script-WithDependencies2"
PS C:\> Get-InstalledScript
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script1                    Script     local1               Description for the Required-Script1 script
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script
2.5        Required-Script3                    Script     local1               Description for the Required-Script3 script
2.0        Script-WithDependencies2            Script     local1               Description for the Script-WithDependencies2 script PS C:\>Get-InstalledModule
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        RequiredModule1                     Module     local1               RequiredModule1 module
2.5        RequiredModule2                     Module     local1               RequiredModule2 module
2.5        RequiredModule3                     Module     local1               RequiredModule3 module PS C:\>Find-Script -Repository "Local1" -Name "Required-Script*"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script1                    Script     local1               Description for the Required-Script1 script
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script
2.5        Required-Script3                    Script     local1               Description for the Required-Script3 script PS C:\>Install-Script -Repository "Local1" -Name "Required-Script*"
PS C:\> Get-InstalledScript
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        Required-Script1                    Script     local1               Description for the Required-Script1 script
2.5        Required-Script2                    Script     local1               Description for the Required-Script2 script
2.5        Required-Script3                    Script     local1               Description for the Required-Script3 script
```

The first command finds the script named Script-WithDependencies2 and its dependencies in the Local1 repository and displays the results.

The second command installs Script-WithDependencies2.

The third command uses the Get-InstalledScript script cmdlet to get installed scripts and display the results.

The fourth command uses the Get-InstalledModule cmdlet to get installed modules and display the results.

The fifth command uses the Find-Script cmdlet to find scripts where the name begins with Required-Script and display the results.

The sixth command installs the scripts where the name begins with Required-Script in the Local1 repository.

The final command gets installed scripts and displays the results.

## PARAMETERS

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

### -MaximumVersion
Specifies the maximum, or newest, version of the script to install.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.
This parameter accepts the wildcard character (*).

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of the script to install.
The MinimumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of scripts to install.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -NoPathUpdate
@{Text=}

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

### -Repository
Specifies the friendly name of a repository that has been registered with the Register-PSRepository cmdlet.
The default is all registered repositories.

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

### -RequiredVersion
Specifies the exact version number of the script to install.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies the installation scope of the script.
Valid values are: AllUsers and CurrentUser.
The default is CurrentUser.

The AllUsers scope specifies to install a script to %systemdrive%:\ProgramFiles\WindowsPowerShell\Scripts so that the script is available to all users.
The CurrentUser scope specifies to install the script in $home\Documents\WindowsPowerShell\Scripts so that the script is available only to the current user.

```yaml
Type: SwitchParameter
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
Aliases: 

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
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Find-Script](ba918f1e-1606-4cfd-b0ff-2c2eb821f586)

[Publish-Script](e8bdc076-6514-4e00-b16d-23e7d5fd4d13)

[Save-Script](e4f6f4ae-94fd-4ac2-adab-d3465dafb562)

[Uninstall-Script](22014a04-4bf6-4d13-98cd-7717567da987)

[Update-Script](aa68486d-6ad6-495f-a1bb-67752ca8ed79)

