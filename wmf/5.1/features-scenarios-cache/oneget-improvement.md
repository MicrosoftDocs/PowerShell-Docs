---
title: PackageManagement (aka. OneGet) Improvements
contributor:  jianyunt, quoctruong
---

>Note: provide a proposed descriptive title and a brief description

## PackageManagement (aka. OneGet) Improvements ##
The following are the fixes made in the WMF 5.1 to address some of the user experience gaps in the WMF 5.0 release. 

1 **Version Alias**

**Scenario**: Assuming you have version 1.0 and 2.0 of a package, P1, installed on your system, and now you want to uninstall version 1.0, so you run "uninstall-package -name P1 -version 1.0". You expect version 1.0 to be uninstalled after running the cmdlet. However the result is that version 2.0 gets uninstalled. 
	
The cause of the issue is that the "-version" parameter is an alias of the "-minimumversion" parameter. When OneGet is looking for a qualitied package with the minimum version of 1.0, it returns the latest version. This behavior is expected under normal cases because finding the latest version is what most people want. However, it should not apply to the uninstall-package case.
	
**Solution**:removed -version alias entirely in OneGet and PowerShellGet. 

2 **Multiple Prompts for Bootstrapping NuGet Provider**

**Scenario**: When you run Find-Module or install-module or other OneGet cmdlets on your machine for the first time, OneGet is trying to bootstrap the NuGet provider. That's because the PowershellGet provider also uses the NuGet provider to download PowerShell modules. OneGet then prompts the user for permission to install the NuGet provider. After the user selects "yes" for the bootstrapping, the latest version of the NuGet provider will be installed. 
	
However there is a case when you have an old version of NuGet provider installed on your machine, the older version of NuGet sometimes gets loaded first into the PowerShell session(that's the race condition in OneGet). However PowerShellGet requires the later version of Nuget provider to work, so PowerShellGet asks the OneGet for bootstrapping the NuGet provider again. That's why you see the mulitple prompts for bootstrapping the NuGet provider.

**Solution**: OneGet now loads the latest version of the NuGet provider to avoid multiple prompts for bootstrapping the NuGet provider.

A workaround also exists, i.e. manually delete the old version of the NuGet provider (NuGet-Anycpu.exe) if exists from $env:ProgramFiles\PackageManagement\ProviderAssemblies 
$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies


3 **Machine with Intranet only**

**Scenario**: For the enterprise scenario, people are working under an environment where there is no internet access but Intranet only. OneGet did not support this case in WMF 5.0.

**Solution**:
- You can download the NuGet provider on another machine with Internet connection by using the command "Install-PackageProvider -Name NuGet".

- Find the NuGet provider you just installed under either  $env:ProgramFiles\PackageManagement\ProviderAssemblies\nuget  or  $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget. 

- Copy the binaries over to a folder or network share location that your machine (the one without Internet) have access too and install NuGet provider with "Install-PackageProvider NuGet -Source <Path to folder>".


4 **Event log**

When you install packages, you are changing the state of your machine. For diagnosis purpose, OneGet now logs events to the Windows event log for install, uninstall, and save-package. The Event channel is the same as PowerShell, that is, Microsoft-Windows-PowerShell, Operational.

5 **Authentication Support**
OneGet now supports finding and installing packages from a repository that requires basic authentication. You can supply your credential to the Find-Package and Install-Package cmdlet. For example:
``` PowerShell
Find-Package -Source <SourceWithCredential> -Credential (Get-Credential)
```
6 **Using OneGet Behind a Proxy**

OneGet now takes proxy parameters: -ProxyCredential and -Proxy. Using these parameters, you can specify proxy url and proxy credential to OneGet cmdlets (by default, we use the system proxy settings). For example:
``` PowerShell
Find-Package -Source http://www.nuget.org/api/v2/ -Proxy http://www.myproxyserver.com -ProxyCredential (Get-Credential)
```
