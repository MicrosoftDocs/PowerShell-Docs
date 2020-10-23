---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Managing Windows PowerShell Drives
description: A PowerShell drive is a data store location that you can access like a file system drive in PowerShell. By default, PowerShell includes providers that support the file system, the registry, certificate stores, and others.
---
# Managing Windows PowerShell Drives

A *Windows PowerShell drive* is a data store location that you can access like a file system drive in Windows PowerShell. The Windows PowerShell providers create some drives for you, such as the file system drives (including C: and D:), the registry drives (HKCU: and HKLM:), and the certificate drive (Cert:), and you can create your own Windows PowerShell drives. These drives are very useful, but they are available only within Windows PowerShell. You cannot access them by using other Windows tools, such as File Explorer or Cmd.exe.

Windows PowerShell uses the noun, **PSDrive**, for commands that work with Windows PowerShell drives. For a list of the Windows PowerShell drives in your Windows PowerShell session, use the **Get-PSDrive** cmdlet.

```
PS> Get-PSDrive

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
A          FileSystem    A:\
Alias      Alias
C          FileSystem    C:\                                 ...And Settings\me
cert       Certificate   \
D          FileSystem    D:\
Env        Environment
Function   Function
HKCU       Registry      HKEY_CURRENT_USER
HKLM       Registry      HKEY_LOCAL_MACHINE
Variable   Variable
```

Although the drives in the display vary with the drives on your system, the listing will look similar to the output of the **Get-PSDrive** command shown above.

File system drives are a subset of the Windows PowerShell drives. You can identify the file system drives by the FileSystem entry in the Provider column. (The file system drives in Windows PowerShell are supported by the Windows PowerShell FileSystem provider.)

To see the syntax of the **Get-PSDrive** cmdlet, type a **Get-Command** command with the **Syntax** parameter:

```
PS> Get-Command -Name Get-PSDrive -Syntax

Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider <String[]>] [-V
erbose] [-Debug] [-ErrorAction <ActionPreference>] [-ErrorVariable <String>] [-
OutVariable <String>] [-OutBuffer <Int32>]
```

The **PSProvider** parameter lets you display only the Windows PowerShell drives that are supported by a particular provider. For example, to display only the Windows PowerShell drives that are supported by the Windows PowerShell FileSystem provider, type a **Get-PSDrive** command with the **PSProvider** parameter and the **FileSystem** value:

```
PS> Get-PSDrive -PSProvider FileSystem

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
A          FileSystem    A:\
C          FileSystem    C:\                           ...nd Settings\PowerUser
D          FileSystem    D:\
```

To view the Windows PowerShell drives that represent registry hives, use the **PSProvider** parameter to display only the Windows PowerShell drives that are supported by the Windows PowerShell Registry provider:

```
PS> Get-PSDrive -PSProvider Registry

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
HKCU       Registry      HKEY_CURRENT_USER
HKLM       Registry      HKEY_LOCAL_MACHINE
```

You can also use the standard Location cmdlets with the Windows PowerShell drives:

```
PS> Set-Location HKLM:\SOFTWARE
PS> Push-Location .\Microsoft
PS> Get-Location

Path
----
HKLM:\SOFTWARE\Microsoft
```

## Adding New Windows PowerShell Drives (New-PSDrive)

You can add your own Windows PowerShell drives by using the **New-PSDrive** command. To get the syntax for the **New-PSDrive** command, enter the **Get-Command** command with the **Syntax** parameter:

```
PS> Get-Command -Name New-PSDrive -Syntax

New-PSDrive [-Name] <String> [-PSProvider] <String> [-Root] <String> [-Descript
ion <String>] [-Scope <String>] [-Credential <PSCredential>] [-Verbose] [-Debug
] [-ErrorAction <ActionPreference>] [-ErrorVariable <String>] [-OutVariable <St
ring>] [-OutBuffer <Int32>] [-WhatIf] [-Confirm]
```

To create a new Windows PowerShell drive, you must supply three parameters:

- A name for the drive (you can use any valid Windows PowerShell name)

- The PSProvider (use "FileSystem" for file system locations and "Registry" for registry locations)

- The root, that is, the path to the root of the new drive

For example, you can create a drive named "Office" that is mapped to the folder that contains the Microsoft Office applications on your computer, such as **C:\\Program Files\\Microsoft Office\\OFFICE11**. To create the drive, type the following command:

```
PS> New-PSDrive -Name Office -PSProvider FileSystem -Root "C:\Program Files\Microsoft Office\OFFICE11"

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
Office     FileSystem    C:\Program Files\Microsoft Offic...
```

> [!NOTE]
> In general, paths are not case-sensitive.

You refer to the new Windows PowerShell drive as you do all Windows PowerShell drives -- by its name followed by a colon (**:**).

A Windows PowerShell drive can make many tasks much simpler. For example, some of the most important keys in the Windows registry have extremely long paths, making them cumbersome to access and difficult to remember. Critical configuration information resides under **HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion**. To view and change items in the CurrentVersion registry key, you can create a Windows PowerShell drive that is rooted in that key by typing:

```
PS> New-PSDrive -Name cvkey -PSProvider Registry -Root HKLM\Software\Microsoft\Windows\CurrentVersion

Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
cvkey      Registry      HKLM\Software\Microsoft\Windows\...
```

You can then change location to the **cvkey:** drive as you would any other drive:

```
PS> cd cvkey:
```

or:

```
PS> Set-Location cvkey: -PassThru

Path
----
cvkey:\
```

The New-PsDrive cmdlet adds the new drive only to the current Windows PowerShell session. If you close the Windows PowerShell window, the new drive is lost. To save a Windows PowerShell drive, use the Export-Console cmdlet to export the current Windows PowerShell session, and then use the PowerShell.exe **PSConsoleFile** parameter to import it. Or, add the new drive to your Windows PowerShell profile.

## Deleting Windows PowerShell Drives (Remove-PSDrive)

You can delete drives from Windows PowerShell by using the **Remove-PSDrive** cmdlet. The **Remove-PSDrive** cmdlet is easy to use; to delete a specific Windows PowerShell drive, you just supply the Windows PowerShell drive name.

For example, if you added the **Office:** Windows PowerShell drive, as shown in the **New-PSDrive** topic, you can delete it by typing:

```powershell
Remove-PSDrive -Name Office
```

To delete the **cvkey:** Windows PowerShell drive, also shown in the **New-PSDrive** topic, use the following command:

```powershell
Remove-PSDrive -Name cvkey
```

It's easy to delete a Windows PowerShell drive, but you can't delete it while you are in the drive. For example:

```
PS> cd office:
PS Office:\> remove-psdrive -name office
Remove-PSDrive : Cannot remove drive 'Office' because it is in use.
At line:1 char:15
+ remove-psdrive  <<<< -name office
```

## Adding and Removing Drives Outside Windows PowerShell

Windows PowerShell detects file system drives that are added or removed in Windows, including network drives that are mapped, USB drives that are attached, and drives that are deleted by using either the **net use** command or the **WScript.NetworkMapNetworkDrive** and **RemoveNetworkDrive** methods from a Windows Script Host (WSH) script.
