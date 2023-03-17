---
description: This article shows how to use WMI to manage software installed in Windows.
ms.date: 03/17/2023
title: Working with software installations
---
# Working with software installations

Applications installed with the Windows Installer can be found through WMI's queries, but not all
applications use the Windows Installer. The specific techniques for find applications installed
with other tools depends on the installer software.

For example, applications installed by copying the files to a folder on the computer usually can't
be managed using techniques discussed here. You can manage these applications as files and folders
using the techniques discussed in [Working With Files and Folders][02].

For software installed using an installer package, the Windows Installer can be found using the
**Win32Reg_AddRemovePrograms** or the **Win32_Product** classes. However, both of these have
problems. The **Win32Reg_AddRemovePrograms** is only available if you are using System Center
Configuration Manager (SCCM). And the **Win32_Product** class can be slow and has side effects.

> [!CAUTION]
> The **Win32_Product** class isn't query optimized. Queries that use wildcard filters cause WMI to
> use the MSI provider to enumerate all installed products then parse the full list sequentially to
> handle the filter. This also initiates a consistency check of packages installed, verifying and
> repairing the install. The validation is a slow process and may result in errors in the event
> logs. For more information seek [KB article 974524][01].

This article provides an alternative method for finding installed software.

## Querying the Uninstall registry key to find installed software

Because most standard applications register an uninstaller with Windows, we can work with those
locally by finding them in the Windows registry. There is no guaranteed way to find every
application on a system. However, it's possible to find all programs with listings displayed in
**Add or Remove Programs** in the following registry key:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`.

We can find the number of installed applications by counting the number
of registry keys:

```powershell
$UninstallPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall'
(Get-ChildItem -Path $UninstallPath).Count
```

```Output
459
```

We can search this list of applications further using a variety of techniques. To display the values
of the registry values in the registry keys under `Uninstall`, use the `GetValue()` method of the
registry keys. The value of the method is the name of the registry entry. For example, to find the
display names of applications in the `Uninstall` key, use the following command:

```powershell
Get-ChildItem -Path $UninstallPath |
    ForEach-Object -Process { $_.GetValue('DisplayName') } |
    Sort-Object
```

> [!NOTE]
> There is no guarantee that the **DisplayName** values are unique.

The following example produces output similar to the **Win32Reg_AddRemovePrograms** class:

```powershell
Get-ChildItem $UninstallPath |
    ForEach-Object {
        $ProdID = ($_.Name -split '\\')[-1]
        Get-ItemProperty -Path "$UninstallPath\$ProdID" -ea SilentlyContinue |
        Select-Object -Property DisplayName, InstallDate, @{n='ProdID'; e={$ProdID}}, Publisher, DisplayVersion
} | Select-Object -First 3
```

For the sake of brevity, this example uses `Select-Object` to limit the number of items returned to
three.

```Output
DisplayName    : 7-Zip 22.01 (x64)
InstallDate    :
ProdID         : 7-Zip
Publisher      : Igor Pavlov
DisplayVersion : 22.01

DisplayName    : AutoHotkey 1.1.33.10
InstallDate    :
ProdID         : AutoHotkey
Publisher      : Lexikos
DisplayVersion : 1.1.33.10

DisplayName    : Beyond Compare 4.4.6
InstallDate    : 20230310
ProdID         : BeyondCompare4_is1
Publisher      : Scooter Software
DisplayVersion : 4.4.6.27483
```

<!-- link references -->
[01]: https://support.microsoft.com/help/974524
[02]: Working-with-Files-and-Folders.md
