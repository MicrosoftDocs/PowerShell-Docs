---
external help file: PSITPro5_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294037
schema: 2.0.0
---

# Enable-WSManCredSSP
## SYNOPSIS
Enables CredSSP authentication on a computer.

## SYNTAX

```
Enable-WSManCredSSP [-Role] <String> [[-DelegateComputer] <String[]>] [-Force]
```

## DESCRIPTION
The Enable-WSManCredSSP cmdlet enables Credential Security Support Provider (CredSSP) authentication on a client or on a server computer.
When CredSSP authentication is used, the user credentials are passed to a remote computer to be authenticated.
This type of authentication is designed for commands that create a remote session from another remote session.
For example, if you want to run a background job on a remote computer, use this kind of authentication.

Use this cmdlet to enable CredSSP on the client by specifying Client in the Role parameter.
This cmdlet performs the following actions: 

- Enables CredSSP on the client.
This cmdlet sets the WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP to true. 
- Sets the Windows CredSSP policy AllowFreshCredentials to WSMan/Delegate on the client. 

These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

Use this cmdlet enable CredSSP on the server by specifying Server in Role.
This cmdlet performs the following action: 

- Enables CredSSP on the server.
This cmdlet sets the WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP to true. 

This policy setting allows the server to act as a delegate for clients.

Caution: CredSSP authentication delegates the user credentials from the local computer to a remote computer.
This practice increases the security risk of the remote operation.
If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.

## EXAMPLES

### Example 1: Delegate client credentials
```
PS C:\>Enable-WSManCredSSP -Role "Client" -DelegateComputer "server02.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to the server02 computer.

### Example 2: Delegate client credentials to all computers in a domain
```
PS C:\>Enable-WSManCredSSP -Role "Client" -DelegateComputer "*.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to all the computers in the accounting.fabrikam.com domain.

### Example 3: Delegate client credentials to multiple computers
```
PS C:\>Enable-WSManCredSSP -Role "Client" -DelegateComputer "server02.accounting.fabrikam.com", "server03.accounting.fabrikam.com", "server04.accounting.fabrikam.com"
cfg         : http://schemas.microsoft.com/wbem/wsman/1/config/client/auth
lang        : en-US
Basic       : true
Digest      : true
Kerberos    : true
Negotiate   : true
Certificate : true
CredSSP     : true
```

This command allows the client credentials to be delegated to multiple computers.

### Example 4: Allow a computer to act as a delegate
```
PS C:\>Enable-WSManCredSSP -Role "Server"
```

This command allows a computer to act as a delegate for another.
The Enable-WSManCredSSP cmdlet, shown in the earlier examples, only enables CredSSP authentication on the client, and specifies the remote computers that can act on its behalf.
In order for the remote computer to act as a delegate for the client, the CredSSP item in the Service node of WSMan must be set to true.
This example sets the CredSSP item in the Service node of WSMan to true.

### Example 5: Allow a computer to act as a delegate by using Set-Item
```
PS C:\>Connect-WSMan -ComputerName "server02"
PS C:\> Set-Item -Path "wsman:\server02\service\auth\credSSP" -Value $True
```

This example allows a computer to act as a delegate for another computer.
The Enable-WSManCredSSP commands, shown in the earlier examples, enable CredSSP authentication only on the client computer, and they specify the remote computers that can act on behalf of the client computer.
For the remote computer to act as a delegate for the client computer, the CredSSP item in the Service directory of the WSMan provider must be set to true.

The first command creates a connection to the remote server02 computer by using the Connect-WSMan cmdlet.

The second command sets the credSSP value on the remote server02 computer by using the Set-Item cmdlet.
This value allows the remote computer to act as a delegate.

## PARAMETERS

### -DelegateComputer
Specifies servers to which client credentials are delegated.
Specify fully qualified domain names.

If the Role parameter is Client, you must specify this paremter.

If Role is Server, do not specify this parameter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Role
Specifies whether to enable CredSSP as a client or as a server.
The acceptable values for this parameter are: Client and Server.

If you specify Client, this cmdlet performs the following actions: 

- Enables CredSSP on the client.
This cmdlet sets the WS-Management setting \<localhost|computername\>\Client\Auth\CredSSP to true. 
- Sets the Windows CredSSP policy AllowFreshCredentials to WSMan/Delegate on the client. 

These settings allow the client to delegate explicit credentials to a server when server authentication is achieved.

If you specify Server, the cmdlet performs the following actions: 

- Enables CredSSP on the server.
This cmdlet sets the WS-Management setting \<localhost|computername\>\Service\Auth\CredSSP to true. 

This policy setting allows the server to act as a delegate for clients.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### System.Xml.XmlElement
If CredSSP authentication is successfully enabled, this cmdlet generates an XMLElement object.

## NOTES
* To disable CredSSP authentication, use the Disable-WSManCredSSP cmdlet.

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Disconnect-WSMan](6d7ef9f8-ac28-46b1-a3ab-e0820c440c01)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

