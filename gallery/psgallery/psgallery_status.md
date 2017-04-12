---
description:  
manager:  carolz
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,gallery
ms.date:  2016-10-14
contributor:  manikb
title:  psgallery_status
ms.technology:  powershell
---

PowerShell Gallery Status
=========================

## 04/11/2017 - Users unable to log in with Azure Active Directory (AAD) accounts

__Summary of Impact__: Some users were unable to log in to the PowerShell Gallery using Azure AD Accounts. 
 
__Root Cause__: During an update to interact more securely with AAD, a setting change was missed. 
The testing done to validate the change did not include certain types of AAD accounts, so the deployment proceeded.

__Resolution__: Engineers identified the missing setting and corrected the problem. 

__Next Steps__: We will be modifying our testing to include a broader set of AAD account types.

## 03/27/2017 - RESOLVED: Unable to see individual module and script pages

__Summary of Impact__: Direct links to individual module and script pages on https://www.powershellgallery.com were broken. This was being reported across all the regions. This did not impact any of the PowerShellGet cmdlets ie., Install-Module, Install-Script, Update-Module, Update-Script, Publish-Module, Publish-Scirpt continued to work.

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



## 7/13/2016 - Download Items Failed

__Summary of Impact__: Between 7/11/2016 and 7/13/2016, a subset of customers experienced issues downloading items from the PowerShell Gallery. The issue likely manifested itself in the following error message returned from Install-Module/Install-Script and Save-Module/Save-Script:

```PowerShell
PS C:\> Install-Module xStorage 
PackageManagement\Install-Package : Package 'xStorage' failed to be installed because: 
End of Central Directory record could not be found. At C:\Program 
Files\WindowsPowerShell\Modules\PowerShellGet\1.0.0.1\PSModule.psm1:1375 char:21 + ... 
$null = PackageManagement\Install-Package @PSBoundParameters + 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ + CategoryInfo : InvalidResult: 
(xStorage:String) [Install-Package], Exception + FullyQualifiedErrorId : Package '{0}' 
failed to be installed because: {1},Microsoft.PowerShell.PackageManagement.Cmdlets.InstallPackage 
```

__Preliminary root cause__: Engineers identified an issue with Azure Content Deliver Network (CDN), which was deployed to the PowerShell Gallery on 7/11/2016.  
__Mitigation__: Engineers disabled Azure CDN in the PowerShell Gallery.  
__Next Steps__: Investigate the underlying root cause and developing a solution to prevent future occurrences.


## 5/19/2016 - Download Items Failed
__Summary of Impact__: Between 5/17/2016 and 5/19/2016, a subset of customers experienced issues downloading items from the PowerShell Gallery. The issue likely manifested itself in the following error message returned from Install-Module/Install-Script and Save-Module/Save-Script:

```PowerShell
VERBOSE: Hash for package 'AzureRM.OperationalInsights' does not match hash provided from the server.
VERBOSE: InstallPackageLocal' - name='AzureRM.OperationalInsights', version='1.0.8',
destination='C:\Users\jbritt\AppData\Local\Temp\2\1741355729'
WARNING: Package 'AzureRM.OperationalInsights' failed to be installed because: 
End of Central Directory record could not be found. 
WARNING: Dependent Package 'AzureRM.OperationalInsights' failed to install. 
WARNING: Package 'AzureRM' failed to install. 
VERBOSE: Module 'AzureRM.Network' was saved successfully. 
VERBOSE: Saving the dependency module 'AzureRM.NotificationHubs' with version '1.0.8' for the 
module 'AzureRM'. 
VERBOSE: Module 'AzureRM.NotificationHubs' was saved successfully. 
PackageManagement\Save-Package : Unable to save the module 'AzureRM'. At C:\Program 
Files\WindowsPowerShell\Modules\PowerShellGet\1.0.0.1\PSModule.psm1:1187 char:21 + 
$null = PackageManagement\Save-Package @PSBoundParameters + 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ + 
CategoryInfo : InvalidOperation: (Microsoft.Power...ets.SavePackage:SavePackage) 
[Save-Package], Exception + FullyQualifiedErrorId : ProviderFailToDownloadFile,
Microsoft.PowerShell.PackageManagement.Cmdlets.SavePackage 
```

__Preliminary root cause__: Engineers identified an outage in the underlying provider of Azure Content Deliver Network (CDN), which was deployed to the PowerShell Gallery on 5/17/2016.  
__Mitigation__: Engineers disabled Azure CDN in the PowerShell Gallery.  
__Next Steps__: Investigate the underlying root cause and developing a solution to prevent future occurrences.

