---
external help file: PSITPro5_PSGet.xml
online version: 8114bf0a-5c4d-45c1-96e6-9242013685df
schema: 2.0.0
---

# Update-ScriptFileInfo
## SYNOPSIS
Updates information for a script.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Update-ScriptFileInfo [-Path] <String> [-Author <String>] [-CompanyName <String>] [-Copyright <String>]
 [-Description <String>] [-ExternalModuleDependencies <String[]>] [-ExternalScriptDependencies <String[]>]
 [-Force] [-Guid <Guid>] [-IconUri <Uri>] [-LicenseUri <Uri>] [-PassThru] [-ProjectUri <Uri>]
 [-ReleaseNotes <String[]>] [-RequiredModules <Object[]>] [-RequiredScripts <String[]>] [-Tags <String[]>]
 [-Version <Version>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Update-ScriptFileInfo [-LiteralPath] <String> [-Author <String>] [-CompanyName <String>] [-Copyright <String>]
 [-Description <String>] [-ExternalModuleDependencies <String[]>] [-ExternalScriptDependencies <String[]>]
 [-Force] [-Guid <Guid>] [-IconUri <Uri>] [-LicenseUri <Uri>] [-PassThru] [-ProjectUri <Uri>]
 [-ReleaseNotes <String[]>] [-RequiredModules <Object[]>] [-RequiredScripts <String[]>] [-Tags <String[]>]
 [-Version <Version>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Update-ScriptFileInfo cmdlet updates information for a script.

## EXAMPLES

### Example 1: Update the version of a script file
```
PS C:\>New-ScriptFileInfo -Path "\temp\temp-scriptfile.ps1" -Version 1.0 -Author "pattif@contoso.com" -Description "my test script file description goes here"
PS C:\> Test-ScriptFileInfo -Path "\temp\temp-scriptfile.ps1"
Version    Name                      Author               Description
-------    ----                      ------               -----------
1.0        temp-scriptfile           manikb@microsoft.com my test script file description goes here PS C:\>Update-ScriptFileInfo -Path "\temp\temp-scriptfile.ps1" -Version 2.0 -PassThru
<#PSScriptInfo

.VERSION 2.0
.GUID eb246b19-17da-4392-8c89-7c280f69ad0e
.AUTHOR manikb@microsoft.com
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
Param()
```

The first command creates a script file and assigns it version 1.0.

The second command uses the Test-ScriptFileInfo cmdlet to validate temp-scriptfile.ps1 and display the results.

The third command uses Update-ScriptFileInfo to update the version number to 2.0.

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

Required: False
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
Specifies a unique ID for a script.

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

### -LiteralPath
Specifies a path to one or more locations.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as it is entered.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose them in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
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
Specifies a path to one or more locations.
Wildcards are permitted.
The default location is the current directory (.).

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByPropertyName)
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
Specifies a string array that contains release notes or comments that you want to be available to users for this version of the script.

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
If the required modules are not in the global session state, Windows PowerShell imports them.

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
Type: Version
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

[New-ScriptFileInfo](8114bf0a-5c4d-45c1-96e6-9242013685df)

[Test-ScriptFileInfo](ea033033-3e11-4d25-a3e0-8137c586e5d1)

