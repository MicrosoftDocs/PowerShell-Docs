---
# required metadata

title: Multi-factor authentication for Windows | Microsoft Intune
description: Intune integrates multi-factor authentication (MFA) to help you secure your corporate resources.
keywords:
author: Nbigman
manager: angrobe
ms.date: 09/15/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 9b4f197d-bc10-4bee-91c9-19bcc8287d36

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: vinaybha
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Protect Windows devices with multi-factor authentication
Microsoft Intune integrates multi-factor authentication (MFA) to help you secure your corporate resources. MFA requires authentication factors like text authentication in addition to user names and passwords. Intune supports the use of MFA during enrollment of Windows 8.1 or later, Windows Phone 8.1, or Windows 10 Desktop and Mobile devices.

## On-premises infrastructure requirements for ADFS MFA
To set up multi-factor authentication, you need:

-   Automatic enrollment, as described in [Set up Windows device management](set-up-windows-device-management-with-microsoft-intune.md).
-   **An Active Directory domain to which the ADFS server is joined.**

-   **Active Directory Federation Services (ADFS) server, configured for MFA.** A server that's running Windows Server 2012 R2 and is set up as an ADFS server. For more information, see: [Secure cloud and on-premises resources using Azure Multi-Factor Authentication Server with Windows Server 2012 R2 AD FS](https://azure.microsoft.com/en-us/documentation/articles/multi-factor-authentication-get-started-adfs-w2k12/)

The servers have to meet the system requirements in [System Requirements and Installation Information for Windows Server 2012 R2](http://technet.microsoft.com/library/dn303418.aspx).

 


#### MFA with Intune
If your organization has an on-premises IT infrastructure that includes an Active Directory domain with Active Directory Federation Services (ADFS), you can set up MFA on your federation server and then enable MFA for Intune enrollment. By configuring MFA on Intune, users can authenticate once, during enrollment, and then use corporate resources without repeating the MFA process each time.

>[!NOTE]
>MFA can be required on a per-user or per-group basis on the ADFS server.  

#### MFA without Intune
If you set up MFA on your federation server, but you don’t enable MFA for enrollment in Intune, users will need to use MFA each time that they access corporate resources (not just at device enrollment).

You can also use Azure Active Directory (Azure AD) MFA to require MFA on a per-user basis each time that users access corporate resources. Azure AD MFA is a cloud service that does not require any on-premises IT infrastructure. To learn how to set up Azure AD MFA, see [Getting started with Azure Multi-Factor Authentication in the cloud.](https://azure.microsoft.com/en-us/documentation/articles/multi-factor-authentication-get-started-cloud/).

## Requiring ADFS MFA during enrollment of Windows devices
For information about how to enable MFA in ADFS, see [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](http://technet.microsoft.com/library/dn280949.aspx).

## Set up device enrollment MFA in Intune
>[!Important]  
>Enable MFA in your Azure AD tenant or on-premises environment before you require MFA for Intune enrollment of Windows devices. If you do not, users who try to enroll their Windows devices or try to Azure AD join their devices will get an error message when automatic enrollment during Azure AD Join is set up.

1.  In the Intune admin console, choose **Admin** &gt; **Mobile Device Management** &gt; **Multi-factor authentication**.

2.  Choose **Configure Multi-factor Authentication**, and then choose **Enable Multi-factor Authentication**.
