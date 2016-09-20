---
# required metadata

title: Enable access to company resources | Microsoft Intune
description:  Wi-Fi, VPN, and email profiles work together to help your users gain access to the files and resources they need.
keywords:
author: Nbigman
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 3dd8dd4e-e165-4d0c-97b7-b3e86ebab909

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Enable access to company resources with Microsoft Intune
Microsoft Intune Wi-Fi, VPN, and email profiles work together to help your users gain access to the files and resources that they need to do their work wherever they are. Certificate profiles help secure that access.

## [Wi-Fi profiles](wi-fi-connections-in-microsoft-intune.md) and supported platforms

Deploy wireless network settings to your users. These settings make it easy for your users to connect to the corporate network.
#### Supported platforms

|Windows 8.1 and later|Windows Phone 8.1 and later|iOS|Android|Samsung KNOX|
|---------------------|---------------------------|---|-------|------------|
|Yes (You can import a Windows Wi-Fi profile.)|Yes (You can configure OMA-URI.) |Yes|Yes|Yes|

## [VPN profiles](vpn-connections-in-microsoft-intune.md) and supported platforms
Deploy virtual private network (VPN) settings to your users. These settings make it easy for users to connect to resources on the corporate network.

|Windows 8.1 and later|Windows Phone 8.1 and later|iOS|Android|Samsung KNOX|
|---------------------|---------------------------|---|-------|------------|
|Yes|Yes|Yes|Yes|Yes|

## [Email profiles](configure-access-to-corporate-email-using-email-profiles-with-microsoft-intune.md) and supported platforms
Create, deploy, and monitor native email client settings on devices in your organization.

|Windows 8.1 and later|Windows Phone 8.1 and later|iOS|Android|Samsung KNOX|
|---------------------|---------------------------|---|-------|------------|
|No|Yes|Yes|No|Yes|
> [!NOTE]
> [This Intune team blog post](https://blogs.technet.microsoft.com/enterprisemobility/2015/02/19/using-oma-uri-to-create-custom-wi-fi-profiles-for-windows-phone-8-1/) gives information about how to configure a Windows Phone 8.1 Wi-Fi profile using OMA-URI.

## [Certificate profiles](secure-resource-access-with-certificate-profiles.md) and supported platforms
Help secure access to company resources including wireless networks and VPN connections.

|Windows 8.1 and later|Windows Phone 8.1 and later|iOS|Android|Samsung KNOX|
|---------------------|---------------------------|---|-------|------------|
|Yes|Yes|Yes|Yes|Yes|
