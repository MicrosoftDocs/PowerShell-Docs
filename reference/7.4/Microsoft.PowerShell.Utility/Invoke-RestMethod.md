---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 11/18/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/invoke-restmethod?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Invoke-RestMethod
---

# Invoke-RestMethod

## SYNOPSIS
Sends an HTTP or HTTPS request to a RESTful web service.

## SYNTAX

### StandardMethod (Default)

```
Invoke-RestMethod [-FollowRelLink] [-MaximumFollowRelLink <Int32>]
 [-ResponseHeadersVariable <String>] [-StatusCodeVariable <String>] [-UseBasicParsing] [-Uri] <Uri>
 [-HttpVersion <Version>] [-WebSession <WebRequestSession>] [-SessionVariable <String>]
 [-AllowUnencryptedAuthentication] [-Authentication <WebAuthenticationType>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-CertificateThumbprint <String>]
 [-Certificate <X509Certificate>] [-SkipCertificateCheck] [-SslProtocol <WebSslProtocol>]
 [-Token <SecureString>] [-UserAgent <String>] [-DisableKeepAlive]
 [-ConnectionTimeoutSeconds <Int32>] [-OperationTimeoutSeconds <Int32>] [-Headers <IDictionary>]
 [-SkipHeaderValidation] [-AllowInsecureRedirect] [-MaximumRedirection <Int32>]
 [-MaximumRetryCount <Int32>] [-PreserveAuthorizationOnRedirect] [-RetryIntervalSec <Int32>]
 [-Method <WebRequestMethod>] [-PreserveHttpMethodOnRedirect]
 [-UnixSocket <UnixDomainSocketEndPoint>] [-Proxy <Uri>] [-ProxyCredential <PSCredential>]
 [-ProxyUseDefaultCredentials] [-Body <Object>] [-Form <IDictionary>] [-ContentType <String>]
 [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>] [-PassThru] [-Resume]
 [-SkipHttpErrorCheck] [<CommonParameters>]
```

### StandardMethodNoProxy

```
Invoke-RestMethod [-FollowRelLink] [-MaximumFollowRelLink <Int32>]
 [-ResponseHeadersVariable <String>] [-StatusCodeVariable <String>] [-UseBasicParsing] [-Uri] <Uri>
 [-HttpVersion <Version>] [-WebSession <WebRequestSession>] [-SessionVariable <String>]
 [-AllowUnencryptedAuthentication] [-Authentication <WebAuthenticationType>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-CertificateThumbprint <String>]
 [-Certificate <X509Certificate>] [-SkipCertificateCheck] [-SslProtocol <WebSslProtocol>]
 [-Token <SecureString>] [-UserAgent <String>] [-DisableKeepAlive]
 [-ConnectionTimeoutSeconds <Int32>] [-OperationTimeoutSeconds <Int32>] [-Headers <IDictionary>]
 [-SkipHeaderValidation] [-AllowInsecureRedirect] [-MaximumRedirection <Int32>]
 [-MaximumRetryCount <Int32>] [-PreserveAuthorizationOnRedirect] [-RetryIntervalSec <Int32>]
 [-Method <WebRequestMethod>] [-PreserveHttpMethodOnRedirect]
 [-UnixSocket <UnixDomainSocketEndPoint>] [-NoProxy] [-Body <Object>] [-Form <IDictionary>]
 [-ContentType <String>] [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>]
 [-PassThru] [-Resume] [-SkipHttpErrorCheck] [<CommonParameters>]
```

### CustomMethod

```
Invoke-RestMethod [-FollowRelLink] [-MaximumFollowRelLink <Int32>]
 [-ResponseHeadersVariable <String>] [-StatusCodeVariable <String>] [-UseBasicParsing] [-Uri] <Uri>
 [-HttpVersion <Version>] [-WebSession <WebRequestSession>] [-SessionVariable <String>]
 [-AllowUnencryptedAuthentication] [-Authentication <WebAuthenticationType>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-CertificateThumbprint <String>]
 [-Certificate <X509Certificate>] [-SkipCertificateCheck] [-SslProtocol <WebSslProtocol>]
 [-Token <SecureString>] [-UserAgent <String>] [-DisableKeepAlive]
 [-ConnectionTimeoutSeconds <Int32>] [-OperationTimeoutSeconds <Int32>] [-Headers <IDictionary>]
 [-SkipHeaderValidation] [-AllowInsecureRedirect] [-MaximumRedirection <Int32>]
 [-MaximumRetryCount <Int32>] [-PreserveAuthorizationOnRedirect] [-RetryIntervalSec <Int32>]
 -CustomMethod <String> [-PreserveHttpMethodOnRedirect] [-UnixSocket <UnixDomainSocketEndPoint>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-ProxyUseDefaultCredentials] [-Body <Object>]
 [-Form <IDictionary>] [-ContentType <String>] [-TransferEncoding <String>] [-InFile <String>]
 [-OutFile <String>] [-PassThru] [-Resume] [-SkipHttpErrorCheck] [<CommonParameters>]
```

### CustomMethodNoProxy

```
Invoke-RestMethod [-FollowRelLink] [-MaximumFollowRelLink <Int32>]
 [-ResponseHeadersVariable <String>] [-StatusCodeVariable <String>] [-UseBasicParsing] [-Uri] <Uri>
 [-HttpVersion <Version>] [-WebSession <WebRequestSession>] [-SessionVariable <String>]
 [-AllowUnencryptedAuthentication] [-Authentication <WebAuthenticationType>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-CertificateThumbprint <String>]
 [-Certificate <X509Certificate>] [-SkipCertificateCheck] [-SslProtocol <WebSslProtocol>]
 [-Token <SecureString>] [-UserAgent <String>] [-DisableKeepAlive]
 [-ConnectionTimeoutSeconds <Int32>] [-OperationTimeoutSeconds <Int32>] [-Headers <IDictionary>]
 [-SkipHeaderValidation] [-AllowInsecureRedirect] [-MaximumRedirection <Int32>]
 [-MaximumRetryCount <Int32>] [-PreserveAuthorizationOnRedirect] [-RetryIntervalSec <Int32>]
 -CustomMethod <String> [-PreserveHttpMethodOnRedirect] [-UnixSocket <UnixDomainSocketEndPoint>]
 [-NoProxy] [-Body <Object>] [-Form <IDictionary>] [-ContentType <String>]
 [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>] [-PassThru] [-Resume]
 [-SkipHttpErrorCheck] [<CommonParameters>]
```

## DESCRIPTION

The `Invoke-RestMethod` cmdlet sends HTTP and HTTPS requests to Representational State Transfer
(REST) web services that return richly structured data.

PowerShell formats the response based to the data type. For an RSS or ATOM feed, PowerShell returns
the Item or Entry XML nodes. For JavaScript Object Notation (JSON) or XML, PowerShell converts, or
deserializes, the content into `[PSCustomObject]` objects.

> [!NOTE]
> When the REST endpoint returns multiple objects, the objects are received as an array. If you pipe
> the output from `Invoke-RestMethod` to another command, it is sent as a single `[Object[]]`
> object. The contents of that array are not enumerated for the next command on the pipeline.

This cmdlet is introduced in Windows PowerShell 3.0.

Beginning in PowerShell 7.0, `Invoke-RestMethod` supports proxy configuration defined by environment
variables. See the [Notes](#notes) section of this article.

Beginning in PowerShell 7.4, character encoding for requests defaults to UTF-8 instead of ASCII. If
you need a different encoding, you must set the `charset` attribute in the `Content-Type` header.

## EXAMPLES

### Example 1: Get the PowerShell RSS feed

This example uses the `Invoke-RestMethod` cmdlet to get information from the PowerShell Blog RSS
feed. The command uses the `Format-Table` cmdlet to display the values of the **Title** and
**pubDate** properties of each blog in a table.

```powershell
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ |
  Format-Table -Property Title, pubDate
```

```Output
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

### Example 2: Run a POST request

In this example, a user runs `Invoke-RestMethod` to do a POST request on an intranet website in the
user's organization.

```powershell
$Cred = Get-Credential
$Url = "https://server.contoso.com:8089/services/search/jobs/export"
$Body = @{
    search = "search index=_internal | reverse | table index,host,source,sourcetype,_raw"
    output_mode = "csv"
    earliest_time = "-2d@d"
    latest_time = "-1d@d"
}
Invoke-RestMethod -Method 'Post' -Uri $url -Credential $Cred -Body $body -OutFile output.csv
```

The credentials are prompted for and then stored in `$Cred` and the URL that will be access is
defined in `$Url`.

The `$Body` variable describes the search criteria, specifies CSV as the output mode, and specifies
a time period for returned data that starts two days ago and ends one day ago. The body variable
specifies values for parameters that apply to the particular REST API with which `Invoke-RestMethod`
is communicating.

The `Invoke-RestMethod` command is run with all variables in place, specifying a path and file name
for the resulting CSV output file.

### Example 3: Follow relation links

Some REST APIs support pagination via Relation Links per
[RFC5988](https://tools.ietf.org/html/rfc5988#page-6). Instead of parsing the header to get the URL
for the next page, you can have the cmdlet do this for you. This example returns the first two pages
of issues from the PowerShell GitHub repository.

```powershell
$url = 'https://api.github.com/repos/powershell/powershell/issues'
Invoke-RestMethod $url -FollowRelLink -MaximumFollowRelLink 2
```

### Example 4: Simplified Multipart/Form-Data Submission

Some APIs require `multipart/form-data` submissions to upload files and mixed content. This example
demonstrates how to update a user's profile.

```powershell
$Uri = 'https://api.contoso.com/v2/profile'
$Form = @{
    firstName  = 'John'
    lastName   = 'Doe'
    email      = 'john.doe@contoso.com'
    avatar     = Get-Item -Path 'c:\Pictures\jdoe.png'
    birthday   = '1980-10-15'
    hobbies    = 'Hiking','Fishing','Jogging'
}
$Result = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form
```

The profile form requires these fields: `firstName`, `lastName`, `email`, `avatar`, `birthday`, and
`hobbies`. The API is expecting an image for the user profile pic to be supplied in the `avatar`
field. The API will also accept multiple `hobbies` entries to be submitted in the same form.

When creating the `$Form` HashTable, the key names are used as form field names. By default, the
values of the HashTable will be converted to strings. If a `System.IO.FileInfo` value is present,
the file contents will be submitted. If a collection such as arrays or lists are present, the form
field will be submitted multiple times.

By using `Get-Item` on the `avatar` key, the `FileInfo` object will be set as the value. The result
is that the image data for `jdoe.png` will be submitted.

By supplying a list to the `hobbies` key, the `hobbies` field will be present in the submissions
once for each list item.

### Example 5: Pass multiple headers

APIs often require passed headers for authentication or validation. This example demonstrates, how
to pass multiple headers from a `hash-table` to a REST API.

```powershell
$headers = @{
    'userId' = 'UserIDValue'
    'token' = 'TokenValue'
}
Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
```

### Example 6: Enumerate returned items on the pipeline

GitHub returns multiple objects an array. If you pipe the output to another command, it is sent as a
single `[Object[]]`object.

To enumerate the objects into the pipeline, pipe the results to `Write-Output` or wrap the cmdlet in
parentheses. The following example counts the number of objects returned by GitHub. Then counts the
number of objects enumerated to the pipeline.

```powershell
$uri = 'https://api.github.com/repos/microsoftdocs/powershell-docs/issues'
$x = 0
Invoke-RestMethod -Uri $uri | ForEach-Object { $x++ }
$x
1

$x = 0
(Invoke-RestMethod -Uri $uri) | ForEach-Object { $x++ }
$x
30

$x = 0
Invoke-RestMethod -Uri $uri | Write-Output | ForEach-Object { $x++ }
$x
30
```

### Example 7: Skipping Header Validation

By default, the `Invoke-RestMethod` cmdlet validates the values of well-known headers that have a
standards-defined value format. The following example shows how this validation can raise an
error and how you can use the **SkipHeaderValidation** parameter to avoid validating values for
endpoints that tolerate invalidly formatted values.

```powershell
$Uri = 'https://httpbin.org/headers'
$InvalidHeaders = @{
    'If-Match' = '12345'
}

Invoke-RestMethod -Uri $Uri -Headers $InvalidHeaders

Invoke-RestMethod -Uri $Uri -Headers $InvalidHeaders -SkipHeaderValidation |
    Format-List
```

```Output
Invoke-RestMethod: The format of value '12345' is invalid.

headers : @{Host=httpbin.org; If-Match=12345; User-Agent=Mozilla/5.0 (Windows NT 10.0; Microsoft Windows
          10.0.19044; en-US) PowerShell/7.2.5;  X-Amzn-Trace-Id=Root=1-62f150a6-27754fd4226f31b43a3d2874}
```

[httpbin.org](https://httpbin.org/) is a service that returns information about web requests and
responses for troubleshooting. The `$Uri` variable is assigned to the `/headers` endpoint of the
service, which returns a request's headers as the content in its response.

The `If-Match` request header is defined in
[RFC-7232 section 3.1](https://www.rfc-editor.org/rfc/rfc7232.html#section-3.1) and requires the
value for that header to be defined with surrounding quotes. The `$InvalidHeaders` variable is
assigned a hash table where the value of `If-Match` is invalid because it's defined as `12345`
instead of `"12345"`.

Calling `Invoke-RestMethod` with the invalid headers returns an error reporting that the formatted
value is invalid. The request is not sent to the endpoint.

Calling `Invoke-RestMethod` with the **SkipHeaderValidation** parameter ignores the validation
failure and sends the request to the endpoint. Because the endpoint tolerates non-compliant header
values, the cmdlet returns the response object without error.

### Example 8: Send a request using HTTP 2.0

This example queries for GitHub issue using the HTTP 2.0 protocol.

```powershell
$uri = 'https://api.github.com/repos/microsoftdocs/powershell-docs/issues'
Invoke-RestMethod -Uri $uri -HttpVersion 2.0 -SkipCertificateCheck
```

### Example 9: Send a request to a Unix socket application

Some applications, such as Docker, expose a Unix socket for communication. This example queries for
a list of Docker images using the Docker API. The cmdlet connects to the Docker daemon using the
Unix socket.

```powershell
Invoke-RestMethod -Uri "http://localhost/v1.40/images/json/" -UnixSocket "/var/run/docker.sock"
```

## PARAMETERS

### -AllowInsecureRedirect

Allows redirecting from HTTPS to HTTP. By default, any request that is redirected from HTTPS to
HTTP results in an error and the request is aborted to prevent unintentionally communicating in
plain text over unencrypted connections. To override this behavior at your own risk, use the
**AllowInsecureRedirect** parameter.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowUnencryptedAuthentication

Allows sending of credentials and secrets over unencrypted connections. By default, supplying
**Credential** or any **Authentication** option with a **Uri** that does not begin with `https://`
will result in an error and the request will abort to prevent unintentionally communicating secrets
in plain text over unencrypted connections. To override this behavior at your own risk, supply the
**AllowUnencryptedAuthentication** parameter.

> [!WARNING]
> Using this parameter is not secure and is not recommended. It is provided only for compatibility
> with legacy systems that cannot provide encrypted connections. Use at your own risk.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication

Specifies the explicit authentication type to use for the request. The default is **None**.
The **Authentication** parameter can't be used with the **UseDefaultCredentials** parameter.

Available Authentication Options:

- `None`: This is the default option when **Authentication** is not supplied. No explicit
  authentication will be used.
- `Basic`: Requires **Credential**. The credentials will be used to send an RFC 7617 Basic
  Authentication `Authorization: Basic` header in the format of `base64(user:password)`.
- `Bearer`: Requires the **Token** parameter. Sends an RFC 6750 `Authorization: Bearer` header with
  the supplied token.
- `OAuth`: Requires the **Token** parameter. Sends an RFC 6750 `Authorization: Bearer` header with
  the supplied token.

Supplying **Authentication** overrides any `Authorization` headers supplied to **Headers** or
included in **WebSession**.

This feature was added in PowerShell 6.0.0.

```yaml
Type: Microsoft.PowerShell.Commands.WebAuthenticationType
Parameter Sets: (All)
Aliases:
Accepted values: None, Basic, Bearer, OAuth

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body

Specifies the body of the request. The body is the content of the request that follows the headers.
You can also pipe a body value to `Invoke-RestMethod`.

The **Body** parameter can be used to specify a list of query parameters or specify the content of
the response. For query parameters, the cmdlet uses the **System.Net.WebUtility.UrlEncode** method
method to encode the key-value pairs. For more information about encoding strings for URLs, see
[the UrlEncode() method reference](xref:System.Net.WebUtility.UrlEncode*).

When the input is a POST request and the body is a **String**, the value to the left of the first
equals sign (`=`) is set as a key in the form data and the remaining text is set as the value. To
specify multiple keys, use an **IDictionary** object, such as a hash table, for the **Body**.

When the input is a GET request and the body is an **IDictionary** (typically, a hash table), the
body is added to the URI as query parameters. For other request types (such as PATCH), the body is
set as the value of the request body in the standard `name=value` format with the values
URL-encoded.

When the input is a **System.Xml.XmlNode** object and the XML declaration specifies an encoding,
that encoding is used for the data in the request unless overridden by the **ContentType**
parameter.

When the body is a form, or it's the output of another `Invoke-WebRequest` call, PowerShell sets the
request content to the form fields.

The **Body** parameter may also accept a **System.Net.Http.MultipartFormDataContent** object. This
will facilitate `multipart/form-data` requests. When a **MultipartFormDataContent** object is
supplied for **Body**, any content related headers supplied to the **ContentType**, **Headers**, or
**WebSession** parameters will be overridden by the content headers of the
`MultipartFormDataContent` object. This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Certificate

Specifies the client certificate that is used for a secure web request. Enter a variable that
contains a certificate or a command or expression that gets the certificate.

To find a certificate, use `Get-PfxCertificate` or use the `Get-ChildItem` cmdlet in the Certificate
(`Cert:`) drive. If the certificate isn't valid or doesn't have sufficient authority, the command
fails.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateThumbprint

Specifies the digital public key certificate (X509) of a user account that has permission to send
the request. Enter the certificate thumbprint of the certificate.

Certificates are used in client certificate-based authentication. Certificates can only be mapped
only to local user accounts, not domain accounts.

To see the certificate thumbprint, use the `Get-Item` or `Get-ChildItem` command to find the
certificate in `Cert:\CurrentUser\My`.

> [!NOTE]
> This feature is currently only supported on Windows OS platforms.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionTimeoutSeconds

Specifies how long the request can be pending before it times out. Enter a value in seconds. The
default value, 0, specifies an indefinite time-out.

A Domain Name System (DNS) query can take up to 15 seconds to return or time out. If your request
contains a host name that requires resolution, and you set **ConnectionTimeoutSeconds** to a value
greater than zero, but less than 15 seconds, it can take 15 seconds or more before a
**WebException** is thrown, and your request times out.

This parameter replaced the **TimeoutSec** parameter in PowerShell 7.4. You can use **TimeoutSec**
as an alias for **ConnectionTimeoutSeconds**.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType

Specifies the content type of the web request.

If the value for **ContentType** contains the encoding format (as `charset`), the cmdlet uses that
format to encode the body of the web request. If the **ContentType** doesn't specify an encoding
format, the default encoding format is used instead. An example of a **ContentType** with an
encoding format is `text/plain; charset=iso-8859-5`, which specifies the
[Latin/Cyrillic](https://www.iso.org/standard/28249.html) alphabet.

If this parameter is omitted and the request method is POST, `Invoke-RestMethod` sets the content
type to `application/x-www-form-urlencoded`. Otherwise, the content type isn't specified in the
call.

**ContentType** will be overridden when a `MultipartFormDataContent` object is supplied for
**Body**.

Starting in PowerShell 7.4, if you use this both this parameter and the **Headers** parameter to
define the `Content-Type` header, the value specified in the **ContentType** parameter is used.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to send the request. The default is the current user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet.

**Credential** can be used alone or in conjunction with certain **Authentication** parameter
options. When used alone, it will only supply credentials to the remote server if the remote server
sends an authentication challenge request. When used with **Authentication** options, the
credentials will be explicitly sent.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomMethod

Specifies custom method used for the web request. This can be used with the Request Method required
by the endpoint is not an available option on the **Method**. **Method** and **CustomMethod** cannot
be used together.

Example:

`Invoke-RestMethod -uri 'https://api.contoso.com/widget/' -CustomMethod 'TEST'`

This makes a `TEST` HTTP request to the API.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.String
Parameter Sets: CustomMethod, CustomMethodNoProxy
Aliases: CM

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableKeepAlive

Indicates that the cmdlet sets the **KeepAlive** value in the HTTP header to False. By default,
**KeepAlive** is True. **KeepAlive** establishes a persistent connection to the server to facilitate
subsequent requests.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FollowRelLink

Indicates the cmdlet should follow relation links.

Some REST APIs support pagination via Relation Links per
[RFC5988](https://tools.ietf.org/html/rfc5988#page-6). Instead of parsing the header to get the URL
for the next page, you can have the cmdlet do this for you. To set how many times to follow relation
links, use the **MaximumFollowRelLink** parameter.

When using this switch, the cmdlet returns a collection of pages of results. Each page of results
may contain multiple result items.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: FL

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Form

Converts a dictionary to a `multipart/form-data` submission. **Form** may not be used with **Body**.
If **ContentType** will be ignored.

The keys of the dictionary will be used as the form field names. By default, form values will be
converted to string values.

If the value is a **System.IO.FileInfo** object, then the binary file contents will be submitted.
The name of the file will be submitted as the `filename`. The MIME will be set as
`application/octet-stream`. `Get-Item` can be used to simplify supplying the **System.IO.FileInfo**
object.

```powershell
$Form = @{
    resume = Get-Item 'c:\Users\jdoe\Documents\John Doe.pdf'
}
```

If the value is a collection type, such as an Array or List, the for field will be submitted
multiple times. The values of the list will be treated as strings by default. If the value is a
**System.IO.FileInfo** object, then the binary file contents will be submitted. Nested collections
aren't supported.

```powershell
$Form = @{
    tags     = 'Vacation', 'Italy', '2017'
    pictures = Get-ChildItem 'c:\Users\jdoe\Pictures\2017-Italy\'
}
```

In the above example, the `tags` field will be supplied three times in the form, once for each of
`Vacation`, `Italy`, and `2017`. The `pictures` field will also be submitted once for each file in
the `2017-Italy` folder. The binary contents of the files in that folder will be submitted as the
values.

This feature was added in PowerShell 6.1.0.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers

Specifies the headers of the web request. Enter a hash table or dictionary.

Content related headers, such as `Content-Type` are overridden when a `MultipartFormDataContent`
object is supplied for **Body**.

Starting in PowerShell 7.4, if you use this parameter to define the `Content-Type` header and use
**ContentType** parameter, the value specified in the **ContentType** parameter is used.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HttpVersion

Specifies the HTTP version used for the request. The default is `1.1`.

Valid values are:

- 1.0
- 1.1
- 2.0
- 3.0

```yaml
Type: System.Version
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

Enter a path and file name. If you omit the path, the default is the current location.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFollowRelLink

Specifies how many times to follow relation links if **FollowRelLink** is used. A smaller value may
be needed if the REST api throttles due to too many requests. The default value is
`[Int32]::MaxValue`. A value of 0 (zero) prevents following relation links.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ML

Required: False
Position: Named
Default value: Int32.MaxValue
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumRedirection

Specifies how many times PowerShell redirects a connection to an alternate Uniform Resource
Identifier (URI) before the connection fails. The default value is 5. A value of 0 (zero) prevents
all redirection.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumRetryCount

Specifies how many times PowerShell retries a connection when a failure code between 400 and 599,
inclusive or 304 is received. Also see **RetryIntervalSec** parameter for specifying the interval
between retries.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method

Specifies the method used for the web request. The acceptable values for this parameter are:

- `Default`
- `Delete`
- `Get`
- `Head`
- `Merge`
- `Options`
- `Patch`
- `Post`
- `Put`
- `Trace`

The **CustomMethod** parameter can be used for Request Methods not listed above.

```yaml
Type: Microsoft.PowerShell.Commands.WebRequestMethod
Parameter Sets: StandardMethod, StandardMethodNoProxy
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

When you need to bypass the proxy configured in Internet Explorer, or a proxy specified in the
environment, use this switch.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: StandardMethodNoProxy, CustomMethodNoProxy
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OperationTimeoutSeconds

This timeout applies to data reads within a stream, not to the stream time as a whole. The default
value, 0, specifies an indefinite timeout.

Setting the value to 30 seconds means that any delay of longer than 30 seconds between data in the
stream terminates the request. A large file that takes several minutes to download won't terminate
unless the stream stalls for more than 30 seconds.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile

By default, `Invoke-RestMethod` returns the results to the pipeline. When you use the **OutFile**
parameter, the results are saved to the specified file and not returned to the pipeline. Enter a
path and filename. To send the results to a file and to the pipeline, add the **PassThru**
parameter.

If you omit the path, the default is the current location. The name is treated as a literal path.
Names that contain brackets (`[]`) must be enclosed in single quotes (`'`).

Starting in PowerShell 7.4, you can specify a folder path without the filename. When you do, the
command uses filename from the last segment of the resolved URI after any redirections. When you
specify a folder path for **OutFile**, you can't use the **Resume** parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

This parameter is valid only when the **OutFile** parameter is also used in the command. The intent
is to have the results written to the file and to the pipeline.

> [!NOTE]
> When you use the **PassThru** parameter, the output is written to the pipeline but the file isn't
> created. This is fixed in PowerShell 7.5-preview.4. For more information, see
> [PowerShell Issue #15409](https://github.com/PowerShell/PowerShell/issues/15409).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: No output
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreserveAuthorizationOnRedirect

Indicates the cmdlet should preserve the `Authorization` header, when present, across redirections.

By default, the cmdlet strips the `Authorization` header before redirecting. Specifying this
parameter disables this logic for cases where the header needs to be sent to the redirection
location.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreserveHttpMethodOnRedirect

Indicates the cmdlet should preserve the method of the request across redirections.

By default, the cmdlet changes the method to `GET` when redirected. Specifying this parameter
disables this logic to ensure that the intended method can be used with redirection.

This feature was added in PowerShell 7.4.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy

Uses a proxy server for the request, rather than connecting directly to the internet resource. Enter
the Uniform Resource Identifier (URI) of a network proxy server.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Uri
Parameter Sets: StandardMethod, CustomMethod
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyCredential

Specifies a user account that has permission to use the proxy server that is specified by the
**Proxy** parameter. The default is the current user.

Type a user name, such as **User01** or **Domain01\User01**, **User@Domain.Com**, or enter a
`PSCredential` object, such as one generated by the `Get-Credential` cmdlet.

This parameter is valid only when the **Proxy** parameter is also used in the command. You can't use
the **ProxyCredential** and **ProxyUseDefaultCredentials** parameters in the same command.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: StandardMethod, CustomMethod
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyUseDefaultCredentials

Indicates that the cmdlet uses the credentials of the current user to access the proxy server that
is specified by the **Proxy** parameter.

This parameter is valid only when the **Proxy** parameter is also used in the command. You can't use
the **ProxyCredential** and **ProxyUseDefaultCredentials** parameters in the same command.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: StandardMethod, CustomMethod
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResponseHeadersVariable

Creates a variable containing a Response Headers Dictionary. Enter a variable name without the
dollar sign (`$`) symbol. The keys of the dictionary contain the field names and values of the
Response Header returned by the web server.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RHV

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resume

Performs a best effort attempt to resume downloading a partial file. The **Resume** parameter
requires the **OutFile** parameter.

**Resume** only operates on the size of the local file and remote file and performs no other
validation that the local file and the remote file are the same.

If the local file size is smaller than the remote file size, then the cmdlet will attempt to resume
downloading the file and append the remaining bytes to the end of the file.

If the local file size is the same as the remote file size, then no action is taken and the cmdlet
assumes the download already completed.

If the local file size is larger than the remote file size, then the local file will be overwritten
and the entire remote file will be completely re-downloaded. This behavior is the same as using
**OutFile** without **Resume**.

If the remote server does not support download resuming, then the local file will be overwritten and
the entire remote file will be completely re-downloaded. This behavior is the same as using
**OutFile** without **Resume**.

If the local file doesn't exist, then the local file will be created and the entire remote file will
be completely downloaded. This behavior is the same as using **OutFile** without **Resume**.

This feature was added in PowerShell 6.1.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryIntervalSec

Specifies the interval between retries for the connection when a failure code between 400 and 599,
inclusive or 304 is received. The value must be between `1` and `[int]::MaxValue`.
When the failure code is 429 and the response includes the **Retry-After** property in its headers,
the cmdlet uses that value for the retry interval, even if this parameter is specified.

Also, see the **MaximumRetryCount** parameter for specifying number of retries.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionVariable

Creates a variable containing the web request session. Enter a variable name without the dollar sign
(`$`) symbol.

When you specify a session variable, `Invoke-RestMethod` creates a web request session object and
assigns it to a variable with the specified name in your PowerShell session. You can use the
variable in your session as soon as the command completes.

Before PowerShell 7.4, the web request session isn't a persistent connection. It's an object that
contains information about the connection and the request, including cookies, credentials, the
maximum redirection value, and the user agent string. You can use it to share state and data among
web requests.

Starting in PowerShell 7.4, the web request session is persistent as long as the properties of the
session aren't overridden in a subsequent request. When they are, the cmdlet recreates the session
with the new values. The persistent sessions reduce the overhead for repeated requests, making them
much faster.

To use the web request session in subsequent web requests, specify the session variable in the value
of the **WebSession** parameter. PowerShell uses the data in the web request session object when
establishing the new connection. To override a value in the web request session, use a cmdlet
parameter, such as **UserAgent** or **Credential**. Parameter values take precedence over values in
the web request session.

You can't use the **SessionVariable** and **WebSession** parameters in the same command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SV

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck

Skips certificate validation checks that include all validations such as expiration, revocation,
trusted root authority, etc.

> [!WARNING]
> Using this parameter is not secure and is not recommended. This switch is only intended to be used
> against known hosts using a self-signed certificate for testing purposes. Use at your own risk.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipHeaderValidation

Indicates the cmdlet should add headers to the request without validation.

This switch should be used for sites that require header values that do not conform to standards.
Specifying this switch disables validation to allow the value to be passed unchecked. When
specified, all headers are added without validation.

This will disable validation for values passed to the **ContentType**, **Headers**, and
**UserAgent** parameters.

This feature was added in PowerShell 6.0.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipHttpErrorCheck

This parameter causes the cmdlet to ignore HTTP error statuses and continue to process responses.
The error responses are written to the pipeline just as if they were successful.

This parameter was introduced in PowerShell 7.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SslProtocol

Sets the SSL/TLS protocols that are permissible for the web request. By default all, SSL/TLS
protocols supported by the system are allowed. **SslProtocol** allows for limiting to specific
protocols for compliance purposes.

These values are defined as a flag-based enumeration. You can combine multiple values together to
set multiple flags using this parameter. The values can be passed to the **SslProtocol** parameter
as an array of values or as a comma-separated string of those values. The cmdlet will combine the
values using a binary-OR operation. Passing values as an array is the simplest option and also
allows you to use tab-completion on the values. You may not be able to supply multiple values on all
platforms.

> [!NOTE]
> On non-Windows platforms it may not be possible to supply `Tls` or `Tls12` as an option. Support
> for `Tls13` is not available on all operating systems and will need to be verified on a per
> operating system basis.

This feature was added in PowerShell 6.0.0 and support for `Tls13` was added in PowerShell 7.1.

```yaml
Type: Microsoft.PowerShell.Commands.WebSslProtocol
Parameter Sets: (All)
Aliases:
Accepted values: Default, Tls, Tls11, Tls12, Tls13

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusCodeVariable

Creates a variable containing a HTTP status code result of the request. Enter a variable name
without the dollar sign (`$`) symbol.

The parameter can identify success messages or failure messages when used with the
**SkipHttpErrorCheck** parameter.

Input the parameter's variable name as a string such as `-StatusCodeVariable "scv"`.

This parameter was introduced in PowerShell 7.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token

The OAuth or Bearer token to include in the request. **Token** is required by certain
**Authentication** options. It can't be used independently.

**Token** takes a `SecureString` that contains the token. To supply the token, manually use the
following:

`Invoke-RestMethod -Uri $uri -Authentication OAuth -Token (Read-Host -AsSecureString)`

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Security.SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransferEncoding

Specifies a value for the transfer-encoding HTTP response header. The acceptable values for this
parameter are:

- Chunked
- Compress
- Deflate
- GZip
- Identity

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: chunked, compress, deflate, gzip, identity

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnixSocket

Specifies the name of the Unix socket to connect to. This parameter is supported on Unix-based
systems and Windows version 1803 and later. For more information about Windows support of Unix
sockets, see the
[Windows/WSL Interop with AF_UNIX](https://devblogs.microsoft.com/commandline/windowswsl-interop-with-af_unix/)
blog post.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.Net.Sockets.UnixDomainSocketEndPoint
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri

Specifies the Uniform Resource Identifier (URI) of the internet resource to which the web request is
sent. This parameter supports HTTP, HTTPS, FTP, and FILE values.

This parameter is required. The parameter name (**Uri**) is optional.

```yaml
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseBasicParsing

This parameter has been deprecated. Beginning with PowerShell 6.0.0, all Web requests use basic
parsing only. This parameter is included for backwards compatibility only and any use of it will
have no effect on the operation of the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredentials

Indicates that the cmdlet uses the credentials of the current user to send the web request. This
can't be used with **Authentication** or **Credential** and may not be supported on all platforms.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent

Specifies a user agent string for the web request.

The default user agent is similar to
`Mozilla/5.0 (Windows NT 10.0; Microsoft Windows 10.0.15063; en-US) PowerShell/6.0.0` with slight
variations for each operating system and platform.

To test a website with the standard user agent string that is used by most internet browsers, use
the properties of the [PSUserAgent](/dotnet/api/microsoft.powershell.commands.psuseragent) class,
such as Chrome, Firefox, InternetExplorer, Opera, and Safari.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebSession

Specifies a web request session. Enter the variable name, including the dollar sign (`$`).

To override a value in the web request session, use a cmdlet parameter, such as **UserAgent** or
**Credential**. Parameter values take precedence over values in the web request session. Content
related headers, such as `Content-Type`, will be also be overridden when a
**MultipartFormDataContent** object is supplied for **Body**.

Unlike a remote session, the web request session isn't a persistent connection. It's an object that
contains information about the connection and the request, including cookies, credentials, the
maximum redirection value, and the user agent string. You can use it to share state and data among
web requests.

To create a web request session, enter a variable name, without a dollar sign, in the value of the
**SessionVariable** parameter of an `Invoke-RestMethod` command. `Invoke-RestMethod` creates the
session and saves it in the variable. In subsequent commands, use the variable as the value of the
**WebSession** parameter.

You can't use the **SessionVariable** and **WebSession** parameters in the same command.

```yaml
Type: Microsoft.PowerShell.Commands.WebRequestSession
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

You can pipe the body of a web request to this cmdlet.

## OUTPUTS

### System.Int64

When the request returns an integer, this cmdlet returns that integer.

### System.String

When the request returns a string, this cmdlet returns that string.

### System.Xml.XmlDocument

When the request returns valid XML, this cmdlet returns it as an **XmlDocument**.

### PSObject

When the request returns JSON strings, this cmdlet returns a **PSObject** representing the data.

## NOTES

PowerShell includes the following aliases for `Invoke-RestMethod`:

- All platforms:
  - `irm`

Some features may not be available on all platforms.

Because of changes in .NET Core 3.1, PowerShell 7.0 and higher use the
[HttpClient.DefaultProxy](xref:System.Net.Http.HttpClient.DefaultProxy*)
property to determine the proxy configuration.

The value of this property is different rules depending on your platform:

- **For Windows**: Reads proxy configuration from environment variables or, if those are not
  defined, from the user's proxy settings.
- **For macOS**: Reads proxy configuration from environment variables or, if those are not defined,
  from the system's proxy settings.
- **For Linux**: Reads proxy configuration from environment variables or, in case those are not
  defined, this property initializes a non-configured instance that bypasses all addresses.

The environment variables used for `DefaultProxy` initialization on Windows and Unix-based platforms
are:

- `HTTP_PROXY`: the hostname or IP address of the proxy server used on HTTP requests.
- `HTTPS_PROXY`: the hostname or IP address of the proxy server used on HTTPS requests.
- `ALL_PROXY`: the hostname or IP address of the proxy server used on HTTP and HTTPS requests in
  case `HTTP_PROXY` or `HTTPS_PROXY` are not defined.
- `NO_PROXY`: a comma-separated list of hostnames that should be excluded from proxying.

PowerShell 7.4 added support for the Brotli compression algorithm.

## RELATED LINKS

[ConvertTo-Json](ConvertTo-Json.md)

[ConvertFrom-Json](ConvertFrom-Json.md)

[Invoke-WebRequest](Invoke-WebRequest.md)
