# Installation of Module Dependencies

There is now side-by-side (SxS) module version support in Install-Module, Update-Module, and Publish-Module cmdlets that run in Windows PowerShell 5.0 or newer.
Also, we have added a -RequiredVersion parameter to the Publish-Module cmdlet to specify the version to be published. The Path parameter now supports the module base path with the version folder.

**Install-Module examples:**
```powershell
PS C:\\windows\\system32&gt; Install-Module -Name ContosoServer -RequiredVersion 1.0 -Repository MSPSGallery
PS C:\\windows\\system32&gt; Get-Module -ListAvailable -Name ContosoServer | Format-List Name,Version,ModuleBase
Name : ContosoServer
Version : 1.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.0
PS C:\\windows\\system32&gt; Install-Module -Name ContosoServer -RequiredVersion 2.0 -Repository MSPSGallery
PS C:\\windows\\system32&gt; Get-Module -ListAvailable -Name ContosoServer | Format-List Name,Version,ModuleBase
Name : ContosoServer
Version : 2.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\2.0
Name : ContosoServer
Version : 1.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.0
PS C:\\windows\\system32&gt; Get-InstalledModule
Version Name Repository Description
------- ---- ---------- -----------
1.0 ContosoServer MSPSGallery ContosoServer module
2.0 ContosoServer MSPSGallery ContosoServer module
```

**Install a module with dependencies:**
```powershell
PS C:\\windows\\system32&gt; Get-InstalledModule
PS C:\\windows\\system32&gt; Find-Module -Repository GalleryINT -Name ModuleWithDependencies2 -IncludeDependencies
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 ModuleWithDependencies2 Module GalleryINT ModuleWithDependencies2 module
2.5 RequiredModule1 Module GalleryINT RequiredModule1 module
2.5 RequiredModule2 Module GalleryINT RequiredModule2 module
2.5 RequiredModule3 Module GalleryINT RequiredModule3 module
2.0 RequiredModule4 Module GalleryINT RequiredModule4 module
1.5 RequiredModule5 Module GalleryINT RequiredModule5 module
2.5 NestedRequiredModule1 Module GalleryINT NestedRequiredModule1 module
2.5 NestedRequiredModule2 Module GalleryINT NestedRequiredModule2 module
2.5 NestedRequiredModule3 Module GalleryINT NestedRequiredModule3 module
2.0 NestedRequiredModule4 Module GalleryINT NestedRequiredModule4 module
1.5 NestedRequiredModule5 Module GalleryINT NestedRequiredModule5 module

PS C:\\windows\\system32&gt; Install-Module -Repository GalleryINT -Name ModuleWithDependencies2 -Scope CurrentUser
PS C:\\windows\\system32&gt; Get-InstalledModule
Version Name Type Repository Description
------- ---- ---- ---------- -----------
2.0 ModuleWithDependencies2 Module GalleryINT ModuleWithDependencies2 module
2.5 NestedRequiredModule1 Module GalleryINT NestedRequiredModule1 module
2.5 NestedRequiredModule2 Module GalleryINT NestedRequiredModule2 module
2.5 NestedRequiredModule3 Module GalleryINT NestedRequiredModule3 module
2.0 NestedRequiredModule4 Module GalleryINT NestedRequiredModule4 module
1.5 NestedRequiredModule5 Module GalleryINT NestedRequiredModule5 module
2.5 RequiredModule1 Module GalleryINT RequiredModule1 module
2.5 RequiredModule2 Module GalleryINT RequiredModule2 module
2.5 RequiredModule3 Module GalleryINT RequiredModule3 module
2.0 RequiredModule4 Module GalleryINT RequiredModule4 module
1.5 RequiredModule5 Module GalleryINT RequiredModule5 module

PS C:\\windows\\system32&gt; $module = Get-Module -Name ModuleWithDependencies2 -ListAvailable
PS C:\\windows\\system32&gt; $module
Directory: C:\\Users\\manikb\\Documents\\WindowsPowerShell\\Modules
ModuleType Version Name ExportedCommands
---------- ------- ---- ----------------
Manifest 2.0 ModuleWithDependencies2 {Get-NestedRequiredModule1, Get-NestedRequiredModule2, Get-NestedRequiredModule3, Get-NestedRequiredModule4...}
```

**Contents of ModuleWithDependencies2 module manifest file:**
```powershell
@{
\# Version number of this module.
ModuleVersion = '2.0'
\# ID used to uniquely identify this module
GUID = '0eae34da-99dd-4608-8d28-c614fe7b0841'
\# Author of this module
Author = 'manikb'
\# Company or vendor of this module
CompanyName = 'Unknown'
\# Copyright statement for this module
Copyright = '(c) 2015 manikb. All rights reserved.'
\# Description of the functionality provided by this module
Description = 'ModuleWithDependencies2 module'
\# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('RequiredModule1',
@{ModuleName = 'RequiredModule2'; ModuleVersion = '2.0'; },
@{ModuleName = 'RequiredModule3'; RequiredVersion = '2.5'; },
@{ModuleName = 'RequiredModule4'; ModuleVersion = '1.1'; MaximumVersion = '2.0'; },
@{ModuleName = 'RequiredModule5'; MaximumVersion = '1.5'; })
\# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('NestedRequiredModule1',
@{ModuleName = 'NestedRequiredModule2'; ModuleVersion = '2.0'; },
@{ModuleName = 'NestedRequiredModule3'; RequiredVersion = '2.5'; },
@{ModuleName = 'NestedRequiredModule4'; ModuleVersion = '0.7'; MaximumVersion = '2.4'; },
@{ModuleName = 'NestedRequiredModule5'; MaximumVersion = '1.6'; },'ModuleWithDependencies2.psm1')
\# Functions to export from this module
FunctionsToExport = '\*'
\# Cmdlets to export from this module
CmdletsToExport = '\*'
\# Variables to export from this module
VariablesToExport = '\*'
\# Aliases to export from this module
AliasesToExport = '\*'
\# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{
PSData = @{
\# Tags applied to this module. These help with module discovery in online galleries.
Tags = 'Tag1', 'Tag2', 'Tag-ModuleWithDependencies2-2.0'
\# A URL to the license for this module.
LicenseUri = 'http://modulewithdependencies2.com/license'
\# A URL to the main website for this project.
ProjectUri = 'http://modulewithdependencies2.com/'
\# A URL to an icon representing this module.
IconUri = 'http://modulewithdependencies2.com/icon'
\# ReleaseNotes of this module
ReleaseNotes = 'ModuleWithDependencies2 release notes'
} \# End of PSData hashtable
} \# End of PrivateData hashtable
}
```

**Update-Module examples:**
```powershell
PS C:\\windows\\system32&gt; Update-Module -Name ContosoServer -RequiredVersion 1.5
PS C:\\windows\\system32&gt; Get-Module -ListAvailable -Name ContosoServer | Format-List Name,Version,ModuleBase
Name : ContosoServer
Version : 2.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\2.0
Name : ContosoServer
Version : 1.5
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.5
Name : ContosoServer
Version : 1.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.0
PS C:\\windows\\system32&gt; Get-InstalledModule
Version Name Repository Description
------- ---- ---------- -----------
1.0 ContosoServer MSPSGallery ContosoServer module
1.5 ContosoServer MSPSGallery ContosoServer module
2.0 ContosoServer MSPSGallery ContosoServer module
PS C:\\windows\\system32&gt; Update-Module -Name ContosoServer
PS C:\\windows\\system32&gt; Get-Module -ListAvailable -Name ContosoServer | Format-List Name,Version,ModuleBase
Name : ContosoServer
Version : 2.8.1
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\2.8.1
Name : ContosoServer
Version : 2.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\2.0
Name : ContosoServer
Version : 1.5
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.5
Name : ContosoServer
Version : 1.0
ModuleBase : C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\1.0
PS C:\\windows\\system32&gt; Get-InstalledModule
Version Name Repository Description
------- ---- ---------- -----------
1.0 ContosoServer MSPSGallery ContosoServer module
1.5 ContosoServer MSPSGallery ContosoServer module
2.0 ContosoServer MSPSGallery ContosoServer module
2.8.1 ContosoServer MSPSGallery ContosoServer module
```

**Publish-Module examples:**
```powershell
ContosoServer module with different versions to be published.
PS C:\\windows\\system32&gt; Get-Module -Name ContosoServer -ListAvailable
Directory: C:\\Program Files\\WindowsPowerShell\\Modules
ModuleType Version Name ExportedCommands
---------- ------- ---- ----------------
Manifest 2.8 ContosoServer Get-ContosoServer
Manifest 2.0 ContosoServer Get-ContosoServer
Manifest 1.5 ContosoServer Get-ContosoServer
Manifest 1.0 ContosoServer Get-ContosoServer
PS C:\\windows\\system32&gt; Publish-Module -Name ContosoServer -RequiredVersion 1.0 -Repository LocalRepo -NuGetApiKey Local-Repo-NuGet-ApiKey
PS C:\\windows\\system32&gt; Find-Module -Name ContosoServer -Repository LocalRepo
Version Name Repository Description
------- ---- ---------- -----------
1.0 ContosoServer LocalRepo ContosoServer module
PS C:\\windows\\system32&gt; Publish-Module -Name ContosoServer -RequiredVersion 1.5 -Repository LocalRepo -NuGetApiKey Local-Repo-NuGet-ApiKey
PS C:\\windows\\system32&gt; Find-Module -Name ContosoServer -Repository LocalRepo
Version Name Repository Description
------- ---- ---------- -----------
1.0 ContosoServer LocalRepo ContosoServer module
1.5 ContosoServer LocalRepo ContosoServer module
PS C:\\windows\\system32&gt; Publish-Module -Path "C:\\Program Files\\WindowsPowerShell\\Modules\\ContosoServer\\2.0" -Repository LocalRepo -NuGetApiKey Local-Repo-NuGet-ApiKey
PS C:\\windows\\system32&gt; Find-Module -Name ContosoServer -Repository LocalRepo
Version Name Repository Description
_------ ---- ---------- -----------
1.0 ContosoServer LocalRepo ContosoServer module
1.5 ContosoServer LocalRepo ContosoServer module
2.0 ContosoServer LocalRepo ContosoServer module
```