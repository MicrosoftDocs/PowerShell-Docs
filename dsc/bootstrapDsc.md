---
title:   Configure new virtual machines by using DSC
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Configure new virtual machines by using DSC

By using DSC, you can automate software installation and configuration for a computer at initial boot-up. You do this by injecting DSC configurations into 
bootable media (such as a VHD) so that they are run during the initial boot-up process. This topic explains three different ways how to do that:

- [Inject a DSC configuration into a VHD](#Inject a DSC configuration into a VHD)
- [Inject a configuration MOF document into a VHD](#Inject a configuration MOF document into a VHD)
- [Inject a DSC metaconfiguration into a VHD](#Inject a DSC metaconfiguration into a VHD)

>**Note:** For all of these examples, you will need a bootable VHD to work with. You can download a VHD with an evaluation copy of Windows Server 2012 R2 at
>[TechNet Evaluation Center](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2012-r2).

# Inject a DSC configuration into a VHD

In this example, we'll inject a DSC configuration (.ps1 file) into a 

