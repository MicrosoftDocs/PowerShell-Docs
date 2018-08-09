---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821813
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Import-Clixml
---

# Import-Clixml

## SYNOPSIS
Imports a CLIXML file and creates corresponding objects in PowerShell.

## SYNTAX

### ByPath (Default)
```
Import-Clixml [-Path] <String[]> [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

### ByLiteralPath
```
Import-Clixml -LiteralPath <String[]> [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
The **Import-CliXml** cmdlet imports a CLIXML file with data that represents Microsoft .NET Framework objects and creates the objects in PowerShell.

A valuable use of **Import-CliXml** is to import credentials and secure strings that have been exported as secure XML by running the Export-Clixml cmdlet.
For an example of how to do this, see Example 2.

## EXAMPLES

### Example 1: Import a serialized file and recreate an object

```powershell
Get-Process | Export-Clixml pi.xml
$Processes = Import-Clixml pi.xml
```

This command uses the Export-Clixml cmdlet to save a serialized copy of the process information returned by Get-Process.
It then uses **Import-Clixml** to retrieve the contents of the serialized file and re-create an object that is stored in the $Processes variable.

### Example 2: Import a secure credential object

```powershell
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential | Export-CliXml $Credxmlpath
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential = Import-CliXml $Credxmlpath
```

The **Export-CliXml** cmdlet encrypts credential objects by using the Windows Data Protection APIhttp://msdn.microsoft.com/library/windows/apps/xaml/hh464970.aspx.
This ensures that only your user account can decrypt the contents of the credential object.

In this example, given a credential that you've stored in the $Credential variable by running the Get-Credential cmdlet, you can run the **Export-CliXml** cmdlet to save the credential to disk.

In the example, the file in which the credential is stored is represented by TestScript.ps1.credential.
Replace TestScript with the name of the script with which you are loading the credential.

In the second command, you pipe the credential object to **Export-CliXml**, and save it to the path, $Credxmlpath, that you specified in the first command.

To import the credential automatically into your script, run the final two commands.
This time, you are running Import-Clixml to import the secured credential object into your script.
This eliminates the risk of exposing plain-text passwords in your script.

## PARAMETERS

### -Path
Specifies the XML files.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath
Specifies the XML files.
Unlike *Path*, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
You can pipe a string that contains a path to **Import-Clixml**.

## OUTPUTS

### PSObject
**Import-Clixml** returns objects that have been deserialized from the stored XML files.

## NOTES
* When specifying multiple values for a parameter, use commas to separate the values. For example, "\<parameter-name\> \<value1\>, \<value2\>".

*

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems](http://blogs.technet.com/b/heyscriptingguy/archive/2011/06/05/use-powershell-to-pass-credentials-to-legacy-systems.aspx)

[Securely Store Credentials on Disk](http://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[ConvertTo-Clixml](ConvertTo-Clixml.md)

[ConvertFrom-Clixml](ConvertFrom-Clixml.md)

[Export-Clixml](Export-Clixml.md)