---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Getting Ready to Use Windows PowerShell
ms.assetid:  6dc7052d-cc5a-4220-950f-98f963a2b587
---

# Getting Ready to Use Windows PowerShell
When Windows PowerShell is installed and started, consider the following setup options. You can perform these tasks at any time.

- **Install help files.** The cmdlets that are included in Windows PowerShell 3.0 do not come with help files. However, you can use the [Update-Help](https://technet.microsoft.com/en-us/library/93e1d870-ace6-432b-8778-8920291d7545) cmdlet to download and install the newest help files on your computer. When the files are installed, you can use the [Get-Help](https://technet.microsoft.com/en-us/library/1f46eeb4-49d7-4bec-bb29-395d9b42f54a) cmdlet to display them right at the command line. For more information, see [about_Updatable_Help](https://technet.microsoft.com/en-us/library/10bba75c-f4ac-4ca1-bbf3-8f34dd521ffe).

    If you decide not to install the help files, you can still read the help topics online. To find the online version of any cmdlet help topic, type: `Get-Help <CmdletName> -Online`. To browse the Windows PowerShell help topics in the TechNet Library, start at [http://go.microsoft.com/fwlink/?LinkID=107116](http://go.microsoft.com/fwlink/?LinkID=107116).

- **Run scripts.** To keep Windows PowerShell secure, the default execution policy on Windows PowerShell is **Restricted**. This policy allows you to run cmdlets, but not scripts. To run scripts, use the [Set-ExecutionPolicy[PSITPro5_Security]](https://technet.microsoft.com/en-us/library/5690a0e1-495b-4e63-8280-65ead7bf01ab) cmdlet to change the execution policy to **AllSigned** or **RemoteSigned**. Only members of the Administrators group on the computer can run this cmdlet. For more information, see [about_Execution_Policies [v4]](https://technet.microsoft.com/en-us/library/347708dc-1515-4d74-978b-8334603472e6).

- **Enable remoting.** The system is already configured for you to run remote commands on other computers. On Windows Server 2012 R2 and Windows Server 2012, the system is also configured to receive remote commands, that is, to allow other computers to run remote commands on the local computer. To enable computers running other versions of Windows to receive remote commands, run the [Enable-PSRemoting](https://technet.microsoft.com/en-us/library/19437c28-33b8-4ac1-9113-8439cc8beffb) cmdlet on the computer that you want to manage remotely. Only members of the Administrators group on the computer can run this cmdlet. For more information, see [about_Remote](https://technet.microsoft.com/en-us/library/9b4a5c87-9162-4adf-bdfe-fbc80b9b8970).

    NOTE: If remoting is enabled on a computer that is running Windows PowerShell 2.0, remoting is still enabled after you install Windows Management Framework 3.0. However, on Windows Server 2008 (not Windows Server 2008 R2), you must re-enable remoting after installing Windows Management Framework 3.0.

## See Also
- [Installing Windows PowerShell](../setup/Installing-Windows-PowerShell.md)
- [Starting Windows PowerShell [ps]](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)

