---
title: Using Visual Studio Code for remote editing and debugging
description: Using Visual Studio Code for remote editing and debugging
ms.date: 08/06/2018
---

# Using Visual Studio Code for remote editing and debugging

For those of you that were familiar with the ISE, you may recall that you could run `psedit file.ps1` from the integrated console to open files - local or remote - right in the ISE.

As it turns out, this feature is also available in the PowerShell extension for VSCode. This guide will show you how to do it.

## Prerequisites

This guide assumes that you have:

- a remote resource (ex: a VM, a container) that you have access to
- PowerShell running on it and the host machine
- VSCode and the PowerShell extension for VSCode

This feature works on Windows PowerShell and PowerShell Core.

This feature also works when connecting to a remote machine via WinRM, PowerShell Direct, or SSH. If you want to use SSH, but are using Windows, check out the [Win32 version of SSH](https://github.com/PowerShell/Win32-OpenSSH)!

## Let's go

In this section, I'll walk through remote editing and debugging from my MacBook Pro, to an Ubuntu VM running in Azure. I might not be using Windows, but **the process is identical**.

### Local file editing with Open-EditorFile

With the PowerShell extension for VSCode started and the PowerShell Integrated Console opened, we can type `Open-EditorFile foo.ps1` or `psedit foo.ps1` to open the local foo.ps1 file right in the editor.

![Open-EditorFile foo.ps1 works locally](https://user-images.githubusercontent.com/2644648/34895897-7c2c46ac-f79c-11e7-9410-a252aff52f13.png)

>[!NOTE]
> foo.ps1 must already exist.

From there, we can:

add breakpoints to the gutter
![adding breakpoint to gutter](https://user-images.githubusercontent.com/2644648/34895893-7bdc38e2-f79c-11e7-8026-8ad53f9a1bad.png)

and hit F5 to debug the PowerShell script.
![debugging the PowerShell local script](https://user-images.githubusercontent.com/2644648/34895894-7bedb874-f79c-11e7-9180-7e0dc2d02af8.png)

While debugging, you can interact with the debug console, check out the variables in the scope on the left, and all the other standard debugging tools.

### Remote file editing with Open-EditorFile

Now let's get into remote file editing and debugging. The steps are nearly the same, there's just one thing we need to do first - enter our PowerShell session to the remote server.

There's a cmdlet for to do so. It's called `Enter-PSSession`.

The watered down explanation of the cmdlet is:

- `Enter-PSSession -ComputerName foo` starts a session via WinRM
- `Enter-PSSession -ContainerId foo` and `Enter-PSSession -VmId foo` start a session via PowerShell Direct
- `Enter-PSSession -HostName foo` starts a session via SSH

For more info on `Enter-PSSession`, check out the docs [here](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/enter-pssession?view=powershell-6).

I'll be using SSH for remoting since I'm going from macOS to an Ubuntu VM in Azure.

First, in the Integrated Console, let's run our Enter-PSSession. You'll know that you're in the session because `[something]` will show up to the left of your prompt.

![The call to Enter-PSSession](https://user-images.githubusercontent.com/2644648/34895896-7c18e0bc-f79c-11e7-9b36-6f4bd0e9b0db.png)

From there, we can do the exact steps as if we were editing a local script.

1. Run `Open-EditorFile test.ps1` or `psedit test.ps1` to open the remote `test.ps1` file ![Open-EditorFile the test.ps1 file](https://user-images.githubusercontent.com/2644648/34895898-7c3e6a12-f79c-11e7-8bdf-549b591ecbcb.png)
2. Edit the file/set breakpoints ![edit and set breakpoints](https://user-images.githubusercontent.com/2644648/34895892-7bb68246-f79c-11e7-8c0a-c2121773afbb.png)
3. Start debugging (F5) the remote file

![debugging the remote file](https://user-images.githubusercontent.com/2644648/34895895-7c040782-f79c-11e7-93ea-47724fa5c10d.png)

That's all there's to it! We hope that this guide helped clear up any questions about remote debugging and editing PowerShell in VSCode.

If you have any problems, feel free to open issues [on the GitHub repo](http://github.com/powershell/vscode-powershell).
