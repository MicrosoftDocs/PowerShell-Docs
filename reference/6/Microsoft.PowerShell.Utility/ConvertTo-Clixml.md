---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertTo-Clixml
---

# ConvertTo-Clixml

## SYNOPSIS
Converts objects to an XML-based representation and returns that as a string.

## SYNTAX

```
ConvertTo-Clixml [-Depth <Int32>] -InputObject <PSObject> [-Encoding <String>] [<CommonParameters>]
```

## DESCRIPTION
The **ConvertTo-CliXml** cmdlet creates XML-based representations of objects and returns them as strings.
You can then use the **ConvertFrom-Clixml** cmdlet to re-create the saved objects based on the contents of the strings.

A valuable use of **ConvertTo-CliXml** is to serialize credentials and secure strings securely as XML.
For an example of how to do this, see Example 3.

## EXAMPLES

### Example 1: Convert a string to an XML representation

```powershell
"This is a test" | ConvertTo-Clixml
```

This command returns a string with am XML-based representation of the string object with a value of "This is a test".

### Example 2: Convert an object to an XML-based representation

```powershell
$FileaclString = Get-Acl C:\test.txt | ConvertTo-Clixml
Fileacl = ConvertFrom-Clixml $FileaclString
```

This example shows how to convert an object to an XML string and then create an object by converting the XML from the string.

The first command uses the Get-Acl cmdlet to get the security descriptor of the Test.txt file.
It uses a pipeline operator to pass the security descriptor to **ConvertTo-Clixml**, which converts the object to an XML-based representation and returns that as a string.
Then, it saves the string in the $FileAclString variable.

The second command uses the ConvertFrom-Clixml cmdlet to create an object from the XML in the $FileAclString variable.
Then, it saves the object in the $FileAcl variable.

### Example 3: Convert an encrypted credential object

```powershell
$CredXml = $Credential | ConvertTo-Clixml
$Credential = ConvertFrom-CliXml $CredXml
```

The **ConvertTo-CliXml** cmdlet encrypts credential objects by using the
[Windows Data Protection API](http://msdn.microsoft.com/library/windows/apps/xaml/hh464970.aspx).
This ensures that only your user account can decrypt the contents of the credential object.

In this example, given a credential that you've stored in the $Credential variable by running the Get-Credential cmdlet, you can run the **ConvertTo-CliXml** cmdlet to serialize the credential to a string.

To deserialize the credential later, run the second command.
This time, you are running ConvertFrom-Clixml to import the secured credential object into your script.
This eliminates the risk of exposing plain-text passwords in your script.

## PARAMETERS

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

### -InputObject
Specifies the object to be converted.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe objects to **ConvertTo-Clixml**.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to **ConvertTo-Clixml**.

## OUTPUTS

### System.String
The XML-based representation is returned as a collection of strings.

## NOTES

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems](http://blogs.technet.com/b/heyscriptingguy/archive/2011/06/05/use-powershell-to-pass-credentials-to-legacy-systems.aspx)

[Securely Store Credentials on Disk](http://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[ConvertTo-Json](ConvertTo-Json.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

[ConvertTo-Csv](ConvertTo-Csv.md)

[Export-Clixml](Export-Clixml.md)

[Import-Clixml](Import-Clixml.md)

[ConvertFrom-Clixml](ConvertFrom-Clixml.md)
