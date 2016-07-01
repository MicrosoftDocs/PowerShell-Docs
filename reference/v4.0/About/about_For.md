---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_For
ms.technology:  powershell
ms.assetid:  a2eb48d6-7d47-4087-a8d6-deb1d029a957
---

# about_For
## TOPIC  
 about\_For  
  
## SHORT DESCRIPTION  
 Describes a language command you can use to run statements based on a conditional test.  
  
## LONG DESCRIPTION  
 The For statement \(also known as a For loop\) is a language construct you can use to create a loop that runs commands in a command block while a specified condition evaluates to true.  
  
 A typical use of the For loop is to iterate an array of values and to operate on a subset of these values. In most cases, if you want to iterate all the values in an array, consider using a Foreach statement.  
  
 Syntax  
  
 The following shows the For statement syntax.  
  
```  
for (<init>; <condition>; <repeat>)   
{<statement list>}  
```  
  
 The \<init\> placeholder represents one or more commands, separated by commas, that are run before the loop begins. You typically use the \<init\> portion of the statement to create and initialize a variable with a starting value. Note that the comma syntax doesn't work with assignment statements, such as the following example:  
  
```  
$ofs=",";$rs = "rs"; $cs = "cs"; for ($r = $rs, $c = $cs; $true;)   
{ "r is '$r' and c is '$c'"; break }  
```  
  
 This variable will then be the basis for the condition to be tested in the next portion of the For statement.  
  
 The \<condition\> placeholder represents the portion of the For statement that resolves to a true or false Boolean value. [!INCLUDE[wps_1]()] evaluates the condition each time the For loop runs. If the statement is true, the commands in the command block run, and the statement is evaluated again. If the condition is still true, the commands in the statement list run again. The loop is repeated until the condition becomes false.  
  
 The \<repeat\> placeholder represents one or more commands, separated by commas, that are executed each time the loop repeats. Typically, this is used to modify a variable that is tested inside the \<condition\> part of the statement.  
  
 The \<statement list\> placeholder represents a set of one or more command that are run each time the loop is entered or repeated. The contents of the statement list are surrounded by braces.  
  
 Examples  
  
 At a minimum, a For statement requires the parenthesis surrounding the \<init\>, \<condition\>, and \<repeat\> part of the statement and a command surrounded by braces in the \<statement list\> part of the statement.  
  
 Note that the upcoming examples intentionally show code outside the For statement. In later examples, code is integrated into the for statement.  
  
 For example, the following For statement continually displays the value of the $i variable until you manually break out of the command by pressing CTRL\+C.  
  
```  
$i = 1  
for (;;){Write-Host $i}  
```  
  
 You can add additional commands to the statement list so that the value of $i is incremented by 1 each time the loop is run, as the following example shows.  
  
```  
for (;;){$i++; Write-Host $i}  
```  
  
 Until you break out of the command by pressing CTRL\+C, this statement will continually display the value of the $i variable as it is  incremented by 1 each time the loop is run.  
  
 Rather than change the value of the variable in the statement list part of the For statement, you can use the \<repeat\> portion of the For statement instead, as follows.  
  
```  
$i=1  
for (;;$i++){Write-Host $i}  
```  
  
 This statement will still repeat indefinitely until you break out of the command by pressing CTRL\+C.  
  
 By setting a condition \(using the \<condition\> portion of the For statement\), you can end the For loop when the condition evaluates to false. In the following example, the For loop runs while the value of $i is less than or equal to 10.  
  
```  
$i=1  
for(;$i -le 10;$i++){Write-Host $i}  
```  
  
 Instead of creating and initializing the variable outside the For statement, you can perform this task inside the For loop by using the \<init\> portion of the For statement.  
  
```  
for($i=1; $i -le 10; $i++){Write-Host $i}  
```  
  
 You can use carriage returns instead of semicolons to delimit the \<init\>, \<condition\>, and \<repeat\> portions of the For statement. The following example shows the For statement syntax in this alternative form.  
  
```  
  
  for (<init>  
<condition>  
<repeat>){  
<statement list>  
}  
```  
  
 This alternative form of the For statement works in [!INCLUDE[wps_2]()] script files and at the [!INCLUDE[wps_2]()] command prompt. However, it is easier to use the For statement syntax with semicolons when you enter interactive commands at the command prompt.  
  
 The For loop is more flexible than the Foreach loop because it allows you to increment values in an array or collection by using patterns. In the following example, the $i variable is incremented by 2 in the \<repeat\> portion of the for statement.  
  
```  
for ($i = 0; $i -ile 20; $i += 2) {Write-Host $i}  
```  
  
## SEE ALSO  
 about\_Comparison\_Operators  
  
 about\_Foreach

