---
# required metadata

title: Access corporate email with email profiles | Microsoft Intune
description: Email profile settings can be used to configure email access settings for specific email clients on mobile devices.  
keywords:
author: Nbigman
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 10f0cd61-e514-4e44-b13e-aeb85a8e53ae

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: karanda
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure access to corporate email using email profiles with Microsoft Intune
Many mobile platforms include a native email client that ships as part of the operating system. Some of these clients can be set up by using email profiles, as described in this topic.

Email profile settings can be used to set up email access settings for specific email clients on mobile devices. On supported platforms, the native email clients can be set up by Microsoft Intune to let users access their corporate email on their personal devices, without any additional setup.

If you need to take additional measures for data loss prevention, use [Conditional access](restrict-access-to-email-and-o365-services-with-microsoft-intune.md), which controls access to the user's mailbox for any email client, including native email clients.

IT admins or users may also choose to install alternative email clients (for example, Microsoft Outlook for Android or iOS). These email clients may not support email profiles, and can't be set up by using Intune email profiles.  

You can use email profiles to configure the native email client on the following device types:
-	Windows Phone 8 and later
-	Windows 10 (for the desktop), Windows 10 Mobile, and later
-	iOS 8.0 and later
-	Samsung KNOX Standard (4.0 and later)

In addition to setting up an email account on the device, you can set up how much email to synchronize, and depending on the device type, which content types to synchronize.
>[!NOTE]
>
>If the user has installed an email profile prior to set up of a profile by Intune, the result of the Intune email profile deployment depends on the device platform:

[comment]: <> Passive construction in next three paragraphs is necessary until the process of duplicate detection is made clear by PM.

>**iOS**: An existing, duplicate email profile is detected based on host name and email address. The duplicate email profile created by the user blocks the deployment of an Intune admin-created profile. This is a common problem, as iOS users typically create an email profile, then enroll. The company portal informs the user that they are not compliant due to their manually-configured email profile, and prompts the user to remove that profile. The user should remove their email profile, so the Intune profile can be set up. To prevent the problem, instruct your users to enroll before installing an email profile, and to allow Intune to set up the profile.

>**Windows**: An existing, duplicate email profile is detected based on host name and email address. Intune overwrites the existing email profile created by the user.

>**Samsung KNOX**: An existing, duplicate email profile is detected based on the email address, and overwrites it with the Intune profile. If the user sets up that account, it is overwritten again by the Intune profile. Note that this may cause some confusion to the user.

>Since Samsung KNOX does not use host name to identify the profile, we recommend that you not create multiple email profiles to use on the same email address on different hosts, as these overwrite each other.


## Secure email profiles
You can secure email profiles using one of two methods: through a certificate or a password.

### Certificates
When you create the email profile, you choose a certificate profile that you have previously created in Intune. This is known as the identity certificate, and is used to authenticate against a trusted certificate profile (or a root certificate) to establish that the user’s device is allowed to connect. The trusted certificate is deployed to the computer that authenticates the email connection, typically, the native mail server.

For more information about how to create and use certificate profiles in Intune, see [Secure resource access with  certificate profiles](secure-resource-access-with-certificate-profiles.md).

### User name and password
The user authenticates to the native mail server by providing their user name and password.

The password is not contained in the email profile, so the user needs to supply this when they connect to email.

### Create an email profile

1.  In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Add Policy**.

2.  Set up one of the following policy types:

    -   **Email Profile for Samsung KNOX Standard (4.0 and later)**

    -   **Email Profile (iOS 8.0 and later)**

    -   **Email Profile (Windows Phone 8 and later)**

    -   **Email Profile (Windows 10 Desktop and Mobile and later)**

    You can only create and deploy a custom email profile policy. Recommended settings are not available.

3.  Use the following table to help you set up email profile settings:

|Setting name | More information|
| ----------- | --------------- |
    |**Name**|Unique name for the email profile.|
    |**Description**|A description that helps you identify this profile.|
    |**Host**|The host name of your company server that hosts your native email service.|
    |**Account name**|The display name for the email account as it will appear to users on their devices.|
    |**Username**|How the user name for the email account will be obtained. Select **Username** for an on-premises Exchange server, or select **User Principal Name** for Office 365.|
    |**Email address**|How the email address for the user on each device is generated. Select **Primary SMTP Address** to use the primary SMTP address to log into Exchange or use  **User Principal Name** to use the full principal name as the email address.|
    |**Authentication method** (Samsung KNOX and iOS)|Select either **Username and Password** or **Certificates** as the authentication method used by the email profile.|
    |**Select a client certificate for client authentication (Identity Certificate)** (Samsung KNOX and iOS)|Select the client SCEP certificate that you previously created that will be used to authenticate the Exchange connection. For more information about how to use certificate profiles in Intune, see [Secure resource access with  certificate profiles](secure-resource-access-with-certificate-profiles.md). This option is displayed only when the authentication method is **Certificates**.|
    |**Use S/MIME** (Samsung KNOX and iOS)|Send outgoing email using S/MIME encryption.|
    |**Signing certificate** (Samsung KNOX and iOS)|Select the signing certificate that will be used to sign outgoing email. This option is displayed only when you select **Use S/MIME**.|
    |**Number of days of email to synchronize**|The number of days of email that you want to synchronize, or select **Unlimited** to synchronize all available email.|
    |**Sync schedule** (Samsung KNOX, Windows Phone 8 and later, Windows 10)|Select the schedule by which devices will synchronize data from the Exchange server. You can also select **As Messages arrive**, which synchronizes data as soon as it arrives, or **Manual**, where the user of the device must initiate the synchronization.|
    |**Use SSL**|Use Secure Sockets Layer (SSL) communication when sending emails, receiving emails, and communicating with the Exchange server. For devices that run Samsung KNOX 4.0 or later, you must export your Exchange Server SSL certificate, and deploy it as an Android Trusted Certificate Profile in Intune. Intune does not support accessing this certificate if it is installed on the Exchange server by other means.|
    |**Content type to synchronize**|Select the content types that you want to synchronize to devices.|
	|**Allow email to be sent from third party applications** (iOS only)|Allow the user to select this profile as the default  account for sending email, and allow third-party applications to open email in the native email app, for example, to attach files to email.|
    > [!IMPORTANT]
    > If you have deployed an email profile and then wish to change the values for **host** or **Email address**, you must delete the existing email profile and create a new one with the required values.

4.  When you are finished, click **Save Policy**.

The new policy displays in the **Configuration Policies** node of the **Policy** workspace.

## Deploy the policy

1.  In the **Policy** workspace, select the policy you want to deploy, and then choose **Manage Deployment**.

2.  In the **Manage Deployment** dialog box:

    -   **To deploy the policy** - Select one or more groups to which you want to deploy the policy, and then choose **Add** &gt; **OK**.

    -   **To close the dialog box without deploying it** - Choose **Cancel**.

A status summary and alerts on the **Overview** page of the **Policy** workspace identify issues with the policy that require your attention. Additionally, a status summary appears in the Dashboard workspace.

> [!NOTE]
> If you want to remove an email profile from a device, edit the deployment and remove any groups of which the device is a member.
