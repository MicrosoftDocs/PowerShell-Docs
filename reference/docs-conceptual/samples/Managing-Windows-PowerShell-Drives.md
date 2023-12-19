---
description: A PowerShell drive is a data store location that you can access like a filesystem drive in PowerShell. By default, PowerShell includes providers that support the filesystem, the registry, certificate stores, and others.
ms.date: 12/08/2022
title: Managing PowerShell drives
---
# Managing PowerShell drives

> This sample only applies to Windows platforms.

A _PowerShell drive_ is a data store location that you can access like a filesystem drive in
PowerShell. The PowerShell providers create some drives for you, such as the file
system drives (including `C:` and `D:`), the registry drives (`HKCU:` and `HKLM:`), and the
certificate drive (`Cert:`), and you can create your own PowerShell drives. These drives are
useful, but they're available only within PowerShell. You can't access them using other Windows
tools, such as File Explorer or `Cmd.exe`.

PowerShell uses the noun, **PSDrive**, for commands that work with PowerShell
drives. For a list of the PowerShell drives in your PowerShell session, use the
`Get-PSDrive` cmdlet.

```powershell
Get-PSDrive
```

```Output
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

Although the drives in the display vary with the drives on your system, yours should look similar to
the output of the `Get-PSDrive` command shown above.

filesystem drives are a subset of the PowerShell drives. You can identify the filesystem drives by
the FileSystem entry in the Provider column. The filesystem drives in PowerShell are supported by
the PowerShell FileSystem provider.

To see the syntax of the `Get-PSDrive` cmdlet, type a `Get-Command` command with the **Syntax**
parameter:

```powershell
Get-Command -Name Get-PSDrive -Syntax
```

```Output
Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider <String[]>] [-V
erbose] [-Debug] [-ErrorAction <ActionPreference>] [-ErrorVariable <String>] [-
OutVariable <String>] [-OutBuffer <Int32>]
```

The **PSProvider** parameter lets you display only the PowerShell drives that are supported by a
particular provider. For example, to display only the PowerShell drives that are supported by the
PowerShell FileSystem provider, type a `Get-PSDrive` command with the **PSProvider** parameter and
the **FileSystem** value:

```powershell
Get-PSDrive -PSProvider FileSystem
```

```Output
Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
A          FileSystem    A:\
C          FileSystem    C:\                           ...nd Settings\PowerUser
D          FileSystem    D:\
```

To view the PowerShell drives that represent registry hives, use the **PSProvider** parameter to
display only the PowerShell drives that are supported by the PowerShell Registry provider:

```powershell
Get-PSDrive -PSProvider Registry
```

```Output
Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
HKCU       Registry      HKEY_CURRENT_USER
HKLM       Registry      HKEY_LOCAL_MACHINE
```

You can also use the standard Location cmdlets with the PowerShell drives:

```powershell
Set-Location HKLM:\SOFTWARE
Push-Location .\Microsoft
Get-Location
```

```Output
Path
----
HKLM:\SOFTWARE\Microsoft
```

## Adding new PowerShell drives

You can add your own PowerShell drives by using the `New-PSDrive` command. To get the syntax for the
`New-PSDrive` command, enter the `Get-Command` command with the **Syntax** parameter:

```powershell
Get-Command -Name New-PSDrive -Syntax
```

```Output
New-[-Description <String>] [-Scope <String>] [-Credential <PSCredential>] [-Verbose] [-Debug ]
[-ErrorAction <ActionPreference>] [-ErrorVariable <String>] [-OutVariable <St ring>]
[-OutBuffer <Int32>] [-WhatIf] [-Confirm]
```

To create a new PowerShell drive, you must supply three parameters:

- A name for the drive (you can use any valid PowerShell name)
- The PSProvider - use `FileSystem` for filesystem locations and `Registry` for registry locations
- The root, that is, the path to the root of the new drive

For example, you can create a drive named `Office` that's mapped to the folder that contains the
Microsoft Office applications on your computer, such as `C:\Program Files\MicrosoftOffice\OFFICE11`.
To create the drive, type the following command:

```powershell
New-PSDrive -Name Office -PSProvider FileSystem -Root "C:\Program Files\Microsoft Office\OFFICE11"
```

```Output
Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
Office     FileSystem    C:\Program Files\Microsoft Offic...
```

> [!NOTE]
> In general, paths aren't case-sensitive.

A PowerShell drive is accessed using its name followed by a colon (`:`).

A PowerShell drive can make many tasks much simpler. For example, some of the most important keys in
the Windows registry have extremely long paths, making them cumbersome to access and difficult to
remember. Critical configuration information resides under
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion`. To view and change items in the
CurrentVersion registry key, you can create a PowerShell drive that's rooted in that key by typing:

```powershell
New-PSDrive -Name cvkey -PSProvider Registry -Root HKLM\Software\Microsoft\Windows\CurrentVersion
```

```Output
Name       Provider      Root                                   CurrentLocation
----       --------      ----                                   ---------------
cvkey      Registry      HKLM\Software\Microsoft\Windows\...
```

You can then change location to the **cvkey:** drive as you would any other drive:

```powershell
cd cvkey:
```

or:

```powershell
Set-Location cvkey: -PassThru
```

```Output
Path
----
cvkey:\
```

The `New-PSDrive` cmdlet adds the new drive only to the current PowerShell session. If you close the
PowerShell window, the new drive is lost. To save a PowerShell drive, use the `Export-Console` cmdlet
to export the current PowerShell session, and then use the `PowerShell.exe` **PSConsoleFile**
parameter to import it. Or, add the new drive to your Windows PowerShell profile.

## Deleting PowerShell drives

You can delete drives from PowerShell using the `Remove-PSDrive` cmdlet. For example, if you added
the `Office:` PowerShell drive, as shown in the `New-PSDrive` topic, you can delete it by typing:

```powershell
Remove-PSDrive -Name Office
```

To delete the `cvkey:` PowerShell drive, use the following command:

```powershell
Remove-PSDrive -Name cvkey
```

However, you can't delete it while you are in the drive. For example:

```powershell
cd office:
Remove-PSDrive -Name office
```

```Output
Remove-PSDrive : Cannot remove drive 'Office' because it is in use.
At line:1 char:15
+ remove-psdrive  <<<< -name office
```

## Adding and removing drives outside PowerShell

PowerShell detects filesystem drives that are added or removed in Windows, including:

- network drives that are mapped
- USB drives that are attached
- Drives that are deleted using the `net use` command or from a Windows Script Host (WSH) script
