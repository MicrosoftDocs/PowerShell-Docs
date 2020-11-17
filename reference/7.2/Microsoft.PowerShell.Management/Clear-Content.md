---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 10/18/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/clear-content?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Clear-Content
---
# Clear-Content

## SYNOPSIS
Deletes the contents of an item, but does not delete the item.

## SYNTAX

### Path (Default)

```
Clear-Content [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-Stream <String>] [<CommonParameters>]
```

### LiteralPath

```
Clear-Content -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-Stream <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Clear-Content` cmdlet deletes the contents of an item, such as deleting the text from a file, but it does not delete the item.
As a result, the item exists, but it is empty.
The `Clear-Content` is similar to `Clear-Item`, but it works on items with contents, instead of items with values.

## EXAMPLES

### Example 1: Delete all content from a directory

```powershell
Clear-Content "..\SmpUsers\*\init.txt"
```

This command deletes all of the content from the "init.txt" files in all subdirectories of the SmpUsers directory.
The files are not deleted, but they are empty.

### Example 2: Delete content of all files with a wildcard

```powershell
Clear-Content -Path "*" -Filter "*.log" -Force
```

This command deletes the contents of all files in the current directory with the ".log" file name extension, including files with the read-only attribute.
The asterisk (\*) in the path represents all items in the current directory.
The **Force** parameter makes the command effective on read-only files.
Using a filter to restrict the command to files with the .log file name extension instead of specifying \*.log in the path makes the operation faster.

### Example 3: Clear all data from a stream

This example shows how the `Clear-Content` cmdlet clears the content from an alternate data stream while leaving the stream intact.

The first command uses the `Get-Content` cmdlet to get the content of the Zone.Identifier stream in the Copy-Script.ps1 file, which was downloaded from the Internet.

The second command uses the `Clear-Content` cmdlet to clear the content.

The third command repeats the first command. It verifies that the content is cleared, but the stream remains. If the stream were deleted, the command would generate an error.

You can use a method like this one to clear the content of an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the `Unblock-File` cmdlet.

```
PS C:\> Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

[ZoneTransfer]
ZoneId=3

PS C:\>Clear-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

PS C:\>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
PS C:\>
```

## PARAMETERS

### -Stream

Specifies an alternative data stream for content.
If the stream does not exist, this cmdlet creates it.
Wildcard characters are not supported.

Stream is a dynamic parameter that the FileSystem provider adds to `Clear-Content`.
This parameter works only in file system drives.

You can use the `Clear-Content` cmdlet to change the content of the Zone.Identifier alternate data stream.
However, we do not recommend this as a way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the `Unblock-File` cmdlet.

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

### -Credential

> [!NOTE]
> This parameter is not supported by any providers installed with PowerShell. To impersonate another
> user, or elevate your credentials when running this cmdlet, use Invoke-Command.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude

Specifies, as a string array, strings that this cmdlet omits from the path to the content.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter in the provider's format or language.
The value of this parameter qualifies the **Path** parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when retrieving the objects, rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force

Forces the command to run without asking for user confirmation.

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

### -Include

Specifies, as a string array, content that this cmdlet clears.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as "*.txt".
Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath

Specifies the paths to the items from which content is deleted.
Unlike the **Path** parameter, the value of **LiteralPath** is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell having PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the paths to the items from which content is deleted.
Wildcards are permitted.
The paths must be paths to items, not to containers.
For example, you must specify a path to one or more files, not a path to a directory.
Wildcards are permitted.
This parameter is required, but the parameter name ("Path") is optional.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to `Clear-Content`.

## OUTPUTS

### None

This cmdlet does not return any objects.

## NOTES

You can use `Clear-Content` with the PowerShell FileSystem provider and with other providers that manipulate content.
To clear items that are not considered to be content, such as items managed by the PowerShell Certificate or Registry providers, use `Clear-Item`.

The `Clear-Content` cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type `Get-PsProvider`.
For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Add-Content](Add-Content.md)

[Get-Content](Get-Content.md)

[Get-Item](Get-Item.md)

[Set-Content](Set-Content.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

