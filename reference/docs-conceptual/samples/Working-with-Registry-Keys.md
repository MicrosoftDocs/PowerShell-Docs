---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Working with Registry Keys
ms.assetid:  91bfaecd-8684-48b4-ad86-065dfe6dc90a
---
# Working with Registry Keys

Because registry keys are items on Windows PowerShell drives, working with them is very similar to working with files and folders. One critical difference is that every item on a registry-based Windows PowerShell drive is a container, just like a folder on a file system drive. However, registry entries and their associated values are properties of the items, not distinct items.

## Listing All Subkeys of a Registry Key

You can show all items directly within a registry key by using **Get-ChildItem**. Add the optional **Force** parameter to display hidden or system items. For example, this command displays the items directly within Windows PowerShell drive HKCU:, which corresponds to the HKEY_CURRENT_USER registry hive:

```
PS> Get-ChildItem -Path hkcu:\

   Hive: Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER

SKC  VC Name                           Property
---  -- ----                           --------
  2   0 AppEvents                      {}
  7  33 Console                        {ColorTable00, ColorTable01, ColorTab...
 25   1 Control Panel                  {Opened}
  0   5 Environment                    {APR_ICONV_PATH, INCLUDE, LIB, TEMP...}
  1   7 Identities                     {Last Username, Last User ...
  4   0 Keyboard Layout                {}
...
```

These are the top-level keys visible under HKEY_CURRENT_USER in the Registry Editor (Regedit.exe).

You can also specify this registry path by specifying the registry provider's name, followed by "**::**". The registry provider's full name is **Microsoft.PowerShell.Core\\Registry**, but this can be shortened to just **Registry**. Any of the following commands will list the contents directly under HKCU:

```powershell
Get-ChildItem -Path Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Registry::HKCU
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKCU
Get-ChildItem HKCU:
```

These commands list only the directly contained items, much like using Cmd.exe's **DIR** command or **ls** in a UNIX shell. To show contained items, you need to specify the **Recurse** parameter. To list all registry keys in HKCU, use the following command (This operation can take an extremely long time.):

```powershell
Get-ChildItem -Path hkcu:\ -Recurse
```

**Get-ChildItem** can perform complex filtering capabilities through its **Path**, **Filter**, **Include**, and **Exclude** parameters, but those parameters are typically based only on name. You can perform complex filtering based on other properties of items by using the **Where-Object** cmdlet. The following command finds all keys within HKCU:\\Software that have no more than one subkey and also have exactly four values:

```powershell
Get-ChildItem -Path HKCU:\Software -Recurse | Where-Object -FilterScript {($_.SubKeyCount -le 1) -and ($_.ValueCount -eq 4) }
```

## Copying Keys

Copying is done with **Copy-Item**. The following command copies HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion and all of its properties to HKCU:\\, creating a new key named "CurrentVersion":

```powershell
Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu:
```

If you examine this new key in the registry editor or by using **Get-ChildItem**, you will notice that you do not have copies of the contained subkeys in the new location. In order to copy all of the contents of a container, you need to specify the **Recurse** parameter. To make the preceding copy command recursive, you would use this command:

```powershell
Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu: -Recurse
```

You can still use other tools you already have available to perform filesystem copies. Any registry editing tools—including reg.exe, regini.exe, and regedit.exe—and COM objects that support registry editing (such as WScript.Shell and WMI's StdRegProv class) can be used from within Windows PowerShell.

## Creating Keys

Creating new keys in the registry is simpler than creating a new item in a file system. Because all registry keys are containers, you do not need to specify the item type; you simply supply an explicit path, such as:

```powershell
New-Item -Path hkcu:\software_DeleteMe
```

You can also use a provider-based path to specify a key:

```powershell
New-Item -Path Registry::HKCU_DeleteMe
```

## Deleting Keys

Deleting items is essentially the same for all providers. The following commands will silently remove items:

```powershell
Remove-Item -Path hkcu:\Software_DeleteMe
Remove-Item -Path 'hkcu:\key with spaces in the name'
```

## Removing All Keys Under a Specific Key

You can remove contained items by using **Remove-Item**, but you will be prompted to confirm the removal if the item contains anything else. For example, if we attempt to delete the HKCU:\\CurrentVersion subkey we created, we see this:

```
Remove-Item -Path hkcu:\CurrentVersion

Confirm
The item at HKCU:\CurrentVersion\AdminDebug has children and the -recurse
parameter was not specified. If you continue, all children will be removed with
 the item. Are you sure you want to continue?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):
```

To delete contained items without prompting, specify the **-Recurse** parameter:

```powershell
Remove-Item -Path HKCU:\CurrentVersion -Recurse
```

If you wanted to remove all items within HKCU:\\CurrentVersion but not HKCU:\\CurrentVersion itself, you could instead use:

```powershell
Remove-Item -Path HKCU:\CurrentVersion\* -Recurse
```