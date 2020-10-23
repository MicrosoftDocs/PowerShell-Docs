---
ms.date:  07/10/2019
keywords:  jea,powershell,security
title:  Registering JEA Configurations
description: Registering the JEA endpoint with the system makes the endpoint available for use by users and automation engines.
---
# Registering JEA Configurations

Once you have your [role capabilities](role-capabilities.md) and
[session configuration file](session-configurations.md) created, the last step is to register the
JEA endpoint. Registering the JEA endpoint with the system makes the endpoint available for use by
users and automation engines.

## Single machine configuration

For small environments, you can deploy JEA by registering the session configuration file using the
[Register-PSSessionConfiguration](/powershell/module/microsoft.powershell.core/register-pssessionconfiguration)
cmdlet.

Before you begin, ensure that the following prerequisites have been met:

- One or more roles has been created and placed in the **RoleCapabilities** folder of a PowerShell
  module.
- A session configuration file has been created and tested.
- The user registering the JEA configuration has administrator rights on the system.
- You've selected a name for your JEA endpoint.

The name of the JEA endpoint is required when users connect to the system using JEA. The
[Get-PSSessionConfiguration](/powershell/module/microsoft.powershell.core/get-pssessionconfiguration)
cmdlet lists the names of the endpoints on a system. Endpoints that start with `microsoft` are
typically shipped with Windows. The `microsoft.powershell` endpoint is the default endpoint used
when connecting to a remote PowerShell endpoint.

```powershell
Get-PSSessionConfiguration | Select-Object Name
```

```Output
Name
----
microsoft.powershell
microsoft.powershell.workflow
microsoft.powershell32
```

Run the following command to register the endpoint.

```powershell
Register-PSSessionConfiguration -Path .\MyJEAConfig.pssc -Name 'JEAMaintenance' -Force
```

> [!WARNING]
> The previous command restarts the WinRM service on the system. This terminates all PowerShell
> remoting sessions and any ongoing DSC configurations. We recommended you take production machines
> offline before running the command to avoid disrupting business operations.

After registration, you're ready to [use JEA](using-jea.md). You may delete the session
configuration file at any time. The configuration file isn't used after registration of the
endpoint.

## Multi-machine configuration with DSC

When deploying JEA on multiple machines, the simplest deployment model uses the JEA
[Desired State Configuration (DSC)](../../../dsc/overview/overview.md) resource to quickly and
consistently deploy JEA on each machine.

To deploy JEA with DSC, ensure the following prerequisites are met:

- One or more role capabilities have been authored and added to a PowerShell module.
- The PowerShell module containing the roles is stored on a (read-only) file share accessible by
  each machine.
- Settings for the session configuration have been determined. You don't need to create a session
  configuration file when using the JEA DSC resource.
- You have credentials that allow administrative actions on each machine or access to the DSC pull
  server used to manage the machines.
- You've downloaded the
  [JEA DSC resource](https://github.com/powershell/JEA/tree/master/DSC%20Resource).

Create a DSC configuration for your JEA endpoint on a target machine or pull server. In this
configuration, the **JustEnoughAdministration** DSC resource defines the session configuration file
and the **File** resource copies the role capabilities from the file share.

The following properties are configurable using the DSC resource:

- Role Definitions
- Virtual account groups
- Group-managed service account name
- Transcript directory
- User drive
- Conditional access rules
- Startup scripts for the JEA session

The syntax for each of these properties in a DSC configuration is consistent with the PowerShell
session configuration file.

Below is a sample DSC configuration for a general server maintenance module. It assumes that a valid
PowerShell module containing role capabilities is located on the `\\myfileshare\JEA` file share.

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

Next, the configuration is applied on a system by directly invoking the
[Local Configuration Manager](/powershell/scripting/dsc/managing-nodes/metaConfig) or updating the
[pull server configuration](/powershell/scripting/dsc/pull-server/pullServer).

The DSC resource also allows you to replace the default **Microsoft.PowerShell** endpoint. When
replaced, the resource automatically registers a backup endpoint named
**Microsoft.PowerShell.Restricted**. The backup endpoint has the default WinRM ACL that allows
Remote Management Users and local Administrators group members to access it.

## Unregistering JEA configurations

The [Unregister-PSSessionConfiguration](/powershell/module/microsoft.powershell.core/Unregister-PSSessionConfiguration)
cmdlet removes a JEA endpoint. Unregistering a JEA endpoint prevents new users from creating new JEA
sessions on the system. It also allows you to update a JEA configuration by re-registering an
updated session configuration file using the same endpoint name.

```powershell
# Unregister the JEA endpoint called "ContosoMaintenance"
Unregister-PSSessionConfiguration -Name 'ContosoMaintenance' -Force
```

> [!WARNING]
> Unregistering a JEA endpoint causes the WinRM service to restart. This interrupts most remote
> management operations in progress, including other PowerShell sessions, WMI invocations, and some
> management tools. Only unregister PowerShell endpoints during planned maintenance windows.

## Next steps

[Test the JEA endpoint](using-jea.md)
