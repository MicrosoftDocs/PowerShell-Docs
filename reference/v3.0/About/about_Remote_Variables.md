---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Remote_Variables
ms.technology:  powershell
ms.assetid:  a31e2e7f-7c66-492c-86ef-d588912feb7d
---

# about_Remote_Variables
```  
TOPIC  
    about_Remote_Variables  
  
SHORT DESCRIPTION  
    Explains how to use local and remote variables in remote  
    commands.  
  
LONG DESCRIPTION  
    You can use variables in commands that you run on remote  
    computers. Simply assign a value to the variable and then  
    use the variable in place of the value.  
  
    By default, the variables in remote commands are assumed  
    to be defined in the session in which the command runs. You  
    can also use variables that are defined in the local session,  
    but you must identify them as local  
    variables in the command.  
  
 USING REMOTE VARIABLES  
  
    Windows PowerShell assumes that the variables used in remote  
    commands  are defined in the session in which the command runs.  
  
    In the following example, the $ps variable is defined in the  
    temporary  session in which the Get-WinEvent command runs.  
  
        PS C:\>Invoke-Command -ComputerName S1 -ScriptBlock {$ps = "Windows PowerShell"; Get-WinEvent -LogName $ps}  
  
    Similarly, when the command runs in a persistent session (PSSession),   
    the remote variable must be defined in the same PSSession.  
  
        PS C:\>$s = New-PSSession -ComputerName S1  
  
        PS C:\>Invoke-Command -ComputerName S1 -ScriptBlock {$ps = "Windows PowerShell"}  
  
        PS C:\>Invoke-Command -Sessions $s -ScriptBlock {Get-WinEvent -LogName $ps}  
  
 USING LOCAL VARIABLES  
  
    You can also use local variables in remote commands, but you must  
    indicate that the variable is defined in the local session.  
  
    Beginning in Windows PowerShell 3.0, you can use the Using scope  
    modifier to identify a local variable in a remote command.  
  
    The syntax of Using is as follows:  
  
       The syntax is:  
           $Using:<VariableName>  
  
    In the following example, the $ps variable is created in the local  
    session, but is used in the session in which the command runs. The  
    Using scope modifier identifies $ps as a local variable.  
  
        PS C:\>$ps = "Windows PowerShell"  
        PS C:\>Invoke-Command -ComputerName S1 -ScriptBlock {Get-WinEvent -LogName $Using:ps}  
  
    You can also use the Using scope modifier in PSSessions.  
  
        PS C:\>$s = New-PSSession -ComputerName S1  
  
        PS C:\>$ps = "Windows PowerShell"  
  
        PS C:\>Invoke-Command -Sessions $s -ScriptBlock {Get-WinEvent -LogName $Using:ps}  
  
 USING LOCAL VARIABLES IN WINDOWS POWERSHELL 2.0  
  
    You can use local variables in a remote command by defining parameters  
    for the remote command and using the ArgumentList parameter of the   
    Invoke-Command cmdlet to specify the local variable as the parameter  
    value.  
  
    This command format is valid on Windows PowerShell 2.0 and later versions  
    of Windows PowerShell.  
  
      -- Use the param keyword to define parameters for the remote command.   
         The parameter names are placeholders that do not need to match the  
         name of the local variable.   
  
      -- Use the parameters defined by the param keyword in the command.  
  
      -- Use the ArgumentList parameter of the Invoke-Command cmdlet to  
         specify the local variable as the parameter value.  
  
     For example, the following commands define the $ps variable in the local   
     session and then use it in a remote command. The command uses $log as   
     the parameter name and the local variable, $ps, as its value.  
  
      C:\PS>$ps = "Windows PowerShell"  
  
      C:\PS>Invoke-Command -ComputerName S1 -ScriptBlock {param($log) Get-WinEvent -logname $log} -ArgumentList $ps  
  
 KEYWORDS  
    about_Using  
  
 SEE ALSO  
    about_Remote  
    about_PSSessions  
    about_Scopes  
    Enter-PSSession  
    Invoke-Command  
    New-PSSession  
  
```

