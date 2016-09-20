---
# required metadata

title: Understand operations by using reports | Microsoft Intune
description: Create and manage reports about software, hardware, and software licenses in your organization.

keywords:
author: Nbigman
manager: angrobe
ms.date: 06/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 857309c2-61c9-4c22-becf-4839fedeaece

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: pbala
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:


---

# Understand Microsoft Intune operations by using reports
Use the information in this topic to help you create and manage Microsoft Intune reports that provide information about software, hardware, and software licenses in your organization.

## Using reports
Intune reports provide information about software, hardware, and software licenses in your organization. Reports can help you confirm current needs and forecast future spending. The **Reports** workspace gives you the tools to create and manage reports. 

### Report types

|Report type|Description|
|---------------|---------------|
|**Update Reports**|Show the software updates that succeeded on computers in your organization. They also show the updates that failed, are pending, or are needed. For more information on software updates, see [Keep Windows PCs up to date with software updates in Microsoft Intune](keep-windows-pcs-up-to-date-with-software-updates-in-microsoft-intune.md).|
|**Detected Software reports**|Show software that is installed on computers in your organization. Software versions are included. You can filter the information that displays based on the software publisher and the software category. You can expand the updates in the list to show more detail (such as the computers on which an update is installed) by choosing the directional arrow next to the list item.<br /><br />When you retire computers or change their group memberships in Intune, it can take several minutes for these changes to be reflected in the Detected Software report. For the most accurate software inventory data, wait a few minutes after retiring computers or changing their group memberships before you run a detected software report that includes those computers.|
|**Computer Inventory Reports**|Show information about managed computers in your organization. Use this report to plan hardware purchases and to understand more about the hardware needs of users in your organization. For more information on working with managed computers, see [Manage Windows PCs with Microsoft Intune](manage-windows-pcs-with-microsoft-intune.md).|
|**Mobile Device Inventory Reports**|Show information about the mobile devices in your organization. You can filter the information that displays based on groups, whether the device is a jailbroken or rooted device, and by operating system.|
|**License Purchase Reports**|Show the software titles for all licensed software in selected license groups, based on their licensing agreements. If software license information has not refreshed in more than 24 hours, it will refresh when you generate a license report. A license report is not an exact calculation of software titles that are being used, or proof of compliance with agreements. The report is a tool to help you make licensing decisions for your organization. Intune might not detect some products that are able to have a Microsoft volume license. The available filters are:<br /><br />**All agreements** shows all licensed software products that are managed by Intune.<br /><br />**Volume licensing agreements** shows only Volume Licensing Service Center (VLSC) software products.<br /><br />**Other software licensing agreements** shows software products that are managed outside of the VLSC.|
|**License Installation Reports**|Compare installed software on computers in your organization with your current license agreement coverage, according to the VLSC. Filters include:<br /><br />**All agreements** shows all licensed software products that are managed by Intune.<br /><br />**Volume licensing agreements** shows only VLSC software products.<br /><br />**Other software licensing agreements** shows software products that are managed outside of the VLSC.|
|**Terms and Conditions Reports**|Show whether users accepted the terms and conditions that you deployed, and which version they accepted. You can show the acceptance of any terms and conditions that were deployed for up to 10 users, or show the acceptance status for a particular term that was deployed to them.|
|**Noncompliant Apps Reports**|Show information about the users who have apps installed that are on your lists of compliant and noncompliant apps. Use this report to find users and devices that are not in compliance with your company app policies.|
|**Certificate Compliance Reports**|Show which certificates have been issued to users and devices through SCEP or PKCS #12 (.PFX). Use this report to find certificates that are issued, expired, and revoked.|
|**Device History Reports**|Show a historical log of retire, wipe, and delete actions. Use this report to see who initiated actions on devices in the past.|
|**Health Attestation Reports**|Show the health of mobile devices.|
|**Mac OS X Hardware Report**|Displays hardware details for all enrolled Mac OS X devices in the groups that you select. For information about the hardware inventory that is collected from these devices, see [Understand your devices with inventory in Microsoft Intune](understand-your-devices-with-inventory-in-microsoft-intune.md).|
|**Mac OS X Software Report**|Displays the software that is installed on all Mac OS X devices in the groups that you selected. The report lists the software name (as a bundle ID), the short version (or friendly) name, the version, and the number of devices with the software installed.|

#### To create a report

1.  In the Intune admin console, choose **Reports**. Then choose the report type that you want to generate, as described in the previous table.

2.  On the **Create New Report** page, accept the default values, or customize them to filter the results that will be returned by the report. For example, you could select that only software published by Microsoft will be displayed in the Detected Software report.

3.  Choose **View Report** to open the report in a new window.

To sort the report by any of the displayed columns, choose the column heading. Additionally, some reports allow you to expand items in the list to show more detail.

## More report actions
In addition, reports support the following actions:

|Action|More information|
|----------|--------------------|
|**Print**|In an open report, choose the print icon and follow the instructions.|
|**Export**|In an open report, choose the export icon and follow the instructions. You can export a report to comma-separated values (.csv) or HTML format.|
|**Save**|On the **Create New Report** page, each user can save up to 100 reports. Configure the report parameters to your requirements, and then choose **Save** or **Save As** (if you want to use a different name).|
|**Load**|On the **Create New Report** page, choose **Load** to retrieve any previously saved sets of report parameters.|
|**Delete**|In the **Reports** workspace, select the desired report type and choose **Load**. Then, in the list of reports, choose the delete (x) icon next to the report.|

### See also
[Monitoring and reports with Microsoft Intune](monitoring-and-reports-with-microsoft-intune.md)
