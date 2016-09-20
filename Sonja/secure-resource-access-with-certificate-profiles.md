---
# required metadata

title: Certificate profiles for resource access |Microsoft Intune
description: Secure VPN, Wi-Fi, and email access with a certificate installed on each user device.
keywords:
author: Nbigman
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8cbb8499-611d-4217-a7b4-e9b864785dd0

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: kmyrup
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Secure resource access with certificate profiles in Microsoft Intune
When you give users access to corporate resources through VPN, Wi-Fi, or email profiles, you can secure the access by using a certificate that is installed on each user device. Here's how it works:

1. Make sure you have the right certificate infrastructure in place, as described in [Configure certificate infrastructure for SCEP](configure-certificate-infrastructure-for-scep.md) and [Configure certificate infrastructure for PFX](configure-certificate-infrastructure-for-pfx.md).

2. Install a root certificate or an intermediate Certification Authority (CA) certificate on each device so that the device recognizes the legitimacy of your CA. To do this, create and deploy a **Trusted Certificate Profile**. When you deploy this profile, the devices that you manage with Intune will request and receive the root certificate. You have to create a separate profile for each platform. The **Trusted Certificate Profile** is available for these platforms:
 -  iOS 8.0 and later
 -  Mac OS X 10.9 and later
 -  Android 4.0 and later
 -  Windows 8.1 and later
 -  Windows Phone 8.1 and later

3. Create certificate profiles so that devices request a certificate to be used for authentication of VPN, Wi-Fi, and email access, as described in [Configure Intune certificate profiles](configure-intune-certificate-profiles.md). You can create and deploy a **PKCS #12 (.PFX) Certificate Profile** *or* a **SCEP Certificate Profile** for devices running these platforms:

  -  iOS 8.0 and later
  -  Android 4.0 and later
  -  Windows 10 (desktop and mobile) and later

  Use a **SCEP Certificate Profile** for devices running these platforms:
    -   Mac OS X 10.9 and later
    -   Windows Phone 8.1 and later

You must create a separate profile for each platform. When you create the profile, associate it with the **Trusted Root Certificate Profile** that you've already created.

> [!NOTE]           
> - If you don't have an Enterprise Certification Authority, you must create one.
>- If you decide, based on your device platforms, to use the Simplified Certificate Enrollment Protocol (SCEP) profile, you'll also need to configure a Network Device Enrollment Service (NDES) server.
>-  Whether you plan to use SCEP or .PFX profiles, you must download and configure the Microsoft Intune Certificate Connector.
>-  Learn how to configure all of the required services in [Configure certificate infrastructure for SCEP](configure-certificate-infrastructure-for-scep.md) or [Configure certificate infrastructure for PFX](configure-certificate-infrastructure-for-pfx.md).

### Next steps
- [Configure certificate infrastructure for SCEP](configure-certificate-infrastructure-for-scep.md)
- [Configure certificate infrastructure for PFX](configure-certificate-infrastructure-for-pfx.md)
- [Configure Intune certificate profiles](configure-intune-certificate-profiles.md)
