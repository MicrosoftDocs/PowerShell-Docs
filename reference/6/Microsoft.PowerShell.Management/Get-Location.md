---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821589
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Location
---

# Get-Location

## SYNOPSIS
Gets information about the current working location or a location stack.

## SYNTAX

### Location (Default)
```
Get-Location [-PSProvider <String[]>] [-PSDrive <String[]>] [-UseTransaction] [<CommonParameters>]
```

### Stack
```
Get-Location [-Stack] [-StackName <String[]>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Location** cmdlet gets an object that represents the current directory, much like the print working directory (pwd) command.

When you move between Windows PowerShell drives, Windows PowerShell retains your location in each drive.
You can use this cmdlet to find your location in each drive.

You can use this cmdlet to get the current directory at run time and use it in functions and scripts, such as in a function that displays the current directory in the Windows PowerShell prompt.

You can also use this cmdlet to display the locations in a location stack.
For more information, see the Notes and the descriptions of the *Stack* and *StackName* parameters.

## EXAMPLES

### Example 1: Display your current drive location
```
PS C:\> Get-Location
Path
----
C:\WINDOWS
```

This command displays your location in the current Windows PowerShell drive.

For instance, if you are in the Windows directory of the C: drive, it displays the path to that directory.

### Example 2: Display your current location for different drives
```
The first command uses the **Set-Location** cmdlet to set the current location to the Windows subdirectory of the C: drive.
PS C:\> Set-Location C:\Windows

The second command uses the **Set-Location** cmdlet to change the location to the HKLM:\Software\Microsoft registry key. When you change to a location in the HKLM: drive, Windows PowerShell retains your location in the C: drive.
PS C:\>
PS C:\WINDOWS> Set-Location HKLM:\Software\Microsoft
PS HKLM:\Software\Microsoft>

The third command uses the **Set-Location** cmdlet to change the location to the HKCU:\Control Panel\Input Method registry key.
PS C:\>
PS HKLM:\Software\Microsoft> Set-Location "HKCU:\Control Panel\Input Method"
PS HKCU:\Control Panel\Input Method>

The fourth command uses the **Get-Location** cmdlet to find the current location on the C: drive. It uses the *PSDrive* parameter to specify the drive.
PS C:\>
PS HKCU:\Control Panel\Input Method> Get-Location -PSDrive C



Path
----
C:\WINDOWS


The fifth command uses the **Set-Location** cmdlet to return to the C: drive. Even though the command does not specify a subdirectory, Windows PowerShell returns you to the saved location.
PS C:\>
PS HKCU:\Control Panel\Input Method> Set-Location C:
PS C:\WINDOWS>

The sixth command uses the **Get-Location** cmdlet to find the current location in the drives supported by the Windows PowerShell registry provider. **Get-Location** returns the location of the most recently accessed registry drive, HKCU.
PS C:\>
PS C:\WINDOWS> Get-Location -PSProvider registry




Path
----
HKCU:\Control Panel\Input Method


To see the current location in the HKLM: drive, you need to use the *PSDrive* parameter to specify the drive. The seventh command does just this:
PS C:\>
PS C:\WINDOWS> Get-Location -PSDrive HKLM



Path
----
HKLM:\Software\Microsoft
```

This example demonstrates the use of **Get-Location** to display your current location in different Windows PowerShell drives.

### Example 3:
```
The first command sets the current location to the Windows directory on the C: drive.
PS C:\> Set-Location C:\Windows

The second command uses the **Push-Location** cmdlet to push the current location (C:\Windows) onto the current location stack and change to the System32 subdirectory. Because no stack is specified, the current location is pushed onto the current location stack. By default, the current location stack is the unnamed default location stack.
PS C:\>
C:\WINDOWS>Push-Location System32

The third command uses the *StackName* parameter of the **Push-Location** cmdlet to push the current location (C:\Windows\System32) onto the Stack2 stack and to change the current location to the WindowsPowerShell subirectory. If the Stack2 stack does not exist, **Push-Location** creates it.
PS C:\>
C:\Windows\System32>Push-Location WindowsPowerShell -StackName Stack2

The fourth command uses the *Stack* parameter of the **Get-Location** cmdlet to get the locations in the current location stack. By default, the current stack is the unnamed default location stack.
PS C:\>
C:\WINDOWS\system32\WindowsPowerShell>Get-Location -Stack



Path
----
C:\WINDOWS


The fifth command uses the *StackName* parameter of the **Get-Location** cmdlet to get the locations in the Stack2 stack.
PS C:\>
C:\WINDOWS\system32\WindowsPowerShell>get-location -stackname Stack2



Path
----
C:\WINDOWS\system32
```

This example shows how to use the *Stack* and *StackName* parameters of **Get-Location** to list the locations in the current location stack and alternate location stacks.
For more information about location stacks, see the Notes.

### Example 4: Customize the Windows PowerShell prompt
```
PS C:\>
function prompt { 'PowerShell: ' + (get-location) + '> '}
PowerShell: C:\WINDOWS>
```

This example shows how to customize the Windows PowerShell prompt.
The function that defines the prompt includes a **Get-Location** command, which is run whenever the prompt appears in the console.

The format of the default Windows PowerShell prompt is defined by a special function named prompt.
You can change the prompt in your console by creating a new function named prompt.

To see the current prompt function, type the following command: `Get-Content Function:prompt`

The command begins with the function keyword followed by the function name, prompt.
The function body appears within braces ( {} ).

This command defines a new prompt that begins with the string PowerShell: .
To append the current location, it uses a **Get-Location** command, which runs when the prompt function is called.
The prompt ends with the string "\> ".

## PARAMETERS

### -PSDrive
Specifies the current location in the specified Windows PowerShell drive that this cmdlet gets in the operation.

For instance, if you are in the Certificate: drive, you can use this parameter to find your current location in the C: drive.

```yaml
Type: String[]
Parameter Sets: Location
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Specifies the current location in the drive supported by the Windows PowerShell provider that this cmdlet gets in the operation.

If the specified provider supports more than one drive, this cmdlet returns the location on the most recently accessed drive.

For example, if you are in the C: drive, you can use this parameter to find your current location in the drives of the Windows PowerShellRegistry provider.

```yaml
Type: String[]
Parameter Sets: Location
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Stack
Indicates that this cmdlet displays the locations in the current location stack.

To display the locations in a different location stack, use the *StackName* parameter.
For information about location stacks, see the Notes.

```yaml
Type: SwitchParameter
Parameter Sets: Stack
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StackName
Specifies, as a string array, the named location stacks.
Enter one or more location stack names.

To display the locations in the current location stack, use the *Stack* parameter.
To make a location stack the current location stack, use the Set-Location parameter.
For information about location stacks, see the Notes.

This cmdlet cannot display the locations in the unnamed default stack unless it is the current stack.

```yaml
Type: String[]
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

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PathInfo or System.Management.Automation.PathInfoStack
If you use the *Stack* or *StackName* parameters, this cmdlet returns a **StackInfo** object.
Otherwise, it returns a **PathInfo** object.

## NOTES
* This cmdlet is designed to work with the data exposed by any provider. To list the providers in your session, type `Get-PSProvider`. For more information, see about_Providers.

  The ways that the *PSProvider*, *PSDrive*, *Stack*, and *StackName* parameters interact depends on the provider.
Some combinations will result in errors, such as specifying both a drive and a provider that does not expose that drive.
If no parameters are specified, this cmdlet returns the **PathInfo** object for the provider that contains the current working location.

  A stack is a last-in, first-out list in which only the most recently added item is accessible.
You add items to a stack in the order that you use them, and then retrieve them for use in the reverse order.
Windows PowerShell lets you store provider locations in location stacks.
Windows PowerShell creates an unnamed default location stack and you can create multiple named location stacks.
If you do not specify a stack name, Windows PowerShell uses the current location stack.
By default, the unnamed default location is the current location stack, but you can use the **Set-Location** cmdlet to change the current location stack.

  To manage location stacks, use the Windows PowerShellLocation cmdlets, as follows.

  - To add a location to a location stack, use the Push-Location cmdlet.

  - To get a location from a location stack, use the Pop-Location cmdlet.

  - To display the locations in the current location stack, use the *Stack* parameter of the **Get-Location** cmdlet.
To display the locations in a named location stack, use the *StackName* parameter of the **Get-Location** cmdlet.

  - To create a new location stack, use the *StackName* parameter of the **Push-Location** cmdlet.
If you specify a stack that does not exist, **Push-Location** creates the stack.

  - To make a location stack the current location stack, use the *StackName* parameter of the **Set-Location** cmdlet.

  The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you cannot no longer use the **Push-Location** or **Pop-Location** add or get items from the default stack or use this cmdlet command to display the locations in the unnamed stack.
To make the unnamed stack the current stack, use the *StackName* parameter of the **Set-Location** cmdlet with a value of $null or an empty string ("").

*

## RELATED LINKS

[Pop-Location](Pop-Location.md)

[Push-Location](Push-Location.md)

[Set-Location](Set-Location.md)

