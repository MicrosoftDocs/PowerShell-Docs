### Cryptographic Message Syntax (CMS) cmdlets

The Cryptographic Message Syntax cmdlets support encryption and decryption of content using the IETF standard format for cryptographically protecting messages as documented by [RFC5652](http://tools.ietf.org/html/rfc5652).

  Get-CmsMessage \[-Content\] &lt;string&gt;

  Get-CmsMessage \[-Path\] &lt;string&gt;

  Get-CmsMessage \[-LiteralPath\] &lt;string&gt;

  Protect-CmsMessage \[-To\] &lt;CmsMessageRecipient\[\]&gt; \[-Content\] &lt;string&gt; \[\[-OutFile\] &lt;string&gt;\]

  Protect-CmsMessage \[-To\] &lt;CmsMessageRecipient\[\]&gt; \[-Path\] &lt;string&gt; \[\[-OutFile\] &lt;string&gt;\]

  Protect-CmsMessage \[-To\] &lt;CmsMessageRecipient\[\]&gt; \[-LiteralPath\] &lt;string&gt; \[\[-OutFile\] &lt;string&gt;\]

  Unprotect-CmsMessage \[-EventLogRecord\] &lt;EventLogRecord&gt; \[\[-To\] &lt;CmsMessageRecipient\[\]&gt;\] \[-IncludeContext\]

  Unprotect-CmsMessage \[-Content\] &lt;string&gt; \[\[-To\] &lt;CmsMessageRecipient\[\]&gt;\] \[-IncludeContext\]

  Unprotect-CmsMessage \[-Path\] &lt;string&gt; \[\[-To\] &lt;CmsMessageRecipient\[\]&gt;\] \[-IncludeContext\]

  Unprotect-CmsMessage \[-LiteralPath\] &lt;string&gt; \[\[-To\] &lt;CmsMessageRecipient\[\]&gt;\] \[-IncludeContext\]

The CMS encryption standard implements public key cryptography, where the keys used to encrypt content (the *public key*) and the keys used to decrypt content (the *private key*) are separate.

Your public key can be shared widely, and is not sensitive data. If any content is encrypted with this public key, only your private key can decrypt it. For more information about Public Key Cryptography, see: <http://en.wikipedia.org/wiki/Public-key_cryptography>.

To be recognized in Windows PowerShell, encryption certificates require a unique key usage identifier (EKU) to identify them as data encryption certificates (like the identifiers for 'Code Signing', 'Encrypted Mail').

Here is an example of creating a certificate that is good for Document Encryption:

(Change the text in **Subject** to your name, email, or other identifier), and put in a file (i.e.: DocumentEncryption.inf):

  \[Version\]

  Signature = "$Windows NT$"

  \[Strings\]

  szOID\_ENHANCED\_KEY\_USAGE = "2.5.29.37"

  szOID\_DOCUMENT\_ENCRYPTION = "1.3.6.1.4.1.311.80.1"

  \[NewRequest\]

  Subject = "<cn=me@somewhere.com>"

  MachineKeySet = false

  KeyLength = 2048

  KeySpec = AT\_KEYEXCHANGE

  HashAlgorithm = Sha1

  Exportable = true

  RequestType = Cert

  KeyUsage = "CERT\_KEY\_ENCIPHERMENT\_KEY\_USAGE | CERT\_DATA\_ENCIPHERMENT\_KEY\_USAGE"

  ValidityPeriod = "Years"

  ValidityPeriodUnits = "1000"

  \[Extensions\]

  %szOID\_ENHANCED\_KEY\_USAGE% = "{text}%szOID\_DOCUMENT\_ENCRYPTION%"

Then run:

  certreq -new DocumentEncryption.inf DocumentEncryption.cer

And you can now encrypt and decrypt content:

> 106 \[C:\\temp\]
> &gt;&gt; $protected = "Hello World" | Protect-CmsMessage -To "\*me@somewhere.com\*[](mailto:*leeholm@microsoft.com*)"
>
> 107 \[C:\\temp\]
> &gt;&gt; $protected
> -----BEGIN CMS-----
> MIIBqAYJKoZIhvcNAQcDoIIBmTCCAZUCAQAxggFQMIIBTAIBADA0MCAxHjAcBgNVBAMMFWxlZWhv
> bG1AbWljcm9zb2Z0LmNvbQIQQYHsbcXnjIJCtH+OhGmc1DANBgkqhkiG9w0BAQcwAASCAQAnkFHM
> proJnFy4geFGfyNmxH3yeoPvwEYzdnsoVqqDPAd8D3wao77z7OhJEXwz9GeFLnxD6djKV/tF4PxR
> E27aduKSLbnxfpf/sepZ4fUkuGibnwWFrxGE3B1G26MCenHWjYQiqv+Nq32Gc97qEAERrhLv6S4R
> G+2dJEnesW8A+z9QPo+DwYU5FzD0Td0ExrkswVckpLNR6j17Yaags3ltNVmbdEXekhi6Psf2MLMP
> TSO79lv2L0KeXFGuPOrdzPAwCkV0vNEqTEBeDnZGrjv/5766bM3GW34FXApod9u+VSFpBnqVOCBA
> DVDraA6k+xwBt66cV84OHLkh0kT02SIHMDwGCSqGSIb3DQEHATAdBglghkgBZQMEASoEEJbJaiRl
> KMnBoD1dkb/FzSWAEBaL8xkFwCu0e1ZtDj7nSJc=
> -----END CMS-----
>
> 108 \[C:\\temp\]
> &gt;&gt; $protected | Unprotect-CmsMessage
> Hello World

Any parameter of type **CMSMessageRecipient** supports identifiers in the following formats:

-   An actual certificate (as retrieved from the certificate provider)

-   Path to the a file containing the certificate

-   Path to a directory containing the certificate

-   Thumbprint of the certificate (used to look in the certificate store)

-   Subject name of the certificate (used to look in the certificate store)

To view document encryption certificates in the certificate provider, you can use the -**DocumentEncryptionCert** dynamic parameter:

58 \[Cert:\\currentuser\\my\]

&gt;&gt; dir -DocumentEncryptionCert