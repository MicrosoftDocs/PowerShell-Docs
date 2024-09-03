---
description: Describes the `ForEach -Parallel` language construct in Windows PowerShell Workflow.
Locale: en-US
ms.date: 09/10/2021
online version: https://learn.microsoft.com/powershell/module/psworkflow/about/about_foreach-parallel?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Foreach-Parallel
---
# about_Foreach-Parallel

## SHORT DESCRIPTION
Describes the `ForEach -Parallel` language construct in Windows PowerShell
Workflow.

## LONG DESCRIPTION

The **Parallel** parameter of the `ForEach` keyword runs the commands in a
`ForEach` script block once for each item in a specified collection.

The items in the collection, such as a disk in a collection of disks, are
processed in parallel. The commands in the script block run sequentially on
each item in the collection.

`ForEach -Parallel` is valid only in a Windows PowerShell Workflow.

### SYNTAX

```
ForEach -Parallel ($<item> in $<collection>)
{
    [<Activity1>]
    [<Activity2>]
    ...
}
```

### DETAILED DESCRIPTION

Like the ForEach statement in Windows PowerShell, the variable that contains
collection `$<collection>` must be defined before the `ForEach -Parallel`
statement, but the variable that represents the current item `$<item>` is
defined in the `ForEach -Parallel` statement.

The `ForEach -Parallel` construct is different from the `ForEach` keyword and
the **Parallel** parameter. The `ForEach` keyword processes the items in the
collection in sequence. The **Parallel** parameter runs commands in a script
block in parallel. You can enclose a Parallel script block in a
`ForEach -Parallel` script block.

The target computers in a workflow, such as those specified by the
**PSComputerName** workflow common parameter, are always processed in parallel.
You do not need to specify the `ForEach -Parallel` keyword for this purpose.

### EXAMPLES

The following workflow contains a `ForEach -Parallel` statement that processes
the disks that the `Get-Disk` activity gets. The commands in the
`ForEach -Parallel` script block run sequentially, but they run on the disks in
parallel. The disks might be processed concurrently and in any order.

```powershell
workflow Test-Workflow
{
    $Disks = Get-Disk

    # The disks are processed in parallel.
    ForEach -Parallel ($Disk in $Disks)
    {
        # The commands run sequentially on each disk.
        $DiskPath = $Disk.Path
        $Disk | Initialize-Disk
        Set-Disk -Path $DiskPath
    }
}
```

In this version of the workflow, the `Get-Process` and `Get-Service` commands
are run in parallel. The workflow function continues to the `ForEach -Parallel`
loop where the commands are run sequentially, but they run on the disks in
parallel. The parallel commands and the `ForEach -Parallel` loop run
concurrently.

```powershell
workflow Test-Workflow
{
    #Run commands in parallel.
    Parallel
    {
        Get-Process
        Get-Service
    }

   $Disks = Get-Disk

   # The disks are processed in parallel.
   ForEach -Parallel ($Disk in $Disks)
   {
       # The commands run in parallel on each disk.
       Parallel
       {
           Initialize-Disk
           InlineScript {.\Get-DiskInventory}
       }
   }
}
```

## See Also

- [about_ForEach](../../Microsoft.PowerShell.Core/About/about_ForEach.md)
- [about_Language_Keywords](../../Microsoft.PowerShell.Core/About/about_Language_Keywords.md)
- [about_Parallel](about_Parallel.md)
- [about_Workflows](about_Workflows.md)
- [Writing a Script Workflow](/previous-versions/powershell/scripting/developer/workflow/creating-a-workflow-by-using-a-windows-powershell-script)
