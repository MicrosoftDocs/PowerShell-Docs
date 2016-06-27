---
title: about_Reserved_Words
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3dc2da5-d6c3-4a28-8a13-51fbc61c4e51
---
# about_Reserved_Words
## TOPIC  
 about\_Reserved\_Words  
  
## SHORT DESCRIPTION  
 Lists the reserved words that cannot be used as identifiers because they have a special meaning in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 There are certain words that have special meaning in [!INCLUDE[wps_2]()]. When these words appear without quotation marks, [!INCLUDE[wps_2]()] attempts to apply their special meaning rather than treating them as character strings. To use these words as parameter arguments in a command or script without invoking their special meaning, enclose the reserved words in quotation marks.  
  
 The following are the reserved words in [!INCLUDE[wps_2]()]:  
  
```  
Begin              Exit               Process  
Break              Filter             Return  
Catch              Finally            Sequence  
Class              For                Switch  
Continue           ForEach            Throw  
Data               From               Trap  
Define             Function           Try  
Do                 If                 Until  
DynamicParam       In                 Using  
Else               InlineScript       Var  
ElseIf             Parallel           While  
End                Param              Workflow  
```  
  
 For more information about language statements, including Foreach, If, For, and While, type "Get\-help", type the prefix "about\_", and then type the name of the statement. For example, to get information about the Foreach statement, type:  
  
```  
Get-Help about_ForEach  
```  
  
 For information about the Filter statement or the Return statement syntax, type:  
  
```  
Get-Help about_Functions  
```  
  
 For information about other reserved words, type:  
  
```  
Get-Help <Reserved_Word>  
```  
  
## SEE ALSO  
 about\_Command\_Syntax  
  
 about\_Escape\_Characters  
  
 about\_Language\_Keywords  
  
 about\_Parsing  
  
 about\_Quoting\_Rules  
  
 about\_Script\_Blocks  
  
 about\_Special\_Characters