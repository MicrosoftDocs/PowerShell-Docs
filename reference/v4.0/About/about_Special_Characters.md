---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Special_Characters
ms.technology:  powershell
ms.assetid:  6eeb395a-cdab-4323-9466-537254a64fb8
---

# about_Special_Characters
## TOPIC  
 about\_Special\_Characters  
  
## SHORT DESCRIPTION  
 Describes the special characters that you can use to control how [!INCLUDE[wps_1]()] interprets the next character in a command or parameter.  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] supports a set of special character sequences that are used to represent characters that are not part of the standard character set.  
  
 The special characters in [!INCLUDE[wps_2]()] begin with the backtick character, also known as the grave accent \(ASCII 96\).  
  
 The following special characters are recognized by [!INCLUDE[wps_2]()]:  
  
```  
`0    Null  
`a    Alert  
`b    Backspace  
`f    Form feed  
`n    New line  
`r    Carriage return  
`t    Horizontal tab  
`v    Vertical tab  
--%   Stop parsing  
```  
  
 These characters are case\-sensitive.  
  
## NULL \(\`0\)  
 [!INCLUDE[wps_2]()] recognizes a null special character \(\`0\) and represents it with a character code of 0. It appears as an empty space in the [!INCLUDE[wps_2]()] output. This allows you to use [!INCLUDE[wps_2]()] to read and process text files that use null characters, such as string termination or record termination indicators. The null special character is not equivalent to the $null variable, which stores a value of NULL.  
  
## ALERT \(\`a\)  
 The alert \(\`a\) character sends a beep signal to the computer's speaker. You can use this to warn a user about an impending action. The following command sends two beep signals to the local computer's speaker:  
  
```  
for ($i = 0; $i -le 1; $i++){"`a"}  
```  
  
## BACKSPACE \(\`b\)  
 The backspace character \(\`b\) moves the cursor back one character, but it does not delete any characters. The following command writes the word "backup", moves the cursor back twice, and then writes the word "out" \(preceded by a space and starting at the new position\):  
  
```  
"backup`b`b out"  
```  
  
 The output from this command is as follows:  
  
```  
back out  
```  
  
## FORM FEED \(\`f\)  
 The form feed character \(\`f\) is a print instruction that ejects the current page and continues printing on the next page. This character affects printed documents only; it does not affect screen output.  
  
## NEW LINE \(\`n\)  
 The new line character \(\`n\) inserts a line break immediately after the character.  
  
 The following example shows how to use the new line character in a Write\-Host command:  
  
```  
"There are two line breaks`n`nhere."  
```  
  
 The output from this command is as follows:  
  
```  
There are two line breaks  
  
here.  
```  
  
## CARRIAGE RETURN \(\`r\)  
 The carriage return character \(\`r\) eliminates the entire line prior to the \`r character, as though the prior text were on a different line.  
  
 For example:  
  
```  
Write-Host "Let's not move`rDelete everything before this point."  
```  
  
 The output from this command is:  
  
```  
Delete everything before this point.  
```  
  
## HORIZONTAL TAB \(\`t\)  
 The horizontal tab character \(\`t\) advances to the next tab stop and continues writing at that point. By default, the [!INCLUDE[wps_2]()] console has a tab stop at every eighth space.  
  
 For example, the following command inserts two tabs between each column.  
  
```  
"Column1`t`tColumn2`t`tColumn3"  
```  
  
 The output from this command is:  
  
```  
Column1         Column2         Column3  
```  
  
## VERTICAL TAB \(\`v\)  
 The horizontal tab character \(\`t\) advances to the next vertical tab stop and writes all subsequent output beginning at that point. This character affects printed documents only. It does not affect screen output.  
  
## STOP PARSING  \(\-\-%\)  
 The stop\-parsing symbol \(\-\-%\) prevents [!INCLUDE[wps_2]()] from interpreting arguments in program calls as [!INCLUDE[wps_2]()] commands and expressions.  
  
 Place the stop\-parsing symbol after the program name and before program arguments that might cause errors.  
  
 For example, the following Icacls command uses the stop\-parsing symbol.  
  
```  
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F  
```  
  
 [!INCLUDE[wps_2]()] sends the following command to Icacls.  
  
```  
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F  
```  
  
 For more information about the stop\-parsing symbol, see about\_Parsing.  
  
## KEYWORDS  
 about\_Punctuation  
  
 about\_Symbols  
  
## SEE ALSO  
 about\_Quoting\_Rules  
  
 about\_Escape\_Characters

