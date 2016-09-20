---
# required metadata

title: Release notes for Microsoft Intune | Microsoft Intune
description: Intune release notes
keywords:
author: Staciebarker
manager: angrobe
ms.date: 09/08/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: db9479b2-582d-4a1a-9fbc-fbfc6c680e6f

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Release notes for Microsoft Intune
Microsoft Intune is an integrated, cloud-based client management solution that provides tools, reports, and upgrade licenses to the latest version of Windows, and helps keep your computers up-to-date and secure. In addition, Intune lets you manage mobile devices on the network either through Exchange ActiveSync or directly through Intune. The following release notes describe important information and known issues in Microsoft Intune.


## Android users can’t send email when conditional access for Exchange Online is implemented

Users running Samsung Android 5.1.1 and above on their devices are unable to send email when conditional access for Exchange Online has been configured. Samsung acknowledges that the issue is in their built-in mail client in Android 5.1.1 and above, and is currently investigating a fix.

**Workaround 1:** Advise end users to use the Outlook app for Android.

**Workaround 2:** To enable impacted users to send email, you can follow these steps:

1. Put the impacted user into a security group in the “exempted groups” section of the conditional access policy for Exchange Online.
2. Allow the user to temporarily sync email on the built-in email client.
3. Remove the impacted user from the exempted group, and confirm that user can now send email.

Microsoft will continue to work closely with Samsung on a fix or additional workarounds.



## Changing resource access profiles between groups for iOS and Android may fail
**Issue:** When you change email or Simple Certificate Enrollment Protocol (SCEP) resource access profiles between groups, the profiles may conflict and fail. For example, let’s say that you have an existing email profile pointing to on-premise Exchange server, targeted to Group A, and then you create a new email profile that points to Exchange online, targeted to Group B. When you move users from Group A to Group B, devices will keep the on-premise Exchange email profile and try to install the Exchange online email profile that is targeted to Group B.

At this point, one of the following occurs: 
* If email profiles A and B are identical, the device rejects email profile B because email profile B already contains email profile A.
* If email profile A is different from email profile B, as mentioned in the example above, the device ends up with two email profiles.

**Note:** The hostname and the attribute used for username are checked to distinguish one email profile from another.

In both cases above, the resource access profile (email profile) was not removed from the device in order to prevent the unintentional removal of a user’s access to email or client's SCEP certificate.

**Workaround:** None.

## When you enroll a Windows 8.1 device that must authenticate to a proxy server, the enrollment process fails with no visible indication as to the cause of the failure
**Issue:** When you enroll a Windows 8.1 device and the device must authenticate to a proxy server during the enrollment process, the enrollment fails if the device has not cached the proxy server credentials. When the credentials for the proxy server are not cached on the device, the enrollment process must wait for the user to enter the credentials. However, the prompt to provide the proxy server credentials does not display during the enrollment process. The result is that the enrollment process cannot authenticate to the proxy server and there is no visible indication of this failure presented to the user.

**Workaround:** For Windows 8.1 devices that must enroll on a network that requires use of an authenticated proxy server, configure and save the credentials for the proxy server prior to enrollment of the device. To configure and save the credentials on a Windows 8.1 device:

1.  On the Windows 8.1 device, open **Internet Explorer**.

2.  When prompted for the proxy server credentials, enter the credentials and then select the option **Remember my credentials**.

3.  Enroll the device.

## Windows Phone 8.1 devices fail to enroll with Microsoft Intune when device authentication is enabled in AD FS
**Issue:** When you enroll a Windows Phone 8.1 device, enrollment fails if the optional setting for device authentication is enabled as part of global authentication policy in Active Directory Federated Services (AD FS).

**Workaround:** Disable device authentication on the AD FS server by unchecking **Enable device authentication** in **Edit Global Authentication Policy**. For more information, see [Configuring Authentication Policies](http://technet.microsoft.com/library/dn486781.aspx)


## Microsoft Intune App Wrapping Tool for Android has no built-in uninstall capability
**Issue:** The **Microsoft App Wrapping Tool for Android** does not have built-in functionality for uninstalling the tool.

**Workaround:** Browse to the location where you installed the tool, and delete the directory. The default installation location is: **C:\Program Files (x86)\Microsoft Intune Mobile Application Management\Android\App Wrapping Tool**. For more information about the app wrapping tool, see [Prepare Android apps for management with App Wrapping Tool](/intune/deploy-use/prepare-android-apps-for-mobile-application-management-with-the-microsoft-intune-app-wrapping-tool).

## Remote assistance is not available on computers that run Windows 8 or Windows 8.1
**Issue:** In this release, the remote assistance feature is not available on computers that run Windows 8 or Windows 8.1.

**Workaround:** None.

## Alert notifications for recipients that are automatically added may not work
**Issue:** If a recipient is automatically added to an alert notification, they may not always receive a notification.

**Workaround:** To make sure that recipients will receive message notification, you should manually add recipients to alert notifications.

## Language support in the Azure preview portal
The Azure preview portal is built on a new platform and supports the following languages - Chinese (Simplified), Chinese (Traditional), Czech, Dutch, English, German, Hungarian, Italian, Japanese, Portuguese (Brazil), Portuguese (Portugal), Russian, Spanish, English, French, Korean, Polish, Swedish, Turkish.

The Intune Admin Console and the end-user facing mobile experiences support Danish, Greek, Finish, Norwegian and Romanian, in addition to all the languages supported by the Azure preview portal.
