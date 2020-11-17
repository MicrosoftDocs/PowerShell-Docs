---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/tee-object?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Tee-Object
---
# Tee-Object

## SYNOPSIS
Saves command output in a file or variable and also sends it down the pipeline.

## SYNTAX

### File (Default)

```
Tee-Object [-InputObject <PSObject>] [-FilePath] <String> [-Append] [<CommonParameters>]
```

### LiteralFile

```
Tee-Object [-InputObject <PSObject>] -LiteralPath <String> [<CommonParameters>]
```

### Variable

```
Tee-Object [-InputObject <PSObject>] -Variable <String> [<CommonParameters>]
```

## DESCRIPTION

The `Tee-Object` cmdlet redirects output, that is, it sends the output of a command in two
directions (like the letter T). It stores the output in a file or variable and also sends it down
the pipeline. If `Tee-Object` is the last command in the pipeline, the command output is displayed
at the prompt.

## EXAMPLES

### Example 1: Output processes to a file and to the console

This example gets a list of the processes running on the computer and sends the result to a file.
Because a second path is not specified, the processes are also displayed in the console.

```powershell
Get-Process | Tee-Object -FilePath "C:\Test1\testfile2.txt"
```

```Output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)    Id ProcessName
-------  ------    -----      ----- -----   ------    -- -----------
83       4     2300       4520    39     0.30    4032 00THotkey
272      6     1400       3944    34     0.06    3088 alg
81       3      804       3284    21     2.45     148 ApntEx
81       4     2008       5808    38     0.75    3684 Apoint
...
```

### Example 2: Output processes to a variable and `Select-Object`

This example gets a list of the processes running on the computer, saves them to the `$proc`
variable, and pipes them to `Select-Object`.

```powershell
Get-Process notepad | Tee-Object -Variable proc | Select-Object processname,handles
```

```Output
ProcessName                              Handles
-----------                              -------
notepad                                  43
notepad                                  37
notepad                                  38
notepad                                  38
```

The `Select-Object` cmdlet selects the **ProcessName** and **Handles** properties. Note that the
`$proc` variable includes the default information returned by `Get-Process`.

### Example 3: Output system files to two log files

This example saves a list of system files in a two log files, a cumulative file and a current file.

```powershell
Get-ChildItem -Path D: -File -System -Recurse |
  Tee-Object -FilePath "c:\test\AllSystemFiles.txt" -Append |
    Out-File c:\test\NewSystemFiles.txt
```

The command uses the `Get-ChildItem` cmdlet to do a recursive search for system files on the D:
drive. A pipeline operator (|) sends the list to `Tee-Object`, which appends the list to the
AllSystemFiles.txt file and passes the list down the pipeline to the `Out-File` cmdlet, which saves
the list in the NewSystemFiles.txt file.

## PARAMETERS

### -Append

Indicates that the cmdlet appends the output to the specified file. Without this parameter, the new
content replaces any existing content in the file without warning.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies a file that this cmdlet saves the object to Wildcard characters are permitted, but must
resolve to a single file.

```yaml
Type: System.String
Parameter Sets: File
Aliases: Path

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject

Specifies the object to be saved and displayed. Enter a variable that contains the objects or type a
command or expression that gets the objects. You can also pipe an object to `Tee-Object`.

When you use the **InputObject** parameter with `Tee-Object`, instead of piping command results to
`Tee-Object`, the **InputObject** value is treated as a single object even if the value is a
collection.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies a file that this cmdlet saves the object to. Unlike **FilePath**, the value of the
**LiteralPath** parameter is used exactly as it is typed. No characters are interpreted as
wildcards. If the path includes escape characters, enclose it in single quotation marks. Single
quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: LiteralFile
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable

Specifies a variable that the cmdlet saves the object to. Enter a variable name without the
preceding dollar sign (`$`).

```yaml
Type: System.String
Parameter Sets: Variable
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe objects to `Tee-Object`.

## OUTPUTS

### System.Management.Automation.PSObject

`Tee-Object` returns the object that it redirects.

## NOTES

You can also use the `Out-File` cmdlet or the redirection operator, both of which save the output in
a file but do not send it down the pipeline.

Beginning in PowerShell 6, `Tee-Object` uses BOM-less UTF-8 encoding when it writes to files. If you
need a different encoding, use the `Out-File` cmdlet with the **Encoding** parameter.

## RELATED LINKS

[Compare-Object](Compare-Object.md)

[ForEach-Object](../Microsoft.PowerShell.Core/ForEach-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[New-Object](New-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

[about_Redirection](../Microsoft.PowerShell.Core/About/about_Redirection.md)

