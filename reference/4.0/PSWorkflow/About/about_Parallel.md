---
title: about_Parallel
description: 
keywords: powershell, cmdlet
author: jpjofre
manager: carolz
ms.date: 2016-09-27
ms.topic: reference
ms.prod: powershell
ms.technology: powershell
title: about_Parallel
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 392ce9ea-1cee-48a3-8297-fa6d1074d069
---
# About Parallel
## about_Parallel
about_Parallel


## SHORT DESCRIPTION
Describes the Parallel keyword, which runs the activities in a workflow in parallel.


## LONG DESCRIPTION
The Parallel keyword runs workflow activities in parallel. This keyword is valid only in  Windows PowerShell® Workflow.


### SYNTAX


```
workflow <Verb-Noun>  
{  
     Parallel  
     {  
          [<Activity>]  
          [<Activity>]  
        ...  
     }  
 }
```



## DETAILED DESCRIPTION
The commands in a Parallel script block can run concurrently. The order in which they run is not determined.

For example, the following workflow includes a Parallel script block that runs activities that get processes and services on the computer. Because the Get-Process and Get-Service commands are independent of each other, they can run concurrently and in any order.


```
workflow Test-Workflow  
{  
    Parallel  
    {  
         Get-Process  
         Get-Service  
    }  
}
```


Running commands in parallel is very efficient and reduces the time it takes to complete a workflow significantly.

To run selected commands in a Parallel script block in sequential order, use the Sequence keyword. For more information, see about_Sequence.

To run a Parallel script block on items in a collection, use the ForEach or ForEach -Parallel keywords.


## SEE ALSO
"Writing a Script Workflow" (http:\/\/go.microsoft.com\/fwlink\/?LinkID\=262872)

about_ForEach

about_ForEach-Parallel

about_Language_Keywords

about_Sequence

about_Workflows


