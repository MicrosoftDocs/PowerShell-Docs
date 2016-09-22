---
# required metadata

title: Troubleshooting ATA using the ATA database | Microsoft ATA
description: Describes how you can use the ATA database to help troubleshoot issues 
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: article
ms.prod:
ms.service: advanced-threat-analytics
ms.technology:
ms.assetid: d89e7aff-a6ef-48a3-ae87-6ac2e39f3bdb

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.7*



# Troubleshooting ATA using the ATA database
ATA uses MongoDB as its database.
You can interact with the database using the default command line or using a user interface tool to perform advanced tasks and troubleshooting.

## Interacting with the database
The default and most basic way to query the database is using the Mongo shell:

1.  Open a command line window and change the path to the MongoDB bin folder. The default path is: **C:\Program Files\Microsoft Advanced Threat Analytics\Center\MongoDB\bin**.

2.  Run: `mongo.exe ATA`. Make sure to type ATA with all capital letters.

|How to...|Syntax|Notes|
|-------------|----------|---------|
|Check for collections in the database.|`show collections`|Useful as an end-to-end test to see that traffic is being written to the database and that event 4776 is being received by ATA.|
|Get the details of a user/computer/group (UniqueEntity), such as user ID.|`db.UniqueEntity.find({SearchNames: "<name of entity in lower case>"})`||
|Find Kerberos authentication traffic originating from a specific computer on a specific day.|`db.KerberosAs_<datetime>.find({SourceComputerId: "<Id of the source computer>"})`|To get the &lt;ID of the source computer&gt; you can query the UniqueEntity collections, as shown in the example.<br /><br />Each network activity type, for example Kerberos authentications, has its own collection per UTC date.|
|Find NTLM traffic originating from a specific computer related to a specific account on a specific day.|`db.Ntlm_<datetime>.find({SourceComputerId: "<Id of the source computer>", SourceAccountId: "<Id of the account>"})`|To get the &lt;ID of the source computer&gt; and &lt;ID of the account&gt; you can query the UniqueEntity collections, as shown in the example.<br /><br />Each network activity type, for example NTLM authentications, has its own collection per UTC date.|
|Search for advanced properties such as the active dates of an account. |`db.UniqueEntityProfile.find({UniqueEntityId: "<Id of the account>")`|To get the &lt;ID of the account&gt; you can query the UniqueEntity collections, as shown in the example.<br>The property name that shows the dates in which the account has been active is called: "ActiveDates". <br>
For example you may want to know if an account has at least 21 days of activity for the abnormal behavior machine learning algorithm to be able to run on it.|
|Make advanced configuration changes. In this example we change the send queue size for all ATA Gateways to 10,000.|`db.SystemProfile.update( {_t: "GatewaySystemProfile"} ,`<br>`{$set:{"Configuration.EntitySenderConfiguration.EntityBatchBlockMaxSize" : "10000"}})`|`|

The following example provides sample code using the syntax provided above. If you are investigating a suspicious activity that occurred on 20/10/2015 and want to learn more about the NTLM activities that "John Doe" performed on that day:<br /><br />First, find the ID of "John Doe"

`db.UniqueEntity.find({Name: "John Doe"})`<br>Take a note of his ID as indicated by the value of "`_id`" For our example, let's assume the ID is "`123bdd24-b269-h6e1-9c72-7737as875351`"<br>Then, search for the collection with the closest date that is before the date you are looking for, in our example 20/10/2015.<br>Then, search for John Doe's account NTLM activities: 

`db.Ntlms_<closest date>.find({SourceAccountId: "123bdd24-b269-h6e1-9c72-7737as875351"})`

## See Also
- [ATA prerequisites](/advanced-threat-analytics/plan-design/ata-prerequisites)
- [ATA capacity planning](/advanced-threat-analytics/plan-design/ata-capacity-planning)
- [Configure event collection](/advanced-threat-analytics/deploy-use/configure-event-collection)
- [Configuring Windows event forwarding](/advanced-threat-analytics/deploy-use/configure-event-collection#configuring-windows-event-forwarding)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
