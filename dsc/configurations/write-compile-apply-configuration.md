---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,service,setup
title:  Write, Compile, and Apply a Configuration
---

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

# Write, Compile, and Apply a Configuration

This exercise walks through creating and applying a Desired State Configuration (DSC) configuration from start to finish.
In the following example, you will learn how to write and apply a very simple Configuration. The Configuration will ensure a "HelloWorld.txt" file exists on your local machine. If you delete the file, DSC will recreate it the next time it updates.

For an overview of what DSC is and how it works, see [Desired State Configuration Overview for Developers](../overview/overview.md).

## Requirements

To run this example, you will need a computer running PowerShell 4.0 or later.

## Write the configuration

A DSC [Configuration](configurations.md) is a special PowerShell function that defines how you want to configure one or more target computers (Nodes).

In the PowerShell ISE, or other PowerShell editor, type the following:

```powershell
Configuration HelloWorld {

    # Import the module that contains the File resource.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets to compile MOF files for, when this configuration is executed.
    Node 'localhost' {

        # The File resource can ensure the state of files, or copy them from a source to a destination with persistent updates.
        File HelloWorld {
            DestinationPath = "C:\Temp\HelloWorld.txt"
            Ensure = "Present"
            Contents   = "Hello World from DSC!"
        }
    }
}
```

Save the file as "HelloWorld.ps1".

Defining a Configuration is like defining a Function. The **Node** block specifies the target node to be configured, in this case `localhost`.

The configuration calls one [resources](../resources/resources.md), the `File` resource. Resources do the work of ensuring that the target node is in the state defined by the configuration.

## Compile the configuration

For a DSC configuration to be applied to a node, it must first be compiled into a MOF file.
Running the configuration, like a function, will compile one ".mof" file for every Node defined by the `Node` block.
In order to run the configuration, you need to *dot source* your "HelloWorld.ps1" script into the current scope.
For more information, see [about_Scripts](/powershell/module/microsoft.powershell.core/about/about_scripts?view=powershell-6#script-scope-and-dot-sourcing).

<!-- markdownlint-disable MD038 -->
*Dot source* your "HelloWorld.ps1" script by typing in the path where you stored it, after the `. ` (dot, space). You may then, run your configuration by calling it like a Function.
<!-- markdownlint-enable MD038 -->

```powershell
. C:\Scripts\HelloWorld.ps1
HelloWorld
```

This generates the following output:

```output
Directory: C:\Scripts\HelloWorld


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        3/13/2017   5:20 PM           2746 localhost.mof
```

## Apply the configuration

Now that you have the compiled MOF, you can apply the configuration to the target node (in this case, the local computer) by calling the
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration) cmdlet.

The `Start-DscConfiguration` cmdlet tells the [Local Configuration Manager (LCM)](../managing-nodes/metaConfig.md),
the engine of DSC, to apply the configuration.
The LCM does the work of calling the DSC resources to apply the configuration.

Use the code below to execute the `Start-DSCConfiguration` cmdlet. Specify the directory path where your "localhost.mof" is stored to the `-Path` parameter. The `Start-DSCConfiguration` cmdlet looks through the directory specified for any "\<computername\>.mof" files. The `Start-DSCConfiguration` cmdlet attempts to apply each ".mof" file it finds to the computername specified by the filename ("localhost", "server01", "dc-02", etc.).

> [!NOTE]
> If the `-Wait` parameter is not specified, `Start-DSCConfiguration` creates a background job to perform the operation. Specifying the `-Verbose` parameter allows you to watch the **Verbose** output of the operation. `-Wait`, and `-Verbose` are both optional parameters.

```powershell
Start-DscConfiguration -Path C:\Scripts\HelloWorld -Verbose -Wait
```

## Test the configuration

Once the `Start-DSCConfiguration` cmdlet is complete, you should see a "HelloWorld.txt" file in the location you specified. You can verify the contents with the [Get-Content](/powershell/module/microsoft.powershell.management/get-content) cmdlet.

You can also *test* the current status using [Test-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/Test-DSCConfiguration).

The output should be "True" if the Node is currently compliant with the applied Configuration.

```powershell
Test-DSCConfiguration
```

```output
True
```

```powershell
Get-Content -Path C:\Temp\HelloWorld.txt
```

```output
Hello World from DSC!
```

## Re-applying the configuration

To see your configuration get applied again, you can remove the text file created by your Configuration. The use the `Start-DSCConfiguration` cmdlet with the `-UseExisting` parameter. The `-UseExisting` parameter instructs `Start-DSCConfiguration` to re-apply the "current.mof" file, which represents the most recently successfully applied configuration.

```powershell
Remove-Item -Path C:\Temp\HelloWorld.txt
```

## Next steps

- Find out more about DSC configurations at [DSC configurations](configurations.md).
- See what DSC resources are available, and how to create custom DSC resources at [DSC resources](../resources/resources.md).
- Find DSC configurations and resources in the [PowerShell Gallery](https://www.powershellgallery.com/).
