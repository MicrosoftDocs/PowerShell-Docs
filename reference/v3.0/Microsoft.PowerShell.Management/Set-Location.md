---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Set Location
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113397
schema:  2.0.0
---


# Set-Location
## SYNOPSIS
Sets the current working location to a specified location.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-Location [[-Path] <String>] [-PassThru] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Set-Location [-PassThru] [-UseTransaction] -LiteralPath <String>
```

### UNNAMED_PARAMETER_SET_3
```
Set-Location [-PassThru] [-StackName <String>] [-UseTransaction]
```

## DESCRIPTION
The Set-Location cmdlet sets the working location to a specified location.
That location could be a directory, a sub-directory, a registry location, or any provider path.

You can also use the StackName parameter of the Set-Location cmdlet to make a named location stack the current location stack.
For more information about location stacks, see the Notes.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>set-location HKLM:
PS HKLM:\>
```

This command sets the current location to the root of the HKLM: drive.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>set-location env: -passthru

Path
----
Env:\
PS Env:\>
```

This command sets the current location to the root of the Env: drive.
It uses the Passthru parameter to direct Windows PowerShell to return a PathInfo (System.Management.Automation.PathInfo) object that represents the Env: location.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>set-location C:
```

This command sets the current location C: drive in the file system provider.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>set-location -stackName WSManPaths
```

This command makes the WSManPaths location stack the current location stack.

The location cmdlets use the current location stack unless a different location stack is specified in the command.
For information about location stacks, see the Notes.

## PARAMETERS

### -LiteralPath
Specifies a path to the location.
The value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns a System.Management.Automation.PathInfo object that represents the location.
By default, this cmdlet does not generate any output.

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

### -Path
This parameter is used to specify the path to a new working location.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -StackName
Makes the specified location stack the current location stack.
Enter a location stack name.
To indicate the unnamed default location stack, type "$null" or an empty string ("").

The Location cmdlets act on the current stack unless you use the StackName parameter to specify a different stack.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter can only be used when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains a path (but not a literal path) to Set-Location.

## OUTPUTS

### None, System.Management.Automation.PathInfo, System.Management.Automation.PathInfoStack
When you use the PassThru parameter, Set-Location generates a System.Management.Automation.PathInfo object that represents the location.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The Set-Location cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get-PSProvider". For more information, see about_Providers.

  A "stack" is a last-in, first-out list in which only the most recently added item is accessible.
You add items to a stack in the order that you use them, and then retrieve them for use in the reverse order. 
Windows PowerShell lets you store provider locations in location stacks.
Windows PowerShell creates an unnamed default location stack and you can create multiple named location stacks.
If you do not specify a stack name, Windows PowerShell uses the current location stack.
By default, the unnamed default location is the current location stack, but you can use the Set-Location cmdlet to change the current location stack.

  To manage location stacks, use the Windows PowerShell Location cmdlets, as follows.

  - To add a location to a location stack, use the Push-Location cmdlet.

  - To get a location from a location stack, use the Pop-Location cmdlet.

  - To display the locations in the current location stack, use the Stack parameter of the Get-Location cmdlet.
To display the locations in a named location stack, use the StackName parameter of the Get-Location cmdlet.

  - To create a new location stack, use the StackName parameter of the Push-Location cmdlet.
If you specify a stack that does not exist, Push-Location creates the stack.

  - To make a location stack the current location stack, use the StackName parameter of the Set-Location cmdlet.

  The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you cannot no longer use Push-Location or Pop-Location cmdlets add or get items from the default stack or use Get-Location command to display the locations in the unnamed stack.
To make the unnamed stack the current stack, use the StackName parameter of the Set-Location cmdlet with a value of $null or an empty string ("").

*

## RELATED LINKS

[Get-Location](Get-Location.md)

[Pop-Location](Pop-Location.md)

[Push-Location](Push-Location.md)

[about_Providers](../About/about_Providers.md)

