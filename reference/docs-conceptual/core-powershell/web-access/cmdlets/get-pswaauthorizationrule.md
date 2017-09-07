---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  get pswaauthorizationrule
ms.technology:  powershell
---
# Get-PswaAuthorizationRule

## SYNOPSIS

Returns a set of the Windows PowerShell® Web Access authorization rules.

## Syntax

### ID
```
Get-PswaAuthorizationRule [[-Id] <Int32[]> ] [ <CommonParameters>]
```

### Name
```
Get-PswaAuthorizationRule [-RuleName] <String[]> [ <CommonParameters>]
```

## DESCRIPTION

The **Get-PswaAuthorizationRule** cmdlet returns a set of the Windows
PowerShell® Web Access authorization rules.
If neither the **Id** parameter nor the **RuleName** parameter is
specified, then this cmdlet lists all rules. The **Id** parameter can be
used to filter the results.

## PARAMETERS

### -Id&lt;Int32\[\]&gt;

Specifies the identifiers (IDs) of the rules that this cmdlet should
get. If no IDs are specified, then this cmdlet returns all authorization
rules.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue, ByPropertyName)       |
| Accept Wildcard Characters?          | false                                |

### -RuleName&lt;String\[\]&gt;

Specifies the names of authorization rules to retrieve. This parameter
returns any rules that exactly match the rule names of the strings in
this array.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue, ByPropertyName)       |
| Accept Wildcard Characters?          | false                                |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters:
-Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable.
For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/p/?LinkID=113216).

## INPUTS

### int\[\]

This cmdlet accepts an array of integers or an array of string values as input.

### String\[\]

This cmdlet accepts an array of integers or an array of string values as input.

## OUTPUTS

### Microsoft.Management.PowerShellWebAccess.PswaAuthorizationRule\[\]

This cmdlet produces a PswaAuthorizationRule object as output.


## EXAMPLES

### EXAMPLE 1

This example gets all of the rules.

```PowerShell
    PS C:\> Get-PswaAuthorizationRule
```

### EXAMPLE 2

This example gets a rule with an ID of *2*.

```PowerShell
    PS C:\> Get-PswaAuthorizationRule –Id 2
```

### EXAMPLE 3 {#example-3 .subHeading}

This example illustrates how the cmdlet accepts a value from pipeline.
A rule id and a rule name are passed in this cmdlet.

```PowerShell
    PS C:\> "rule1",0 | Get-PswaAuthorizationRule
```

## Related topics

- [Add-PswaAuthorizationRule](add-pswaauthorizationrule.md)
- [Remove-PswaAuthorizationRule](remove-pswaauthorizationrule.md)
- [Test-PswaAuthorizationRule](test-pswaauthorizationrule.md)
- [Install-PswaWebApplication](install-pswawebapplication.md)
