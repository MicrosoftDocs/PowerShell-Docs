---
title: about_PSConsoleHostReadLine
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9f17a26d-c97b-4ecf-97c6-d51abd2138da
---
# about_PSConsoleHostReadLine
## TOPIC  
 about\_PSConsoleHostReadLine  
  
## SHORT DESCRIPTION  
 Explains how to create a customize how [!INCLUDE[wps_1]()] reads input at the console prompt.  
  
## LONG DESCRIPTION  
 Starting in [!INCLUDE[wps_2]()] V3, you can write a function named PSConsoleHostReadLine that overrides the default way that console input is processed.  
  
## EXAMPLES  
 The following example launches Notepad and gets input from a text File that the user creates:  
  
```  
         function PSConsoleHostReadLine  
         {  
             $inputFile = Join-Path $env:TEMP PSConsoleHostReadLine  
             Set-Content $inputFile "PS > "  
  
             ## Notepad opens. Enter your command in it, save the file,  
             ## and then exit.  
             notepad $inputFile | Out-Null  
             $userInput = Get-Content $inputFile  
             $resultingCommand = $userInput.Replace("PS >", "")  
             $resultingCommand  
         }  
```  
  
## REMARKS  
 By default, [!INCLUDE[wps_2]()] reads input from the console in what is known as “Cooked Mode”—in which the Windows console subsystem handles all the keypresses, F7 menus, and other input. When you press Enter or Tab, [!INCLUDE[wps_2]()] gets the text that you have typed up to that point. There is no way for it to know that you pressed Ctrl\-R, Ctrl\-A, Ctrl\-E, or any other keys before pressing Enter or Tab. In [!INCLUDE[wps_2]()] version 3, the PSConsoleHostReadLine function solves this issue. When you define a function named PSConsoleHostReadline in the [!INCLUDE[wps_2]()] console host, [!INCLUDE[wps_2]()] calls that function instead of the “Cooked Mode” input mechanism.  
  
## SEE ALSO  
 about\_Prompts