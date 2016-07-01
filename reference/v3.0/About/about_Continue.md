---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Continue
ms.technology:  powershell
ms.assetid:  a7d1e707-f9c7-4a15-9f92-bc530a40a91a
---

# about_Continue
```  
TOPIC  
    about_Continue  
  
SHORT DESCRIPTION  
    Describes how the Continue statement immediately returns the program flow  
    to the top of a program loop.  
  
LONG DESCRIPTION  
    In a script, the Continue statement immediately returns the program flow  
    to the top of the innermost loop that is controlled by a For, Foreach, or  
    While statement.  
  
    The Continue keyword supports labels. A label is a name you assign to a   
    statement in a script. For information about labels, see about_Break.  
  
    In the following example, program flow returns to the top of the While loop  
    if the $ctr variable is equal to 5. As a result, all the numbers between 1   
    and 10 are displayed except for 5:  
  
        while ($ctr -lt 10)  
             {  
               $ctr +=1   
               if ($ctr -eq 5) {continue}  
               Write-Host $ctr  
             }  
  
    Note that in a For loop, execution continues at the first line in the   
    loop. If the arguments of the For statement test a value that is   
    modified by the For statement, an infinite loop may result.  
  
SEE ALSO  
    about_Break  
    about_Comparison_Operators  
    about_Throw  
    about_Trap  
    about_Try_Catch_Finally  
```

