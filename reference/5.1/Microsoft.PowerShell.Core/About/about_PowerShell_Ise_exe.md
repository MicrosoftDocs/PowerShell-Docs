---
description: Explains how to use the `powershell_ise.exe` command-line tool.
Locale: en-US
ms.date: 06/09/2017
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_powershell_ise_exe?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PowerShell_Ise_exe
---

# about_PowerShell_Ise_exe

## Short description

Explains how to use the `powershell_ise.exe` command-line tool.

## Long description

Running `powershell_ise.exe` starts a Windows PowerShell Integrated
Scripting Environment (ISE) session. You can run it in Cmd.exe
and in Windows PowerShell.

To run Windows PowerShell ISE, type `powershell_ise.exe`, `powershell_ise`,
or `ISE`.

## Syntax

```
powershell_ise[.exe]
ISE
[-File]<FilePath[]> [-NoProfile] [-MTA]
-Help | ? | -? | /? Displays the syntax and describes the command-line switches.
```

## Parameters

### -File

Opens the specified files in Windows PowerShell ISE. The
parameter name ("-File") is optional. To list more than one
file, enter one text string enclosed in quotation marks. Use
commas to separate the file names within the string.

For example:

```powershell
powershell_ise -File "File1.ps1,File2.ps1,File3.xml".
```

Spaces between the file names are permitted in Windows PowerShell,
but might not be interpreted correctly by other programs, such as
Cmd.exe.

You can use this parameter to open any text file, including Windows
PowerShell script files and XML files.

### -MTA

Starts Windows PowerShell ISE using a multi-threaded apartment. This
parameter is introduced in Windows PowerShell 3.0. Single-threaded
apartment (STA) is the default.

### -NoProfile

Does not run Windows PowerShell profiles. By default, Windows PowerShell
profiles are run in every session.

This parameter is recommended when you are writing shared content, such as
functions and scripts that will be run on systems with different profiles.
For more information, see [about_Profiles](about_Profiles.md).

### -Help -?, /?

Displays help for `powershell_ise.exe`.

## Examples

These commands start Windows PowerShell ISE. The commands are equivalent
and can be used interchangeably.

```
PS C:> powershell_ise.exe
PS C:> powershell_ise
PS C:> ISE
```

These commands open the Get-Profile.ps1 script in Windows PowerShell ISE.
The commands are equivalent and can be used interchangeably.

```
PS C:> powershell_ise.exe -File .\Get-Profile.ps1
PS C:> ISE -File .\Get-Profile.ps1
PS C:> ISE .\Get-Profile.ps1
```

This command opens the Get-Backups.ps1 and Get-BackupInstance.ps1 scripts
in Windows PowerShell ISE. To open more than one file, use a comma to
separate the file names and enclose the entire file name value in quotation
marks.

```
PS C:> ISE -File ".\Get-Backups.ps1,Get-BackupInstance.ps1"
```

This command starts Windows PowerShell ISE with no profiles.

```
PS C:> ISE -NoProfile
```

This command gets help for `powershell_ise.exe`.

```
PS C:> ISE -Help
```

## See also

- [about_PowerShell_exe](about_PowerShell_exe.md)
- [about_Windows_PowerShell_ISE](about_Windows_PowerShell_ISE.md)
- [Windows PowerShell Integrated Scripting Environment (ISE)](/powershell/scripting/windows-powershell/ise/introducing-the-windows-powershell-ise)
