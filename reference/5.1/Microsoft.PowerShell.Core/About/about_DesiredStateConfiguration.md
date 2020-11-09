---
description:  Provides a brief introduction to the PowerShell Desired State Configuration (DSC) feature.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 07/23/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_desiredstateconfiguration?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_DesiredStateConfiguration
---

# about_DesiredStateConfiguration

## SHORT DESCRIPTION

Provides a brief introduction to the PowerShell Desired State
Configuration (DSC) feature.

## LONG DESCRIPTION

DSC is a management platform in PowerShell that enables deploying and managing
configuration data for software services, and managing the environment in
which these services run.

DSC provides a set of PowerShell language extensions, new cmdlets, and
resources that you can use to declaratively specify how you want the state of
your software environment to be configured. It also provides a means to
maintain and manage existing configurations.

DSC is introduced in PowerShell 4.0.

For detailed information about DSC, see
[PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/overview).

## DEVELOPING DSC RESOURCES WITH CLASSES

Starting in PowerShell 5.0, you can develop DSC resources by using classes.
For more information, see [about_Classes](about_Classes.md), and
[Writing a custom DSC resource with PowerShell classes](/powershell/scripting/dsc/resources/authoringresourceclass).

## USING DSC

To use DSC to configure your environment, first define a PowerShell
script block using the Configuration keyword, followed by an identifier, which
is in turn followed by the pair of curly braces delimiting the block. Inside
the configuration block you can define node blocks that specify the desired
configuration state for each node (computer) in the environment. A node block
starts with the Node keyword, followed by the name of the target computer,
which can be a variable. After the computer name, come the curly braces that
delimit the node block. Inside the node block, you can define resource blocks
to configure specific resources. A resource block starts with the type name of
the resource, followed by the identifier you want to specify for that block,
followed by the curly braces that delimit the block, as shown in the following
example.

```powershell
Configuration MyWebConfig {
    # Parameters are optional
    param ($MachineName, $WebsiteFilePath)
    # A Configuration block can have one or more Node blocks
    Node $MachineName
    {
        # Next, specify one or more resource blocks
        # WindowsFeature is one of the resources you can use in a Node block
        # This example ensures the Web Server (IIS) role is installed
        WindowsFeature IIS
        {
            # To ensure that the role is not installed, set Ensure to "Absent"
            Ensure = "Present"
            Name = "Web-Server" # Use the Name property from Get-WindowsFeature
        }

        # You can use the File resource to create files and folders
        # "WebDirectory" is the name you want to use to refer to this instance
        File WebDirectory
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Type = "Directory" # Default is "File"
            Recurse = $true
            SourcePath = $WebsiteFilePath
            DestinationPath = "C:\inetpub\wwwroot"

            # Ensure that the IIS block is successfully run first before
            # configuring this resource
            DependsOn = "[WindowsFeature]IIS"  # Use for dependencies
        }
    }
}
```

To create a configuration, invoke the Configuration block the same way you
would invoke a PowerShell function, passing in any expected parameters you may
have defined (two in the example above). For example, in this case:

```powershell
MyWebConfig -MachineName "TestMachine" -WebsiteFilePath `
  "\\filesrv\WebFiles" -OutputPath "C:\Windows\system32\temp"
# OutputPath is optional
```

This generates a MOF file per node at the path you specify. These MOF files
specify the desired configuration for each node. Next, use the following
cmdlet to parse the configuration MOF files, send each node its corresponding
configuration, and enact those configurations. Note that you do not need to
create a separate MOF file for class-based DSC resources.

```powershell
Start-DscConfiguration -Verbose -Wait -Path "C:\Windows\system32\temp"
```

## USING DSC TO MAINTAIN CONFIGURATION STATE

With DSC, configuration is idempotent. This means that if you use DSC to enact
the same configuration more than once, the resulting configuration state will
always be the same. Because of this, if you suspect that any nodes in your
environment may have drifted from the desired state of configuration, you can
enact the same DSC configuration again to bring them back to the desired
state. You do not need to modify the configuration script to address only
those resources whose state has drifted from the desired state.

The following example shows how you can verify whether the actual state of
configuration on a given node has drifted from the last DSC configuration
enacted on the node. In this example we are checking the configuration of the
local computer.

```powershell
$session = New-CimSession -ComputerName "localhost"
Test-DscConfiguration -CimSession $session
```

## BUILT-IN DSC RESOURCES

You can use the following built-in resources in your configuration scripts:

|Name                  |Properties                                         |
|----------------------|---------------------------------------------------|
|File                  |{DestinationPath, Attributes, Checksum, Content...}|
|Archive               |{Destination, Path, Checksum, Credential...}       |
|Environment           |{Name, DependsOn, Ensure, Path...}                 |
|Group                 |{GroupName, Credential, DependsOn, Description...} |
|Log                   |{Message, DependsOn, PsDscRunAsCredential}         |
|Package               |{Name, Path, ProductId, Arguments...}              |
|Registry              |{Key, ValueName, DependsOn, Ensure...}             |
|Script                |{GetScript, SetScript, TestScript, Credential...}  |
|Service               |{Name, BuiltInAccount, Credential, Dependencies...}|
|User                  |{UserName, DependsOn, Description, Disabled...}    |
|WaitForAll            |{NodeName, ResourceName, DependsOn, PsDscRunAsC...}|
|WaitForAny            |{NodeName, ResourceName, DependsOn, PsDscRunAsC...}|
|WaitForSome           |{NodeCount, NodeName, ResourceName, DependsOn...}  |
|WindowsFeature        |{Name, Credential, DependsOn, Ensure...}           |
|WindowsOptionalFeature|{Name, DependsOn, Ensure, LogLevel...}             |
|WindowsProcess        |{Arguments, Path, Credential, DependsOn...}        |

To get a list of available DSC resources on your system, run the
`Get-DscResource` cmdlet.

> [!NOTE]
> In PowerShell versions below 7.0, `Get-DscResource` does not find Class based
> DSC resources.

The example in this topic demonstrates how to use the File and WindowsFeature
resources. To see all properties that you can use with a resource, insert the
cursor in the resource keyword (for example, File) within your configuration
script in PowerShell ISE, hold down <kbd>CTRL</kbd>+<kbd>SPACEBAR</kbd>

## FIND MORE RESOURCES

You can download, install, and learn about many other available DSC resources
that have been created by the PowerShell and DSC user community, and by
Microsoft. Visit the [PowerShell Gallery](https://www.powershellgallery.com/)
to browse and learn about available DSC resources.

## SEE ALSO

[PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/overview)

[Built-In PowerShell Desired State Configuration Resources](/powershell/scripting/dsc/resources/resources)

[Build Custom PowerShell Desired State Configuration Resources](/powershell/scripting/dsc/resources/authoringResource)
