---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_ForEach
ms.technology:  powershell
ms.assetid:  50b1bd2b-d061-4d60-84d9-33e422dba357
---

# about_ForEach
```  
TOPIC  
    about_Foreach  
  
SHORT DESCRIPTION  
    Describes a language command you can use to traverse all the items in a   
    collection of items.  
  
LONG DESCRIPTION  
    The Foreach statement (also known as a Foreach loop) is a language   
    construct for stepping through (iterating) a series of values in a   
    collection of items.  
  
    The simplest and most typical type of collection to traverse is an array.  
    Within a Foreach loop, it is common to run one or more commands against  
    each item in an array.  
  
  Syntax          
      The following shows the Foreach syntax:  
  
          foreach ($<item> in $<collection>){<statement list>}  
  
  The Foreach Statement Outside a Command Pipeline  
      The part of the Foreach statement enclosed in parenthesis represents a  
      variable and a collection to iterate. Windows PowerShell creates the   
      variable ($<item>) automatically when the Foreach loop runs. Prior to   
      each iteration through the loop, the variable is set to a value in the   
      collection. The block following a Foreach statement {<statement list>}  
      contains a set of commands to execute against each item in a collection.  
  
  Examples  
      For example, the Foreach loop in the following example displays the   
      values in the $letterArray array.  
  
          $letterArray = "a","b","c","d"  
          foreach ($letter in $letterArray)  
          {  
              Write-Host $letter  
          }  
  
      In this example, the $letterArray array is created and initialized with   
      the string values "a", "b", "c", and "d". The first time the Foreach   
      statement runs, it sets the $letter variable equal to the first item in   
      $letterArray ("a"). Then, it uses the Write-Host cmdlet to display the   
      letter a. The next time through the loop, $letter is set to "b", and so   
      on. After the Foreach loop displays the letter d, Windows PowerShell   
      exits the loop.  
  
      The entire Foreach statement must appear on a single line to run it as a  
      command at the Windows PowerShell command prompt. The entire Foreach   
      statement does not have to appear on a single line if you place the   
      command in a .ps1 script file instead.  
  
      Foreach statements can also be used together with cmdlets that   
      return a collection of items. In the following example, the Foreach   
      statement steps through the list of items that is returned by the   
      Get-ChildItem cmdlet.  
  
          foreach ($file in Get-ChildItem)  
          {  
              Write-Host $file  
          }  
  
      You can refine the example by using an If statement to limit the results   
      that are returned. In the following example, the Foreach statement   
      performs the same looping operation as the previous example, but it adds  
      an If statement to limit the results to files that are greater than 100   
      kilobytes (KB):  
  
          foreach ($file in Get-ChildItem)  
          {  
              if ($file.length -gt 100KB)   
              {  
                  Write-Host $file  
              }  
          }  
  
      In this example, the Foreach loop uses a property of the $file variable  
      to perform a comparison operation ($file.length -gt 100KB). The $file   
      variable contains all the properties in the object that is returned by   
      the Get-ChildItem cmdlet. Therefore, you can return more than just a   
      file name. In the next example, Windows PowerShell returns the length and  
      the last access time inside the statement list:  
  
          foreach ($file in Get-ChildItem)  
          {  
              if ($file.length -gt 100KB)   
              {  
                  Write-Host $file  
                  Write-Host $file.length  
                  Write-Host $file.lastaccesstime  
              }  
          }  
  
      In this example, you are not limited to running a single command in a   
      statement list.  
  
      You can also use a variable outside a Foreach loop and increment the   
      variable inside the loop. The following example counts files over 100 KB  
      in size:  
  
          $i = 0  
          foreach ($file in Get-ChildItem)  
          {  
              if ($file.length -gt 100KB)   
              {  
                  Write-Host $file "file size:" ($file.length /   
          1024).ToString("F0") KB  
                  $i = $i + 1  
              }  
          }  
  
          if ($i -ne 0)  
          {  
              Write-Host  
              Write-Host $i " file(s) over 100 KB in the current   
          directory."}  
          else   
          {  
              Write-Host "No files greater than 100 KB in the current   
          directory."  
          }  
  
      In the preceding example, the $i variable is set to 0 outside the loop,  
      and the variable is incremented inside the loop for each file that is  
      found that is larger than 100 KB. When the loop exits, an If statement  
      evaluates the value of $i to display a count of all the files over   
      100 KB. Or, it displays a message stating that no files over 100 KB were  
      found.  
  
      The previous example also demonstrates how to format the file length   
      results:  
  
          ($file.length / 1024).ToString("F0")  
  
      The value is divided by 1,024 to show the results in kilobytes rather   
      than bytes, and the resulting value is then formatted using the   
      fixed-point format specifier to remove any decimal values from the   
      result. The 0 makes the format specifier show no decimal places.  
  
  The Foreach Statement Inside a Command Pipeline  
      When Foreach appears in a command pipeline, Windows PowerShell uses the  
      foreach alias, which calls the ForEach-Object command. When you use   
      the foreach alias in a command pipeline, you do not include   
      the ($<item> in $<collection>) syntax as you do with the Foreach   
      statement. This is because the prior command in the pipeline provides   
      this information. The syntax of the foreach alias when used in a command  
      pipeline is as follows:  
  
          <command> | foreach {<command_block>}  
  
      For example, the Foreach loop in the following command displays processes  
      whose working set (memory usage) is greater than 20 megabytes (MB).   
  
      The Get-Process command gets all of the processes on the computer. The   
      Foreach alias performs the commands in the script block on each process  
      in sequence.   
  
      The IF statement selects processes with a working set (WS) greater than  
      20 megabytes. The Write-Host cmdlet writes the name of the process followed  
      by a colon. It divides the working set value, which is stored in bytes  
      by 1 megabyte to get the working set value in megabytes. Then it converts the  
      result from a double to a string. It displays the value as a fixed point  
      number with zero decimals (F0), a space separator (" "), and then "MB".  
  
          Write-Host "Processes with working sets greater than 20 MB."  
          Get-Process | foreach {   
             if ($_.WS -gt 20MB)  
             { Write-Host $_.name ": " ($_.WS/1MB).ToString("F0") MB -Separator ""}  
          }  
  
      The foreach alias also supports beginning command blocks, middle command  
      blocks, and end command blocks. The beginning and end command blocks run  
      once, and the middle command block runs every time the Foreach loop steps  
      through a collection or array.  
  
      The syntax of the foreach alias when used in a command pipeline with a   
      beginning, middle, and ending set of command blocks is as follows:  
  
          <command> | foreach {<beginning command_block>}{<middle   
          command_block>}{<ending command_block>}  
  
      The following example demonstrates the use of the beginning, middle, and  
      end command blocks.  
  
          Get-ChildItem | foreach {  
          $fileCount = $directoryCount = 0}{  
          if ($_.PsIsContainer) {$directoryCount++} else {$fileCount++}}{  
          "$directoryCount directories and $fileCount files"}  
  
      The beginning block creates and initializes two variables to 0:  
  
          {$fileCount = $directoryCount = 0}  
  
      The middle block evaluates whether each item returned by Get-ChildItem  
      is a directory or a file:  
  
          {if ($_.PsIsContainer) {$directoryCount++} else {$fileCount++}}  
  
      If the item that is returned is a directory, the $directoryCount   
      variable is incremented by 1. If the item is not a directory,   
      the $fileCount variable is incremented by 1. The ending block runs after  
      the middle block completes its looping operation and then returns the   
      results of the operation:  
  
          {"$directoryCount directories and $fileCount files"}  
  
      By using the beginning, middle, and ending command block structure and   
      the pipeline operator, you can rewrite the earlier example to find any   
      files that are greater than 100 KB, as follows:  
  
          Get-ChildItem | foreach{  
              $i = 0}{  
              if ($_.length -gt 100KB)  
              {  
                  Write-Host $_.name "file size:" ($_.length /   
          1024).ToString("F0") KB  
                  $i++  
              }  
              }{  
              if ($i -ne 0)  
              {  
                  Write-Host  
                  Write-Host "$i file(s) over 100 KB in the current   
          directory."  
              }  
              else   
              {  
              Write-Host "No files greater than 100 KB in the current   
          directory."}  
              }  
  
SEE ALSO  
    about_Automatic_Variables  
    about_If  
    Foreach-Object  
  
```

