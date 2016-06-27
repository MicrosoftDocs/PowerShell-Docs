---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294023
schema: 2.0.0
---

# Update-FormatData
## SYNOPSIS
Updates the formatting data in the current session.

## SYNTAX

```
Update-FormatData [[-AppendPath] <String[]>] [-PrependPath <String[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Update-FormatData cmdlet reloads the formatting data from formatting files into the current session.
This cmdlet lets you update the formatting data without restarting Windows PowerShell.

Without parameters, Update-FormatData reloads the formatting files that it loaded previously.
You can use the parameters of Update-FormatData to add new formatting files to the session.

Formatting files are text files in XML format with the format.ps1xml file name extension.
The formatting data in the files defines the display of Microsoft .NET Framework objects in the session.

When Windows PowerShell starts, it loads the format data from the formatting files in the Windows PowerShell installation directory ($pshome) into the session.
You can use Update-FormatData to reload the formatting data into the current session without restarting Windows PowerShell.
This is useful when you have added or changed a formatting file, but do not want to interrupt the session.

For more information about formatting files in Windows PowerShell, see about_Format.ps1xml.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>update-formatdata
```

This command reloads the formatting files that it loaded previously.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>update-formatdata -appendpath trace.format.ps1xml, log.format.ps1xml
```

This command reloads the formatting files into the session, including two new files, Trace.format.ps1xml and Log.format.ps1xml.

Because the command uses the AppendPath parameter, the formatting data in the new files is loaded after the formatting data from the built-in files.

The AppendPath parameter is used because the new files contain formatting data for objects that are not referenced in the built-in files.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>update-formatdata -prependPath c:\test\NewFiles.format.ps1xml

# Edit the NewFiles.format.ps1 file.

PS C:\>update-formatdata
```

This example shows how to reload a formatting file after you have edited it.

The first command adds the NewFiles.format.ps1xml file to the session.
It uses the PrependPath parameter because the file contains formatting data for objects that are referenced in the built-in files.

After adding the NewFiles.format.ps1xml file and testing it in these session, the author edits the file.

The second command uses the Update-FormatData cmdlet to reload the formatting files.
Because the NewFiles.format.ps1xml file was previously loaded, Update-FormatData automatically reloads it without using parameters.

## PARAMETERS

### -AppendPath
Adds the specified formatting files to the session.
The files are loaded after Windows PowerShell loads the built-in formatting files.

When formatting .NET objects, Windows PowerShell uses the first formatting definition that it finds for each .NET type.
If you use the AppendPath parameter, Windows PowerShell searches the data from the built-in files before it encounters the formatting data that you are adding.

Use this parameter to add a file that formats a .NET object that is not referenced in the built-in formatting files.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSPath, Path

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InformationAction
When formatting .NET objects, Windows PowerShell uses the first formatting definition that it finds for each .NET type.
If you use the AppendPath parameter, Windows PowerShell searches the data from the built-in files before it encounters the formatting data that you are adding.

Use this parameter to add a file that formats a .NET object that is not referenced in the built-in formatting files.

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
When formatting .NET objects, Windows PowerShell uses the first formatting definition that it finds for each .NET type.
If you use the AppendPath parameter, Windows PowerShell searches the data from the built-in files before it encounters the formatting data that you are adding.

Use this parameter to add a file that formats a .NET object that is not referenced in the built-in formatting files.

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

### -PrependPath
Adds the specified formatting files to the session.
The files are loaded before Windows PowerShell loads the built-in formatting files.

When formatting .NET objects, Windows PowerShell uses the first formatting definition that it finds for each .NET type.
If you use the PrependPath parameter, Windows PowerShell searches the data from the files that you are adding before it encounters the formatting data from the built-in files.

Use this parameter to add a file that formats a .NET object that is also referenced in the built-in formatting files.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
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

### System.String
You can pipe a string that contains the append path to Update-FormatData.

## OUTPUTS

### None
The cmdlet does not return any output.

## NOTES
Update-FormatData also updates the formatting data for commands in the session that were imported from modules.
If the formatting file for a module changes, you can run an Update-FormatData command to update the formatting data for imported commands.
You do not need to import the module again.

## RELATED LINKS

