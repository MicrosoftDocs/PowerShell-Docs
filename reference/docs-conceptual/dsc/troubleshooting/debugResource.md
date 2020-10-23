---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Debugging DSC resources
description: This article shows you how to enable debugging for DSC configurations.
---

# Debugging DSC resources

> Applies To: Windows PowerShell 5.0

In PowerShell 5.0, a new feature was introduced in Desired State Configuration (DSC) that allows you
to debug a DSC resource as a configuration is being applied.

## Enabling DSC debugging

Before you can debug a resource, you have to enable debugging by calling the
[Enable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Enable-DscDebug) cmdlet. This
cmdlet takes a mandatory parameter, **BreakAll**.

You can verify that debugging has been enabled by looking at the result of a call to
[Get-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Get-DscLocalConfigurationManager).

The following PowerShell output shows the result of enabling debugging:

```powershell
PS C:\DebugTest> $LCM = Get-DscLocalConfigurationManager

PS C:\DebugTest> $LCM.DebugMode
NONE

PS C:\DebugTest> Enable-DscDebug -BreakAll

PS C:\DebugTest> $LCM = Get-DscLocalConfigurationManager

PS C:\DebugTest> $LCM.DebugMode
ForceModuleImport
ResourceScriptBreakAll

PS C:\DebugTest>
```

## Starting a configuration with debug enabled

To debug a DSC resource, you start a configuration that calls that resource. For this example, we'll
look at a simple configuration that calls the **WindowsFeature** resource to ensure that the
"WindowsPowerShellWebAccess" feature is installed:

```powershell
Configuration PSWebAccess
    {
    Import-DscResource -ModuleName 'PsDesiredStateConfiguration'
    Node localhost
        {
        WindowsFeature PSWA
            {
            Name = 'WindowsPowerShellWebAccess'
            Ensure = 'Present'
            }
        }
    }
PSWebAccess
```

After compiling the configuration, start it by calling
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration). The
configuration will stop when the Local Configuration Manager (LCM) calls into the first resource in
the configuration. If you use the `-Verbose` and `-Wait` parameters, the output displays the lines
you need to enter to start debugging.

```powershell
Start-DscConfiguration .\PSWebAccess -Wait -Verbose
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' = SendConfigurationApply,'className' = MSFT_DSCLocalConfiguration
Manager,'namespaceName' = root/Microsoft/Windows/DesiredStateConfiguration'.
VERBOSE: An LCM method call arrived from computer TEST-SRV with user sid S-1-5-21-2127521184-1604012920-1887927527-108583.
VERBOSE: An LCM method call arrived from computer TEST-SRV with user sid S-1-5-21-2127521184-1604012920-1887927527-108583.
VERBOSE: [TEST-SRV]: LCM:  [ Start  Set      ]
WARNING: [TEST-SRV]:                            [DSCEngine] Warning LCM is in Debug 'ResourceScriptBreakAll' mode.  Resource script processing will
be stopped to wait for PowerShell script debugger to attach.
VERBOSE: [TEST-SRV]:                            [DSCEngine] Importing the module C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\PSDesiredStateCo
nfiguration\DscResources\MSFT_RoleResource\MSFT_RoleResource.psm1 in force mode.
VERBOSE: [TEST-SRV]: LCM:  [ Start  Resource ]  [[WindowsFeature]PSWA]
VERBOSE: [TEST-SRV]: LCM:  [ Start  Test     ]  [[WindowsFeature]PSWA]
VERBOSE: [TEST-SRV]:                            [[WindowsFeature]PSWA] Importing the module MSFT_RoleResource in force mode.
WARNING: [TEST-SRV]:                            [[WindowsFeature]PSWA] Resource is waiting for PowerShell script debugger to attach.
Use the following commands to begin debugging this resource script:
Enter-PSSession -ComputerName TEST-SRV -Credential <credentials>
Enter-PSHostProcess -Id 9000 -AppDomainName DscPsPluginWkr_AppDomain
Debug-Runspace -Id 9
```

At this point, the LCM has called the resource, and come to the first break point. The last three
lines in the output show you how to attach to the process and start debugging the resource script.

## Debugging the resource script

Start a new instance of the PowerShell ISE. In the console pane, enter the last three lines of
output from the `Start-DscConfiguration` output as commands, replacing `<credentials>` with valid
user credentials. You should now see a prompt that looks similar to:

```powershell
[TEST-SRV]: [DBG]: [Process:9000]: [RemoteHost]: PS C:\DebugTest>>
```

The resource script will open in the script pane, and the debugger is stopped at the first line of
the **Test-TargetResource** function (the **Test()** method of a class-based resource). Now you can
use the debug commands in the ISE to step through the resource script, look at variable values, view
the call stack, and so on. Remember that every line in the resource script (or class) is set as a
break point.

## Disabling DSC debugging

After calling [Enable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Enable-DscDebug), all
calls to
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration) will
result in the configuration breaking into the debugger. To allow configurations to run normally, you
must disable debugging by calling the
[Disable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Disable-DscDebug) cmdlet.

> [!NOTE]
> Rebooting does not change the debug state of the LCM. If debugging is enabled, starting a
> configuration will still break into the debugger after a reboot.

## See Also

- [Writing a custom DSC resource with MOF](../resources/authoringResourceMOF.md)
- [Writing a custom DSC resource with PowerShell classes](../resources/authoringResourceClass.md)
