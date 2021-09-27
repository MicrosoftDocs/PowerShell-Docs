---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Security
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.security/get-pfxcertificate?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-PfxCertificate
---
# Get-PfxCertificate

## Synopsis
Gets information about PFX certificate files on the computer.

## Syntax

### ByPath (Default)

```
Get-PfxCertificate [-FilePath] <String[]> [-Password <SecureString>] [-NoPromptForPassword]
 [<CommonParameters>]
```

### ByLiteralPath

```
Get-PfxCertificate -LiteralPath <String[]> [-Password <SecureString>] [-NoPromptForPassword]
 [<CommonParameters>]
```

## Description

The `Get-PfxCertificate` cmdlet gets an object representing each specified PFX certificate file.
A PFX file includes both the certificate and a private key.

## Examples

### Example 1: Get a PFX certificate

```powershell
Get-PfxCertificate -FilePath "C:\windows\system32\Test.pfx"
```

```output
Password: ******
Signer Certificate:      David Chew (Self Certificate)
Time Certificate:
Time Stamp:
Path:                    C:\windows\system32\zap.pfx
```

This command gets information about the Test.pfx certificate file on the system.

### Example 2: Get a PFX certificate from a remote computer

```powershell
Invoke-Command -ComputerName "Server01" -ScriptBlock {Get-PfxCertificate -FilePath "C:\Text\TestNoPassword.pfx"} -Authentication CredSSP
```

This command gets a PFX certificate file from the Server01 remote computer. It uses `Invoke-Command`
to run a `Get-PfxCertificate` command remotely.

When the PFX certificate file is not password-protected, the value of the **Authentication**
parameter of `Invoke-Command` must be CredSSP.

## Parameters

### -FilePath

Specifies the full path to the PFX file of the secured file. If you specify a value for this
parameter, it is not necessary to type `-FilePath` at the command line.

```yaml
Type: System.String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LiteralPath

The full path to the PFX file of the secured file. Unlike **FilePath**, the value of the
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

### -NoPromptForPassword

Suppresses prompting for a password.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password

Specifies a password required to access a `.pfx` certificate file.

This parameter was introduced in PowerShell 6.1.

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

You can pipe a string that contains a file path to `Get-PfxCertificate`.

## Outputs

### System.Security.Cryptography.X509Certificates.X509Certificate2

`Get-PfxCertificate` returns an object for each certificate that it gets.

## Notes

When using the `Invoke-Command` cmdlet to run a `Get-PfxCertificate` command remotely, and the PFX
certificate file is not password protected, the value of the **Authentication** parameter of
`Invoke-Command` must be CredSSP.

## Related links

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)
