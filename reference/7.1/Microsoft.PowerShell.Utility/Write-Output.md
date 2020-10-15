---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/write-output?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Output
---
# Write-Output

## SYNOPSIS
Sends the specified objects to the next command in the pipeline. If the command is the last command
in the pipeline, the objects are displayed in the console.

## SYNTAX

```
Write-Output [-InputObject] <PSObject[]> [-NoEnumerate] [<CommonParameters>]
```

## DESCRIPTION

The `Write-Output` cmdlet sends the specified object down the pipeline to the next command.
If the command is the last command in the pipeline, the object is displayed in the console.

`Write-Output` sends objects down the primary pipeline, also known as the "output stream" or the
"success pipeline." To send error objects down the error pipeline, use Write-Error.

This cmdlet is typically used in scripts to display strings and other objects on the console. One of
the built-in aliases for `Write-Output` is `echo` and similar to other shells that use `echo`, the
default behavior is to display the output at the end of a pipeline. In PowerShell, it is generally
not necessary to use the cmdlet in instances where the output is displayed by default. For example,
`Get-Process | Write-Output` is equivalent to `Get-Process`. Or, `echo "Home directory: $HOME"` can
be written, `"Home directory: $HOME"`.

By default, `Write-Output` enumerates through collections provided to the cmdlet. However,
`Write-Output` can also be used to pass collections down the pipeline as a single object with the
**NoEnumerate** parameter.

## EXAMPLES

### Example 1: Get objects and write them to the console

```powershell
$P = Get-Process
Write-Output $P
```

The first command gets processes running on the computer and stores them in the `$P` variable.

The second and third commands display the process objects in `$P` on the console.

### Example 2: Pass output to another cmdlet

```powershell
Write-Output "test output" | Get-Member
```

This command pipes the "test output" string to the `Get-Member` cmdlet, which displays the members
of the **System.String** class, demonstrating that the string was passed along the pipeline.

### Example 3: Suppress enumeration in output

```powershell
Write-Output 1,2,3 | Measure-Object
```

```Output
Count    : 3
...
```

```powershell
Write-Output 1,2,3 -NoEnumerate | Measure-Object
```

```Output
Count    : 1
...
```

This command adds the **NoEnumerate** parameter to treat a collection or array as a single object
through the pipeline.

## PARAMETERS

### -InputObject

Specifies the objects to send down the pipeline. Enter a variable that contains the objects, or type
a command or expression that gets the objects.

```yaml
Type: System.Management.Automation.PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoEnumerate

By default, the `Write-Output` cmdlet always enumerates its output. The **NoEnumerate** parameter
suppresses the default behavior, and prevents `Write-Output` from enumerating output. The
**NoEnumerate** parameter has no effect if the command is wrapped in parentheses, because the
parentheses force enumeration. For example, `(Write-Output 1,2,3)` still enumerates the array.

> [!NOTE]
> This switch only works correctly with PowerShell Core 6.2 and newer. On older versions of
> PowerShell Core, the collection is still enumerated even with use of this switch.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe objects to `Write-Output`.

## OUTPUTS

### System.Management.Automation.PSObject

`Write-Output` returns the objects that are submitted as input.

## NOTES

## RELATED LINKS

[about_Output_Streams](../Microsoft.PowerShell.Core/About/about_Output_Streams.md)

[about_Redirection](../Microsoft.PowerShell.Core/About/about_Redirection.md)

[Tee-Object](Tee-Object.md)

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Information](Write-Information.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)
