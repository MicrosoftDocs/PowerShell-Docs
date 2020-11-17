---
description: WSMan
Locale: en-US
ms.date: 10/18/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/about/about_wsman_provider?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: WSMan Provider
---
# WSMan Provider

## Provider name

WSMan

## Drives

`WSMan:`

## Short description

Provides access to Web Services for Management (WS-Management) configuration
information.

## Detailed description

The **WSMan** provider for PowerShell lets you add, change, clear, and
delete WS-Management configuration data on local or remote computers.

The **WSMan** provider exposes a PowerShell drive with a directory
structure that corresponds to a logical grouping of WS-Management configuration
settings. These groupings are known as containers.

Beginning in Windows PowerShell 3.0, the **WSMan** provider has been
updated to support new properties for session configurations, such as
**OutputBufferingMode**. The session configurations appear as items in the
Plugin directory of the `WSMan:` drive and the properties appear as items in
each session configuration.

The **WSMan** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location](xref:Microsoft.PowerShell.Management.Get-Location)
- [Set-Location](xref:Microsoft.PowerShell.Management.Set-Location)
- [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item)
- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)
- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)
- [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item)

> [!NOTE]
> You can use commands in the `WSMan:` drive to change the values of the new
> properties. However, you cannot use the `WSMan:` drive in PowerShell 2.0
> to change properties that are introduced in Windows PowerShell 3.0.
> Although no error is generated, the commands are not effective To change these
> settings, use the **WSMan** drive in Windows PowerShell 3.0.

### Organization of the WSMan: Drive

- **Client**: You can configure various aspects of the WS-Management client. The
  configuration information is stored in the registry.

- **Service**: You can configure various aspects of the WS-Management service.
  The configuration information is stored in the registry.
  > [!NOTE]
  > Service configuration is sometimes referred to as Server configuration.

- **Shell**: You can configure various aspects of the WS-Management shell, such
  as the setting to allow remote shell access (**AllowRemoteShellAccess**) and
  the maximum number of concurrent users allowed (**MaxConcurrentUsers**).

- **Listener**: You can create and configure a listener. A listener is a
  management service that implements the WS-Management protocol to send and to
  receive messages.

- **Plugin**: Plug-ins are loaded and used by the WS-Management service to
  provide various functions. By default, PowerShell provides three plug-ins:
  - The Event Forwarding plug-in.
  - The Microsoft.PowerShell plug-in.
  - The Windows Management Instrumentation (WMI) Provider plug-in.
  These three plug-ins support event forwarding, configuration, and WMI access.

- **ClientCertificate**: You can create and configure a client certificate.
  A client certificate is used when the WS-Management client is configured to
  use certificate authentication.

### Directory Hierarchy of the WSMan Provider

The directory hierarchy of the WSMan provider for the local computer is as
follows.

```
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
```

The directory hierarchy of the WSMan provider for a remote computer is the same
as a local computer. However, in order to access the configuration settings of
a remote computer, you need to make a connection to the remote computer using
[Connect-WSMan](xref:Microsoft.WSMan.Management.Connect-WSMan). Once a connection is made to a remote
computer, the name of the remote computer shows up in the provider.

```
WSMan:\<Remote_Computer_Name>
```

## Navigating the WSMan: Drive

This command uses the `Set-Location` cmdlet to change the current location to
the `WSMan:` drive.

```powershell
Set-Location WSMan:
```

To return to a file system drive, type the drive name. For example, type.

```powershell
Set-Location C:
```

### Navigating to a remote system store location

This command uses the `Set-Location` command to change the current location
to the root location in the remote system store location. Use a backslash `\`
or forward slash `/` to indicate a level of the `WSMan:` drive.

```powershell
Set-Location -Path  WSMan:\SERVER01
```

> [!NOTE]
> The above command assume that a connection to the remote system already
> exists.

## Displaying the Contents of the WSMan: Drive

This command uses the `Get-Childitem` cmdlet to display the WS-Management stores
in the Localhost store location.

```powershell
Get-ChildItem -path WSMan:\Localhost
```

If you are in the `WSMan:` drive, you can omit the drive name.

This command uses the `Get-Childitem` cmdlet to display the WS-Management
stores in the remote computer "SERVER01" store location.

```powershell
Get-ChildItem -path WSMan:\SERVER01
```

> [!NOTE]
> The above command assume that a connection to the remote system already
> exists.

## Setting the value of items in the  WSMAN: drive

You can use the `Set-Item` cmdlet to change configuration settings in the
`WSMAN` drive. The following example sets the **TrustedHosts** value to
accept all hosts with the suffix "contoso.com".

```powershell
# You do not need to specify the -Path parameter name when using Set-Item.
PS WSMAN:\localhost\Client> Set-Item .\TrustedHosts -Value "*.contoso.com"
```

The `Set-Item` cmdlet supports an additional parameter `-Concatenate` that
appends a value instead of changing it. The following example will append a
new value "*.domain2.com" to the old value stored in `TrustedHost:`

```powershell
Set-Item WSMAN:\localhost\Client\TrustedHosts *.domain2.com -Concatenate
```

## Creating items in the WSMAN: drive

### Creating a new listener

The `New-Item` cmdlet creates items within a provider drive. Each provider
has different item types that you can create. In the `WSMAN:` drive, you can
create *Listeners* which you configure to receive and respond to remote
requests. The following command creates a new HTTP listener using the `New-Item`
cmdlet.

```powershell
New-Item -Path WSMan:\localhost\Listener -Address * -Transport HTTP -force
```

### Creating a new plug-in

This command creates (registers) a plug-in for the WS-Management service.

```powershell
New-Item -Path WSMan:\localhost\Plugin `
         -Plugin TestPlugin `
         -FileName %systemroot%\system32\WsmWmiPl.dll `
         -Resource http://schemas.dmtf.org/wbem/wscim/2/cim-schema `
         -SDKVersion 1 `
         -Capability "Get","Put","Invoke","Enumerate" `
         -XMLRenderingType text
```

### Creating a new resource entry

This command creates a resource entry in the Resources directory of
a TestPlugin. This command assumes that a TestPlugin has been created using
a separate command.

```powershell
New-Item -Path WSMan:\localhost\Plugin\TestPlugin\Resources `
         -ResourceUri http://schemas.dmtf.org/wbem/wscim/3/cim-schema `
         -Capability "Enumerate"

```

### Creating a new security entry for a resource

This command creates a security entry in the Security directory of
Resource_5967683 (a specific resource). This command assumes that the resource
entry has been created using a separate command.

```powershell
$path = "WSMan:\localhost\Plugin\TestPlugin\Resources\Resource_5967683"
New-Item -Path $path\Security `
         -Sddl "O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;SA;GWGX;;;WD)"
```

### Creating a new Client Certificate

This command creates **ClientCertificate** entry that can be used by the
WS-Management client. The new **ClientCertificate** will show up under the
**ClientCertificate** directory as "ClientCertificate_1234567890". All of the
parameters are mandatory. The **Issuer** needs to be thumbprint of the issuers
certificate.

```powershell
$cred = Get-Credential
New-Item -Path WSMan:\localhost\ClientCertificate `
         -Issuer 1b3fd224d66c6413fe20d21e38b304226d192dfe `
         -URI wmicimv2/* `
         -Credential $cred;
```

### Creating a new Initialization Parameter

This command creates an Initialization parameter named "testparametername"
in the "InitializationParameters" directory. This command assumes that the
"TestPlugin" has been created using a separate command.

```powershell
New-Item -Path WSMan:\localhost\Plugin\TestPlugin\InitializationParameters `
         -ParamName testparametername `
         -ParamValue testparametervalue
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive.

### Address \<String\>

Specifies the address for which this listener was created. The value can be one
of the following:

- The literal string "*". (The wildcard character (`*`) makes the command bind
  all the IP addresses on all the network adapters.)
- The literal string "IP:" followed by a valid IP address in either IPv4
  dotted-decimal format or in IPv6 cloned-hexadecimal format.
- The literal string "MAC:" followed by the MAC address of an adapter.
  For example: MAC:32-a3-58-90-be-cc.

> [!NOTE]
> The Address value is set when creating a Listener.

#### Cmdlets supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Capability \<Enumeration\>

When working with *Plug-ins* this parameter specifies an operation that is
supported on this Uniform Resource Identifier (URI). You have to create one
entry for each type of operation that the URI supports. You can specify
any valid attributes for a given operation, if the operation supports it.

These attributes include **SupportsFiltering** and **SupportsFragment**.

- **Create**: Create operations are supported on the URI.
  - The **SupportFragment**  attribute is used if the Create operation
    supports the concept.
  - The **SupportFiltering** attribute is NOT valid for Create operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Delete**: Delete operations are supported on the URI.
  - The **SupportFragment** attribute is used if the Delete operation supports
    the concept.
  - The **SupportFiltering** attribute is NOT valid for Delete operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Enumerate**: Enumerate operations are supported on the URI.
  - The **SupportFragment** attribute is NOT supported for Enumerate operations
    and should be set to False.
  - The **SupportFiltering** attribute is valid, and if the plug-in supports
    filtering, this attribute should be set to "True".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Get**: Get operations are supported on the URI.
  - The **SupportFragment** attribute is used if the Get operation supports the
    concept.
  - The **SupportFiltering** attribute is NOT valid for Get operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Invoke**: Invoke operations are supported on the URI.
  - The **SupportFragment** attribute is not supported for Invoke operations
    and should be set to False.
  - The **SupportFiltering** attribute is not valid and should be set to
    "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Put**: Put operations are supported on the URI.
  - The **SupportFragment** attribute is used if the Put operation supports the
    concept.
  - The **SupportFiltering** attribute is not valid for Put operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Subscribe**: Subscribe operations are supported on the URI.
  - The **SupportFragment** attribute is not supported for Subscribe operations
    and should be set to False.
  - The **SupportFiltering** attribute is not valid for Subscribe operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if Shell operations are also
  > supported.
- **Shell**: Shell operations are supported on the URI.
  - The **SupportFragment** attribute is not supported for Shell operations and
    should be set to "False".
  - The **SupportFiltering** attribute is not valid for Shell operations and
    should be set to "False".
  > [!NOTE]
  > This operation is not valid for a URI if ANY other operation is also
  > supported.
  > [!NOTE]
  > If a Shell operation is configured for a URI, Get, Put, Create, Delete,
  > Invoke, and Enumerate operations are processed internally within the
  > WS-Management (WinRM) service to manage shells. As a result, the plug-in
  > cannot handle the operations.

#### Cmdlets supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### CertificateThumbprint \<String\>

Specifies the thumbprint of the service certificate.

This value represents the string of two-digit hexadecimal values in the
Thumbprint field of the certificate. It specifies the digital public key
certificate (X509) of a user account that has permission to perform this
action. Certificates are used in client certificate-based authentication. They
can be mapped only to local user accounts, and they do not work with domain
accounts. To get a certificate thumbprint, use the `Get-Item` or `Get-ChildItem`
cmdlets in the PowerShell `Cert:` drive.

#### Cmdlets supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Enabled \<Boolean\>

Specifies whether the listener is enabled or disabled. The default is True.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### FileName (Plugin) \<String\>

Specifies the file name of the operations plug-in. Any environment variables
that are put in this entry will be expanded in the users' context when a
request is received. Because each user could have a different version of the
same environment variable, each user could have a different plug-in. This entry
cannot be blank and must point to a valid plug-in.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### HostName \<String\>

Specifies the host name of the computer on which the WS-Management (WinRM)
service is running.

The value must be a fully qualified domain name, an IPv4 or IPv6 literal
string, or a wildcard character.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Issuer \<String\>

Specifies the name of the certification authority that issued the certificate.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Plugin \<\> WS-Management plug-ins are native dynamic link libraries (DLLs)

that plug in to and extend the functionality of WS-Management . The
WSW-Management Plug-in API provides functionality that enables a user to write
plug-ins by implementing certain APIs for supported resource URIs and
operations. After the plug-ins are configured for either the WS-Management
(WinRM) service or for Internet Information Services (IIS), the plug-ins are
loaded in the WS-Management host or in the IIS host, respectively. Remote
requests are routed to these plug-in entry points to perform operations.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Port \<Unsigned Short Integer\>

Specifies the TCP port for which this listener is created. You can specify any
value from 1 through 65535.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Resource \<String\>

Specifies an endpoint that represents a distinct type of management operation
or value. A service exposes one or more resources, and some resources can have
more than one instance. A management resource is similar to a WMI class or to a
database table, and an instance is similar to an instance of the class or to a
row in the table. For example, the **Win32_LogicalDisk** class represents a
resource. `Win32_LogicalDisk="C:\\"` is a specific instance of the resource.

A Uniform Resource Identifier (URI) contains a prefix and a path to a resource.
For example:

`http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk`

`http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor`

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Resource \<String\>

Specifies the Uniform Resource Identifier (URI) that identifies a specific type
of resource, such as a disk or a process, on a computer.

A URI consists of a prefix and a path to a resource. For example:

`http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk`

`http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor`

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### SDKVersion \<String\>

Specifies the version of the WS-Management plug-in SDK. The only valid value is
1.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Subject \<String\>

Specifies the entity that is identified by the certificate.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Transport \<String\>

Specifies the transport to use to send and receive WS-Management protocol
requests and responses. The value must be either HTTP or HTTPS.

Note: The Transport value is set when creating a Listener.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### URI \<String\>

Identifies the URI for which access is authorized based on the value of the
Sddl parameter.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### URLPrefix \<String\>

A URL prefix on which to accept HTTP or HTTPS requests. This is a string
containing only the characters `[a-z]`, `[A-Z]`, `[9-0]`,
underscore (`_`) and backslash (`/`). The string must not start with or end
with a backslash (`/`). For example, if the computer name is "SampleComputer",
the WS-Management client would specify `http://SampleMachine/URLPrefix`
in the destination address.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### Value \<String\>

Specifies the value of an initialization parameter, which is a plug-in-specific
value that is used to specify configuration options.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

### XMLRenderingType \<String\>

Specifies the format in which XML is passed to plug-ins through the
**WSMAN_DATA** object. The following are valid values:

- Text: Incoming XML data is contained in a **WSMAN_DATA_TYPE_TEXT** structure,
  which represents the XML as a **PCWSTR** memory buffer.
- XMLReader: Incoming XML data is contained in a
  **WSMAN_DATA_TYPE_WS_XML_READER** structure, which represents the XML as an
  **XmlReader** object, which is defined in the "WebServices.h" header file.

#### Cmdlets Supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

## Using the pipeline

Provider cmdlets accept pipeline input. You can use the pipeline to simplify
task by sending provider data from one cmdlet to another provider cmdlet.
To read more about how to use the pipeline with provider cmdlets, see the
cmdlet references provided throughout this article.

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) command in a file
system drive or use the `-Path` parameter of
[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) to specify a file
system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path wsman:
```

## See also

[about_Providers](../../Microsoft.PowerShell.Core/About/about_Providers.md)

