---
# required metadata

title: Restrict access to email example scenarios | Microsoft Intune
description: A few example scenarios and how they could be implemented with conditional access.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 454eab79-b620-42c9-b8e6-fada6e719fcd

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Restrict access to email with Microsoft Intune: Example scenarios

## Block users from using noncompliant devices to access Exchange Online.
### Scenario requirements
- All users in the **Accounting** Active Directory security group must be blocked from accessing Exchange Online if their device is not compliant with a compliance policy you deployed.
- If any users exist in this group whose devices are not supported by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)], they must be blocked from accessing Exchange Online on that device.
- Users in the **Finance** Active Directory security group must be exempt from the policy, even if they are also in the **Accounting** security group.

To accomplish this, configure a conditional access policy for Exchange Online with the following settings:

-   Select **Enable conditional access policy**.

- Select the platforms that you want to allow access from apps with modern authentication.
- For Exchange ActiveSync apps, select **Block noncompliant devices on platforms supported by Microsoft Intune** and **Block all other devices on platforms not supported by Microsoft Intune.**
-   In the **Targeted group** section, under **Selected security groups** choose the **Accounting** user group.

-   In the **Exempted group** section, under **Selected security groups** choose the  **Finance** user group.


The following flow is used to decide which devices can access Exchange Online:

![Device access flow](./media/ConditionalAccess8-5.png)

## All iOS devices that access Exchange on-premises must be managed by Intune
### Scenario requirements
- Only devices that run iOS should allowed access to Exchange on-premises.
- The devices must also be enrolled in Intune and meet the compliance policy rules before they can be used to access Exchange.

To accomplish this, configure the following conditional access policy for Exchange on-premises with the following settings:

-   Select the option **Block email apps from accessing Exchange on-premises if the device in noncompliant or not enrolled in Microsoft Intune**. By selecting this option, the conditional access policy is enabled, which requires that all devices must be enrolled in Microsoft Intune and meet the compliancy policy rules before they can access Exchange.

-   For advanced Exchange Active Sync settings, create a:

  -   A platform exception that allows devices that run iOS to access Exchange.   

  -   A default rule that specifies when a device is not covered by the platform exception rule, it should be blocked from accessing Exchange. This rule makes sure that devices not running iOS are blocked from accessing Exchange.

The following flow is used to decide which devices can access Exchange:

![Device access flow](./media/ConditionalAccess8-3.png)

## No Android devices can access Exchange on-premises.
### Scenario requirements
- All Android devices should blocked from accessing Exchange.
- All other supported devices can access Exchange as long as they are managed by [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)].

To accomplish this, configure a conditional access policy for Exchange on-premises with the following settings:

-   Select the option **Block email apps from accessing Exchange on-premises if the device is noncompliant or not enrolled in Microsoft Intune**. By selecting this option, they require that any device must be enrolled in Intune and meet the compliance policy rules.

- For advanced Exchange Active Sync settings, create a:
  -   Platform exception that blocks devices that run Android from accessing Exchange. This rule makes sure that Android devices cannot be used to access Exchange.

  -   Default rule that specifies when a device is not covered by other rules, it should be allowed to access Exchange. This default rule makes sure that devices running platforms other than Android, but supported by Microsoft Intune can be used to access Exchange. They must however be enrolled in Intune and meet the compliance policy rules.

The following flow is used to decide which devices can access Exchange:

![Device access flow](./media/ConditionalAccess8-4.png)
