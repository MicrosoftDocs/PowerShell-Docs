---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293988
schema: 2.0.0
---

# Invoke-WebRequest
## SYNOPSIS
Gets content from a web page on the Internet.

## SYNTAX

```
Invoke-WebRequest [-UseBasicParsing] [-Uri] <Uri> [-WebSession <WebRequestSession>] [-SessionVariable <String>]
 [-Credential <PSCredential>] [-UseDefaultCredentials] [-CertificateThumbprint <String>]
 [-Certificate <X509Certificate>] [-UserAgent <String>] [-DisableKeepAlive] [-TimeoutSec <Int32>]
 [-Headers <IDictionary>] [-MaximumRedirection <Int32>] [-Method <WebRequestMethod>] [-Proxy <Uri>]
 [-ProxyCredential <PSCredential>] [-ProxyUseDefaultCredentials] [-Body <Object>] [-ContentType <String>]
 [-TransferEncoding <String>] [-InFile <String>] [-OutFile <String>] [-PassThru]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Invoke-WebRequest cmdlet sends HTTP, HTTPS, FTP, and FILE requests to a web page or web service.
It parses the response and returns collections of forms, links, images, and other significant HTML elements.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1
```
PS C:\>$r = Invoke-WebRequest -URI http://www.bing.com?q=how+many+feet+in+a+mile
PS C:\>$r.AllElements | where {$_.innerhtml -like "*=*"} | Sort { $_.InnerHtml.Length } | Select InnerText -First 5
innerText---------1 =5280 feet1 mile
```

This command uses the Invoke-WebRequest cmdlet to send a web request to the Bing.com site.

The first command issues the request and saves the response in the $r variable.

The second command gets the InnerHtml property when it includes an equal sign, sorts the inner HTML by length and selects the 5 shortest values.
Sorting by the shortest HTML value often helps you find the most specific element that matches that text.

### Example 2
```
The first command uses the Invoke-WebRequest cmdlet to send a sign-in request. The command specifies a value of "fb" for the value of the SessionVariable parameter, and saves the result in the $r variable.When the command completes, the $r variable contains an HtmlWebResponseObject and the $fb variable contains a WebRequestSession object.
PS C:\>$r=Invoke-WebRequest http://www.facebook.com/login.php -SessionVariable fb

The second command shows the WebRequestSession object in the $fb variable.
PS C:\>$fb

The third command gets the first form in the Forms property of the HTTP response object in the $r variable, and saves it in the $form variable.
PS C:\>$form = $r.Forms[0]

The fourth command pipes the properties of the form in the $form variable into a list by using the Format-List cmdlet.
PS C:\>$form | Format-List

The fifth command displays the keys and values in the hash table (dictionary) object in the Fields property of the form.
PS C:\>$form.fields

The sixth and seventh commands populate the values of the "email" and "pass" keys of the hash table in the Fields property of the form. You can replace the email and password with values that you want to use.
PS C:\>$form.Fields["email"]="User01@Fabrikam.com"
$form.Fields["pass"]="P@ssw0rd"

The eighth command uses the Invoke-WebRequest cmdlet to sign into the Facebook web service.The value of the Uri parameter is the value of the Action property of the form. The WebRequestSession object in the $fb variable (the session variable specified in the first command) is now the value of the WebSession parameter. The value of the Body parameter is the hash table in the Fields property of the form and the value of the Method parameter is POST. The command saves the output in the $r variable.
PS C:\>$r=Invoke-WebRequest -Uri ("https://www.facebook.com" + $form.Action) -WebSession $fb -Method POST -Body $form.Fields

The full script, then, is as follows.
PS C:\># Sends a sign-in request by running the Invoke-WebRequest cmdlet. The command specifies a value of "fb" for the SessionVariable parameter, and saves the results in the $r variable.

$r=Invoke-WebRequest http://www.facebook.com/login.php -SessionVariable fb

# Use the session variable that you created in Example 1. Output displays values for Headers, Cookies, Credentials, etc. 

$fb

# Gets the first form in the Forms property of the HTTP response object in the $r variable, and saves it in the $form variable. 

$form = $r.Forms[0]

# Pipes the form properties that are stored in the $forms variable into the Format-List cmdlet, to display those properties in a list. 

$form | Format-List

# Displays the keys and values in the hash table (dictionary) object in the Fields property of the form.

$form.fields

# The next two commands populate the values of the "email" and "pass" keys of the hash table in the Fields property of the form. Of course, you can replace the email and password with values that you want to use. 

$form.Fields["email"] = "User01@Fabrikam.com"
$form.Fields["pass"] = "P@ssw0rd"

# The final command uses the Invoke-WebRequest cmdlet to sign in to the Facebook web service. 

$r=Invoke-WebRequest -Uri ("https://www.facebook.com" + $form.Action) -WebSession $fb -Method POST -Body $form.Fields

When the command finishes, the StatusDescription property of the web response object in the $r variable indicates that the user is signed in successfully.
PS C:\>$r.StatusDescription
```

This example shows how to use the Invoke-WebRequest cmdlet with a stateful web service, such as Facebook.

### Example 3
```
PS C:\>(Invoke-WebRequest -Uri "http://msdn.microsoft.com/en-us/library/aa973757(v=vs.85).aspx").Links.Href
```

This command gets the links in a web page.
It uses the Invoke-WebRequest cmdlet to get the web page content.
Then it users the Links property of the HtmlWebResponseObject that Invoke-WebRequest returns, and the Href property of each link.

## PARAMETERS

### -Body
Specifies the body of the request.
The body is the content of the request that follows the headers.
You can also pipe a body value to Invoke-WebRequest.

The Body parameter can be used to specify a list of query parameters or specify the content of the response.

When the input is a GET request and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other GET requests, the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of an Invoke-WebRequest call, Windows PowerShell sets the request content to the form fields.

For example:

$r = Invoke-WebRequest http://website.com/login.aspx
$r.Forms\[0\].Name = "MyName"
$r.Forms\[0\].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $r

- or -

Invoke-RestMethod http://website.com/service.aspx -Body $r.Forms\[0\]

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

If this parameter is omitted and the request method is POST, Invoke-WebRequest sets the content type to "application/x-www-form-urlencoded".
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

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.

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
Sets the KeepAlive value in the HTTP header to False.
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

To set UserAgent headers, use the UserAgent parameter.
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

When the input is a GET request and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other GET requests, the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of an Invoke-WebRequest call, Windows PowerShell sets the request content to the form fields.

For example:

$r = Invoke-WebRequest http://website.com/login.aspx
$r.Forms\[0\].Name = "MyName"
$r.Forms\[0\].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $r

- or -

Invoke-RestMethod http://website.com/service.aspx -Body $r.Forms\[0\]

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

When the input is a GET request and the body is an IDictionary (typically, a hash table), the body is added to the URI as query parameters.
For other GET requests, the body is set as the value of the request body in the standard name=value format.

When the body is a form, or it is the output of an Invoke-WebRequest call, Windows PowerShell sets the request content to the form fields.

For example:

$r = Invoke-WebRequest http://website.com/login.aspx
$r.Forms\[0\].Name = "MyName"
$r.Forms\[0\].Password = "MyPassword"
Invoke-RestMethod http://website.com/service.aspx -Body $r

- or -

Invoke-RestMethod http://website.com/service.aspx -Body $r.Forms\[0\]

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

### -Method
Specifies the method used for the web request.
Valid values are Default, Delete, Get, Head, Merge, Options, Patch, Post, Put, and Trace.

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
Saves the response body in the specified output file.
Enter a path and file name.
If you omit the path, the default is the current location.

By default, Invoke-WebRequest returns the results to the pipeline.
To send the results to a file and to the pipeline, use the Passthru parameter.

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
This parameter is valid only when the OutFile parameter is also used in the command.

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
Specifies a user account that has permission to use the proxy server that is specified by the Proxy parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.

This parameter is valid only when the Proxy parameter is also used in the command.
You cannot use the ProxyCredential and ProxyUseDefaultCredentials parameters in the same command.

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
Uses the credentials of the current user to access the proxy server that is specified by the Proxy parameter.

This parameter is valid only when the Proxy parameter is also used in the command.
You cannot use the ProxyCredential and ProxyUseDefaultCredentials parameters in the same command.

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
Creates a web request session and saves it in the value of the specified variable.
Enter a variable name without the dollar sign ($) symbol.

When you specify a session variable, Invoke-WebRequest creates a web request session object and assigns it to a variable with the specified name in your Windows PowerShell session.
You can use the variable in your session as soon as the command completes.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To use the web request session in subsequent web requests, specify the session variable in the value of the WebSession parameter.
Windows PowerShell uses the data in the web request session object when establishing the new connection.
To override a value in the web request session, use a cmdlet parameter, such as UserAgent or Credential.
Parameter values take precedence over values in the web request session.

You cannot use the SessionVariable and WebSession parameters in the same command.

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
Valid values are Chunked, Compress, Deflate, GZip and Identity.

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
Enter a URI.
This parameter supports HTTP, HTTPS, FTP, and FILE values.

This parameter is required.
The parameter name (-Uri) is optional.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseBasicParsing
Uses the response object for HTML content without Document Object Model (DOM) parsing.

This parameter is required when Internet Explorer is not installed on the computers, such as on a Server Core installation of a Windows Server operating system.

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

To test a website with the standard user agent string that is used by most Internet browsers, use the properties of the PSUserAgent class, such as Chrome, FireFox, InternetExplorer, Opera, and Safari.

For example, the following command uses the user agent string for Internet

Invoke-WebRequest -Uri http://website.com/ -UserAgent (\[Microsoft.PowerShell.Commands.PSUserAgent\]::InternetExplorer)

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

To override a value in the web request session, use a cmdlet parameter, such as UserAgent or Credential.
Parameter values take precedence over values in the web request session.

Unlike a remote session, the web request session is not a persistent connection.
It is an object that contains information about the connection and the request, including cookies, credentials, the maximum redirection value, and the user agent string.
You can use it to share state and data among web requests.

To create a web request session, enter a variable name (without a dollar sign) in the value of the SessionVariable parameter of an Invoke-WebRequest command.
Invoke-WebRequest creates the session and saves it in the variable.
In subsequent commands, use the variable as the value of the WebSession parameter.

You cannot use the SessionVariable and WebSession parameters in the same command.

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

## INPUTS

### System.Object
You can pipe the body of a web request to Invoke-WebRequest

## OUTPUTS

### Microsoft.PowerShell.Commands.HtmlWebResponseObject

## NOTES

## RELATED LINKS

[Invoke-RestMethod]()

[ConvertFrom-Json]()

[ConvertTo-Json]()

