---
title:   Improvements to Package Management in WMF 5.1 (Preview)
ms.date:  2016-07-15
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  jaimeo
contributor: jianyunt, quoctruong
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# Improvements to Package Management in WMF 5.1 (Preview) #

##Improvements in PackageManagement ##
The following are the fixes made in the WMF 5.1: 

### Version Alias

**Scenario**: If you have version 1.0 and 2.0 of a package, P1, installed on your system, and you want to uninstall version 1.0, you would run "uninstall-package -name P1 -version 1.0" and expect version 1.0 to be uninstalled after running the cmdlet. However the result is that version 2.0 gets uninstalled.  
	
This occurs because the "-version" parameter is an alias of the "-minimumversion" parameter. When OneGet is looking for a qualified package with the minimum version of 1.0, it returns the latest version. This behavior is expected in normal cases because finding the latest version is usually the desired result. However, it should not apply to the uninstall-package case..
	
**Solution**:removed -version alias entirely in OneGet and PowerShellGet. 

###Multiple prompts for bootstrapping the NuGet provider

**Scenario**: When you run Find-Module or Install-module or other OneGet cmdlets on your computer for the first time, OneGet tries to bootstrap the NuGet provider. It does this because the PowerShellGet provider also uses the NuGet provider to download PowerShell modules. OneGet then prompts the user for permission to install the NuGet provider. After the user selects "yes" for the bootstrapping, the latest version of the NuGet provider will be installed. 
	
However, in some cases, when you have an old version of NuGet provider installed on your computer, the older version of NuGet sometimes gets loaded first into the PowerShell session (that's the race condition in OneGet). However PowerShellGet requires the later version of the NuGet provider to work, so PowerShellGet asks the OneGet for bootstrapping the NuGet provider again. This results in multiple prompts for bootstrapping the NuGet provider.

**Solution**: In WMF5.1, OneGet loads the latest version of the NuGet provider to avoid multiple prompts for bootstrapping the NuGet provider.

You could also work around this issue by manually deleting the old version of the NuGet provider (NuGet-Anycpu.exe) if exists from $env:ProgramFiles\PackageManagement\ProviderAssemblies 
$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies


###Support for OneGet on computers with intranet access only

**Scenario**: For the enterprise scenario, people are working under an environment where there is no internet access but Intranet only. OneGet did not support this case in WMF 5.0.

**Scenario**: In WMF 5.0, OneGet did not support computers that have only intranet (but not internet) access.

**Solution**: In WMF 5.1, you can follow these steps to allow intranet computers to use OneGet:

1. Download the NuGet provider using another computer that has an internet connection by using Install-PackageProvider NuGet.

2. Find the NuGet provider under either  $env:ProgramFiles\PackageManagement\ProviderAssemblies\nuget  or  $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget. 

3. Copy the binaries to a folder or network share location that the intranet computer can access, and then install the NuGet provider with "Install-PackageProvider NuGet -Source <Path to folder>".


###Event logging improvements

When you install packages, you are changing the state of the computer. In WMF 5.1, OneGet now logs events to the Windows event log for install, uninstall, and save-package activities. The Event channel is the same as for PowerShell, that is, Microsoft-Windows-PowerShell, Operational.

###Support for basic authentication

In WMF 5.1, OneGet supports finding and installing packages from a repository that requires basic authentication. You can supply your credentials to the Find-Package and Install-Package cmdlets. For example:

``` PowerShell
Find-Package -Source <SourceWithCredential> -Credential (Get-Credential)
```
###Support for using OneGet behind a proxy

In WMF 5.1, OneGet now takes new proxy parameters: -ProxyCredential and -Proxy. Using these parameters, you can specify the proxy URL and credentials to OneGet cmdlets. By default, system proxy settings are used. For example:

``` PowerShell
Find-Package -Source http://www.nuget.org/api/v2/ -Proxy http://www.myproxyserver.com -ProxyCredential (Get-Credential)
```

