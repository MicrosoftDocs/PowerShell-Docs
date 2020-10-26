---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Publish to a Pull Server using Configuration IDs (v4/v5)
description: This article shows you how to upload resources so they're available to be downloaded, and configure clients to automatically download resources.
---

# Publish to a Pull Server using Configuration IDs (v4/v5)

The sections below assume that you have already set up a Pull Server. If you haven't set up your
Pull Server, you can use the following guides:

- [Set up a DSC SMB Pull Server](pullServerSmb.md)
- [Set up a DSC HTTP Pull Server](pullServer.md)

Each target node can be configured to download configurations, resources, and even report its
status. This article shows you how to upload resources so they're available to be downloaded, and
configure clients to automatically download resources. When the node receives an assigned
Configuration, through **Pull** or **Push** (v5), it automatically downloads any resources required
by the Configuration from the location specified in the Local Configuration Manager (LCM).

## Compile configurations

The first step to storing [Configurations](../configurations/configurations.md) on a Pull Server, is
to compile them into `.mof` files. To make a configuration generic, and applicable to more clients,
use `localhost` in your Node block. The example below shows a Configuration shell that uses
`localhost` instead of a specific client name.

```powershell
Configuration GenericConfig
{
    Node localhost
    {

    }
}
GenericConfig
```

Once you've compiled your generic configuration, you should have a `localhost.mof` file.

## Renaming the MOF file

You can store Configuration `.mof` files on a Pull Server by **ConfigurationName** or
**ConfigurationID**. Depending on how you plan to set up your pull clients, you can choose a section
below to properly rename your compiled `.mof` files.

### Configuration IDs (GUID)

You'll need to rename your `localhost.mof` file to `<GUID>.mof` file. You can create a random
**Guid** using the example below, or by using the [New-Guid](/powershell/module/microsoft.powershell.utility/new-guid)
cmdlet.

```powershell
[System.Guid]::NewGuid()
```

Sample Output

```Output
Guid
----
64856475-939e-41fb-aba5-4469f4006059
```

You can then rename your `.mof` file using any acceptable method. The example below, uses the [Rename-Item](/powershell/module/microsoft.powershell.management/rename-item)
cmdlet.

```powershell
Rename-Item -Path .\localhost.mof -NewName '64856475-939e-41fb-aba5-4469f4006059.mof'
```

For more information about using **Guids** in your environment, see [Plan for Guids](secureServer.md#guids).

### Configuration names

You'll need to rename your `localhost.mof` file to `<Configuration Name>.mof` file. In the following
example, the configuration name from the previous section is used. You can then rename your `.mof`
file using any acceptable method. The example below, uses the [Rename-Item](/powershell/module/microsoft.powershell.management/rename-item)
cmdlet.

```powershell
Rename-Item -Path .\localhost.mof -NewName 'GenericConfig.mof'
```

## Create the checkSum

Each `.mof` file stored on a Pull Server, or SMB share needs to have an associated `.checksum` file.
This file lets clients know when the associated `.mof` file has changed and should be downloaded
again.

You can create a **CheckSum** with the [New-DSCCheckSum](/powershell/module/psdesiredstateconfiguration/new-dscchecksum)
cmdlet. You can also run `New-DSCCheckSum` against a directory of files using the `-Path` parameter.
If a checksum already exists, you can force it to be re-created with the `-Force` parameter. The
following example specified a directory containing the `.mof` file from the previous section, and
uses the `-Force` parameter.

```powershell
New-DscChecksum -Path '.\' -Force
```

No output will be shown, but you should now see a `<GUID or Configuration Name>.mof.checksum` file.

## Where to store MOF files and checkSums

### On a DSC HTTP Pull Server

When you set up your HTTP Pull Server, as explained in [Set up a DSC HTTP Pull Server](pullServer.md),
you specify directories for the **ModulePath** and **ConfigurationPath** keys. The **ModulePath**
key indicates where a module's packaged `.zip` files should be stored. The **ConfigurationPath**
indicates where any `.mof` files and `.checksum` files should be stored.

```powershell
    xDscWebService PSDSCPullServer
    {
    ...
        ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
        ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
    ...
    }

```

### On an SMB share

When you set up a Pull Client to use an SMB share, you specify a **ConfigurationRepositoryShare**.
All `.mof` files and `.checksum` files should be stored in the **SourcePath** directory from the
**ConfigurationRepositoryShare** block.

```powershell
ConfigurationRepositoryShare SMBPullServer
{
    SourcePath = '\\SMBPullServer\Pull'
}
```

## Next steps

Next, you'll want to configure Pull Clients to pull the specified configuration. For more
information, see one of the following guides:

- [Set up a Pull Client using Configuration IDs (v4)](pullClientConfigId4.md)
- [Set up a Pull Client using Configuration IDs (v5)](pullClientConfigId.md)
- [Set up a Pull Client using Configuration Names (v5)](pullClientConfigNames.md)

## See also

- [Set up a DSC SMB Pull Server](pullServerSmb.md)
- [Set up a DSC HTTP Pull Server](pullServer.md)
- [Package and Upload Resources to a Pull Server](package-upload-resources.md)
