---
description: Where to find and how to launch PowerShell for new users.
ms.custom: Contributor-mikefrobbins
ms.date: 06/25/2024
ms.reviewer: mirobb
title: Getting started with PowerShell
---

# Chapter 1 - Getting started with PowerShell

This chapter focuses on finding and launching PowerShell and solving the initial pain points that
new users experience with PowerShell. Follow along and walk through the examples in this chapter on
your lab environment computer.

## What is PowerShell?

Windows PowerShell is an easy-to-use command-line shell and scripting environment for automating
administrative tasks of Windows-based systems.

## What you need to get started with PowerShell

All modern versions of Windows operating systems ship with Windows PowerShell preinstalled.

## Where to find PowerShell

The easiest way to find PowerShell on Windows 11 is to type `PowerShell` into the search bar, as
shown in Figure 1-1. Notice that there are four different shortcuts for Windows PowerShell.

![Figure 1-1 - Search for PowerShell.](media/figure1-1.jpg)

Windows PowerShell shortcuts on a 64-bit version of Windows:

- Windows PowerShell
- Windows PowerShell ISE
- Windows PowerShell (x86)
- Windows PowerShell ISE (x86)

On a 64-bit version of Windows, you have a 64-bit version of the Windows PowerShell console and the
Windows PowerShell Integrated Scripting Environment (ISE) and a 32-bit version of each one, as
indicated by the (x86) suffix on the shortcuts.

> [!NOTE]
> Windows 11 only ships as a 64-bit operating system. There is no 32-bit version of Windows 11.

You only have two shortcuts if you're running an older 32-bit version of Windows. Those shortcuts
don't have the (x86) suffix but are 32-bit versions.

I recommend using the 64-bit version of Windows PowerShell if you're running a 64-bit operating
system unless you have a specific reason for using the 32-bit version.

Depending on what version of Windows 11 you're running, Windows PowerShell may open in
[Windows Terminal][windows-terminal].

The PowerShell ISE is no longer in active feature development. I recommend using
[Visual Studio Code][vs-code] (VS Code) with the [PowerShell extension][ps-extension] to replace the
ISE. You must install VS Code and the PowerShell extension because they don't ship preinstalled with
Windows. You only need to install them on the computer where you create PowerShell scripts. You
don't need to install them on all the computers where you run PowerShell.

For information about finding PowerShell on other versions of Windows, see
[Starting Windows PowerShell][start-ps].

## How to launch PowerShell

I use three different Active Directory user accounts in the production environments I support. I've
mirrored those accounts in the lab environment used in this book. I log into my Windows 11 computer
as a domain user without domain or local administrator rights.

Launch the PowerShell console by clicking the **Windows PowerShell** shortcut, as shown in Figure
1-1. Notice that the title bar of the Windows PowerShell console says **Windows PowerShell**, as
shown in Figure 1-2.

![Figure 1-2 - Title bar of PowerShell window.](media/figure1-2.jpg)

Some commands run fine when you run PowerShell as an ordinary user. However, PowerShell doesn't
participate in User Access Control (UAC). That means it's unable to prompt for elevation for tasks
that require the approval of an administrator.

> [!NOTE]
> UAC is a Windows security feature that helps prevent malicious code from running with elevated
> privileges.

When running as an ordinary user, PowerShell returns an error when you run a command that requires
elevation, such as stopping a Windows service.

```powershell
Stop-Service -Name W32Time
```

```Output
Stop-Service : Service 'Windows Time (W32Time)' cannot be stopped due to
the following error: Cannot open W32Time service on computer '.'.
At line:1 char:1
+ Stop-Service -Name W32Time
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : CloseError: (System.ServiceProcess.ServiceCon
   troller:ServiceController) [Stop-Service], ServiceCommandException
    + FullyQualifiedErrorId : CouldNotStopService,Microsoft.PowerShell.Comm
   ands.StopServiceCommand
```

The solution is to run PowerShell elevated as a user who is a local administrator. That's how I
configured my second domain user account. Following the principle of least privilege, this account
shouldn't be a domain administrator or have any elevated privileges in the domain.

Close the PowerShell console. When you relaunch it, right-click the **Windows PowerShell** shortcut
and select **Run as administrator**, as shown in Figure 1-3.

![Figure 1-3 - Context menu - Run as administrator.](media/figure1-3.jpg)

You're prompted for credentials because you logged into Windows as an ordinary user. Enter the
credentials of your domain user who is a local administrator, as shown in Figure 1-4.

![Figure 1-4 - User account control - Enter credentials.](media/figure1-4.jpg)

After you've relaunched the PowerShell console elevated as an administrator, the title bar says
**Administrator: Windows PowerShell**, as shown in Figure 1-5.

![Figure 1-5 - Title bar of elevated PowerShell window.](media/figure1-5.jpg)

Now that you're running PowerShell elevated as an administrator, UAC is no longer a problem when you
run a command that requires elevation.

> [!IMPORTANT]
> You should only run PowerShell elevated as an administrator when absolutely necessary.

When targeting remote computers, there is no need to run PowerShell elevated. Running PowerShell
elevated as an administrator only affects commands that run against your local computer, not those
that target remote computers.

You can simplify finding and launching PowerShell. Pin the PowerShell console or Windows Terminal
shortcut to your taskbar, but don't set it to launch automatically as an administrator.

> The original version of this book, published in 2017, recommended pinning a shortcut to the
> taskbar to launch an elevated instance automatically every time you start PowerShell. However,
> this guidance is no longer recommended due to potential security implications. When you launch an
> application from an elevated instance of PowerShell, it also runs elevated and bypasses UAC. For
> example, if you launch a web browser from an elevated instance of PowerShell, any website you
> visit containing malicious code also runs elevated.

Search for PowerShell again, except this time right-click on it and select **Pin to taskbar** as
shown in Figure 1-6.

![Figure 1-6 - Context menu - Pin to taskbar.](media/figure1-6.jpg)

When you need to run PowerShell with elevated permissions, right-click the PowerShell shortcut
pinned to your taskbar while pressing <kbd>Shift</kbd> and select **Run as administrator**, as shown
in Figure 1-7.

![Figure 1-7 - Context menu - Run as administrator.](media/figure1-7.jpg)

You'll never have to worry about finding PowerShell or whether it's running elevated as an
administrator again.

## Determine your version of PowerShell

There are automatic variables in PowerShell that store state information. One of these variables is
`$PSVersionTable`, which contains a hashtable that you can use to display the PowerShell version.

```powershell
$PSVersionTable
```

```Output
Name                           Value
----                           -----
PSVersion                      5.1.22621.2428
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.22621.2428
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

If you're running a version of Windows PowerShell older than 5.1, you should update to Windows
PowerShell 5.1. Microsoft distributes new versions of Windows PowerShell as part of the Windows
Management Framework (WMF). Depending on the WMF version, a specific version of the .NET Framework
is required. To upgrade Windows PowerShell, see
[Upgrading existing Windows PowerShell][upgrade-ps].

PowerShell version 7 isn't an upgrade to Windows PowerShell 5.1; it installs side-by-side with
Windows PowerShell. Windows PowerShell version 5.1 and PowerShell version 7 are two different
products. For more information about the differences between Windows PowerShell version 5.1 and
PowerShell version 7, see [Migrating from Windows PowerShell 5.1 to PowerShell 7][migrate-ps].

> [!TIP]
> PowerShell version 6, formerly known as PowerShell Core, is no longer supported.

## Execution policy

PowerShell execution policy controls the conditions under which you can run PowerShell scripts. The
execution policy in PowerShell is a safety feature designed to help prevent the unintentional
execution of malicious scripts. However, it's not a security boundary because it can't stop
determined users from deliberately running scripts. A determined user can bypass the execution
policy in PowerShell.

You can set an execution policy for the local computer, current user, or a PowerShell session. You
can also set execution policies for users and computers with Group Policy.

The following table shows the default execution policy for current Windows operating systems.

| Windows Operating System Version | Default Execution Policy |
| -------------------------------- | ------------------------ |
| Windows Server 2022              | Remote Signed            |
| Windows Server 2019              | Remote Signed            |
| Windows Server 2016              | Remote Signed            |
| Windows 11                       | Restricted               |
| Windows 10                       | Restricted               |

Regardless of the execution policy setting, you can run any PowerShell command interactively. The
execution policy only affects commands running in a script. Use the `Get-ExecutionPolicy` cmdlet to
determine the current execution policy setting.

Check the execution policy setting on your computer.

```powershell
Get-ExecutionPolicy
```

```Output
Restricted
```

List the execution policy settings for all scopes.

```powershell
Get-ExecutionPolicy -List
```

```Output
        Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser       Undefined
 LocalMachine       Undefined
```

All Windows client operating systems have the default execution policy setting of `Restricted`. You
can't run PowerShell scripts using the `Restricted` execution policy setting. To test the execution
policy, save the following code as a `.ps1` file named `Get-TimeService.ps1`.

> A PowerShell script is a plaintext file with a `.ps1` extension that contains the commands you
> want to run. To create a PowerShell script, use a code editor like Visual Studio Code (VS Code) or
> any text editor such as Notepad.

```powershell
Get-Service -Name W32Time
```

When you run the previous command interactively, it completes without error. PowerShell returns an
error when you run the same command from a script.

```powershell
.\Get-TimeService.ps1
```

Notice the error message tells you why the command failed: "_Running scripts is disabled on this
system_".

```Output
.\Get-TimeService.ps1 : File C:\tmp\Get-TimeService.ps1 cannot be loaded
because running scripts is disabled on this system. For more information,
see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ .\Get-TimeService.ps1
+ ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

When you run a command in PowerShell that generates an error, read the error message before retrying
the command. The error message often tells you why the command failed.

You change the execution policy with the `Set-ExecutionPolicy` cmdlet. `LocalMachine` is the default
scope when you don't specify the **Scope** parameter. You must run PowerShell elevated as an
administrator to change the execution policy for the local machine. Unless you're signing your
scripts, I recommend using the `RemoteSigned` execution policy. `RemoteSigned` requires downloaded
scripts to be signed by a trusted publisher.

Before you change the execution policy, read the [about_Execution_Policies][execution-policies] help
topic to understand the security implications.

Change the execution policy setting on your computer to `RemoteSigned`.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

Read the warning that's displayed when you change the execution policy.

```Output
Execution Policy Change
The execution policy helps protect you from scripts that you do not trust.
Changing the execution policy might expose you to the security risks
described in the about_Execution_Policies help topic at
https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the
execution policy?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "N"):y
```

If you're not running PowerShell elevated as an administrator, you'll receive the following error
message when you attempt to change the execution policy for the local machine.

```Output
Set-ExecutionPolicy : Access to the registry key 'HKEY_LOCAL_MACHINE\SOFTWAR
E\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell' is denied. To
change the execution policy for the default (LocalMachine) scope, start
Windows PowerShell with the "Run as administrator" option. To change the
execution policy for the current user, run "Set-ExecutionPolicy -Scope
CurrentUser".
At line:1 char:1
+ Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : PermissionDenied: (:) [Set-ExecutionPolicy],
   UnauthorizedAccessException
    + FullyQualifiedErrorId : System.UnauthorizedAccessException,Microsoft.
   PowerShell.Commands.SetExecutionPolicyCommand
```

It's also possible to change the execution policy for the current user without requiring you to run
PowerShell elevated as an administrator.

Set the execution policy for the current user to `RemoteSigned`. This step is unnecessary if you
successfully set the execution policy for the local machine to `RemoteSigned`.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Now that you've changed the execution policy to `RemoteSigned`, the `Get-TimeService.ps1` script
runs successfully.

```powershell
.\Get-TimeService.ps1
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  W32Time            Windows Time
```

## Summary

In this chapter, you've learned where to find and how to launch PowerShell. You've also learned how
to determine the version of PowerShell and the purpose of execution policies.

## Review

1. How do you determine what PowerShell version a computer is running?
1. When should you launch PowerShell elevated as an administrator?
1. What's the default execution policy on Windows client computers, and what does it prevent you
   from doing?
1. How do you determine the current PowerShell execution policy setting?
1. How do you change the PowerShell execution policy?

## References

If you're interested in learning more about the topics covered in this chapter, you should read the
following PowerShell help topics.

- [about_Automatic_Variables][auto-variables]
- [about_Execution_Policies][execution-policies]
- [about_Hash_Tables][hash-tables]

## Next steps

In the next chapter, you'll learn about the discoverability of commands in PowerShell. You'll also
learn how to download PowerShell's help topics to view offline.

<!-- link references -->

[windows-terminal]: /windows/terminal/
[vs-code]: https://code.visualstudio.com/
[ps-extension]: https://code.visualstudio.com/docs/languages/powershell
[start-ps]: /scripting/windows-powershell/starting-windows-powershell
[upgrade-ps]: /powershell/scripting/windows-powershell/install/installing-windows-powershell#upgrading-existing-windows-powershell
[migrate-ps]: /powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7
[execution-policies]: /powershell/module/microsoft.powershell.core/about/about_execution_policies
[auto-variables]: /powershell/module/microsoft.powershell.core/about/about_automatic_variables
[hash-tables]: /powershell/module/microsoft.powershell.core/about/about_hash_tables
