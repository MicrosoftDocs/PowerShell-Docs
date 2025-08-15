---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 05/22/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/read-host?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Read-Host
---

# Read-Host

## SYNOPSIS
Reads a line of input from the console.

## SYNTAX

### AsString (Default)

```
Read-Host [[-Prompt] <Object>] [-MaskInput] [<CommonParameters>]
```

### AsSecureString

```
Read-Host [[-Prompt] <Object>] [-AsSecureString] [<CommonParameters>]
```

## DESCRIPTION

The `Read-Host` cmdlet reads a line of input from the console (stdin). You can use it to prompt a
user for input. Because you can save the input as a secure string, you can use this cmdlet to prompt
users for secure data, such as passwords.

> [!NOTE]
> `Read-Host` has a limit of 1022 characters it can accept as input from a user.

## EXAMPLES

### Example 1: Save console input to a variable

This example displays the string "Please enter your age:" as a prompt. When a value is entered and
the Enter key is pressed, the value is stored in the `$Age` variable.

```powershell
$Age = Read-Host "Please enter your age"
```

### Example 2: Save console input as a secure string

This example displays the string "Enter a Password:" as a prompt. As a value is being entered,
asterisks (`*`) appear on the console in place of the input. When the Enter key is pressed, the
value is stored as a **SecureString** object in the `$pwd_secure_string` variable.

```powershell
$pwd_secure_string = Read-Host "Enter a Password" -AsSecureString
```

### Example 3: Mask input and as a plaintext string

This example displays the string "Enter a Password:" as a prompt. As a value is being entered,
asterisks (`*`) appear on the console in place of the input. When the Enter key is pressed, the
value is stored as a plaintext **String** object in the `$pwd_string` variable.

```powershell
$pwd_string = Read-Host "Enter a Password" -MaskInput
```

### Example 4: Normalizing input

This example prompts the user to input a list of cities separated by semi-colons. It shows the
string's value as typed by the user. In the example, the user added spaces between some of
the entries. This could lead to an error later in the script where the code expects an exact
name.

The example shows how you can convert an input string into an array of entries without any
extra spaces.

```powershell
$prompt = @(
    'List the cities you want weather information for.'
    'When specifying multiple cities, separate them with a semi-colon, like:'
    "'New York; Osan; Koforidua'"
) -join ' '

$cities = Read-Host $prompt

"Input cities string: `n`t'$cities'"

$splitCities = $cities -split ';'

"Split cities array:"
$splitCities | ForEach-Object -Process { "`t'$_'" }

$normalizedCities = $splitCities  | ForEach-Object -Process { $_.Trim() }

"Normalized split cities array:"
$normalizedCities | ForEach-Object -Process { "`t'$_'" }
```

```output
Input cities string:
        '    New York;  Osan   ;Koforidua   '
Split cities array:
        '    New York'
        '  Osan   '
        'Koforidua   '
Normalized split cities array:
        'New York'
        'Osan'
        'Koforidua'
```

The example uses the `-split` operator to convert the input string into an array of strings. Each
string in the array includes the name of a different city. However, the split strings include extra
spaces. The `Trim()` method removes the leading and trailing spaces from each string.

## PARAMETERS

### -AsSecureString

Indicates that the cmdlet displays asterisks (`*`) in place of the characters that the user types as
input. When you use this parameter, the output of the `Read-Host` cmdlet is a **SecureString**
object (**System.Security.SecureString**).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AsSecureString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaskInput

Indicates that the cmdlet displays asterisks (`*`) in place of the characters that the user types as
input. When you use this parameter, the output of the `Read-Host` cmdlet is a **String** object.
This allows you to safely prompt for a password that is returned as plaintext instead of
**SecureString**.

This parameter was added in PowerShell 7.1.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AsString
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prompt

Specifies the text of the prompt. Type a string. If the string includes spaces, enclose it in
quotation marks. PowerShell appends a colon (`:`) to the text that you enter.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.String

By default, this cmdlet returns a string.

### System.Security.SecureString

When you use **AsSecureString** parameter, this cmdlet returns a **SecureString**.

## NOTES

This cmdlet only reads from the stdin stream of the host process. Usually, the stdin stream is
connected to the keyboard of the host console.

## RELATED LINKS

[Clear-Host](../microsoft.powershell.core/clear-host.md)

[Get-Host](Get-Host.md)

[Write-Host](Write-Host.md)

[ConvertFrom-SecureString](../Microsoft.PowerShell.Security/ConvertFrom-SecureString.md)
