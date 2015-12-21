# PowerShellGet Cmdlets for Script Management

## Find-Script cmdlet
Find-Script cmdlet lets you to discover the script files with different search criteria like name, tag, filter, command name, version range, exact version, all versions, including its dependencies and from specific or all registered repositories.

Example usage:
```powershell
\# Find a script from the registered repository with ScriptSourceLocation
Find-Script -Repository GalleryINT -Name Required-Script2

\# Find all available scripts in a specified repository
Find-Script -Repository GalleryINT

\# Find script output with all properties in PSRepositoryItemInfo object.
Find-Script -Name Required-Script2 -RequiredVersion 2.0 -Repository GalleryINT | Format-List \* -Force

\# Find a script within the specified minimum and maximum version range.
Find-Script -Name Required-Script2 -MinimumVersion 2.1 -MaximumVersion 2.5 -Repository GalleryINT

\# Find a script from the registered repository with ScriptSourceLocation
Find-Script -Repository GalleryINT -Name Required-Script2
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script

\# Find all available scripts in a specified repository
Find-Script -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Fabrikam-ServerScript Script GalleryINT Description for the Fabrikam-ServerScript script
2.5 Fabrikam-ClientScript Script GalleryINT Description for the Fabrikam-ClientScript script
3.0 TestScript Script GalleryINT This is a test script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script
2.0 Script-WithDependencies1 Script GalleryINT Description for the Script-WithDependencies1 script
2.5 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script

\# Find script output with all properties in PSRepositoryItemInfo object.
Find-Script -Name Required-Script2 -RequiredVersion 2.0 -Repository GalleryINT | Format-List \* -Force
Name : Required-Script2
Version : 2.0
Type : Script
Description : Description for the Required-Script2 script
Author : manikb
CompanyName :
Copyright : (c) 2015 Microsoft Corporation. All rights reserved.
PublishedDate : 10/30/2015 1:25:11 AM
LicenseUri : http://required-script2.com/license
ProjectUri : http://required-script2.com/
IconUri : http://required-script2.com/icon
Tags : {Tag1, Tag2, Tag-Required-Script2-2.0, PSScript}
Includes : {Function, DscResource, Cmdlet, Workflow...}
PowerShellGetFormatVersion :
ReleaseNotes : Required-Script2 release notes
Dependencies : {}
RepositorySourceLocation : https://customgallery.cloudapp.net/api/v2/
Repository : GalleryINT
PackageManagementProvider : NuGet
AdditionalMetadata : {Created, ItemType, copyright, PackageManagementProvider...}

\# Find a script within the specified minimum and maximum version range.
Find-Script -Name Required-Script2 -MinimumVersion 2.1 -MaximumVersion 2.5 -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script

\# Find all versions of a script.
Find-Script -Name Required-Script2 -AllVersions -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.0 Required-Script2 Script GalleryINT Description for the Required-Script2 script
1.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
1.0 Required-Script2 Script GalleryINT Description for the Required-Script2 script

\# Find script with wildcards
Find-Script -Name Required-Script\* -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script

\# Find a script with its dependent modules and scripts
Find-Script -Name Script-WithDependencies1 -IncludeDependencies -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Script-WithDependencies1 Script GalleryINT Description for the Script-WithDependencies1 script
2.5 RequiredModule1 Module GalleryINT RequiredModule1 module
2.5 RequiredModule2 Module GalleryINT RequiredModule2 module
2.5 RequiredModule3 Module GalleryINT RequiredModule3 module
2.0 RequiredModule4 Module GalleryINT RequiredModule4 module
1.5 RequiredModule5 Module GalleryINT RequiredModule5 module
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script

\# Find scripts with specified command name
Find-Script -Tag Tag-Fabrikam-ClientScript-2.5 -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Fabrikam-ClientScript Script GalleryINT Description for the Fabrikam-ClientScript script

\# Find scripts with -Filter
Find-Script -Filter ServerScript -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Fabrikam-ServerScript Script GalleryINT Description for the Fabrikam-ServerScript script

\# Find scripts with specified command name
Find-Script -Command Test-FunctionFromScript\_Required-Script3 -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script

\# Find scripts with workflows
Find-Script -Includes Workflow -Repository GalleryINT
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Fabrikam-ServerScript Script GalleryINT Description for the Fabrikam-ServerScript script
2.5 Fabrikam-ClientScript Script GalleryINT Description for the Fabrikam-ClientScript script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script
2.0 Script-WithDependencies1 Script GalleryINT Description for the Script-WithDependencies1 script
2.5 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script
1.0 PSGTEST-ScriptMetadata Script GalleryINT This sample file is used to test script metadata.
 $t = Find-Script -Includes Workflow -Repository GalleryINT -Name Fabrikam-ClientScript
 $t.Includes
Name Value
---- -----
Function {Test-FunctionFromScript\_Fabrikam-ClientScript}
DscResource {}
Cmdlet {}
Workflow {Test-WorkflowFromScript\_Fabrikam-ClientScript}
Command {Test-FunctionFromScript\_Fabrikam-ClientScript, Test-WorkflowFromScript\_Fabrikam-ClientScript}
```

## Save-Script cmdlet
Save-Script cmdlet lets you to review the script file by saving it to a specified location.
```powershell
\# Save a script file to the specified location for the script analysis
\# Piping the Find-Script output to Save-Script cmdlet
Find-Script -Name Fabrikam-ClientScript -Repository GalleryINT -RequiredVersion 1.5 | Save-Script -Path C:\\ScriptSharingDemo
Test-ScriptFileInfo C:\\ScriptSharingDemo\\Fabrikam-ClientScript.ps1

Version Name Author Description
------- ---- ------ -----------
1.5 Fabrikam-ClientScript manikb Description for the Fabrikam-ClientScript script
```

## Install-Script and Get-InstalledScript cmdlets
Install-Script cmdlet lets you to install a specific script file along with its dependencies to the specified scope. By default, scripts are installed to the AllUsers scope. Get-InstalledScript cmdlet lets you to get the list of script files which were installed using Install-Script cmdlet.

Use note: To allow management and locating of scripts once they are installed, Install-script will create a default folder for storing scripts at $home\Documents\WindowsPowerShell\Scripts, and add that folder to your PATH environment. If modifying the path is a concern, use Save-Script instead of Install-Script. Get-InstalledScripts and Uninstall-Script can only work with scripts placed on the system using Install-Script.
```powershell
\# Install locations for scripts:
\# Default scope is AllUsers.
\# AllUsers scope --&gt; "$env:ProgramFiles\\WindowsPowerShell\\Scripts"
\# CurrentUser scope --&gt; "$env:USERPROFILE\\Documents\\WindowsPowerShell\\Scripts"

\# Piping Find-Script output to Install-Script cmdlet
Find-Script -Repository GalleryINT -Name Required-Script2 | Install-Script -Scope CurrentUser -Verbose
VERBOSE: Repository details, Name = 'GalleryINT', Location = 'https://customgallery.cloudapp.net/api/v2/'; IsTrusted = 'True'; IsRegistered = 'True'.
VERBOSE: Performing the operation "Install-Script" on target "Version '2.5' of script 'Required-Script2'".
VERBOSE: Using the provider 'PowerShellGet' for searching packages.
VERBOSE: Using the specified source names : 'GalleryINT'.
VERBOSE: Getting the provider object for the PackageManagement Provider 'NuGet'.
VERBOSE: The specified Location is 'https://customgallery.cloudapp.net/api/v2/items/psscript/' and PackageManagementProvider is 'NuGet'.
VERBOSE: Searching repository 'https://customgallery.cloudapp.net/api/v2/items/psscript/FindPackagesById()?id='Required-Script2'' for ''.
VERBOSE: Total package yield:'1' for the specified package 'Required-Script2'.
VERBOSE: Performing the operation "Install-Script" on target "Version '2.5' of script 'Required-Script2'".
VERBOSE: The installation scope is specified to be 'CurrentUser'.
VERBOSE: The specified script will be installed in 'C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts' and its dependent modules will be installed in
'C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Modules'.
VERBOSE: The specified Location is 'NuGet' and PackageManagementProvider is 'NuGet'.
VERBOSE: Downloading script 'Required-Script2' with version '2.5' from the repository 'https://customgallery.cloudapp.net/api/v2/items/psscript/'.
VERBOSE: Script 'Required-Script2' was installed successfully.

Get-InstalledScript Required-Scri\*
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script

Get-InstalledScript Required-Script2 | Format-List \* -Force
Name : Required-Script2
Version : 2.5
Type : Script
Description : Description for the Required-Script2 script
Author : manikb
CompanyName :
Copyright : (c) 2015 Microsoft Corporation. All rights reserved.
PublishedDate : 10/30/2015 1:25:15 AM
LicenseUri : http://required-script2.com/license
ProjectUri : http://required-script2.com/
IconUri : http://required-script2.com/icon
Tags : {Tag1, Tag2, Tag-Required-Script2-2.5, PSScript}
Includes : {Function, DscResource, Cmdlet, Workflow...}
PowerShellGetFormatVersion :
ReleaseNotes : Required-Script2 release notes
Dependencies : {}
RepositorySourceLocation : https://customgallery.cloudapp.net/api/v2/
Repository : GalleryINT
PackageManagementProvider : NuGet
AdditionalMetadata : {Type, releaseNotes, copyright, PackageManagementProvider...}
InstalledLocation : C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts

Installed script file is immediately available for usage.
```

You can also use Get-Command –Name &lt;InstalledScriptFileName&gt; to get it. Two install locations are added to the PATH environment variable on first use of a specified scope.
```powershell
$env:Path -split ';'| Where-Object {$\_} | Select-Object -Last 2
C:\\Program Files\\WindowsPowerShell\\Scripts
C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts

Get-Command Required-Script2
CommandType Name Version Source
----------- ---- ------- ------
ExternalScript Required-Script2.ps1 C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts\\Required-Script2.ps1

Find-Script -Repository LocalRepo1 -Name Demo-Script
Version Name Type Repository Description
------- ---- ---- ---------- -----------
1.0 Demo-Script Script LocalRepo1 Script file description goes here

Find-Script -Repository LocalRepo1 -Name Demo-Script | Install-Script -Scope CurrentUser
Untrusted repository
You are installing the scripts from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the scripts from 'C:\\MyLocalRepo'?
\[Y\] Yes \[A\] Yes to All \[N\] No \[L\] No to All \[S\] Suspend \[?\] Help (default is "N"): Y

Get-InstalledScript Demo-Script
Version Name Type Repository Description
------- ---- ---- ---------- -----------
1.0 Demo-Script Script LocalRepo1 Script file description goes here

Get-Command Demo-Script
CommandType Name Version Source
----------- ---- ------- ------
ExternalScript Demo-Script.ps1 C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts\\Demo-Script.ps1

\# Using the installed script
Demo-Script
Demo-ScriptFunction
Demo-ScriptWorkflow

\# Installing a script to default AllUsers scope and with RequiredVersion
Install-Script -Repository GalleryINT -Name Required-Script3 -RequiredVersion 2.0
Get-InstalledScript -Name Required-Script3

Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Required-Script3 Script GalleryINT Description for the Required-Script3 script
Get-InstalledScript -Name Required-Script3 | Format-List Name,InstalledLocation -Force
Name : Required-Script3
InstalledLocation : C:\\Program Files\\WindowsPowerShell\\Scripts

Get-Command Required-Script3
CommandType Name Version Source
----------- ---- ------- ------
ExternalScript Required-Script3.ps1 C:\\Program Files\\WindowsPowerShell\\Scripts\\Required-Script3.ps1

\# Installing a script with dependent scripts and modules
Find-Script -Repository GalleryINT -Name Script-WithDependencies2 -IncludeDependencies
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script
2.5 RequiredModule1 Module GalleryINT RequiredModule1 module
2.5 RequiredModule2 Module GalleryINT RequiredModule2 module
2.5 RequiredModule3 Module GalleryINT RequiredModule3 module
2.0 RequiredModule4 Module GalleryINT RequiredModule4 module
1.5 RequiredModule5 Module GalleryINT RequiredModule5 module
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script

Get-InstalledScript
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Required-Script3 Script GalleryINT Description for the Required-Script3 script
1.0 Demo-Script Script LocalRepo1 Script file description goes here
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
Get-InstalledModule
Install-Script -Repository GalleryINT -Name Script-WithDependencies2 -Scope CurrentUser
Get-InstalledScript
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Required-Script3 Script GalleryINT Description for the Required-Script3 script
1.0 Demo-Script Script LocalRepo1 Script file description goes here
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script
Get-InstalledModule
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 RequiredModule1 Module GalleryINT RequiredModule1 module
2.5 RequiredModule2 Module GalleryINT RequiredModule2 module
2.5 RequiredModule3 Module GalleryINT RequiredModule3 module
2.0 RequiredModule4 Module GalleryINT RequiredModule4 module
1.5 RequiredModule5 Module GalleryINT RequiredModule5 module

\# Contents of Script-WithDependencies2 file.
&lt;\#PSScriptInfo
.VERSION 2.0
.GUID 90082fa1-0b84-49fb-a00e-0a624fbb6584
.AUTHOR manikb
.COMPANYNAME Microsoft Corporation
.COPYRIGHT (c) 2015 Microsoft Corporation. All rights reserved.
.TAGS Tag1 Tag2 Tag-Script-WithDependencies2-2.0
.LICENSEURI http://script-withdependencies2.com/license
.PROJECTURI http://script-withdependencies2.com/
.ICONURI http://script-withdependencies2.com/icon
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS Required-Script1,Required-Script2,Required-Script3
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
Script-WithDependencies2 release notes
\#&gt;
**\#Requires -Module RequiredModule1**
**\#Requires -Module @{ModuleName = 'RequiredModule2'; ModuleVersion = '2.0'}**
**\#Requires -Module @{RequiredVersion = '2.5'; ModuleName = 'RequiredModule3'}**
**\#Requires -Module @{ModuleVersion = '1.1'; ModuleName = 'RequiredModule4'; MaximumVersion = '2.0'}**
**\#Requires -Module @{MaximumVersion = '1.5'; ModuleName = 'RequiredModule5'}**
&lt;\#
.DESCRIPTION
Description for the Script-WithDependencies2 script
\#&gt;
Param()
Function Test-FunctionFromScript\_Script-WithDependencies2 { Get-Date }
Workflow Test-WorkflowFromScript\_Script-WithDependencies2 { Get-Date }
```

## Update-Script cmdlet
Update-Script cmdlet lets you to do in-place update of the script files which were installed using Install-Script cmdlet.
```powershell
Install-Script -Name Fabrikam-Script -RequiredVersion 1.0 -Repository GalleryINT -Scope
Get-InstalledScript -Name Fabrikam-Script
Version Name Type Repository Description
------- ---- ---- ---------- -----------
1.0 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script

\# Update a specific script to the required version
Update-Script -Name Fabrikam-Script -RequiredVersion 1.5
Get-InstalledScript -Name Fabrikam-Script
Version Name Type Repository Description
------- ---- ---- ---------- -----------
1.5 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script

\# Update all installed scripts
Install-Script -Name Fabrikam-ServerScript -RequiredVersion 1.0 -Repository GalleryINT -Scope CurrentUser
Get-InstalledScript
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 Required-Script3 Script GalleryINT Description for the Required-Script3 script
1.0 Demo-Script Script LocalRepo1 Script file description goes here
1.5 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script
1.0 Fabrikam-ServerScript Script GalleryINT Description for the Fabrikam-ServerScript script
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script

Update-Script
Get-InstalledScript
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.5 Required-Script3 Script GalleryINT Description for the Required-Script3 script
1.0 Demo-Script Script LocalRepo1 Script file description goes here
2.5 Fabrikam-Script Script GalleryINT Description for the Fabrikam-Script script
2.5 Fabrikam-ServerScript Script GalleryINT Description for the Fabrikam-ServerScript script
2.5 Required-Script1 Script GalleryINT Description for the Required-Script1 script
2.5 Required-Script2 Script GalleryINT Description for the Required-Script2 script
2.0 Script-WithDependencies2 Script GalleryINT Description for the Script-WithDependencies2 script
```

## Uninstall-Script cmdlet
```powershell
Uninstall-Script cmdlet lets you to uninstall the installed script files.
Get-InstalledScript | Uninstall-Script -WhatIf
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script3'".
What if: Performing the operation "Uninstall-Script" on target "Version '1.0' of script 'Demo-Script'".
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Fabrikam-Script'".
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Fabrikam-ServerScript'".
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script1'".
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script2'".
What if: Performing the operation "Uninstall-Script" on target "Version '2.0' of script 'Script-WithDependencies2'".
Uninstall-Script Required-Script1 -WhatIf -RequiredVersion 2.5
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script1'".
Uninstall-Script Required-Script1 -WhatIf -MinimumVersion 2.0 -MaximumVersion 3.0
What if: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script1'".
Get-InstalledScript -Name Script-WithDependencies2 | Uninstall-Script -WhatIf
What if: Performing the operation "Uninstall-Script" on target "Version '2.0' of script 'Script-WithDependencies2'".
Get-InstalledScript -Name Script-WithDependencies2 | Uninstall-Script -Confirm
Confirm
Are you sure you want to perform this action?
Performing the operation "Uninstall-Script" on target "Version '2.0' of script 'Script-WithDependencies2'".
\[Y\] Yes \[A\] Yes to All \[N\] No \[L\] No to All \[S\] Suspend \[?\] Help (default is "Y"): N

Uninstall-Script Required-Script1 -RequiredVersion 2.5 -Verbose
VERBOSE: Performing the operation "Uninstall-Script" on target "Version '2.5' of script 'Required-Script1'".
VERBOSE: Successfully uninstalled the script 'Required-Script1' from script base 'C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Scripts'.

\# Get-InstalledScript should not return the Required-Script1
Get-InstalledScript Required-Script1
PackageManagement\\Get-Package : No match was found for the specified search criteria and script names 'Required-Script1'.
At C:\\Program Files\\WindowsPowerShell\\Modules\\PowerShellGet\\1.0.0.1\\PSModule.psm1:3142 char:9
+ PackageManagement\\Get-Package @PSBoundParameters | Microsoft. ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : ObjectNotFound: (Microsoft.Power...lets.GetPackage:GetPackage) \[Get-Package\], Exception
+ FullyQualifiedErrorId : NoMatchFound,Microsoft.PowerShell.PackageManagement.Cmdlets.GetPackage
```

## New-ScriptFileInfo and Test-ScriptFileInfo cmdlets
New-ScriptFileInfo cmdlet lets you to create a new script file with metadata like Version, Guid, Author, and Description, etc. Test-ScriptFileInfo cmdlet lets you to validate and get the script file metadata.
```powershell
\# Create a new script file with minimum required metadata values
New-ScriptFileInfo -Path C:\\ScriptSharingDemo\\Demo-Script.ps1 -Description "Script file description goes here"
Get-Content -Path C:\\ScriptSharingDemo\\Demo-Script.ps1
&lt;\#PSScriptInfo
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
\#&gt;
&lt;\#
.DESCRIPTION
Script file description goes here
\#&gt;
Param()

\# Validate and get the script metadata
Test-ScriptFileInfo -Path C:\\ScriptSharingDemo\\Demo-Script.ps1
Version Name Author Description
------- ---- ------ -----------
1.0 Demo-Script manikb Script file description goes here

\# Add function and workflow to the script file
Add-Content -Path C:\\ScriptSharingDemo\\Demo-Script.ps1 -Value @"
&gt;&gt;&gt;
&gt;&gt;&gt; Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
&gt;&gt;&gt;
&gt;&gt;&gt; Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
&gt;&gt;&gt;
&gt;&gt;&gt; Demo-ScriptFunction
&gt;&gt;&gt; Demo-ScriptWorkflow
&gt;&gt;&gt; "@

\# Validate and get the script metadata
Test-ScriptFileInfo -Path C:\\ScriptSharingDemo\\Demo-Script.ps1
Version Name Author Description
------- ---- ------ -----------
1.0 Demo-Script manikb Script file description goes here

\# Create a script file all metadata properties
New-ScriptFileInfo -Path 'C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1' \`
&gt;&gt;&gt; -Version 1.0 \`
&gt;&gt;&gt; -Author 'manikb' \`
&gt;&gt;&gt; -Description "my new script file" \`
&gt;&gt;&gt; -CompanyName "Microsoft Corporation" \`
&gt;&gt;&gt; -Copyright "(c) 2015 Microsoft Corporation. All rights reserved." \`
&gt;&gt;&gt; -Tags @('Tag1', 'Tag2', 'Tag3') \`
&gt;&gt;&gt; -ProjectUri 'https://contoso.com' \`
&gt;&gt;&gt; -LicenseUri "https://contoso.com/License" \`
&gt;&gt;&gt; -IconUri 'https://contoso.com/Icon' \`
&gt;&gt;&gt; -ReleaseNotes @('contoso script now supports following features',
&gt;&gt;&gt; 'Feature 1',
&gt;&gt;&gt; 'Feature 2',
&gt;&gt;&gt; 'Feature 3',
&gt;&gt;&gt; 'Feature 4',
&gt;&gt;&gt; 'Feature 5') \`
&gt;&gt;&gt; -RequiredModules @('RequiredModule1',
&gt;&gt;&gt; @{ModuleName='RequiredModule2';ModuleVersion='1.0'},
&gt;&gt;&gt; @{ModuleName='RequiredModule3';RequiredVersion='2.0'},
&gt;&gt;&gt; @{ModuleName = 'RequiredModule4'; ModuleVersion = '0.1'; MaximumVersion = '1.\*'; },
&gt;&gt;&gt; @{ModuleName = 'RequiredModule5'; MaximumVersion = '1.\*'; },
&gt;&gt;&gt; 'ExternalModule1') \`
&gt;&gt;&gt; -ExternalModuleDependencies 'ExternalModule1' \`
&gt;&gt;&gt; -RequiredScripts 'Start-WFContosoServer', 'Stop-ContosoServerScript', 'ExternalScript1' \`
&gt;&gt;&gt; -ExternalScriptDependencies 'ExternalScript1'

\# Add function and workflow to the script file
Add-Content -Path 'C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1' -Value @"
&gt;&gt;&gt;
&gt;&gt;&gt; Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
&gt;&gt;&gt;
&gt;&gt;&gt; Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
&gt;&gt;&gt;
&gt;&gt;&gt; Demo-ScriptFunction
&gt;&gt;&gt; Demo-ScriptWorkflow
&gt;&gt;&gt; "@

Get-Content -Path C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1
&lt;\#PSScriptInfo
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
\#&gt;
\#Requires -Module RequiredModule1
\#Requires -Module @{ModuleName = 'RequiredModule2'; ModuleVersion = '1.0'}
\#Requires -Module @{RequiredVersion = '2.0'; ModuleName = 'RequiredModule3'}
\#Requires -Module @{ModuleVersion = '0.1'; ModuleName = 'RequiredModule4'; MaximumVersion = '1.\*'}
\#Requires -Module @{MaximumVersion = '1.\*'; ModuleName = 'RequiredModule5'}
\#Requires -Module ExternalModule1
&lt;\#
.DESCRIPTION
my new script file
\#&gt;
Param()
Function Demo-ScriptFunction { 'Demo-ScriptFunction' }
Workflow Demo-ScriptWorkflow { 'Demo-ScriptWorkflow' }
Demo-ScriptFunction
Demo-ScriptWorkflow

\# Validate and get the script metadata
Test-ScriptFileInfo C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1 | Format-List \* -Force
Name : Demo-ScriptWithCompletePSScriptInfo
Version : 1.0
Guid : fe4cc121-f87e-4ddb-8186-ff362e23a935
Path : C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1
ScriptBase : C:\\ScriptSharingDemo
Description : my new script file
Author : manikb
CompanyName : Microsoft Corporation
Copyright : (c) 2015 Microsoft Corporation. All rights reserved.
Tags : {Tag1, Tag2, Tag3}
ReleaseNotes : {contoso script now supports following features, Feature 1, Feature 2, Feature 3...}
RequiredModules : {RequiredModule1, @{ ModuleName = 'RequiredModule2'; ModuleVersion = '1.0' }, @{ ModuleName = 'RequiredModule3'; RequiredVersion = '2.0' }, @{ ModuleName = 'RequiredModule4'; ModuleVersion = '0.1';
MaximumVersion = '1.\*' }...}
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

## Update-ScriptFileInfo cmdlet
Update-ScriptFileInfo cmdlet lets you to update the existing script file metadata.
```powershell
\# Use Update-ScriptFileInfo cmdlet to update the script metadata
Update-ScriptFileInfo -Path C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1 -Version 2.0
Test-ScriptFileInfo C:\\ScriptSharingDemo\\Demo-ScriptWithCompletePSScriptInfo.ps1
Version Name Author Description
------- ---- ------ -----------
2.0 Demo-ScriptWithComplet... manikb my new script file
```

## Register-PSRepository and Set-PSRepository cmdlets with script sharing support
Use Register-PSRepository/Set-PSRepository cmdlets to add the **ScriptSourceLocation** and **ScriptPublishLocation** to the PSRepository.
```powershell
\# Register an GalleryINT repository with Scripts and Modules support
Register-PSRepository -Name GalleryINT \`
&gt;&gt;&gt; -SourceLocation https://customgallery.cloudapp.net \`
&gt;&gt;&gt; -InstallationPolicy Trusted \`
&gt;&gt;&gt; -Verbose
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet provider must be available in 'C:\\Program
Files\\PackageManagement\\ProviderAssemblies' or 'C:\\Users\\manikb\\AppData\\Local\\PackageManagement\\ProviderAssemblies'. You can also install the NuGet provider by running
'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install and import the NuGet provider now?
\[Y\] Yes \[N\] No \[S\] Suspend \[?\] Help (default is "Y"): Y
VERBOSE: Installing NuGet provider.
VERBOSE: The specified assembly 'C:\\Program Files\\PackageManagement\\ProviderAssemblies\\nuget-anycpu.exe' is installed at top level directory. However it is recommended that the assemblies
should be installed under its ProviderName\\Version folder.
VERBOSE: Installing the package 'https://oneget.org/nuget-2.8.5.201.package.swidtag'.
VERBOSE: Installed the package 'nuget' to 'C:\\Program Files\\PackageManagement\\ProviderAssemblies\\nuget\\2.8.5.201\\Microsoft.PackageManagement.NuGetProvider.dll'.
VERBOSE: The provider 'NuGet' has already been imported. Trying to import it again.
VERBOSE: Importing package provider 'NuGet'.
VERBOSE: Performing the operation "Register Module Repository" on target "Module Repository 'GalleryINT' (https://customgallery.cloudapp.net/) in provider 'PowerShellGet'".
VERBOSE: User did not specify the PackageManagement provider name, trying with the provider name 'NuGet'.
VERBOSE: Successfully registered the repository 'GalleryINT' with source location 'https://customgallery.cloudapp.net/api/v2/'.
VERBOSE: Repository details, Name = 'GalleryINT', Location = 'https://customgallery.cloudapp.net/api/v2/'; IsTrusted = 'True'; IsRegistered = 'True'.

\# Get the registered repository details
Get-PSRepository -Name GalleryINT
Name PackageManagementProvider InstallationPolicy SourceLocation
---- ------------------------- ------------------ --------------
GalleryINT NuGet Trusted https://customgallery.cloudapp.net/api/v2/
Get-PSRepository -Name GalleryINT | Format-List \* -Force
Name : GalleryINT
SourceLocation : https://customgallery.cloudapp.net/api/v2/
Trusted : True
Registered : True
InstallationPolicy : Trusted
PackageManagementProvider : NuGet
PublishLocation : https://customgallery.cloudapp.net/api/v2/package/
ScriptSourceLocation : https://customgallery.cloudapp.net/api/v2/items/psscript/
ScriptPublishLocation : https://customgallery.cloudapp.net/api/v2/package/
ProviderOptions : {}

\# Add script sharing locations to an existing PSRepository using Set-PSRepository object.  Set-PSRepository -Name MyGallery \`
&gt;&gt;&gt; -ScriptSourceLocation https://MyGallery.com/api/v2/items/psscript/ \`
&gt;&gt;&gt; -ScriptPublishLocation https://MyGallery.com/api/v2/package/
Get-PSRepository -Name GalleryINT | Format-List \* -Force
Name : GalleryINT
SourceLocation : https://MyGallery.com/api/v2/
Trusted : True
Registered : True
InstallationPolicy : Trusted
PackageManagementProvider : NuGet
PublishLocation : https://MyGallery.com/api/v2/package/
ScriptSourceLocation : https://MyGallery.com/api/v2/items/psscript/
ScriptPublishLocation : https://MyGallery.com/api/v2/package/
ProviderOptions : {}
```

## Publish-Script cmdlet
Publish-Script cmdlet lets you to publish your script file with valid metadata like Version, Guid, Author, and Description, etc.
```powershell
\# Publish the really basic script file with required metadata
Publish-Script -Path C:\\ScriptSharingDemo\\Demo-Script.ps1 -Repository GalleryINT -NuGetApiKey cad91af7-a49c-4026-9570-a4c16564e785 -Verbose
NuGet.exe is required to continue
PowerShellGet requires NuGet.exe to publish an item to the NuGet-based repositories. NuGet.exe must be available under one of the paths specified in PATH environment variable value. Do you
want PowerShellGet to install NuGet.exe now?
\[Y\] Yes \[N\] No \[S\] Suspend \[?\] Help (default is "Y"): Y
VERBOSE: Installing NuGet.exe.
VERBOSE: GET http://go.microsoft.com/fwlink/?LinkID=690216&clcid=0x409 with 0-byte payload
VERBOSE: received 1686528-byte response of content type application/octet-stream
VERBOSE: Performing the operation "Publish-Script" on target "Version '1.0' of script 'Demo-Script'".
VERBOSE: Successfully published script 'Demo-Script' to the publish location https://customgallery.cloudapp.net/api/v2/package/'. Please allow few minutes for 'Demo-Script' to show up in the search results.

Find-Script -Repository GalleryINT -Name Demo-Script
Version Name Type Repository Description
------- ---- ---- ---------- -----------
1.0 Demo-Script Script GalleryINT Script file description goes here

Find-Script -Repository GalleryINT -Name Demo-Script | Format-List \* -Force
Name : Demo-Script
Version : 1.0
Type : Script
Description : Script file description goes here
Author : manikb
CompanyName : manikb
Copyright :
PublishedDate : 11/16/2015 6:46:28 PM
LicenseUri :
ProjectUri :
IconUri :
Tags : {PSScript}
Includes : {Function, DscResource, Cmdlet, Workflow...}
PowerShellGetFormatVersion :
ReleaseNotes :
Dependencies : {}
RepositorySourceLocation : https://customgallery.cloudapp.net/api/v2/
Repository : GalleryINT
PackageManagementProvider : NuGet
AdditionalMetadata : {description, developmentDependency, tags, PackageManagementProvider...}
```

