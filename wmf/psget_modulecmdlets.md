## PowerShellGet Cmdlets for Module Management

**Find-DscResource** \[\[-Name\] &lt;string\[\]&gt;\] \[-ModuleName &lt;string&gt;\] \[-MinimumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-AllVersions\] \[-Tag &lt;string\[\]&gt;\] \[-Filter &lt;string&gt;\] \[-Repository &lt;string\[\]&gt;\] \[&lt;CommonParameters&gt;\]

**Find-Module** \[\[-Name\] &lt;string\[\]&gt;\] \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-AllVersions\] \[-IncludeDependencies\] \[-Filter &lt;string&gt;\] \[-Tag &lt;string\[\]&gt;\] \[-Includes &lt;string\[\]&gt;\] \[-DscResource &lt;string\[\]&gt;\] \[-Command &lt;string\[\]&gt;\] \[-Repository &lt;string\[\]&gt;\] \[&lt;CommonParameters&gt;\]

**Save-Module** \[-Name\] &lt;string\[\]&gt; -Path &lt;string&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Module** \[-Name\] &lt;string\[\]&gt; -LiteralPath &lt;string&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Module** \[-InputObject\] &lt;psobject\[\]&gt; -LiteralPath &lt;string&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Module** \[-InputObject\] &lt;psobject\[\]&gt; -Path &lt;string&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Publish-Module** -Name &lt;string&gt; \[-RequiredVersion &lt;version&gt;\] \[-NuGetApiKey &lt;string&gt;\] \[-Repository &lt;string&gt;\] \[-FormatVersion &lt;version&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Publish-Module** -Path &lt;string&gt; \[-NuGetApiKey &lt;string&gt;\] \[-Repository &lt;string&gt;\] \[-FormatVersion &lt;version&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Install-Module** \[-Name\] &lt;string\[\]&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Scope &lt;string&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Install-Module** \[-InputObject\] &lt;psobject\[\]&gt; \[-Scope &lt;string&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Update-Module** \[\[-Name\] &lt;string\[\]&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Get-InstalledModule** \[\[-Name\] &lt;string\[\]&gt;\] \[-MinimumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-AllVersions\] \[&lt;CommonParameters&gt;\]

**Uninstall-Module** \[-Name\] &lt;string\[\]&gt; \[-MinimumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-AllVersions\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Uninstall-Module** \[-InputObject\] &lt;psobject\[\]&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Unregister-PSRepository** \[-Name\] &lt;string\[\]&gt; \[&lt;CommonParameters&gt;\]

**Set-PSRepository** -Name &lt;string&gt; \[-SourceLocation &lt;uri&gt;\] \[-PublishLocation &lt;uri&gt;\] \[-ScriptSourceLocation &lt;uri&gt;\] \[-ScriptPublishLocation &lt;uri&gt;\] \[-InstallationPolicy &lt;string&gt;\] \[-PackageManagementProvider &lt;string&gt;\] \[&lt;CommonParameters&gt;\]

**Get-PSRepository** \[\[-Name\] &lt;string\[\]&gt;\] \[&lt;CommonParameters&gt;\]

**Register-PSRepository** -Name &lt;string&gt; -SourceLocation &lt;uri&gt; \[-PublishLocation &lt;uri&gt;\] \[-ScriptSourceLocation &lt;uri&gt;\] \[-ScriptPublishLocation &lt;uri&gt;\] \[-InstallationPolicy &lt;string&gt;\] \[-PackageManagementProvider &lt;string&gt;\] \[&lt;CommonParameters&gt;\]

**New-ScriptFileInfo** \[-Path\] &lt;string&gt; -Description &lt;string&gt; \[-Version &lt;version&gt;\] \[-Author &lt;string&gt;\] \[-Guid &lt;guid&gt;\] \[-CompanyName &lt;string&gt;\] \[-Copyright &lt;string&gt;\] \[-RequiredModules &lt;Object\[\]&gt;\] \[-ExternalModuleDependencies &lt;string\[\]&gt;\] \[-RequiredScripts &lt;string\[\]&gt;\] \[-ExternalScriptDependencies &lt;string\[\]&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-PassThru\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Test-ScriptFileInfo** \[-Path\] &lt;string&gt; \[&lt;CommonParameters&gt;\]

**Test-ScriptFileInfo** -LiteralPath &lt;string&gt; \[&lt;CommonParameters&gt;\]

**Update-ScriptFileInfo** \[-Path\] &lt;string&gt; \[-Version &lt;version&gt;\] \[-Author &lt;string&gt;\] \[-Guid &lt;guid&gt;\] \[-Description &lt;string&gt;\] \[-CompanyName &lt;string&gt;\] \[-Copyright &lt;string&gt;\] \[-RequiredModules &lt;Object\[\]&gt;\] \[-ExternalModuleDependencies &lt;string\[\]&gt;\] \[-RequiredScripts &lt;string\[\]&gt;\] \[-ExternalScriptDependencies &lt;string\[\]&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-PassThru\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Update-ScriptFileInfo** \[-LiteralPath\] &lt;string&gt; \[-Version &lt;version&gt;\] \[-Author &lt;string&gt;\] \[-Guid &lt;guid&gt;\] \[-Description &lt;string&gt;\] \[-CompanyName &lt;string&gt;\] \[-Copyright &lt;string&gt;\] \[-RequiredModules &lt;Object\[\]&gt;\] \[-ExternalModuleDependencies &lt;string\[\]&gt;\] \[-RequiredScripts &lt;string\[\]&gt;\] \[-ExternalScriptDependencies &lt;string\[\]&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-PassThru\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Find-Script** \[\[-Name\] &lt;string\[\]&gt;\] \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-AllVersions\] \[-IncludeDependencies\] \[-Filter &lt;string&gt;\] \[-Tag &lt;string\[\]&gt;\] \[-Includes &lt;string\[\]&gt;\] \[-Command &lt;string\[\]&gt;\] \[-Repository &lt;string\[\]&gt;\] \[&lt;CommonParameters&gt;\]

**Install-Script** \[-Name\] &lt;string\[\]&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Scope &lt;string&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Install-Script** \[-InputObject\] &lt;psobject\[\]&gt; \[-Scope &lt;string&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Update-Script** \[\[-Name\] &lt;string\[\]&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Get-InstalledScript** \[\[-Name\] &lt;string\[\]&gt;\] \[-MinimumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[&lt;CommonParameters&gt;\]

**Uninstall-Script** \[-Name\] &lt;string\[\]&gt; \[-MinimumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Uninstall-Script** \[-InputObject\] &lt;psobject\[\]&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Script** \[-Name\] &lt;string\[\]&gt; -Path &lt;string&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Script** \[-Name\] &lt;string\[\]&gt; -LiteralPath &lt;string&gt; \[-MinimumVersion &lt;version&gt;\] \[-MaximumVersion &lt;version&gt;\] \[-RequiredVersion &lt;version&gt;\] \[-Repository &lt;string\[\]&gt;\] \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Script** \[-InputObject\] &lt;psobject\[\]&gt; -LiteralPath &lt;string&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Save-Script** \[-InputObject\] &lt;psobject\[\]&gt; -Path &lt;string&gt; \[-Force\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Publish-Script** -Path &lt;string&gt; \[-NuGetApiKey &lt;string&gt;\] \[-Repository &lt;string&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Publish-Script** -LiteralPath &lt;string&gt; \[-NuGetApiKey &lt;string&gt;\] \[-Repository &lt;string&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

**Update-ModuleManifest** \[-Path\] &lt;string&gt; \[-NestedModules &lt;Object\[\]&gt;\] \[-Guid &lt;guid&gt;\] \[-Author &lt;string&gt;\] \[-CompanyName &lt;string&gt;\] \[-Copyright &lt;string&gt;\] \[-RootModule &lt;string&gt;\] \[-ModuleVersion &lt;version&gt;\] \[-Description &lt;string&gt;\] \[-ProcessorArchitecture &lt;ProcessorArchitecture&gt;\] \[-PowerShellVersion &lt;version&gt;\] \[-ClrVersion &lt;version&gt;\] \[-DotNetFrameworkVersion &lt;version&gt;\] \[-PowerShellHostName &lt;string&gt;\] \[-PowerShellHostVersion &lt;version&gt;\] \[-RequiredModules &lt;Object\[\]&gt;\] \[-TypesToProcess &lt;string\[\]&gt;\] \[-FormatsToProcess &lt;string\[\]&gt;\] \[-ScriptsToProcess &lt;string\[\]&gt;\] \[-RequiredAssemblies &lt;string\[\]&gt;\] \[-FileList &lt;string\[\]&gt;\] \[-ModuleList &lt;Object\[\]&gt;\] \[-FunctionsToExport &lt;string\[\]&gt;\] \[-AliasesToExport &lt;string\[\]&gt;\] \[-VariablesToExport &lt;string\[\]&gt;\] \[-CmdletsToExport &lt;string\[\]&gt;\] \[-DscResourcesToExport &lt;string\[\]&gt;\] \[-PrivateData &lt;hashtable&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-LicenseUri &lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-HelpInfoUri &lt;uri&gt;\] \[-PassThru\] \[-DefaultCommandPrefix &lt;string&gt;\] \[-ExternalModuleDependencies &lt;string\[\]&gt;\] \[-PackageManagementProviders &lt;string\[\]&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

### Module dependency installation support, Get-InstalledModule and Uninstall-Module cmdlets

-   Added module dependencies population in the Publish-Module cmdlet. The RequiredModules and NestedModules lists of PSModuleInfo are used in preparing the dependency list of a module to be published.

-   Added dependency installation support in the Install-Module and Update-Module cmdlets. Module dependencies are installed and updated by default.

-   Added an -IncludeDependencies parameter to the Find-Module cmdlet to include module dependencies in the results.

-   Added -MaximumVersion support on the Find-Module, Install-Module, and Update-Module cmdlets.

-   Added new Get-InstalledModule and Uninstall-Module cmdlets.

PowerShellGet cmdlets demo with module dependencies support:

1.  Ensure that module dependencies are available on the repository.

PS C:\\windows\\system32&gt; Find-Module -Repository LocalRepo -Name RequiredModule1,RequiredModule2,RequiredModule3,NestedRequiredModule1,NestedRequiredModule2,NestedRequiredModule3 | Sort-Object -Property Name

Version    Name                     Repository    Description                  

-------    ----                     ----------    -----------                  

2.5        NestedRequiredModule1    LocalRepo     NestedRequiredModule1 module 

2.5        NestedRequiredModule2    LocalRepo     NestedRequiredModule2 module 

2.0        NestedRequiredModule3    LocalRepo     NestedRequiredModule3 module 

2.5        RequiredModule1          LocalRepo     RequiredModule1 module  

2.5        RequiredModule2          LocalRepo     RequiredModule2 module  

2.0        RequiredModule3          LocalRepo     RequiredModule3 module

1.  Create a module with dependencies that are specified in the RequiredModules and NestedModules properties of its module manifest.

$RequiredModules = @('RequiredModule1',

@{ModuleName = 'RequiredModule2'; ModuleVersion = '1.5'; },

@{ModuleName = 'RequiredModule3'; RequiredVersion = '2.0'; })

$NestedRequiredModules = @('TestDepWithNestedRequiredModules1.psm1', 'NestedRequiredModule1',

@{ModuleName = 'NestedRequiredModule2'; ModuleVersion = '1.5'; },

@{ModuleName = 'NestedRequiredModule3'; RequiredVersion = '2.0'; })

New-ModuleManifest -Path 'C:\\Program Files\\WindowsPowerShell\\Modules\\TestDepWithNestedRequiredModules1\\TestDepWithNestedRequiredModules1.psd1' \`

-NestedModules $NestedRequiredModules \`

-RequiredModules $RequiredModules \`

-ModuleVersion "1.0" \`

-Description "TestDepWithNestedRequiredModules1 module"

1.  Publish two versions (**“1.0”** and **“2.0”**) of the TestDepWithNestedRequiredModules1 module with dependencies to the repository.

Publish-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -NuGetApiKey "MyNuGet-ApiKey-For-LocalRepo"

1.  Find the TestDepWithNestedRequiredModules1 module with its dependencies by specifying -IncludeDependencies.

PS C:\\windows\\system32&gt; Find-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo –IncludeDependencies -MaximumVersion "1.0"

Version    Name                                Repository  Description 

-------    ----                                ----------  -----------  

1.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module  

2.5        RequiredModule1                     LocalRepo   RequiredModule1 module      

2.5        RequiredModule2                     LocalRepo   RequiredModule2 module      

2.0        RequiredModule3                     LocalRepo   RequiredModule3 module      

2.5        NestedRequiredModule1               LocalRepo   NestedRequiredModule1 module

2.5        NestedRequiredModule2               LocalRepo   NestedRequiredModule2 module

2.0        NestedRequiredModule3               LocalRepo   NestedRequiredModule3 module

 

1.  Use Find-Module metadata to find the module dependencies.

PS C:\\windows\\system32&gt; $psgetModuleInfo = Find-Module -Repository MSPSGallery -Name ModuleWithDependencies2

PS C:\\windows\\system32&gt; $psgetModuleInfo.Dependencies.ModuleName

RequiredModule1

RequiredModule2

RequiredModule3

NestedRequiredModule1

NestedRequiredModule2

NestedRequiredModule3

PS C:\\windows\\system32&gt; $psgetModuleInfo.Dependencies

Name Value

---- -----

ModuleName RequiredModule1

CanonicalId PowerShellGet:RequiredModule1/\#http://psget/psGallery/api/v2/

ModuleName RequiredModule2

ModuleVersion 2.0

CanonicalId PowerShellGet:RequiredModule2/2.0\#http://psget/psGallery/api/v2/

ModuleName RequiredModule3

RequiredVersion 2.5

CanonicalId PowerShellGet:RequiredModule3/\[2.5\]\#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule1

CanonicalId PowerShellGet:NestedRequiredModule1/\#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule2

ModuleVersion 2.0

CanonicalId PowerShellGet:NestedRequiredModule2/2.0\#http://psget/psGallery/api/v2/

ModuleName NestedRequiredModule3

RequiredVersion 2.5

CanonicalId PowerShellGet:NestedRequiredModule3/\[2.5\]\#http://psget/psGallery/api/v2/

1.  Install the TestDepWithNestedRequiredModules1 module with dependencies.

PS C:\\windows\\system32&gt; Install-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -RequiredVersion "1.0"

PS C:\\windows\\system32&gt; Get-InstalledModule

Version    Name                    Repository   Description                 

-------    ----                    ----------   -----------                 

1.0        NestedRequiredModule1   LocalRepo    NestedRequiredModule1 module

2.5        NestedRequiredModule2   LocalRepo    NestedRequiredModule2 module

2.0        NestedRequiredModule3   LocalRepo    NestedRequiredModule3 module

1.0        RequiredModule1         LocalRepo    RequiredModule1 module      

2.5        RequiredModule2                    LocalRepo    RequiredModule2 module 

2.0        RequiredModule3                    LocalRepo    RequiredModule3 module 

1.0        TestDepWithNestedRequiredModules1  LocalRepo    TestDepWithNestedRequiredModules1 module

 

1.  Update the TestDepWithNestedRequiredModules1 module with dependencies.

PS C:\\windows\\system32&gt; Find-Module -Name TestDepWithNestedRequiredModules1 -Repository LocalRepo -AllVersions

Version    Name                                Repository  Description

-------    ----                                ----------  -----------

1.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module

2.0        TestDepWithNestedRequiredModules1   LocalRepo   TestDepWithNestedRequiredModules1 module

PS C:\\windows\\system32&gt; Update-Module -Name TestDepWithNestedRequiredModules1 -RequiredVersion 2.0

PS C:\\windows\\system32&gt; Get-InstalledModule

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

1.  Run the Uninstall-Module cmdlet to uninstall a module that you installed by using PowerShellGet. If any other module depends on the module that you want to delete, PowerShellGet throws an error.

PS C:\\windows\\system32&gt; Get-InstalledModule -Name RequiredModule1 | Uninstall-Module

PackageManagement\\Uninstall-Package : The module 'RequiredModule1' of version '2.5' in module base folder 'C:\\Program Files\\WindowsPowerShell\\Modules\\RequiredModule1\\2.5' cannot be uninstalled, because one or more other modules 'ModuleWithDependencies2' are dependent on this module. Uninstall the modules that depend on this module before uninstalling module 'RequiredModule1'.

At C:\\Program Files\\WindowsPowerShell\\Modules\\PowerShellGet\\PSGet.psm1:1303 char:25

+ ... $null = PackageManagement\\Uninstall-Package @PSBoundParameters

+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+ CategoryInfo : InvalidOperation: (Microsoft.Power...ninstallPackage:UninstallPackage) \[Uninstall-Package\], Exception

+ FullyQualifiedErrorId : UnableToUninstallAsOtherModulesNeedThisModule,Uninstall-Package,Microsoft.PowerShell.PackageManagement.Cmdlets.Uninsta

llPackage

### Save-Module cmdlet

PS C:\\windows\\system32&gt; Save-Module -Repository MSPSGallery -Name ModuleWithDependencies2 -Path C:\\MySavedModuleLocation

PS C:\\windows\\system32&gt; dir C:\\MySavedModuleLocation

Directory: C:\\MySavedModuleLocation

Mode LastWriteTime Length Name

---- ------------- ------ ----

d----- 4/21/2015 5:40 PM ModuleWithDependencies2

d----- 4/21/2015 5:40 PM NestedRequiredModule1

d----- 4/21/2015 5:40 PM NestedRequiredModule2

d----- 4/21/2015 5:40 PM NestedRequiredModule3

d----- 4/21/2015 5:40 PM RequiredModule1

d----- 4/21/2015 5:40 PM RequiredModule2

d----- 4/21/2015 5:40 PM RequiredModule3

### Update-ModuleManifest cmdlet

This new cmdlet is used to help update manifest file with input property values. It takes all parameters that Test-ModuleManifest does.

We notice that a lot of module authors would like to specify “\*” in exported values such as FunctionsToExport, CmdletsToExport, etc. During module publishing to PowerShell Gallery, unspecified functions and commands will not be populated properly onto the Gallery. Therefore, we suggest module authors update their manifests with proper values.

Syntax:

 

Update-ModuleManifest \[-Path\] &lt;string&gt; \[-NestedModules &lt;Object\[\]&gt;\] \[-Guid &lt;guid&gt;\] \[-Author &lt;string&gt;\] \[-CompanyName

&lt;string&gt;\] \[-Copyright &lt;string&gt;\] \[-RootModule &lt;string&gt;\] \[-ModuleVersion &lt;version&gt;\] \[-Description &lt;string&gt;\]

\[-ProcessorArchitecture &lt;ProcessorArchitecture&gt;\] \[-PowerShellVersion &lt;version&gt;\] \[-ClrVersion &lt;version&gt;\]

\[-DotNetFrameworkVersion &lt;version&gt;\] \[-PowerShellHostName &lt;string&gt;\] \[-PowerShellHostVersion &lt;version&gt;\]

\[-RequiredModules &lt;Object\[\]&gt;\] \[-TypesToProcess &lt;string\[\]&gt;\] \[-FormatsToProcess &lt;string\[\]&gt;\] \[-ScriptsToProcess

&lt;string\[\]&gt;\] \[-RequiredAssemblies &lt;string\[\]&gt;\] \[-FileList &lt;string\[\]&gt;\] \[-ModuleList &lt;Object\[\]&gt;\] \[-FunctionsToExport

&lt;string\[\]&gt;\] \[-AliasesToExport &lt;string\[\]&gt;\] \[-VariablesToExport &lt;string\[\]&gt;\] \[-CmdletsToExport &lt;string\[\]&gt;\]

\[-DscResourcesToExport &lt;string\[\]&gt;\] \[-PrivateData &lt;hashtable&gt;\] \[-Tags &lt;string\[\]&gt;\] \[-ProjectUri &lt;uri&gt;\] \[-LicenseUri

&lt;uri&gt;\] \[-IconUri &lt;uri&gt;\] \[-ReleaseNotes &lt;string\[\]&gt;\] \[-HelpInfoUri &lt;uri&gt;\] \[-PassThru\] \[-DefaultCommandPrefix &lt;string&gt;\]

\[-ExternalModuleDependencies &lt;string\[\]&gt;\] \[-PackageManagementProviders &lt;string\[\]&gt;\] \[-WhatIf\] \[-Confirm\]

\[&lt;CommonParameters&gt;\]

If you have modules that have exported properties, Update-ModuleManifest will fill the specified manifest file with information from exported functions, cmdlets, variables etc:

PS C:\\WINDOWS\\system32&gt; Get-Content -Path "C:\\Temp\\PSGTEST-TestPackageMetadata\\2.5\\PSGTEST-TestPackageMetadata.psd1"

@{

\# Script module or binary module file associated with this manifest.

\# RootModule = ''

\# Version number of this module.

ModuleVersion = '2.5'

\# ID used to uniquely identify this module

GUID = '610e5c5b-dc42-4eaa-8511-ebfb44066d5e'

(Other properties removed here for Simplicity…)

\# Functions to export from this module

FunctionsToExport = '\*'

\# Cmdlets to export from this module

CmdletsToExport = '\*'

\# Variables to export from this module

VariablesToExport = '\*'

\# Aliases to export from this module

AliasesToExport = '\*'

After Update-ModuleManifest:

PS C:\\WINDOWS\\system32&gt; Update-ModuleManifest -Path "C:\\Temp\\PSGTEST-TestPackageMetadata\\2.5\\PSGTEST-TestPackageMetadata

.psd1"

PS C:\\WINDOWS\\system32&gt; Get-Content -Path "C:\\Temp\\PSGTEST-TestPackageMetadata\\2.5\\PSGTEST-TestPackageMetadata.psd1"

\#

\# Module manifest for module 'NewManifest'

\#

\# Generated by: manikb

\#

\# Generated on: 11/13/2015

\#

@{

\# Script module or binary module file associated with this manifest.

\# RootModule = ''

\# Version number of this module.

ModuleVersion = '2.5'

\# ID used to uniquely identify this module

GUID = '610e5c5b-dc42-4eaa-8511-ebfb44066d5e'

\# Functions to export from this module

FunctionsToExport = 'Get-FooFn Get-FooWF'

\# Cmdlets to export from this module

CmdletsToExport = 'Test-PSGetTestCmdlet'

For each module, there are also metadata fields associated with it. In order to display metadata properly on PowrShell Gallery, you can use Update-ModuleManifest to populate those fields under PrivateData.

PS C:\\WINDOWS\\system32&gt; Update-ModuleManifest -Path "C:\\Temp\\PSGTEST-TestPackageMetadata\\2.5\\PSGTEST-TestPackageMetadata

.psd1" -Tags "Tag1" -LicenseUri "http://license.com" -ProjectUri "http://project.com" -IconUri "http://icon.com" -Releas

eNotes "Test module"

PrivateData hashtable from the manifest file template has the following properties:

\# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.

PrivateData = @{

PSData = @{

\# Tags applied to this module. These help with module discovery in online galleries.

\# Tags = @()

\# A URL to the license for this module.

\# LicenseUri = ''

\# A URL to the main website for this project.

\# ProjectUri = ''

\# A URL to an icon representing this module.

\# IconUri = ''

\# ReleaseNotes of this module

\# ReleaseNotes = ''

\# External dependent modules of this module

\# ExternalModuleDependencies = ''

} \# End of PSData hashtable

} \# End of PrivateData hashtable

***Note:*** DscResourcesToExport is only supported on the latest PowerShell version 5.0. We won’t be able to update the field if you are running on previous PowerShell version.