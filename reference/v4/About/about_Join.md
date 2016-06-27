---
title: about_join
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba5c61cc-4742-4207-8eeb-2a9a15eb6482
---
# about_join
## TOPIC  
 about\_join  
  
## SHORT DESCRIPTION  
 Describes how the join operator \(\-join\) combines multiple strings into a single string.  
  
## LONG DESCRIPTION  
 The join operator concatenates a set of strings into a single string. The strings are appended to the resulting string in the order that they appear in the command.  
  
 Syntax  
  
 The following diagram shows the syntax for the join operator.  
  
```  
 -Join <String[]>  
<String[]> -Join <Delimiter>  
```  
  
 Parameters  
  
 String\[\]  
  
 Specifies one or more strings to be joined.  
  
 Delimiter  
  
 Specifies one or more characters placed between the concatenated strings.  
  
 The default is no delimiter \(""\).  
  
 Remarks  
  
 The unary join operator \(\-join \<string\[\]\>\) has higher precedence than a comma. As a result, if you submit a comma\-separated list of strings to the unary join operator, only the first string \(before the first comma\) is submitted to the join operator.  
  
 To use the unary join operator, enclose the strings in parentheses, or store the strings in a variable, and then submit the variable to join.  
  
 For example:  
  
```  
-join "a", "b", "c"  
a  
b  
c  
  
-join ("a", "b", "c")  
abc  
  
$z = "a", "b", "c"  
-join $z  
abc  
```  
  
 Examples  
  
 The following statement joins three strings:  
  
```  
-join ("Windows", "PowerShell", "2.0")  
WindowsPowerShell2.0  
```  
  
 The following statement joins three strings delimited by a space:  
  
```  
"Windows", "PowerShell", "2.0" -join " "  
Windows PowerShell 2.0  
```  
  
 The following statements use a multiple\-character delimiter to join three strings:  
  
```  
$a = "WIND", "SP", "ERSHELL"   
$a -join "OW"  
WINDOWSPOWERSHELL  
```  
  
 The following statement joins the lines in a here\-string into a single string. Because a here\-string is one string, the lines in the here\-string must be split before they can be joined. You can use this method to rejoin the strings in an XML file that has been saved in a here\-string:  
  
```  
$a = @'  
a  
b  
c  
'@  
  
(-split $a) -join " "  
a b c  
```  
  
## SEE ALSO  
 about\_Operators  
  
 about\_Comparison\_Operators  
  
 about\_Split