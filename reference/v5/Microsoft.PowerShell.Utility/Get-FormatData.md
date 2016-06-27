---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293969
schema: 2.0.0
---

# Get-FormatData
## SYNOPSIS
Gets the formatting data in the current session.

## SYNTAX

```
Get-FormatData [[-TypeName] <String[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-FormatData cmdlet gets the formatting data in the current session.

The formatting data in the session includes formatting data from Format.ps1xml formatting files (such as those in the $pshome directory), formatting data for modules that you import into the session, and formatting data for commands that you import into your session by using the Import-PSSession cmdlet.

You can use this cmdlet to examine the formatting data.
Then, you can use the Export-FormatData cmdlet to serialize the objects (convert them to XML) and save them in Format.ps1xml files.

For more information about formatting files in Windows PowerShell, see about_Format.ps1xml.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-formatdata
```

This command gets all the formatting data in the session.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-formatdata -typename Microsoft.Wsman*
```

This command gets the formatting data items whose names begin with "Microsoft.Wsman".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$f = get-formatdata -typename helpinfoshort
PS C:\>$f

TypeName        FormatViewDefinition
--------        --------------------
HelpInfoShort   {help , TableControl}

PS C:\>$f.FormatViewDefinition[0].control

Headers                                                                    Rows
-------                                                                    ----
{System.Management.Automation.TableControlColumnHeader, System.Manageme... {System.Management.Automation.TableControlRow}

PS C:\>$f.FormatViewDefinition[0].control.headers

Label         Alignment      Width
-----         ---------      -----
Name          Left           33
Category      Left           9
Undefined      0
```

This example shows how to get a formatting data object and examine its properties.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>$a = get-formatdata
PS C:\>import-module bitstransfer
PS C:\>$b = get-formatdata
PS C:\>compare-object $a $b

InputObject                                                SideIndicator
-----------                                                -------------
Microsoft.BackgroundIntelligentTransfer.Management.BitsJob =>

PS C:\>get-formatdata *bits* | export-formatdata -filepath c:\test\bits.format.ps1xml
PS C:\>get-content c:\test\bits.format.ps1xml

<?xml version="1.0" encoding="utf-8"?><Configuration><ViewDefinitions>
<View><Name>Microsoft.BackgroundIntelligentTransfer.Management.BitsJob</Name>
...
```

This example shows how to use Get-FormatData and Export-FormatData to export the formatting data that is added by a module.

The first four commands use the Get-FormatData, Import-Module, and Compare-Object cmdlets to identify the format type that the BitsTransfer module adds to the session.

The fifth command uses the Get-FormatData cmdlet to get the format type that the BitsTransfer module adds.
It uses a pipeline operator (|) to send the format type object to the Export-FormatData cmdlet, which converts it back to XML and saves it in the specified format.ps1xml file.

The final command shows an excerpt of the format.ps1xml file content.

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

### -TypeName
Gets only the formatting data with the specified type names.
Enter the type names.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.ExtendedTypeDefinition

## NOTES

## RELATED LINKS

[Export-FormatData]()

[Update-FormatData]()

