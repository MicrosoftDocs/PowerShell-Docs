---
external help file: PSITPro3_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkID=113289
schema: 2.0.0
---

# Convert-Path
## SYNOPSIS
Converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Convert-Path [-Path] <String[]> [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Convert-Path -LiteralPath <String[]> [-UseTransaction]
```

## DESCRIPTION
The Convert-Path cmdlet converts a path from a Windows PowerShell path to a Windows PowerShell provider path.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>convert-path .
```

This command converts the current working directory, which is represented by a dot (.), to a standard file system path.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>convert-path HKLM:\software\microsoft
```

This command converts the Windows PowerShell provider path to a standard registry path.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>convert-path ~
C:\Users\User01
```

This command converts the path to the home directory of the current provider, which is the FileSystem provider, to a string.

## PARAMETERS

### -LiteralPath
Specifies the path to be converted.
The value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the Windows PowerShell path to be converted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see

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
You can pipe a path (but not a literal path) to Convert-Path.

## OUTPUTS

### System.String
Convert-Path returns a string that contains the converted path.

## NOTES
The cmdlets that contain the Path noun (the Path cmdlets) manipulate path names and return the names in a concise format that all Windows PowerShell providers can interpret.
They are designed for use in programs and scripts where you want to display all or part of a path name in a particular format.
Use them like you would use Dirname, Normpath, Realpath, Join, or other path manipulators.

You can use the path cmdlets with several providers, including the FileSystem, Registry, and Certificate providers.

The Convert-Path cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type "Get-PSProvider".
For more information, see about_Providers.

## RELATED LINKS

[Join-Path](742e18e1-55c8-44ce-9c05-526bc22bf1f5)

[Resolve-Path](f84dd2a9-2961-400b-8b0a-45551b886172)

[Split-Path](844e6307-86cc-4d08-a82f-991414d582e9)

[Test-Path](2e9df935-45e8-44ba-a66a-2de2dd61f3f5)

[about_Providers](55e2974f-3314-48d2-8b1b-abdea6b303cb)

