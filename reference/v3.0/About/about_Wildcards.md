---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Wildcards
ms.technology:  powershell
ms.assetid:  9fe09a23-afce-4547-9e2f-c38090f77636
---

# about_Wildcards
```  
TOPIC  
    about_Wildcards  
  
SHORT DESCRIPTION  
    Describes how to use wildcard characters in Windows PowerShell.  
  
LONG DESCRIPTION  
    Wildcard characters represent one or many characters. You can use them  
    to create word patterns in commands. For example, to get all the files  
    in the C:\Techdocs directory that have a .ppt file name extension, type:  
  
        Get-ChildItem c:\techdocs\*.ppt  
  
    In this case, the asterisk (*) wildcard character represents any characters  
    that appear before the .ppt file name extension.   
  
    Windows PowerShell supports the following wildcard characters.  
  
        Wildcard Description        Example  Match             No match  
        -------- ------------------ -------- ----------------- --------  
        *        Matches zero or    a*       A, ag, Apple      banana  
                 more characters  
  
        ?        Matches exactly    ?n       an, in, on        ran  
                 one character in   
                 the specified   
                 position  
  
        [ ]      Matches a range    [a-l]ook book, cook, look  took  
                 of characters  
  
        [ ]      Matches specified  [bc]ook  book, cook        hook  
                 characters  
  
    You can include multiple wildcard characters in the same word pattern.  
    For example, to find text files whose names begin with the letters "a"   
    through "l", type:  
  
         Get-ChildItem c:\techdocs\[a-l]*.txt  
  
    Many cmdlets accept wildcard characters in parameter values. The   
    Help topic for each cmdlet describes which parameters, if any, permit   
    wildcard characters. For parameters in which wildcard characters are   
    accepted, their use is case-insensitive.   
  
    You can also use wildcard characters in commands and script blocks, such as  
    to create a word pattern that represents property values. For example, the  
    following command gets services in which the ServiceType property value  
    includes "Interactive".   
  
        Get-Service | Where-Object {$_.ServiceType -like "*Interactive*"}  
  
    In the following example, wildcard characters are used to find property values  
    in the conditions of an If statement. In this command, if the Description of a  
    restore point includes "PowerShell", the command adds the value of the CreationTime  
    property of the restore point to a log file.  
  
        $p = Get-ComputerRestorePoint  
        foreach ($point in $p)   
          {if ($point.description -like "*PowerShell*")   
              {add-content -path C:\TechDocs\RestoreLog.txt "$($point.CreationTime)"}}  
  
SEE ALSO  
    about_Language_Keywords  
    about_If  
    about_Script_Blocks  
```

