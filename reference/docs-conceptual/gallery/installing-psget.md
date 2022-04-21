---
description: This article explains how to install the PowerShellGet module in various versions of PowerShell.
ms.date: 04/21/2022
title: Installing PowerShellGet
---
# Installing PowerShellGet on Windows

Windows PowerShell 5.1 comes with version 1.0.0.1 of **PowerShellGet** preinstalled.

> [!IMPORTANT]
> This version of PowerShellGet has a limited features and doesn't support the updated capabilities
> of the PowerShell Gallery. To be supported, you must update to the latest version.

PowerShell 6.0 shipped with version 1.6.0 of **PowerShellGet**. PowerShell 7.0 shipped with version
2.2.3 of **PowerShellGet**. The current supported version of **PowerShellGet** is 2.2.5.

If you are running PowerShell 6 or higher, you have a usable version of **PowerShellGet**. If you
are running Windows PowerShell 5.1, you must install a newer version.

For best results, you should always install the latest supported version.

## Updating the preinstalled version of PowerShellGet

The PowerShellGet module includes cmdlets to install and update modules:

- `Install-Module` installs the latest (non-prerelease) version of a module.
- `Update-Module` installs the latest (non-prerelease) version of a module if it is newer than the
  currently installed module. However, this cmdlet only works if the previous version was installed
  using `Install-Module`.

To update the preinstalled module you must use install a new version using `Install-Module`. After
you have installed the new version from the PowerShell Gallery, you can use `Update-Module` to
install newer releases.

## Updating PowerShellGet for Windows PowerShell 5.1

### System requirements

- **PowerShellGet** requires .NET Framework 4.5 or above. For more information, see
  [Install the .NET Framework for developers](/dotnet/framework/install/guide-for-developers).

- To access the PowerShell Gallery, you must use Transport Layer Security (TLS) 1.2 or higher. By
  default, PowerShell is not configured to use TLS 1.2. Use the following command to enable TLS 1.2
  in your PowerShell session.

  ```powershell
  [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
  ```

  We also recommend adding this line of code to your PowerShell profile script. For more information
  about profiles, see
  [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles).

### Installing the latest version of PowerShellGet

Windows PowerShell 5.1 comes with **PowerShellGet** version 1.0.0.1, which doesn't include the NuGet
provider. The provider is required by **PowerShellGet** when working with the PowerShell Gallery.

> [!NOTE]
> The following commands must be run from an elevated PowerShell session. Right-click the PowerShell
> icon and choose **Run as administrator** to start an elevated session.

There are two ways to install the NuGet provider:

- Use `Install-PackageProvider` to install NuGet before installing other modules

  Run the following command to install the NuGet provider.

  ```powershell
  Install-PackageProvider -Name NuGet -Force
  ```

  After you have installed the provider you should be able to use any of the **PowerShellGet**
  cmdlets with the PowerShell Gallery.

- Let `Install-Module` prompt you to install the NuGet provider

  The following command attempts to install the updated PowerShellGet module without the NuGet
  provider.

  ```powershell
  Install-Module PowerShellGet -AllowClobber -Force
  ```

  `Install-Module` prompts you to install the NuGet provider. Type <kbd>Y</kbd> to install the
  provider.

  ```Output
  NuGet provider is required to continue
  PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based
  repositories. The NuGet provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies'
  or 'C:\Users\user1\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet
  provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you
  want PowerShellGet to install and import the NuGet provider now?
  [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
  VERBOSE: Installing NuGet provider.
  ```

> [!NOTE]
> If you have not configured TLS 1.2, any attempts to install the NuGet provider and other
> packages will fail.

### After installing PowerShellGet

After you have installed the new version of **PowerShellGet**, you should open a new PowerShell
session. PowerShell automatically loads the newest version of the module when you use a
**PowerShellGet** cmdlet.

We also recommend that you register the PowerShell Gallery as a trusted repository. Use the following command:

```powershell
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
```

For more information, see [Set-PSRepository](xref:PowerShellGet.Set-PSRepository).
