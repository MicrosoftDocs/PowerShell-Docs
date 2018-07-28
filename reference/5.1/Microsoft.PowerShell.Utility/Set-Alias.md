---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821857
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Set-Alias
---

# Set-Alias

## SYNOPSIS
Creates or changes an alias for a cmdlet or other command element in the current Windows PowerShell session.

## SYNTAX

```
Set-Alias [-Name] <String> [-Value] <String> [-Description <String>] [-Option <ScopedItemOptions>] [-PassThru]
 [-Scope <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-Alias** cmdlet creates or changes an alias (alternate name) for a cmdlet or for a command element, such as a function, a script, a file, or other executable.
You can also use **Set-Alias** to reassign a current alias to a new command, or to change any of the properties of an alias, such as its description.
Unless you add the alias to the Windows PowerShell profile, the changes to an alias are lost when you exit the session or close Windows PowerShell.

## EXAMPLES

### Example 1: Create an alias for a Get-ChildItem
```
PS C:\> Set-Alias -Name list -Value get-childitem
```

This command creates the alias **list** for the Get-ChildItem cmdlet.
After you create the alias, you can use **list** in place of **Get-ChildItem** at the command line and in scripts.

### Example 2: Create an alias and omit parameter names
```
PS C:\> Set-Alias list get-location
```

This command associates the alias **list** with the Get-Location cmdlet.
If **list** is an alias for another cmdlet, this command changes its association so that it now is the alias only for **Get-Location**.

This command uses the same format as the command in the previous example, but it omits the optional parameter names, *Name* and *Value*.
When you omit parameter names, the values of those parameters must appear in the specified order in the command.
In this case, the value of *Name* (**list**) must be the first parameter and the value of *Value* (get-location) must be the second parameter.

### Example 3: Make an alias read-only
```
PS C:\> Set-Alias scrub Remove-Item -Option ReadOnly -Passthru | Format-List
```

This command associates the alias **scrub** with the **Remove-Item** cmdlet.
It uses the ReadOnly option to prevent the alias from being deleted or assigned to another cmdlet.

The *PassThru* parameter directs Windows PowerShell to pass an object that represents the new alias through the pipeline to the Format-List cmdlet.
If the *PassThru* parameter were omitted, there would be no output from this cmdlet to display (in a list or otherwise).

### Example 4: Create an alias for Notepad.exe
```
PS C:\> Set-Alias np c:\windows\notepad.exe
```

This command associates the alias, **np**, with the executable file for Notepad.
After the command completes, to open Notepad from the Windows PowerShell command line, just type `np`.

This example demonstrates that you can create aliases for executable files and elements other than cmdlets.

To make the command more generic, you can use the Windir environment variable (${env:windir}) to represent the C\Windows directory.
The generic version of the command is `Set-Alias np ${env:windir}\notepad.exe`.

### Example 5: Create an alias for a command with parameters
```
PS C:\> function CD32 {set-location c:\windows\system32}
PS C:\> Set-Alias go cd32
```

These commands show how to assign an alias to a command with parameters, or even to a pipeline of many commands.

You can create an alias for a cmdlet, but you cannot create an alias for a command that consists of a cmdlet and its parameters.
However, if you place the command in a function or a script, then you can create a useful function or script name and you can create one or more aliases for the function or script.

In this example, the user wants to create an alias for the command `Set-Location C:\windows\system32`, where **Set-Location** is a cmdlet and C:\Windows\System32 is the value of the *Path* parameter.

To do this, the first command creates a function called CD32 that contains the Set-Location command.

The second command creates the alias **go** for the CD32 function.
Then, to run the **Set-Location** command, the user can type either `CD32` or `go`.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

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

### -Description
Specifies a description of the alias.
You can type any string.
If the description includes spaces, enclose it quotation marks.

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
Indicates that the cmdlet will set a read-only alias.
Use the *Option* parameter to create a read-only alias.
The *Force* parameter cannot set a constant alias.

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

### -Name
Specifies the new alias.
You can use any alphanumeric characters in an alias, but the first character cannot be a number.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option
Sets the value of the Options property of the alias.
The acceptable values for this parameter are:

- None.
Sets no options.
(None is the default.)
- ReadOnly.
Can be deleted.
Cannot be not changed, except by using the Force parameter.
- Constant.
Cannot be deleted or changed.
- Private.
The alias is available only in the current scope.
- AllScope.
The alias is copied to any new scopes that are created.
- Unspecified.

To see the Options property of all aliases in the session, type `get-alias | format-table -property name, options -autosize`.

```yaml
Type: ScopedItemOptions
Parameter Sets: (All)
Aliases:
Accepted values: None, ReadOnly, Constant, Private, AllScope, Unspecified

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
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

### -Scope
Specifies the scope in which this alias is valid.
The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).

Local is the default.
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

### -Value
Specifies the name of the cmdlet or command element that is being aliased.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.AliasInfo
When you use the *PassThru* parameter, **Set-Alias** generates a **System.Management.Automation.AliasInfo** object representing the alias.
Otherwise, this cmdlet does not generate any output.

## NOTES
* An alias is an alternate name or nickname for a cmdlet or command element. To run the cmdlet, you can use its full name or any valid alias. For more information, see about_Aliases.
* To create a new alias, use **Set-Alias** or New-Alias. To delete an alias, use Remove-Item.
* A cmdlet can have multiple aliases, but an alias can only be associated with one cmdlet at a time. If you use **Set-Alias** to associate the alias with a different cmdlet, it is no longer associated with the original cmdlet.
* You can create an alias for a cmdlet, but you cannot create an alias for a command with parameters and values. For example, you can create an alias for **Set-Location**, but you cannot create an alias for `Set-Location C:\Windows\System32`. To create an alias for a command, create a function that includes the command, and then create an alias to the function.
* To save the aliases from a session and use them in a different session, add the **Set-Alias** command to your Windows PowerShell profile. Profiles do not exist by default. To create a profile in the path stored in the $profile variable, type `New-Item -Type file -Force $profile`. To see the value of the $profile variable, type `$profile`.
* You can also save your aliases by using Export-Alias to copy the aliases from the session to a file, and then use Import-Alias to add them to the alias list for a new session.
* You can also refer to **Set-Alias** by its built-in alias, **sal**. For more information, see about_Aliases.

## RELATED LINKS

[Export-Alias](Export-Alias.md)

[Get-Alias](Get-Alias.md)

[Import-Alias](Import-Alias.md)

[New-Alias](New-Alias.md)