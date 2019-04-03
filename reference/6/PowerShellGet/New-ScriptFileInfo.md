---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822329
schema: 2.0.0
title: New-ScriptFileInfo
---

# New-ScriptFileInfo

## SYNOPSIS
Creates a script file with metadata.

## SYNTAX

```
New-ScriptFileInfo [[-Path] <String>] [-Version <String>] [-Author <String>] -Description <String>
 [-Guid <Guid>] [-CompanyName <String>] [-Copyright <String>] [-RequiredModules <Object[]>]
 [-ExternalModuleDependencies <String[]>] [-RequiredScripts <String[]>]
 [-ExternalScriptDependencies <String[]>] [-Tags <String[]>] [-ProjectUri <Uri>] [-LicenseUri <Uri>]
 [-IconUri <Uri>] [-ReleaseNotes <String[]>] [-PrivateData <String>] [-PassThru] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-ScriptFileInfo** cmdlet creates a PowerShell script file, including metadata about the script.

## EXAMPLES

### Example 1: Create a script file and specify its version, author, and description
```
PS C:\> New-ScriptFileInfo -Path "\temp\Temp-Scriptfile.ps1" -Version 1.0 -Author "pattif@contoso.com" -Description "My test script file description goes here"
PS C:\> Get-Content -Path "\temp\Temp-Scriptfile.ps1"
<#PSScriptInfo

.VERSION 1.0

.GUID eb246b19-17da-4392-8c89-7c280f69ad0e

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
Param() PS C:\> Test-ScriptFileInfo -Path "\temp\Temp-Scriptfile.ps1"
Version    Name                      Author               Description
-------    ----                      ------               -----------
1.0        temp-scriptfile           pattif@contoso.com   my test script file description goes here
```

The first command creates the script file Temp-Scriptfile.ps1 and sets the Version, Author, and Description properties for it.

The second command uses the Get-Content cmdlet to get the contents of the script file and display them.

### Example 2: Create a script file with all of the metadata properties
```
PS C:\> New-ScriptFileInfo -Path "C:\temp\temp_scripts\New-ScriptFile.ps1" -Verbose
>> -Version 1.0 -Author pattif -Description "my new script file test" -CompanyName "Contoso Corporation" `
>> -Copyright "2015 Contoso Corporation. All rights reserved." -ExternalModuleDependencies 'ff','bb' `
>> -RequiredScripts 'Start-WFContosoServer', 'Stop-ContosoServerScript' `
>> -ExternalScriptDependencies Stop-ContosoServerScript -Tags @('Tag1', 'Tag2', 'Tag3') `
>> -ProjectUri https://contoso.com -LicenseUri "https://contoso.com/License" -IconUri 'https://contoso.com/Icon' `
>> -Verbose -PassThru `
>> -ReleaseNotes @('contoso script now supports following features',
>>          'Feature 1',
>>          'Feature 2',
>>          'Feature 3',
>>          'Feature 4',
>>          'Feature 5') `
>> -RequiredModules "1","2",RequiredModule1,@{ModuleName='RequiredModule2';ModuleVersion='1.0'},@{ModuleName='RequiredModule3';RequiredVersion='2.0'},ExternalModule1 `
>>
VERBOSE: Performing the operation "Creating the 'C:\temp\temp_scripts\New-ScriptFile.ps1' PowerShell Script file" on target "C:\temp\temp_scripts\New-ScriptFile.ps1".

<#PSScriptInfo

.VERSION 1.0

.GUID eb246b19-17da-4392-8c89-7c280f69ad0a

.AUTHOR pattif

.COMPANYNAME Microsoft Corporation

.COPYRIGHT 2015 Microsoft Corporation. All rights reserved.

.TAGS Tag1 Tag2 Tag3

.LICENSEURI https://contoso.com/License

.PROJECTURI https://contoso.com/

.ICONURI https://contoso.com/Icon

.EXTERNALMODULEDEPENDENCIES ff,bb

.REQUIREDSCRIPTS Start-WFContosoServer,Stop-ContosoServerScript

.EXTERNALSCRIPTDEPENDENCIES Stop-ContosoServerScript

.RELEASENOTES
contoso script now supports following features
Feature 1
Feature 2
Feature 3
Feature 4
Feature 5

#>

#Requires -Modules Module1
#Requires -Modules Module2
#Requires -Modules RequiredModule1
#Requires -Modules @{ModuleName = 'RequiredModule2'; ModuleVersion = '1.0'}
#Requires -Modules @{RequiredVersion = '2.0'; ModuleName = 'RequiredModule3'}
#Requires -Modules ExternalModule1

<#

.DESCRIPTION
 my new script file test

#>
Param()
```

This command creates a script file New-ScriptFile.ps1 with all of its metadata properties.
The *Verbose* parameter specifies that the command display verbose output.

## PARAMETERS

### -Author
Specifies the script author.

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

### -CompanyName
Specifies the company or vendor who created the script.

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

### -Copyright
Specifies a copyright statement for the script.

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

### -Description
Specifies a description for the script.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalModuleDependencies
Specifies an array of external module dependencies.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalScriptDependencies
Specifies an array of external script dependencies.

```yaml
Type: String[]
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

### -Guid
Specifies a unique ID for the script.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconUri
Specifies the URL of an icon for the script.
The specified icon is displayed on the gallery web page for the script.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenseUri
Specifies the URL of licensing terms.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path to the module manifest file to update.
Wildcards are permitted.
The default location is the current directory (.)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PrivateData
Specifies private data for the script.

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

### -ProjectUri
Specifies the URL of a web page about this project.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReleaseNotes
Specifies a string array that contains release notes or comments that you want to be available to users of this version of the script.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredModules
Specifies modules that must be in the global session state.
If the required modules are not in the global session state, PowerShell imports them.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredScripts
Specifies an array of required scripts.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
Specifies an array of tags.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Specifies the version of the script.

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

[Test-ScriptFileInfo](Test-ScriptFileInfo.md)

[Update-ScriptFileInfo](Update-ScriptFileInfo.md)
