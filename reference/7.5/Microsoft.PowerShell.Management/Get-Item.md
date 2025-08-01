---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 02/14/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - gi
title: Get-Item
---
# Get-Item

## SYNOPSIS
Gets the item at the specified location.

## SYNTAX

### Path (Default) - FileSystem provider

```
Get-Item [-Path] <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
 [-Stream <string[]>] [<CommonParameters>]
```

### LiteralPath - FileSystem provider

```
Get-Item -LiteralPath <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
 [-Stream <string[]>] [<CommonParameters>]
```

### Path (Default) - Certificate provider

```
Get-Item [-Path] <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-CodeSigningCert]
 [-DocumentEncryptionCert] [-SSLServerAuthentication] [-DnsName <string>]
 [-Eku <string[]>] [-ExpiringInDays <int>] [<CommonParameters>]
```

### LiteralPath - Certificate provider

```
Get-Item -LiteralPath <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>] [-CodeSigningCert]
 [-DocumentEncryptionCert] [-SSLServerAuthentication] [-DnsName <string>]
 [-Eku <string[]>] [-ExpiringInDays <int>] [<CommonParameters>]
```

### Path (Default) - All providers

```
Get-Item [-Path] <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
 [<CommonParameters>]
```

### LiteralPath - All providers

```
Get-Item -LiteralPath <string[]> [-Filter <string>] [-Include <string[]>]
 [-Exclude <string[]>] [-Force] [-Credential <pscredential>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-Item` cmdlet gets the item at the specified location. It doesn't get the contents of the
item at the location unless you use a wildcard character (`*`) to request all the contents of the
item.

This cmdlet is used by PowerShell providers to navigate through different types of data stores.

## EXAMPLES

### Example 1: Get the current directory

This example gets the current directory. The dot ('.') represents the item at the current location
(not its contents).

```powershell
Get-Item .
```

```output
Directory: C:\

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006  10:01 AM            ps-test
```

### Example 2: Get all the items in the current directory

This example gets all the items in the current directory. The wildcard character (`*`) represents
all the contents of the current item.

```powershell
Get-Item *
```

```output
Directory: C:\ps-test

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006   9:29 AM            Logs
d----         7/26/2006   9:26 AM            Recs
-a---         7/26/2006   9:28 AM         80 date.csv
-a---         7/26/2006  10:01 AM         30 filenoext
-a---         7/26/2006   9:30 AM      11472 process.doc
-a---         7/14/2006  10:47 AM         30 test.txt
```

### Example 3: Get the current directory of a drive

This example gets the current directory of the `C:` drive. The object that is retrieved represents
only the directory, not its contents.

```powershell
Get-Item C:
```

### Example 4: Get items in the specified drive

This example gets the items in the `C:` drive. The wildcard character (`*`) represents all the items
in the container, not just the container.

```powershell
Get-Item C:\*
```

In PowerShell, use a single asterisk (`*`) to get contents, instead of the traditional `*.*`. The
format is interpreted literally, so `*.*` wouldn't retrieve directories or filenames without a dot.

### Example 5: Get a property in the specified directory

This example gets the **LastAccessTime** property of the `C:\Windows` directory. **LastAccessTime**
is just one property of file system directories. To see all the properties of a directory, type
`(Get-Item <directory-name>) | Get-Member`.

```powershell
(Get-Item C:\Windows).LastAccessTime
```

### Example 6: Show the contents of a registry key

This example shows the contents of the **Microsoft.PowerShell** registry key. You can use this
cmdlet with the PowerShell Registry provider to get registry keys and subkeys, but you must use the
`Get-ItemProperty` cmdlet to get the registry values and data.

```powershell
Get-Item HKLM:\Software\Microsoft\PowerShell\1\Shellids\Microsoft.PowerShell\
```

### Example 7: Get items in a directory that have an exclusion

This example gets items in the Windows directory with names that include a dot (`.`), but don't
begin with `w*`.This example works only when the path includes a wildcard character (`*`) to specify
the contents of the item.

```powershell
Get-Item C:\Windows\*.* -Exclude "w*"
```

### Example 8: Getting hardlink information

In PowerShell 6.2, an alternate view was added to get hardlink information. To get the hardlink
information, pipe the output to `Format-Table -View childrenWithHardlink`

```powershell
Get-Item C:\Windows\System32\ntoskrnl.exe |
    Format-Table -View childrenWithHardLink
```

```Output
    Directory: C:\Windows\System32

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
la---           5/12/2021  7:40 AM       10848576 ntoskrnl.exe
```

The `Mode` property identifies the hardlink by the `l` in `la---`

### Example 9: Output for Non-Windows Operating Systems

In PowerShell 7.1 on Unix systems, the `Get-Item` cmdlet provides Unix-like
output:

```powershell
PS> Get-Item /Users
```

```Output
    Directory: /

UnixMode    User  Group   LastWriteTime      Size  Name
--------    ----  -----   -------------      ----  ----
drwxr-xr-x  root  admin   12/20/2019 11:46   192   Users
```

The new properties that are now part of the output are:

- **UnixMode** is the file permissions as represented on a Unix system
- **User** is the file owner
- **Group** is the group owner
- **Size** is the size of the file or directory as represented on a Unix system

> [!NOTE]
> This feature was moved from experimental to mainstream in PowerShell 7.1.

## PARAMETERS

### -CodeSigningCert

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

To get certificates that have `Code Signing` in their **EnhancedKeyUsageList** property value, use
the **CodeSigningCert** parameter.

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: System.Management.Automation.SwitchParameter
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
> This parameter isn't supported by any providers installed with PowerShell.
> To impersonate another user, or elevate your credentials when running this cmdlet,
> use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

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

### -DnsName

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

Specifies a domain name or name pattern to match with the **DNSNameList** property of certificates
the cmdlet gets. The value of this parameter can either be `Unicode` or `ASCII`. Punycode values
are converted to Unicode. Wildcard characters (`*`) are permitted.

This parameter was reintroduced in PowerShell 7.1

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: Microsoft.PowerShell.Commands.DnsNameRepresentation
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -DocumentEncryptionCert

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

To get certificates that have `Document Encryption` in their **EnhancedKeyUsageList** property
value, use the **DocumentEncryptionCert** parameter.

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Eku

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

Specifies text or a text pattern to match with the **EnhancedKeyUsageList** property of
certificates the cmdlet gets. Wildcard characters (`*`) are permitted. The **EnhancedKeyUsageList**
property contains the friendly name and the OID fields of the EKU.

This parameter was reintroduced in PowerShell 7.1

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

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

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

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

### -ExpiringInDays

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

Specifies that the cmdlet should only return certificates that are expiring in or before the
specified number of days. A value of zero (`0`) gets certificates that have expired.

This parameter was reintroduced in PowerShell 7.1

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The
[FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md) provider is the only
installed PowerShell provider that supports filters. Filters are more efficient than other
parameters. The provider applies filter when the cmdlet gets the objects rather than having
PowerShell filter the objects after they're retrieved. The filter string is passed to the .NET API
to enumerate files. The API only supports `*` and `?` wildcards.

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

Indicates that this cmdlet gets items that can't otherwise be accessed, such as hidden items.
Implementation varies from provider to provider. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md). Even using the **Force**
parameter, the cmdlet can't override security restrictions.

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

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Include** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

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

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it's
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see
[about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

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

Specifies the path to an item. This cmdlet gets the item at the specified location. Wildcard
characters are permitted. This parameter is required, but the parameter name **Path** is optional.

Use a dot (`.`) to specify the current location. Use the wildcard character (`*`) to specify all the
items in the current location.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -SSLServerAuthentication

This is a dynamic parameter made available by the **Certificate** provider. This parameter and the
**Certificate** provider are only available on Windows.

To get certificates that have `Server Authentication` in their **EnhancedKeyUsageList** property
value, use the **SSLServerAuthentication** parameter.

For more information, see
[about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream

This is a dynamic parameter made available by the **FileSystem** provider. This parameter is only
available on Windows.

Gets the specified alternative data stream from the file. Enter the stream name. Wildcards are
supported. To get all streams, use an asterisk (`*`). This parameter is valid on directories, but
note that directories do not have data streams by default.

This parameter was introduced in PowerShell 3.0.  As of PowerShell 7.2, `Get-Item` can get
alternative data streams from directories as well as files.

For more information, see
[about_FileSystem_Provider](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: No alternate file streams
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to this cmdlet.

## OUTPUTS

### System.Management.Automation.AliasInfo

The cmdlet outputs this type when accessing the `Alias:` drive.

### Microsoft.PowerShell.Commands.X509StoreLocation

### System.Security.Cryptography.X509Certificates.X509Store

### System.Security.Cryptography.X509Certificates.X509Certificate2

The cmdlet outputs these types when accessing the `Cert:` drive.

### System.Collections.DictionaryEntry

The cmdlet outputs this type when accessing the `Env:` drive.

### System.IO.DirectoryInfo

### System.IO.FileInfo

The cmdlet outputs these types when accessing the FileSystem drives.

### System.Management.Automation.FunctionInfo

### System.Management.Automation.FilterInfo

The cmdlet outputs these types when accessing the `Function:` drives.

### Microsoft.Win32.RegistryKey

The cmdlet outputs this type when accessing the Registry drives.

### System.Management.Automation.PSVariable

The cmdlet outputs this type when accessing the `Variable:` drives.

### Microsoft.WSMan.Management.WSManConfigContainerElement

### Microsoft.WSMan.Management.WSManConfigLeafElement

The cmdlet outputs these types when accessing the `WSMan:` drives.

## NOTES

PowerShell includes the following aliases for `Get-Item`:

- All platforms:
  - `gi`

This cmdlet does not have a **Recurse** parameter, because it gets only an item, not its contents.
To get the contents of an item recursively, use `Get-ChildItem`.

To navigate through the registry, use this cmdlet to get registry keys and the `Get-ItemProperty`
to get registry values and data. The registry values are considered to be properties of the
registry key.

This cmdlet is designed to work with the data exposed by any provider. To list the providers
available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

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

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)
