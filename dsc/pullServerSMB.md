---
title:   Setting up a DSC SMB pull server
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Setting up a DSC SMB pull server

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

A DSC [SMB](https://technet.microsoft.com/en-us/library/hh831795.aspx) pull server is an SMB file share that makes DSC configuration files and/or DSC resources
available to target nodes when those nodes ask for them.

To use an SMB pull server for DSC, you have to:
- Set up an SMB file share on a server running PowerShell 4.0 or higher
- Configure a client running PowerShell 4.0 or higher to pull from that SMB share

## Using the xSmbShare resource to create an SMB file share

There are a number of ways to set up an SMB file share, but let's look at how you can do this by using DSC.

### Install the xSmbShare resource

Call the [Install-Module](https://technet.microsoft.com/en-us/library/dn807162.aspx) cmdlet to install the **xSmbShare** module.
>**Note**: **Install-Module** is included in the **PowerShellGet** module, which is included in PowerShell 5.0. You can download the **PowerShellGet** module for PowerShell 3.0 and 4.0
>at [PackageManagement PowerShell Modules Preview](https://www.microsoft.com/en-us/download/details.aspx?id=49186). The **xSmbShare** contains the DSC resource **xSmbShare**, which can be used
to create an SMB file share.

### Create the directory and file share

The following configuration uses the [File](fileResource.md) resource to create the directory for the share, and the **xSmbShare** resource to set up the SMB share:

```powershell
Configuration SmbShare {

Import-DscResource -ModuleName PSDesiredStateConfiguration
Import-DscResource -ModuleName xSmbShare
 
    Node localhost {
 
        File CreateFolder {
 
            DestinationPath = 'C:\DscSmbShare'
            Type = 'Directory'
            Ensure = 'Present'
 
        }
 
        xSMBShare CreateShare {
 
            Name = 'DscSmbShare'
            Path = 'C:\DscSmbShare'
            FullAccess = 'admininstrator'
            ReadAccess = 'myDomain\Contoso-Server$'
            FolderEnumerationMode = 'AccessBased'
            Ensure = 'Present'
            DependsOn = '[File]CreateFolder'
 
        }
        
    }
 
}
```

The configuration creates the directory `C:\DscSmbShare` if it doesn't already exists, and then uses that directory as an SMB file share. **FullAccess** should be given to any
account that needs to write to or delete from the file share, and **ReadAccess** must be given to any client nodes that will get configurations and/or DSC resources from the share (
this is because DSC runs as the system account by default, so the computer itself has to have access to the share).


### Give file system access to the pull client

Giving **ReadAccess** to a client node allows that node to access the SMB share, but not to files or folders within that share. You have to explicitly grant client nodes access to the SMB share
folder and sub-folders. We can do this with DSC by adding using the **cNtfsPermissionEntry** resource, which is contained in the [CNtfsAccessControl](https://www.powershellgallery.com/packages/cNtfsAccessControl/1.2.0)
module. The following configuration adds a **cNtfsPermissionEntry** block that grants ReadAndExecute access to the pull client:

```powershell
Configuration DSCSMB {

Import-DscResource -ModuleName PSDesiredStateConfiguration
Import-DscResource -ModuleName xSmbShare
Import-DscResource -ModuleName cNtfsAccessControl
 
    Node localhost {
 
        File CreateFolder {
 
            DestinationPath = 'DscSmbShare'
            Type = 'Directory'
            Ensure = 'Present'
 
        }
 
        xSMBShare CreateShare {
 
            Name = 'DscSmbShare'
            Path = 'DscSmbShare'
            FullAccess = 'administrator'
            ReadAccess = 'myDomain\Contoso-Server$'
            FolderEnumerationMode = 'AccessBased'
            Ensure = 'Present'
            DependsOn = '[File]CreateFolder'
 
        }

        cNtfsPermissionEntry PermissionSet1 {
            
        Ensure = 'Present'
        Path = 'C:\DSCSMB'
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

Save any configuration MOF files and/or DSC resources that you want client nodes to pull in the SMB share folder.

Any configuration MOF file must be named _ConfigurationID_.mof, where _ConfigurationID_ is the value of the **ConfigurationID** property of the target node's LCM. For more information about
setting up pull clients, see [Setting up a pull client using configuration ID](pullClientConfigID.md).

>**Note:** You must use configuration IDs if you are using an SMB pull server. Configuration names are not supported for SMB.

Any resources needed by the client must be placed in the SMB share folder as archived `.zip` files.  

## Creating the MOF checksum
A configuration MOF file needs to be paired with a checksum file so that an LCM on a target node can validate the configuration. 
To create a checksum, call the [New-DSCCheckSum](https://technet.microsoft.com/en-us/library/dn521622.aspx) cmdlet. The cmdlet takes a **Path** parameter that specifies the folder 
where the configuration MOF is located. The cmdlet creates a checksum file named `ConfigurationMOFName.mof.checksum`, where `ConfigurationMOFName` is the name of the configuration mof file. 
If there are more than one configuration MOF files in the specified folder, a checksum is created for each configuration in the folder.

The checksum file must be present in the same directory as the configuration MOF file (`$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration` by default), and have the same name with the `.checksum` extension appended.

>**Note**: If you change the configuration MOF file in any way, you must also recreate the checksum file.

## Acknowledgements

Special thanks to the following:

- Mike F. Robbins, whose posts on using SMB for DSC helped inform the content in this topic. His blog is at [Mike F Robbins](http://mikefrobbins.com/).
- Serge Nikalaichyk, who authored the **cNtfsAccessControl** module. The source for this module is at https://github.com/SNikalaichyk/cNtfsAccessControl.

## See also
- [Windows PowerShell Desired State Configuration Overview](overview.md)
- [Enacting configurations](enactingConfigurations.md)
- [Setting up a pull client using configuration ID](pullClientConfigID.md)

 
