---
title: about_Parallel
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 104559a8-e89a-49f5-8c08-e5bf72768cbf
---
# about_Parallel
## TOPIC  
 about\_Parallel  
  
## SHORT DESCRIPTION  
 Describes the Parallel keyword, which runs the activities in a workflow in parallel.  
  
## LONG DESCRIPTION  
 The Parallel keyword runs workflow activities in parallel. This keyword is valid only in [!INCLUDE[wps_1]()] Workflow.  
  
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
  
 For example, the following workflow includes a Parallel script block that runs activities that get processes and services on the computer. Because the Get\-Process and Get\-Service commands are independent of each other, they can run concurrently and in any order.  
  
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
  
 To run selected commands in a Parallel script block in sequential order, use the Sequence keyword. For more information, see about\_Sequence.  
  
 To run a Parallel script block on items in a collection, use the ForEach or ForEach \-Parallel keywords.  
  
## SEE ALSO  
 "Writing a Script Workflow" \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=262872\)  
  
 about\_ForEach  
  
 about\_ForEach\-Parallel  
  
 about\_Language\_Keywords  
  
 about\_Sequence  
  
 about\_Workflows