---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Getting Ready to Use Windows PowerShell
ms.assetid:  6dc7052d-cc5a-4220-950f-98f963a2b587
---

# Getting Ready to Use Windows PowerShell
When Windows PowerShell is installed and started, consider the following setup options. You can perform these tasks at any time.

- **Install help files.** The cmdlets that are included in Windows PowerShell 3.0 do not come with help files. However, you can use the [Update-Help](/powershell/module/microsoft.powershell.core/update-help) cmdlet to download and install the newest help files on your computer. When the files are installed, you can use the [Get-Help](/powershell/module/microsoft.powershell.core/get-help) cmdlet to display them right at the command line. For more information, see [about_Updatable_Help](/powershell/module/microsoft.powershell.core/about/about_updatable_help).

    If you decide not to install the help files, you can still read the help topics online. To find the online version of any cmdlet help topic, type: `Get-Help <CmdletName> -Online`. To browse the Windows PowerShell help topics see the [PowerShell documentation](/powershell/scripting).

- **Run scripts.** To keep Windows PowerShell secure, the default execution policy on Windows PowerShell is **Restricted**. This policy allows you to run cmdlets, but not scripts. To run scripts, use the [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy) cmdlet to change the execution policy to **AllSigned** or **RemoteSigned**. Only members of the Administrators group on the computer can run this cmdlet. For more information, see [about_Execution_Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

- **Enable remoting.** The system is already configured for you to run remote commands on other computers. On Windows Server 2012 R2 and Windows Server 2012, the system is also configured to receive remote commands, that is, to allow other computers to run remote commands on the local computer. To enable computers running other versions of Windows to receive remote commands, run the [Enable-PSRemoting](/powershell/module/microsoft.powershell.core/enable-psremoting) cmdlet on the computer that you want to manage remotely. Only members of the Administrators group on the computer can run this cmdlet. For more information, see [about_Remote](/powershell/module/microsoft.powershell.core/about/about_remote).

    NOTE: If remoting is enabled on a computer that is running Windows PowerShell 2.0, remoting is still enabled after you install Windows Management Framework 3.0. However, on Windows Server 2008 (not Windows Server 2008 R2), you must re-enable remoting after installing Windows Management Framework 3.0.

## See Also
- [Installing Windows PowerShell](../setup/Installing-Windows-PowerShell.md)
- [Starting Windows PowerShell](/powershell/scripting/setup/starting-windows-powershell)