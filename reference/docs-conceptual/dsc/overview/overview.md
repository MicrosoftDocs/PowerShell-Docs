---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Windows PowerShell Desired State Configuration Overview
description: DSC is a management platform in PowerShell that enables you to manage your IT and development infrastructure with configuration as code.
---

# Windows PowerShell Desired State Configuration Overview

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

DSC is a management platform in PowerShell that enables you to manage your IT and development
infrastructure with configuration as code.

- For an overview of the business benefits of using DSC, see
  [Desired State Configuration Overview for Decision Makers](decisionMaker.md).
- For an overview of the engineering benefits of using DSC, see
  [Desired State Configuration Overview for Engineers](DscForEngineers.md).
- To start using DSC quickly, see [DSC quick start](../quickstarts/website-quickstart.md).

## Key Concepts

DSC is a declarative platform used for configuration, deployment, and management of systems. It
consists of three primary components:

- [Configurations](../configurations/configurations.md) are declarative PowerShell scripts which
  define and configure instances of resources. Upon running the configuration, DSC (and the
  resources being called by the configuration) will simply "make it so", ensuring that the system
  exists in the state laid out by the configuration. DSC configurations are also idempotent: the
  Local Configuration Manager (LCM) will continue to ensure that machines are configured in whatever
  state the configuration declares.
- [Resources](../resources/resources.md) are the "make it so" part of DSC. They contain the code
  that put and keep the target of a configuration in the specified state. Resources reside in
  PowerShell modules and can be written to model something as generic as a file or a Windows
  process, or as specific as an IIS server or a VM running in Azure.
- The [Local Configuration Manager (LCM)](../managing-nodes/metaConfig.md) is the engine by which
  DSC facilitates the interaction between resources and configurations. The LCM regularly polls the
  system using the control flow implemented by resources to ensure that the state defined by a
  configuration is maintained. If the system is out of state, the LCM makes calls to the code in
  resources to "make it so" according to the configuration.

## See Also

- [DSC Configurations](../configurations/configurations.md)
- [DSC Resources](../resources/resources.md)
- [Configuring The Local Configuration Manager](../managing-nodes/metaConfig.md)
