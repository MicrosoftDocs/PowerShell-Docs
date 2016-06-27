---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293979
schema: 2.0.0
---

# Get-Variable
## SYNOPSIS
Gets the variables in the current console.

## SYNTAX

```
Get-Variable [[-Name] <String[]>] [-ValueOnly] [-Include <String[]>] [-Exclude <String[]>] [-Scope <String>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-Variable cmdlet gets the Windows PowerShell variables in the current console.
You can retrieve just the values of the variables by specifying the ValueOnly parameter, and you can filter the variables returned by name.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-Variable m*
```

This command gets variables with names that begin with the letter "m".
The command also gets the value of the variables.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-Variable m* -Valueonly
```

This command gets only the values of the variables that have names that begin with "m".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Get-Variable -Include M*,P*
```

This command gets information about the variables that begin with either the letter "M" or the letter "P".

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>Get-Variable -Scope 0
PS C:\>Compare-Object (Get-Variable -Scope 0) (Get-Variable -Scope 1)
```

The first command gets only the variables that are defined in the local scope.
It is equivalent to "Get-Variable -Scope Local" and can be abbreviated as "gv -s 0".

The second command uses the Compare-Object cmdlet to find the variables that are defined in the parent scope (Scope 1) but are visible only in the local scope (Scope 0).

## PARAMETERS

### -Exclude
Omits the specified items.
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
Specifies only the items upon which the cmdlet will act, excluding all others.
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

### -Name
Specifies the name of the variable.
Wildcards are permitted.
You can also pipe a variable name to Get-Variable.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope
Gets only the variables in the specified scope.
Valid values are "Global", "Local", or "Script", or a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
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

### -ValueOnly
Gets only the value of the variable.

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

## INPUTS

### System.String
You can pipe a string that contains the variable name to Get-Variable.

## OUTPUTS

### System.Management.Automation.PSVariable
Get-Variable returns a System.Management.Automation variable object for each variable that it gets.
The object type depends on the variable.

## NOTES
This cmdlet does not manage environment variables.
To manage environment variables, you can use the environment variable provider.

## RELATED LINKS

[Clear-Variable]()

[New-Variable]()

[Remove-Variable]()

[Set-Variable]()

