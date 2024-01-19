---
external help file: Microsoft.PowerShell.Utility-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/19/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/format-hex?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Format-Hex
---

# Format-Hex

## SYNOPSIS

Displays a file or other input as hexadecimal.

## SYNTAX

### Path (Default)

```
Format-Hex [-Path] <string[]> [<CommonParameters>]
```

### LiteralPath

```
Format-Hex -LiteralPath <string[]> [<CommonParameters>]
```

### ByInputObject

```
Format-Hex -InputObject <Object> [-Encoding <string>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The `Format-Hex` cmdlet displays a file or other input as hexadecimal values. To determine the
offset of a character from the output, add the number at the leftmost of the row to the number at
the top of the column for that character.

The `Format-Hex` cmdlet can help you determine the file type of a corrupted file or a file that
might not have a filename extension. You can run this cmdlet, and then read the hexadecimal output
to get file information.

When using `Format-Hex` on a file, the cmdlet ignores newline characters and returns the entire
contents of a file in one string with the newline characters preserved.

## EXAMPLES

### Example 1: Get the hexadecimal representation of a string

This command returns the hexadecimal values of a string.

```powershell
'Hello World' | Format-Hex
```

```Output
           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   48 65 6C 6C 6F 20 57 6F 72 6C 64                 Hello World
```

The string **Hello World** is sent down the pipeline to the `Format-Hex` cmdlet. The hexadecimal
output from `Format-Hex` shows the values of each character in the string.

### Example 2: Find a file type from hexadecimal output

This example uses the hexadecimal output to determine the file type. The cmdlet displays the file's
full path and the hexadecimal values.

To test the following command, make a copy of an existing PDF file on your local computer and rename
the copied file to **File.t7f**.

```powershell
Format-Hex -Path .\File.t7f
```

```Output
           Path: C:\Test\File.t7f

           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   25 50 44 46 2D 31 2E 35 0D 0A 25 B5 B5 B5 B5 0D  %PDF-1.5..%????.
00000010   0A 31 20 30 20 6F 62 6A 0D 0A 3C 3C 2F 54 79 70  .1 0 obj..<</Typ
00000020   65 2F 43 61 74 61 6C 6F 67 2F 50 61 67 65 73 20  e/Catalog/Pages
```

The `Format-Hex` cmdlet uses the **Path** parameter to specify a filename in the current directory,
`File.t7f`. The file extension `.t7f` is uncommon, but the hexadecimal output `%PDF` shows
that it is a PDF file.

### Example 3: Display raw hexadecimal output

By default `Format-Hex` opts for compact output of numeric data types: single-byte or double-byte
sequences are used if the value is small enough. The **Raw** parameter deactivates this behavior.

```
PS> 1,2,3,1000 | Format-Hex

           Path:

           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   01 02 03 E8 03                                   ...è.


PS> 1,2,3,1000 | Format-Hex -Raw

           Path:

           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   01 00 00 00 02 00 00 00 03 00 00 00 E8 03 00 00  ............è...
```

Notice the difference in output. The **Raw** parameter displays the numbers as 4-byte values, true
to their **Int32** types.

## PARAMETERS

### -Encoding

Specifies the encoding of the output. This only applies to `[string]` input. The parameter has no
effect on numeric types. The default value is `ASCII`.

The acceptable values for this parameter are as follows:

- `Ascii` Uses ASCII (7-bit) character set.
- `BigEndianUnicode` Uses UTF-16 with the big-endian byte order.
- `Unicode` Uses UTF-16 with the little-endian byte order.
- `UTF7` Uses UTF-7.
- `UTF8` Uses UTF-8.
- `UTF32` Uses UTF-32 with the little-endian byte order.

Non-ASCII characters in the input are output as literal `?` characters resulting in a loss of
information.

```yaml
Type: System.String
Parameter Sets: ByInputObject
Aliases:
Accepted values: ASCII, BigEndianUnicode, Unicode, UTF7, UTF8, UTF32

Required: False
Position: Named
Default value: ASCII
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to be formatted. Enter a variable that contains the objects or type a command
or expression that gets the objects.

Only certain [scalar](/powershell/scripting/learn/glossary#scalar-value) types and
`[system.io.fileinfo]` are supported.

The supported scalar types are:

- `[string]`
- `[byte]`
- `[int]`, `[int32]`
- `[long]`, `[int64]`

```yaml
Type: System.Object
Parameter Sets: ByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the complete path to a file. The value of **LiteralPath** is used exactly as it is typed.
This parameter does not accept wildcard characters. To specify multiple paths to files, separate the
paths with a comma. If the **LiteralPath** parameter includes escape characters, enclose the path in
single quotation marks. PowerShell does not interpret any characters in a single quoted string as
escape sequences. For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to files. Use a dot (`.`) to specify the current location. The wildcard character
(`*`) is accepted and can be used to specify all the items in a location. If the **Path** parameter
includes escape characters, enclose the path in single quotation marks. To specify multiple paths to
files, separate the paths with a comma.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Raw

By default `Format-Hex` opts for compact output of numeric data types: single-byte or double-byte
sequences are used if the value is small enough. The **Raw** parameter deactivates this behavior.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ByInputObject
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ByteCollection

This cmdlet returns a **ByteCollection**. This object represents a collection of bytes. It includes
methods that convert the collection of bytes to a string formatted like each line of output returned
by `Format-Hex`. If you specify the **Path** or **LiteralPath** parameter, the object also contains
the path of the file that contains each byte.

## NOTES

Windows PowerShell includes the following aliases for `Format-Hex`:

- `fhx`

The right-most column of output tries to render the bytes as characters:

Generally, each byte is interpreted as a Unicode code point, which means that:

- Printable ASCII characters are always rendered correctly
- Multi-byte UTF-8 characters never render correctly
- UTF-16 characters render correctly only if their high-order byte happens be `NUL`.

## RELATED LINKS

[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md)

[Format-Custom](Format-Custom.md)

[Format-List](Format-List.md)

[Format-Table](Format-Table.md)

[Format-Wide](Format-Wide.md)
