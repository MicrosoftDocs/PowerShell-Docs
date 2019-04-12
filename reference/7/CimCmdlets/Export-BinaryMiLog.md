---
ms.date:  02/20/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=301310
external help file:  Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
---

# Export-BinaryMiLog

## SYNOPSIS
Creates a binary encoded representation of an object or objects and stores it in a file.

## SYNTAX

```powershell
Export-BinaryMiLog [-InputObject <CimInstance>] [-Path] <String>
```

## DESCRIPTION

The `Export-BinaryMILog` cmdlet creates a binary-based representation of an object or objects and
stores it in a file. You can then use the `Import-BinaryMiLog` cmdlet to re-create the saved object
based on the contents of that file.

This cmdlet is similar to `Import-Clixml`, except that `Export-BinaryMILog` stores the resulting
object in a binary encoded file.

## EXAMPLES

### Example 1 - Create a binary representation of CimInstances

```powershell
Get-CimInstance Win32_Process | Export-BinaryMiLog -Path "Processes.bmil"
```

This command exports CimInstances to a binary MI log file specified by the Path parameter.
See the example for Import-BinaryMiLog to see how to recreate the CimInstances by importing this file.

## PARAMETERS

### -InputObject

Specifies the input to this cmdlet. You can use this parameter, or you can pipe the input to this
cmdlet.

```yaml
Type: CimInstance
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

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

### Microsoft.Management.Infrastructure.CimInstance

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-CimInstance](get-ciminstance.md)

[Import-BinaryMiLog](import-binarymilog.md)

[Import-Clixml](../microsoft.powershell.utility/import-clixml.md)