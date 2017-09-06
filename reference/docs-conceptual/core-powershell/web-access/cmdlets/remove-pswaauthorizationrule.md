---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  remove pswaauthorizationrule
ms.technology:  powershell
---

# Remove-PswaAuthorizationRule

## SYNOPSIS

Removes a specified authorization rule from Windows PowerShell® Web
Access.

## SYNTAX

### Id
```
Remove-PswaAuthorizationRule [-Id] <Int32[]> [-Force] [-Confirm] [-WhatIf] [ <CommonParameters>]
```

### Rule
```
Remove-PswaAuthorizationRule [-Rule] <PswaAuthorizationRule[]> [-Force] [-Confirm] [-WhatIf] [ <CommonParameters>]
```

## DESCRIPTION

Removes a specified authorization rule from Windows PowerShell Web
Access.

## PARAMETERS

### -Force

Runs the cmdlet without prompting for confirmation. By default the
cmdlet asks for confirmation before proceeding.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -Id &lt;Int32\[\]&gt;

Specifies the identifiers (IDs) of one or more rules to remove.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue, ByPropertyName)       |
| Accept Wildcard Characters?          | false                                |

### -Rule &lt;PswaAuthorizationRule\[\]&gt;

Specifies the rules to remove.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue)                       |
| Accept Wildcard Characters?          | false                                |

### -Confirm

Prompts you for confirmation before running the cmdlet.

|||  
|-|-|
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | false                                |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

|||  
|-|-|
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | false                                |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters:
-Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable.
For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/p/?LinkID=113216).

## INPUTS

### int\[\]

This cmdlet accepts either an array of integers
or an array of PswaAuthorizationRule objects.

### PswaAuthorizationRule\[\]

This cmdlet accepts either an array of integers
or an array of PswaAuthorizationRule objects.

## OUTPUTS

This cmdlet produces no output.

## EXAMPLES

### EXAMPLE 1

This example removes the authorization rule with an ID of *2*.

```
Remove-PswaAuthorizationRule –Id 2
```

### EXAMPLE 2 {#example-2 .subHeading}

This example removes all authorization rules and also requires
confirmation by the user.

```
Get-PswaAuthorizationRule | Remove-PswaAuthorizationRule -Confirm
```

## Related topics

- [Add-PswaAuthorizationRule](add-pswaauthorizationrule.md)
- [Get-PswaAuthorizationRule](get-pswaauthorizationrule.md)
- [Install-PswaWebApplication](install-pswawebapplication.md)
- [Test-PswaAuthorizationRule](test-pswaauthorizationrule.md)
