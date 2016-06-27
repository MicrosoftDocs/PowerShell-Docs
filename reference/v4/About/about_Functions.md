---
title: about_Functions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b29b6f17-2469-4047-a875-ce0e79c30ab2
---
# about_Functions
## TOPIC  
 about\_Functions  
  
## SHORT DESCRIPTION  
 Describes how to create and use functions in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 A function is a list of [!INCLUDE[wps_2]()] statements that has a name that you assign. When you run a function, you type the function name. The statements in the list run as if you had typed them at the command prompt.  
  
 Functions can be as simple as:  
  
```  
function Get-PowerShellProcess {Get-Process PowerShell}  
```  
  
 or as complex as a cmdlet or an application program.  
  
 Like cmdlets, functions can have parameters. The parameters can be named, positional, switch, or dynamic parameters. Function parameters can be read from the command line or from the pipeline.  
  
 Functions can return values that can be displayed, assigned to variables, or passed to other functions or cmdlets.  
  
 The function's statement list can contain different types of statement lists with the keywords Begin, Process, and End. These statement lists handle input from the pipeline differently.  
  
 A filter is a special kind of function that uses the Filter keyword.  
  
 Functions can also act like cmdlets. You can create a function that works just like a cmdlet without using C\# programming. For more information, see about\_Functions\_Advanced \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=144511\).  
  
 Syntax  
  
 The following is the syntax for a function:  
  
```  
function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]    
{  
    param([type]$parameter1 [,[type]$parameter2])  
  
    dynamicparam {<statement list>}  
  
    begin {<statement list>}  
    process {<statement list>}  
    end {<statement list>}  
}  
```  
  
 A function includes the following items:  
  
```  
- A Function keyword  
- A scope (optional)  
- A name that you select  
- Any number of named parameters (optional)  
- One or more Windows PowerShell commands enclosed in braces ({})  
```  
  
 For more information about the Dynamicparam keyword and dynamic parameters in functions, see about\_Functions\_Advanced\_Parameters.  
  
 Simple Functions  
  
 Functions do not have to be complicated to be useful. The simplest functions have the following format:  
  
```  
function <function-name> {statements}  
```  
  
 For example, the following function starts [!INCLUDE[wps_2]()] with the Run as Administrator option.  
  
```  
function Start-PSAdmin {Start-Process PowerShell -Verb RunAs}  
```  
  
 To use the function, type: Start\-PSAdmin  
  
 To add statements to the function, use a semi\-colon \(;\) to separate the statements, or type each statement on a separate line.  
  
 For example, the following function finds all .jpg files in the current user's directories that were changed after the start date.  
  
```  
function Get-NewPix  
{  
    $start = Get-Date -Month 1 -Day 1 -Year 2010  
    $allpix = Get-ChildItem -Path $env:UserProfile\*.jpg -Recurse  
    $allpix | where {$_.LastWriteTime -gt $Start}  
}      
```  
  
 You can create a toolbox of useful small functions. Add these functions to your [!INCLUDE[wps_2]()] profile, as described in about\_Profiles and later in this topic.  
  
 Function Names  
  
 You can assign any name to a function, but functions that you share with others should follow the naming rules that have been established for all [!INCLUDE[wps_2]()] commands.  
  
 Functions names should consist of a verb\-noun pair in which the verb identifies the action that the function performs and the noun identifies the item on which the cmdlet performs its action.  
  
 Functions should use the standard verbs that have been approved for all [!INCLUDE[wps_2]()] commands. These verbs help us to keep our command names simple, consistent, and easy for users to understand.  
  
 For more information about the standard [!INCLUDE[wps_2]()] verbs, see "Cmdlet Verbs" on MSDN at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=160773.  
  
## FUNCTIONS WITH PARAMETERS  
 You can use parameters with functions, including named parameters, positional parameters, switch parameters, and dynamic parameters. For more information about dynamic parameters in functions, see about\_Functions\_Advanced\_Parameters \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135173\).  
  
 Named Parameters  
  
 You can define any number of named parameters. You can include a default value for named parameters, as described later in this topic.  
  
 You can define parameters inside the braces using the Param keyword, as shown in the following sample syntax:  
  
```  
function <name> {   
     param ([type]$parameter1[,[type]$parameter2])  
     <statement list>   
}  
```  
  
 You can also define parameters outside the braces without the Param keyword, as shown in the following sample syntax:  
  
```  
function <name> [([type]$parameter1[,[type]$parameter2])] {   
    <statement list>   
}  
```  
  
 There is no difference between these two methods. Use the method that you prefer.  
  
 When you run the function, the value you supply for a parameter is assigned to a variable that contains the parameter name. The value of that variable can be used in the function.  
  
 The following example is a function called Get\-SmallFiles. This function has a $size parameter. The function displays all the files that are smaller than the value of the $size parameter, and it excludes directories:  
  
```  
function Get-SmallFiles {  
    param ($size)  
    Get-ChildItem c:\ | where {$_.Length -lt $Size -and !$_.PSIsContainer}   
}  
```  
  
 In the function, you can use the $size variable, which is the name defined for the parameter.  
  
 To use this function, type the following command:  
  
```  
C:\PS> function Get-SmallFiles –Size 50  
```  
  
 You can also enter a value for a named parameter without the parameter name. For example, the following command gives the same result as a command that names the Size parameter:  
  
```  
C:\PS> function Get-SmallFiles 50  
```  
  
 To define a default value for a parameter, type an equal sign and the value after the parameter name, as shown in the following variation of the Get\-SmallFiles example:  
  
```  
function Get-SmallFiles ($size = 100) {  
    Get-ChildItem c:\ | where {$_.Length -lt $Size -and !$_.PSIsContainer}   
}  
```  
  
 If you type "Get\-SmallFiles" without a value, the function assigns 100 to $size. If you provide a value, the function uses that value.  
  
 Optionally, you can provide a brief help string that describes the default value of your parameter, by adding the PSDefaultValue attribute to the description of your parameter, and specifying the Help property of PSDefaultValue. To provide a help string that describes the default value \(100\) of the Size parameter in the Get\-SmallFiles function, add the PSDefaultValue attribute as shown in the following example.  
  
```  
function Get-SmallFiles {  
    param (  
    [PSDefaultValue(Help = '100')]  
    $size = 100  
    )  
```  
  
 For more information about the PSDefaultValue attribute class, see PSDefaultValue Attribute Members on MSDN. \(http:\/\/msdn.microsoft.com\/library\/windows\/desktop\/system.management.automation.psdefaultvalueattribute\_members\(v\=vs.85\).aspx  
  
 Positional Parameters  
  
 A positional parameter is a parameter without a parameter name. [!INCLUDE[wps_2]()] uses the parameter value order to associate each parameter value with a parameter in the function.  
  
 When you use positional parameters, type one or more values after the function name. Positional parameter values are assigned to the $args array variable. The value that follows the function name is assigned to the first position in the $args array, $args\[0\].  
  
 The following Get\-Extension function adds the .txt file name extension to a file name that you supply:  
  
```  
function Get-Extension {  
    $name = $args[0] + ".txt"  
    $name  
}  
```  
  
```  
C:\PS> Get-Extension myTextFile  
myTextFile.txt  
```  
  
## SWITCH PARAMETERS  
 A switch is a parameter that does not require a value. Instead, you type the function name followed by the name of the switch parameter.  
  
 To define a switch parameter, specify the type \[switch\] before the parameter name, as shown in the following example:  
  
```  
function Switch-Item {  
    param ([switch]$on)  
    if ($on) { "Switch on" }  
    else { "Switch off" }  
}  
```  
  
 When you type the On switch parameter after the function name, the function displays "Switch on". Without the switch parameter, it displays "Switch off".  
  
```  
C:\PS> Switch-Item -on  
Switch on  
  
C:\PS> Switch-Item  
Switch off  
```  
  
 You can also assign a Boolean value to a switch when you run the function, as shown in the following example:  
  
```  
C:\PS> Switch-Item -on:$true  
Switch on  
  
C:\PS> Switch-Item -on:$false  
Switch off  
```  
  
 Using Splatting to Represent Command Parameters  
  
 You can use splatting to represent the parameters of a command. This feature is introduced in [!INCLUDE[wps_2]()] 3.0.  
  
 Use this technique in functions that call commands in the session. You do not need to declare or enumerate the command parameters, or change the function when command parameters change.  
  
 The following sample function calls the Get\-Command cmdlet. The command uses @Args to represent the parameters of Get\-Command.  
  
```  
function Get-MyCommand { Get-Command @Args }  
```  
  
 You can use all of the parameters of Get\-Command when you call the Get\-MyCommand function. The parameters and parameter values are passed to the command using @Args.  
  
```  
PS C:\>Get-MyCommand -Name Get-ChildItem  
CommandType     Name                ModuleName  
-----------     ----                ----------  
Cmdlet          Get-ChildItem       Microsoft.PowerShell.Management  
```  
  
 The @Args feature uses the $Args automatic parameter, which represents undeclared cmdlet parameters and values from remaining arguments.  
  
 For more information about splatting, see about\_Splatting \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=262720\).  
  
 Piping Objects to Functions  
  
 Any function can take input from the pipeline. You can control how a function processes input from the pipeline using Begin, Process, and End keywords. The following sample syntax shows the three keywords:  
  
```  
function <name> {   
    begin {<statement list>}  
    process {<statement list>}  
    end {<statement list>}  
}  
```  
  
 The Begin statement list runs one time only, at the beginning of the function.  
  
 The Process statement list runs one time for each object in the pipeline. While the Process block is running, each pipeline object is assigned to the $\_ automatic variable, one pipeline object at a time.  
  
 After the function receives all the objects in the pipeline, the End statement list runs one time. If no Begin, Process, or End keywords are used, all the statements are treated like an End statement list.  
  
 The following function uses the Process keyword. The function displays examples from the pipeline:  
  
```  
function Get-Pipeline   
{   
    process {"The value is: $_"}   
}  
```  
  
 To demonstrate this function, enter an list of numbers separated by commas, as shown in the following example:  
  
```  
C:\PS> 1,2,4 | Get-Pipeline  
The value is: 1  
The value is: 2  
The value is: 4  
```  
  
 When you use a function in a pipeline, the objects piped to the function are assigned to the $input automatic variable. The function runs statements with the Begin keyword before any objects come from the pipeline. The function runs statements with the End keyword after all the objects have been received from the pipeline.  
  
 The following example shows the $input automatic variable with Begin and End keywords.  
  
```  
function Get-PipelineBeginEnd   
{  
    begin {"Begin: The input is $input"}  
    end {"End:   The input is $input" }  
}  
```  
  
 If this function is run by using the pipeline, it displays the following results:  
  
```  
C:\PS> 1,2,4 | Get-PipelineBeginEnd  
Begin: The input is   
End:   The input is 1 2 4  
```  
  
 When the Begin statement runs, the function does not have the input from the pipeline. The End statement runs after the function has the values.  
  
 If the function has a Process keyword, the function reads the data in $input. The following example has a Process statement list:  
  
```  
function Get-PipelineInput  
{  
    process {"Processing:  $_ " }  
    end {"End:   The input is: $input" }  
}    
```  
  
 In this example, each object that is piped to the function is sent to the Process statement list. The Process statements run on each object, one object at a time. The $input automatic variable is empty when the function reaches the End keyword.  
  
```  
C:\PS> 1,2,4 | Get-PipelineInput  
Processing:  1   
Processing:  2   
Processing:  4   
End:   The input is:  
```  
  
 Filters  
  
 A filter is a type of function that runs on each object in the pipeline. A filter resembles a function with all its statements in a Process block.  
  
 The syntax of a filter is as follows:  
  
```  
filter [<scope:>]<name> {<statement list>}  
```  
  
 The following filter takes log entries from the pipeline and then displays either the whole entry or only the message portion of the entry:  
  
```  
filter Get-ErrorLog ([switch]$message)  
{  
    if ($message) { out-host -inputobject $_.Message }  
    else { $_ }     
}  
```  
  
 Function Scope  
  
 A function exists in the scope in which it was created.  
  
 If a function is part of a script, the function is available to statements within that script. By default, a function in a script is not available at the command prompt.  
  
 You can specify the scope of a function. For example, the function is added to the global scope in the following example:  
  
```  
function global:Get-DependentSvs { Get-Service |  
   where {$_.DependentServices} }  
```  
  
 When a function is in the global scope, you can use the function in scripts, in functions, and at the command line.  
  
 Functions normally create a scope. The items created in a function, such as variables, exist only in the function scope.  
  
 For more information about scope in [!INCLUDE[wps_2]()], see about\_Scopes \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113260\).  
  
 Finding and Managing Functions Using the Function: Drive  
  
 All the functions and filters in [!INCLUDE[wps_2]()] are automatically stored in the Function: drive. This drive is exposed by the [!INCLUDE[wps_2]()] Function provider.  
  
 When referring to the Function: drive, type a colon after Function, just as you would do when referencing the C or D drive of a computer.  
  
 The following command displays all the functions in the current session of[!INCLUDE[wps_2]()]:  
  
```  
Get-ChildItem function:  
```  
  
 The commands in the function are stored as a script block in the definition property of the function. For example, to display the commands in the Help function that comes with [!INCLUDE[wps_2]()], type:  
  
```  
(Get-ChildItem function:help).Definition  
```  
  
 For more information about the Function: drive, see the help topic for the Function provider. Type "Get\-Help Function" or view it in the TechNet Library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113436.  
  
 Reusing Functions in New Sessions  
  
 When you type a function at the [!INCLUDE[wps_2]()] command prompt, the function becomes part of the current session. It is available until the session ends.  
  
 To use your function in all [!INCLUDE[wps_2]()]sessions, add the function to your [!INCLUDE[wps_2]()] profile. For more information about profiles, see about\_Profiles \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113729\).  
  
 You can also save your function in a [!INCLUDE[wps_2]()] script file. Type your function in a text file, and then save the file with the .ps1 file name extension.  
  
 Writing Help for Functions  
  
 The Get\-Help cmdlet gets help for functions, as well as for cmdlets, providers, and scripts. To get help for a function, type Get\-Help followed by the function name.  
  
 For example, to get help for the Get\-MyDisks function, type:  
  
```  
Get-Help Get-MyDisks  
```  
  
 You can write help for a function by using either of the two following methods:  
  
 Comment\-Based Help  for Functions  
  
 Create a help topic by using special keywords in the comments. To create comment\-based help for a function, the comments must be placed at the beginning or end of the function body or on the lines preceding the function keyword. For more information about comment\-based help, see about\_Comment\_Based\_Help.  
  
 XML\-Based Help  for Functions  
  
 Create an XML\-based help topic, such as the type that is typically created for cmdlets. XML\-based help is required if you are localizing help topics into multiple languages.  
  
 To associate the function with the XML\-based help topic, use the.ExternalHelp comment\-based help keyword. Without this keyword, Get\-Help cannot find the function help topic and calls to Get\-Help for the function return only auto\-generated help.  
  
 For more information about the ExternalHelp keyword, see about\_Comment\_Based\_Help. For more information about XML\-based help, see "How to Write Cmdlet Help" in MSDN.  
  
## SEE ALSO  
 about\_Automatic\_Variables  
  
 about\_Comment\_Based\_Help  
  
 about\_Functions\_Advanced  
  
 about\_Functions\_Advanced\_Methods  
  
 about\_Functions\_Advanced\_Parameters  
  
 about\_Functions\_CmdletBindingAttribute  
  
 about\_Functions\_OutputTypeAttribute  
  
 about\_Parameters  
  
 about\_Profiles  
  
 about\_Scopes  
  
 about\_Script\_Blocks  
  
 Function \(provider\)