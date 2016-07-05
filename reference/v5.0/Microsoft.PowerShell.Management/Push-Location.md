---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293892
schema: 2.0.0
---

# Push-Location
## SYNOPSIS
Adds the current location to the top of a location stack.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Push-Location [[-Path] <String>] [-PassThru] [-StackName <String>] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Push-Location [-LiteralPath <String>] [-PassThru] [-StackName <String>] [-UseTransaction]
```

## DESCRIPTION
The Push-Location cmdlet adds, or pushes, the current location onto a location stack.
If you specify a path, this cmdlet pushes the current location onto a location stack and then changes the current location to the location specified by the path.
You can use the Pop-Location cmdlet to get locations from the location stack.

By default, Push-Location pushes the current location onto the current location stack, but you can use the StackName parameter to specify another location stack.
If the stack does not exist, Push-Location creates it.

For more information about location stacks, see the Notes.

## EXAMPLES

### Example 1: Change location
```
PS C:\>Push-Location -Path "C:\Windows"
```

This command pushes the current location onto the default location stack and then changes the location to C:\Windows.

### Example 2: Change location in a named stack
```
PS C:\>Push-Location -Path "HKLM:\Software\Policies" -StackName RegFunction
```

This command pushes the current location onto the RegFunction stack and changes the current location to the HKLM:\Software\Policies location.
You can use the Location cmdlets in any Windows PowerShell drive (PSDrive).

### Example 3: Push the current location onto the default stack
```
PS C:\>Push-Location
```

This command pushes the current location onto the default stack.
It does not change the location.

### Example 4: Create and use a named stack
```
PS C:\>Push-Location ~ -StackName "Stack2"
PS C:\Users\User01> Pop-Location -StackName "Stack2"
PS C:\>
```

These commands show how to create and use a named location stack.

The first command pushes the current location onto a new stack named Stack2, and then changes the current location to the root directory (%USERPROFILE%), which is represented in the command by the tilde symbol (~) or $home.
If Stack2 does not already occur in the session, Push-Location creates it.

The second command uses Pop-Location to pop the original location (PS C:\\\>) from the Stack2 stack.
Without StackName, Pop-Location would pop the location from the unnamed default stack.

## PARAMETERS

### -LiteralPath
Specifies the path of the new location.
Unlike the Path parameter, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Passes an object that represents the location to the pipeline.
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
Specifies the path of the new location.
This cmdlet your location to the location specified by this path after it adds, or pushes, the current location onto the top of the stack.
Enter a path of any location whose provider supports this cmdlet.
Wildcard characters are permitted.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -StackName
Specifies the location stack to which the current location is added.
Enter a location stack name.
If the stack does not exist, Push-Location creates it.

Without this parameter, Push-Location adds the location to the current location stack.
By default, the current location stack is the unnamed default location stack that Windows PowerShell creates.
To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet. 
For more information about location stacks, see the Notes.

Push-Location cannot add a location to the unnamed default stack unless it is the current location stack.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.PathInfo
This cmdlet generates a System.Management.Automation.PathInfo object that represents the location, if you specify the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* A stack is a last-in, first-out list in which only the most recently added item can be accessed. You add items to a stack in the order that you use them, and then retrieve them for use in the reverse order. Windows PowerShell lets you store provider locations in location stacks.
* Windows PowerShell creates an unnamed default location stack and you can create multiple named location stacks. If you do not specify a stack name, Windows PowerShell uses the current location stack. By default, the unnamed default location is the current location stack, but you can use Set-Location to change the current location stack.
* To manage location stacks, use the Windows PowerShellLocation cmdlets, as follows: 

- To add a location to a location stack, use the Push-Location cmdlet. 
- To get a location from a location stack, use the Pop-Location cmdlet. 
- To display the locations in the current location stack, use the Stack parameter of the Get-Location cmdlet. 
- To display the locations in a named location stack, use the StackName parameter of the Get-Location cmdlet. 
- To create a new location stack, use the StackName parameter of the Push-Location cmdlet. If you specify a stack that does not exist, Push-Location creates the stack. 
- To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet.
* The unnamed default location stack is fully available only when it is the current location stack. If you make a named location stack the current location stack, you can no longer use Push-Location or Pop-Location cmdlets add or get items from the default stack or use a Get-Location command to display the locations in the unnamed stack. To make the unnamed stack the current stack, use the StackName parameter of Set-Location with a value of $Null or an empty string ("").
* You can also refer to Push-Location by its built-in alias, pushd. For more information, see about_Aliases.
* Push-Location is designed to work with the data exposed by any provider. To list the providers available in your session, type Get-PSProvider. For more information, see about_Providers.

## RELATED LINKS

[Get-Location](b4c8d674-ba23-4bdf-8322-1f08acdc0ca9)

[Pop-Location](c36cf84e-1380-4964-b986-01b4cc1489a5)

[Set-Location](d7f353cd-ebd7-462a-bd57-1498dc8b88a6)

[about_Providers](55e2974f-3314-48d2-8b1b-abdea6b303cb)

