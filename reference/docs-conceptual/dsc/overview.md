---
description: DSC is a management platform that enables you to manage your IT and development infrastructure with configuration as code.
ms.date: 03/18/2025
title: Desired State Configuration (DSC)
---

# Desired State Configuration (DSC) Overview

DSC is a management platform that enables you to manage your IT and development infrastructure with
configuration as code.

There are four versions of DSC available:

- **Microsoft DSC 3.0** is the new version of DSC. This version provides true cross-platform
  support. It is a standalone product that's not dependent on PowerShell, however, you can still use
  your existing PowerShell DSC resources.

- **PowerShell DSC 3.0 (preview)** is the version of DSC supported by the
  [Azure Machine Configuration][01] on Linux.

- **PowerShell DSC 2.0** is the version of DSC that shipped in PowerShell 7.

  With the release of PowerShell 7.2, the **PSDesiredStateConfiguration** module is no longer
  included in the PowerShell package. Separating DSC into its own module allows us to invest and
  develop DSC independent of PowerShell and reduces the size of the PowerShell package. Users of DSC
  will enjoy the benefit of upgrading DSC without the need to upgrade PowerShell, accelerating the time
  to deployment of new DSC features. Users that want to continue using DSC v2 can download
  **PSDesiredStateConfiguration** 2.0.5 from the PowerShell Gallery.

- **PowerShell DSC 1.1** is the legacy version of DSC that originally shipped in Windows PowerShell
  5.1.

For more information, see the [Desired State Configuration][02] overview article.

[01]: /azure/governance/machine-configuration/overview
[02]: /powershell/dsc/overview
