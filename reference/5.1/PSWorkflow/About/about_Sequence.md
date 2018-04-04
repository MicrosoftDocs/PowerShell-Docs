---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Sequence
---

# About Sequence
## about_Sequence


# SHORT DESCRIPTION

Describes the Sequence keyword, which runs selected
activities sequentially.

# LONG DESCRIPTION

The Sequence keyword runs selected workflow activities
sequentially, that is, they run in the order in which
they appear and do not run concurrently. The Sequence
keyword is valid only in a Windows PowerShell Workflow.

The Sequence keyword is typically used in a Parallel
script block to run selected commands sequentially.

Because workflow activities run sequentially by default,
the Sequence keyword effective only in a Parallel
script block. However, it valid outside of a Parallel
script block, even if it has no effect.

The Sequence script block lets you run more commands
in parallel by allowing you to run dependent commands
sequentially.

# SYNTAX


workflow <Verb-Noun>
{
Sequence
{
[<Activity>]
[<Activity>]
# ...

}
}

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

# DETAILED DESCRIPTION


The commands in a Parallel script block can run concurrently.
The order in which they run is not determined. This feature
improves the performance of a script workflow.

You can use a Sequence script block to run selected activities
sequentially, even though the activities appear in a Parallel
script block.

The activities in a Sequence script block run one at a time
in the order in which they are listed. An activity in a Sequence
script block starts only after the previous activity completes.

However, when the Sequence script block appears in a Parallel
script block, the order in which the Sequence script block runs
is not determined. It might run before, after, or concurrent with
other activities in the Parallel script block.

For example, the following workflow includes a Parallel script
block that runs activities that get processes and services on
the computer. The Parallel script block contains a Sequence
script block that gets information from a file and uses the
information as input to a script.

The Get-Process, Get-Service and hotfix-related commands
are independent of each other and can run concurrently or
in any order, but the command that gets the hotfix information
must run before the command that uses it.

workflow Test-Workflow
{
Parallel
{
Get-Process
Get-Service

Sequence
{
$Hotfix = Get-Content D:\HotFixes\Required.txt
Foreach ($h in $Hotfix} {D:\Scripts\Verify-Hotfix -Hotfix $h}
}
}
}

# SEE ALSO

"Writing a Script Workflow" (http://go.microsoft.com/fwlink/?LinkID=262872)
about_ForEach
about_ForEach-Parallel
about_Language_Keywords
about_Parallel
about_Workflows