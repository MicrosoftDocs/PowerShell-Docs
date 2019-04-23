---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/23/2019
online version: http://go.microsoft.com/fwlink/?LinkID=113363
schema: 2.0.0
title: Out-File
---
# Out-File

## SYNOPSIS
Sends output to a file.

## SYNTAX

### ByPath (Default)

```
Out-File [-FilePath] <string> [[-Encoding] <string>] [-Append] [-Force] [-NoClobber] [-Width <int>]
[-InputObject <psobject>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Out-File [[-Encoding] <string>] -LiteralPath <string> [-Append] [-Force] [-NoClobber] [-Width <int>]
[-InputObject <psobject>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Out-File` cmdlet sends output to a file. When you need to specify parameters for the output use
`Out-File` rather than the redirection operator (`>`).

## EXAMPLES

### Example 1: Send output and create a file

This example shows how to send a list of the local computer's processes to a file. If the file does
not exist, `Out-File` creates the file in the specified path.

```powershell
Get-Process | Out-File -FilePath .\Process.txt
Get-Content -Path .\Process.txt
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     29    22.39      35.40      10.98   42764   9 Application
     53    99.04     113.96       0.00   32664   0 CcmExec
     27    96.62     112.43     113.00   17720   9 Code
```

The `Get-Process` cmdlet gets the list of processes running on the local computer. The **Process**
objects are sent down the pipeline to the `Out-File` cmdlet. `Out-File` uses the **FilePath**
parameter and creates a file in the current directory named **Process.txt**. The `Get-Content`
command gets content from the file and displays it in the PowerShell console.

### Example 2: Prevent an existing file from being overwritten

This example prevents an existing file from being overwritten. By default, `Out-File` overwrites
existing files.

```powershell
Get-Process | Out-File -FilePath .\Process.txt -NoClobber
```

```Output
Out-File : The file 'C:\Test\Process.txt' already exists.
At line:1 char:15
+ Get-Process | Out-File -FilePath .\Process.txt -NoClobber
+               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

The `Get-Process` cmdlet gets the list of processes running on the local computer. The **Process**
objects are sent down the pipeline to the `Out-File` cmdlet. `Out-File` uses the **FilePath**
parameter and attempts to write to a file in the current directory named **Process.txt**. The
**NoClobber** parameter prevents the file from being overwritten and displays a message that the
file already exists.

### Example 3: Send output to a file in ASCII format

This example shows how to encode output with a specific encoding type.

```powershell
$Procs = Get-Process
Out-File -FilePath .\Process.txt -InputObject $Procs -Encoding ASCII -Width 50
```

The `Get-Process` cmdlet gets the list of processes running on the local computer. The **Process**
objects are stored in the variable, `$Procs`. `Out-File` uses the **FilePath** parameter and creates
a file in the current directory named **Process.txt**. The **InputObject** parameter passes the
process objects in `$Procs` to the file **Process.txt**. The **Encoding** parameter converts the
output to **ASCII** format. The **Width** parameter limits each line in the file to 50 characters so
some data might be truncated.

### Example 4: Use a provider and send output to a file

This example shows how to use the `Out-File` cmdlet when you are not in a **FileSystem** provider
drive. Use the `Get-PSProvider` cmdlet to view the providers on your local computer. For more
information, see [about_Providers](../Microsoft.Powershell.Core/About/about_Providers.md).

```
PS> Set-Location -Path Alias:

PS> Get-Location

Path
----
Alias:\

PS> Get-ChildItem | Out-File -FilePath C:\TestDir\AliasNames.txt

PS> Get-Content -Path C:\TestDir\AliasNames.txt

CommandType     Name
-----------     ----
Alias           % -> ForEach-Object
Alias           ? -> Where-Object
Alias           ac -> Add-Content
Alias           cat -> Get-Content
```

The `Set-Location` command uses the **Path** parameter to set the current location to the registry
provider `Alias:`. The `Get-Location` cmdlet displays the complete path for `Alias:`.
`Get-ChildItem` sends objects down the pipeline to the `Out-File` cmdlet. `Out-File` uses the
**FilePath** parameter to specify the complete path and filename for the output,
**C:\TestDir\AliasNames.txt**. The `Get-Content` cmdlet uses the **Path** parameter and displays the
file's content in the PowerShell console.

## PARAMETERS

### -Append

Adds the output to the end of an existing file. If no **Encoding** is specified, the cmdlet uses the
default encoding. That encoding may not match the encoding of the target file. This is the same
behavior as the redirection operator (`>>`).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -Encoding

Specifies the type of encoding for the target file. The default value is **Unicode**.

The acceptable values for this parameter are as follows:

- **ASCII** Uses ASCII (7-bit) character set.
- **BigEndianUnicode** Uses UTF-16 with the big-endian byte order.
- **Default** Uses the encoding that corresponds to the system's active code page (usually ANSI).
- **OEM** Uses the encoding that corresponds to the system's current OEM code page.
- **String** Same as **Unicode**.
- **Unicode** Uses UTF-16 with the little-endian byte order.
- **Unknown** Same as **Unicode**.
- **UTF7** Uses UTF-7.
- **UTF8** Uses UTF-8.
- **UTF32** Uses UTF-32 with the little-endian byte order.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, Default, OEM, String, Unicode, Unknown, UTF7, UTF8, UTF32

Required: False
Position: 1
Default value: Unicode
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies the path to the output file.

```yaml
Type: String
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Overrides the read-only attribute and overwrites an existing read-only file. The **Force** parameter
does not override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to be written to the file. Enter a variable that contains the objects or type
a command or expression that gets the objects.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the output file. The **LiteralPath** parameter is used exactly as it is typed.
Wildcard characters are not accepted. If the path includes escape characters, enclose it in single
quotation marks. Single quotation marks tell PowerShell not to interpret any characters as escape
sequences. For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: String
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoClobber

**NoClobber** prevents an existing file from being overwritten and displays a message that the file
already exists. By default, if a file exists in the specified path, `Out-File` overwrites the file
without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### -Width

Specifies the number of characters in each line of output. Any additional characters are truncated,
not wrapped. If this parameter is not used, the width is determined by the characteristics of the
host. The default for the PowerShell console is 80 characters.

```yaml
Type: Int
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Out-File`.

## OUTPUTS

### None

`Out-File` does not generate any output.

## NOTES

The `Out` cmdlets do not format objects; they just render them and send them to the specified
display destination. If you send an unformatted object to an `Out` cmdlet, the cmdlet sends it to a
formatting cmdlet before rendering it.

To send a PowerShell command's output to the `Out-File` cmdlet, use the pipeline. You can store data
in a variable and use the **InputObject** parameter to pass data to the `Out-File` cmdlet.

`Out-File` sends data but it does not produce any output objects. If you pipe the output of
`Out-File` to `Get-Member`, the `Get-Member` cmdlet reports that no objects were specified.

## RELATED LINKS

[about_Providers](../Microsoft.Powershell.Core/About/about_Providers.md)

[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md)

[Out-Default](../Microsoft.PowerShell.Core/Out-Default.md)

[Out-GridView](Out-GridView.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Out-Null](../Microsoft.PowerShell.Core/Out-Null.md)

[Out-Printer](Out-Printer.md)

[Out-String](Out-String.md)

[Tee-Object](Tee-Object.md)