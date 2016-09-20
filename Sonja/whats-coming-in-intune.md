---
# required metadata

title: What's coming | Microsoft Intune
description:
keywords:
author: Lindavr
manager: angrobe
ms.date: 08/04/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: f49650f4-31fa-406c-a4da-d8c9a4a8384d

# optional metadata

ROBOTS: NOINDEX,NOFOLLOW
#audience:
#ms.devlang:
ms.reviewer: mamoriss
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# What's coming in Microsoft Intune - August
This information is provided under NDA on an extremely limited basis and is subject to change. Some features listed here are at risk of not making the cutoff dates and may be delayed until a future release. Other features are being tested in a pilot (flighting) to ensure they're customer-ready. Please reach out to your Intune/PM buddy if you have any questions or concerns.

This page is updated periodically. Check back for new What’s Coming updates.

The following changes are under development for Intune. All of these features will eventually be supported for hybrid customers' deployments (Configuration Manager with Intune). For more information about new hybrid features, check out our [hybrid What’s New page](https://technet.microsoft.com/en-US/library/mt718155(TechNet.10).aspx).


## App management
### Hidden and shown apps for iOS 9.3
For supervised devices running iOS 9.3 or later, you will be able to use the hidden and shown apps list in the iOS general configuration policy to:
- Specify a list of apps that will be hidden from users. Users cannot view, or launch these apps.
- Specify a list of apps that users can view and launch. No other apps can be viewed or launched.

The apps you can specify include both apps you have deployed, and the built-in iOS apps like Messages and Notes.
<!---TFS 1279009--->

### Allowed and blocked apps policy for Samsung KNOX devices

You can now configure a custom policy for Samsung KNOX devices that lets you create one of the following:
- A list of apps that are blocked from running on the device. Even if installed, an app defined in the blocked list cannot be activated on the device.
- A list of apps that users of the device are allowed to install from the Google Play store. No other apps can be installed from the store.

These settings can only be used by devices that run Samsung KNOX.
<!--- For details, see [Use custom policies to allow and block apps for Samsung KNOX devices]( custom-policy-to-allow-and-block-samsung-knox-apps.md)--->
<!---TFS 1311629 --->

### New apps compatible with mobile application management (MAM) policies
The Yammer app for [iOS](https://itunes.apple.com/app/yammer/id289559439?mt=8) and [Android](https://play.google.com/store/apps/details?id=com.yammer.v1) will be compatible with [Intune mobile application management (MAM) policies](/intune/deploy-use/protect-app-data-using-mobile-app-management-policies-with-microsoft-intune), whether or not the device is enrolled.

For a full list of MAM compatible apps, see the [Microsoft Intune application partners](https://www.microsoft.com/en-us/cloud-platform/microsoft-intune-partners) site.
<!--- TFS 1252335 & 1252336--->

## Device management
### Android 7.0 support
In August, Intune will provide “day 0” support for the forthcoming Android 7.0 operating system for mobile devices.
<!---TFS 1262053--->
### Google removal of remote passcode reset capability on Android 7.0 devices
Google is removing the ability of IT administrators and end users to remotely reset the passcode of Android 7.0 devices. Previously, IT administrators could remotely reset a user’s passcode, and end users could reset their passcodes from the Company Portal website.

## Group management
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

## Service deprecation
### Company Portal apps for Windows 8 and Windows Phone 8 are being deprecated starting in September 2016
Starting in October 2016, Microsoft Intune will deprecate support for Windows 8 and Windows Phone 8 Company Portal apps. Microsoft Intune will also deprecate support for the Windows Phone 8 platform. As a consequence, you will not be able to enroll or update any Windows Phone 8 devices. You can continue to manage Windows Phone 8 and Windows 8 devices that are already enrolled. Update Windows Phone 8 and Windows 8 devices to Windows 8.1 and Windows Phone 8.1, and use the corresponding Windows 8.1 and Windows Phone 8.1 Company Portal apps to continue distributing apps to these devices without disruptions.
<!---TFS 1255391--->

### Custom Group Targeting of Notification Rules Removal
Intune notification rules define who an email alert will be sent to from Intune. Currently, you can configure notification rules to send emails to all users of devices in an Intune device group that you created. Starting in June 2016, targeting user-created groups will no longer be supported.

The preliminary timeline for this change is as follows:
- In September 2016, new tenants will not see step two of the Create Notification Rule Wizard. Existing tenants are unaffected.
- Around October 2016, some existing tenants will not see the “select device groups” in the wizard.
- At a later date, we expect that all tenants will not see the “select device groups” in the wizard.

<!---	TFS 1278864--->
### Changes in support for the iOS Company Portal app
In September, all users of the Microsoft Intune Company Portal app for iOS will be required to use its latest version. New users will only be able to download the latest version and current users will be required to update to it. The latest version requires iOS 8.0 or later, so devices running older iOS versions won’t be able to use the Company Portal or enroll until they update their device to iOS 8.0 or later and then update the Company Portal app to the latest version. Enrolled devices running versions below iOS 8.0 will continue to be managed and listed in the Intune Admin Console.

<!---TFS 1283165--->


### Intune Viewer apps
With the release of the new RMS sharing app, we will remove the following Intune Viewer apps in August 2016:
- Intune AV Viewer
- Intune PDF Viewer
- Intune Image Viewer for Android from Google Play

Instead of using the Intune Viewer apps, we recommend using the new Rights Management app (RMS sharing) for Android, which allows you to deploy one app instead of three separate apps to securely view corporate files on Android devices. Learn more about the [RMS sharing app](https://docs.microsoft.com/en-us/intune/deploy-use/end-user-experience-for-mam-enabled-apps-with-microsoft-intune#viewing-media-files-with-the-rights-management-sharing-app).
<!--- goes in 1608 What's New--->


### See also
See [What’s New in Microsoft Intune](whats-new-in-microsoft-intune.md) for details on recent developments.
