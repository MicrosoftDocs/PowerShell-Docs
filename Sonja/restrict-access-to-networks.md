---
# required metadata

title: Restrict access to networks with Cisco ISE | Microsoft Intune
description: Use Cisco ISE with Intune so that devices are Intune enrolled and policy compliant before they access Wi-Fi and VPN that are controlled by Cisco ISE.
keywords:
author: nbigman
manager: angrobe
ms.date: 09/08/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 5631bac3-921d-438e-a320-d9061d88726c

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: muhosabe
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Using Cisco ISE with Microsoft Intune
Intune integration with Cisco Identity Services Engine (ISE) allows you to author network policies in your ISE environment by using the Intune device-enrollment and compliance state. You can use these policies to ensure that access to your company network is restricted to devices that are managed by Intune and compliant with Intune policies.

## Configuration steps

To enable this integration, you don’t need to do any setup in your Intune tenant. You will need to provide permissions to your Cisco ISE server to access your Intune tenant. After that's done, the rest of the setup happens in your Cisco ISE server. This article gives you instructions on providing your ISE server with permissions to access your Intune tenant.

### Step 1: Manage the certificates
Export the certificate from the Azure Active Directory (Azure AD) console, then import it into the Trusted Certificates store of the ISE console:

#### Internet Explorer 11


   a. Run Internet Explorer as an administrator, and sign in to the Azure AD console.

   b. Choose the lock icon in the address bar and choose **View certificates**.

   c. On the **Details** tab of the certificate properties, choose **Copy to file**.

   d. In the **Certificate export wizard** welcome page, choose **Next**.

   e. On the **Export file format** page, leave the default, **DER encoded binary x.509 (.CER)**, and choose **Next**.  

   f. On the **File to export** page, choose **Browse** to pick a location in which to save the file, and provide a file name. Though it seems like you’re picking a file to export, you’re actually naming the file that the exported certificate will be saved to. Choose **Next** &gt; **Finish**.

   g. From within the ISE console, import the Intune certificate (the file you exported) into the  **Trusted Certificates** store.

#### Safari

 a. Sign in to the Azure AD console.

b. Choose the lock icon &gt;  **More information**.

   c. Choose **View certificate** &gt; **Details**.

   d. Choose the certificate, and then choose **Export**. 

   e. From within the ISE console, import the Intune certificate (the file you exported) into the  **Trusted Certificates** store.

> [!IMPORTANT]
>
> Check the expiration date of the certificate, as you will have to export and import a new certificate when this one expires.


### Obtain a self-signed cert from ISE 

1.  In the ISE console, go to **Administration** > **Certificates** > **System Certificates** > **Generate Self Signed Certificate**.  
2.       Export the self-signed certificate.
3. In a text editor, edit the exported certificate:
[comment]: <> I'd rather not put a period at the end of these two statements, I think it could be confusing.
 - Delete ** -----BEGIN CERTIFICATE-----**
 - Delete ** -----END CERTIFICATE-----**
 
Ensure all of the text is a single line


### Step 2: Create an app for ISE in your Azure AD tenant
1. In the Azure AD console, choose **Applications** > **Add an Application** > **Add an application my organization is developing**.
2. Provide a name and a URL for the app. The URL could be your company website.
3. Download the app manifest (a JSON file).
4. Edit the manifest JSON file. In the setting called **keyCredentials**, provide the edited certificate text from Step 1 as the setting value.
5. Save the file without changing its name.
6. Provide your app with permissions to Microsoft Graph and the Microsoft Intune API.

 a. For Microsoft Graph, choose the following:
    - **Application permissions**: Read directory data
    - **Delegated permissions**:
        - Access user’s data anytime
        - Sign users in

 b. For the Microsoft Intune API, in **Application permissions**, choose **Get device state and compliance from Intune**.

7. Choose **View Endpoints** and copy the following values for use in configuring ISE settings:

|Value in Azure AD portal|Corresponding field in ISE portal|
|-------------------|---------------------------------|
|Microsoft Azure AD Graph API endpoint|Auto Discovery URL|
|Oauth 2.0 Token endpoint|Token Issuing URL|
|Update your code with your Client ID|Client ID|

### Step 4: Upload the self-signed certificate from ISE into the ISE app you created in Azure AD
1.     Get the base64 encoded cert value and thumbprint from a .cer X509 public cert file. This example uses PowerShell:
   
      
    `$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2`
     `$cer.Import(“mycer.cer”)`
      `$bin = $cer.GetRawCertData()`
      `$base64Value = [System.Convert]::ToBase64String($bin)`
      `$bin = $cer.GetCertHash()`
      `$base64Thumbprint = [System.Convert]::ToBase64String($bin)`
      `$keyid = [System.Guid]::NewGuid().ToString()`
 
	Store the values for $base64Thumbprint, $base64Value and $keyid, to be used in the next step.
2.       Upload the certificate through the manifest file. Log in to the [Azure Management Portal](https://manage.windowsazure.com)
2.      In to the Azure AD snap-in find the application that you want to configure with an X.509 certificate.
3.      Download the application manifest file. 
5.      Replace the empty “KeyCredentials”: [], property with the following JSON.  The KeyCredentials complex type is documented in[Entity and complex type reference](https://msdn.microsoft.com/library/azure/ad/graph/api/entity-and-complex-type-reference#KeyCredentialType).

 
    `“keyCredentials“: [`
    `{`
     `“customKeyIdentifier“: “$base64Thumbprint_from_above”,`
     `“keyId“: “$keyid_from_above“,`
     `“type”: “AsymmetricX509Cert”,`
     `“usage”: “Verify”,`
     `“value”:  “$base64Value_from_above”`
     `}2. `
     `], `
 
For example:
 
    `“keyCredentials“: [`
    `{`
    `“customKeyIdentifier“: “ieF43L8nkyw/PEHjWvj+PkWebXk=”,`
    `“keyId“: “2d6d849e-3e9e-46cd-b5ed-0f9e30d078cc”,`
    `“type”: “AsymmetricX509Cert”,`
    `“usage”: “Verify”,`
    `“value”: “MIICWjCCAgSgAwIBA***omitted for brevity***qoD4dmgJqZmXDfFyQ”`
    `}`
    `],`
 
6.      Save the change to the application manifest file.
7.      Upload the edited application manifest file through the Azure management mortal.
8.      Optional:  Download the manifest again, to check that your X.509 cert is present on the application.

>[!NOTE]
>
> KeyCredentials is a collection, so you can upload multiple X.509 certificates for rollover scenarios, or delete certficates in compromise scenarios.


### Step 4: Configure ISE Settings
In the ISE admin console, provide these setting values:
  - **Server Type**: Mobile Device Manager
  - **Authentication type**: OAuth – Client Credentials
  - **Auto Discovery**: Yes
  - **Auto Discover URL**: *Enter the value from Step 1.*
  - **Client ID**: *Enter the value from Step 1.*
  - **Token issuing URL**: *Enter the value from Step 1.*



## Information shared between your Intune tenant and your Cisco ISE server
This table lists the information that is shared between your Intune tenant and your Cisco ISE server for devices that are managed by Intune.

|Property|	Description|
|---------------|------------------------------------------------------------|
|complianceState|The true or false string that indicates whether the device is compliant or noncompliant.|
|isManaged|The true or false string that indicates whether the client is managed by Intune or not.|
|macAddress|The MAC address of the device.|
|serialNumber|The serial number of the device. It applies only to iOS devices.|
|imei|The IMEI (15 decimal digits: 14 digits plus a check digit) or IMEISV (16 digits) number includes information on the origin, model, and serial number of the device. The structure of this number is specified in 3GPP TS 23.003. It applies only to devices with SIM cards.|
|udid|The Unique Device Identifier, which is a sequence of 40 letters and numbers. It is specific to iOS devices.|
|meid|The mobile equipment identifier, which is a globally unique number that identifies a physical piece of CDMA mobile station equipment. The number format is defined by the 3GPP2 report S. R0048. However, in practical terms, it can be seen as an IMEI, but with hexadecimal digits. An MEID is 56 bits long (14 hex digits). It consists of three fields, including an 8-bit regional code (RR), a 24-bit manufacturer code, and a 24-bit manufacturer-assigned serial number.|
|osVersion|The operating system version for the device.
|model|The device model.
|manufacturer|The device manufacturer.
|azureDeviceId|The device ID after it has workplace joined with Azure AD. It is an empty GUID for devices that are not joined.|
|lastContactTimeUtc|The date and time when the device last checked in with the Intune management service.


## User experience

When a user attempts to access resources by using an unenrolled device, they receive a prompt to enroll, such as the one shown here:

![Example of enrollment prompt](../media/cisco-ise-user-iphone.png)

When a user chooses to enroll, they are redirected to the Intune enrollment process. The user enrollment experience for Intune is described in these topics:

- [Enroll your Android device in Intune](/intune/enduser/enroll-your-device-in-Intune-android)</br>
- [Enroll your iOS device in Intune](/intune/enduser/enroll-your-device-in-intune-ios)</br>
- [Enroll your Mac OS X device in Intune](/intune/enduser/enroll-your-device-in-intune-mac-os-x)</br>
- [Enroll your Windows device in Intune](/intune/enduser/enroll-your-device-in-intune-windows)</br>

There is also a [downloadable set of enrollment instructions](https://gallery.technet.microsoft.com/End-user-Intune-enrollment-55dfd64a) that you can use to create customized guidance for your user experience.


### See also

[Cisco Identity Services Engine Administrator Guide, Release 2.1](http://www.cisco.com/c/en/us/td/docs/security/ise/2-1/admin_guide/b_ise_admin_guide_21/b_ise_admin_guide_20_chapter_01000.html#task_820C9C2A1A6647E995CA5AAB01E1CDEF)
