---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822331
schema: 2.0.0
title: Publish-Script
---
# Publish-Script

## SYNOPSIS
Publishes a script.

## SYNTAX

### PathParameterSet (Default)

```
Publish-Script -Path <String> [-NuGetApiKey <String>] [-Repository <String>] [-Credential <PSCredential>]
 [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPathParameterSet

```
Publish-Script -LiteralPath <String> [-NuGetApiKey <String>] [-Repository <String>]
 [-Credential <PSCredential>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Publish-Script** cmdlet publishes the specified script to the online gallery.

## EXAMPLES

### Example 1: Create a script file, add content to it, and publish it

```
PS C:\> New-ScriptFileInfo -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Version 1.0 -Author "pattif@microsoft.com" -Description "my test script file description goes here"
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
Param() PS C:\> Add-Content -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Value @"

Function Demo-ScriptFunction { 'Demo-ScriptFunction' }

Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }

Demo-ScriptFunction
Demo-ScriptWorkflow
"@
PS C:\> Test-ScriptFileInfo -Path "D:\ScriptSharingDemo\Demo-Script.ps1"
Version    Name                      Author               Description
-------    ----                      ------               -----------
1.0        Demo-Script               pattif@microsoft.com my test script file description goes here
PS C:\> Publish-Script -Path "D:\ScriptSharingDemo\Demo-Script.ps1" -Repository "LocalRepo1"
PS C:\> Find-Script -Repository "LocalRepo1" -Name "Demo-Script"
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
1.0        Demo-Script                         Script     LocalRepo1           my test script file description goes here
```

The first command uses the New-ScriptFileInfo cmdlet to create a script file named Demo-Script.ps1.

The second command uses the Get-Content cmdlet to get the content of Demo-Script.ps1 and display it.

The third command uses the Add-Content cmdlet to add a function and a workflow to Demo-Script.

The fourth command uses the Test-ScriptFileInfo cmdlet to validate Demo-Script and display the results.

The fifth command uses the **Publish-Script** cmdlet to publish Demo-Script.ps1 to the LocalRepo1 repository and display the results.

The final command uses the Find-Script cmdlet to find Demo-Script.ps1 in the LocalRepo1 repository.

## PARAMETERS

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
Unlike the *Path* parameter, the value of the *LiteralPath* parameter is used exactly as entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralPathParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Parameter Sets: PathParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
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

[Find-Script](Find-Script.md)

[Install-Script](Install-Script.md)

[Publish-Script](Publish-Script.md)

[Save-Script](Save-Script.md)

[Update-Script](Update-Script.md)