---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Security
ms.date: 04/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.security/set-authenticodesignature?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-AuthenticodeSignature
---
# Set-AuthenticodeSignature

## SYNOPSIS
Adds an [Authenticode](/windows-hardware/drivers/install/authenticode) signature to a PowerShell
script or other file.

## SYNTAX

### ByPath (Default)

```
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-IncludeChain <String>]
 [-TimestampServer <String>] [-HashAlgorithm <String>] [-Force] [-FilePath] <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-IncludeChain <String>]
 [-TimestampServer <String>] [-HashAlgorithm <String>] [-Force] -LiteralPath <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByContent

```
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-IncludeChain <String>]
 [-TimestampServer <String>] [-HashAlgorithm <String>] [-Force] -SourcePathOrExtension <String[]>
 -Content <Byte[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-AuthenticodeSignature` cmdlet adds an Authenticode signature to any file that supports
Subject Interface Package (SIP).

In a PowerShell script file, the signature takes the form of a block of text that indicates the end
of the instructions that are executed in the script. If there is a signature in the file when this
cmdlet runs, that signature is removed.

## EXAMPLES

### Example 1 - Sign a script using a certificate from the local certificate store

These commands retrieve a code-signing certificate from the PowerShell certificate provider and use
it to sign a PowerShell script.

```powershell
$cert=Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert
Set-AuthenticodeSignature -FilePath PsTestInternet2.ps1 -Certificate $cert
```

The first command uses the `Get-ChildItem` cmdlet and the PowerShell certificate provider to get the
certificates in the `Cert:\CurrentUser\My` subdirectory of the certificate store. The `Cert:` drive
is the drive exposed by the certificate provider. The **CodeSigningCert** parameter, which is
supported only by the certificate provider, limits the certificates retrieved to those with
code-signing authority. The command stores the result in the `$cert` variable.

The second command uses the `Set-AuthenticodeSignature` cmdlet to sign the `PSTestInternet2.ps1`
script. It uses the **FilePath** parameter to specify the name of the script and the **Certificate**
parameter to specify that the certificate is stored in the `$cert` variable.

> [!NOTE]
> Using the **CodeSigningCert** parameter with `Get-ChildItem` only returns certificates that have
> code-signing authority and contain a private key. If there is no private key, the certificates
> cannot be used for signing.

### Example 2 - Sign a script using a certificate from a PFX file

These commands use the `Get-PfxCertificate` cmdlet to load a code signing certificate. Then, use it
to sign a PowerShell script.

```powershell
$cert = Get-PfxCertificate -FilePath C:\Test\Mysign.pfx
Set-AuthenticodeSignature -FilePath ServerProps.ps1 -Certificate $cert
```

The first command uses the `Get-PfxCertificate` cmdlet to load the C:\Test\MySign.pfx certificate
into the `$cert` variable.

The second command uses `Set-AuthenticodeSignature` to sign the script. The **FilePath** parameter
of `Set-AuthenticodeSignature` specifies the path to the script file being signed and the **Cert**
parameter passes the `$cert` variable containing the certificate to `Set-AuthenticodeSignature`.

If the certificate file is password protected, PowerShell prompts you for the password.

### Example 3 - Add a signature that includes the root authority

This command adds a digital signature that includes the root authority in the trust chain, and it is
signed by a third-party timestamp server.

```powershell
Set-AuthenticodeSignature -FilePath c:\scripts\Remodel.ps1 -Certificate $cert -IncludeChain All -TimestampServer "http://timestamp.fabrikam.com/scripts/timstamper.dll"
```

The command uses the **FilePath** parameter to specify the script being signed and the
**Certificate** parameter to specify the certificate that is saved in the `$cert` variable. It uses
the **IncludeChain** parameter to include all of the signatures in the trust chain, including the
root authority. It also uses the **TimeStampServer** parameter to add a timestamp to the signature.
This prevents the script from failing when the certificate expires.

## PARAMETERS

### -Certificate

Specifies the certificate that will be used to sign the script or file. Enter a variable that stores
an object representing the certificate or an expression that gets the certificate.

To find a certificate, use `Get-PfxCertificate` or use the `Get-ChildItem` cmdlet in the Certificate
`Cert:` drive. If the certificate is not valid or does not have `code-signing` authority, the
command fails.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies the path to a file that is being signed.

```yaml
Type: System.String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force

Allows the cmdlet to append a signature to a read-only file. Even using the **Force** parameter, the
cmdlet cannot override security restrictions.

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

### -HashAlgorithm

Specifies the hashing algorithm that Windows uses to compute the digital signature for the file.

For PowerShell 3.0, the default is SHA256, which is the Windows default hashing algorithm. For
PowerShell 2.0, the default is SHA1. Files that are signed with a different hashing algorithm might
not be recognized on other systems. Which algorithms are supported depends on the version of the
operating system.

For a list of possible values, see [HashAlgorithmName Struct](/dotnet/api/system.security.cryptography.hashalgorithmname?view=netframework-4.7.2#properties).

```yaml
Type: System.String
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
**NotRoot** is the default.

Valid values are:

- Signer: Includes only the signer's certificate.
- NotRoot: Includes all of the certificates in the certificate chain, except for the root authority.
- All: Includes all the certificates in the certificate chain.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: NotRoot
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimestampServer

Uses the specified time stamp server to add a time stamp to the signature. Type the URL of the time
stamp server as a string.

The time stamp represents the exact time that the certificate was added to the file. A time stamp
prevents the script from failing if the certificate expires because users and programs can verify
that the certificate was valid at the time of signing.

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

### -LiteralPath

Specifies the path to a file that is being signed. Unlike **FilePath**, the value of the
**LiteralPath** parameter is used exactly as it is typed. No characters are interpreted as
wildcards. If the path includes escape characters, enclose it in single quotation marks. Single
quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SourcePathOrExtension

Path to the file or file type of the content for which the digital signature is added. This
parameter is used with **Content** where file content is passed as a byte array.

```yaml
Type: System.String[]
Parameter Sets: ByContent
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Content

Contents of a file as a byte array for which the digital signature is added. This parameter must be
used with **SourcePathOrExtension** parameter. The contents of the file must be in Unicode
(UTF-16LE) format.

```yaml
Type: System.Byte[]
Parameter Sets: ByContent
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains the file path to `Set-AuthenticodeSignature`.

## OUTPUTS

### System.Management.Automation.Signature

## NOTES

This cmdlet is only available on Windows platforms.

## RELATED LINKS

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Get-ExecutionPolicy](Get-ExecutionPolicy.md)

[Get-PfxCertificate](Get-PfxCertificate.md)

[Set-ExecutionPolicy](Set-ExecutionPolicy.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)
