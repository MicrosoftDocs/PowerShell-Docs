---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
online version: https://go.microsoft.com/fwlink/?linkid=2181448
ms.date: 01/19/2022
schema: 2.0.0
---

# Switch-Process

## Synopsis
On Linux and macOS, the cmdlet calls the `execv()` function to provide similar behavior as POSIX
shells.

## Syntax

```
Switch-Process [[-WithCommand] <String[]>] [<CommonParameters>]
```

## Description

Some native Unix commands shell out to run something (like ssh) and use the `bash` built-in command
`exec` to spawn a new process that replaces the current one. By default, `exec` is not a valid
command in PowerShell. This is affecting some known scripts like `copy-ssh-id` and some subcommands
of AzCLI.

The `PSExec` experimental feature adds a new `Switch-Process` cmdlet aliased to `exec`. The cmdlet
calls `execv()` function to provide similar behavior as POSIX shells.

The `PSExec` experimental feature must be enabled for this cmdlet to be available. This cmdlet is
only available for non-Windows systems.

## Examples

### Example 1 - Execute a command that depends on `exec`

This example assumes that PowerShell is the default shell on a non-Windows system. `ssh-copy-id` is
a popular bash script to deploy public keys on target machines for key-based authentication. The
script depends on the bash command, `exec`.

```powershell
ssh-copy-id user@host
```

With the `PSExec` feature enabled, the `ssh-copy-id` script succeeds.

## Parameters

### -WithCommand

Specifies the native executable (and any parameters) to be run. All additional values passed as
arguments are passed as an array of strings to be executed with the first command.

The target command must be a native executable, not a PowerShell command.

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

This feature is not intended to have parity with the built-in `exec` function in POSIX shells (like
how file descriptors are handled), but should cover most cases.

The `Switch-Process` cmdlet was created to provide `exec` compatibility is other POSIX shells. Under
normal conditions, the cmdlet was not intended to be used in PowerShell scripts.

## RELATED LINKS

[Using experimental features](/powershell/learn/experimental-features)

[about_Experimental_Features](/powershell/module/Microsoft.PowerShell.Core/About/about_Experimental_Features)
