---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821601
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Move-Item
---

# Move-Item

## SYNOPSIS
Moves an item from one location to another.

## SYNTAX

### Path (Default)
```
Move-Item [-Path] <String[]> [[-Destination] <String>] [-Force] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-PassThru] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath
```
Move-Item -LiteralPath <String[]> [[-Destination] <String>] [-Force] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-PassThru] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The **Move-Item** cmdlet moves an item, including its properties, contents, and child items, from one location to another location.
The locations must be supported by the same provider.
For example, it can move a file or subdirectory from one directory to another or move a registry subkey from one key to another.
When you move an item, it is added to the new location and deleted from its original location.

## EXAMPLES

### Example 1: Move a file to another directory and rename it
```
PS C:\> Move-Item -Path C:\test.txt -Destination E:\Temp\tst.txt
```

This command moves the Test.txt file from the C: drive to the E:\Temp directory and renames it from test.txt to tst.txt.

### Example 2: Move a directory and its contents to another directory
```
PS C:\> Move-Item -Path C:\Temp -Destination C:\Logs
```

This command moves the C:\Temp directory and its contents to the C:\Logs directory.
The Temp directory, and all of its subdirectories and files, then appear in the Logs directory.

### Example 3: Move all files of a specified extension from the current directory to another directory
```
PS C:\> Move-Item -Path .\*.txt -Destination C:\Logs
```

This command moves all of the text files (*.txt) in the current directory (represented by a dot (.)) to the C:\Logs directory.

### Example 4: Recursively move all files of a specified extension from the current directory to another directory
```
PS C:\> Get-ChildItem -Path ".\*.txt" -Recurse | Move-Item -Destination "C:\TextFiles"
```

This command moves all of the text files from the current directory and all subdirectories, recursively, to the C:\TextFiles directory.

The command uses the **Get-ChildItem** cmdlet to get all of the child items in the current directory (represented by the dot \[.\]) and its subdirectories that have a *.txt file name extension.
It uses the *Recurse* parameter to make the retrieval recursive and the Include parameter to limit the retrieval to *.txt files.

The pipeline operator (|) sends the results of this command to **Move-Item**, which moves the text files to the TextFiles directory.

If files that are to be moved to C:\Textfiles have the same name, **Move-Item** displays an error and continues, but it moves only one file with each name to C:\Textfiles.
The other files remain in their original directories.

If the Textfiles directory (or any other element of the destination path) does not exist, the command fails.
The missing directory is not created for you, even if you use the *Force* parameter.
**Move-Item** moves the first item to a file called Textfiles and then displays an error explaining that the file already exists.

Also, by default, Get-ChildItem does not move hidden files.
To move hidden files, use the*Force* parameter with **Get-ChildItem**.

Note: In Windows PowerShell 2.0, when using the **Recurse** parameter of the **Get-ChildItem** cmdlet, the value of the **Path** parameter must be a container.
Use the **Include** parameter to specify the .txt file name extension filter (`Get-ChildItem -Path .\* -Include *.txt -Recurse | Move-Item -Destination C:\TextFiles`).

### Example 5: Move registry keys and values to another key
```
PS C:\> Move-Item "HKLM:\software\mycompany\*" "HKLM:\software\mynewcompany"
```

This command moves the registry keys and values within the MyCompany registry key in HKLM\Software to the MyNewCompany key.
The wildcard character (*) indicates that the contents of the MyCompany key should be moved, not the key itself.
In this command, the optional *Path* and *Destination* parameter names are omitted.

### Example 6: Move a directory and its contents to a subdirectory of the specified directory
```
PS C:\> Move-Item -LiteralPath 'Logs[Sept`06]' -Destination 'Logs[2006]'
```

This command moves the Logs\[Sept\`06\] directory (and its contents) into the Logs\[2006\] directory.

The *LiteralPath* parameter is used instead of *Path*, because the original directory name includes left bracket and right bracket characters ("\[" and "\]").
The path is also enclosed in single quotation marks (' '), so that the backtick symbol (\`) is not misinterpreted.

The *Destination* parameter does not require a literal path, because the Destination variable also must be enclosed in single quotation marks, because it includes brackets that can be misinterpreted.

## PARAMETERS

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers installed with PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Destination
Specifies the path to the location where the items are being moved.
The default is the current directory.
Wildcards are permitted, but the result must specify a single location.

To rename the item being moved, specify a new name in the value of the *Destination* parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Specifies, as a string array, an item or items that this cmdlet excludes from the operation.
The value of this parameter qualifies the *Path* parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

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
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the *Path* parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when the cmdlet gets the objects, rather than having PowerShell filter the objects after they are retrieved.

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
Forces the command to run without asking for user confirmation.

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

### -Include
Specifies, as a string array, an item or items that this cmdlet moves in the operation.
The value of this parameter qualifies the *Path* parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

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
Specifies the path to the current location of the items.
Unlike the *Path* parameter, the value of *LiteralPath* is used exactly as it is typed.
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

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path to the current location of the items.
The default is the current directory.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### None or an object representing the moved item.
When you use the *PassThru* parameter, this cmdlet generates an object representing the moved item.
Otherwise, this cmdlet does not generate any output.

## NOTES
* This cmdlet will move files between drives that are supported by the same provider, but it will move directories only within the same drive.

  Because a **Move-Item** command moves the properties, contents, and child items of an item, all moves are recursive by default.

  You can also refer to this cmdlet by its built-in aliases, "move", "mv", and "mi".
For more information, see about_Aliases.

  This cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type Get-PSProvider.
For more information, see about_Providers.

*

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[New-Item](New-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[Get-PSProvider](Get-PSProvider.md)