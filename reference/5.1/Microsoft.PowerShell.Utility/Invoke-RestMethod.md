---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Invoke RestMethod
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821824
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Invoke-RestMethod

## SYNOPSIS
Sends an HTTP or HTTPS request to a RESTful web service.

## SYNTAX

```
Invoke-RestMethod [-Method <WebRequestMethod>] [-UseBasicParsing] [-Uri] <Uri>
 [-WebSession <WebRequestSession>] [-SessionVariable <String>] [-Credential <PSCredential>]
 [-UseDefaultCredentials] [-CertificateThumbprint <String>] [-Certificate <X509Certificate>]
 [-UserAgent <String>] [-DisableKeepAlive] [-TimeoutSec <Int32>] [-Headers <IDictionary>]
 [-MaximumRedirection <Int32>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-ProxyUseDefaultCredentials]
 [-Body <Object>] [-ContentType <String>] [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>]
 [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
The **Invoke-RestMethod** cmdlet sends HTTP and HTTPS requests to Representational State Transfer (REST) web services that returns richly structured data.

Windows PowerShell formats the response based to the data type.
For an RSS or ATOM feed, Windows PowerShell returns the Item or Entry XML nodes.
For JavaScript Object Notation (JSON) or XML, Windows PowerShell converts (or deserializes) the content into objects.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Get the PowerShell RSS feed
Get the latest feeds from the PowerShell team's blog.

```PowerShell
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ |
    Format-Table -Property Title, PubDate
```

```
PS C:\ >Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ |
    Format-Table -Property Title, PubDate



title                                                                pubDate                        
-----                                                                -------                        
Join the PowerShell 10th Anniversary Celebration!                    Tue, 08 Nov 2016 23:00:04 +0000
DSC Resource Kit November 2016 Release                               Thu, 03 Nov 2016 00:19:07 +0000
PSScriptAnalyzer Community Call - Oct 18, 2016                       Thu, 13 Oct 2016 17:52:35 +0000
New Home for In-Box DSC Resources                                    Sat, 08 Oct 2016 07:13:10 +0000
New Social Features on Gallery                                       Fri, 30 Sep 2016 23:04:34 +0000
PowerShellGet and PackageManagement in PowerShell Gallery and GitHub Thu, 29 Sep 2016 22:21:42 +0000
PowerShell Security at DerbyCon                                      Wed, 28 Sep 2016 01:13:19 +0000
DSC Resource Kit September Release                                   Thu, 22 Sep 2016 00:25:37 +0000
PowerShell DSC and implicit remoting broken in KB3176934             Tue, 23 Aug 2016 15:07:50 +0000
PowerShell on Linux and Open Source!                                 Thu, 18 Aug 2016 15:32:02 +0000



PS C:\ >
```

This command uses the **Invoke-RestMethod** cmdlet
to get information from the Windows PowerShell Blog RSS feed.
The command uses the Format-Table cmdlet
to display the values of the Title and pubDate properties of each blog in a table.

### Example 2: Perform a POST request
In the following example,
a user runs **Invoke-RestMethod**
to perform a POST request on an intranet website in the user's organization.

```PowerShell
$Cred = Get-Credential

# Next, allow the use of self-signed SSL certificates.

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }

# Create variables to store the values consumed by the Invoke-RestMethod command.
# The search variable contents are later embedded in the body variable.

$Server = 'server.contoso.com'
$Url = "https://${server}:8089/services/search/jobs/export"
$Search = "search index=_internal | reverse | table index,host,source,sourcetype,_raw"

# The cmdlet handles URL encoding. The body variable describes the search criteria, specifies CSV as the output mode, and specifies a time period for returned data that starts two days ago and ends one day ago. The body variable specifies values for parameters that apply to the particular REST API with which Invoke-RestMethod is communicating.

$Body = @{
    search = $Search
    output_mode = "csv"
    earliest_time = "-2d@d"
    latest_time = "-1d@d"
}

# Now, run the Invoke-RestMethod command with all variables in place, specifying a path and file name for the resulting CSV output file.

Invoke-RestMethod -Method Post -Uri $url -Credential $Cred -Body $body -OutFile output.csv

{"preview":true,"offset":0,"result":{"sourcetype":"contoso1","count":"9624"}}

{"preview":true,"offset":1,"result":{"sourcetype":"contoso2","count":"152"}}

{"preview":true,"offset":2,"result":{"sourcetype":"contoso3","count":"88494"}}

{"preview":true,"offset":3,"result":{"sourcetype":"contoso4","count":"15277"}}
```

## PARAMETERS

### -Body
Specifies the body of the request.
The body is the content of the request that follows the headers.
You can also pipe a body value to **Invoke-RestMethod**.

The *Body* parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

**Warning**: *The verbose output of a POST body will end with `with -1-byte payload`, even though the size of the body is both known and sent in the `Content-Length` HTTP header.*

When the body is a form, or it is the output of another **Invoke-WebRequest** call, Windows PowerShell sets the request content to the form fields.

For example:

```powershell
$R = Invoke-WebRequest http://website.com/login.aspx
$R.Forms[0].Name = "MyName"
$R.Forms[0].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $R
```

or

```powershell
Invoke-RestMethod http://website.com/service.aspx -Body $R.Forms[0]
```

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Certificate
Specifies the client certificate that is used for a secure web request.
Enter a variable that contains a certificate or a command or expression that gets the certificate.

To find a certificate, use Get-PfxCertificate or use the Get-ChildItem cmdlet in the Certificate (Cert:) drive.
If the certificate is not valid or does not have sufficient authority, the command fails.

```yaml
Type: X509Certificate
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint
Specifies the digital public key certificate (X509) of a user account that has permission to send the request.
Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication.
They can be mapped only to local user accounts; they do not work with domain accounts.

To get a certificate thumbprint, use the Get-Item or Get-ChildItem command in the Windows PowerShell Cert: drive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType
Specifies the content type of the web request.

If this parameter is omitted and the request method is POST, **Invoke-RestMethod** sets the content type to application/x-www-form-urlencoded.
Otherwise, the content type is not specified in the call.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to send the request.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableKeepAlive
Indicates that the cmdlet sets the KeepAlive value in the HTTP header to False.
By default, KeepAlive is True.
KeepAlive establishes a persistent connection to the server to facilitate subsequent requests.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers
Specifies the headers of the web request.
Enter a hash table or dictionary.

To set UserAgent headers, use the *UserAgent* parameter.
You cannot use this parameter to specify UserAgent or cookie headers.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InFile
Specifies the file for which this cmdlet gets the content of the web request.

Enter a path and file name.
If you omit the path, the default is the current location.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumRedirection
Specifies how many times Windows PowerShell redirects a connection to an alternate Uniform Resource Identifier (URI) before the connection fails.
The default value is 5.
A value of 0 (zero) prevents all redirection.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
Specifies the method used for the web request.
The acceptable values for this parameter are:

- Default
- Delete
- Get
- Head
- Merge
- Options
- Patch
- Post
- Put
- Trace

```yaml
Type: WebRequestMethod
Parameter Sets: (All)
Aliases:
Accepted values: Default, Get, Head, Post, Put, Delete, Trace, Options, Merge, Patch

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Specifies the output file that this cmdlet saves the response body.
Enter a path and file name.
If you omit the path, the default is the current location.

By default, **Invoke-RestMethod** returns the results to the pipeline.
To send the results to a file and to the pipeline, use the *Passthru* parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Indicates that the cmdlet returns the results, in addition to writing them to a file.
This parameter is valid only when the **OutFile** parameter is also used in the command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy
Specifies that the cmdlet uses a proxy server for the request, rather than connecting directly to the Internet resource.
Enter the URI of a network proxy server.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyCredential
Specifies a user account that has permission to use the proxy server that is specified by the *Proxy* parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.

This parameter is valid only when the *Proxy* parameter is also used in the command.
You cannot use the *ProxyCredential* and *ProxyUseDefaultCredentials* parameters in the same command.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyUseDefaultCredentials
Indicates that the cmdlet uses the credentials of the current user to access the proxy server that is specified by the *Proxy* parameter.

This parameter is valid only when the *Proxy* parameter is also used in the command.
You cannot use the *ProxyCredential* and *ProxyUseDefaultCredentials* parameters in the same command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionVariable
Specifies a variable for which this cmdlet creates a web request session and saves it in the value.
Enter a variable name without the dollar sign ($) symbol.

When you specify a session variable, **Invoke-RestMethod** creates a web request session object and assigns it to a variable with the specified name in your Windows PowerShell session.
You can use the variable in your session as soon as the command completes.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To use the web request session in subsequent web requests, specify the session variable in the value of the *WebSession* parameter.
Windows PowerShell uses the data in the web request session object when establishing the new connection.
To override a value in the web request session, use a cmdlet parameter, such as *UserAgent* or *Credential*.
Parameter values take precedence over values in the web request session.

You cannot use the *SessionVariable* and *WebSession* parameters in the same command.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SV

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSec
Specifies how long the request can be pending before it times out.
Enter a value in seconds.
The default value, 0, specifies an indefinite time-out.

A Domain Name System (DNS) query can take up to 15 seconds to return or time out.
If your request contains a host name that requires resolution, and you set *TimeoutSec* to a value greater than zero, but less than 15 seconds, it can take 15 seconds or more before a WebException is thrown, and your request times out.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransferEncoding
Specifies a value for the transfer-encoding HTTP response header.
The acceptable values for this parameter are:

- Chunked
- Compress
- Deflate
- GZip
- Identity

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: chunked, compress, deflate, gzip, identity

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
Specifies the Uniform Resource Identifier (URI) of the Internet resource to which the web request is sent.
This parameter supports HTTP, HTTPS, FTP, and FILE values.

This parameter is required.
The parameter name (*Uri*) is optional.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseBasicParsing
Indicates that the cmdlet uses basic parsing.

The *Body* parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of another **Invoke-WebRequest** call, Windows PowerShell sets the request content to the form fields.

For example:

`$R = Invoke-WebRequest http://website.com/login.aspx`
`$R.Forms\[0\].Name = "MyName"`
`$R.Forms\[0\].Password = "MyPassword"`
`Invoke-RestMethod http://website.com/service.aspx -Body $R`

- or -

`Invoke-RestMethod http://website.com/service.aspx -Body $R.Forms\[0\]`

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredentials
Indicates that the cmdlet uses the credentials of the current user to send the web request.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent
Specifies a user agent string for the web request.

The default user agent is similar to Mozilla/5.0 (Windows NT; Windows NT 6.1; en-US) WindowsPowerShell/3.0 with slight variations for each operating system and platform.

To test a website with the standard user agent string that is used by most Internet browsers, use the properties of the PSUserAgenthttp://msdn.microsoft.com/en-us/library/windows/desktop/hh484857(v=vs.85).aspx class, such as Chrome, FireFox, InternetExplorer, Opera, and Safari.

For example, the following command uses the user agent string for Internet.

`Invoke-WebRequest -Uri http://website.com/ -UserAgent (\[Microsoft.PowerShell.Commands.PSUserAgent\]::InternetExplorer)`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebSession
Specifies a web request session.
Enter the variable name, including the dollar sign ($).

To override a value in the web request session, use a cmdlet parameter, such as *UserAgent* or *Credential*.
Parameter values take precedence over values in the web request session.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To create a web request session, enter a variable name (without a dollar sign) in the value of the *SessionVariable* parameter of an **Invoke-RestMethod** command.
**Invoke-RestMethod** creates the session and saves it in the variable.
In subsequent commands, use the variable as the value of the *WebSession* parameter.

You cannot use the *SessionVariable* and *WebSession* parameters in the same command.

```yaml
Type: WebRequestSession
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
You can pipe the body of a web request to **Invoke-Rest-Method**.

## OUTPUTS

### System.Xml.XmlDocument, Microsoft.PowerShell.Commands.HtmlWebResponseObject, System.String
The output of the cmdlet depends upon the format of the content that is retrieved.

### PSObject
If the request returns JSON strings, **Invoke-RestMethod** returns a **PSObject** that represents the strings.

## NOTES

## RELATED LINKS

[ConvertTo-Json](ConvertTo-Json.md)

[ConvertFrom-Json](ConvertFrom-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

