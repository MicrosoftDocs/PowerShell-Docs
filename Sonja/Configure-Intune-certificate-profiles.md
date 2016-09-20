---
# required metadata

title: Configure certificate profiles | Microsoft Intune
description: Learn how to create an Intune certificate profile.
keywords:
author: nbigman
manager: angrobe
ms.date: 09/08/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 679a20a1-e66f-4b6b-bd8f-896daf1f8175

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: kmyrup
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure Intune certificate profiles
After you've configured your infrastructure and certificates as described in [Configure certificate infrastructure for SCEP](configure-certificate-infrastructure-for-scep.md) or [Configure certificate infrastructure for PFX](configure-certificate-infrastructure-for-pfx.md), you can create certificate profiles. Here's the process:

- **Task 1**: Export the Trusted Root CA certificate
- **Task 2**: Create Trusted certificate profiles
- **Task 3**: Create one of two certificate profile types:
  - SCEP certificate profiles
  - .PFX certificate profiles

## **Task 1**: Export the Trusted Root CA certificate
Export the Trusted Root Certification Authorities (CA) certificate as a **.cer** file from the issuing CA, or from any device that trusts your issuing CA. Do not export the private key.

You'll import this certificate when you set up a Trusted certificate profile.

## **Task 2**: Create Trusted certificate profiles
You must create a Trusted certificate profile before you can create a Simple Certificate Enrollment Protocol (SCEP) or a PKCS #12 (.PFX) certificate profile. You need a Trusted certificate profile and an SCEP or .PFX profile for each mobile device platform.

### To create a Trusted certificate profile

1.  In the [Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Add Policy**.
2.  Add one of these policy types:
    - **Android &gt; Trusted Certificate Profile (Android 4 and later)**
    - **iOS &gt; Trusted Certificate Profile (iOS 8.0 and later)**
    - **Mac OS X &gt; Trusted Certificate Profile (Mac OS X 10.9 and later)**
    - **Windows &gt; Trusted Certificate Profile (Windows 8.1 and later)**
    - **Windows &gt; Trusted Certificate Profile (Windows Phone 8.1 and later)**

    Learn more: [Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).

3.  Enter the requested information to configure the Trusted certificate profile settings for Android, iOS, Mac OS X, Windows 8.1, or Windows Phone 8.1. 
4.  In the **Certificate file** setting, import the Trusted Root CA certificate (.cer file) that you exported from your issuing CA. The **Destination store** setting applies only to devices running Windows 8.1 and later, and only if the device has more than one certificate store.
	
4.  Choose **Save Policy**.

The new policy is shown in the **Policy** workspace. Now you can deploy it.

## **Task 3**: Create SCEP or .PFX certificate profiles
After you create a Trusted CA certificate profile, create SCEP or .PFX certificate profiles for each platform you want to use. When you create an SCEP certificate profile, you must specify a Trusted certificate profile for that same platform. This links the two certificate profiles, but you still must deploy each profile separately.

### To create an SCEP certificate profile

1.  In the [Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Add Policy**.
2.  Add one of these policy types:
    - **Android &gt; SCEP Certificate Profile (Android 4 and later)**
    - **iOS &gt; SCEP Certificate Profile (iOS 8.0 and later)**
    - **Mac OS X &gt; SCEP Certificate Profile (Mac OS X 10.9 and later)**
    - **Windows &gt; SCEP Certificate Profile (Windows 8.1 and later)**
    - **Windows &gt; SCEP Certificate Profile (Windows Phone 8.1 and later)**

    Learn more: [Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).

3.  Follow the instructions on the profile configuration page to configure the SCEP certificate profile settings.
	> [!NOTE]
	>
	> Under **Subject name format**, select **Custom** to enter a custom subject name format (in iOS profiles, only).
	>
	> The two variables currently supported for the custom format are `Common Name (CN)` and `Email (E)`. By using a combination of these variables and static strings, you can create a custom subject name format, like this one:

	>     CN={{UserName}},E={{EmailAddress}},OU=Mobile,O=Finance Group,L=Redmond,ST=Washington,C=US

	> In this example, the admin created a subject name format that, in addition to the `CN` and `E` variables, uses strings for Organizational Unit, Organization, Location, State, and Country values. [CertStrToName function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa377160.aspx) lists supported strings.

4.  Choose **Save Policy**.

The new policy is shown in the **Policy** workspace. Now you can deploy it.

### To create a .PFX certificate profile

1.  In the [Intune administration console](https://manage.microsoft.com), choose **Policy** &gt; **Add Policy**.
2.  Add one of these policy types:
  - **Android &gt; .PFX Certificate Profile (Android 4 and later)**
  - **Windows &gt; PKCS #12 (.PFX) Certificate Profile (Windows 10 and later)**
  - **Windows &gt; PKCS #12 (.PFX) Certificate Profile (Windows Phone 10 and later)**
  - **iOS > PKCS #12 (.PFX) Certificate Profile (iOS 8.0 and later)**    
    Learn more: [Manage settings and features on your devices with Microsoft Intune policies](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md).
3.  Enter the information requested on the policy form.
4.  Choose **Save Policy**.

The new policy is shown in the **Policy** workspace. Now you can deploy it.

## Deploy certificate profiles
When you deploy certificate profiles, the certificate file from the Trusted CA certificate profile is installed on the device. The device uses the SCEP or .PFX certificate profile to create a certificate request by the device.

Certificate profiles install only on devices running the platform you use when you create the profile.

-   You can deploy certificate profiles to user collections or to device collections.

    > [!TIP]
    > To publish a certificate to a device quickly after the device enrolls, deploy the certificate profile to a user group rather than to a device group. If you deploy to a device group, a full device registration is required before the device receives policies.

-   Although you deploy each profile separately, you also need to deploy the Trusted Root CA and the SCEP or .PFX profile. Otherwise, the SCEP or .PFX certificate policy will fail.

Deploy certificate profiles the same way you deploy other policies for Intune:

1.  In the **Policy** workspace, select the policy you want to deploy, and then choose **Manage Deployment**.
2.  In the **Manage Deployment** dialog box:
    -   **To deploy the policy**, select one or more groups to deploy the policy to, and then choose **Add** &gt; **OK**.
    -   **To close the dialog box without deploying it**, choose **Cancel**.

When you select a deployed policy, you can see more information about the deployment in the lower part of the list of policies.

### Next steps

Next, learn how to use certificates to help secure email, Wi-Fi, and VPN profiles.

-  [Configure access to corporate email using email profiles](configure-access-to-corporate-email-using-email-profiles-with-Microsoft-Intune.md)
-  [Wi-Fi connections in Microsoft Intune](wi-fi-connections-in-microsoft-intune.md)
-  [VPN connections in Microsoft Intune](vpn-connections-in-microsoft-intune.md)
