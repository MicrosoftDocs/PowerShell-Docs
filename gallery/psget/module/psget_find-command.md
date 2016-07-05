# Find-Command

Finds PowerShell commands in modules.

## Description
The Find-Command cmdlet finds PowerShell commands such as cmdlets, aliases, functions, and workflows. Find-Command searches modules in registered repositories.
For each command that this cmdlet finds, it returns a PSGetCommandInfo object. You can pass a PSGetCommandInfo object to the Install-Module cmdlet to install the module that contains the command.

- Find-Command can filter with version parameters: MinimumVersion, RequiredVersion, AllVersions.
  - These parameters are mutually exclusive.
  - These version parameters are allowed only with the single module name without any wildcards.
  - If the RequiredVersion parameter is not specified, Find-Command returns the latest version of the module that is equal to or greater than the minimum version specified or the latest version of the module if no minimum version is specified.
  - If the RequiredVersion parameter is specified, Find-Command only returns the version of the module that exactly matches the specified version.
- Find-Command can filter on module metadata with the -Tag parameter
- Find-Command can filter on repository-specific search language with the -Filter parameter.
- Find-Command can filter on modules from all or few of the registered repositories.

## Cmdlet syntax
```powershell
Get-Command -Name Find-Command -Module PowerShellGet -Syntax
```

## Cmdlet online help reference

[Find-Command](http://go.microsoft.com/fwlink/?LinkId=733636)

## Example commands
```powershell

# Find a specific command
Find-Command -Name Get-ScriptAnalyzerRule

Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Get-ScriptAnalyzerRule              1.5.0      PSScriptAnalyzer                    PSGallery

# Find multiple commands
Find-Command -Name Get-ScriptAnalyzerRule, Invoke-ScriptAnalyzer

# Find all available commands from all registered repositories
Find-Command

# Find available commands from few registered repositories
Find-Command -Repository PSGallery,PrivatePSGallery

# Find all commands in a specified repository
Find-Command -Repository PSGallery

# Find a command defined in a specific module
Find-Command -Name Get-ScriptAnalyzerRule -Module PSScriptAnalyzer

# Find commands from all versions of a module
Find-Command -ModuleName PSReadline -AllVersions

# Find commands with module name and MinimumVersion.
Find-Command -ModuleName PSReadline -MinimumVersion 1.1

# Find commands with module name and exact version
Find-Command -ModuleName AzureRM -RequiredVersion 1.4.0

# Find commands defined modules with -Filter based search. -Filter searches in description and module names
Find-Command -Filter Cookbook
Find-Command -Filter RBAC

# Find all commands with tags Azure or DSC in module metadata
Find-Command -Tag Azure, DSC

```