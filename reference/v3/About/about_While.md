---
title: about_While
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3a1a1329-2501-4e4e-8660-a2ca68c68541
---
# about_While
```  
TOPIC  
    about_While  
  
SHORT DESCRIPTION  
    Describes a language statement that you can use to run a command block   
    based on the results of a conditional test.  
  
LONG DESCRIPTION  
    The While statement (also known as a While loop) is a language construct  
    for creating a loop that runs commands in a command block as long as a  
    conditional test evaluates to true. The While statement is easier to   
    construct than a For statement because its syntax is less complicated.  
    In addition, it is more flexible than the Foreach statement because you  
    specify a conditional test in the While statement to control how many times  
    the loop runs.  
  
    The following shows the While statement syntax:  
  
        while (<condition>){<statement list>}  
  
    When you run a While statement, Windows PowerShell evaluates   
    the <condition> section of the statement before entering the   
    <statement list> section. The condition portion of the statement resolves  
    to either true or false. As long as the condition remains true, Windows   
    PowerShell reruns the <statement list> section.  
  
    The <statement list> section of the statement contains one or more commands  
    that are run each time the loop is entered or repeated.  
  
    For example, the following While statement displays the numbers 1   
    through 3 if the $val variable has not been created or if the $val variable  
    has been created and initialized to 0.  
  
        while($val -ne 3)  
        {  
            $val++  
            Write-Host $val  
        }  
  
    In this example, the condition ($val is not equal to 3) is true while   
    $val = 0, 1, 2. Each time through the loop, $val is incremented by 1   
    using the ++ unary increment operator ($val++). The last time through   
    the loop, $val = 3. When $val equals 3, the condition statement   
    evaluates to false, and the loop exits.  
  
    To conveniently write this command at the Windows PowerShell command   
    prompt, you can enter it in the following way:  
  
        while($val -ne 3){$val++; Write-Host $val}  
  
    Notice that the semicolon separates the first command that adds 1 to   
    $val from the second command that writes the value of $val to the   
    console.  
  
SEE ALSO  
    about_Comparison_Operators  
    about_Do  
    about_Foreach  
    about_For  
    about_Language_Keywords  
  
```