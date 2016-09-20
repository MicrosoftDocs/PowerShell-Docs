---
# required metadata

title: Overview of the MDM lifecycle | Microsoft Intune
description: Learn how Intune helps you manage devices through their lifecycle—from enrollment, through configuration, to eventual retirement.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 07/19/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: f6051fa7-133f-4712-86a5-e5f5bc5ab3c7

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Overview of the mobile device management (MDM) lifecycle

All devices that you manage have what we call a *lifecycle*. Intune can help you manage this lifecycle—from enrollment, through configuration and protection, to retiring the device when it's no longer required:

![The device lifecycle](./media/device-lifecycle.png "the Intune device lifecycle")

## Enroll
Today's mobile device management (MDM) strategies deal with a variety of phones, tablets, and PCs (iOS, Android, Windows, and Mac OS X). If you need to be able to manage the device, which is commonly the case for corporate-owned devices, the first step is to [set up device enrollment](enroll-devices-in-microsoft-intune.md). You can also manage Windows PCs by enrolling them with Intune (MDM) or by [installing the Intune client software](manage-windows-pcs-with-microsoft-intune.md).

## Configure
Getting your devices enrolled is just the first step. To take advantage of all that Intune offers and to ensure that your devices are secure and compliant with company standards, you can choose from a wide range of policies. These let you configure almost every aspect of how managed devices operate. For example, should users have a password on devices that have company data? You can require one. Do you have corporate Wi-Fi? You can automatically configure it. Here are the types of configuration options that are available:

- [**Configuration policies**](manage-settings-and-features-on-your-devices-with-microsoft-intune-policies.md). These policies let you configure the features and capabilities of the devices that you manage. For example, you could require the use of a password on Windows phones or disable the use of the camera on iPhones.
- [**Company resource access policies**](enable-access-to-company-resources-with-microsoft-intune.md). When you let your users access their work on their personal device, this can present you with challenges. For example, how do you ensure that all devices that need to access company email are configured correctly? How can you ensure that users can access the company network with a VPN connection without having to know complex settings? Intune can help to reduce this burden by automatically configuring the devices that you manage to access common company resources.
- [**Windows PC management policies (with the Intune client software)**](common-windows-pc-management-tasks-with-the-microsoft-intune-computer-client.md). While enrolling Windows PCs with Intune gives you the most device management capabilities, Intune continues to support managing Windows PCs with the Intune client software. If you need information about some of the tasks that you can perform with PCs, start here.

## Protect
In the modern IT world, protecting devices from unauthorized access is one of the most important tasks that you'll perform. In addition to the items in the **Configure** step of the device lifecycle, Intune provides these capabilities that help protect devices you manage from unauthorized access or malicious attacks:
- [**Multi-factor authentication**](protect-windows-devices-with-multi-factor-authentication.md). Adding an extra layer of authentication to user sign-ins can help make devices even more secure. Windows, Windows Phone, and Windows Mobile devices offer multi-factor authentication that requires a second level of authentication, such as a phone call or text message, before users can gain access.
- [**Microsoft Passport settings**](control-microsoft-passport-settings-on-devices-with-microsoft-intune.md). Microsoft Passport is an alternative sign-in method that lets users use a *gesture*—such as a fingerprint or Windows Hello—to sign in without needing a password.
- [**Policies to protect Windows PCs (with the Intune client software)**](policies-to-protect-windows-pcs-in-microsoft-intune.md). When you manage Windows PCs by using the Intune client software, policies are available that let you control settings for Endpoint Protection, software updates, and Windows Firewall on PCs that you manage.

## Retire
When a device gets lost or stolen, when it needs to be replaced, or when users move to another position, it's usually time to [retire or wipe](use-remote-wipe-to-help-protect-data-using-microsoft-intune.md) the device. There are a number of ways you can do this—including resetting the device, removing it from management, and wiping the corporate data on it.
