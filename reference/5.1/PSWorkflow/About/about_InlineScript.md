---
description:  Describes the `InlineScript` activity, that runs PowerShell commands in a workflow. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_inlinescript?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_InlineScript
---

# About InlineScript

## Short description

Describes the `InlineScript` activity, that runs PowerShell commands in a
workflow.

## Long description

The `InlineScript` activity runs commands in a shared PowerShell session's
workflow. `InlineScript` is only valid in workflows.

## Syntax

```
InlineScript {<script block>} <ActivityCommonParameters>
```

## Detailed description

The `InlineScript` activity runs commands in a shared PowerShell session. You
can include it in a workflow to run commands that share data and commands that
aren't otherwise valid in a workflow.

The `InlineScript` script block can include all valid PowerShell commands and
expressions. Because the commands and expressions in an `InlineScript` script
block run in the same session, they share all state and data, including
imported modules and the values of variables.

You can place an `InlineScript` activity anywhere in a workflow or nested
workflow, including inside a loop or control statement or a Parallel or
Sequence script block.

The `InlineScript` activity has the activity common parameters, including
**PSPersist**. However, the commands and expressions in an `InlineScript`
script block don't have the workflow features such as checkpointing, or
persistence, and workflow or activity common parameters. For more information,
see [about_ActivityCommonParameters](about_ActivityCommonParameters.md).

## InlineScript Variables

By default, the variables that are defined in a workflow aren't visible to the
commands in the `InlineScript` script block. To make workflow variables visible
to the `InlineScript`, use the `$Using` scope modifier. The `$Using` scope
modifier is required only once for each variable in the `InlineScript`.

For more information about the `$Using` scope modifier, see
[about_Remote_Variables](../../Microsoft.PowerShell.Core/About/about_Remote_Variables.md).

The following example shows that the `$Using` scope modifier makes the value of
the `$a` top-level workflow variable available to the commands in the
`InlineScript` script block.

```powershell
workflow Test-Workflow {
  $a = 3

  ## Without $Using, the $a workflow variable isn't visible
  ## in inline script.
  InlineScript {"Inline A0 = $a"}

  ## $Using imports the variable and its current value.
  InlineScript {"Inline A1 = $Using:a"}
}

Test-Workflow
```

```output
Inline A0 =
Inline A1 = 3
```

## Returning variables in InlineScript

`InlineScript` commands can change the value of the variable that was imported
from workflow scope, but the changes aren't visible in workflow scope. To make
them visible, return the changed value to the workflow scope, as shown in the
following example.

```powershell
workflow Test-Workflow {
  $a = 3

  ##  Changes to the InlineScript variable value don't
  ##  change the workflow variable.
  InlineScript {
    $a = $Using:a+1;
    "Inline A = $a"
  }
  "Workflow A = $a"

  ##  To change the variable in workflow scope, return the
  ##  new value.
  $a = InlineScript {$b = $Using:a+1; $b}
  "Workflow New A = $a"
}

Test-Workflow
```

```output
Inline A = 4
Workflow A = 3
Workflow New A = 4
```

> [!NOTE]
> A statement with the `$Using` scope modifier should appear before any use of
> the variable in the `InlineScript` script block.

## Running in-process

To improve reliability, the commands in the `InlineScript` script block run in
their own process, separate from the process in which the workflow runs, and
then return their output to the workflow process.

To direct PowerShell to run the `InlineScript` activity in the workflow
process, remove the `InlineScript` value from the **OutOfProcessActivity**
property of the session configuration, such as by using the
`New-PSWorkflowExecutionOption` cmdlet.

### Example

The `InlineScript` in the following workflow includes commands that are valid
in PowerShell but aren't valid in workflows. For example, the `New-Object`
cmdlet with the **ComObject** parameter.

```powershell
workflow Test-Workflow
{
  $ie = InlineScript {
    $ie = New-Object -ComObject InternetExplorer.Application -Property @{navigate2="www.microsoft.com"}

    $ie.Visible = $true
  }

  $ie
}

Test-Workflow
```

## See also

[about_ActivityCommonParameters](about_ActivityCommonParameters.md)

[about_Remote_Variables](../../Microsoft.PowerShell.Core/About/about_Remote_Variables.md)

[about_WorkflowCommonParameters](about_WorkflowCommonParameters.md)

[PSWorkflow](xref:PSWorkflow) cmdlets

[Workflows Guide](/previous-versions/powershell/scripting/components/workflows-guide)

[Writing a Windows PowerShell Workflow](/previous-versions/powershell/scripting/developer/workflow/writing-a-windows-powershell-workflow)
