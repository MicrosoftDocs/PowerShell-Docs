---
# required metadata

title: Previous releases | Microsoft Intune
description:
keywords:
author: Lindavr
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 45dad14a-d412-488d-bb1e-ad990ea503df

# optional metadata

ROBOTS: noindex,nofollow
#audience:
#ms.devlang:
#ms.reviewer:
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Previous Intune releases
## August 2016
## August 2016
## App management
<!---@Barry, I created the buckets of App management, Device management, etc but am not tied to them. Just wanted to break up and organize the feature list. If you're going to take over the Company Portal section, please talk to Stacie about how she's been organizing it. --->

### Hidden and shown apps for iOS 9.3
For supervised devices running iOS 9.3 or later, you can use the hidden and shown apps list in the iOS general configuration policy to:
- Specify a list of apps that will be hidden from users. Users cannot view, or launch these apps.
- Specify a list of apps that users can view and launch. No other apps can be viewed or launched.

The apps you can specify include both apps you have deployed, and the built-in iOS apps like Messages and Notes. For details, see [iOS policy settings in Microsoft Intune]( https://docs.microsoft.com/intune/deploy-use/ios-policy-settings-in-microsoft-intune)
<!---TFS 1279009 checked--->
### Allowed and blocked apps policy for Samsung KNOX devices
You can now configure a custom policy for Samsung KNOX devices that lets you create one of the following:
- A list of apps that are blocked from running on the device. Even if installed, an app defined in the blocked list cannot be activated on the device.
- A list of apps that users of the device are allowed to install from the Google Play store. No other apps can be installed from the store.

These settings can only be used by devices that run Samsung KNOX.
For details, see [Use custom policies to allow and block apps for Samsung KNOX devices]( custom-policy-to-allow-and-block-samsung-knox-apps.md).
<!---TFS 1311629 checked --->
### New apps compatible with mobile application management (MAM) policies
The Yammer app for [iOS](https://itunes.apple.com/app/yammer/id289559439?mt=8) and [Android](https://play.google.com/store/apps/details?id=com.yammer.v1) is now compatible with [Intune mobile application management (MAM) policies](/intune/deploy-use/protect-app-data-using-mobile-app-management-policies-with-microsoft-intune), whether or not the device is enrolled.

For a full list of MAM compatible apps, see the [Microsoft Intune application partners](https://www.microsoft.com/en-us/cloud-platform/microsoft-intune-partners) site.
<!--- TFS 1252335 & 1252336 checked--->


<!--- I started putting TFS numbers in the What's Coming topic and found it helpful when updating the What's New. Up to you if you want to continue. --->

### Intune Viewer apps
With the release of the new RMS sharing app, we are removing the following Intune Viewer apps, beginning in August, 2016:
- Intune AV Viewer
- Intune PDF Viewer
- Intune Image Viewer for Android from Google Play

Instead of using the Intune Viewer apps, we recommend using the new [Rights Management app (RMS sharing) for Android](https://docs.microsoft.com/en-us/intune/deploy-use/end-user-experience-for-mam-enabled-apps-with-microsoft-intune#viewing-media-files-with-the-rights-management-sharing-app), which allows you to deploy one app instead of three separate apps to securely view corporate files on Android devices. When the Intune viewer app is no longer supported, it will be removed from the Google Store and will not be available for future use.

## Device management
### Android 7.0 support
Intune provides “day 0” support for the forthcoming Android 7.0 operating system for mobile devices.
<!---TFS 1262053--->
### Google removal of remote passcode reset capability on Android 7.0 devices
Google is removing the ability of IT administrators and end users to remotely reset the passcode of Android 7.0 devices. Previously, IT administrators could remotely reset a user’s passcode, and end users could reset their passcodes from the Company Portal website.



## Company Portal updates
### Company Portal website
- **Feedback link from the Company Portal to Microsoft** <br/>
The Company Portal website enables end users to tap a new "Feedback" link, at the bottom of the page, to send feedback to Microsoft about their experience with the site. The collected, anonymized feedback will help Microsoft improve the Company Portal website experience for users.
<!--- TFS 1313657 checked--->

### iOS
- **Minimum iOS Managed Browser version updated to 8.0**<br/>
The Microsoft Intune Managed Browser app for iOS has been updated to support devices running iOS 8.0 or later. While iOS 7.1 devices can still use the existing Managed Browser app, encourage your users to update to iOS 8.0 or later to access and take full advantage of new Managed Browser features.  
<!---TFS 1313253 checked--->

## What's coming

### iOS 10 support
Intune will fully support iOS 10. More information will follow the iOS 10 public release.

### Intune Groups transitioning to Azure Active Directory Groups beginning in September 2016
Intune is creating a new group management experience that uses Azure Active Directory (AAD) security groups as user and device groups in Intune. These groups will be used for all group management, policy deployment, and profile deployment **when we introduce the new Azure-based Intune admin portal**.

This new experience will keep you from having to duplicate groups between services, **allow you access to some new Azure Active Directory Premium (AADP) group features**, and provide extensibility using PowerShell and Graph. This will also unify the group management experience across enterprise mobility management.

To enable the move to Security Groups, the experience in the **current admin console** will undergo some modifications. **These changes, and the use of AAD security groups, will be recorded in the Intune documentation**.

Customers who are new to Intune will see **some of the security group changes before current tenants do**.

In addition to changes in group management, **the following functionality will be deprecated**:
- Excluding members or groups while creating a new group
- **Ungrouped Users** and **Ungrouped Devices** groups
- **Manage Groups** in the Service Admin role
- Custom group-based alerts for Notification Rules
- Pivoting with groups in reports
<!--- TFS 1295329--->

### Addition of 'Notifications' to the Company Portal for Android
We are releasing an update to the Company Portal for Android in September that will introduce a new **Notifications** icon on the homepage. Tapping this icon will access the **Notifications** page that will show your end user all the items that require attention in the Company Portal app such as device non-compliance, enrollment update, and enrollment activation. If you also use the iOS Company Portal app, you’ll already see the notifications experience. With the introduction of the **Notifications** page, you will not see the **Company Access Setup** page every time you launch or resume the Company Portal for Android as long as the device is already enrolled. We hear many of you have created end-user guidance and appreciate advanced notice when your guidance/screen shots may need updating. Please update your documentation to reflect the upcoming change in experience. Find updated screenshots here: https://aka.ms/androidcpupdate.  

### Improvements in how iOS end users get their apps
The following changes are being made in September to the apps tiles in the Company Portal app for iOS to point users to different views in a single location, the Company Portal website, for all of their apps. Currently, Apple restrictions prohibit line-of-business and managed app store apps from being listed in the Company Portal app, and require users to visit different views to find all of their apps.

- The **Company Apps** tile currently points to a list of all apps in the ALL tab of the Company Portal website, and it will continue to work the same way. The tile name will change to **All Apps**.
- The **Other Apps** tile currently points to a view, inside the Company Portal app, that lists all apps that Apple permits the Company Portal app to show. The tile name will change to **Featured Apps**, and tapping the tile will take users to the FEATURED tab of the Company Portal website.
-  The **Categories** tile currently points to a view, inside the Company Portal app, that lists categories of apps. The tile name will not change, but it will now point to the CATEGORIES tab of the Company Portal website. You can find updated screenshots [here](https://gallery.technet.microsoft.com/Improvements-in-how-iOS-d1104186).
<!---TFS 1317133--->

### Cloud roadmap
Keep informed about upcoming developments for Intune with the [Cloud Platform roadmap](http://www.microsoft.com/en-us/server-cloud/roadmap/Indevelopment.aspx?TabIndex=0&dropValue=Intune).

### Service deprecation
<!---@Barry, we started listing service deprecations earlier this summer. --->
- **Changes in support for the iOS Company Portal app**<br/>
In September, all users of the Microsoft Intune Company Portal app for iOS will be required to use its latest version. New users will only be able to download the latest version and current users will be required to update to it. The latest version requires iOS 8.0 or later, so devices running older iOS versions won’t be able to use the Company Portal or enroll until they update their device to iOS 8.0 or later and then update the Company Portal app to the latest version. Enrolled devices running versions below iOS 8.0 will continue to be managed and listed in the Intune Admin Console.  

- **Minimum iOS Managed Browser version updated to 8.0**<br/>
In August, Intune will release an updated Microsoft Intune Managed Browser app for iOS that will only support devices running iOS 8.0 or later. While iOS 7.1 devices will still be able to use the existing Managed Browser app, please encourage your users to update to iOS 8.0 or later to access and take full advantage of new Managed Browser features.  
<!---TFS 1313253--->

- **Company Portal apps for Windows 8 and Windows Phone 8 are being deprecated** <br/>
Starting in October 2016, Microsoft Intune will deprecate support for Windows 8 and Windows Phone 8 Company Portal apps. Microsoft Intune will also deprecate support for the Windows Phone 8 platform. As a consequence, you will not be able to enroll or update any Windows Phone 8 devices. You can continue to manage Windows Phone 8 and Windows 8 devices that are already enrolled. Update Windows Phone 8 and Windows 8 devices to Windows 8.1 and Windows Phone 8.1, and use the corresponding Windows 8.1 and Windows Phone 8.1 Company Portal apps to continue distributing apps to these devices without disruptions.
<!---TFS 1255391--->

<!--- - **Custom Group Targeting of Notification Rules Removal.**<br/>
Intune notification rules define who an email alert will be sent to from Intune. Currently, you can configure notification rules to send emails to all users of devices in an Intune device group that you created. From around June 1st 2016 moving forward, targeting user-created groups will no longer be supported.

	Today, to target a notification rule to a group you created from the Microsoft Intune administration console, you would take the following steps:

	In the **Admin** workspace, click **Notification Rules** > **Create New Rule**

	In step two of the Create Notification Rule Wizard, select the device groups which the rule will target. This step, “select device groups”, is being removed from the Intune Console.

	The preliminary timeline for this change is as follows:
	- In August, 2016, new tenants will not see step two of the Create Notification Rule Wizard. Exiting tenants are unaffected.
	- Around September, 2016, some existing tenants will not see the “select device groups” in the wizard.
	- Around November, 2016, we expect that all tenants will not see the “select device groups” in the wizard.

--->

## July 2016
### App management
#### Improve the app provisioning profile update experience
Apple iOS line of business mobile apps are built with a provisioning profile included and code signed with a certificate. When the app runs on an iOS device, iOS confirms the integrity of the iOS app and enforces policies defined by the provisioning profile.

The enterprise signing certificate you use to sign apps typically lasts for 3 years. However, the provisioning profile expires after 1 year. With this update, Intune gives you the tools to proactively deploy a new provisioning profile policy to devices that have apps that are near expiry while the certificate is still valid. For more information, see [Use iOS mobile provisioning profile policies to keep your line of business apps up to date](/intune/deploy-use/ios-mobile-app-provisioning-profiles).
<!--- TFS 1280247--->
#### Xamarin SDK for Intune apps is available
The Intune App SDK Xamarin component allows you to enable the Intune mobile app management features in your mobile iOS and Android apps built with Xamarin. You can find the component in the [Xamarin store](https://components.xamarin.com/view/Microsoft.Intune.MAM) or on the [Microsoft Intune Github page](https://github.com/msintuneappsdk).
<!--- TFS 1061478 --->

### Device management
#### Increased device enrollment limits
Intune increased the maximum configurable device enrollment limit from 5 to 15 devices per user.
<!---TFS 1289896 --->

#### TeamViewer Integration for Windows PCs running the Intune client software
[TeamViewer](https://www.teamviewer.com) integration for Windows PCs that run the Intune client lets you establish remote assistance sessions with Windows PCs to help support end-user helpdesk departments. This includes Windows 7, 8, 8.1 and Windows 10. For details, see [Common Windows PC management tasks with the Microsoft Intune computer client](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client.md).
<!---TFS 1284856--->

### Company Portal updates
#### Company Portal website
- **Improved end-user experience when enrolling Windows devices**<br/>
When you are using conditional access, the enrollment steps for Windows 8.1, Windows 10 Desktop, and Windows 10 Mobile have been clarified in the Company Portal website. Users will now see separate “Device enrollment” and “Workplace Join” steps, making it easier for them to see the status of their device and to complete the process if they experience a Workplace Join (WPJ) failure. The separate steps are also expected to simplify the troubleshooting process for IT administrators. Previously, when end users tried to enroll and all enrollment steps succeeded except for WPJ, the enrolled device would not appear on the list of devices for users to identify, causing confusion for users.

#### Android
- **Android Company Portal app**<br/>
If Android end users see an error message that says their device is missing a required certificate, they can tap a "How to resolve this" button to get [steps](/intune/enduser/your-device-is-missing-a-required-certificate-android#your-device-is-missing-a-certificate-required-by-your-it-administrator) for installing the missing certificate. If users complete the steps, but see an additional "missing certificate" error message, they are asked to contact their IT administrator and provide this [link](/intune/troubleshoot/troubleshoot-device-enrollment-in-intune#android-certificate-issues), which contains steps that IT administrators can use to fix the certificate issue.

- **Restrict side-loaded app installations to enrolled devices**<br/>
Android devices can no longer install applications through the Company Portal website unless the devices have been enrolled in Intune by using the Intune Company Portal app for Android.
<!---TFS 1299082--->

#### iOS
- **Changes to Device Enrollment Managers accounts in the iOS Company Portal app**<br/>
To improve performance and scale, Intune no longer displays all Device Enrollment Managers (DEM) devices in the **My Devices** pane of the iOS Company Portal app. Only the local device running the app is displayed, and only if it is enrolled via the Company Portal app.

The DEM user may perform actions on the local device, but remote management of other enrolled devices can only be performed from the Intune admin console. Additionally, Intune is deprecating use of DEM accounts with either the Apple Device Enrollment Program or the Apple Configurator tool. Both these enrollment methods already support user-less enrollment for shared iOS devices.

Only use DEM accounts when user-less enrollment for shared devices is unavailable. For more information, see [Enroll corporate-owned devices with the Device Enrollment Manager in Microsoft Intune](https://docs.microsoft.com/en-us/intune/deploy-use/enroll-corporate-owned-devices-with-the-device-enrollment-manager-in-microsoft-intune).
<!---TFS 1233681--->

### Change of names for Windows features
- [Microsoft Passport for Windows](control-microsoft-passport-settings-on-devices-with-microsoft-intune.md) is now known as **Windows Hello for Business**.
- [Enterprise data protection](https://technet.microsoft.com/itpro/windows/keep-secure/create-edp-policy-using-intune) is now known as **Windows Information Protection**.

## June 2016
### Intune service health
Service health information for Intune has been moved to a central location with other Microsoft services. You'll now find this information in the Office 365 management portal under Service Health. For more information, see [this blog post](https://blogs.technet.microsoft.com/enterprisemobility/2016/04/28/intune-service-health-is-now-available-in-the-office-365-portal/).

### App management
- **Enhanced Windows 10 enterprise data policy configuration experience.** We have made enhancements to the Windows 10 enterprise data protection policy configuration experience around creating app rules, specifying network boundary definition, and other enterprise data protection settings. To learn more, see [Create an enterprise data protection (EDP) policy using Microsoft Intune](https://technet.microsoft.com/itpro/windows/keep-secure/create-edp-policy-using-intune).


### Device management
- **Windows Defender policy setting to protect against potentially unwanted apps.** A new Windows Defender setting named **Potentially Unwanted Application Detection** has been added to the general configuration policy for Windows 10 Desktop and Mobile. You can use this setting to protect enrolled Windows desktop computers against running software classed by Windows Defender as potentially unwanted. You can protect against these applications running, or use audit mode to report when a potentially unwanted application is installed. See [Windows 10 policy settings in Microsoft Intune](https://docs.microsoft.com/en-us/intune/deploy-use/windows-10-policy-settings-in-microsoft-intune) for more information.
<!---TFS 1244478--->

### Conditional access
- **Cisco ISE network access control policy for Intune.**  Customers who use the Cisco Identity Service Engine (ISE) 2.1 and also use Microsoft Intune can set a network access control policy in ISE.

	Using this policy, devices that need to connect to the network using WiFi or VPN must meet following conditions before they are allowed access:

	* Must be managed by Intune
	* Must be compliant with any deployed Intune compliance policies

 End users of noncompliant devices will be prompted to enroll, and remediate any compliance issues to gain access.
- **Conditional access for browser.** You can set a conditional access policy for [Exchange Online](restrict-access-to-exchange-online-with-microsoft-intune.md) and [SharePoint Online](restrict-access-to-sharepoint-online-with-microsoft-intune.md) so that they can only be accessed from supported web browsers on managed and compliant iOS and Android devices. End users who try to sign in to Outlook Web Access (OWA) and SharePoint sites with iOS and Android devices will be prompted to enroll their device with Intune as well as to fix any non-compliance issues before they can complete sign-in.
<!---TFS 1175844--->

- **Dynamics CRM Online supports conditional access.** You can set a conditional access policy for [Dynamics CRM Online](restrict-access-to-dynamics-crm-online-with-microsoft-intune.md) so that it can only be accessed by managed and compliant iOS and Android devices. End users who try to sign in to the Dynamics CRM mobile app on iOS and Android will be prompted to enroll with Intune as well as remediate any non-compliance issues before sign-in can complete.
<!---TFS1295358--->

##E Company Portal updates

#### Android Company Portal app

- When IT administrators apply the new "Require that devices disallow installation of apps from unknown sources (Android 4.0+)" policy, end users with Android 4.0 or later devices will see the message, "Installation from Unknown sources must be disabled." Users will need to go to  **Settings** > **Security**, and turn off **Unknown sources**. A link in the compliance message lets users get more [information](/Intune/EndUser/you-are-asked-to-turn-off-unknown-sources-android) about the message and why they are being required to turn off the setting.

- When IT administrators apply the new "Require that devices have enabled scanning of apps for security threats (Android 4.0+)" policy, end users with Android 4.0 or later devices will see the message, "Scan device for security threats." Users will need to go to **Settings** > **Google** > **Security**, and turn on **Scan device for security threats**. A link in the compliance message lets users get more [information](/Intune/EndUser/you-are-asked-to-turn-on-scan-device-for-security-threats-android) about the message and why they are being required to turn on the setting.

- When IT administrators apply the new "Require that USB debugging is disabled (Android 4.2+)" policy, end users with Android 4.2 or later devices will see the message, "USB debugging must be disabled." Users will need to go to **Settings** > **Developer options**, and turn off **USB debugging**." A link in the compliance message lets users get more [information](/Intune/EndUser/you-are-asked-to-turn-off-usb-debugging-android) about the message and why they are being required to turn off the setting.

- When IT administrators apply the new "Minimum Android security patch level (Android 6.0+)" policy, end users with Android 6.0 or later devices will see the message, "This device does not meet the minimum Android security patch level." Users will need to install the required security patch. A link in the compliance message lets users get [information](/Intune/EndUser/you-are-asked-to-turn-on-scan-device-for-security-threats-android) about how to install the required security patch and to see which security patch they currently have installed.

#### iOS Company Portal app

- When end users are installing line-of-business apps, they will now see an improved app installation experience. If the app installation is taking a long time, users can manually sync their device to force the sync process to resume. To review the end-user instructions, see [Sync your iOS device manually](/Intune/EndUser/sync-your-device-manually-ios).

- The Microsoft Intune Company Portal app for iOS has been updated to support iOS version 8.0 and later. This update means that end users can install the Company Portal app and enroll new devices in Intune only if the device is running iOS version 8.0 or later. Users who have already enrolled devices that are running on an unsupported version of iOS can continue to use the Company Portal app that is on their device.


## May 2016

All of these features are also supported for hybrid deployments (Configuration Manager with Intune). For more information about new hybrid features, check out the [Hybrid What’s New](https://technet.microsoft.com/en-us/library/mt718155.aspx) page.

### Documentation
Welcome to the preview version of [docs.microsoft.com](https://docs.microsoft.com/en-us/intune)!
This is a completely new, modern content platform designed to make it easier for you, our customers to understand and use Intune.
To read about all of the new features, see [Introducing docs.microsoft.com](https://docs.microsoft.com/teamblog/introducing-docs-microsoft-com/)

### Intune service health
Service health information for Intune has been moved to a central location with other Microsoft services. You'll now find this information in the [Office 365 management portal](https://portal.office.com/Admin/Default.aspx) under **Service Health**.
For more information, see [this blog post](https://blogs.technet.microsoft.com/microsoftintune/2016/04/28/intune-service-health-is-now-available-in-the-office-365-portal/).


### App management
- **MAM SDK: Support PIN length configuration.** You will be able to specify the length of the PIN for MAM apps similar to a device PIN. This will require end users to comply with the new restrictions you set. They will see a slightly modified PIN screen to account for the longer input. For details, see [MAM policy settings for Android](android-mam-policy-settings.md), and [MAM policy settings for iOS](ios-mam-policy-settings.md).

- **Skype for Business for iOS and Android.** You can now target Skype for business with [MAM without enrollment policies](get-ready-to-configure-mobile-app-management-policies-with-microsoft-intune.md). Once users log in, the MAM policies will be applied.

- **New apps available for management with MAM policies.** The Microsoft Word, Excel, and PowerPoint apps for Android can now be associated with MAM policies on devices that are not enrolled with Intune. For a full list of supported apps, go the Microsoft Intune mobile application gallery on the [Microsoft Intune application partners](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx) page.


### Company Portal updates

#### Android Company Portal app
- **End user toast notifications**: End users will now see toast notifications from the Android Company Portal app when they are enrolling their devices or removing their devices from the Company Portal.

- **Changes to Device Enrollment Managers accounts in the Android Company Portal app.** To improve performance and scale, Intune is no longer showing all Device Enrollment Managers (DEM) devices in the My Devices pane of the Android Company Portal app. Only the local device running the app is displayed, and only if it is enrolled via the Company Portal app. The DEM user may perform actions on the local device, but remote management of other enrolled devices can only be performed from the Intune admin console.

#### Company Portal website
- **Company Portal website: Device identification banner will provide more information to end users.** End users can now more easily identify the device they’ve selected when they are using the Company Portal website. If the wrong device is selected, they will be able to select the correct device by tapping the **Tap here** link in the home page banner.

## What's coming
- **Message center UI onboarding**. As part of the migration of Intune into the [Office 365 Management portal](https://portal.office.com/), we will begin taking advantage of their Message Center to communicate new features and other notifications. Also, by installing the companion Office 365 Admin mobile app, you can receive notifications on your mobile phone and easily forward any messages to users or a distribution alias.
We will begin using the Message Center with our May release to notify you when updates are completed and will include information on new and improved Intune features. Check out the Message Center today by logging into the [Office 365 Management portal](https://portal.office.com/) and choosing the MESSAGE CENTER option in the left navigation pane.

- **Changes to Device Enrollment Managers accounts**. To improve performance and scale, Intune is no longer showing **all** Device Enrollment Managers (DEM) devices in the **My Devices** pane of the iOS Company Portal app. Only the local device running the app is displayed, and only if it is enrolled via the Company Portal app. The DEM user may perform actions on the local device, but remote management of other enrolled devices can only be performed from the Intune admin console. Additionally, Intune is deprecating use of DEM accounts with either the Apple Device Enrollment Program or the Apple Configurator tool. Both these enrollment methods already support user-less enrollment for shared iOS devices. Only use DEM accounts when user-less enrollment for shared devices is unavailable.

### Cloud roadmap
Keep informed about upcoming developments for Intune with the [Cloud Platform roadmap](http://www.microsoft.com/en-us/server-cloud/roadmap/Indevelopment.aspx?TabIndex=0&dropValue=Intune).

### Service deprecation
- **Intune Viewer apps.** With the release of the new RMS sharing app, we are removing the following Intune Viewer apps, beginning August, 2016:
	- Intune AV Viewer
	- Intune PDF Viewer
	- Intune Image Viewer for Android from Google Play

  Instead of using the Intune Viewer apps, we recommend using the new Rights Management app (RMS sharing) for Android, which allows you to deploy one app instead of three separate apps to securely view corporate files on Android devices. Learn more about the RMS sharing app (with link to documentation).

- **Custom Group Targeting of Notification Rules Removal.**
Intune notification rules define who an email alert will be sent to from Intune. Currently, you can configure notification rules to send emails to all users of devices in an Intune device group that you created. From around June 1st 2016 moving forward, targeting user-created groups will no longer be supported.

	Today, to target a notification rule to a group you created from the Microsoft Intune administration console, you would take the following steps:

	In the **Admin** workspace, click **Notification Rules** > **Create New Rule**

	In step two of the Create Notification Rule Wizard, select the device groups which the rule will target. This step, “select device groups”, is being removed from the Intune Console.

	The preliminary timeline for this change is as follows:
	- In June, 2016, new tenants will not see step two of the Create Notification Rule Wizard. Exiting tenants are unaffected.
	- Around August, 2016, some existing tenants will not see the “select device groups” in the wizard.
	- Around October, 2016, we expect that all tenants will not see the “select device groups” in the wizard.


- **Changes in support for the iOS Company Portal app**. In the coming months, there will be an update for the Microsoft Intune Company Portal app for iOS that will only support devices running iOS 8.0 or later. Users won’t be able to enroll new devices running versions below iOS 8.0. Enrolled devices running versions below iOS 8.0 will continue to be managed and will, for a limited time, be able to continue using the Company Portal app. However, devices must be on iOS 8.0 or later to access the latest versions of the Company Portal app. We encourage you to notify users to update to iOS 8.0 or later to take full advantage of new Intune features.  


## April 2016
All of these features are also supported for hybrid customers (Configuration Manager integrated with Intune).
### App management
- **MAM user compliance.**
You can now view the [status](monitor-mobile-app-management-policies-with-Microsoft-Intune.md) of your application management policies for any user in your Azure Active Directory (AAD) tenant. This includes:
   - Devices
   - Apps on the device

   Status values:

   **Checked in**: Indicates the policy was deployed to the user, and app was used in work context, and successfully received the policy.

    **Not checked in**: Indicates the policy was deployed to the user, but app has not been used in the work context since then.


- **MAM controls to prevent Outlook contacts sync (Android).**
A new setting is available for [mobile application management](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md) without device enrollment. This setting  allows you to prevent an application from syncing contacts to the native address book on Android devices. When this setting is enabled, targeted applications will no longer be able to save contacts to the native address book. When this setting is disabled, targeted applications will be able to save contacts to the native address book. When you [remotely wipe a device or app](wipe-managed-company-app-data-with-Microsoft-Intune.md), contacts that have already been saved to the native address book will be removed. This new setting is supported initially by the Outlook application on Android devices.

### Device management
- **Phone number identification for corporate-owned devices.** Phones that are categorized as "Corporate" are now identified with their full phone number when, for example, you run a mobile device inventory report. BYOD phone numbers continue to be masked with ****, with only the last 4 digits displayed.


### Company portal updates
**Android Company portal app**
Users who have not enrolled their device in Intune and who do not have the correct certificate installed will not be able to sign in to the Android Company Portal app and will see the message, “You cannot sign in because your device is missing a required certificate.” The message includes a “How to resolve this” link that users can tap to see instructions for installing the certificate. To see the steps that end users follow to resolve the issue, see [Your device is missing a required certificate](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_cert_missing).

**iOS Company Portal app**
Support has been added for the pull-to-refresh action to refresh the content on the home screen, which includes listed apps, listed devices, and IT contact information. The pull-to-refresh action does not check compliance or policy information, which can be done by selecting the tile for your current device and tapping the **Sync** button.

**Windows 10 Mobile and Windows Phone 8.1 Company Portal app**
When end users are installing line-of-business apps, they will now see an improved app installation experience. If the app installation is taking a long time, users can manually sync their device to force the sync process to resume. To review the end-user instructions, see [Sync your device manually to speed up app installations](https://technet.microsoft.com/library/mt427782.aspx#BKMK_win10m_wp81_sync_manually).

**Company Portal website**
When Windows 10 Mobile and Windows Phone 8.1 users are installing line-of-business apps, they will now see the following new statuses, which provide them with more detail about the status of their installation:

* **Waiting for device to sync** – the user has tapped “Install” and the device now tries to sync with the Intune infrastructure. The sync is required before the installation can complete. The "Waiting for device to sync" message is also a link that users can tap to see [instructions](https://technet.microsoft.com/library/mt590895.aspx#BKMK_iwp_sync_manually) on how to manually sync their device with Intune if the sync process is taking a long time or gets stalled.
* **Downloading** – the user’s download request is being processed and the device is downloading and installing the app.

Before these statuses were added, users got confused if an app installation took a long time, because they saw only an “Installing” status, which might remain on the screen for hours. Adding the new statuses means that, instead of calling support, users can now tap the "Waiting for device to sync" link and follow the instructions to force the sync process to resume.


## March 2016
### What's new as of March 29, 2016
With the exception of the update to the Windows 10 general configuration policy, all of the features releasing on March 29, 2016, are also supported for hybrid customers (Configuration Manager integrated with Intune). Hybrid support for the Windows 10 general configuration policy update is coming soon. Please note that some of these features may require the latest version of Configuration Manager.

### App management
- **MAM controls to prevent Outlook contacts sync (iOS).** A new setting is available for mobile application management without device enrollment. This setting allows you to prevent an application from syncing contacts to the native address book on iOS devices. When this setting is enabled, the app will no longer be able to save contacts to the native address book. When this setting is disabled, the app will be able to save contacts to the native address book. When you selectively wipe a device, all contacts that have already been saved to the native address book will be removed. This new setting is supported by the Outlook application on iOS devices. For more details about this and other settings, see [Create and deploy MAM policies](https://technet.microsoft.com/en-us/library/dn292747.aspx).

### Access control
- **Skype for Business Online supports conditional access.** You can set a conditional access policy for Skype for Business Online so that it can only be accessed by managed and compliant iOS and Android devices. End users who try to sign in to the Skype for Business mobile app on iOS and Android will be prompted to enroll with Intune as well as fix any non-compliance issues before sign-in can complete. For details, see [Manage access to Skype for Business Online](https://technet.microsoft.com/en-us/library/mt695297.aspx).

### Device management
- **Intune support for iOS 9.3.** On Monday March 21st, Apple announced the availability of iOS 9.3. We have been busy working to ensure that Microsoft Intune is compatible with the latest version of Apple's mobile operating system, and [we are pleased to announce that Intune supports managing iOS 9.3 devices](https://blogs.technet.microsoft.com/microsoftintune/2016/03/23/microsoft-intune-provides-support-for-ios-9-3/).

  All existing Intune features currently available for managing iOS devices will continue to work seamlessly as users upgrade their devices to iOS 9.3. In addition, iOS 9.3 is also supported today for hybrid customers (Configuration Manager integrated with Intune).

- **The Windows 10 general configuration policy now contains settings to manage Windows Defender on enrolled Windows 10 PC's.** For details, see [Windows 10 configuration policy settings in Microsoft Intune](https://technet.microsoft.com/en-us/library/mt404697.aspx).


### Company portal

- **Windows app packages available directly from the Company Portal website.** Users of Windows 8, Windows 8.1, and Windows RT PCs can now install Windows app packages (with the .appx extension) directly from the Company Portal website. Previously, you had to deploy, or users had to install the Company Portal app on their devices to install apps.

- **Users can remotely lock their device from the Company Portal website.** A new Remote Lock option has been added to the Company Portal website to enable users to remotely lock their device from the Portal if their device is lost or stolen. See the [end-user instructions](https://technet.microsoft.com/library/mt590895.aspx/?wt.mc_id=ui#BKMK_iwp_remote_lock). The following table lists the platform support for Remote Lock for Intune Standalone and Intune with Configuration Manager.

|Platform | Support details|
|---------|----------------|
|Android |Supported|
|iOS |Supported|
|Windows 10 Mobile |Supported only if the phone has a passcode set|
|Windows 10 Desktop |Not supported|
|Windows Phone 8.1 |Supported only if the phone has a passcode set|
|Windows Phone 8.0 |Not supported|
|PC (Windows 8.0 and earlier) |Not supported|
|PC (Windows 8.1) |Not supported|

### What's new as of March 10, 2016

### App management

- **Take advantage of iOS "Open-in" management for devices that are enrolled in a third-party MDM solution**
You can use your third-party mobile device management (MDM) vendor to take advantage of iOS "Open-In" management. You can set the restrictions in the configuration profile settings and deploy the app using [Manage data transfer between iOS apps](manage-data-transfer-between-ios-apps-with-microsoft-intune.md).

     This approach has two main benefits:

     1. Users are required to log in with their work account before they get access to any corporate data from Cloud Services or other apps. This ensures that mobile app management (MAM) policies are in place when the data is accessed.

     2. Managed  email profiles and other managed apps deployed through a third-party MDM solution can share files and data with the apps that have Intune MAM policies.

- **Manage the Microsoft Outlook app with MAM policies for devices not enrolled in Intune**
You can now manage the Microsoft Outlook app on devices that are not enrolled in Intune with the Intune mobile application management policy. The updated Microsoft Outlook app with the MAM capabilities is available for both [iOS](https://itunes.apple.com/us/app/microsoft-outlook-email-calendar/id951937596?mt=8) and [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.outlook) devices. Use the instructions in the [Create and deploy mobile app management policies](https://technet.microsoft.com/library/mt627829.aspx) topic to create a MAM policy.  


- **Mobile app configuration policies give you more flexibility to specify user details for iOS apps**
You can supply user settings that an iOS app might need when it is opened. For example, you can supply a network port, or a user name. For details, see [Configure iOS apps with mobile app configuration policies in Microsoft Intune](configure-ios-apps-with-mobile-app-configuration-policies-in-microsoft-intune.md).


- **Deploy Adobe Reader for Microsoft Intune to Intune-managed iOS devices in your enterprise**
The Adobe Reader app for iOS can now be managed on enrolled devices with the Intune mobile application management policy.

- **Ensure deployed web clips are opened in the managed browser**
You can deploy targeted web clips that can only be opened using the managed browser on iOS and Android devices. For example, you deploy links to corporate resources through the Company Portal, and when users navigate to the links, they open directly into the managed browser where they can be protected by MAM policy. For details, see [Deploy apps ](deploy-apps.md).


- **Find, manage, and distribute Windows Store for Business apps for Windows 10 devices from the Intune administrator console**
Support for Windows Store for Business is available in Intune to help you find, manage, and distribute apps to the Windows 10 devices you’re managing. Windows Store for Business lets you manage the process of deploying and monitoring these apps from the Intune administrator console—the same console you use to manage your other apps. Specifically, Windows Store for Business manages the content and licensing  of “online licensed apps”. For details, see [Manage apps you purchased from the Windows Store for Business](manage-apps-you-purchased-from-the-windows-store-for-business-with-microsoft-intune.md).


### Device management
- **PFX certificates distribution for iOS devices**
Intune administrators can create and deploy iOS PFX certificates for Wi-Fi, email, and VPN authentication on iOS devices. This feature is already available for Android and Windows 10 devices. For details, see [Enable access to company resources using certificate profiles ](secure-resource-access-with-certificate-profiles.md).


- **Apply apps and policies to different device groups based on user category selection**
Intune administrators can now define custom device categories for users to select from during enrollment. For example, administrators might want their users to specify if they're enrolling a device used for the "Cash Register" or "Delivery Truck" or "Inventory Room." The category selected will cause the device to become a member of an Intune device group, which can be used for deploying different apps and policies to the enrolled device. For details, see [Categorize devices with device group mapping](categorize-devices-with-device-group-mapping-in-microsoft-intune.md).

### Changes and updates to Microsoft Company Portal
The following changes have been made to the Company Portal in this release.

**Android Company Portal app**

* When your users launch an app that is managed by mobile application management (MAM), they will see a message notifying them that the app is managed by their company. Users can now tap a “Learn More” link to get [more information](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_use_mgd_apps) here about what “managed apps” means. They can also tap “Don’t Show Again” so that the message no longer appears when they launch the app.
* New screens have been added to guide users through the enrollment process and provide more information about why users should enroll and what IT administrators can and can’t see on their enrolled devices. See the [enrollment instructions](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_enroll_devc) for details.
* Enrollment error messages are now displayed in the Company Portal app. Previously, these messages appeared in the Company Portal website. Making this change means that all error messages now appear in just one place instead of two different places.


**iOS Company Portal app**
* When your users launch an app that is managed by mobile application management (MAM), they will see a message notifying them that the app is managed by their company. Users can now tap a “Learn More” link to get [more information](https://technet.microsoft.com/library/mt598622.aspx#BKMK_ios_use_mgd_apps) here about what “managed apps” means. They can also tap “Don’t Show Again” so that the message no longer appears when they launch the app.
* New screens have been added to guide users through the enrollment process and provide more information about why users should enroll and what IT administrators can and can’t see on their enrolled devices. See the [enrollment instructions](https://technet.microsoft.com/library/mt598622.aspx#BKMK_enroll_ios_device) for details.
* Enrollment error messages are now displayed in the Company Portal app. Previously, these messages appeared in the Company Portal website. Making this change means that all error messages now appear in just one place instead of two different places.




## February 2016
### Changes and updates to Microsoft Company Portal

The following changes have been made to the Company Portal in this release.

#### Android Company Portal app
- New screens have been added to guide users through the enrollment process and provide more information about why users should enroll and what IT administrators can and can’t see on their enrolled devices. See the [enrollment instructions](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_enroll_devc) for details.
- Enrollment error messages are now displayed in the Company Portal app. Previously, these messages appeared in the Company Portal website. Making this change means that all error messages now appear in just one place instead of two different places.

#### iOS Company Portal app
 - New screens have been added to guide users through the enrollment process and provide more information about why users should enroll and what IT administrators can and can’t see on their enrolled devices. See the [enrollment instructions](https://technet.microsoft.com/library/mt598622.aspx#BKMK_enroll_ios_device) for details.

 - Enrollment error messages are now displayed in the Company Portal app. Previously, these messages appeared in the Company Portal website. Making this change means that all error messages now appear in just one place instead of two different places.


## January 2016

### Take advantage of Windows 10 features
* **Conditional access with Health Attestation Service**
Intune administrators can now view the status of Windows 10 Device Health Attestation in the Intune Admin console. Device health attestation lets the administrator ensure that client computers have trustworthy BIOS, TPM, and boot software configurations. To support device health attestation, client devices must be running Windows 10 with TPM 2 enabled. Device health attestation displays the number of devices enabled for each of the following:
	* Early-launch antimalware
	* BitLocker
	* Secure Boot
	* Code Integrity

	Read [Introduction to device compliance policies for Microsoft Intune](introduction-to-device-compliance-policies-in-microsoft-intune.md) for more details on the device health setting, collected data points, and the health attestation report. The [HAS service details](https://msdn.microsoft.com/en-us/library/dn934876.aspx) explains the service in depth.

* **Windows 10 Passport for Work Policy and certificate management**
With Intune, you can [integrate with Microsoft Passport for Work](control-microsoft-passport-settings-on-devices-with-microsoft-intune.md), which is an alternative sign-in method for Windows 10 that uses Active Directory or an Azure Active Directory account to replace a password, smart card, or virtual smart card. Passport lets you use a user gesture to log in instead of a password. A user gesture might be a simple PIN, biometric authentication such as Windows Hello, or an external device such as a fingerprint reader.

* **VPN for specific apps**
You can select apps that automatically connect to your corporate network over VPN. Create the list of apps when you set up the VPN profile, as described in Help users connect to their work using VPN profiles with Microsoft Intune.

* **Windows 10 Full Wipe support**
You can now issue a remote full wipe of Windows 10 desktop devices enrolled in Intune through the Intune admin console. Windows 10 full wipe does a factory reset of the device.


### Apple Volume Purchase Program (VPP) update
Intune can now help you [manage apps you purchased through the Apple Volume Purchase Program (VPP) for Business](manage-ios-apps-you-purchased-through-a-volume-purchase-program-with-microsoft-intune.md). This includes synchronizing license information between Apple and Intune, and tracking how many copies of each app you have deployed.

### Use IMEI numbers to identify corporate-owned devices
You can now [import international mobile equipment identity (IMEI) numbers](specify-corporate-owned-devices-with-international-mobile-equipment-identity-imei-numbers.md) for mobile device platforms that have an IMEI number to help identify corporate-owned mobile devices. Once enrolled in Intune, devices with imported IMEI numbers are tagged as Corporate, which can be used for applying policies that are different than those applied to personally owned devices.

### More apps are now compatible with Intune MAM policies
Additional apps from Microsoft partners are now compatible with Intune mobile application management (MAM) policies (for devices managed by Intune):
* Box for EMM (from Box Inc) – iOS only
* Adobe Reader (from Adobe) – Android only
* Foxit PDF Reader (from Foxit Corporation) – iOS and Android


### IE9 support ending in January
Starting in February, 2016, Internet Explorer 9 will no longer be supported as an official browser for accessing the Microsoft Intune company portal website, Intune account portal, and Intune administration console. You will need to migrate to Internet Explorer 10 or later.


>[!div class="step-by-step"]

>[&larr; **What's new in Intune**](whats-new-in-microsoft-intune.md)    
