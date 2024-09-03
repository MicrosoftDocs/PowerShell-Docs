---
description: Describes  Windows PowerShell snap-ins and shows how to use and manage them.
Locale: en-US
ms.date: 12/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pssnapins?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSSnapins
---
# about_PSSnapins

## Short description

Describes  Windows PowerShell snap-ins and shows how to use and manage them.

## Long description

A Windows PowerShell snap-in is a Microsoft .NET Framework assembly that can
contain Windows PowerShell providers and cmdlets. Windows PowerShell includes a
set of basic snap-ins, but you can extend the power and value of Windows
PowerShell by adding snap-ins that contain providers and cmdlets that you
create or get from others.

When you add a snap-in, the cmdlets and providers that it contains are
immediately available for use in the current session, but the change affects
only the current session.

To add the snap-in to all future sessions, save it in your Windows PowerShell
profile. You can also use the `Export-Console` cmdlet to save the snap-in names
to a console file and then use that saved configuration in future sessions.

Beginning in Windows PowerShell 3.0, the cmdlets that ship with PowerShell are
packaged in modules. The exception is **Microsoft.PowerShell.Core**, which is
the only remaining snap-in. The **Microsoft.PowerShell.Core** snap-in is loaded
in every session by default. The remaining modules are loaded automatically on
first-use. For more information, see [about_Modules][02].

## Find a snap-in

To get a list of the  Windows PowerShell snap-ins on your computer, type:

```powershell
Get-PSSnapin
```

To get the snap-in for each  Windows PowerShell provider, type:

```powershell
Get-PSProvider | Format-List name, pssnapin
```

To get all the registered snap-ins on your system or to verify that a snap-in
is registered, type:

```powershell
Get-PSSnapin -registered
```

To get a list of the cmdlets in a  Windows PowerShell snap-in, type:

```powershell
Get-Command -Module <snap-in_name>
```

## Install a snap-in

The built-in snap-ins are registered in the system and added to the default
session when you start Windows PowerShell. However, you have to register
snap-ins that you create or obtain from others and then add the snap-ins to
your session.

## Add a snap-in to the current session

To add a registered snap-in to the current session, use the `Add-PsSnapin`
cmdlet. For example, to add the Microsoft SQL Server snap-in to the session,
type:

```powershell
Add-PSSnapin sql
```

After the command is completed, the providers and cmdlets in the snap-in are
available in the session. However, they're available only in the current
session unless you save them.

## Save a snap-ins

To use a snap-in in future Windows PowerShell sessions, add the `Add-PsSnapin`
command to your Windows PowerShell profile. Or, export the snap-in names to a
console file.

If you add the `Add-PSSnapin` command to your profile, it's available in all
future Windows PowerShell sessions. If you export the names of the snap-ins in
your session, you can use the export file only when you need the snap-ins.

To add the `Add-PsSnapin` command to your Windows PowerShell profile, open your
profile, paste or type the command, and then save the profile. For more
information, see [about_Profiles][03].

To save the snap-ins from a session in console file (`.psc1`), use the
`Export-Console` cmdlet. For example, to save the snap-ins in the current
session configuration to the `NewConsole.psc1` file in the current directory,
type:

```powershell
Export-Console NewConsole
```

For more information, see [Export-Console][05].

## Open Windows PowerShell using a console file

To use a console file that includes the snap-in, start Windows PowerShell
(`powershell.exe`) from the command prompt in `cmd.exe` or in another Windows
PowerShell session. Use the **PsConsoleFile** parameter to specify the console
file that includes the snap-in. For example, the following command starts
Windows PowerShell with the `NewConsole.psc1` console file:

```powershell
PowerShell.exe -psconsolefile NewConsole.psc1
```

The providers and cmdlets in the snap-in are now available for use in the
session.

## Remove a snap-in

To remove a Windows PowerShell snap-in from the current session, use the
`Remove-PsSnapin` cmdlet. For example, to remove the SQL Server snap-in from the
current session, type:

```powershell
Remove-PSSnapin sql
```

This cmdlet removes the snap-in from the session. The snap-in is still loaded,
but the providers and cmdlets that it supports are no longer available.

## Log snap-in events

Beginning in Windows PowerShell 3.0, you can record execution events for the
cmdlets in Windows PowerShell modules and snap-ins by setting the
**LogPipelineExecutionDetails** property of modules and snap-ins to `$true`.
For more information, see [about_EventLogs][01].

## See also

- [about_Modules][02]
- [about_Profiles][03]
- [Get-Command][06]
- [Export-Console][05]
- [Add-PsSnapin][04]
- [Get-PsSnapin][07]
- [Remove-PsSnapin][08]

<!-- link references -->
[01]: about_EventLogs.md
[02]: about_Modules.md
[03]: about_Profiles.md
[04]: xref:Microsoft.PowerShell.Core.Add-PSSnapin
[05]: xref:Microsoft.PowerShell.Core.Export-Console
[06]: xref:Microsoft.PowerShell.Core.Get-Command
[07]: xref:Microsoft.PowerShell.Core.Get-PSSnapin
[08]: xref:Microsoft.PowerShell.Core.Remove-PSSnapin
