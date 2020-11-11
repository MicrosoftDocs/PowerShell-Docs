---
ms.date: 06/12/2017
title: Improvements to Package Management in WMF 5.1
description: Windows PowerShell 5.1 includes updated Package Management cmdlets.
---
# Improvements to Package Management in WMF 5.1

The following are the fixes made in the WMF 5.1:

## Version Alias

**Scenario**: If you have version 1.0 and 2.0 of a package, P1, installed on your system, and you
want to uninstall version 1.0, you would run `Uninstall-Package -Name P1 -Version 1.0` and expect
version 1.0 to be uninstalled after running the cmdlet. However the result is that version 2.0 gets
uninstalled.

This occurs because the `-Version` parameter is an alias of the `-MinimumVersion` parameter. When
PackageManagement is looking for a qualified package with the minimum version of 1.0, it returns the
latest version. This behavior is expected in normal cases because finding the latest version is
usually the desired result. However, it should not apply to the `Uninstall-Package` case.

**Solution**:removed `-Version` alias entirely in PackageManagement (a.k.a. OneGet) and
PowerShellGet.

## Multiple prompts for bootstrapping the NuGet provider

**Scenario**: When you run `Find-Module` or `Install-Module` or other PackageManagement cmdlets on
your computer for the first time, PackageManagement tries to bootstrap the NuGet provider. It does
this because the PowerShellGet provider also uses the NuGet provider to download PowerShell modules.
PackageManagement then prompts the user for permission to install the NuGet provider. After the user
selects "yes" for the bootstrapping, the latest version of the NuGet provider will be installed.

However, in some cases, when you have an old version of NuGet provider installed on your computer,
the older version of NuGet sometimes gets loaded first into the PowerShell session (that's the race
condition in PackageManagement). However PowerShellGet requires the later version of the NuGet
provider to work, so PowerShellGet asks PackageManagement to bootstrap the NuGet provider again.
This results in multiple prompts for bootstrapping the NuGet provider.

**Solution**: In WMF5.1, PackageManagement loads the latest version of the NuGet provider to avoid
multiple prompts for bootstrapping the NuGet provider.

You could also work around this issue by manually deleting the old version of the NuGet provider
(NuGet-Anycpu.exe) if exists from $env:ProgramFiles\PackageManagement\ProviderAssemblies
$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies

## Support for PackageManagement on computers with Intranet access only

**Scenario**: For the enterprise scenario, people are working under an environment where there is no
Internet access but Intranet only. PackageManagement did not support this case in WMF 5.0.

**Scenario**: In WMF 5.0, PackageManagement did not support computers that have only Intranet (but
not Internet) access.

**Solution**: In WMF 5.1, you can follow these steps to allow Intranet computers to use
PackageManagement:

1. Download the NuGet provider using another computer that has an Internet connection by using
   `Install-PackageProvider -Name NuGet`.

2. Find the NuGet provider under either
   `$env:ProgramFiles\PackageManagement\ProviderAssemblies\nuget` or
   `$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget`.

3. Copy the binaries to a folder or network share location that the Intranet computer can access,
   and then install the NuGet provider with
   `Install-PackageProvider -Name NuGet -Source <Path to folder>`.

## Event logging improvements

When you install packages, you are changing the state of the computer. In WMF 5.1, PackageManagement
now logs events to the Windows event log for `Install-Package`, `Uninstall-Package`, and
`Save-Package` activities. The Event log is the same as for PowerShell, that is,
`Microsoft-Windows-PowerShell, Operational`.

## Support for basic authentication

In WMF 5.1, PackageManagement supports finding and installing packages from a repository that
requires basic authentication. You can supply your credentials to the `Find-Package` and
`Install-Package` cmdlets. For example:

```powershell
Find-Package -Source <SourceWithCredential> -Credential (Get-Credential)
```

## Support for using PackageManagement behind a proxy

In WMF 5.1, PackageManagement now takes new proxy parameters `-ProxyCredential` and `-Proxy`. Using
these parameters, you can specify the proxy URL and credentials to PackageManagement cmdlets. By
default, system proxy settings are used. For example:

```powershell
Find-Package -Source https://www.nuget.org/api/v2/ -Proxy http://www.myproxyserver.com -ProxyCredential (Get-Credential)
```
