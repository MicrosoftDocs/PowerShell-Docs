---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
online version: https://go.microsoft.com/fwlink/?linkid=2181448
ms.date: 01/19/2022
schema: 2.0.0
---

# Switch-Process

## Synopsis
The cmdlet calls the `execv()` function to provide similar behavior as POSIX shells.

## SYNTAX

```
Switch-Process [[-WithCommand] <String[]>] [<CommonParameters>]
```

## Description

Some native unix commands shell out to run something (like ssh) and use the bash built-in `exec` to
spawn a new process that replaces the current one. This fails when PowerShell is the default shell
as `exec` is not a valid command. This is affecting some known scripts like `copy-ssh-id` or some
subcommands of AzCLI.

The `PSExec` experimental feature adds a new `Switch-Process` cmdlet aliased to `exec`. The cmdlet
calls `execv()` function to provide similar behavior as POSIX shells. This is not intended to have
parity with the `exec` built-in function in POSIX shells (like how file descriptors are handled),
but should cover most cases.

The `PSExec` experimental feature must be enabled for this cmdlet to be available. This cmdlet is
only available for non-Windows systems.

## Examples

### Example 1 - Execute a native command

```powershell
$id, $uname = pwsh -noprofile -noexit -outputformat text -command { $pid; exec uname -a }
Get-Process -Id $id -ErrorAction Ignore
$uname
uname -a
```

This example runs the Unix native command `uname -a`. Since `pwsh` process gets replaced by the
newly created process, `Get-Process` returns nothing. However, `$uname` contains the information
about the new process.

## Parameters

### -WithCommand

Specifies the native executable (and any parameters) to be run. All arguments of this parameter are
passed as an array of strings to be executed. The target command must be a native executable, not a
PowerShell command.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String[]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Using experimental features](/powershell/learn/experimental-features)

[about_Experimental_Features](/powershell/module/Microsoft.PowerShell.Core/About/about_Experimental_Features)
