---
# required metadata

title: Set up iOS and Mac management | Microsoft Intune
description: Enable mobile device management (MDM) for iOS devices including iPads and iPhones as well as Mac OS X devices with Microsoft Intune.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/20/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: dc451224-1372-4b84-b641-cfa67cb3849b

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: dagerrit
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Set up iOS and Mac device management
To set up your iOS or Mac device, you can find help [here](../enduser/using-your-ios-or-mac-os-x-device-with-intune.md).

Intune mobile device management of iPads, iPhones, and Mac OS X devices and give access to company email and apps. An Apple Push Notification service (APNs) certificate is required for Intune to manage iOS and Mac devices. Once the certificate is added to Intune, users can install the Company Portal app to enroll their devices or the administrator can set up [corporate-owned iOS device management](enroll-corporate-owned-ios-devices-in-microsoft-intune.md).

1.  **Set up Intune**<br>
    If you haven’t already, prepare for mobile device management by  [setting the mobile device management authority](get-ready-to-enroll-devices-in-microsoft-intune.md#set-mobile-device-management-authority) as **Microsoft Intune** and setting up MDM.

2.  **Get a certificate signing request**<br>
    As an administrative user, open the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Administration** &gt; **Mobile Device Management** &gt; **iOS and Mac OS X** &gt; **Upload an APNs Certificate**, and click **Download the APNs certificate request**. Save the certificate signing request (.csr) file locally. The .csr file is used to request a trust relationship certificate from the Apple Push Certificates Portal.

    ![Upload APNs certificate dialog box](../media/Intune-iOS-enrollment-with-apns.png)

3.  **Get an Apple Push Notification service certificate**<br>
    Go to the [Apple Push Certificates Portal](http://go.microsoft.com/fwlink/?LinkId=269844) and sign in with your company Apple ID to create the APNs certificate using the .csr file. After clicking **Upload** on Apple's Push Certificate Porta, you will receive a .json file which cannot be used for APNs. Complete the download and return to the Apple Push Certificates Portal for **Certificates for Third-Party Servers** and click **Download**.

    Download the APNs (.pem) certificate and save the file locally. This Apple ID must be used in future to renew your APNs certificate.

4.  **Add the APNs certificate to Intune**<br>
    In the [Microsoft Intune administration console](http://manage.microsoft.com), go to **Administration** &gt; **Mobile Device Management** &gt; **iOS and Mac OS X** &gt; **Upload an APNs Certificate**, and click **Upload the APNs certificate**. **Browse** to the certificate (.pem) file and click **Open** and then enter your **Apple ID**. With the APNs certificate, Intune can enroll and manage iOS devices by pushing policy to enrolled mobile devices.

5.  **Tell users how to get access to company resources with the company portal**<br>
    Your users will need to know how to enroll their devices and what to expect once they're brought into management.
    - [What to tell your end users about using Microsoft Intune](what-to-tell-your-end-users-about-using-microsoft-intune.md)
    - [End user guidance for iOS and Mac devices](../enduser/using-your-ios-or-mac-os-x-device-with-intune.md)

If your company or organization purchases iOS devices for users, those devices can also be enrolled for management as [company-owned iOS devices](enroll-corporate-owned-ios-devices-in-microsoft-intune.md).

### See Also
[Get ready to enroll devices in Microsoft Intune](get-ready-to-enroll-devices-in-microsoft-intune.md)
