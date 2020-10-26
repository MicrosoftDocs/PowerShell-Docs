---
ms.date:  01/02/2020
title:  How to Use Profiles in Windows PowerShell ISE
description: This article explains how to use Profiles in Windows PowerShell ISE.
---

# How to Use Profiles in Windows PowerShell ISE

This article explains how to use Profiles in Windows PowerShell&reg; Integrated Scripting Environment
(ISE). We recommend that before performing the tasks in this section, you review
[about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles), or in the
Console Pane, type, `Get-Help about_Profiles` and press <kbd>ENTER</kbd>.

A profile is a Windows PowerShell ISE script that runs automatically when you start a new session.
You can create one or more Windows PowerShell profiles for Windows PowerShell ISE and use them to
add the configure the Windows PowerShell or Windows PowerShell ISE environment, preparing it for
your use, with variables, aliases, functions, and color and font preferences that you want
available. A profile affects every Windows PowerShell ISE session that you start.

> [!NOTE]
> The Windows PowerShell execution policy determines whether you can run scripts and load a profile.
> The default execution policy, "Restricted," prevents all scripts from running, including profiles.
> If you use the "Restricted" policy, the profile cannot load. For more information about execution
> policy, see [about_Execution_Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

## Selecting a profile to use in the Windows PowerShell ISE

Windows PowerShell ISE supports profiles for the current user and all users. It also supports the
Windows PowerShell profiles that apply to all hosts.

The profile that you use is determined by how you use Windows PowerShell and Windows PowerShell ISE.

- If you use only Windows PowerShell ISE to run Windows PowerShell, then save all your items in one
  of the ISE-specific profiles, such as the **CurrentUserCurrentHost** profile for Windows PowerShell
  ISE or the **AllUsersCurrentHost** profile for Windows PowerShell ISE.

- If you use multiple host programs to run Windows PowerShell, save your functions, aliases,
  variables, and commands in a profile that affects all host programs, such as the
  CurrentUserAllHosts or the **AllUsersAllHosts** profile, and save ISE-specific features, like color
  and font customization in the **CurrentUserCurrentHost** profile for Windows PowerShell ISE profile or
  the **AllUsersCurrentHost** profile for Windows PowerShell ISE.

The following are profiles that can be created and used in Windows PowerShell ISE. Each profile is
saved to its own specific path.

|           Profile Type           |                   Profile Path                   |
| -------------------------------- | ------------------------------------------------ |
| **Current user, PowerShell ISE** | `$PROFILE.CurrentUserCurrentHost`, or `$PROFILE` |
| **All users, PowerShell ISE**    | `$PROFILE.AllUsersCurrentHost`                   |
| **Current user, All hosts**      | `$PROFILE.CurrentUserAllHosts`                   |
| **All users, All hosts**         | `$PROFILE.AllUsersAllHosts`                      |

## To create a new profile

To create a new "Current user, Windows PowerShell ISE" profile, run this command:

```powershell
if (!(Test-Path -Path $PROFILE ))
{ New-Item -Type File -Path $PROFILE -Force }
```

To create a new "All users, Windows PowerShell ISE" profile, run this command:

```powershell
if (!(Test-Path -Path $PROFILE.AllUsersCurrentHost))
{ New-Item -Type File -Path $PROFILE.AllUsersCurrentHost -Force }
```

To create a new "Current user, All Hosts" profile, run this command:

```powershell
if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts))
{ New-Item -Type File -Path $PROFILE.CurrentUserAllHosts -Force }
```

To create a new "All users, All Hosts" profile, type:

```powershell
if (!(Test-Path -Path $PROFILE.AllUsersAllHosts))
{ New-Item -Type File -Path $PROFILE.AllUsersAllHosts -Force }
```

## To edit a profile

1. To open the profile, run the command `psEdit` with the variable that specifies the profile you want
   to edit. For example, to open the "Current user, Windows PowerShell ISE" profile, type:
   `psEdit $PROFILE`

2. Add some items to your profile. The following are a few examples to get you started:

   - To change the default background color of the Console Pane to blue, in the profile file type:
     `$psISE.Options.OutputPaneBackground = 'blue'` . For more information about the `$psISE`
     variable, see [Windows PowerShell ISE Object Model Reference](object-model/The-ISE-Object-Model-Hierarchy.md).

   - To change font size to 20, in the profile file type: `$psISE.Options.FontSize =20`

3. To save your profile file, on the **File** menu, click **Save**. Next time you open the Windows
   PowerShell ISE, your customizations are applied.

## See Also

- [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles)
- [Introducing the Windows PowerShell ISE](Introducing-the-Windows-PowerShell-ISE.md)
