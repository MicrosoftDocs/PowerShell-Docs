---
title: about_Regular_Expressions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b8dfae27-fb64-4d24-b065-fbc9bee88ae3
---
# about_Regular_Expressions
Insert introduction here.  
  
## TOPIC  
 about\_Regular\_Expressions  
  
## SHORT DESCRIPTION  
 Describes regular expressions in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] supports the following regular expression characters.  
  
```  
Format   Logic                            Example  
-------- -------------------------------  -----------------------  
value    Matches exact characters         "book" -match "oo"  
         anywhere in the original value.  
  
.        Matches any single character.    "copy" -match "c..y"  
  
[value]  Matches at least one of the      "big" -match "b[iou]g"  
         characters in the brackets.  
  
[range]  Matches at least one of the      "and" -match "[a-e]nd"  
         characters within the range.  
         The use of a hyphen (–) allows   
         you to specify an adjacent   
         character.  
  
[^]      Matches any characters except    "and" -match "[^brt]nd"  
         those in brackets.  
  
^        Matches the beginning            "book" -match "^bo"  
         characters.  
  
$        Matches the end characters.      "book" -match "ok$"  
  
*        Matches any instances            "baggy" -match "g*"  
         of the preceding character.  
  
?        Matches zero or one instance     "baggy" -match "g?"  
         of the preceding character.  
  
\        Matches the character that       "Try$" -match "Try\$"  
         follows as an escaped character.  
```  
  
 [!INCLUDE[wps_2]()] supports the character classes available in Microsoft .NET Framework regular expressions.  
  
```  
Format   Logic                            Example  
-------- -------------------------------  -----------------------  
\p{name} Matches any character in the     "abcd defg" -match "\p{Ll}+"  
         named character class specified   
         by {name}. Supported names are   
         Unicode groups and block   
         ranges such as Ll, Nd,   
         Z, IsGreek, and IsBoxDrawing.  
  
\P{name} Matches text not included in     1234 -match "\P{Ll}+"  
         the groups and block ranges   
         specified in {name}.  
  
\w       Matches any word character.      "abcd defg" -match "\w+"  
         Equivalent to the Unicode        (this matches abcd)  
         character categories [\p{Ll}  
         \p{Lu}\p{Lt}\p{Lo}\p{Nd}\p{Pc}].   
         If ECMAScript-compliant behavior   
         is specified with the ECMAScript   
         option, \w is equivalent to   
         [a-zA-Z_0-9].  
  
\W       Matches any nonword character.   "abcd defg" -match "\W+"  
         Equivalent to the Unicode        (This matches the space)  
         categories [^\p{Ll}\p{Lu}\p{Lt}  
         \p{Lo}\p{Nd}\p{Pc}].  
  
\s       Matches any white-space          "abcd defg" -match "\s+"  
         character.  Equivalent to the   
         Unicode character categories   
         [\f\n\r\t\v\x85\p{Z}].  
  
\S       Matches any non-white-space      "abcd defg" -match "\S+"  
         character. Equivalent to the   
         Unicode character categories   
         [^\f\n\r\t\v\x85\p{Z}].  
  
\d       Matches any decimal digit.       12345 -match "\d+"  
         Equivalent to \p{Nd} for   
         Unicode and [0-9] for non-  
         Unicode behavior.  
  
\D       Matches any nondigit.            "abcd" -match "\D+"  
         Equivalent  to \P{Nd} for   
         Unicode and [^0-9] for non-  
         Unicode behavior.  
```  
  
 [!INCLUDE[wps_2]()] supports the quantifiers available in .NET Framework regular expressions. The following are some examples of quantifiers.  
  
```  
Format   Logic                            Example  
-------- -------------------------------  -----------------------  
*        Specifies zero or more matches;  "abc" -match "\w*"  
         for example, \w* or (abc)*.   
         Equivalent to {0,}.  
  
+        Matches repeating instances of   "xyxyxy" -match "xy+"  
         the preceding characters.  
  
?        Specifies zero or one matches;   "abc" -match "\w?"  
         for example, \w? or (abc)?.   
         Equivalent to {0,1}.  
  
{n}      Specifies exactly n matches;     "abc" -match "\w{2}"  
         for example, (pizza){2}.   
  
{n,}     Specifies at least n matches;    "abc" -match "\w{2,}"  
         for example, (abc){2,}.   
  
{n,m}    Specifies at least n, but no     "abc" -match "\w{2,3}"  
         more than m, matches.  
```  
  
 All the comparisons shown in the preceding table evaluate to true.  
  
 Notice that the escape character for regular expressions, a backslash \(\\\), is different from the escape character for [!INCLUDE[wps_2]()]. The escape character for [!INCLUDE[wps_2]()] is the backtick character \(\`\) \(ASCII 96\).  
  
 For more information, see the "Regular Expression Language Elements" topic in the Microsoft Developer Network \(MSDN\) library at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133231.  
  
## SEE ALSO  
 about\_Comparison\_Operators  
  
 about\_Operators