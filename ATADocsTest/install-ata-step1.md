---
# required metadata

title: Install ATA - Step 1 | Microsoft ATA
description: First step to install ATA involves downloading and installing the ATA Center onto your chosen server.
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: get-started-article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: b3cceb18-0f3c-42ac-8630-bdc6b310f1d6

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.7*



# Install ATA - Step 1

>[!div class="step-by-step"]
[Step 2 »](install-ata-step2.md)

This installation procedure provides instructions for performing a fresh installation of ATA 1.7. For information on updating an existing ATA deployment from an earlier version, see [the ATA migration guide for version 1.7](/advanced-threat-analytics/understand-explore/ata-update-1.7-migration-guide).

> [!IMPORTANT] 
> If using Windows 2012 R2, you can install KB2934520 on the ATA Center server and on the ATA Gateway servers before beginning installation, otherwise the ATA installation will install this update and will require a restart in the middle of the ATA installation.

## Step 1. Download and Install the ATA Center
After you have verified that the server meets the requirements, you can proceed with the installation of the ATA Center.

Perform the following steps on the ATA Center server.

1.  Download ATA from the [Microsoft Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) or from the [TechNet Evaluation Center](http://www.microsoft.com/evalcenter/) or from [MSDN](https://msdn.microsoft.com/subscriptions/downloads).

2.  Log in to the computer onto which you are installing the ATA Center as a user who is a member of the local administrators group.

3.  Run **Microsoft ATA Center Setup.EXE** and follow the setup wizard.

4.  If Microsoft .Net Framework is not installed, you will be prompted to install it when you start installation. You may be prompted to reboot after .NET Framework installation.
5.  On the **Welcome** page, select the language to be used for the ATA installation screens and click **Next**.

6.  Read the Microsoft Software License Terms and if you accept the terms, click the check box and then click **Next**.

7.  It is recommended that you set ATA to update automatically. If Windows isn't set to do this on your computer, you will get the **Use Microsoft Update to help keep your computer secure and up to date** screen. 
    ![Keep ATA up to date image](media/ata_ms_update.png)

8. Select **Use Microsoft Update when I check for updates (recommended)**. This will adjust the Windows settings to enable updates for other Microsoft products (including ATA), as seen here. 
    ![Windows auto-update image](media/ata_installupdatesautomatically.png)

8.  On the **ATA Center Configuration** page, enter the following information based on your environment:

    |Field|Description|Comments|
    |---------|---------------|------------|
    |Installation Path|This is the location where the ATA Center will be installed. By default this is  %programfiles%\Microsoft Advanced Threat Analytics\Center|Leave the default value|
    |Database Data Path|This is the location where the MongoDB database files will be located. By default this is %programfiles%\Microsoft Advanced Threat Analytics\Center\MongoDB\bin\data|Change the location to a place where you have room to grow based on your sizing. **Note:** <ul><li>In production environments you should use a drive that has enough space based on capacity planning.</li><li>For large deployments the database should be on a separate physical disk.</li></ul>See [ATA capacity planning](/advanced-threat-analytics/plan-design/ata-capacity-planning) for sizing information.|
    |Center Service IP address: Port|This is the IP address that the ATA Center service will listen on for communication from the ATA Gateways.<br /><br />**Default port:** 443|Click the down arrow to select the IP address to be used by the ATA Center service.<br /><br />The IP address and port of the ATA Center service cannot be the same as the IP address and port of the ATA Console. Make sure to change the port of the ATA Console.|
    |Center Service SSL Certificate|This is the certificate that will be used by the ATA Console and ATA Center service.|Click the key icon to select a certificate installed or check self-signed certificate when deploying in a lab environment.|
    |Console IP address|This is the IP address that will be used for the ATA Console.|Click the down arrow to select the IP address used by the ATA Console. **Note:** Make a note of this IP address to make it easier to access the ATA Console from the ATA Gateway.|
    
    ![ATA center configuration image](media/ATA-Center-Configuration.png)

10.  Click **Install** to install the ATA Center and its components.
    The following components are installed and configured during the installation of ATA Center:

    -   ATA Center service

    -   MongoDB

    -   Custom Performance Monitor data collection set

    -   Self-signed certificates (if selected during the installation)

11.  When the installation completes, click **Launch**  to connect to the ATA Console.
At this point you will be brought automatically to the **General** settings page to continue the configuration and the deployment of the ATA Gateways.
Because you are logging into the site using an IP address, you will receive a warning related to the certificate, this is normal and you should click **Continue to this website**.

### Validate installation

1.  Check to see that the service named **Microsoft Advanced Threat Analytics Center** is running.
2.  On the desktop, click the **Microsoft Advanced Threat Analytics** shortcut to connect to the ATA Console. Log in with the same user credentials that you used to install the ATA Center.



>[!div class="step-by-step"]
[« Pre-install](preinstall-ata.md)
[Step 2 »](install-ata-step2.md)

## See Also

- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
- [Configure event collection](configure-event-collection.md)
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)

