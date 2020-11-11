---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Use Credentials with DSC Resources
description: DSC allows you to provide credentials to a configuration so that configuration settings can be applied the in the context of a specific user account rather than the Local System account.
---
# Use Credentials with DSC Resources

> Applies To: Windows PowerShell 5.0, Windows PowerShell 5.1

You can run a DSC resource under a specified set of credentials by using the automatic
**PsDscRunAsCredential** property in the configuration. By default, DSC runs each resource as the
system account. There are times when running as a user is necessary, such as installing MSI packages
in a specific user context, setting a user's registry keys, accessing a user's specific local
directory, or accessing a network share. The **SeInteractiveLogonRight** is required, by the target
machine, for any account you specify to **PSDSCRunAsCredential**. For more information, see
[Account Rights Constants](/windows/desktop/secauthz/account-rights-constants).

Every DSC resource has a **PsDscRunAsCredential** property that can be set to any user credentials
(a [PSCredential](/dotnet/api/system.management.automation.pscredential) object). The credential can
be hard-coded as the value of the property in the configuration, or you can set the value to
[Get-Credential](/powershell/module/Microsoft.PowerShell.Security/Get-Credential), which will prompt
the user for a credential when the configuration is compiled (for information about compiling
configurations, see [Configurations](configurations.md).

> [!NOTE]
> In PowerShell 5.0, using the **PsDscRunAsCredential** property in configurations calling
> composite resources was not supported. In PowerShell 5.1, the **PsDscRunAsCredential** property is
> supported in configurations calling composite resources. The **PsDscRunAsCredential** property is
> not available in PowerShell 4.0.

In the following example, `Get-Credential` is used to prompt the user for credentials. The
**Registry** resource is used to change the registry key that specifies the background color for the
Windows command prompt window.

```powershell
Configuration ChangeCmdBackGroundColor
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.NodeName
    {
        Registry CmdPath
        {
            Key                  = 'HKEY_CURRENT_USER\SOFTWARE\Microsoft\Command Processor'
            ValueName            = 'DefaultColor'
            ValueData            = '1F'
            ValueType            = 'DWORD'
            Ensure               = 'Present'
            Force                = $true
            Hex                  = $true
            PsDscRunAsCredential = Get-Credential
        }
    }
}

$configData = @{
    AllNodes = @(
        @{
            NodeName             = 'localhost';
            PSDscAllowDomainUser = $true
            CertificateFile      = 'C:\publicKeys\targetNode.cer'
            Thumbprint           = '7ee7f09d-4be0-41aa-a47f-96b9e3bdec25'
        }
    )
}

ChangeCmdBackGroundColor -ConfigurationData $configData
```

> [!NOTE]
> This example assumes that you have a valid certificate at `C:\publicKeys\targetNode.cer`, and that
> the thumbprint of that certificate is the value shown. For information about encrypting
> credentials in DSC configuration MOF files, see
> [Securing the MOF file](../pull-server/secureMOF.md).
