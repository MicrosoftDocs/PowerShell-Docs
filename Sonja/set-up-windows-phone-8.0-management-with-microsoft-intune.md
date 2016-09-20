---
# required metadata

title: Set up Windows Phone 8.0 management | Microsoft Intune
description: Enable mobile device management (MDM) for Windows Phone 8.0 devices with Microsoft Intune.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/09/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 61e9b6c3-8795-49b0-8ab2-a9a05ee3ea1f

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: priyar
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Set up device management for Windows Phone 8.0

Windows Phone 8.0 requires a Symantec certificate to install the Intune Company Portal app and allow device management. A certificate is also required to sign line-of-business apps. The following topic is only for Windows Phone 8.0. To manage Windows Phone 8.1 or later, including Windows 10 Mobile, see [Set up Windows Phone enrollment](set-up-windows-phone-management-with-microsoft-intune.md).

> [!IMPORTANT]
> Starting September of 2016, the Company Portal app for Windows 8.0 and Windows Phone 8.0 will no longer be available for download.

-   **Windows Phone 8** - Certificate required
-   **Windows Phone 8.1 and Windows 10 Mobile** require a certificate only if:

    -   You want to deploy the Company Portal app using Intune

    -   You'll deploy  line-of-business (AKA "side-loaded") apps


![Certificate requirements diagram](../media/wpcertreqs.png)

  > [!IMPORTANT]
  > The Symantec certificate used to manage certain Windows and Windows Phone mobile devices [must be renewed periodically](renew-a-symantec-code-signing-certificate.md).

Setup requirements for Window Phone mobile device management depend upon how you'll manage devices.  Setting two CNAMEs in your company's DNS registration makes enrollment easier for uses. If your users will download the Company Portal app from the Store, then once you've configured DNS settings you just need to set up the Company Portal and inform users how to enroll.  For Windows Phone 8.0, or Windows Phone 8.1 where you'll deploy the Company Portal, you'll need a Symantec certificate to code-sign the app.

## Configure setup requirements to enable Windows Phone management
1.  **Set up Intune**
    If you haven’t already, prepare for mobile device management by  [setting the mobile device management authority](get-ready-to-enroll-devices-in-microsoft-intune.md#set-mobile-device-management-authority) as **Microsoft Intune** and setting up MDM.

2.  **Set a DNS alias for the enrollment server address** (optional)

    A DNS alias (CNAME record type) makes it easier users to enroll their devices by automatically populating the server name during enrollment.

    1.  In the [Intune administration console](http://manage.microsoft.com), click **Administration** &gt; **Mobile Device Management** &gt; **Windows Phone**.

    2.  Type the URL of the verified domain of the company website in the **Specify a verified domain name** box and then click **Test Auto-Detection**.

    3.  Create **CNAME** DNS resource records for your company’s domain. The CNAME resource records must contain the following information:

        |Host Name|Points to|TTL|
        |-------------|-------------|-------|
        |enterpriseenrollment.company_domain.com|enterpriseenrollment-s.manage.microsoft.com |1 Hour|
        |enterpriseregistration.company_domain.com|enterpriseregistration.windows.net|1 Hour|
        For example, if your company’s website is contoso.com, you would create a CNAME in DNS that redirects EnterpriseEnrollment.contoso.com to manage.microsoft.com. If there is more than one verified domain, create a CNAME record for each domain.

        -   `enterpriseenrollment-s.manage.microsoft.com` – Supports a redirect to the Intune service with domain recognition from the email’s domain name

        -   `enterpriseregistration.windows.net` – Supports workplace join for mobile devices. It also supports conditional access for Windows 8.1

    ![Windows Phone Mobile Device Management Settings dialog box](../media/windows-phone-enrollment.png)

3.  **Certificate management to support app signing**
    [Required for Windows Phone 8.0 and Windows Phone 8.1 that won’t access the Windows Phone Store and/or need line-of-business apps.]

    To support the Company Portal app for Windows Phone 8.0 and to deploy company apps to Windows Phone 8.1 you must get a **Symantec Enterprise Mobile Code Signing Certificate**. You cannot use a certificate issued by your own certification authority because only the Symantec certificate is trusted by Windows Phone devices. This certificate is required in order to:

    -   Sign the Company Portal app for deployment to [!INCLUDE[winphone8_client_1](../includes/winphone8_client_1_md.md)] for enrollment and phone management

    -   Sign company line-of-business apps so [!INCLUDE[wit_nextref](../includes/wit_nextref_md.md)] can deploy them to Windows Phones

    The steps below will help you get the required certificates and sign the company portal app. You will need a Windows Phone Dev Center account and then you will need to purchase a Symantec certificate.

    1.  **Join the Windows Phone Dev Center**
        Join the [Windows Phone Dev Center](http://go.microsoft.com/fwlink/?LinkId=268442) using corporate account information when logging in to purchase your company account. This request will need to be authorized by a company officer before you receive a code-signing certificate.

    2.  **Get a company Symantec certificate**
        Purchase a certificate from the [Symantec website](http://go.microsoft.com/fwlink/?LinkId=268441) using your Symantec ID. After you purchase the certificate, the corporate approver whom you designated in your Windows Phone Dev Center account will receive an email asking for approval of the certificate request. For more information about the Symantec certificate requirement, see the [Why Windows Phone requires a Symantec certificate?](https://technet.microsoft.com/en-us/library/dn764959.aspx#BKMK_Symantec) Windows device enrollment FAQ.

    3.  **Import certificates**
        Once the request has been approved, you will receive an email containing instructions for importing certificates. Follow the instructions in the email to import the certificates.

    4.  **Verify certificates imported**
        To verify that the certificates have been imported correctly, go to the **Certificates** snap-in, right-click **Certificates**, and select **Find Certificates**. In the **Contains** field, enter “Symantec”, and click **Find Now**. The certificates you imported should appear in the results.

        ![Find the Symantec certificate](../media/wit.gif)

    5.  **Export a signing certificate**
        Having verified that the certificates are present, you can export the .pfx file to sign the company portal. Select the Symantec certificate with **Intended purpose** “code-signing.” Right-click the code-signing certificate and select **Export**.

        ![Export the signing certificate](../media/wit-walk-cert2.gif)

        In the **Certificate Export Wizard**, select **Yes, export the private key** and then click **Next**. **Select Personal Information Exchange –PKCS #12 (.PFX)** and check **Include all the certificates in the certification path if possible**. Complete the wizard. For more information, see [How to Export a Certificate with the Private Key](http://go.microsoft.com/fwlink/?LinkID=203031).

    6.  **Download and sign the Company Portal app**

        Support for Windows Phone enrollment requires the Windows Phone 8.0 Company Portal app be signed and uploaded to Intune.

        1.  **Download the Company Portal**
            Download the [Intune Company Portal for Windows Phone](http://go.microsoft.com/fwlink/?LinkId=268440) from the Download Center. The default installation location is `C:\Program Files (x86)\Microsoft Corporation\Windows Intune Company Portal for Windows Phone`.

        2.  **Download the Windows Phone 8.0 SDK**
            Download the [Windows Phone SDK](http://go.microsoft.com/fwlink/?LinkId=615570).

        3.  **Code-sign the Company Portal app**
            Use the XAPSignTool app downloaded with the SDK to sign the company portal with the .pfx file you created from the Symantec certificate. For more information, see [How to sign a company app by using XapSignTool](http://go.microsoft.com/fwlink/?LinkID=280195).

    7.  **Upload the Company Portal app to Intune**
        Upload the signed Company Portal app file and your code-signing certificate to make the app available to your end users.

        1.  In the [Intune administration console](http://manage.microsoft.com) click **Administration** &gt; **Windows Phone**.

        2.  Click the **Upload Signed App File** and sign in with your Intune Administrator ID.

        3.  On the **Software setup** page for **Specify the location of the software setup files**, browse to the code-signed Company Portal app location (.xap for Windows Phone 8.0 or .appx for Windows Phone 8.1).

            If you are evaluating Intune and uploading a code-signed app file in a trial Intune account, uncheck the **Use the Company Portal App file signed by the sample Symantec code-signed certificate** checkbox.

        4.  Add the certificate (.pfx) file that you exported to **Code-signing certificate** and create a password for the certificate.

        5.  On the **Software description** page, complete the fields remembering that users see this information on their devices when viewing details about the app in the Company Portal.

        6.  Complete the wizard. Users who enroll a Windows Phone 8.0 device will now get the Company Portal app on their devices during enrollment. Windows Phone 8.1 users can install the Company Portal app from the store version of the Company Portal.  If Windows Phone 8.1 devices are blocked from the Windows Phone Store or you want to deploy the Company Portal app using Intune, you must download and sign the Windows Phone 8.1 Company Portal (SSP.appx) app.

4.  **Tell users how to get access to company resources with the company portal**
    Your users will need to know how to enroll their devices and what to expect once they're brought into management. [What to tell your end users about using Microsoft Intune](what-to-tell-your-end-users-about-using-microsoft-intune.md)

## Deploy the Windows Phone 8.1 Company Portal app
You can deploy the Company Portal app to Windows Phone 8.1 devices with Intune instead of installing from the Windows Phone Store. You must still enable Windows Phone device enrollment with the steps above using the Symantec certificate. You must then download the Windows Phone 8.1 Company Portal app and sign it with your Symantec certificate.  This is only necessary if your users won't use the Company Store and you want to deploy the Company Portal to Windows Phone 8.1 devices.


1.  **Download the Company Portal**

    Download the [Microsoft Intune Company Portal App for Windows Phone 8.1](http://go.microsoft.com/fwlink/?LinkId=615799) from the Download Center and run the self-extracting (.exe) file. This file contains two files:

    -   CompanyPortal.appx– The Company Portal installation app for Windows Phone 8.1

    -   WinPhoneCompanyPortal.ps1 – A PowerShell script you can use to sign the Company Portal app file so it can be deployed to Windows Phone 8.1 devices

2.  **Download the Windows Phone SDK**
    Download the [Windows Phone SDK 8.0](http://go.microsoft.com/fwlink/?LinkId=615570) (http://go.microsoft.com/fwlink/?LinkId=268439) and install the SDK to your computer. This SDK is needed to generate an application enrollment token.

3.  **Generate an AETX file**
    Generate an application enrollment token (.aetx) file from the Symantec PFX file using AETGenerator.exe, part of Windows Phone SDK 8.0. For instructions on how to create an AETX file, see [How to generate an application enrollment token for Windows Phone](https://msdn.microsoft.com/library/windows/apps/jj735576.aspx)

4.  **Download the Windows SDK for Windows 8.1**
    Download and install the [Windows Phone SDK](http://go.microsoft.com/fwlink/?LinkId=613525) (http://go.microsoft.com/fwlink/?LinkId=613525). Note that the PowerShell script included with the Company Portal app uses the default install location, `${env:ProgramFiles(x86)}\Windows Kits\8.1`. If you install elsewhere, you must include the location in a cmdlet parameter.

5.  **Code-sign the app using PowerShell**
    As an administrator, open **Windows PowerShell** on the host computer installed with the Windows SDK, the Symantec Enterprise Mobile Code Signing Certificate, navigate to the Sign-WinPhoneCompanyPortal.ps1 file and run the script.

    **Example 1**

    ```
    .\Sign-WinPhoneCompanyPortal.ps1 -InputAppx 'C:\temp\CompanyPortal.appx' -OutputAppx 'C:\temp\CompanyPortalEnterpriseSigned.appx' -PfxFilePath 'C:\signing\cert.pfx' -PfxPassword '1234' -AetxPath 'C:\signing\cert.aetx'
    ```
    This example signs the CompanyPortal.appx at C:\temp\ and produces the CompanyPortalEnterpriseSigned.appx. It would use PFX password 1234 and read the publisher ID from the PFX file. It reads the enterprise ID from the cert.aetx file as well.

    **Example 2**

    ```
    .\Sign-WinPhoneCompanyPortal.ps1 -InputAppx 'C:\temp\CompanyPortal.appx' -OutputAppx 'C:\temp\CompanyPortalEnterpriseSigned.appx' -PfxFilePath 'C:\signing\cert.pfx' -PfxPassword '1234' -PublisherId 'OID.0.9.2342.19200300.100.1.1=1000000001, CN="Test, Inc.", OU=Test 1' -EnterpriseId 1000000001
    ```
    This example signs the CompanyPortal.appx at C:\temp\ and produces the CompanyPortalEnterpriseSigned.appx. It would use PFX password 1234 and use the publisher ID specified.

    **Parameters:**

    -   `-InputAppx` – The local path to the CompanyPortal.appx file in single quotes. For example 'C:\temp\CompanyPortal.appx'

    -   `-OutputAppx` – The local path and file name for the signed Company Portal app in single quotes. For example, 'C:\temp\CompanyPortalEnterpriseSigned.appx'

    -   `-PfxFilePath` – The local path and file name for the exported PFX file of the Symantec certificate. For example, 'C:\signing\cert.pfx'

    -   `-PfxPassword` – The password used to sign the PFX file in single quotes. For example '1234'

    -   `-AetxPath` – The local path to the .aetx file which is used for reading the enterprise ID if the 'EnterpriseId' argument is not defined. Either this argument or EnterpriseId must be provided. For example 'C:\signing\cert.aetx'

    -   `-PublisherId` - The Publisher ID of the enterprise. If absent, the 'Subject' field of the Symantec Enterprise Mobile Code Signing Certificate is used. For example, 'OID.0.9.2342.19200300.100.1.1=1000000001, CN="Test, Inc.", OU=Test 1'

    -   `-SdkPath` - The path to the root folder of the Windows SDK for Windows 8.1. This argument is optional and defaults to ${env:ProgramFiles(x86)}\Windows Kits\8.1.

    -   `-EnterpriseId` - The enterprise ID. Either this argument or 'AetxPath' must be provided. If this argument is not provided, the enterprise ID is read from the AETX file. For example, 1000000001

6.  Deploy the Windows Phone 8.1 Company Portal (SSP.appx) app.

    > [!IMPORTANT]
    > The ssp.xap and the Company Portal from the store can both be installed at the same time, which can be confusing for users. To have all users using the ssp.xap, create a blocked app for the store version of the Company Portal. To have all Windows Phone 8.1 devices to use only the store version of the Company Portal, you have three choices:
    >
    > -   If you won’t sideload apps and don’t need to support Windows Phone 8.0, don’t upload the signed ssp.xap.
    > -   If sideloaded apps are needed, and if there are no Windows Phone 8 devices enrolling, change the automatically created ssp.xap deployment from “available” to “uninstall.”
    > -   If sideloaded apps need to be installed and Windows Phone 8.0 devices need to enroll and receive the ssp.xap, create a new software deployment of the ssp.xap and deploy it with the **uninstall** action. Windows Phone 8.0 devices don’t support forced install or uninstall of apps, so they will ignore the deployment. Windows Phone 8.1 devices support the uninstall action and will remove the ssp.xap.
