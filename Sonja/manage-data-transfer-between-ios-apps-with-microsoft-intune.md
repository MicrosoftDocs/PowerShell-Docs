---
# required metadata

title: Manage data transfer between iOS apps | Microsoft Intune
description: Use this topic to understand how you can use the iOS Open in feature and mobile app management policies to manage data transfers between apps.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 3a4515c1-b325-4ac1-9f0a-45ac27e00681

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage data transfer between iOS apps with Microsoft Intune
## Manage iOS apps
Protecting your company data includes making sure that file transfers are restricted to apps that are managed by you.  You can manage iOS apps in the following ways:

-   Prevent company data loss  by configuring a MAM policy for the apps, which we will refer to as **policy-managed**  apps.

-   You can also deploy and manage apps through the **MDM channel**.  This requires that the devices are enrolled in the MDM solution. These can be **policy-managed**  apps or other managed  apps.

The **Open in management** feature for iOS devices can limit file transfers between apps that are deployed through the **MDM channel**. Open in management restrictions are set in configuration settings and deployed using your MDM solution.  When the user installs the deployed app, the restrictions you set are applied.
##  Using MAM with iOS apps
Mobile app management (MAM) policies can be used with the iOS **Open in management** feature to protect company data in the following ways:

-   **Employee owned devices not managed by any MDM solution:** You can set the MAM policy settings to **Allow app to transfer data to only managed apps**. When the end user opens a protected file in an app that is not policy-managed, the file is unreadable.

-   **Devices managed by Intune:** For devices enrolled in Intune, data transfer between apps with MAM policies and other managed iOS apps deployed through Intune is allowed  automatically. To allow data transfer between apps with MAM policies, enable the **Allow app to transfer data to only managed apps** setting. You can use the **Open in management** feature to control data transfer between apps that are deployed through Intune.   

-   **Devices managed by a third party MDM solution:** You can restrict data transfer to only managed apps by using the iOS **Open in management** feature.
To make sure that apps that you deploy using your third party MDM solution are also associated with the MAM policies you have configured in Intune, you must configure the user UPN setting as described in the [Configure user UPN setting](#configure-user-upn-setting) walkthrough.  When apps are deployed with the user UPN setting, the MAM policies are applied to the app when the end user signs-in using their work account.

> [!IMPORTANT]
> The user UPN setting is only required for apps deployed to devices managed by a third-party MDM.  For Intune managed devices, this setting is not required.

## Configure user UPN setting
This configuration is required for devices that are managed by a third-party MDM solution. The procedure described below is a general flow on how to implement the UPN setting and the resulting end user experience:


1.  In the Azure portal, [configure a mobile app management policy](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md) for iOS platform. Configure policy settings per your company requirements and select the apps that should have this policy.

2.  Deploy the apps and the email profile that you want managed **through your third-party MDM solution** using the setting described in steps 3 and 4.

3.  Deploy the app with the following app configuration settings: key=IntuneMAMUPN, Value=<username@company.com> [example: ‘IntuneMAMUPN’, ‘jondoe@microsoft.com’]

4.  Deploy the Open in management policy to enrolled devices.

### Example end user experience

1.  End user installs Microsoft Word app on the device.

2.  End user launches the managed native email app to access their email.

3.  End user tries to open document from native mail in Microsoft Word.

4.  When the Word app launches, the end user is prompted to log in using their work account.  This work account the end user enters when prompted should match account you specified in the configured in the app configuration settings for the Microsoft Word app.

    > [!NOTE]
    > The end user can add other personal accounts to Word to do their personal work and not be affected by the MAM policies when using the Word app in a personal context.

5.  When the login is successful, the app policy settings are applied to the Word app.

6.  Now the data transfer succeeds and the document is tagged as corporate identity in the app. In addition, the data is treated in a work context and the policy settings are applied accordingly.

### See also
[Protect app data using mobile app management policies with Microsoft Intune](protect-app-data-using-mobile-app-management-policies-with-microsoft-intune.md)
