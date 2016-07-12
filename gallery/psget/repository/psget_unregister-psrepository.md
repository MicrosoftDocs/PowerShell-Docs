# Unregister-PSRepository

Unregisters a repository.

## Description

The Unregister-PSRepository cmdlet unregisters a repository for the current user.
- Unregistration and re-registration of the PSGallery repository is allowed for an enterprise and disconnected scenarios.
- Users can re-register the PSGallery by simply running `Register-PSRepository -Default`
- Since PSGallery is the default publish repository in Publish-Module and Publish-Script cmdlets, an error will be thrown if PSGallery is not available in the registered repository list.

## Cmdlet syntax

```powershell
Get-Command -Name Unregister-PSRepository -Module PowerShellGet -Syntax
```
## Cmdlet online help reference

[Unregister-PSRepository](http://go.microsoft.com/fwlink/?LinkID=517130)

## Example commands

```powershell
Unregister-PSRepository -Name "MyPrivateGallery"

Get-PSRepository exp | Unregister-PSRepository
```

### Unregistration and re-registration of the PSGallery repository is allowed for an enterprise and disconnected scenarios.
```powershell

# Unregister PSGallery repository
Unregister-PSRepository PSGallery

# Publish-Module throws an error when PSGallery is not a registered repository
Publish-Module -Name MyModule
publish-module : Unable to find repository 'PSGallery'. Use Get-PSRepository to see all available repositories. Try again after specifying a valid repository name. You can use 'Register-PSRepository -Default' to register the PSGallery repository.
At line:1 char:1
+ publish-module -name mymodule
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (PSGallery:String) [Publish-Module], ArgumentException
    + FullyQualifiedErrorId : PSGalleryNotFound,Publish-Module

# Re-register PSGallery repository
Register-PSRepository -Default
```