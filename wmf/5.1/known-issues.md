---
title:   Known Issues in WMF 5.1 (Preview)
ms.date:  2016-07-13
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  krishna
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

#Known Issues in WMF 5.1 (Preview) #

> Note: This information is preliminary and subject to change.

##Starting PowerShell shortcut as Administrator
Upon installing WMF, if you try to start PowerShell as administrator from the shortcut, you may get an "Unspecified error" message.
Reopen the shortcut as non-administrator and the shortcut will now work even as administrator.

##Pester
In this release, there are two issues you should be aware of when using Pester on Nano Server:

* Running tests against Pester itself can result in some failures because of differences between FULL CLR and CORE CLR. In particular, the Validate method is not available on the XmlDocument type. Six tests which attempt to validate the schema of the NUnit output logs are known to fail. 
* One Code Coverage test fails currently because the *WindowsFeature* DSC Resource does not exist in Nano Server. However, these failures are generally benign and can safely be ignored.

##Operation Validation 

* Update-Help will fail for Microsoft.PowerShell.Operation.Validation module due to non-working help URI
