---
title: about_Quoting_Rules
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad0f71ce-9982-4396-ab10-b681bfb27cdc
---
# about_Quoting_Rules
## TOPIC  
 about\_Quoting\_Rules  
  
## SHORT DESCRIPTION  
 Describes rules for using single and double quotation marks in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 Quotation marks are used to specify a literal string. You can enclose a string in single quotation marks \('\) or double quotation marks \("\).  
  
 Quotation marks are also used to create a here\-string. A here\-string is a single\-quoted or double\-quoted string in which quotation marks are interpreted literally. A here\-string can span multiple lines. All the lines in a here\-string are interpreted as strings, even though they are not enclosed in quotation marks.  
  
 In commands to remote computers, quotation marks define the parts of the command that are run on the remote computer. In a remote session, quotation marks also determine whether the variables in a command are interpreted first on the local computer or on the remote computer.  
  
## SINGLE AND DOUBLE\-QUOTED STRINGS  
 When you enclose a string in double quotation marks \(a double\-quoted string\), variable names that are preceded by a dollar sign \($\) are replaced with the variable's value before the string is passed to the command for processing.  
  
 For example:  
  
```  
$i = 5  
"The value of $i is $i."  
```  
  
 The output of this command is:  
  
```  
The value of 5 is 5.  
```  
  
 Also, in a double\-quoted string, expressions are evaluated, and the result is inserted in the string. For example:  
  
```  
"The value of $(2+3) is 5."  
```  
  
 The output of this command is:  
  
```  
The value of 5 is 5.  
```  
  
 When you enclose a string in single\-quotation marks \(a single\-quoted string\), the string is passed to the command exactly as you type it. No substitution is performed. For example:  
  
```  
$i = 5  
'The value of $i is $i.'  
```  
  
 The output of this command is:  
  
```  
The value $i is $i.  
```  
  
 Similarly, expressions in single\-quoted strings are not evaluated. They are interpreted as literals. For example:  
  
```  
'The value of $(2+3) is 5.'  
```  
  
 The output of this command is:  
  
```  
The value of $(2+3) is 5.  
```  
  
 To prevent the substitution of a variable value in a double\-quoted string, use the backtick character \(\`\)\(ASCII 96\), which is the [!INCLUDE[wps_2]()] escape character.  
  
 In the following example, the backtick character that precedes the first $i variable prevents [!INCLUDE[wps_2]()] from replacing the variable name with its value. For example:  
  
```  
$i = 5  
"The value of `$i is $i."  
```  
  
 The output of this command is:  
  
```  
The value $i is 5.  
```  
  
 To make double\-quotation marks appear in a string, enclose the entire string in single quotation marks. For example:  
  
```  
'As they say, "live and learn."'  
```  
  
 The output of this command is:  
  
```  
As they say, "live and learn."  
```  
  
 You can also enclose a single\-quoted string in a double\-quoted string. For example:  
  
```  
"As they say, 'live and learn.'"  
```  
  
 The output of this command is:  
  
```  
As they say, 'live and learn.'  
```  
  
 Or, double the quotation marks around a double\-quoted phrase. For example:  
  
```  
"As they say, ""live and learn."""  
```  
  
 The output of this command is:  
  
```  
As they say, "live and learn."  
```  
  
 To include a single quotation mark in a single\-quoted string, use a second consecutive single quote. For example:  
  
```  
'don''t'  
```  
  
 The output of this command is:  
  
```  
don't  
```  
  
 To force [!INCLUDE[wps_2]()] to interpret a double quotation mark literally, use a backtick character. This prevents [!INCLUDE[wps_2]()] from interpreting the quotation mark as a string delimiter. For example:  
  
```  
"Use a quotation mark (`") to begin a string."  
```  
  
 Because the contents of single\-quoted strings are interpreted literally, you cannot use the backtick character to force a literal character interpretation in a single\-quoted string.  
  
 For example, the following command generates an error because [!INCLUDE[wps_2]()] does not recognize the escape character. Instead, it interprets the second quotation mark as the end of the string.  
  
```  
PS C:\> 'Use a quotation mark (`') to begin a string.'  
Unexpected token ')' in expression or statement.  
At line:1 char:27  
+ 'Use a quotation mark (`') <<<<  to begin a string.'  
```  
  
## HERE\-STRINGS  
 The quotation rules for here\-strings are slightly different.  
  
 A here\-string is a single\-quoted or double\-quoted string in which quotation marks are interpreted literally. A here\-string can span multiple lines. All the lines in a here\-string are interpreted as strings even though they are not enclosed in quotation marks.  
  
 Like regular strings, variables are replaced by their values in double\-quoted here\-strings. In single\-quoted here\-strings, variables are not replaced by their values.  
  
 You can use here\-strings for any text, but they are particularly useful for the following kinds of text:  
  
-   \-\- Text that contains literal quotation marks  
  
-   \-\- Multiple lines of text, such as the text in an HTML or XML document  
  
-   \-\- The Help text for a script or function  
  
 A here\-string can have either of the following formats, where \<Enter\> represents the linefeed or newline hidden character that is added when you press the ENTER key.  
  
```  
 Double-quotes:  
    @"<Enter>  
    <string> [string] ...<Enter>  
    "@  
  
Single-quotes:  
    @'<Enter>  
    <string> [string] ...<Enter>  
    '@  
  
```  
  
 In either format, the closing quotation mark must be the first character in the line.  
  
 A here\-string contains all the text between the two hidden characters. In the here\-string, all quotation marks are interpreted literally. For example:  
  
```  
@"  
For help, type "get-help"  
"@  
```  
  
 The output of this command is:  
  
```  
For help, type "get-help"  
```  
  
 Using a here\-string can simplify using a string in a command. For example:  
  
```  
@"  
Use a quotation mark (') to begin a string.  
"@  
```  
  
 The output of this command is:  
  
```  
Use a quotation mark (') to begin a string.  
```  
  
 In single\-quoted here\-strings, variables are interpreted literally and reproduced exactly. For example:  
  
```  
@'  
The $profile variable contains the path  
of your Windows PowerShell profile.  
'@  
```  
  
 The output of this command is:  
  
```  
The $profile variable contains the path  
of your Windows PowerShell profile.  
```  
  
 In double\-quoted here\-strings, variables are replaced by their values. For example:  
  
```  
@"   
Even if you have not created a profile,  
the path of the profile file is:  
$profile.  
"@  
```  
  
 The output of this command is:  
  
```  
Even if you have not created a profile,  
the path of the profile file is:  
C:\Users\User01\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.  
```  
  
 Here\-strings are typically used to assign multiple lines to a variable. For example, the following here\-string assigns a page of XML to the $page variable.  
  
```  
$page = [XML] @"  
<command:command xmlns:maml="http://schemas.microsoft.com/maml/2004/10"  
xmlns:command="http://schemas.microsoft.com/maml/dev/command/2004/10"   
xmlns:dev="http://schemas.microsoft.com/maml/dev/2004/10">  
<command:details>  
        <command:name>  
               Format-Table  
        </command:name>  
        <maml:description>  
            <maml:para>Formats the output as a table.</maml:para>  
        </maml:description>  
        <command:verb>format</command:verb>  
        <command:noun>table</command:noun>  
        <dev:version></dev:version>  
</command:details>  
...  
</command:command>  
"@  
```  
  
 Here\-strings are also a convenient format for input to the ConvertFrom\-StringData cmdlet, which converts here\-strings to hash tables. For more information, see ConvertFrom\-StringData.  
  
## KEYWORDS  
 about\_Here\-Strings  
  
 about\_Quotes  
  
 about\_Quotation\_Marks  
  
## SEE ALSO  
 about\_Escape\_Characters  
  
 ConvertFrom\-StringData