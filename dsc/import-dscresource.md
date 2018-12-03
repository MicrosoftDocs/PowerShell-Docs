---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Using Import-DSCResource
---

# Using Import-DSCResource

Import-DScResource is a cmdlet which can only be used inside a Configuration script block. When you are authoring a new configuration, you must import the resources needed by your configuration using this cmdlet. Resources under `$phsome` are imported automatically, but it is still considered best practice to explicitly import all resources used in your [Configuration](Configuration.md).

The cmdlet syntax is shown below.

```syntax
Import-DscResource [-Name <ResourceName(s)>] [-ModuleName <ModuleName(s)>]
```

|Parameter  |Description  |
|---------|---------|
|`-Name`|This is the DSC resource name(s) that you must import. If the module name is specified, the command searches for these DSC resources within this module; otherwise the command searches the DSC resources in all DSC resource paths. Wildcards are supported.|
|`-ModuleName`|This is the container module name(s), or module specification(s).  If the DSC resources that are required are specified, the command will try to import only those resources from the module(s).; Otherwise, the command imports all  the DSC resources in this module.|

You can use wildcards with the `-Name` parameter when using `Import-DSCResource`.

```powershell
Import-DscResource -Name * -ModuleName xActiveDirectory;
```

## Example: Use Import-DSCResource within a configuration

```powershell
Configuration MSDSCConfiguration
{
    # Search for and imports Service, File, and Registry from the module PSDesiredStateConfiguration.
    Import-DSCResource -ModuleName MS_DSC1 -name Service, File, Registry

    # Search for and import Resource1 from the module that defines it.
    # If only –Name parameter is used then resources can belong to different PowerShell modules as well.
    # TimeZone resource is from the ComputerManagementDSC module which is not installed by default.
    Import-DSCResource -Name File, TimeZone

    # Search for and import all DSC resources inside the module PSDesiredStateConfiguration.
    Import-DSCResource -ModuleName PSDesiredStateConfiguration
...
```

> [!NOTE]
> Specifying multiple values for Resource names and modules names in same command are not supported. It can have non-deterministic behavior about which resource to load from which module in case same resource exists in multiple modules. Below command will result in error during compilation.
>
> ```powershell
> Import-DscResource -Name UserConfigProvider*,TestLogger1 -ModuleName UserConfigProv,PsModuleForTestLogger
> ```

Things to consider when using only the Name parameter:

- It has performance implications because it is resource intensive operation. It can use lots of memory on machine depending on how many modules are installed on machine.
- It will load the first resource found with given name so in the case where ther are more than one resource with same name deployed on machine, it can end up loading different resource then the one desired.

The recommended way is to specify `–ModuleName` as well as described below, this accomplishes two things:

- It reduces the performance impact by limiting the search scope for the specified resource.
- It explicitly defines the module the resource is defined in ensuring the correct resource is loaded.

> [!NOTE]
> In PowerShell 5.0, DSC resources can have multiple versions, and versions can be installed on a computer side-by-side. This is implemented by having multiple versions of a resource module that are contained in the same module folder.
> For more information see [Using resources with multiple versions](sxsresource.md).

## Intellisense with Import-DSCResource

When authoring the DSC configuration in ISE, PowerShell provides IntelliSence for resources and resource properties. Resource definitions under the `$pshome` module path are loaded automatically. When you import resources using the `Import-DSCResource` cmdlet, the specified resource definitions are added and Intellisense is expanded to include the imported resource's schema.

[Resource Intellisense](resource-intellisense.png)

> [!NOTE]
> Beginning in PowerShell 5.0, tab completion was added to the ISE for DSC resources and their properties. For more information, see [Resources](resources.md).

When compiling the Configuration, PowerShell uses the imported resource definitions to validate all resource blocks in the configuration.
Each resource block is validated, using the resource's schema definition, for the following rules.

- Only properties defined in schema are used.
- The data types for each property is correct.
- Keys properties are specified.
- No read only property is used.
- Validation on value maps types.

Consider this configuration:

```powershell
Configuration SchemaValidationInCorrectEnumValue
{
    # It is best practice to explicitly import all resources used in your Configuration.
    # This includes resources that are imported automatically, like WindowsFeature.
    Import-DSCResource -Name WindowsFeature
    Node localhost
    {
        WindowsFeature ROLE1
        {
            Name = “Telnet-Client”
            Ensure = “Invalid”
        }
    }
}
```

Compiling this Configuration results in an error.

```output
PSDesiredStateConfiguration\WindowsFeature: At least one of the values ‘Invalid’ is not supported or valid for property ‘Ensure’ on class ‘WindowsFeature’. Please specify only supported values: Present, Absent.
```

This allows catching most of the errors during parse and compilation time instead of delaying it till run time (configuration application).

> [!NOTE]
> Each DSC resource can have a name, and a **FriendlyName** defined by the resource's schema. Below are the first two lines of "MSFT_ServiceResource.shema.mof".
> ```syntax
> [ClassVersion("1.0.0"),FriendlyName("Service")]
> class MSFT_ServiceResource : OMI_BaseResource
> ```
> When using this resource in a Configuration, you can specify **MSFT_ServiceResource** or **Service**.

## PowerShell v4 and v5 differences

There are multiple differences you see when authoring Configurations in PowerShell 4.0 vs. PowerShell 5.0 and later. This section will highlight the differences that you see relevant to this article.

### Multiple Resource Versions

Installing and using multiple versions of resources side-by-side was not supported in PowerShell 4.0. If you notice issues importing resources into your Configuration, ensure that you only have one version of the resource installed.

In the image below, two versions of the **xPSDesiredStateConfiguration** module are installed.

[Multiple Resource Versions Fixed](multiple-resource-versions-broken.md)

You should copy the contents of your desired module version to the top-level of the module directory.

[Multiple Resource Versions Fixed](multiple-resource-versions-fixed.md)

### Resource location

When authoring and compiling Configurations, your resources can be stored in any directory specified by your [PSModulePath](/powershell/developer/module/modifying-the-psmodulepath-installation-path). In PowerShell 4.0, the LCM requires all DSC resource modules to be stored under "Program Files\WindowsPowerShell\Modules" or `$pshome\Modules`. Beginning in PowerShell 5.0, this requirement was removed, and resource modules can be stored in any directory specified by `PSModulePath`.

## See also

- [Resources](resources.md)
