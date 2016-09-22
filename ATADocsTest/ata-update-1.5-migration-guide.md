---
# required metadata

title: ATA update to 1.5 migration guide | Microsoft ATA
description: Procedures to update ATA to version 1.5
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 04/28/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: fb65eb41-b215-4530-93a2-0b8991f4e980

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# ATA update to 1.5 migration guide
The update to ATA 1.5 provides improvements in the following areas:

-   Faster detection times

-   Enhanced automatic detection algorithm for NAT (network address translation) devices

-   Enhanced name resolution process for non-domain joined devices

-   Support for data migration during product updates

-   Better UI responsiveness for suspicious activities with thousands of entities involved

-   Improved auto-resolution of monitoring alerts

-   Additional performance counters for enhanced monitoring and troubleshooting

## Updating ATA to version 1.5
> [!NOTE]
> If ATA is not installed in your environment, download the full version of ATA which includes version 1.5  and follow the standard installation procedure described in [Install ATA](/advanced-threat-analytics/deploy-use/install-ata).

If you already have ATA version 1.4 deployed, this procedure will walk you through the steps necessary to update your installation.

Follow these steps to update to ATA version 1.5:

1.  [Download update 1.5](http://aka.ms/ata1_5update)
      > [!NOTE]
         You can also use the updated full version of ATA to perform the update to version 1.5.


2.  Update the ATA Center

3.  Download the updated ATA Gateway package

4.  Update the ATA Gateways

    > [!IMPORTANT]
    > Update all the ATA Gateways to make sure ATA functions properly.

### Step 1: Update the ATA Center

1.  Back up your database: (optional)

    -   If the ATA Center is running as a virtual machine and you want to take a checkpoint, shut the virtual machine down first.

    -   If the ATA Center is running on a physical server, follow the recommended procedure to [back up MongoDB](https://docs.mongodb.org/manual/core/backups/).

2.  Run the update file, Microsoft ATA Center Update.exe, and follow the instructions on the screen to install the update.

    1.  In the **Welcome** page, select your language and click **Next**.

    2.  Read the End User License Agreement and if you accept the terms, click the checkbox and click **Next**.

    3.  Select whether you want to run the full (default) or partial migration.

        ![Choose full or partial migration](media/ATA-center-fullpartial.png)

        -   If you select **Partial** migration, any network traffic collected and forwarded Windows events analyzed by ATA will be deleted and user behavioral profiles will have to be re-learned; this takes a minimum of three weeks. If you are running low on disk space then it is helpful to run a **Partial** migration.

        -   If you run a **Full** migration, you will need additional disk space, as calculated for you on the upgrade page, and the migration may take longer, depending on the network traffic. The full migration retains all previously collected data and user behavioral profiles are maintained, meaning that it will not take additional time for ATA to learn behavior profiles and anomalous behavior can be detected immediately after update.

3.  Click **Update**. Once you click Update, ATA is offline until the update procedure is complete.

4.  After updating the ATA Center, the ATA Gateways will report that they are now outdated.

    ![Outdated gateways image](media/ATA-center-outdated.png)

> [!IMPORTANT]
> - Update all the ATA Gateways to make sure ATA functions properly.

### Step 2. Download the ATA Gateway setup package
After configuring the domain connectivity settings you can download the ATA Gateway setup package.

To download the ATA Gateway package:

1.  Delete any previous versions of the ATA Gateway package you previously downloaded.

2.  On the ATA Gateway machine, open a browser and enter the IP address you configured in the ATA Center for the ATA Console. When the ATA Console opens, click on the settings icon and select **Configuration**.

    ![Configuration settings icon](media/ATA-config-icon.JPG)

3.  In the **ATA Gateways** tab, click **Download ATA Gateway Setup**.

4.  Save the package locally.

The zip file includes the following:

-   ATA Gateway installer

-   Configuration setting file with the required information to connect to the ATA Center

### Step 3: Update the ATA Gateways

1.  On each ATA Gateway, extract the files from the ATA Gateway package and run the file Microsoft ATA Gateway Setup.

    > [!NOTE]
    > You can also use this ATA Gateway package to install new ATA Gateways.

2.  Your previous settings will be preserved, but it may take a few minutes until for the service to restart.

3.  Repeat this step for all other ATA Gateways deployed.

> [!NOTE]
> After successfully updating an ATA Gateway, the outdated notification for the specific ATA Gateway will go away.

You will know that all the ATA Gateways have been successfully updated when all the ATA Gateways report that they are successfully synced and the message that an updated ATA Gateway package is available is no longer displayed.

![Updated gateways image](media/ATA-gw-updated.png)

## See Also

- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
