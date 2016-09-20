---
# required metadata

title: Multi-factor authentication using Azure AD| Microsoft Intune
description: How to require multi-factor authentication in Azure AD for device enrollment.
keywords:
author: nbigman
manager: angerobe
ms.date: 08/17/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: 47abdabd-dcd6-48d8-aade-3f3eefb92ee1

# optional metadata

ROBOTS: NOINDEX,NOFOLLOW
#audience:
#ms.devlang:
#ms.reviewer: damionw
#ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Multi-factor authentication for Microsoft Intune

Intune integrates Azure AD multi-factor authentication (MFA) for device enrollment to help you secure your corporate resources. MFA requires authentication factors like text authentication in addition to user names and passwords. This is supported for iOS, Android, Windows 8.1 or later, or Windows Phone 8.1 or later devices.

> [!NOTE]
>
> In older versions of Configuration Manager (earlier than release 1610), you will still see the MFA setting in the Configuration Manager admin console. Do not attempt to configure MFA in the Configuration Manager admin console, as it will not work. Configure MFA as described in this topic.

### Configuring Intune to require multi-factor authentication at device enrollment
To require MFA at device enrollment, follow these steps:

1. Sign in to your [Microsoft Azure portal](https://manage.windowsazure.com) with your admin credentials.
2. Choose your tenant.
2. Choose the **applications** tab. You will see a list of services for which you can configure Azure AD security features.
3. Choose **Microsoft Intune enrollment**.
4. Choose **Configure**. 
5. Under **multi-factor authentication and location-based access rules** you can:
	-  Enable the access rules
	-  Choose whether to apply the rules to all users or to specific Azure AD security groups.
	-  Require multi-factor authentication for enrollment of all devices.
	-  Require multi-factor authentication for enrollment when the device is not at work.
	-  Choose **Block access to corporate resources** to prevent enrollment of a device when it is not connected to the corporate network. 
4. You can also click the link to **define/edit your work network location**, to configure network connectivity requirements for device enrollment.
> [!IMPORTANT]
> 
> Do not configure **Device based access rules** for Microsoft Intune Enrollment.
