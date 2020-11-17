---
external help file: Microsoft.PowerShell.Utility-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-sddlstring?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-SddlString
---
# ConvertFrom-SddlString

## SYNOPSIS
Converts a SDDL string to a custom object.

## SYNTAX

### All

```
ConvertFrom-SddlString [-Sddl] <String> [-Type <AccessRightTypeNames>] [<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-SddlString` cmdlet converts a Security Descriptor Definition Language string to a
custom **PSCustomObject** object with the following properties: Owner, Group, DiscretionaryAcl,
SystemAcl and RawDescriptor.

Owner, Group, DiscretionaryAcl and SystemAcl properties contain a readable text representation of
the access rights specified in a SDDL string.

This cmdlet was introduced in PowerShell 5.0.

## EXAMPLES

### Example 1: Convert file system access rights SDDL to a PSCustomObject

```powershell
$acl = Get-Acl -Path C:\Windows
ConvertFrom-SddlString -Sddl $acl.Sddl
```

The first command uses the `Get-Acl` cmdlet to get the security descriptor for the C:\Windows folder
and saves it in the variable.

The second command uses the `ConvertFrom-SddlString` cmdlet to get the text representation of the
SDDL string, contained in the Sddl property of the object representing the security descriptor.

### Example 2: Convert registry access rights SDDL to a PSCustomObject

```powershell
$acl = Get-Acl HKLM:\SOFTWARE\Microsoft\
ConvertFrom-SddlString -Sddl $acl.Sddl -Type RegistryRights
```

The first command uses the `Get-Acl` cmdlet to get the security descriptor for the
HKLM:\SOFTWARE\Microsoft\ key and saves it in the variable.

The second command uses the `ConvertFrom-SddlString` cmdlet to get the text representation of the
SDDL string, contained in the Sddl property of the object representing the security descriptor.

It uses the `-Type` parameter to specify that SDDL string represents a registry security descriptor.

### Example 3: Convert registry access rights SDDL to a PSCustomObject by using ConvertFrom-SddlString with and without the `-Type` parameter

```powershell
$acl = Get-Acl -Path HKLM:\SOFTWARE\Microsoft\

ConvertFrom-SddlString -Sddl $acl.Sddl | Foreach-Object {$_.DiscretionaryAcl[0]}

BUILTIN\Administrators: AccessAllowed (ChangePermissions, CreateDirectories, Delete, ExecuteKey, FullControl, GenericExecute, GenericWrite, ListDirectory, ReadExtendedAttributes, ReadPermissions, TakeOwnership, Traverse, WriteData, WriteExtendedAttributes, WriteKey)

ConvertFrom-SddlString -Sddl $acl.Sddl -Type RegistryRights | Foreach-Object {$_.DiscretionaryAcl[0]}

BUILTIN\Administrators: AccessAllowed (ChangePermissions, CreateLink, CreateSubKey, Delete, EnumerateSubKeys, ExecuteKey, FullControl, GenericExecute, GenericWrite, Notify, QueryValues, ReadPermissions, SetValue, TakeOwnership, WriteKey)
```

The first command uses the `Get-Acl` cmdlet to get the security descriptor for the
HKLM:\SOFTWARE\Microsoft\ key and saves it in the variable.

The second command uses the `ConvertFrom-SddlString` cmdlet to get the text representation of the
SDDL string, contained in the Sddl property of the object representing the security descriptor.

It doesn't use the `-Type` parameter, so the access rights shown are for file system.

The third command uses the `ConvertFrom-SddlString` cmdlet with the `-Type` parameter, so the access
rights returned are for registry.

## PARAMETERS

### -Sddl

Specifies the string representing the security descriptor in SDDL syntax.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Type

Specifies the type of rights that SDDL string represents.

The acceptable values for this parameter are:

- FileSystemRights
- RegistryRights
- ActiveDirectoryRights
- MutexRights
- SemaphoreRights
- CryptoKeyRights
- EventWaitHandleRights

By default cmdlet uses file system rights.

CryptoKeyRights and ActiveDirectoryRights are not supported in PowerShell Core.

```yaml
Type: Microsoft.PowerShell.Commands.ConvertFromSddlStringCommand+AccessRightTypeNames
Parameter Sets: (All)
Aliases:
Accepted values: FileSystemRights, RegistryRights, ActiveDirectoryRights, MutexRights, SemaphoreRights, CryptoKeyRights, EventWaitHandleRights

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a SDDL string to `ConvertFrom-SddlString`.

## OUTPUTS

## NOTES

This cmdlet is only available on Windows platforms.

## RELATED LINKS

[Security Descriptor Definition Language](/windows/win32/secauthz/security-descriptor-definition-language)
