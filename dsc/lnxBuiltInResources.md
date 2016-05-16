---
title:   Built-In Desired State Configuration Resources for Linux
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Built-In Desired State Configuration Resources for Linux

Resources are building blocks that you can use to write a PowerShell Desired State Configuration (DSC) script. DSC for Linux comes with a set of built-in functionality for configuring resources such as files and folders, packages, environment variables, and services and processes.

## Built-in resources 

The following table provides a list of these resources and links to topics that describe them in detail.

* [nxArchive Resource](lnxArchiveResource.md)--Provides a mechanism to unpack archive (.tar, .zip) files at a specific path.
* [nxEnvironment Resource](lnxEnvironmentResource.md)--Manages environment variables on target nodes. 
* [nxFile Resource](lnxFileResource.md)--Manages Linux files and directories. 
* [nxFileLine Resource](lnxFileLineResource.md)--Manages individual lines in a Linux file. 
* [nxGroup Resource](lnxGroupResource.md)--Manages local Linux groups. 
* [nxPackage Resource](lnxPackageResource.md)--Manages packages on Linux nodes.
* [nxScript Resource](lnxScriptResource.md)--Runs scripts on target nodes.
* [nxService Resource](lnxServiceResource.md)--Manages Linux services (daemons).
* [nxSshAuthorizedKeys Resource](lnxSshAuthorizedKeysResource.md)--Manages public ssh keys for a Linux user. 
* [nxUser Resource](lnxUserResource.md)--Manages local Linux users. 
  
