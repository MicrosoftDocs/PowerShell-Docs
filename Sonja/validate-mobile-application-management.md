---
# required metadata

title: [Validate your MAM setup | Microsoft Intune]
description: This topics describes how you can test and validate if your MAM policy is set up correctly and working as expected.
keywords:
author: karthikaraman
manager: angerobe
ms.date: 08/16/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 41d82597-e13e-4c3e-9151-e71392236ca0

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
#ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Validating your mobile application management setup

This topic provides information on checking for issues after you set up mobile application management (MAM). This guidance applies to MAM policies in the Azure portal.

### Checking for symptoms
Users are unlikely to report issues since MAM is a data protection tool. If there is a problem with the MAM configuration the user will have unrestricted access, as they would have without MAM, and would not be aware that there is an issue. For this reason we recommend that you validate your MAM configuration by piloting your MAM policies with a small group of users who can deliberately test the MAM restrictions. 


### What to check 

If testing shows that your MAM policy behavior is not as anticipated, we recommend that you check the following:

- Are the users licensed for MAM?
- Are the users licensed for O365?
- The status of each of the users' MAM apps. The possible statuses for the apps are **Checked in** and **Not checked in**.

#### User MAM status
1. In the Azure portal choose **Intune mobile application management** > **settings** > **app management** > **All settings** > **App reporting by user** > **users**.

2. Choose a user from the list or search for and choose a user, then choose **Select user**. At the top of the **App reporting** column you will see whether the user is licensed for MAM. Below that you will see whether the user is licensed for O365 and the app status for all of the user's devices.

![App statuts for MAM](..\media\ts-mam-use-apps.png) 

### What to do
Here are the actions to take based on the user status:

- If the user is not licensed for MAM, assign an Intune license to the user as described in [Manage Intune licenses](..\get-started\start-with-a-paid-subscription-to-microsoft-intune).
- If the user is not licensed for O365 obtain a license for the user.
- If a user's app is listed as **Not checked in**, check if you've correctly configured a MAM policy for that app.
- Ensure that these conditions are applied across all users to which you want MAM policies to apply.

### See also
[Get ready to configure mobile app management policies with Microsoft Intune](..\deploy-use\get-ready-to-configure-mobile-app-management-policies-with-microsoft-intune)

[Protect app data using mobile app management policies with Microsoft Intune](..\deploy-use\protect-app-data-using-mobile-app-management-policies-with-microsoft-intune)
