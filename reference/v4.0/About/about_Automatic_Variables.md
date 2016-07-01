---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Automatic_Variables
ms.technology:  powershell
ms.assetid:  fc1ec15e-f704-4bc5-83d1-040c1d3241a1
---

# about_Automatic_Variables
Insert introduction here.  
  
## TOPIC  
 about\_Automatic\_Variables  
  
## SHORT DESCRIPTION  
 Describes variables that store state information for [!INCLUDE[wps_1]()]. These variables are created and maintained by [!INCLUDE[wps_2]()].  
  
## LONG DESCRIPTION  
 Here is a list of the automatic variables in [!INCLUDE[wps_2]()]:  
  
### $$  
 Contains the last token in the last line received by the session.  
  
### $?  
 Contains the execution status of the last operation. It contains TRUE if the last operation succeeded and FALSE if it failed.  
  
### $^  
 Contains the first token in the last line received by the session.  
  
### $\_  
 Same as $PSItem. Contains the current object in the pipeline object. You can use this variable in commands that perform an action on every object or on selected objects in a pipeline.  
  
### $ARGS  
 Contains an array of the undeclared parameters and\/or parameter values that are passed to a function, script, or script block. When you create a function, you can declare the parameters by using the param keyword or by adding a comma\-separated list of parameters in parentheses after the function name.  
  
 In an event action, the $Args variable contains objects that represent the event arguments of the event that is being processed. This variable is populated only within the Action block of an event registration command.  The value of this variable can also be found in the SourceArgs property of the PSEventArgs object \(System.Management.Automation.PSEventArgs\) that Get\-Event returns.  
  
### $CONSOLEFILENAME  
 Contains the path of the console file \(.psc1\) that was most recently used in the session. This variable is populated when you start [!INCLUDE[wps_2]()] with the PSConsoleFile parameter or when you use the Export\-Console cmdlet to export snap\-in names to a console file.  
  
 When you use the Export\-Console cmdlet without parameters, it automatically updates the console file that was most recently used in the session. You can use this automatic variable to determine which file will be updated.  
  
### $ERROR  
 Contains an array of error objects that represent the most recent errors. The most recent error is the first error object in the array \($Error\[0\]\).  
  
 To prevent an error from being added to the $Error array, use the ErrorAction common parameter with a value of Ignore. For more information, see about\_CommonParameters \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113216\).  
  
### $EVENT  
 Contains a PSEventArgs object that represents the event that is being processed.  This variable is populated only within the Action block of an event registration command, such as Register\-ObjectEvent. The value of this variable is the same object that the Get\-Event cmdlet returns. Therefore, you can use the properties of the $Event variable, such as $Event.TimeGenerated , in an Action script block.  
  
### $EVENTARGS  
 Contains an object that represents the first event argument that derives from EventArgs of the event that is being processed. This variable is populated only within the Action block of an event registration command. The value of this variable can also be found in the SourceEventArgs property  of the PSEventArgs \(System.Management.Automation.PSEventArgs\) object that Get\-Event returns.  
  
### $EVENTSUBSCRIBER  
 Contains a PSEventSubscriber object that represents the event subscriber of the event that is being processed. This variable is populated only within the Action block of an event registration command. The value of this variable is the same object that the Get\-EventSubscriber cmdlet returns.  
  
### $EXECUTIONCONTEXT  
 Contains an EngineIntrinsics object that represents the execution context of the [!INCLUDE[wps_2]()] host. You can use this variable to find the execution objects that are available to cmdlets.  
  
### $FALSE  
 Contains FALSE. You can use this variable to represent FALSE in commands and scripts instead of using the string "false". The string can be interpreted as TRUE if it is converted to a non\-empty string or to a non\-zero integer.  
  
### $FOREACH  
 Contains the enumerator \(not the resulting values\) of a ForEach loop. You can use the properties and methods of enumerators on the value of the $ForEach variable. This variable exists only while the ForEach loop is running; it is deleted after the loop is completed. For detailed information, see about\_ForEach.  
  
### $HOME  
 Contains the full path of the user's home directory. This variable is the equivalent of the %homedrive%%homepath% environment variables, typically C:\\Users\\\<UserName\>.  
  
### $HOST  
 Contains an object that represents the current host application for [!INCLUDE[wps_2]()]. You can use this variable to represent the current host in commands or to display or change the properties of the host, such as $Host.version or $Host.CurrentCulture, or $host.ui.rawui.setbackgroundcolor\("Red"\).  
  
### $INPUT  
 Contains an enumerator that enumerates all input that is passed to a function. The $input variable is available only to functions and script blocks \(which are unnamed functions\).  In the Process block of a function, the $input variable enumerates the object that is currently in the pipeline. When the Process block completes, there are no objects left in the pipeline, so the $input variable enumerates an empty collection. If the function does not have a Process block, then in the End block, the $input variable enumerates the collection of all input to the function.  
  
### $LASTEXITCODE  
 Contains the exit code of the last Windows\-based program that was run.  
  
### $MATCHES  
 The $Matches variable works with the \-match and \-notmatch operators. When you submit scalar input to the \-match or \-notmatch operator, and either one detects a match, they return a Boolean value and populate the $Matches automatic variable with a hash table of any string values that were matched. For more information about the \-match operator, see about\_comparison\_operators.  
  
### $MYINVOCATION  
 Contains an information about the current command, such as the name, parameters, parameter values, and information about how the command was started, called, or "invoked," such as the name of the script that called the current command.  
  
 $MyInvocation is populated only for scripts, function, and script blocks. You can use the information in the System.Management.Automation.InvocationInfo object that $MyInvocation returns in the current script, such as the path and file name of the script \($MyInvocation.MyCommand.Path\) or the name of a function \($MyInvocation.MyCommand.Name\) to identify the current command. This is particularly useful for finding the name of the current script.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, $MyInvocation has the following new properties.  
  
```  
-- PSScriptRoot: Contains the full path to the script that invoked the  
   current command. The value of this property is populated only when  
   the caller is a script.  
  
```  
  
```  
-- PSCommandPath: Contains the full path and file name of the script that  
   invoked the current command. The value of this property is populated  
   only when the caller is a script.  
  
```  
  
 Unlike the $PSScriptRoot and $PSCommandPath automatic variables, the PSScriptRoot and PSCommandPath properties of the $MyInvocation automatic variable contain information about the invoker or calling script, not the current script.  
  
### $NESTEDPROMPTLEVEL  
 Contains the current prompt level. A value of 0 indicates the original prompt level. The value is incremented when you enter a nested level and decremented when you exit it.  
  
 For example, [!INCLUDE[wps_2]()] presents a nested command prompt when you use the $Host.EnterNestedPrompt method. [!INCLUDE[wps_2]()] also presents a nested command prompt when you reach a breakpoint in the [!INCLUDE[wps_2]()] debugger.  
  
 When you enter a nested prompt, [!INCLUDE[wps_2]()] pauses the current command, saves the execution context, and increments the value of the $NestedPromptLevel variable. To create additional nested command prompts \(up to 128 levels\) or to return to the original command prompt, complete the command, or type "exit".  
  
 The $NestedPromptLevel variable helps you track the prompt level. You can create an alternative [!INCLUDE[wps_2]()] command prompt that includes this value so that it is always visible.  
  
### $NULL  
 $null is an automatic variable that contains a NULL or empty value. You can use this variable to represent an absent or undefined value in commands and scripts.  
  
 [!INCLUDE[wps_2]()] treats $null as an object with a value, that is, as an explicit placeholder, so you can use $null to represent an empty value in a series of values.  
  
 For example, when $null is included in a collection, it is counted as one of the objects.  
  
```  
C:\PS> $a = ".dir", $null, ".pdf"  
C:\PS> $a.count  
3  
  
```  
  
 If you pipe the $null variable to the ForEach\-Object cmdlet, it generates a value for $null, just as it does for the other objects.  
  
```  
PS C:\ps-test> ".dir", "$null, ".pdf" | Foreach {"Hello"}  
Hello  
Hello  
Hello  
  
```  
  
 As a result, you cannot use $null to mean "no parameter value." A parameter value of $null overrides the default parameter value.  
  
 However, because [!INCLUDE[wps_2]()] treats the $null variable as a placeholder, you can use it scripts like the following one, which would not work if $null were ignored.  
  
```  
$calendar = @($null, $null, “Meeting”, $null, $null, “Team Lunch”, $null)  
$days = Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"  
$currentDay = 0  
  
foreach($day in $calendar)  
{  
    if($day –ne $null)  
    {  
        "Appointment on $($days[$currentDay]): $day"  
    }  
  
    $currentDay++  
}   
  
Appointment on Tuesday: Meeting  
Appointment on Friday: Team lunch  
  
```  
  
### $OFS  
 $OFS is a special variable that stores a string that you want to use as an output field separator. Use this variable when you are converting an array to a string. By default, the value of $OFS is " ", but you can change the value of $OFS in your session, by typing $OFS\="\<value\>". If you are expecting the default value of " " in your script, module, or configuration output, be careful that the $OFS default value has not been changed elsewhere in your code.  
  
 Examples:  
  
```  
PS> $a="1","2","3","4"  
           PS> $a  
           1  
           2  
           3  
           4  
  
```  
  
```  
PS> [string]$a  
           1 2 3 4  
           PS> $OFS="";[string]$a  
           1234  
  
```  
  
```  
PS> $OFS=",";[string]$a  
           1,2,3,4  
  
```  
  
```  
PS> $OFS="--PowerShellRocks--";[string]$a  
           1--PowerShellRocks--2--PowerShellRocks--3--PowerShellRocks--4  
           PS> $OFS="`n`n";[string]$a  
           1  
  
           2  
  
           3  
  
           4  
  
```  
  
### $PID  
 Contains the process identifier \(PID\) of the process that is hosting the current [!INCLUDE[wps_2]()] session.  
  
### $PROFILE  
 Contains the full path of the [!INCLUDE[wps_2]()] profile for the current user and the current host application. You can use this variable to represent the profile in commands. For example, you can use it in a command to determine whether a profile has been created:  
  
```  
test-path $profile  
```  
  
 Or, you can use it in a command to create a profile:  
  
```  
new-item -type file -path $pshome -force  
```  
  
 You can also use it in a command to open the profile in Notepad:  
  
```  
notepad $profile  
```  
  
### $PSBOUNDPARAMETERS  
 Contains a dictionary of the parameters that are passed to a script or function and their current values. This variable has a value only in a scope where parameters are declared, such as a script or function. You can use it to display or change the current values of parameters or to pass parameter values to another script or function.  
  
 For example:  
  
```  
function Test {  
   param($a, $b)  
  
   # Display the parameters in dictionary format.  
   $PSBoundParameters  
  
   # Call the Test1 function with $a and $b.  
   test1 @PSBoundParameters  
}  
  
```  
  
### $PSCMDLET  
 Contains an object that represents the cmdlet or advanced function that is being run.  
  
 You can use the properties and methods of the object in your cmdlet or function code to respond to the conditions of use. For example, the ParameterSetName property contains the name of the parameter set that is being used, and the ShouldProcess method adds the WhatIf and Confirm parameters to the cmdlet dynamically.  
  
 For more information about the $PSCmdlet automatic variable, see about\_Functions\_Advanced.  
  
### $PSCOMMANDPATH  
 Contains the full path and file name of the script that is being run. This variable is valid in all scripts.  
  
### $PSCULTURE  
 Contains the name of the culture currently in use in the operating system. The culture determines the display format of items such as numbers, currrency, and dates. This is the value of the System.Globalization.CultureInfo.CurrentCulture.Name property of the system. To get the System.Globalization.CultureInfo object for the system, use the Get\-Culture cmdlet.  
  
### $PSDEBUGCONTEXT  
 While debugging, this variable contains information about the debugging environment. Otherwise, it contains a NULL value. As a result, you can use it to indicate whether the debugger has control. When populated, it contains a PsDebugContext object that has Breakpoints and InvocationInfo properties. The InvocationInfo property has several useful properties, including the Location property. The Location property indicates the path of the script that is being debugged.  
  
### $PSHOME  
 Contains the full path of the installation directory for [!INCLUDE[wps_2]()], typically, %windir%\\System32\\WindowsPowerShell\\v1.0. You can use this variable in the paths of [!INCLUDE[wps_2]()] files. For example, the following command searches the conceptual Help topics for the word "variable":  
  
```  
Select-String -Pattern Variable -Path $pshome\*.txt  
  
```  
  
### $PSITEM  
 Same as $\_. Contains the current object in the pipeline object. You can use this variable in commands that perform an action on every object or on selected objects in a pipeline.  
  
### $PSSCRIPTROOT  
 Contains the directory from which a script is being run.  
  
 In [!INCLUDE[wps_2]()] 2.0, this variable is valid only in script modules \(.psm1\). Beginning in [!INCLUDE[wps_2]()] 3.0, it is valid in all scripts.  
  
### $PSSENDERINFO  
 Contains information about the user who started the PSSession, including  the user identity and the time zone of the originating computer. This variable is available only in PSSessions.  
  
 The $PSSenderInfo variable includes a user\-configurable property, ApplicationArguments, which, by default, contains only the $PSVersionTable from the originating session. To add data to the ApplicationArguments property, use the ApplicationArguments parameter of the New\-PSSessionOption cmdlet.  
  
### $PSUICULTURE  
 Contains the name of the user interface \(UI\) culture that is currently in use in the operating system. The UI culture determines which text strings are used for user interface elements, such as menus and messages. This is the value of the System.Globalization.CultureInfo.CurrentUICulture.Name property of the system. To get the System.Globalization.CultureInfo object for the system, use the Get\-UICulture cmdlet.  
  
### $PSVERSIONTABLE  
 Contains a read\-only hash table that displays details about the version of [!INCLUDE[wps_2]()] that is running in the current session. The table includes the following items:  
  
```  
CLRVersion:            The version of the common language runtime (CLR)  
  
BuildVersion:          The build number of the current version  
  
    PSVersion:             The Windows PowerShell version number  
  
      WSManStackVersion:     The version number of the WS-Management stack  
  
PSCompatibleVersions:  Versions of Windows PowerShell that are  
                             compatible with the current version  
  
      SerializationVersion   The version of the serialization method  
  
      PSRemotingProtocolVersion  
                             The version of the Windows PowerShell remote  
                             management protocol  
  
```  
  
### $PWD  
 Contains a path object that represents the full path of the current directory.  
  
### $REPORTERRORSHOWEXCEPTIONCLASS<br /> $REPORTERRORSHOWINNEREXCEPTION<br /> $REPORTERRORSHOWSOURCE<br /> $REPORTERRORSHOWSTACKTRACE  
 The "ReportErrorShow" variables are defined in [!INCLUDE[wps_2]()], but they are not implemented. Get\-Variable gets them, but they do not contain valid data.  
  
### $SENDER  
 Contains the object that generated this event. This variable is populated only within the Action block of an event registration command. The value of this variable can also be found in the Sender property of the PSEventArgs \(System.Management.Automation.PSEventArgs\) object that Get\-Event returns.  
  
### $SHELLID  
 Contains the identifier of the current shell.  
  
### $STACKTRACE  
 Contains a stack trace for the most recent error.  
  
### $THIS  
 In a script block that defines a script property or script method, the $This variable refers to the object that is being extended.  
  
### $TRUE  
 Contains TRUE. You can use this variable to represent TRUE in commands and scripts.  
  
## SEE ALSO  
 about\_Hash\_Tables  
  
 about\_Preference\_Variables  
  
 about\_Variables

