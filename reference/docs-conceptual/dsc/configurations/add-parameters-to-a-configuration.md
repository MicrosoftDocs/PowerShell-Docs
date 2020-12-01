---
ms.date:  12/12/2018
keywords:  dsc,powershell,resource,gallery,setup
title:  Add Parameters to a Configuration
description: DSC Configurations can be parameterized to allow more dynamic configurations based on user input.
---

# Add Parameters to a Configuration

Like Functions, [Configurations](configurations.md) can be parameterized to allow more dynamic
configurations based on user input. The steps are similar to those described in
[Functions with Parameters](/powershell/module/microsoft.powershell.core/about/about_functions).

This example starts with a basic Configuration that configures the "Spooler" service to be
"Running".

```powershell
Configuration TestConfig
{
    # It is best practice to explicitly import any required resources or modules.
    Import-DSCResource -Module PSDesiredStateConfiguration

    Node localhost
    {
        Service 'Spooler'
        {
            Name = 'Spooler'
            State = 'Running'
        }
    }
}
```

## Built-in Configuration parameters

Unlike a Function though, the
[CmdletBinding](/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute)
attribute adds no functionality. In addition to
[Common Parameters](/powershell/module/microsoft.powershell.core/about/about_commonparameters),
Configurations can also use the following built in parameters, without requiring you to define them.

|        Parameter        |                                         Description                                          |
| ----------------------- | -------------------------------------------------------------------------------------------- |
| `-InstanceName`         | Used in defining [Composite Configurations](compositeconfigs.md)                             |
| `-DependsOn`            | Used in defining [Composite Configurations](compositeconfigs.md)                             |
| `-PSDSCRunAsCredential` | Used in defining [Composite Configurations](compositeconfigs.md)                             |
| `-ConfigurationData`    | Used to pass in structured [Configuration Data](configData.md) for use in the Configuration. |
| `-OutputPath`           | Used to specify where your "\<computername\>.mof" file will be compiled                      |

## Adding your own parameters to Configurations

In addition to the built-in parameters, you can also add your own parameters to your Configurations.
The parameter block goes directly inside the Configuration declaration, just like a Function. A
Configuration parameter block should be outside any **Node** declarations, and above any *import*
statements. By adding parameters, you can make your Configurations more robust and dynamic.

```powershell
Configuration TestConfig
{
    param
    (

    )
```

### Add a ComputerName parameter

The first parameter you might add is a `-Computername` parameter so you can dynamically compile a
".mof" file for any `-Computername` you pass to your configuration. Like Functions, you can also
define a default value, in case the user does not pass in a value for `-ComputerName`

```powershell
param
(
    [String]
    $ComputerName="localhost"
)
```

Within your configuration, you can then specify your `-ComputerName` parameter when defining your
Node block.

```powershell
Node $ComputerName
{

}
```

### Calling your Configuration with parameters

After you have added parameters to your Configuration, you can use them just like you would with a
cmdlet.

```powershell
TestConfig -ComputerName "server01"
```

### Compiling multiple .mof files

The Node block can also accept a comma-separated list of computer names and will generate ".mof"
files for each. You can run the following example to generate ".mof" files for all of the computers
passed to the `-ComputerName` parameter.

```powershell
Configuration TestConfig
{
    param
    (
        [String[]]
        $ComputerName="localhost"
    )

    # It is best practice to explicitly import any required resources or modules.
    Import-DSCResource -Module PSDesiredStateConfiguration

    Node $ComputerName
    {
        Service 'Spooler'
        {
            Name = 'Spooler'
            State = 'Running'
        }
    }
}

TestConfig -ComputerName "server01", "server02", "server03"
```

## Advanced parameters in Configurations

In addition to a `-ComputerName` parameter, we can add parameters for the service name and state.
The following example adds a parameter block with a `-ServiceName` parameter and uses it to
dynamically define the **Service** resource block. It also adds a `-State` parameter to dynamically
define the **State** in the **Service** resource block.

```powershell
Configuration TestConfig
{
    param
    (
        [String]
        $ServiceName,

        [String]
        $State,

        [String]
        $ComputerName="localhost"
    )

    # It is best practice to explicitly import any required resources or modules.
    Import-DSCResource -Module PSDesiredStateConfiguration

    Node $ComputerName
    {
        Service $ServiceName
        {
            Name = $ServiceName
            State = $State
        }
    }
}
```

> [!NOTE]
> In more advanced scenarios, it might make more sense to move your dynamic data into a structured
> [Configuration Data](configData.md).

The example Configuration now takes a dynamic `$ServiceName`, but if one is not specified, compiling
results in an error. You could add a default value like this example.

```powershell
[String]
$ServiceName="Spooler"
```

In this instance though, it makes more sense to simply force the user to specify a value for the
`$ServiceName` parameter. The `parameter` attribute allows you to add further validation and
pipeline support to your Configuration's parameters.

Above any parameter declaration, add the `parameter` attribute block as in the example below.

```powershell
[parameter()]
[String]
$ServiceName
```

You can specify arguments to each `parameter` attribute, to control aspects of the defined
parameter. The following example makes the `$ServiceName` a **Mandatory** parameter.

```powershell
[parameter(Mandatory)]
[String]
$ServiceName
```

For the `$State` parameter, we would like to prevent the user from specifying values outside of a
predefined set (like Running, Stopped) the `ValidationSet*`attribute would prevent the user from
specifying values outside of a predefined set (like Running, Stopped). The following example adds
the `ValidationSet` attribute to the `$State` parameter. Since we do not want to make the `$State`
parameter **Mandatory**, we will need to add a default value for it.

```powershell
[ValidateSet("Running", "Stopped")]
[String]
$State="Running"
```

> [!NOTE]
> You do not need to specify a `parameter` attribute when using a `validation` attribute.

You can read more about the `parameter` and validation attributes in
[about_Functions_Advanced_Parameters](/powershell/module/microsoft.powershell.core/about/about_Functions_Advanced_Parameters).

## Fully parameterized Configuration

We now have a parameterized Configuration that forces the user to specify an `-InstanceName`,
`-ServiceName`, and validates the `-State` parameter.

```powershell
Configuration TestConfig
{
    param
    (
        [parameter(Mandatory)]
        [String]
        $ServiceName,

        [ValidateSet("Running","Stopped")]
        [String]
        $State="Running",

        [String]
        $ComputerName="localhost"
    )

    # It is best practice to explicitly import any required resources or modules.
    Import-DSCResource -Module PSDesiredStateConfiguration

    Node $ComputerName
    {
        Service $ServiceName
        {
            Name = $ServiceName
            State = $State
        }
    }
}
```

## See also

- [Write help for DSC configurations](configHelp.md)
- [Dynamic Configurations](flow-control-in-configurations.md)
- [Use Configuration Data in your Configurations](configData.md)
- [Separate configuration and environment data](separatingEnvData.md)
