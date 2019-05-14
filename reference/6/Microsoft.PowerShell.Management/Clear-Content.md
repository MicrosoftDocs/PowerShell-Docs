---
ms.date: 5/14/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821567
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Clear-Content
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

The `Clear-Content` cmdlet deletes the contents of an item, such as deleting the text from a file,
but it does not delete the item. As a result, the item exists, but it is empty.
The `Clear-Content` is similar to `Clear-Item`, but it works on items with contents, instead of
items with values.

## EXAMPLES

### Example 1: Delete all content from a directory

This command deletes all of the content from the `init.txt` files in all subdirectories of the
SmpUsers directory. The files are not deleted, but they are empty.

```powershell
Clear-Content "..\SmpUsers\*\init.txt"
```

### Example 2: Delete content of all files with a wildcard

This command deletes the contents of all files in the current directory with the `.log` file name
extension, including files with the read-only attribute.
The asterisk (`*`) in the path represents all items in the current directory.
The **Force** parameter makes the command effective on read-only files.
Using a filter to restrict the command to files with the `.log` file name extension instead of
specifying `*.log` in the path makes the operation faster.

```powershell
Clear-Content -Path "*" -Filter "*.log" -Force
```

### Example 3: Clear all data from a stream

This example shows how the `Clear-Content` cmdlet clears the content from an alternate data stream
while leaving the stream intact.

```powershell
Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```Output
[ZoneTransfer]
ZoneId=3
```

```powershell
Clear-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```powershell
Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```Output

```

The `Get-Content` cmdlet gets the content of the **Zone.Identifier** stream in the `Copy-Script.ps1`
file, which was downloaded from the Internet. The **ZoneId** shows that the script will be blocked
by **ExecutionPolicy**. The `Clear-Content` cmdlet to clear the content of the **Zone.Identifier**
stream. The last command uses `Get-Content` to show that the **Zone.Identifier** stream has been
cleared.

> [!NOTE]
> You can use a method like this one to clear the content of an alternate data stream. However, it is
> not the recommended way to eliminate security checks that block files that are downloaded from the
> Internet. If you want to verify that a downloaded file is safe, use the [Unblock-File](../Microsoft.PowerShell.Utility/Unblock-File.md)
> cmdlet.

For more about execution policies, see [about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md).

### Example 4: Use Filters with Clear-Content

You can specify a filter to the `Clear-Content` cmdlet. When using filters to qualify the **Path**
parameter, you need to include a trailing asterisk (`*`) to indicate the contents of the
path.

The following command clears the content of all `*.log` files in the `C:\Temp`
directory.

```powershell
Clear-Content -Path C:\Temp\* -Filter *.log
```

## PARAMETERS

### -Stream

Specifies an alternative data stream for content.
If the stream does not exist, this cmdlet creates it.
Wildcard characters are not supported.

Stream is a dynamic parameter that the FileSystem provider adds to `Clear-Content`.
This parameter works only in file system drives.

```yaml
Type: String
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
> This parameter is not supported by any providers installed with Windows PowerShell.
> To impersonate another user, or elevate your credentials when running this cmdlet,
> use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)
provider is the only installed PowerShell provider that supports the use of filters. You can find
the syntax for the **FileSystem** filter language in [about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md).
Filters are more efficient than other parameters, because the provider applies them when the cmdlet
gets the objects rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: String
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`"*.txt"`. Wildcard characters are permitted. The **Include** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

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
This parameter is required, but the parameter name **Path** is optional.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to `Clear-Content`.

## OUTPUTS

### None

This cmdlet does not return any objects.

## NOTES

- You can use `Clear-Content` with the PowerShell FileSystem provider and with other providers that
  manipulate content.
- To clear items that are not considered to be content, such as items managed by the PowerShell
  **Certificate** or **Registry** providers, use `Clear-Item`.
- The `Clear-Content` cmdlet is designed to work with the data exposed by any provider.
  - To list the providers available in your session, type `Get-PsProvider`.
- For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Add-Content](Add-Content.md)

[Get-Content](Get-Content.md)

[Get-Item](Get-Item.md)

[Set-Content](Set-Content.md)
