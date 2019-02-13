---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821711
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Get-AuthenticodeSignature
---
# Get-AuthenticodeSignature

## SYNOPSIS
Gets information about the Authenticode signature for a file.

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

```
PS C:\> Get-AuthenticodeSignature -FilePath "C:\Test\NewScript.ps1"
```

This command gets information about the Authenticode signature in the NewScript.ps1 file.
It uses the *FilePath* parameter to specify the file.

### Example 2: Get the Authenticode signature for multiple files

```
PS C:\> Get-AuthenticodeSignature test.ps1, test1.ps1, sign-file.ps1, makexml.ps1
```

This command gets information about the Authenticode signature for the four files listed at the command line.
In this example, the name of the *FilePath* parameter, which is optional, is omitted.

### Example 3: Get only valid Authenticode signatures for multiple files

```
PS C:\> Get-ChildItem $pshome\*.* | ForEach-object {Get-AuthenticodeSignature $_} | where {$_.status -eq "Valid"}
```

This command lists all of the files in the $pshome directory that have a valid Authenticode signature.
The $pshome automatic variable contains the path to the Windows PowerShell installation directory.

The command uses the **Get-ChildItem** cmdlet to get the files in the $pshome directory.
It uses a pattern of *.* to exclude directories (although it also excludes files without a dot in the filename).

The command uses a pipeline operator (|) to send the files in $pshome to the ForEach-Object cmdlet, where **Get-AuthenticodeSignature** is called for each file.

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
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the file being examined.
Unlike *FilePath*, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes an escape character, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape characters.

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

You can pipe a string that contains a file path to **Get-AuthenticodeSignature**.

## OUTPUTS

### System.Management.Automation.Signature

**Get-AuthenticodeSignature** returns a signature object for each signature that it gets.

## NOTES

* For information about Authenticode signatures in Windows PowerShell, see about_Signing.

*

## RELATED LINKS

[Get-ExecutionPolicy](Get-ExecutionPolicy.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)

[Set-ExecutionPolicy](Set-ExecutionPolicy.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)