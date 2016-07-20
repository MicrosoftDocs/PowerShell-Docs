# New-ScriptFileInfo

Creates a script file with metadata.

## Description

The New-ScriptFileInfo cmdlet creates a PowerShell script file, including metadata about the script.

## Cmdlet syntax

```powershell
Get-Command -Name New-ScriptFileInfo -Module PowerShellGet -Syntax
```

## Cmdlet online help reference

[New-ScriptFileInfo](http://go.microsoft.com/fwlink/?LinkId=619792)

## Example commands

### PassThru parameter

```powershell
New-ScriptFileInfo -Description "Script file description." -PassThru
```

### New-ScriptFileInfo cmdlet
New-ScriptFileInfo cmdlet lets you to create a new script file with metadata like Version, Guid, Author, and Description, etc. 

```powershell
# Create a new script file with minimum required metadata values
New-ScriptFileInfo -Path C:\ScriptSharingDemo\Demo-Script.ps1 -Description "Script file description goes here"

Get-Content -Path C:\ScriptSharingDemo\Demo-Script.ps1
<#PSScriptInfo
.VERSION 1.0
.GUID 926b47c3-6af2-4b18-b6f5-8b813a9e93ab
.AUTHOR manikb
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
Script file description goes here
#>
Param()

# Validate and get the script metadata
Test-ScriptFileInfo -Path C:\ScriptSharingDemo\Demo-Script.ps1
Version Name Author Description
------- ---- ------ -----------
1.0 Demo-Script manikb Script file description goes here

# Add function and workflow to the script file
Add-Content -Path C:\ScriptSharingDemo\Demo-Script.ps1 -Value @"
   
    Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
   
    Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
   
    Demo-ScriptFunction
    Demo-ScriptWorkflow
"@

# Validate and get the script metadata
Test-ScriptFileInfo -Path C:\ScriptSharingDemo\Demo-Script.ps1

Version Name Author Description
------- ---- ------ -----------
1.0 Demo-Script manikb Script file description goes here

# Create a script file all metadata properties
New-ScriptFileInfo -Path 'C:\ScriptSharingDemo\Demo-ScriptWithCompletePSScriptInfo.ps1' `
    -Version 1.0 `
    -Author 'manikb' `
    -Description "my new script file" `
    -CompanyName "Microsoft Corporation" `
    -Copyright "(c) 2015 Microsoft Corporation. All rights reserved." `
    -Tags @('Tag1', 'Tag2', 'Tag3') `
    -ProjectUri 'https://contoso.com' `
    -LicenseUri "https://contoso.com/License" `
    -IconUri 'https://contoso.com/Icon' `
    -ReleaseNotes @('contoso script now supports following features',
    'Feature 1',
    'Feature 2',
    'Feature 3',
    'Feature 4',
    'Feature 5') `
    -RequiredModules @('RequiredModule1',
    @{ModuleName='RequiredModule2';ModuleVersion='1.0'},
    @{ModuleName='RequiredModule3';RequiredVersion='2.0'},
    @{ModuleName = 'RequiredModule4'; ModuleVersion = '0.1'; MaximumVersion = '1.*'; },
    @{ModuleName = 'RequiredModule5'; MaximumVersion = '1.*'; },
    'ExternalModule1') `
    -ExternalModuleDependencies 'ExternalModule1' `
    -RequiredScripts 'Start-WFContosoServer', 'Stop-ContosoServerScript', 'ExternalScript1' `
    -ExternalScriptDependencies 'ExternalScript1'

# Add function and workflow to the script file
Add-Content -Path 'C:\ScriptSharingDemo\Demo-ScriptWithCompletePSScriptInfo.ps1' -Value @"
   
    Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
   
    Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
   
    Demo-ScriptFunction
    Demo-ScriptWorkflow
"@

Get-Content -Path C:\ScriptSharingDemo\Demo-ScriptWithCompletePSScriptInfo.ps1

<#PSScriptInfo
.VERSION 1.0
.GUID fe4cc121-f87e-4ddb-8186-ff362e23a935
.AUTHOR manikb
.COMPANYNAME Microsoft Corporation
.COPYRIGHT (c) 2015 Microsoft Corporation. All rights reserved.
.TAGS Tag1 Tag2 Tag3
.LICENSEURI https://contoso.com/License
.PROJECTURI https://contoso.com/
.ICONURI https://contoso.com/Icon
.EXTERNALMODULEDEPENDENCIES ExternalModule1
.REQUIREDSCRIPTS Start-WFContosoServer,Stop-ContosoServerScript,ExternalScript1
.EXTERNALSCRIPTDEPENDENCIES ExternalScript1
.RELEASENOTES
contoso script now supports following features
Feature 1
Feature 2
Feature 3
Feature 4
Feature 5
#>
#Requires -Module RequiredModule1
#Requires -Module @{ModuleName = 'RequiredModule2'; ModuleVersion = '1.0'}
#Requires -Module @{RequiredVersion = '2.0'; ModuleName = 'RequiredModule3'}
#Requires -Module @{ModuleVersion = '0.1'; ModuleName = 'RequiredModule4'; MaximumVersion = '1.*'}
#Requires -Module @{MaximumVersion = '1.*'; ModuleName = 'RequiredModule5'}
#Requires -Module ExternalModule1
<#
.DESCRIPTION
my new script file
#>
Param()
Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
Demo-ScriptFunction
Demo-ScriptWorkflow

# Validate and get the script metadata
Test-ScriptFileInfo C:\ScriptSharingDemo\Demo-ScriptWithCompletePSScriptInfo.ps1 | Format-List * -Force

Name : Demo-ScriptWithCompletePSScriptInfo
Version : 1.0
Guid : fe4cc121-f87e-4ddb-8186-ff362e23a935
Path : C:\ScriptSharingDemo\Demo-ScriptWithCompletePSScriptInfo.ps1
ScriptBase : C:\ScriptSharingDemo
Description : my new script file
Author : manikb
CompanyName : Microsoft Corporation
Copyright : (c) 2015 Microsoft Corporation. All rights reserved.
Tags : {Tag1, Tag2, Tag3}
ReleaseNotes : {contoso script now supports following features, Feature 1, Feature 2, Feature 3...}
RequiredModules : {RequiredModule1, @{ ModuleName = 'RequiredModule2'; ModuleVersion = '1.0' }, @{ ModuleName = 'RequiredModule3'; RequiredVersion = '2.0' }, @{ ModuleName = 'RequiredModule4'; ModuleVersion = '0.1';
MaximumVersion = '1.*' }...}
ExternalModuleDependencies : ExternalModule1
RequiredScripts : {Start-WFContosoServer, Stop-ContosoServerScript, ExternalScript1}
ExternalScriptDependencies : ExternalScript1
LicenseUri : https://contoso.com/License
ProjectUri : https://contoso.com/
IconUri : https://contoso.com/Icon
DefinedCommands : {Demo-ScriptFunction, Demo-ScriptWorkflow}
DefinedFunctions : Demo-ScriptFunction
DefinedWorkflows : Demo-ScriptWorkflow
```
