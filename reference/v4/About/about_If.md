---
title: about_If
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cbbd277e-c3f1-4827-9858-a0785ce3720e
---
# about_If
## TOPIC  
 about\_If  
  
## SHORT DESCRIPTION  
 Describes a language command you can use to run statement lists based on the results of one or more conditional tests.  
  
## LONG DESCRIPTION  
 You can use the If statement to run code blocks if a specified conditional test evaluates to true. You can also specify one or more additional conditional tests to run if all the prior tests evaluate to false. Finally, you can specify an additional code block that is run if no other prior conditional test evaluates to true.  
  
### SYNTAX  
 The following example shows the If statement syntax:  
  
```  
if (<test1>)   
    {<statement list 1>}  
[elseif (<test2>)  
    {<statement list 2>}]  
[else  
    {<statement list 3>}]  
```  
  
 When you run an If statement, [!INCLUDE[wps_1]()] evaluates the \<test1\> conditional expression as true or false. If \<test1\> is true, \<statement list 1\> runs, and [!INCLUDE[wps_2]()]exits the If statement. If \<test1\> is false, [!INCLUDE[wps_2]()] evaluates the condition specified by the \<test2\> conditional statement.  
  
 If \<test2\> is true, \<statement list 2\> runs, and [!INCLUDE[wps_2]()] exits the If statement. If both \<test1\> and \<test2\> evaluate to false, the \<statement list 3\> code block runs, and [!INCLUDE[wps_2]()] exits the If statement.  
  
 You can use multiple Elseif statements to chain a series of conditional tests so that each test is run only if all the previous tests are false. If you need to create an If statement that contains many Elseif statements, consider using a Switch statement instead.  
  
### Examples  
 The simplest If statement contains a single command and does not contain any Elseif statements or any Else statements. The following example shows the simplest form of the If statement:  
  
```  
if ($a -gt 2)  
{  
    Write-Host "The value $a is greater than 2."  
}  
```  
  
 In this example, if the $a variable is greater than 2, the condition evaluates to true, and the statement list runs. However, if $a is less than or equal to 2 or is not an existing variable, the If statement does not display a message. By adding an Else statement, a message is displayed when $a is less than or equal to 2, as the next example shows:  
  
```  
if ($a -gt 2)  
{  
    Write-Host "The value $a is greater than 2."  
}  
else  
{  
    Write-Host "The value $a is less than or equal to 2, is not   
created or is not initialized."  
}  
```  
  
 To further refine this example, you can use the Elseif statement to display a message when the value of $a is equal to 2, as the next example shows:  
  
```  
if ($a -gt 2)  
{  
    Write-Host "The value $a is greater than 2."  
}  
elseif ($a -eq 2)  
{  
    Write-Host "The value $a is equal to 2."  
}  
else  
{  
    Write-Host "The value $a is less than 2 or was not created   
or initialized."  
}  
```  
  
## SEE ALSO  
 about\_Comparison\_Operators  
  
 about\_Switch