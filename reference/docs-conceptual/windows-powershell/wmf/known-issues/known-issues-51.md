---
ms.date:  06/12/2017
ms.topic: conceptual
title:  Known Issues in WMF 5.1
description:  Known Issues in WMF 5.1
---
# Known Issues in WMF 5.1

## Starting PowerShell shortcut as Administrator

Upon installing WMF, if you try to start PowerShell as administrator from the shortcut, you may get
an "Unspecified error" message. Reopen the shortcut as non-administrator and the shortcut now works
even as administrator.

## Pester

In this release, there are two issues you should be aware of when using Pester on Nano Server:

- Running tests against Pester itself can result in some failures because of differences between
  FULL CLR and CORE CLR. In particular, the **Validate** method is not available on the
  **XmlDocument** type. Six tests which attempt to validate the schema of the NUnit output logs are
  known to fail.
- One code coverage test fails because the **WindowsFeature** DSC Resource does not exist in Nano
  Server. However, these failures are generally benign and can safely be ignored.

## Operation Validation

- `Update-Help` fails for Microsoft.PowerShell.Operation.Validation module due to non-working help
  URI

## DSC after uninstall WMF

- Uninstalling WMF does not delete DSC MOF documents from the configuration folder. DSC won't work
  properly if the MOF documents contain newer properties which are not available on the older
  systems. In this case, run the following script from elevated PowerShell console to clean up the
  DSC states.

  ```powershell
  $PreviousDSCStates = @("$env:windir\system32\configuration\*.mof",
    "$env:windir\system32\configuration\*.mof.checksum",
    "$env:windir\system32\configuration\PartialConfiguration\*.mof",
    "$env:windir\system32\configuration\PartialConfiguration\*.mof.checksum"
  )
  $PreviousDSCStates | Remove-Item -ErrorAction SilentlyContinue -Verbose
  ```

## JEA Virtual Accounts

JEA endpoints and session configurations configured to use virtual accounts in WMF 5.0 will not be
configured to use a virtual account after upgrading to WMF 5.1. This means that commands run in JEA
sessions will run under the connecting user's identity instead of a temporary administrator account,
potentially preventing the user from running commands which require elevated privileges. To restore
the virtual accounts, you need to unregister and re-register any session configurations that use
virtual accounts.

```powershell
# Find the JEA endpoint by its name
$jea = Get-PSSessionConfiguration -Name MyJeaEndpoint

# Copy the cached PSSC file so it can be re-registered
$pssc = Copy-Item $jea.ConfigFilePath $env:temp -PassThru

# Unregister the current PSSC
Unregister-PSSessionConfiguration -Name $jea.Name

# Re-register the PSSC
Register-PSSessionConfiguration -Name $jea.Name -Path $pssc.FullName -Force

# Ensure the access policies remain the same
Set-PSSessionConfiguration -Name $newjea.Name -SecurityDescriptorSddl $jea.SecurityDescriptorSddl
```
