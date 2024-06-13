---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
ms.date: 06/13/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/tabexpansion2?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
---

# TabExpansion2

## SYNOPSIS
A helper function that wraps the `CompleteInput()` method of the **CommandCompletion** class to
provide tab completion for PowerShell scripts.

## SYNTAX

### ScriptInputSet (Default)

```
TabExpansion2 [-inputScript] <String> [[-cursorColumn] <Int32>] [[-options] <Hashtable>]
 [<CommonParameters>]
```

### AstInputSet

```
TabExpansion2 [-ast] <Ast> [-tokens] <Token[]> [-positionOfCursor] <IScriptPosition>
 [[-options] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION

`TabExpansion2` is a built-in function that provides tab completion for user input. PowerShell calls
this function when the user presses the <kbd>Tab</kbd> or <kbd>Ctrl</kbd>+<kbd>Space</kbd> key while
typing a command. The function returns a list of possible completions for the current input.

`TabExpansion2` isn't normally called directly by users. However, it can be useful for testing tab
completion. To use `TabExpansion2`, you need to provide the current input script and the cursor
position in the script. The function returns a **CommandCompletion** object that contains a list of
possible completions for the current input. This input script can be a string or an abstract syntax
tree (AST) that represents the script.

You can override the default behavior of `TabExpansion2` by defining a custom function with the same
name in your PowerShell session. This custom function can provide completions for custom commands or
parameters. While it is possible to override `TabExpansion2`, it's not supported. You should create
a custom function only if you have a specific need to customize the tab completion behavior.

## EXAMPLES

### Example 1 - Get tab completion for command parameter

This example shows the same results you would get by entering `Format-Hex -<Tab>` at the PowerShell
command prompt. The `TabExpansion2` function returns a **CommandCompletion** object that contains a
list of possible completions for the `-` token.

```powershell
TabExpansion2 -inputScript ($s = 'Format-Hex -') -cursorColumn $s.Length |
    Select-Object -ExpandProperty CompletionMatches
```

```Output
CompletionText ListItemText    ResultType ToolTip
-------------- ------------    ---------- -------
-Path          Path         ParameterName [string[]] Path
-LiteralPath   LiteralPath  ParameterName [string[]] LiteralPath
-InputObject   InputObject  ParameterName [psobject] InputObject
-Encoding      Encoding     ParameterName [Encoding] Encoding
-Count         Count        ParameterName [long] Count
-Offset        Offset       ParameterName [long] Offset
```

### Example 2 - Get tab completion for parameter values

This example shows how to get tab completion for parameter values. In this example, we expect that
**Stage** parameter has three possible values and that one of the values is `Three`. You can use
this technique to test that tab completion for your function returns the expected results.

```powershell
function GetData {
    param (
        [ValidateSet('One', 'Two', 'Three')]
        [string]$Stage
    )
    Write-Verbose "Retrieving data for stage $Stage"
}

$result = TabExpansion2 -inputScript ($line = 'GetData -Stage ') -cursorColumn $line.Length |
    Select-Object -ExpandProperty CompletionMatches
$result.Count -eq 3
$result.CompletionText -contains 'Three'
```

```Output
True
True
```

## PARAMETERS

### -ast

An abstract syntax tree (AST) object that represents the script that you want to expand using tab
completion.

```yaml
Type: System.Management.Automation.Language.Ast
Parameter Sets: AstInputSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cursorColumn

The column number of the cursor in the input script string. The cursor position is used to determine
the token that gets expanded by tab completion.

```yaml
Type: System.Int32
Parameter Sets: ScriptInputSet
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inputScript

A string that represents the script that you want to expand using tab completion.

```yaml
Type: System.String
Parameter Sets: ScriptInputSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -options

A hashtable of option values to pass to the `CompleteInput()` API. The API accepts the following
boolean options:

- `IgnoreHiddenShares` - When set to `$true`, ignore hidden UNC shares such as `\\COMPUTER\ADMIN$`
  and `\\COMPUTER\C$`. By default, PowerShell includes hidden shares.
- `RelativePaths` - By default, PowerShell decides how to expand paths based on the input you
  provided. Setting this value to `$true` forces PowerShell to replace paths with relative paths.
  Setting this value to `$false`, forces PowerShell to replace them with absolute paths.
- `LiteralPaths` - By default, PowerShell replace special file characters, such as square brackets
  and back-ticks, with their escaped equivalents. Setting this value to `$true` prevents the
  replacement.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -positionOfCursor

The column number of the cursor in the input AST. The cursor position is used to determine
the token that gets expanded by tab completion.

```yaml
Type: System.Management.Automation.Language.IScriptPosition
Parameter Sets: AstInputSet
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -tokens

An array of tokens parsed from the input script. The tokens are used to determine the token that
gets expanded by tab completion.

```yaml
Type: System.Management.Automation.Language.Token[]
Parameter Sets: AstInputSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable,
-ProgressAction -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.CommandCompletion

## NOTES

## RELATED LINKS

[about_Built-in_Functions](./about/about_Built-in_Functions.md)

[about_Tab_Expansion](./about/about_Tab_Expansion.md)

[CompleteInput() method](xref:System.Management.Automation.CommandCompletion.CompleteInput*)
