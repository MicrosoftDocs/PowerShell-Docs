---
external help file: PSITPro5_PSGet.xml
online version: d70909ca-b3bd-4859-81f4-5b68731c8feb
schema: 2.0.0
---

# Save-Module
## SYNOPSIS
Saves a module locally without installing it.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Save-Module [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-Repository <String[]>] [-RequiredVersion <Version>] -Path <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Save-Module [-Name] <String[]> [-Force] [-MaximumVersion <Version>] [-MinimumVersion <Version>]
 [-Repository <String[]>] [-RequiredVersion <Version>] -LiteralPath <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Save-Module [-Force] -LiteralPath <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Save-Module [-Force] -Path <String> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Save-Module cmdlet saves a module locally from the specified repository for inspection.
The module is not installed.

## EXAMPLES

### Example 1: Find modules and save them locally
```
PS C:\>Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.3.5      AzureAutomationDebug                Module     PSGallery            Module for debugging Azure Automation runbooks, emulating AA native cmdlets PS C:\>Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery" -IncludeDependencies
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.3.5      AzureAutomationDebug                Module     PSGallery            Module for debugging Azure Automation runbooks, emulating AA native cmdlets
1.0.1      AzureRM.Automation                  Module     PSGallery            Microsoft Azure PowerShell - Automation service cmdlets for Azure Resource Manager
1.0.1      AzureRM.profile                     Module     PSGallery            Microsoft Azure PowerShell - Profile credential management cmdlets for Azure Resource Manager PS C:\>Find-Module -Name "AzureAutomationDebug" -Repository "PSGallery" | Save-Module -Path "C:\MyLocalModules\"
PS C:\> dir C:\MyLocalModules\
    Directory: C:\MyLocalModules


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       12/14/2015  11:20 AM                AzureAutomationDebug
d-----       12/14/2015  11:20 AM                AzureRM.Automation
d-----       12/14/2015  11:20 AM                AzureRM.profile PS C:\>Save-Module -LiteralPath "C:\MyLocalModules\" -Name "xPSDesiredStateConfiguration" -Repository "PSGallery" -MinimumVersion 2.0 -MaximumVersion 3.5.0
PS C:\> dir C:\MyLocalModules
   Directory: C:\MyLocalModules


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       12/14/2015  11:22 AM                xPSDesiredStateConfiguration
```

The first command uses the Find-Module cmdlet to find the AzureAutomationDebug module in the PSGallery repository and displays the results.

The second command uses Find-Module to find the AzureAutomationDebug module and its dependencies, and displays the results.

The third command uses Find-Module to find the AzureAutomationDebug module, and then uses the pipeline operator to pass the module to the Save-Module cmdlet, which save the module to the specified folder.

The fourth command displays the contents of the saved module.

The fifth command saves the specified versions of the module xPSDesiredStateConfiguration to C:\MyLocalModules.

The final command displays the contents of the C:\MyLocalModules folder.

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

### -LiteralPath
Specifies a path to one or more locations.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Windows PowerShell does not interpret any characters that are enclosed in single quotation marks as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumVersion
Specifies the maximum, or newest, version of the module to save.
The MaximumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of a single module to save.
You cannot add this parameter if you are attempting to install multiple modules.
The MinimumVersion and RequiredVersion parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of modules to save.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to the module that you want to publish.
This parameter accepts either the path to the folder that contains the module, or the module manifest (.psd1) file.
The parameter accepts piped values from Get-Module.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the exact version number of the module to save.

```yaml
Type: Version
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
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

[Find-Module](d70909ca-b3bd-4859-81f4-5b68731c8feb)

[Import-Module](af616c24-e122-4098-930e-1e3ea2080ade)

[Publish-Module](074815a6-779e-4e5f-a291-6677550c6f45)

[Uninstall-Module](970bfdf8-9f4a-4cac-b015-5e6cbf1b59b6)

[Update-Module](7557593d-d028-4e42-8e65-6180f88d7fb9)

