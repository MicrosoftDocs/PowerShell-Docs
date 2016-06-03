---
external help file: PSITPro3_Security.xml
schema: 2.0.0
---

# Get-AuthenticodeSignature
## SYNOPSIS
Gets information about the Authenticode signature in a file.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-AuthenticodeSignature [-FilePath] <String[]>
```

### UNNAMED_PARAMETER_SET_2
```
Get-AuthenticodeSignature -LiteralPath <String[]>
```

## DESCRIPTION
The Get-AuthenticodeSignature cmdlet gets information about the Authenticode signature in a file.
If the file is not signed, the information is retrieved, but the fields are blank.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-AuthenticodeSignature -filepath C:\Test\NewScript.ps1
```

This command gets information about the Authenticode signature in the NewScript.ps1 file.
It uses the FilePath parameter to specify the file.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-authenticodesignature test.ps1, test1.ps1, sign-file.ps1, makexml.ps1
```

This command gets information about the Authenticode signature in the four files listed at the command line.
In this command, the name of the FilePath parameter, which is optional, is omitted.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-childitem $pshome\*.* | foreach-object {Get-AuthenticodeSignature $_} | where {$_.status -eq "Valid"}
```

This command lists all of the files in the $pshome directory that have a valid Authenticode signature.
The $pshome automatic variable contains the path to the Windows PowerShell installation directory.

The command uses the Get-ChildItem cmdlet to get the files in the $pshome directory.
It uses a pattern of *.* to exclude directories \(although it also excludes files without a dot in the filename\).

The command uses a pipeline operator \(|\) to send the files in $pshome to the Foreach-Object cmdlet, where Get-AuthenticodeSignature is called for each file.

The results of the Get-AuthenticodeSignature command are sent to a Where-Object command that selects only the signature objects with a status of "Valid".

## PARAMETERS

### -FilePath
Specifies the path to the file being examined.
Wildcards are permitted, but they must lead to a single file.
The parameter name \("FilePath"\) is optional.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: True
```

### -LiteralPath
Specifies the path to the file being examined.
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
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains a file path to Get-AuthenticodeSignature.

## OUTPUTS

### System.Management.Automation.Signature
Get-AuthenticodeSignature returns a signature object for each signature that it gets.

## NOTES
For information about Authenticode signatures in Windows PowerShell, see about_Signing.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113307)

[Get-ExecutionPolicy](f9f34cdc-63fb-47fc-adf7-6dcdafcc7431)

[Set-AuthenticodeSignature](f3c13299-4463-48af-83ea-86de4a239509)

[Set-ExecutionPolicy](5690a0e1-495b-4e63-8280-65ead7bf01ab)

[about_Execution_Policies](2e8d33b9-6c07-4a15-a486-9388d10eb00f)

[about_Signing](054e64fa-3571-40fd-a862-630b5217b4f4)


