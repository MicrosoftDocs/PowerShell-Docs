---
# required metadata

title: Add apps | Microsoft Intune
description: Before you start deploying apps with Intune, take some time to familiarize yourself with the concepts introduced in this topic.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 2b770f4f-6d36-41e4-b535-514b46e29aaa

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: mghadial
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Add apps with Microsoft Intune
Before you start deploying apps with Microsoft Intune, take some time to familiarize yourself with the concepts introduced in this topic. These concepts will help you understand which apps you can deploy to which platform. They'll also help you understand the prerequisites that must be in place before you deploy the apps.

## App types that you can deploy

### Software installer

|App type|Details|
|----------------|-------|
|**Windows Installer (&#42;.exe, &#42;.msi)**|This type of app must support silent installation with no user input. Your app documentation should include the relevant command-line options to silently install the app (for example, **/q**). You can find a list of common command-line options in [Command-Line Switches for the Microsoft Windows Installer Tool](https://support.microsoft.com/en-us/kb/227091).<br><br>Any additional files and folders that the app’s setup program requires must be available from the location that you specify for the app setup files.<br><br>In most cases, Windows Installer (.msi) and Windows Installer Patch (.msp) files do not require Intune to install any command-line arguments. Check your app documentation.<br><br>If command-line arguments are required, they must be entered as Name=Value pairs (such as TRANSFORMS=custom_transform.mst).|
|**App Package for Android (&#42;.apk)**|To deploy Android apps, you must have a valid .apk package.|
|**App Package for iOS (&#42;.ipa)**|To deploy iOS apps, you must have a valid .ipa package.<br><br>The .ipa package must be signed by Apple, and the expiration date in the provisioning profile must be valid. Intune can distribute enterprise certificate iOS applications.<br><br>Not all Apple developer certificate apps are supported.<br><br>Your company must be registered for the iOS Developer Enterprise Program.<br><br>Make sure that your organization’s firewall allows access to the iOS provisioning and certification websites.<br><br>You don't need to deploy a manifest  file (.plist) with the app.|
|**Windows Phone app package (&#42;.xap, .appx, .appxbundle)**|To deploy apps, you'll need an enterprise mobile code-signing certificate. For details, see [Set up Windows Phone management with Microsoft Intune](set-up-windows-phone-management-with-microsoft-intune.md).|
|**Windows app package (.appx, .appxbundle)**|To deploy apps, you'll need an enterprise mobile code-signing certificate. For details, see [Set up Windows device management with Microsoft Intune](set-up-windows-device-management-with-microsoft-intune.md).|
|**Windows Installer through MDM (&#42;.msi)**|You use this app to create and deploy Windows Installer-based apps to enrolled PCs that run Windows 10. These PCs are managed through mobile device management (MDM).<br /><br />You can upload only a single file with the extension .msi.<br><br>The file's product code and product version are used for app detection.<br><br>The default restart behavior of the app will be used. Intune does not control this.<br><br>Per-user MSI packages will be installed for a single user.<br><br>Per-machine MSI packages will be installed for all users on the device.<br><br>Dual-mode MSI packages are currently installed only for all users on the device.<br><br>App updates are supported when the MSI product code of each version is the same.<br>
All software installer app types are uploaded to your cloud storage space.

### **External Link**
Use an external link when you have a:
- URL that lets users download an app from an app store.
- Link to a web-based app that runs from the web browser.

Apps based on external links are not stored in your Intune cloud storage space.
### **Managed iOS app from the app store**
You can use managed iOS apps to manage and deploy iOS apps that are free of charge from the app store. You can also use managed iOS apps to associate [mobile application management policies](configure-and-deploy-mobile-application-management-policies-in-the-microsoft-intune-console.md) with [compatible apps](https://www.microsoft.com/en-us/server-cloud/products/microsoft-intune/partners.aspx) and review their status in the administrator console.<br /><br />Managed iOS apps are not stored in your Intune cloud storage space.

> [!TIP]
> Options for mobile devices are not available until you [set the MDM authority](get-ready-to-enroll-devices-in-microsoft-intune.md) to Intune.

## Intune software publisher
The Microsoft Intune Software Publisher starts when you add or modify apps from the Intune administrator console. From the publisher, you select and configure a software installer type that will either:

- Upload apps (programs for computers or apps for mobile devices) to be stored in Intune cloud storage.
- Link to an online store or web application.

Before you begin to use the software publisher, you must install the full version of [Microsoft .NET Framework 4.0](https://www.microsoft.com/download/details.aspx?id=17851). After installation, you might have to restart your computer before the software publisher will open correctly.

## Cloud storage space
All apps that you create by using the software installer installation type (for example, a line-of-business app) are  packaged and uploaded to Microsoft Intune cloud storage. A trial subscription of Intune includes 2 gigabytes (GB) of cloud-based storage that is used to store managed apps and updates. Your full subscription includes 20 GB of storage space.

You can see how much space you are using in the **Storage Use** node of the **Admin** workspace.

Requirements for cloud storage space are as follows:

-   All app installation files must be in the same folder.
-   The maximum file size for any file that you upload is 2 GB.


## Support for Universal Windows Platform (UWP) apps
Windows 10 PCs do not require a sideloading key to install line-of-business apps. However, the registry key **HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Appx\AllowAllTrustedApps** must have a value of to **1** to enable sideloading.

If this registry key is not configured, Intune will automatically set this value to **1** the first time you deploy an app to the device. If you set this value to **0**, Intune cannot automatically change the value, and the deployment of line-of-business apps will fail.

Universal Windows Platform line-of-business apps must be signed with a code-signing certificate that is trusted on each device to which the app is deployed. You can use a certificate from an in-house public key infrastructure (PKI), or a certificate from a third-party public root certificate installed on the device.

On Windows 10 Mobile devices, you can use a non-Symantec code-signing certificate to sign universal **.appx** apps. For **.xap** apps, and also **.appx** packages built for Windows Phone 8.1 that you want to install on Windows 10 Mobile devices, you must use a Symantec code-signing certificate.

## Next steps

You'll need to add apps in the Intune console before you can deploy them. You can add apps for [enrolled devices](add-apps-for-mobile-devices-in-microsoft-intune.md) or for [Windows PCs that you manage with the Intune client software](add-apps-for-windows-pcs-in-microsoft-intune.md).
