---
description: Learn how to create reusable PowerShell functions, implement best practices, and avoid common pitfalls in function design, error handling, and parameter validation.
ms.custom: Contributor-mikefrobbins
ms.date: 01/22/2025
ms.reviewer: mirobb
title: Functions
---

# Chapter 9 - Functions

PowerShell one-liners and scripts that have to be modified often are good candidates to turn into
reusable functions.

Write functions whenever possible because they're more tool-oriented. You can add the functions to a
script module, put that module in a location defined in the `$Env:PSModulePath`, and call the
functions without needing to locate where you saved the functions. Using the **PowerShellGet**
module, it's easy to share your PowerShell modules in a NuGet repository. **PowerShellGet** ships
with PowerShell version 5.0 and higher. It's also available as a separate download for PowerShell
version 3.0 and higher.

Don't overcomplicate things. Keep it simple and use the most straightforward way to accomplish a
task. Avoid aliases and positional parameters in any code that you reuse. Format your code for
readability. Don't hardcode values; use parameters and variables. Don't write unnecessary code even
if it doesn't hurt anything. It adds unnecessary complexity. Attention to detail goes a long way
when writing any PowerShell code.

## Naming

When naming your functions in PowerShell, use a [Pascal case][Pascal case] name with an approved
verb and a singular noun. To obtain a list of approved verbs in PowerShell, run `Get-Verb`. The
following example sorts the results of `Get-Verb` by the **Verb** property.

```powershell
Get-Verb | Sort-Object -Property Verb
```

The **Group** property gives you an idea of how the verbs are meant to be used.

```Output
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

It's important to use an approved verb for your PowerShell functions. Modules that contain functions
with unapproved verbs generate a warning message when they're imported into a PowerShell session.
That warning message makes your functions look unprofessional. Unapproved verbs also limit the
discoverability of your functions.

## A simple function

A function in PowerShell is declared with the function keyword followed by the function name and
then an opening and closing curly brace (`{ }`). The code executed by the function is contained
within those curly braces.

```powershell
function Get-Version {
    $PSVersionTable.PSVersion
}
```

The function shown in the following example is a simple example that returns the version of
PowerShell.

```powershell
Get-Version
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

When you use a generic name for your functions, such as `Get-Version`, it could cause naming
conflicts. Default commands added in the future or commands that others might write could conflict
with them. Prefix the noun portion of your function names to help prevent naming conflicts. For
example: `<ApprovedVerb>-<Prefix><SingularNoun>`.

The following example uses the prefix `PS`.

```powershell
function Get-PSVersion {
    $PSVersionTable.PSVersion
}
```

Other than the name, this function is identical to the previous one.

```powershell
Get-PSVersion
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

You can still have a name conflict even when you add a prefix to the noun. I like to prefix my
function nouns with my initials. Develop a standard and stick to it.

```powershell
function Get-MrPSVersion {
    $PSVersionTable.PSVersion
}
```

This function is no different than the previous two, except for using a more unique name to try to
prevent naming conflicts with other PowerShell commands.

```powershell
Get-MrPSVersion
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      14393  693
```

Once loaded into memory, you can see functions on the **Function** PSDrive.

```powershell
Get-ChildItem -Path Function:\Get-*Version
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Function        Get-Version
Function        Get-PSVersion
Function        Get-MrPSVersion
```

If you want to remove these functions from your current session, remove them from the **Function**
PSDrive or close and reopen PowerShell.

```powershell
Get-ChildItem -Path Function:\Get-*Version | Remove-Item
```

Verify that the functions were indeed removed.

```powershell
Get-ChildItem -Path Function:\Get-*Version
```

If the functions were loaded as part of a module, you can unload the module to remove them.

```powershell
Remove-Module -Name <ModuleName>
```

The `Remove-Module` cmdlet removes PowerShell modules from memory in your current PowerShell
session. It doesn't remove them from your system or disk.

## Parameters

Don't statically assign values. Use parameters and variables instead. When naming your parameters,
use the same name as the default cmdlets for your parameter names whenever possible.

In the following function, notice that I used **ComputerName** and not **Computer**, **ServerName**,
or **Host** for the parameter name. Using **ComputerName** standardizes the parameter name to match
the parameter name and case like the default cmdlets.

```powershell
function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

The following function queries all commands on your system and returns the number with specific
parameter names.

```powershell
function Get-MrParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($Parameter in $ParameterName) {
        $Results = Get-Command -ParameterName $Parameter -ErrorAction SilentlyContinue

        [pscustomobject]@{
            ParameterName   = $Parameter
            NumberOfCmdlets = $Results.Count
        }
    }
}
```

As you can see in the following results, 39 commands that have a **ComputerName** parameter. There
aren't any commands with parameters such as **Computer**, **ServerName**, **Host**, or **Machine**.

```powershell
Get-MrParameterCount -ParameterName ComputerName, Computer, ServerName,
    Host, Machine
```

```Output
ParameterName NumberOfCmdlets
------------- ---------------
ComputerName               39
Computer                    0
ServerName                  0
Host                        0
Machine                     0
```

Use the same case for your parameter names as the default cmdlets. For example, use `ComputerName`,
not `computername`. This naming scheme helps people familiar with PowerShell discover your functions
and look and feel like the default cmdlets.

The `param` statement allows you to define one or more parameters. A comma (`,`) separates the
parameter definitions. For more information, see
[about_Functions_Advanced_Parameters][about_Functions_Advanced_Parameters].

## Advanced functions

Turning a function into an advanced function in PowerShell is simple. One of the differences between
a function and an advanced function is that advanced functions have common parameters that are
automatically added. Common parameters include parameters such as **Verbose** and **Debug**.

Start with the `Test-MrParameter` function that was used in the previous section.

```powershell
function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

There are a couple of different ways to see the common parameters. One is by viewing the syntax with
`Get-Command`.

```powershell
Get-Command -Name Test-MrParameter -Syntax
```

Notice the `Test-MrParameter` function doesn't have any common parameters.

```Output
Test-MrParameter [[-ComputerName] <Object>]
```

Another is to drill down into the parameters property of `Get-Command`.

```powershell
(Get-Command -Name Test-MrParameter).Parameters.Keys
```

```Output
ComputerName
```

Add the `CmdletBinding` attribute to turn the function into an advanced function.

```powershell
function Test-MrCmdletBinding {

    [CmdletBinding()] # Turns a regular function into an advanced function
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

When you specify `CmdletBinding`, the common parameters are added automatically. `CmdletBinding`
requires a `param` block, but the `param` block can be empty.

```powershell
Get-Command -Name Test-MrCmdletBinding -Syntax
```

```Output
Test-MrCmdletBinding [[-ComputerName] <Object>] [<CommonParameters>]
```

Drilling down into the parameters property of `Get-Command` shows the actual parameter names,
including the common ones.

```powershell
(Get-Command -Name Test-MrCmdletBinding).Parameters.Keys
```

```Output
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

The `SupportsShouldProcess` attribute adds the **WhatIf** and **Confirm** risk mitigation
parameters. These parameters are only needed for commands that make changes.

```powershell
function Test-MrSupportsShouldProcess {

    [CmdletBinding(SupportsShouldProcess)]
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}
```

Notice that there are now **WhatIf** and **Confirm** parameters.

```powershell
Get-Command -Name Test-MrSupportsShouldProcess -Syntax
```

```Output
Test-MrSupportsShouldProcess [[-ComputerName] <Object>] [-WhatIf] [-Confirm]
[<CommonParameters>]
```

Once again, you can also use `Get-Command` to return a list of the actual parameter names, including
the common, ones along with **WhatIf** and **Confirm**.

```powershell
(Get-Command -Name Test-MrSupportsShouldProcess).Parameters.Keys
```

```Output
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

## Parameter validation

Validate input early on. Don't allow your code to continue on a path when it can't complete without
valid input.

Always specify a datatype for the variables used for parameters. In the following example,
**String** is specified as the datatype for the **ComputerName** parameter. This validation limits
it to only allow a single computer name to be specified for the **ComputerName** parameter.

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [string]$ComputerName
    )

    Write-Output $ComputerName

}
```

An error is generated if more than one computer name is specified.

```powershell
Test-MrParameterValidation -ComputerName Server01, Server02
```

```Output
Test-MrParameterValidation : Cannot process argument transformation on
parameter 'ComputerName'. Cannot convert value to type System.String.
At line:1 char:42
+ Test-MrParameterValidation -ComputerName Server01, Server02
+                                          ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidData: (:) [Test-MrParameterValidation]
   , ParameterBindingArgumentTransformationException
    + FullyQualifiedErrorId : ParameterArgumentTransformationError,Test-MrP
   arameterValidation
```

The problem with the current definition is that it's valid to omit the value of the **ComputerName**
parameter, but a value is required for the function to complete successfully. This scenario is where
the `Mandatory` parameter attribute is beneficial.

The syntax used in the following example is compatible with PowerShell version 3.0 and higher.
`[Parameter(Mandatory=$true)]` could be specified to make the function compatible with PowerShell
version 2.0 or higher.

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

Now that the **ComputerName** is required, if one isn't specified, the function prompts for one.

```powershell
Test-MrParameterValidation
```

```Output
cmdlet Test-MrParameterValidation at command pipeline position 1
Supply values for the following parameters:
ComputerName:
```

If you want to allow more than one value for the **ComputerName** parameter, use the **String**
datatype but add square brackets (`[]`) to the datatype to allow an array of strings.

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

Maybe you want to specify a default value for the **ComputerName** parameter if one isn't specified.
The problem is that default values can't be used with mandatory parameters. Instead, use the
`ValidateNotNullOrEmpty` parameter validation attribute with a default value.

Even when setting a default value, try not to use static values. In the following example,
`$Env:COMPUTERNAME` is used as the default value, which is automatically translated to the local
computer name if a value isn't provided.

```powershell
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $Env:COMPUTERNAME
    )

    Write-Output $ComputerName

}
```

## Verbose output

Inline comments are useful if you're writing complex code, but users don't see them unless they look
at the code.

The function in the following example has an inline comment in the `foreach` loop. While this
particular comment might not be difficult to locate, imagine if the function contained hundreds of
lines of code.

```powershell
function Test-MrVerboseOutput {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $Env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        #Attempting to perform an action on $Computer <<-- Don't use
        #inline comments like this, use write verbose instead.
        Write-Output $Computer
    }

}
```

A better option is to use `Write-Verbose` instead of inline comments.

```powershell
function Test-MrVerboseOutput {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $Env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        Write-Verbose -Message "Attempting to perform an action on $Computer"
        Write-Output $Computer
    }

}
```

The verbose output isn't displayed when the function is called without the **Verbose** parameter.

```powershell
Test-MrVerboseOutput -ComputerName Server01, Server02
```

The verbose output is displayed when the function is called with the **Verbose** parameter.

```powershell
Test-MrVerboseOutput -ComputerName Server01, Server02 -Verbose
```

## Pipeline input

Extra code is necessary when you want your function to accept pipeline input. As mentioned earlier
in this book, commands can accept pipeline input **by value** (by type) or **by property name**. You
can write your functions like the native commands so they accept either one or both of these input
types.

To accept pipeline input **by value**, specify the `ValueFromPipeline` parameter attribute for that
particular parameter. You can only accept pipeline input **by value** from one parameter of each
datatype. If you have two parameters that accept string input, only one of them can accept pipeline
input **by value**. If you specified **by value** for both of the string parameters, the input
wouldn't know which parameter to bind to. This scenario is another reason I call this type of
pipeline input _by type_ instead of **by value**.

Pipeline input is received one item at a time, similar to how items are handled in a `foreach` loop.
A `process` block is required to process each item if your function accepts an array as input. If
your function only accepts a single value as input, a `process` block isn't necessary but is
recommended for consistency.

```powershell
function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [string[]]$ComputerName
    )

    process {
        Write-Output $ComputerName
    }

}
```

Accepting pipeline input **by property name** is similar, except you specify it with the
`ValueFromPipelineByPropertyName` parameter attribute, and it can be specified for any number of
parameters regardless of datatype. The key is the output of the command being piped in must have a
property name that matches the name of the parameter or a parameter alias of your function.

```powershell
function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    process {
            Write-Output $ComputerName
    }

}
```

`begin` and `end` blocks are optional. `begin` is specified before the `process` block and is used
to perform any initial work before the items are received from the pipeline. Values that are piped
in aren't accessible in the `begin` block. The `end` block is specified after the `process` block
and is used for cleanup after all items piped in are processed.

## Error handling

The function shown in the following example generates an unhandled exception when a computer can't
be contacted.

```powershell
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    process {
        foreach ($Computer in $ComputerName) {
            Test-WSMan -ComputerName $Computer
        }
    }

}
```

There are a couple of different ways to handle errors in PowerShell. `Try/Catch` is the more modern
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

    process {
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

Although the function shown in the previous example uses error handling, it generates an unhandled
exception because the command doesn't generate a terminating error. Only terminating errors are
caught. Specify the **ErrorAction** parameter with **Stop** as its value to turn a nonterminating
error into a terminating one.

```powershell
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    process {
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

Don't modify the global `$ErrorActionPreference` variable unless absolutely necessary. If you change
it in a local scope, it reverts to the previous value when you exit that scope.

If you're using something like .NET directly from within your PowerShell function, you can't specify
the **ErrorAction** parameter on the command itself. You can change the `$ErrorActionPreference`
variable just before you call the .NET method.

## Comment-based help

Adding help to your functions is considered a best practice. Help allows people you share them with
to know how to use them.

```powershell
function Get-MrAutoStoppedService {

<#
.SYNOPSIS
    Returns a list of services that are set to start automatically, are not
    currently running, excluding the services that are set to delayed start.

.DESCRIPTION
    Get-MrAutoStoppedService is a function that returns a list of services
    from the specified remote computer(s) that are set to start
    automatically, are not currently running, and it excludes the services
    that are set to start automatically with a delayed startup.

.PARAMETER ComputerName
    The remote computer(s) to check the status of the services on.

.PARAMETER Credential
    Specifies a user account that has permission to perform this action. The
    default is the current user.

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
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (

    )

    #Function Body

}
```

When you add comment-based help to your functions, help can be retrieved for them like the default
built-in commands.

All the syntax for writing a function in PowerShell can seem overwhelming for someone getting
started. If you can't remember the syntax for something, open a second instance of the PowerShell
Integrated Scripting Environment (ISE) on a separate monitor and view the "Cmdlet (advanced
function) - Complete" snippet while typing in the code for your functions. Snippets can be accessed
in the PowerShell ISE using the <kbd>Ctrl</kbd> + <kbd>J</kbd> key combination.

## Summary

In this chapter, you learned the basics of writing functions in PowerShell, including how to:

- Create advanced functions
- Use parameter validation
- Use verbose output
- Support pipeline input
- Handle errors
- Create comment-based help

## Review

1. How do you obtain a list of approved verbs in PowerShell?
1. How do you turn a PowerShell function into an advanced function?
1. When should **WhatIf** and **Confirm** parameters be added to your PowerShell functions?
1. How do you turn a nonterminating error into a terminating one?
1. Why should you add comment-based help to your functions?

## References

- [about_Functions][about_Functions]
- [about_Functions_Advanced_Parameters][about_Functions_Advanced_Parameters]
- [about_CommonParameters][about_CommonParameters]
- [about_Functions_CmdletBindingAttribute][about_Functions_CmdletBindingAttribute]
- [about_Functions_Advanced][about_Functions_Advanced]
- [about_Try_Catch_Finally][about_Try_Catch_Finally]
- [about_Comment_Based_Help][about_Comment_Based_Help]
- [Video: PowerShell Toolmaking with Advanced Functions and Script Modules][Video: PowerShell Toolmaking with Advanced Functions and Script Modules]

<!-- link references -->

[about_Functions]: /powershell/module/microsoft.powershell.core/about/about_functions
[about_Functions_Advanced_Parameters]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters
[about_CommonParameters]: /powershell/module/microsoft.powershell.core/about/about_commonparameters
[about_Functions_CmdletBindingAttribute]: /powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute
[about_Functions_Advanced]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced
[about_Try_Catch_Finally]: /powershell/module/microsoft.powershell.core/about/about_try_catch_finally
[about_Comment_Based_Help]: /powershell/module/microsoft.powershell.core/about/about_comment_based_help
[Video: PowerShell Toolmaking with Advanced Functions and Script Modules]: https://mikefrobbins.com/2016/05/26/video-powershell-toolmaking-with-advanced-functions-and-script-modules/
[Pascal case]: /dotnet/standard/design-guidelines/capitalization-conventions
