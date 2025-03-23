---
description: Describes the `sequence` keyword that runs selected activities sequentially.
Locale: en-US
ms.date: 06/09/2017
online version: https://learn.microsoft.com/powershell/module/psworkflow/about/about_sequence?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Sequence
---

# about_Sequence

## Short description

Describes the `sequence` keyword that runs selected activities sequentially.

## Long description

The `sequence` keyword runs selected workflow activities sequentially. Workflow
activities run in the order that they appear and do not run concurrently. The
`sequence` keyword is only valid in a PowerShell Workflow.

The `sequence` keyword is used in a `parallel` script block to run selected
commands sequentially.

Because workflow activities run sequentially by default, the `sequence` keyword
is only effective in a `parallel` script block. If the `sequence` keyword isn't
included in a `parallel` script block, it's valid but ineffective.

The `sequence` script block lets you run more commands in parallel by allowing
you to run dependent commands sequentially.

## Syntax

### Workflow using `sequence`

```
workflow <Verb-Noun>
{
    sequence
    {
        [<Activity>]
        [<Activity>]
        # ...
    }
}
```

### Workflow using `parallel` and `sequence`

```
workflow <Verb-Noun>
{
    parallel
    {
        [<Activity>]
        sequence
        {
            [<Activity>]
            [<Activity>]
            # ...
        }
    }
}
```

## Detailed description

The commands in a `parallel` script block can run concurrently. The order in
which they run is not determined. This feature improves the performance of a
script workflow.

You can use a `sequence` script block to run selected activities sequentially,
even though the activities appear in a `parallel` script block.

The activities in a `sequence` script block run consecutively in the order that
they are listed. An activity in a `sequence` script block starts only after the
previous activity completes.

However, when the `sequence` script block appears in a `parallel` script block,
the order in which the `sequence` script block runs isn't determined. It might
run before, after, or concurrent with other activities in the `parallel` script
block.

For example, the following workflow includes a `parallel` script block that
runs activities that get processes and services on the computer. The `parallel`
script block contains a `sequence` script block that gets information from a
file and uses the information as input to a script.

The `Get-Process`, `Get-Service`, and hotfix-related commands are independent
of each other. The commands can run concurrently or in any order. But, the
command that gets the hotfix information must run before the command that uses
it.

```powershell
workflow Test-Workflow
{
    parallel
    {
    Get-Process
    Get-Service

    sequence
    {
        $Hotfix = Get-Content 'D:\HotFixes\Required.txt'
        foreach ($h in $Hotfix) {'D:\Scripts\Verify-Hotfix' -Hotfix $h}
        }
    }
}
```

## See also

- [about_Foreach](../../Microsoft.PowerShell.Core/About/about_Foreach.md)
- [about_Foreach-Parallel](about_Foreach-Parallel.md)
- [about_Language_Keywords](../../Microsoft.PowerShell.Core/About/about_Language_Keywords.md)
- [about_Parallel](about_Parallel.md)
- [about_Workflows](about_Workflows.md)
- [Creating a Workflow by Using a Windows PowerShell Script](/previous-versions/powershell/scripting/developer/workflow/creating-a-workflow-by-using-a-windows-powershell-script)
