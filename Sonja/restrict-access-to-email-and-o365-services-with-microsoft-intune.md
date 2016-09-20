---
# required metadata

title: Restrict access to email and O365 services | Microsoft Intune
description: This topic describes how conditional can be used to allow only compliant devices to access company email and company data on SharePoint Online and other services.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: c564d292-b83b-440d-bf08-3f5b299b7a5e

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Restrict access to email, O365, and other services with Microsoft Intune
You can restrict access to your company email and O365 services with Intune's conditional access. Intune's conditional access capability allows you to make sure that access to your company email and O365 services is restricted to devices that are compliant with the rules that you set.
## How does conditional access work?
Compliance policy settings are used to evaluate the compliance of the device. Conditional access policy uses the evaluation to restrict or allow access to a specific service. When a conditional access policy is used in combination with a compliance policy, only compliant devices will be allowed to access the service. The compliance policy and the conditional access policy are deployed to the user. Any device that the user uses to access the services is checked for compliance with the policies.

Keep in mind that the user who is using the device must have a compliance policy deployed to them in order for the device to be evaluated for compliance.
If no compliance policy is deployed to the user the device is treated as compliant, and no access restrictions will be applied.

When devices do not meet the conditions set in the policies, the end user is guided though the process of enrolling the device and fixing the issue that prevents the device from being compliant.

A typical flow of conditional access:

![Diagram shows the decision points used to determine whether a device is allowed access to a service or is blocked](../media/ConditionalAccess4.png)

## How to configure conditional access?
Use conditional access to manage access to Microsoft **Exchange On-premises**, **Exchange Online**, **Exchange Online Dedicated**,  **SharePoint Online** and **Skype for Business Online**.

To set up conditional access, configure a device compliance policy, and a conditional access policy.

The compliance policy includes settings like passcode, encryption, and whether or not a device is jailbroken. The device must meet these rules in order to be considered compliant.

You can set a conditional access policy to restrict access based on:
- The device compliance status.
- The platform running on the device.
- The type of apps used to access the services.

Unlike other Intune policies, you do not deploy conditional access policies. Instead, once you configure the policy and select the users that should have the policy, the policy is applied to all targeted users. When a user is targeted by a policy, each device they use must be compliant in order to access resources.


## Next steps
1. [Learn about device compliance policy and how it works ](introduction-to-device-compliance-policies-in-microsoft-intune.md)

2. [Create a compliance policy](create-a-device-compliance-policy-in-microsoft-intune.md)

2.  Create a conditional access policy for one of the following:
> [!div class="op_single_selector"]
  - [Create a conditional access policy for Exchange Online](restrict-access-to-exchange-online-with-microsoft-intune.md)
  - [Create a conditional access policy for Exchange On-premises](restrict-access-to-exchange-onpremises-with-microsoft-intune.md)
  - [Create a conditional access policy for new Exchange Online Dedicated](restrict-access-to-exchange-online-with-microsoft-intune.md)
  - [Create a conditional access policy for legacy Exchange Online Dedicated](restrict-access-to-exchange-onpremises-with-microsoft-intune.md)
  - [Create conditional access policy for SharePoint Online](restrict-access-to-sharepoint-online-with-microsoft-intune.md)
  - [Create conditional access policy for Skype for Business Online](restrict-access-to-skype-for-business-online-with-microsoft-intune.md)
  - [Create conditional access policy for Dynamics CRM Online](restrict-access-to-dynamics-crm-online-with-microsoft-intune.md)
