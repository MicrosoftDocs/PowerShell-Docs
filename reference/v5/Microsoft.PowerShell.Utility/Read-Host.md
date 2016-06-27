---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294000
schema: 2.0.0
---

# Read-Host
## SYNOPSIS
Reads a line of input from the console.

## SYNTAX

```
Read-Host [[-Prompt] <Object>] [-AsSecureString] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Read-Host cmdlet reads a line of input from the console.
You can use it to prompt a user for input.
Because you can save the input as a secure string, you can use this cmdlet to prompt users for secure data, such as passwords, as well as shared data.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$age = read-host "Please enter your age"
```

This command displays the string "Please enter your age:" as a prompt.
When a value is entered and the Enter key is pressed, the value is stored in the $age variable.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$pwd_secure_string = read-host "Enter a Password" -assecurestring
```

This command displays the string "Enter a Password:" as a prompt.
As a value is being entered, asterisks (*) appear on the console in place of the input.
When the Enter key is pressed, the value is stored as a SecureString object in the $pwd_secure_string variable.

## PARAMETERS

### -AsSecureString
Displays asterisks (*) in place of the characters that the user types as input.

When you use this parameter, the output of the Read-Host cmdlet is a SecureString object (System.Security.SecureString).

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

### -InformationAction
When you use this parameter, the output of the Read-Host cmdlet is a SecureString object (System.Security.SecureString).

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
When you use this parameter, the output of the Read-Host cmdlet is a SecureString object (System.Security.SecureString).

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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String or System.Security.SecureString
If the AsSecureString parameter is used, Read-Host returns a SecureString.
Otherwise, it returns a string.

## NOTES

## RELATED LINKS

[Clear-Host]()

[ConvertFrom-SecureString]()

[Get-Host]()

[Out-Host]()

[Write-Host]()

