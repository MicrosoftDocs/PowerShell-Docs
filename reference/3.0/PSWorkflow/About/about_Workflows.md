---
ms.date:  06/09/2017
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Workflows
---
# About Workflows

## SHORT DESCRIPTION

Provides a brief introduction to the Windows
PowerShell Workflow feature.

## LONG DESCRIPTION

Windows PowerShell Workflow brings the benefits of
Windows Workflow Foundation to Windows PowerShell
by enabling you to write and run workflows in Windows
PowerShell.

Windows PowerShell Workflow is introduced in Windows
PowerShell 3.0.

For detailed information about Windows PowerShell
Workflow, see ["Introducing Windows PowerShell Workflow"](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134242(v=ws.11))
and ["Writing a Windows PowerShell Workflow"](https://msdn.microsoft.com/en-us/library/hh852738(v=vs.85).aspx)

## ABOUT WORKFLOWS

Workflows are commands that consist of an ordered sequence of
related activities. Typically, they run for an extended period
of time, gathering data from and making changes to hundreds of
computers, often in heterogeneous environments.

Workflows can be written in XAML, the language used in Windows
Workflow Foundation, or in the Windows PowerShell language.
Workflows are typically packaged in modules and include help
topics.

Workflows are critical in an IT environment because they can
survive reboots and recover automatically from common failures.
You can disconnect and reconnect from sessions and computers
running workflows without interrupting workflow processing,
and suspend and resume workflows transparently without data
loss. Each activity in a workflow can be logged and audited
for reference. Workflow can run as jobs and can be scheduled
by using the Scheduled Jobs feature of Windows PowerShell.

The state and data in a workflow is saved or "persisted" at
the beginning and end of the workflow and at points that you
specify. Workflow persistence points work like database snapshots
or program checkpoints to protect the workflow from  the effects
of interruptions and failures. In the case of a failure from
which the workflow cannot recover, you can use  the persisted
data and resume from the last persistence point, instead of
rerunning an extensive workflow from the beginning.

## REQUIREMENTS AND CONFIGURATION

A Windows PowerShell Workflow configuration consists of
the following elements.

-- A client computer, which runs the workflow.
-- A workflow session (PSSession) on the client computer or
on a remote computer.
-- Managed nodes, the target computers that are affected by
the workflow activities.

## NOTE

The workflow session is not required, but is recommended.
PSSessions can take advantage of the robust recovery and
Disconnected Sessions features of Windows PowerShell to
recover disconnected workflow sessions.

Because the client computer and the computer on  which the
workflow session runs can be managed nodes, you can run a
workflow on a single computer that fulfills all roles.

The client computer and the computer on which the workflow
session runs must be running Windows PowerShell 3.0. All
eligible systems are supported, including the Server Core
installation options of Windows Server operating systems.

To run workflows that include cmdlets, the managed nodes
must have Windows PowerShell 2.0 or later. Managed nodes
do not require Windows PowerShell unless the workflow
include cmdlets. You can run workflows that include
Windows Management Instrumentation (WMI) and Common Information
Model (CIM) commands on computers that do not have Windows
PowerShell.

For more information about system requirements and configuration,
see "Introducing Windows PowerShell Workflow" in the TechNet Library
at http://go.microsoft.com/fwlink/?LinkID=252592.

## HOW TO GET WORKFLOWS

Workflows are typically packaged in modules. To import the module
that includes a workflow, use any command in the module or use the
Import-Module cmdlets. Modules are imported automatically on first
use of any command in the module.

To find the workflows in modules installed on your computer, use the
CommandType parameter of the Get-Command cmdlet.

PS C:> Get-Command -CommandType Workflow

## HOW TO RUN WORKFLOWS

To run a workflow, use the following procedure.

1. On the client computer, start Windows PowerShell with the
Run as administrator option.

PS C:> Start-Process PowerShell -Verb RunAs

This step is not required when the managed node is
the local computer.

2. Enable Windows PowerShell remoting on the computer on which
the workflow session runs and on managed nodes affected by
workflows that include cmdlets.

You need to do this step only once on each participating
computer.

This step is required only when running workflows that
include cmdlets. You do not need to enable remoting on
the client computer (unless the workflows session runs
on the client computer) or on any managed nodes that are
running Windows PowerShell 3.0.

To enable remoting, use the Enable-PSRemoting cmdlet.
[Enable-PSremoting](../../Microsoft.PowerShell.Core/Enable-PSRemoting.md)

You can also enable remoting by using the "Turn on Script
Execution" Group Policy setting. For more information, see
[about_Group_Policy_Settings](../../Microsoft.PowerShell.Core/About/about_Group_Policy_Settings.md)
and [about_Execution_Policies](../../Microsoft.PowerShell.Core/About/about_Execution_Policies.md).

3. Create the workflow session. Use the New-PSWorkflowSession
or New-PSSession cmdlets.

The New-PSWorkflowSession cmdlet starts a session that
uses the built-in Microsoft.PowerShell.Workflow session
configuration on the destination computer. This session
configuration includes scripts, type and formatting files,
and options that are designed for workflows.

For more, See:
[New-PSWorkflowSession](../New-PSWorkflowSession.md)

Or, use the New-PSSession cmdlet. Use the ConfigurationName parameter
to specify the Microsoft.PowerShell.Workflow session configuration.
This command is equivalent to using the New-PSWorkflowSession cmdlet.

If you are a member of the Administrators group on the workflow
session computer, you can also use the New-PSWorkflowExecutionOption
cmdlet to create custom option settings for the workflow session
configuration and use the Set-PSSessionConfiguration cmdlet to
change the session configuration.

```powershell
$sto = New-PSWorkflowExecutionOption -MaxConnectedSessions 150
Invoke-Command -ComputerName Server0 {Set-PSSessionConfiguration Microsoft.PowerShell.Workflo -SessionTypeOption $Using:sto}
$ws = New-PSWorkflowSession -ComputerName Server0 -Credential Domain01\Admin01
```

4. Run the workflow in the workflow session. To specify the
names of the managed nodes (target computers), use the
PSComputerName workflow common parameter.

The following commands run the Test-Workflow workflow.

For more information about the Using scope modifier, see
[about_Remote_Variables](../../Microsoft.PowerShell.Core/About/about_Remote_Variables.md)

```powershell
# On the current host
Invoke-Command -Session $ws {Test-Workflow}
```

```powershell
# On a remote machine
Invoke-Command -Session $ws{
Test-Workflow -PSComputerName Server01, Server02 }
```

```powershell
# Run Test-Workflow against all machines in servers.txt
$Servers = Get-Content Servers.txt
# Use the $Using scope modifier to retrieve the value from the current session.
Invoke-Command -Session $ws {Test-Workflow -PSComputerName $Using:Servers }
```

## USING WORKFLOW COMMON PARAMETERS

The workflow common parameters are a set of parameters that
Windows PowerShell adds automatically to all workflows.
Windows PowerShell also adds the cmdlet common parameters to
all workflows, even if the workflow do not use the CmdletBinding
attribute.

For example, the following very simple workflow defines no
parameters. However, when you run the workflow, it has both
the CommonParameters and WorkflowCommonParameters.

```powershell
workflow Test-Workflow {Get-Process}
Get-Command Test-Workflow -Syntax
```

```output
Test-Workflow [<WorkflowCommonParameters>] [<CommonParameters>]
```

## PsComputerName

The workflow common parameters include several parameters that
are essential to running workflows. For example, the PSComputerName
common parameter specifies the managed nodes that the workflow affects.

```powershell
Invoke-Command -Session $ws {Test-Workflow -PSComputerName Server01, Server02}
```

## PsPersist

The PSPersist workflow common parameter determines when workflow
data is persisted. It enables you to add persistence point between
activities to workflows that do not define persistence points.

```powershell
Invoke-Command -Session $ws {Test-Workflow -PSComputerName Server01, Server02 -PSPersist:$True}
```

## PsPort

Other workflow common parameters let you specify the
characteristics of the remote connection to the managed nodes.
Their names and functionality are very similar to the parameters
of remoting cmdlets, including Invoke-Command.

```powershell
Invoke-Command -Session $ws `{Test-Workflow -PSComputerName Server01, Server02 -PSPort 443}
```

## ConfigurationName vs PSConfigurationName

Take care to distinguish the remoting parameters that define the
connection for the workflow session from the PS-prefixed workflow
common parameters that define the connection to the managed nodes.

Some workflow common parameters are unique to workflows, such
as the PSParameterCollection parameter that lets you specify
different workflow common parameter values for different remote
nodes.

```powershell
$ws = New-PSSession -ComputerName Server01 -ConfigurationName Microsoft.PowerShell.Workflow
```

```powershell
Invoke-Command -Session $ws {Test-Workflow -PSComputerName Server01, Server02 -PSConfigurationName Microsoft.PowerShell.Workflow}
```

## SEE ALSO

[Invoke-AsWorkflow](../../PSWorkflowUtility/Invoke-AsWorkflow.md)

[New-PSWorkflowExecutionOption](../New-PSWorkflowExecutionOption.md)

[New-PSWorkflowSession](../New-PSWorkflowSession.md)

[about_WorkflowCommonParameters](about_WorkflowCommonParameters.md)

["Getting Started with Windows PowerShell Workflow"](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134242(v=ws.11))

["Writing a Windows PowerShell Workflow"](https://msdn.microsoft.com/en-us/library/hh852738(v=vs.85).aspx)