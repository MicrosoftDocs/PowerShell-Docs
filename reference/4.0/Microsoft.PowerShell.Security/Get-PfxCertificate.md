---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293938
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Get-PfxCertificate
---

# Get-PfxCertificate

## SYNOPSIS
Gets information about .pfx certificate files on the computer.

## SYNTAX

### ByPath (Default)
```
Get-PfxCertificate [-FilePath] <String[]> [<CommonParameters>]
```

### ByLiteralPath
```
Get-PfxCertificate -LiteralPath <String[]> [<CommonParameters>]
```

## DESCRIPTION
The Get-PfxCertificate cmdlet gets an object representing each specified .pfx certificate file.
A .pfx file includes both the certificate and a private key.

## EXAMPLES

### Example 1
```
PS C:\> get-pfxcertificate -filepath C:\windows\system32\Test.pfx
Password: ******
Signer Certificate:      Matt Berg (Self Certificate)
Time Certificate:
Time Stamp:
Path:                    C:\windows\system32\zap.pfx
```

This command gets information about the Test.pfx certificate on the system.

### Example 2
```
PS C:\> invoke-command -computername Server01 -scriptblock {get-pfxcertificate -filepath C:\Text\TestNoPassword.pfx} -authentication CredSSP
```

This command gets a .pfx certificate file from the Server01 remote computer.
It uses the Invoke-Command to run a Get-PfxCertificate command remotely.

When the .pfx certificate file is not password-protected, the value of the Authentication parameter of Invoke-Command must be "CredSSP".

## PARAMETERS

### -FilePath
The full path to the .pfx file of the secured file.
The parameter name ("FilePath") is optional.

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

### -LiteralPath
The full path to the .pfx file of the secured file.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a file path to Get-PfxCertificate.

## OUTPUTS

### System.Security.Cryptography.X509Certificates.X509Certificate2
Get-PfxCertificate returns an object for each certificate that it gets.

## NOTES
* When using the Invoke-Command cmdlet to run a Get-PfxCertificate command remotely, and the .pfx certificate file is not password protected, the value of the Authentication parameter of Invoke-Command must be "CredSSP".

*

## RELATED LINKS

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)

