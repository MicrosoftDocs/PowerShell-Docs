---
# required metadata

title: Retire devices | Microsoft Intune
description: Intune supports both a selective wipe and a full wipe to remove the device from Intune management by removing their policy and the company portal.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/25/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 3dbec400-5d8a-47be-b892-7745811d9de2

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Retire devices from Intune management

Whether devices are corporate-owned or personal, there comes a time when a managed device needs to be removed from Intune management. A device might need to retired for a variety of reasons:

-	User leaves a company in a planned way (“managed” departure)
-	User leaves abruptly (gets fired, quits, etc.).
-	Loss of device
-	Repurposing of a device (move to another user, reuse for a different purpose, etc.)

You can perform either a selective wipe or a full wipe on devices managed as mobile devices or lock a device and reset its password. By wiping the device you free up the user's subscription to add a different device. You can also retire PCs managed with the Intune client software.

## Wipe data and apps from devices
Both a selective wipe and a full wipe remove the device from Intune management by removing their policy and the company portal, which means the device no longer has the credentials necessary to log on to company resources such as Microsoft SharePoint, email, or Office 365.

[Selective wipe](use-remote-wipe-to-help-protect-data-using-microsoft-intune.md#selective-wipe) is the preferred action for employees who have enrolled their own devices in Intune because it does not affect personal information on the device. Only corporate data is removed.

For devices that need to be repurposed, you can also use a [full wipe](use-remote-wipe-to-help-protect-data-using-microsoft-intune.md#full-wipe), which resets the device to factory default settings.

## To delete devices in the Azure Active Directory portal

1.  Login with your organization credentials to [http://aka.ms/accessaad](http://aka.ms/accessaad) or [https://portal.office.com](https://portal.office.com) and then choose **Admin centers** &gt; **Azure AD**.

2.  Create an Azure Subscription if you don’t have one. This should not require a credit card or payment if you have a paid account (choose the **Register your free Azure Active Directory** subscription link).

4.  Select **Active Directory** and then select your organization.

5.  Select the **Users** tab.

6.  Select the user whose devices you want to delete.

7.  Choose **Devices**.

8.  Select the devices as appropriate and choose **Delete device**. The device will be deleted the next time it syncs with Active Directory. This typically happens within 4 hours. After syncing, the device is removed from management. This removes one device from the device limit for this user.

## Retire managed computers
Computers managed with Intune client software can be removed from management from the Intune admin console. This also uninstalls the client software and deletes Intune policy from the computer. See information about [retiring computers managed with the Intune client software](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client#retire-a-computer.md).

## Block access a device
In the case of a lost device or when you must retire a device because an employee left your company without return a company-owned hardware, you can also [passcode reset and remotely lock](use-remote-lock-and-passcode-reset-in-microsoft-intune.md) the device. This keeps company information from being misused, although you might have to write the device off as a loss.

You also want to revoke the license from the employee's Intune user account. This frees up the license and you can assign it to a new user account.

## Retire hardware
Sometimes, it’s the device itself that has reached its end of life. In such cases, [resetting it to factory settings](use-remote-wipe-to-help-protect-data-using-microsoft-intune.md) with a full wipe removes all data and removes the device from Intune. Then you can get rid of the hardware according to your company’s policy.

### See also
[Help protect your data with full or selective wipe](use-remote-wipe-to-help-protect-data-using-microsoft-intune.md)
