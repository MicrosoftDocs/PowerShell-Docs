---
# required metadata

title: Exchange connector for Exchange Online | Microsoft Intune
description: Connect Intune to Office 365 Exchange service to support Exchange ActiveSync mobile device management (MDM).
keywords:
author: NathBarn
manager: angrobe
ms.date: 07/29/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 05fa5dc9-9bad-4557-987a-9b8ce4edebb0

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: muhosabe
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Configure the Intune service-to-service connector for Exchange Online

Use this information to connect Microsoft Intune and Exchange Online or new Exchange Online Dedicated service. To determine whether your Exchange Online Dedicated environment is in **new** or **legacy**,  contact your account manager. Intune only supports one Exchange connector connection of any type per subscription.

## Requirements for the service-to-service Connector
The **Service to Service Connector** supports only Exchange Online or new Exchange Online Dedicated and has no requirements for on-premises infrastructure.

|Requirement|More information|
|---------------|--------------------|
|Exchange Online configured and running|[Exchange Online](https://technet.microsoft.com/library/jj200580.aspx) |
|Mobile device management authority| [Set the mobile device management authority to Microsoft Intune](get-ready-to-enroll-devices-in-microsoft-intune.md#set-mobile-device-management-authority)|
|Microsoft Exchange version|Exchange Online or new Exchange Online Dedicated service|
|Active Directory Synchronization|Before you can use the Intune Connector, you must [set up Active Directory synchronization](/intune/get-started/start-with-a-paid-subscription-to-microsoft-intune-step-3) so that your local users and security groups are synchronized with your instance of Azure Active Directory.|

### Exchange cmdlet requirements

You must also create an Exchange Online user account that is used by the Intune Exchange Connector. The account must have permission to use the Intune admin console and to run these required Windows PowerShell Exchange cmdlets:

 - Get-ActiveSyncOrganizationSettings, Set-ActiveSyncOrganizationSettings
 - Get-MobileDeviceMailboxPolicy, Set-MobileDeviceMailboxPolicy, New-MobileDeviceMailboxPolicy, Remove-MobileDeviceMailboxPolicy
 - Get-ActiveSyncDeviceAccessRule, Set-ActiveSyncDeviceAccessRule, New-ActiveSyncDeviceAccessRule, Remove-ActiveSyncDeviceAccessRule
 - Get-MobileDeviceStatistics
 - Get-MobileDevice
 - Get-ActiveSyncDeviceClass

## Set up the service-to-service connector

1. Open the [Microsoft Intune administration console](http://manage.microsoft.com) with a user account with Exchange admin rights and permissions for the cmdlets [above](#exchange-cmdlet-requirements). Microsoft Intune uses the email address of the currently logged in user to set up the connection.

2.  In the workspace shortcuts pane, choose **ADMIN**, then go **Mobile Device Management** > **Microsoft Exchange** > **Set Up Exchange Connection**.
![Set up service to service connector page](../media/intunesa5cservicetoserviceconnector.png)

3.  On the **Set Up Exchange Connection** page, choose **Set Up Service to Service Connector**.


The Service-to-Service Connector will automatically configure and synchronize with your Exchange Online or new Exchange Online Dedicated environment.

## Validate your Exchange connection

After you have successfully configured the Exchange Connector, in the [Microsoft Intune administration console](http://manage.microsoft.com) choose the **Admin** and go **Mobile Device Management** > **Microsoft Exchange** and validate that the details you provided appear under **Exchange Connection Information**.

You can also check the time and date of the last successful synchronization attempt.
