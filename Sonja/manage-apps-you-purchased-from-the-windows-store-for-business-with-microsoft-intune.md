---
# required metadata

title: Manage Windows Store for Business apps | Microsoft Intune
description: Connect Microsoft Intune to the Windows Store for Business if you want to manage and deploy volume-purchased apps from the Intune console
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8e38d47d-0c5e-40ce-b379-29d3657f5c28

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage apps you purchased from the Windows Store for Business with Microsoft Intune
The [Windows Store for Business](https://www.microsoft.com/business-store) gives you a place to find and purchase apps for your organization, individually, or in volume. By connecting the store to Microsoft Intune, you can manage volume-purchased apps from the Intune console. For example:
* You can synchronize the list of apps you have purchased from the store with Intune.
* Apps that are synchronized appear in the Intune administration console, and you can deploy these like any other apps.
* You can track how many licenses are available, and how many are being used in the Intune administration console.
* Intune blocks deployment and installation of apps if there are an insufficient number of licenses available.

## Before you start
Review the following information before you start syncing and deploying apps from the Windows Store for Business:
* You must configure Intune as the mobile device management authority for your organization. For more information, see [Get ready to enroll devices in Microsoft Intune](get-ready-to-enroll-devices-in-microsoft-intune.md).
* You must have signed up for an account on the Windows Store for Business.
* Once you have associated a Windows Business Store account with Intune, you cannot change to a different account in the future.
* Apps purchased from the store cannot be manually added to or deleted from Intune. They can only be synchronized with the Windows Store for Business.
* Intune synchronizes only online licensed apps you have purchased from the Windows Store for Business.
* Devices must be joined to Active Directory Domain Services, or workplace-joined, to use this capability.
* Enrolled devices must be using the 1511 release of Windows 10.

## Associate your Windows Store for Business account with Intune
Before you enable synchronization in the Intune console, you must configure your store account to use Intune as a management tool:
1. Ensure that you sign into the Business Store using the same tenant account you use to sign into Intune.
2. In the Business Store, choose **Settings** > **Management tools**.
3. On the Management tools page, choose **Add a management tool**, and choose **Microsoft Intune**.

You can now continue, and set up synchronization in the Intune console.

## Configure synchronization

1. In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Admin**.
2. In the **Administration** workspace, expand **Mobile Device Management**, and then choose **Store for Business**.
3. On the **Windows Store for Business** page, do the following:
 * If you haven't already done so, click the link to sign-up for the Windows Store for Business.
 * Once you are signed-up, choose **Configure Sync**.
4. In the **Configure Windows Store for Business app sync** dialog box, select **Enable Windows Store for Business sync**.
5. From the **Language** drop-down list, choose the language in which apps from the Windows Store for Business will be displayed in the Intune console. Regardless of the language in which they are displayed, they will be installed in the end user's language when available.
6. Click **OK**.

## Synchronize apps

1. On the **Windows Store for Business** page, choose **Sync now** to synchronize the apps you've purchased from the store with Intune.
2. In the **Apps** workspace, choose **Managed Software** > **Licensed Software** to view the available apps, and to verify that your purchased apps were imported correctly. The apps in this node are displayed with the total number of licenses you own, and the number of licenses you have available.

## Deploy apps

You deploy apps from the store in the same way you deploy any other Intune app. For more information, see [Deploy apps in Microsoft Intune](deploy-apps-in-microsoft-intune.md).
When you deploy a Windows Store for Business app, a license is used by each user who installs the app. If you use all of the available licenses for a deployed app, you will not be able to deploy any more copies. You must take one of the following actions:
* Uninstall the app from some devices.
* Reduce the scope of the current deployment to target only the users you have sufficient licenses for.
* Buy more copies of the app from the Windows Store for Business.

> [!Important]
> Deployed apps are only available to the user who originally enrolled the device. No other users can access the app.


### See also
[Add apps for mobile devices in Microsoft Intune](add-apps-for-mobile-devices-in-microsoft-intune.md)
