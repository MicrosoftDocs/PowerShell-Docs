---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Execution_Policies
ms.technology:  powershell
ms.assetid:  411d5d78-4d92-4d76-bfc1-ff3461cb8885
---

# about_Execution_Policies
## TOPIC  
 about\_Execution\_Policies  
  
## SHORT DESCRIPTION  
 Describes the [!INCLUDE[wps_1]()] execution policies and explains how to manage them.  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] execution policies let you determine the conditions under which [!INCLUDE[wps_2]()] loads configuration files and runs scripts.  
  
 You can set an execution policy for the local computer, for the current user, or for a particular session. You can also use a Group Policy setting to set execution policy for computers and users.  
  
 Execution policies for the local computer and current user are stored in the registry. You do not need to set execution policies in your [!INCLUDE[wps_2]()] profile. The execution policy for a particular session is stored only in memory and is lost when the session is closed.  
  
 The execution policy is not a security system that restricts user actions. For example, users can easily circumvent a policy by typing the script contents at the command line when they cannot run a script. Instead, the execution policy helps users to set basic rules and prevents them from violating them unintentionally.  
  
### WINDOWS POWERSHELL EXECUTION POLICIES  
 The [!INCLUDE[wps_2]()] execution policies are as follows:  
  
 "Restricted" is the default policy.  
  
#### RESTRICTED  
 \- Default execution policy in Windows 8, Windows Server 2012, and Windows 8.1.  
  
 \- Permits individual commands, but will not run scripts.  
  
 \- Prevents running of all script files, including formatting and configuration files \(.ps1xml\), module script files \(.psm1\), and [!INCLUDE[wps_2]()] profiles \(.ps1\).  
  
#### ALLSIGNED  
 \- Scripts can run.  
  
 \- Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.  
  
 \- Prompts you before running scripts from publishers that you have not yet classified as trusted or untrusted.  
  
 \- Risks running signed, but malicious, scripts.  
  
#### REMOTESIGNED  
 \- Scripts can run. This is the default execution policy in Windows Server 2012 R2.  
  
 \- Requires a digital signature from a trusted publisher on scripts and configuration files that are downloaded from the Internet \(including e\-mail and instant messaging programs\).  
  
 \- Does not require digital signatures on scripts that you have written on the local computer \(not downloaded from the Internet\).  
  
 \- Runs scripts that are downloaded from the Internet and not signed, if the scripts are unblocked, such as by using the Unblock\-File cmdlet.  
  
 \- Risks running unsigned scripts from sources other than the Internet and signed, but malicious, scripts.  
  
#### UNRESTRICTED  
 \- Unsigned scripts can run. \(This risks running malicious scripts.\)  
  
 \- Warns the user before running srcipts and configuration files that are downloaded from the Internet.  
  
#### BYPASS  
 \- Nothing is blocked and there are no warnings or prompts.  
  
 \- This execution policy is designed for configurations in which a [!INCLUDE[wps_2]()] script is built in to a larger application or for configurations in which [!INCLUDE[wps_2]()] is the foundation for a program that has its own security model.  
  
#### UNDEFINED  
 \- There is no execution policy set in the current scope.  
  
 \- If the execution policy in all scopes is Undefined, the effective execution policy is Restricted, which is the default execution policy.  
  
 Note: On systems that do not distinguish Universal Naming Convention \(UNC\) paths from Internet paths, scripts that are identified by a UNC path might not be permitted to run with the RemoteSigned execution policy.  
  
### EXECUTION POLICY SCOPE  
 You can set an execution policy that is effective only in a particular scope.  
  
 The valid values for Scope are Process, CurrentUser, and LocalMachine. LocalMachine is the default when setting an execution policy.  
  
 The Scope values are listed in precedence order.  
  
#### \- PROCESS  
 The execution policy affects only the current session \(the current [!INCLUDE[wps_2]()] process\).  
  
 The execution policy is stored in the $env:PSExecutionPolicyPreference environment variable, not in the registry, and it is deleted when the session is closed. You cannot change the policy by editing the variable value.  
  
#### \- CURRENTUSER  
 The execution policy affects only the current user. It is stored in the HKEY\_CURRENT\_USER registry subkey.  
  
#### \- LOCALMACHINE  
 The execution policy affects all users on the current computer. It is stored in the HKEY\_LOCAL\_MACHINE registry subkey.  
  
 The policy that takes precedence is effective in the current session, even if a more restrictive policy was set at a lower level of precedence.  
  
 For more information, see Set\-ExecutionPolicy.  
  
### GET YOUR EXECUTION POLICY  
 To get the [!INCLUDE[wps_2]()] execution policy that is in effect in the current session, use the Get\-ExecutionPolicy cmdlet.  
  
 The following command gets the current execution policy:  
  
```  
Get-ExecutionPolicy      
```  
  
 To get all of the execution policies that affect the current session and displays them in precedence order, type:  
  
```  
Get-ExecutionPolicy -List  
```  
  
 The result will look similar to the following sample output:  
  
```  
        Scope    ExecutionPolicy  
        -----    ---------------  
MachinePolicy          Undefined  
   UserPolicy          Undefined  
      Process          Undefined  
  CurrentUser       RemoteSigned  
 LocalMachine          AllSigned  
```  
  
 In this case, the effective execution policy is RemoteSigned because the execution policy for the current user takes precedence over the execution policy set for the local computer.  
  
 To get the execution policy set for a particular scope, use the Scope parameter of Get\-ExecutionPolicy.  
  
 For example, the following command gets the execution policy for the current user scope.  
  
```  
Get-ExecutionPolicy -Scope CurrentUser  
  
```  
  
### CHANGE YOUR EXECUTION POLICY  
 To change the [!INCLUDE[wps_2]()] execution policy on your computer, use the Set\-ExecutionPolicy cmdlet.  
  
 The change is effective immediately; you do not need to restart [!INCLUDE[wps_2]()].  
  
 If you set the execution policy for the local computer \(the default\) or the current user, the change is saved in the registry and remains effective until you change it again.  
  
 If you set the execution policy for the current process, it is not saved in the registry. It is retained until the current process and any child processes are closed.  
  
 Note: In Windows Vista and later versions of Windows, to run commands that change the execution policy for the local computer \(the default\), start [!INCLUDE[wps_2]()] with the "Run as administrator" option.  
  
 To change your execution policy, type:  
  
```  
Set-ExecutionPolicy -ExecutionPolicy <PolicyName>  
```  
  
 For example:  
  
```  
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned  
```  
  
 To set the execution policy in a particular scope, type:  
  
```  
Set-ExecutionPolicy -ExecutionPolicy <PolicyName> -Scope <scope>  
```  
  
 For example:  
  
```  
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  
```  
  
 A command to change an execution policy can succeed but still not change the effective execution policy.  
  
 For example, a command that sets the execution policy for the local computer can succeed but be overridden by the execution policy for the current user.  
  
### REMOVE YOUR EXECUTION POLICY  
 To remove the execution policy for a particular scope, set the value of the value of the execution policy to Undefined.  
  
 For example, to remove the execution policy for all the users of the local computer, type:  
  
```  
Set-ExecutionPolicy Undefined  
```  
  
 Or, type:  
  
```  
Set-ExecutionPolicy Undefined -scope LocalMachine  
```  
  
 If no execution policy is set in any scope, the effective execution policy is Restricted, which is the default.  
  
### SET A DIFFERENT EXECUTION POLICY FOR ONE SESSION  
 You can use the ExecutionPolicy parameter of PowerShell.exe to set an execution policy for a new [!INCLUDE[wps_2]()] session. The policy affects only the current session and child sessions.  
  
 To set the execution policy for a new session, start [!INCLUDE[wps_2]()] at the command line \(such as Cmd.exe or [!INCLUDE[wps_2]()]\), and then use the ExecutionPolicy parameter of PowerShell.exe to set the execution policy.  
  
 For example:  
  
```  
PowerShell.exe -ExecutionPolicy AllSigned  
```  
  
 The execution policy that you set is not stored in the registry Instead, it is stored in the $env:PSExecutionPolicyPreference environment variable. The variable is deleted when you close the session in which the policy is set. You cannot change the policy by editing the variable value.  
  
 During the session, the execution policy that is set for the session takes precedence over an execution policy that is set in the registry for the local computer or current user. However, it does not take precedence over the execution policy set by using a Group Policy setting \(discussed below\).  
  
### USE GROUP POLICY TO MANAGE EXECUTION POLICY  
 You can use the "Turn on Script Execution" Group Policy setting to manage the execution policy of computers in your enterprise. The Group Policy setting overrides the execution policies set in [!INCLUDE[wps_2]()] in all scopes.  
  
 The "Turn on Script Execution" policy settings are as follows:  
  
 \-\- If you disable "Turn on Script Execution", scripts do not run. This is equivalent to the "Restricted" execution policy.  
  
 \-\- If you enable "Turn on Script Execution", you can select an execution policy. The Group Policy settings are equivalent to the following execution policy settings.  
  
```  
Group Policy                Execution Policy    
------------                ----------------  
Allow all scripts.          Unrestricted  
  
Allow local scripts         RemoteSigned  
and remote signed  
scripts.   
  
Allow only signed           AllSigned  
scripts.  
```  
  
 \-\- If "Turn on Script Execution" is not configured, it has no effect. The execution policy set in [!INCLUDE[wps_2]()] is effective.  
  
 The PowerShellExecutionPolicy.adm and PowerShellExecutionPolicy.admx files add the "Turn on Script Execution" policy to the Computer Configuration and User Configuration nodes in Group Policy Editor in the following paths.  
  
```  
For Windows XP and Windows Server 2003:  
Administrative Templates\Windows Components\Windows PowerShell  
  
For Windows Vista and later versions of Windows:  
Administrative Templates\Classic Administrative Templates\  
Windows Components\Windows PowerShell  
```  
  
 Policies set in the Computer Configuration node take precedence over policies set in the User Configuration node.  
  
 The PowerShellExecutionPolicy.adm file is available on the Microsoft Download Center. For more information, see "Administrative Templates for [!INCLUDE[wps_2]()]" at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131786.  
  
 For more information, see about\_Group\_Policy\_Settings at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=251696.  
  
### EXECUTION POLICY PRECEDENCE  
 When determining the effective execution policy for a session, [!INCLUDE[wps_2]()] evaluates the execution policies in the following precedence order:  
  
```  
- Group Policy: Computer Configuration  
- Group Policy: User Configuration  
- Execution Policy: Process (or PowerShell.exe -ExecutionPolicy)  
- Execution Policy: CurrentUser  
- Execution Policy: LocalMachine      
```  
  
### MANAGE SIGNED AND UNSIGNED SCRIPTS  
 If your [!INCLUDE[wps_2]()] execution policy is RemoteSigned, [!INCLUDE[wps_2]()] will not run unsigned scripts that are downloaded from the Internet \(including e\-mail and instant messaging programs\).  
  
 You can sign the script or elect to run an unsigned script without changing the execution policy.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, you can use the Stream parameter of the Get\-Item cmdlet to detect files that are blocked because they were downloaded from the Internet, and you can use the Unblock\-File cmdlet to unblock the scripts so that you can run them in [!INCLUDE[wps_2]()].  
  
 For more information, see about\_Signing, Get\-Item, and Unblock\-File.  
  
## SEE ALSO  
 about\_Environment\_Variables  
  
 about\_Signing  
  
 Get\-ExecutionPolicy  
  
 Set\-ExecutionPolicy  
  
 Get\-Item  
  
 Unblock\-File  
  
 "Administrative Templates for [!INCLUDE[wps_2]()]"  
  
 \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=131786\)  
  
 "PowerShell.exe Console Help"  
  
 \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113439\)

