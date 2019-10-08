---
external help file: Microsoft.PowerShell.Security.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.security/get-authenticodesignature?view=powershell-3.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-AuthenticodeSignature
---
# Get-AuthenticodeSignature

## SYNOPSIS
Gets information about the Authenticode signature in a file.

## SYNTAX

### ByPath (Default)

```
Get-AuthenticodeSignature [-FilePath] <String[]> [<CommonParameters>]
```

### ByLiteralPath

```
Get-AuthenticodeSignature -LiteralPath <String[]> [<CommonParameters>]
```

## DESCRIPTION

The **Get-AuthenticodeSignature** cmdlet gets information about the Authenticode signature for a file.
If the file is not signed, the information is retrieved, but the fields are blank.

## EXAMPLES

### Example 1: Get the Authenticode signature for a file

```powershell
Get-AuthenticodeSignature -FilePath "C:\Test\NewScript.ps1"
```

This command gets information about the Authenticode signature in the NewScript.ps1 file.
It uses the *FilePath* parameter to specify the file.

### Example 2: Get the Authenticode signature for multiple files

```powershell
Get-AuthenticodeSignature test.ps1, test1.ps1, sign-file.ps1, makexml.ps1
```

This command gets information about the Authenticode signature for the four files listed at the command line.
In this example, the name of the *FilePath* parameter, which is optional, is omitted.

### Example 3: Get only valid Authenticode signatures for multiple files

```powershell
Get-ChildItem $PSHOME\*.* | ForEach-object {Get-AuthenticodeSignature $_} | Where-Object {$_.status -eq "Valid"}
```

This command lists all of the files in the `$PSHOME` directory that have a valid Authenticode signature.
The `$PSHOME` automatic variable contains the path to the PowerShell installation directory.

The command uses the **Get-ChildItem** cmdlet to get the files in the `$PSHOME` directory.
It uses a pattern of *.* to exclude directories (although it also excludes files without a dot in the filename).

The command uses a pipeline operator (|) to send the files in `$PSHOME` to the ForEach-Object cmdlet, where **Get-AuthenticodeSignature** is called for each file.

The results of the **Get-AuthenticodeSignature** command are sent to a Where-Object command that selects only the signature objects with a status of Valid.

## PARAMETERS

### -FilePath

Specifies the path to the file to examine.
Wildcards are permitted, but they must lead to a single file.
It is not necessary to type `-FilePath` at the command line when you specify a value for this parameter.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -LiteralPath

Specifies the path to the file being examined.
Unlike *FilePath*, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes an escape character, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape characters.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a file path to **Get-AuthenticodeSignature**.

## OUTPUTS

### System.Management.Automation.Signature

**Get-AuthenticodeSignature** returns a signature object for each signature that it gets.

## NOTES

For information about Authenticode signatures in PowerShell, see [about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md).

## RELATED LINKS

[Get-ExecutionPolicy](Get-ExecutionPolicy.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)

[Set-ExecutionPolicy](Set-ExecutionPolicy.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)

