---
ms.date: 5/20/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821507
external help file:  System.Management.Automation.dll-Help.xml
title:  Register-ArgumentCompleter
---
# Register-ArgumentCompleter

## SYNOPSIS
Registers a custom argument completer.

## SYNTAX

### PowerShellSet

```
Register-ArgumentCompleter [-CommandName <String[]>] -ParameterName <String> -ScriptBlock <ScriptBlock>
 [<CommonParameters>]
```

### NativeSet

```
Register-ArgumentCompleter -CommandName <String[]> -ScriptBlock <ScriptBlock> [-Native] [<CommonParameters>]
```

## DESCRIPTION

The `Register-ArgumentCompleter` cmdlet registers a custom argument completer. An argument
completer allows you to provide dynamic tab completion, at run time for any command that you
specify.

## EXAMPLES

### Example 1: Register a custom argument completer

The following example registers an argument completer for the **Id** parameter of the `Set-TimeZone`
cmdlet.

```powershell
$scriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-TimeZone -ListAvailable).Id | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
          "'$_'"
    }
}
Register-ArgumentCompleter -CommandName Set-TimeZone -ParameterName Id -ScriptBlock $scriptBlock
```

The first command creates a script block which takes the required parameters which are passed
in when the user presses `<TAB>`. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the available values for **Id** are retrieved using the
`Get-TimeZone` cmdlet. The **Id** property for each Time Zone is piped to the `Where-Object` cmdlet.
The `Where-Object` cmdlet filters out any ids that do not start with the value provided by
`$wordToComplete`, which represents the text the user typed before they pressed `<TAB>`. The
filtered ids are piped to the `For-EachObject` cmdlet which encloses each value in quotes, should
the value contain spaces.

The second command registers the argument completer by passing the scriptblock, the
**ParameterName** "Id" and the **CommandName** `Set-TimeZone`.

### Example 2: Add details to your tab completion values

The following example overwrites tab completion for the **Name** parameter of the `Stop-Service`
cmdlet and only returns running services.

```powershell
$s = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $services = Get-Service | Where-Object {$_.Status -eq "Running" }
    $services | Where-Object { $_.Name -like "$wordToComplete*" } | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_,
            $_,
            "ParameterValue",
            $_
    }
}
Register-ArgumentCompleter -CommandName dotnet -Native -ScriptBlock $s
```

The first command creates a script block which takes the required parameters which are passed
in when the user presses `<TAB>`. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the first command retrieves all running services using the `Where-Object`
cmdlet. The services are piped to the `ForEach-Object` cmdlet. The `ForEach-Object` cmdlet creates
a new
[`[System.Management.Automation.CompletionResult]`](/dotnet/api/system.management.automation.completionresult) object
and populates it with the values of the current service (represented by the pipeline variable `$_`).

The **CompletionResult** object allows you to provide additional details to each returned value:

- **completionText** (String) - The text to be used as the auto completion result. This is the value
  sent to the command.
- **listItemText** (String) - The text to be displayed in a list, such as when the user presses
  `<Ctrl>+<Space>`. This is used for display only and is not passed to the command when selected.
- **resultType** ([CompletionResultType](/dotnet/api/system.management.automation.completionresulttype)) - The type of completion result.
- **toolTip** (String) - The text for the tooltip with details to be displayed about the object.
  This is visible when the user selects an item after pressing `<Ctrl>+<Space>`.

The last command demonstrates that stopped services can still be passed in manually to the
`Stop-Service` cmdlet. The tab completion is the only aspect affected.

### Example 3: Register a custom Native argument completer

You can use the **Native** parameter to provide tab-completion for a native command. The following
example adds tab-completion for the `dotnet` Command Line Interface (CLI).

> [!NOTE]
> The `dotnet complete` command is only available in version 2.0 and greater of the dotnet cli.

```powershell
$scriptblock = {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock
```

The first command creates a script block which takes the required parameters which are passed
in when the user presses `<TAB>`. For more information, see the **ScriptBlock** parameter
description.

Within the script block, the `dotnet complete` command is used to perform the tab completion.
The results are piped to the `ForEach-Object` cmdlet which use the **new** static method of the
[`[System.Management.Automation.CompletionResult]`](/dotnet/api/system.management.automation.completionresult) class
to create a new **CompletionResult** object for each value.

## PARAMETERS

### -CommandName

Specifies the name of the commands as an array.

```yaml
Accept pipeline input: False
Position: Named
Accept wildcard characters: False
Parameter Sets: PowerShellSet, NativeSet
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

Specifies the name of the parameter whose argument is being completed. The parameter name specified
cannot be an enumerated value, such as the **ForegroundColor** parameter of the `Write-Host` cmdlet.

For more information on enums, see [about_Enum](./About/about_Enum.md).

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

Specifies the commands to run to perform tab completion. The script block you provide should return
the values complete the input. The script block must unroll the values using the pipeline
(`ForEach-Object`, `Where-Object`, etc.), or another suitable method. Returning an array of values
causes PowerShell to treat the entire array as **one** tab completion value.

The script block should also accept the following parameters in the order specified below. The names
of the parameters are not important because PowerShell passes in the values *positionally*.

- `$commandName` (Position 0) - This parameter is set to the name of the
  command for which the script block is providing tab completion.
- `$parameterName` (Position 1) - This parameter is set to the parameter
  whose value requires tab completion.
- `$wordToComplete` (Position 2) - This parameter is set to value the user has
  provided before they pressed `<TAB>`. Your script block should use this value
  to determine tab completion values.
- `$commandAst` (Position 3) - This parameter is set to the Abstract Syntax
  Tree (AST) for the current input line. For more information, see
  [Ast Class](/dotnet/api/system.management.automation.language.ast).
- `$fakeBoundParameter` (Position 4) - This parameter is set to a hashtable
  containing the `$PSBoundParameters` for the cmdlet, before the user pressed
  `<TAB>`. For more information, see [about_Automatic_Variables](./About/about_Automatic_Variables.md).

When you specify the **Native** parameter, the script block should take the following parameters in
the specified order. The names of the parameters are not important because PowerShell
passes in the values *positionally*.

- `$commandName` (Position 0) - This parameter is set to the name of the
  command for which the script block is providing tab completion.
- `$wordToComplete` (Position 1) - This parameter is set to value the user has
  provided before they pressed `<TAB>`. Your script block should use this value
  to determine tab completion values.
- `$cursorPosition` (Position 2) - This parameter is set to the position of the cursor when the
  user pressed `<TAB>`.

You can also provide an **ArgumentCompleter** as a parameter attribute. For more information, see
[about_Functions_Advanced_Parameters](./About/about_Functions_Advanced_Parameters.md).

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS

[Core Cmdlets](Microsoft.PowerShell.Core.md)