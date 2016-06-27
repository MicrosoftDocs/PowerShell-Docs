---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293982
schema: 2.0.0
---

# Import-Clixml
## SYNOPSIS
Imports a CLIXML file and creates corresponding objects within Windows PowerShell.

## SYNTAX

### ByPath (Default)
```
Import-Clixml [-Path] <String[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>]
```

### ByLiteralPath
```
Import-Clixml -LiteralPath <String[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>]
```

## DESCRIPTION
The Import-CliXml cmdlet imports a CLIXML file with data that represents Microsoft .NET Framework objects and creates the objects in Windows PowerShell.

A valuable use of Import-CliXml is to import credentials and secure strings that have been exported as secure XML by running the Export-CliXml cmdlet.
For an example of how to do this, see Example 2 in this topic.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-process | export-clixml pi.xml
PS C:\>$processes = import-clixml pi.xml
```

This command uses the Export-Clixml cmdlet to save a serialized copy of the process information returned by Get-Process.
It then uses Import-Clixml to retrieve the contents of the serialized file and re-create an object that is stored in the $processes variable.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
PS C:\>$credential | Export-CliXml $credxmlpath PS C:\>$credxmlpath = Join-Path (Split-Path $profile) TestScript.ps1.credential
PS C:\>$credential = Import-CliXml $credxmlpath
```

The Export-CliXml cmdlet encrypts credential objects by using the Windows Data Protection API.
This ensures that only your user account can decrypt the contents of the credential object.

In this example, given a credential that you've stored in the $credential variable by running the Get-Credential cmdlet, you can run the Export-CliXml cmdlet to save the credential to disk.In the example, the file in which the credential is stored is represented by TestScript.ps1.credential.
Replace TestScript with the name of the script with which you are loading the credential.

In the second command, you pipe the credential object to Export-CliXml, and save it to the path, $credxmlpath, that you specified in the first command.

To import the credential automatically into your script, run the final two commands.
This time, you are running Import-CliXml to import the secured credential object into your script.
This eliminates the risk of exposing plain-text passwords in your script.

## PARAMETERS

### -InformationAction
@{Text=}

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
@{Text=}

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
Unlike Path, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

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

## INPUTS

### System.String
You can pipe a string that contains a path to Import-Clixml.

## OUTPUTS

### PSObject
Import-Clixml returns objects that have been deserialized from the stored XML files.

## NOTES
When specifying multiple values for a parameter, use commas to separate the values.
For example, "\<parameter-name\> \<value1\>, \<value2\>".

## RELATED LINKS

[Use PowerShell to Pass Credentials to Legacy Systems]()

[Securely Store Credentials on Disk]()

[Export-CliXml]()

