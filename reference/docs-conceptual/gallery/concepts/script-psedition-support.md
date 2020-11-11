---
ms.date:  06/12/2017
title:  Script with compatible PowerShell editions
description: This article explains how the PowerShellGet cmdlets support the Desktop and Core editions of PowerShell scripts.
---
# Script with compatible PowerShell editions

Starting with version 5.1, PowerShell is available in different editions which denote varying
feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules
  targeting versions of PowerShell running on full footprint editions of Windows such as Server
  Core and Windows Desktop.

- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules
  targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano
  Server and Windows IoT.

The running edition of PowerShell is shown in the PSEdition property of $PSVersionTable.

```powershell
$PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.14300.1000
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
CLRVersion                     4.0.30319.42000
BuildVersion                   10.0.14300.1000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

Script authors can prevent a script from executing unless it is run on a compatible edition of
PowerShell using the PSEdition parameter on a `#requires` statement.

```powershell
Set-Content C:\script.ps1 -Value "#requires -PSEdition Core
Get-Process -Name PowerShell"
Get-Content C:\script.ps1
#requires -PSEdition Core
Get-Process -Name PowerShell

C:\script.ps1
C:\script.ps1 : The script 'script.ps1' cannot be run because it contained a "#requires" statement for PowerShell editions 'Core'. The edition of PowerShell that is required by the script does not match the currently running PowerShell Desktop edition.
At line:1 char:1
+ C:\script.ps1
+ ~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (script.ps1:String) [], RuntimeException
    + FullyQualifiedErrorId : ScriptRequiresUnmatchedPSEdition
```

PowerShell Gallery users can find the list of scripts supported on a specific PowerShell Edition.
Scripts without PSEdition_Desktop and PSEdition_Core tags are considered to work fine on PowerShell
Desktop edition.

```powershell
# Find scripts supported on PowerShell Desktop edition
Find-Script -Tag PSEdition_Desktop

# Find scripts supported on PowerShell Core edition
Find-Script -Tag PSEdition_Core
```

## More details

- [Modules with PSEditions](module-psedition-support.md)
- [PSEditions support on PowerShellGallery](../how-to/finding-packages/searching-by-compatibility.md)
