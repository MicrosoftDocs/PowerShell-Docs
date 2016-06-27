---
title: about_Continue
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb27914c-9fcc-4366-b310-4e553dde6cdf
---
# about_Continue
Insert introduction here.  
  
## TOPIC  
 about\_Continue  
  
## SHORT DESCRIPTION  
 Describes how the Continue statement immediately returns the program flow to the top of a program loop.  
  
## LONG DESCRIPTION  
 In a script, the Continue statement immediately returns the program flow to the top of the innermost loop that is controlled by a For, Foreach, or While statement.  
  
 The Continue keyword supports labels. A label is a name you assign to a statement in a script. For information about labels, see about\_Break.  
  
 In the following example, program flow returns to the top of the While loop if the $ctr variable is equal to 5. As a result, all the numbers between 1 and 10 are displayed except for 5:  
  
```  
while ($ctr -lt 10)  
     {  
       $ctr +=1   
       if ($ctr -eq 5) {continue}  
       Write-Host $ctr  
     }  
  
```  
  
 Note that in a For loop, execution continues at the first line in the loop. If the arguments of the For statement test a value that is modified by the For statement, an infinite loop may result.  
  
## SEE ALSO  
 about\_Break  
  
 about\_Comparison\_Operators  
  
 about\_Throw  
  
 about\_Trap  
  
 about\_Try\_Catch\_Finally