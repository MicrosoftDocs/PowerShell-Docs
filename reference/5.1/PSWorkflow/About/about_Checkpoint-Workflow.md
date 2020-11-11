---
description: Describes the Checkpoint-Workflow activity, which takes a checkpoint in a workflow. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_checkpoint-workflow?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Checkpoint Workflow
---

# About Checkpoint-Workflow

## SHORT DESCRIPTION
Describes the Checkpoint-Workflow activity, which takes a checkpoint in a workflow.

## LONG DESCRIPTION

The Checkpoint-Workflow activity takes a checkpoint, which saves state and data in the workflow. If
the workflow is suspended or interrupted, it can be resumed from the most recent checkpoint, rather
than having to be restarted.

The Checkpoint-Workflow activity is valid only in a workflow.

### SYNTAX

```
Workflow <Verb-Noun>
{
    Checkpoint-Workflow
}
```

The Checkpoint-Workflow activity does not accept any parameters, including common parameters and
workflow common parameters.

You can place the Checkpoint-Activity checkpoint anywhere in a workflow after the CmdletBinding or
Param statement. However, when placing checkpoints, consider the performance cost of collecting the
data and writing it to disk on the computer that is running the workflow.

Be sure that the time it takes to rerun a section of the workflow if it is interrupted is greater
than the time it takes to write the checkpoint state and data to disk.

Consider taking checkpoints after critical steps so the workflow can be resumed rather than
restarted. For example, take a checkpoint after commands that are not idempotent.

### ABOUT CHECKPOINTS

A checkpoint is a snapshot of the current state of the workflow, including the current values of
variables, and any output generated up to that point, and it saves it to disk.

If a workflow is interrupted, intentionally or unintentionally, Windows PowerShell Workflow
automatically uses the data in newest checkpoint to recover and resume the workflow.

When you run the workflow as a job, such as by using the AsJob workflow common parameter, the
workflow checkpoints are retained until you delete the job, such as by using the Remove-Job cmdlet.
Otherwise, workflow checkpoints are deleted when the workflow completes.

### OTHER CHECKPOINTING TECHNIQUES

In addition to the Checkpoint-Workflow activity, Windows PowerShell Workflow supports other
checkpointing techniques, including the following:

- PSPersist workflow common parameter
- PSPersist activity common parameter
- PSPersistPreference variable (in a workflow)

For more information about adding a checkpoint to a workflow, see "How to Add Checkpoints to a
Workflow."

## EXAMPLES

The following workflow includes a call to the Checkpoint-Workflow activity after completing a
long-running function and a script that share data.

```powershell
Workflow Test-Workflow
{
    $a = Invoke-LongRunningFunction
    InlineScript { \\Server\Share\Get-DataPacks.ps1 $Using:a}
    Checkpoint-Workflow

    Invoke-LongRunningFunction
    {
        ...
    }
}
```

## SEE ALSO

[Writing a Windows PowerShell Workflow](/previous-versions/powershell/scripting/developer/workflow/writing-a-windows-powershell-workflow)
