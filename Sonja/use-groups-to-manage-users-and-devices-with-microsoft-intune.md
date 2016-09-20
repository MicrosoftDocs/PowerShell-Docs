---
# required metadata

title: Use groups to manage users and devices | Microsoft Intune
description: Create and manage groups by using the Groups workspace.
keywords:
author: Nbigman
manager: angrobe
ms.date: 09/13/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: eb9b01ce-9b9b-4c2a-bf99-3879c0bdaba5

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: lpatha
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---
# Use groups to manage users and devices in Microsoft Intune

This topic describes how to create groups in Intune. It also provides information about how the management of groups is going to change over the coming months. 

>[!IMPORTANT]
>
>If you open the Groups workspace in the Intune portal and see a link to the Azure active directory (Azure AD) portal, then you are already using the *new* Azure AD security groups approach to group management in Intune, described in [Notice of upcoming improvements to the admin experience for groups](#notice-of-upcoming-improvements-to-the-admin-experience-for-groups). Click the link to the Azure AD portal to create and manage your groups. To learn how to work with Azure AD security groups, see [Managing access to resources with Azure Active Directory groups](https://azure.microsoft.com/en-us/documentation/articles/active-directory-manage-groups/).
>
>If you do not see the link to the Azure AD portal, you are still using the *current* approach to group management, described in [Create groups to manage users and devices with Microsoft Intune](#Create-groups-to-manage-users-and-devices-with-Microsoft-Intune) in this topic.


## Notice of upcoming improvements to the admin experience for groups

You've let us know that you'd like one grouping and targeting experience across Enterprise Mobility + Security. We hear you. Based on your feedback, soon we will be converting Intune groups to Azure Active Directory-based security groups. This change will unify group management across Intune and Azure Active Directory (Azure AD). The new experience means that you won't have to duplicate groups between services. It also will provide extensibility through the options to use Windows PowerShell and Microsoft Graph.

### How does this affect me right now?
This change doesn’t affect you now. But here's what's coming:

-	In September 2016, new accounts that are provisioned after the monthly service release will use Azure AD security groups instead of Intune user groups.   
-	In October 2016, new accounts that are provisioned after the monthly service release will manage both user-based groups and device-based groups in the Azure AD portal. There will be no effect on existing customers.
-	In November 2016, the Intune product team will start to migrate existing customers to the new Azure AD-based group management experience. All user and device groups that exist in Intune today will be migrated to Azure AD security groups. We will do the migration in batches starting in November 2016. We won’t start migrations until we can minimize any effect on your day-to-day work, and when we expect there will be no effect on your users. We also will give you notice before we migrate your account.


### How and when will I migrate to the new groups experience?
We will migrate current Intune customers over a period of time. We’re finalizing the schedule for that migration and will update this topic in a few weeks to give you more details. We'll give you notice before you are migrated. If you have any migration concerns, please contact our migration team at <intunegrps@microsoft.com>.

### What happens to my existing user and device groups?
 User groups and device groups that you've created in Intune will migrate to Azure AD security groups. Default Intune groups, such as the All Users group, will migrate only if you are using them in deployments at the time of migration. Migration may be more complex for some groups. We will notify you if additional steps are required for migration in your organization.

### What new features will be available to me?
Here's the new functionality we'll introduce with this migration from Intune to Azure Active Directory:

-	 Azure AD security groups will be supported in Intune for all types of deployments.
-	 Azure AD security groups will support the grouping of devices and users.
-	 Azure AD security groups will support dynamic groups that have Intune device attributes. For example, you will be able to dynamically group devices by platform, like iOS. When a new iOS device is enrolled in your organization, it automatically will be added to the iOS dynamic device group.
-	 You'll have a shared admin experience for group management across Azure AD and Intune.
- The Intune Service Administrator role will be added to Azure AD so that Intune service admins can perform group management tasks in Azure AD.

### What Intune functionality won’t be available?
Although the groups experience will improve, there will be some Intune functionality that won't be available after your organization migrates from Intune groups to Azure AD security groups.

#### Group management functionality

-	After migrating, you won't be able to exclude members or groups when you create a new group. However, with Azure AD dynamic groups, you can use attributes to create advanced rules that you can use to exclude members from a group based on criteria that you set.
-	Ungrouped Users and Ungrouped Devices groups won't be supported. We will not migrate those groups from Intune to Azure AD.


#### Group-dependent functionality

-	The Service Admin role will not have **Manage groups** permissions.
-	You won’t be able to group Exchange ActiveSync devices. Your All EAS Managed Devices group will be converted from a group to a report view.
-  Pivoting with groups in reports will not be available.
-  Custom group targeting of notification rules will not be available.

### What should I do to prepare for this change?
 We have recommendations that will make this transition easier for you:

- Clean up any unwanted or unneeded Intune groups before migration.
- Evaluate your use of exclusion in groups, and consider redesigning your groups so that you don't need to use exclusion.
-  If you have admins who do not have permissions to create groups in Azure AD, ask your Azure AD administrator to add them to the Intune Service Administrator Azure AD role.


## Create groups to manage users and devices with Microsoft Intune

This section describes how to create Intune groups in the Intune administration console.

You can create and manage groups in the **Groups** workspace in the Microsoft Intune admin console. The **Groups Overview** page shows status summaries that can help you identify and prioritize issues that require your attention. Status summaries cover these areas:

-   Alerts
-   Software updates
-   Endpoint Protection
-   Policy
-   Software management

Your group hierarchy also shows status summaries to help you identify and resolve problems for members of a selected group.

## Create groups

> [!TIP]
> When you create groups, consider how you will apply policies. For example, you might have policies that are specific to a device operating system, and policies that are specific to different roles in your organization, or to organizational units that you've already defined in Active Directory. It might be useful to have separate device groups for iOS, Android, and Windows, as well as a user group for each organizational role.
>
> You'll probably also want to create a default policy that applies to all groups and devices, to establish the basic compliance requirements of your organization. Then, you can create more specific policies for the broadest categories of users and devices. For example, you might create email policies for each of the device operating systems.
>
> Be careful when you name your policies so that you can easily identify them later. For example, a good descriptive policy name is **WP Email Policy for Entire Company**.
>
> Each time you create a restrictive policy, you'll want to communicate it to your users. After you create the more general groups and policies, pay attention to how you create smaller groups, so that you can reduce unnecessary communication.

### To create a device group

1.  In the Intune admin console, choose **Groups** &gt; **Overview** &gt; **Create Group**.

2.  Enter a name and a description (optional) for the group, and then select a device group as the parent group. Choose **Next**.

3.  On the **Define Membership Criteria** page, select the type of devices to include in the group. You have additional group configuration options based on the types of devices you choose to include:

    -   **Computer**. Select whether to include all members of the parent group; the organizational units you want to include or exclude; and domains you want to include or exclude. You can get organizational unit and domain information for a computer from inventory.

    -   **Mobile**. Select whether to include mobile devices that are managed by Intune, mobile devices that are managed by Exchange ActiveSync, or both.

    -   **All devices**. This option includes all devices, with no exclusions based on any criteria.

4.  On the **Define Direct Membership** page, choose **Browse** to select individual devices to include or exclude. If you select devices that are not in the parent group that you specified, Intune automatically adds those devices to the parent group.

5.  On the **Summary** page, review your selections, and then choose **Finish**.

The newly created group is shown in the **Groups** list, in the **Groups** workspace, under the parent group. That's also where you can edit or delete the group.

### To create a user group

1.  In the Intune admin console, choose **Groups** &gt; **Overview** &gt; **Create Group**.

2.  Enter a name and a description (optional) for the group, and then select a user group as the parent group. Choose **Next**.

3.  On the **Define Membership Criteria** page, choose whether to include all members of the parent group or to start with an empty group. Then, include or exclude members based on the security groups of users that you either manually configure in the [Office 365 admin center](http://go.microsoft.com/fwlink/?LinkId=698854), or sync from Active Directory. If the membership of a security group changes, the membership of user groups based on that security group also might change.

    > [!IMPORTANT]
    > Currently, if your group includes members from specific security groups or manager groups and you exclude members from some groups, the members you initially included will be removed. To create a group that has both included members and excluded members, we recommend that first you create a parent group that has the included members. Then, create a child group for that parent group. In the new child group, list the excluded members. Then, use that child group to manage Intune policies, profiles, and app distribution.

    > [!NOTE]
    > In the Azure portal, you can create groups based on the managers who users report to. This type of group is dynamic, and it will change as employees are added to or removed from a manager's team in Azure Active Directory. How to create an Azure group based on manager name is described in [Using attributes to create advanced rules](https://azure.microsoft.com/en-us/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/), in the section **To configure a group as a “Manager” group**.

4.  On the **Define Direct Membership** page, choose **Browse** to select individual users to include or exclude. If you select users that are not in the parent group that you specified, those devices are automatically added to the parent group. The option to manually add a user is at the bottom of the **Select Members** dialog box. This is helpful if you want to add a user who does not yet have an enrolled device.

5.  On the **Summary** page, review your selections, and then choose **Finish**.

The newly created group is shown in the **Groups** list, in the **Groups** workspace, under the parent group. That's also where you can edit or delete the group.

> [!TIP]
> Security groups are a good resource to use when you populate user groups. Because security groups define who can access which resources, security groups can translate well to Intune user groups. Security groups that are synced from Active Directory to Azure Active Directory, or which you create directly in Azure Active Directory through the Office 365 admin center or the Azure portal are available to you to use when you create user groups in Intune.

## Filter admin views by role
In filtered group views, you can tailor what an IT admin can see based on the admin's role. You also can restrict which groups each IT admin can manage. This can be useful when:

-   You want your IT admins to be able to deploy items only to specific users and devices
-   You want your IT admins to see only the groups that are relevant to that admin

You can configure filtered group views for service admins in the Intune admin console. For details, see [What to know before you start Microsoft Intune](/intune/get-started/what-to-know-before-you-start-microsoft-intune).

After you set up filtered group views for a service admin, when the admin deploys software or policies, or runs reports, the admin can view and select only the groups that you specified. The admin also doesn't see status information on these pages of the admin console:

-   **System Overview**
-   **Groups Overview**
-   **Endpoint Protection Overview**
-   **Alerts Overview**
-   **Software Overview**
-   **Policy Overview**

### To create a filtered group view

1.  In the Intune admin console, choose **Admin** &gt; **Administrator Management** &gt; **Service Administrators**.

2.  Select the service admin who you want to create a filtered group view for, and then choose **Manage Groups**.

3.  In the **Select the groups that will be visible to this service administrator** dialog box, add the groups that the service admin will be able to access, and then choose **OK**.

After you've set up the filtered group views, the IT admin will be able to view and select only the groups you've indicated.

## Manage your groups
After you create your groups, you can continue to manage them according to the needs of your organization.

You can edit your group to change its name or description, or who belongs to the group.

You can delete a group that no longer serves the needs of your organization. Deleting a group does not delete the users that belong to that group.

## Next steps
After you set up your groups and policies, review **Intended Value** and **Status** to check the practical implications of your design.

### To check your design

1. Select any device from a device group and browse through the categories of information at the top of the page.
2. Choose **Policy**. You'll see something like this screenshot of an Android device's policy settings.

![Example of Android settings policy](../media/Intune-Device-Policy-v.2.jpg)

Each policy has an **Intended Value** and a **Status**. The intended value is what you intended to achieve when you assigned the policy. The status is what you achieve when all of the policies that apply to the device, as well as the restrictions and requirements of the hardware and operating system are considered together. In this screenshot you can see two clear examples:

-   **Allow simple passwords** is set to **Yes**, as shown in the **Intended Value** column, but its **Status** is **Not applicable**. This is because simple passwords are not supported for Android devices.
-   Similarly, the expanded policy item **Email settings for iOS devices** is not applied to this device because it is an Android device.

> [!NOTE]
> Remember that when two policies that have different levels of restriction apply to the same device or user, the more restrictive policy applies in practice.
