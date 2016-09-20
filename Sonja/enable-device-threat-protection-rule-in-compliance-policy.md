---
# required metadata

title: Enable device protection rule in compliance policy | Microsoft Intune
description: Enable mobile threat protection rule in the device compliance policy.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service:
ms.technology:
ms.assetid: c951692d-6538-46c0-a9f0-d607ded189ae

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: sandera
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Enable device threat protection rule in the compliance policy
Intune with Lookout mobile threat protection gives you the ability to detect mobile threats and make a risk assessment on the device.  
Compliance policy rule allows you to use this risk assessment to determine if the device is compliant with your policy. You can then use the conditional access policy to allow or block to Exchange, SharePoint, and other services based on device compliance.

To have Lookout MTP threat detection influence the compliance policy for the device:

1.	The  **Device Threat Protection** rule must be enabled on the compliance policy.

2.	The **Lookout Status** page in the Intune Admin console must show **Active**. See the [Enable Lookout MTP connection in Intune](enable-lookout-mtp-connection-in-intune.md) topic for more details and instructions on how to activate Lookout integration.


## Configure device threat protection rule

Before creating the device threat protection rule in the compliancy policy, we recommend that you [set up your subscription with Lookout MTP](set-up-your-subscription-with-lookout-mtp.md), [enable Lookout connection in Intune](enable-lookout-mtp-connection-in-intune.md),and [configure the Lookout for work app](configure-and-deploy-lookout-for-work-apps.md). The compliance rule is only enforced once the setup is completed.

To enable the device threat protection rule, you can either use an existing compliance policy or create a new one.

As part of the Lookout MTP setup, in the [Lookout MTP console](https://aad.lookout.com), you created a policy that classifies various threats into high, medium and low levels. In the Intune compliance policy you will use the threat level to set the maximum allowed threat level.

In the Intune administrator console, in the  compliance policy page, go to **Device Health** and enable the **Device Threat Protection** rule using the toggle option. Then select the maximum allowed threat level, which is one of the following:
* **None (secured)**: This is the most secure.  This means that the device cannot have any threats.  If the device is detected as having any level of threats, it will be evaluated as non-compliant.  
* **Low**: Device is evaluated as compliant if only low level threats are present. Anything higher puts the device in a non-compliant status.
* **Medium**: Device is evaluated as compliant if the threats that are present on the device are low or medium level. If the device is detected to have high level threats, it is determined as non-compliant.
* **High**: This is the least secure. Essentially, this allows all threat levels, and perhaps only useful if you using this solution only  for reporting purposes.

![screenshot showing the device threat protection rule setting in ](../media/mtp/mtp-compliance-policy-rule.png)

![screenshot showing the threat level option for the device threat protection rule setting](../media/mtp/mtp-compliance-policy-setting.png)

If you create conditional access policies for O365 and other services, the above compliance evaluation is taken into consideration and non-compliant devices are blocked access until the threat is resolved.

You can see the compliance state of a device on the devices page of the Intune administrator console.

![screenshot of the devices page in the Intune admin console showing the compliance status of a device](../media/mtp/mtp-device-status-intune-console.png)

## Next steps
* Create conditional access policy
  * [Exchange Online](restrict-access-to-exchange-online-with-microsoft-intune.md)
  * [Exchange On-premises](restrict-access-to-exchange-onpremises-with-microsoft-intune.md)
  * [SharePoint Online](restrict-access-to-sharepoint-online-with-microsoft-intune.md)
  * [Skype for Business Online](restrict-access-to-skype-for-business-online-with-microsoft-intune,md)
  * [Dynamics CRM](restrict-access-to-dynamics-crm-online-with-microsoft-intune.md)
