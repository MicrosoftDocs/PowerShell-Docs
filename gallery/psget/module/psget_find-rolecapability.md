# Find-RoleCapability

Finds role capabilities in modules.

## Description
The Find-RoleCapability cmdlet finds PowerShell role capabilities in modules. Find-RoleCapability searches modules in registered repositories. 
For each role capability that this cmdlet finds, it returns a PSGetRoleCapabilityInfo object. You can pass a PSGetRoleCapabilityInfo object to the Install-Module cmdlet to install the module that contains the role capability.
PowerShell role capabilities define which commands, applications, and so on are available to a user at a Just Enough Administration (JEA) endpoint. Role capabilities are defined by files with a .psrc extension.

- Find-RoleCapability can filter with version parameters: MinimumVersion, RequiredVersion, AllVersions.
  - These parameters are mutually exclusive.
  - These version parameters are allowed only with the single module name without any wildcards.
  - If the RequiredVersion parameter is not specified, Find-RoleCapability returns the latest version of the module that is equal to or greater than the minimum version specified or the latest version of the module if no minimum version is specified.
  - If the RequiredVersion parameter is specified, Find-RoleCapability only returns the version of the module that exactly matches the specified version.
- Find-RoleCapability can filter on module metadata with the -Tag parameter
- Find-RoleCapability can filter on repository-specific search language with the -Filter parameter.
- Find-RoleCapability can filter on modules from all or few of the registered repositories.

## Cmdlet syntax
```powershell
Get-Command -Name Find-RoleCapability -Module PowerShellGet -Syntax
```

## Cmdlet online help reference

[Find-RoleCapability](http://go.microsoft.com/fwlink/?LinkId=718029)

## Example commands
```powershell

# Find a specific role capability
Find-RoleCapability -Name Maintenance

Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Maintenance                         1.5.0      RoleCapModule                       PrivatePSGallery

# Find multiple role capabilities
Find-RoleCapability -Name MyJeaRole, Maintenance

# Find all available role capabilities from all registered repositories
Find-RoleCapability

# Find available role capabilities from few registered repositories
Find-RoleCapability -Repository PSGallery,PrivatePSGallery

# Find all role capabilities in a specified repository
Find-RoleCapability -Repository PSGallery

# Find a role capability defined in a specific module
Find-RoleCapability -Name Maintenance -ModuleName RoleCapModule

# Find role capabilities from all versions of a module
Find-RoleCapability -ModuleName RoleCapModule -AllVersions

# Find role capabilities with module name and MinimumVersion.
Find-RoleCapability -ModuleName RoleCapModule -MinimumVersion 1.1

# Find role capabilities with module name and exact version
Find-RoleCapability -ModuleName RoleCapModule -RequiredVersion 1.4.0

# Find role capabilities defined modules with -Filter based search. -Filter searches in description and module names
Find-RoleCapability -Filter Cookbook
Find-RoleCapability -Filter RBAC

# Find all role capabilities with tags Azure or DSC in module metadata
Find-RoleCapability -Tag Azure, DSC

```