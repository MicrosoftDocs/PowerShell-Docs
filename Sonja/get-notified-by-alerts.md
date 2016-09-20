---
# required metadata

title: Get notified by alerts | Microsoft Intune
description: Learn how alerts keep you in touch with what's happening in Microsoft Intune.
keywords:
author: Nbigman
manager: angrobe
ms.date: 07/21/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 396ea714-0433-4bd5-a934-8d0b477f28e4

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Get notified by Microsoft Intune alerts
Alerts keep you in touch with what's happening in Microsoft Intune.

For example, alerts can notify you about the following events:

-   A problem with the Exchange Connector which affects mobile device management

-   Malware was found on a computer

-   A conflict between two Intune policies was detected


## How alerts work
Alerts are generated based on **alert types**, a set of preconfigured rules built into Intune. For example, the alert type, **Cloud storage has 10% or less free space**, alerts you when you are running out of space to store your apps in the cloud. You can enable or disable alert types and configure properties for each alert type. For example, using the above alert type, you can configure:

-   **State:** Whether this alert type is enabled or disabled

-   **Severity:** How serious is this alert?


|Severity|Details|
|--------|-------|
    |![Critical alert](../media/Critical-Alert.jpg)|Indicates a serious issue that you should investigate as soon as possible, for example, if malware was detected on a computer.|
    |![Warning alert](../media/Warning-Alert.jpg)|Indicates an issue that isn't currently serious but might become serious if you don't attend to it, for example, security updates are waiting to be installed.|
    |![Informational alert](../media/Informational-Alert.jpg)|Indicates information that isn't critical to your operations, for example, a new version of the Exchange Connector is available.|

Other alert types might have different items that you can configure, like the percentage of devices that must be affected by an issue before an alert is generated.

**When the criteria in an alert type is met, an alert is generated and shown in the Intune admin console.**

Additionally, you can configure Intune to notify you by email when an alert is generated.

## Set up alerts
In the [Microsoft Intune administration console](https://manage.microsoft.com), choose **Admin** &gt; **Alerts and Notifications**, and then choose one of the following tasks:

|Task|Description|
|--------|---------------|
|**Alert Types**|Choose the alert type that you want to configure, and then do one of the following:<br /><br />Choose **Configure**. In the **Configure Alert Type** dialog box, configure the settings that you want, and then choose **OK**.<br /><br />**Enable** or **Disable** the alert.<br /><br />Expand the **Alert Types** node, and choose a category to view only the alert types in that category.|
|**Recipients**|Choose **Add** to add a new email address that will receive the email notifications that you set up.<br /><br />You can also **Edit** or **Delete** existing recipients.<br /><br />To receive notifications, you must also add this email address as a recipient under **Notification Rules**.|
|**Notification Rules**|Configures rules that define who an email alert will be sent to. You can either:<br /><br />**Choose an existing rule** - Choose a rule, and then choose **Select Recipients**. You can then select all recipients who will receive an email when an alert that fulfills this rule is generated.<br /><br />**Create a new rule** - enter a name for the rule, select the alert categories and alert severity that apply to the rules, select the device groups that the rule applies to, and select the users who will receive an email when an alert is generated.<br /><br />You can also **Enable**, **Disable**, **Edit**, or **Delete** an existing rule.|

## Working with alerts
Use the following options to help you work with alerts from the Intune admin console.

|Option|Description|
|----------|---------------|
|**View active alerts**|Choose one of:<br /><br />**View an alert summary** - In the **Dashboard** workspace, the top errors are shown in the Alerts pane. Choose the pane to see more detailed information.<br /><br />Additionally, you can view an alert summary on the **Overview** page of the **Alerts** workspace.<br /><br />**View all alerts** - In the **Alerts** workspace, choose **All Alerts**.|
|**View notices**|Choose one of:<br /><br />In the **Dashboard** workspace, choose **Notices**.<br /><br />In the **Alerts** workspace, choose **All Alerts** &gt; **Notices**.|
|**Close an alert**|In the list of alerts, choose the alert to close, and then choose **Close Alert**.<br /><br />Closed alerts are permanently deleted after 90 days.|
|**Reactivate a closed alert**|In the list of alerts, set the **Filters** drop-down to **Closed**.<br /><br />In the list of closed alerts, select the alert that you want to reactivate, and then choose **Reactivate Alert**.|
Intune alerts remain active until:

-   The issue that caused the alert is fixed

-   You manually close the alert

-   45 days have passed since the alert was generated

> [!TIP]
> If the same alert is generated by devices that run different operating systems, you might see multiple versions of the same alert in the alerts list.

### See also
[Monitoring and reports with Microsoft Intune](monitoring-and-reports-with-microsoft-intune.md)
