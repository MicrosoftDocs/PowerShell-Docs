# Register a PowerShell Repository
You can configure PowerShellGet to operate against internal repositories. This is done by using the following additions:
- Register-PSRepository: Registers a repository for the current user.
- Unregister-PSRepository: Removes a registered repository for the current user.
- Set-PSRepository: Set values for a registered repository.
- Get-PSRepository: Get all registered repositories for the current user.

After a repository is registered, you can use Find-Module and Install-Module to work with it.

```powershell
\#Register a default repository
Register-PSRepository –Name DemoRepo –SourceLocation “https://www.myget.org/F/powershellgetdemo/api/v2” –PublishLocation “<https://www.myget.org/F/powershellgetdemo/api/v2>/package” –InstallationPolicy –Trusted

\#Get all of the registered repositories
Get-PSRepository
Name SourceLocation
---- --------------
PSGallery https://msconfiggallery.cloudapp...
DemoRepo https://www.myget.org/F/powershe...

\#Search only the new repository for modules
Find-Module -Repository DemoRepo
Repository Version Name
---------- ------- ----
DemoRepo 1.0.1 xActiveDirectory
DemoRepo 1.1.1 SomeModule

\#By default, PowerShellGet operates against all registered repositories when none is specified. In this example, the “SomeModule” module is installed from the DemoRepo.
Install-Module SomeModule

\#Removing a repository
Unregister-PSRepository DemoRepo
```