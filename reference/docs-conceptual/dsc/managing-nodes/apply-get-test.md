---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Apply, Get, and Test Configurations on a Node
description: This guide will show you how to work with Configurations on a target Node.
---

# Apply, Get, and Test Configurations on a Node

This guide will show you how to work with Configurations on a target Node. This guide is broken up
into the following steps:

## Apply a Configuration

In order to apply and manage a Configuration, we need to generate a ".mof" file. The following code
will represent a simple Configuration that will be used throughout this guide.

```powershell
Configuration Sample
{
    # This will generate two .mof files, a localhost.mof, and a server02.mof
    Node localhost, server02
    {
        File SampleFile
        {
            DestinationPath = 'C:\Temp\temp.txt'
            Contents = 'This is a simple resource to show Configuration functionality on a Node.'
        }
    }
}

# The -OutputPath parameter is built into every Configuration automatically.
# The value of -OutputPath determines where the .mof file should be stored, once compiled.
Sample -OutputPath "C:\Temp\"
```

Compiling this configuration will yield two ".mof" files.

```Output
Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a----       11/27/2018   7:29 AM     2.13KB localhost.mof
-a----       11/27/2018   7:29 AM     2.13KB server02.mof
```

To apply a Configuration, use the
[Start-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
cmdlet. The `-Path` parameter specifies a directory where ".mof" files reside. If no `-Computername`
is specified, `Start-DSCConfiguration` will attempt to apply each Configuration to the computer name
specified by the name of the '.mof' file (`<computername>.mof`). Specify `-Verbose` to
`Start-DSCConfiguration` to see more verbose output.

```powershell
Start-DSCConfiguration -Path C:\Temp\ -Verbose
```

If `-Wait` is not specified, you see one job created. The job created will have one **ChildJob** for
each ".mof" file processed by `Start-DSCConfiguration`.

```Output
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
45     Job45           Configuratio... Running       True            localhost,server02   Start-DSCConfiguration...
```

If a Configuration is taking a long time and you want to stop it, you can use
[Stop-DSCConfiguration](/powershell/module/PSDesiredStateConfiguration/Stop-DscConfiguration) to
stop application on the local Node.

```powershell
Stop-DSCConfiguration -Force
```

Once complete, you can view the status of the jobs through the job object returned by
[Get-Job](/powershell/module/microsoft.powershell.core/get-job).

```powershell
$job = Get-Job
$job.ChildJobs
```

```Output
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
49     Job49           Configuratio... Completed     True            localhost            Start-DSCConfiguration...
50     Job50           Configuratio... Completed     True            server02             Start-DSCConfiguration...
```

To see the **Verbose** output, use the following commands to view the **Verbose** stream for each
**ChildJob**. For more about PowerShell jobs, see
[about_Jobs](/powershell/module/microsoft.powershell.core/about/about_jobs).

```powershell
# View the verbose output of the localhost job using array indexing.
$job.ChildJobs[0].Verbose
```

```Output
Perform operation 'Invoke CimMethod' with following parameters, ''methodName' = SendConfigurationApply,
'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' = root/Microsoft/Windows/DesiredStateConfiguration'.
An LCM method call arrived from computer SERVER01 with user sid S-1-5-21-124525095-708259637-1543119021-1282804.
[SERVER01]: LCM:  [ Start  Set      ]
[SERVER01]: LCM:  [ Start  Resource ]  [[File]SampleFile]
[SERVER01]: LCM:  [ Start  Test     ]  [[File]SampleFile]
[SERVER01]:                            [[File]SampleFile] The destination object was found and no action is required.
[SERVER01]: LCM:  [ End    Test     ]  [[File]SampleFile]  in 0.0370 seconds.
[SERVER01]: LCM:  [ Skip   Set      ]  [[File]SampleFile]
[SERVER01]: LCM:  [ End    Resource ]  [[File]SampleFile]
[SERVER01]: LCM:  [ End    Set      ]
[SERVER01]: LCM:  [ End    Set      ]    in  0.2400 seconds.
Operation 'Invoke CimMethod' complete.
```

Beginning in PowerShell 5.0, the `-UseExisting` parameter was added to `Start-DSCConfiguration`. By
specifying `-UseExisting`, you instruct the cmdlet to use the existing applied Configuration instead
of one specified by the `-Path` parameter.

```powershell
Start-DSCConfiguration -UseExisting -Verbose -Wait
```

## Test a Configuration

You can test a currently applied Configuration using
[Test-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/Test-DSCConfiguration).
`Test-DSCConfiguration` will return `True` if the Node is compliant, and `False` if it is not.

```powershell
Test-DSCConfiguration
```

Beginning in PowerShell 5.0, the `-Detailed` parameter was added which returns an object with
collections for **ResourcesInDesiredState** and **ResourcesNotInDesiredState**

```powershell
Test-DSCConfiguration -Detailed
```

Beginning in PowerShell 5.0 you can test a Configuration without applying it. The
`-ReferenceConfiguration` parameter accepts the path of a ".mof" file to test the Node against. No
**Set** actions are taken against the Node. In PowerShell 4.0, there are workarounds to test a
Configuration without applying it, but they are not discussed here.

## Get Configuration Values

The [Get-DSCConfiguration](/powershell/module/PSDesiredStateConfiguration/Get-DscConfiguration)
cmdlet returns the current values for any configured resources in the currently applied
Configuration.

```powershell
Get-DSCConfiguration
```

Output from our sample Configuration would look like this if applied successfully.

```Output
ConfigurationName    : Sample
DependsOn            :
ModuleName           : PSDesiredStateConfiguration
ModuleVersion        :
PsDscRunAsCredential :
ResourceId           : [File]SampleFile
SourceInfo           :
Attributes           : {archive}
Checksum             :
Contents             :
CreatedDate          : 11/27/2018 7:16:06 AM
Credential           :
DestinationPath      : C:\Temp\temp.txt
Ensure               : present
Force                :
MatchSource          :
ModifiedDate         : 11/27/2018 7:16:06 AM
Recurse              :
Size                 : 75
SourcePath           :
SubItems             :
Type                 : file
PSComputerName       :
CimClassName         : MSFT_FileDirectoryConfiguration
```

## Get Configuration Status

Beginning in PowerShell 5.0 the
[Get-DSCConfigurationStatus](/powershell/module/PSDesiredStateConfiguration/Get-DscConfigurationStatus)
cmdlet allows you to see the history of applied Configurations to the node. PowerShell DSC keeps
track of the last {{N}} Configurations applied in **Push** or **Pull** mode. This includes any
*consistency* checks executed by the LCM. By default, `Get-DSCConfigurationStatus` shows you the
last history entry only.

```powershell
Get-DSCConfigurationStatus
```

```Output
Status     StartDate                 Type            Mode  RebootRequested      NumberOfResources
------     ---------                 ----            ----  ---------------      -----------------
Success    11/27/2018 7:18:40 AM     Consistency     PUSH  False                1
```

Use the `-All` parameter to see all Configuration Status history.

> [!NOTE]
> Output is truncated for brevity.

```powershell
Get-DSCConfigurationStatus -All
```

```Output
Status     StartDate                 Type            Mode  RebootRequested      NumberOfResources
------     ---------                 ----            ----  ---------------      -----------------
Success    11/27/2018 7:18:40 AM     Consistency     PUSH  False                1
Success    11/27/2018 7:16:06 AM     Initial         PUSH  False                1
Success    11/27/2018 7:04:53 AM     Initial         PUSH  False                1
Success    11/27/2018 7:03:45 AM     Consistency     PUSH  False                2
Success    11/27/2018 7:03:40 AM     Consistency     PUSH  False                2
Success    11/27/2018 6:48:40 AM     Consistency     PUSH  False                2
Success    11/27/2018 6:33:44 AM     Consistency     PUSH  False                2
Success    11/27/2018 6:33:40 AM     Consistency     PUSH  False                2
Success    11/27/2018 6:18:40 AM     Consistency     PUSH  False                2
Success    11/27/2018 6:03:44 AM     Consistency     PUSH  False                2
```

## Manage Configuration Documents

The LCM manages the Configuration of the Node by working with **Configuration Documents**. These
".mof" files reside in the `C:\Windows\System32\Configuration` directory.

Beginning in PowerShell 5.0 the
[Remove-DSCConfigurationDocument](/powershell/module/PSDesiredStateConfiguration/Remove-DscConfigurationDocument)
allows you to remove the ".mof" files to stop future consistency checks or remove a Configuration
that has errors when applied. The `-Stage` parameter allows you to specify which ".mof" file you
want to remove.

```powershell
Remove-DSCConfigurationDocument -Stage Current
```

> [!NOTE]
> In PowerShell 4.0, you can still remove these ".mof" files directly using
> [Remove-Item](/powershell/module/microsoft.powershell.management/remove-item).

## Publish Configurations

Beginning in PowerShell 5.0, the
[Publish-DSCConfiguration](/powershell/module/PSDesiredStateConfiguration/Publish-DscConfiguration)
cmdlet was added. This cmdlet allows you to publish a ".mof" file to remote computers, without
applying it.

```powershell
Publish-DscConfiguration -Path '$home\WebServer' -ComputerName "ContosoWebServer" -Credential (get-credential Contoso\webadministrator)
```

## See also

- [Get, Test, and Set](../resources/get-test-set.md)
