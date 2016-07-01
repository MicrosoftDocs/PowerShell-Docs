---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  PowerShell_ISE.exe Command Line Help
ms.technology:  powershell
robots:  noindex,nofollow
ms.assetid:  c220acec-181c-4b60-bc5c-71ca25e2d542
---

# PowerShell_ISE.exe Command-Line Help
Starts [!INCLUDE[mshgraphicalhost]()]. You can use PowerShell\_ISE.exe to start [!INCLUDE[mshgraphicalhostshort]()] at the Windows PowerShell command line or the command line of another tool, such as Cmd.exe. Use the parameters to customize the session.  
  
 To run the PowerShell\_ISE.exe executable file that starts [!INCLUDE[mshgraphicalhostshort]()], type PowerShell\_ISE.exe, PowerShell\_ISE or ISE.  
  
## Syntax  
  
```  
  
PowerShell_ISE[.exe]  
ISE[.exe]  
       [–File]<FilePath[]> [–NoProfile] [–MTA]  
       –Help | ? | -? | /?  
  
```  
  
## Parameters  
  
### \-File  
 Opens the specified files in [!INCLUDE[mshgraphicalhostshort]()]. The parameter name \("\-File"\) is optional.  
  
 To list more than one file, enter one text string enclosed in quotation marks. Use commas to separate the file names within the string. For example, `PowerShell_ISE -File "File1.ps1,File2.ps1,File3.xml"`. Spaces between the file names are permitted in Windows PowerShell, but might not be interpreted correctly by other programs, such as Cmd.exe.  
  
 You can use this parameter to open any text file, including [!INCLUDE[mshshort]()] script files and XML files.  
  
 [!INCLUDE[ps_sdk_paramintrodps3]()]. To open a file in ISE in [!INCLUDE[psversion2]()], type the file name without the **\-File** parameter. For example, `PowerShell_ISE File1.ps1`.  
  
### \-Mta  
 Starts [!INCLUDE[mshgraphicalhostshort]()] using a multi\-threaded apartment. [!INCLUDE[ps_sdk_paramintrodps3]()] Single\-threaded apartment \(STA\) is the default.  
  
 [!INCLUDE[ps_sdk_paramintrodps3]()]  
  
### \-NoProfile  
 Does not load the Windows PowerShell profiles. By default, Windows PowerShell profiles are loaded into the session.  
  
 This parameter is recommended when you are writing shared content, such as functions and scripts that will be run on systems with different profiles. For more information, see [about\_Profiles](about_Profiles.md).  
  
 [!INCLUDE[ps_sdk_paramintrodps3]()]  
  
### \-Help, \-?, \/?  
 Displays help for PowerShell\_ISE.exe.  
  
 [!INCLUDE[ps_sdk_paramintrodps3]()]  
  
## EXAMPLES  
 These commands start [!INCLUDE[mshgraphicalhostshort]()]. The commands are equivalent and can be used interchangeably.  
  
```  
  
PS C:\>PowerShell_ISE.exe  
PS C:\>PowerShell_ISE  
PS C:\>ISE  
  
```  
  
 These commands open the Get\-Profile.ps1 script in Windows PowerShell ISE. The commands are equivalent and can be used interchangeably.  
  
```  
  
PS C:\>PowerShell_ISE.exe -File .\Get-Profile.ps1  
PS C:\>ISE -File .\Get-Profile.ps1  
PS C:\>ISE .\Get-Profile.ps1  
  
```  
  
 This command opens the Get\-Backups.ps1 and Get\-BackupInstance.ps1 scripts in [!INCLUDE[mshgraphicalhostshort]()]. To open more than one file, use a comma to separate the file names and enclose the entire file name value in quotation marks.  
  
```  
PS C:\>ISE -File ".\Get-Backups.ps1,Get-BackupInstance.ps1"  
```  
  
 This command starts [!INCLUDE[mshgraphicalhostshort]()] with no profiles.  
  
```  
PS C:\>ISE -NoProfile  
```  
  
 This command gets help for PowerShell\_ISE.exe.  
  
```  
PS C:\>ISE -help  
```  
  
## See Also  
 [PowerShell\_ISE.exe Console Help](PowerShell_ISE.exe-Command-Line-Help.md)   
 [about\_Windows\_PowerShell\_ISE](about_Windows_PowerShell_ISE.md)   
 [Windows PowerShell 3.0 Integrated Scripting Environment \(ISE\)](assetId:///dd8fe61e-969d-4cc3-97a1-0132c6253437)

