---
# required metadata

title: Overview of the Microsoft Intune App SDK | Microsoft Intune
description:
keywords:
author: Msmbaldwin
manager: jeffgilb
ms.date: 04/28/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: ef1751bb-3a2f-4662-a922-38c076869eb3

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Overview of the Microsoft Intune App SDK
The Intune App SDK is available for both the iOS and Android platform, and enables mobile app management features with Microsoft Intune. In addition, we strive to reduce the amount of code changes required of the developer. You will find that you can enable most of the SDK features without changing your app’s behavior. For enhanced end user and IT administrator experience, you can utilize our APIs to customize your app behavior for features that require your app participation. 

Once you’ve enabled your app, IT administrators can deploy policies to Intune managed apps and take advantage of these features to protect their corporate data.

# Features
## Control users’ ability to move corporate documents
IT administrators can control file relocation of corporate documents in Intune managed apps. For instance, they can deploy a policy that disables file backup apps from backing up corporate data to the cloud.  

## Configure clipboard restrictions
IT administrators can configure the clipboard behavior in Intune managed apps. For instance, they can deploy a policy so that end users are unable to use the clipboard to cut/copy from an Intune-managed app and paste into a non-managed app.

## Configure screen capture restrictions
IT administrators can prevent users from capturing the screen if an Intune-managed app is displayed. Applying this restriction prevents the capture and release of confidential corporate content. This feature is only available for android devices. 

## Enforce encryption on saved data
IT administrators can enforce a policy that ensures that data saved to the device by the app is encrypted.

## Remotely wipe corporate data
IT administrators can remotely wipe corporate data from an Intune-managed app when the device is unenrolled from Microsoft Intune. This feature is identity-based and will delete only the files that relate to the corporate identity of the end user. To do that, the feature requires the app’s participation. The app can specify the identity for which the wipe should occur based on user settings. In the absence of these specified user settings from the app, the default behavior is to wipe the application directory and notify the end user that company resource access has been removed. 

## Enforce the use of a managed browser
IT administrators can enforce the use of a managed browser when opening links from within Intune-managed apps. Using the Microsoft Intune managed browser helps to ensure that links that appear in emails (which are in an Intune-managed mail client) are kept within the domain of Intune managed apps.

## Enforce a PIN policy
IT administrators can enforce a PIN policy when an Intune-managed app is started. This policy helps to ensure that the end users who enrolled their devices with Microsoft Intune are the same individuals who are starting the apps. When end users configure their PIN, Intune App SDK uses Azure Active Directory to verify the credentials of end users against the device enrollment credentials. 

## Require users to enter credentials before they can start apps
IT administrators can require users to enter their credentials before users can start an Intune-managed app. Intune App SDK uses Azure Active Directory to provide a single sign-on experience, where the credentials, once entered, are reused for subsequent logins. We also support authentication of identity management solutions [federated with Azure Active Directory](/active-directory/active-directory-aadconnect-federation-compatibility). 

## Check device health and compliance
IT administrators can a check the health of the device and its compliance with corporate policies before end users access Intune-managed apps. On the iOS platform, this policy checks if the device has been jailbroken. On the Android platform, this policy checks if the device has been rooted.  


