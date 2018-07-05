---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821809
schema: 2.0.0
title: Get-Variable
---

# Get-Variable

## SYNOPSIS
Gets the variables in the current console.

## SYNTAX

```
Get-Variable [[-Name] <String[]>] [-ValueOnly] [-Include <String[]>] [-Exclude <String[]>] [-Scope <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-Variable** cmdlet gets the Windows PowerShell variables in the current console.
You can retrieve just the values of the variables by specifying the *ValueOnly* parameter, and you can filter the variables returned by name.

## EXAMPLES

### Example 1: Get variables by letter
```
PS C:\> Get-Variable m*
```

This command gets variables with names that begin with the letter m.
The command also gets the value of the variables.

### Example 2: Get variable values by letter
```
PS C:\> Get-Variable m* -ValueOnly
```

This command gets only the values of the variables that have names that begin with m.

### Example 3: Get variables by two letters
```
PS C:\> Get-Variable -Include M*,P*
```

This command gets information about the variables that begin with either the letter M or the letter P.

### Example 4: Get variables by scope
```
PS C:\> Get-Variable -Scope 0
PS C:\> Compare-Object (Get-Variable -Scope 0) (Get-Variable -Scope 1)
```

The first command gets only the variables that are defined in the local scope.
It is equivalent to `Get-Variable -Scope Local` and can be abbreviated as `gv -s 0`.

The second command uses the Compare-Object cmdlet to find the variables that are defined in the parent scope (Scope 1) but are visible only in the local scope (Scope 0).

## PARAMETERS

### -Exclude
Specifies an array of items that this cmdlet excludes from the operation.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Specifies an array of items upon which the cmdlet will act, excluding all others.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the variable.
Wildcards are permitted.
You can also pipe a variable name to **Get-Variable**.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope
Specifies the variables in the scope.The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent)

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

### -ValueOnly
Indicates that this cmdlet gets only the value of the variable.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains the variable name to **Get-Variable**.

## OUTPUTS

### System.Management.Automation.PSVariable
This cmdlet returns a **System.Management.AutomationPSVariable** object for each variable that it gets.
The object type depends on the variable.

## NOTES
* This cmdlet does not manage environment variables. To manage environment variables, you can use the environment variable provider.

*

## RELATED LINKS

[Clear-Variable](Clear-Variable.md)

[New-Variable](New-Variable.md)

[Remove-Variable](Remove-Variable.md)

[Set-Variable](Set-Variable.md)