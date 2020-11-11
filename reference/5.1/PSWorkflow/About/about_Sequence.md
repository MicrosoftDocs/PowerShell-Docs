---
description:  Describes the `Sequence` keyword that runs selected activities sequentially. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_sequence?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Sequence
---

# About Sequence

## Short description

Describes the `Sequence` keyword that runs selected activities sequentially.

## Long description

The `Sequence` keyword runs selected workflow activities sequentially. Workflow
activities run in the order that they appear and do not run concurrently. The
`Sequence` keyword is only valid in a PowerShell Workflow.

The `Sequence` keyword is used in a `Parallel` script block to run selected
commands sequentially.

Because workflow activities run sequentially by default, the `Sequence` keyword
is only effective in a `Parallel` script block. If the `Sequence` keyword isn't
included in a `Parallel` script block, it's valid but ineffective.

The `Sequence` script block lets you run more commands in parallel by allowing
you to run dependent commands sequentially.

## Syntax

### Workflow using Sequence

```
workflow <Verb-Noun>
{
    Sequence
    {
        [<Activity>]
        [<Activity>]
        # ...
    }
}
```

### Workflow using Parallel and Sequence

```
workflow <Verb-Noun>
{
    Parallel
    {
        [<Activity>]
        Sequence
        {
            [<Activity>]
            [<Activity>]
            # ...
        }
    }
}
```

## Detailed description

The commands in a `Parallel` script block can run concurrently. The order in
which they run is not determined. This feature improves the performance of a
script workflow.

You can use a `Sequence` script block to run selected activities sequentially,
even though the activities appear in a `Parallel` script block.

The activities in a `Sequence` script block run consecutively in the order that
they are listed. An activity in a `Sequence` script block starts only after the
previous activity completes.

However, when the `Sequence` script block appears in a `Parallel` script block,
the order in which the `Sequence` script block runs isn't determined. It might
run before, after, or concurrent with other activities in the `Parallel` script
block.

For example, the following workflow includes a `Parallel` script block that
runs activities that get processes and services on the computer. The `Parallel`
script block contains a `Sequence` script block that gets information from a
file and uses the information as input to a script.

The `Get-Process`, `Get-Service`, and hotfix-related commands are independent
of each other. The commands can run concurrently or in any order. But, the
command that gets the hotfix information must run before the command that uses
it.

```powershell
workflow Test-Workflow
{
    Parallel
    {
    Get-Process
    Get-Service

    Sequence
    {
        $Hotfix = Get-Content 'D:\HotFixes\Required.txt'
        Foreach ($h in $Hotfix) {'D:\Scripts\Verify-Hotfix' -Hotfix $h}
        }
    }
}
```

## See also

[about_ForEach](../../Microsoft.PowerShell.Core/About/about_Foreach.md)

[about_ForEach-Parallel](about_ForEach-Parallel.md)

[about_Language_Keywords](../../Microsoft.PowerShell.Core/About/about_Language_Keywords.md)

[about_Parallel](about_Parallel.md)

[about_Workflows](about_Workflows.md)

[Creating a Workflow by Using a Windows PowerShell Script](/previous-versions/powershell/scripting/developer/workflow/creating-a-workflow-by-using-a-windows-powershell-script)
