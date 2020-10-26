---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
title:  Writing a custom DSC resource with MOF
description: This article defines the schema for a DSC custom resource in a MOF file and implements the resource in a PowerShell script file.
---

# Writing a custom DSC resource with MOF

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

In this article, we will define the schema for a Windows PowerShell Desired State Configuration
(DSC) custom resource in a MOF file, and implement the resource in a Windows PowerShell script file.
This custom resource is for creating and maintaining a web site.

## Creating the MOF schema

The schema defines the properties of your resource that can be configured by a DSC configuration
script.

### Folder structure for a MOF resource

To implement a DSC custom resource with a MOF schema, create the following folder structure. The MOF
schema is defined in the file `Demo_IISWebsite.schema.mof`, and the resource script is defined in
`Demo_IISWebsite.psm1`. Optionally, you can create a module manifest (psd1) file.

```
$env:ProgramFiles\WindowsPowerShell\Modules (folder)
    |- MyDscResources (folder)
        |- DSCResources (folder)
            |- Demo_IISWebsite (folder)
                |- Demo_IISWebsite.psd1 (file, optional)
                |- Demo_IISWebsite.psm1 (file, required)
                |- Demo_IISWebsite.schema.mof (file, required)
```

> [!NOTE]
> It is necessary to create a folder named DSCResources under the top-level folder, and that the
> folder for each resource must have the same name as the resource.

### The contents of the MOF file

Following is an example MOF file that can be used for a custom website resource. To follow this
example, save this schema to a file, and call the file `Demo_IISWebsite.schema.mof`.

```
[ClassVersion("1.0.0"), FriendlyName("Website")]
class Demo_IISWebsite : OMI_BaseResource
{
  [Key] string Name;
  [Required] string PhysicalPath;
  [write,ValueMap{"Present", "Absent"},Values{"Present", "Absent"}] string Ensure;
  [write,ValueMap{"Started","Stopped"},Values{"Started", "Stopped"}] string State;
  [write] string Protocol[];
  [write] string BindingInfo[];
  [write] string ApplicationPool;
  [read] string ID;
};
```

Note the following about the previous code:

- `FriendlyName` defines the name you can use to refer to this custom resource in DSC configuration
  scripts. In this example, `Website` is equivalent to the friendly name `Archive` for the built-in
  Archive resource.
- The class you define for your custom resource must derive from `OMI_BaseResource`.
- The type qualifier, `[Key]`, on a property indicates that this property will uniquely identify the
  resource instance. At least one `[Key]` property is required.
- The `[Required]` qualifier indicates that the property is required (a value must be specified in
  any configuration script that uses this resource).
- The `[write]` qualifier indicates that this property is optional when using the custom resource in
  a configuration script. The `[read]` qualifier indicates that a property cannot be set by a
  configuration, and is for reporting purposes only.
- `Values` restricts the values that can be assigned to the property to the list of values defined
  in `ValueMap`. For more information, see
  [ValueMap and Value Qualifiers](/windows/desktop/WmiSdk/value-map).
- Including a property called `Ensure` with values `Present` and `Absent` in your resource is
  recommended as a way to maintain a consistent style with built-in DSC resources.
- Name the schema file for your custom resource as follows: `classname.schema.mof`, where
  `classname` is the identifier that follows the `class` keyword in your schema definition.

### Writing the resource script

The resource script implements the logic of the resource. In this module, you must include three
functions called `Get-TargetResource`, `Set-TargetResource`, and `Test-TargetResource`. All three
functions must take a parameter set that is identical to the set of properties defined in the MOF
schema that you created for your resource. In this document, this set of properties is referred to
as the "resource properties." Store these three functions in a file called `<ResourceName>.psm1`. In
the following example, the functions are stored in a file called `Demo_IISWebsite.psm1`.

> [!NOTE]
> When you run the same configuration script on your resource more than once, you should receive no
> errors and the resource should remain in the same state as running the script once. To accomplish
> this, ensure that your `Get-TargetResource` and `Test-TargetResource` functions leave the
> resource unchanged, and that invoking the `Set-TargetResource` function more than once in a
> sequence with the same parameter values is always equivalent to invoking it once.

In the `Get-TargetResource` function implementation, use the key resource property values that are
provided as parameters to check the status of the specified resource instance. This function must
return a hash table that lists all the resource properties as keys and the actual values of these
properties as the corresponding values. The following code provides an example.

```powershell
# DSC uses the Get-TargetResource function to fetch the status of the resource instance
# specified in the parameters for the target machine
function Get-TargetResource
{
    param
    (
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PhysicalPath,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApplicationPool,

        [string[]]$BindingInfo,

        [string[]]$Protocol
    )

        $getTargetResourceResult = $null;

        <#
          Insert logic that uses the mandatory parameter values to get the website and
          assign it to a variable called $Website
          Set $ensureResult to "Present" if the requested website exists and to "Absent" otherwise
        #>

        # Add all Website properties to the hash table
        # This simple example assumes that $Website is not null
        $getTargetResourceResult = @{
            Name = $Website.Name
            Ensure = $ensureResult
            PhysicalPath = $Website.physicalPath
            State = $Website.state
            ID = $Website.id
            ApplicationPool = $Website.applicationPool
            Protocol = $Website.bindings.Collection.protocol
            Binding = $Website.bindings.Collection.bindingInformation
        }

        $getTargetResourceResult
}
```

Depending on the values that are specified for the resource properties in the configuration script,
the `Set-TargetResource` must do one of the following:

- Create a new website
- Update an existing website
- Delete an existing website

The following example illustrates this.

```powershell
# The Set-TargetResource function is used to create, delete or configure a website on the target machine.
function Set-TargetResource
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param
    (
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PhysicalPath,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApplicationPool,

        [string[]]$BindingInfo,

        [string[]]$Protocol
    )

    <#
        If Ensure is set to "Present" and the website specified in the mandatory input parameters
          does not exist, then create it using the specified parameter values
        Else, if Ensure is set to "Present" and the website does exist, then update its properties
          to match the values provided in the non-mandatory parameter values
        Else, if Ensure is set to "Absent" and the website does not exist, then do nothing
        Else, if Ensure is set to "Absent" and the website does exist, then delete the website
    #>
}
```

Finally, the `Test-TargetResource` function must take the same parameter set as `Get-TargetResource`
and `Set-TargetResource`. In your implementation of `Test-TargetResource`, check the status of the
resource instance that is specified in the key parameters. If the actual status of the resource
instance does not match the values specified in the parameter set, return `$false`. Otherwise,
return `$true`.

The following code implements the `Test-TargetResource` function.

```powershell
function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,

        [parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [parameter(Mandatory = $true)]
        [System.String]
        $PhysicalPath,

        [ValidateSet("Started","Stopped")]
        [System.String]
        $State,

        [System.String[]]
        $Protocol,

        [System.String[]]
        $BindingData,

        [System.String]
        $ApplicationPool
    )

    # Get the current state
    $currentState = Get-TargetResource -Ensure $Ensure -Name $Name -PhysicalPath $PhysicalPath -State $State -ApplicationPool $ApplicationPool -BindingInfo $BindingInfo -Protocol $Protocol

    # Write-Verbose "Use this cmdlet to deliver information about command processing."

    # Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    # Include logic to
    $result = [System.Boolean]
    # Add logic to test whether the website is present and its status matches the supplied
    # parameter values. If it does, return true. If it does not, return false.
    $result
}
```

> [!NOTE]
> For easier debugging, use the `Write-Verbose` cmdlet in your implementation of the previous
> three functions. This cmdlet writes text to the verbose message stream. By default, the verbose
> message stream is not displayed, but you can display it by changing the value of the
> **$VerbosePreference** variable or by using the **Verbose** parameter in the DSC cmdlets = new.

### Creating the module manifest

Finally, use the `New-ModuleManifest` cmdlet to define a `<ResourceName>.psd1` file for your
custom resource module. When you invoke this cmdlet, reference the script module (.psm1) file
described in the previous section. Include `Get-TargetResource`, `Set-TargetResource`, and
`Test-TargetResource` in the list of functions to export. Following is an example manifest file.

```powershell
# Module manifest for module 'Demo.IIS.Website'
#
# Generated on: 1/10/2013
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '6AB5ED33-E923-41d8-A3A4-5ADDA2B301DE'

# Author of this module
Author = 'Contoso'

# Company or vendor of this module
CompanyName = 'Contoso'

# Copyright statement for this module
Copyright = 'Contoso. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This Module is used to support the creation and configuration of IIS Websites through Get, Set and Test API on the DSC managed nodes.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0'

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @("WebAdministration")

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @("Demo_IISWebsite.psm1")

# Functions to export from this module
FunctionsToExport = @("Get-TargetResource", "Set-TargetResource", "Test-TargetResource")

# Cmdlets to export from this module
#CmdletsToExport = '*'

# HelpInfo URI of this module
# HelpInfoURI = ''
}
```

## Supporting PsDscRunAsCredential

> [!Note]
> **PsDscRunAsCredential** is supported in PowerShell 5.0 and later.

The **PsDscRunAsCredential** property can be used in
[DSC configurations](../configurations/configurations.md) resource block to specify that the
resource should be run under a specified set of credentials. For more information, see
[Running DSC with user credentials](../configurations/runAsUser.md).

To access the user context from within a custom resource, you can use the automatic variable
`$PsDscContext`.

For example the following code would write the user context under which the resource is running to
the verbose output stream:

```powershell
if (PsDscContext.RunAsUser) {
    Write-Verbose "User: $PsDscContext.RunAsUser";
}
```

## Rebooting the Node

If the actions taken in your `Set-TargetResource` function require a reboot, you can use a global
flag to tell the LCM to reboot the Node. This reboot occurs directly after the `Set-TargetResource`
function completes.

Inside your `Set-TargetResource` function, add the following line of code.

```powershell
# Include this line if the resource requires a system reboot.
$global:DSCMachineStatus = 1
```

In order for the LCM to reboot the Node, the **RebootNodeIfNeeded** flag needs to be set to `$true`.
The **ActionAfterReboot** setting should also be set to **ContinueConfiguration**, which is the
default. For more information on configuring the LCM, see
[Configuring the Local Configuration Manager](../managing-nodes/metaConfig.md), or
[Configuring the Local Configuration Manager (v4)](../managing-nodes/metaConfig4.md).
