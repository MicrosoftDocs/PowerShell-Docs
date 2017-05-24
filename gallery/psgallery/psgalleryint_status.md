---
description:  
manager:  carolz
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,gallery
ms.date:  2016-10-14
contributor:  manikb
title:  psgalleryint_status
ms.technology:  powershell
---

PowerShell Gallery Status
=========================

## 03/27/2017 - RESOLVED: Unable to see individual module and script pages

__Summary of Impact__: Direct links to individual module and script pages on https://www.powershellgallery.com were broken. This was being reported across all the regions. This did not impact any of the PowerShellGet cmdlets ie., Install-Module, Install-Script, Update-Module, Update-Script, Publish-Module, Publish-Script continued to work.

__Root Cause__: Engineers identified the cause as an issue bringing up social media buttons like Facebook onto the page.  

__Resolution__: Engineers fixed the problem by disabling the Facebook count information.

__Next Steps__: We opened an internal tracking issue to fix our usage of Facebook API.

## 12/15/2016 - Unable to send emails via PowerShellGallery website

__Summary of Impact__: Between 12/13/2016 and 12/15/2016, any messages sent via Contact Owners, Manage Owners, Contact Support, or Report Abuse were not received by the PowerShell Gallery Administrators.  
__Root Cause__: Engineers identified the cause as an authentication issue with the SMTP server.  
__Resolution__: Engineers were able to resolve the authentication issue and restore connection to the SMTP server.  
__Next Steps__: If you used the Contact Owners, Manage Owners, Contact Support, or Report Abuse links to send mail to cgadmin@microsoft.com during this time and we have not responded, please try again. We apologize for the inconvenience.   


## 8/10/2016 - Resolved: Unable to send emails to cgadmin@microsoft.com
__Summary of Impact__: Between 8/5/2016 and 8/10/2016, customers were unable to send emails to cgadmin@microsoft.com, or use the Contact Us feature.  
__Root Cause__: Engineers identified the cause as a configuration change of the email account.  
__Resolution__: Engineers worked to resolve the configuration issue.  
__Next Steps__: If you used the Contact Us link or sent mail to cgadmin@microsoft.com during this time and we have not responded, please try again. Thank you for your patience.


