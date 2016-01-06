# PowerShell Module Discovery, Install and Inventory with PowerShellGet
 
PowerShellGet is included in this release of WMF:
-   Find-Module can filter on module metadata with the -Tag parameter
-   Find-Module can filter on repository-specific search language with the -Filter parameter
-   Find-Module can filter based on module contents with the -Command, -DscResource, and -Includes parameters
-   Find-DscResource allows discovery of individual DSC resources in repositories
-   Support for installing from and publishing to file shares with NuGet

## Example commands
```powershell
\# Find all modules with tags Azure or DSC
Find-Module -Tag Azure, DSC

\# Find modules with a specific DscResource
Find-Module -DscResource xFirewall

\#Find modules with specific commands
Find-Module -Command Get-ScriptAnalyzerRule, Invoke-ScriptAnalyzer

\# Find all modules with Dsc resources
Find-Module -Includes DscResource

\# Find all modules with cmdlets
Find-Module -Includes Cmdlet

\# Find all modules with functions
Find-Module -Includes Function

\# Find all DSC resources
Find-DscResource

\# Find all DSC resources contained within a specific module
Find-DscResource -ModuleName xNetworking

\# Find all DSC resources in modules with DSCResourceKit or DesiredStateConfiguration
Find-DscResource -Tag DesiredStateConfiguration, DSCResourceKit

\# Find modules using -Filter parameter
\# Specified filter value is searched in Name and Description properties
Find-Module -Filter Cookbook -Repository PSGallery
Find-Module -Filter RBAC -Repository PSGallery
```

## New features in PowerShellGet
-   Side-by-side version support on Windows PowerShell 5.0 or newer
-   Module dependency installation support
-   Three new cmdlets
    -   Get-InstalledModule
    -   Uninstall-Module
    -   Save-Module
    