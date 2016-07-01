---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Arithmetic_Operators
ms.technology:  powershell
ms.assetid:  e471f288-0182-4474-a2de-aa8353c3b09b
---

# about_Arithmetic_Operators
```  
TOPIC  
    about_Arithmetic_Operators  
  
SHORT DESCRIPTION  
    Describes the operators that perform arithmetic in Windows PowerShell.  
  
LONG DESCRIPTION  
  
    Arithmetic operators calculate numeric values. You can use one or  
    more arithmetic operators to add, subtract, multiply, and divide  
    values, and to calculate the remainder (modulus) of a division operation.  
  
    In addition, the addition operator (+) and multiplication operator (*)  
    also operate on strings, arrays, and hash tables. The addition operator  
    concatenates the input. The multiplication operator returns multiple copies  
    of the input. You can even mix object types in an arithmetic statement.  
    The method that is used to evaluate the statement is determined by the type  
    of the leftmost object in the expression.  
  
    Beginning in Windows PowerShell 2.0, all arithmetic operators work  
    on 64-bit numbers.   
  
    Beginning in Windows PowerShell 3.0, the -shr (shift-right) and   
    -shl (shift-left) are added to support bitwise arithmetic in   
    Windows PowerShell.  
  
    Windows PowerShell supports the following arithmetic operators:  
  
    Operator  Description                             Example  
    --------  -----------                             -------  
    +         Adds integers; concatenates strings,    6+2  
              arrays, and hash tables.                "file" + "name"  
  
    -         Subtracts one value from another        6-2  
              value.                                  (get-date).date - 1  
  
    -         Makes a number a negative number.       -6+2  
                                                      -4  
  
    *         Multiplies integers; copies strings     6*2  
              and arrays the specified number of      "w" * 3  
              times.  
  
    /         Divides two values.                     6/2  
  
    %         Returns the remainder of a division     7%2  
              operation.  
  
    -shl      Shift-left                              100 -shl 2  
  
    -shr      Shift-right                             100 -shr 1  
  
    OPERATOR PRECEDENCE  
    Windows PowerShell processes arithmetic operators in the following order:  
  
        Parentheses ()  
        - (for a negative number)  
        *, /, %  
        +, - (for subtraction)  
  
    Windows PowerShell processes the expressions from left to right according  
    to the precedence rules. The following examples show the effect of the  
    precedence rules:   
  
        C:\PS> 3+6/3*4   
        11  
  
        C:\PS> 10+4/2  
        12  
  
        C:\PS> (10+4)/2  
        7  
  
        C:\PS> (3+3)/ (1+1)  
        3  
  
    The order in which Windows PowerShell evaluates expressions might differ   
    from other programming and scripting languages that you have used. The   
    following example shows a complicated assignment statement.  
  
        C:\PS> $a = 0  
        C:\PS> $b = 1,2  
        C:\PS> $c = -1,-2  
  
        C:\PS> $b[$a] = $c[$a++]  
  
        C:\PS> $b  
        1  
        -1  
  
    In this example, the expression $a++ is evaluated before $c[$a++].   
    Evaluating $a++ changes the value of $a. The variable $a in $b[$a]   
    equals 1, not 0, so the statement assigns a value to $b[1], not $b[0].  
  
    DIVISION AND ROUNDING  
    When the quotient of a division operation is an integer, Windows  
    PowerShell rounds the value to the nearest integer. When the value  
    is .5, it rounds to the nearest even integer.  
  
    The following example shows the effect of rounding to the nearest   
    even integer.  
  
        C:\PS> [int](-5-/-2-)  
        2  
  
        C:\PS> [int](-7-/-2-)  
        4  
  
    ADDING AND MULTIPLYING NON-NUMERIC TYPES  
    You can add numbers, strings, arrays, and hash tables. And, you can  
    multiply numbers, strings, and arrays. However, you cannot multiply hash  
    tables.  
  
    When you add strings, arrays, or hash tables, the elements are   
    concatenated. When you concatenate collections, such as arrays or hash  
    tables, a new object is created that contains the objects from both  
    collections. If you try to concatenate hash tables that have the same key,  
    the operation fails.  
  
    For example, the following commands create two arrays and then add them:  
  
C:\PS> $a = 1,2,3  
C:\PS> $b = "A","B","C"  
C:\PS> $a + $b  
1  
2  
3  
A  
B  
C  
  
    You can also perform arithmetic operations on objects of different types.   
    The operation that Windows PowerShell performs is determined by the  
    Microsoft .NET Framework type of the leftmost object in the operation.  
    Windows PowerShell tries to convert all the objects in the operation to the  
    .NET Framework type of the first   
    object. If it succeeds in converting the objects, it performs the operation  
    appropriate to the .NET Framework type of the first object. If it fails to   
    convert any of the objects, the operation fails.   
  
    The following example demonstrates the use of the addition and   
    multiplication operators in operations that include different object types:  
  
        C:\PS> "file" + 16  
        file16  
  
        C:\PS> $array = 1,2,3  
        C:\PS> $array + 16  
        1  
        2  
        3  
        16  
  
C:\PS> $array + "file"  
        1  
        2  
        3  
        file  
  
        C:\PS> "file" * 3  
        filefilefile  
  
    Because the method that is used to evaluate statements is determined by the  
    leftmost object, addition and multiplication in Windows PowerShell are not  
    strictly commutative. For example, (a + b) does not always equal (b + a),   
    and (a * b) does not always equal (b * a).  
  
    The following examples demonstrate this principle:  
  
        C:\PS> "file" + 2  
        file2  
  
        C:\PS> 2 + "file"  
        Cannot convert value "file" to type "System.Int32". Error: "Input  
        string was not in a correct format."  
        At line:1 char:4  
        + 2 + <<<<  "file"  
  
        C:\PS> "file" * 3  
        filefilefile  
  
        C:\PS> 3 * "file"  
        Cannot convert value "file" to type "System.Int32". Error: "Input   
        string was not in a correct format."  
        At line:1 char:4  
        + 3 * <<<<  "file"  
  
    Hash tables are a slightly different case. You can add hash tables. And,  
    you can add a hash table to an array. However, you cannot add any other   
    type to a hash table.   
  
    The following examples show how to add hash tables to each other and to   
    other objects:  
  
        C:\PS> $hash1 = @{a=1; b=2; c=3}  
        C:\PS> $hash2 = @{c1="Server01"; c2="Server02"}  
        C:\PS> $hash1 + $hash2  
  
        Name                           Value  
        ----                           -----  
        c2                             Server02  
        a                              1  
        b                              2  
        c1                             Server01  
        c                              3  
  
        C:\PS> $hash1 + 2  
        You can add another hash table only to a hash table.  
        At line:1 char:9  
        + $hash1 + <<<<  2  
  
        C:\PS> 2 + $hash1  
        Cannot convert "System.Collections.Hashtable" to "System.Int32".  
        At line:1 char:4  
        + 2 + <<<<  $hash1  
  
    The following examples demonstrate that you can add a hash table to an   
    array. The entire hash table is added to the array as a single object.  
  
        C:\PS> $array = 1,2,3  
        C:\PS> $array + $hash1  
        1  
        2  
        3  
  
        Name                           Value  
        ----                           -----  
        a                              1  
        b                              2  
        c                              3  
  
        C:\PS> $sum = $array + $hash1  
        C:\PS> $sum.count  
        4  
  
        C:\PS> $sum[3]  
        Name                           Value  
        ----                           -----  
        a                              1  
        b                              2  
        c                              3  
  
        PS C:\ps-test> $sum + $hash2  
        1  
        2  
        3  
  
        Name                           Value  
        ----                           -----  
        a                              1  
        b                              2  
        c                              3  
        c2                             Server02  
  
    The following example shows that you cannot add hash tables that contain   
    the same key:  
  
        C:\PS> $hash1 = @{a=1; b=2; c=3}  
        C:\PS> $hash2 = @{c="red"}  
        C:\PS> $hash1 + $hash2  
        Bad argument to operator '+': Item has already been added.   
        Key in dictionary: 'c'    Key being added: 'c'.  
        At line:1 char:9  
        + $hash1 + <<<<  $hash2  
  
    Although the addition operators are very useful, use the assignment   
    operators to add elements to hash tables and arrays. For more information  
    see about_assignment_operators. The following examples use the +=   
    assignment operator to add items to an array:  
  
        C:\PS>  $array  
        1  
        2  
        3  
  
        C:\PS>  $array + "file"  
        1  
        2  
        3  
        file  
  
        C:\PS>  $array  
        1  
        2  
        3  
  
        C:\PS>  $array += "file"  
        C:\PS>  $array  
        1  
        2  
        3  
        file  
  
        C:\PS> $hash1  
  
        Name                           Value  
        ----                           -----  
        a                              1  
        b                              2  
        c                              3  
  
        C:\PS> $hash1 += @{e = 5}  
        C:\PS> $hash1  
  
        Name                           Value  
        ----                           -----  
        a                              1  
        b                              2  
        e                              5  
        c                              3  
  
    Windows PowerShell automatically selects the .NET Framework numeric type  
    that best expresses the result without losing  precision. For example:  
  
        C:\PS> 2 + 3.1  
        5.1  
        C:\PS> (2). GetType().FullName  
        System.Int32  
        C:\PS> (2 + 3.1).GetType().FullName  
        System.Double  
  
    If the result of an operation is too large for the type, the type of the   
    result is widened to accommodate the result, as in the following example:   
  
        C:\PS> (512MB).GetType().FullName  
        System.Int32  
        C:\PS> (512MB * 512MB).GetType().FullName  
        System.Double  
  
    The type of the result will not necessarily be the same as one of the   
    operands. In the following example, the negative value cannot be cast to an  
    unsigned integer, and the unsigned integer is too large to be cast to  
    Int32:  
  
        C:\PS> ([int32]::minvalue + [uint32]::maxvalue).gettype().fullname  
        System.Int64  
  
    In this example, Int64 can accommodate both types.  
  
    The System.Decimal type is an exception. If either operand has the Decimal  
    type, the result will be of the Decimal type. If the result is too large  
    for the Decimal type, it will not be cast to Double. Instead, an error  
    results.  
  
        C:\PS> [Decimal]::maxvalue  
        79228162514264337593543950335  
        C:\PS> [Decimal]::maxvalue + 1  
        Value was either too large or too small for a Decimal.  
        At line:1 char:22  
        + [Decimal]::maxvalue + <<<<  1  
  
    ARITHMETIC OPERATORS AND VARIABLES  
    You can also use arithmetic operators with variables. The operators act on   
    the values of the variables. The following examples demonstrate the use of   
    arithmetic operators with variables:  
  
        C:\PS> $intA = 6   
        C:\PS> $intB = 4   
        C:\PS> $intA + $intB   
  
        10  
  
        C:\PS> $a = "Windows "   
        C:\PS> $b = "PowerShell "   
        C:\PS> $c = 2   
C:\PS> $a + $b + $c  
  
        Windows PowerShell 2  
  
    ARITHMETIC OPERATORS AND COMMANDS  
    Typically, you use the arithmetic operators in expressions with numbers,   
    strings, and arrays. However, you can also use arithmetic operators with   
    the objects that commands return and with the properties of those objects.  
  
    The following examples show how to use the arithmetic operators in   
    expressions with Windows PowerShell commands:  
  
C:\PS> get-date  
Wednesday, January 02, 2008 1:28:42 PM  
  
C:\PS> $day = new-timespan -day 1  
C:\PS> get-date + $day  
Thursday, January 03, 2008 1:34:52 PM  
  
C:\PS> get-process | where {($_.ws * 2) -gt 50mb}  
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName  
-------  ------    -----      ----- -----   ------     -- -----------  
   1896      39    50968      30620   264 1,572.55   1104 explorer  
  12802      78   188468      81032   753 3,676.39   5676 OUTLOOK  
    660       9    36168      26956   143    12.20    988 PowerShell  
    561      14     6592      28144   110 1,010.09    496 services  
   3476      80    34664      26092   234 ...45.69    876 svchost  
    967      30    58804      59496   416   930.97   2508 WINWORD  
  
 EXAMPLES  
    The following examples show how to use the arithmetic operators in   
    Windows PowerShell:  
  
C:\PS> 1 + 1  
2   
  
C:\PS> 1 - 1   
0   
  
C:\PS> -(6 + 3)   
-9   
  
C:\PS> 6 * 2   
12   
  
C:\PS> 7 / 2   
3.5   
  
C:\PS> 7 % 2   
1   
  
C:\PS> w * 3   
www   
  
C:\PS> 3 * "w"   
Cannot convert value "w" to type "System.Int32". Error: "Input string was not  
        in a correct format."   
At line:1 char:4   
+ 3 * <<<< "w"   
  
PS C:\ps-test> "Windows" + " " + "PowerShell"   
Windows PowerShell   
  
PS C:\ps-test> $a = "Windows" + " " + "PowerShell"   
PS C:\ps-test> $a   
Windows PowerShell   
  
C:\PS> $a[0]   
W   
  
C:\PS> $a = "TestFiles.txt"   
C:\PS> $b = "C:\Logs\"   
C:\PS> $b + $a   
C:\Logs\TestFiles.txt   
  
C:\PS> $a = 1,2,3   
C:\PS> $a + 4   
1   
2   
3   
4   
  
C:\PS> $servers = @{0 = "LocalHost"; 1 = "Server01"; 2 = "Server02"}   
C:\PS> $servers + @{3 = "Server03"}   
Name Value   
---- -----   
3 Server03   
2 Server02   
1 Server01   
0 LocalHost   
  
C:\PS> $servers   
Name Value   
---- -----   
2 Server02   
1 Server01   
0 LocalHost   
  
C:\PS> $servers += @{3 = "Server03"} #Use assignment operator   
C:\PS> $servers   
Name Value   
---- -----   
3 Server03   
2 Server02   
1 Server01   
0 LocalHost  
  
    BITWISE ARITHMETIC IN WINDOWS POWERSHELL  
  
    Windows PowerShell supports the -shl (shift-left) and   
    -shr (shift-right) operators for bitwise arithmetic.  
  
    These operators are introduced in Windows   
    PowerShell 3.0.  
  
    In a bitwise shift-left operation, all bits are moved "n" places to   
    the left, where "n" is the value of the right operand. A zero is   
    inserted in the ones place.   
  
    When the left operand is an Integer (32-bit) value, the lower 5 bits  
    of the right operand determine how many bits of the left operand are   
    shifted.  
  
    When the left operand is a Long (64-bit) value, the lower 6 bits of   
    the right operand determine how many bits of the left operand are   
    shifted.  
  
        PS C:\> 21 -shl 1  
        42  
  
          00010101  (21)  
          00101010  (42)  
  
        PS C:\> 21 -shl 2  
        84  
  
          00010101  (21)  
          00101010  (42)  
          01010100  (84)  
  
    In a bitwise shift-right operation, all bits are moved "n" places  
    to the right, where "n" is specified by the right operand. The   
    shift-right operator (-shr) inserts a zero in the left-most   
    place when shifting a positive or unsigned value to the right.  
  
    When the left operand is an Integer (32-bit) value, the lower 5 bits  
    of the right operand determine how many bits of the left operand are   
    shifted.  
  
    When the left operand is a Long (64-bit) value, the lower 6 bits of   
    the right operand determine how many bits of the left operand are   
    shifted.  
  
        PS C:\> 21 -shr 1  
        10  
  
          00010101  (21)  
          00001010  (10)  
  
        PS C:\> 21 -shr 2  
        5  
  
          00010101  (21)  
          00001010  (10)  
          00000101  ( 5)  
  
SEE ALSO  
    about_arrays  
    about_assignment_operators  
    about_comparison_operators  
    about_hash_tables  
    about_operators  
    about_variables  
    Get-Date  
    New-TimeSpan  
```

