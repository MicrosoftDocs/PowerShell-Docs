---
# required metadata

title: What's new | Microsoft Intune
description: Find out what’s new in this month’s, and past releases of Microsoft Intune
keywords:
author: Lindavr
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: fab51ee0-638d-4dd4-8d8f-1f263bc11e5c

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mamoriss
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# What's new in Microsoft Intune -- September
Learn what’s new in this release of Microsoft Intune. You can also find out about upcoming changes that you should be planning for, as well as information about past releases.

All of these features will eventually be supported for hybrid customers' deployments (Configuration Manager with Intune). For more information about new hybrid features, check out our [hybrid What’s New page](https://technet.microsoft.com/library/mt718155.aspx).
<!---@Barry, the above blurb stays in each version, but make sure Tyler signs off each time. Also, remember to set the ms.date in the metadata to the sprint release. --->

>[!IMPORTANT]
>Blog post - Ensuring mobile devices are up to date using Microsoft Intune<br>
>In light of the recent "Trident" malware attacks on iOS devices, we've published a new blog post, [Ensuring mobile devices are up to date using Microsoft Intune](https://blogs.technet.microsoft.com/enterprisemobility/2016/08/26/ensuring-mobile-devices-are-up-to-date-using-microsoft-intune/) to help you learn about the different ways that Intune can help keep your devices secure and up to date.

## iOS 10 support
Existing Intune MDM and MAM scenarios are compatible with iOS 10. For tips, refer to the [Intune Support Team Blog](https://blogs.technet.microsoft.com/intunesupport/2016/09/13/support-tip-intune-support-for-ios-10/).

## App Wrapping Tool supports MAM without device enrollment for Android and iOS
The Intune App Wrapping Tool is a command line tool used to enable Intune MAM on line-of-business (LOB) apps for iOS and Android. It is the simplest way to incorporate the Intune MAM SDK into your app, so that your app can enforce MAM policies deployed through Intune. Using MAM policies, you can:

1. Encrypt the app's data.
2. Require the information worker to enter a PIN when launching the app.
3. Allow the app to transfer data only to other managed apps.
4. Prevent the app from backing up data to Android, iTunes, and iCloud.
5. Only allow Cut, Copy, and Paste into and out of other managed apps.

The public preview of the updated Intune App Wrapping Tool now supports MAM without device enrollment on internal LOB apps on iOS and Android. This means your end-users are not required to enroll their devices with Intune to use MAM-enabled LOB apps.

Anyone can test the public preview software and read helpful documentation, located in msintuneappsdk's GitHub:

http://www.github.com/msintuneappsdk/intune-app-wrapper-ios-preview

http://www.github.com/msintuneappsdk/intune-app-wrapper-android-preview

Before you install and use Microsoft Intune App Wrapper for Android and iOS Pre-Release you must:

* Review the Microsoft License Terms for Microsoft Intune App Wrapping Tool for Android and iOS Pre-Release
* Print and retain a copy of the license terms for your records. By downloading and using Microsoft Intune App Wrapping Tool for Android Pre-Release you agree to such license terms. If you do not accept them, do not use the software.
<!---TFS 1235607--->

## Intune groups begin transitioning to Azure Active Directory in September
Some new Intune accounts will use Azure Active Directory security groups rather than Intune user groups. You will know that you’re working with security groups, as the Intune portal groups page will have a link directing you to the Azure management portal.

## Lookout integration to protect Android devices
Microsoft is integrating with Lookout’s mobile threat protection solution to protect Android mobile devices by detecting malware, risky apps, and more, on devices. Lookout’s solution helps you determine the threat level, which is configurable. You can create a compliance policy rule in Intune to determine device compliance based on the risk assessment by Lookout. Using conditional access policies, you can allow or block access to company resources based on the device compliance status.

End users of noncompliant devices will be prompted to enroll, and will be required to install the Lookout for Work application on Android devices, activate the app, and remediate threats reported in the Lookout for Work application to gain access. To learn more, see [Restrict access based on device, network, and application risk](restrict-access-based-on-device-network-app-risk.md).


## Company Portal updates

### Android

**Addition of "Notifications" to the Company Portal for Android**<br/>
A new Notifications icon has been added to the Company Portal for Android on the homepage. Tapping this icon accesses the Notifications page, which shows your end users all items that require attention in the Company Portal app, such as device noncompliance, enrollment update, and enrollment activation. The iOS Company Portal app already has this notifications experience. Having the new Notifications page means that user won’t see the Company Access Setup page every time they launch or resume the Company Portal as long as the device is already enrolled. If you create your own end-user guidance, you might want to update your documentation to reflect this change. Find updated screenshots [here](https://aka.ms/androidcpupdate).  
<!---TFS 1095560--->


### iOS
**Changes in support for the iOS Company Portal app**<br/>
All users of the Microsoft Intune Company Portal app for iOS are now required to use its latest version. New users are able to download only the latest version, and current users are required to update to it. The latest version requires iOS 8.0 or later, so devices running older iOS versions cannot use the Company Portal or enroll until they update their device to iOS 8.0 or later and then update the Company Portal app to the latest version. Enrolled devices running versions below iOS 8.0 will continue to be managed and listed in the Intune Admin Console.
<!---TFS 1283165--->

**Improvements in how iOS end users get their apps**<br/>
The following changes have been made to the apps tiles in the Company Portal app for iOS to point users to different views in a single location, the Company Portal website, for all of their apps. Apple restrictions prohibit line-of-business and managed app store apps from being listed in the Company Portal app, and require users to visit different views to find all of their apps.

- The **Company Apps** tile previously pointed to a list of all apps in the ALL tab of the Company Portal website, and it will continue to work the same way. The tile name has changed to **All Apps**.
- The **Other Apps** tile previously pointed to a view, inside the Company Portal app, that lists all apps that Apple permits the Company Portal app to show. The tile name has changed to **Featured Apps**, and tapping the tile will take users to the FEATURED tab of the Company Portal website.
-  The **Categories** tile previously pointed to a view, inside the Company Portal app, that lists categories of apps. The tile name has not changed, but it now points to the CATEGORIES tab of the Company Portal website.
You can find updated screenshots [here](https://gallery.technet.microsoft.com/Improvements-in-how-iOS-d1104186).
<!---TFS 1317133--->

**Prompt to install the iOS Managed Browser app if IT Pro sets that requirement for an app**<br/>
If you have configured a web clip to open only in the managed browser, and the managed browser is not installed on a device, the Company Portal app on the device will prompt the user to install the managed browser before the web clip can be installed. 
<!---TFS 1228570--->

### Windows
**Feedback button added to Windows Phone 8.1 Company Portal app**<br/>
The Windows Phone 8.1 Company Portal app enables end users to send feedback about the app by using a new "send feedback" button. To find the button, users tap the “three dots” menu at the bottom right of the Company Portal app screen and then tap **send feedback**. The collected, anonymized feedback will help Microsoft improve the Company Portal app experience for users.
<!---TFS 1317806--->


## What's coming

### Intune Groups transitioning to Azure Active Directory Groups
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

### New Conditional Access app policies for Exchange Online and SharePoint Online
You will be able to restrict access to Exchange Online and SharePoint Online so that access can come only from Office mobile apps such as Outlook, Word, Excel, and OneDrive. This new feature pairs up perfectly with Intune mobile app management (MAM) policies as you can block access to built-in mail clients or other apps that have not been configured with the Intune MAM policies. This ensures your users are accessing your organization’s data with apps that can be protected using Intune MAM. You can get started in Intune mobile app management via the Azure portal. Look for the new Conditional Access section in the “Settings” blade.



### Service deprecation

- **Company Portal apps for Windows 8 and Windows Phone 8 are being deprecated** <br/>
Starting in October 2016, Microsoft Intune will deprecate support for Windows 8 and Windows Phone 8 Company Portal apps. Microsoft Intune will also deprecate support for the Windows Phone 8 platform. As a consequence, you will not be able to enroll or update any Windows Phone 8 devices. You can continue to manage Windows Phone 8 and Windows 8 devices that are already enrolled. Update Windows Phone 8 and Windows 8 devices to Windows 8.1 and Windows Phone 8.1, and use the corresponding Windows 8.1 and Windows Phone 8.1 Company Portal apps to continue distributing apps to these devices without disruptions.



### Cloud roadmap
Keep informed about upcoming developments for Intune with the [Cloud Platform roadmap](http://www.microsoft.com/en-us/server-cloud/roadmap/Indevelopment.aspx?TabIndex=0&dropValue=Intune).


## Previous Intune releases
If you want to see what's released in Intune during the last six months, they are listed in the [Previous Intune releases](previous-intune-releases.md) article.

### See also
* [Microsoft Intune Blog](http://go.microsoft.com/fwlink/?LinkID=273882)
* [Cloud Platform roadmap](http://www.microsoft.com/en-us/server-cloud/roadmap/Indevelopment.aspx?TabIndex=0&dropValue=Intune)
