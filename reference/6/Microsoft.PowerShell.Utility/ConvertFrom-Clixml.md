---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertFrom-Clixml
---

# ConvertFrom-Clixml

## SYNOPSIS
Converts an CLIXML string into new corresponding object in Windows PowerShell.

## SYNTAX

```
ConvertFrom-Clixml -InputObject <string> [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
The **ConvertFrom-CliXml** cmdlet converts a CLIXML string with data that represents Microsoft .NET Framework objects and creates the objects in Windows PowerShell.

A valuable use of **ConvertFrom-CliXml** is to deserialize credentials and secure strings that have been serialized as secure XML by running the ConvertTo-Clixml cmdlet.
For an example of how to do this, see Example 2.

## EXAMPLES

### Example 1: Import a serialized file and recreate an object

```powershell
$clixml = Get-Process | ConvertTo-Clixml
$Processes = ConvertFrom-Clixml $clixml
```

This command uses the ConvertTo-Clixml cmdlet to create a serialized copy of the process information returned by Get-Process.
It then uses **ConvertFrom-Clixml** to retrieve the contents of the serialized string and re-create an object that is stored in the $Processes variable.

### Example 2: Convert an encrypted credential object

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

### -InputObject
Specifies the CLIXML string to be converted to objects.
You can also pipe the CLIXML string to **ConvertFrom-Clixml**.

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -First
Gets only the specified number of objects.
Enter the number of objects to get.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Skip
Ignores the specified number of objects and then gets the remaining objects.
Enter the number of objects to skip.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTotalCount
Reports the total number of objects in the data set (an integer) followed by the selected objects.
If the cmdlet cannot determine the total count, it displays "Unknown total count." The integer has an Accuracy property that indicates the reliability of the total count value.
The value of Accuracy ranges from 0.0 to 1.0 where 0.0 means that the cmdlet could not count the objects, 1.0 means that the count is exact, and a value between 0.0 and 1.0 indicates an increasingly reliable estimate.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String
You can pipe a string that contains a path to **ConvertFrom-Clixml**.

## OUTPUTS

### PSObject
**ConvertFrom-Clixml** returns objects that have been deserialized from the stored XML files.

## NOTES
* When specifying multiple values for a parameter, use commas to separate the values. For example, "\<parameter-name\> \<value1\>, \<value2\>".

*

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems](http://blogs.technet.com/b/heyscriptingguy/archive/2011/06/05/use-powershell-to-pass-credentials-to-legacy-systems.aspx)

[Securely Store Credentials on Disk](http://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[Export-Clixml](Export-Clixml.md)

[Import-Clixml](Import-Clixml.md)

[ConvertTo-Clixml](ConvertTo-Clixml.md)