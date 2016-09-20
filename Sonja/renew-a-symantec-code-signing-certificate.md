---
# required metadata

title: Renew a Symantec enterprise code-signing certificate to use with Intune | Microsoft Intune
description: Guidance to renew Symantec certificates used to manage certain Windows and Windows Phone mobile devices
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/25/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: c4813044-a925-4273-b0ec-e992fd55850a

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: damionw
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Renew a Symantec enterprise code-signing certificate for Windows devices

The Symantec certificate used to manage certain Windows and Windows Phone mobile devices must be renewed periodically. For Windows Phone 8.0 devices, a signed Company Portal app and the code-signing certificate are needed for device enrollment. Later Windows Phone devices can use the company portal app downloaded from the store. A code-signing certificate is also be required for deploying line-of-business apps.

## How to renew the Symantec enterprise code-signing certificate

1.  Look for a renewal email sent from Symantec approximately 14 days prior to certificate expiration. This email contains directions from Symantec about renewing your enterprise certificate.

    For additional information about Symantec certificates, visit [www.symantec.com](http://www.symantec.com) or call 1-877-438-8776 or 1-650-426-3400.

2.  Go to the website (example: [https://products.websecurity.symantec.com/orders/enrollment/microsoftCert.do](https://products.websecurity.symantec.com/orders/enrollment/microsoftCert.do)) and login with the Symantec Publisher ID and email addressed associated with the certificate. Remember to use the same machine for starting the renewal that you’ll use to download the certificate.

3.  Once the renewal is approved and paid for, download the certificate.

## How to install the updated certificate for Windows Phone 8.0

1.  Download and sign the latest Windows Phone Company Portal located here: [http://www.microsoft.com/en-us/download/details.aspx?id=36060](http://www.microsoft.com/en-us/download/details.aspx?id=36060).

2.  Open your Intune Administration Console ([https://admin.manage.microsoft.com](https://admin.manage.microsoft.com)) and go to **Admin**, **Mobile Device Management** &gt; **Windows Phone** and click **Upload Signed App**.

3.  Upload the newly signed Company Portal. You’ll need the newly signed SSP.xap and the new .PFX file you received from Symantec or the application enrollment token that was created with this new .PFX file.

4.  When the upload is complete, remove the old Company Portal version in the **Software** workspace in the Intune Management Console.

5.  Sign all enterprise line-of-business apps again using the same certificate and upload and replace existing applications.

Providing a signed SSP.xap file is currently the only way to provide the updated code signing certificate. To support signed line-of-business apps, you must sign and upload a Company Portal app even though your users will install the Company Portal app from the store.

## How to install the updated certificate for Windows Phone 8.1 and later devices

1.  Download and sign the latest Windows Phone Company Portal from the Download Center located here: [http://www.microsoft.com/en-us/download/details.aspx?id=36060](http://www.microsoft.com/en-us/download/details.aspx?id=36060).

2.  Open your [Intune Administration Console](https://admin.manage.microsoft.com) (https://admin.manage.microsoft.com) and go to **Admin** &gt; **Mobile Device Management** &gt; **Windows Phone** and click **Upload Signed App**.

3.  Upload the newly signed Company Portal. You’ll need the newly signed SSP.xap and the new .PFX file you received from Symantec or the Application enrollment token that was created with this new .PFX file.

4.  When the upload is complete, remove the old Company Portal version in the **Software**  workspace.

5.  Sign all new and any updated enterprise line-of-business apps using the new certificate. Existing applications do not need to be resigned and redeployed.


### See also
[Set up Windows Phone 8.0 management](set-up-windows-phone-8.0-management-with-microsoft-intune.md)
[Set up Windows Phone management](set-up-windows-phone-management-with-microsoft-intune.md)
