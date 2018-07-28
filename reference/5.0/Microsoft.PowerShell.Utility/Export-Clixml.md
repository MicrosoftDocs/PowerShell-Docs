---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821767
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Export-Clixml
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
The **Export-Clixml** cmdlet creates an XML-based representation of an object or objects and stores it in a file.
You can then use the Import-Clixml cmdlet to re-create the saved object based on the contents of that file.

This cmdlet is similar to ConvertTo-Xml, except that **Export-Clixml** stores the resulting XML in a file.
**ConvertTo-XML** returns the XML, so you can continue to process it in Windows PowerShell.

A valuable use of **Export-Clixml** is to export credentials and secure strings securely as XML.
For an example of how to do this, see Example 3.

## EXAMPLES

### Example 1: Export a string to an XML file
```
PS C:\> "This is a test" | Export-Clixml sample.xml
```

This command creates an XML file that stores a representation of the string, "This is a test".

### Example 2: Export an object to an XML file
```
PS C:\> Get-Acl C:\test.txt | Export-Clixml -Path "fileacl.xml"
PS C:\> $Fileacl = Import-Clixml "fileacl.xml"
```

This example shows how to export an object to an XML file and then create an object by importing the XML from the file.

The first command uses the Get-Acl cmdlet to get the security descriptor of the Test.txt file.
It uses a pipeline operator to pass the security descriptor to **Export-Clixml**, which stores an XML-based representation of the object in a file named FileACL.xml.

The second command uses the Import-Clixml cmdlet to create an object from the XML in the FileACL.xml file.
Then, it saves the object in the $FileAcl variable.

### Example 3: Encrypt an exported credential object
```
PS C:\> $CredXmlPath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
PS C:\> $credential | Export-Clixml $CredPath
PS C:\> $CredXmlPath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
PS C:\> $Credential = Import-Clixml $CredXmlPath
```

The **Export-Clixml** cmdlet encrypts credential objects by using the Windows Data Protection API http://msdn.microsoft.com/library/windows/apps/xaml/hh464970.aspx.
This ensures that only your user account can decrypt the contents of the credential object.

In this example, given a credential that you've stored in the $Credential variable by running the Get-Credential cmdlet, you can run the **Export-Clixml** cmdlet to save the credential to disk.In the example, the file in which the credential is stored is represented by TestScript.ps1.credential.
Replace TestScript with the name of the script with which you are loading the credential.

In the second command, pipe the credential object to **Export-Clixml**, and save it to the path, $CredXmlPath, that you specified in the first command.

To import the credential automatically into your script, run the final two commands.
This time, you are running Import-Clixml to import the secured credential object into your script.
This eliminates the risk of exposing plain-text passwords in your script.

## PARAMETERS

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

### -Depth
Specifies how many levels of contained objects are included in the XML representation.
The default value is 2.

The default value can be overridden for the object type in the Types.ps1xml files.
For more information, see about_Types.ps1xml.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the type of encoding for the target file.
The acceptable values for this parameter are:

- ASCII
- UTF8
- UTF7
- UTF32
- Unicode
- BigEndianUnicode
- Default
- OEM

The default value is Unicode.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Unicode, UTF7, UTF8, ASCII, UTF32, BigEndianUnicode, Default, OEM

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

Causes the cmdlet to clear the read-only attribute of the output file if necessary.
The cmdlet will attempt to reset the read-only attribute when the command completes.

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
Specifies the object to be converted.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe objects to **Export-Clixml**.

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
Specifies the path to the file where the XML representation of the object will be stored.
Unlike *Path*, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

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
Indicates that the cmdlet does not overwrite the contents of an existing file.
By default, if a file exists in the specified path, **Export-Clixml** overwrites the file without warning.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to **Export-Clixml**.

## OUTPUTS

### System.IO.FileInfo
**Export-Clixml** creates a file that contains the XML.

## NOTES

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems](http://blogs.technet.com/b/heyscriptingguy/archive/2011/06/05/use-powershell-to-pass-credentials-to-legacy-systems.aspx)

[Securely Store Credentials on Disk](http://www.powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[ConvertTo-Html](ConvertTo-Html.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[Export-Csv](Export-Csv.md)

[Import-Clixml](Import-Clixml.md)