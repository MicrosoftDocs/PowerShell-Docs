---
title: about_Operators
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0b0c09a4-76e1-4951-9158-d973b48a1d7b
---
# about_Operators
```  
TOPIC  
    about_Operators  
  
SHORT DESCRIPTION  
    Describes the operators that are supported by Windows PowerShell.   
  
LONG DESCRIPTION  
    An operator is a language element that you can use in a command or  
    expression. Windows PowerShell supports several types of operators to  
    help you manipulate values.  
  
  Arithmetic Operators  
      Use arithmetic operators (+, -, *, /, %) to calculate values in a command  
      or expression. With these operators, you can add, subtract, multiply, or  
      divide values, and calculate the remainder (modulus) of a division   
      operation.  
  
      You can also use arithmetic operators with strings, arrays, and hash   
      tables. The addition operator concatenates elements. The multiplication  
      operator returns the specified number of copies of each element.  
  
      For more information, see about_Arithmetic_Operators.  
  
  Assignment Operators  
      Use assignment operators (=, +=, -=, *=, /=, %=) to assign one or more  
      values to variables, to change the values in a variable, and to append  
      values to variables. You can also cast the variable as any Microsoft .NET  
      Framework data type, such as string or DateTime, or Process variable.  
  
      For more information, see about_Assignment_Operators.  
  
  Comparison Operators  
      Use comparison operators (-eq, -ne, -gt, -lt, -le, -ge) to compare values  
      and test conditions. For example, you can compare two string values to   
      determine whether they are equal.  
  
      The comparison operators include the match operators (-match, -notmatch),   
      which find patterns by using regular expressions; the replace operator   
      (-replace), which uses regular expressions to change input values; the  
      like operators (-like, -notlike), which find patterns using wildcard   
      characters (*); and the containment operators (-in, -notin, -contains,   
      -notcontains), which determine whether a test value appears in a reference  
      set.  
  
      They also include the bitwise operators (-bAND, -bOR, -bXOR, -bNOT) to   
      manipulate the bit patterns in values.  
  
    For more information, see about_Comparison_Operators  
  
  Logical Operators  
      Use logical operators (-and, -or, -xor, -not, !) to connect conditional  
      statements into a single complex conditional. For example, you can use a  
      logical -and operator to create an object filter with two different   
      conditions.  
  
      For more information, see about_Logical_Operators.  
  
  Redirection Operators  
      Use redirection operators (>, >>, 2>, 2>, and 2>&1) to send the output of  
      a command or expression to a text file. The redirection operators work   
      like the Out-File cmdlet (without parameters) but they also let you   
      redirect error output to specified files. You can also use the Tee-Object  
      cmdlet to redirect output.  
  
      For more information, see about_Redirection.  
  
  Split and Join Operators  
      The -split and -join operators divide and combine substrings. The -split   
      operator splits a string into substrings. The -join operator concatenates  
      multiple strings into a single string.  
  
      For more information, see about_Split and about_Join.  
  
  Type Operators  
      Use the type operators (-is, -isnot, -as) to find or change the .NET   
      Framework type of an object.   
  
      For more information, see about_Type_Operators.  
  
  Unary Operators  
      Use unary operators to increment or decrement variables or object   
      properties and to set integers to positive or negative numbers. For   
      example, to increment the variable $a from 9 to 10, you type $a++.  
  
  Special Operators  
      Use special operators to perform tasks that cannot be performed by the   
      other types of operators. For example, special operators allow you to   
      perform operations such as running commands and changing a value's data   
      type.  
  
      @( ) Array subexpression operator  
         Returns the result of one or more statements as an array.   
         If there is only one item, the array has only one member.  
  
             @(Get-WMIObject win32_logicalDisk)  
  
      & Call operator  
         Runs a command, script, or script block. The call operator, also known as  
         the "invocation operator," lets you run commands that are stored in  
         variables and represented by strings. Because the call operator does not  
         parse the command, it cannot interpret command parameters.   
  
             C:\PS> $c = "get-executionpolicy"  
             C:\PS> $c  
             get-executionpolicy  
  
             C:\PS> & $c  
             AllSigned  
  
      [ ] Cast operator  
           Converts or limits objects to the specified type. If the objects  
           cannot be converted, Windows PowerShell generates an error.  
  
             [datetime]$birthday = "1/20/88"  
             [int64]$a = 34  
  
      , Comma operator  
         As a binary operator, the comma creates an array. As a unary  
         operator, the comma creates an array with one member. Place the  
         comma before the member.  
  
             $myArray = 1,2,3   
             $SingleArray = ,1  
  
      . Dot sourcing operator  
         Runs a script in the current scope so that any functions,  
         aliases, and variables that the script creates are added to the current  
         scope.   
  
             . c:\scripts.sample.ps1  
  
         Note: The dot sourcing operator is followed by a space. Use the space to  
               distinguish the dot from the dot (.) symbol that represents the   
               current directory.  
  
               In the following example, the Sample.ps1 script in the current   
               directory is run in the current scope.  
  
                 . .\sample.ps1  
  
      -f Format operator  
          Formats strings by using the format method of string   
          objects. Enter the format string on the left side of the operator   
          and the objects to be formatted on the right side of the operator.  
  
             C:\PS> "{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi  
             1 hello      3.14  
  
          For more information, see the String.Format method   
          (http://go.microsoft.com/fwlink/?LinkID=166450) and   
          Composite Formatting (http://go.microsoft.com/fwlink/?LinkID=166451).  
  
      [ ] Index operator  
           Selects objects from indexed collections, such as arrays and  
           hash tables. Array indexes are zero-based, so the first object   
           is indexed as [0]. For arrays (only), you can also use negative  
           indexes to get the last values. Hash tables are indexed by key  
           value.  
  
             C:\PS> $a = 1, 2, 3  
             C:\PS> $a[0]  
             1  
             C:\PS> $a[-1]  
             3  
  
             C:\PS> (get-hotfix | sort installedOn)[-1]  
  
             C:\PS> $h = @{key="value"; name="Windows PowerShell"; version="2.0"}  
             C:\PS> $h["name"]  
             Windows PowerShell  
  
             C:\PS> $x = [xml]"<doc><intro>Once upon a time...</intro></doc>"  
             C:\PS> $x["doc"]  
             intro  
             -----  
             Once upon a time...  
  
      | Pipeline operator  
         Sends ("pipes") the output of the command that precedes it to the  
         command that follows it. When the output includes more than one object  
         (a "collection"), the pipeline operator sends the objects one at a time.  
  
               get-process | get-member  
               get-pssnapin | where {$_.vendor -ne "Microsoft"}  
  
      . Property dereference operator  
         Accesses the properties and methods of an object.  
  
             $myProcess.peakWorkingSet  
             (get-process PowerShell).kill()  
  
      .. Range operator  
          Represents the sequential integers in an integer array,   
          given an upper and lower boundary.  
  
             1..10  
             10..1  
             foreach ($a in 1..$max) {write-host $a}  
  
      :: Static member operator  
          Calls the static properties operator and methods of a .NET  
          Framework class. To find the static properties and methods of an   
          object, use the Static parameter of the Get-Member cmdlet.  
  
             [datetime]::now  
  
      $( ) Subexpression operator  
         Returns the result of one or more statements. For a   
         single result, returns a scalar. For multiple results, returns an   
         array.  
  
             $($x * 23)  
             $(Get-WMIObject win32_Directory)  
  
SEE ALSO  
    about_Arithmetic_Operators  
    about_Assignment_Operators  
    about_Comparison_Operators  
    about_Logical_Operators  
    about_Type_Operators  
    about_Split  
    about_Join  
    about_Redirection  
```