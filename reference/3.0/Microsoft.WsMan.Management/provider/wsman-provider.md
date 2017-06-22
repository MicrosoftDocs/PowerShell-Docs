---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  WSMan Provider
---

# WSMan Provider
## PROVIDER NAME  
 WSMan  
  
## DRIVES  
 WSMan  
  
## SHORT DESCRIPTION  
 Provides access to Web Services for Management (WS-Management) configuration information.  
  
## DETAILED DESCRIPTION  
 The WSMan provider for Windows PowerShell lets you add, change, clear, and delete WS-Management configuration data on local or remote computers.  
  
 The WSMan provider exposes a Windows PowerShell drive with a directory structure that corresponds to a logical grouping of WS-Management configuration settings. These groupings are known as containers.  
  
 New in Windows PowerShell 3.0  
  
 Beginning in Windows PowerShell 3.0, the WS-Management provider has been updated to support new properties for session configurations, such as OutputBufferingMode. The session configurations appear as items in the Plugin directory of the WSMan: drive and the properties appear as items in each session configuration.  
  
 You can use commands in the WSMan: drive to change the values of the new properties. However, you cannot use the WSMan: drive in Windows PowerShell 2.0 to change properties that are introduced in Windows PowerShell 3.0. Although no error is generated, the commands are not effective To change these settings, use the WSMan drive in Windows PowerShell 3.0.  
  
 Organization of the WSMan: Drive  
  
 -- Client  
  
 You can configure various aspects of the WS-Management client. The configuration information is stored in the registry.  
  
 -- Service  
  
 You can configure various aspects of the WS-Management service. The configuration information is stored in the registry.  
  
 Note: Service configuration is sometimes referred to as Server configuration.  
  
 -- Shell  
  
 You can configure various aspects of the WS-Management shell, such as the setting to allow remote shell access (AllowRemoteShellAccess) and the maximum number of concurrent users allowed (MaxConcurrentUsers).  
  
 -- Listener  
  
 You can create and configure a listener. A listener is a management service that implements the WS-Management protocol to send and to receive messages.  
  
 -- Plugin  
  
 Plug-ins are loaded and used by the WS-Management service to provide various functions. By default, Windows PowerShell provides three plug-ins: the Event Forwarding plug-in, the Microsoft.PowerShell plug-in, and the Windows Management Instrumentation (WMI) Provider plug-in. These three plug-ins support event forwarding, configuration, and WMI access.  
  
 -- ClientCertificate  
  
 You can create and configure a client certificate. A client certificate is used when the WS-Management client is configured to use certificate authentication.  
  
 Directory Hierarchy of the WSMan Provider  
  
 --------------\-  
  
 The directory hierarchy of the WSMan provider for the local computer is as follows:  
  
 WSMan:\localhost  
  
 --- Client  
  
 --- Service  
  
 --- Shell  
  
 --- Listener  
  
 ------ <Specific_Listener>  
  
 --- Plugin  
  
 ------ Event Forwarding Plugin  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 ------ Microsoft.Powershell  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 ------ WMI Provider  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 --- ClientCertificate  
  
 The directory hierarchy of the WSMan provider for a remote computer is the same as a local computer. However, in order to access the configuration settings of a remote computer, you need to make a connection to the remote computer using [Connect-WSMan](../Connect-WSMan.md). Once a connection is made to a remote computer, the name of the remote computer shows up in the provider.  
  
 WSMan:\\<Remote_Computer_Name>  
  
 --- Client  
  
 --- Service  
  
 --- Shell  
  
 --- Listener  
  
 ------ <Specific_Listener>  
  
 --- Plugin  
  
 ------ Event Forwarding Plugin  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 ------ Microsoft.Powershell  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 ------ WMI Provider  
  
 --------- InitializationParameters  
  
 --------- Resources  
  
 ------------ Security  
  
 --- ClientCertificate  
  
 Custom Provider Help  
  
 -------------------\-  
  
 The Listener, Plugin (IntitializationParameters, Resources, Security) and ClientCertificate provider paths provide specific [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) support.  Type "[Get-Help](../../Microsoft.PowerShell.Core/Get-Help.md)[New-Item](../../Microsoft.PowerShell.Management/New-Item.md)" in the relevant path for custom help.  
  
## EXAMPLES  
  
### Navigating the WSMan: Drive  
  
#### Example 1  
 This command uses the Set-Location cmdlet to change the current location to the WSMan: drive.  
  
```  
Set-Location WSMan:  
  
```  
  
#### Example 2  
 This command uses the Set-Location command to change the current location to the root location in the Localhost store location.  Use a backslash (\\) or forward slash (/) to indicate a level of the WSMan: drive.  
  
```  
Set-Location -Path Localhost  
  
```  
  
 If you are not in the WSMan: drive, begin the path with the drive name.  
  
#### Example 3  
 This command uses the Set-Location command to change the current location to the root location in the remote system store location.  Use a backslash (\\) or forward slash (/) to indicate a level of the WSMan: drive.  
  
```  
Set-Location -Path  WSMan:\SERVER01  
  
```  
  
 If you are not in the WSMan: drive, begin the path with the drive name.  
The above command assume that a connection to the remote system already exists.  If a connection has not been made to the remote system, then a connection could be make immediately prior to navigating to the root location in the remote system store location. For example:  
  WSMan-Connect SERVER01  
  Set-Location -Path  WSMan:\SERVER01  
  
#### Example 4  
 This command uses the Set-Location command to change the current location to the Client location in the Localhost store location.  Use a backslash (\\) or forward slash (/) to indicate a level of the WSMan: drive.  
  
```  
Set-Location -Path Localhost\Client  
  
```  
  
 If you are not in the WSMan: drive, begin the path with the drive name.  
  
### Displaying the Contents of the WSMan: Drive  
  
#### Example 1  
 This command uses the Get-Childitem cmdlet to display the WS-Management stores in the Localhost store location.  
  
```  
get-childitem -path WSMan:\Localhost  
  
```  
  
 If you are in the WSMan: drive, you can omit the drive name.  
  
#### Example 2  
 This command uses the Get-Childitem cmdlet to display the WS-Management stores in the remote computer (SERVER01) store location.  
  
```  
get-childitem -path WSMan:\SERVER01  
  
```  
  
 If you are in the WSMan: drive, you can omit the drive name.  
The above command assume that a connection to the remote system already exists.  If a connection has not been made to the remote system, then a connection could be make immediately displaying the properties and containers in the remote system store location. For example:  
  WSMan-Connect SERVER01  
  get-childitem -path WSMan:\SERVER01  
  
#### Example 3  
 This command uses the Get-Childitem cmdlet to display the current WS-Management connections.  
  
```  
get-childitem -path WSMan:\  
  
```  
  
 If you are in the WSMan: drive, you can omit the drive name.  
  
#### Example 4  
 This command uses the Get-Item cmdlet to get the properties and containers in the current store.  
  
```  
Get-Childitem  
  
```  
  
 The above command returns a list of properties and containers.  For example:  
PS WSMan:\localhost&gt; get-childitem  
   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost  
Name                   Value          Type  
----                             -----          ---\-  
MaxEnvelopeSizekb      150            System.String  
MaxTimeoutms           60000          System.String  
MaxBatchItems          32000          System.String  
MaxProviderRequests    4294967295     System.String  
Client                                Container  
Service                               Container  
Shell                                 Container  
Listener                              Container  
Plugin                                Container  
ClientCertificate                     Container  
  
## DYNAMIC PARAMETERS  
 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.  
  
### Address <String\>  
 Specifies the address for which this listener was created. The value can be one of the following:  
  
 -- The literal string "*". (The wildcard character (\*) makes the command bind all the IP addresses on all the network adapters.)  
  
 -- The literal string "IP:" followed by a valid IP address in either IPv4 dotted-decimal format or in IPv6 cloned-hexadecimal format.  
  
 -- The literal string "MAC:" followed by the MAC address of an adapter. For example: MAC:32-a3-58-90-be-cc.  
  
 Note: The Address value is set when creating a Listener.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### AllowRemoteShellAccess <Boolean\>  
 Enables access to remote shells. If you set this parameter to False, new remote shell connections will be rejected by the server. The default is True.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### AllowUnEncrypted <Boolean\>  
 Allows the client computer to request unencrypted traffic. By default, the client computer requires encrypted network traffic.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Arguments <String\>  
 Specifies the argument string and the command-line arguments that you want to pass to the custom shell. This parameter is optional.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Basic <Boolean\>  
 Allows the client computer to use Basic authentication. Basic authentication is a scheme in which the user name and password are sent in clear text to the server or proxy. This method is the least secure method of authentication.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Capability <Enumeration\>  
 Specifies an operation that is supported on this Uniform Resource Identifier (URI). You have to create one entry for each type of operation that the URI supports. The following are valid values:  
  
 -- Create: Create operations are supported on the URI. The SupportFragment attribute is used if the Create operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Delete: Delete operations are supported on the URI. The SupportFragment attribute is used if the Delete operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Enumerate: Enumerate operations are supported on the URI. The SupportFragment attribute is not supported for Enumerate operations and should be set to False. The SupportFiltering attribute is valid, and if the plug-in supports filtering, this attribute should be set to True. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Get: Get operations are supported on the URI. The SupportFragment attribute is used if the Get operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Invoke: Invoke operations are supported on the URI. The SupportFragment attribute is not supported for Invoke operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Put: Put operations are supported on the URI. The SupportFragment attribute is used if the Put operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Subscribe: Subscribe operations are supported on the URI. The SupportFragment attribute is not supported for Subscribe operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 -- Shell: Shell operations are supported on the URI. The SupportFragment attribute is not supported for Shell operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if any other operation is also supported. If a Shell operation is configured for a URI, Get, Put, Create, Delete, Invoke, and Enumerate operations are processed internally within the WS-Management (WinRM) service to manage shells. As a result, the plug-in cannot handle the operations.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)  
  
-   [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### CbtHardeningLevel <String\>  
 Sets the policy for channel-binding token requirements in authentication requests. The following are valid values:  
  
 -- Strict:  Any request will be denied unless a channel-binding token is present. This setting guarantees that all connections are secured by the use of channel-binding tokens.  
  
 -- Relaxed: If a channel-binding token is present in a request, the connection will be secured.  If a channel-binding token is not present, the connection will still be accepted. However, it will be vulnerable to attacks that are prevented by the use of channel-binding tokens.  
  
 -- None: Any channel-binding tokens that are supplied are ignored.  
  
 The value of this parameter is only effective for HTTPS connections.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### CertificateThumbprint <String\>  
 Specifies the thumbprint of the service certificate.  
  
 This value represents the string of two-digit hexadecimal values in the Thumbprint field of the certificate. It specifies the digital public key certificate (X509) of a user account that has permission to perform this action. Certificates are used in client certificate-based authentication. They can be mapped only to local user accounts, and they do not work with domain accounts. To get a certificate thumbprint, use the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) or [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlets in the Windows PowerShell Cert: drive.  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Certificate <Boolean\>  
 Allows the client to be used for certificate authentication. The WS-Management client will try to find the certificate in the computer store. If the client cannot find the certificate in the computer store, the client tries to find it in the current user store. If no matching certificate is found, the user receives an error message.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### CredSSP <Boolean\>  
 Allows the client to use Credential Security Service Provider (CredSSP) authentication.  
  
 CredSSP authentication allows the user to delegate credentials. This option is designed for commands that run on one remote computer but collect data from or run additional commands on other remote computers.  
  
 Caution: CredSSP authentication delegates the user's credentials from the local computer to a remote computer. This practice increases the security risk of the remote operation. If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### HTTP <Unsigned Short Integer\>  
 Specifies the port that the client will use when HTTP is used. By default, HTTP uses port 80. You can specify any value from 1 through 65535.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### HTTPS <Unsigned Short Integer\>  
 Specifies the port that the client will use when HTTPS is used. By default, HTTPS uses port 443. You can specify any value from 1 through 65535.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Digest <Boolean\>  
 Allows the client to use Digest authentication. Digest authentication is a challenge-response scheme that uses a server-specified data string for the challenge.  Only the client computer can initiate a Digest authentication request. The client computer sends a request to the server to authenticate and receives a token string from the server. Then, the client computer sends the resource request, including the user name and a cryptographic hash of the password combined with the token string. Digest authentication is supported for HTTP and for HTTPS. WinRM Shell client scripts and applications can specify Digest authentication, but the WS-Management service does not accept Digest authentication.  
  
 Note: Digest authentication over HTTP is not considered secure.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Enabled <Boolean\>  
 Specifies whether the listener is enabled or disabled. The default is True.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### ExactMatch <Boolean\>  
 Specifies how to use the security settings that are specified in the Sddl parameter. If the ExactMatch parameter is set to True, the security settings in Sddl are used only to authorize access attempts to the URI exactly as specified by the URI. If ExactMatch is set to false, the security settings in Sddl are used to authorize access attempts to the URIs that begin with the string specified in the URI.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### FileName <String\>  
 Specifies an input file to use to update the management resource specified by the ResourceURI and SelectorSet.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### FileName (Plugin) <String\>  
 Specifies the file name of the operations plug-in. Any environment variables that are put in this entry will be expanded in the users' context when a request is received. Because each user could have a different version of the same environment variable, each user could have a different plug-in. This entry cannot be blank and must point to a valid plug-in.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### HostName <String\>  
 Specifies the host name of the computer on which the WS-Management (WinRM) service is running.  
  
 The value must be a fully qualified domain name, an IPv4 or IPv6 literal string, or a wildcard character.  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### IdleTimeOut <Unsigned Long Integer\>  
 Specifies the maximum time, in milliseconds, that the remote shell will remain open when there is no user activity in the remote shell. The remote shell is automatically deleted after the time that is specified. You can specify any values from 0 through 2147483647. A value of 0 indicates an infinite time-out. The default is 900000 (15 minutes).  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### IPv4Filter <String\>  
 Specifies the IPv4 addresses that listeners can use. The following are valid values:  
  
 -- If you leave the parameter blank, no IPv4 addresses can be used.  
  
 -- If you enter a wildcard character (*), any IPv4 address can be used.  
  
 -- If you enter a list of IP ranges, any IP address in the specified ranges can be used. Separate the ranges by using a comma (,), and specify each range as a pair of IPv4 addresses in dotted-decimal format, separated by a hyphen (-). Make sure that the smaller value occurs first in the pair. The ranges are inclusive.  
  
 Note: An IPv4 literal string consists of four dotted decimal numbers, each in the range 0 though 255. For example: 192.168.0.0.  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### IPv6Filter <String\>  
 Specifies the IPv6 addresses that listeners can use. The following are valid values:  
  
 -- If you leave the parameter blank, no IPv6 addresses can be used.  
  
 -- If you enter a wildcard character (*), any IPv6 address can be used.  
  
 -- If you enter a list of IP ranges, any IP address in the specified ranges can be used. Separate the ranges by using a comma (,"), and specify each range as a pair of IPv6 addresses in cloned-hexadecimal format, separated by a hyphen (-). Make sure that the smaller value occurs first in the pair.  The ranges are inclusive.  
  
 Note: An IPv6 literal string is enclosed in brackets and contains hexadecimal numbers that are separated by colons. For example: [::1] or [3ffe:ffff::6ECB:0101].  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Issuer <String\>  
 Specifies the name of the certification authority that issued the certificate.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Kerberos <Boolean\>  
 Allows the client to use Kerberos authentication. Kerberos authentication is a scheme in which the client and server mutually authenticate by using Kerberos certificates.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### ListeningOn <String\>  
 Specifies the IP address or all the IP addresses on which the service is actually listening. This is derived from the Address element based upon the actual IPs associated with the listener. The value of the IP address must be in IPv4 dotted-decimal notation or in IPv6 colon-delimited hexadecimal notation. Multiple ListeningOn entries exist, each entry starting with ListeningOn_. For example:  
  
 ListeningOn_1201550598  
  
 ListeningOn_1973755898  
  
 ListeningOn_1508953035  
  
 ListeningOn_1560839940  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### MaxBatchItems <Unsigned Long Integer\>  
 Specifies the maximum number of elements that can be used in a Pull response. You can specify any value from 1 through 4294967295.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxConcurrentUsers <Unsigned Long Integer\>  
 Specifies the maximum number of users who can concurrently perform remote operations on the same computer through a remote shell. New shell connections  will be rejected if they exceed the specified limit. You can specify any value from 1 through 100.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxEnvelopeSizekb <Unsigned Long Integer\>  
 Specifies the maximum SOAP data in kilobytes. You can specify any value from 32 through 4294967295.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxMemoryPerShellMB <Unsigned Long Integer\>  
 Specifies the maximum total amount of memory that can be allocated by an active remote shell and all its child processes. You can specify any value from 0 through 2147483647. A value of 0 means that the ability of the remote operations  to allocate memory is limited only by the available virtual memory. The default value is 0.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxProcessesPerShell <Unsigned Long Integer\>  
 Specifies the maximum number of processes that any shell operation is allowed to start. You can specify any number from 0 through 2147483647. A value of 0 allows for an unlimited number of processes. By default, the limit is five processes per shell.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxProviderRequests <Unsigned Long Integer\>  
 Specifies the maximum number of concurrent requests that are allowed by the service. You can specify any value from 1 through 4294967295. The limit is applied per provider.  
  
 Note: This value is deprecated and should not be used.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### MaxShellsPerUser <Unsigned Long Integer\>  
 Specifies the maximum number of concurrent shells that any user can remotely open on the same system. If this policy setting is enabled, the user will not be able to open new remote shells  if the count exceeds the specified limit. If this policy setting is disabled or is not configured, by default, the limit will be set to two remote shells per user. You can specify any number from 0 through 2147483647. A value of 0 allows for an unlimited number of shells.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxTimeoutMs <Unsigned Long Integer\>  
 Specifies the maximum time-out in milliseconds that can be used for any request except for Pull requests. You can specify any number from  500 to 4294967295.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Name <String\>  
 Specifies a display name for the WS-Management session . You can use the name to refer to the session when using other cmdlets, such as [Get-PSSession](../../Microsoft.PowerShell.Core/Get-PSSession.md) and [Enter-PSSession](../../Microsoft.PowerShell.Core/Enter-PSSession.md). The name does not have to be unique to the computer or to the current session.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Name (Plugin) <String\>  
 Specifies the display name to use for the plug-in. If an error is returned by the plug-in, the display name will be put in the error XML that is returned to the client application. The name is not locale specific.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Negotiate <Boolean\>  
 Allows the client to use Negotiate authentication. Negotiate authentication is a scheme in which the client sends a request to the server to authenticate. The server determines whether to use the Kerberos protocol or NTLM. The Kerberos protocol is selected to authenticate a domain account, and NTLM is selected for local computer accounts. The user name must be specified in the domain\user_name form for a domain user. The user name must be specified in the server_name\user_name format for a local user on a server computer.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### NetworkDelayMs <Unsigned Long Integer\>  
 Specifies the extra time in milliseconds that the client computer waits to accommodate for network delay time. You can specify any value from 500 through 4294967295.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Password <String\>  
 Specifies the password for a local or a domain account. It cannot be NULL.  
  
 The client computer can specify the credentials to use when creating  a shell on a computer. The user name must be specified in the domain\user_name form for a domain user. The user name must be specified in the server_name\user_name format for a local user on a server computer.  
  
 If you use this structure, then it should have both the user name and password fields specified. It can be used with Basic, Digest, Negotiate, or Kerberos authentication. The client must explicitly specify the credentials when either Basic or Digest authentication is used.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Plugin <>  
 WS-Management  plug-ins are native dynamic link libraries (DLLs) that plug in to and extend the functionality of WS-Management . The WSW-Management Plug-in API  provides functionality that enables a user to write plug-ins by implementing certain APIs for supported resource URIs and operations. After the plug-ins are configured for either the WS-Management (WinRM) service or for Internet Information Services (IIS), the plug-ins are loaded in the WS-Management host or in the IIS host, respectively. Remote requests are routed to these plug-in entry points to perform operations.  
  
#### Cmdlets supported:  
  
-   [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)  
  
-   [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)  
  
### Port <Unsigned Short Integer\>  
 Specifies the TCP port for which this listener is created. You can specify any value from 1 through 65535.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Resource <String\>  
 Specifies an endpoint that represents a distinct type of management operation or value. A service exposes one or more resources, and some resources can have more than one instance. A management resource is similar to a WMI class or to a database table, and an instance is similar to an instance of the class or to a row in the table. For example, the Win32_LogicalDisk class represents a resource. Win32_LogicalDisk="C:\\" is a specific instance of the resource.  
  
 A Uniform Resource Identifier (URI) contains a prefix and a path to a resource. For example:  
  
 http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk  
  
 http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### ResourceURI <String\>  
 Specifies the Uniform Resource Identifier (URI) that identifies a specific type of resource, such as a disk or a process, on a computer.  
  
 A URI consists of a prefix and a path to a resource. For example:  
  
 http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk  
  
 http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### RootSDDL <String\>  
 Specifies the Security Descriptor Definition Language (SDDL) for the access control entry. This identifies the security settings that are used to authorize access to a specified resource URI.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### SDKVersion <String\>  
 Specifies the version of the WS-Management plug-in SDK.  The only valid value is 1.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Shell <String\>  
 Specifies the process string for the custom shell. You can specify environment variables.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### ShellTimeout <Unsigned Long Integer\>  
 Specifies the length of time before the shell times out due to inactivity.  Specify the time-out value in milliseconds.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Subject <String\>  
 Specifies the entity that is identified by the certificate.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### SupportsOptions <Boolean\>  
 Specifies whether the plug-in supports the use of options, which are passed within the wsman:OptionSet header in a request message.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Transport <String\>  
 Specifies the transport to use to send and receive WS-Management protocol requests and responses. The value must be either HTTP or HTTPS.  
  
 Note: The Transport value is set when creating a Listener.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### TrustedHosts <String\>  
 List of remote computers that are connected to the local computer through a trusted network connection.  Requests are allowed to be sent to computers specified in this list when using an authentication scheme and transport that does not allow the client to authenticate the service, such as Basic authentication over HTTP.  
  
 If a server is specified in TrustedHosts, the client does not authenticate the server's identity, leaving it vulnerable to man-in-the-middle attacks.  You should only specify hostnames when the network connection is safe from malicious users, such as in a Domain environment.  
  
 The specified host names can be either Domain Name System (DNS) names or IP addresses. The following values are valid:  
  
 -- Blank: No hosts are trusted.  
  
 -- The asterisk "*" character: All hosts are trusted.  
  
 A list of host name patterns separated by commas (,) The host name patterns must be formatted as follows:  
  
 -- A string that starts with the wildcard character (*). The string must contain at least two characters. All the hosts that share the suffix are trusted.  
  
 -- A string that ends with the wildcard character (*). The string must contain at least two characters. All the hosts that share the prefix are trusted.  
  
 -- All NetBIOS names are trusted (for example, strings that do not contain a period).  
  
 -- A string without the wildcard character (*): The host named by the string is trusted.  
  
 Note: When the TrustedHosts value is set with the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet, the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet supports an additional parameter -Concatenate.  The following example will append a new value (*.domain2.com) to the old value stored in TrustedHost:  
  
 [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) .\TrustedHosts *.domain2.com -Concatenate -Force  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### URI <String\>  
 Identifies the URI for which access is authorized based on the value of the Sddl parameter.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### URLPrefix <String\>  
 A URL prefix on which to accept HTTP or HTTPS requests. This is a string containing only the characters a-z, A-Z, 9-0, underscore (_) and backslash (/). The string must not start with or end with a backslash (/). For example, if the computer name is SampleComputer, the WS-Management client would specify http://SampleMachine/URLPrefix in the destination address.  
  
#### Cmdlets supported:  
  
-   [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### UserName <String\>  
 Specifies the user name for a local account or for a domain account. It cannot have a value of NULL.  
  
 The client can specify the credentials to use when creating  a shell on a computer. The user name must be specified in the domain\user_name format for a domain account. The user name must be specified in the server_name\user_name format for a local account on a server computer.  
  
 If this structure is used, it must have both the username and password fields specified . It can be used with Basic, Digest, Negotiate, or Kerberos authentication. The client  must explicitly specify the credentials when either Basic or Digest authentication is used.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### Value <String\>  
 Specifies the value of an initialization parameter, which is a plug-in-specific value that is used to specify configuration options.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### XMLRenderingType <String\>  
 Specifies the format in which XML is passed to plug-ins through the WSMAN_DATA object. The following are valid values:  
  
 Text: Incoming XML data is contained in a WSMAN_DATA_TYPE_TEXT structure, which represents the XML as a PCWSTR memory buffer.  
  
 XMLReader:  Incoming XML data is contained in a WSMAN_DATA_TYPE_WS_XML_READER structure, which represents the XML as an XmlReader object, which is defined in the WebServices.h header file.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### xmlns <String\>  
 A string that specifies specifies a Uniform Resource Name (URN) that uniquely identifies the namespace.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### lang <String\>  
 A string that specifies a language, or a language-region with language and region separated by a hyphen.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### HTTP <Unsigned Short Integer\>  
 Specifies the port that the client will use when HTTP is used. By default, HTTP uses port 80. You can specify any value from 1 through 65535.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### HTTPS <Unsigned Short Integer\>  
 Specifies the port that the client will use when HTTPS is used. By default, HTTPS uses port 443. You can specify any value from 1 through 65535.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  
  
### MaxShellRunTime <Unsigned Long Integer\>  
 Note: This value is deprecated and the value is no longer used.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)  
  
### MaxShellRunTime <Unsigned Long Integer\>  
 Note: This value is deprecated and the value is no longer used.  
  
#### Cmdlets supported:  
  
-   [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)

