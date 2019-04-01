 - -
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Built-In Windows PowerShell Desired State Configuration Resources
 - -
# Built-In PowerShell Desired State Configuration Resources

> Applies To: PowerShell 4.0, PowerShell 5.0

Resources are building blocks that you can use to write a PowerShell Desired State Configuration
(DSC) script. If you need to create additional resources, see
[Build Custom Windows PowerShell Desired State Configuration Resources](../../../resources/authoringResource.md)

## Built-In Windows PowerShell Desired State Configuration Resources

DSC for Windows includes the following list of  resources.

- [Archive Resource](archiveResource.md) - Provides a mechanism to unpack archive (.tar, .zip) files at a specific path
- [Environment Resource](environmentResource.md) - Manages environment variables on target nodes.
- [File Resource](fileResource.md) - Manages Windows files and directories
- [Group Resource](groupResource.md) - Manages local Windows groups
- [Log Resource](logResource.md) - Manages packages on Linux nodes
- [Package Resource](packageResource.md) - Manages packages on Windows nodes
- [Registry Resource](registryResource.md)
- [Script Resource](scriptResource.md)
- [Service Resource](serviceResource.md)
- [User Resource](userResource.md)
- [WindowsFeature Resource](windowsfeatureResource.md)
- [WindowsProcess Resource](windowsProcessResource.md)

## Built-In Desired State Configuration Resources for Linux

DSC for Linux comes with a set of built-in functionality for configuring resources such as files and
folders, packages, environment variables, and services and processes.

- [nxArchive Resource](lnxArchiveResource.md) - Provides a mechanism to unpack archive (.tar, .zip) files at a specific path
- [nxEnvironment Resource](lnxEnvironmentResource.md) - Manages environment variables on target nodes
- [nxFile Resource](lnxFileResource.md) - Manages Linux files and directories
- [nxFileLine Resource](lnxFileLineResource.md) - Manages individual lines in a Linux file
- [nxGroup Resource](lnxGroupResource.md) - Manages local Linux groups
- [nxPackage Resource](lnxPackageResource.md) - Manages packages on Linux nodes
- [nxScript Resource](lnxScriptResource.md) - Runs scripts on target nodes
- [nxService Resource](lnxServiceResource.md) - Manages Linux services (daemons)
- [nxSshAuthorizedKeys Resource](lnxSshAuthorizedKeysResource.md) - Manages public ssh keys for a Linux user
- [nxUser Resource](lnxUserResource.md) - Manages local Linux users

## Built-In Desired State Configuration Resources for PackageManagement

- [DSC PackageManagement Resource]
- [DSC PackageManagementSource Resource]