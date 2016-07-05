---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294000
schema: 2.0.0
---

# Read-Host
## SYNOPSIS
Reads a line of input from the console.

## SYNTAX

```
Read-Host [[-Prompt] <Object>] [-AsSecureString]
```

## DESCRIPTION
The Read-Host cmdlet reads a line of input from the console.
You can use it to prompt a user for input.
Because you can save the input as a secure string, you can use this cmdlet to prompt users for secure data, such as passwords, as well as shared data.

## EXAMPLES

### Example 1: Save console input to a variable
```
PS C:\>$Age = Read-Host "Please enter your age"
```

This command displays the string "Please enter your age:" as a prompt.
When a value is entered and the Enter key is pressed, the value is stored in the $Age variable.

### Example 2: Save console input as a secure string
```
PS C:\>$pwd_secure_string = Read-Host "Enter a Password" -AsSecureString
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

[Clear-Host](http://go.microsoft.com/fwlink/?LinkID=225747)

[ConvertFrom-SecureString](82c65ee1-a382-4649-ac71-ad716211d53d)

[Get-Host](c06266da-6241-4680-b883-c77b31f51f9d)

[Out-Host](d572e893-ef19-42e6-8d00-2e90fa013750)

[Write-Host](023e670a-cfda-4e8c-af8f-c2b2d9ee5612)

