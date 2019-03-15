---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Module Name: CimCmdlets
online version:
schema: 2.0.0
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
 [-OperationTimeoutSec <UInt32>] [-SkipTestConnection] [-Port <UInt32>] [-SessionOption <CimSessionOptions>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-CimSession` cmdlet creates a CIM session.
A CIM session is a client-side object representing a connection to a local computer or a remote computer.
The CIM session contains information about the connection, such as ComputerName, the protocol used for the connection, session ID and instance ID.

This cmdlet returns a CIM session object that can be used by all other CIM cmdlets.

## EXAMPLES

### Example 1: Create a CIM session with default options

```powershell
New-CimSession
```

This command creates a local CIM session with default options.
If **ComputerName** is not specified, `New-CimSession` creates a DCOM session to the local computer.

### Example 2: Create a CIM session to a specific computer

```powershell
New-CimSession -ComputerName Server01
```

This command creates a CIM session to the computer specified by **ComputerName**.
By default, `New-CimSession` creates a WsMan session when **ComputerName** is specified.

### Example 3: Create a CIM session to multiple computers

```powershell
New-CimSession -ComputerName Server01,Server02,Server03
```

This command creates a CIM session to each of the computers specified by **ComputerName**, in the comma separated list.

### Example 4: Create a CIM session with a friendly name

You can use the friendly name of a CIM session to easily refer to the session in other CIM cmdlets, for example, [Get-CimSession](Get-CimSession.md).

```powershell
New-CimSession -ComputerName Server01,Server02 -Name FileServers

Get-CimSession -Name File*
```

This command creates a remote CIM session to each of the computers specified by **ComputerName**, in the comma separated list, and assigns a friendly name to the new sessions, by specifying **Name**.

### Example 5: Create a CIM session to a computer using a PSCredential object

```powershell
New-CimSession -ComputerName Server01 -Credential $cred -Authentication Negotiate
```

This command creates a CIM session to the computer specified by **ComputerName**, using the PSCredential object specified by **Credential**, and the authentication type specified by **Authentication**.

You can create a PSCredential object by using the [`Get-Credential`](../Microsoft.PowerShell.Security/Get-Credential.md) cmdlet.

### Example 6: Create a CIM session to a computer using a specific port

```powershell
New-CimSession -ComputerName Server01 -Port 1234
```

This command creates a CIM session to the computer specified by ComputerName using the TCP port specified by **Port**.

### Example 7: Create a CIM session using DCOM

```powershell
$SessionOption = New-CimSessionOption -Protocol DCOM

New-CimSession -ComputerName Server1 -SessionOption $SessionOption
```

This command creates a CIM session by using the Distributed COM (DCOM) protocol instead of WSMan.

## PARAMETERS

### -Authentication

Specifies the authentication type used for the user's credentials.
The acceptable values for this parameter are:

- Default
- Digest
- Negotiate
- Basic
- Kerberos
- NtlmDomain
- CredSsp

You cannot use the NtlmDomain authentication type for connection to the local computer.
CredSSP authentication is available only in Windows Vista, Windows Server 2008, and later versions of Windows.

Caution: Credential Security Service Provider (CredSSP) authentication, in which the user's credentials are passed to a remote computer to be authenticated, is designed for commands that require authentication on more than one resource, such as accessing a remote network share.
This mechanism increases the security risk of the remote operation.
If the remote computer is compromised, the credentials that are passed to it can be used to control the network session.

```yaml
Type: PasswordAuthenticationMechanism
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

Specifies the digital public key certificate (X.509) of a user account that has permission to perform this action.
Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication.
They can be mapped only to local user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use the [`Get-Item`](../Microsoft.Powershell.Management/Get-Item.md) or [`Get-ChildItem`](../Microsoft.Powershell.Management/Get-ChildItem.md) cmdlets in the PowerShell Certificate Provider.
For more information about using the PowerShell Certificate provider, type `Get-Help Certificate`, or see [Certificate Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: String
Parameter Sets: CertificateParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ComputerName

Specifies the name of the computer to which to create the CIM session.
Specify either a single computer name, or multiple computer names separated by a comma.

If **ComputerName** is not specified, a CIM session to the local computer is created.

You can specify the value for computer name in one of the following formats:

- One or more NetBIOS names
- One or more IP addresses
- One or more fully qualified domain names.

If the computer is in a different domain than the user, you must specify the fully qualified domain name.

You can also pass a computer name (in quotes) to `New-CimSession` by using the pipeline.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: CN, ServerName

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action.
If **Credential** is not specified, the current user account is used.

Specify the value for **Credential** by using one of the following formats:

- A user name: "User01"
- A domain name and a user name: "Domain01\User01"
- A user principal name: "User@Domain.com"
- A PSCredential object, such as one returned by the [`Get-Credential`](../Microsoft.PowerShell.Security/Get-Credential.md) cmdlet.

When you type a user name, you are prompted for a password.

```yaml
Type: PSCredential
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

You can use the name to refer to the CIM session when using other cmdlets, such as the [`Get-CimSession`](Get-CimSession.md) cmdlet.
The name is not required to be unique to the computer or the current session.

```yaml
Type: String
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

By default, the value of this parameter is 0, which means that the cmdlet uses the default timeout value for the server.

If the **OperationTimeoutSec** parameter is set to a value less than the robust connection retry timeout of 3 minutes, network failures that last more than the value of the **OperationTimeoutSec** parameter are not recoverable, because the operation on the server times out before the client can reconnect.

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases: OT

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Port

Specifies the network port on the remote computer that is used for this connection.
To connect to a remote computer, the remote computer must be listening on the port that the connection uses.
The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Before using an alternate port, you must configure the WinRM listener on the remote computer to listen at that port.
Use the following commands to configure the listener:

`winrm delete winrm/config/listener?Address=*+Transport=HTTP`

`winrm create winrm/config/listener?Address=*+Transport=HTTP @{Port="\<port-number>"}`

Do not use the **Port** parameter unless you must.
The port setting in the command applies to all computers or sessions on which the command runs.
An alternate port setting might prevent the command from running on all computers.

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SessionOption

Sets advanced options for the new CIM session.
Enter the name of a CimSessionOption object created by using the [`New-CimSessionOption`](New-CimSessionOption.md) cmdlet.

```yaml
Type: CimSessionOptions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipTestConnection

By default, the `New-CimSession` cmdlet establishes a connection with a remote WS-Management endpoint for two reasons: to verify that the remote server is listening on the port number that is specified by using the **Port** parameter, and to verify the specified account credentials.
The verification is accomplished by using a standard WS-Identity operation.
You can add the **SkipTestConnection** switch parameter if the remote WS-Management endpoint cannot use WS-Identify, or if you want to reduce some data transmission time.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

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