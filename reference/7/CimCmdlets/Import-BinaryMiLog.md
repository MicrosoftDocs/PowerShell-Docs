---
ms.date:  02/20/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=301309
external help file:  Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
---

# Import-BinaryMiLog

## SYNOPSIS
Used to re-create the saved objects based on the contents of an export file.

## SYNTAX

```
Import-BinaryMiLog [-Path] <String>
```

## DESCRIPTION

Use this cmdlet to re-create saved objects based on the contents of an export file created by
`Export-BinaryMILog`. This cmdlet is similar to `Import-Clixml`, except that `Export-BinaryMILog`
stores the resulting object in a binary encoded file.

## EXAMPLES

### Example 1 - Restore objects exported to a file

```powershell
Import-BinaryMiLog -Path "Processes.bmil"
```

## PARAMETERS

### -Path

Specifies the path of the file in which to store the binary representation of the object. The
**Path** parameter supports wild cards and relative paths. This cmdlet generates an error if the
path resolves to more than one file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
