---
ms.date:  2017-06-12
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# PowerShellGet Cmdlets for Module Management

- [Find-DscResource](https://technet.microsoft.com/library/mt654006.aspx)
- [Find-Module](https://technet.microsoft.com/library/dn807167.aspx)
- [Find-Script](https://technet.microsoft.com/library/mt654001.aspx)
- [Get-InstalledModule](https://technet.microsoft.com/en-us/library/mt653990.aspx)
- [Get-InstalledScript](https://technet.microsoft.com/en-us/library/mt653994.aspx)
- [Get-PSRepository](https://technet.microsoft.com/en-us/library/dn807170.aspx)
- [Install-Module](https://technet.microsoft.com/en-us/library/dn807162.aspx)
- [Install-Script](https://technet.microsoft.com/en-us/library/mt653998.aspx)
- [New-ScriptFileInfo](https://technet.microsoft.com/en-us/library/mt653995.aspx)
- [Publish-Module](https://technet.microsoft.com/en-us/library/dn807163.aspx)
- [Publish-Script](https://technet.microsoft.com/en-us/library/mt654003.aspx)
- [Register-PSRepository](https://technet.microsoft.com/en-us/library/dn807168.aspx)
- [Save-Module](https://technet.microsoft.com/en-us/library/mt653992.aspx)
- [Save-Script](https://technet.microsoft.com/en-us/library/mt654004.aspx)
- [Set-PSRepository](https://technet.microsoft.com/en-us/library/dn807165.aspx)
- [Test-ScriptFileInfo](https://technet.microsoft.com/en-us/library/mt654005.aspx)
- [Uninstall-Module](https://technet.microsoft.com/en-us/library/mt653996.aspx)
- [Uninstall-Script](https://technet.microsoft.com/en-us/library/mt653989.aspx)
- [Update-Module](https://technet.microsoft.com/en-us/library/dn807166.aspx)
- [Update-ModuleManifest](https://technet.microsoft.com/en-us/library/mt654002.aspx)
- [Update-Script](https://technet.microsoft.com/en-us/library/mt653997.aspx)
- [Update-ScriptFileInfo](https://technet.microsoft.com/en-us/library/mt653991.aspx)
- [Unregister-PSRepository](https://technet.microsoft.com/en-us/library/dn807161.aspx)

## Module dependency installation support, Get-InstalledModule and Uninstall-Module cmdlets
- Added module dependencies population in the Publish-Module cmdlet. The RequiredModules and NestedModules lists of PSModuleInfo are used in preparing the dependency list of a module to be published.
- Added dependency installation support in the Install-Module and Update-Module cmdlets. Module dependencies are installed and updated by default.
- Added an -IncludeDependencies parameter to the Find-Module cmdlet to include module dependencies in the results.
- Added -MaximumVersion support on the Find-Module, Install-Module, and Update-Module cmdlets.
- Added new Get-InstalledModule and Uninstall-Module cmdlets.

## PowerShellGet cmdlets demo with module dependencies support:

### Ensure that module dependencies are available on the repository:
```powershell
Find-Module -Repository LocalRepo -Name RequiredModule1,RequiredModule2,RequiredModule3,NestedRequiredModule1,NestedRequiredModule2,NestedRequiredModule3 | Sort-Object -Property Name

Version    Name                     Repository    Description                  
-------    ----                     ----------    -----------                  
2.5        NestedRequiredModule1    LocalRepo     NestedRequiredModule1 module 
2.5        NestedRequiredModule2    LocalRepo     NestedRequiredModule2 module 
2.0        NestedRequiredModule3    LocalRepo     NestedRequiredModule3 module 
2.5        RequiredModule1          LocalRepo     RequiredModule1 module  
2.5        RequiredModule2          LocalRepo     RequiredModule2 module  
2.0        RequiredModule3          LocalRepo     RequiredModule3 module
```

### Create a module with dependencies that are specified in the RequiredModules and NestedModules properties of its module manifest.
```powershell
$RequiredModules = @('RequiredModule1',
					 @{ModuleName = 'RequiredModule2'; ModuleVersion = '1.5'; },
					 @{ModuleName = 'RequiredModule3'; RequiredVersion = '2.0'; })

$NestedRequiredModules = @('TestDepWithNestedRequiredModules1.psm1', 'NestedRequiredModule1',
							@{ModuleName = 'NestedRequiredModule2'; ModuleVersion = '1.5'; },
							@{ModuleName = 'NestedRequiredModule3'; RequiredVersion = '2.0'; })

New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\TestDepWithNestedRequiredModules1\TestDepWithNestedRequiredModules1.psd1' `
-NestedModules $NestedRequiredModules -RequiredModules $RequiredModules -ModuleVersion "1.0" -Description "TestDepWithNestedRequiredModules1 module"
```

###  Publish two versions (**“1.0”** and **“2.0”**) of the TestDepWithNestedRequiredModules1 module with dependencies to the repository.
```powershell
Publish-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -NuGetApiKey "MyNuGet-ApiKey-For-LocalRepo"
```

###  Find the TestDepWithNestedRequiredModules1 module with its dependencies by specifying -IncludeDependencies.
```powershell
Find-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo –IncludeDependencies -MaximumVersion "1.0"

Version    Name                                Repository  Description 
-------    ----                                ----------  -----------  
1.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module  
2.5        RequiredModule1                     LocalRepo   RequiredModule1 module      
2.5        RequiredModule2                     LocalRepo   RequiredModule2 module      
2.0        RequiredModule3                     LocalRepo   RequiredModule3 module      
2.5        NestedRequiredModule1               LocalRepo   NestedRequiredModule1 module
2.5        NestedRequiredModule2               LocalRepo   NestedRequiredModule2 module
2.0        NestedRequiredModule3               LocalRepo   NestedRequiredModule3 module
``` 

### Use Find-Module metadata to find the module dependencies.
```powershell
$psgetModuleInfo = Find-Module -Repository MSPSGallery -Name ModuleWithDependencies2
$psgetModuleInfo.Dependencies.ModuleName

RequiredModule1
RequiredModule2
RequiredModule3
NestedRequiredModule1
NestedRequiredModule2
NestedRequiredModule3

$psgetModuleInfo.Dependencies

Name Value
---- -----
ModuleName RequiredModule1
CanonicalId PowerShellGet:RequiredModule1/#http://psget/psGallery/api/v2/

ModuleName RequiredModule2
ModuleVersion 2.0
CanonicalId PowerShellGet:RequiredModule2/2.0#http://psget/psGallery/api/v2/

ModuleName RequiredModule3
RequiredVersion 2.5
CanonicalId PowerShellGet:RequiredModule3/2.5#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule1
CanonicalId PowerShellGet:NestedRequiredModule1/#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule2
ModuleVersion 2.0
CanonicalId PowerShellGet:NestedRequiredModule2/2.0#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule3
RequiredVersion 2.5
CanonicalId PowerShellGet:NestedRequiredModule3/2.5#http://psget/psGallery/api/v2/
```

###  Install the TestDepWithNestedRequiredModules1 module with dependencies.
```powershell
Install-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -RequiredVersion "1.0"
Get-InstalledModule

Version    Name                    Repository   Description                 
-------    ----                    ----------   -----------                 
1.0        NestedRequiredModule1   LocalRepo    NestedRequiredModule1 module
2.5        NestedRequiredModule2   LocalRepo    NestedRequiredModule2 module
2.0        NestedRequiredModule3   LocalRepo    NestedRequiredModule3 module
1.0        RequiredModule1         LocalRepo    RequiredModule1 module      
2.5        RequiredModule2                    LocalRepo    RequiredModule2 module 
2.0        RequiredModule3                    LocalRepo    RequiredModule3 module 
1.0        TestDepWithNestedRequiredModules1  LocalRepo    TestDepWithNestedRequiredModules1 module
```

###  Update the TestDepWithNestedRequiredModules1 module with dependencies.
```powershell
Find-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -AllVersions

Version    Name                                Repository  Description
-------    ----                                ----------  -----------
1.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module
2.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module

Update-Module -Name TestDepWithNestedRequiredModules1 -RequiredVersion 2.0
Get-InstalledModule

Version    Name                                Repository  Description
-------    ----                                ----------  -----------
1.0        NestedRequiredModule1               LocalRepo   NestedRequiredModule1 module
2.5        NestedRequiredModule2               LocalRepo   NestedRequiredModule2 module
2.0        NestedRequiredModule3               LocalRepo   NestedRequiredModule3 module
2.5        NestedRequiredModule3               LocalRepo   NestedRequiredModule3 module
1.0        RequiredModule1                     LocalRepo   RequiredModule1 module
2.5        RequiredModule2                     LocalRepo   RequiredModule2 module
2.0        RequiredModule3                     LocalRepo   RequiredModule3 module
2.5        RequiredModule3                     LocalRepo   RequiredModule3 module
1.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module
2.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module
```

###  Run the Uninstall-Module cmdlet to uninstall a module that you installed by using PowerShellGet.
If any other module depends on the module that you want to delete, PowerShellGet throws an error.
```powershell
Get-InstalledModule -Name RequiredModule1 | Uninstall-Module

PackageManagement\Uninstall-Package : The module 'RequiredModule1' of version '2.5' in module base folder 'C:\Program Files\WindowsPowerShell\Modules\RequiredModule1\2.5' cannot be uninstalled, because one or more other modules 'ModuleWithDependencies2' are dependent on this module. Uninstall the modules that depend on this module before uninstalling module 'RequiredModule1'.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\PSGet.psm1:1303 char:25
+ ... $null = PackageManagement\\Uninstall-Package @PSBoundParameters
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : InvalidOperation: (Microsoft.Power...ninstallPackage:UninstallPackage) [Uninstall-Package], Exception
+ FullyQualifiedErrorId : UnableToUninstallAsOtherModulesNeedThisModule,Uninstall-Package,Microsoft.PowerShell.PackageManagement.Cmdlets.UninstallPackage
```

## Save-Module cmdlet
```powershell
Save-Module -Repository MSPSGallery -Name ModuleWithDependencies2 -Path C:\MySavedModuleLocation
dir C:\MySavedModuleLocation

Directory: C:\MySavedModuleLocation

Mode LastWriteTime Length Name
---- ------------- ------ ----
d----- 4/21/2015 5:40 PM ModuleWithDependencies2
d----- 4/21/2015 5:40 PM NestedRequiredModule1
d----- 4/21/2015 5:40 PM NestedRequiredModule2
d----- 4/21/2015 5:40 PM NestedRequiredModule3
d----- 4/21/2015 5:40 PM RequiredModule1
d----- 4/21/2015 5:40 PM RequiredModule2
d----- 4/21/2015 5:40 PM RequiredModule3
```

## Update-ModuleManifest cmdlet
This new cmdlet is used to help update manifest file with input property values. It takes all parameters that Test-ModuleManifest does.

We notice that a lot of module authors would like to specify “\*” in exported values such as FunctionsToExport, CmdletsToExport, etc. During module publishing to PowerShell Gallery, unspecified functions and commands will not be populated properly onto the Gallery. Therefore, we suggest module authors update their manifests with proper values.

If you have modules that have exported properties, Update-ModuleManifest will fill the specified manifest file with information from exported functions, cmdlets, variables etc:
```powershell
Get-Content -Path "C:\Temp\PSGTEST-TestPackageMetadata\2.5\PSGTEST-TestPackageMetadata.psd1"
@{
# Script module or binary module file associated with this manifest.
# RootModule = ''
# Version number of this module.
ModuleVersion = '2.5'
# ID used to uniquely identify this module
GUID = '610e5c5b-dc42-4eaa-8511-ebfb44066d5e'

#(Other properties removed here for Simplicity…)

# Functions to export from this module
FunctionsToExport = '*'
# Cmdlets to export from this module
CmdletsToExport = '*'
# Variables to export from this module
VariablesToExport = '*'
# Aliases to export from this module
AliasesToExport = '*'
}
```

After Update-ModuleManifest:
```powershell
Update-ModuleManifest -Path "C:\Temp\PSGTEST-TestPackageMetadata\2.5\PSGTEST-TestPackageMetadata.psd1"
Get-Content -Path "C:\Temp\PSGTEST-TestPackageMetadata\2.5\PSGTEST-TestPackageMetadata.psd1"
#
# Module manifest for module 'NewManifest'
#
# Generated by: author name
#
# Generated on: 11/13/2015
#
@{
# Script module or binary module file associated with this manifest.
# RootModule = ''
# Version number of this module.
ModuleVersion = '2.5'
# ID used to uniquely identify this module
GUID = '610e5c5b-dc42-4eaa-8511-ebfb44066d5e'
# Functions to export from this module
FunctionsToExport = 'Get-FooFn Get-FooWF'
# Cmdlets to export from this module
CmdletsToExport = 'Test-PSGetTestCmdlet'
}
```

For each module, there are also metadata fields associated with it. In order to display metadata properly on PowrShell Gallery, you can use Update-ModuleManifest to populate those fields under PrivateData.
```powershell
Update-ModuleManifest -Path "C:\Temp\PSGTEST-TestPackageMetadata\2.5\PSGTEST-TestPackageMetadata.psd1" -Tags "Tag1" -LicenseUri "http://license.com" -ProjectUri "http://project.com" -IconUri "http://icon.com" -ReleaseNotes "Test module"
```
PrivateData hashtable from the manifest file template has the following properties:
```powershell
# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{
	PSData = @{
		# Tags applied to this module. These help with module discovery in online galleries.
		# Tags = @()

		# A URL to the license for this module.
		# LicenseUri = ''
	
		# A URL to the main website for this project.
		# ProjectUri = ''
		
		# A URL to an icon representing this module.
		# IconUri = ''
		
		# ReleaseNotes of this module
		# ReleaseNotes = ''
		
		# External dependent modules of this module
		# ExternalModuleDependencies = ''
	} # End of PSData hashtable
} # End of PrivateData hashtable
```
***Note:*** DscResourcesToExport is only supported on the latest PowerShell version 5.0. We won’t be able to update the field if you are running on previous PowerShell version.

