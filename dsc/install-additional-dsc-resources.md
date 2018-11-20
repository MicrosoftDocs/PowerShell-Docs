---
ms.date:  10/16/2017
keywords:  dsc,powershell,resource,gallery,setup
title:  Install Additional DSC Resources
---

# Install Additional DSC Resources

PowerShell includes several Out-of-the-box resources for Desired State Configuration (DSC). The **PSDesiredStateConfiguration** module contains all of the OOB DSC resources available on your specific instance of PowerShell.

This is a list of the OOB resources included in PowerShell 4.0 and a description of the resource's capabilities.

> [!NOTE]
> This is an incomplete list, as the number of OOB resources has grown with each version of PowerShell.

|Resource  |Description  |
|---------|---------|
|**File**|Controls the state of files and directories. Copies files from a **Source** to a **Destination** and updates them when the **Source** changes by comparing dates, checksums, and hashes.|
|**Archive**|Unpacks archives and a specified location. Validates the archives with a specified **Checksum**.|
|**Environment**|Manages environment variables.|
|**Group**|Manages local groups and controls group membership.|
|**Log**|Writes messages to the `Microsoft-Windows-Desired State Configuration/Analytic` event log.|
|**Package**|Installs or uninstalls packages using **Arguments**, **LogPath**, **ReturnCode**, other settings.|
|**Registry**|Manages registry keys and values.|
|**Script**|Allows you to design your own [get-test-set](get-test-set.md) script blocks.|
|**Service**|Configures Windows services.|
|**User** |Manages local users and attributes.|
|**WindowsFeature**|Manages roles and features.|
|**WindowsProcess**|Configures Windows processes.|

The OOB resources allow a good starting point for common operations. If the OOB resources do not meet your needs, you can write your own [Custom Resource](authoringresource.md). Before you write a custom resource to solve your problem, you should look through the vast number of DSC resources that have already been created by both Microsoft and the PowerShell community.

You can find DSC resources in both the [PowerShell Gallery](https://www.powershellgallery.com/) and [GitHub](https://github.com/). You can also install DSC resources directly from the PowerShell console using [PowerShellGet](/powershell/module/powershellget/).

## Installing PowerShellGet

To determine if you already have **PowerShell** get, or to get help installing it, see the following guide: [Installing PowerShellGet](/powershell/gallery/installing-psget).

## Finding DSC resources using PowerShellGet

Once **PowerShellGet** is installed on your system, you can find and install DSC resources hosted in the [PowerShell Gallery](https://www.powershellgallery.com/).

First, use the [Find-DSCResource](Find-DSCResource.md) cmdlet to find DSC resources. When you run `Find-DSCResource` for the first time, you see the following prompt to install the "Nuget provider".

```
PS> Find-DSCResource

NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The
NuGet provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\xAdministrator\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet provider
 by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to
install and import the NuGet provider now?
[Y] Yes  [N] No  [?] Help (default is "Y"):
```

After pressing 'y', the "Nuget" provider is installed, you see a list of DSC resources that you can install from the PowerShell Gallery.

> [!NOTE]
> List is not shown because it is very large.

You can also specify the `-Name` parameter using wildcards, or `-Filter` parameter without wildcards to narrow down your search. This example attempts to find a "TimeZone" DSC resource using the wildcarded name "\*Time\*"

```
PS> Find-DSCResource -Name *Time*

Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Carbon_EnvironmentVariable          2.6.0      Carbon                              PSGallery
Carbon_FirewallRule                 2.6.0      Carbon                              PSGallery
Carbon_Group                        2.6.0      Carbon                              PSGallery
Carbon_IniFile                      2.6.0      Carbon                              PSGallery
Carbon_Permission                   2.6.0      Carbon                              PSGallery
Carbon_Privilege                    2.6.0      Carbon                              PSGallery
Carbon_ScheduledTask                2.6.0      Carbon                              PSGallery
Carbon_Service                      2.6.0      Carbon                              PSGallery
TimeZone                            6.0.0.0    ComputerManagementDsc               PSGallery
xTimeZone                           1.8.0.0    xTimeZone                           PSGallery
xSqlServerDefaultDir                1.0.0      mlSqlServerDSC                      PSGallery
xSqlServerMoveDatabaseFiles         1.0.0      mlSqlServerDSC                      PSGallery
xSqlServerSQLDataRoot               1.0.0      mlSqlServerDSC                      PSGallery
xSqlServerStartupParam              1.0.0      mlSqlServerDSC                      PSGallery
```

## Installing DSC Resources using PowerShellGet

To install a DSC resource, usse the [Install-Module](Install-Module.md) cmdlet, specifying the name of the module shown under **Module** name in your search results.

The "TimeZone" resource exists in the "ComputerManagementDSC" module, so that is the module this example installs.

> [!NOTE]
> If you have not trusted the PowerShell gallery, you see the warning below asking for confirmation, and instructing you how to avoid subsequent prompts on installs.

```
PS> Install-Module -Name ComputerManagementDSC

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its
InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):
```

Press 'y' to continue installing the module. After install, you can verify that your new resource is installed using [Get-DSCResource](Get-DSCResource.md).

```
PS> Get-DSCResource -Name TimeZone -Syntax

TimeZone [String] #ResourceName
{
    IsSingleInstance = [string]{ Yes }
    TimeZone = [string]
    [DependsOn = [string[]]]
    [PsDscRunAsCredential = [PSCredential]]
}
```

You can also view other resources in your newly installed module, by specifying the `-ModuleName` parameter.

```
PS> Get-DSCResource -Module ComputerManagementDSC

ImplementedAs   Name                      ModuleName                     Version    Properties
-------------   ----                      ----------                     -------    ----------
PowerShell      Computer                  ComputerManagementDsc          6.0.0.0    {Name, Credential, DependsOn, ...
PowerShell      OfflineDomainJoin         ComputerManagementDsc          6.0.0.0    {IsSingleInstance, RequestFile...
PowerShell      PowerPlan                 ComputerManagementDsc          6.0.0.0    {IsSingleInstance, Name, Depen...
PowerShell      PowerShellExecutionPolicy ComputerManagementDsc          6.0.0.0    {ExecutionPolicy, ExecutionPol...
PowerShell      ScheduledTask             ComputerManagementDsc          6.0.0.0    {TaskName, ActionArguments, Ac...
PowerShell      TimeZone                  ComputerManagementDsc          6.0.0.0    {IsSingleInstance, TimeZone, D...
PowerShell      VirtualMemory             ComputerManagementDsc          6.0.0.0    {Drive, Type, DependsOn, Initi...
```

## See also

- [What are Resources?](resources.md)
- [Install PowerShellGet using DSC](install-powershellget-using-dsc.md)
