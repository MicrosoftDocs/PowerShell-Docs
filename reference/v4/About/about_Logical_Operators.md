---
title: about_Logical_Operators
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c11b13b4-be7b-4c2a-9921-f274c8424f4f
---
# about_Logical_Operators
## TOPIC  
 about\_Logical\_Operators  
  
## SHORT DESCRIPTION  
 Describes the operators that connect statements in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 The [!INCLUDE[wps_2]()] logical operators connect expressions and statements, allowing you to use a single expression to test for multiple conditions.  
  
 For example, the following statement uses the and operator and the or operator to connect three conditional statements. The statement is true only when the value of $a is greater than the value of $b, and either $a or $b is less than 20.  
  
```  
($a -gt $b) -and (($a -lt 20) -or ($b -lt 20))  
  
```  
  
 Windows PowerShell supports the following logical operators.  
  
```  
Operator  Description                      Example  
--------  ------------------------------   ------------------------  
-and      Logical and. TRUE only when      (1 -eq 1) -and (1 -eq 2)   
          both statements are TRUE.         False  
  
-or       Logical or. TRUE when either     (1 -eq 1) -or (1 -eq 2)   
          or both statements are TRUE.     True  
  
-xor      Logical exclusive or. TRUE       (1 -eq 1) -xor (2 -eq 2)  
          only when one of the statements  False   
          is TRUE and the other is FALSE.  
  
-not      Logical not. Negates the         -not (1 -eq 1)  
          statement that follows it.       False  
  
!         Logical not. Negates the         !(1 -eq 1)  
          statement that follows it.       False  
          (Same as -not)  
  
```  
  
 Note:  
  
 The previous examples also use the equal to comparison operator \(\-eq\). For more information, see about\_Comparison\_Operators. The examples also use the Boolean values of integers. The integer 0 has a value of FALSE. All other integers have a value of TRUE.  
  
 The syntax of the logical operators is as follows:  
  
```  
<statement> {-AND | -OR | -XOR} <statement>  
{! | -NOT} <statement>  
  
```  
  
 Statements that use the logical operators return Boolean \(TRUE or FALSE\) values.  
  
 The [!INCLUDE[wps_2]()] logical operators evaluate only the statements required to determine the truth value of the statement. If the left operand in a statement that contains the and operator is FALSE, the right operand is not evaluated. If the left operand in a statement that contains the or statement is TRUE, the right operand is not evaluated. As a result, you can use these statements in the same way that you would use the If statement.  
  
## SEE ALSO  
 about\_Operators  
  
 Compare\-Object  
  
 about\_Comparison\_operators  
  
 about\_If