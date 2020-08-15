---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: CimCmdlets
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/new-cimsession?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-CimSession
---
# New-CimSession

## SYNOPSIS

Creates a CIM session.

## SYNTAX

### CredentialParameterSet (Default)

```
New-CimSession [-Authentication <PasswordAuthenticationMechanism>] [[-Credential] <PSCredential>]
 [[-ComputerName] <String[]>] [-Name <String>] [-OperationTimeoutSec <UInt32>] [-SkipTestConnection]
 [-Port <UInt32>] [-SessionOption <CimSessionOptions>] [<CommonParameters>]
```

### CertificateParameterSet

```
New-CimSession [-CertificateThumbprint <String>] [[-ComputerName] <String[]>] [-Name <String>]
 [-OperationTimeoutSec <UInt32>] [-SkipTestConnection] [-Port <UInt32>]
 [-SessionOption <CimSessionOptions>] [<CommonParameters>]
```

## DESCRIPTION

The `New-CimSession` cmdlet creates a CIM session. A CIM session is a client-side object
representing a connection to a local computer or a remote computer. The CIM session contains
information about the connection, such as **ComputerName**, the protocol used, or various
identifiers.

This cmdlet returns a CIM session object that can be used by all other CIM cmdlets.

## EXAMPLES

### Example 1: Create a CIM session with default options

This example creates a local CIM session with default options. If **ComputerName** is not specified,
`New-CimSession` creates a DCOM session to the local computer.

```powershell
New-CimSession
```

### Example 2: Create a CIM session to a specific computer

This example creates a CIM session to the computer specified by **ComputerName**.
By default, `New-CimSession` creates a WSMan session when **ComputerName** is specified.

```powershell
New-CimSession -ComputerName Server01
```

### Example 3: Create a CIM session to multiple computers

This example creates a CIM session to each of the computers specified by **ComputerName**, in the
comma separated list.

```powershell
New-CimSession -ComputerName Server01,Server02,Server03
```

### Example 4: Create a CIM session with a friendly name

This example creates a remote CIM session to each of the computers specified by **ComputerName**, in
the comma separated list, and assigns a friendly name to the new sessions, by specifying **Name**.

```powershell
New-CimSession -ComputerName Server01,Server02 -Name FileServers
Get-CimSession -Name File*
```

You can use the friendly name of a CIM session to refer to the session in other CIM cmdlets, for
example, [Get-CimSession](Get-CimSession.md).

### Example 5: Create a CIM session to a computer using a PSCredential object

This example creates a CIM session to the computer specified by **ComputerName**, using the
**PSCredential** object specified by **Credential**, and the authentication type specified by
**Authentication**.

```powershell
New-CimSession -ComputerName Server01 -Credential $cred -Authentication Negotiate
```

You can create a **PSCredential** object using the
[`Get-Credential`](../Microsoft.PowerShell.Security/Get-Credential.md) cmdlet.

### Example 6: Create a CIM session to a computer using a specific port

This example creates a CIM session to the computer specified by **ComputerName** using the TCP port
specified by **Port**.

```powershell
New-CimSession -ComputerName Server01 -Port 1234
```

### Example 7: Create a CIM session using DCOM

This example creates a CIM session using the Distributed COM (DCOM) protocol instead of WSMan.

```powershell
$SessionOption = New-CimSessionOption -Protocol DCOM
New-CimSession -ComputerName Server1 -SessionOption $SessionOption
```

## PARAMETERS

### -Authentication

Specifies the authentication type used for the user's credentials. The acceptable values for this
parameter are:

- Default
- Digest
- Negotiate
- Basic
- Kerberos
- NtlmDomain
- CredSsp

You cannot use the **NtlmDomain** authentication type for connection to the local computer. **CredSSP**
authentication is available only in Windows Vista, Windows Server 2008, and later versions of
Windows.

> [!CAUTION]
> Credential Security Service Provider (CredSSP) authentication is designed for commands that
> require authentication on more than one resource, such as accessing a remote network share. This
> mechanism increases the security risk of the remote operation. If the remote computer is
> compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: Microsoft.Management.Infrastructure.Options.PasswordAuthenticationMechanism
Parameter Sets: CredentialParameterSet
Aliases:
Accepted values: Default, Digest, Negotiate, Basic, Kerberos, NtlmDomain, CredSsp

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CertificateThumbprint

Specifies the digital public key certificate (X.509) of a user account that has permission to
perform this action. Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication. They can be mapped only to local
user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use the
[`Get-Item`](../Microsoft.Powershell.Management/Get-Item.md) or
[`Get-ChildItem`](../Microsoft.Powershell.Management/Get-ChildItem.md) cmdlets in the PowerShell
Certificate Provider.

For more information, see [about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: System.String
Parameter Sets: CertificateParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComputerName

Specifies the name of the computer to which to create the CIM session. Specify either a single
computer name, or multiple computer names separated by a comma.

If **ComputerName** is not specified, a CIM session to the local computer is created. You can
specify the value for computer name in one of the following formats:

- One or more NetBIOS names
- One or more IP addresses
- One or more fully qualified domain names.

If the computer is in a different domain than the user, you must specify the fully qualified domain
name.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: CN, ServerName

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action. If **Credential** is not
specified, the current user account is used.

Specify the value for **Credential** using one of the following formats:

- A user name: "User01"
- A domain name and a user name: "Domain01\User01"
- A user principal name: "User@Domain.com"
- A PSCredential object, such as one returned by the [`Get-Credential`](../Microsoft.PowerShell.Security/Get-Credential.md) cmdlet.

When you type a user name, you are prompted for a password.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: CredentialParameterSet
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies a friendly name for the CIM session.

You can use the name to refer to the CIM session when using other cmdlets, such as the [Get-CimSession](Get-CimSession.md) cmdlet.
The name is not required to be unique to the computer or the current session.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OperationTimeoutSec

Duration for which the cmdlet waits for a response from the server.

By default, the value of this parameter is 0, which means that the cmdlet uses the default timeout
value for the server.

If the **OperationTimeoutSec** parameter is set to a value less than the robust connection retry
timeout of 3 minutes, network failures that last more than the value of the **OperationTimeoutSec**
parameter are not recoverable, because the operation on the server times out before the client can
reconnect.

```yaml
Type: System.UInt32
Parameter Sets: (All)
Aliases: OT

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port

Specifies the network port on the remote computer that is used for this connection. To connect to a
remote computer, the remote computer must be listening on the port that the connection uses. The
default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Before using an alternate port, you must configure the WinRM listener on the remote computer to
listen at that port. Use the following commands to configure the listener:

`winrm delete winrm/config/listener?Address=*+Transport=HTTP`

`winrm create winrm/config/listener?Address=*+Transport=HTTP @{Port="\<port-number>"}`

Do not use the **Port** parameter unless you must. The port setting in the command applies to all
computers or sessions on which the command runs. An alternate port setting might prevent the command
from running on all computers.

```yaml
Type: System.UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SessionOption

Sets advanced options for the new CIM session. Enter the name of a **CimSessionOption** object
created using the [`New-CimSessionOption`](New-CimSessionOption.md) cmdlet.

```yaml
Type: Microsoft.Management.Infrastructure.Options.CimSessionOptions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipTestConnection

By default, the `New-CimSession` cmdlet establishes a connection with a remote WS-Management
endpoint for two reasons: to verify that the remote server is listening on the port number that is
specified using the **Port** parameter, and to verify the specified account credentials. The
verification is accomplished using a standard WS-Identity operation. You can add the
**SkipTestConnection** switch parameter if the remote WS-Management endpoint cannot use WS-Identify,
or to reduce some data transmission time.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

This cmdlet accepts no inputs.

## OUTPUTS

### Microsoft.Management.Infrastructure.CimSession

## NOTES

## RELATED LINKS

[Get-ChildItem](../Microsoft.Powershell.Management/Get-ChildItem.md)

[Get-Credential](../Microsoft.PowerShell.Security/Get-Credential.md)

[Get-Item](../Microsoft.Powershell.Management/Get-Item.md)

[Get-CimSession](Get-CimSession.md)

[Remove-CimSession](Remove-CimSession.md)

[New-CimSessionOption](New-CimSessionOption.md)

[about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md)
