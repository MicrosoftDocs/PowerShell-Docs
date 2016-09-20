---
# required metadata

title: Enroll with the device enrollment manager | Microsoft Intune
description: The device enrollment manager (DEM) account can manage large numbers of shared, corporate-owned mobile devices with a single user account.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/12/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: a23abc61-69ed-44f1-9b71-b86aefc6ba03

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: dagerrit
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---


# Enroll corporate-owned devices with the device enrollment manager in Microsoft Intune
Organizations can use Intune to manage large numbers of mobile devices with a single user account. The *device enrollment manager* (DEM) account is a special Intune account that can enroll up to 1,000 devices. We recommend that you use devices enrolled through this account as shared devices rather than personal ("BYOD") devices. Users will not be able to use "native" email apps, for example.

As an example, you could assign a device enrollment manager user account to a store manager or supervisor to let them:

-   Enroll devices in Intune.

-   Sign in to the Company Portal to get company apps.

-   Install and uninstall software.

-   Configure access to company data.


**A device enrollment manager scenario:**
A restaurant wants point-of-sale tablets for its wait staff and order monitors for its kitchen staff. The employees never need to access company data or sign in as users. The Intune admin creates a device enrollment manager account and enrolls the company-owned devices by using that account. Alternatively, the admin could give the device enrollment manager credentials to a restaurant manager, which would let the manager enroll and manage the devices.

The admin or manager can deploy role-specific apps to the restaurant devices. An admin can also select the device in the Intune console and retire it from mobile device management with the administration console.

Devices that are enrolled with a device enrollment manager account have the following limitations:
  - There is no specific device "user"—therefore, there is no email or company data access. However VPN, for example, could still provide device apps with access to data.
  - There is no conditional access because these are per-user scenarios.
  - You can't reset these devices from the Company Portal.
  - Only the local device appears in the Company Portal app or website.
  - They can't use Apple Volume Purchase Program (VPP) apps because of per-user Apple ID requirements for app management.
  - (iOS) They can't also be enrolled with Apple Configurator or the Apple Device Enrollment Program (DEP), but DEP or Apple Configurator-managed devices can be enrolled without user affinity.

> [!NOTE]
> To deploy company apps to devices that are managed by the device enrollment manager, deploy the Company Portal app as a **Required Install** to the device enrollment manager's user account.
> To improve performance, viewing the Company Portal app on a DEM device only shows the local device. Remote management of other DEM devices can only be done from the Intune admin console.

## Create device enrollment manager accounts
Device enrollment manager accounts are user accounts with permission to enroll large numbers of corporate-owned devices. Only users in the Intune console can be device enrollment managers.

#### Add a device enrollment manager to Intune

1.  Go to the [Microsoft Intune account portal](http://go.microsoft.com/fwlink/?LinkId=698854) and sign in to your admin account.

2.  Choose **Add user**.

3.  Confirm that the user account that will be a device enrollment manager is listed. If it isn't, add the user by choosing **New** and completing the **Add user** process. A subscription license is required for each user that accesses the service. The device enrollment manager cannot be an Intune admin. Check whether you need to add more licenses before you use this feature.

4.  Sign in to the [Microsoft Intune administration console](http://manage.microsoft.com) with your admin credentials.

5.  In the navigation pane, choose **Admin**, go to **Administrator Management**, and select **Device Enrollment Manager**. The **Device Enrollment Managers** page opens.

6.  Choose **Add…**. The **Add Device Enrollment Manager** dialog box opens.

7.  Enter the **User ID** of the Intune account, and then choose **OK**. The device enrollment manager user cannot be an Intune admin.

8.  The device enrollment manager can now enroll mobile devices by using the same procedure that an end user uses for a BYOD scenario in the Company Portal.

## Delete a device enrollment manager from Intune

1.  Sign in to the [Microsoft Intune admin portal](http://manage.microsoft.com) with your admin credentials.

2.  In the navigation pane, choose **Admin**, go to **Administrator Management**, and select **Device Enrollment Manager**. The **Device Enrollment Managers** page opens.

3.  Select the device enrollment manager **User** that you want to delete, and then choose **Delete**. This user won’t be deleted from Intune, and the devices this user manages will remain enrolled in Intune. Deleting a device enrollment manager prevents that user from enrolling more devices in Intune.

4.  Choose **Yes** to confirm that you want to delete the device enrollment manager.

Deleting a device enrollment manager does not affect enrolled devices. When a device enrollment manager is deleted:

-   No enrolled devices are affected.

-   Enrolled devices continue to be fully managed.

-   The deleted device enrollment manager account credentials remain valid to sign in to the Company Portal to access apps.

-   The deleted device enrollment manager account credentials still cannot wipe or retire devices.

-   The deleted device enrollment manager account’s relationship to enrolled devices remains, but no additional devices can be enrolled.
