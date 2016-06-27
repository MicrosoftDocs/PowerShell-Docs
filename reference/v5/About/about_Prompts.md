---
title: about_Prompts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6117d7b4-bdb5-48ee-821a-6e92f7c3db8a
---
# about_Prompts
## TOPIC  
 about\_Prompts  
  
## SHORT DESCRIPTION  
 Describes the Prompt function and demonstrates how to create a custom Prompt function.  
  
## LONG DESCRIPTION  
 The [!INCLUDE[wps_1](../Token/wps_1_md.md)] command prompt indicates that [!INCLUDE[wps_2](../Token/wps_2_md.md)] is ready to run a command:  
  
```  
PS C:\>  
```  
  
 The [!INCLUDE[wps_2](../Token/wps_2_md.md)] prompt is determined by the built\-in Prompt function. You can customize the prompt by creating your own Prompt function and saving it in your [!INCLUDE[wps_2](../Token/wps_2_md.md)] profile.  
  
### ABOUT THE PROMPT FUNCTION  
 The Prompt function determines the appearance of the [!INCLUDE[wps_2](../Token/wps_2_md.md)] prompt. [!INCLUDE[wps_2](../Token/wps_2_md.md)] comes with a built\-in Prompt function, but you can override it by defining your own Prompt function.  
  
 The Prompt function has the following syntax:  
  
```  
function Prompt { <function-body> }  
```  
  
 The Prompt function must return an object. As a best practice, return a string or an object that is formatted as a string. The maximum recommended length is 80 characters.  
  
 For example, the following prompt function returns a "Hello, World" string followed by a caret \(\>\).  
  
```  
PS C:\> function prompt {"Hello, World > "}  
Hello, World >  
```  
  
### GETTING THE PROMPT FUNCTION  
 To get the Prompt function, use the Get\-Command cmdlet or use the Get\-Item cmdlet in the Function drive.  
  
 Functions are commands. So, you can use the Get\-Command cmdlet to get functions, including the Prompt function.  
  
 For example:  
  
```  
PS C:\>Get-Command Prompt  
  
CommandType     Name                                               ModuleName  
-----------     ----                                               ----------  
Function        prompt  
```  
  
 To get the script that sets the value of the prompt, use the dot method to get the ScriptBlock property of the Prompt function.  
  
 For example:  
  
```  
PS C:\>(Get-Command Prompt).ScriptBlock  
  
"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "  
# .Link  
# http://go.microsoft.com/fwlink/?LinkID=225750  
# .ExternalHelp System.Management.Automation.dll-help.xml  
```  
  
 Like all functions, the Prompt function is stored in the Function: drive. To display the script that creates the current Prompt function, type:  
  
```  
(Get-Item function:prompt).ScriptBlock  
```  
  
### THE DEFAULT PROMPT  
 The default prompt appears only when the Prompt function generates an error or does not return an object.  
  
 The default [!INCLUDE[wps_2](../Token/wps_2_md.md)] prompt is:  
  
```  
PS>  
```  
  
 For example, the following command sets the Prompt function to $null, which is invalid. As a result, the default prompt appears.  
  
```  
PS C:\> function prompt {$null}  
PS>  
```  
  
 Because [!INCLUDE[wps_2](../Token/wps_2_md.md)] comes with a built\-in prompt, you usually do not see the default prompt.  
  
### BUILT\-IN PROMPT  
 [!INCLUDE[wps_2](../Token/wps_2_md.md)] includes a built\-in prompt function.  
  
 In [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0, the built\-in prompt function is:  
  
```  
function prompt  
{  
    "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "  
}  
```  
  
 This simplified prompt starts with "PS" followed by the current location, and one "\>" for each nested prompt level.  
  
 In [!INCLUDE[wps_2](../Token/wps_2_md.md)] 2.0, the built\-in prompt function is:  
  
```  
function prompt  
{  
    $(if (test-path variable:/PSDebugContext) { '[DBG]: ' }   
    else { '' }) + 'PS ' + $(Get-Location) `  
    + $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '  
}  
```  
  
 The function uses the Test\-Path cmdlet to determine whether the $PSDebugContext automatic variable is populated. If $PSDebugContext is populated, you are in debugging mode, and "\[DBG\]" is added to the prompt, as follows:  
  
```  
[DBG] PS C:\ps-test>  
```  
  
 If $PSDebugContext is not populated, the function adds "PS" to the prompt. And, the function uses the Get\-Location cmdlet to get the current file system directory location. Then, it adds a right angle bracket \(\>\).  
  
```  
For example:          
    PS C:\ps-test>  
```  
  
 If you are in a nested prompt, the function adds two angle brackets \(\>\>\) to the prompt. \(You are in a nested prompt if the value of the $NestedPromptLevel automatic variable is greater than 1.\)  
  
 For example, when you are debugging in a nested prompt, the prompt resembles the following prompt:  
  
```  
[DBG] PS C:\ps-test>>>  
```  
  
### CHANGES TO THE PROMPT  
 The Enter\-PSSession cmdlet prepends the name of the remote computer to the current Prompt function. When you use the Enter\-PSSession cmdlet to start a session with a remote computer, the command prompt changes to include the name of the remote computer. For example:  
  
```  
PS Hello, World> Enter-PSSession Server01  
[Server01]: PS Hello, World>  
```  
  
 Other [!INCLUDE[wps_2](../Token/wps_2_md.md)] host applications and alternate shells might have their own custom command prompts.  
  
 For more information about the $PSDebugContext and $NestedPromptLevel automatic variables, see about\_Automatic\_Variables.  
  
### HOW TO CUSTOMIZE THE PROMPT  
 To customize the prompt, write a new Prompt function. The function is not protected, so you can overwrite it.  
  
 To write a prompt function, type the following:  
  
```  
function prompt { }  
```  
  
 Then, between the braces, enter the commands or the string that creates your prompt.  
  
 For example, the following prompt includes your computer name:  
  
```  
function prompt {"PS [$env:COMPUTERNAME]> "}  
```  
  
 On the Server01 computer, the prompt resembles the following prompt:  
  
```  
PS [Server01] >  
```  
  
 The following prompt function includes the current date and time:  
  
```  
function prompt {"$(get-date)> "}  
```  
  
 The prompt resembles the following prompt:  
  
```  
03/15/2012 17:49:47>  
```  
  
 You can also change the default Prompt function:  
  
 For example, the following modified Prompt function adds "\[ADMIN\]:" to the built\-in [!INCLUDE[wps_2](../Token/wps_2_md.md)] prompt when [!INCLUDE[wps_2](../Token/wps_2_md.md)] is opened by using the "Run as administrator" option:  
  
```  
function prompt   
{  
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()  
    $principal = [Security.Principal.WindowsPrincipal] $identity  
  
    $(if (test-path variable:/PSDebugContext) { '[DBG]: ' }   
  
    elseif($principal.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
    { "[ADMIN]: " }  
  
    else { '' }) + 'PS ' + $(Get-Location) + $(if ($nestedpromptlevel -ge 1) { '>>' }) + '> '  
}  
```  
  
 When you start [!INCLUDE[wps_2](../Token/wps_2_md.md)] by using the "Run as administrator" option, a prompt that resembles the following prompt appears:  
  
```  
[ADMIN]: PS C:\ps-test>  
```  
  
 The following Prompt function displays the history ID of the next command. To view the command history, use the Get\-History cmdlet.  
  
```  
function prompt  
{  
   # The at sign creates an array in case only one history item exists.  
   $history = @(get-history)  
   if($history.Count -gt 0)  
   {  
      $lastItem = $history[$history.Count - 1]  
      $lastId = $lastItem.Id  
   }  
  
   $nextCommand = $lastId + 1  
   $currentDirectory = get-location  
   "PS: $nextCommand $currentDirectory >"  
}  
```  
  
 The following prompt uses the Write\-Host and Get\-Random cmdlets to create a prompt that changes color randomly. Because Write\-Host writes to the current host application but does not return an object, this function includes a Return statement. Without it, [!INCLUDE[wps_2](../Token/wps_2_md.md)] uses the default prompt, "PS\>".  
  
```  
function prompt  
{  
    $color = Get-Random -Min 1 -Max 16  
    Write-Host ("PS " + $(Get-Location) +">") -NoNewLine -ForegroundColor $Color  
    return " "  
}  
```  
  
### SAVING THE PROMPT FUNCTION  
 Like any function, the Prompt function exists only in the current session. To save the Prompt function for future sessions, add it to your [!INCLUDE[wps_2](../Token/wps_2_md.md)] profiles. For more information about profiles, see about\_Profiles.  
  
## SEE ALSO  
 Get\-Location  
  
 Enter\-PSSession  
  
 Get\-History  
  
 Get\-Random  
  
 Write\-Host  
  
 about\_Profiles  
  
 about\_Functions  
  
 about\_Scopes  
  
 about\_Debuggers  
  
 about\_Automatic\_Variables