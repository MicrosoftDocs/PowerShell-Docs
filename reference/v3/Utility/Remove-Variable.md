---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Remove-Variable
## SYNOPSIS
Deletes a variable and its value.

## SYNTAX

```
Remove-Variable [-Name] <String[]> [-Exclude <String[]>] [-Force] [-Include <String[]>] [-Scope <String>]
 [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-Variable cmdlet deletes a variable and its value from the scope in which it is defined, such as the current session.
You cannot use this cmdlet to delete variables that are set as constants or those that are owned by the system.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>remove-variable Smp
```

This command deletes the $Smp variable.

## PARAMETERS

### -Exclude
Omits the specified items.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: True
```

### -Force
Allows the cmdlet to remove a variable even if it is read-only.
Even using the Force parameter, the cmdlet cannot remove a constant.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: false
Accept wildcard characters: False
```

### -Include
Deletes only the specified items.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: True
```

### -Name
Specifies the name of the variable to be removed.
The parameter name \("Name"\) is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies the scope in which this alias is valid.
Valid values are "Global", "Local", or "Script", or a number relative to the current scope \(0 through the number of scopes, where 0 is the current scope and 1 is its parent\).
"Local" is the default.
For more information, see about_Scopes.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Local
Accept pipeline input: false
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSVariable
You can pipe a variable object to Remove-Variable.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
Changes affect only the current scope, such as a session.
To delete a variable from all sessions, add a Remove-Variable command to your Windows PowerShell profile.

You can also refer to RemoveVariable by its built-in alias, "rv".
For more information, see about_Aliases.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113380)

[Clear-Variable](e8e9af2f-e5c9-4ab8-8518-b305b1c4494a)

[Get-Variable](385002f8-2406-42f9-843b-9cb16aec927f)

[New-Variable](5c7c621f-c086-4286-8f9b-86cadecb8c0b)

[Set-Variable](a961f6e3-12d2-4210-a039-62f502623a8c)

[about_Profiles](c555334d-3000-4fc4-a076-1486c3ed27ec)


