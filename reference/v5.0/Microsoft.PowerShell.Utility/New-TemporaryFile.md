---
external help file: PSITPro5_Utility.xml
online version: 998c8863-3794-42a8-8971-a5cadef72772
schema: 2.0.0
---

# New-TemporaryFile
## SYNOPSIS
Creates a temporary file.

## SYNTAX

```
New-TemporaryFile [-Confirm] [-WhatIf]
```

## DESCRIPTION
The New-TemporaryFile cmdlet creates an empty file that has the .tmp file name extension.
This cmdlet names the file tmpNNNN.tmp, where NNNN is a random hexadecimal number.
The cmdlet creates the file in your $Env:Temp folder.

This cmdlet creates temporary files that you can use in scripts.

## EXAMPLES

### Example 1: Create a temporary file
```
PS C:\>$TempFile = New-TemporaryFile
```

This command generates a .tmp file in your temporary folder, and then stores a reference to the file in the $TempFile variable.
You can use this file later in your script.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

## OUTPUTS

### System.IO.FileInfo
This cmdlet returns a FileInfo object that represents the temporary file.

## NOTES

## RELATED LINKS

[about_Environment_Variables](998c8863-3794-42a8-8971-a5cadef72772)

