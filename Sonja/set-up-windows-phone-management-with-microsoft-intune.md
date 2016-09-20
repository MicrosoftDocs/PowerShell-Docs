---
# required metadata

title: Set up Windows 10 Mobile and Windows Phone management | Microsoft Intune
description: Enable mobile device management (MDM) for Windows 10 Mobile or Windows Phone devices with Microsoft Intune.
keywords:
author: NathBarn
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: f5615051-2dd1-453b-9872-d3fdcefb2cb8

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: damionw
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---


# Set up Windows Phone and Windows 10 Mobile management with Microsoft Intune

As an Intune administrator, you can enable enrollment and management for Windows 10 Mobile and Windows Phone devices in two ways:

- **[Automatic enrollment with Azure AD](#azure-active-directory-enrollment)** -  Windows 10 and Window 10 Mobile users enroll their devices by adding a work or school account to the device
- **[Company Portal enrollment](#company-portal-app-enrollment)** - Windows Phone 8.1 and later devices are enrolled by downloading and installing the Company Portal app, and then entering their work or school account credentials in the app.


[!INCLUDE[AAD-enrollment](../includes/win10-automatic-enrollment-aad.md)]

## Company Portal app enrollment
You can let users enroll their devices by installing and enrolling their devices with the Intune Company Portal app. Creating a DNS CNAME helps users connect and enroll in Intune without entering a server name. If you manage Windows Phone 8.0 devices or need to deploy the Company Portal to Windows Phone devices, you must also download and sign the Company Portal app. See [Set up Windows Phone 8.0 management](set-up-windows-phone-8.0-management-with-microsoft-intune.md).

1.  **Set up Intune**<br>If you haven’t already, prepare for mobile device management by  [setting the mobile device management authority](get-ready-to-enroll-devices-in-microsoft-intune.md#set-mobile-device-management-authority) as **Microsoft Intune** and setting up MDM.

2.  **Create CNAMEs** (optional)<br>Create **CNAME** DNS resource records for your company’s domain. For example, if your company’s website is contoso.com, you would create a CNAME in DNS that redirects EnterpriseEnrollment.contoso.com to manage.microsoft.com. If there is more than one verified domain, create a CNAME record for each domain. The CNAME resource records must contain the following information:

  |TYPE|Host name|Points to|TTL|
  |--------|-------------|-------------|-------|
  |CNAME|EnterpriseEnrollment.company_domain.com|EnterpriseEnrollment-s.manage.microsoft.com |1 Hour|
  |CNAME|EnterpriseRegistration.company_domain.com|EnterpriseRegistration.windows.net|1 Hour|
  DNS record changes might take up to 72 hours to propagate. You cannot verify the DNS change in Intune until the DNS record propagates.

  `EnterpriseEnrollment-s.manage.microsoft.com` – Supports a redirect to the Intune service with domain recognition from the email’s domain name

  `EnterpriseRegistration.windows.net` – Supports Windows 8.1 and Windows 10 Mobile devices that will register with Azure Active Directory using their work or school account

  If your company uses multiple domains for user credentials, create CNAME records for each domain.

  For example, if your company’s website is contoso.com, you would create a CNAME in DNS that redirects EnterpriseEnrollment.contoso.com to EnterpriseEnrollment-s.manage.microsoft.com. DNS record changes might take up to 72 hours to propagate. You cannot verify the DNS change in Intune until the DNS record propagates.

3.  **Verify CNAME**<br>In the [Intune administration console](http://manage.microsoft.com), click **Administration** &gt; **Mobile Device Management** &gt; **Windows Phone**. Type the URL of the verified domain of the company website in the **Specify a verified domain name** box and then click **Test Auto-Detection**.

    ![Set up mobile device management for Windows dialog box](../media/windows-phone-enrollment.png)

4.  **Optional steps**<br>The **Add Sideloading keys** step is not needed for Windows 10. The **Upload Code-Signing Certificate** step is only needed if you will distribute line-of-business (LOB) apps to devices not available from the Windows Store. [Learn more](set-up-windows-phone-8.0-management-with-microsoft-intune.md)

5.  **Inform users**<br>Your users will need to know how to enroll their devices and what to expect once they're brought into management.
    - [What to tell your end users about using Microsoft Intune](what-to-tell-your-end-users-about-using-microsoft-intune.md)
    - [End user guidance for Windows devices](../enduser/using-your-windows-device-with-intune.md)

No additional work is required unless you will deploy the Company Portal to devices.  Steps 2 and 3 in the admin console can be safely ignored.
