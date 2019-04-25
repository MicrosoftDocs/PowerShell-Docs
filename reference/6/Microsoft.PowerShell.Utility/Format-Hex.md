---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/25/2019
online version: http://go.microsoft.com/fwlink/?LinkId=821773
schema: 2.0.0
title: Format-Hex
---
# Format-Hex

## SYNOPSIS
Displays a file or other input as hexadecimal.

## SYNTAX

### Path (Default)

```
Format-Hex [-Path] <string[]> [-Count <long>] [-Offset <long>] [<CommonParameters>]
```

### LiteralPath

```
Format-Hex -LiteralPath <string[]> [-Count <long>] [-Offset <long>] [<CommonParameters>]
```

### ByInputObject

```
Format-Hex -InputObject <psobject> [-Encoding <Encoding>] [-Count <long>] [-Offset <long>] [-Raw] [<CommonParameters>]
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
**File.t7f**. The file extension **.t7f** is uncommon, but the hexadecimal output **%PDF** shows
that it is a PDF file.

## PARAMETERS

### -Encoding

Specifies the encoding of the output. This only applies to `[string]` input. The parameter has no
effect on numeric types. The default value is **UTF8NoBOM**. 

The acceptable values for this parameter are as follows:

- **ASCII**: Uses the encoding for the ASCII (7-bit) character set.
- **BigEndianUnicode**: Encodes in UTF-16 format using the big-endian byte order.
- **OEM**: Uses the default encoding for MS-DOS and console programs.
- **Unicode**: Encodes in UTF-16 format using the little-endian byte order.
- **UTF7**: Encodes in UTF-7 format.
- **UTF8**: Encodes in UTF-8 format.
- **UTF8BOM**: Encodes in UTF-8 format with Byte Order Mark (BOM)
- **UTF8NoBOM**: Encodes in UTF-8 format without Byte Order Mark (BOM)
- **UTF32**: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

```yaml
Type: Encoding
Parameter Sets: ByInputObject
Aliases:
Accepted values: ASCII, BigEndianUnicode, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Used for pipeline input. Pipeline input supports only certain scalar types and `[system.io.fileinfo]`
instances for piping from `Get-ChildItem`.

The supported scalar types are:

- `[string]`, `[char]`
- `[byte]`, `[sbyte]`
- `[int16]`, `[uint16]`, `[short]`, `[ushort]`
- `[int]`, `[uint]`, `[int32]`, `[uint32]`,
- `[long]`, `[ulong]`, `[int64]`, `[uint64]`
- `[single]`, `[float]`, `[double]`

```yaml
Type: PSObject
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
Type: String[]
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
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Raw

This parameter no longer does anything. It is retained for script compatibility.

```yaml
Type: SwitchParameter
Parameter Sets: ByInputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset

This represents the number of bytes to skip from being part of the hex output.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count

This represents the number of bytes to include in the hex output.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Int64.MaxValue
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
