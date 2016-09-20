---
# required metadata

title: Manage volume-purchased iOS apps | Microsoft Intune
description: Use Intune to manage apps that you volume purchased from Apple by importing the license information from the app store, tracking how many of the licenses you have used, and preventing you from installing more copies of the app than you own.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/08/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 1dafc28a-7f8b-4fe0-8619-f977c93d1140

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage iOS apps you purchased through a volume-purchase program with Microsoft Intune
The iOS app store lets you purchase multiple licenses for an app that you want to run in your company. This helps you reduce the administrative overhead of tracking multiple purchased copies of apps.

Microsoft Intune helps you manage apps that you purchased through this program by importing the license information from the app store, tracking how many of the licenses you have used, and preventing you from installing more copies of the app than you own.

> [!Important]
> Currently, Intune assigns iOS Volume Purchase Program for Business (VPP) app licenses to users and not devices. Because of this, users must enter their Apple ID password to install the app.

## Manage volume-purchased apps for iOS devices
You purchase multiple licenses for iOS apps through the [Apple Volume Purchase Program for Business](http://www.apple.com/business/vpp/). This involves setting up an Apple VPP account from the Apple website and uploading the Apple VPP token to Intune.  You can then synchronize your volume purchase information with Intune and track your volume-purchased app use.

## Before you start
Before you start, you'll need to get a VPP token from Apple and upload this to your Intune account. Additionally, you should understand the following:

* Each organization can have only one VPP account and token.
* After you associate an Apple VPP account to Intune, you cannot associate a different account later. For this reason, it's very important that more than one person has the details of the account that you use.
* If you previously used a VPP token with a different product, you must generate a new one to use with Intune.
* Each token is valid for one year.
* By default, Intune syncs with the Apple VPP service twice a day. You can start a manual sync at any time.
* After you have imported the VPP token to Intune, do not import the same token to any other device management solution. Doing so might result in the loss of license assignment and user records.
* Before you start to use iOS VPP with Intune, remove any existing VPP user accounts created with other mobile device management (MDM) vendors. Intune will not synchronize those user accounts into Intune as a security measure. Intune will only synchronize data from the Apple VPP service that Intune created.
* You cannot deploy iOS VPP apps to devices that were enrolled using the Device Enrollment Protocol (DEP).

## To get and upload an Apple VPP token

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Admin** &gt; **iOS and Mac OS X** &gt;  **Volume Purchase Program**.

2.  Choose the **Apple VPP Account** link. If you haven't already, sign up for the Volume Purchase Program for Business. After you sign up, download the Apple VPP token for your account.

3.  On the **Manage Apple Volume Purchase Program (VPP)** page of the Intune console, choose **Upload the VPP token**.

4.  In the **Upload the VPP token** dialog box, enter or paste the VPP token name and your Apple ID, and then choose **Upload**.

5.  In the warning dialog box, check the box to indicate that you understand that you can't change to a different VPP account later, and then choose **Yes**.

On the **Volume Purchase Program** page, you can now view information about the Apple VPP token, including when it was last updated, when it will expire, and when it was last synchronized with Intune.

You can synchronize the data held by Apple with Intune at any time by choosing **Sync now**.

## To deploy a volume-purchased app

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Apps** &gt; **Managed Software** &gt; **Volume-Purchased apps**. This list shows all apps that were synchronized from the Apple VPP service.

2.  Choose the app that you want to deploy, choose **Manage Deployment**, and then use the instructions in the [Deploy apps in Microsoft Intune](deploy-apps-in-microsoft-intune.md) topic to finish uploading, creation, and deployment of the app.

> [!TIP]
> You must choose a deployment action of **Required**. Available installations are not currently supported.

When you deploy the app as a **Required** installation, each user who installs the app uses a license.

To reclaim a license, you must change the deployment action to **Uninstall**. The license will be reclaimed after the app is uninstalled.

When a user with an eligible device first tries to install a VPP app, they will be asked to join the Apple Volume Purchase program. They must do this before the app installation proceeds.

> [!TIP]
> Look at the **VPP Terms Status** column to see the acceptance status for each user to whom the app was deployed.

If there are no more licenses available, the deployment will fail.

## To monitor Apple VPP apps
You can monitor which VPP apps have been deployed, and how many licenses are used, from the **Apps** workspace in the **Managed Software** &gt; **Volume-Purchased Apps** node.

> [!TIP]
> You can also use app **Filters** to examine the status of each app installation.

### See also
[Deploy apps in Microsoft Intune](deploy-apps-in-microsoft-intune.md)
