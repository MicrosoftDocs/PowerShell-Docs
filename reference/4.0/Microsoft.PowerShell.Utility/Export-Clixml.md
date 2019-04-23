---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/23/2019
online version: http://go.microsoft.com/fwlink/p/?linkid=293956
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
[-Encoding <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Export-Clixml [-Depth <Int32>] -LiteralPath <String> -InputObject <PSObject> [-Force] [-NoClobber]
[-Encoding <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
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
This ensures that only your user account can decrypt the contents of the credential object.

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

Specifies the type of encoding for the target file. The default value is **Unicode**.

The acceptable values for this parameter are as follows:

- **ASCII** Uses ASCII (7-bit) character set.
- **BigEndianUnicode** Uses UTF-16 with the big-endian byte order.
- **Default** Uses the encoding that corresponds to the system's active code page (usually ANSI).
- **OEM** Uses the encoding that corresponds to the system's current OEM code page.
- **Unicode** Uses UTF-16 with the little-endian byte order.
- **UTF7** Uses UTF-7.
- **UTF8** Uses UTF-8.
- **UTF32** Uses UTF-32 with the little-endian byte order.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, Default, OEM, Unicode, UTF7, UTF8, UTF32

Required: False
Position: Named
Default value: Unicode
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
Default value: False
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

### -NoClobber

Ensures that the cmdlet does not overwrite the contents of an existing file. By default, if a file
exists in the specified path, `Export-Clixml` overwrites the file without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: False
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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the file where the XML representation of the object will be stored. Unlike
**Path**, the value of the **LiteralPath** parameter is used exactly as it is typed. No characters
are interpreted as wildcards. If the path includes escape characters, enclose it in single
quotation marks. Single quotation marks tell PowerShell not to interpret any characters as escape
sequences.

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