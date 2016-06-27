---
title: about_PowerShell_Ise.exe
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f78d2891-de05-4403-8c91-e856abbd4fb6
---
# about_PowerShell_Ise.exe
## TOPIC  
 about\_PowerShell\_Ise.exe  
  
## SHORT DESCRIPTION  
 Explains how to use the PowerShell\_Ise.exe command\-line tool. Displays the syntax and describes the command\-line switches.  
  
 PowerShell\_Ise.exe starts a [!INCLUDE[wps_2]()] Integrated Scripting Environment \(ISE\) session. You can run it in Cmd.exe and in Windows PowerShell.  
  
 To run PowerShell\_ISE.exe, type PowerShell\_ISE.exe, PowerShell\_ISE, or ISE.  
  
## LONG DESCRIPTION  
  
## SYNTAX  
  
```  
PowerShell_Ise[.exe]  
PowerShell_ISE[.exe]  
ISE[.exe]  
     [–File]<FilePath[]> [–NoProfile] [–MTA]  
     –Help | ? | -? | /?  
```  
  
## PARAMETERS  
 \-File  
  
 Opens the specified files in Windows PowerShell ISE. The parameter name \("\-File"\) is optional. To list more than one file, enter one text string enclosed in quotation marks. Use commas to separate the file names within the string.  
  
 For example:  
  
```  
PowerShell_ISE -File "File1.ps1,File2.ps1,File3.xml".  
```  
  
 Spaces between the file names are permitted in Windows PowerShell, but might not be interpreted correctly by other programs, such as Cmd.exe.  
  
 You can use this parameter to open any text file, including Windows PowerShell script files and XML files.  
  
 \-Mta  
  
 Starts Windows PowerShell ISE using a multi\-threaded apartment. This parameter is introduced in Windows PowerShell 3.0. Single\-threaded apartment \(STA\) is the default.  
  
 \-NoProfile  
  
 Does not run Windows PowerShell profiles. By default, Windows PowerShell profiles are run in every session.  
  
 This parameter is recommended when you are writing shared content, such as functions and scripts that will be run on systems with different profiles. For more information, see about\_Profiles \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113729\).  
  
 \-Help, \-?, \/?  
  
 Displays help for PowerShell\_ISE.exe.  
  
## EXAMPLES  
 These commands start [!INCLUDE[wps_2]()] ISE. The commands are equivalent and can be used interchangeably.  
  
```  
PS C:\>PowerShell_ISE.exe  
PS C:\>PowerShell_ISE  
PS C:\>ISE  
```  
  
 These commands open the Get\-Profile.ps1 script in [!INCLUDE[wps_2]()] ISE. The commands are equivalent and can be used interchangeably.  
  
```  
PS C:\>PowerShell_ISE.exe -File .\Get-Profile.ps1  
PS C:\>ISE -File .\Get-Profile.ps1  
PS C:\>ISE .\Get-Profile.ps1  
```  
  
 This command opens the Get\-Backups.ps1 and Get\-BackupInstance.ps1 scripts in [!INCLUDE[wps_2]()] ISE. To open more than one file, use a comma to separate the file names and enclose the entire file name value in quotation marks.  
  
```  
PS C:\>ISE -File ".\Get-Backups.ps1,Get-BackupInstance.ps1"  
```  
  
 This command starts [!INCLUDE[wps_2]()] ISE with no profiles.  
  
```  
PS C:\>ISE -NoProfile  
```  
  
 This command gets help for PowerShell\_ISE.exe.  
  
```  
PS C:\>ISE -help  
```  
  
## SEE ALSO  
 about\_PowerShell.exe  
  
 about\_Windows\_PowerShell\_ISE  
  
 [!INCLUDE[wps_2]()] 3.0 Integrated Scripting Environment \(ISE\)