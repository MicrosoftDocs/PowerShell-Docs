---
title: Use remote lock and passcode reset | Microsoft Intune
description: Intune provides both remote lock and passcode reset capabilities.
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 970f8c81-7c7f-4789-9ed4-2133d50b9db6

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: chrisgre
#ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:
---
# Help protect your devices with remote lock and passcode reset
Microsoft Intune provides both remote lock and passcode reset capabilities.

## Lock a device remotely
If a user loses their device you can lock the device remotely. The table below lists how remote lock works on different mobile platforms. Remote lock is not supported

|Platform|Remote lock|
|------------|---------------|
|iOS|Supported|
|Android|Supported|
|Windows 10 and Windows 10 Mobile|Supported|
|Windows Phone 8 and Windows Phone 8.1|Supported|
|Windows RT 8.1 and Windows RT|Supported if the current user of the device is the same user who enrolled the device.|
|Windows 8.1|Supported if the current user of the device is the same user who enrolled the device.|

Remote lock is not supported for Windows PCs enrolled with the Intune software client.

### To lock a mobile device remotely through the Intune console

1.  In the [Intune administrator  console](https://manage.microsoft.com/), choose **Groups** &gt; **All Devices** &gt; **All Mobile Devices**.

2.  Choose **All Direct Managed Devices** for devices enrolled in Intune or **All Exchange ActiveSync Managed Devices**.

    > [!TIP]
    > You can also navigate to a device by user. Choose **All Users**. On the user's properties page, choose **Devices**, and then choose the name of the mobile device you want to wipe.

3.  In the list, choose the device or devices that you want to lock. On the taskbar, choose **Remote Tasks**, and select **Remote Lock**.

## Reset the passcode on a device
If a user forgets their passcode, you can help them by removing the passcode from a device or by forcing a new temporary passcode on a device. The table below lists how passcode reset works on different mobile platforms.

|Platform|Passcode reset|
|------------|------------------|
|iOS|Supported for clearing the passcode from a device. Does not create a new temporary passcode.|
|Android|Supported and a temporary passcode is created.|
|Windows 10 Mobile|Supported|
|Windows Phone 8 and Windows Phone 8.1|Supported|
|Windows RT 8.1 and Windows RT|Not Supported|
|Windows 8.1|Not Supported|

Passcode reset is not supported for Windows PCs enrolled with the Intune software client.

### To reset a passcode

1.  In the [Intune administrator console](https://manage.microsoft.com/), choose **Groups** &gt; **All Devices** &gt; **All Mobile Devices**.

2.  Choose **All Direct Managed Devices** for devices enrolled in Intune or **All Exchange ActiveSync Managed Devices**.

    > [!TIP]
    > You can also navigate to a device by user. Click **All Users**. On the user's properties page, click **Devices**, and then click the name of the mobile device you want to wipe.

3.  In the list, choose the device or devices that you want to lock. On the taskbar, choose **Remote Tasks**, and select **Passcode Reset**.


### See also
[Retire devices](retire-devices-from-microsoft-intune-management.md)
[Windows Selective Wipe for Device Data Management](http://technet.microsoft.com/library/dn486874.aspx)
