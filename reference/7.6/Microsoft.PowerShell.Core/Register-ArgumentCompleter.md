---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 07/10/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/register-argumentcompleter?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Register-ArgumentCompleter
---

# Register-ArgumentCompleter

## SYNOPSIS

Registers a custom argument completer.

## SYNTAX

### NativeSet

```
Register-ArgumentCompleter -CommandName <String[]> -ScriptBlock <ScriptBlock> [-Native]
 [<CommonParameters>]
```

### PowerShellSet

```
Register-ArgumentCompleter [-CommandName <String[]>] -ParameterName <String>
 -ScriptBlock <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION

The `Register-ArgumentCompleter` cmdlet registers a custom argument completer. An argument
completer allows you to provide dynamic tab completion, at run time for any command that you
specify.

When you call this command with the **CommandName** parameter and without the **ParameterName** or
**Native** parameters, the command runs as if you specified the **Native** parameter. This prevents
the argument completer from working for PowerShell command parameters. Always specify the
**ParameterName** parameter when you want to register an argument completer for PowerShell
commands.

## EXAMPLES

### Example 1: Register a custom argument completer

The following example registers an argument completer for the **Id** parameter of the `Set-TimeZone`
cmdlet.

```powershell
$s = {
    param(
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )

    (Get-TimeZone -ListAvailable).Id | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
        "'$_'"
    }
}

Register-ArgumentCompleter -CommandName Set-TimeZone -ParameterName Id -ScriptBlock $s
```

The first command creates a script block that takes the required parameters, which are passed in
when the user presses <kbd>Tab</kbd>. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the available values for **Id** are retrieved using the `Get-TimeZone`
cmdlet. The **Id** property for each Time Zone is piped to the `Where-Object` cmdlet. The
`Where-Object` cmdlet filters out any ids that don't start with the value provided by
`$wordToComplete`, which represents the text the user typed before they pressed <kbd>Tab</kbd>. The
filtered ids are piped to the `ForEach-Object` cmdlet, which encloses each value in quotes to handle
values that contain spaces.

The second command registers the argument completer by passing the scriptblock, the
**ParameterName** **Id** and the **CommandName** `Set-TimeZone`.

### Example 2: Add details to your tab completion values

The following example overwrites tab completion for the **Name** parameter of the `Stop-Service`
cmdlet and only returns running services.

```powershell
$s = {
    param(
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )

    $services = Get-Service | Where-Object {
        $_.Status -eq 'Running' -and $_.Name -like "$wordToComplete*"
    }

    $services | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList @(
            $_.Name          # completionText
            $_.Name          # listItemText
            'ParameterValue' # resultType
            $_.Name          # toolTip
        )
    }
}

Register-ArgumentCompleter -CommandName Stop-Service -ParameterName Name -ScriptBlock $s
```

The first command creates a script block that takes the required parameters, which are passed in
when the user presses <kbd>Tab</kbd>. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the first command retrieves all running services using the `Where-Object`
cmdlet. The services are piped to the `ForEach-Object` cmdlet. The `ForEach-Object` cmdlet creates
a new
[System.Management.Automation.CompletionResult](/dotnet/api/system.management.automation.completionresult)
object and populates it with the name of the current service (represented by the pipeline variable
`$_.Name`).

The **CompletionResult** object allows you to provide additional details to each returned value:

- **completionText** (String) - The text to be used as the auto completion result. This is the value
  sent to the command.
- **listItemText** (String) - The text to be displayed in a list, such as when the user presses
  <kbd>Ctrl</kbd>+<kbd>Space</kbd>. PowerShell uses this for display only. It isn't passed to the
  command when selected.
- **resultType**
  ([CompletionResultType](/dotnet/api/system.management.automation.completionresulttype)) - The
  type of completion result.
- **toolTip** (String) - The text for the tooltip with details to display about the object. This is
  visible when the user selects an item after pressing <kbd>Ctrl</kbd>+<kbd>Space</kbd>.

### Example 3: Register a custom Native argument completer

You can use the **Native** parameter to provide tab-completion for a native command. The following
example adds tab-completion for the `dotnet` Command Line Interface (CLI).

> [!NOTE]
> The `dotnet complete` command is only available in version 2.0 and greater of the dotnet cli.

```powershell
$scriptblock = {
    param(
        $wordToComplete,
        $commandAst,
        $cursorPosition
    )

    dotnet complete --position $cursorPosition $commandAst.ToString() | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new(
            $_,               # completionText
            $_,               # listItemText
            'ParameterValue', # resultType
            $_                # toolTip
        )
    }
}

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock
```

The first command creates a script block that takes the required parameters, which are passed in
when the user presses <kbd>Tab</kbd>. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the `dotnet complete` command performs the tab completion. The results are
piped to the `ForEach-Object` cmdlet, which uses the **new** static method of the
[System.Management.Automation.CompletionResult](/dotnet/api/system.management.automation.completionresult)
class to create a **CompletionResult** object for each value.

## PARAMETERS

### -CommandName

Specifies the name of one or more commands to register the argument completer for. This parameter
is mandatory for native commands.

When you specify this parameter without the **ParameterName** or **Native** parameters, the command
behaves as if you had specified the **Native** parameter. When registering argument completers for
PowerShell commands, always specify the **ParameterName** parameter.

If you don't specify this parameter, PowerShell registers the argument completer for the specified
**ParameterName** across all PowerShell commands.

```yaml
Type: System.String[]
Parameter Sets: NativeSet, PowerShellSet
Aliases:

Required: True (NativeSet), False (PowerShellSet)
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Native

Indicates that the argument completer is for a native command where PowerShell can't complete
parameter names.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NativeSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterName

Specifies the name of the parameter the argument completer applies to. The type for specified
parameters can't be an enumeration, such as the **ForegroundColor** parameter of the `Write-Host`
cmdlet.

For more information on enums, see [about_Enum](./About/about_Enum.md).

When registering an argument completer for PowerShell commands, always specify this parameter. When
you specify the **CommandName** parameter without the **ParameterName** or **Native** parameters,
the command behaves as if you specified the **Native** parameter.

```yaml
Type: System.String
Parameter Sets: PowerShellSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

Specifies the commands to run to perform tab completion. The script block you provide should return
the values that complete the input. The script block must unroll the values using the pipeline
(`ForEach-Object`, `Where-Object`, etc.), or another suitable method. Returning an array of values
causes PowerShell to treat the entire array as **one** tab completion value.

The script block can also return
[System.Management.Automation.CompletionResult](/dotnet/api/system.management.automation.completionresult)
objects for each value to enhance the user experience. Returning **CompletionResult** objects
enables you to define tooltips and custom list entries displayed when users press
<kbd>Ctrl</kbd>+<kbd>Space</kbd> to show the list of available completions.

The script block must accept the following parameters in the order specified below. The names of the
parameters aren't important because PowerShell passes in the values by position.

- `$commandName` (Position 0, **String**) - This parameter is set to the name of the
  command for which the script block is providing tab completion.
- `$parameterName` (Position 1, **String**) - This parameter is set to the parameter
  whose value requires tab completion.
- `$wordToComplete` (Position 2, **String**) - This parameter is set to value the user has provided
  before they pressed <kbd>Tab</kbd>. Your script block should use this value to determine tab
  completion values.
- `$commandAst` (Position 3, **CommandAst**) - This parameter is set to the Abstract Syntax
  Tree (AST) for the current input line. For more information, see
  [CommandAst Class](/dotnet/api/system.management.automation.language.commandast).
- `$fakeBoundParameters` (Position 4 **IDictionary**) - This parameter is set to a hashtable
  containing the `$PSBoundParameters` for the cmdlet, before the user pressed <kbd>Tab</kbd>. For
  more information, see [about_Automatic_Variables](./About/about_Automatic_Variables.md).

When you specify the **Native** parameter, the script block must take the following parameters in
the specified order. The names of the parameters aren't important because PowerShell passes in the
values by position.

- `$wordToComplete` (Position 0, **String**) - This parameter is set to value the user has provided
  before they pressed <kbd>Tab</kbd>. Your script block should use this value to determine tab
  completion values.
- `$commandAst` (Position 1, **CommandAst**) - This parameter is set to the Abstract Syntax Tree
  (AST) for the current input line. For more information, see
  [CommandAst Class](/dotnet/api/system.management.automation.language.commandast).
- `$cursorPosition` (Position 2, **Int32**) - This parameter is set to the position of the cursor
  when the user pressed <kbd>Tab</kbd>.

You can also provide an **ArgumentCompleter** as a parameter attribute. For more information, see
[about_Functions_Advanced_Parameters](./About/about_Functions_Advanced_Parameters.md).

```yaml
Type: System.Management.Automation.ScriptBlock
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS

[about_Functions_Argument_Completion](./About/about_Functions_Argument_Completion.md)
