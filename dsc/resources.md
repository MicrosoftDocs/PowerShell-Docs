---
title:   DSC Resources
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# DSC Resources

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

Desired State Configuration (DSC) Resources provide the building blocks for a DSC configuration. A resource exposes properties that can be configured (schema) and contains the PowerShell script functions that the Local Configuration Manager (LCM) calls to "make it so".

A resource can model something as generic as a file or as specific as an IIS server setting.  Groups of like resources are combined in to a DSC Module, which organizes all the required files in to a structure that is portable and includes metadata to identify how the resources are intended to be used.  

The following topics describe DSC resources:

- [Built-In DSC resources](builtInResource.md)
- [Build custom DSC resources](authoringResource.md)
- [Built-In DSC resources for Linux](lnxBuiltInResources.md)

