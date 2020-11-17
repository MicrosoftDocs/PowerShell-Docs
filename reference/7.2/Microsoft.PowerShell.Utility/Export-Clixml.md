---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/19/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.2&WT.mc_id=ps-gethelp
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

The `Export-Clixml` cmdlet creates a Common Language Infrastructure (CLI) XML-based representation
of an object or objects and stores it in a file. You can then use the `Import-Clixml` cmdlet to
recreate the saved object based on the contents of that file.
For more information about CLI, see [Language independence](/dotnet/standard/language-independence).

This cmdlet is similar to `ConvertTo-Xml`, except that `Export-Clixml` stores the resulting XML in a
file. `ConvertTo-XML` returns the XML, so you can continue to process it in PowerShell.

A valuable use of `Export-Clixml` on Windows computers is to export credentials and secure strings
securely as XML. For an example, see Example 3.

## EXAMPLES

### Example 1: Export a string to an XML file

This example creates an XML file that stores in the current directory, a representation of the
string **This is a test**.

```powershell
"This is a test" | Export-Clixml -Path .\sample.xml
```

The string `This is a test` is sent down the pipeline. `Export-Clixml` uses the **Path** parameter
to create an XML file named `sample.xml` in the current directory.

### Example 2: Export an object to an XML file

This example shows how to export an object to an XML file and then create an object by importing the
XML from the file.

```powershell
Get-Acl C:\test.txt | Export-Clixml -Path .\FileACL.xml
$fileacl = Import-Clixml -Path .\FileACL.xml
```

The `Get-Acl` cmdlet gets the security descriptor of the `Test.txt` file. It sends the object down
the pipeline to pass the security descriptor to `Export-Clixml`. The XML-based representation of the
object is stored in a file named `FileACL.xml`.

The `Import-Clixml` cmdlet creates an object from the XML in the `FileACL.xml` file. Then, it saves
the object in the `$fileacl` variable.

### Example 3: Encrypt an exported credential object on Windows

In this example, given a credential that you've stored in the `$Credential` variable by running the
`Get-Credential` cmdlet, you can run the `Export-Clixml` cmdlet to save the credential to disk.

> [!IMPORTANT]
> `Export-Clixml` only exports encrypted credentials on Windows. On non-Windows operating systems
> such as macOS and Linux, credentials are exported as a plain text stored as a Unicode character
> array. This provides some obfuscation but does not provide encryption.

```powershell
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential | Export-Clixml $Credxmlpath
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential = Import-Clixml $Credxmlpath
```

The `Export-Clixml` cmdlet encrypts credential objects by using the Windows
[Data Protection API](/previous-versions/windows/apps/hh464970(v=win.10)). The encryption ensures
that only your user account on only that computer can decrypt the contents of the credential object.
The exported `CLIXML` file can't be used on a different computer or by a different user.

In the example, the file in which the credential is stored is represented by
`TestScript.ps1.credential`. Replace **TestScript** with the name of the script with which you're
loading the credential.

You send the credential object down the pipeline to `Export-Clixml`, and save it to the path,
`$Credxmlpath`, that you specified in the first command.

To import the credential automatically into your script, run the final two commands. Run
`Import-Clixml` to import the secured credential object into your script. This import eliminates the
risk of exposing plain-text passwords in your script.

### Example 4: Exporting a credential object on Linux or macOS

In this example, we create a **PSCredential** in the `$Credential` variable using the
`Get-Credential` cmdlet. Then we use `Export-Clixml` to save the credential to disk.

> [!IMPORTANT]
> `Export-Clixml` only exports encrypted credentials on Windows. On non-Windows operating systems
> such as macOS and Linux, credentials are exported as a plain text stored as a Unicode character
> array. This provides some obfuscation but does not provide encryption.

```powershell
PS> $Credential = Get-Credential

PowerShell credential request
Enter your credentials.
User: User1
Password for user User1: ********

PS> $Credential | Export-Clixml ./cred2.xml
PS> Get-Content ./cred2.xml

...
    <Props>
      <S N="UserName">User1</S>
      <SS N="Password">700061007300730077006f0072006400</SS>
    </Props>
...

PS> 'password' | Format-Hex -Encoding unicode

   Label: String (System.String) <52D60C91>

          Offset Bytes                                           Ascii
                 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
          ------ ----------------------------------------------- -----
0000000000000000 70 00 61 00 73 00 73 00 77 00 6F 00 72 00 64 00 p a s s w o r d
```

The output of `Get-Content` in this example has been truncate to focus on the credential information
in the XML file. Note that the plain text value of the password is stored in the XML file as a
Unicode character array as proven by `Format-Hex`. So the value is encoded but not encrypted.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

Specifies how many levels of contained objects are included in the XML representation. The default
value is `2`.

The default value can be overridden for the object type in the `Types.ps1xml` files. For more
information, see [about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `bigendianutf32`: Encodes in UTF-32 format using the big-endian byte order.
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

> [!NOTE]
> **UTF-7*** is no longer recommended to use. In PowerShell 7.1, a warning is written if you
> specify `utf7` for the **Encoding** parameter.

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

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
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.PSObject
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
**Path**, the value of the **LiteralPath** parameter is used exactly as it's typed. No characters
are interpreted as wildcards. If the path includes escape characters, enclose it in single quotation
marks. Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber

Indicates that the cmdlet doesn't overwrite the contents of an existing file. By default, if a file
exists in the specified path, `Export-Clixml` overwrites the file without warning.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.String
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipeline any object to `Export-Clixml`.

## OUTPUTS

### System.IO.FileInfo

`Export-Clixml` creates a file that contains the XML.

## NOTES

## RELATED LINKS

[ConvertTo-Html](ConvertTo-Html.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[Export-Csv](Export-Csv.md)

[Import-Clixml](Import-Clixml.md)

[Join-Path](../Microsoft.PowerShell.Management/Join-Path.md)

[Securely Store Credentials on Disk](https://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[Use PowerShell to Pass Credentials to Legacy Systems](https://devblogs.microsoft.com/scripting/use-powershell-to-pass-credentials-to-legacy-systems/)

[Windows.Security.Cryptography.DataProtection](/uwp/api/windows.security.cryptography.dataprotection)
