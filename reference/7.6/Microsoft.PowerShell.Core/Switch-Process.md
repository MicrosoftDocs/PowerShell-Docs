---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/switch-process?view=powershell-7.6&WT.mc_id=ps-gethelp
ms.date: 01/20/2023
schema: 2.0.0
---

# Switch-Process

## SYNOPSIS
On Linux and macOS, the cmdlet calls the `execv()` function to provide similar behavior as POSIX
shells.

## SYNTAX

```
Switch-Process [[-WithCommand] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Some native Unix commands shell out to run something (like ssh) and use the `bash` built-in command
`exec` to spawn a new process that replaces the current one. By default, `exec` isn't a valid
command in PowerShell. This is affecting some known scripts like `copy-ssh-id` and some subcommands
of AzCLI.

The `Switch-Process` cmdlet calls the native `execv()` function to provide similar behavior as POSIX
shells. This cmdlet and its alias, `exec`, were added in PowerShell 7.3.0.

PowerShell 7.3.1 changed the `exec` alias to a function that wraps `Switch-Process`. The function
allows you to pass parameters to the native command that might have erroneously bound to the
**WithCommand** parameter.

This cmdlet is only available for non-Windows systems.

## EXAMPLES

### Example 1 - Execute a command that depends on `exec`

This example assumes that PowerShell is the default shell on a non-Windows system. `ssh-copy-id` is
a popular bash script to deploy public keys on target machines for key-based authentication. The
script depends on the bash command, `exec`.

```powershell
ssh-copy-id user@host
```

With the `PSExec` feature enabled, the `ssh-copy-id` script succeeds.

## PARAMETERS

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

## INPUTS

### System.String[]

## OUTPUTS

### System.Object

## NOTES

The `Switch-Process` cmdlet was created to provide `exec` compatibility is other POSIX shells. Under
normal conditions, the cmdlet isn't intended to be used in PowerShell scripts. `Switch-Process`
doesn't have feature parity with the built-in `exec` function in POSIX shells, such as like how file
descriptors are handled, but should cover most cases.

## RELATED LINKS
