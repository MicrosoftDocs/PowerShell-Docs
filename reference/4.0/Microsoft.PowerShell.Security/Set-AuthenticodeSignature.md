---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293940
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Set-AuthenticodeSignature
---

# Set-AuthenticodeSignature

## SYNOPSIS
Adds an Authenticode signature to a Windows PowerShell script or other file.

## SYNTAX

### ByPath (Default)
```
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-IncludeChain <String>]
 [-TimestampServer <String>] [-HashAlgorithm <String>] [-Force] [-FilePath] <String[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ByLiteralPath
```
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-IncludeChain <String>]
 [-TimestampServer <String>] [-HashAlgorithm <String>] [-Force] -LiteralPath <String[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The Set-AuthenticodeSignature cmdlet adds an Authenticode signature to any file that supports Subject Interface Package (SIP).

In a Windows PowerShell script file, the signature takes the form of a block of text that indicates the end of the instructions that are executed in the script.
If there is a signature in the file when this cmdlet runs, that signature is removed.

## EXAMPLES

### Example 1
```
PS C:\> $cert=Get-ChildItem -Path cert:\CurrentUser\my -CodeSigningCert
PS C:\> Set-AuthenticodeSignature -FilePath PsTestInternet2.ps1 -certificate $cert
```

These commands retrieve a code-signing certificate from the Windows PowerShell certificate provider and use it to sign a Windows PowerShell script.

The first command uses the Get-ChildItem cmdlet and the Windows PowerShell certificate provider to get the certificates in the Cert:\CurrentUser\My subdirectory of the certificate store.
(The Cert: drive is the drive exposed by the certificate provider.) The CodeSigningCert parameter, which is supported only by the certificate provider, limits the certificates retrieved to those with code-signing authority.
The command stores the result in the $cert variable.

The second command uses the Set-AuthenticodeSignature cmdlet to sign the PSTestInternet2.ps1 script.
It uses the FilePath parameter to specify the name of the script and the Certificate parameter to specify that the certificate is stored in the $cert variable.

### Example 2
```
PS C:\> $cert = Get-PfxCertificate C:\Test\Mysign.pfx
PS C:\> Set-AuthenticodeSignature -Filepath ServerProps.ps1 -Cert $cert
```

These commands use the Get-PfxCertificate cmdlet to find a code signing certificate.
Then, they use it to sign a Windows PowerShell script.

The first command uses the Get-PfxCertificate cmdlet to find the C:\Test\MySign.pfx certificate and store it in the $cert variable.

The second command uses Set-AuthenticodeSignature to sign the script.
The FilePath parameter of Set-AuthenticodeSignature specifies the path to the script file being signed and the Cert parameter passes the $cert variable containing the certificate to Set-AuthenticodeSignature.

If the certificate file is password protected, Windows PowerShell prompts you for the password.

### Example 3
```
PS C:\> Set-AuthenticodeSignature -filepath c:\scripts\Remodel.ps1 -certificate $cert -IncludeChain All -TimeStampServer "http://timestamp.fabrikam.com/scripts/timstamper.dll"
```

This command adds a digital signature that includes the root authority in the trust chain, and it is signed by a third-party timestamp server.

The command uses the FilePath parameter to specify the script being signed and the Certificate parameter to specify the certificate that is saved in the $cert variable.
It uses the IncludeChain parameter to include all of the signatures in the trust chain (including the root authority).
It also uses the TimeStampServer parameter to add a timestamp to the signature.
This prevents the script from failing when the certificate expires.

## PARAMETERS

### -Certificate
Specifies the certificate that will be used to sign the script or file.
Enter a variable that stores an object representing the certificate or an expression that gets the certificate.

To find a certificate, use Get-PfxCertificate or use the Get-ChildItem cmdlet in the Certificate (Cert:) drive.
If the certificate is not valid or does not have code-signing authority, the command fails.

```yaml
Type: X509Certificate2
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies the path to a file that is being signed.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force
Allows the cmdlet to append a signature to a read-only file.
Even using the Force parameter, the cmdlet cannot override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HashAlgorithm
Specifies the hashing algorithm that Windows uses to compute the digital signature for the file.

For Windows PowerShell 3.0, the default is SHA256, which is the Windows default hashing algorithm.
For Windows PowerShell 2.0, the default is SHA1.
Files that are signed with a different hashing algorithm might not be recognized on other systems.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: SHA256
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeChain
Determines which certificates in the certificate trust chain are included in the digital signature.
"NotRoot" is the default.

Valid values are:

- Signer: Includes only the signer's certificate.
- NotRoot: Includes all of the certificates in the certificate chain, except for the root authority.
--All: Includes all the certificates in the certificate chain.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: NotRoot
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimestampServer
Uses the specified time stamp server to add a time stamp to the signature.
Type the URL of the time stamp server as a string.

The time stamp represents the exact time that the certificate was added to the file.
A time stamp prevents the script from failing if the certificate expires because users and programs can verify that the certificate was valid at the time of signing.

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

### -LiteralPath
Specifies the path to a file that is being signed.
Unlike **FilePath**, the value of the **LiteralPath** parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains the file path to Set-AuthenticodeSignature.

## OUTPUTS

### System.Management.Automation.Signature

## NOTES

## RELATED LINKS

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Get-ExecutionPolicy](Get-ExecutionPolicy.md)

[Get-PfxCertificate](Get-PfxCertificate.md)

[Set-ExecutionPolicy](Set-ExecutionPolicy.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)

