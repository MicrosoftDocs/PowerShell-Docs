---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  test pswaauthorizationrule
ms.technology:  powershell
---

# Test-PswaAuthorizationRule

## SYNOPSIS

Verifies whether a rule exists for a specified user, computer, or
endpoint.

## SYNTAX

### ComputerName
```
Test-PswaAuthorizationRule [-UserName] <String> [-ComputerName] <String> [[-ConfigurationName] <String> ] [-Credential <PSCredential> ] [-Rule <PswaAuthorizationRule[]> ] [ <CommonParameters>]
```

### ConnectionUri
```
Test-PswaAuthorizationRule [-UserName] <String> [-ConnectionUri] <Uri> [[-ConfigurationName] <String> ] [-Credential <PSCredential> ] [-Rule <PswaAuthorizationRule[]> ] [ <CommonParameters>]
```

## DESCRIPTION

The **Test-PswaAuthorizationRule** cmdlet verifies whether a rule exists
for a specified user, computer, or endpoint.
This cmdlet can also be used to test authorization rules,
to validate that a particular user, computer or endpoint access request
is authorized.
By default, this cmdlet evaluates all rules in the authorization file.
However, you can specify a subset of rules to test.

You can use this cmdlet to help troubleshoot authentication failures.

The parameters for this cmdlet correspond to fields on the Windows
PowerShell® Web Access sign-on page.

## PARAMETERS

### -ComputerName &lt;String&gt;

Specifies the name of the computer to test.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -ConfigurationName &lt;String&gt;

Specifies the name of the Windows PowerShell session configuration, also
known as endpoint or runspace, to test.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | 3                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -ConnectionUri &lt;Uri&gt;

Specifies the connection URI to test.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 2                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -Credential &lt;PSCredential&gt;

Specifies a **PSCredential** object for a user account that you want to
use to test Windows PowerShell Web Access authorization rules. If you do
not add this parameter, the cmdlet uses the currently logged-on user
account. To get a **PSCredential** object, which is required to test
authorization rules remotely, run the
[Get-Credential](http://go.microsoft.com/fwlink/?LinkID=293936) cmdlet.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -Rule &lt;PswaAuthorizationRule\[\]&gt;

Specifies a subset of rules to test. If this parameter is not specified,
then this cmdlet tests against all authorization rules.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | True (ByValue)                       |
| Accept Wildcard Characters?          | false                                |

### -UserName &lt;String&gt;

Specifies the name of the user to test.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | true                                 |
| Position?                            | 1                                    |
| Default Value                        | none                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters:
-Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable.
For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/p/?LinkID=113216).

## INPUTS

### Microsoft.Management.PowerShellWebAccess.PswaAuthorizationRule\[\]

This cmdlet accepts an array of PswaAuthorizationRule objects as input.

## OUTPUTS

### Microsoft.Management.PowerShellWebAccess.PswaAuthorizationRule\[\]

This cmdlet produces an array of PswaAuthorizationRule objects as output.

## EXAMPLES

### EXAMPLE 1

This example tests all authorization rules in order to display all the
rules that allow the user *contoso\\mhanson* to connect to the computer
*srv2* and use a Windows PowerShell session configuration named *test*.

```
Test-PswaAuthorizationRule -ComputerName srv2.contoso.com -UserName contoso\mhanson -ConfigurationName test
```

### EXAMPLE 2

This example tests all authorization rules to check which authorization
rules apply to the user *contoso\\mhanson*.

```
Test-PswaAuthorizationRule -UserName contoso\mhanson -ComputerName *
```

## Related topics

- [Add-PswaAuthorizationRule](add-pswaauthorizationrule.md)
- [Get-PswaAuthorizationRule](get-pswaauthorizationrule.md)
- [Install-PswaWebApplication](install-pswawebapplication.md)
- [Remove-PswaAuthorizationRule](remove-pswaauthorizationrule.md)
