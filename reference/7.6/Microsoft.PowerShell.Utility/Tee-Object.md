---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/25/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/tee-object?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Tee-Object
---

# Tee-Object

## SYNOPSIS
Saves command output in a file or variable and also sends it down the pipeline.

## SYNTAX

### File (Default)

```
Tee-Object [-InputObject <PSObject>] [-FilePath] <String> [-Append] [[-Encoding] <Encoding>] [<CommonParameters>]
```

### LiteralFile

```
Tee-Object [-InputObject <PSObject>] -LiteralPath <String> [[-Encoding] <Encoding>] [<CommonParameters>]
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
Get-Process notepad | Tee-Object -Variable proc | Select-Object ProcessName, Handles
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
drive. A pipeline operator (`|`) sends the list to `Tee-Object`, which appends the list to the
AllSystemFiles.txt file and passes the list down the pipeline to the `Out-File` cmdlet, which saves
the list in the `NewSystemFiles.txt file`.

### Example 4: Print output to console and use in the pipeline

This example gets the files in a folder, prints them to the console, then filters the files for
those that have a defined front matter metadata block. Finally, it lists the names of the articles
that have front matter.

```powershell
$consoleDevice = if ($IsWindows) {
    '\\.\CON'
} else {
    '/dev/tty'
}
$frontMatterPattern = '(?s)^---(?<FrontMatter>.+)---'

$articles = Get-ChildItem -Path .\reference\7.4\PSReadLine\About\ |
    Tee-Object -FilePath $consoleDevice |
    Where-Object {
        (Get-Content $_ -Raw) -match $frontMatterPattern
    }

$articles.Name
```

```Output
    Directory: C:\code\docs\PowerShell-Docs\reference\7.4\PSReadLine\About

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          12/13/2022 11:37 AM            384 .markdownlint.yaml
-a---           4/25/2023 11:28 AM          40194 about_PSReadLine_Functions.md
-a---           4/25/2023 10:58 AM          10064 about_PSReadLine.md

about_PSReadLine_Functions.md
about_PSReadLine.md
```

The example sets the `$consoleDevice` variable to the value of the current terminal's console
device. On Windows, you can write to the current console device by redirecting your output to the
`\\.\CON` filepath. On non-Windows systems, you use the `/dev/tty` filepath.

Then it sets the `$frontMatterPattern` variable to a regular expression that matches when a string
starts with three dashes (`---`) and has any content before another three dashes. When this pattern
matches an article's content, the article has a defined front matter metadata block.

Next, the example uses `Get-ChildItem` to retrieve every file in the `About` folder. `Tee-Object`
prints the piped results to the console using the **FileName** parameter. `Where-Object` filters
the files by getting their content as a single string with the **Raw** parameter of `Get-Content`
and comparing that string to `$frontMatterPattern`.

Finally, the example prints the names of the files in the folder that have a defined front matter
metadata block.

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

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `ansi`: Uses the encoding for the for the current culture's ANSI code page. This option was added
  in PowerShell 7.4.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format.
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

Starting with PowerShell 7.4, you can use the `Ansi` value for the **Encoding** parameter to pass
the numeric ID for the current culture's ANSI code page without having to specify it manually.

This parameter was introduced in PowerShell 7.2.

> [!NOTE]
> **UTF-7*** is no longer recommended to use. As of PowerShell 7.1, a warning is written if you
> specify `utf7` for the **Encoding** parameter.

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: 1
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies a file that this cmdlet saves the object to Wildcard characters are permitted, but must
resolve to a single file.

Starting in PowerShell 7, when you specify the **FilePath** as `\\.\CON` on Windows or `/dev/tty`
on non-Windows systems, the **InputObject** is printed in the console. Those file paths correspond
to the current terminal's console device on the system, enabling you to print the **InputObject**
and send it to the output stream with one command.

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

You can pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSObject

This cmdlet returns the object that it redirects.

## NOTES

PowerShell includes the following aliases for `Tee-Object`:

- Windows:
  - `tee`

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
