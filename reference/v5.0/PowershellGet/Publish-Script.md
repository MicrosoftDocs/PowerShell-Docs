---
external help file: PSITPro5_PSGet.xml
online version: ba918f1e-1606-4cfd-b0ff-2c2eb821f586
schema: 2.0.0
---

# Publish-Script
## SYNOPSIS
Publishes a script.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Publish-Script [-NuGetApiKey <String>] [-Repository <String>] -LiteralPath <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Publish-Script [-NuGetApiKey <String>] [-Repository <String>] -Path <String> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Publish-Script cmdlet publishes the specified script to the online gallery.

## EXAMPLES

### Example 1: Create a script file, add content to it, and publish it
```
PS C:\>New-ScriptFileInfo -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Version 1.0 -Author "pattif@microsoft.com" -Description "my test script file description goes here"
PS C:\> Get-Content -Path "D:\ScriptSharingDemo\Demo-Script.ps1"
<#PSScriptInfo

.VERSION 1.0

.AUTHOR pattif@microsoft.com

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 my test script file description goes here 

#> 
Param() PS C:\>Add-Content -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Value @"

Function Demo-ScriptFunction { 'Demo-ScriptFunction' }

Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }

Demo-ScriptFunction
Demo-ScriptWorkflow
"@
PS C:\> Test-ScriptFileInfo -Path "D:\ScriptSharingDemo\Demo-Script.ps1"
Version    Name                      Author               Description                                                                                
-------    ----                      ------               -----------                                                                                
1.0        Demo-Script               pattif@microsoft.com my test script file description goes here PS C:\>Publish-Script -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Repository "LocalRepo1"
PS C:\> Find-Script -Repository "LocalRepo1" -Name "Demo-Script"
Version    Name                                Type       Repository           Description                                                           
-------    ----                                ----       ----------           -----------                                                           
1.0        Demo-Script                         Script     LocalRepo1           my test script file description goes here
```

The first command uses the New-ScriptFileInfo cmdlet to create a script file named Demo-Script.ps1.

The second command uses the Get-Content cmdlet to get the content of Demo-Script.ps1 and display it.

The third command uses the Add-Content cmdlet to add a function and a workflow to Demo-Script.

The fourth command uses the Test-ScriptFileInfo cmdlet to validate Demo-Script and display the results.

The fifth command uses the Publish-Script cmdlet to publish Demo-Script.ps1 to the LocalRepo1 repository and display the results.

The final command uses the Find-Script cmdlet to find Demo-Script.ps1 in the LocalRepo1 repository.

## PARAMETERS

### -LiteralPath
Specifies a path to one or more locations.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -NuGetApiKey
Specifies the API key that you want to use to publish a script to the online gallery.
The API key is part of your profile in the online gallery, and can be found on your user account page in the gallery.
The API key is NuGet-specific functionality.

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

### -Path
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (.).

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -Repository
Specifies the friendly name of a repository that has been registered by running Register-PSRepository.

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

[Install-Script](ad041750-9866-43b1-af85-077f2b2efae0)

[Publish-Script](e8bdc076-6514-4e00-b16d-23e7d5fd4d13)

[Save-Script](e4f6f4ae-94fd-4ac2-adab-d3465dafb562)

[Update-Script](aa68486d-6ad6-495f-a1bb-67752ca8ed79)

