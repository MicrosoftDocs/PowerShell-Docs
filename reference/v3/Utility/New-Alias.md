---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# New-Alias
## SYNOPSIS
Creates a new alias.

## SYNTAX

```
New-Alias [-Name] <String> [-Value] <String> [-Description <String>] [-Force] [-Option <ScopedItemOptions>]
 [-PassThru] [-Scope <String>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The New-Alias cmdlet creates a new alias in the current Windows PowerShell session.
Aliases created by using New-Alias are not saved after you exit the session or close Windows PowerShell.
You can use the Export-Alias cmdlet to save your alias information to a file.
You can later use Import-Alias to retrieve that saved alias information.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>new-alias list get-childitem
```

This command creates an alias named "list" to represent the Get-ChildItem cmdlet.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>new-alias -name w -value get-wmiobject -description "quick wmi alias" -option ReadOnly
PS C:\>get-alias -name w | format-list *
```

This command creates an alias named "w" to represent the Get-WMIObject cmdlet.
It creates a description, "quick wmi alias", for the alias and makes it read only.
The last line of the command uses Get-Alias to get the new alias and pipes it to Format-List to display all of the information about it.

## PARAMETERS

### -Description
Specifies a description of the alias.
You can type any string.
If the description includes spaces, enclose it in quotation marks.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -Force
If set, act like set-alias if the alias named already exists.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: false
Accept wildcard characters: False
```

### -Name
Specifies the new alias.
You can use any alphanumeric characters in an alias, but the first character cannot be a number.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: False
```

### -Option
Sets the value of the Options property of the alias.

Valid values are:

-- None: Sets no options. \("None" is the default.\)
-- ReadOnly: Can be deleted. Cannot be not changed, except by using the Force parameter.
-- Constant: Cannot be deleted or changed.
-- Private: The alias is available only in the current scope.
-- AllScope: The alias is copied to any new scopes that are created.

To see the Options property of all aliases in the session, type "get-alias | format-table -property name, options -autosize".

```yaml
Type: ScopedItemOptions
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: "None"
Accept pipeline input: false
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the new alias.
By default, this cmdlet does not generate any output.

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

### -Scope
Specifies the scope of the new alias.
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

### -Value
Specifies the name of the cmdlet or command element that is being aliased.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: true (ByPropertyName)
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

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.AliasInfo
When you use the Passthru parameter, New-Alias generates a System.Management.Automation.AliasInfo object representing the new alias.
Otherwise, this cmdlet does not generate any output.

## NOTES
To create a new alias, use Set-Alias or New-Alias.
To change an alias, use Set-Alias.
To delete an alias, use Remove-Item.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113352)

[Export-Alias](f2ebfdac-0af9-4bf1-bef9-2b612381f3e6)

[Get-Alias](c5703118-f617-4535-afc3-e6e64f333856)

[Import-Alias](c4368ff1-c02a-47aa-b5c0-80503a20b4da)

[Set-Alias](b77236fb-e34f-4ac9-b8f7-9682dcb08593)


