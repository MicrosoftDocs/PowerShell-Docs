---
ms.date:  03/27/2018
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,psgallery,GDPR
title:  PowerShell Gallery GDPR Compliance
---

# PowerShell Gallery GDPR Compliance

## Overview

In May 2018, a European privacy law, the General Data Protection Regulation (GDPR), will take effect. 
The GDPR imposes new rules on companies, government agencies, non-profits, and other organizations that offer goods and services to people in the European Union (EU), or that collect and analyze data tied to EU residents. The GDPR applies no matter where you are located. 

Microsoft products and services are available today to help you meet the GDPR requirements. 
Read more about Microsoft Privacy policy at [Trust Center](https://www.microsoft.com/trustcenter).

The PowerShell Gallery meets GDPR requirements. 

The Powershell Gallery stores the following information that may be provided by users, which may contain End User Identifiable Information (EUII):

* PowerShell Gallery account 
* Items published to the PowerShell Gallery
* Email correspondence with the PowerShell Gallery team 

Most users do not create a PowerShell Gallery account, as it is not required unless the user is going to publish an item, or use the "Contact Owner" feature in the PowerShell Gallery. 
The PowerShell Gallery does not store EUII data for users who have not created a PowerShell Gallery account, other than email correspondence initiated by the user. 

Users who create a PowerShell Gallery account can publish items to the PowerShell Gallery. 
Those items are expected to be PowerShell code, but may contain other information. The information below will show how you can get all the items you have published to the PowerShell Gallery.


## DSR Export of PowerShell Gallery Data

The following sections describe the PowerShell Gallery supports a GDPR Data Subject Request (DSR) by explaining how to export information stored in the PowerShell Gallery, and how to request deletion of this information.

__Email__ 

Email correspondence may include any of the following:

* Email sent to the owners of PowerShell Gallery items if the code analysis scans detected an issue with any item they have published to the PowerShell Gallery
* Email sent by anyone to the PowerShell Gallery team using the email address in the "Contact Us" page (cgadmin@microsoft.com)
* Registered users who use the "Contact Owner" feature in the PowerShell Gallery to send email to the owner of an item in the PowerShell Gallery

Emails sent by or to the PowerShell Gallery have a retention policy of 90 days, in order to support possible security investigations should malicious code be discovered on the PowerShell Gallery. 
Emails are deleted by policy after 90 days.

Users may request copies of all emails that sent within the previous 90 days to or from the PowerShell Gallery to their email account. This can be done by sending an email to cgadmin@microsoft.com, with the title: "DSR Request for emails relating to this account", and stating in the body what they are seeking (for example: Please send all emails sent to or received from this email address that you currently have.) All emails involving that email address within 90 days of the request will be sent to the requesting email account within 7 business days.


__PowerShell Gallery Account Information__

If you have created a PowerShell Gallery account, you can find all information that has been stored in PowerShell Gallery by taking the following steps: 

1. Sign in to the PowerShell Gallery, then click on your username
2. The next page displayed is the Account page, which shows the email address used for the PowerShell Gallery account

If you have created more than one account in the PowerShell Gallery, you will need to repeat these steps for each account.

__Items in the PowerShell Gallery__

To facilitate exporting all versions of all items, users may download the script "GetPSGalleryItemsForAuthor" from the PowerShell Gallery, or from https://github.com/powershell/powershellgallery. This script will export a copy of every version of every item put onto the PowerShell Gallery based on the author information stored in the item. It is important to note that the Author is stored in the item manifest when you publish your item,and is not guaranteed to be the same as the account you use in the PowerShell Gallery. If you use some other value in the Author field, you will need to supply that value when using this script.

You may download the script by using the following PowerShell command:

Save-Script GetPSGalleryItemsForAuthor -path <local folder location> -repository psgallery 

You can then run the script directly, by running the following PowerShell commands:
cd <local folder location supplied previously>
.\GetPSGalleryItemsForAuthor 

You will be prompted to supply the Author and a folder on your system where you want the items to be saved.

