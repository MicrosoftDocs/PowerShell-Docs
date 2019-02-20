---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821843
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Read-Host
---
# Read-Host

## SYNOPSIS
Reads a line of input from the console.

## SYNTAX

```
Read-Host [[-Prompt] <Object>] [-AsSecureString] [<CommonParameters>]
```

## DESCRIPTION

The **Read-Host** cmdlet reads a line of input from the console.
You can use it to prompt a user for input.
Because you can save the input as a secure string, you can use this cmdlet to prompt users for secure data, such as passwords, as well as shared data.

## EXAMPLES

### Example 1: Save console input to a variable

```
PS C:\> $Age = Read-Host "Please enter your age"
```

This command displays the string "Please enter your age:" as a prompt.
When a value is entered and the Enter key is pressed, the value is stored in the $Age variable.

### Example 2: Save console input as a secure string

```
PS C:\> $pwd_secure_string = Read-Host "Enter a Password" -AsSecureString
```

This command displays the string "Enter a Password:" as a prompt.
As a value is being entered, asterisks (*) appear on the console in place of the input.
When the Enter key is pressed, the value is stored as a **SecureString** object in the $pwd_secure_string variable.

## PARAMETERS

### -AsSecureString

Indicates that the cmdlet displays asterisks (*) in place of the characters that the user types as input.

When you use this parameter, the output of the **Read-Host** cmdlet is a **SecureString** object (**System.Security.SecureString**).

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

### -Prompt

Specifies the text of the prompt.
Type a string.
If the string includes spaces, enclose it in quotation marks.
Windows PowerShell appends a colon (:) to the text that you enter.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String or System.Security.SecureString

If the *AsSecureString* parameter is used, **Read-Host** returns a **SecureString**.
Otherwise, it returns a string.

## NOTES

## RELATED LINKS

[Clear-Host](../Microsoft.PowerShell.Core/Functions/Clear-Host.md)

[ConvertFrom-SecureString](../Microsoft.PowerShell.Security/ConvertFrom-SecureString.md)

[Get-Host](Get-Host.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Write-Host](Write-Host.md)