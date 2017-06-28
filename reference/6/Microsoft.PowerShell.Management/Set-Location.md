---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821632
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Set-Location
---

# Set-Location

## SYNOPSIS
Sets the current working location to a specified location.

## SYNTAX

### Path (Default)
```
Set-Location [[-Path] <String>] [-PassThru] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath
```
Set-Location -LiteralPath <String> [-PassThru] [-UseTransaction] [<CommonParameters>]
```

### Stack
```
Set-Location [-PassThru] [-StackName <String>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The **Set-Location** cmdlet sets the working location to a specified location.
That location could be a directory, a sub-directory, a registry location, or any provider path.

You can also use the *StackName* parameter of to make a named location stack the current location stack.
For more information about location stacks, see the Notes.

## EXAMPLES

### Example 1: Set the current location
```
PS C:\> Set-Location -Path "HKLM:"
PS HKLM:\>
```

This command sets the current location to the root of the HKLM: drive.

### Example 2: Set the current location and display that location
```
PS C:\> Set-Location -Path "Env:" -PassThru

Path
----
Env:\
PS Env:\>
```

This command sets the current location to the root of the Env: drive.
It uses the *PassThru* parameter to direct Windows PowerShell to return a **PathInfo** object that represents the Env: location.

### Example 3: Set location to the C: drive
```
PS C:\> Set-Location C:
```

This command sets the current location C: drive in the file system provider.

### Example 4: Set the current location to a named stack
```
PS C:\> Set-Location -StackName "WSManPaths"
```

This command makes the WSManPaths location stack the current location stack.

The location cmdlets use the current location stack unless a different location stack is specified in the command.
For information about location stacks, see the Notes.

## PARAMETERS

### -LiteralPath
Specifies a path of the location.
The value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns a **System.Management.Automation.PathInfo** object that represents the location.
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
Specify the path of a new working location.

```yaml
Type: String
Parameter Sets: Path
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -StackName
Specifies the location stack name that this cmdlet makes the current location stack.
Enter a location stack name.
To indicate the unnamed default location stack, type $Null" or an empty string ("").

The **Location** cmdlets act on the current stack unless you use the *StackName* parameter to specify a different stack.

```yaml
Type: String
Parameter Sets: Stack
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
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.PathInfo, System.Management.Automation.PathInfoStack
This cmdlet generates a **System.Management.Automation.PathInfo** object that represents the location, if you specify the *PassThru* parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The **Set-Location** cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PSProvider`. For more information, see about_Providers.

  A stack is a last-in, first-out list in which only the most recently added item can be accessed.
You add items to a stack in the order that you use them, and then retrieve them for use in the reverse order.
Windows PowerShell lets you store provider locations in location stacks.
Windows PowerShell creates an unnamed default location stack.
You can create multiple named location stacks.
If you do not specify a stack name, Windows PowerShell uses the current location stack.
By default, the unnamed default location is the current location stack, but you can use the **Set-Location** cmdlet to change the current location stack.

  To manage location stacks, use the Windows PowerShell Location cmdlets, as follows: 

- To add a location to a location stack, use the Push-Location cmdlet.
- To get a location from a location stack, use the Pop-Location cmdlet.
- To display the locations in the current location stack, use the *Stack* parameter of the Get-Location cmdlet.
To display the locations in a named location stack, use the *StackName* parameter of **Get-Location**.
- To create a new location stack, use the *StackName* parameter of **Push-Location**.
If you specify a stack that does not exist, **Push-Location** creates the stack.
- To make a location stack the current location stack, use the *StackName* parameter of **Set-Location**.

  The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you cannot no longer use **Push-Location** or **Pop-Location** cmdlets add or get items from the default stack or use **Get-Location** to display the locations in the unnamed stack.
To make the unnamed stack the current stack, use the *StackName* parameter of **Set-Location** with a value of $Null or an empty string ("").

*

## RELATED LINKS

[Get-Location](Get-Location.md)

[Pop-Location](Pop-Location.md)

[Push-Location](Push-Location.md)

