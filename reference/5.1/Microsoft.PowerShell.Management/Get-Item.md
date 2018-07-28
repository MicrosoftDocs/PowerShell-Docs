---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821587
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Item
---

# Get-Item

## SYNOPSIS
Gets the item at the specified location.

## SYNTAX

### Path (Default)
```powershell
Get-Item [-Path] <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-UseTransaction] [-Stream <String[]>] [<CommonParameters>]
```

### LiteralPath
```powershell
Get-Item -LiteralPath <String[]> [-Filter <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force]
 [-Credential <PSCredential>] [-UseTransaction] [-Stream <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Item** cmdlet gets the item at the specified location.
It does not get the contents of the item at the location unless you use a wildcard character (*) to request all the contents of the item.

This cmdlet is used by Windows PowerShell providers to navigate through different types of data stores.

## EXAMPLES

### Example 1: Get the current directory
```
PS C:\ps-test> Get-Item .

    Directory: C:\


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d-----        7/26/2006  10:01 AM            ps-test
```

This command gets the current directory.
The dot (.) represents the item at the current location (not its contents).

### Example 2: Get all the items in the current directory
```
PS C:\ps-test> Get-Item *

    Directory: C:\ps-test


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d-----        7/26/2006   9:29 AM            Logs
d-----        7/26/2006   9:26 AM            Recs
-a----        7/26/2006   9:28 AM         80 date.csv
-a----        7/26/2006  10:01 AM         30 filenoext
-a----        7/26/2006   9:30 AM      11472 process.doc
-a----        7/14/2006  10:47 AM         30 test.txt
```

This command gets all the items in the current directory.
The wildcard character (*) represents all the contents of the current item.

### Example 3: Get the current directory of a drive
```
PS C:\ps-test> Get-Item C:\


    Directory:


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d--hs-       12/10/2017   1:16 PM                C:\
```

This command gets the current directory of the C: drive.
The object that is retrieved represents only the directory, not its contents.

### Example 4: Get items in the specified drive root
```
PS C:\ps-test> Get-Item C:\*


    Directory: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        3/19/2017  12:33 AM                PerfLogs
d-r---       11/29/2017   2:36 PM                Program Files
d-r---       11/29/2017   2:14 PM                Program Files (x86)
d-r---        7/16/2017   4:03 PM                Users
d-----       12/10/2017   1:16 PM                Windows
```

This command gets the items in the C: drive.
The wildcard character (*) represents all the items in the container, not just the container.

In Windows PowerShell, use a single asterisk (*) to get contents, instead of the traditional *.*.
The format is interpreted literally, so *.* would not retrieve directories or file names without a dot.

### Example 5: Get a property in the specified directory
```
PS C:\> (Get-Item C:\Windows).LastAccessTime

Sunday, December 10, 2017 1:16:45 PM
```

This command gets the LastAccessTime property of the C:\Windows directory.
LastAccessTime is just one property of file system directories.
To see all of the properties of a directory, type `(Get-Item \<directory-name\>) | Get-Member`.

### Example 6: Show the contents of a registry key
```
PS C:\Windows> Get-Item "hklm:\Software\Microsoft\Windows NT\*"


    Hive: HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT


Name                           Property
----                           --------
CurrentVersion                 SystemRoot                : C:\WINDOWS
                               BuildBranch               : rs2_release
                               BuildGUID                 : ffffffff-ffff-ffff-ffff-ffffffffffff
                               BuildLab                  : 15063.rs2_release.170317-1834
                               BuildLabEx                : 15063.0.amd64fre.rs2_release.170317-1834
                               CompositionEditionID      : Enterprise
                               CurrentBuild              : 15063
                               CurrentBuildNumber        : 15063
                               CurrentMajorVersionNumber : 10
                               CurrentMinorVersionNumber : 0
                               CurrentType               : Multiprocessor Free
                               CurrentVersion            : 6.3
                               EditionID                 : Enterprise
                               EditionSubstring          :
                               InstallationType          : Client
                               InstallDate               : 1495262485
                               ProductName               : Windows 10 Enterprise
                               ReleaseId                 : 1703
                               SoftwareType              : System
                               UBR                       : 726
                               PathName                  : C:\WINDOWS
                               DigitalProductId          : {164, 0, 0, 0...}
                               DigitalProductId4         : {248, 4, 0, 0...}
                               ProductId                 : 00329-00000-00003-AA840
                               RegisteredOrganization    :
                               RegisteredOwner           :
                               InstallTime               : 131397360853701614
```

This command shows the contents of the "Windows NT" registry key.
You can use this cmdlet with the Windows PowerShell Registry provider to get registry keys and subkeys, but you must use the **Get-ItemProperty** cmdlet to get the registry values and data.

### Example 7: Get items in a directory that have an exclusion
```
PS C:\> Get-Item c:\Windows\*.* -exclude "w*"


    Directory: C:\Windows


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-r---       12/11/2017  10:25 AM                Microsoft.NET
d-----         4/5/2017   4:34 PM                SoftwareDistribution.bak
-a----        5/20/2017  10:54 AM              0 ativpsrm.bin
-a----        8/25/2008  10:31 PM         292352 atprs.exe
-a----         6/3/2017   1:21 PM          64512 bfsvc.exe
-a--s-       12/11/2017   1:10 PM          67584 bootstat.dat
-a----       10/30/2015  10:48 AM          31816 CoreSingleLanguage.xml
-a----        10/8/2016   9:45 PM         232960 DfsrAdmin.exe
-a----        5/22/2017  10:24 AM           1315 DfsrAdmin.exe.config
-a----       12/10/2017   1:21 PM           1908 diagerr.xml
-a----       12/10/2017   1:21 PM           1908 diagwrn.xml
-a----        3/19/2017  12:29 AM          34774 Enterprise.xml
-a----        10/7/2015   2:11 AM        2238152 ETDUninst.dll
-a----        9/30/2017   9:12 AM        4848952 explorer.exe
-a----         6/3/2017   1:29 PM         975360 HelpPane.exe
-a----        3/19/2017  12:27 AM          18432 hh.exe
-a----       12/14/2016  10:57 AM              0 HPMProp.INI
-a----        3/19/2017  12:27 AM          43131 mib.bin
-a----         4/9/2008   6:00 PM          53478 mvtcpui.ini
-a----        3/19/2017  12:28 AM         246784 notepad.exe
-a----       11/29/2017   4:23 PM            686 PFRO.log
-a----        3/19/2017  12:27 AM         321024 regedit.exe
-a----       12/10/2017   1:21 PM            445 setupact.log
-a----       12/10/2017   1:16 PM              0 setuperr.log
-a----        3/19/2017  12:28 AM         130560 splwow64.exe
-a----       10/30/2015  10:51 AM            219 system.ini
-a----        3/19/2017  12:28 AM          65536 twain_32.dll
```

This command gets items in the Windows directory with names that include a dot (.), but do not begin with w*.
This command works only when the path includes a wildcard character (*) to specify the contents of the item.

## PARAMETERS

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user-name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one generated by the Get-Credential cmdlet.
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

### -Exclude
Specifies, as a string array, an item or items that this cmdlet excludes in the operation.
The value of this parameter qualifies the Path parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

The *Exclude* parameter is effective only when the command includes the contents of an item, such as C:\Windows\*, where the wildcard character specifies the contents of the C:\Windows directory.

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
Filters are more efficient than other parameters, because the provider applies them when this cmdlet gets the objects, rather than having Windows PowerShell filter the objects after they are retrieved.

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
Indicates that this cmdlet gets items that cannot otherwise be accessed, such as hidden items.
Implementation varies from provider to provider.
For more information, see about_Providers.
Even using the *Force* parameter, the cmdlet cannot override security restrictions.

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
Specifies, as a string array, an item or items that this cmdlet includes in the operation.
The value of this parameter qualifies the *Path* parameter.
Enter a path element or pattern, such as *.txt.
Wildcards are permitted.

The *Include* parameter is effective only when the command includes the contents of an item, such as C:\Windows\*, where the wildcard character specifies the contents of the C:\Windows directory.

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
Unlike the *Path* parameter, the value of *LiteralPath* is used exactly as it is typed.
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

### -Path
Specifies the path to an item.
This cmdlet gets the item at the specified location.
Wildcards are permitted.
This parameter is required, but the parameter name ("Path") is optional.

Use a dot (.) to specify the current location.
Use the wildcard character (*) to specify all the items in the current location.

```yaml
Type: String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Stream
Specifies an alternative data stream from a file that this cmdlet deletes.
This cmdlet does not delete the file.
Enter the stream name.
Wildcard characters are supported.

This parameter is not valid on folders.

The *Stream* parameter is a dynamic parameter that the FileSystem provider adds to **Get-Item**.
This parameter works only in file system drives.

You can use **Get-Item** to delete an alternative data stream.
However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet.
If you verify that a downloaded file is safe, use the Unblock-File cmdlet.

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

### System.Object
This cmdlet returns the objects that it gets.
The type is determined by the type of objects in the path.

## NOTES
* You can also refer to this cmdlet by its built-in alias, "gi". For more information, see about_Aliases.

  This cmdlet does not have a *Recurse* parameter, because it gets only an item, not its contents.
To get the contents of an item recursively, use Get-ChildItem.

  To navigate through the registry, use this cmdlet to get registry keys and the Get-ItemProperty to get registry values and data.
The registry values are considered to be properties of the registry key.

  This cmdlet is designed to work with the data exposed by any provider.
To list the providers available in your session, type `Get-PsProvider`.
For more information, see about_Providers.

## RELATED LINKS

[Clear-Item](Clear-Item.md)

[Copy-Item](Copy-Item.md)

[Invoke-Item](Invoke-Item.md)

[Move-Item](Move-Item.md)

[New-Item](New-Item.md)

[Remove-Item](Remove-Item.md)

[Rename-Item](Rename-Item.md)

[Set-Item](Set-Item.md)

[Get-ChildItem](Get-ChildItem.md)

[Get-ItemProperty](Get-ItemProperty.md)

[Get-PSProvider](Get-PSProvider.md)