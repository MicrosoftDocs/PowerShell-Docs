---
# required metadata

title: Resolve GPO and Intune policy conflicts | Microsoft Intune
description: Learn how to resolve conflicts between Group Policy and Intune configuration policies.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: e76af5b7-e933-442c-a9d3-3b42c5f5868b

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: owenyen
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Resolve Group Policy Objects (GPO) and Microsoft Intune policy conflicts
Intune uses policies that help you manage settings on Windows PCs. For example, you can use a policy to control settings for the Windows Firewall on PCs. Many Intune settings are similar to settings that you might configure with Windows Group Policy. However, it is possible that, at times, the two methods might conflict with each another.

When conflicts happen, domain-level Group Policy takes precedence over Intune policy, unless the PC can’t sign in to the domain. In this case, Intune policy is applied to the client PC.

## What to do if you are using Group Policy
Make sure that policies that you apply are not being managed by Group Policy. To help prevent conflicts, you can use one or more of the following methods:

-   Move your PCs to an Active Directory organizational unit (OU) that does not have Group Policy settings applied before you install the Intune client. You can also block Group Policy inheritance on OUs that contain PCs enrolled in Intune to which you do not want to apply Group Policy settings.

-   Use a security group filter to restrict GPOs only to PCs that are not managed by Intune.

-   Disable or remove the Group Policy Objects that conflict with the Intune policies.

For more information about Active Directory and Windows Group Policy, see your Windows Server Documentation.

## How to filter existing GPOs to avoid conflicts with Intune policy
If you have identified GPOs whose settings conflict with Intune policies, you can use security group filters to restrict those GPOs only to PCs that are not managed by Intune.

<!--- ### Use WMI filters
WMI filters selectively apply GPOs to computers that satisfy the conditions of a query. To apply a WMI filter, deploy a WMI class instance to all PCs in the enterprise before you enroll any PCs in the Intune service.

#### To apply WMI filters to a GPO

1.  Create a management object file by copying and pasting the following into a text file, and then saving it to a convenient location as **WIT.mof**. The file contains the WMI class instance that you deploy to PCs that you want to enroll in the Intune service.

    ```
    //Beginning of MOF file.
    #pragma classflags("forceupdate")
    #pragma namespace ("\\\\.\\Root")
    instance of __Namespace
    {
       Name = "WindowsIntune";
    };

    #pragma namespace ("\\\\.\\Root\\WindowsIntune")
    [
       Description("This class defines Microsoft Intune common properties")
    ]
    class WindowsIntune_ManagedNode
    {
       [ read, Description("This defines whether Microsoft Intune Policy is enabled"): DisableOverride ToSubClass ]
       boolean WindowsIntunePolicyEnabled;
       [ read, key, Description("This property defines the version." "Example: 1.0"): ToSubClass ]
       string Version;
    };

    instance of WindowsIntune_ManagedNode
    {
       Version = "1.0";
       WindowsIntunePolicyEnabled = 1;
    };
    ```

2.  Use either a startup script or Group Policy to deploy the file. The following is the deployment command for the startup script. The WMI class instance must be deployed before you enroll client PCs in the Intune service.

    **C:/Windows/System32/Wbem/MOFCOMP &lt;path to MOF file&gt;\wit.mof**

3.  Run either of the following commands to create the WMI filters, depending on whether the GPO you want to filter applies to PCs that are managed by using Intune or to PCs that are not managed by using Intune.

    -   For GPOs that apply to PCs that are not managed by using Intune, use the following:

        ```
        Namespace:root\WindowsIntune
        Query:  SELECT WindowsIntunePolicyEnabled FROM WindowsIntune_ManagedNode WHERE WindowsIntunePolicyEnabled=0
        ```

    -   For GPOs that apply to PCs that are managed by Intune, use the following:

        ```
        Namespace:root\WindowsIntune
        Query:  SELECT WindowsIntunePolicyEnabled FROM WindowsIntune_ManagedNode WHERE WindowsIntunePolicyEnabled=1
        ```

4.  Edit the GPO in the Group Policy Management console to apply the WMI filter that you created in the previous step.

    -   For GPOs that should apply only to PCs that you want to manage by using Intune, apply the filter **WindowsIntunePolicyEnabled=1**.

    -   For GPOs that should apply only to PCs that you do not want to manage by using Intune, apply the filter **WindowsIntunePolicyEnabled=0**.

For more information about how to apply WMI filters in Group Policy, see the blog post [Security Filtering, WMI Filtering, and Item-level Targeting in Group Policy Preferences](http://go.microsoft.com/fwlink/?LinkId=177883). --->


You can apply GPOs to only those security groups that are specified in the **Security Filtering** area of the Group Policy Management console for a selected GPO. By default, GPOs apply to *Authenticated Users*.

-   In the **Active Directory Users and Computers** snap-in, create a new security group that contains computers and user accounts that you do not want Intune to manage. For example, you might name the group *Not In Microsoft Intune*.

-   In the Group Policy Management console, on the **Delegation** tab for the selected GPO, right-click the new security group to delegate appropriate **Read** and **Apply Group Policy** permissions to both users and computers in the security group. (**Apply Group Policy** permissions are available on the **Advanced** dialog box.)

-   Then, apply the new security group filter to a selected GPO, and remove the **Authenticated Users** default filter.

The new security group must be maintained as enrollment in the Intune service changes.

### See also
[Manage Windows PCs with Microsoft Intune](manage-windows-pcs-with-microsoft-intune.md)
