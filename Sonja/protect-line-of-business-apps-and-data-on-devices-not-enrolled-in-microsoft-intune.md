---
# required metadata

title: Protect LOB apps on devices not enrolled | Microsoft Intune
description: This topic describes how you can prepare your custom line of business apps so you can apply mobile app management policies that can help prevent data loss.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: 00219467-a62e-43b6-954b-3084f54c45ba

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Protect line of business apps and data  on devices not enrolled in Microsoft Intune

Mobile app management (MAM) policies help protect your company data by restricting data movement like copy and paste or by preventing users from saving company documents to a personal location.   To apply MAM policies to iOS and or Android line of business apps, you must first wrap the app with Microsoft Intune App Wrapping tool.  App wrapping is the process of applying a management layer to a mobile app without requiring any changes to the underlying application.  Once the app is wrapped, you can apply MAM policies to it and distribute it to your end-users.  

This topic explains the steps required to apply MAM policies for apps that are accessed on **employee owned devices that are not managed**, and devices that are managed by a **third-party mobile device management (MDM) solution**.  To prepare your line of business apps that run on **devices that are enrolled in Intune**, see [Decide how to prepare apps for mobile application management with Microsoft Intune](decide-how-to-prepare-apps-for-mobile-application-management-with-microsoft-intune.md).
##  Step 1: Prepare the app
Before you can apply MAM policies to an app, you must first wrap the app with the Microsoft Intune App Wrapping tool.  The instructions to install and use the app wrapping tool are included in the download.  
>[!IMPORTANT]  
>This version of the app wrapping tool, which supports devices not enrolled in Intune is available in public preview. If you wish to participate in the public preview, you can download the tool from [this github page](https://github.com/msintuneappsdk/intune-app-wrapper-ios-preview) for iOS and [this github site](https://github.com/msintuneappsdk/intune-app-wrapper-android-preview) for Android.

## Step 2: Add the app

To associate your line-of-business app with MAM policies, you must add the app details to your Intune subscription/tenant using the following steps:

1. In the [Azure portal](https://portal.azure.com/), go to **Intune mobile application management > Settings**, and choose **Line-of-business apps**.

  ![Screenshot of the settings blade with line of business option](../media/mam-azure-portal-lob-on-settings.png)

2. In the **Line-of-business-apps** blade, choose **Add a custom app**.

  ![Screenshot of the line of business apps blade with the Add custom app button at the top](../media/mam-azure-portal-add-lob-app-action.png)
3.	Provide a name for the app, the bundle identifier in the App identifier field, and the platform (iOS or Android).

  ![Screenshot of the Add a custom app blade ](../media/mam-azure-portal-add-app-details.png)
  This step helps create a unique listing of your app.  The app will be also be displayed in the list of Targeted apps for a MAM policy for your tenant, as described in the next step.

## Step 3: Apply MAM policies
Once the app metadata is uploaded to the service, the app will show up in the list of apps.  You can now [create a new policy or an existing policy](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md) and apply it to the line of business app you added in step 2.

>[!IMPORTANT]
>You must target the MAM policy to the users who are going to use the wrapped app.  Users who don’t have this policy deployed to them will not be able to use the
              app.


  ![Screenshot of the Targeted list of apps blade with the new line of business app displayed](../media/mam-azure-portal-lob-on-targeted-app-list.png)
## Step 4: Distribute the app
You can deploy apps to your end-users in the following ways:
* For devices enrolled in a third party MDM solution, you can distribute the apps through your MDM solution.
* For devices not managed by any MDM solution, you will need a custom solution. End-users have to download and install the app on their device.

## Changing the metadata
If you need to change the app details like the name of the app, or the Bundle identifier, you must [remove the app](#remove-apps), and [add it](#step-2-add-the-app) with the new metadata.

##  Remove apps
You can remove a line of business app from the app list.  This will remove the app from the list and remove the association with MAM policies, but will not remove or uninstall the app from the end-user’s device.  

1.	On the [Azure portal](https://portal.azure.com/), go to **Intune mobile app management > Settings**.  On the **Settings** blade, choose **Line-of-business** to open the list of existing apps.  
2.	Select the app that you want to remove, and choose the **(…) context** menu.

  ![Screenshot of the line of business apps blade with the ellipsis](../media/mam-azure-portal-lob-context-menu.png)
3.	Choose **Delete Application** to delete the app.

  ![Screenshot of the line of business blade with the delete application option](../media/mam-azure-portal-delete-app.png)

  This will remove apps from the list of line of business apps and the Targeted list of apps in the MAM policy.
