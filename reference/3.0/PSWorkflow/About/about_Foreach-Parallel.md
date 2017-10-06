---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Foreach Parallel
---

# About Foreach-Parallel
## about_Foreach-Parallel


## SHORT DESCRIPTION
Describes the ForEach -Parallel language construct in  Windows PowerShell® Workflow


## LONG DESCRIPTION
The Parallel parameter of the ForEach keyword runs the commands in a ForEach script block once for each item in a specified collection.

The items in the collection, such as a disk in a collection of disks, are processed in parallel. The commands in the script block run sequentially on each item in the collection.

ForEach -Parallel is valid only in a  Windows PowerShell Workflow.


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
Like the ForEach statement in  Windows PowerShell, the variable that contains collection ($<Collection>) must be defined before the ForEach -Parallel statement, but the variable that represents the current item ($<item>) is defined in the ForEach -Parallel statement.

The ForEach -Parallel construct is different from the ForEach keyword and the Parallel keyword. The ForEach keyword processes the items in the collection in sequence. The Parallel keyword runs commands in a script block in parallel. You can enclose a Parallel script block in a ForEach -Parallel script block.

The target computers in a workflow, such as those specified by the PSComputerName workflow common parameter, are always processed in parallel. You do not need to specify the ForEach -Parallel keyword for this purpose.


### EXAMPLES
The following workflow contains a ForEach -Parallel statement that processes the disks that the Get-Disk activity gets. The commands in the ForEach -Parallel script block run sequentially, but they run on the disks in parallel. The disks might be processed concurrently and in any order.


```
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



## SEE ALSO
Writing a Script Workflow (http://go.microsoft.com/fwlink/?LinkId=262872)

about_ForEach

about_Language_Keywords

about_Parallel

about_Workflows


