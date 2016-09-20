---
# required metadata

title: End user experience for MAM enabled apps | Microsoft Intune
description: This topic describes what to expect when your app is managed by mobile app management policies.
keywords:
author: karthikaraman
manager: angrobe
ms.date: 07/22/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: b57e6525-b57c-4cb4-a84c-9f70ba1e8e19

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: andcerat
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# End user experience for MAM enabled apps with Microsoft Intune
Mobile application management (MAM) polices are applied only when apps are used in the work context.  Read the following scenarios to understand how managed apps work.
##  Accessing OneDrive on an iOS device

1.  Launch the  **OneDrive** app to open the sign in page.

    ![Screenshot of the One drive log in page](../media/AppManagement/iOS_OneDriveLaunch.png)

    > [!NOTE]
    > On a personal device, typically the end user would download the app.  If the device is managed by a MDM solution, your can deploy the app to the device.

2.  Type your work account user name. You are redirected to the **O365 authentication** page to enter your work credentials.

    ![Screenshot of the O365 log in page](../media/AppManagement/iOS_O365SignInPage.png)

3.  After your credentials are successfully authenticated  by Azure AD, the MAM polices are applied, and you will be asked to restart the **OneDrive** app.
  >[NOTE!]
  > The restart required dialog box is displayed only on devices that are not enrolled in Intune.

    ![Screenshot of the Restart required dialog box](../media/AppManagement/iOS_AppRestartforMAM.png)

4.  When you re-launch the **OneDrive** app, the app launches with the MAM policies turned on. You are now prompted to set a **PIN** for the app. (if you configured the policy for this).

    ![Screenshot of OneDrive app asking for a PIN](../media/AppManagement/iOS_AppPINPrompt.png)

5.  Once you set the PIN and confirm,  you are able to access the files on your **OneDrive for Business**.

    ![Screenshot showing the file location open with the list of existing files](../media/AppManagement/iOS_OneDriveSuccess.png)

    > [!NOTE]
    > When you change a deployed policy, the changes will be applied next time you open the app.

##  Accessing OneDrive on an Android device

1.  Launch the OneDrive app to open the sign in page.

    > [!NOTE]
    > On a personal device, typically the end user would download the app.  If the device is managed by a MDM solution, you can deploy the app to the device.

2.  Type your work account user name. You are redirected to the **O365 authentication** page to enter your work credentials.

    ![Screenshot of O365 sign in page on an Android device](../media/AppManagement/Android_O365SignInPage.png)

3.  Once your credentials are successfully authenticated by **Azure AD**, you should see a message displayed with instructions to install the company portal app, if it is not already installed on the device.  Tap on **Get the app** to proceed.

>[!NOTE]
>The Company Portal app is required for all apps associated with MAM policies on Android devices. For devices not enrolled in Intune, the app must be installed on the device, but does not require launching or signing into the app.  


  ![Screenshot of the dialog box with the company portal app install requirement message](../media/AppManagement/Android_CompanyPortalMessage.png)

4.  You are now in the **Google Play** store where you can download and install the **Company Portal** app.

    The Company Portal app helps keep the data secure and protected.

    ![Screenshot of the company portal app](../media/AppManagement/Android_CompanyPortalInstall.png)

5.  Once you have completed the install, choose **Accept** to accept the terms.

6.  The **OneDrive** app launches automatically.

7.  The next time you open OneDrive, you will see the prompt to set a **PIN**, provided the policy settings are set to require a PIN to access the **OneDrive** app.

    ![Screenshot of the OneDrive app with the PIN prompt](../media/AppManagement/Android_OneDriveSetPIN.png)

8.  Once the PIN is set and confirmed, you can continue using **OneDrive**, which is now managed by app policies.


##  Using apps with multi-identity support
Microsoft Word is used as an example for this scenario.

1.  Open the **Word** app on your device. We are using an iOS device to show the steps.

2.  Tap **New** to create a new word document.

    ![Screenshot of an iOS device with the New menu option displayed at the bottom of the screen](../media/AppManagement/iOS_WordCreateNewDoc.png)

3.  Type a sentence of your choice.  When you try to save this document, both personal and work locations are shown as options to save the document you just created.  At this step, the app policies are not yet applied since this work/personal context is not yet established.

4.  Save the document to your OneDrive for business location. This is now tagged as company data and the policy restrictions apply.

    ![Screenshot of a typed sentence in a Word document](../media/AppManagement/iOS_WordCreateCompanyDoc.PNG)

5.  Open the document you saved to your work location.  Copy the text, open your personal **Facebook** account  and try to paste the copied text.  You should not be able paste the content into the new Facebook post. The paste option is not greyed out, but nothing happens when you press **Paste**.

    ![Screenshot showing the cut, copy, and paste selections](../media/AppManagement/iOS_WordCopyCompany.png)

    ![Screenshot showing no pasted data in the Facebook post](../media/AppManagement/iOS_FacebookPasteCompany.png)

6.  Now repeat steps 2 and 3 to create another new document, type a sentence of your choice, and instead of saving it to your work, save it to your personal location, like **OneDrive - personal**.

    ![Screenshot of the cut, copy, and paste selection with the sentence selected to copy](../media/AppManagement/iOS_WordCopyPersonal.png)

7.  Open the personal saved document.  Copy the text, open the **Facebook** app and try to paste the copied text. You see that you are able to paste the content to a Facebook post.

    ![Content showing as pasted in the Facebook post](../media/AppManagement/iOS_FacebookPastePersonal.png)

##  Managing user accounts

Intune only supports deploying MAM policies to only one user account per device. If a device has more than one work account, only one work account is managed by the MAM policies.

Depending on the app that you are using, the second user may or may not be blocked on the device. However, in all cases, only the first user who gets the MAM policies is affected by the policy.

If a device has existing multiple user accounts before the MAM policies are deployed, the account that the MAM policies is deployed to first is managed by Intune MAM policies.

**Microsoft Word**, **Excel**, and **PowerPoint** don't block a second user account, but the second user account is not affected by the MAM policies.  

For **OneDrive and Outlook apps**, you can only use one work account.  Adding multiple work accounts are blocked on these apps.  You can however, remove a user and add a different user on the device.

Read the example scenario below to get a deeper understanding of how multiple user accounts are treated.

User A works for two companies - **Company X**, and **Company Y**. User A has a work account for each company, and both use Intune to deploy MAM policies. **Company X** deploys MAM policies **before** **Company Y**. The account associated with **Company X** will get the MAM policy, but not the account associated with Company Y. If you want the user account associated with Company Y to be managed by the MAM policies, you must remove the user account associated with Company X.
### Adding a second account
#### IOS
If you are using an iOS device, when you try to add a second work account on the same device, you may see blocking message.  You will also see an option to remove the existing account and add a new one. You can do so by choosing **Yes**.

![Screenshot of the dialog box with the blocking message and Yes and No options](../media/AppManagement/iOS_SwitchUser.PNG)
####  Android
If you are using an Android device, You may see a blocking message with instructions to remove the existing account and add a new one.  On Android devices, to remove the existing account, go to **Settings &gt;General &gt; Application Manager &gt;Company Portal and select "Clear Data"**.

![Screenshot of the error message and instructions to remove the account](../media/AppManagement/Android_SwitchUser.png)

##  Viewing media files with the Rights Management sharing app
To view company AV, PDF, and image files on Android devices, use the [Microsoft Rights Management (RMS) sharing app](https://play.google.com/store/apps/details?id=com.microsoft.ipviewer).

Download this app from the  Google Play store.  Once the app is installed on your device, launch the app and authenticate with your company credentials. You should now be able to view unprotected and protected files from other policy-managed apps.

The following filetypes are supported:

* **Audio:** AAC LC, HE-AACv1 (AAC+), HE-AACv2 (enhanced AAC+), AAC ELD (enhanced low delay AAC), AMR-NB, AMR-WB, FLAC, MP3, MIDI, Vorbis, PCM/WAVE.
* **Video:** H.263, H.264 AVC, MPEG-4 SP, VP8.
* **Image:** jpg, pjpg, png, ppng, bmp, pbmp, gif, pgif, jpeg, pjpeg.
* PDF, PPDF

------------
|**pfile**|**text**|
|----|----|
|Pfile is a generic “wrapper” format for protected files that encapsulates the encrypted content and the RMS licenses and can be used to protect any file type.|Text files, including XML, CSV, etc. can be opened for viewing in the app even when they are protected. File types: txt, ptxt, csv, pcsv, log, plog, xml, pxml.|
---------------
**Android devices that are not enrolled in Intune**

Before you can use the RMS sharing app to view files from other apps managed by Intune, launch the RMS app and authenticate with your work account.  When you log in, you will see the following message **only if you don’t have an RMS license**:

**Authentication Successful – You can now view corporate files, but your organization isn’t set up to let you protect files. Contact your IT admin for more details.**

This does not prevent you from using the RMS sharing app to view company files. You can still open and view company files from other apps managed by Intune, and the MAM policies will still apply.  What this message is saying is that you will not be able to add the additional protection capabilities that the RMS sharing app provides.  You must have an RMS license to add protection to your files. To learn more about RMS file protection capabilities, see [Protect a file on a device](https://docs.microsoft.com/en-us/rights-management/rms-client/sharing-app-protect-in-place)  and [Protect a file that you share by email](https://docs.microsoft.com/en-us/rights-management/rms-client/sharing-app-protect-by-email).


### See also
[Create and deploy mobile app management policies with Microsoft Intune](create-and-deploy-mobile-app-management-policies-with-microsoft-intune.md)
