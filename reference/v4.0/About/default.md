---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  default
ms.technology:  powershell
ms.assetid:  11042b16-0f0b-4d9a-b02d-2e8b98d61dc2
---

# default
```  
  
TOPIC  
    Windows PowerShell Help System  
  
SHORT DESCRIPTION  
    Displays help about Windows PowerShell cmdlets and concepts.   
  
LONG DESCRIPTION  
    Windows PowerShell Help describes Windows PowerShell cmdlets,  
    functions, scripts, and modules, and explains concepts, including  
    the elements of the Windows PowerShell language.  
  
    Windows PowerShell does not include help files, but you can read the  
    help topics online, or use the Update-Help cmdlet to download help files  
    to your computer and then use the Get-Help cmdlet to display the help  
    topics at the command line.  
  
    You can also use the Update-Help cmdlet to download updated help files  
    as they are released so that your local help content is never obsolete.   
  
    Without help files, Get-Help displays auto-generated help for cmdlets,   
    functions, and scripts.  
  
  ONLINE HELP      
    You can find help for Windows PowerShell online in the TechNet Library  
    beginning at http://go.microsoft.com/fwlink/?LinkID=108518.   
  
    To open online help for any cmdlet or function, type:  
  
        Get-Help <cmdlet-name> -OnlineUPDATE-HELP  
    To download and install help files on your computer:  
  
       1. Start Windows PowerShell with the "Run as administrator" option.  
       2. Type:  
  
          Update-Help  
  
    After the help files are installed, you can use the Get-Help cmdlet to  
    display the help topics. You can also use the Update-Help cmdlet to  
    download updated help files so that your local help files are always  
    up-to-date.  
  
    For more information about the Update-Help cmdlet, type:  
  
       Get-Help Update-Help -Online  
  
    or go to: http://go.microsoft.com/fwlink/?LinkID=210614  
  
  GET-HELP  
    The Get-Help cmdlet displays help at the command line from content in  
    help files on your computer. Without help files, Get-Help displays basic  
    help about cmdlets and functions. You can also use Get-Help to display  
    online help for cmdlets and functions.  
  
    To get help for a cmdlet, type:  
  
        Get-Help <cmdlet-name>  
  
    To get online help, type:  
  
        Get-Help <cmdlet-name> -Online      
  
    The titles of conceptual topics begin with "About_".  
    To get help for a concept or language element, type:  
  
        Get-Help About_<topic-name>  
  
    To search for a word or phrase in all help files, type:  
  
        Get-Help <search-term>  
  
    For more information about the Get-Help cmdlet, type:  
  
        Get-Help Get-Help -Online  
  
    or go to: http://go.microsoft.com/fwlink/?LinkID=113316  
  
  EXAMPLES:  
      Save-Help              : Download help files from the Internet and saves  
                               them on a file share.  
      Update-Help            : Downloads and installs help files from the  
                               Internet or a file share.  
      Get-Help Get-Process   : Displays help about the Get-Process cmdlet.     
      Get-Help Get-Process -Online  
                             : Opens online help for the Get-Process cmdlet.                              
      Help Get-Process       : Displays help about Get-Process one page at a time.  
      Get-Process -?         : Displays help about the Get-Process cmdlet.        
      Get-Help About_Modules : Displays help about Windows PowerShell modules.  
      Get-Help remoting      : Searches the help topics for the word "remoting."  
  
  SEE ALSO:  
      about_Updatable_HelpGet-HelpSave-HelpUpdate-Help  
```

