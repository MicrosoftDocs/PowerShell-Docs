---
# required metadata

title: Enable Lookout MTP in Intune | Microsoft Intune
description: Enable Lookout mobile threat protection in the Intune admin console.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: 2f835fd0-4e62-42f3-b7ca-ce8b7ddd40e4

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: sandera
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Enable Lookout MTP connection in the Intune admin console
This topic shows you how to enable the Lookout MTP connection in Intune. You should have already configured the Intune Connector in the Lookout MTP console before doing this step.  If you have not already done so, do the steps described in  [Set up your subscription with Lookout mobile threat protection](set-up-your-subscription-with-lookout-mtp.md).

To enable the Lookout MTP connection in Intune, on the **Administration** page in the [Microsoft Intune administrator console](https://manage.microsoft.com), choose **Third Party Service Integration**. Choose **Lookout status** and enable **Synchronization with MTP** using the toggle button.

![screenshot of the Lookout synchronization page with the enable toggle button highlighted](../media/mtp/lookout-intune-synchronization.png)

This completes the setup of the Lookout and Intune integration in the Intune administrator console.  The next few steps to implement this solution involve deploying the [Lookout for Work apps](configure-and-deploy-lookout-for-work-apps.md) and setting up the [compliance](enable-device-threat-protection-rule-in-compliance-policy.md) policy.

>[!IMPORTANT]
> You **must** configure the Lookout for Work app before creating compliance policy rules and configuring conditional access. This ensures that the app is ready and available for end users to install before they can get access to email or other company resources.
## Next steps
[Configure Lookout for Work app ](configure-and-deploy-lookout-for-work-apps.md)
