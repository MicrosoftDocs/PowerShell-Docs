---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Switch
ms.technology:  powershell
ms.assetid:  6d31467b-3e85-4471-a7d2-ef8c2e086400
---

# about_Switch
## TOPIC  
 about\_Switch  
  
## SHORT DESCRIPTION  
 Explains how to use a switch to handle multiple If statements.  
  
## LONG DESCRIPTION  
 To check a condition in a script or function, use an If statement. The If can check many types of conditions, including the value of variables and the properties of objects.  
  
 To check multiple conditions, use a Switch statement. The Switch statement is equivalent to a series of If statements, but it is simpler. The Switch statement lists each condition and an optional action. If a condition obtains, the action is performed.  
  
 A basic Switch statement has the following format:  
  
```  
 Switch (<test-value>)  
 {  
     <condition> {<action>}  
     <condition> {<action>}  
}  
```  
  
 For example, the following Switch statement compares the test value, 3, to each of the conditions. When the test value matches the condition, the action is performed.  
  
```  
PS> switch (3)   
 {  
    1 {"It is one."}  
    2 {"It is two."}  
    3 {"It is three."}  
    4 {"It is four."}  
 }   
It is three.  
```  
  
 In this simple example, the value is compared to each condition in the list, even though there is a match for the value 3. The following Switch statement has two conditions for a value of 3. It demonstrates that, by default, all conditions are tested.  
  
```  
PS> switch (3)   
 {  
    1 {"It is one."}  
    2 {"It is two."}  
    3 {"It is three."}  
    4 {"It is four."}  
    3 {"Three again."}  
 }   
It is three.  
Three again.  
```  
  
 To direct the Switch to stop comparing after a match, use the Break statement. The Break statement terminates the Switch statement.  
  
```  
PS> switch (3)   
 {  
    1 {"It is one."}  
    2 {"It is two."}  
    3 {"It is three."; Break}  
    4 {"It is four."}  
    3 {"Three again."}  
 }   
It is three.  
```  
  
 If the test value is a collection, such as an array, each item in the collection is evaluated in the order in which it appears. The following examples evaluates 4 and then 2.  
  
```  
 PS> switch (4, 2)   
 {  
    1 {"It is one." }  
    2 {"It is two." }  
    3 {"It is three." }  
    4 {"It is four." }  
    3 {"Three again."}  
 }   
It is four.  
It is two.  
```  
  
 Any Break statements apply to the collection, not to each value, as shown in the following example. The Switch statement is terminated by the Break statement in the condition of value 4.  
  
```  
 PS> switch (4, 2)   
 {  
    1 {"It is one."; Break}  
    2 {"It is two." ; Break }  
    3 {"It is three." ; Break }  
    4 {"It is four." ; Break }  
    3 {"Three again."}  
 }   
It is four.  
```  
  
## SYNTAX  
 The complete Switch statement syntax is as follows:  
  
```  
switch [-regex|-wildcard|-exact][-casesensitive] (<value>)  
```  
  
 or  
  
```  
switch [-regex|-wildcard|-exact][-casesensitive] -file filename  
```  
  
 followed by  
  
```  
{   
    "string"|number|variable|{ expression } { statementlist }  
    default { statementlist }   
}  
```  
  
 If no parameters are used, Switch performs a case\-insensitive exact match for the value. If the value is a collection, each element is evaluated in the order in which it appears.  
  
 The Switch statement must include at least one condition statement.  
  
 The Default clause is triggered when the value does not match any of the conditions. It is equivalent to an Else clause in an If statement. Only one Default clause is permitted in each Switch statement.  
  
 Switch has the following parameters:  
  
 Regex  
  
 Performs regular expression matching of the value to the condition. If you use Regex, Wildcard and Exact are ignored. Also, if the match clause is not a string, this parameter is ignored.  
  
```  
   Example:  
   PS> switch ("fourteen")   
       {  
           1 {"It is one."; Break}  
           2 {"It is two."; Break}  
           3 {"It is three."; Break}  
           4 {"It is four."; Break}  
           3 {"Three again."; Break}  
           "fo*" {"That's too many."}  
       }   
  
   PS> switch -Regex ("fourteen")   
       {  
           1 {"It is one."; Break}  
           2 {"It is two."; Break}  
           3 {"It is three."; Break}  
           4 {"It is four."; Break}  
           3 {"Three again."; Break}  
           "fo*" {"That's too many."}  
       }  
That's too many.  
```  
  
 Wildcard  
  
 Indicates that the condition is a wildcard string. If you use Wildcard, Regex and Exact are ignored. Also, if the match clause is not a string, this parameter is ignored.  
  
 Exact  
  
 Indicates that the match clause, if it is a string, must match exactly. If you use Exact, Regex and Wildcard and Exact are ignored. Also, if the match clause is not a string, this parameter is ignored.  
  
 CaseSensitive  
  
 Performs a case\-sensitive match. If the match clause is not a string, this parameter is ignored.  
  
 File  
  
 Takes input from a file rather than a value statement. If multiple File parameters are included, only the last one is used. Each line of the file is read and evaluated by the Switch statement.  
  
 Multiple instances of Regex, Wildcard, or Exact are permitted. However, only the last parameter used is effective.  
  
 If the value matches multiple conditions, the action for each condition is executed. To change this behavior, use the Break or Continue keywords.  
  
 The Break keyword stops processing and exits the Switch statement.  
  
 The Continue keyword continues processing the current value and any subsequent values.  
  
 If the condition is an expression or a script block, it is evaluated just before it is compared to the value. The value is assigned to the $\_ automatic variable and is available in the expression. The match succeeds if the expression is true or matches the value. The expression is evaluated in its own scope.  
  
 The "Default" keyword specifies a condition that is evaluated only when no other conditions match the value.  
  
 The action for each condition is independent of the actions in other conditions. The closing brace \( } \) in the action is an explicit break.  
  
## SEE ALSO  
 about\_Break  
  
 about\_Continue  
  
 about\_If  
  
 about\_Script\_Blocks

