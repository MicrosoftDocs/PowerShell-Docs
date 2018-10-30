---
ms.date:  10/18/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293896
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Remove-Item
---
# Remove-Item

## SYNOPSIS

Deletes the specified items.

## SYNTAX

### Path (Default)

```
Remove-Item [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse]
 [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [-Stream <String[]>]
 [<CommonParameters>]
```

### LiteralPath

```
Remove-Item -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Recurse]
 [-Force] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [-Stream <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Item` cmdlet deletes one or more items.
Because it is supported by many providers, it can delete many different types of items, including files, folders, registry keys, variables, aliases, and functions.

## EXAMPLES

### Example 1: Delete files that have any file name extension

This command deletes all of the files that have names that include a dot ('.') from the "C:\Test" folder.
Because the command specifies a dot, the command does not delete folders or files that have no file name extension.

```powershell
Remove-Item C:\Test\*.*
```

### Example 2: Delete some of the document files in a folder

This command deletes from the current folder all files that have a ".doc" file name extension and a name that does not include 1.
It uses the wildcard character ('*') to specify the contents of the current folder.
It uses the **Include** and **Exclude** parameters to specify the files to delete.

```powershell
Remove-Item * -Include *.doc -Exclude *1*
```

### Example 3: Delete hidden, read-only files

This command deletes a file that is both *hidden* and *read-only*.
It uses the **Path** parameter to specify the file.
It uses the **Force** parameter to delete it.
Without **Force**, you cannot delete *read-only* or *hidden* files.

```powershell
Remove-Item -Path C:\Test\hidden-RO-file.txt -Force
```

### Example 4: Delete files in subfolders recursively

This command deletes all of the CSV files in the current folder and all subfolders recursively.

Because the **Recurse** parameter in `Remove-Item` has a known issue, the command in this example uses `Get-ChildItem` to get the desired files, and then uses the pipeline operator to pass them to `Remove-Item`.

In the `Get-ChildItem` command, **Path** has a value of '*', which represents the contents of the current folder.
It uses **Include** to specify the CSV file type, and it uses **Recurse** to make the retrieval recursive.

If you try to specify the file type the path, such as `-Path *.csv`, the cmdlet interprets the subject of the search to be a file that has no child items, and **Recurse** fails.

```powershell
Get-ChildItem * -Include *.csv -Recurse | Remove-Item
```

### Example 5: Delete subkeys recursively

This command deletes the "OldApp" registry key and all its subkeys and values.
It uses `Remove-Item` to remove the key.
The path is specified, but the optional parameter name (**Path**) is omitted.

The **Recurse** parameter deletes all of the contents of the "OldApp" key recursively.
If the key contains subkeys and you omit the **Recurse** parameter, you are prompted to confirm that you want to delete the contents of the key.

```powershell
Remove-Item HKLM:\Software\MyCompany\OldApp -Recurse
```

### Example 6: Deleting files with special characters

The following example shows how to delete files that contain special characters like brackets or parentheses.

```powershell
Get-ChildItem
```

```output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/1/2018  12:19 PM           1362 myFile.txt
-a----         6/1/2018  12:30 PM           1132 myFile[1].txt
-a----         6/1/2018  12:19 PM           1283 myFile[2].txt
-a----         6/1/2018  12:19 PM           1432 myFile[3].txt

```

```powershell
Get-ChildItem | Where-Object Name -Like '*`[*'
```

```output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/1/2018  12:30 PM           1132 myFile[1].txt
-a----         6/1/2018  12:19 PM           1283 myFile[2].txt
-a----         6/1/2018  12:19 PM           1432 myFile[3].txt

```

```powershell
Get-ChildItem | Where-Object Name -Like '*`[*' | ForEach-Object { Remove-Item -LiteralPath $_.Name }
Get-ChildItem
```

```output
    Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         6/1/2018  12:19 PM           1362 myFile.txt
```

### Example 7: Remove an alternate data stream

This example shows how to use the Stream dynamic parameter of the `Remove-Item` cmdlet to delete an alternate data stream. The stream parameter is introduced in Windows PowerShell 3.0.

The first command uses the **Stream** dynamic parameter of the `Get-Item` cmdlet to get the **Zone.Identifier** stream of the "Copy-Script.ps1" file.

The second command uses the **Stream** dynamic parameter of the `Remove-Item` cmdlet to remove the **Zone.Identifier** stream of the file.

The third command uses the **Stream** dynamic parameter of the `Get-Item` cmdlet to verify that the **Zone.Identifier** stream is deleted.

The fourth command `Get-Item` cmdlet without the **Stream** parameter to verify that the file is not deleted.

```powershell
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```output
   FileName: \\C:\Test\Copy-Script.ps1

Stream                   Length
------                   ------
Zone.Identifier              26

```

```powershell
Remove-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
```

```output
Get-Item : Could not open alternate data stream 'Zone.Identifier' of file 'C:\Test\Copy-Script.ps1'.
At line:1 char:1
+ Get-Item 'C:\Test\Copy-Script.ps1' -Stream Zone.Identifier
+ [!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()]~~
    + CategoryInfo          : ObjectNotFound: (C:\Test\Copy-Script.ps1:String) [Get-Item], FileNotFoundE
   xception
    + FullyQualifiedErrorId : AlternateDataStreamNotFound,Microsoft.PowerShell.Commands.GetItemCommand

```

```powershell
Get-Item C:\Test\Copy-Script.ps1
```

```output
    Directory: C:\Test

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---          8/4/2011  11:15 AM       9436 Copy-Script.ps1
```

## PARAMETERS

### -Credential

Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a **PSCredential** object, such as one generated by the `Get-Credential` cmdlet.
If you type a user name, you are prompted for a password.

> [!WARNING]
> This parameter is not supported by any providers installed with Windows PowerShell.

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

Specifies items that this cmdlet omits.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as *.txt.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies a filter in the format or language of the provider.
The value of this parameter qualifies the **Path** parameter.

The syntax of the filter, including the use of wildcard characters, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when the cmdlet gets the objects rather than having PowerShell filter the objects after they are retrieved.

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

### -Force

Forces the cmdlet to remove items that cannot otherwise be changed, such as hidden or read-only files or read-only aliases or variables.
The cmdlet cannot remove constant aliases or variables.
Implementation varies from provider to provider.
For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).
Even using the **Force** parameter, the cmdlet cannot override security restrictions.

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

Specifies items to delete.
The value of this parameter qualifies the **Path** parameter.
Enter a path element or pattern, such as "*.txt".
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies a path of the items being removed.
Unlike the **Path** parameter, the value of **LiteralPath** is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

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

Specifies a path of the items being removed.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Recurse

Indicates that this cmdlet deletes the items in the specified locations and in all child items of the locations.

When it is used with the **Include** parameter, the **Recurse** parameter might not delete all subfolders or all child items.
This is a known issue.
As a workaround, try piping results of the `Get-ChildItem -Recurse` command to `Remove-Item`, as described in "Example 4" in this topic.

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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see [about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream

The **Stream** parameter is a dynamic parameter that the FileSystem provider adds to `Remove-Item`.
This parameter works only in file system drives.

You can use `Remove-Item` to delete an alternative data stream.
However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the `Unblock-File` cmdlet.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

The `Remove-Item` cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PsProvider`. For more information, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[New-Item](New-Item.md)

[Remove-ItemProperty](Remove-ItemProperty.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)