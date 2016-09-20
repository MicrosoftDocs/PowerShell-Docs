---
# required metadata

title: Apple DEP management for iOS devices | Microsoft Intune
description: Deploy an enrollment profile that enrolls iOS devices purchased through the iOS Device Enrollment Program (DEP) “over the air” to manage Apple devices.
keywords:
author: NathBarn
manager: arob98
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8ff9d9e7-eed8-416c-8508-efc20fca8578

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: dagerrit
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Enroll corporate-owned Device Enrollment Program iOS devices
Microsoft Intune can deploy an enrollment profile that enrolls iOS devices purchased through the Device Enrollment Program (DEP) “over the air.” The enrollment package can include setup assistant options for the device. Devices enrolled through DEP cannot be un-enrolled by users.

## Apple DEP management for iOS devices with Microsoft Intune
To manage corporate-owned iOS devices with Apple’s Device Enrollment Program (DEP), your organization must join Apple DEP and acquire devices through that program. Details of that process are available at:  [https://deploy.apple.com](https://deploy.apple.com). Advantages of the program include hands-free set up of devices without USB-connecting each device to a computer.

Before you can enroll corporate-owned iOS devices with DEP, you need a DEP Token from Apple. This token allows Intune to sync information about DEP-participating devices owned by your corporation. It also permits Intune to perform Enrollment Profile uploads to Apple and to assign devices to those profiles.

1.  **Start managing iOS devices with Microsoft Intune**
    Before you can enroll iOS Device Enrollment Program (DEP) devices, you must complete enable iOS management for Intune.

2.  **Get an Encryption Key**
    As an administrative user, open the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Admin** &gt; **Mobile Device Management** &gt; **iOS** &gt; **Device Enrollment Program**, and click **Download Encryption Key**. Save the encryption key (.pem) file locally. The .pem file is used to request a trust-relationship certificate from the Apple Device Enrollment Program portal.

      ![Update a device enrollment program token](../media/dev-sa-ios-dep.png)

3.  **Get a Device Enrollment Program token**
    Go to the [Device Enrollment Program Portal](https://deploy.apple.com) (https://deploy.apple.com) and sign in with your company Apple ID. This Apple ID must be used in future to renew your DEP token.

    1.  In the [Device Enrollment Program Portal](https://deploy.apple.com) portal, go **Device Enrollment Program** &gt; **Manage Servers**, and then click **Add MDM Server**.

    2.  Enter the **MDM Server Name** and then click **Next**. The server name is for your reference to identify the MDM server. It is not name or URL of the Microsoft Intune server.

    3.  The **Add &lt;ServerName&gt;** dialog box opens. Click **Choose File…** to upload the .pem file and then click **Next**.

    4.  The **Add &lt;ServerName&gt;** dialog box displays a **Your Server Token** link. Download the server token (.p7m) file to your computer, and then click **Done**.

    This certificate (.p7m) file is used to establish a trust relationship between Intune and Apple’s Device Enrollment Program servers.

4.  **Add the DEP token to Intune**
    In the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Admin** &gt; **Mobile Device Management** &gt; **iOS** &gt; **Device Enrollment Program**, and click **Upload the DEP Token**. **Browse** to the certificate (.p7m) file, enter your **Apple ID**, and click **Upload**.

5.  **Add the Corporate Device Enrollment Policy**
    In the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Policy** &gt; **Corporate Device Enrollment** and then click **Add**.

    Provide **General** details including **Name** and **Description**, specify whether devices assigned to the profile have user affinity or belong to a group.
      - **Prompt for user affinity**: The device must be affiliated with a user during initial setup and could then be permitted to access company data and email as that user.  **User affinity** should be configured for DEP-managed devices that belong to users and need to use the company portal (i.e. to install apps). **Note:** DEP devices with user affinity cannot support multifactor authentication.
      - **No user affinity**: The device is not affiliated with a user. Use this affiliation for devices that perform tasks without accessing local user data. Apps requiring user affiliation, including the Company Portal app used for installing line-of-business apps, won’t work.

    You can also **Assign devices to the following group**. Click **Select...** to choose a group.

    [!INCLUDE[groups deprecated](../includes/group-deprecation.md)]

    Next, enable **Configure Device Enrollment Program settings for this policy** to support DEP.

      ![Setup assistant pane](../media/pol-sa-corp-enroll.png)

     The following settings are available for DEP-managed devices:

     - **Department** - Appears when users tap "About Configuration" during activation
     - **Support phone number** - Displayed when the user clicks the **Need Help** button during activation
     - **Preparation mode** - This state is set during activation and cannot be changed without factory resetting the device:
        - **Unsupervised** - Limited management capabilities
        - **Supervised** - Enables more management options and disables Activation Lock by default
     - **Lock enrollment profile to device** - This state is set during activation and cannot be changed without a factory reset
        - **Disable** - Allows the management profile to be removed from the **Settings** menu
        - **Enable** - (Requires **Preparation Mode** = **Supervised**) Disables iOS settings that could allow removal of the management profile
     - **Setup Assistant Options** - These settings are optional and can be configured later in the iOS **Settings** menu
        - **Passcode** - Prompt for passcode during activation. Always require a passcode unless the device will be secured or have access controlled in some other manner (i.e. kiosk mode that restricts the device to one app).
        - **Location Services** - If enabled, Setup Assistant prompts for the service during activation
        - **Restore** - If enabled, Setup Assistant prompts for iCloud backup during activation
        - **Apple ID** - An Apple ID is required to download iOS App Store apps, including those installed by Intune. If enabled, iOS will prompt users for an Apple ID when Intune attempts to install an app without an ID.
        - **Terms and Conditions** - If enabled, Setup Assistant prompts users to accept Apple's terms and conditions during activation
        - **Touch ID** - If enabled, Setup Assistant prompts for this service during activation
        - **Apple Pay** - If enabled, Setup Assistant prompts for this service during activation
        - **Zoom** - If enabled, Setup Assistant prompts for this service during activation
        - **Siri** - If enabled, Setup Assistant prompts for this service during activation
        - **Send diagnostic data to Apple** - If enabled, Setup Assistant prompts for this service during activation
     -  **Enable additional Apple Configurator management** - Set to **Disallow** to prevent syncing files with iTunes or management via Apple Configurator. Microsoft recommends you set to **Disallow**, export any further configuration from Apple Configurator, and then deploy as a Custom iOS configuration profile via Intune, rather than use this setting to allow manual deployment with or without a certificate.
        - **Disallow** - Prevents the device from communicating via USB (disables pairing)
        - **Allow** - Allows device communicate via USB connection for any PC or Mac
        - **Require certificate** - Allows pairing with a Mac with a certificate imported to the enrollment profile

6.  **Assign DEP Devices for Management**
    Go to the [Device Enrollment Program Portal](https://deploy.apple.com) (https://deploy.apple.com) and sign in with your company Apple ID. Go **Deployment Program** &gt; **Device Enrollment Program** &gt; **Manage Devices**. Specify how you will **Choose Devices**, provide device information and specify details by device **Serial Number**, **Order Number**, or **Upload CSV File**. Next, select **Assign to Server** and select the &lt;ServerName&gt; specified for Microsoft Intune, and then click **OK**.

7.  **Synchronize DEP-Managed Devices**
    As an administrative user, open the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Admin** &gt; **Mobile Device Management** &gt; **iOS** &gt; **Device Enrollment Program**, and click **Sync now**. A sync request is sent to Apple. To see DEP-managed devices after synchronization, in the [Microsoft Intune administration console](http://manage.microsoft.com) go **Groups** &gt; **All Devices** &gt; **Corporate Pre-enrolled devices** &gt; **By iOS Serial Number**. In the **By iOS Serial Number** workspace, the **State** for managed devices reads “Not contacted” until the device is powered on and runs the Setup Assistant to enroll the device.

    To comply with Apple’s terms for acceptable DEP traffic, Intune imposes the following restrictions:
     -	A full DEP sync can run no more than once every 7 days. During a full sync, Intune refreshes every serial number Apple has assigned to Intune whether the serial has previously been synced or not. If a full sync is attempted within 7 days of the previous full sync, Intune only refreshes serial numbers not already listed in Intune.
     -	Any sync request is given 10 minutes to complete. During this time or until the request succeeds, the Sync button is disabled.

8.  **Distribute devices to users**
    Your corporate-owned devices can now be distributed to users. When an iOS device is turned on it will be enrolled for management by Intune.

## Changes to Intune group assignments

Starting in November, device group management will move to Azure Active Directory. After the transition to Azure Active Directory groups, group assignment will not appear in the **Corporate Enrollment Profile** options. Because this change will roll out over a series of months, you might not see the change right away. After moving to the new portal, dynamic device group assignments can be defined based on the Corporate Enrollment Profile names. This process ensures that devices pre-assigned to a device group will automatically enroll in the group with policy and apps deployed. [Learn more about Azure Active Directory groups](https://azure.microsoft.com/documentation/articles/active-directory-accessmanagement-manage-groups/)

### See also
[Get ready to enroll devices](get-ready-to-enroll-devices-in-microsoft-intune.md)
