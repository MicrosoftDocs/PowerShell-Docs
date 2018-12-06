---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Module Name: CimCmdlets
online version:
schema: 2.0.0
---

# New-CimSessionOption

## SYNOPSIS
Specifies advanced options for the New-CimSession cmdlet.

## SYNTAX

### ProtocolTypeSet (Default)
```
New-CimSessionOption [-Protocol] <ProtocolType> [-UICulture <CultureInfo>] [-Culture <CultureInfo>]
 [<CommonParameters>]
```

### WSManParameterSet
```
New-CimSessionOption [-NoEncryption] [-SkipCACheck] [-SkipCNCheck] [-SkipRevocationCheck]
 [-EncodePortInServicePrincipalName] [-Encoding <PacketEncoding>] [-HttpPrefix <Uri>]
 [-MaxEnvelopeSizeKB <UInt32>] [-ProxyAuthentication <PasswordAuthenticationMechanism>]
 [-ProxyCertificateThumbprint <String>] [-ProxyCredential <PSCredential>] [-ProxyType <ProxyType>] [-UseSsl]
 [-UICulture <CultureInfo>] [-Culture <CultureInfo>] [<CommonParameters>]
```

### DcomParameterSet
```
New-CimSessionOption [-Impersonation <ImpersonationType>] [-PacketIntegrity] [-PacketPrivacy]
 [-UICulture <CultureInfo>] [-Culture <CultureInfo>] [<CommonParameters>]
```

## DESCRIPTION
The New-CimSessionOption cmdlet creates an instance of a CIM session options object.
You use a CIM session options object as input to the New-CimSession cmdlet to specify the options for a CIM session.

This cmdlet has two parameter sets, one for WsMan options and one for Distributed Component Object Model (DCOM) options.
Depending on which parameters you use, the cmdlet returns either an instance of DCOM session options or returns WsMan session options.

## EXAMPLES

### Example 1: Create a CIM session options object for DCOM
```
PS C:\>$so = New-CimSessionOption -Protocol DCOM



PS C:\>New-CimSession -ComputerName Server01 -SessionOption $so
```

This set of commands creates a CIM session options object for the DCOM protocol and stores it in a variable named $so.
The contents of the variable are then passed to the New-CimSession cmdlet.
New-CimSession then creates a new CIM session with the remote server named Server01, using the options defined in the variable.

### Example 2: Create a CIM session options object for WsMan
```
PS C:\>New-CimSessionOption -ProxyAuthentication Kerberos -ProxyCredential $cred -SkipCACheck -SkipCNCheck -UseSsl
```

This command creates a CIM session options object for the WsMan protocol.
The object contains configuration for the authentication mode of Kerberos specified by the ProxyAuthentication parameter, the credentials specified by the ProxyCredential parameter, and specifies that the command is to skip the CA check, skip the CN check, and use SSL.

### Example 3: Create a CIM session options object with the culture specified
```
PS C:\>New-CimSessionOption -Culture Fr-Fr -Protocol Wsman
```

This command specifies the culture that is used for the CIM session.
By default, the culture of the client is used when performing operations.
However, the default culture can be overridden using the Culture parameter.

## PARAMETERS

### -Culture
Specifies the user interface culture to use for the CIM session.
Specify the value for this parameter using one of the following formats:

Enter a culture name in \<languagecode2\>-\<country/regioncode2\> format such as "EN-US". 


                        
A variable that contains a CultureInfo object. 


                        
A command that gets a CultureInfo object, such as Get-Culture.
For more information about Get-Culture, see http://technet.microsoft.com/library/hh849930.aspx.

```yaml
Type: CultureInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EncodePortInServicePrincipalName
Indicates that the Kerberos connection is connecting to a service whose service principal name (SPN) includes the service port number.
This type of connection is not common.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Encoding
Specifies the encoding used for the WsMan protocol.

The acceptable values for this parameter are:  Default, Utf8, or Utf16.

```yaml
Type: PacketEncoding
Parameter Sets: WSManParameterSet
Aliases:
Accepted values: Default, Utf8, Utf16

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HttpPrefix
Specifies the part of the HTTP URL after the computer name and port number.
Changing this is not common.

By default, the value of this parameter is /wsman.

```yaml
Type: Uri
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Impersonation
Creates a DCOM session to Windows Management Instrumentation (WMI) using impersonation.

Valid values for this parameter are: 

- Default: DCOM can choose the impersonation level using its normal security negotiation algorithm. 
- None: The client is anonymous to the server.
  The server process can impersonate the client, but the impersonation token does not contain any information and cannot be used. 
- Identify: Allows objects to query the credentials of the caller. 
- Impersonate: Allows objects to use the credentials of the caller. 
- Delegate: Allows objects to permit other objects to use the credentials of the caller.

If Impersonation is not specified, the New-CimSession cmdlet uses the value of 3: Impersonate

```yaml
Type: ImpersonationType
Parameter Sets: DcomParameterSet
Aliases:
Accepted values: Default, None, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxEnvelopeSizeKB
Specifies the size limit of WsMan XML messages for either direction.

```yaml
Type: UInt32
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoEncryption
Specifies that data encryption is turned off.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PacketIntegrity
Specifies that the DCOM session created to WMI uses the Component Object Model (COM) PacketIntegrity functionality.
For enhanced security, by default all CIM sessions created using DCOM have the PacketIntegrity parameter set to True.

```yaml
Type: SwitchParameter
Parameter Sets: DcomParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PacketPrivacy
Creates a DCOM session to WMI using the COM PacketPrivacy.
For enhanced security, by default all CIM sessions created using DCOM have the PacketPrivacy parameter set to true.

```yaml
Type: SwitchParameter
Parameter Sets: DcomParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol
Specifies the protocol to use.

The acceptable values for this parameter are: DCOM or WinRM.

```yaml
Type: ProtocolType
Parameter Sets: ProtocolTypeSet
Aliases:
Accepted values: Dcom, Default, Wsman

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyAuthentication
Specifies the authentication method to use for proxy resolution.

The acceptable values for this parameter are: Default, Digest, Negotiate, Basic, Kerberos, NtlmDomain, or CredSsp.

```yaml
Type: PasswordAuthenticationMechanism
Parameter Sets: WSManParameterSet
Aliases:
Accepted values: Default, Digest, Negotiate, Basic, Kerberos, NtlmDomain, CredSsp

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyCertificateThumbprint
Specifies the (x.509) digital public key certificate of a user account for proxy authentication.
Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication.
They can only be mapped to local user accounts and they do not work with domain accounts.

To get a certificate thumbprint, use the Get-Item or Get-ChildItem cmdlets in the PowerShell Cert: drive.
For more information about the Get-ChildItem cmdlet for the PowerShell Cert: drive, see http://technet.microsoft.com/library/hh847761.aspx.
For more information about Get-Item, see http://technet.microsoft.com/library/hh849788.aspx

```yaml
Type: String
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyCredential
Specifies the credentials to use for proxy authentication.
Enter one of the following:

- A variable that contains a PSCredential object. 
- A command that gets a PSCredential object, such as Get-Credential

If this option is not set, then you cannot specify any credentials.

```yaml
Type: PSCredential
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyType
Specifies the host name resolution mechanism to use.

The acceptable values for this parameter are: None, WinHttp, Auto, or InternetExplorer.

By default, the value of this parameter is InternetExplorer.

```yaml
Type: ProxyType
Parameter Sets: WSManParameterSet
Aliases:
Accepted values: None, WinHttp, Auto, InternetExplorer

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipCACheck
Indicates that when connecting over HTTPS, the client does not validate that the server certificate is signed by a trusted certification authority (CA).

Use this parameter only when the remote computer is trusted using another mechanism, such as when the remote computer is part of a network that is physically secure and isolated, or when the remote computer is listed as a trusted host in a WinRM configuration.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipCNCheck
Indicates that the certificate common name (CN) of the server does not need to match the hostname of the server.

Use this parameter only for remote operations that use the HTTPS protocol.

Note: use this parameter only for trusted computers.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipRevocationCheck
Indicates that the revocation check for server certificates is skipped.

Note: use this parameter only for trusted computers.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UICulture
Specifies the user interface culture to use for the CIM session.
Specify the value for this parameter using one of the following formats:

- Enter a culture name in \<languagecode2\>-\<country/regioncode2\> format such as "EN-US".
- A variable that contains a CultureInfo object.
- A command that gets a CultureInfo object, such as Get-Culture.
  For more information about Get-Culture, see http://technet.microsoft.com/library/hh849930.aspx.

```yaml
Type: CultureInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseSsl
Indicates that SSL should be used to establish a connection to the remote computer.
By default, SSL is not used.

WsMan encrypts all content that is transmitted over the network.
This parameter lets you specify the additional protection of HTTPS instead of HTTP.
If SSL is not available on the port used for the connection and you specify this parameter, then the command fails.

It is recommended that you use this parameter only when the PacketPrivacy parameter is not specified.

```yaml
Type: SwitchParameter
Parameter Sets: WSManParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet accepts no input objects.

## OUTPUTS

### CIMSessionOption
This cmdlet returns an object that contains CIM session options information.

## NOTES

## RELATED LINKS

[Get-ChildItem](../microsoft.powershell.management/get-childitem.md)

[Get-Credential](../microsoft.powershell.security/get-credential.md)

[Get-Culture](../microsoft.powershell.utility/get-culture.md)

[Get-Item](../microsoft.powershell.management/get-item.md)

[New-CimSession](New-CimSession.md)