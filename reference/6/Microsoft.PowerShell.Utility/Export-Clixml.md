---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 1/22/2019
online version: http://go.microsoft.com/fwlink/?LinkId=821767
schema: 2.0.0
title: Export-Clixml
---
# Export-Clixml

## SYNOPSIS
Creates an XML-based representation of an object or objects and stores it in a file.

## SYNTAX

### ByPath (Default)

```
Export-Clixml [-Depth <Int32>] [-Path] <String> -InputObject <PSObject> [-Force] [-NoClobber]
[-Encoding <Encoding>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Export-Clixml [-Depth <Int32>] -LiteralPath <String> -InputObject <PSObject> [-Force] [-NoClobber]
[-Encoding <Encoding>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Export-Clixml` cmdlet creates an XML-based representation of an object or objects and stores
it in a file. You can then use the `Import-Clixml` cmdlet to recreate the saved object based on the
contents of that file.

This cmdlet is similar to `ConvertTo-Xml`, except that `Export-Clixml` stores the resulting XML in
a file. `ConvertTo-XML` returns the XML, so you can continue to process it in PowerShell.

A valuable use of `Export-Clixml` is to export credentials and secure strings securely as XML. For
an example of how to do this, see Example 3.

## EXAMPLES

### Example 1: Export a string to an XML file

This command creates an XML file that stores a representation of the string, "This is a test" in
the current directory.

```powershell
"This is a test" | Export-Clixml -Path .\sample.xml
```

### Example 2: Export an object to an XML file

This example shows how to export an object to an XML file and then create an object by importing
the XML from the file.

```powershell
Get-Acl C:\test.txt | Export-Clixml -Path .\fileacl.xml
$fileacl = Import-Clixml -Path .\fileacl.xml
```

The `Get-Acl` cmdlet gets the security descriptor of the Test.txt file. It sends the object down
the pipeline to pass the security descriptor to `Export-Clixml`. The XML-based representation of
the object is stored in a file named FileACL.xml.

The `Import-Clixml` cmdlet creates an object from the XML in the FileACL.xml file. Then, it saves
the object in the `$fileacl` variable.

### Example 3: Encrypt an exported credential object

This example shows how to use a credential stored in a variable and save it to disk. The credential
can then be imported into scripts.

```powershell
$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
$credential | Export-Clixml $credxmlpath
$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
$credential = Import-Clixml $credxmlpath
```

The `Export-Clixml` cmdlet encrypts credential objects by using the
[Windows Data Protection API](https://msdn.microsoft.com/library/windows/apps/xaml/hh464970.aspx).
This ensures that only your user account on only that computer can decrypt the contents of the
credential object. The exported CliXml file can neither be used on a different computer nor by a
different user.

In this example, given a credential that you've stored in the `$credential` variable by running the
`Get-Credential` cmdlet, you can run the `Export-Clixml` cmdlet to save the credential to disk. In
the example, the file in which the credential is stored is represented by
TestScript.ps1.credential. Replace TestScript with the name of the script with which you are
loading the credential.

In the second command, pipe the credential object to `Export-Clixml`, and save it to the path,
`$credxmlpath`, that you specified in the first command.

To import the credential automatically into your script, run the final two commands. This time, you
are running `Import-Clixml` to import the secured credential object into your script. This
eliminates the risk of exposing plain-text passwords in your script.

## PARAMETERS

### -Depth

Specifies how many levels of contained objects are included in the XML representation. The default
value is 2.

The default value can be overridden for the object type in the Types.ps1xml files. For more
information, see [about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is **UTF8NoBOM**.

The acceptable values for this parameter are as follows:

- **ASCII**: Uses the encoding for the ASCII (7-bit) character set.
- **BigEndianUnicode**: Encodes in UTF-16 format using the big-endian byte order.
- **Byte**: Encodes a set of characters into a sequence of bytes.
- **Default**: Encodes using the default value: ASCII.
- **OEM**: Uses the default encoding for MS-DOS and console programs.
- **String**: Uses the encoding type for a string.
- **Unicode**: Encodes in UTF-16 format using the little-endian byte order.
- **UTF7**: Encodes in UTF-7 format.
- **UTF8**: Encodes in UTF-8 format.
- **UTF8BOM**: Encodes in UTF-8 format with Byte Order Mark (BOM)
- **UTF8NoBOM**: Encodes in UTF-8 format without Byte Order Mark (BOM)
- **UTF32**: Encodes in UTF-32 format.
- **Unknown**: The encoding type is unknown or invalid; the data can be treated as binary.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, Byte, Default, OEM, String, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32, Unknown

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

Causes the cmdlet to clear the read-only attribute of the output file if necessary. The cmdlet will
attempt to reset the read-only attribute when the command completes.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the object to be converted. Enter a variable that contains the objects, or type a command
or expression that gets the objects. You can also pipe objects to `Export-Clixml`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the file where the XML representation of the object will be stored. Unlike
**Path**, the value of the **LiteralPath** parameter is used exactly as it is typed. No characters
are interpreted as wildcards. If the path includes escape characters, enclose it in single
quotation marks. Single quotation marks tell PowerShell not to interpret any characters as
escape sequences.

```yaml
Type: String
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber

Indicates that the cmdlet does not overwrite the contents of an existing file. By default, if a
file exists in the specified path, `Export-Clixml` overwrites the file without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the file where the XML representation of the object will be stored.

```yaml
Type: String
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
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

You can pipe any object to `Export-Clixml`.

## OUTPUTS

### System.IO.FileInfo

`Export-Clixml` creates a file that contains the XML.

## NOTES

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems](https://blogs.technet.microsoft.com/heyscriptingguy/2011/06/05/use-powershell-to-pass-credentials-to-legacy-systems/)

[Securely Store Credentials on Disk](https://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[ConvertTo-Html](ConvertTo-Html.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[Export-Csv](Export-Csv.md)

[Import-Clixml](Import-Clixml.md)