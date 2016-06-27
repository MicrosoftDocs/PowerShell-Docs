---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=290500
schema: 2.0.0
---

# Get-PSDrive
## SYNOPSIS
Gets drives in the current session.

## SYNTAX

### Name (Default)
```
Get-PSDrive [[-Name] <String[]>] [-Scope <String>] [-PSProvider <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-UseTransaction]
```

### LiteralName
```
Get-PSDrive [-LiteralName] <String[]> [-Scope <String>] [-PSProvider <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-UseTransaction]
```

## DESCRIPTION
The Get-PSDrive cmdlet gets the drives in the current session.
You can get a particular drive or all drives in the session.

Get-PSDrive gets the following types of drives:

-- Windows logical drives on the computer, including drives mapped to network shares.
-- Drives exposed by Windows PowerShell providers (such as the Certificate:, Function:, and Alias: drives) and the HKLM: and HKCU: drives that are exposed by the Windows PowerShell Registry provider.
-- Session-specified temporary drives and persistent mapped network drives that you create by using the New-PSDrive cmdlet.

Beginning in Windows PowerShell 3.0, the Persist parameter of the New-PSDrive cmdlet can create mapped network drives that are saved on the local computer and are available in other sessions.
For more information, see New-PSDrive.

Also, beginning in Windows PowerShell 3.0, when an external drive is connected to the computer, Windows PowerShell automatically adds a PSDrive to the file system that represents the new drive.
You do not need to restart Windows PowerShell.
Similarly, when an external drive is disconnected from the computer, Windows PowerShell automatically deletes the PSDrive that represents the removed drive.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-PSDriveName       Provider      Root----       --------      ----Alias      AliasC          FileSystem    C:\cert       Certificate   \D          FileSystem    D:\Env        EnvironmentFunction   FunctionHKCU       Registry      HKEY_CURRENT_USERHKLM       Registry      HKEY_LOCAL_MACHINEVariable   VariableX          FileSystem    X:\
```

This command gets the drives in the current session.

The output shows the hard drive (C:) and CD-ROM drive (D:) on the computer, the drives exposed by the Windows PowerShell providers (Alias:, Cert:, Env:, Function:, HKCU:, HKLM:, and Variable:), and a drive mapped to a network share (X:).

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Get-PSDrive DName       Provider      Root----       --------      ----D          FileSystem    D:\
```

This command gets the D: drive on the computer.
Note that the drive letter in the command is not followed by a colon.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>Get-PSDrive -PSProvider FileSystemName       Provider      Root----       --------      ----C          FileSystem    C:\D          FileSystem    D:\X          FileSystem    X:\Y          FileSystem    \\Server01\PublicZ          FileSystem    C:\Windows\System32
```

This command gets all of the drives that are supported by the Windows PowerShell FileSystem provider.
This includes fixed drives, logical partitions, mapped network drives, and temporary drives that you create by using the New-PSDrive cmdlet.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>if (!(Get-PSDrive X)) {New-PSDrive -Name X -PSProvider Registry -Root HKLM:\Network}else { Write-Host "The X: drive is already in use." }
```

This command checks to see whether the X drive is already in use as a Windows PowerShell drive name.
If it is not, the command uses the New-PSDrive cmdlet to create a temporary drive that is mapped to the HKLM:\Network registry key.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>Get-PSDrive -PSProvider FileSystemPS C:\>Get-PSDrive -provider FileSystemName       Provider      Root----       --------      ----C          FileSystem    C:\D          FileSystem    D:\X          FileSystem    X:\Y          FileSystem    \\Server01\PublicZ          FileSystem    C:\Windows\System32PS C:\>net useNew connections will be remembered.Status       Local     Remote                    Network-------------------------------------------------------------------------------X:        \\Server01\Public         Microsoft Windows NetworkPS C:\>[System.IO.DriveInfo]::getdrives()Name               : C:\DriveType          : FixedDriveFormat        : NTFSIsReady            : TrueAvailableFreeSpace : 39831498752TotalFreeSpace     : 39831498752TotalSize          : 79900368896RootDirectory      : C:\VolumeLabel        :Name               : D:\DriveType          : CDRomDriveFormat        :IsReady            : FalseAvailableFreeSpace :TotalFreeSpace     :TotalSize          :RootDirectory      : D:\VolumeLabel        :Name               : X:\DriveType          : NetworkDriveFormat        : NTFSIsReady            : TrueAvailableFreeSpace : 36340559872TotalFreeSpace     : 36340559872TotalSize          : 36413280256RootDirectory      : X:\VolumeLabel        : D_DrivePS C:\>get-wmiobject win32_logicaldiskDeviceID     : C:DriveType    : 3ProviderName :FreeSpace    : 39831252992Size         : 79900368896VolumeName   :DeviceID     : D:DriveType    : 5ProviderName :FreeSpace    :Size         :VolumeName   :DeviceID     : X:DriveType    : 4ProviderName : \\server01\publicFreeSpace    : 36340559872Size         : 36413280256VolumeName   : D_DrivePS C:\>get-wmiobject win32_networkconnectionLocalName                     RemoteName--------------               ------------x:                            \\server01\public
```

This example compares the types of file system drives that are displayed by Get-PSDrive to those displayed by using other methods.
This example demonstrates different ways to display drives in Windows PowerShell, and it shows that temporary, session-specific drives created by using the New-PSDrive cmdlet are accessible only in Windows PowerShell.

The first command uses Get-PSDrive to get all of the file system drives in the session.
This includes the fixed drives (C: and D:), a mapped network drive (X:) that was created by using the Persist parameter of New-PSDrive, and two temporary Windows PowerShell drives (Y: and Z:) that were created by using New-PSDrive  without the Persist parameter.

A "net use" command, which displays Windows mapped network drives, displays only the X drive.
It does not display the Y: and Z: drives that were created by New-PSDrive.
It shows that the X: drive is also mapped to \\\\Server01\Public.

The third command uses the GetDrives method of the Microsoft .NET Framework System.IO.DriveInfo class.
This command gets the Windows file system drives, including drive X:, but it does not get the temporary drives created by New-PSDrive.

The fourth command uses the Get-WmiObject cmdlet to get the instances of the Win32_LogicalDisk class.
It returns the C:, D:, and X: drives, but not the temporary drives created by New-PSDrive.

The last command uses the Get-WmiObject cmdlet to display the instances of the Win32_NetworkConnection class.
Like "net use", it returns only the persistent X: drive that was created by New-PSDrive.

## PARAMETERS

### -InformationAction
The value of LiteralName is used exactly as it is typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
The value of LiteralName is used exactly as it is typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralName
Specifies the name of the drive.

The value of LiteralName is used exactly as it is typed.
No characters are interpreted as wildcards.
If the name includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralName
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Gets only the specified drives.
Type the drive name or letter without a colon (:).

```yaml
Type: String[]
Parameter Sets: Name
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider
Gets only the drives supported by the specified Windows PowerShell provider.
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
Gets only drives in the specified scope.
Valid values are "Global", "Local", or "Script", or a number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).
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

## INPUTS

### None
You cannot pipe objects to Get-PSDrive.

## OUTPUTS

### System.Management.Automation.PSDriveInfo
Get-PSDrive returns objects that represent the drives in the session.

## NOTES
The Get-PSDrive cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, use the Get-PSProvider cmdlet.
For more information, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250).

Mapped network drives that are created by using the Persist parameter of the New-PSDrive cmdlet are specific to a user account.
Mapped network drives that you create in sessions that are started with the "Run as administrator" option or with the credentials of another user are not visible in sessions that are started without explicit credentials or with  the credentials of the current user.

## RELATED LINKS

[New-PSDrive]()

[Remove-PSDrive]()

[about_Providers]()

