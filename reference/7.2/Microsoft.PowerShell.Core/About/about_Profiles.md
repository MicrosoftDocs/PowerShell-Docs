---
description: Describes how to create and use a PowerShell profile.
ms.date: 11/30/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Profiles
---
# About Profiles

## Short Description
Describes how to create and use a PowerShell profile.

## Long Description

You can create a PowerShell profile to customize your environment and to add
session-specific elements to every PowerShell session that you start.

A PowerShell profile is a script that runs when PowerShell starts. You can use
the profile as a logon script to customize the environment. You can add
commands, aliases, functions, variables, snap-ins, modules, and PowerShell
drives. You can also add other session-specific elements to your profile so
they are available in every session without having to import or re-create
them.

PowerShell supports several profiles for users and host programs. However, it
does not create the profiles for you. This topic describes the profiles, and
it describes how to create and maintain profiles on your computer.

It explains how to use the **NoProfile** parameter of the PowerShell console
(PowerShell.exe) to start PowerShell without any profiles. And, it explains
the effect of the PowerShell execution policy on profiles.

## The Profile Files

PowerShell supports several profile files. Also, PowerShell host programs can
support their own host-specific profiles.

For example, the PowerShell console supports the following basic
profile files. The profiles are listed in precedence order. The first
profile has the highest precedence.

|Description               | Path                                          |
|--------------------------|-----------------------------------------------|
|All Users, All Hosts      |$PSHOME\\Profile.ps1                           |
|All Users, Current Host   |$PSHOME\\Microsoft.PowerShell_profile.ps1      |
|Current User, All Hosts   |$Home\\[My ]Documents\\PowerShell\\Profile.ps1 |
|Current user, Current Host|$Home\\[My ]Documents\\PowerShell\\<br>Microsoft.PowerShell_profile.ps1 |

The profile paths include the following variables:

- The `$PSHOME` variable, which stores the installation directory for
PowerShell
- The `$Home` variable, which stores the current user's home directory

In addition, other programs that host PowerShell can support their own
profiles. For example, Visual Studio Code supports the following
host-specific profiles.

|Description               | Path                                     |
|--------------------------|------------------------------------------|
|All users, Current Host   |$PSHOME\\Microsoft.VSCode_profile.ps1|
|Current user, Current Host|$Home\\[My ]Documents\\PowerShell\\<br>Microsoft.VSCode_profile.ps1|

In PowerShell Help, the "CurrentUser, Current Host" profile is the profile
most often referred to as "your PowerShell profile".

## The $PROFILE variable

The `$PROFILE` automatic variable stores the paths to the PowerShell profiles
that are available in the current session.

To view a profile path, display the value of the `$PROFILE` variable. You can
also use the `$PROFILE` variable in a command to represent a path.

The `$PROFILE` variable stores the path to the "Current User, Current Host"
profile. The other profiles are saved in note properties of the `$PROFILE`
variable.

For example, the `$PROFILE` variable has the following values in the Windows
PowerShell console.

|Description                |Name                              |
|---------------------------|----------------------------------|
|Current User, Current Host |`$PROFILE`                        |
|Current User, Current Host |`$PROFILE.CurrentUserCurrentHost` |
|Current User, All Hosts    |`$PROFILE.CurrentUserAllHosts`    |
|All Users, Current Host    |`$PROFILE.AllUsersCurrentHost`    |
|All Users, All Hosts       |`$PROFILE.AllUsersAllHosts`       |

Because the values of the `$PROFILE` variable change for each user and in each
host application, ensure that you display the values of the profile variables
in each PowerShell host application that you use.

To see the current values of the `$PROFILE` variable, type:

```powershell
$PROFILE | Get-Member -Type NoteProperty
```

You can use the `$PROFILE` variable in many commands. For example, the
following command opens the "Current User, Current Host" profile in Notepad:

```powershell
notepad $PROFILE
```

The following command determines whether an "All Users, All Hosts" profile has
been created on the local computer:

```powershell
Test-Path -Path $PROFILE.AllUsersAllHosts
```

## How to create a profile

To create a PowerShell profile, use the following command format:

```powershell
if (!(Test-Path -Path <profile-name>)) {
  New-Item -ItemType File -Path <profile-name> -Force
}
```

For example, to create a profile for the current user in the current
PowerShell host application, use the following command:

```powershell
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}
```

In this command, the `If` statement prevents you from overwriting an existing
profile. Replace the value of the \<profile-path\> placeholder with the path
to the profile file that you want to create.

> [!NOTE]
> To create "All Users" profiles in Windows Vista and later versions of
> Windows, start PowerShell with the **Run as administrator** option.

## How to edit a profile

You can open any PowerShell profile in a text editor, such as Notepad.

To open the profile of the current user in the current PowerShell host
application in Notepad, type:

```powershell
notepad $PROFILE
```

To open other profiles, specify the profile name. For example, to open the
profile for all the users of all the host applications, type:

```powershell
notepad $PROFILE.AllUsersAllHosts
```

To apply the changes, save the profile file, and then restart PowerShell.

## How to choose a profile

If you use multiple host applications, put the items that you use in all the
host applications into your `$PROFILE.CurrentUserAllHosts` profile. Put items
that are specific to a host application, such as a command that sets the
background color for a host application, in a profile that is specific to that
host application.

If you are an administrator who is customizing PowerShell for many
users, follow these guidelines:

- Store the common items in the `$PROFILE.AllUsersAllHosts` profile
- Store items that are specific to a host application in
  `$PROFILE.AllUsersCurrentHost` profiles that are specific to the host
  application
- Store items for particular users in the user-specific profiles

Be sure to check the host application documentation for any special
implementation of PowerShell profiles.

## How to use a profile

Many of the items that you create in PowerShell and most commands that you run
affect only the current session. When you end the session, the items are
deleted.

The session-specific commands and items include variables, preference
variables, aliases, functions, commands (except for
[Set-ExecutionPolicy](xref:Microsoft.PowerShell.Security.Set-ExecutionPolicy)),
and PowerShell modules that you add to the session.

To save these items and make them available in all future sessions, add them
to a PowerShell profile.

Another common use for profiles is to save frequently-used functions, aliases,
and variables. When you save the items in a profile, you can use them in any
applicable session without recreating them.

## How to start a profile

When you open the profile file, it is blank. However, you can fill it with the
variables, aliases, and commands that you use frequently.

Here are a few suggestions to get you started.

### Add commands that make it easy to open your profile

This is especially useful if you use a profile other than the "Current User,
Current Host" profile. For example, add the following command:

```powershell
function Pro {notepad $PROFILE.CurrentUserAllHosts}
```

### Add a function that lists the aliases for any cmdlet

```powershell
function Get-CmdletAlias ($cmdletname) {
  Get-Alias |
    Where-Object -FilterScript {$_.Definition -like "$cmdletname"} |
      Format-Table -Property Definition, Name -AutoSize
}
```

### Customize your console

```powershell
function Color-Console {
  $Host.ui.rawui.backgroundcolor = "white"
  $Host.ui.rawui.foregroundcolor = "black"
  $hosttime = (Get-ChildItem -Path $PSHOME\PowerShell.exe).CreationTime
  $hostversion="$($Host.Version.Major)`.$($Host.Version.Minor)"
  $Host.UI.RawUI.WindowTitle = "PowerShell $hostversion ($hosttime)"
  Clear-Host
}
Color-Console
```

### Add a customized PowerShell prompt

```powershell
function Prompt
{
$env:COMPUTERNAME + "\" + (Get-Location) + "> "
}
```

For more information about the PowerShell prompt, see
[about_Prompts](about_Prompts.md).

## The NoProfile parameter

To start PowerShell without profiles, use the **NoProfile** parameter of
**PowerShell.exe**, the program that starts PowerShell.

To begin, open a program that can start PowerShell, such as Cmd.exe or
PowerShell itself. You can also use the Run dialog box in Windows.

Type:

```
PowerShell -NoProfile
```

For a complete list of the parameters of PowerShell.exe, type:

```
PowerShell -?
```

## Profiles and Execution Policy

The PowerShell execution policy determines, in part, whether you can run
scripts and load configuration files, including the profiles. The **Restricted**
execution policy is the default. It prevents all scripts from running,
including the profiles. If you use the "Restricted" policy, the profile does
not run, and its contents are not applied.

A `Set-ExecutionPolicy` command sets and changes your execution policy. It is
one of the few commands that applies in all PowerShell sessions because the
value is saved in the registry. You do not have to set it when you open the
console, and you do not have to store a `Set-ExecutionPolicy` command in your
profile.

## Profiles and remote sessions

PowerShell profiles are not run automatically in remote sessions, so the
commands that the profiles add are not present in the remote session. In
addition, the `$PROFILE` automatic variable is not populated in remote
sessions.

To run a profile in a session, use the [Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
cmdlet.

For example, the following command runs the "Current user, Current Host"
profile from the local computer in the session in `$s`.

```powershell
Invoke-Command -Session $s -FilePath $PROFILE
```

The following command runs the "Current user, Current Host" profile from the
remote computer in the session in `$s`. Because the `$PROFILE` variable is not
populated, the command uses the explicit path to the profile. We use dot
sourcing operator so that the profile executes in the current scope on the
remote computer and not in its own scope.

```powershell
Invoke-Command -Session $s -ScriptBlock {
  . "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}
```

After running this command, the commands that the profile adds to the session
are available in `$s`.

## See Also

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Functions](about_Functions.md)

[about_Prompts](about_Prompts.md)

[about_Execution_Policies](about_Execution_Policies.md)

[about_Signing](about_Signing.md)

[about_Remote](about_Remote.md)

[about_Scopes](about_Scopes.md)

[Set-ExecutionPolicy](xref:Microsoft.PowerShell.Security.Set-ExecutionPolicy)

