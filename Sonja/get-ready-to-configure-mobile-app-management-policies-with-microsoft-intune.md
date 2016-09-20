---
# required metadata

title: Get ready to configure MAM policies | Microsoft Intune
description: This topic describes the pre-requisites and setting up users before you can create mobile app management policies.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/22/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 7e6a85e7-e007-41b6-9034-64d77f547b87

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: joglocke
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Get ready to configure mobile app management policies with Microsoft Intune
This topic describes what you need to do before you can create mobile app management (MAM) policies in the Azure portal.

The Azure portal is the new admin console for creating MAM policies. We recommend that you use this portal to create MAM  policies. The Azure portal supports the following MAM scenarios:
- Devices that are enrolled in Intune
- Devices that are managed by a third-party MDM solution
- Devices that are not managed by any MDM solution (BYOD)

If you are new to using the Azure portal, read the [Azure portal for Microsoft Intune MAM policies](azure-portal-for-microsoft-intune-mam-policies.md) topic to get a quick overview.

>[!IMPORTANT]

> If you are currently using the Intune admin console to manage your devices, you can create MAM policies that support apps for devices enrolled in Intune by using the Intune admin console. But we recommend that you use the Azure portal, even for devices that are enrolled in Intune. For instructions on how to create a MAM policy by using the Intune admin console, see [Configure and deploy mobile application management policies in the Microsoft Intune console](configure-and-deploy-mobile-application-management-policies-in-the-microsoft-intune-console.md).

> You may not see all MAM policy settings in the Intune admin console. If you create MAM policies in both the Intune admin console and the Azure portal, the policy in the Azure portal is applied to the apps and deployed to users.
> MAM policies that are created in the Intune admin console cannot be imported into the Azure portal.  The MAM policies must be re-created in the Azure portal.


##  Supported platforms
- iOS 8.1 or later

- Android 4 or later

Windows devices are currently not supported.
##  Supported apps
* **Microsoft apps:** These apps have the Intune App SDK built in and require no further processing before you apply MAM policies.
To see the full list of supported Microsoft apps, go to the [Microsoft Intune mobile application gallery](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx) on the Microsoft Intune application partners page. Click an app to see the supported scenarios and platforms, and to see whether the app supports multiple identities.
* **Your organization's line-of-business apps:** These require preparing the apps to include the Intune App SDK before you can apply MAM policies.

  * For devices that are managed by Intune, see [Decide how to prepare apps for MAM](decide-how-to-prepare-apps-for-mobile-application-management-with-microsoft-intune.md).
  * For devices that are not managed (like employee-owned devices), or for devices that are managed by a third-party mobile device management solution, see [Protect line-of-business apps and data on devices not enrolled in Intune](protect-line-of-business-apps-and-data-on-devices-not-enrolled-in-microsoft-intune.md).

*Before* you can configure MAM policies, you need the following:

-   A subscription to Microsoft Intune.    Users need [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] licenses to get apps that have MAM policies.

-   An Office 365 subscription, which is required for the following:
  - To apply MAM policies to apps with multiple-identity support.
  - To create  SharePoint Online and Exchange Online work accounts. Exchange on-premises and SharePoint on-premises are not supported.
-   Skype for Business Online setup for modern authentication. For more information, see [Enable modern authentication](http://social.technet.microsoft.com/wiki/contents/articles/34339.skype-for-business-online-enable-your-tenant-for-modern-authentication.aspx).


- Azure Active Directory (Azure AD) to create users. Azure AD authenticates users when they open the app and enter their work credentials.

    > [!NOTE]
    > If you are setting up users by using the [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] console, be aware that the MAM policy configuration is moving to the Azure portal. To use this portal, you need to set up Azure AD user groups by using the Office 365 portal.


## Create users and assign Microsoft Intune licenses

1. Make sure that you have an Intune subscription. You   already have an [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] subscription if you are currently using [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] to manage your devices.  You also have an [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] subscription if you have purchased an Enterprise Mobility Suite (EMS) license. If you are trying [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] to check out the MAM capabilities, you can get a trial account on the [Microsoft Intune webpage](http://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/).

    To check whether you have an [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] subscription, in the Office portal, go to the **Billing** page.  You should see [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] as **Active** in the subscriptions.

2.  Sign in to the   [Office portal](http://portal.office.com) with your admin credentials.

3.  Go to the **Active Users** page to add users and assign [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] licenses.

    ![Active Users page in the Office portal](../media/AppManagement/OfficePortal_AddUsers.png)

    ![Edit user page in the Office portal](../media/AppManagement/OfficePortal_AssignLicenses.png)

4.  To give a user the ability to access the Office portal, the Azure AD portal, and the Azure  portal, assign the **Global administrator** role to the user.

    ![Page for editing user roles in the Office portal](../media/AppManagement/OfficePortal_AddRoletoUser.png)

5.  MAM policies are deployed to user groups in Azure Active Directory. To create user groups for your MAM policies, go to the **Groups** page in the Office portal and choose the **Add a group option** in the top menu to create a new security group.  Type a name and a description, and then click **Create**. When the group is created, you can add users to the group by clicking **Edit members**. The security group is created in Azure Active Directory.

    ![Page for security groups in the Office portal](../media/AppManagement/OfficePortal_CreateGroups.png)

The following table lists the roles and permissions that you can assign to admin users.

|||
|--|----|
|**Role**|**Permissions**|
|Global administrator (Office 365 portal)|Access to the Office 365 portal and the Azure AD portal.<br /><br />Access to the Azure  portal (can do both role management and mobile app management tasks).|
|Owner (Azure  portal)|Access to the Azure  portal (can do both role management and mobile app management tasks).|
|Contributor (Azure  portal)|Access to the Azure  portal (can do only the mobile app management tasks).|

## Assign the contributor role to a user

Global administrators have access to the [Azure portal](https://portal.azure.com).  If you want other admin users to be able to configure policies and do other mobile app management tasks, you can assign the contributor role to the users:


1.  On the **Settings** blade,  in the **Resource management** section, click **Users**.

    ![Users blade in the Azure portal](../media/AppManagement/AzurePortal_MAM_AddUsers.png)

2.  Click **Add** to open the **Add access** blade.

3.  Click **Select a role**, and then click **Contributor**.

    ![Select a role blade in the Azure portal](../media/AppManagement/AzurePortal_MAM_AddRole.png)

4.  Click **Add user**, and search for the user by name or email address. The users that you see in this list are the first 1,000 users that you previously created in Azure AD by using the Office portal. Click **OK** on the **Add access** blade to save and assign the role to the user.

    ![Add users blade in the Azure portal](../media/AppManagement/AzurePortal_MAM_AddusertoRole.png)

    > [!IMPORTANT]
    > If you select a user who does not have an [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] license assigned to them, they will not be able to access the portal.

## Next steps
[Create and deploy mobile app management policies with Microsoft Intune](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md)
