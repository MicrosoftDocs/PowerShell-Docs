---
ms.date:  2017-06-12
author:  rpsqrd
ms.topic:  conceptual
keywords:  jea,powershell,security
title:  Registering JEA Configurations
---

# Registering JEA Configurations

> Applies to: Windows PowerShell 5.0

The last step before you can use JEA once you have your [role capabilities](role-capabilities.md) and [session configuration file](session-configurations.md) created is to register the JEA endpoint.
This process applies the session configuration information to the system and makes the endpoint available for use by users and automation engines.

## Single machine configuration

For small environments, you can deploy JEA by registering the session configuration file using the [Register-PSSessionConfiguration](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/register-pssessionconfiguration) cmdlet.

Before you begin, ensure that the following prerequisites have been met:
- One or more roles has been created and placed in the 'RoleCapabilities' folder of a valid PowerShell module.
- A session configuration file has been created and tested.
- The user registering the JEA configuration has administrator rights on the system(s).

You will also need to select a name for your JEA endpoint.
The name of the JEA endpoint will be required when users want to connect to the system using JEA.
You can use the [Get-PSSessionConfiguration](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/get-pssessionconfiguration) cmdlet to check the names of existing endpoints on the system.
Endpoints that start with 'microsoft' are typically shipped with Windows.
The 'microsoft.powershell' endpoint is the default endpoint used when connecting to a remote PowerShell endpoint.

```powershell
PS C:\> Get-PSSessionConfiguration | Select-Object Name

Name
----
microsoft.powershell
microsoft.powershell.workflow
microsoft.powershell32
```

When you have determined an appropriate name for your JEA endpoint, run the following command to register the endpoint.

```powershell
Register-PSSessionConfiguration -Path .\MyJEAConfig.pssc -Name 'JEAMaintenance' -Force
```

> [!WARNING]
> The above command will restart the WinRM service on the system.
> This will terminate all PowerShell remoting sessions as well as any ongoing DSC configurations.
> It is recommended that you take any production machines offline before running the command to avoid disrupting business operations.

If registration was successful, you are ready to [use JEA](using-jea.md).
You may delete the session configuration file at any time; it is not used after registration.

## Multi-machine configuration with DSC

If you are deploying JEA on multiple machines, the simplest deployment model is to use the JEA [Desired State Configuration](https://msdn.microsoft.com/en-us/powershell/dsc/overview) resource to quickly and consistently deploy JEA on each machine.

To deploy JEA with DSC, you will need to ensure the following prerequisites are met:
- One or more role capabilities have been authored and added to a valid PowerShell module.
- The PowerShell module containing the roles is stored on a (read-only) file share accessible by each machine.
- Settings for the session configuration have been determined. You do not need to create a session configuration file when using the JEA DSC resource.
- You have credentials that will allow you to perform administrative actions on each machine, or have access to a DSC pull server used to manage the machines.
- You have downloaded the [JEA DSC resource](https://github.com/PowerShell/JEA/tree/master/DSC%20Resource)

On a target machine (or pull server, if you are using one), create a DSC configuration for your JEA endpoint.
In this configuration, you will use the JustEnoughAdministration DSC resource to set up the session configuration file and the File resource to copy over the role capabilities from the file share.

The following properties are configurable using the DSC resource:
- Role Definitions
- Virtual Account groups
- Group Managed Service Account name
- Transcript directory
- User drive
- Conditional access rules
- Startup scripts for the JEA session

The syntax for each of these properties in a DSC configuration is consistent with the PowerShell session configuration file.

Below is a sample DSC configuration for a general server maintenance module.

It assumes that a valid PowerShell module containing role capabilities in a 'RoleCapabilities' subfolder is located on the '\\\\myfileshare\\JEA' file share.


```powershell
Configuration JEAMaintenance
{
    Import-DscResource -Module JustEnoughAdministration, PSDesiredStateConfiguration

    File MaintenanceModule
    {
        SourcePath = "\\myfileshare\JEA\ContosoMaintenance"
        DestinationPath = "C:\Program Files\WindowsPowerShell\Modules\ContosoMaintenance"
        Checksum = "SHA-256"
        Ensure = "Present"
        Type = "Directory"
        Recurse = $true
    }

    JeaEndpoint JEAMaintenanceEndpoint
    {
        EndpointName = "JEAMaintenance"
        RoleDefinitions = "@{ 'CONTOSO\JEAMaintenanceAuditors' = @{ RoleCapabilities = 'GeneralServerMaintenance-Audit' }; 'CONTOSO\JEAMaintenanceAdmins' = @{ RoleCapabilities = 'GeneralServerMaintenance-Audit', 'GeneralServerMaintenance-Admin' } }"
        TranscriptDirectory = 'C:\ProgramData\JEAConfiguration\Transcripts'
        DependsOn = '[File]MaintenanceModule'
    }
}
```

This configuration can then be applied on a system by [directly invoking the Local Configuration Manager](https://msdn.microsoft.com/en-us/powershell/dsc/metaconfig) or updating the [pull server configuration](https://msdn.microsoft.com/en-us/powershell/dsc/pullserver).

The DSC resource also allows you to replace the default Microsoft.PowerShell remoting endpoint.
If you do this, the resource will automatically register a backup unconstrainted endpoint named "Microsoft.PowerShell.Restricted" which has the default WinRM ACL (allowing Remote Management Users and local Administrators group members to access it).

## Unregistering JEA configurations

To remove a JEA endpoint on a system, use the [Unregister-PSSessionConfiguration](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/Unregister-PSSessionConfiguration) cmdlet.
Unregistering a JEA endpoint will prevent new users from creating new JEA sessions on the system.
It also allows you to update a JEA configuration by re-registering an updated session configuration file using the same endpoint name.

```powershell
# Unregister the JEA endpoint called "ContosoMaintenance"
Unregister-PSSessionConfiguration -Name 'ContosoMaintenance' -Force
```

> [!WARNING]
> Unregistering a JEA endpoint will cause the WinRM service to restart.
> This will interrupt most remote management operations in progress, including other PowerShell sessions, WMI invocations, and some management tools.
> Only unregister PowerShell endpoints during planned maintenance windows.

## Next steps

- [Test the JEA endpoint](using-jea.md)

