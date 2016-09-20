
---
# required metadata

title: App provisioning profiles | Microsoft Intune
description: Intune gives you the tools to proactively deploy a new provisioning profile policy to devices that have apps that are nearing expiry.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 86fbe736-7bdb-4f5e-ae21-13c91eb2462c

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Use iOS mobile provisioning profile policies to prevent your apps from expiring


Apple iOS line of business apps that are deployed to iPhones and iPads are built with an included provisioning profile and code that is signed with a certificate. When the app is run, iOS confirms the integrity of the iOS app and enforces policies that are defined by the provisioning profile. The following validations happen:

- **Installation file integrity** - iOS compares the app's details with the enterprise signing certificate's public key. If they differ, the app's content might have changed, and the app will not be allowed to run.
- **Capabilities enforcement** - iOS attempts to enforce the app's capabilities from the enterprise provisioning profile (not individual developer provisioning profiles) that are in the app installation (.ipa) file.


The enterprise signing certificate that you use to sign apps typically lasts for three years. However, the provisioning profile expires after a year. While the certificate is still valid, Intune gives you the tools to proactively deploy a new provisioning profile policy to devices that have apps that are nearing expiry.
After the certificate expires, you must sign the app again with a new certificate and embed a new provisioning profile with the key of the new certificate.



## How to find out when a line of business app will expire

1. In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Apps** > **Apps**.
2. In the list of apps, look at the **Expiration date** column to see the expiry date for the app. You can also set the **Filters** drop-down list to **Expired/about to expire** to see only the apps for which you must take action.

## How to create an iOS mobile provisioning profile policy


1. In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** > **Overview** > **Add Policy**.
2. In the **Create a New Policy** dialog box, choose **iOS** > **Mobile Provisioning Profile Policy**, and then choose **Create Policy**.
3. On the **General** page, configure the following values:
	- **Name** - Provide a name for this mobile provisioning profile policy.
	- **Description** - Optionally, provide a description for the policy.
	- **Configuration profile file** - Click **Import**, and then choose an Apple Mobile Configuration Profile file (with the extension **.mobileprovision**) that you downloaded from the Apple Developer website.
4. When you are done, choose **Save Policy**.
5. Now, deploy the policy to the required iOS devices. For more information, see [Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies).
