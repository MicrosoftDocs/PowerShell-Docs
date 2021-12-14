---
description: DSC is a management platform in PowerShell that enables you to manage your IT and development infrastructure with configuration as code.
ms.date: 12/13/2021
title: PowerShell Desired State Configuration (DSC)
---

# PowerShell Desired State Configuration (DSC) Overview

DSC is a management platform in PowerShell that enables you to manage your IT and development
infrastructure with configuration as code.

There are two active versions of DSC available:

- DSC 2.0 is the legacy version of DSC that originally shipped in Windows PowerShell.

  With the release of PowerShell 7.2, the PSDesiredStateConfiguration module is no longer be
  included in the PowerShell package. Separating DSC into its own module allows us to invest and
  develop DSC independent of PowerShell and reduces the size of the PowerShell package. Users of DSC
  will enjoy the benefit of upgrading DSC without the need to upgrade PowerShell, accelerating time
  to deployment of new DSC features. Users that want to continue using DSC v2 can download
  PSDesiredStateConfiguration 2.0.5 from the PowerShell Gallery.

- DSC 3.0 is the new version of DSC. This version is a preview release that is still being
  developed. Users working with non-Windows environments can expect cross-platform features in DSC
  v3. DSC 3.0 is the version that is supported by the
  [Azure Guest Configuration](/azure/governance/policy/concepts/guest-configuration) feature of
  Azure Policy.

The documentation for DSC has been moved to a new location so that we can manage the DSC
version-specific information separate from the versions of PowerShell.

See the new documentation at
[https://docs.microsoft.com/powershell/dsc](/powershell/dsc).
