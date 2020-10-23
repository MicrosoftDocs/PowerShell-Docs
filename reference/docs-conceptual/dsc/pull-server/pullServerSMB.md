---
ms.date:  04/11/2018
keywords:  dsc,powershell,configuration,setup
title:  Setting up a DSC SMB pull server
description: A DSC SMB pull server is a computer hosting SMB file shares that make DSC configuration files and DSC resources available to target nodes when those nodes ask for them.
---
# Setting up a DSC SMB pull server

Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

> [!IMPORTANT]
> The Pull Server (Windows Feature *DSC-Service*) is a supported component of Windows Server however
> there are no plans to offer new features or capabilities. It is recommended to begin transitioning
> managed clients to [Azure Automation DSC](/azure/automation/automation-dsc-getting-started)
> (includes features beyond Pull Server on Windows Server) or one of the community solutions listed
> [here](pullserver.md#community-solutions-for-pull-service).

A DSC [SMB](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831795(v=ws.11))
pull server is a computer hosting SMB file shares that make DSC configuration files and DSC
resources available to target nodes when those nodes ask for them.

To use an SMB pull server for DSC, you have to:

- Set up an SMB file share on a server running PowerShell 4.0 or higher
- Configure a client running PowerShell 4.0 or higher to pull from that SMB share

## Using the xSmbShare resource to create an SMB file share

There are a number of ways to set up an SMB file share, but let's look at how you can do this by
using DSC.

### Install the xSmbShare resource

Call the [Install-Module](/powershell/module/PowershellGet/Install-Module) cmdlet to install the
**xSmbShare** module.

> [!NOTE]
> `Install-Module` is included in the **PowerShellGet** module, which is included in PowerShell 5.0.
> The **xSmbShare** contains the DSC resource **xSmbShare**, which can be used to create an SMB file
> share.

### Create the directory and file share

The following configuration uses the **File** resource to create the directory for the share and the
**xSmbShare** resource to set up the SMB share:

```powershell
Configuration SmbShare
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xSmbShare

    Node localhost
    {

        File CreateFolder
        {
            DestinationPath = 'C:\DscSmbShare'
            Type = 'Directory'
            Ensure = 'Present'
        }

        xSMBShare CreateShare
        {
            Name = 'DscSmbShare'
            Path = 'C:\DscSmbShare'
            FullAccess = 'administrator'
            ReadAccess = 'myDomain\Contoso-Server$'
            FolderEnumerationMode = 'AccessBased'
            Ensure = 'Present'
            DependsOn = '[File]CreateFolder'
        }
    }
}
```

The configuration creates the directory `C:\DscSmbShare`, if it doesn't already exist, and then uses
that directory as an SMB file share. **FullAccess** should be given to any account that needs to
write to or delete from the file share. **ReadAccess** must be given to any client nodes that get
configurations and/or DSC resources from the share.

> [!NOTE]
> DSC runs as the system account by default, so the computer itself must have access to the share.

### Give file system access to the pull client

Giving **ReadAccess** to a client node allows that node to access the SMB share, but not to files or
folders within that share. You have to explicitly grant client nodes access to the SMB share folder
and subfolders. We can do this with DSC by adding using the **cNtfsPermissionEntry** resource, which
is contained in the
[CNtfsAccessControl](https://www.powershellgallery.com/packages/cNtfsAccessControl/1.2.0) module.
The following configuration adds a **cNtfsPermissionEntry** block that grants ReadAndExecute access
to the pull client:

```powershell
Configuration DSCSMB
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xSmbShare
    Import-DscResource -ModuleName cNtfsAccessControl

    Node localhost
    {

        File CreateFolder
        {
            DestinationPath = 'C:\DscSmbShare'
            Type = 'Directory'
            Ensure = 'Present'
        }

        xSMBShare CreateShare
        {
            Name = 'DscSmbShare'
            Path = 'C:\DscSmbShare'
            FullAccess = 'administrator'
            ReadAccess = 'myDomain\Contoso-Server$'
            FolderEnumerationMode = 'AccessBased'
            Ensure = 'Present'
            DependsOn = '[File]CreateFolder'
        }

        cNtfsPermissionEntry PermissionSet1
        {
            Ensure = 'Present'
            Path = 'C:\DscSmbShare'
            Principal = 'myDomain\Contoso-Server$'
            AccessControlInformation = @(
                cNtfsAccessControlInformation
                {
                    AccessControlType = 'Allow'
                    FileSystemRights = 'ReadAndExecute'
                    Inheritance = 'ThisFolderSubfoldersAndFiles'
                    NoPropagateInherit = $false
                }
            )
            DependsOn = '[File]CreateFolder'
        }
    }
}
```

## Placing configurations and resources

Save any configuration MOF files and/or DSC resources that you want client nodes to pull in the SMB
share folder.

Any configuration MOF file must be named *ConfigurationID*.mof, where *ConfigurationID* is the value
of the **ConfigurationID** property of the target node's LCM. For more information about setting up
pull clients, see [Setting up a pull client using configuration ID](pullClientConfigID.md).

> [!NOTE]
> You must use configuration IDs if you are using an SMB pull server. Configuration names are not
> supported for SMB.

Each resource module needs to be zipped and named according to the following pattern
`{Module Name}_{Module Version}.zip`. For example, a module named xWebAdminstration with a module
version of 3.1.2.0 would be named 'xWebAdministration_3.2.1.0.zip'. Each version of a module must be
contained in a single zip file. Separate versions of a module in a zip file are not supported.
Before packaging up DSC resource modules for use with pull server, you need to make a small change
to the directory structure.

The default format of modules containing DSC resource in WMF 5.0 is
`{Module Folder}\{Module Version}\DscResources\{DSC Resource Folder}\`.

Before packaging up for the pull server simply remove the `{Module version}` folder so the path
becomes `{Module Folder}\DscResources\{DSC Resource Folder}\`. With this change, zip the folder as
described above and place these zip files in the SMB share folder.

## Creating the MOF checksum

A configuration MOF file needs to be paired with a checksum file so that an LCM on a target node can
validate the configuration. To create a checksum, call the
[New-DSCCheckSum](/powershell/module/PSDesiredStateConfiguration/New-DSCCheckSum) cmdlet. The cmdlet
takes a `Path` parameter that specifies the folder where the configuration MOF is located. The
cmdlet creates a checksum file named `ConfigurationMOFName.mof.checksum`, where
`ConfigurationMOFName` is the name of the configuration mof file. If there are more than one
configuration MOF files in the specified folder, a checksum is created for each configuration in the
folder.

The checksum file must be present in the same directory as the configuration MOF file
(`$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration` by default), and have the same name
with the `.checksum` extension appended.

> [!NOTE]
> If you change the configuration MOF file in any way, you must also recreate the checksum file.

## Setting up a pull client for SMB

To set up a client that pulls configurations and/or resources from an SMB share, you configure the
client's Local Configuration Manager (LCM) with **ConfigurationRepositoryShare** and
**ResourceRepositoryShare** blocks that specify the share from which to pull configurations and DSC
resources.

For more information about configuring the LCM, see
[Setting up a pull client using configuration ID](pullClientConfigID.md).

> [!NOTE]
> For simplicity, this example uses the **PSDscAllowPlainTextPassword** to allow passing a plaintext
> password to the **Credential** parameter. For information about passing credentials more securely,
> see [Credentials Options in Configuration Data](../configurations/configDataCredentials.md). You
> **MUST** specify a **ConfigurationID** in the **Settings** block of a metaconfiguration for an SMB
> pull server, even if you are only pulling resources.

```powershell
$secpasswd = ConvertTo-SecureString "Pass1Word" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("TestUser", $secpasswd)

[DSCLocalConfigurationManager()]
configuration SmbCredTest
{
    Node $AllNodes.NodeName
    {
        Settings
        {
            RefreshMode = 'Pull'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
            ConfigurationID    = '16db7357-9083-4806-a80c-ebbaf4acd6c1'
        }

         ConfigurationRepositoryShare SmbConfigShare
        {
            SourcePath = '\\WIN-E0TRU6U11B1\DscSmbShare'
            Credential = $mycreds
        }

        ResourceRepositoryShare SmbResourceShare
        {
            SourcePath = '\\WIN-E0TRU6U11B1\DscSmbShare'
            Credential = $mycreds

        }
    }
}

$ConfigurationData = @{
    AllNodes = @(
        @{
            #the "*" means "all nodes named in ConfigData" so we don't have to repeat ourselves
            NodeName="localhost"
            PSDscAllowPlainTextPassword = $true
        })
}
```

## Acknowledgements

Special thanks to the following individuals:

- Mike F. Robbins, whose posts on using SMB for DSC helped inform the content in this topic. His
  blog is at [Mike F Robbins](http://mikefrobbins.com/).
- Serge Nikalaichyk, who authored the **cNtfsAccessControl** module. The source for this module is
  at [cNtfsAccessControl](https://github.com/SNikalaichyk/cNtfsAccessControl).

## See also

[Windows PowerShell Desired State Configuration Overview](../overview/overview.md)

[Enacting configurations](enactingConfigurations.md)

[Setting up a pull client using configuration ID](pullClientConfigID.md)
