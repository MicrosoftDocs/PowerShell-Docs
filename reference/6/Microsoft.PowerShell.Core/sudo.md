---
ms.date:  2017-07-10
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
external help file:  System.Management.Automation.dll-Help.xml
---

# sudo

## SYNOPSIS
Provides support for running a PowerShell expression or script through sudo on UNIX systems.

## SYNTAX

```
sudo [sudo parameters] commandexpression
```

## DESCRIPTION
Provides a function wrapper around the native sudo command to simplify running PowerShell expressions through sudo.

## EXAMPLES

### Example 1
```
PS /home/user> get-item /etc/* {where-object {($_.Attributes -band 'ReadOnly') -eq 'ReadOnly'}
PS /home/user> sudo {get-item /etc/* {where-object {($_.Attributes -band 'ReadOnly') -eq 'ReadOnly'}
```
Compare the output of running get-item directly versus running it via sudo.
In the first example, most file entries are reported with the readonly attribute since the expression is run using the current PowerShell instance.

In the secound example, only a few files are reported with the ReadOnly attribute since the expression is run from instance of PowerShell launched via sudo.

### Example 2
```
PS /home/user> sudo reboot now
```
This example illustrates running a native command directly through sudo.

### Example 3
```
PS /home/user> sudo --version
```
Invokes sudo to display its version information.

### Example 4
```
PS /home/user> sudo --help
```
Invokes sudo to display its command-line usage.
To invoke sudo with its command-line options; ensure the options are defined before the command to execute. Otherwise, the options will be passed to the command instead of sudo.

## PARAMETERS

## INPUTS

### None

## OUTPUTS

### System.String

Commands invoked through sudo always output text; even when the commands are valid PowerShell expressions or scripts. For example, the following produces an array of strings as the output.
```
PS /home/user> $result = {Get-Item -Path /etc/*}
PS /home/user> $result.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Object[]                                 System.Array

PS /home/user> $result[0].GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     String                                   System.Object

```

## NOTES

### Using tab completion.
To ensure expected tab completion, type the command expression with curly braces {some expression}
For example, the following will expand -P to -Path

sudo {Get-Item -P[tab]

### Parameter spatting
Due to the design of the sudo function; parameter splatting is not supported when a scriptblock is passed as the command expression. For example, the following will produce an error indicating the Path parameter is null.
```
$h = @{ Path = "file.txt"; Force = $true }
sudo { remove-item @h }
```

When splatting is used without a scriptblock, all arguments being expanded.
```
$h = @{ Path = "file.txt"; Force = $true }
sudo remove-item @h
```
The above will invoke powershell with the following parameters
```
remove-item -Force: $true -Path: file.txt
```

### Referencing built-in variables in expressions
When using PowerShell expressions, be aware that variable expansion occurs in the calling PowerShell session. As a result, some expressions may not work as expected.  For example,when referencing $true or $false, the variables will be converted to the string values before calling sudo, resulting in the values 'true' and 'false'.  Other variables, such as environment variables, may exhibit a different behavior; the variable may a different value in the launched  PowerShell session than it does in the launching PowerShell session.

For these situations, where the variable value must be interpreted in the launched session, enclose the variable in double quotes and excape the $ character.
For example, use "`$env:PATH" to reference the PATH environment variable in the launched session.

## RELATED LINKS

