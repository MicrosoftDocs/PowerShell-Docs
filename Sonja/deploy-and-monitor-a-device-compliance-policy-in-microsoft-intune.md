---
# required metadata

title: Deploy and monitor a compliance policy | Microsoft Intune
description: Use the step-by-step instructions in this topic to deploy and monitor a device compliance policy.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/18/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: d8f246d4-0d86-4c8b-a1bf-9977985506d8

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Deploy and monitor a device compliance policy in Microsoft Intune
## Deploy a compliance policy
Deploy the compliance policy you [created](create-a-device-compliance-policy-in-microsoft-intune.md) to one or more groups of users in your organization. When a compliance policy is deployed to a user, the user's devices are checked for compliance.

1.  In the **Policy** workspace, select the policy you want to deploy, then choose **Manage Deployment**.
![Screenshot of the compliance policy page showing the Manage Deployment menu option at the top](./media/intune-sa-3c-deploy-compliance-policy2.png)

2.  In the **Manage Deployment** dialog box, choose one or more groups to which you want to deploy the policy, then choose **Add > OK**.
![Screenshot of the manage deployment dialog box](./media/intune-sa-3d-deploy-compliance-policy3-Manage.png)
You can deploy a compliance policy to users. Use Active Directory groups that you have already created and synced to Intune, or create these groups manually in the Intune console. To learn more about how to deploy policies, see [deploy a configuration policy](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).

Use the status summary and alerts on the **Overview** page of the **Policy** workspace to identify issues with the policy that require your attention. Additionally, a status summary appears in the **Dashboard** workspace.

> [!IMPORTANT]
> If you have not deployed a compliance policy and then enable an Exchange conditional access policy, all targeted devices will be allowed access.

## How Intune policy conflicts are resolved
Policy conflicts  can occur due when multiple Intune policies are applied to a device. If the policy settings overlap, Intune resolves any conflicts using the following rules:

-   If the conflicting settings are from an Intune configuration policy and a compliance policy, the settings in the compliance policy take precedence over the settings in the configuration policy, even if the settings in the configuration policy are more secure.

-   If you have deployed multiple compliance policies, the most secure of these policies will be used.

## Monitor the compliance policy

#### To view devices that do not conform to a compliance policy

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Groups > All Devices**.

2.  Double-click the name of a device in the list of devices.

3.  Choose the **Policy** tab to see a list of the policies for that device.

4.  From the **Filters** drop-down list, select **Does not conform to compliance policy**.
![Screenshot showing the list of options in the filters list](./media/intune-sa-3e-view-device-noncompliance.png)

#### To view the Health Attestation Reports

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Reports**.

2.  In the **Health Attestation Report - Create a new report** page, you can view a report with all the Windows 10 health attestation data collected by Intune. You can also create a report with a subset of the data using filters. The filters can be based on the type of device, operating system, or only a subset of data points.


## Next steps
You can now use the compliance policy with conditional access policies to control access to services in your organization.

[Restrict access to email and O365 services](restrict-access-to-email-and-o365-services-with-microsoft-intune.md)


### See also
[Introduction to device compliance polices in Intune](introduction-to-device-compliance-policies-in-microsoft-intune.md)
