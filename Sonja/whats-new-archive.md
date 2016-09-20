---
# required metadata

title: What's new archive | Microsoft Intune
description:
keywords:
author: Lindavr
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: ed2db991-4729-49a7-a1e6-be2ffa0d03d1

# optional metadata

ROBOTS: noindex,nofollow
#audience:
#ms.devlang:
#ms.reviewer:
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---
## December 2015
### Changes and updates to Microsoft Company Portal
The following changes have been made to the Company Portal in this release.

**Android Company Portal app**

The following changes have been made to comply with new Google requirements. On Android 6.0 and above devices, two new messages are displayed to users:
* Allow Company Portal to make and manage phone calls?
* Allow Company Portal to access photos, media, and files on your device?

See the following tables for details about these two messages.



Message text  |Allow Company Portal to make and manage phone calls?  
---------|---------
Meaning of message     |  Enables the user's device phone number and IMEI to be sent to the Intune service and appear in the Admin console on the Hardware page.   </br></br>**NOTE: The Company Portal app never makes or manages phone calls!** The message text is controlled by Google and cannot be changed. </br></br>To see the **Hardware** page, go to **Groups** > **All mobile devices** > **Device**s. Select the user's device, and go to **View Properties** > **Hardware**.    
Where and when message appears  | The message appears when users sign in to the Company Portal app for the first time to start enrolling their device.|         
What happens if users allow access  |  The device's phone number and IMEI will appear on the Hardware page in the Admin console. |         
What happens if users deny access     | They can continue to use the Company Portal app and enroll their device, but the users's device phone number and IMEI will be blank on the Hardware page in the Admin console.       </br></br> The second time that users sign in to the Company Portal app after denying access, the message displays a **Never ask again** check box that users can select so that the message never shows again.</br></br>If users allow but then later deny access, the message appears the next time users sign in to the Company Portal app after enrollment.</br></br>If users later decide to allow access, they can go to **Settings** > **Apps** > **Company Portal** > **Permissions** > **Phone**, and then turn on the permission.
More information     |  For your users: [Sign in to the Company Portal](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_signin_cp)  </br></br>For IT Pros: The information in this table is also in [Helping your users understand Company Portal app messages](https://technet.microsoft.com/library/dn948527.aspx#BKMK_help_users_understd_msgs)   

Message text  |Allow Company Portal to access photos, media, and files on your device?  
---------|---------
Meaning of message     |  Enables the device to write data logs to the device's SD card, which enables logs to be moved by using a USB cable.   </br></br>**NOTE: The Company Portal app never accesses users' photos, media, and files!** The message text is controlled by Google and cannot be changed.     
Where and when message appears  | The message appears when users tap **Send Data** to send data logs to their IT admin.|         
What happens if users allow access  |  The logs will be copied to the SD card. |         
What happens if users deny access     | They can still send data logs, but the logs won't be copied to the device's SD card.       </br></br> The second time that users sign in to the Company Portal app after denying access, the message displays a **Never ask again** check box that users can select so that the message never shows again.</br></br>If users allow but then later deny access, the message appears the next time users try to send logs.</br></br>If users later decide to allow access, they can go to **Settings** > **Apps** > **Company Portal** > **Permissions** > **Storage**, and then turn on the permission.
More information     |  For your users: [Send diagnostic data logs to your IT admin using email](https://technet.microsoft.com/library/mt502762.aspx#BKMK_andr_send_diag_logs)  </br></br>For IT Pros: The information in this table is also in [Helping your users understand Company Portal app messages](https://technet.microsoft.com/library/dn948527.aspx#BKMK_help_users_understd_msgs)   


**iOS Company Portal app**
* Users can now use Microsoft Outlook or other mail apps to send diagnostic logs to the IT administrator. Previously, only the native app could be used.
* Support has been improved for Apple's Device Enrollment Program (DEP) and corporate-enrolled devices. For details, see [You are asked to identify your device when you're trying to enroll](https://technet.microsoft.com/library/mt598622.aspx#BKMK_ios_id_your_device).
* In the user's list of enrolled devices, a green check mark now appears next to the device that the user is currently using. Before this check mark was added, users couldn't tell which enrolled device they were using.

**Windows Company Portal app**

Microsoft automatically collects anonymous data about the performance and use of the company portal to improve Microsoft products and services. End users can turn off data collection by using the Usage Data setting on their device, but administrators have no control over the data collection and cannot change the end user’s selection for this setting.



## November 2015
### App management
Intune supports mobile application management (MAM) policies that help prevent corporate data from being leaked to consumer apps or services. Historically, these policies would only be enforced on mobile apps running on devices that were also enrolled for mobile device management (MDM) into Intune.

With this month's update, Intune is expanding its MAM capabilities to new classes of devices. In addition to devices enrolled into Intune, you can now enforce MAM policies on:
* devices managed by any other device management (MDM) solution
* device that are not enrolled into any device management system, typically bring-your-own (BYO) devices

You can find more information about these new MAM capabilities in the following blog posts:
* [Enhancing managed mobile productivity](http://blogs.technet.com/b/microsoftintune/archive/2015/11/17/enhancing-managed-mobile-productivity.aspx)
* [Announcing new Microsoft Enterprise Mobility capabilities](http://blogs.technet.com/b/microsoftintune/archive/2015/11/17/enhancing-managed-mobile-productivity.aspx)

Additionally, here are some highlights and additional information about Intune's MAM features:
* Corporate data is isolated from consumer data within apps enlightened for Intune including Office Mobile apps, third-party apps that have adopted the Intune SDK, or line-of-business apps wrapped by Intune.
* Company data can be shared (**cut/copy/paste**) across company apps, while preventing the sharing of company data into personal apps. Read [How MAM policies protect app data](https://technet.microsoft.com/library/mt627825.aspx) for more details. This example scenario, [Using Microsoft Word app for work and personal tasks](https://technet.microsoft.com/library/mt627827.aspx), shows how sharing company data into personal apps is prevented.
* Key data loss prevention policies like per-App PIN, save-as controls, and managed data sharing between apps. Read [Create and deploy mobile app management policies with Microsoft Intune](https://technet.microsoft.com/library/mt627829.aspx) to see a list of all the policies.
* Word, Excel, PowerPoint, Outlook, OneNote, and OneDrive for Business all have these new capabilities and can be managed with and without device enrollment. The data loss protection capabilities are natively built into the standard Office apps in the Apple Store or the Google Play store, and do not require app wrapping or sideloading.
* To learn how to get started, see [Get started with mobile app management policies in the Azure portal](https://technet.microsoft.com/library/mt627830.aspx). To learn how to configure and deploy mobile app management policies, see [Create and deploy mobile app management policies with Microsoft Intune](https://technet.microsoft.com/library/mt627829.aspx).
* When end-users authenticate to the app with their corporate credentials, the data loss protection capabilities are automatically set up. The [End-user experience for apps associated with Microsoft Intune mobile app management policies](https://technet.microsoft.com/library/mt627827.aspx) topic has some example scenarios for accessing OneDrive on iOS and Android devices.
* Works on both iOS and Android devices.

The list of [Microsoft apps you can use with Microsoft Intune mobile application management policies](https://technet.microsoft.com/library/dn708489.aspx) has been updated to show the latest apps.

### Device management
 **Mac OS X device management**
With Intune, you can now enroll and manage Mac OS X devices. You can do the following with your Mac OS X devices:
* Enroll devices to be managed by Intune. See [Set up iOS and Mac management with Microsoft Intune](https://technet.microsoft.com/library/dn408185.aspx).
* Control device settings with a general configuration policy. See [Mac OS X configuration policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt627823.aspx).
* Deploy Mac OS X settings you created with the Apple Configurator. See [Mac OS X custom policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt627820.aspx).
* Collect hardware and software inventory from Mac OS X devices. See [Understand your devices with inventory in Microsoft Intune](https://technet.microsoft.com/library/jj733634.aspx).
* Run new reports that display details about the Mac OS X devices you manage. See [Understand Microsoft Intune operations by using reports](https://technet.microsoft.com/library/dn646977.aspx).

**New Edge browser settings for Windows 10 devices**
New settings have been added to the Windows 10 general configuration policy that let you manage settings and features of the Microsoft Edge browser. See [Windows 10 configuration policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt404697.aspx).

**Email profiles**
A new email profiles policy has been added for Windows 10 desktop and Windows 10 mobile devices. See [Manage settings and features on your devices with Microsoft Intune policies](https://technet.microsoft.com/library/dn646984.aspx).

**New compliance policy settings**
The following new security and system policy settings have been added to the list of compliance policies:
* To make sure that Windows 8.1 or later devices that access your company resources have the latest updates installed, use the **Require automatic updates** setting. You can also specify the type of updates to be automatically installed -- either all updates marked as important to be installed, or all updates marked important or recommended. For the full list of compliance policy settings, see [Manage device compliance policies for Microsoft Intune](https://technet.microsoft.com/library/dn705843.aspx).
* The new **Require a password when the device returns from the idle state** setting combined with the existing **Minutes of inactivity before password is required** setting allows you to create a compliance setting that requires the end-user to enter a password to use a device that has been inactive for a certain time.

**New conditional access policy options**
You can apply conditional access policies to **all users** in either new or existing conditional access policies. All users licensed for Intune and Office 365 will be required to enroll their devices, and if the device platform is not supported by Intune, access is blocked for client applications using [Active Directory authentication based sign-in (modern authentication)](https://blogs.office.com/2014/11/12/office-2013-updated-authentication-enabling-multi-factor-authentication-saml-identity-providers/).

You can also specify that the conditional access policy applies to **all platforms**.  Any client application using the [Active Directory authentication based sign-in (modern authentication)](https://blogs.office.com/2014/11/12/office-2013-updated-authentication-enabling-multi-factor-authentication-saml-identity-providers/) is subject to the conditional access policy, and if the platform is not supported by Intune, it will be blocked.

### Changes and updates to Microsoft Company Portal
The following changes have been made to the company portal apps in this release:

* **Android**: A Welcome screen has been added to the Android Company Portal app to help users understand the purpose of the Company Portal app. This screen is intended to reduce downloads of the app by users whose companies are not Intune subscribers.

* **iOS**: Intune now supports the enrollment of Mac OS X devices  by using  the [Company Portal website](https://portal.manage.microsoft.com). For instructions, see [Enroll your Mac OS X device in Intune](https://technet.microsoft.com/library/mt598622.aspx).

* **Company Portal website**: Users who have enrolled their device in Intune can now reset their passcode by using the **Reset Passcode** option on the Company Portal website. Previously, only IT administrators could reset users' passcodes. The  Reset Passcode option is not supported on Windows 8.1 and Windows RT devices, and the option appears only when devices are enrolled in mobile device management (MDM) or MDM with Exchange ActiveSync. For user instructions, see [Reset your passcode](https://technet.microsoft.com/library/mt590895.aspx).

### Changes to Global Admins licensing
In October, we shared that Global Admins (also referred to as Tenant Admins) could continue to do day-to-day administration tasks without a separate Intune or Enterprise Mobility Suite (EMS) license. However, if Global Admins want to use the service, such as to enroll their own device, a corporate device, or use the Intune Company Portal, they will need an Intune or EMS license just like any other user. Below are a few additional details.
* The Intune Company Portal is where end users can:
    * enroll their device
    * view the status of their device
    * download software that a Global Admin has deployed to the organization
    * find links published by the Global Admin for how to contact their IT department

	[Learn about the Company Portal](https://technet.microsoft.com/library/dn646966.aspx#BKMK_CompanyPortal)  and about [ways to customize the Company Portal](https://technet.microsoft.com/library/dn646983.aspx#BKMK_ConfigureCompanyPortal).
* The person who signs up to purchase Intune or EMS on behalf of an organization automatically becomes the first Global Admin in their tenant. This fall, Intune started to auto-assign an Intune or EMS license to that very first Global Admin as part of the move to the [Office 365 Portal](http://portal.office.com/) and retirement of the [Intune Account Portal](http://account.manage.microsoft.com/). Any additional Global Admins added can continue to do day-to-day administration without a separate Intune or EMS license. Acting as an end user and enrolling their own (or corporate) device or downloading software from the company portal would then trigger a need for a license, just like any other user.
* The change will be phased in and will now start in January, 2016.
* For Microsoft Partners, this change should not affect your ability to administer the service on behalf of customers. For end-user tasks, a user will need to have an Intune or EMS license in order to enroll a device and access or download software from the Company Portal.

If you have any questions about this change, feel free to contact your Intune support team:
* [Microsoft Intune support channels](https://technet.microsoft.com/library/jj839713.aspx)
* [Community support](https://social.technet.microsoft.com/Forums/en-US/home?forum=microsoftintuneprod)

For general Microsoft Intune feedback, including filing Design Change Requests (DCRs) or bugs, please visit [Intune user voice](https://microsoftintune.uservoice.com/).


### What's new in Intune documentation -- November 2015
**New content**
* [Mac OS X configuration policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt627823.aspx): How to control device settings and features for Mac OS X devices.
* [Mac OS X custom policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt627820.aspx): How to deploy Mac OS X device settings that you created using the Apple Configurator tool.
* [Configure data loss prevention app policies with Microsoft Intune](https://technet.microsoft.com/library/mt627825.aspx): Contains information about the scenarios that mobile app management policies support and  how the policy works to protect data.
* [Get started with mobile app management policies in the Azure portal](https://technet.microsoft.com/library/mt627830.aspx): What you need to get started using the Azure preview portal for mobile app management policies.
* [Create and deploy mobile app management policies with Microsoft Intune](https://technet.microsoft.com/library/mt627829.aspx): Contains a step-by-step walkthrough of how to create mobile app management policies in the Azure preview portal.
* [Monitor mobile app management policies with Microsoft Intune](https://technet.microsoft.com/library/mt627824.aspx): Information on how you can monitor your mobile app management policies using the Azure preview portal.
* [Microsoft Intune mobile app management policies and iOS Open In](https://technet.microsoft.com/library/mt627821.aspx): Information on how mobile app management policies work with iOS Open In feature.
* [End-user experience for apps associated with Microsoft Intune mobile app management policies](https://technet.microsoft.com/library/mt627827.aspx): What the end-user experience is when using apps associated with mobile app management policy.
* [Wipe managed company app data with Microsoft Intune](https://technet.microsoft.com/library/mt627826.aspx): How you can remove company app data.

**Updated content**
* [Windows 10 configuration policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt404697.aspx): Added new Edge browser settings.
* [Set up iOS and Mac management with Microsoft Intune](http://technet.microsoft.com/library/dn408185.aspx): Added information about how to enroll Mac OS X devices.
* [Understand your devices with inventory in Microsoft Intune](https://technet.microsoft.com/library/jj733634.aspx): Added information about the inventory collected from Mac OS X devices. Also, updated the topic with the latest information for all device platforms.
* [Understand Microsoft Intune operations by using reports](https://technet.microsoft.com/library/dn646977.aspx): Added information about the two new reports used to display information about your managed Mac OS X devices.
* [Manage device compliance policies for Microsoft Intune](https://technet.microsoft.com/library/dn705843.aspx): Added information about the new compliance policies for requiring automatic updates and password requirement when a device returns from idle state.
* [Manage email access with Microsoft Intune](https://technet.microsoft.com/library/dn705841.aspx): Added information about the ability to apply the conditional access  policy to all platforms and all users.
* [Manage SharePoint Online access with Microsoft Intune](https://technet.microsoft.com/library/dn705844.aspx): Added information about the ability to apply conditional access policy to all platforms and all users.

## October 2015

### Updates to conditional access for Exchange on-premises
**You can now allow access to Exchange Active Sync email for compliant devices enrolled in Intune when the global Exchange rule is set to block or quarantine** Until now, to allow email access on enrolled and compliant devices, you had to set the default global Exchange rule to **Allow**.

With this service update, this setting is no longer a requirement for conditional access. If your Exchange environment requires that your default global rule to be set to **Block/Quarantine**, simply check the **Default Rule Override** checkbox in the Exchange on-premises conditional access policy page. The [Manage email access with Microsoft Intune](https://technet.microsoft.com/library/dn705841.aspx) topic has more details on the rules and the resulting end user notifications.

**New one-click quarantine experience** We have simplified the quarantine email experience to allow one-click enrollment. With this service update, end users can click  a single link in the quarantine email to complete the  enrollment process within the company portal app.
### Mobile device and app management updates
**Android** All Intune management features now support Android 6.0 (Marshmallow) as described in this blog post: [Microsoft Intune Provides Day 0 Support for Android Marshmallow](http://blogs.technet.com/b/microsoftintune/archive/2015/10/09/microsoft-intune-to-provide-day-0-support-for-android-marshmallow.aspx)

**iOS** You can no longer create new app deployments to iOS devices running a version earlier than iOS 7.1. Any existing app deployments to devices running an earlier version than iOS 7.1 will continue to work and be managed by Intune.

**Windows 10** Intune now supports deploying Windows 10 Universal apps using the **Windows app package** software installer type. For details and requirements, see [Get started with app deployment in Microsoft Intune](http://technet.microsoft.com/en-US/library/dn646955.aspx).


### Changes and updates to Microsoft Company Portal apps
The following changes have been made to the company portal apps in this release:
**iOS**
New buttons have been added to the Company Portal app to make it easier for users to send diagnostic logs to their IT admins:

|Button name|Where it appears|
|------------|---------------|
|Report|Error alert messages|
|Send Diagnostic Report|About screen of the Company Portal app|



## September 2015
### Mobile device and app management updates
**All Intune iOS management features now support iOS 9**
For details about iOS 9 management capabilities, see [this blog post](http://blogs.technet.com/b/microsoftintune/archive/2015/09/09/day-zero-support-for-ios-9-with-intune.aspx).

**New mobile app configuration policy for iOS**
Use the new mobile app configuration policy to automatically supply settings that an iOS app might need when it is run. For example, you could supply a network port, or a user name. For details, see [Configure apps with mobile app configuration policies in Microsoft Intune](https://technet.microsoft.com/library/mt481447.aspx).

**Easier app management for iOS 9 users**
 In this release, you can bring already-deployed apps under Intune management for iOS 9 users. For earlier versions of iOS, when you deploy an app and an unmanaged version of the app is already installed on a device, you still have to ask the user to uninstall the app manually before Intune can install the managed app.

 But starting with this release of Intune, you can now prompt users of iOS 9 devices to allow Intune to take over management of the app and apply any relevant mobile application management policies.

 **Windows 10 management** Use the new [Windows 10 general configuration policy](https://technet.microsoft.com/library/mt404697.aspx) to configure password, device, browser and other settings for enrolled devices that run Windows 10 and Windows 10 Mobile.

 **Create and deploy apps to enrolled Windows 10 devices** A new software installer type, Windows Installer through MDM (&#42;.msi) lets you create and deploy Windows Installer apps to enrolled devices that run Windows 10. For details, see [Get started with app deployment in Microsoft Intune](https://technet.microsoft.com/library/dn646955.aspx).

### Changes and updates to Microsoft Company Portal apps
The following changes have been made to the company portal apps in this release:

**iOS**
* Microsoft automatically collects anonymous data about the performance and use of the company portal to improve Microsoft products and services. End users can turn off data collection by using the Usage Data setting on their device, but administrators have no control over the data collection and cannot change the end user’s selection for this setting.
* Full screen resolution support on iPhone 6 and 6 Plus
* Bug fixes to improve security

### What's new in Intune documentation -- September 2015
**New topics**

|Name|Details|
|----|--------|
|[Windows 10 configuration policy settings in Microsoft Intune](https://technet.microsoft.com/library/mt404697.aspx)|This is a new configuration policy that lets you manage settings and features on devices that run Windows 10 and Windows 10 Mobile.
| [Configure apps with mobile app configuration policies in Microsoft Intune](https://technet.microsoft.com/library/mt481447.aspx)|This is a new policy type that lets you automatically supply settings that might be required when the user runs an iOS app. |

**Updated topics**

|Name|Details|
|----|-------|
|[Use policies to manage computers and mobile devices with Microsoft Intune](https://technet.microsoft.com/library/dn743712.aspx)|Updated to include the latest information to help you understand and create policies.|

## August 2015
### Mobile device and app management updates
* **Terms and conditions** for Intune enrollment and company access are [now managed using policies](https://technet.microsoft.com/library/mt405893.aspx). You can target different sets of terms and conditions to meet specific user group requirements. For example, you can  deploy terms and conditions in different languages to geographically defined user groups. You can also [edit your terms and conditions](https://technet.microsoft.com/library/mt405893.aspx#BKMK_TCVers) and specify whether to increment the version numbers, requiring users to agree to the new terms and conditions before they can use the company portal.
* **A number of Intune policies have been renamed** to make them more consistent across the product and easier for you to find. For a list of all available Intune policies, see [Use policies to manage computers and mobile devices with Microsoft Intune](https://technet.microsoft.com/library/dn743712.aspx).
* **PKCS #12 (.PFX) Certificate Profiles** are available for Android 4.0 or later, and Windows 10 (desktop and mobile) and later. Using .PFX does not require an NDES server. Learn how to use .PFX certificate profiles in [Enable access to company resources using certificate profiles with Microsoft Intune](http://technet.microsoft.com/library/dn818904.aspx)
* **Corporate Boundaries settings for Windows 10 Desktop and Mobile** enable granular VPN settings, as described in [Help users connect to their work using VPN profiles with Microsoft Intune](https://technet.microsoft.com/library/dn818905.aspx)
* **The OneDrive app for Android now supports multi-identity**. This and other updates to mobile app management policies are described in the [list of Microsoft applications you can manage](https://technet.microsoft.com/library/dn708489.aspx).
* **iOS Activation Lock bypass**. If company-owned iOS devices are protected by Activation Lock, you must enter the user's Apple ID and password before you can erase or reactivate the device. This can present a challenge when users leave the company and return a company-owned device without turning off Activation Lock. To help solve this problem, you can use [Intune Activation Lock Bypass](https://technet.microsoft.com/library/mt414176.aspx)

### Conditional access for PCs
You can now configure conditional access policies for PCs. This allows Office desktop apps to access Exchange Online and SharePoint online services.
To enable conditional access policy for PCs, the PC must either be domain joined or be complaint.
* See the **Getting started** section in  [Manage access to email and SharePoint with Microsoft Intune](http://technet.microsoft.com/library/dn818907).aspx) for the full list of requirements to enable conditional access for PCs.
* See [Manage email access with Microsoft Intune](https://technet.microsoft.com/library/dn705841.aspx) for options you can set to enable conditional access for email access.
* See [Manage SharePoint Online access with Microsoft Intune](https://technet.microsoft.com/library/dn705844.aspx) for options you can set to enable conditional access for SharePoint Online.

### Changes and updates to Microsoft Company Portal apps
The following changes have been made to the company portal apps in this release:

**Android**

Users will now see device enrollment instructions after signing in if they have not yet enrolled their device for management.

### What's new in Intune documentation -- August 2015
**New topics**

|Title|Details|
|-----|-------|
|[Help protect iOS devices with Activation Lock bypass for Microsoft Intune](https://technet.microsoft.com/library/mt414176.aspx)|Learn about how you can use Intune to bypass iOS Activation lock when a user leaves the company and returns a locked device.|

**Updated topics**

|Title|Details|
|-----|-------|
|[Microsoft apps you can use with Microsoft Intune mobile application management policies](https://technet.microsoft.com/library/dn708489.aspx)|Updated with the latest information about apps you can manage with mobile application management policies.
|[Use policies to manage computers and mobile devices with Microsoft Intune](http://technet.microsoft.com/library/dn743712.aspx)|Updated with the newest policies added to Intune.|
<!---
## July 2015
July updates for Intune are limited to behind-the-scenes enhancements that allow us to continue providing you with a high-quality service experience. New features are not included in this service update.

### Intune Onboarding benefit
Microsoft offers the Intune Onboarding benefit for eligible plans. The Onboarding benefit lets you work remotely with Microsoft specialists to get your Intune environment ready for use. For more information, see [Microsoft Intune Onboarding benefit description](https://technet.microsoft.com/library/mt228266.aspx)
### Changes and updates to Microsoft Company Portal apps
The following changes have been made to the company portal apps in this release.

**Android**

Microsoft automatically collects anonymous data about the performance and use of the company portal to improve Microsoft products and services. End users can turn off data collection by using the Usage Data setting on their device, but administrators have no control over the data collection and cannot change the end user’s selection for this setting.--->
