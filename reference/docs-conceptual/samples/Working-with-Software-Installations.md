---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Working with Software Installations
ms.assetid:  51a12fe9-95f6-4ffc-81a5-4fa72a5bada9
---
# Working with Software Installations

Applications that are designed to use Windows Installer can be accessed through WMI's **Win32_Product** class, but not all applications in use today use the Windows Installer. Because the Windows Installer provides the widest range of standard techniques for working with installable applications, we will focus primarily on those applications. Applications that use alternate setup routines will generally not be managed by the Windows Installer. Specific techniques for working with those applications will depend on the installer software and decisions made by the application developer.

> [!NOTE]
> Applications that are installed by copying the application files to the computer usually cannot be managed by using techniques discussed here. You can manage these applications as files and folders by using the techniques discussed in the "Working With Files and Folders" section.

## Listing Windows Installer Applications

To list the applications installed with the Windows Installer on a local or remote system, use the following simple WMI query:

```
PS> Get-WmiObject -Class Win32_Product -ComputerName .

IdentifyingNumber : {7131646D-CD3C-40F4-97B9-CD9E4E6262EF}
Name              : Microsoft .NET Framework 2.0
Vendor            : Microsoft Corporation
Version           : 2.0.50727
Caption           : Microsoft .NET Framework 2.0
```

To display all of the properties of the Win32_Product object to the display, use the Properties parameter of the formatting cmdlets, such as the Format-List cmdlet, with a value of \* (all).

```
PS> Get-WmiObject -Class Win32_Product -ComputerName . | Where-Object -FilterScript {$_.Name -eq "Microsoft .NET Framework 2.0"} | Format-List -Property *

Name              : Microsoft .NET Framework 2.0
Version           : 2.0.50727
InstallState      : 5
Caption           : Microsoft .NET Framework 2.0
Description       : Microsoft .NET Framework 2.0
IdentifyingNumber : {7131646D-CD3C-40F4-97B9-CD9E4E6262EF}
InstallDate       : 20060506
InstallDate2      : 20060506000000.000000-000
InstallLocation   :
PackageCache      : C:\WINDOWS\Installer\619ab2.msi
SKUNumber         :
Vendor            : Microsoft Corporation
```

Or, you could use the **Get-WmiObject Filter** parameter to select only Microsoft .NET Framework 2.0. Because the filter used in this command is a WMI filter, it uses WMI Query Language (WQL) syntax, not Windows PowerShell syntax. Instead,:

```powershell
Get-WmiObject -Class Win32_Product -ComputerName . -Filter "Name='Microsoft .NET Framework 2.0'"| Format-List -Property *
```

Note that WQL queries frequently use characters, such as spaces or equal signs, that have a special meaning in Windows PowerShell. For this reason, it is prudent to always enclose the value of the Filter parameter in quotation marks. You can also use the Windows PowerShell escape character, a backtick (\`), although it may not improve readability. The following command is equivalent to the previous command and returns the same results, but uses the backtick to escape special characters, instead of quoting the entire filter string.

```powershell
Get-WmiObject -Class Win32_Product -ComputerName . -Filter Name`=`'Microsoft` .NET` Framework` 2.0`' | Format-List -Property *
```

To list only the properties that interest you, use the Property parameter of the formatting cmdlets to list the desired properties.

```
Get-WmiObject -Class Win32_Product -ComputerName . | Format-List -Property Name,InstallDate,InstallLocation,PackageCache,Vendor,Version,IdentifyingNumber
...
Name              : HighMAT Extension to Microsoft Windows XP CD Writing Wizard
InstallDate       : 20051022
InstallLocation   : C:\Program Files\HighMAT CD Writing Wizard\
PackageCache      : C:\WINDOWS\Installer\113b54.msi
Vendor            : Microsoft Corporation
Version           : 1.1.1905.1
IdentifyingNumber : {FCE65C4E-B0E8-4FBD-AD16-EDCBE6CD591F}
...
```

Finally, to find only the names of installed applications, a simple **Format-Wide** statement simplifies the output:

```powershell
Get-WmiObject -Class Win32_Product -ComputerName .  | Format-Wide -Column 1
```

Although we now have several ways to look at applications that used the Windows Installer for installation, we have not considered other applications. Because most standard applications register their uninstaller with Windows, we can work with those locally by finding them in the Windows registry.

## Listing All Uninstallable Applications

Although there is no guaranteed way to find every application on a system, it is possible to find all programs with listings displayed in the Add or Remove Programs dialog box. Add or Remove Programs finds these applications in the following registry key:

**HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall**.

We can also examine this key to find applications. To make it easier to view the Uninstall key, we can map a Windows PowerShell drive to this registry location:

```
PS> New-PSDrive -Name Uninstall -PSProvider Registry -Root HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
Uninstall  Registry      HKEY_LOCAL_MACHINE\SOFTWARE\Micr...
```

> [!NOTE]
> The **HKLM:** drive is mapped to the root of **HKEY_LOCAL_MACHINE**, so we used that drive in the path to the Uninstall key. Instead of **HKLM:** we could have specified the registry path by using either **HKLM** or **HKEY_LOCAL_MACHINE**. The advantage of using an existing registry drive is that we can use tab-completion to fill in the keys names, so we do not need to type them.

We now have a drive named "Uninstall" that can be used to quickly and conveniently look for application installations. We can find the number of installed applications by counting the number of registry keys in the Uninstall: Windows PowerShell drive:

```
PS> (Get-ChildItem -Path Uninstall:).Count
459
```

We can search this list of applications further by using a variety of techniques, beginning with **Get-ChildItem**. To get a list of applications and save them in the **$UninstallableApplications** variable, use the following command:

```powershell
$UninstallableApplications = Get-ChildItem -Path Uninstall:
```

> [!NOTE]
> We are using a lengthy variable name here for clarity. In actual use, there is no reason to use long names. Although you can use tab-completion for variable names, you can also use 1-2 character names for speed. Longer, descriptive names are most useful when you are developing code for reuse.

To display the values of the registry entries in the registry keys under Uninstall, use the GetValue method of the registry keys. The value of the method is the name of the registry entry.

For example, to find the display names of applications in the Uninstall key, use the following command:

```powershell
Get-ChildItem -Path Uninstall: | ForEach-Object -Process { $_.GetValue('DisplayName') }
```

There is no guarantee that these values are unique. In the following example, two installed items appear as "Windows Media Encoder 9 Series":

```
PS> Get-ChildItem -Path Uninstall: | Where-Object -FilterScript { $_.GetValue("DisplayName") -eq "Windows Media Encoder 9 Series"}

   Hive: Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Micros
oft\Windows\CurrentVersion\Uninstall

SKC  VC Name                           Property
---  -- ----                           --------
  0   3 Windows Media Encoder 9        {DisplayName, DisplayIcon, UninstallS...
  0  24 {E38C00D0-A68B-4318-A8A6-F7... {AuthorizedCDFPrefix, Comments, Conta...
```

## Installing Applications

You can use the **Win32_Product** class to install Windows Installer packages, remotely or locally.

> [!NOTE]
> On Windows Vista, Windows Server 2008, and later versions of Windows, to install an application, you must start Windows PowerShell with the "Run as administrator" option.

When installing remotely, use a Universal Naming Convention (UNC) network path to specify the path to the .msi package, because the WMI subsystem does not understand Windows PowerShell paths. For example, to install the NewPackage.msi package located in the network share \\\\AppServ\\dsp on the remote computer PC01, type the following command at the Windows PowerShell prompt:

```powershell
(Get-WMIObject -ComputerName PC01 -List | Where-Object -FilterScript {$_.Name -eq 'Win32_Product'}).Install(\\AppSrv\dsp\NewPackage.msi)
```

Applications that do not use Windows Installer technology may have application-specific methods available for automated deployment. To determine whether there is a method for deployment automation, check the documentation for the application or consult the application vendor's support system. In some cases, even if the application vendor did not specifically design the application for installation automation, the installer software manufacturer may have some techniques for automation.

## Removing Applications

Removing a Windows Installer package by using Windows PowerShell works in approximately the same way as installing a package. Here is an example that selects the package to uninstall based on its name; in some cases it may be easier to filter with the **IdentifyingNumber**:

```powershell
(Get-WmiObject -Class Win32_Product -Filter "Name='ILMerge'" -ComputerName . ).Uninstall()
```

Removing other applications is not quite so simple, even when done locally. We can find the command line uninstallation strings for these applications by extracting the **UninstallString** property. This method works for Windows Installer applications and for older programs appearing under the Uninstall key:

```powershell
Get-ChildItem -Path Uninstall: | ForEach-Object -Process { $_.GetValue('UninstallString') }
```

You can filter the output by the display name, if you like:

```powershell
Get-ChildItem -Path Uninstall: | Where-Object -FilterScript { $_.GetValue('DisplayName') -like 'Win*'} | ForEach-Object -Process { $_.GetValue('UninstallString') }
```

However, these strings may not be directly usable from the Windows PowerShell prompt without some modification.

## Upgrading Windows Installer Applications

To upgrade an application, you need to know the name of the application and the path to the application upgrade package. With that information, you can upgrade an application with a single Windows PowerShell command:

```powershell
(Get-WmiObject -Class Win32_Product -ComputerName . -Filter "Name='OldAppName'").Upgrade(\\AppSrv\dsp\OldAppUpgrade.msi)
```