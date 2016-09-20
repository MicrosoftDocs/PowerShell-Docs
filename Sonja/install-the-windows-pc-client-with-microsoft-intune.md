---
# required metadata

title: Install the PC client software | Microsoft Intune
description: Use this guide to help you get your Windows PCs managed by the Microsoft Intune client software.
keywords:
author: NathBarn
manager: arob98
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 64c11e53-8d64-41b9-9550-4b4e395e8c52

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: owenyen
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Install the Intune software client on Windows PCs
Windows PCs can be enrolled by installing the Intune client software. The Intune client software can be installed in the following ways:

- Manually installed
- Install using Group policy
- Include in a disk image
- Installed by users

## Download Intune client software

All methods, except where users install the Intune client software themselves, require that you download the software so it can be deployed.

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), click **Admin** &gt; **Client Software Download**

  ![Download the Intune PC client](../media/pc-sa-client-download.png)

2.  On the **Client Software Download** page, click **Download Client Software** and save the **Microsoft_Intune_Setup.zip** package containing the software to a secure location on your network.

    > [!NOTE]
    > The Intune client software installation package contains information about your account. If unauthorized users gain access to the installation package, they can enroll computers to the account that is represented by its embedded certificate.

3.  Extract the contents of the installation package to the secure location on your network.

    > [!IMPORTANT]
    > Do not rename or remove the **ACCOUNTCERT** file that is extracted or the client software installation will fail.

## Manually deploy

1.  On a computer, browse to the folder where the client software installation files are located, and then run **Microsoft_Intune_Setup.exe** to install the client software.

    > [!NOTE]
    > The status of the installation is displayed when you hover over the icon in the taskbar on the client computer.

## Deploy with using Group Policy

1.  In the folder that contains the files **Microsoft_Intune_Setup.exe** and **MicrosoftIntune.accountcert**, run the following command to extract the Windows Installer-based installation programs for 32-bit and 64-bit computers:

    ```
    Microsoft_Intune_Setup.exe/Extract <destination folder>
    ```

2.  Copy the **Microsoft_Intune_x86.msi** file, the **Microsoft_Intune_x64.msi** file, and the **MicrosoftIntune.accountcert** file to a network location that can be accessed by all computers to which the client software is to be installed.

    > [!IMPORTANT]
    > Do not separate or rename the files or the client software installation will fail.

3.  Use Group Policy to deploy the software to computers on your network.

    For more information about how to use Group Policy to automatically deploy software, see your Windows Server documentation.

## Install  as part of an image
You can deploy the Intune client software to computers as part of an operating system image by using the following example procedure as a basis:

1.  Copy the client installation files, **Microsoft_Intune_Setup.exe** and **MicrosoftIntune.accountcert** to the **%Systemdrive%\Temp\Microsoft_Intune_Setup** folder on the reference computer.

2.  Create the **WindowsIntuneEnrollPending** registry entry by adding the following command to the **SetupComplete.cmd** script:

    ```
    %windir%\system32\reg.exe add HKEY_LOCAL_MACHINE\Software\Microsoft\Onlinemanagement\Deployment /v
    WindowsIntuneEnrollPending /t REG_DWORD /d 1
    ```

3.  Add the following command to **setupcomplete.cmd** to run the enrollment package with the /PrepareEnroll command-line argument:

    ```
    %systemdrive%\temp\Microsoft_Intune_Setup\Microsoft_Intune_Setup.exe /PrepareEnroll
    ```
    > [!TIP]
    > The **SetupComplete.cmd** script enables Windows Setup to make modifications to the system before a user logs on. The **/PrepareEnroll** command-line argument prepares a targeted computer to be automatically enrolled in Intune after Windows Setup finishes.

4.  Put **SetupComplete.cmd** in the **%Windir%\Setup\Scripts** folder on the reference computer.

5.  Capture an image of the reference computer and then deploy this to targeted computers.

When the targeted computer restarts at the completion of Windows Setup, the **WindowsIntuneEnrollPending** registry key is created. The enrollment package checks whether the computer is enrolled. If the computer is enrolled, no further action is taken. If the computer is not enrolled, the enrollment package creates a Microsoft Intune Automatic Enrollment Task.

When the automatic enrollment task runs at the next scheduled time, it checks the existence of the **WindowsIntuneEnrollPending** registry value, and it tries to enroll the targeted PC in Intune. If the enrollment fails for any reason, the enrollment is retried the next time the task runs. The retries continue for a period of one month.

The Intune Automatic Enrollment Task, the **WindowsIntuneEnrollPending** registry value, and the account certificate are deleted from the targeted computer when the enrollment is successful or after one month.

## Instruct user to self-enroll

Users can install the Intune client software by browsing to  [http://portal.manage.microsoft.com](http://portal..manage.microsoft.com). If the web portal can detect the device is a Windows PC, it will prompted to enroll PC by downloading the Intune software client. Once downloaded, users can install the software to bring their PCs into management.

![Intune Portal prompting to download the Intune software client](../media/software-client-download.png)

## Monitor and validate successful client deployment
Use one of the following procedures to help you monitor and validate successful client deployment.

### To verify the installation of the client software from the Microsoft Intune administrator console

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), click **Groups** &gt; **All Devices** &gt; **All Computers**.

2.  Scroll down the list of computers to find managed computers that are communicating with Intune, or to search for a specific managed computer by typing the computer name, or any part of the name, in the **Search devices** box.

3.  Examine the status of the computer in the bottom pane of the console, and resolve any errors.

### To create a computer inventory report to display all enrolled computers

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), click **Reports** &gt; **Computer Inventory Reports**.

2.  On the **Create New Report** page, leave all fields as the default values (unless you want to apply filters), and click **View Report**.

3.  The **Computer Inventory Report** page opens in a new window that displays all computers that are successfully enrolled in Intune.

    > [!TIP]
    > Click any column heading in the report to sort the list by the contents of that column.


### See Also
[Manage Windows PCs with Microsoft Intune](manage-windows-pcs-with-microsoft-intune.md)
[Troubleshoot client setup](../troubleshoot/troubleshoot-client-setup-in-microsoft-intune)
