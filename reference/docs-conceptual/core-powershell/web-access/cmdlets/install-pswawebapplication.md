---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  install pswawebapplication
ms.technology:  powershell
---

# Install-PswaWebApplication

## SYNOPSIS

Configures the Windows PowerShell® Web Access web application in IIS.

## SYNTAX

### Default
```
Install-PswaWebApplication [[-WebApplicationName] <String> ] [-UseTestCertificate] [-WebSiteName <String> ] [-Confirm] [-WhatIf] [ <CommonParameters>]
```

## DESCRIPTION

The **Install-PswaWebApplication** cmdlet configures Windows PowerShell
Web Access web application. This cmdlet installs the web application,
associates it with a web site, and optionally creates a test SSL
certificate using the **useTestCertificate** parameter. For security
reasons web administrators should not use a test certificate for
production environments.

## PARAMETERS

### -UseTestCertificate

Specifies that a test certificate is created. If this parameter is set
to true, then this cmdlet creates a test certificate and configures the
Windows PowerShell Web Access web application to use the certificate for
HTTPS requests. If this parameter is set to false, then no certificate
or binding is created. Set this value to false if another certificate is
used for Windows PowerShell Web Access.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | true                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -WebApplicationName&lt;String&gt;

Specifies the name for your web application. This is displayed as the
last part of the Windows PowerShell Web Access URL.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | 1                                    |
| Default Value                        | pswa                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -WebSiteName&lt;String&gt;

Specifies the name of the Web Server (IIS) website on which to install
this Windows PowerShell Web Access web application.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | Default Web Site                     |
| Accept Pipeline Input?               | false                                |
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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet takes no input.

## OUTPUTS

This cmdlet produces no output.

## EXAMPLES

### EXAMPLE 1

This example installs the PSWA web application using the default values
for the **WebApplicationName** (*pswa*) and **WebSiteName** (*Default
Web Site*) parameters .

```
Install-PswaWebApplication
```

### EXAMPLE 2

This example installs the PSWA web application with a test certificate,
and using the default values for the **WebApplicationName** and
**WebSiteName** parameters.

```
Install-PswaWebApplication -UseTestCertificate
```

## Related topics

- [Add-PswaAuthorizationRule](add-pswaauthorizationrule.md)
- [Get-PswaAuthorizationRule](get-pswaauthorizationrule.md)
- [Remove-PswaAuthorizationRule](remove-pswaauthorizationrule.md)
- [Test-PswaAuthorizationRule](test-pswaauthorizationrule.md)
