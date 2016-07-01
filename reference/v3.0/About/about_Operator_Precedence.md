---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Operator_Precedence
ms.technology:  powershell
ms.assetid:  ce3badd8-dd8d-4c75-b698-bf07304228ce
---

# about_Operator_Precedence
```  
TOPIC  
    about_Operator_Precedence  
  
SHORT DESCRIPTION  
    Lists the Windows PowerShell operators in precedence order.  
  
    [This topic was contributed by Kirk Munro, a Windows PowerShell MVP  
     from Ottawa, Ontario]       
  
LONG DESCRIPTION  
    Windows PowerShell operators let you construct simple, but powerful  
    expressions. This topic lists the operators in precedence order.   
    Precedence order is the order in which Windows PowerShell evaluates  
    the operators when multiple operators appear in the same expression.  
  
    When operators have equal precedence, Windows PowerShell evaluates   
    them from left to right. The exceptions are the assignment operators,  
    the cast operators, and the negation operators (!, -not, -bnot),   
    which are evaluated from right to left.  
  
    You can use enclosures, such as parentheses, to override the   
    standard precedence order and force Windows PowerShell to evaluate  
    the enclosed part of an expression before an unenclosed part.   
  
    In the following list, operators are listed in the order that they  
    are evaluated. Operators on the same line, or in the same group, have  
    equal precedence.   
  
    The Operator column lists the operators. The Reference column lists  
    the Windows PowerShell Help topic in which the operator is described.  
    To display the topic, type "get-help <topic-name>".  
  
    OPERATOR                         REFERENCE   
    --------                         ---------  
  
    $()  @()                         about_Operators  
  
    . (dereference) :: (static)      about_Operators  
  
    [0] (index operator)             about_Operators  
  
    [int] (cast operators)           about_Operators  
  
    -split (unary) -join (unary)     about_Split, about_Join  
  
    , (comma operator)               about_Operators  
  
    ++ --                            about_Assignment_Operators  
  
    -not ! -bNot                     about_Logical_Operators, about_Comparison_Operators  
  
    .. (range operator)              about_Operators  
  
    -f (format operator)             about_Operators   
  
    * / %                            about_Arithmetic_Operators  
  
    + -                              about_Arithmetic_Operators  
  
    The following group of operators have equal precedence. Their  
    case-sensitive and explicitly case-insensitive variants have  
    the same precedence.  
  
    -split (binary)                  about_Split  
    -join (binary)                   about_Join  
    -is  -isnot  -as                 about_Type_Operators  
    -eq  -ne  -gt  -gt  -lt  -le     about_Comparison_Operators  
    -like  -notlike                  about_comparison_operators  
    -match  -notmatch                about_comparison_operators  
    -in -notIn                       about_comparison_operators  
    -contains -notContains           about_comparison_operators  
    -replace                         about_comparison_operators  
  
    The list resumes here with the following operators in precedence  
    order:  
  
    -band -bor -bxor                 about_Comparison_Operators  
  
    -and -or -xor                    about_Comparison_Operators  
  
    . (dot-source)  & (call)         about_Scopes, about_Operators  
  
    | (pipeline operator)            about_Operators  
  
    >  >>  2>  2>>  2>&1             about_Redirection  
  
    =  +=  -=  *=  /= %=             about_Assignment_Operators  
  
EXAMPLES  
  
    The following two commands show the arithmetic operators and  
    the effect of using parentheses to force Windows PowerShell to  
    evaluate the enclosed part of the expression first.  
  
        C:\PS> 2 + 3 * 4  
        14  
  
        C:\PS> (2 + 3) * 4  
        20  
  
    The following example gets the read-only text files from the local  
    directory and saves them in the $read_only variable.  
  
        $read_only = get-childitem *.txt | where-object {$_.isReadOnly}  
  
    It is equivalent to the following example.  
  
        $read_only = ( get-childitem *.txt | where-object {$_.isReadOnly} )  
  
    Because the pipeline operator (|) has a higher precedence than the  
    assignment operator (=), the files that the Get-ChildItem cmdlet   
    gets are sent to the Where-Object cmdlet for filtering before they  
    are assigned to the $read_only variable.  
  
    The following example demonstrates that the index operator takes  
    precedence over the cast operator.  
  
    The first expression creates an array of three strings. Then, it  
    uses the index operator with a value of 0 to select the first object  
    in the array, which is the first string. Finally, it casts the   
    selected object as a string. In this case, the cast has no effect.  
  
        C:\PS> [string]@('Windows','PowerShell','2.0')[0]  
        Windows  
  
    The second expression uses parentheses to force the cast operation  
    to occur before the index selection. As a result, the entire array  
    is cast as a (single) string. Then, the index operator selects  
    the first item in the string array, which is the first character.  
  
        C:\PS> ([string]@('Windows','PowerShell','2.0'))[0]  
        W  
  
    In the following example, because the -gt (greater-than) operator  
    has a higher precedence than the -and (logical AND) operator, the  
    result of the expression is FALSE.  
  
        C:\PS> 2 -gt 4 -and 1  
        False   
  
    It is equivalent to the following expression.  
  
        C:\PS> (2 -gt 4) -and 1  
        False   
  
    If the -and operator had higher precedence, the answer would be TRUE.  
  
        C:\PS> 2 -gt (4 -and 1)  
        True   
  
    However, this example demonstrates an important principle of managing  
    operator precedence. When an expression is difficult for people to  
    interpret, use parentheses to force the evaluation order, even when it  
    forces the default operator precedence. The parentheses make your  
    intentions clear to people who are reading and maintaining your scripts.  
  
SEE ALSO  
    about_Assignment_Operators  
    about_Comparison_Operators  
    about_Join  
    about_Logical_Operators  
    about_Operators  
    about_Redirection  
    about_Scopes  
    about_Split  
    about_Type_Operators  
```

