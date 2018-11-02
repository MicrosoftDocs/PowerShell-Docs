---
ms.date:  11/02/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821773
external help file:  Microsoft.PowerShell.Utility-help.xml
title:  Format-Hex
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
Format-Hex -InputObject <PSObject> [-Encoding <Encoding>] [-Count <long>] [-Offset <long>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The **Format-Hex** cmdlet displays a file or other input as hexadecimal values.
To determine the offset of a character from the output, add the number at the leftmost of the row to the number at the top of the column for that character.

This cmdlet can help you determine the file type of a corrupted file or a file which may not have a file name extension.
Run this cmdlet, and then inspect the results for file information.

## EXAMPLES

### Example 1: Get the hexadecimal representation of a string

```
PS C:\> "Hello World" | Format-Hex


                       00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000000000000000   48 65 6C 6C 6F 20 57 6F 72 6C 64                 Hello World
```

This command returns the hexadecimal representation of the string Hello World.

### Example 2: Get the hexadecimal representation of a string with offset and count

```
PS C:\> "Hello World, Goodbye!" | Format-Hex -Offset 6 -Count 5


                       00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000000000000000   57 6F 72 6C 64                                   World
```

### Example 3: Get the hexadecimal representation of a file

```
PS C:\> Format-Hex -Path .\README.md -Count 67

                       Path: C:\README.md

                       00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000000000000000   23 20 21 5B 6C 6F 67 6F 5D 5B 5D 20 50 6F 77 65  # ![logo][] Powe
00000000000000000010   72 53 68 65 6C 6C 0A 0A 57 65 6C 63 6F 6D 65 20  rShell..Welcome
00000000000000000020   74 6F 20 74 68 65 20 50 6F 77 65 72 53 68 65 6C  to the PowerShel
00000000000000000030   6C 20 47 69 74 48 75 62 20 43 6F 6D 6D 75 6E 69  l GitHub Communi
00000000000000000040   74 79 21                                         ty!
```

## PARAMETERS

### -Encoding

Specifies the type of character encoding used in the file that this cmdlet formats as hexadecimal.
The acceptable values for this parameter are:

- Ascii
- UTF32
- UTF7
- UTF8
- BigEndianUnicode
- Unicode

The default value is Unicode.

```yaml
Type: String
Parameter Sets: ByInputObject
Aliases:
Accepted values: Ascii, UTF32, UTF7, UTF8, BigEndianUnicode, Unicode

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to be formatted.
Enter a variable that contains the objects or type a command or expression that gets the objects.

```yaml
Type: Object
Parameter Sets: ByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies an array of literal paths of items.
This parameter does not accept wildcard characters.
To use wildcard characters, specify the *Path* parameter instead.

If this parameter includes escape characters, enclose the path in single quotation marks.
PowerShell does not interpret any characters in a single quoted string as escape sequences.
For more information, type `Get-Help about_Quoting_Rules`.

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

Specifies an array of paths of items.
This cmdlet returns a hexadecimal representation of the items that this parameter specifies.

Use a dot (.) to specify the current location.
Use the wildcard character (*) to specify all the items in the current location.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ByteCollection

This cmdlet returns a **ByteCollection**.
This object represents a collection of bytes.
It includes methods that convert the collection of bytes to a string formatted like each line of output returned by **Format-Hex**.
If you specify the *Path* or *LiteralPath* parameter, the object also contains the path of the file that contains each byte.

## NOTES

## RELATED LINKS

[Format-Custom](Format-Custom.md)

[Format-List](Format-List.md)

[Format-Table](Format-Table.md)

[Format-Wide](Format-Wide.md)
