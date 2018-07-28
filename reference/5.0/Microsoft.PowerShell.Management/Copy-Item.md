---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821574
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Copy-Item
---

# Copy-Item

## SYNOPSIS
Copies an item from one location to another.

## SYNTAX

### Path (Default)
```
Copy-Item [-Path] <String[]> [[-Destination] <String>] [-Container] [-Force] [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-PassThru] [-Credential <PSCredential>] [-WhatIf]
 [-Confirm] [-UseTransaction] [-FromSession <PSSession>] [-ToSession <PSSession>] [<CommonParameters>]
```

### LiteralPath
```
Copy-Item -LiteralPath <String[]> [[-Destination] <String>] [-Container] [-Force] [-Filter <String>]
 [-Include <String[]>] [-Exclude <String[]>] [-Recurse] [-PassThru] [-Credential <PSCredential>] [-WhatIf]
 [-Confirm] [-UseTransaction] [-FromSession <PSSession>] [-ToSession <PSSession>] [<CommonParameters>]
```

## DESCRIPTION
The **Copy-Item** cmdlet copies an item from one location to another location in the same namespace.
For instance, it can copy a file to a folder, but it cannot copy a file to a certificate drive.

This cmdlet does not cut or delete the items being copied.
The particular items that the cmdlet can copy depend on the Windows PowerShell provider that exposes the item.
For instance, it can copy files and directories in a file system drive and registry keys and entries in the registry drive.

This cmdlet can copy and rename items in the same command.
To rename an item, enter the new name in the value of the *Destination* parameter.
To rename an item and not copy it, use the Rename-Item cmdlet.

## EXAMPLES

### Example 1: Copy a file to the specified directory
```
PS C:\> Copy-Item "C:\Wabash\Logfiles\mar1604.log.txt" -Destination "C:\Presentation"
```

This command copies the mar1604.log.txt file to the C:\Presentation directory.
The command does not delete the original file.

### Example 2: Copy the contents of a directory to another directory
```
PS C:\> Copy-Item "C:\Logfiles" -Destination "C:\Drawings" -Recurse
```

This command copies the entire contents of the Logfiles directory into the Drawings directory.
If the LogFiles directory contains files in subdirectories, those subdirectories will be copied with their file trees intact.
The *Container* parameter is set to true by default.
This preserves the directory structure.

### Example 3: Copy the contents of a directory to another directory and create the destination directory if it does not exist
```
PS C:\> Copy-Item C:\Logfiles -Destination C:\Drawings\Logs -Recurse
```

This command copies the contents of the C:\Logfiles directory to the C:\Drawings\Logs directory.
It creates the \Logs subdirectory if it does not already exist.

### Example 4: Copy a file to the specified directory and rename the file
```
PS C:\> Copy-Item "\\Server01\Share\Get-Widget.ps1" -Destination "\\Server12\ScriptArchive\Get-Widget.ps1.txt"
```

This command uses the **Copy-Item** cmdlet to copy the Get-Widget.ps1 script from the \\\\Server01\Share directory to the \\\\Server12\ScriptArchive directory.
As part of the copy operation, the command also changes the item name from Get-Widget.ps1 to Get-Widget.ps1.txt, so it can be attached to email messages.

### Example 5: Copy a file to a remote computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "D:\Folder001\test.log" -Destination "C:\Folder001_Copy\" -ToSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy test.log from the D:\Folder001 folder to the C:\Folder001_Copy folder on the remote computer using the session information stored in the $Session variable.
This command does not delete the original file.

### Example 6: Copy the entire contents of a folder to a remote computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server02" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "D:\Folder002\" -Destination "C:\Folder002_Copy\" -ToSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy the entire contents from the D:\Folder002 folder to the C:\Folder002_Copy directory on the remote computer using the session information stored in the $Session variable.
The subfolders will be copied with their file trees intact.

### Example 7: Recursively copy the entire contents of a folder to a remote computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server04" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "D:\Folder003\" -Destination "C:\Folder003_Copy\" -ToSession $Session -Recurse
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy the entire contents from the D:\Folder003 folder to the C:\Folder003_Copy directory on the remote computer using the session information stored in the $Session variable.
The subfolders will be copied with their file trees intact.
Since this command uses the *Recurse* parameter, the operation will create the Folder003_Copy folder if it does not already exist.

### Example 8: Copy a file to a remote computer and then rename the file
```
PS C:\> $Session = New-PSSession -ComputerName "Server04" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "D:\Folder004\scriptingexample.ps1" -Destination "C:\Folder004_Copy\scriptingexample_copy.ps1" -ToSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy scriptingexample.ps1 from the D:\Folder004 folder to the C:\Folder004_Copy folder on the remote computer using the session information stored in the $Session variable.
As part of the copy operation, the command also changes the item name from scriptingexample.ps1 to scriptingexample_copy.ps1, so it can be attached to email messages.
This command does not delete the original file.

### Example 9: Copy a remote file to the local computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "C:\MyRemoteData\test.log" -Destination "D:\MyLocalData\" -FromSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy test.log from the remote C:\MyRemoteData\ to the local D:\MyLocalData folder using the session information stored in the $Session variable.
This command does not delete the original file.

### Example 10: Copy the entire contents of a remote folder to the local computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "C:\MyRemoteData\scripts" -Destination "D:\MyLocalData\" -FromSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy the entire contents from the remote C:\MyRemoteData\scripts folder to the local D:\MyLocalData folder using the session information stored in the $Session variable.
If the scripts folder contains files in subfolders, those subfolders will be copied with their file trees intact.

### Example 11: Recursively copy the entire contents of a remote folder to the local computer
```
PS C:\> $Session = New-PSSession -ComputerName "Server01" -Credential "Contoso\PattiFul"
PS C:\> Copy-Item "C:\MyRemoteData\scripts" -Destination "D:\MyLocalData\scripts" -FromSession $Session
```

The first command creates a session to the remote computer named Server01 with the credential of Contoso\PattiFul and stores the results in the variable named $Session.

The second command uses the **Copy-Item** cmdlet to copy the entire contents from the remote C:\MyRemoteData\scripts folder to the local D:\MyLocalData\scripts folder using the session information stored in the $Session variable.
Since this command uses the *Recurse* parameter, the operation will create the scripts folder if it does not already exist .If the scripts folder contains files in subfolders, those subfolders will be copied with their file trees intact.

## PARAMETERS

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

### -Container
Indicates that this cmdlet preserves container objects during the copy operation.

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

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers installed with Windows PowerShell.

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
Specifies the path to the new location.
To rename a copied item, include the new name in the value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Specifies, as a string array, an item or items that this cmdlet excludes from the operation.
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
Filters are more efficient than other parameters, because the provider applies them when the cmdlet gets the objects, rather than have Windows PowerShell filter the objects after they are retrieved.

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
Indicates that this cmdlet will copy items that cannot otherwise be changed, such as copying over a read-only file or alias.

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

### -FromSession
Specifies the **PSSession** object from which a remote file is being copied.
When you use this parameter, the *Path* and *LiteralPath* parameters refer to the local path on the remote machine.

```yaml
Type: PSSession
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Specifies, as a string array, only those items upon which the cmdlet will act, excluding all others.

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
Specifies a path to the item.
The value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

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
Specifies, as a string array, the path to the items to copy.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Recurse
Indicates that this cmdlet performs a recursive copy.

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

### -ToSession
Specifies the **PSSession** object to which a remote file is being copied.
When you use this parameter, the *Path* and *LiteralPath* parameters refer to the local path on the remote machine.

```yaml
Type: PSSession
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### None or an object representing the copied item.
When you use the *PassThru* parameter, this cmdlet returns an object that represents the copied item.
Otherwise, this cmdlet does not generate any output.

## NOTES
* This cmdlet is similar to the cp or copy commands in other shells.

  This cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type `Get-PsProvider`.
For more information, see about_Providers.

*

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Get-Item](Get-Item.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[New-Item](New-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[Get-PSProvider](Get-PSProvider.md)