---
description: This article discusses how to deal with registry entries using PowerShell.
ms.date: 07/31/2024
title: Working with registry entries
---
# Working with registry entries

> This sample only applies to Windows platforms.

Because registry entries are properties of keys and, as such, can't be directly browsed, we need to
take a slightly different approach when working with them.

## Listing registry entries

There are many different ways to examine registry entries. The simplest way is to get the property
names associated with a key. For example, to see the names of the entries in the registry key
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion`, use `Get-Item`. Registry keys have a
property with the generic name of "Property" that's a list of registry entries in the key. The
following command selects the Property property and expands the items so that they're displayed in a
list:

```powershell
Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion |
    Select-Object -ExpandProperty Property
```

```Output
DevicePath
MediaPathUnexpanded
ProgramFilesDir
CommonFilesDir
ProductId
```

To view the registry entries in a more readable form, use `Get-ItemProperty`:

```powershell
Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
```

```Output
ProgramFilesDir          : C:\Program Files
CommonFilesDir           : C:\Program Files\Common Files
ProgramFilesDir (x86)    : C:\Program Files (x86)
CommonFilesDir (x86)     : C:\Program Files (x86)\Common Files
CommonW6432Dir           : C:\Program Files\Common Files
DevicePath               : C:\WINDOWS\inf
MediaPathUnexpanded      : C:\WINDOWS\Media
ProgramFilesPath         : C:\Program Files
ProgramW6432Dir          : C:\Program Files
SM_ConfigureProgramsName : Set Program Access and Defaults
SM_GamesName             : Games
PSPath                   : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWA
                           RE\Microsoft\Windows\CurrentVersion
PSParentPath             : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWA
                           RE\Microsoft\Windows
PSChildName              : CurrentVersion
PSDrive                  : HKLM
PSProvider               : Microsoft.PowerShell.Core\Registry
```

The Windows PowerShell-related properties for the key are all prefixed with "PS", such as
**PSPath**, **PSParentPath**, **PSChildName**, and **PSProvider**.

You can use the `*.*` notation for referring to the current location. You can use `Set-Location` to
change to the **CurrentVersion** registry container first:

```powershell
Set-Location -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
```

Alternatively, you can use the built-in `HKLM:` PSDrive with `Set-Location`:

```powershell
Set-Location -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion
```

You can then use the `.` notation for the current location to list the properties without
specifying a full path:

```powershell
Get-ItemProperty -Path .
```

```Output
...
DevicePath          : C:\WINDOWS\inf
MediaPathUnexpanded : C:\WINDOWS\Media
ProgramFilesDir     : C:\Program Files
...
```

Path expansion works the same as it does within the filesystem, so from this location you can get
the **ItemProperty** listing for `HKLM:\SOFTWARE\Microsoft\Windows\Help` using
`Get-ItemProperty -Path ..\Help`.

## Getting a single registry entry

If you want to retrieve a specific entry in a registry key, you can use one of several possible
approaches. This example finds the value of **DevicePath** in
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion`.

Using `Get-ItemProperty`, use the **Path** parameter to specify the name of the key, and the
**Name** parameter to specify the name of the **DevicePath** entry.

```powershell
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion -Name DevicePath
```

```Output
DevicePath   : C:\WINDOWS\inf
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows
PSChildName  : CurrentVersion
PSDrive      : HKLM
PSProvider   : Microsoft.PowerShell.Core\Registry
```

This command returns the standard Windows PowerShell properties as well as the **DevicePath**
property.

> [!NOTE]
> Although `Get-ItemProperty` has **Filter**, **Include**, and **Exclude** parameters, they can't
> be used to filter by property name. These parameters refer to registry keys, which are item
> paths and not registry entries, which are item properties.

Another option is to use the `reg.exe` command line tool. For help with `reg.exe`, type `reg.exe /?`
at a command prompt. To find the **DevicePath** entry, use `reg.exe` as shown in the following
command:

```powershell
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion /v DevicePath
```

```Output
! REG.EXE VERSION 3.0

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
    DevicePath  REG_EXPAND_SZ   %SystemRoot%\inf
```

You can also use the **WshShell** COM object to find some registry entries, although this method
doesn't work with large binary data or with registry entry names that include characters such as
backslash (`\`). Append the property name to the item path with a `\` separator:

```powershell
(New-Object -ComObject WScript.Shell).RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DevicePath")
```

```Output
%SystemRoot%\inf
```

## Setting a single registry entry

If you want to change a specific entry in a registry key, you can use one of several possible
approaches. This example modifies the **Path** entry under `HKEY_CURRENT_USER\Environment`. The
**Path** entry specifies where to find executable files.

1. Retrieve the current value of the **Path** entry using `Get-ItemProperty`.
1. Add the new value, separating it with a `;`.
1. Use `Set-ItemProperty` with the specified key, entry name, and value to modify the registry
   entry.

```powershell
$value = Get-ItemProperty -Path HKCU:\Environment -Name Path
$newpath = $value.Path += ";C:\src\bin\"
Set-ItemProperty -Path HKCU:\Environment -Name Path -Value $newpath
```

> [!NOTE]
> Although `Set-ItemProperty` has **Filter**, **Include**, and **Exclude** parameters, they
> can't be used to filter by property name. These parameters refer to registry keys—which are item
> paths—and not registry entries—which are item properties.

Another option is to use the Reg.exe command line tool. For help with reg.exe, type `reg.exe /?` at
a command prompt.

The following example changes the **Path** entry by removing the path added in the example above.
`Get-ItemProperty` is still used to retrieve the current value to avoid having to parse the string
returned from `reg query`. The **SubString** and **LastIndexOf** methods are used to retrieve the
last path added to the **Path** entry.

```powershell
$value = Get-ItemProperty -Path HKCU:\Environment -Name Path
$newpath = $value.Path.SubString(0, $value.Path.LastIndexOf(';'))
reg add HKCU\Environment /v Path /d $newpath /f
```

```Output
The operation completed successfully.
```

## Creating new registry entries

To add a new entry named "PowerShellPath" to the **CurrentVersion** key, use `New-ItemProperty` with
the path to the key, the entry name, and the value of the entry. For this example, we will take the
value of the Windows PowerShell variable `$PSHome`, which stores the path to the installation
directory for Windows PowerShell.

You can add the new entry to the key using the following command, and the command also returns
information about the new entry:

```powershell
$newItemPropertySplat = @{
    Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
    Name = 'PowerShellPath'
    PropertyType = 'String'
    Value = $PSHome
}
New-ItemProperty @newItemPropertySplat
```

```Output
PSPath         : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
PSParentPath   : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows
PSChildName    : CurrentVersion
PSDrive        : HKLM
PSProvider     : Microsoft.PowerShell.Core\Registry
PowerShellPath : C:\Program Files\Windows PowerShell\v1.0
```

The **PropertyType** must be the name of a **Microsoft.Win32.RegistryValueKind** enumeration member
from the following table:

- `String` - Used for REG_SZ values. Pass a `[System.String]` object to the **Value** parameter.
- `ExpandString` - Used for REG_EXPAND_SZ values. Pass a `[System.String]` object to the **Value**
  parameter. The string should contain unexpanded references to environment variables that are
  expanded when the value is retrieved.
- `Binary` - Used for REG_BINARY values. Pass a `[System.Byte[]]` object to the **Value** parameter.
- `DWord` - Used for REG_DWORD values. Pass a `[System.Int32]` object to the **Value** parameter.
- `MultiString` - Used for REG_MULTI_SZ values. Pass a `[System.String[]]` object to the **Value**
  parameter.
- `QWord` - Used for REG_QWORD values. Pass a `[System.Int64]` object to the **Value** parameter.

You can add a registry entry to multiple locations by specifying an array of values for the **Path**
parameter:

```powershell
$newItemPropertySplat = @{
    Name = 'PowerShellPath'
    PropertyType = 'String'
    Value = $PSHome
    Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion',
           'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion'
}
New-ItemProperty @newItemPropertySplat
```

You can also overwrite a pre-existing registry entry value by adding the **Force** parameter to any
`New-ItemProperty` command.

The following examples show how to create new registry entries of various types. The registry values
are created in a new key named **MySoftwareKey** under `HKEY_CURRENT_USER\Software`. The `$key`
variable is used to store the new key object.

```powershell
$key = New-Item -Path HKCU:\Software -Name MySoftwareKey
$newItemPropertySplat = @{
    Path = $key.PSPath
    Name = 'DefaultFolders'
    PropertyType = 'MultiString'
    Value = 'Home', 'Temp', 'Publish'
}
New-ItemProperty @newItemPropertySplat
```

```Output
DefaultFolders : {Home, Temp, Publish}
PSPath         : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\MySoftwareKey
PSParentPath   : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software
PSChildName    : MySoftwareKey
PSProvider     : Microsoft.PowerShell.Core\Registry
```

You can use the **PSPath** property of the key object in subsequent commands.

```powershell
New-ItemProperty -Path $key.PSPath -Name MaxAllowed -PropertyType QWord -Value 1024
```

```Output
MaxAllowed   : 1024
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\MySoftwareKey
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software
PSChildName  : MySoftwareKey
PSProvider   : Microsoft.PowerShell.Core\Registry
```

You can also pipe `$key` to `New-ItemProperty` to add a value to the key.

```powershell
$date = Get-Date -Format 'dd-MMM-yyyy'
$newItemPropertySplat = @{
    Name = 'BinaryDate'
    PropertyType = 'Binary'
    Value = ([System.Text.Encoding]::UTF8.GetBytes($date))
}
$key | New-ItemProperty @newItemPropertySplat
```

```Output
BinaryDate   : {51, 49, 45, 74…}
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\MySoftwareKey
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software
PSChildName  : MySoftwareKey
PSProvider   : Microsoft.PowerShell.Core\Registry
```

Displaying the content of `$key` shows the new entries.

```powershell
$key
```

```Output
    Hive: HKEY_CURRENT_USER\Software

Name                           Property
----                           --------
MySoftwareKey                  DefaultFolders : {Home, Temp, Publish}
                               MaxAllowed     : 1024
                               BinaryDate     : {51, 49, 45, 74…}
```

The following example shows the value type for each kind of registry entry:

```powershell
$key.GetValueNames() | Select-Object @{n='ValueName';e={$_}},
     @{n='ValueKind';e={$key.GetValueKind($_)}},
     @{n='Type';e={$key.GetValue($_).GetType()}},
     @{n='Value';e={$key.GetValue($_)}}
```

```Output
ValueName        ValueKind Type            Value
---------        --------- ----            -----
DefaultFolders MultiString System.String[] {Home, Temp, Publish}
MaxAllowed           QWord System.Int64    1024
BinaryDate          Binary System.Byte[]   {51, 49, 45, 74…}
```

## Renaming registry entries

To rename the **PowerShellPath** entry to "PSHome," use `Rename-ItemProperty`:

```powershell
$renameItemPropertySplat = @{
    Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
    Name = 'PowerShellPath'
    NewName = 'PSHome'
}
Rename-ItemProperty @renameItemPropertySplat
```

To display the renamed value, add the **PassThru** parameter to the command.

```powershell
$renameItemPropertySplat = @{
    Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
    Name = 'PowerShellPath'
    NewName = 'PSHome'
    PassThru = $true
}
Rename-ItemProperty @renameItemPropertySplat
```

## Deleting registry entries

To delete both the PSHome and PowerShellPath registry entries, use `Remove-ItemProperty`:

```powershell
Remove-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PSHome
Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath
```
