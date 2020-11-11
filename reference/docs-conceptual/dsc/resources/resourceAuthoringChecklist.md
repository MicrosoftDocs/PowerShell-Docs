---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
title:  Resource authoring checklist
description: This article contains a checklist of best practices that should be used when authoring a new DSC Resource.
---
# Resource authoring checklist

This checklist is a list of best practices when authoring a new DSC Resource.

## Resource module contains .psd1 file and schema.mof for every resource

Check that your resource has correct structure and contains all required files. Every resource
module should contain a .psd1 file and every non-composite resource should have schema.mof file.
Resources that do not contain schema will not be listed by `Get-DscResource` and users will not be
able to use the IntelliSense when writing code against those modules in ISE. The directory structure
for xRemoteFile resource, which is part of the
[xPSDesiredStateConfiguration resource module](https://github.com/PowerShell/xPSDesiredStateConfiguration),
looks as follows:

```
xPSDesiredStateConfiguration
    DSCResources
        MSFT_xRemoteFile
            MSFT_xRemoteFile.psm1
            MSFT_xRemoteFile.schema.mof
    Examples
        xRemoteFile_DownloadFile.ps1
    ResourceDesignerScripts
        GenerateXRemoteFileSchema.ps1
    Tests
        ResourceDesignerTests.ps1
    xPSDesiredStateConfiguration.psd1
```

## Resource and schema are correct

Verify the resource schema (`*.schema.mof`) file. You can use the
[DSC Resource Designer](https://www.powershellgallery.com/packages/xDSCResourceDesigner/1.12.0.0) to
help develop and test your schema. Make sure that:

- Property types are correct (e.g. don't use String for properties which accept numeric values, you
  should use UInt32 or other numeric types instead)
- Property attributes are specified correctly as: ([key], [required], [write], [read])
- At least one parameter in the schema has to be marked as [key]
- [read] property does not coexist together with any of: [required], [key], [write]
- If multiple qualifiers are specified except [read], then [key] takes precedence
- If [write] and [required] are specified, then [required] takes precedence
- ValueMap is specified where appropriate
  Example:

  ```
  [Read, ValueMap{"Present", "Absent"}, Values{"Present", "Absent"}, Description("Says whether DestinationPath exists on the machine")] String Ensure;
  ```

- Friendly name is specified and confirms to DSC naming conventions

  Example:
  `[ClassVersion("1.0.0.0"), FriendlyName("xRemoteFile")]`

- Every field has meaningful description. The PowerShell GitHub repository has good examples, such
  as the [.schema.mof for xRemoteFile](https://github.com/dsccommunity/xPSDesiredStateConfiguration/blob/master/source/DSCResources/DSC_xRemoteFile/DSC_xRemoteFile.schema.mof)

Additionally, you should use `Test-xDscResource` and `Test-xDscSchema` cmdlets from
[DSC Resource Designer](https://www.powershellgallery.com/packages/xDSCResourceDesigner/1.12.0.0) to
automatically verify the resource and schema:

```
Test-xDscResource <Resource_folder>
Test-xDscSchema <Path_to_resource_schema_file>
```

For example:

```powershell
Test-xDscResource ..\DSCResources\MSFT_xRemoteFile
Test-xDscSchema ..\DSCResources\MSFT_xRemoteFile\MSFT_xRemoteFile.schema.mof
```

## Resource loads without errors

Check whether the resource module can be successfully loaded. This can be achieved manually, by
running `Import-Module <resource_module> -force` and confirming that no errors occurred, or by
writing test automation. In case of the latter, you can follow this structure in your test case:

```powershell
$error = $null
Import-Module <resource_module> –force
If ($error.count –ne 0) {
    Throw "Module was not imported correctly. Errors returned: $error"
}
```

## Resource is idempotent in the positive case

One of the fundamental characteristics of DSC resources is idempotence. It means that applying a DSC
configuration containing that resource multiple times will always achieve the same result. For
example, if we create a configuration which contains the following File resource:

```powershell
File file {
    DestinationPath = "C:\test\test.txt"
    Contents = "Sample text"
}
```

After applying it for the first time, file test.txt should appear in `C:\test` folder. However,
subsequent runs of the same configuration should not change the state of the machine (e.g. no copies
of the `test.txt` file should be created). To ensure a resource is idempotent you can repeatedly
call `Set-TargetResource` when testing the resource directly, or call `Start-DscConfiguration`
multiple times when doing end to end testing. The result should be the same after every run.

## Test user modification scenario

By changing the state of the machine and then rerunning DSC, you can verify that
`Set-TargetResource` and `Test-TargetResource` function properly. Here are steps you should take:

1. Start with the resource not in the desired state.
1. Run configuration with your resource
1. Verify `Test-DscConfiguration` returns True
1. Modify the configured item to be out of the desired state
1. Verify `Test-DscConfiguration` returns false

Here's a more concrete example using Registry resource:

1. Start with registry key not in the desired state
1. Run `Start-DscConfiguration` with a configuration to put it in the desired state and verify it
   passes.
1. Run `Test-DscConfiguration` and verify it returns true
1. Modify the value of the key so that it is not in the desired state
1. Run `Test-DscConfiguration` and verify it returns false
1. `Get-TargetResource` functionality was verified using `Get-DscConfiguration`

`Get-TargetResource` should return details of the current state of the resource. Make sure to test
it by calling `Get-DscConfiguration` after you apply the configuration and verifying that output
correctly reflects the current state of the machine. It's important to test it separately, since any
issues in this area won't appear when calling `Start-DscConfiguration`.

## Call **Get/Set/Test-TargetResource** functions directly

Make sure you test the `Get/Set/Test-TargetResource` functions implemented in your resource by
calling them directly and verifying that they work as expected.

## Verify End to End using Start-DscConfiguration

Testing `Get/Set/Test-TargetResource` functions by calling them directly is important, but not all
issues will be discovered this way. You should focus significant part of your testing on using
`Start-DscConfiguration` or the pull server. In fact, this is how users will use the resource, so
don't underestimate the significance of this type of tests. Possible types of issues:

- Credential/Session may behave differently because the DSC agent runs as a service. Be sure to test
  any features here end to end.
- Errors output by `Start-DscConfiguration` may be different than those displayed when calling the
  `Set-TargetResource` function directly.

## Test compatibility on all DSC supported platforms

Resource should work on all DSC supported platforms (Windows Server 2008 R2 and newer). Install the
latest WMF (Windows Management Framework) on your OS to get the latest version of DSC. If your
resource does not work on some of these platforms by design, a specific error message should be
returned. Also, make sure your resource checks whether cmdlets you are calling are present on
particular machine. Windows Server 2012 added a large number of new cmdlets that are not available
on Windows Server 2008R2, even with WMF installed.

## Verify on Windows Client (if applicable)

One very common test gap is verifying the resource only on server versions of Windows. Many
resources are also designed to work on Client SKUs, so if that's true in your case, don't forget to
test it on those platforms as well.

## Get-DSCResource lists the resource

After deploying the module, calling `Get-DscResource` should list your resource among others as a
result. If you can't find your resource in the list, make sure that schema.mof file for that
resource exists.

## Resource module contains examples

Creating quality examples which will help others understand how to use it. This is crucial,
especially since many users treat sample code as documentation.

- First, you should determine the examples that will be included with the module – at minimum, you
  should cover most important use cases for your resource:
- If your module contains several resources that need to work together for an end-to-end scenario,
  the basic end-to-end example would ideally be first.
- The initial examples should be very simple -- how to get started with your resources in small
  manageable chunks (e.g. creating a new VHD)
- Subsequent examples should build on those examples (e.g. creating a VM from a VHD, removing VM,
  modifying VM), and show advanced functionality (e.g. creating a VM with dynamic memory)
- Example configurations should be parameterized (all values should be passed to the configuration
  as parameters and there should be no hardcoded values):

```powershell
configuration Sample_xRemoteFile_DownloadFile
{
    param
    (
        [string[]] $nodeName = 'localhost',

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $destinationPath,

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $uri,

        [String] $userAgent,

        [Hashtable] $headers
    )

    Import-DscResource -Name MSFT_xRemoteFile -ModuleName xPSDesiredStateConfiguration

    Node $nodeName
    {
        xRemoteFile DownloadFile
        {
            DestinationPath = $destinationPath
            Uri = $uri
            UserAgent = $userAgent
            Headers = $headers
        }
    }
}
```

- It's a good practice to include (commented out) example of how to call the configuration with the
  actual values at the end of the example script. For example, in the configuration above it isn't
  necessarily obvious that the best way to specify UserAgent is:

  `UserAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer`
  In which case a comment can clarify the intended execution of the configuration:

```powershell
<#
Sample use (parameter values need to be changed according to your scenario):

Sample_xRemoteFile_DownloadFile -destinationPath "$env:SystemDrive\fileName.jpg" -uri "http://www.contoso.com/image.jpg"

Sample_xRemoteFile_DownloadFile -destinationPath "$env:SystemDrive\fileName.jpg" -uri "http://www.contoso.com/image.jpg" `
-userAgent [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer -headers @{"Accept-Language" = "en-US"}
#>
```

- For each example, write a short description which explains what it does, and the meaning of the
  parameters.
- Make sure examples cover most the important scenarios for your resource and if there's nothing
  missing, verify that they all execute and put machine in the desired state.

## Error messages are easy to understand and help users solve problems

Good error messages should be:

- There: The biggest problem with error messages is that they often don't exist, so make sure they
  are there.
- Easy to understand: Human readable, no obscure error codes
- Precise: Describe what's exactly the problem
- Constructive: Advice how to fix the issue
- Polite: Don't blame user or make them feel bad

Make sure you verify errors in End to End scenarios (using `Start-DscConfiguration`), because they
may differ from those returned when running resource functions directly.

## Log messages are easy to understand and informative (including –verbose, –debug and ETW logs)

Ensure that logs outputted by the resource are easy to understand and provide value to the user.
Resources should output all information which might be helpful to the user, but more logs is not
always better. You should avoid redundancy and outputting data which does not provide additional
value – don't make someone go through hundreds of log entries in order to find what they're looking
for. Of course, no logs is not an acceptable solution for this problem either.

When testing, you should also analyze verbose and debug logs (by running `Start-DscConfiguration`
with `–Verbose` and `–Debug` switches appropriately), as well as ETW logs. To see DSC ETW logs, go
to Event Viewer and open the following folder: Applications and Services- Microsoft - Windows -
Desired State Configuration. By default there will be Operational channel, but make sure you enable
Analytic and Debug channels before running the configuration. To enable Analytic/Debug channels, you
can execute script below:

```powershell
$statusEnabled = $true
# Use "Analytic" to enable Analytic channel
$eventLogFullName = "Microsoft-Windows-Dsc/Debug"
$commandToExecute = "wevtutil set-log $eventLogFullName /e:$statusEnabled /q:$statusEnabled   "
$log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $eventLogFullName
if($statusEnabled -eq $log.IsEnabled)
{
    Write-Host -Verbose "The channel event log is already enabled"
    return
}
Invoke-Expression $commandToExecute
```

## Resource implementation does not contain hardcoded paths

Ensure there are no hardcoded paths in the resource implementation, particularly if they assume
language (en-us), or when there are system variables that can be used. If your resource need to
access specific paths, use environment variables instead of hardcoding the path, as it may differ on
other machines.

Example:

Instead of:

```powershell
$tempPath = "C:\Users\kkaczma\AppData\Local\Temp\MyResource"
$programFilesPath = "C:\Program Files (x86)"
```

You can write:

```powershell
$tempPath = Join-Path $env:temp "MyResource"
$programFilesPath = ${env:ProgramFiles(x86)}
```

## Resource implementation does not contain user information

Make sure there are no email names, account information, or names of people in the code.

## Resource was tested with valid/invalid credentials

If your resource takes a credential as parameter:

- Verify the resource works when Local System (or the computer account for remote resources) does
  not have access.
- Verify the resource works with a credential specified for Get, Set and Test
- If your resource accesses shares, test all the variants you need to support, such as:
  - Standard windows shares.
  - DFS shares.
  - SAMBA shares (if you want to support Linux.)

## Resource does not require interactive input

`Get/Set/Test-TargetResource` functions should be executed automatically and must not wait for
user's input at any stage of execution (e.g. you should not use `Get-Credential` inside these
functions). If you need to provide user's input, you should pass it to the configuration as
parameter during the compilation phase.

## Resource functionality was thoroughly tested

This checklist contains items which are important to be tested and/or are often missed. There will
be bunch of tests, mainly functional ones which will be specific to the resource you are testing and
are not mentioned here. Don't forget about negative test cases.

## Best practice: Resource module contains Tests folder with ResourceDesignerTests.ps1 script

It's a good practice to create folder "Tests" inside resource module, create
`ResourceDesignerTests.ps1` file and add tests using `Test-xDscResource` and `Test-xDscSchema`
for all resources in given module. This way you can quickly validate schemas of all resources from
the given modules and do a sanity check before publishing. For xRemoteFile, `ResourceTests.ps1`
could look as simple as:

```powershell
Test-xDscResource ..\DSCResources\MSFT_xRemoteFile
Test-xDscSchema ..\DSCResources\MSFT_xRemoteFile\MSFT_xRemoteFile.schema.mof
```

## Best practice: Resource supports -WhatIf

If your resource is performing "dangerous" operations, it's a good practice to implement `-WhatIf`
functionality. After it's done, make sure that `-WhatIf` output correctly describes operations which
would happen if command was executed without `-WhatIf` switch. Also, verify that operations does not
execute (no changes to the node's state are made) when `–WhatIf` switch is present. For example,
let's assume we are testing File resource. Below is simple configuration which creates file
`test.txt` with contents "test":

```powershell
configuration config
{
    node localhost
    {
        File file
        {
            Contents="test"
            DestinationPath="C:\test\test.txt"
        }
    }
}
config
```

If we compile and then execute the configuration with the `-WhatIf` switch, the output is telling us
exactly what would happen when we run the configuration. The configuration itself however was not
executed (`test.txt` file was not created).

```powershell
Start-DscConfiguration -Path .\config -ComputerName localhost -Wait -Verbose -WhatIf
```

```Output
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' =
SendConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' =
root/Microsoft/Windows/DesiredStateConfiguration'.
VERBOSE: An LCM method call arrived from computer CHARLESX1 with user sid
S-1-5-21-397955417-626881126-188441444-5179871.
What if: [X]: LCM:  [ Start  Set      ]
What if: [X]: LCM:  [ Start  Resource ]  [[File]file]
What if: [X]: LCM:  [ Start  Test     ]  [[File]file]
What if: [X]:                            [[File]file] The system cannot find the file specified.
What if: [X]:                            [[File]file] The related file/directory is: C:\test\test.txt.
What if: [X]: LCM:  [ End    Test     ]  [[File]file]  in 0.0270 seconds.
What if: [X]: LCM:  [ Start  Set      ]  [[File]file]
What if: [X]:                            [[File]file] The system cannot find the file specified.
What if: [X]:                            [[File]file] The related file/directory is: C:\test\test.txt.
What if: [X]:                            [C:\test\test.txt] Creating and writing contents and setting attributes.
What if: [X]: LCM:  [ End    Set      ]  [[File]file]  in 0.0180 seconds.
What if: [X]: LCM:  [ End    Resource ]  [[File]file]
What if: [X]: LCM:  [ End    Set      ]
VERBOSE: [X]: LCM:  [ End    Set      ]    in  0.1050 seconds.
VERBOSE: Operation 'Invoke CimMethod' complete.
```

This list is not exhaustive, but it covers many important issues which can be encountered while
designing, developing and testing DSC resources.
