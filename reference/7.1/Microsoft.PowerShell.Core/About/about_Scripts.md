---
description: Describes how to run and write scripts in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/06/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scripts?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Scripts
---
# About Scripts

## Short description
Describes how to run and write scripts in PowerShell.

## Long description

A script is a plain text file that contains one or more PowerShell commands.
PowerShell scripts have a `.ps1` file extension.

Running a script is a lot like running a cmdlet. You type the path and file
name of the script and use parameters to submit data and set options. You can
run scripts on your computer or in a remote session on a different computer.

Writing a script saves a command for later use and makes it easy to share with
others. Most importantly, it lets you run the commands simply by typing the
script path and the filename. Scripts can be as simple as a single command in
a file or as extensive as a complex program.

Scripts have additional features, such as the `#Requires` special comment, the
use of parameters, support for data sections, and digital signing for security.
You can also write Help topics for scripts and for any functions in the script.

## How to run a script

Before you can run a script on Windows, you need to change the default
PowerShell execution policy. Execution policy does not apply to PowerShell
running on non-Windows platforms.

The default execution policy, `Restricted`, prevents all scripts from running,
including scripts that you write on the local computer. For more information,
see [about_Execution_Policies](about_Execution_Policies.md).

The execution policy is saved in the registry, so you need to change it only
once on each computer.

To change the execution policy, use the following procedure.

At the command prompt, type:

```powershell
Set-ExecutionPolicy AllSigned
```

or

```powershell
Set-ExecutionPolicy RemoteSigned
```

The change is effective immediately.

To run a script, type the full name and the full path to the script file.

For example, to run the Get-ServiceLog.ps1 script in the C:\Scripts directory,
type:

```powershell
C:\Scripts\Get-ServiceLog.ps1
```

To run a script in the current directory, type the path to the current
directory, or use a dot to represent the current directory, followed by a path
backslash (`.\`).

For example, to run the ServicesLog.ps1 script in the local directory, type:

```powershell
.\Get-ServiceLog.ps1
```

If the script has parameters, type the parameters and parameter values after
the script filename.

For example, the following command uses the ServiceName parameter of the
Get-ServiceLog script to request a log of WinRM service activity.

```powershell
.\Get-ServiceLog.ps1 -ServiceName WinRM
```

As a security feature, PowerShell does not run scripts when you double-click
the script icon in File Explorer or when you type the script name without a
full path, even when the script is in the current directory. For more
information about running commands and scripts in PowerShell, see
[about_Command_Precedence](about_Command_Precedence.md).

### Run with PowerShell

Beginning in PowerShell 3.0, you can run scripts from File Explorer.

To use the "Run with PowerShell" feature:

Run File Explorer, right-click the script filename and then select "Run with
PowerShell".

The "Run with PowerShell" feature is designed to run scripts that do not have
required parameters and do not return output to the command prompt.

For more information, see [about_Run_With_PowerShell](about_Run_With_PowerShell.md).

### Running scripts on other computers

To run a script on one or more remote computers, use the **FilePath** parameter of
the `Invoke-Command` cmdlet.

Enter the path and filename of the script as the value of the **FilePath**
parameter. The script must reside on the local computer or in a directory that
the local computer can access.

The following command runs the `Get-ServiceLog.ps1` script on the remote
computers named Server01 and Server02.

```powershell
Invoke-Command -ComputerName Server01,Server02 -FilePath `
  C:\Scripts\Get-ServiceLog.ps1
```

## Get help for scripts

The Get-Help cmdlet gets the help topics for scripts as well as for cmdlets
and other types of commands. To get the help topic for a script, type
`Get-Help` followed by the path and filename of the script. If the script
path is in your `Path` environment variable, you can omit the path.

For example, to get help for the ServicesLog.ps1 script, type:

```powershell
get-help C:\admin\scripts\ServicesLog.ps1
```

## How to write a script

A script can contain any valid PowerShell commands, including single commands,
commands that use the pipeline, functions, and control structures such as If
statements and For loops.

To write a script, open a new file in a text editor, type the commands, and
save them in a file with a valid filename with the `.ps1` file extension.

The following example is a simple script that gets the services that are
running on the current system and saves them to a log file. The log filename is
created from the current date.

```powershell
$date = (get-date).dayofyear
get-service | out-file "$date.log"
```

To create this script, open a text editor or a script editor, type these
commands, and then save them in a file named `ServiceLog.ps1`.

### Parameters in scripts

To define parameters in a script, use a Param statement. The `Param` statement
must be the first statement in a script, except for comments and any
`#Require` statements.

Script parameters work like function parameters. The parameter values are
available to all of the commands in the script. All of the features of
function parameters, including the Parameter attribute and its named
arguments, are also valid in scripts.

When running the script, script users type the parameters after the script
name.

The following example shows a `Test-Remote.ps1` script that has a
**ComputerName** parameter. Both of the script functions can access the
**ComputerName** parameter value.

```powershell
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

```powershell
C:\PS> .\test-remote.ps1 -computername Server01

Ping succeeded: Server01
Remote test failed: Server01
```

For more information about the Param statement and the function parameters, see
[about_Functions](about_Functions.md) and
[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md).

### Writing help for scripts

You can write a help topic for a script by using either of the two following
methods:

- Comment-Based Help for Scripts

  Create a Help topic by using special keywords in the comments. To create
  comment-based Help for a script, the comments must be placed at the beginning
  or end of the script file. For more information about comment-based Help, see
  [about_Comment_Based_Help](about_Comment_Based_Help.md).

- XML-Based Help  for Scripts

  Create an XML-based Help topic, such as the type that is typically created
  for cmdlets. XML-based Help is required if you are translating Help topics
  into multiple languages.

To associate the script with the XML-based Help topic, use the .ExternalHelp
Help comment keyword. For more information about the ExternalHelp keyword, see
[about_Comment_Based_Help](about_Comment_Based_Help.md). For more information
about XML-based help, see
[How to Write Cmdlet Help](/powershell/scripting/developer/help/writing-help-for-windows-powershell-cmdlets).

### Returning an exit value

By default, scripts do not return an exit status when the script ends. You must
use the `exit` statement to return an exit code from a script. By default, the
`exit` statement returns `0`. You can provide a numeric value to return a
different exit status. A nonzero exit code typically signals a failure.

On Windows, any number between `[int]::MinValue` and `[int]::MaxValue` is
allowed.

On Unix, only positive numbers between `[byte]::MinValue` (0) and
`[byte]::MaxValue` (255) are allowed. A negative number in the range of `-1`
through `-255` is automatically translated into a positive number by adding
256. For example, `-2` is transformed to `254`.

In PowerShell, the `exit` statement sets the value of the `$LASTEXITCODE`
variable. In the Windows Command Shell (cmd.exe), the exit statement sets the
value of the `%ERRORLEVEL%` environment variable.

Any argument that is non-numeric or outside the platform-specific range is
translated to the value of `0`.

## Script scope and dot sourcing

Each script runs in its own scope. The functions, variables, aliases, and
drives that are created in the script exist only in the script scope. You
cannot access these items or their values in the scope in which the script
runs.

To run a script in a different scope, you can specify a scope, such as Global
or Local, or you can dot source the script.

The dot sourcing feature lets you run a script in the current scope instead of
in the script scope. When you run a script that is dot sourced, the commands in
the script run as though you had typed them at the command prompt. The
functions, variables, aliases, and drives that the script creates are created
in the scope in which you are working. After the script runs, you can use the
created items and access their values in your session.

To dot source a script, type a dot (.) and a space before the script path.

For example:

```powershell
. C:\scripts\UtilityFunctions.ps1
```

or

```powershell
. .\UtilityFunctions.ps1
```

After the `UtilityFunctions.ps1` script runs, the functions and variables that
the script creates are added to the current scope.

For example, the `UtilityFunctions.ps1` script creates the `New-Profile`
function and the `$ProfileName` variable.

```powershell
#In UtilityFunctions.ps1

function New-Profile
{
  Write-Host "Running New-Profile function"
  $profileName = split-path $profile -leaf

  if (test-path $profile)
    {write-error "Profile $profileName already exists on this computer."}
  else
    {new-item -type file -path $profile -force }
}
```

If you run the `UtilityFunctions.ps1` script in its own script scope, the
`New-Profile` function and the `$ProfileName` variable exist only while the
script is running. When the script exits, the function and variable are
removed, as shown in the following example.

```powershell
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

When you dot source the script and run it, the script creates the `New-Profile`
function and the `$ProfileName` variable in your session in your scope. After
the script runs, you can use the `New-Profile` function in your session, as
shown in the following example.

```powershell
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

## Scripts in modules

A module is a set of related PowerShell resources that can be distributed as a
unit. You can use modules to organize your scripts, functions, and other
resources. You can also use modules to distribute your code to others, and to
get code from trusted sources.

You can include scripts in your modules, or you can create a script module,
which is a module that consists entirely or primarily of a script and
supporting resources. A script module is just a script with a .psm1 file
extension.

For more information about modules, see [about_Modules](about_Modules.md).

## Other script features

PowerShell has many useful features that you can use in scripts.

- `#Requires` - You can use a `#Requires` statement to prevent a script from
  running without specified modules or snap-ins and a specified version of
  PowerShell. For more information, see about_Requires.

- `$PSCommandPath` - Contains the full path and name of the script that is
  being run. This parameter is valid in all scripts. This automatic variable is
  introduced in PowerShell 3.0.

- `$PSScriptRoot` - Contains the directory from which a script is being run. In
  PowerShell 2.0, this variable is valid only in script modules (`.psm1`).
  Beginning in PowerShell 3.0, it is valid in all scripts.

- `$MyInvocation` - The `$MyInvocation` automatic variable contains information
  about the current script, including information about how it was started or
  "invoked." You can use this variable and its properties to get information
  about the script while it is running. For example, the
  `$MyInvocation`.MyCommand.Path variable contains the path and filename of the
  script. `$MyInvocation`.Line contains the command that started the script,
  including all parameters and values.

  Beginning in PowerShell 3.0, `$MyInvocation` has two new properties that
  provide information about the script that called or invoked the current
  script. The values of these properties are populated only when the invoker or
  caller is a script.

  - **PSCommandPath** contains the full path and name of the script that called or
    invoked the current script.

  - **PSScriptRoot** contains the directory of the script that called or invoked
    the current script.

  Unlike the `$PSCommandPath` and `$PSScriptRoot` automatic variables, which
  contain information about the current script, the **PSCommandPath** and
  **PSScriptRoot** properties of the `$MyInvocation` variable contain
  information about the script that called the current script.

- Data sections - You can use the `Data` keyword to separate data from logic in
  scripts. Data sections can also make localization easier. For more
  information, see [about_Data_Sections](about_Data_Sections.md) and
  [about_Script_Internationalization](about_Script_Internationalization.md).

- Script Signing - You can add a digital signature to a script. Depending on
  the execution policy, you can use digital signatures to restrict the running
  of scripts that could include unsafe commands. For more information, see
  [about_Execution_Policies](about_Execution_Policies.md) and
  [about_Signing](about_Signing.md).

## See also

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

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
