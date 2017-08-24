---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821591
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-PSDrive
---

# Get-PSDrive

## SYNOPSIS
Gets drives in the current session.

## SYNTAX

### Name (Default)
```
Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider <String[]>] [-UseTransaction]
 [<CommonParameters>]
```

### LiteralName
```
Get-PSDrive [-LiteralName] <String[]> [-Scope <String>] [-PSProvider <String[]>] [-UseTransaction]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-PSDrive** cmdlet gets the drives in the current session.
You can get a particular drive or all drives in the session.

This cmdlet gets the following types of drives:

- Windows logical drives on the computer, including drives mapped to network shares.
- Drives exposed by Windows PowerShell providers (such as the Certificate:, Function:, and Alias: drives) and the HKLM: and HKCU: drives that are exposed by the Windows PowerShell Registry provider.
- Session-specified temporary drives and persistent mapped network drives that you create by using the New-PSDrive cmdlet.

Beginning in Windows PowerShell 3.0, the *Persist* parameter of the **New-PSDrive** cmdlet can create mapped network drives that are saved on the local computer and are available in other sessions.
For more information, see New-PSDrive.

Also, beginning in Windows PowerShell 3.0, when an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive.
You do not need to restart Windows PowerShell.
Similarly, when an external drive is disconnected from the computer, Windows PowerShell automatically deletes the PSDrive that represents the removed drive.

## EXAMPLES

### Example 1: Get drives in the current session
```
PS C:\> Get-PSDrive

Name       Provider      Root
----       --------      ----
Alias      Alias
C          FileSystem    C:\
Cert       Certificate   \
D          FileSystem    D:\
Env        Environment
Function   Function
HKCU       Registry      HKEY_CURRENT_USER
HKLM       Registry      HKEY_LOCAL_MACHINE
Variable   Variable
```

This command gets the drives in the current session.

The output shows the hard drive (C:), CD-ROM drive (D:), and the drives exposed by the Windows PowerShell providers (Alias:, Cert:, Env:, Function:, HKCU:, HKLM:, and Variable:).

### Example 2: Get a drive on the computer
```
PS C:\> Get-PSDrive D

Name       Provider      Root
----       --------      ----
D          FileSystem    D:\
```

This command gets the D: drive on the computer.
Note that the drive letter in the command is not followed by a colon.

### Example 3: Get all the drives that are supported by the Windows PowerShell file system provider
```
PS C:\> Get-PSDrive -PSProvider FileSystem

Name       Provider      Root
----       --------      ----
C          FileSystem    C:\
D          FileSystem    D:\
X          FileSystem    X:\
Y          FileSystem    \\Server01\Public
Z          FileSystem    C:\Windows\System32
```

This command gets all of the drives that are supported by the Windows PowerShell FileSystem provider.
This includes fixed drives, logical partitions, mapped network drives, and temporary drives that you create by using the `New-PSDrive` cmdlet.

### Example 4: Check to see if a drive is in use as a Windows PowerShell drive name
```powershell
if (Get-PSDrive X -ErrorAction SilentlyContinue) {
	Write-Host 'The X: drive is already in use.'
} else {
	New-PSDrive -Name X -PSProvider Registry -Root HKLM:\SOFTWARE
}
```

This command checks to see whether the X drive is already in use as a Windows PowerShell drive name.
If it is not, the command uses the `New-PSDrive` cmdlet to create a temporary drive that is mapped to the HKLM:\SOFTWARE registry key.

### Example 5: Compare the types of files system drives
```
PS C:\> Get-PSDrive -PSProvider FileSystem

Name       Provider      Root
----       --------      ----
C          FileSystem    C:\
D          FileSystem    D:\
X          FileSystem    X:\
Y          FileSystem    \\Server01\Public
Z          FileSystem    C:\Windows\System32

PS C:\> net use
New connections will be remembered.

Status       Local     Remote                    Network
-------------------------------------------------------------------------------
X:        \\Server01\Public         Microsoft Windows Network

PS C:\> [System.IO.DriveInfo]::GetDrives()

Name               : C:\
DriveType          : Fixed
DriveFormat        : NTFS
IsReady            : True
AvailableFreeSpace : 39831498752
TotalFreeSpace     : 39831498752
TotalSize          : 79900368896
RootDirectory      : C:\
VolumeLabel        :
Name               : D:\
DriveType          : CDRom
DriveFormat        :
IsReady            : False
AvailableFreeSpace :
TotalFreeSpace     :
TotalSize          :
RootDirectory      : D:\
VolumeLabel        :
Name               : X:\
DriveType          : Network
DriveFormat        : NTFS
IsReady            : True
AvailableFreeSpace : 36340559872
TotalFreeSpace     : 36340559872
TotalSize          : 36413280256
RootDirectory      : X:\
VolumeLabel        : D_Drive

PS C:\> Get-WmiObject Win32_LogicalDisk

DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 39831252992
Size         : 79900368896
VolumeName   :
DeviceID     : D:
DriveType    : 5
ProviderName :
FreeSpace    :
Size         :
VolumeName   :
DeviceID     : X:
DriveType    : 4
ProviderName : \\server01\public
FreeSpace    : 36340559872
Size         : 36413280256
VolumeName   : D_Drive

PS C:\> Get-WmiObject Win32_NetworkConnection

LocalName                     RemoteName
--------------               ------------
x:                            \\server01\public
```

This example compares the types of file system drives that are displayed by **Get-PSDrive** to those displayed by using other methods.
This example demonstrates different ways to display drives in Windows PowerShell, and it shows that temporary, session-specific drives created by using the New-PSDrive cmdlet are accessible only in Windows PowerShell.

The first command uses **Get-PSDrive** to get all of the file system drives in the session.
This includes the fixed drives (C: and D:), a mapped network drive (X:) that was created by using the *Persist* parameter of **New-PSDrive**, and two temporary Windows PowerShell drives (Y: and Z:) that were created by using **New-PSDrive** without the *Persist* parameter.

A net use command, which displays Windows mapped network drives, displays only the X drive.
It does not display the Y: and Z: drives that were created by **New-PSDrive**.
It shows that the X: drive is also mapped to \\\\Server01\Public.

The third command uses the **GetDrives** method of the Microsoft .NET Framework **System.IO.DriveInfo** class.
This command gets the Windows file system drives, including drive X:, but it does not get the temporary drives created by **New-PSDrive**.

The fourth command uses the Get-WmiObject cmdlet to get the instances of the **Win32_LogicalDisk** class.
It returns the C:, D:, and X: drives, but not the temporary drives created by **New-PSDrive**.

The last command uses the Get-WmiObject cmdlet to display the instances of the **Win32_NetworkConnection** class.
Like net use, it returns only the persistent X: drive that was created by **New-PSDrive**.

## PARAMETERS

### -LiteralName
Specifies the name of the drive.

The value of *LiteralName* is used exactly as it is typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralName
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies, as a string array, the name or name of drives that this cmdlet gets in the operation.
Type the drive name or letter without a colon (:).

```yaml
Type: String[]
Parameter Sets: Name
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Specifies, as a string array, the Windows PowerShell provider.
This cmdlet gets only the drives supported by this provider.
Type the name of a provider, such as FileSystem, Registry, or Certificate.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Specifies the scope in which this cmdlet gets the drives.

The acceptable values for this parameter are:

- Global
- Local
- Script
- a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
"Local" is the default.
For more information, see about_Scopes (http://go.microsoft.com/fwlink/?LinkID=113260).

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
You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSDriveInfo
This cmdlet returns objects that represent the drives in the session.

## NOTES
* This cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, use the Get-PSProvider cmdlet. For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).
* Mapped network drives that are created by using the *Persist* parameter of the New-PSDrive cmdlet are specific to a user account. Mapped network drives that you create in sessions that are started with the Run as administrator option or with the credentials of another user are not visible in sessions that are started without explicit credentials or with the credentials of the current user.

## RELATED LINKS

[New-PSDrive](New-PSDrive.md)

[Remove-PSDrive](Remove-PSDrive.md)

[Get-WmiObject](Get-WmiObject.md)

[Get-PSProvider](Get-PSProvider.md)


