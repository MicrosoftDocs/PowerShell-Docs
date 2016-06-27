---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293956
schema: 2.0.0
---

# Export-Clixml
## SYNOPSIS
Creates an XML-based representation of an object or objects and stores it in a file.

## SYNTAX

### ByPath (Default)
```
Export-Clixml [-Depth <Int32>] [-Path] <String> -InputObject <PSObject> [-Force] [-NoClobber]
 [-Encoding <String>] [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf]
 [-Confirm]
```

### ByLiteralPath
```
Export-Clixml [-Depth <Int32>] -LiteralPath <String> -InputObject <PSObject> [-Force] [-NoClobber]
 [-Encoding <String>] [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf]
 [-Confirm]
```

## DESCRIPTION
The Export-CliXml cmdlet creates an XML-based representation of an object or objects and stores it in a file.
You can then use the Import-CliXml cmdlet to re-create the saved object based on the contents of that file.

This cmdlet is similar to ConvertTo-XML, except that Export-CliXml stores the resulting XML in a file.
ConvertTo-XML returns the XML, so you can continue to process it in Windows PowerShell.

A valuable use of Export-CliXml is to export credentials and secure strings securely as XML.
For an example of how to do this, see Example 3 in this topic.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>"This is a test" | export-clixml sample.xml
```

This command creates an XML file that stores a representation of the string, "This is a test".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-acl C:\test.txt | export-clixml -Path fileacl.xml
PS C:\>$fileacl = import-clixml fileacl.xml
```

This example shows how to export an object to an XML file and then create an object by importing the XML from the file.

The first command uses the Get-ACL cmdlet to get the security descriptor of the Test.txt file.
It uses a pipeline operator to pass the security descriptor to Export-Clixml, which stores an XML-based representation of the object in a file named FileACL.xml.

The second command uses the Import-Clixml cmdlet to create an object from the XML in the FileACL.xml file.
Then, it saves the object in the $FileAcl variable.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
PS C:\>$credential | Export-CliXml $credPath
PS C:\>$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
PS C:\>$credential = Import-CliXml $credxmlpath
```

The Export-CliXml cmdlet encrypts credential objects by using the Windows Data Protection API.
This ensures that only your user account can decrypt the contents of the credential object.

In this example, given a credential that you've stored in the $credential variable by running the Get-Credential cmdlet, you can run the Export-CliXml cmdlet to save the credential to disk.In the example, the file in which the credential is stored is represented by TestScript.ps1.credential.
Replace TestScript with the name of the script with which you are loading the credential.

In the second command, pipe the credential object to Export-CliXml, and save it to the path, $credxmlpath, that you specified in the first command.

To import the credential automatically into your script, run the final two commands.
This time, you are running Import-CliXml to import the secured credential object into your script.
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
Valid values are ASCII, UTF8, UTF7, UTF32, Unicode, BigEndianUnicode, Default, and OEM.
Unicode is the default.

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

### -InformationAction
The default value can be overridden for the object type in the Types.ps1xml files.
For more information, see about_Types.ps1xml.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
The default value can be overridden for the object type in the Types.ps1xml files.
For more information, see about_Types.ps1xml.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the object to be converted.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe objects to Export-Clixml.

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
Ensures that the cmdlet does not overwrite the contents of an existing file.
By default, if a file exists in the specified path, Export-Clixml overwrites the file without warning.

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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to the file where the XML representation of the object will be stored.
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
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

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Export-Clixml.

## OUTPUTS

### System.IO.FileInfo
Export-Clixml creates a file that contains the XML.

## NOTES

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems]()

[Securely Store Credentials on Disk]()

[ConvertTo-Html]()

[ConvertTo-Xml]()

[Export-Csv]()

[Import-Clixml]()

