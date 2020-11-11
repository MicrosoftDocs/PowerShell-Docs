---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
title:  Get-Test-Set
description: This article illustrates how to implement the Get, Test, and Set methods in a DSC Configuration.
---

# Get-Test-Set

>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

PowerShell Desired State Configuration is constructed around a **Get**, **Test**, and **Set**
process. DSC [resources](resources.md) each contains methods to complete each of these operations.
In a [Configuration](../configurations/configurations.md), you define resource blocks to fill in
keys that become parameters for a resource's **Get**, **Test**, and **Set** methods.

This is the syntax for a **Service** resource block. The **Service** resource configures Windows
services.

```syntax
Service [String] #ResourceName
{
    Name = [string]
    [BuiltInAccount = [string]{ LocalService | LocalSystem | NetworkService }]
    [Credential = [PSCredential]]
    [Dependencies = [string[]]]
    [DependsOn = [string[]]]
    [Description = [string]]
    [DisplayName = [string]]
    [Ensure = [string]{ Absent | Present }]
    [Path = [string]]
    [PsDscRunAsCredential = [PSCredential]]
    [StartupType = [string]{ Automatic | Disabled | Manual }]
    [State = [string]{ Running | Stopped }]
}
```

The **Get**, **Test**, and **Set** methods of the **Service** resource will have parameter blocks
that accept these values.

```powershell
param
(
    [parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $Name,

    [System.String]
    [ValidateSet("Automatic", "Manual", "Disabled")]
    $StartupType,

    [System.String]
    [ValidateSet("LocalSystem", "LocalService", "NetworkService")]
    $BuiltInAccount,

    [System.Management.Automation.PSCredential]
    [ValidateNotNull()]
    $Credential,

    [System.String]
    [ValidateSet("Running", "Stopped")]
    $State="Running",

    [System.String]
    [ValidateNotNullOrEmpty()]
    $DisplayName,

    [System.String]
    [ValidateNotNullOrEmpty()]
    $Description,

    [System.String]
    [ValidateNotNullOrEmpty()]
    $Path,

    [System.String[]]
    [ValidateNotNullOrEmpty()]
    $Dependencies,

    [System.String]
    [ValidateSet("Present", "Absent")]
    $Ensure="Present"
)
```

> [!NOTE]
> The language and method used to define the resource determines how the **Get**, **Test**, and
> **Set** methods will be defined.

Because the **Service** resource only has one required key (`Name`), a **Service** block resource
could be as simple as this:

```powershell
Configuration TestConfig
{
    Import-DSCResource -Name Service
    Node localhost
    {
        Service "MyService"
        {
            Name = "Spooler"
        }
    }
}
```

When you compile the Configuration above, the values you specify for a key are stored in the `.mof`
file that is generated. For more information, see [MOF](/windows/desktop/wmisdk/managed-object-format--mof-).

```
instance of MSFT_ServiceResource as $MSFT_ServiceResource1ref
{
SourceInfo = "::5::1::Service";
 ModuleName = "PsDesiredStateConfiguration";
 ResourceID = "[Service]MyService";
 Name = "Spooler";

ModuleVersion = "1.0";

 ConfigurationName = "Test";

};
```

When applied, the [Local Configuration Manager](../managing-nodes/metaConfig.md) (LCM) will read the
value "Spooler" from the `.mof` file, and pass it to the **Name** parameter of the **Get**,
**Test**, and **Set** methods for the "MyService" instance of the **Service** resource.

## Get

The **Get** method of a resource, retrieves the state of the resource as it is configured on the
target Node. This state is returned as a
[hashtable](/powershell/module/microsoft.powershell.core/about/about_hash_tables). The keys of the
**hashtable** will be the configurable values, or parameters, the resource accepts.

The **Get** method maps directly to the
[Get-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/get-dscconfiguration) cmdlet.
When you call `Get-DSCConfiguration`, the LCM runs the **Get** method of each resource in the
currently applied configuration. The LCM uses the key values stored in the `.mof` file as parameters
to each corresponding resource instance.

This is sample output from a **Service** resource that configures the "Spooler" service.

```output
ConfigurationName    : Test
DependsOn            :
ModuleName           : PsDesiredStateConfiguration
ModuleVersion        : 1.1
PsDscRunAsCredential :
ResourceId           : [Service]Spooler
SourceInfo           :
BuiltInAccount       : LocalSystem
Credential           :
Dependencies         : {RPCSS, http}
Description          : This service spools print jobs and handles interaction with the printer.  If you turn off
                       this service, you won't be able to print or see your printers.
DisplayName          : Print Spooler
Ensure               :
Name                 : Spooler
Path                 : C:\WINDOWS\System32\spoolsv.exe
StartupType          : Automatic
State                : Running
Status               :
PSComputerName       :
CimClassName         : MSFT_ServiceResource
```

The output shows the current value properties configurable by the **Service** resource.

```syntax
Service [String] #ResourceName
{
    Name = [string]
    [BuiltInAccount = [string]{ LocalService | LocalSystem | NetworkService }]
    [Credential = [PSCredential]]
    [Dependencies = [string[]]]
    [DependsOn = [string[]]]
    [Description = [string]]
    [DisplayName = [string]]
    [Ensure = [string]{ Absent | Present }]
    [Path = [string]]
    [PsDscRunAsCredential = [PSCredential]]
    [StartupType = [string]{ Automatic | Disabled | Manual }]
    [State = [string]{ Running | Stopped }]
}
```

## Test

The **Test** method of a resource determines if the target node is currently compliant with the
resource's _desired state_. The **Test** method returns `$true` or `$false` only to indicate whether
the Node is compliant. When you call
[Test-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/Test-DSCConfiguration), the
LCM calls the **Test** method of each resource in the currently applied configuration. The LCM uses
the key values stored in the ".mof" file as parameters to each corresponding resource instance.

If the result of any individual resource's **Test** is `$false`, `Test-DSCConfiguration` returns
`$false` indicating that the Node is not compliant. If all resource's **Test** methods return
`$true`, `Test-DSCConfiguration` returns `$true` to indicate that the Node is compliant.

```powershell
Test-DSCConfiguration
```

```output
True
```

Beginning in PowerShell 5.0, the **Detailed** parameter was added. Specifying **Detailed** causes
`Test-DSCConfiguration` to return an object containing collections of results for compliant, and
non-compliant resources.

```powershell
Test-DSCConfiguration -Detailed
```

```output
PSComputerName  ResourcesInDesiredState        ResourcesNotInDesiredState     InDesiredState
--------------  -----------------------        --------------------------     --------------
localhost       {[Service]Spooler}                                            True
```

For more information, see
[Test-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/Test-DSCConfiguration).

## Set

The **Set** method of a resource attempts to force the Node to become compliant with the resource's
*desired state*. The **Set** method is meant to be **idempotent**, which means that **Set** could be
run multiple times and always get the same result without errors. When you run
[Start-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/Start-DSCConfiguration), the
LCM cycles through each resource in the currently applied configuration. The LCM retrieves key
values for the current resource instance from the ".mof" file and uses them as parameters for the
**Test** method. If the **Test** method returns `$true`, the Node is compliant with the current
resource, and the **Set** method is skipped. If the **Test** returns `$false`, the Node is
non-compliant. The LCM passes the resource instance's key values as parameters to the resource's
**Set** method, restoring the Node to compliance.

By specifying the **Verbose** and **Wait** parameters, you can watch the progress of the
`Start-DSCConfiguration` cmdlet. In this example, the Node is already compliant. The `Verbose`
output indicates that the **Set** method was skipped.

```
PS> Start-DSCConfiguration -Verbose -Wait -UseExisting

VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' =
ApplyConfiguration,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' =
root/Microsoft/Windows/DesiredStateConfiguration'.
VERBOSE: An LCM method call arrived from computer SERVER01 with user sid
S-1-5-21-124525095-708259637-1543119021-1282804.
VERBOSE: [SERVER01]:                            [] Starting consistency engine.
VERBOSE: [SERVER01]:                            [] Checking consistency for current configuration.
VERBOSE: [SERVER01]:                            [DSCEngine] Importing the module
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\PSDesiredStateConfiguration\DscResources\MSFT_ServiceResource\MSFT
_ServiceResource.psm1 in force mode.
VERBOSE: [SERVER01]: LCM:  [ Start  Resource ]  [[Service]Spooler]
VERBOSE: [SERVER01]: LCM:  [ Start  Test     ]  [[Service]Spooler]
VERBOSE: [SERVER01]:                            [[Service]Spooler] Importing the module MSFT_ServiceResource in
force mode.
VERBOSE: [SERVER01]: LCM:  [ End    Test     ]  [[Service]Spooler]  in 0.2540 seconds.
VERBOSE: [SERVER01]: LCM:  [ Skip   Set      ]  [[Service]Spooler]
VERBOSE: [SERVER01]: LCM:  [ End    Resource ]  [[Service]Spooler]
VERBOSE: [SERVER01]:                            [] Consistency check completed.
VERBOSE: Operation 'Invoke CimMethod' complete.
VERBOSE: Time taken for configuration job to complete is 1.379 seconds
```

## See also

- [Azure Automation DSC Overview](/azure/automation/automation-dsc-overview)
- [Setting up an SMB pull server](../pull-server/pullServerSMB.md)
- [Configuring a pull client](../pull-server/pullClientConfigID.md)
