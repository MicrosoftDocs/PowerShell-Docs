# Chapter 9 - Functions

If you're writing PowerShell one-liners or scripts and find yourself often having to modify them for
different scenarios, or if you're sharing the code with others, there's a good chance that
particular one-liner or script is a good candidate to be turned into a function so that it can be
used as a reusable tool.

Whenever possible, I prefer to write a function because to me it's more tool oriented. I can place
the function in a script module, place that module in the $env:PSModulePath and with PowerShell
version 3.0 or higher, I can simply call the function without needing to physically locate where
it's saved. With PowerShellGet which was introduced in PowerShell version 5.0, it's also easier to
share those modules in a NuGet repository. PowerShellGet is available as a separate download for
PowerShell version 3.0 and higher.

Don't overcomplicate things. Keep it simple and use the most straight forward way to accomplish a
task. Avoid aliases and positional parameters in scripts and functions and any code that you share.
Format your code for readability. Don't hard code values (don't use static values), use parameters
and variables. Don't write unnecessary code even if it doesn't hurt anything because it adds
unnecessary complexity. Attention to detail goes a long way when writing any PowerShell code.

## Naming

When naming your functions in PowerShell, use a pascal case name with an approved verb and a
singular noun. I also recommend prefixing the noun. For example: ApprovedVerb-PrefixSingularNoun.

In PowerShell, there's a specific list of approved verbs which can be obtained by running Get-Verb.

```powershell
 Get-Verb | Sort-Object -Property Verb
```

```powershell
Verb        Group
----        -----
Add         Common
Approve     Lifecycle
Assert      Lifecycle
Backup      Data
Block       Security
Checkpoint  Data
Clear       Common
Close       Common
Compare     Data
Complete    Lifecycle
Compress    Data
Confirm     Lifecycle
Connect     Communications
Convert     Data
ConvertFrom Data
ConvertTo   Data
Copy        Common
Debug       Diagnostic
Deny        Lifecycle
Disable     Lifecycle
Disconnect  Communications
Dismount    Data
Edit        Data
Enable      Lifecycle
Enter       Common
Exit        Common
Expand      Data
Export      Data
Find        Common
Format      Common
Get         Common
Grant       Security
Group       Data
Hide        Common
Import      Data
Initialize  Data
Install     Lifecycle
Invoke      Lifecycle
Join        Common
Limit       Data
Lock        Common
Measure     Diagnostic
Merge       Data
Mount       Data
Move        Common
New         Common
Open        Common
Optimize    Common
Out         Data
Ping        Diagnostic
Pop         Common
Protect     Security
Publish     Data
Push        Common
Read        Communications
Receive     Communications
Redo        Common
Register    Lifecycle
Remove      Common
Rename      Common
Repair      Diagnostic
Request     Lifecycle
Reset       Common
Resize      Common
Resolve     Diagnostic
Restart     Lifecycle
Restore     Data
Resume      Lifecycle
Revoke      Security
Save        Data
Search      Common
Select      Common
Send        Communications
Set         Common
Show        Common
Skip        Common
Split       Common
Start       Lifecycle
Step        Common
Stop        Lifecycle
Submit      Lifecycle
Suspend     Lifecycle
Switch      Common
Sync        Data
Test        Diagnostic
Trace       Diagnostic
Unblock     Security
Undo        Common
Uninstall   Lifecycle
Unlock      Common
Unprotect   Security
Unpublish   Data
Unregister  Lifecycle
Update      Data
Use         Other
Wait        Lifecycle
Watch       Common
Write       Communications
```

In the previous example, I've sorted the results by the Verb column. The Group column gives you an
idea of how these verbs are used. The reason it's important to choose an approved verb in PowerShell
is once the functions are added to a module, the module will generate a warning message if you
choose an unapproved verb. That warning message will make your functions look unprofessional.
Unapproved verbs also limit the discoverability of your functions.

## A Simple function

A function in PowerShell is declared with the function keyword followed by the function name and
then an open and closing curly brace. The code that the function will execute is contained within
those curly braces.

```powershell
function Get-Version {
    $PSVersionTable.PSVersion
}
```

The PowerShell function shown in the previous example is a very simple example. It returns the
version of PowerShell.

```powershell
 Get-Version
```

```powershell
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

There's a good chance of name conflict with functions named something like Get-Version and default
commands in PowerShell or commands that others may write. This is why I recommend prefixing the noun
portion of your functions to help prevent naming conflicts. In the following example, I'll use the
prefix "PS".

```powershell
function Get-PSVersion {
    $PSVersionTable.PSVersion
}
```

Other than the name, this function is identical to the previous one.

```powershell
 Get-PSVersion
```

```powershell
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

Even when prefixing the noun with something like PS, there's still a good chance of having a name
conflict. I typically prefix my function nouns with my initials. Develop a standard and stick to it.

```powershell
function Get-MrPSVersion {
    $PSVersionTable.PSVersion
}
```

This function is no different than the previous two other than using a more sensible name to try to
prevent naming conflicts with other PowerShell commands.

```powershell
 Get-MrPSVersion
```

```powershell
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

Once loaded into memory, you can see functions on the Function PSDrive.

```powershell
 Get-ChildItem -Path Function:\Get-*Version
```

```powershell
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-Version
Function        Get-PSVersion
Function        Get-MrPSVersion
```

If you want to remove these functions from your current session, you'll have to remove them from the
Function PSDrive or close and re-open PowerShell.

```powershell
 Get-ChildItem -Path Function:\Get-*Version | Remove-Item
```

```powershell

```

Verify that the functions were indeed removed.

```powershell
 Get-ChildItem -Path Function:\Get-*Version
```

```powershell

```

If the functions were loaded as part of a module, the module can simply be unloaded to remove them.

```powershell
 Remove-Module -Name <ModuleName>
```

The Remove-Module cmdlet removes modules from memory in your current PowerShell session, it doesn't
remove them from your system or from disk.

## Parameters

Don't statically assign values! Use parameters and variables. When it comes to naming your
parameters, use the same name as the default cmdlets for your parameter names whenever possible.

```powershell
function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

Why did I use ComputerName and not Computer, ServerName, or Host for my parameter name? It's because
I wanted my function standardized like the default cmdlets.

I'll create a function to query all of the commands on a system and return the number of them that
have specific parameter names.

```powershell
function Get-MrParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($Parameter in $ParameterName) {
        $Results = Get-Command -ParameterName $Parameter -ErrorAction SilentlyContinue

        [pscustomobject]@{
            ParameterName = $Parameter
            NumberOfCmdlets = $Results.Count
        }
    }
}
```

As you can see in the results shown below, there are 39 commands that have a ComputerName parameter
and there aren't any that have parameters such as Computer, ServerName, Host, or Machine.

```powershell
 Get-MrParameterCount -ParameterName ComputerName, Computer,
ServerName, Host, Machine
```

```powershell
ParameterName NumberOfCmdlets
------------- ---------------
ComputerName               39
Computer                    0
ServerName                  0
Host                        0
Machine                     0
```

I also recommend using the same case for your parameter names as the default cmdlets. Use
ComputerName, not computername. This will make your functions look and feel like the default cmdlets
which means that people who are already familiar with PowerShell will feel right at home.

## Advanced Functions

Turning a function in PowerShell into an advanced function is really simple. One of the differences
in a function and an advanced function is that advanced functions have a number of common parameters
that are added to the function automatically. These common parameters include parameters such as
Verbose and Debug.

I'll start out with the Test-MrParameter function that was used in the previous section.

```powershell
function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

What I want you to notice is that the Test-MrParameter function doesn't have any common parameters.
There are a couple of different ways to see the common parameters. One is by viewing the syntax
using Get-Command.

```powershell
 Get-Command -Name Test-MrParameter -Syntax
```

```powershell
Test-MrParameter [[-ComputerName] <Object>]
```

Another is to drill down into the parameters with Get-Command.

```powershell
 (Get-Command -Name Test-MrParameter).Parameters.Keys
```

```powershell
ComputerName

```

Add CmdletBinding to turn the function into an advanced function.

```powershell
function Test-MrCmdletBinding {

    [CmdletBinding()] #<<-- This turns a regular function into an advanced function
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

Simply adding CmdletBinding adds the common parameters automatically. CmdletBinding does require a
param block, but the param block can be empty.

```powershell
 Get-Command -Name Test-MrCmdletBinding -Syntax
```

```powershell
Test-MrCmdletBinding [[-ComputerName] <Object>] [<CommonParameters>]
```

Drilling down into the parameters with Get-Command shows the actual parameter names including the
common ones.

```powershell
 (Get-Command -Name Test-MrCmdletBinding).Parameters.Keys
```

```powershell
ComputerName
Verbose
Debug
ErrorAction
WarningAction
InformationAction
ErrorVariable
WarningVariable
InformationVariable
OutVariable
OutBuffer
PipelineVariable

```

## SupportsShouldProcess

SupportsShouldProcess adds WhatIf and Confirm parameters. This is only needed for commands that make
changes.

```powershell
function Test-MrSupportsShouldProcess {

    [CmdletBinding(SupportsShouldProcess)]
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

Notice that there are now WhatIf and Confirm parameters.

```powershell
 Get-Command -Name Test-MrSupportsShouldProcess -Syntax
```

```powershell
Test-MrSupportsShouldProcess [[-ComputerName] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

Once again, you can also use Get-Command to return a list of the actual parameter names including
the common ones along with WhatIf and Confirm.

```powershell
 (Get-Command -Name Test-MrSupportsShouldProcess).Parameters.Keys
```

```powershell
ComputerName
Verbose
Debug
ErrorAction
WarningAction
InformationAction
ErrorVariable
WarningVariable
InformationVariable
OutVariable
OutBuffer
PipelineVariable
WhatIf
Confirm

```

## Parameter Validation

Validate input early on. Why allow your code to continue on a path when it's not possible to
successfully complete without valid input?

Always type the variables that are being used for your parameters (specify a datatype).

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [string]$ComputerName
    )

    Write-Output $ComputerName

}
```

In the previous example, I've specified String as the datatype for the ComputerName parameter. This
causes it to allow only a single computer name to be specified. If more than one computer name is
specified via a comma separated list, an error will be generated.

```powershell
 Test-MrParameterValidation -ComputerName Server01, Server02
```

```powershell
Test-MrParameterValidation : Cannot process argument transformation on parameter
'ComputerName'. Cannot convert value to type System.String.
At line:1 char:42
+ Test-MrParameterValidation -ComputerName Server01, Server02
+
    + CategoryInfo          : InvalidData: (:) [Test-MrParameterValidation], ParameterBi
   ndingArgumentTransformationException
    + FullyQualifiedErrorId : ParameterArgumentTransformationError,Test-MrParameterValid
   ation
```

The problem at this point is that it's perfectly valid to not specify a computer name at all and at
least one computer name needs to be specified otherwise the function can't possibly complete
successfully. This is where the Mandatory parameter attribute comes in handy.

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ComputerName
    )

    Write-Output $ComputerName

}
```

The syntax used in the previous example is PowerShell version 3.0 and higher compatible.
[Parameter(Mandatory=$true)] could be specified instead to make the function compatible with
PowerShell version 2.0 and higher. Now that the ComputerName is required, if one isn't specified,
the function will prompt for one.

```powershell
 Test-MrParameterValidation
```

```powershell
cmdlet Test-MrParameterValidation at command pipeline position 1
Supply values for the following parameters:
ComputerName:
```

If you want to allow for more than one value to be specified for the ComputerName parameter, use the
String datatype but add open and closed square brackets to the datatype to allow for an array of
strings.

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$ComputerName
    )

    Write-Output $ComputerName

}
```

Maybe you want to specify a default value for the ComputerName parameter if one is not specified.
The problem is that default values cannot be used with mandatory parameters. Instead, you'll need to
use the ValidateNotNullOrEmpty parameter validation attribute with a default value.

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    Write-Output $ComputerName

}
```

Even when setting a default value, try not to use static values. In the previous example,
$env:COMPUTERNAME is used as the default value which will automatically be translated into the local
computer name if a value is not provided.

## Verbose Output

While inline comments are useful, especially if you writing some unusual code that may not be
straight forward, they'll never been seen by someone who is using your functions unless they dig
into the code itself.

The function shown in the following example has an inline comment in the foreach loop. While this
particular comment may not be that difficult to locate, imagine if the function included hundreds of
lines of code.

```powershell
function Test-MrVerboseOutput {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        #Attempting to perform some action on $Computer <<-- Don't use
        #inline comments like this, use write verbose instead.
        Write-Output $Computer
    }

}
```

A better option is to use Write-Verbose instead of inline comments.

```powershell
function Test-MrVerboseOutput {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        Write-Verbose -Message "Attempting to perform some action on $Computer"
        Write-Output $Computer
    }

}
```

When the function is called without the Verbose parameter, the verbose output won't be displayed.

```powershell
Test-MrVerboseOutput -ComputerName Server01, Server02
```

When it's called with the Verbose parameter, the verbose output will be displayed.

```powershell
Test-MrVerboseOutput -ComputerName Server01, Server02 -Verbose
```

## Pipeline Input

When you want your function to accept pipeline input, some additional coding is necessary. As
mentioned earlier in this book, commands can accept pipeline input by value (by type) or by property
name. You can write your functions just like the native commands so they can accept either one or
both of these types of input.

To accept pipeline input by value, specified the ValueFromPipeline parameter attribute for that
particular parameter. Keep in mind that you can only accept pipeline input by value from one of each
datatype. For example, if you have two parameters that accept string input, only one of those can
accept pipeline input by value because if you specified it for both of the string parameters, the
pipeline input wouldn't know which one to bind to. This is another reason I call this type of
pipeline input by type instead of by value.

Pipeline input comes in one item at a time similar to the way a foreach loop works. At a minimum, a
PROCESS block is required to process each of these items if you're accepting an array as input. If
you're only accepting a single value as input, a process block isn't necessary, but I still
recommend going ahead and specifying it for consistency.

```powershell
function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [string[]]$ComputerName
    )

    PROCESS {
        Write-Output $ComputerName
    }

}
```

Accepting pipeline input by property name is similar except it's specified with the
ValueFromPipelineByPropertyName parameter attribute and it can be specified for any number of
parameters regardless of datatype. The key is that the output of the command that's being piped in
has to have a property name that matches the name of the parameter or a parameter alias of your
function.

```powershell
function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
            Write-Output $ComputerName
    }

}
```

BEGIN and END blocks are optional. BEGIN would be specified before the PROCESS block and is used to
perform any initial work prior to the items being received from the pipeline. This is very important
to understand. Values that are piped in are NOT accessible in the BEGIN block. The END block would
be specified after the PROCESS block and is used for cleanup once all of the items that are piped in
have been processed.

## Error Handling

The function shown in the following example will generate an unhandled exception if a computer
cannot be contacted.

```powershell
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            Test-WSMan -ComputerName $Computer
        }
    }

}
```

There are a couple of different ways to handle errors in PowerShell. Try / Catch is the more modern
way to handle errors.

```powershell
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                Test-WSMan -ComputerName $Computer
            }
            catch {
                Write-Warning -Message "Unable to connect to Computer: $Computer"
            }
        }
    }

}
```

Although the function shown in the previous example uses error handling, it also generates an
unhandled exception because the command doesn't generate a terminating error. This is also very
important to understand. Only terminating errors are caught. Specify the ErrorAction parameter with
Stop as the value to turn a non-terminating error into a terminating one.

```powershell
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                Test-WSMan -ComputerName $Computer -ErrorAction Stop
            }
            catch {
                Write-Warning -Message "Unable to connect to Computer: $Computer"
            }
        }
    }

}
```

Don't modify the global $ErrorActionPreference variable unless absolutely necessary. If you're using
something like the .NET Framework directly from within your PowerShell function, you won't be able
to specify the ErrorAction on the command itself. In that scenario, you might need to change the
global $ErrorActionPreference variable, but if you do change it, change it back immediately after
trying the command.

## Comment-Based Help

It's considered to be a best practice to add comment based help to your functions so the people
you're sharing them with will know how to use them.

```powershell
function Get-MrAutoStoppedService {

<#
.SYNOPSIS
    Returns a list of services that are set to start automatically, are not
    currently running, excluding the services that are set to delayed start.

.DESCRIPTION
    Get-MrAutoStoppedService is a function that returns a list of services from
    the specified remote computer(s) that are set to start automatically, are not
    currently running, and it excludes the services that are set to start automatically
    with a delayed startup.

.PARAMETER ComputerName
    The remote computer(s) to check the status of the services on.

.PARAMETER Credential
    Specifies a user account that has permission to perform this action. The default
    is the current user.

.EXAMPLE
     Get-MrAutoStoppedService -ComputerName 'Server1', 'Server2'

.EXAMPLE
     'Server1', 'Server2' | Get-MrAutoStoppedService

.EXAMPLE
     Get-MrAutoStoppedService -ComputerName 'Server1' -Credential (Get-Credential)

.INPUTS
    String

.OUTPUTS
    PSCustomObject

.NOTES
    Author:  Mike F Robbins
    Website: http://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (

    )

    #Function Body

}
```

When you add comment based help to your functions, help can be retrieved for them just like the
default built-in commands.

All of the syntax for writing a function in PowerShell can seem overwhelming especially for someone
who is just getting started. Often times if I can't remember the syntax for something, I'll open a
second copy of the ISE on a separate monitor and view the "Cmdlet (advanced function) - Complete"
snippet while typing in the code for my function. Snippets can be access in the PowerShell ISE using
the Cntl + J key combination.

## Summary

In this chapter you've learned the basics of writing functions in PowerShell to include how to turn
a function into an advanced function and some of the more important elements that you should
consider when writing PowerShell functions such as parameter validation, verbose output, pipeline
input, error handling, and comment based help.

## Review

1. How do you obtain a list of approved verbs in PowerShell?
1. How do you turn a PowerShell function into an advanced function?
1. When should WhatIf and Confirm parameters be added to your PowerShell functions?
1. How do you turn a non-terminating error into a terminating one?
1. Why should you add comment based help to your functions?

## Recommended Reading

- [about_Functions](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions)
- [about_Functions_Advanced_Parameters](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions_advanced_parameters)
- [about_CommonParameters](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_commonparameters)
- [about_Functions_CmdletBindingAttribute](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions_cmdletbindingattribute)
- [about_Functions_Advanced](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions_advanced)
- [about_Try_Catch_Finally](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_try_catch_finally)
- [about_Comment_Based_Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_comment_based_help)
- [Video: PowerShell Toolmaking with Advanced Functions and Script Modules](http://mikefrobbins.com/2016/05/26/video-powershell-toolmaking-with-advanced-functions-and-script-modules/)
