---
external help file: PSITPro3_Security.xml
online version: http://go.microsoft.com/fwlink/?LinkID=113323
schema: 2.0.0
---

# Get-PfxCertificate
## SYNOPSIS
Gets information about .pfx certificate files on the computer.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-PfxCertificate [-FilePath] <String[]>
```

### UNNAMED_PARAMETER_SET_2
```
Get-PfxCertificate -LiteralPath <String[]>
```

## DESCRIPTION
The Get-PfxCertificate cmdlet gets an object representing each specified .pfx certificate file.
A .pfx file includes both the certificate and a private key.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-pfxcertificate -filepath C:\windows\system32\Test.pfx
Password: ******
Signer Certificate:      Matt Berg (Self Certificate)
Time Certificate:
Time Stamp:
Path:                    C:\windows\system32\zap.pfx
```

This command gets information about the Test.pfx certificate on the system.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>invoke-command -computername Server01 -scriptblock {get-pfxcertificate -filepath C:\Text\TestNoPassword.pfx} -authentication CredSSP
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -LiteralPath
The full path to the .pfx file of the secured file.
Unlike FilePath, the value of the LiteralPath parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains a file path to Get-PfxCertificate.

## OUTPUTS

### System.Security.Cryptography.X509Certificates.X509Certificate2
Get-PfxCertificate returns an object for each certificate that it gets.

## NOTES
When using the Invoke-Command cmdlet to run a Get-PfxCertificate command remotely, and the .pfx certificate file is not password protected, the value of the Authentication parameter of Invoke-Command must be "CredSSP".

## RELATED LINKS

[Get-AuthenticodeSignature](36e5e640-2125-476e-98d9-495977315f14)

[Set-AuthenticodeSignature](f3c13299-4463-48af-83ea-86de4a239509)

[about_Signing](054e64fa-3571-40fd-a862-630b5217b4f4)

