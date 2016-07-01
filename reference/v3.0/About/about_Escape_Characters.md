---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Escape_Characters
ms.technology:  powershell
ms.assetid:  576ca013-c4ca-4ade-bf46-b0d1ce2c778f
---

# about_Escape_Characters
```  
TOPIC  
    about_Escape_Characters  
  
SHORT DESCRIPTION  
    Introduces the escape character in Windows PowerShell and explains  
    its effect.  
  
LONG DESCRIPTION  
    Escape characters are used to assign a special interpretation to  
    the characters that follow it.  
  
    In Windows PowerShell, the escape character is the backtick (`), also  
    called the grave accent (ASCII 96). The escape character can be used  
    to indicate a literal, to indicate line continuation, and to indicate  
    special characters.  
  
    In a call to another program, instead of using escape characters   
    to prevent Windows PowerShell from misinterpreting program arguments,   
    you can use the stop-parsing symbol (--%). The stop-parsing symbol  
    is introduced in Windows PowerShell 3.0.  
  
 ESCAPING A VARIABLE  
    When an escape character precedes a variable, it prevents a value from  
    being substituted for the variable.   
  
    For example:  
  
        PS C:\>$a = 5  
        PS C:\>"The value is stored in $a."  
        The value is stored in 5.  
  
        PS C:\>$a = 5  
        PS C:\>"The value is stored in `$a."  
        The value is stored in $a.  
  
 ESCAPING QUOTATION MARKS  
  
    When an escape character precedes a  
    double quotation mark, Windows PowerShell interprets the double quotation  
    mark as a character, not as a string delimiter.  
  
        PS C:\> "Use quotation marks (") to indicate a string."  
        Unexpected token ')' in expression or statement.  
        At line:1 char:25  
        + "Use quotation marks (") <<<<  to indicate a string."  
  
        PS C:\> "Use quotation marks (`") to indicate a string."  
        Use quotation marks (") to indicate a string.  
  
 USING LINE CONTINUATION  
  
    The escape character tells Windows PowerShell that the command continues   
    on the next line.  
  
    For example:  
  
      PS C:\> Get-Process `  
      >> PowerShell  
  
      Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName  
      -------  ------    -----      ----- -----   ------     -- -----------  
          340       8    34556      31864   149     0.98   2036 PowerShell  
  
 USING SPECIAL CHARACTERS    
  
    When used within quotation marks, the escape character indicates a   
    special character that provides instructions to the command parser.  
  
    The following special characters are recognized by Windows PowerShell:  
  
        `0    Null  
        `a    Alert  
        `b    Backspace  
        `f    Form feed  
        `n    New line  
        `r    Carriage return  
        `t    Horizontal tab  
        `v    Vertical tab  
  
    For example:  
  
        PS C:\> "12345678123456781`nCol1`tColumn2`tCol3"  
        12345678123456781  
        Col1    Column2 Col3  
  
    For more information, type:  
          Get-Help about_Special_Characters  
  
 STOP-PARSING SYMBOL  
    When calling other programs, you can use the stop-parsing  
    symbol (--%) to prevent Windows PowerShell from generating  
    errors or misinterpreting program arguments. The stop-parsing   
    symbol is an alternative to using escape characters in program   
    calls. It is introduced in Windows PowerShell 3.0.  
  
    For example, the following command uses the stop-parsing  
    symbol in an Icacls command:  
  
        icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F  
  
    For more information about the stop-parsing symbol,   
    see about_Parsing.  
  
SEE ALSO  
    about_Quoting_Rules  
```

