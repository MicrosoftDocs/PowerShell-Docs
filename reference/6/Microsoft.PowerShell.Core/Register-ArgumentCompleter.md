---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 5/15/2019
online version: http://go.microsoft.com/fwlink/?LinkId=821507
schema: 2.0.0
title: Register-ArgumentCompleter
---
# Register-ArgumentCompleter

## SYNOPSIS
Registers a custom argument completer.

## SYNTAX

### NativeSet

```
Register-ArgumentCompleter -CommandName <String[]> -ScriptBlock <ScriptBlock> [-Native] [<CommonParameters>]
```

### PowerShellSet

```
Register-ArgumentCompleter [-CommandName <String[]>] -ParameterName <String> -ScriptBlock <ScriptBlock>
 [<CommonParameters>]
```

## DESCRIPTION

The **Register-ArgumentCompleter** cmdlet registers a custom argument completer.

## EXAMPLES

### Example 1: Register a custom argument completer

```
PS C:\> Register-ArgumentCompleter -Native -CommandName powershell -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

        echo -- -PSConsoleFile -Version -NoLogo -NoExit -Sta -NoProfile -NonInteractive `
            -InputFormat -OutputFormat -WindowStyle -EncodedCommand -File -ExecutionPolicy `
            -Command |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
}
PS C:\> Register-ArgumentCompleter -CommandName Get-Command -ParameterName Verb -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Verb "$wordToComplete*" |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_.Verb, $_.Verb, 'ParameterValue', ("Group: " + $_.Group))
        }
}
```

This example registers a custom argument completer.

## PARAMETERS

### -CommandName

Specifies the name of the command as an array.

```yaml
Accept pipeline input: False
Position: Named
Accept wildcard characters: False
Parameter Sets: NativeSet, PowerShellSet
Required: True (NativeSet), False (PowerShellSet)
Default value: None
Aliases: 
Type: String[]
```

### -Native

Indicates that the argument completer is for a native command where PowerShell cannot complete
parameter names.

```yaml
Type: SwitchParameter
Parameter Sets: NativeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterName

Specifies the name of the parameter whose argument is being completed.

```yaml
Type: String
Parameter Sets: PowerShellSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

Specifies the commands to run.
Enclose the commands in braces ( { } ) to create a script block.
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see about_CommonParameters
(http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS