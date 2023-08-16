---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/28/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.localaccounts/new-localuser?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-LocalUser
---

# New-LocalUser

## SYNOPSIS

Creates a local user account.

## SYNTAX

### Password (Default)

```
New-LocalUser [-AccountExpires <DateTime>] [-AccountNeverExpires] [-Description <String>]
 [-Disabled] [-FullName <String>] [-Name] <String> -Password <SecureString>
 [-PasswordNeverExpires] [-UserMayNotChangePassword] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### NoPassword

```
New-LocalUser [-AccountExpires <DateTime>] [-AccountNeverExpires] [-Description <String>]
 [-Disabled] [-FullName <String>] [-Name] <String> [-NoPassword]
 [-UserMayNotChangePassword] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `New-LocalUser` cmdlet creates a local user account. This cmdlet creates a local user account.

> [!NOTE]
> The Microsoft.PowerShell.LocalAccounts module isn't available in 32-bit PowerShell on a 64-bit
> system.

## EXAMPLES

### Example 1: Create a user account

```powershell
New-LocalUser -Name 'User02' -Description 'Description of this account.' -NoPassword
```

```output
Name    Enabled  Description
----    -------  -----------
User02  True     Description of this account.
```

This command creates a local user account and doesn't specify the **AccountExpires** or
**Password** parameters. The account doesn't expire or have a password.

### Example 2: Create a user account that has a password

```powershell
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'User03'
    Password    = $Password
    FullName    = 'Third User'
    Description = 'Description of this account.'
}
New-LocalUser @params
```

```output
Name    Enabled  Description
----    -------  -----------
User03  True     Description of this account.
```

The first command uses the `Read-Host` cmdlet to prompts you for a password. The command stores the
password as a secure string in the `$Password` variable.

The second command creates a local user account and sets the new account's password to the secure
string stored in `$Password`. The command specifies a user name, full name, and description for the
user account.

## PARAMETERS

### -AccountExpires

Specifies when the user account expires. You can use the `Get-Date` cmdlet to get a **DateTime**
object. If you don't specify this parameter, the account doesn't expire.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountNeverExpires

Indicates that the account doesn't expire.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description

Specifies a comment for the user account. The maximum length is 48 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Disabled

Indicates that this cmdlet creates the user account as disabled.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FullName

Specifies the full name for the user account. The full name differs from the user name of the user
account.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the user name for the user account.

A user name can contain up to 20 uppercase characters or lowercase characters. A user name can't
contain the following characters:

`"`, `/`, `\`, `[`, `]`, `:`, `;`, `|`, `=`, `,`, `+`, `*`, `?`, `<`, `>`, `@`

A user name can't consist only of periods `.` or spaces.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NoPassword

Indicates that the user account doesn't have a password.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NoPassword
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Password

Specifies a password for the user account. You can use `Read-Host -AsSecureString`,
`Get-Credential`, or `ConvertTo-SecureString` to create a **SecureString** object for the password.

If you omit the **Password** and **NoPassword** parameters, `New-LocalUser` prompts you for the new
user's password.

```yaml
Type: System.Security.SecureString
Parameter Sets: Password
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PasswordNeverExpires

Indicates whether the new user's password expires.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Password
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserMayNotChangePassword

Indicates that the user can't change the password on the user account.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string to this cmdlet.

### System.DateTime

You can pipe a **DateTime** object to this cmdlet.

### System.Boolean

You can pipe a boolean value to this cmdlet.

### System.Security.SecureString

You can pipe a secure string to this cmdlet.

## OUTPUTS

### System.Management.Automation.SecurityAccountsManager.LocalUser

This cmdlet returns a **LocalUser** object representing the created user account.

## NOTES

Windows PowerShell includes the following aliases for `New-LocalUser`:

- `nlu`

A user name can't be identical to any other user name or group name on the computer. A user name
can't consist only of periods `.` or spaces. A user name can contain up to 20 uppercase characters
or lowercase characters. A user name can't contain the following characters:

`"`, `/`, `\`, `[`, `]`, `:`, `;`, `|`, `=`, `,`, `+`, `*`, `?`, `<`, `>`, `@`

A password can contain up to 127 characters.

The **PrincipalSource** property is a property on **LocalUser**, **LocalGroup**, and
**LocalPrincipal** objects that describes the source of the object. The possible sources are as
follows:

- `Local`
- `Active Directory`
- `AzureAD`
- `MicrosoftAccount`

> [!NOTE]
> **PrincipalSource** is supported only by Windows 10, Windows Server 2016, and later versions of
> the Windows operating system. For earlier versions, the property is blank.

## RELATED LINKS

[Disable-LocalUser](Disable-LocalUser.md)

[Enable-LocalUser](Enable-LocalUser.md)

[Get-LocalUser](Get-LocalUser.md)

[Remove-LocalUser](Remove-LocalUser.md)

[Rename-LocalUser](Rename-LocalUser.md)

[Set-LocalUser](Set-LocalUser.md)
