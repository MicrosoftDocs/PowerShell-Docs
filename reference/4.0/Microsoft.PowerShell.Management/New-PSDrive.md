---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293888
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  New-PSDrive
---

# New-PSDrive

## SYNOPSIS
Creates temporary and persistent mapped network drives.

## SYNTAX

```
New-PSDrive [-Name] <String> [-PSProvider] <String> [-Root] <String> [-Description <String>] [-Scope <String>]
 [-Persist] [-Credential <PSCredential>] [-WhatIf] [-Confirm] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The **New-PSDrive** cmdlet creates temporary and persistent drives that are "mapped" to or associated with a location in a data store, such as a network drive, a directory on the local computer, or a registry key, and persistent Windows mapped network drives that are associated with a file system location on a remote computer.

Temporary drives exist only in the current Windows PowerShell session and in sessions that you create in the current session.
They can have any name that is valid in Windows PowerShell and can be mapped to any local or remote resource.
You can use temporary Windows PowerShell drives to access data in the associated data store, just like you would do with any mapped network drive.
You can change locations into the drive (using "set-location", "cd", or "chdir") and access the contents of the drive (using "get-item", "get-childitem", or "dir").

However, because temporary drives are known only to Windows PowerShell, you cannot access them by using File Explorer, Windows Management Instrumentation (WMI), Component Object Model (COM), or the Microsoft .NET Framework, or by using tools such as Net Use.

New features are added to New-PSDrive in Windows PowerShell 3.0.

- Mapped network drives: You can use the **Persist** parameter of **New-PSDrive** to create Windows mapped network drives. Unlike temporary Windows PowerShell drives, Windows mapped network drives are not session-specific; they are saved in Windows and they can be managed by using standard Windows tools, such as File Explorer and Net Use. Mapped network drives must have a drive-letter name and be connected to a remote file system location. When your command is scoped locally (no dot-sourcing), the **Persist** parameter doesn't persist the creation of a PSDrive beyond the scope in which the command is running. If you are running New-PSDrive inside of a script, and you want the drive to persist indefinitely, you must dot-source the script. For best results, to force a new drive to persist indefinitely, add the **Scope** parameter to your command, and set its value to **Global**.
- External drives: When an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive. You do not need to restart Windows PowerShell. Similarly, when an external drive is disconnected from the computer, Windows PowerShell automatically deletes the PSDrive that represents the removed drive.
- Credentials for UNC Paths: When the value of the **Root** parameter is a UNC path, such as \\\\Server\Share, the credential specified in the value of the **Credential** parameter is used to create the PSDrive. Otherwise, the **Credential** parameter is not effective when creating new file system drives.

## EXAMPLES

### Example 1
```
PS C:\> New-PSDrive -Name P -PSProvider FileSystem -Root \\Server01\Public

Name       Provider      Root
----       --------      ----
P          FileSystem    \\Server01\Public
```

This command creates a temporary Windows PowerShell drive named P: that is mapped to the \\\\Server01\Public network share.

It uses the **Name** parameter to specify a name for the drive, the **PSProvider** parameter to specify the Windows PowerShell FileSystem provider, and the **Root** parameter to specify the network share.

When the command completes, the contents of the \\\\Server01\Public share appear in the P: drive.
To see them, type: "`dir P:`".

### Example 2
```
PS C:\> New-PSDrive -Name MyDocs -PSProvider FileSystem -Root "C:\Documents and Settings\User01\My Documents" -Description "Maps to my My Documents folder."

Name       Provider      Root
----       --------      ----
MyDocs     FileSystem    C:\Documents and Settings\User01\My Documents
```

This command creates a temporary Windows PowerShell drive that provides quick access to a local directory.
It creates a drive named MyDocs: that is mapped to the "C:\Documents and Settings\User01\My Documents" directory on the local computer.

It uses the **Name** parameter to specify a name for the drive, the **PSProvider** parameter to specify the Windows PowerShell FileSystem provider, the **Root** parameter to specify the path to the My Documents folder, and the **Description** parameter to create a description of the drive.

When the command completes, the contents of the My Documents folder appear in the MyDocs: drive.
To see them, type: "dir MyDocs:".

### Example 3
```
PS C:\> New-PSDrive -Name MyCompany -PSProvider Registry -Root HKLM:\Software\MyCompany

Name       Provider      Root
----       --------      ----
MyCompany  Registry      HKEY_LOCAL_MACHINE\Software\MyCo...
```

This command creates a temporary Windows PowerShell drive that provides quick access to a frequently checked registry key.
It creates a drive named MyCompany that is mapped to the HKLM\Software\MyCompany registry key.

It uses the **Name** parameter to specify a name for the drive, the **PSProvider** parameter to specify the Windows PowerShell Registry provider, and the **Root** parameter to specify the registry key.

When the command completes, the contents of the MyCompany key appear in the MyCompany: drive.
To see them, type: "`dir MyCompany:`".

### Example 4
```
PS C:\> New-PSDrive -Name S -Root \\Server01\Scripts -Persist -PSProvider FileSystem
PS C:\> net use
Status       Local     Remote                    Network
---------------------------------------------------------
OK           S:        \\Server01\Scripts        Microsoft Windows Network
```

This command creates the "S" mapped network drive on the local computer.
The "S" drive is mapped to the \\\\Server01\Scripts network share.

The command uses the **New-PSDrive** cmdlet to create the mapped network drive.
It uses the **Persist** parameter to create a Windows mapped network drive that is saved on the local computer.

The command uses the **Name** parameter to specify a letter name that Windows accepts and the **Root** parameter to specify a location on a remote computer.
It uses the **PSProvider** parameter to specify the FileSystem provider.

The resulting drive can be viewed in other Windows PowerShell sessions on the local computer, in Windows Explorer, and in other tools, such as Net Use.

### Example 5
```
The first command uses the **New-PSDrive** cmdlet to create a temporary Windows PowerShell drive called PSDrive: that is mapped to the \\Server01\Public network share.
PS C:\> New-PSDrive -Name PSDrive -PSProvider FileSystem -Root \\Server01\Public

The second command uses the **Persist** parameter of **New-PSDrive** to create the X: mapped network drive, which is also mapped to the \\Server01\Public network share.
PS C:\> New-PSDrive -Persist -Name X -PSProvider FileSystem -Root \\Server01\Public

Now, you can use the **Get-PSDrive** drive cmdlet to examine the two drives. The drives appear to be the same, although the network share name appears only in the root of the PSDrive: drive.
PS C:\> Get-PSDrive -Name PSDrive, X
Name       Provider      Root
----       --------      ----

PsDrive    FileSystem    \\Server01\public
X          FileSystem    X:\

The output of the Get-Member cmdlet shows that the drives have the same object type, System.Management.Automation.PSDriveInfo.
PS C:\> Get-PSDrive PSDrive, x | Get-Member
TypeName: System.Management.Automation.PSDriveInfo
 


Name                MemberType Definition
----                ---------- ----------
CompareTo           Method     System.Int32 CompareTo(PSDriveInfo drive),
Equals              Method     System.Boolean Equals(Object obj),
GetHashCode         Method     System.Int32 GetHashCode()
...


However, a "net use" command, a Get-WmiObject command for the Win32_LogicalDisk class, and a **Get-WmiObject** command for the Win32_NetworkConnection class find only the persistent X: drive because Windows PowerShell temporary drives are known only to Windows PowerShell.If you close the Windows PowerShell session and then open a new one, the PSDrive: drive is gone, and the X: drive persists. Therefore, when deciding which method to use to map network drives, consider how you will use the drive, whether it needs to be persistent, and whether the drive needs to be visible to other Windows features.
PS C:\> net use

Status       Local     Remote                    Network
--------------------------------------------------------
OK           X:        \\contoso-pc\data            Microsoft Windows Network

PS C:\> Get-WmiObject Win32_LogicalDisk | Format-Table -Property DeviceID

deviceid
--------
C:
D:
X:

PS C:\> Get-WmiObject Win32_NetworkConnection

LocalName                  RemoteName                 ConnectionState            Status
---------                  ----------              ---------------               ------
X:                         \\products\public          Disconnected               Unavailable
```

This example shows the difference between a persistent mapped network drive and a temporary Windows PowerShell drive that is mapped to the same network share.

## PARAMETERS

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01".
Or, enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

Beginning in Windows PowerShell 3.0, when the value of the **Root** parameter is a UNC path, you can use credentials to create file system drives.
This parameter is not supported by all Windows PowerShell providers.

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

### -Description
Specifies a brief text description of the drive.
Type any string.

To see the descriptions of all of the drives in the session, type "`Get-PSDrive | Format-Table Name, Description`".
To see the description of a particular drives, type "`(Get-PSDrive \<DriveName\>).Description`".

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies a name for the new drive.
For persistent mapped network drives, type a drive letter.
For temporary Windows PowerShell drives, type any valid string; you are not limited to drive letters.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Persist
Creates a Windows mapped network drive.
Mapped network drives are saved in Windows on the local computer.
They are persistent, not session-specific, and can be viewed and managed in File Explorer and other tools.

When you scope the command locally (that is, without dot-sourcing), the Persist parameter won't persist the creation of a PSDrive beyond the scope in which you run the command.
If you run the New-PSDrive cmdlet inside of a script, and you want the new drive to persist indefinitely, you must dot-source the script.
For best results, to force a new drive to persist, specify Global as the value of the **Scope** parameter, as well as adding the Persist parameter to your command.

The name of the drive must be a letter, such as D or E.
The value of the **Root** parameter must be a UNC path to a different computer.
The value of the **PSProvider** parameter must be FileSystem.

To disconnect a Windows mapped network drive, use the Remove-PSDrive cmdlet.
When you disconnect a Windows mapped network drive, the mapping is permanently deleted from the computer, not just deleted from the current session.

NOTE: Mapped network drives are specific to a user account.
Mapped network drives that you create in sessions that are started with the "Run as administrator" option or with the credential of another user are not visible in a session that you started without explicit credentials, or with the credentials of the current user.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Specifies the Windows PowerShell provider that supports drives of this type.

For example, if the drive is associated with a network share or file system directory, the Windows PowerShell provider is "FileSystem".
If the drive is associated with a registry key, the provider is "Registry".

Temporary Windows PowerShell drives can be associated with any Windows PowerShell provider.
Mapped network drives can be associated only with the FileSystem provider.

To see a list of the providers in your Windows PowerShell session, use the Get-PSProvider cmdlet.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Root
Specifies the data store location to which a Windows PowerShell drive is mapped.

For example, specify a network share (such as \\\\Server01\Public), a local directory (such as C:\Program Files), or a registry key (such as HKLM:\Software\Microsoft).

Temporary Windows PowerShell drives can be associated with a local or remote location on any supported provider drive.
Mapped network drives can be associated only with a file system location on a remote computer.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies a scope for the drive.
Valid values are "**Global**", "**Local**", or "**Script**", or a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
"**Local**" is the default.
For more information, see about_Scopes (http://go.microsoft.com/fwlink/?LinkID=113260).

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Local
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSDriveInfo

## NOTES
* The **New-PSDrive** cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, use the Get-PSProvider cmdlet. For more information about providers, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).
* Mapped network drives are specific to a user account. Mapped network drives that you create in sessions that are started with the "Run as administrator" option or with the credential of another user are not visible in a session that you started without explicit credentials, or with the credentials of the current user.

## RELATED LINKS

[Get-PSDrive](Get-PSDrive.md)

[Remove-PSDrive](Remove-PSDrive.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)


