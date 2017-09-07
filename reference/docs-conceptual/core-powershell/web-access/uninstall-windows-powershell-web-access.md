---
ms.date:  2017-08-23
keywords:  powershell,cmdlet
title:  uninstall windows powershell web access
---

# Uninstall Windows PowerShell Web Access

Updated: June 24, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

The steps in this topic remove the Windows PowerShell Web Access website
and corresponding application from the gateway server where it is installed.

## Notify users

Before you begin, notify users of the web-based console that you are 
removing the website.

Uninstalling Windows PowerShell Web Access does not uninstall IIS or any
other features that were installed automatically because Windows PowerShell
Web Access requires them to run.
The uninstallation process leaves features installed upon which Windows
PowerShell Web Access was dependent;
you can uninstall those features separately if needed.

## Recommended (quick) uninstallation

Procedures in this section help you uninstall both:

- the Windows PowerShell Web Access web application, and
- the Windows PowerShell Web Access feature
 
by using Windows PowerShell cmdlets.

### Step 1: Delete the web application using cmdlets

1. Do one of the following to open a Windows PowerShell session.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar.

    -   On the Windows **Start** screen, click **Windows PowerShell**.

2. Type `Uninstall-PswaWebApplication`, and then press **Enter**.
   1. If you have specified your own, custom website name, add the `-WebsiteName` parameter to your command, and specify the website name.

        `Uninstall-PswaWebApplication -WebsiteName <web-site-name>`
   1. If you have used a custom web application (not the default application, **pswa**, add the `-WebApplicationName` parameter to your command, and specify the name of the web application.

        `Uninstall-PswaWebApplication -WebApplicationName <web-application-name>`
   1. If you are using a test certificate, add the `DeleteTestCertificate` parameter to the cmdlet, as shown in the following example.

        `Uninstall-PswaWebApplication -DeleteTestCertificate`

### Step 2: Uninstall Windows PowerShell Web Access using cmdlets

1. Do one of the following to open a Windows PowerShell session with elevated user rights. If a session is already open, go on to the next step.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right-click **Windows PowerShell**, and then click **Run as Administrator**.

1. Type the following, and then press **Enter**, where *computer_name* represents a remote server from which you want to remove Windows PowerShell Web Access. The `-Restart` parameter automatically restarts destination servers if required by the removal.

        Uninstall-WindowsFeature -Name WindowsPowerShellWebAccess -ComputerName <computer_name> -Restart

    To remove roles and features from an offline VHD, you must add both the `-ComputerName` parameter and the `-VHD` parameter. The `-ComputerName` parameter contains the name of the server on which to mount the VHD, and the `-VHD` parameter contains the path to the VHD file on the specified server.

        Uninstall-WindowsFeature -Name WindowsPowerShellWebAccess -VHD <path> -ComputerName <computer_name> -Restart

1. When removal is finished, verify that you removed Windows PowerShell Web Access by opening the **All Servers** page in Server Manager, selecting a server from which you removed the feature, and viewing the **Roles and Features** tile on the page for the selected server.

    You can also run the `Get-WindowsFeature` cmdlet targeted at the selected server (Get-WindowsFeature -ComputerName &lt;*computer_name*&gt;) to view a list of roles and features that are installed on the server.

## Custom uninstallation

Procedures in this section help you uninstall both the Windows PowerShell Web Access web application and the Windows PowerShell Web Access feature by using the Remove Roles and Features Wizard in Server Manager, and the IIS Manager console.

### Step 1: Delete the web application using IIS Manager


1. Open the IIS Manager console by doing one of the following. If it is already open, go on to the next step.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar. On the **Tools** menu in Server Manager, click **Internet Information Services (IIS) Manager**.

    -   On the Windows **Start** screen, type any part of the name **Internet Information Services (IIS) Manager**. Click the shortcut when it is displayed in the **Apps** results.

1. In the IIS Manager tree pane, select the website that is running the Windows PowerShell Web Access web application.

1. In the **Actions** pane, under **Manage Website**, click **Stop**.

1. In the tree pane, right-click the web application in the website that is running the Windows PowerShell Web Access web application, and then click **Remove**.

1. In the tree pane, select **Application Pools**, select the Windows PowerShell Web Access application pool folder, click **Stop** in the **Actions** pane, and then click **Remove** in the content pane.

1. Close IIS Manager.

> ![Warning note](images/SecurityNote.jpeg)**Note**:
>
> The certificate is not deleted during uninstallation. 
>
> If you created a self-signed certificate or used a test certificate and want to remove it, delete the certificate in IIS Manager. 

### Step 2: Uninstall Windows PowerShell Web Access using the Remove Roles and Features Wizard

1. If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.

    -   On the Windows **Start** screen, click **Server Manager**.

1. On the **Manage** menu, click **Remove Roles and Features**.

1. On the **Select destination server** page, select the server or offline VHD from which you want to remove the feature. To select an offline VHD, first select the server on which to mount the VHD, and then select the VHD file. After you have selected the destination server, click **Next**.

1. Click **Next** again to skip to the **Remove features** page.

1. Clear the check box for **Windows PowerShell Web Access**, and then click **Next**.

1. On the **Confirm removal selections** page, click **Remove**.

## See Also

- [Install and Use Windows PowerShell Web Access](install-and-use-windows-powershell-web-access.md)
- [IIS Manager 7.0 Help](https://technet.microsoft.com/library/cc732664.aspx)
