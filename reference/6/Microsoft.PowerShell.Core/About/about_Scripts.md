---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Scripts
---

# About Scripts
## about_Scripts


## SHORT DESCRIPTION
Describes how to run and write scripts in  Windows PowerShell.


## LONG DESCRIPTION
A script is a plain text file that contains one or more  Windows PowerShell commands.  Windows PowerShell scripts have a .ps1 file name extension.

Running a script is a lot like running cmdlet. You type the path and file name of the script and use parameters to submit data and set options. You can run scripts on your computer or in a remote session on a different computer.

Writing a script saves a command for later use and makes it easy to share with others. Most importantly, it lets you run the commands simply by typing the script path and the file name. Scripts can be as simple as a single command in a file or as extensive as a complex program.

Scripts have additional features, such as the \#Requires special comment, the use of parameters, support for data sections, and digital signing for security. You can also write Help topics for scripts and for any functions in the script.


### HOW TO RUN A SCRIPT
Before you can run a script, you need to change the default  Windows PowerShell execution policy. The default execution policy, "Restricted", prevents all scripts from running, including scripts that you write on the local computer. For more information, see about_Execution_Policies.

The execution policy is saved in the registry, so you need to change it only once on each computer.

To change the execution policy, use the following procedure.

-   1.  Start Windows PowerShell with the "Run  as administrator" option.

-   At the command prompt, type:

Set-ExecutionPolicy AllSigned

-or-

Set-ExecutionPolicy RemoteSigned

The change is effective immediately

To run a script, type the full name and the full path to the script file.

For example, to run the Get-ServiceLog.ps1 script in the C:\Scripts directory, type:


```
C:\Scripts\Get-ServiceLog.ps1
```


To run a script in the current directory, type the path to the current directory, or use a dot to represent the current directory, followed by a path backslash (.\).

For example, to run the ServicesLog.ps1 script in the local directory, type:


```
.\Get-ServiceLog.ps1
```


If the script has parameters, type the parameters and parameter values after the script file name.

For example, the following command uses the ServiceName parameter of the Get-ServiceLog script to request a log of WinRM service activity.


```
.\Get-ServiceLog.ps1 -ServiceName WinRM
```


As a security feature,  Windows PowerShell does not run scripts when you double-click the script icon in File Explorer or when you type the script name without a full path, even when the script is in the current directory. For more information about running commands and scripts in Windows PowerShell, see about_Command_Precedence.


### RUN WITH POWERSHELL
Beginning in  Windows PowerShell 3.0, you can run scripts from File Explorer (or Windows Explorer, in earlier versions of Windows).

To use the "Run with PowerShell" feature:


```
In File Explorer (or Windows Explorer), right-click the   
script file name and then select "Run with PowerShell".
```


The "Run with PowerShell" feature is designed to run scripts that do not have required parameters and do not return output to the command prompt.

For more information, see about_Run_With_PowerShell


### RUNNING SCRIPTS ON OTHER COMPUTERS
To run a script on one or more remote computers, use the FilePath parameter of the Invoke-Command cmdlet.

Enter the path and file name of the script as the value of the FilePath parameter. The script must reside on the local computer or in a directory that the local computer can access.

The following command runs the Get-ServiceLog.ps1 script on the Server01 and Server02 remote computers.


```
Invoke-Command -ComputerName Server01, Server02 -FilePath C:\Scripts\Get-ServiceLog.ps1
```



### GET HELP FOR SCRIPTS
The Get-Help cmdlet gets the help topics for scripts as well as for cmdlets and other types of commands. To get the help topic for a script, type "Get-Help" followed by the path and file name of the script. If the script path is in your Path environment variable, you can omit the path.

For example, to get help for the ServicesLog.ps1 script, type:


```
get-help C:\admin\scripts\ServicesLog.ps1
```



### HOW TO WRITE A SCRIPT
A script can contain any valid  Windows PowerShell commands, including single commands, commands that use the pipeline, functions, and control structures such as If statements and For loops.

To write a script, start a text editor (such as Notepad) or a script editor (such as the  Windows PowerShell Integrated Scripting Environment [ISE]). Type the commands and save them in a file with a valid file name and the .ps1 file name extension.

The following example is a simple script that gets the services that are running on the current system and saves them to a log file. The log file name is created from the current date.


```
$date = (get-date).dayofyear  
get-service | out-file "$date.log"
```


To create this script, open a text editor or a script editor, type these commands, and then save them in a file named ServiceLog.ps1.


### PARAMETERS IN SCRIPTS
To define parameters in a script, use a Param statement. The Param statement must be the first statement in a script, except for comments and any \#Requires statements.

Script parameters work like function parameters. The parameter values are available to all of the commands in the script. All of the features of function parameters, including the Parameter attribute and its named arguments, are also valid in scripts.

When running the script, script users type the parameters after the script name.

The following example shows a Test-Remote.ps1 script that has a ComputerName parameter. Both of the script functions can access the ComputerName parameter value.


```
param ($ComputerName = $(throw "ComputerName parameter is required."))  
  
function CanPing {  
   $error.clear()  
   $tmp = test-connection $computername -erroraction SilentlyContinue  
  
   if (!$?)   
       {write-host "Ping failed: $ComputerName."; return $false}  
   else  
       {write-host "Ping succeeded: $ComputerName"; return $true}  
}  
  
function CanRemote {  
    $s = new-pssession $computername -erroraction SilentlyContinue  
  
    if ($s -is [System.Management.Automation.Runspaces.PSSession])  
        {write-host "Remote test succeeded: $ComputerName."}  
    else  
        {write-host "Remote test failed: $ComputerName."}  
}  
  
if (CanPing $computername) {CanRemote $computername}
```


To run this script, type the parameter name after the script name. For example:


```
C:\PS> .\test-remote.ps1 -computername Server01  
  
Ping succeeded: Server01  
Remote test failed: Server01
```


For more information about the Param statement and the function parameters, see about_Functions and about_Functions_Advanced_Parameters.


### WRITING HELP FOR SCRIPTS
You can write a help topic for a script by using either of the two following methods:

--  Comment-Based Help for Scripts

Create a Help topic by using special keywords in the comments. To create comment-based Help for a script, the comments must be placed at the beginning or end of the script file. For more information about comment-based Help, see about_Comment_Based_Help.

--  XML-Based Help  for Scripts

Create an XML-based Help topic, such as the type that is typically created for cmdlets. XML-based Help is required if you are translating Help topics into multiple languages.

To associate the script with the XML-based Help topic, use the .ExternalHelp Help comment keyword. For more information about the ExternalHelp keyword, see about_Comment_Based_Help. For more information about XML-based help, see [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.


### SCRIPT SCOPE AND DOT SOURCING
Each script runs in its own scope. The functions, variables, aliases, and drives that are created in the script exist only in the script scope. You cannot access these items or their values in the scope in which the script runs.

To run a script in a different scope, you can specify a scope, such as Global or Local, or you can dot source the script.

The dot sourcing feature lets you run a script in the current scope instead of in the script scope. When you run a script that is dot sourced, the commands in the script run as though you had typed them at the command prompt. The functions, variables, aliases, and drives that the script creates are created in the scope in which you are working. After the script runs, you can use the created items and access their values in your session.

To dot source a script, type a dot (.) and a space before the script path.

For example:


```
. C:\scripts\UtilityFunctions.ps1  
  
-or-  
  
    . .\UtilityFunctions.ps1
```


After the UtilityFunctions script runs, the functions and variables that the script creates are added to the current scope.

For example, the UtilityFunctions.ps1 script creates the New-Profile function and the $ProfileName variable.


```
#In UtilityFunctions.ps1  
  
function New-Profile  
{  
    Write-Host "Running New-Profile function"  
    $profileName = split-path $profile -leaf  
  
    if (test-path $profile)  
       {write-error "There is already a $profileName profile on this computer."}  
    else  
       {new-item -type file -path $profile -force }  
}
```


If you run the UtilityFunctions.ps1 script in its own script scope, the New-Profile function and the $ProfileName variable exist only while the script is running. When the script exits, the function and variable are removed, as shown in the following example.


```
C:\PS> .\UtilityFunctions.ps1  
  
C:\PS> New-Profile  
The term 'new-profile' is not recognized as a cmdlet, function, operable  
program, or script file. Verify the term and try again.  
At line:1 char:12  
+ new-profile <<<<   
   + CategoryInfo          : ObjectNotFound: (new-profile:String) [],   
   + FullyQualifiedErrorId : CommandNotFoundException  
  
C:\PS> $profileName  
C:\PS>
```


When you dot source the script and run it, the script creates the New-Profile function and the $ProfileName variable in your session in your scope. After the script runs, you can use the New-Profile function in your session, as shown in the following example.


```
C:\PS> . .\UtilityFunctions.ps1  
  
C:\PS> New-Profile  
  
    Directory: C:\Users\juneb\Documents\WindowsPowerShell  
  
    Mode    LastWriteTime     Length Name                                                                     
    ----    -------------     ------ ----                                                                     
    -a---   1/14/2009 3:08 PM      0 Microsoft.PowerShellISE_profile.ps1  
  
C:\PS> $profileName  
Microsoft.PowerShellISE_profile.ps1
```


For more information about scope, see about_Scopes.


### SCRIPTS IN MODULES
A module is a set of related Windows PowerShell resources that can be distributed as a unit. You can use modules to organize your scripts, functions, and other resources. You can also use modules to distribute your code to others, and to get code from trusted sources.

You can include scripts in your modules, or you can create a script module, which is a module that consists entirely or primarily of a script and supporting resources. A script module is just a script with a .psm1 file name extension.

For more information about modules, see about_Modules.


### OTHER SCRIPT FEATURES
Windows PowerShell has many useful features that you can use in scripts.

\#Requires

You can use a \#Requires statement to prevent a script from running without specified modules or snap-ins and a specified version of  Windows PowerShell. For more information, see about_Requires.

$PSCommandPath

Contains the full path and name of the script that is being run. This parameter is valid in all scripts. This automatic variable is introduced in  Windows PowerShell 3.0.

$PSScriptRoot

Contains the directory from which a script is being run. In  Windows PowerShell 2.0, this variable is valid only in script modules (.psm1). Beginning in  Windows PowerShell 3.0, it is valid in all scripts.

$MyInvocation

The $MyInvocation automatic variable contains information about the current script, including information about how it was started or "invoked." You can use this variable and its properties to get information about the script while it is  running. For example, the $MyInvocation.MyCommand.Path variable contains the path and file name of the script. $MyInvocation.Line contains the command that started the script, including all parameters and values.

Beginning in  Windows PowerShell 3.0, $MyInvocation has two new properties that provide information about the script that called or invoked the current script. The values of these properties are populated only when the invoker or caller is a script.

-- PSCommandPath contains the full path and name of the script that called or invoked the current script.

-- PSScriptRoot contains the directory of the script that called or invoked the current script.

Unlike the $PSCommandPath and $PSScriptRoot automatic variables, which contain information about the current script, the PSCommandPath and PSScriptRoot properties of the $MyInvocation variable contain information about the script that called or invoke the current script.

Data sections

You can use the Data keyword to separate data from logic in scripts. Data sections can also make localization easier. For more information, see about_Data_Sections and about_Script_Localization.

Script Signing

You can add a digital signature to a script. Depending on the execution policy, you can use digital signatures to restrict the running of scripts that could include unsafe commands. For more information, see about_Execution_Policies and about_Signing.


## SEE ALSO

[about_Command_Precedence](about_Command_Precedence.md)

[about_Comment_Based_Help](about_Comment_Based_Help.md)

[about_Execution_Policies](about_Execution_Policies.md)

[about_Functions](about_Functions.md)

[about_Modules](about_Modules.md)

[about_Profiles](about_Profiles.md)

[about_Requires](about_Requires.md)

[about_Run_With_PowerShell](about_Run_With_PowerShell.md)

[about_Scopes](about_Scopes.md)

[about_Script_Blocks](about_Script_Blocks.md)

[about_Signing](about_Signing.md)

Invoke-Command

