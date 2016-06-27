---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293955
schema: 2.0.0
---

# Export-Alias
## SYNOPSIS
Exports information about currently defined aliases to a file.

## SYNTAX

### ByPath (Default)
```
Export-Alias [-Path] <String> [[-Name] <String[]>] [-PassThru] [-As <ExportAliasFormat>] [-Append] [-Force]
 [-NoClobber] [-Description <String>] [-Scope <String>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### ByLiteralPath
```
Export-Alias -LiteralPath <String> [[-Name] <String[]>] [-PassThru] [-As <ExportAliasFormat>] [-Append]
 [-Force] [-NoClobber] [-Description <String>] [-Scope <String>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Export-Alias cmdlet exports the aliases in the current session to a file. 
If the output file does not exist, the cmdlet will create it.

Export-Alias can export the aliases in a particular scope or all scopes, it can generate the data in CSV format or as a series of Set-Alias commands that you can add to a session or to a Windows PowerShell profile.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>export-alias -path alias.csv
```

Description

-----------

This command exports current alias information to a file named Alias.csv in the current directory.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>export-alias -path alias.csv -noclobber
```

Description

-----------

This command exports the aliases in the current session to an Alias.csv file.

Because the NoClobber parameter is specified, the command will fail if an Alias.csv file already exists in the current directory.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>export-alias -path alias.csv -append -description "Appended Aliases" -force
```

Description

-----------

This command appends the aliases in the current session to the Alias.csv file.

The command uses the Description parameter to add a description to the comments at the top of the file.

The command also uses the Force parameter to overwrite any existing Alias.csv files, even if they have the read-only attribute.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>export-alias -path alias.ps1 -as script
PS C:\> add-content -path $profile -value (get-content alias.ps1)
PS C:\> $s = new-pssession -computername Server01
PS C:\> invoke-command -session $s -filepath .\alias.ps1
```

Description

-----------

This example shows how to use the script file format that Export-Alias generates.

The first command exports the aliases in the session to the Alias.ps1 file.
It uses the As parameter with a value of Script to generate a file that contains a Set-Alias command for each alias.

The second command adds the aliases in the Alias.ps1 file to the CurrentUser-CurrentHost profile.
(The path to the profile is saved in the $profile variable.) The command uses the Get-Content cmdlet to get the aliases from the Alias.ps1 file and the Add-Content cmdlet to add them to the profile.
For more information, see about_Profiles.

The third and fourth commands add the aliases in the Alias.ps1 file to a  remote session on the Server01 computer.
The third command uses the New-PSSession cmdlet to create the session.
The fourth command uses the FilePath parameter of the Invoke-Command cmdlet to run the Alias.ps1 file in the new session.

## PARAMETERS

### -Append
Appends the output to the specified file, rather than overwriting the existing contents of that file.

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

### -As
Determines the output format.
CSV is the default.

Valid values are:

-- CSV: Comma-separated value (CSV) format.
-- Script: Creates a Set-Alias command for each exported alias. If you name the output file with a .ps1 file name extension, you can run it as a script to add the aliases to any session.

```yaml
Type: ExportAliasFormat
Parameter Sets: (All)
Aliases: 
Accepted values: Csv, Script

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Adds a description to the exported file.
The description appears as a comment at the top of the file, following the header information.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overwrites the output file, even if the read-only attribute is set on the file.

By default, Export-Alias overwrites files without warning, unless the read-only or hidden attribute is set or the NoClobber parameter is used in the command.
The NoClobber parameter takes precedence over the Force parameter when both are used in a command.

The Force parameter cannot force Export-Alias to overwrite files with the hidden attribute.

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

### -LiteralPath
Specifies the path to the output file.
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the names of the aliases to export.
Wildcards are permitted.

By default, Export-Alias exports all aliases in the session or scope.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoClobber
Prevents Export-Alias from overwriting any files, even if the Force parameter is used in the command.

If the NoClobber parameter is omitted, Export-Alias will overwrite an existing file without warning, unless the read-only attribute is set on the file.
NoClobber takes precedence over the Force parameter, which permits Export-Alias to overwrite a file with the read-only attribute.

NoClobber does not prevent the Append parameter from adding content to an existing file.

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

### -PassThru
Returns objects that represent the aliases that were exported.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path to the output file.
Wildcards are permitted, but the resulting path value must resolve to a single file name.
This parameter is required.

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

### -Scope
Specifies the scope from which the aliases should be exported.

Valid values are "Global", "Local", or "Script", or a number relative to the current scope (0 through the number of scopes where 0 is the current scope and 1 is its parent).
"Local" is the default.
For more information, see about_Scopes.

```yaml
Type: String
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

### None.
You cannot pipe objects to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.AliasInfo
When you use the Passthru parameter, Export-Alias returns a System.Management.Automation.AliasInfo object that represents the alias.
Otherwise, this cmdlet does not generate any output.

## NOTES
You can only Export-Aliases to a file.

## RELATED LINKS

[Get-Alias]()

[Import-Alias]()

[New-Alias]()

[Set-Alias]()

