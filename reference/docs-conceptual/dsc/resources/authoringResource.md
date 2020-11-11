---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
title:  Build Custom Windows PowerShell Desired State Configuration Resources
description:  This article provides an overview of developing resources and links to articles with specific information and examples.
---

# Build Custom Windows PowerShell Desired State Configuration Resources

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

Windows PowerShell Desired State Configuration (DSC) has built-in resources that you can use to
configure your environment. This article provides an overview of developing resources and links to
articles with specific information and examples.

## DSC resource components

A DSC resource is a Windows PowerShell module. The module contains both the schema (the definition
of the configurable properties) and the implementation (the code that does the actual work specified
by a configuration) for the resource. A DSC resource schema can be defined in a MOF file, and the
implementation is performed by a script module. Beginning with the support of PowerShell classes in
version 5, the schema and implementation can both be defined in a class. The following articles
describe in more detail how to create DSC resources.

- [Writing a custom DSC resource with MOF](authoringResourceMOF.md)
- [Implementing a DSC resource in C#](authoringResourceMofCS.md)
- [Writing a custom DSC resource with PowerShell classes](authoringResourceClass.md)
- [Composite resources: Using a DSC configuration as a resource](authoringResourceComposite.md)
- [Using the Resource Designer tool](authoringResourceMofDesigner.md)
