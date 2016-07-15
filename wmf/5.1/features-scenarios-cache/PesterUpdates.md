---
title: Pester updated to version 3.4.0 
author:jaimeo
contributor: jkeithb
contributor: Keith Bankston (expert is Jim Truher)
---

In version 5.1, the version of Pester that ships with PowerShell has been updated from 3.3.5 to 3.4.0, with the addition of commit https://github.com/pester/Pester/pull/484/commits/3854ae8a1f215b39697ac6c2607baf42257b102e, which enables better behavior for Pester on Nano. 


You can review the changes in versions 3.3.5 to 3.4.0 by inspecting the ChangeLog.md file at: https://github.com/pester/Pester/blob/master/CHANGELOG.md

**Known Issues**
Pester on Nano 
* Running tests against Pester itself still results in some failures due to  differences between FULL CLR and CORE CLR, specifically the Validate method is not available on the XmlDocument type. There are 6 tests which attempt to validate the schema of the nunit output logs which fail. 
* One Code Coverage test fails curently because the *WindowsFeature* DSC Resource does not exist on Nano. These failures are generally benign.