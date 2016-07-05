---
external help file: PSITPro5_Utility.xml
online version: f45e1921-dc98-4d7e-a938-e7a503284c61
schema: 2.0.0
---

# Format-Hex
## SYNOPSIS
Displays a file or other input as hexadecimal.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Format-Hex [-Encoding]
```

### UNNAMED_PARAMETER_SET_2
```
Format-Hex -LiteralPath <String[]>
```

### UNNAMED_PARAMETER_SET_3
```
Format-Hex [-Path] <String[]>
```

## DESCRIPTION
The Format-Hex cmdlet displays a file or other input as hexadecimal values.
To determine the offset of a character from the output, add the number at the leftmost of the row to the number at the top of the column for that character.

This cmdlet can help you determine the file type of a corrupted file or a file which may not have a file name extension.
Run this cmdlet, and then inspect the results for file information.

## EXAMPLES

### Example 1: Get the hexadecimal representation of a string
```
PS C:\>"Hello World" | Format-Hex
           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   48 65 6C 6C 6F 20 57 6F 72 6C 64                 Hello World
```

This command returns the hexadecimal representation of the string Hello World.

### Example 2: Investigate a file type
```
PS C:\>Format-Hex -Path "C:\temp\temp.t7f"
           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   25 50 44 46 2D 31 2E 35 0D 0A 25 B5 B5 B5 B5 0D  %PDF-1.5..%????. 
00000010   0A 31 20 30 20 6F 62 6A 0D 0A 3C 3C 2F 54 79 70  .1 0 obj..<</Typ
00000020   65 2F 43 61 74 61 6C 6F 67 2F 50 61 67 65 73 20  e/Catalog/Pages
```

This command converts the file that is named temp.t7f to hexadecimal.
In this example, a file that has the unfamiliar file name extension .t7f is actually a PDF file.
The first few bytes of the header contain that information.

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
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 
Accepted values: Ascii, UTF32, UTF7, UTF8, BigEndianUnicode, Unicode

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies an array of literal paths of items.
This parameter does not accept wildcard characters.
To use wildcard characters, specify the Path parameter instead.

If this parameter includes escape characters, enclose the path in single quotation marks.
Windows PowerShell does not interpret any characters in a single quoted string as escape sequences.
For more information, type Get-Help about_Quoting_Rules.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.ByteCollection
This cmdlet returns a ByteCollection.
This object represents a collection of bytes.
It includes methods that convert the collection of bytes to a string formatted like each line of output returned by Format-Hex.
If you specify the Path or LiteralPath parameter, the object also contains the path of the file that contains each byte.

## NOTES

## RELATED LINKS

[Format-Custom](f45e1921-dc98-4d7e-a938-e7a503284c61)

[Format-List](dec7f080-d85c-46c4-ade4-5aef22c1bf18)

[Format-Table](2b56a2d0-c067-40e4-b744-979fbaf847e2)

[Format-Wide](6e24fa8c-30b4-440c-a84a-54b517933cb2)

