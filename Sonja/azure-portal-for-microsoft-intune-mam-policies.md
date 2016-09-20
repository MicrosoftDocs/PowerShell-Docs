---
# required metadata

title: Azure portal for MAM policies | Microsoft Intune
description: Create mobile app management policies using the Azure portal. The policies you create here can be applied to devices with or without enrollment in Intune.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/22/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 7d6dae94-a833-40b7-9016-14ea234bb33c

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Azure portal for Microsoft Intune MAM policies
## Accessing the Azure  portal
The **Azure  portal** allows you create and manage mobile app management policies.

Azure portal supports creating MAM policies for:
- Apps running on devices **enrolled and managed by Intune**.
- Apps running on devices that are **not enrolled** in any MDM solution.
- Apps running on devices that are **enrolled in a third party MDM solution**.

>[!IMPORTANT]

> If you are currently using the Intune admin console to manage your devices, you can create a MAM policy that supports apps for devices enrolled in Intune using the [Intune admin console](configure-and-deploy-mobile-application-management-policies-in-the-microsoft-intune-console.md).

> You may not see all MAM policy settings in the Intune admin console. The Azure portal is the new admin console for creating MAM policies.If you create MAM policies on both Intune admin console and Azure portal, the policy in the Azure portal is applied to the apps and deployed to users.

## Login to the Azure portal and customize your start page

1.  Go the [Azure  portal](https://portal.azure.com) and sign in with  your [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] credentials.

    ![Screenshot of the Azure portal log in page](../media/AppManagement/AzurePortal_MAMSigninPage.png)

2.  Once you are successfully signed in, you will see the **Dashboard**. The **Dashboard** page can be customized.

    ![Screenshot of the Azure portal dashboard](../media/AppManagement/AzurePortal_MAMStartboard_NoMAM.png)

3.  From the **Browse** menu, find **Intune**.![Screenshot of the Browse menu with Intune highlighted](../media/AppManagement/AzurePortal_MAM_Browse_Intune.png)

4.  Choose **Intune > Intune mobile application management > Settings**.

    ![Screenshot of the Intune mobile application management blade](../media/AppManagement/AzurePortal_MAM_Mainblade.png)

    > [!TIP]
    > To pin a blade to the **Start** page, you can use the **pin** option on the blade.  Click the pin icon on the **Intune mobile application management blade**, to pin it to the **Start** page.

    ![Screenshot of the Intune mobile application management blade with the pin icon highlighted](../media/AppManagement/AzurePortal_MAM_PinBladeAction.png)

    ![Screenshot of the dashboard with the pinned Intune tile](../media/AppManagement/AzurePortal_MAM_Startboard_withMAM.png)
## Next steps
[Get ready to configure mobile app management policies](get-ready-to-configure-mobile-app-management-policies-with-microsoft-intune.md)
