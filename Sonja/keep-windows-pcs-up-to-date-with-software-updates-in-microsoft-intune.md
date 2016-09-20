---
# required metadata

title: Software updates for Windows PCs | Microsoft Intune
description: Intune helps you to keep your managed computers up to date by ensuring the latest patches and software updates are quickly installed.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 48e9c41a-d2de-424e-9610-cfd1ad514210

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: owenyen
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Keep Windows PCs up to date with software updates in Microsoft Intune
Microsoft Intune can help you to secure your managed computers in a number of ways, including the management of software updates that keep your computers up to date by ensuring the latest patches and software updates are quickly installed.

If you have not yet installed the Intune client on your computers, see [Install the Windows PC client with Microsoft Intune](install-the-windows-pc-client-with-microsoft-intune.md).

When new updates are available from Microsoft Update, or you have created a third-party update, and they are applicable to your managed computers, a notification is displayed on the **Overview** page of the **Updates** workspace. After you choose this notification link, you can then perform various operations like viewing more information about the update, approving or declining the update, and viewing the computers that will install the update if it is approved.

> [!IMPORTANT]
> The **Updates** workspace is not displayed in the administrator console until you have installed the client on, and are successfully managing at least one computer client.

As updates are approved and installed, you can examine the success or failure of the installation in the **Updates** workspace of the Intune console.

The following sections will help you to keep software up to date on your managed computers.

## Before you start
Before you begin to create and approve software updates, configure and deploy polices to your computers that control when and how the updates are installed.

### To configure update policy settings

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Policy** &gt; **Overview** &gt; **Add Policy**.

2.  Configure and deploy a **Microsoft Intune Agent Settings** policy for the update settings. You can use recommended settings or customize the settings. If you need more information about how to create and deploy policies, see [Common Windows PC management tasks with the Microsoft Intune computer client](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client.md).

The following table shows the values you can configure in the policy and also the recommended values that will be used if you don’t customize the policy. You can find these settings in the **Updates** section.

  |Policy setting|Details|
    |------------------|--------------------|
    |**Update and application detection frequency (hours)** |Specifies how frequently (from 8-22 hours) Intune checks for new updates and applications.<br /><br />Recommended value: **8** hours.|
    |**Automated or prompted installation of updates and applications** |Specifies whether updates are installed automatically or whether the user is prompted before installation. Additionally, this setting lets you schedule the installation of updates and applications.<br /><br />**Install updates and applications automatically as scheduled**  installs updates and applications using the specified schedule.<br /><br />As a dependent policy setting, **Use Automatic Maintenance for Windows computers**  specifies that updates and applications are installed during the Windows Automatic maintenance window.<br /><br />**Prompt user for installation** prompts the user to install updates when they are ready.<br /><br />Recommended values:<br /><br />**Install updates and applications automatically as scheduled** selected<br /><br />**Day scheduled: Every day**<br /><br />**Time scheduled: 3:00 AM**<br /><br />**Use Automatic Maintenance for Windows computers** selected|
    |**Allow immediate installation of updates that do not interrupt Windows** |**Allow** installs updates immediately after they are downloaded, except for updates that would interrupt or restart Windows. Those updates are installed according to the configuration of the **Automated or prompted installation of updates** setting.<br /><br />**Do not allow** installs updates according to the configuration of the **Automated or prompted installation of updates** setting.<br /><br />Recommended value: **Allow** |
    |**Delay to restart Windows after installation of scheduled updates and applications (minutes)** |Specifies (from 1-30 minutes), the time to wait to restart Windows after the installation of scheduled updates and applications.<br /><br />Recommended value: **15 minutes** |
    |**Delay following Windows restart to begin installing missed scheduled updates and applications (minutes)** |Specifies (from 1-60 minutes), how long to wait to start the installation of updates and applications after Windows is restarted when a scheduled update was missed.<br /><br />Recommended value: **5 minutes**|
    |**Allow logged-on user to control Windows restart after installation of scheduled updates and applications** |Specifies whether the logged-on user can delay restarting Windows (if set to **Yes**), or be notified of the automatic Windows restart (if set to **No**). If no user is logged on when the scheduled installation of updates and applications is completed, Windows is restarted automatically when required. When set to **No**, by default, the time before Windows restarts is set to 5 minutes.<br /><br />Recommended value: **Yes**|
    |**Prompt user to restart Windows during Intune client agent mandatory updates** |Specifies whether the logged on users is prompted to restart Windows when an Intune client mandatory update requires Windows to restart.<br /><br />Recommended value: **Yes**|
    |**Microsoft Intune client agent mandatory updates installation schedule** |Schedules when the installation of client updates occur.<br /><br />Recommended value: not configured|
    |**Delay between prompts to restart Windows after installation of scheduled updates and applications (minutes)** |Specifies how frequently (from 1-1440 minutes) the user is prompted to restart Windows when a scheduled update or application that requires restarting Windows is installed, and the user delays the restart.<br /><br />Recommended value: **30 minutes** |

## Update software made by Microsoft
Updating Microsoft software requires very little work from you. However, before you start, there are two things you should configure:

-   **Product categories and update classifications** – Defines the categories and classifications of the updates you want to make available to computers. For example, you might decide that you only want critical updates for Microsoft Office to be installed.

-   **Automatic approval rules** – These rules automatically approve specified types of update and reduce your administrative overhead. For example, you might want to automatically approve all critical software updates.

Use the following two procedures to help you get ready to use software updates:

### Configure the product categories and update classifications you want to make available to managed computers

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Admin** &gt; **Updates**.

2.  On the **Service Settings: Updates** page, in the **Product Category** list, select the update categories that you want to make available to computers. Note that the most common updates are selected by default.

    > [!IMPORTANT]
    > To ensure that computers receive the updates that have been approved by the admin, the Windows Server Update Services (WSUS) Group Policy setting, **Specify Intranet Microsoft update service location** must not be applied to computers that have been enrolled with Intune.

3.  In the **Update Classification** list, select the classes of update that you want to make available to managed computers. Again, the most common options are selected by default.

4.  Choose **Save** to store your selections.

### To configure automatic approval rules for software updates

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Admin** &gt; **Updates**.

2.  In the **Automatic Approval Rules** section of the **Server Settings: Updates** page, choose **New**.

3.  On the **General** page of the Create Automatic Approval Rule Wizard, specify a name and optional description for the rule.

4.  On the **Product Categories** page, select any products for which you want to have updates approved automatically.

5.  On the **Update Classifications** page, specify the update classifications that you want to have approved automatically.

6.  On the **Deployment** page, do the following:

    -   Select the computer groups to which you want to deploy the new rule, and then choose **Add**.

    -   To specify an installation deadline for the updates, select the **Enforce an installation deadline for these updates** check box, and then on the **Installation deadline** list, select the installation deadline.

        > [!NOTE]
        > If you specify an installation deadline, the managed computer might require one or more restarts after the deadline interval has passed.

    -   When you are finished, Choose **Next**.

7.  On the **Summary** page, review the settings for the new rule, and then choose **Finish**.

The new rule is shown in the **Automatic Approval Rules** section of the **Service Settings: Updates** page.

> [!NOTE]
> When you create an automatic approval rule, it only approves future updates, and does not automatically approve previously existing updates that already exist in Intune. To approve these updates you need to run the automatic approval rule.


### To edit, run, or delete an automatically approved update rule

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Admin** &gt; **Updates**.

2.  In the **Automatic Approval Rules** section, select a rule, and then do one of the following:

    -   To edit the rule, choose **Edit**, and then change the rule’s parameters in the **Update Auto Approval Rule Wizard**.

    -   To run the rule, choose **Run Selected**.

    -   To delete the rule, choose **Delete**.

        > [!NOTE]
        > Deleting a rule does not affect previous updates that were approved by the deleted rule.

## Update software not made by Microsoft
You can deploy updates for software that is not made by Microsoft. You do this by using the **Upload Update** wizard to get the update into your Cloud Storage space, after which you can approve or decline the update just like with Microsoft software.

### To upload and configure a third-party update

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Updates** &gt; **Overview** &gt; **Upload**.

2.  On the **Update files** page, choose **Browse** to select the setup files that are required to install the update package. The file can be a Windows Installer (.msi) file, a Windows Installer patch (.msp) file, or a .exe program file. You can also include any additional files or folders that are in the same folder as the setup file.

    The total size of the selected files to upload is displayed. Note that this size does not include the uncompressed or expanded sizes of installation files.

3.  After you specify the setup files, the **Update description** page displays the name, description, and classification for software information that Intune extracted from the software setup files. You can select a classification to label the type of update you are deploying (Updates, Critical Updates, Security Updates, Update Rollups or Service Packs). Choose **Next** when you are done.

4.  On the **Requirements** page of the wizard, choose the architecture (32-bit, 64-bit, or both), and the operating systems of the managed computers to which this update will be applicable.

5.  On the **Detection rules** page, specify how Intune determines whether the update already exists on managed computers. If you use the default option, **Use the default detection rules**, Intune always installs the update package on each targeted computer once.

    > [!NOTE]
    > If the update setup file that you specified is a Windows Installer or .msp file, the **Detection rules** page of the wizard does not appear. This is because Windows Installer and .msp files contain their own instructions for detecting previous update installations.

    Select one or more of the following rules to determine whether the update is already installed on managed computers:

    -   **File exists**

    -   **MSI product code exists**

    -   **Registry key exists**

6.  Provide any further information that is required to configure the detection rule such as a file path and name, Windows Installer product code, or a registry key, and then choose **Next**.

7.  On the **Prerequisites** page of the wizard, you specify any software that must already be installed before this update can be installed. You can specify **None**, select a software package that has already been added to, and is managed by Intune, or you can specify one of the following rules to describe the software:

    -   **File exists**

    -   **MSI product code exists**

    -   **Registry key exists**

8.  Provide any further information that is required to configure the detection rule like a file path and name, Windows Installer product code, or a registry key, and then choose **Next**.

9. On the **Command line arguments** page of the wizard, you can add any required installation properties to the installation command line to modify the behavior of the setup file. For example, some software supports the **/q** property to enable silent installation. Refer to the documentation for your software package to learn about any supported command line arguments. Specify any command line arguments you need and then choose **Next**.

    > [!NOTE]
    > If the update does not support silent installation, you cannot install the update using Intune

10. On the **Return codes** page of the wizard, you can specify how return codes from the update installation are interpreted. By default, Intune uses industry-standard return codes to report a failed or successful installation of an update package. The supplied return codes are:

|Return code|Details|
|---------------|------------------|
|**0**|Success|
|**3010**|Success with restart|

11. Any return code that is not listed is considered a failure.
Some updates use nonstandard interpretations for return codes. In this case, you can specify your own return code interpretations.

12. Specify or edit the required return codes, and then choose **Next**.

13. On the **Summary** page of the wizard, review the actions that will be taken, and then choose **Upload** to complete the wizard.

The uploaded update is stored in your Intune cloud storage. If you have insufficient free space to upload the update package, you are notified of this during the upload process. Intune cannot determine sufficient free space until after the update upload has started, because compressed setup and installation files require more space when they are uncompressed.

After it is uploaded into Intune, a third-party update is displayed in the **Updates** workspace in the **All Updates** pane. You can then approve and deploy the update. For more information, see the following "Approve and decline updates" section.

## Approve and decline updates
When updates are ready to install, a message is shown on the **Updates Overview** page of the **Updates** workspace, under **Update Status**. Choose this message to open the **All Updates** page to see which updates are ready for approval.

You can use the **Filters** list to make it easier to find updates. For example, you can display only updates that failed, or updates that are superseded.

When you select an update from the list, further commands are available that let you manage updates as shown in the following table:

|Task|Details|
|--------|--------------------|
|**View Properties**|Displays detailed information about the update including the number of computers to which it is applicable.|
|**Edit**|For non-Microsoft updates only. Allows you to edit the properties of the update.|
|**Approve**|Approves the selected update and allows you to configure which groups is will be deployed to. For more information, see the procedure **To approve updates** in this topic.|
|**Decline**|Removes any previous approvals for the update and hides the update from the default views. Additionally, any report data for the update will be removed.<br /><br />If you later want to locate a declined update, set the filter on the **All Updates** page to **Declined**. You can then approve this update as required.<br /><br />If an update was declined because the update was expired in Microsoft Update, that update cannot be approved in the Intune administration console.<br /><br />If you delete an updates policy that is deployed to computers, the values of those updates policy settings are reset to the default state for the operating system that is installed on the computers.|
|**Delete**|For non-Microsoft updates only. Deletes the selected update.|
|**Upload**|Starts the **Upload Update** wizard that allows you to upload non-Microsoft updates that you want to deploy.|

### To approve updates

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com/), choose **Updates** &gt; **Overview** &gt; **New updates to approve**.

    In the **Updates** workspace, choose **Overview** &gt; **New updates to approve**.

    > [!NOTE]
    > The **New updates to approve** link appears in the **Updates Status** area only when there is at least one managed computer that needs an update to be approved.

2.  Select an update, review the update properties at the bottom of the page to ensure that you want to approve the update, and then choose **Approve**. You can select multiple updates by holding down the **CTRL** key as you select each item.

3.  On the **Select Groups** page, select a group that you want to deploy the updates to, and then choose **Add**. When you have finished specifying groups, choose **Next**.

4.  On the **Deployment Action** page, do the following for each group in the list:

    -   On the **Approval** list, select one of the following:

        -   **Required Install** - Installs the update on computers in the specified group.

        -   **Do Not Install** - Reports applicability only and does not install the update.

        -   **Available Install** – The user can install the application on demand from the Company Portal.

        -   **Uninstall** - Removes updates from computers in the targeted group.

            > [!IMPORTANT]
            > The update is removed even if it was not installed by Intune.

    -   On the **Deadline** list, select one of the following:

        -   **None** - Indicates that no deadline is enforced for the installation of the update and users may decline the update continually.

        -   **As soon as possible** - Installs the update at the next opportunity on targeted computers.

        -   **Custom** - Specifies the date and time that approved updates are installed.

        -   **One week**, **Two weeks**, **One month** – Installs the update within the specified time period.

5.  Choose **Finish** to save the settings, or **Cancel** to discard the settings and return to the updates list.

    > [!IMPORTANT]
    > Unless the action **Do Not Install**, **Required Install**, or **Uninstall** was explicitly configured for a child group, an action configured for a parent group is inherited by all its children.

6.  You can check the details pane at the bottom of the **All Updates** page for reminder messages about the update.


### See also
[Policies to protect Windows PCs](policies-to-protect-windows-pcs-in-microsoft-intune.md)
