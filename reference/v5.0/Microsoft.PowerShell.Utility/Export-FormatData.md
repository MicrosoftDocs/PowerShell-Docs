---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293958
schema: 2.0.0
---

# Export-FormatData
## SYNOPSIS
Saves formatting data from the current session in a formatting file.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Export-FormatData [-Force] [-IncludeScriptBlock] [-NoClobber] -InputObject <ExtendedTypeDefinition[]>
 -Path <String>
```

### UNNAMED_PARAMETER_SET_2
```
Export-FormatData [-Force] [-IncludeScriptBlock] [-NoClobber] -InputObject <ExtendedTypeDefinition[]>
 -LiteralPath <String>
```

## DESCRIPTION
The Export-FormatData cmdlet creates Windows PowerShell formatting files (format.ps1xml) from the formatting objects in the current session.
It takes the ExtendedTypeDefinition objects that Get-FormatData returns and saves them in a file in XML format.

Windows PowerShell uses the data in formatting files (format.ps1xml) to generate the default display of Microsoft .NET Framework objects in the session.
You can view and edit the formatting files and use the Update-FormatData cmdlet to add the formatting data to a session.

For more information about formatting files in Windows PowerShell, see about_Format.ps1xml.

## EXAMPLES

### Example 1: Export session format data
```
PS C:\>Get-FormatData -TypeName "*" | Export-FormatData -Path "allformat.ps1xml" -IncludeScriptBlock
```

This command exports all of the format data in the session to the AllFormat.ps1xml file.

The command uses the Get-FormatData cmdlet to get the format data in the session.
A value of * (all) for the TypeName parameter directs the cmdlet to get all of the data in the session.

The command uses a pipeline operator (|) to send the format data from the Get-FormatData command to the Export-FormatData cmdlet, which exports the format data to the AllFormat.ps1 file.

The Export-FormatData command uses the IncludeScriptBlock parameter to include script blocks in the format data in the file.

### Example 2: Export format data for a type
```
PS C:\>$F = Get-FormatData -TypeName "helpinfoshort"
PS C:\> Export-FormatData -InputObject $F -Path "c:\test\help.format.ps1xml" -IncludeScriptBlock
```

These commands export the format data for the HelpInfoShort type to the Help.format.ps1xml file.

The first command uses the Get-FormatData cmdlet to get the format data for the HelpInfoShort type, and it saves it in the $F variable.

The second command uses the InputObject parameter of the Export-FormatData cmdlet to enter the format data saved in the $F variable.
It also uses the IncludeScriptBlock parameter to include script blocks in the output.

### Example 3: Export format data without a script block
```
PS C:\>Get-FormatData -TypeName "System.Diagnostics.Process" | Export-FormatData -Path process.format.ps1xml
PS C:\> Update-FormatData -PrependPath ".\process.format.ps1xml"
PS C:\> Get-Process p*
Handles  NPM(K)  PM(K)  WS(K) VM(M)   CPU(s)    Id ProcessName
-------  ------  -----  ----- -----   ------    -- -----------
323                                       5600 powershell
336                                       3900 powershell_ise
138                                       4076 PresentationFontCache
```

This example shows the effect of omitting the IncludeScriptBlock parameter from an Export-FormatData command.

The first command uses the Get-FormatData cmdlet to get the format data for the System.Diagnostics.Process object that the Get-Process cmdlet returns.
The command uses a pipeline operator (|) to send the formatting data to the Export-FormatData cmdlet, which exports it to the Process.format.ps1xml file in the current directory.

In this case, the Export-FormatData command does not use the IncludeScriptBlock parameter.

The second command uses the Update-FormatData cmdlet to add the Process.format.ps1xml file to the current session.
The command uses the PrependPath parameter to ensure that the formatting data for process objects in the Process.format.ps1xml file is found before the standard formatting data for process objects.

The third command shows the effects of this change.
The command uses the Get-Process cmdlet to get processes that have names that begin with P.
The output shows that property values that are calculated by using script blocks are missing from the display.

## PARAMETERS

### -Force
Overwrites an existing output file, even if the file has the read-only attribute.

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

### -IncludeScriptBlock
Determines whether script blocks in the format data are exported.

Because script blocks contain code and can be used maliciously, they are not exported by default.

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
Specifies the format data objects to be exported.
Enter a variable that contains the objects or a command that gets the objects, such as a Get-FormatData command.
You can also pipe the objects from Get-FormatData to Export-FormatData.

```yaml
Type: ExtendedTypeDefinition[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoClobber
Prevents the cmdlet from overwriting existing files.
By default, Export-FormatData overwrites files without warning unless the file has the read-only attribute.

To direct Export-FormatData to overwrite read-only files, use the Force parameter.

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
Specifies a location for the output file.
Enter a path (optional) and file name with a format.ps1xml file name extension.
If you omit the path, Export-FormatData creates the file in the current directory.

If you use a file name extension other than .ps1xml, the Update-FormatData cmdlet will not recognize the file.

If you specify an existing file, Export-FormatData overwrites the file without warning, unless the file has the read-only attribute.
To overwrite a read-only file, use the Force parameter.
To prevent files from being overwritten, use the NoClobber parameter.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: FilePath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies a location for the output file.
Unlike the Path parameter, the value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.ExtendedTypeDefinition
You can pipe ExtendedTypeDefinition objects from Get-FormatData to Export-FormatData.

## OUTPUTS

### None
Export-FormatData does not return any objects.
It generates a file and saves it in the specified path.

## NOTES
* To use any formatting file, including an exported formatting file, the execution policy for the session must allow scripts and configuration files to run. For more information, see about_Execution_Policies.

*

## RELATED LINKS

[Get-FormatData](1644b550-d90b-4c96-9e6a-659bb924969d)

[Get-Process](b30db241-c0f6-40d3-ab3b-ab86342b36c1)

[Update-FormatData](166535eb-9cdd-4269-b612-f936f6740b79)

