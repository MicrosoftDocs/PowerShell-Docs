---
# required metadata

title: Restrict access to Skype for Business Online | Microsoft Intune
description: Protect and control access to Skype for Business Online with conditional access.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 1b2d7125-f63f-43cf-ac1e-94fbedf2a7e8

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Restrict access to Skype for Business Online with Microsoft Intune
Use conditional access policy for  **Skype for Business Online** to control access to Skype for Business Online.
Conditional access has two components:
- Device compliance policy that the device must comply with in order to be considered compliant.
- Conditional access policy that where you specify the conditions that the device must meet in order to access the service.
To learn more about how conditional access works, read the [restrict access to email and O365 services](restrict-access-to-email-and-o365-services-with-microsoft-intune.md) article.

When a targeted user attempts to use Skype for Business Online on their device, the following evaluation occurs:

![Diagram that shows the decision points that is used to determine if a device is allowed access to Skype for Business Online or blocked](../media/ConditionalAccess_SkypeforBusiness.png)

**Before** configuring a conditional access policy for Skype for Business Online, you must:
- Have a **Skype for Business Online subscription** and assign Skype for Business Online license to users.
- Have a subscription for the **Enterprise Mobility Suite** or **Azure Active Directory Premium**.
-   [Enable modern authentication](https://docs.microsoft.com/en-us/intune/deploy-use/restrict-access-to-skype-for-business-online-with-microsoft-intune) for Skype for Business Online.
-  All your end users must be using **Skype for Business Online**. If you have a deployment with both Skype for Business Online and Skype for Business on-premises, conditional access policy will not be applied to end users.

    The device that needs access to Skype for Business Online must:

-   Be an **Android** or **iOS** device.

-   Be **enrolled** with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)].

-   Be **compliant** with any deployed [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] compliance policies.


The device state is stored in Azure Active Directory which grants or blocks access, based on the conditions you specify.

If a condition is not met, the user is presented with one of the following messages when they log in:

-   If the device is not enrolled with [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)], or is not registered in Azure Active Directory, a message is displayed with instructions about how to install the company portal app and enroll.

-   If the device is not compliant, a message is displayed that directs the user to the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] Company Portal website or Company Portal app where they can find information about the problem, and how to remediate it.

## Configure conditional access for Skype for Business Online

### Step 1: Configure Active Directory security groups
Before you start, configure Azure Active Directory security groups for the conditional access policy. You can configure these groups in the **Office 365 admin center**. These groups will be used to target, or exempt users from the policy. When a user is targeted by a policy, each device they use must be compliant in order to access resources.

You can specify two group types to use for the Skype for Business policy:

-   **Targeted groups** – Contains groups of users to which the policy will apply.

-   **Exempted groups** – Contains groups of users that are exempt from the policy.

If a user is in both groups, they will be exempt from the policy.

### Step 2: Configure and deploy a compliance policy
[Create](create-a-device-compliance-policy-in-microsoft-intune.md) and [deploy](deploy-and-monitor-a-device-compliance-policy-in-microsoft-intune.md) a compliance policy to all devices that will be affected by the policy. These would be all the devices that are used by the users in the **Targeted groups**.

> [!NOTE]
> While compliance policies are deployed to [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] groups, conditional access policies are targeted to Azure Active Directory security groups.


> [!IMPORTANT]
> If you have not deployed a compliance policy, the devices will be treated as compliant.

When you are ready, continue to **Step 3**.

### Step 3: Configure the Skype for Business Online policy
Next, configure the policy to require that only managed and compliant devices can access Skype for Business Online. This policy will be will be stored in Azure Active Directory.

####
1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), click **Policy** > **Conditional Access** > **Skype for Business Online Policy**.

![Screenshot of Skype for Business Online conditional access policy page](./media/conditional_access_SFBPolicy.png)

2.  Select **Enable conditional access policy**.

3.  Under **Application access**, you can choose to apply conditional access policy to:

    -   **iOS**

    -   **Android**

4.  Under **Targeted Groups**, click **Modify** to select the Azure Active Directory security groups to which the policy will apply. You can choose to target this to all users or just a select group of users.

5.  Under **Exempted Groups**, optionally, click **Modify** to select the Azure Active Directory security groups that are exempt from this policy.

6.  When you are done, click **Save**.

You have now configured conditional access for Skype for Business Online. You do not have to deploy the conditional access policy, it takes effect immediately.


## Monitor the compliance and conditional access policies
In the **Groups** workspace, you can view the conditional access status of your devices.

Select any mobile device group and then, on the **Devices** tab, select one of the following **Filters**:

* **Devices that are not registered with AAD** – These devices are blocked from Skype for Business Online.

* **Devices that are not compliant** – These devices are blocked from Skype for Business Online.

* **Devices that are registered with AAD and compliant** – These devices can access Skype for Business Online.
