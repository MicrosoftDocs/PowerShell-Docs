---
ms.date:  12/23/2019
keywords:  powershell,cmdlet
title:  Working with Software Installations
description: This article shows how to use WMI to manage software installed in Windows.
---
# Working with Software Installations

Applications that are designed to use Windows Installer can be accessed through WMI's
**Win32_Product** class, but not all applications in use today use the Windows Installer.
Applications that use alternate setup routines are not usually managed by the Windows Installer.
Specific techniques for working with those applications depends on the installer software and
decisions made by the application developer. For example, applications installed by copying the
files to a folder on the computer usually cannot be managed by using techniques discussed here. You
can manage these applications as files and folders by using the techniques discussed in
[Working With Files and Folders](Working-with-Files-and-Folders.md).

> [!CAUTION]
> The **Win32_Product** class is not query optimized. Queries that use wildcard filters cause WMI to
> use the MSI provider to enumerate all installed products then parse the full list sequentially to
> handle the filter. This also initiates a consistency check of packages installed, verifying and
> repairing the install. The validation is a slow process and may result in errors in the event
> logs. For more information seek [KB article 974524](https://support.microsoft.com/help/974524).

## Listing Windows Installer Applications

To list the applications installed with the Windows Installer on a local or remote system, use the
following simple WMI query:

```powershell
Get-CimInstance -Class Win32_Product |
  Where-Object Name -eq "Microsoft .NET Core Runtime - 2.1.5 (x64)"
```

```Output
Name             Caption                   Vendor                    Version       IdentifyingNumber
----             -------                   ------                    -------       -----------------
Microsoft .NET … Microsoft .NET Core Runt… Microsoft Corporation     16.84.26919   {BEB59D04-C6DD-4926-AFE…
```

To display all the properties of the **Win32_Product** object to the display, use the **Properties**
parameter of the formatting cmdlets, such as the `Format-List` cmdlet, with a value of `*` (all).

```powershell
Get-CimInstance -Class Win32_Product |
  Where-Object Name -eq "Microsoft .NET Core Runtime - 2.1.5 (x64)" |
    Format-List -Property *
```

```Output
Name                  : Microsoft .NET Core Runtime - 2.1.5 (x64)
Version               : 16.84.26919
InstallState          : 5
Caption               : Microsoft .NET Core Runtime - 2.1.5 (x64)
Description           : Microsoft .NET Core Runtime - 2.1.5 (x64)
IdentifyingNumber     : {BEB59D04-C6DD-4926-AFEB-410CBE2EBCE4}
SKUNumber             :
Vendor                : Microsoft Corporation
AssignmentType        : 1
HelpLink              :
HelpTelephone         :
InstallDate           : 20181105
InstallDate2          :
InstallLocation       :
InstallSource         : C:\ProgramData\Package Cache\{BEB59D04-C6DD-4926-AFEB-410CBE2EBCE4}v16.84.26919\
Language              : 1033
LocalPackage          : C:\WINDOWS\Installer\4f97a771.msi
PackageCache          : C:\WINDOWS\Installer\4f97a771.msi
PackageCode           : {9A271A10-039D-49EA-8D24-043D91B9F915}
PackageName           : dotnet-runtime-2.1.5-win-x64.msi
ProductID             :
RegCompany            :
RegOwner              :
Transforms            :
URLInfoAbout          :
URLUpdateInfo         :
WordCount             : 0
PSComputerName        :
CimClass              : root/cimv2:Win32_Product
CimInstanceProperties : {Caption, Description, IdentifyingNumber, Name...}
CimSystemProperties   : Microsoft.Management.Infrastructure.CimSystemProperties
```

Or, you could use the `Get-CimInstance` **Filter** parameter to select only Microsoft .NET 2.0
Runtime. The value of the **Filter** parameter uses WMI Query Language (WQL) syntax, not Windows
PowerShell syntax. For example:

```powershell
Get-CimInstance -Class Win32_Product -Filter "Name='Microsoft .NET Core Runtime - 2.1.5 (x64)'" |
  Format-List -Property *
```

To list only the properties that interest you, use the **Property** parameter of the formatting
cmdlets to list the desired properties.

```powershell
Get-CimInstance -Class Win32_Product  -Filter "Name='Microsoft .NET Core Runtime - 2.1.5 (x64)'" |
  Format-List -Property Name,InstallDate,InstallLocation,PackageCache,Vendor,Version,IdentifyingNumber
```

```Output
Name              : Microsoft .NET Core Runtime - 2.1.5 (x64)
InstallDate       : 20180816
InstallLocation   :
PackageCache      : C:\WINDOWS\Installer\4f97a771.msi
Vendor            : Microsoft Corporation
Version           : 16.72.26629
IdentifyingNumber : {ACC73072-9AD5-416C-94BF-D82DDCEA0F1B}
```

## Listing All Uninstallable Applications

Because most standard applications register an uninstaller with Windows, we can work with those
locally by finding them in the Windows registry. There is no guaranteed way to find every
application on a system. However, it is possible to find all programs with listings displayed in
**Add or Remove Programs** in the following registry key:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`.

We can examine this key to find applications. To make it easier to view the Uninstall key, we
can map a PowerShell drive to this registry location:

```powershell
New-PSDrive -Name Uninstall -PSProvider Registry -Root HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
```

```Output
Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
Uninstall  Registry      HKEY_LOCAL_MACHINE\SOFTWARE\Micr...
```

We now have a drive named "Uninstall:" that can be used to quickly and conveniently look for
application installations. We can find the number of installed applications by counting the number
of registry keys in the Uninstall: PowerShell drive:

```powershell
(Get-ChildItem -Path Uninstall:).Count
```

```Output
459
```

We can search this list of applications further by using a variety of techniques, beginning with
`Get-ChildItem`. To get a list of applications and save them in the `$UninstallableApplications`
variable, use the following command:

```powershell
$UninstallableApplications = Get-ChildItem -Path Uninstall:
```

To display the values of the registry entries in the registry keys under Uninstall, use the GetValue
method of the registry keys. The value of the method is the name of the registry entry.

For example, to find the display names of applications in the Uninstall key, use the following
command:

```powershell
$UninstallableApplications | ForEach-Object -Process { $_.GetValue('DisplayName') }
```

There is no guarantee that these values are unique. In the following example, two installed items
appear as "Windows Media Encoder 9 Series":

```powershell
$UninstallableApplications | Where-Object -FilterScript {
  $_.GetValue("DisplayName") -eq "Microsoft Silverlight"
}
```

```Output
    Hive: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

Name                           Property
----                           --------
{89F4137D-6C26-4A84-BDB8-2E5A4 AuthorizedCDFPrefix :
BB71E00}                       Comments            :
                               Contact             :
                               DisplayVersion      : 5.1.50918.0
                               HelpLink            : https://go.microsoft.com/fwlink/?LinkID=91955
                               HelpTelephone       :
                               InstallDate         : 20190115
                               InstallLocation     : C:\Program Files\Microsoft Silverlight\
                               InstallSource       : c:\ef64c54526db9c34cd477c103e68a254\
                               ModifyPath          : MsiExec.exe /X{89F4137D-6C26-4A84-BDB8-2E5A4BB71E00}
                               NoModify            : 1
                               NoRepair            : 1
                               Publisher           : Microsoft Corporation
                               Readme              :
                               Size                :
                               EstimatedSize       : 236432
                               UninstallString     : MsiExec.exe /X{89F4137D-6C26-4A84-BDB8-2E5A4BB71E00}
                               URLInfoAbout        :
                               URLUpdateInfo       :
                               VersionMajor        : 5
                               VersionMinor        : 1
                               WindowsInstaller    : 1
                               Version             : 84002534
                               Language            : 1033
                               DisplayName         : Microsoft Silverlight
                               sEstimatedSize2     : 79214
```

## Installing Applications

You can use the **Win32_Product** class to install Windows Installer packages, remotely or locally.

> [!NOTE]
> To install an application, you must start PowerShell with the "Run as administrator" option.

When installing remotely, use a Universal Naming Convention (UNC) network path to specify the path
to the .msi package, because the WMI subsystem does not understand PowerShell paths. For example, to
install the NewPackage.msi package located in the network share `\\AppServ\dsp` on the remote
computer PC01, type the following command at the PowerShell prompt:

```powershell
Invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation='\\AppSrv\dsp\NewPackage.msi'}
```

Applications that do not use Windows Installer technology may have application-specific methods for
automated deployment. Check the documentation for the application or consult the application
vendor's support system.

## Removing Applications

Removing a Windows Installer package using PowerShell works in approximately the same way as
installing a package. Here is an example that selects the package to uninstall based on its name; in
some cases it may be easier to filter with the **IdentifyingNumber**:

```powershell
Get-CimInstance -Class Win32_Product -Filter "Name='ILMerge'" | Invoke-CimMethod -MethodName Uninstall
```

Removing other applications is not quite so simple, even when done locally. We can find the command
line uninstallation strings for these applications by extracting the **UninstallString** property.
This method works for Windows Installer applications and for older programs appearing under the
Uninstall key:

```powershell
Get-ChildItem -Path Uninstall: | ForEach-Object -Process { $_.GetValue('UninstallString') }
```

You can filter the output by the display name, if you like:

```powershell
Get-ChildItem -Path Uninstall: |
    Where-Object -FilterScript { $_.GetValue('DisplayName') -like 'Win*'} |
        ForEach-Object -Process { $_.GetValue('UninstallString') }
```

However, these strings may not be directly usable from the PowerShell prompt without some modification.

## Upgrading Windows Installer Applications

To upgrade an application, you need to know the name of the application and the path to the
application upgrade package. With that information, you can upgrade an application with a single
PowerShell command:

```powershell
Get-CimInstance -Class Win32_Product -Filter "Name='OldAppName'" |
  Invoke-CimMethod -MethodName Upgrade -Arguments @{PackageLocation='\\AppSrv\dsp\OldAppUpgrade.msi'}
```
