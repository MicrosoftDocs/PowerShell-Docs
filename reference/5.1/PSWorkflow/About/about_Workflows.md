---
description:  Provides a brief introduction to the PowerShell Workflow feature. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_workflows?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Workflows
---

# About Workflows

## Short description

Provides a brief introduction to the PowerShell Workflow feature.

## Long description

PowerShell Workflow brings the benefits of the
[Windows Workflow Foundation](/dotnet/framework/windows-workflow-foundation) to
PowerShell and enables you to write and run workflows.

PowerShell Workflow was introduced in PowerShell 3.0 and the module is
available up to PowerShell 5.1. For more information about PowerShell Workflow,
see the [Workflows Guide](/previous-versions/powershell/scripting/components/workflows-guide)
and [Writing a Windows PowerShell Workflow](/previous-versions/powershell/scripting/developer/workflow/writing-a-windows-powershell-workflow).

## About workflows

Workflows are commands that consist of an ordered sequence of related
activities. Typically, they run for an extended period of time, gathering data
from and making changes to hundreds of computers, often in heterogeneous
environments.

Workflows can be written in XAML, the language used in Windows Workflow
Foundation, or in the PowerShell language. Workflows are typically packaged in
modules and include help topics. For more information, see
[XAML Overview (WPF)](/dotnet/framework/wpf/advanced/xaml-overview-wpf).

Workflows are critical in an IT environment because they can survive reboots
and recover automatically from common failures. You can disconnect and
reconnect from sessions and computers running workflows without interrupting
workflow processing, and suspend and resume workflows transparently without
data loss. Each activity in a workflow can be logged and audited for reference.
Workflows can run as jobs and can be scheduled by using the Scheduled Jobs
feature of PowerShell.

The state and data in a workflow is saved or persisted at the beginning and end
of the workflow and at points that you specify. Workflow persistence points
work like database snapshots or program checkpoints to protect the workflow
from the effects of interruptions and failures. If the workflow is unable to
recover from a failure, you can use the persisted data and resume from the last
persistence point, instead of rerunning an extensive workflow from the
beginning.

## Workflow requirements and configuration

A PowerShell Workflow configuration consists of the following elements:

- A client computer, which runs the workflow.
- A workflow session, **PSSession**, on the client computer or on a remote
  computer.
- Managed nodes, the target computers that are affected by the workflow
  activities.

The workflow session isn't required, but is recommended. **PSSessions** can
take advantage of the robust recovery and Disconnected Sessions features of
PowerShell to recover disconnected workflow sessions. For more information, see
[about_Remote_Disconnected_Sessions](../../Microsoft.PowerShell.Core/About/about_Remote_Disconnected_Sessions.md)

Because the client computer and the computer on which the workflow session runs
can be managed nodes, you can run a workflow on a single computer that fulfills
all roles.

The client computer and the computer on which the workflow session runs must be
running PowerShell 3.0. All eligible systems are supported, including the
Server Core installation options of Windows Server operating systems.

To run workflows that include cmdlets, the managed nodes must have Windows
PowerShell 2.0 or later. Managed nodes don't require PowerShell unless the
workflow includes cmdlets. You can run workflows that include Windows
Management Instrumentation (WMI) and Common Information Model (CIM) commands on
computers that don't have PowerShell.

## How to get workflows

Workflows are typically packaged in modules. To import the module that includes
a workflow, use any command in the module or use the `Import-Module` cmdlet.
Modules are imported automatically on first use of any command in the module.

To find the workflows in modules installed on your computer, use the
`Get-Command` cmdlet's **CommandType** parameter.

```powershell
Get-Command -CommandType Workflow
```

## How to run workflows

To run a workflow, use the following procedure.

1. When the managed node is the local computer, this step isn't required.
   Otherwise, on the client computer, start PowerShell with the **Run as
   administrator** option.

   ```powershell
   Start-Process PowerShell -Verb RunAs
   ```

1. Enable PowerShell remoting on the computer that runs the workflow session
   and on managed nodes affected by workflows that include cmdlets.

   You only need to do this step once on each participating computer.

   This step is required only when running workflows that include cmdlets. You
   don't need to enable remoting on the client computer, unless the workflows
   session runs on the client computer, or on any managed nodes that are running
   PowerShell 3.0.

   To enable remoting, use the `Enable-PSRemoting` cmdlet.

   ```powershell
   Enable-PSRemoting -Force
   ```

   You can enable remoting by using the **Turn on Script Execution** Group Policy
   setting. For more information, see
   [about_Group_Policy_Settings](../../Microsoft.PowerShell.Core/About/about_Group_Policy_Settings.md)
   and
   [about_Execution_Policies](../../Microsoft.PowerShell.Core/About/about_Execution_Policies.md).

1. Use the `New-PSWorkflowSession` or `New-PSSession` cmdlets to create the
   workflow session.

   The `New-PSWorkflowSession` cmdlet starts a session that uses the built-in
   **Microsoft.PowerShell.Workflow** session configuration on the destination
   computer. This session configuration includes scripts, type and formatting
   files, and options that are designed for workflows.

   Or, use the `New-PSSession` cmdlet. Use the **ConfigurationName** parameter to
   specify the **Microsoft.PowerShell.Workflow** session configuration. This
   command is the same as using the `New-PSWorkflowSession` cmdlet.

   An alternative is to use the `New-PSSession` cmdlet. Use the
   **ConfigurationName** parameter to specify the
   **Microsoft.PowerShell.Workflow** session configuration.

   On the local computer:

   ```powershell
   $ws = New-PSWorkflowSession
   ```

   On a remote computer:

   ```powershell
   $ws = New-PSWorkflowSession -ComputerName Server01 `
   -Credential Domain01\Admin01
   ```

   If you are an Administrator on the workflow session computer, you can use the
   `New-PSWorkflowExecutionOption` cmdlet to create custom option settings for the
   workflow session configuration. And, use the `Set-PSSessionConfiguration`
   cmdlet to change the session configuration.

   ```powershell
   $sto = New-PSWorkflowExecutionOption -MaxConnectedSessions 150
   Invoke-Command -ComputerName Server01 `
   {Set-PSSessionConfiguration Microsoft.PowerShell.Workflow `
   -SessionTypeOption $Using:sto}
   $ws = New-PSWorkflowSession -ComputerName Server01 `
   -Credential Domain01\Admin01
   ```

1. Run the workflow in the workflow session. To specify the names of the
   managed nodes, target computers, use the **PSComputerName** workflow common
   parameter.

   The following examples run the workflow named **Test-Workflow**.

   Where the managed node is the computer that hosts the workflow session:

   ```powershell
   Invoke-Command -Session $ws {Test-Workflow}
   ```

   Where the managed nodes are remote computers.

   ```powershell
   Invoke-Command -Session $ws{
   Test-Workflow -PSComputerName Server01, Server02 }
   ```

   The following example runs the **Test-Workflow** on hundreds of computers. The
   `Get-Content` cmdlet gets the computer names from a text file and saves them in
   the `$Servers` variable on the local computer.

   `Invoke-Command` uses the `$Using` scope modifier to define the `$Servers`
   variable in the local session. For more information about the `$Using` scope
   modifier, see
   [about_Remote_Variables](../../Microsoft.PowerShell.Core/About/about_Remote_Variables.md).

   ```powershell
   $Servers = Get-Content Servers.txt
   Invoke-Command -Session $ws {Test-Workflow -PSComputerName $Using:Servers }
   ```

## Using workflow common parameters

The workflow common parameters are a set of parameters that PowerShell adds
automatically to all workflows. PowerShell adds the cmdlet common parameters to
all workflows, even if the workflow doesn't use the **CmdletBinding**
attribute.

For example, the following workflow defines no parameters. However, when you
run the workflow, it has both the **CommonParameters** and
**WorkflowCommonParameters**.

```powershell
workflow Test-Workflow {Get-Process}
Get-Command Test-Workflow -Syntax
```

```powershell
Test-Workflow [<WorkflowCommonParameters>] [<CommonParameters>]
```

The workflow common parameters include several parameters that are essential to
running workflows. For example, the **PSComputerName** common parameter
specifies the managed nodes that the workflow affects.

```powershell
Invoke-Command -Session $ws {
  Test-Workflow -PSComputerName Server01, Server02
}
```

The **PSPersist** workflow common parameter determines when workflow data is
persisted. It enables you to add persistence point between activities to
workflows that don't define persistence points.

```powershell
Invoke-Command -Session $ws {
  Test-Workflow -PSComputerName Server01, Server02 -PSPersist:$True
}
```

Other workflow common parameters let you specify the characteristics of the
remote connection to the managed nodes. Their names and functionality are
similar to the parameters of remoting cmdlets, including `Invoke-Command`.

```powershell
Invoke-Command -Session $ws {
  Test-Workflow -PSComputerName Server01, Server02 -PSPort 443
}
```

Take care to distinguish the remoting parameters that define the connection for
the workflow session from the **PS-prefixed** workflow common parameters that
define the connection to the managed nodes.

```powershell
$ws = New-PSSession -ComputerName Server01 -ConfigurationName Microsoft.PowerShell.Workflow

Invoke-Command -Session $ws {
  Test-Workflow -PSComputerName Server01, Server02 -PSConfigurationName Microsoft.PowerShell.Workflow
}
```

Some workflow common parameters are unique to workflows, such as the
**PSParameterCollection** parameter that lets you specify different workflow
common parameter values for different remote nodes. For a list and description
of the workflow common parameters, see
[about_WorkflowCommonParameters](about_WorkflowCommonParameters.md).

## See also

[Invoke-AsWorkflow](xref:PSWorkflowUtility.Invoke-AsWorkflow)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

[PSWorkflow](xref:PSWorkflow) cmdlets

[Workflows Guide](/previous-versions/powershell/scripting/components/workflows-guide)

[Writing a Windows PowerShell Workflow](/previous-versions/powershell/scripting/developer/workflow/writing-a-windows-powershell-workflow)
