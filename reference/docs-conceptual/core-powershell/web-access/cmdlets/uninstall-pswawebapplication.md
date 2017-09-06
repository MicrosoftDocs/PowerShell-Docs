---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  uninstall pswawebapplication
ms.technology:  powershell
---

# Uninstall-PswaWebApplication

## SYNOPSIS

Uninstalls the Windows PowerShell® web application.

## SYNTAX

### Default
```
Uninstall-PswaWebApplication [[-WebApplicationName] <String> ] [-DeleteTestCertificate] [-WebSiteName <String> ] [-Confirm] [-WhatIf] [ <CommonParameters>]
```

## DESCRIPTION

The **Uninstall-PswaWebApplication** cmdlet uninstalls the Windows
PowerShell web application and removes the website from IIS. The cmdlet
does not uninstall IIS, or any other features installed because they
were required for Windows PowerShell to run.

## PARAMETERS

### -DeleteTestCertificate

Indicates that the test certificates
created by the **Install\_PswaWebApplication** cmdlet
(with the **UseTestCertificate** parameter)
is deleted.
Only the test certificate
with the same name as
the one created by the **Install-PswaWebApplication** cmdlet
is removed.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | named                                |
| Default Value                        | true                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -WebApplicationName &lt;String&gt;

Specifies the name of the web application to uninstall.

|||  
|-|-|
| Aliases                              | none                                 |
| Required?                            | false                                |
| Position?                            | 1                                    |
| Default Value                        | pswa                                 |
| Accept Pipeline Input?               | false                                |
| Accept Wildcard Characters?          | false                                |

### -WebSiteName &lt;String&gt;

Specifies the name of the web site
where the web application is installed.

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

This cmdlet returns no output.

## EXAMPLES

### EXAMPLE 1

This command uninstalls the Windows PowerShell Web Application.
You can use this cmdlet to uninstall the Windows PowerShell Web Application
if you installed it using the default values.

```PowerShell
Uninstall-PswaWebApplication
```

### EXAMPLE 2

This command uninstalls the Windows PowerShell Web Application, and
deletes the test certificate associated with the application.
You can use this cmdlet to uninstall the Windows PowerShell Web Application
if you installed it using the default values
and created a test certificate.

```PowerShell
Uninstall-PswaWebApplication -DeleteTestCertificate
```

### EXAMPLE 3 {#example-3 .subHeading}

This command uninstalls the Windows PowerShell Web Application
when a custom website and application were specified during the install.
The command removes the website named *MySite*
and the application named *TestApplication*
and specifies that the test certificates associated with the application
are also deleted.

```
Uninstall-PswaWebApplication -WebApplicationName TestApplication -WebsiteName MySite -DeleteTestCertificate
```

## Related topics

- [Add-PswaAuthorizationRule](add-pswaauthorizationrule.md)
- [Get-PswaAuthorizationRule](get-pswaauthorizationrule.md)
- [Install-PswaWebApplication](install-pswawebapplication.md)
- [Remove-PswaAuthorizationRule](remove-pswaauthorizationrule.md)
- [Test-PswaAuthorizationRule](test-pswaauthorizationrule.md)
