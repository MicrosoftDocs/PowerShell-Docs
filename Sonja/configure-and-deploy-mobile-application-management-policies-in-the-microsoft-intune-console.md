---
# required metadata

title: Configure MAM policies in the Intune console | Microsoft Intune
description: Mobile application management policies in Microsoft Intune let you modify the functionality of apps that you deploy to help align them with your company's compliance and security policies.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/06/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: b4fb33a8-a2fa-4353-bd89-5bda48b68e83

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure and deploy mobile application management policies in the Microsoft Intune console
Mobile application management (MAM) policies in Microsoft Intune let you modify the functionality of apps that you deploy to help align them with your company's compliance and security policies. For example, you can restrict cut, copy, and paste operations within a managed app, or configure an app to open all web links inside a managed browser.

Mobile application management policies support:

-   Devices that run Android 4 and later.

-   Devices that run iOS 8.0 and later.

> [!TIP]
> Mobile application management policies support devices that are enrolled with Intune.
>
> If you are looking for information about how to create app management policies for devices that Intune doesn't manage, see [Protect app data using mobile app management policies with Microsoft Intune](protect-app-data-using-mobile-app-management-policies-with-microsoft-intune.md).

Unlike other Intune policies, you do not deploy a mobile application management policy directly. Instead, you associate the policy with the app that you want to restrict. When the app is deployed and installed on devices, the settings that you specify will take effect.

To apply restrictions to an app, the app must incorporate the Microsoft Intune App SDK. There are three methods of obtaining this type of app:

-   **Use a policy managed app**. A policy managed app has the App SDK built in. To add this type of app, you specify a link to the app from an app store such as the iTunes store or Google Play. No further processing is required for this type of app. For more information, see the [list of apps that you can use with Microsoft Intune mobile application management policies](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx).

-   **Use a wrapped app**. A wrapped app is an app that you repackage to include the App SDK by using the Microsoft Intune App Wrapping Tool. This tool is typically used to process company apps that were created in house. You can't use it to process apps that were downloaded from the app store. For more information, see [Prepare iOS apps for mobile application management with the Microsoft Intune App Wrapping Tool](prepare-ios-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md) and [Prepare Android apps for mobile application management with the Microsoft Intune App Wrapping Tool](prepare-android-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool.md).

- **Write your own app that incorporates the Intune App SDK**. The Intune App SDK lets you incorporate app management features into an app while you are writing it. For more information, see [Intune App SDK Overview](/intune/develop/intune-app-sdk).

For help choosing between the App Wrapping Tool and the Intune App SDK, see [Decide how to prepare apps for mobile application management with Microsoft Intune](decide-how-to-prepare-apps-for-mobile-application-management-with-microsoft-intune.md).

Some managed apps, like the Outlook app for iOS and Android, support *multi-identity*. This means that Intune applies management settings only to corporate accounts or data in the app.

For example, using the Outlook app:

-   If the user configures a corporate email account and a personal email account, Intune applies management settings only to the corporate account and does not manage the personal account.

-   If the device is retired or unenrolled, only the corporate Outlook data is removed from the device.

-   The corporate account must be the same account that was used to enroll the device with Intune.

> [!TIP]
> If you are using Intune with Configuration Manager, see [How to Control Apps Using Mobile Application Management Policies in Configuration Manager](https://technet.microsoft.com/library/mt131414.aspx).

## Create and deploy an app with a mobile application management policy

-   **Step 1:** Get the link to a policy managed app, create a wrapped app, or use the Intune App SDK to write a MAM-enabled app.

-   **Step 2:** Publish the app to your cloud storage space.

-   **Step 3:** Create a mobile application management policy.

-   **Step 4:** Associate the app with a mobile application management policy, and then deploy the app.

-   **Step 5:** Monitor the app deployment.

## Step 1: Get the link to a policy managed app, create a wrapped app, or use the Intune App SDK to write a MAM-enabled app

From the app store, find and note the URL of the policy managed app that you want to deploy. For example, the URL of the Microsoft Word for iPad app is **https://itunes.apple.com/us/app/microsoft-word-for-ipad/id586447913?mt=8**.


## Step 2: Publish the app to your cloud storage space
When you publish a managed app, the procedures differ depending on whether you are publishing a policy managed app or an app that was processed by using the the Microsoft Intune App Wrapping Tool for iOS.

#### To publish a policy managed app

1.  When you are ready to upload the app to your cloud storage space, follow the instructions in [Add apps for mobile devices in Microsoft Intune](add-apps-for-mobile-devices-in-microsoft-intune.md).

2.  For iOS apps, select **Managed iOS App from the App Store** under **Select how this software is made available to devices**.

    For Android apps, select **External link**.

3.  Under **Specify the URL**, enter the URL to the policy managed app that you noted earlier.

After the upload finishes, you will see **Yes** for **App Management Policies** on the **Software Properties** page for the uploaded app.

After you have verified that the app is uploaded successfully, continue to step 3.

#### To publish an app that was processed through the Microsoft Intune App Wrapping Tool

1.  When you are ready to upload the app to your cloud storage space, follow the instructions in [Add apps for mobile devices in Microsoft Intune](add-apps-for-mobile-devices-in-microsoft-intune.md).

2.  Select **Software Installer** under **Select how this software is made available to devices**.

3.  Select **App package for iOS (&#42;.ipa file)** under **Software installer file type**.

After the upload finishes, you will see **Yes** for **App Management Policies** on the **Software Properties** page for the uploaded app.

After you have verified that the app is uploaded successfully, continue to step 3.

## Step 3: Create a mobile application management policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Overview** &gt; **Add Policy**.

2.  Configure and deploy one of the following **Software** policies, depending on the device type that you want to configure apps for:

    -   **Mobile Application Management Policy (Android 4 and later)**

    -   **Mobile Application Management Policy (iOS 8.0 and later)**

    You can use recommended settings or customize the settings. For details, see [Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).

3.  Configure the following settings as required. The options might differ depending on the device type for which you are configuring the policy.

|Setting name|Details|
    |---------|--------------------|
    |**Name**|Specify a name for this policy.|
    |**Description**|Optionally, specify a description for this policy.|
    |**Restrict web content to display in a corporate managed browser**|When this setting is enabled, any links in the app will be opened in the managed browser. For this option to work, you must have deployed this app to devices.|
    |**Prevent Android backups** or **Prevent iTunes and iCloud backups**|This setting disables the backup of any information from the app.|
    |**Allow app to transfer data to other apps**|This setting specifies the apps that this app can send data to. You can choose to not allow data transfer to any app, allow transfer only to other managed apps, or allow transfer to any app. <br /><br />For example, when you do not allow data transfer, you restrict data transfer to services like SMS messaging, assigning images to contacts, and posting to Facebook or Twitter.<br /><br />For iOS devices, to prevent document transfer between managed and unmanaged apps, you must also configure and deploy a mobile device security policy that disables the setting **Allow managed documents in other unmanaged apps**. If you choose to allow transfer only to other managed apps, the Intune PDF and image viewers (if deployed) will be used to open content of the respective types.<br /><br />Additionally, if you set this option to **Policy Managed Apps** or **None**, the iOS 9 feature that allows Spotlight Search to search data within apps will be blocked.<br><br>This setting does not control the use of the Open In feature on mobile devices. To manage Open In, see [Manage data transfer between iOS apps with Microsoft Intune](manage-data-transfer-between-ios-apps-with-microsoft-intune.md).|
    |**Allow app to receive data from other apps**|This setting specifies the apps that this app can receive data from. You can choose to not allow data transfer from any app, allow transfer only from other managed apps, or allow transfer from any app.<br /><br />When a user accesses data from an app that is not managed by a mobile application management policy, the data will be treated as corporate data and protected by the policy. This applies to iOS apps that support multi-identity (where Intune applies management settings only to corporate accounts or data in the app). Or, this applies to an enrolled device with a mobile application management policy applied.|
    |**Prevent “Save As”**|This setting disables use of the **Save As** option to save data to personal cloud storage locations (such as OneDrive or Dropbox) in any app that uses this policy.|
    |**Restrict cut, copy and paste with other apps**|This setting specifies how cut, copy, and paste operations can be used with the app. Choose from:<br /><br />**Blocked**. Do not allow cut, copy, and paste operations between this app and other apps.<br /><br />**Policy Managed Apps**. Allow cut, copy, and paste operations only between this app and other managed apps.<br /><br />**Policy Managed Apps with Paste In**. Allow data cut or copied from this app to be pasted only into other managed apps. Allow data cut or copied from any app to be pasted into this app.<br /><br />**Any App**. Put no restrictions on cutting, copying, and pasting operations to or from this app.<br /><br />To copy and paste data between managed apps, both apps must have either the **Policy Managed Apps** or **Policy Managed Apps with Paste In** setting configured.|
    |**Require simple PIN for access**|This setting requires the user to enter a PIN that they specify to use this app. The user will be asked to set this up the first time they run the app.|
    |**Number of attempts before PIN reset**|Specify the number of PIN entry attempts that can be made before the user must reset the PIN.|
    |**Require corporate credentials for access**|This setting requires the user to enter their corporate logon information before they can access the app.|
    |**Require device compliance with corporate policy for access**|This setting allows the app to be used only when the device is not jailbroken or rooted.|
    |**Recheck the access requirements after (minutes)**|In the **Timeout** field, specify the time period before the access requirements for the app are rechecked after the app is opened.|
    |**Offline grace period**|If the device is offline, specify the time period before the access requirements for the app are rechecked.|
    |**Encrypt app data**|This setting specifies that all data associated with this app will be encrypted. This includes data stored externally, such as in SD cards.<br /><br />**Encryption for iOS**<br /><br />For apps that are associated with an Intune mobile application management policy, data is encrypted at rest through device-level encryption that the OS provides. This is enabled through a device PIN policy that the IT admin sets. When a PIN is required, the data will be encrypted according to the settings in the mobile application management policy. As stated in Apple documentation, [the modules that iOS uses are FIPS 140-2 certified](http://support.apple.com/en-us/HT202739).<br /><br />**Encryption for Android**<br /><br />For apps that are associated with an Intune mobile application management policy, Microsoft provides encryption. Data is encrypted synchronously during file I/O operations.  Content on the device storage will always be encrypted. The encryption method is not FIPS 140-2 certified.|
    |**Block screen capture** (Android devices only)|This setting specifies that the screen capture capabilities of the device are blocked when someone is using this app.|
    
4. When you are finished, choose **Save Policy**.

The new policy appears in the **Configuration Policies** node of the **Policy** workspace.

## Step 4: Associate the app with a mobile application management policy, and then deploy the app
Ensure that you select the mobile application management policy on the **Mobile App Management** page of the **Manage Deployment** dialog box to associate the policy with the app.

For details, see [Deploy apps in Microsoft Intune](deploy-apps.md).

> [!IMPORTANT]
> If the device is unenrolled from Intune, polices are not removed from the apps. Any apps that had policies applied will retain the policy settings after the app is uninstalled and reinstalled.

### What to do when an app is already deployed on devices
There might be situations where you deploy an app and one of the targeted users or devices already has an unmanaged version of the app installed. For example, the user might have installed Microsoft Word from the app store.

In this case, you must ask the user to manually uninstall the unmanaged version so that the managed version that you configured can be installed.

However, for devices that run iOS 9 and later, Intune will automatically ask the user for permission to take over management of the existing app. If they agree, then the app will become managed by Intune and any mobile application management policies that you associated with the app will also be applied.

> [!TIP]
> If the device is in supervised mode, Intune will take over management of the existing app without asking the user's permission.

## Step 5: Monitor the app deployment
After you have created and deployed an app that's associated with a mobile application management policy, use the following procedure to monitor the app and resolve any policy conflicts.

#### To view the status of the deployment

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Groups** &gt; **Overview**.

2.  Perform one of the following steps:

    -   Choose **All Users**, and then double-click the user whose device you want to examine. One the **User Properties** page, choose **Devices**, and then double-click the device that you want to examine.

    -   Choose **All Devices** &gt; **All Mobile Devices**. On the **Device Group Properties** page, choose **Devices**, and then double-click the device that you want to examine.

3.  From the **Mobile Device Properties** page, choose **Policy** to see a list of the mobile application management policies that have been deployed to the device.

4.  Select the mobile application management policy whose status you want to view. You can view details of the policy in the bottom pane and expand its node to display its settings.

5.  Under the **Status** column of each of the mobile application management policies, **Conforms**, **Conforms (Pending)**, or **Error** will appear. If the selected policy has one or more settings in conflict, **Error** will appear in this field.

6.  After you have identified a conflict, you can revise conflicting policy settings to use the same setting, or you can deploy only one policy to the app and user.

### How policy conflicts are resolved
When there is a mobile application management policy conflict on the first deployment to the user or device, the specific setting value in conflict will be removed from the policy deployed to the app. The app will use a built-in conflict value.

When there is a mobile app management policy conflict on later deployments to the app or user, the specific setting value in conflict will not be updated on the mobile app management policy deployed to the app. The app will use the existing value for that setting.

In cases where the device or user receives two conflicting policies, the following behavior applies:

-   If a policy has already been deployed to the device, the existing policy settings are not overwritten.

-   If no policy has already been deployed to the device, and two conflicting settings are deployed, the default setting built into the device is used.
