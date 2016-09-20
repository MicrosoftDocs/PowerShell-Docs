---
# required metadata

title: Update apps | Microsoft Intune
description: Use the information in this topic to understand how to update apps when a new version is required.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/12/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: beee6933-876a-4be0-b395-4c24cfbd519b

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Update apps using Microsoft Intune
Microsoft Intune can help you manage app updates. Use the information in this topic to understand how to update apps when a new version is required.

## How to update apps
When a new version of an app that you've deployed is released, Intune lets you update and deploy the newer version of the app. You can only replace a deployment with a newer version of the same app (that has the same identifier). You cannot use app updates to update a deployment with a different app package.

### App identifiers
The app identifier is a property that uniquely identifies an app. You cannot install multiple copies of an app with the same identifier. Following are some examples of app identifiers:

- **iOS** - Bundle ID (for example: com.microsoft.excel)
- **Android** - Package ID (for example: com.microsoft.excel)
- **Windows Phone** - (xap installer) use Product ID (GUID)
- **Windows** - (appx/appxbundle), use the Package Full Name



> [!IMPORTANT]
> When you deploy an app with a deployment action of **Required install** and later change the deployment action to **Available install**, updates to the app are not automatically installed on devices that installed the app before the deployment change was made. To fix this issue, you can do the following:
>
> -   Have the user of the device go to the company portal, select the installed app, and then choose **Install**.
> -   Change the deployment action to **Uninstall**, and after the app has been uninstalled, redeploy the app with a deployment action of **Available install**.

### To update an app

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Apps** &gt; **Apps**.

2.  From the **Apps** list, select the app you want to update, and then choose **Edit**.

3.  In the **Edit Software** wizard, supply any new details for the app package.

4.  When you are finished, choose **Update**.

When devices next check for available apps, the app will be automatically updated to the latest version.
For apps installed from an app package (line of business apps), the app will be upgraded automatically for both required and available deployments, as long as the app has the same identifier.

For apps deployed as a link to a store, the update is managed by the store from which the app originates.
