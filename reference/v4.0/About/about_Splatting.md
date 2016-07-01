---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Splatting
ms.technology:  powershell
ms.assetid:  94639e7b-25ee-424b-9a51-bda2891d8882
---

# about_Splatting
## TOPIC  
 about\_Splatting  
  
## SHORT DESCRIPTION  
 Describes how to use splatting to pass parameters to commands in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 \[This topic was contributed by Rohn Edwards of Gulfport, Mississippi, a system administrator and the winner of the Advanced Division of the 2012 Scripting Games. Revised for [!INCLUDE[wps_2]()] 3.0.\]  
  
 Splatting is a method of passing a collection of parameter values to a command as unit. [!INCLUDE[wps_2]()] associates each value in the collection with a command parameter. Splatted parameter values are stored in named splatting variables, which look like standard variables, but begin with an At symbol \(@\) instead of a dollar sign \($\). The At symbol tells [!INCLUDE[wps_2]()] that you are passing a collection of values, instead of a single value.  
  
 Splatting makes your commands shorter and easier to read. You can re\-use the splatting values in different command calls and use splatting to pass parameter values from the $PSBoundParameters automatic variable to other scripts and functions.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, you can also use splatting to represent all parameters of a command.  
  
## SYNTAX  
  
```  
<CommandName> <optional parameters> @<HashTable> <optional parameters>  
  
<CommandName> <optional parameters> @<Array> <optional parameters>  
```  
  
 To provide parameter values for positional parameters, in which parameter names are not required, use the array syntax. To provide parameter name and value pairs, use the hash table syntax. The splatted value can appear anywhere in the parameter list.  
  
 When splatting, you do not need to use a hash table or an array to pass all parameters. You may pass some parameters by using splatting and pass others by position or by parameter name. Also, you can splat multiple objects in a single command just so you pass no more than one value for each parameter.  
  
## SPLATTING WITH HASH TABLES  
 Use a hash table to splat parameter name and value pairs. You can use this format for all parameter types, including positional and named parameters and switch parameters.  
  
 The following examples compare two Copy\-Item commands that copy the Test.txt file to the Test2.txt file in the same directory.  
  
 The first example uses the traditional format in which parameter names are included.  
  
```  
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf  
```  
  
 The second example uses hash table splatting. The first command creates a hash table of parameter\-name and parameter\-value pairs and stores it in the $HashArguments variable. The second command uses the $HashArguments variable in a command with splatting. The At symbol \(@HashArguments\) replaces the dollar sign \($HashArguments\) in the command.  
  
 To provide a value for the WhatIf switch parameter, use $True or $False.  
  
```  
PS C:\>$HashArguments = @{ Path = "test.txt"; Destination = "test2.txt"; WhatIf = $true }  
PS C:\>Copy-Item @HashArguments  
```  
  
 Note: In the first command, the At symbol \(@\) indicates a hash table, not a splatted value. The syntax for hash tables in [!INCLUDE[wps_2]()] is: @{ \<name\>\=\<value\>; \<name\>\=\<value\>; …}  
  
## SPLATTING WITH ARRAYS  
 Use an array to splat values for positional parameters, which do not require parameter names. The values must be in position\-number order in the array.  
  
 The following examples compare two Copy\-Item commands that copy the Test.txt file to the Test2.txt file in the same directory.  
  
 The first example uses the traditional format in which parameter names are omitted. The parameter values appear in position order in the command.  
  
```  
Copy-Item "test.txt" "test2.txt" -WhatIf  
```  
  
 The second example uses array splatting. The first command creates an array of the parameter values and stores it in the $ArrayArguments variable. The values are in position order in the array. The second command uses the $ArrayArguments variable in a command in splatting. The At symbol \(@ArrayArguments\) replaces the dollar sign \($ArrayArguments\) in the command.  
  
```  
PS C:\>$ArrayArguments = "test.txt", "test2.txt"  
PS C:\>Copy-Item @ArrayArguments -WhatIf  
```  
  
## EXAMPLES  
 This example shows how to re\-use splatted values in different commands. The commands in this example use the Write\-Host cmdlet to write messages to the host program console. It uses splatting to specify the foreground and background colors.  
  
 To change the colors of all commands, just change the value of the $Colors variable.  
  
 The first command creates a hash table of parameter names and values and stores the hash table in the $Colors variable.  
  
```  
$Colors = @{ForegroundColor = "black"  
            BackgroundColor = "white"}  
```  
  
 The second and third commands use the $Colors variable for splatting in a Write\-Host command. To use the $Colors variable, replace the dollar sign \($Colors\) with an At symbol \(@Colors\).  
  
```  
# Write a message with the colors in $Colors  
Write-Host "This is a test." @Colors  
  
# Write second message with same colors.   
# The position of splatted hash table does not matter.  
Write-Host @Colors "This is another test."  
```  
  
 This example shows how to forward their parameters to other commands by using splatting and the $PSBoundParameters automatic variable.  
  
 The $PSBoundParameters automatic variable is a dictionary \(System.Collections.Generic.Dictionary\) that contains all of the parameter names and values that are used when a script or function is run.  
  
 In the following example, we use the $PSBoundParameters variable to forward the parameters values passed to a script or function from Test2 function to the Test1 function. Both calls to the Test1 function from Test2 use splatting.  
  
```  
function Test1  
{  
     param($a, $b, $c)  
  
     $a  
     $b  
     $c  
 }                
  
function Test2  
{  
     param($a, $b, $c)  
  
     # Call the Test1 function with $a, $b, and $c.  
     Test1 @PsBoundParameters  
  
     # Call the Test1 function with $b and $c, but not with $a  
     $LimitedParameters = $PSBoundParameters  
     $LimitedParameters.Remove("a") | Out-Null  
     Test1 @LimitedParameters  
 }  
  
 PS C:\> Test2 -a 1 -b 2 -c 3  
 1  
 2  
 3  
 2  
 3  
```  
  
## SPLATTING COMMAND PARAMETERS  
 You can use splatting to represent the parameters of a command. This technique is useful when you are creating a proxy function, that is, a function that calls another command. This feature is introduced in [!INCLUDE[wps_2]()] 3.0.  
  
 To splat the parameters of a command, use @Args to represent the command parameters. This technique is easier than enumerating command parameters and it works without revision even if the parameters of the called command change.  
  
 The feature uses the $Args automatic variable, which contains all unassigned parameter values.Insert section body here.  
  
 For example, the following function calls the Get\-Process cmdlet. In this function, @Args represents all of the parameters of the Get\-Process cmdlet.  
  
```  
function Get-MyProcess { Get-Process @Args }  
```  
  
 When you use the Get\-MyProcess function, all unassigned parameters and parameter values are passed to @Args, as shown in the following commands.  
  
```  
PS C:\> Get-MyProcess -Name PowerShell    
  
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName  
-------  ------    -----      ----- -----   ------     -- -----------  
    463      46   225484     237196   719    15.86   3228 powershell  
  
PS C:\> Get-MyProcess -Name PowerShell_Ise -FileVersionInfo   
  
ProductVersion   FileVersion      FileName  
--------------   -----------      --------  
6.2.9200.16384   6.2.9200.1638... C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe  
```  
  
 You can use @Args in a function that has explicitly declared parameters. You can use it more than once in a function, but all parameters that you enter are passed to all instances of @Args, as shown in the following example.  
  
```  
function Get-MyCommand   
{   
    Param ([switch]$P, [switch]$C)  
    if ($P) { Get-Process @Args }  
    if ($C) { Get-Command @Args }  
}          
  
PS C:\> Get-MyCommand -P -C -Name PowerShell  
  
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName  
-------  ------    -----      ----- -----   ------     -- -----------  
    408      28    75568      83176   620     1.33   1692 powershell  
  
Path               : C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe  
Extension          : .exe  
Definition         : C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe  
Visibility         : Public  
OutputType         : {System.String}  
Name               : powershell.exe  
CommandType        : Application  
ModuleName         :  
Module             :  
RemotingCapability : PowerShell  
Parameters         :  
ParameterSets      :  
HelpUri            :  
FileVersionInfo    : File:             C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe  
```  
  
## SEE ALSO  
 about\_Arrays  
  
 about\_Automatic\_Variables  
  
 about\_Hash\_Tables  
  
 about\_Parameters

