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
```  
TOPIC  
    about_Reserved_Words  
  
SHORT DESCRIPTION  
    Lists the reserved words that cannot be used as identifiers because they  
    have a special meaning in Windows PowerShell.  
  
LONG DESCRIPTION  
    There are certain words that have special meaning in Windows PowerShell.   
    When these words appear without quotation marks, Windows PowerShell   
    attempts to apply their special meaning rather than treating them as   
    character strings. To use these words as parameter arguments in a command  
    or script without invoking their special meaning, enclose the reserved   
    words in quotation marks.  
  
    The following are the reserved words in Windows PowerShell:  
  
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
  
    For more information about language statements, including Foreach, If,   
    For, and While, type "Get-help", type the prefix "about_", and then type  
    the name of the statement. For example, to get information about the   
    Foreach statement, type:  
  
    Get-Help about_ForEach  
  
    For information about the Filter statement or the Return statement   
    syntax, type:  
  
        Get-Help about_Functions  
  
   For information about other reserved words, type:  
  
        Get-Help <Reserved_Word>  
  
SEE ALSO  
    about_Command_Syntax  
    about_Escape_Characters  
    about_Language_Keywords  
    about_Parsing  
    about_Quoting_Rules  
    about_Script_Blocks  
    about_Special_Characters  
```