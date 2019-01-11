---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_InlineScript
---

# About InlineScript

# SHORT DESCRIPTION

Describes the InlineScript activity, which runs Windows
PowerShell commands in a workflow.

# LONG DESCRIPTION

The InlineScript activity runs commands in a shared
Windows PowerShell session in a workflow. This activity
is valid only in workflows.

# SYNTAX

InlineScript {\<script block\>} \<ActivityCommonParameters\>

# DETAILED DESCRIPTION

The InlineScript activity runs commands in a shared
Windows PowerShell session. You can include it in a
workflow to run commands that share data and commands
that are not otherwise valid in a workflow.

The InlineScript script block can include all valid
Windows PowerShell commands and expressions. Because the
commands and expressions in an InlineScript script block
run in the same session, they share all state and data,
including imported modules and the values of variables.

You can place an InlineScript activity anywhere in a workflow
or nested workflow, including inside a loop or control
statement or a Parallel or Sequence script block.

The InlineScript activity has the activity common parameters,
including PSPersist. However, the commands and expressions in
an InlineScript script block do not have the workflow features
such as checkpointing ("persistence) and workflow or activity
common parameters.

# VARIABLES IN INLINESCRIPT

By default, the variables that are defined in a workflow are
not visible to the commands in the InlineScript script block.
To make workflow variables visible to the InlineScript, use the
$Using scope modifier. The $Using scope modifier is required
only once for each variable in the InlineScript.

The following example shows that the $Using scope modifier
makes the value of the $a top-level workflow variable available
to the commands in the InlineScript script block.

```powershell
workflow Test-Workflow {
  $a = 3

  ## Without $Using, the $a workflow variable is not visible
  ## in inline script.
  InlineScript {"Inline A0 = $a"}

  ## $Using imports the variable and its current value.
  InlineScript {"Inline A1 = $Using:a"}
}

Test-Workflow
```

```output
PS C:> Test-Workflow
Inline A0 =
Inline A1 = 3
```

InlineScript commands can change the value of the variable
that was imported from workflow scope, but the changes are
not visible in workflow scope. To make them visible, return
the changed value to the workflow scope, as shown in the
following example.

```powershell
workflow Test-Workflow {
  $a = 3

  ##  Changes to the InlineScript variable value do not
  ##  change the workflow variable.
  InlineScript {
    $a = $using:a+1;
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
PS C:> test-workflow
Inline A = 4
Workflow A = 3
Workflow New A = 4
```

Troubleshooting Note:  A statement with the $Using scope modifier
should appear before any use of the variable in the InlineScript
script block.

# RUNNING IN-PROCESS

To improve reliability, the commands in the InlineScript script
block run in their own process, outside of the  process in which
the workflow runs, and then return their output to the workflow
process.

To direct Windows PowerShell to run the InlineScript activity in
the workflow process, remove the InlineScript value from the
OutOfProcessActivity property of the session configuration,
such as by using the New-PSWorkflowExecutionOption cmdlet.

# EXAMPLES

The InlineScript in the following workflow includes commands
that are not valid in workflows, including the use of the
New-Object cmdlet with the ComObject parameter.

```powershell
workflow Test-Workflow
{
  $ie = InlineScript {
    $ie = New-Object -ComObject InternetExplorer.Application -property @{navigate2="www.microsoft.com"}

    $ie.Visible = $true
  }

  $ie
}

Test-Workflow
```