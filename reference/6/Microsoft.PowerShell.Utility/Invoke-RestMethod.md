---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821824
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Invoke-RestMethod
---

# Invoke-RestMethod

## Synopsis
Sends an HTTP or HTTPS request to a RESTful web service.

## Syntax

```powershell
Invoke-RestMethod [-Method <WebRequestMethod>] [-CustomMethod <String>] [-UseBasicParsing] [-Uri] <Uri>
 [-WebSession <WebRequestSession>] [-SessionVariable <String>] [-Credential <PSCredential>]
 [-UseDefaultCredentials] [-CertificateThumbprint <String>] [-Certificate <X509Certificate>] [-SkipCertificateCheck]
 [-UserAgent <String>] [-DisableKeepAlive] [-TimeoutSec <Int32>] [-Headers <IDictionary>] [-SkipHeaderValidation]
 [-MaximumRedirection <Int32>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-ProxyUseDefaultCredentials]
 [-FollowRelLink] [-MaximumFollowRelLink <Int32>] [-ResponseHeadersVariable <String>]
 [-Body <Object>] [-ContentType <String>] [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>]
 [-PassThru] [<CommonParameters>]
```

## Description
The `Invoke-RestMethod` cmdlet sends HTTP and HTTPS requests to Representational State Transfer (REST) web services that returns richly structured data.

Windows PowerShell formats the response based to the data type.
For an RSS or ATOM feed, Windows PowerShell returns the Item or Entry XML nodes.
For JavaScript Object Notation (JSON) or XML, Windows PowerShell converts (or deserializes) the content into objects.

This cmdlet is introduced in Windows PowerShell 3.0.

## Examples

### Example 1: Get the PowerShell RSS feed
```powershell
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ |
Format-Table -Property Title, pubDate
```

```
Title                                                                pubDate
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
```

This command uses the `Invoke-RestMethod` cmdlet to get information from the Windows PowerShell Blog RSS feed.
The command uses the `Format-Table` cmdlet to display the values of the **Title** and **pubDate** properties of each blog in a table.

### Example 2
In the following example, a user runs `Invoke-RestMethod` to perform a POST request on an intranet website in the user's organization.

```powershell
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

### Example 3: Follow relation links

```powershell
# REST apis that support pagination implement relation links per [RFC5988](https://tools.ietf.org/html/rfc5988#page-6)
# Instead of parsing the header to get the URL for the next page, you can have the cmdlet do this for you
# This example returns the first two pages of issues from the PowerShell GitHub repository

Invoke-RestMethod https://api.github.com/repos/powershell/powershell/issues -FollowRelLink -MaximumFollowRelLink 2
```

## Parameters

### -Body
Specifies the body of the request.
The body is the content of the request that follows the headers.
You can also pipe a body value to `Invoke-RestMethod`.

The `-Body` parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

**Warning**: *The verbose output of a POST body will end with `with -1-byte payload`, even though the size of the body is both known and sent in the `Content-Length` HTTP header.*

When the body is a form, or it is the output of another `Invoke-WebRequest` call, Windows PowerShell sets the request content to the form fields.

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

The *Body* parameter may also accept a `System.Net.Http.MultipartFormDataContent` object. This will facilitate `multipart/form-data` requests. When a `MultipartFormDataContent` object is supplied for *Body*, any Content related headers supplied to the *ContentType*, *Headers*, or *WebSession* parameters will be overridden by the Content headers of the `MultipartFormDataContent` object.

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

To find a certificate, use `Get-PfxCertificate` or use the `Get-ChildItem` cmdlet in the Certificate (`Cert:`) drive.
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

To get a certificate thumbprint, use the `Get-Item` or `Get-ChildItem` command in the Windows PowerShell (`Cert:`) drive.

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

If this parameter is omitted and the request method is POST, `Invoke-RestMethod` sets the content type to "application/x-www-form-urlencoded".
Otherwise, the content type is not specified in the call.

*ContentType* will be overridden when a `MultipartFormDataContent` object is supplied for *Body*.

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

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the `Get-Credential` cmdlet.

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

### -CustomMethod
Specifies custom method used for the web request.

```yaml
Type: String
Parameter Sets: StandardMethod, CustomMethod
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableKeepAlive
Sets the **KeepAlive** value in the HTTP header to False.
By default, **KeepAlive** is True.
**KeepAlive** establishes a persistent connection to the server to facilitate subsequent requests.

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

### -FollowRelLink
Indicates the cmdlet should follow relation links.

To set how many times to follow relation links, use the `-MaximumFollowRelLink` parameter.

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

To set UserAgent headers, use the `-UserAgent` parameter.
You cannot use this parameter to specify UserAgent or cookie headers.

Content related headers, such as `Content-Type` will be overridden when a `MultipartFormDataContent` object is supplied for *Body*.

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

### -SkipHeaderValidation
Indicates the cmdlet should add headers to the request without validation.

This switch should be used for sites that require header values that do not conform to standards. Specifying this switch disables validation to allow the value to be passed unchecked.  When specified, all headers are added without validation.

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

### -InFile
Gets the content of the web request from a file.

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

### -InformationAction
The Body parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters. For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of another `Invoke-WebRequest` call, Windows PowerShell sets the request content to the form fields.

For example:

```powershell
$r = Invoke-WebRequest http://website.com/login.aspx
$r.Forms[0].Name = "MyName"
$r.Forms[0].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $r
```

or

```powershell
Invoke-RestMethod http://website.com/service.aspx -Body $r.Forms[0]
```

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
The Body parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters. For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of another `Invoke-WebRequest` call, Windows PowerShell sets the request content to the form fields.

For example:

```powershell
$r = Invoke-WebRequest http://website.com/login.aspx
$r.Forms[0].Name = "MyName"
$r.Forms[0].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $r
```

or

```powershell
Invoke-RestMethod http://website.com/service.aspx -Body $r.Forms[0]
```

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFollowRelLink
Specifies how many times to follow relation links if `-FollowRelLink` is used.
A smaller value may be needed if the REST api throttles due to too many requests.
The default value is Int32.MaxValue.
A value of 0 (zero) prevents following relation links.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Int32.MaxValue
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumRedirection
Determines how many times Windows PowerShell redirects a connection to an alternate Uniform Resource Identifier (URI) before the connection fails.
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

### -PreserveAuthorizationOnRedirect
Indicates the cmdlet should preserve the Authorization header, when present, across redirections.

By default, the cmdlet strips the Authorization header before redirecting. Specifying this parameter disables this logic for cases where the header needs to be sent to the redirection location.

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

### -Method
Specifies the method used for the web request.
The acceptable values for this parameter are:
* Default
* Delete
* Get
* Head
* Merge
* Options
* Patch
* Post
* Put
* Trace

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

### -NoProxy
Indicates that the cmdlet will not use a proxy to reach the destination.

When you need to bypass the proxy configured in Internet Explorer, or a proxy specified in the environment, use this switch.

```yaml
Type: SwitchParameter
Parameter Sets: StandardMethodNoProxy, CustomMethodNoProxy
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Saves the response body in the specified output file.
Enter a path and file name.
If you omit the path, the default is the current location.

By default, `Invoke-RestMethod` returns the results to the pipeline.
To send the results to a file and to the pipeline, use the `-Passthru` parameter.

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
Returns the results, in addition to writing them to a file.
This parameter is valid only when the `-OutFile` parameter is also used in the command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: No output
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy
Uses a proxy server for the request, rather than connecting directly to the Internet resource.
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
Specifies a user account that has permission to use the proxy server that is specified by the `-Proxy` parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the `Get-Credential` cmdlet.

This parameter is valid only when the `-Proxy` parameter is also used in the command.
You cannot use the `-ProxyCredential` and `-ProxyUseDefaultCredentials` parameters in the same command.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyUseDefaultCredentials
Uses the credentials of the current user to access the proxy server that is specified by the `-Proxy` parameter.

This parameter is valid only when the `-Proxy` parameter is also used in the command.
You cannot use the `-ProxyCredential` and `-ProxyUseDefaultCredentials` parameters in the same command.

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

### -ResponseHeadersVariable
Creates a Response Headers Dictionary and saves it in the value of the specified variable. The the keys of the dictionary will contain the field names of the Response Header returned by the web server and the values will be the respective field values. 


```yaml
Type: String
Parameter Sets: (All)
Aliases: RHV

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

```

### -SessionVariable
Creates a web request session and saves it in the value of the specified variable.
Enter a variable name without the dollar sign (`$`) symbol.

When you specify a session variable, `Invoke-RestMethod` creates a web request session object and assigns it to a variable with the specified name in your Windows PowerShell session.
You can use the variable in your session as soon as the command completes.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To use the web request session in subsequent web requests, specify the session variable in the value of the `-WebSession` parameter.
Windows PowerShell uses the data in the web request session object when establishing the new connection.
To override a value in the web request session, use a cmdlet parameter, such as `-UserAgent` or `-Credential`.
Parameter values take precedence over values in the web request session.

You cannot use the `-SessionVariable` and `-WebSession` parameters in the same command.

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
### -SkipCertificateCheck
Skips certificate validation checks.

This includes all validations such as expiration, revocation, trusted root authority, etc. This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes.

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

### -TimeoutSec
Specifies how long the request can be pending before it times out.
Enter a value in seconds.
The default value, 0, specifies an indefinite time-out.

A Domain Name System (DNS) query can take up to 15 seconds to return or time out.
If your request contains a host name that requires resolution, and you set TimeoutSec to a value greater than zero, but less than 15 seconds, it can take 15 seconds or more before a WebException is thrown, and your request times out.

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
* Chunked
* Compress
* Deflate
* GZip
* Identity

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
The parameter name (`-Uri`) is optional.

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

The Body parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request, and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters. For other request types (such as POST), the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of another `Invoke-WebRequest` call, Windows PowerShell sets the request content to the form fields.

For example:

```powershell
$R = Invoke-WebRequest http://website.com/login.aspx $R.Forms\[0\].Name = "MyName" $R.Forms\[0\].Password = "MyPassword" Invoke-RestMethod http://website.com/service.aspx -Body $R
```

or

```powershell
Invoke-RestMethod http://website.com/service.aspx -Body $R.Forms\[0\]
```

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
Uses the credentials of the current user to send the web request.

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

The default user agent is similar to "Mozilla/5.0 (Windows NT; Windows NT 6.1; en-US) WindowsPowerShell/3.0" with slight variations for each operating system and platform.

To test a website with the standard user agent string that is used by most Internet browsers, use the properties of the [PSUserAgent](http://msdn.microsoft.com/library/windows/desktop/hh484857(v=vs.85).aspx) class, such as Chrome, FireFox, Internet Explorer, Opera, and Safari.

For example, the following command uses the user agent string for Internet

```powershell
Invoke-WebRequest -Uri http://website.com/ -UserAgent (\[Microsoft.PowerShell.Commands.PSUserAgent\]::InternetExplorer)
```

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
Enter the variable name, including the dollar sign (`$`).

To override a value in the web request session, use a cmdlet parameter, such as `-UserAgent` or `-Credential`.
Parameter values take precedence over values in the web request session. Content related headers, such as `Content-Type`, will be also be overridden when a `MultipartFormDataContent` object is supplied for `-Body`.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To create a web request session, enter a variable name (without a dollar sign) in the value of the `-SessionVariable` parameter of an `Invoke-RestMethod` command.
`Invoke-RestMethod` creates the session and saves it in the variable.
In subsequent commands, use the variable as the value of the `-WebSession` parameter.

You cannot use the `-SessionVariable` and `-WebSession` parameters in the same command.

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
This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.Object
You can pipe the body of a web request to `Invoke-Rest-Method`.

## Outputs

### System.Xml.XmlDocument, Microsoft.PowerShell.Commands.HtmlWebResponseObject, System.String
The output of the cmdlet depends upon the format of the content that is retrieved.

### PSObject
If the request returns JSON strings, `Invoke-RestMethod` returns a PSObject that represents the strings.

## Notes

## Related Links

[ConvertTo-Json](ConvertTo-Json.md)

[ConvertFrom-Json](ConvertFrom-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)

