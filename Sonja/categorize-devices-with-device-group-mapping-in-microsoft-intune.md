---
# required metadata

title: Categorize devices with device group mapping | Microsoft Intune
description: Use Microsoft Intune device group mapping to group devices into categories that you define, in order to make it easier for you to manage those devices. 
keywords:
author: robstackmsft
manager: angrobe
ms.date: 08/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 8b8c06a3-6b6c-4cf1-8646-b24fa9b1a39e

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: sumitp
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Categorize devices with device group mapping in Microsoft Intune
Use Microsoft Intune **device group mapping** to group devices into categories that you define, in order to make it easier for you to manage those devices. 

Device group mapping uses the following workflow:
1. You create Intune device groups for each category you want to use.
2. You configure device group mapping rules that map the category you choose to the device group you created.
3. When end users enroll their device, they must choose a category from the categories you configured. After they choose, their device will be automatically added to the corresponding device group you created.
4. You can then use these device groups when you deploy policies and apps.

Examples of categories might be:
* Personal
* Point of sale device
* Demonstration device
* Sales
* Accounting
* Manager

However, you can configure any categories you want.

## How to configure device group mapping
1. For each device category you want to use, create an Intune device group. For information about how to create groups, see [Use groups to manage users and devices with Microsoft Intune](use-groups-to-manage-users-and-devices-with-microsoft-intune.md).
2. In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Admin**.
3. In the **Administration** workspace, expand **Mobile Device Management**, and then choose **Device Group Mapping**.
4. On the **Device Group Mapping** page, enable device group mapping.
5. Choose **Add** to create a new mapping rule.
6. In the **Add device group mapping rule** dialog box, enter the name of the category you want to create and then, from the drop-down list, choose the device collection you want to map this category to. Choose **Add** when you are done.
7. When you have finished adding categories and groups, choose **Save**.

Now, when users enroll their device, they will be presented with a list of the categories you configured. After they choose a category and finish enrollment, their device will be added to the device group that corresponds with the category they chose.

### See also
[Use groups to manage users and devices with Microsoft Intune](use-groups-to-manage-users-and-devices-with-microsoft-intune.md)