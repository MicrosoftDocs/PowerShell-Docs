---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821713
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Get-Credential
---

# Get-Credential

## SYNOPSIS
Gets a credential object based on a user name and password.

## SYNTAX

### CredentialSet (Default)
```
Get-Credential [-Credential] <PSCredential> [<CommonParameters>]
```

### MessageSet
```
Get-Credential -Message <String> [[-UserName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Credential** cmdlet creates a credential object for a specified user name and password.
You can use the credential object in security operations.

Beginning in Windows PowerShell 3.0, you can use the *Message* parameter to specify a customized message on the dialog box that prompts the user for their name and password.

The **Get-Credential** cmdlet prompts the user for a password or a user name and password.
By default, an authentication dialog box appears to prompt the user.
However, in some host programs, such as the Windows PowerShell console, you can prompt the user at the command line by changing a registry entry.
For more information about this registry entry, see the notes and examples.

## EXAMPLES

### Example 1: Get a credential and save it
```
PS C:\> $C = Get-Credential
```

This command gets a credential object and saves it in the $C variable.

When you enter the command, a dialog box appears requesting a user name and password.
When you enter the requested information, the cmdlet creates a **PSCredential** object representing the credentials of the user and saves it in the $C variable.

You can use the object as input to cmdlets that request user authentication, such as those with a *Credential* parameter.
However, some providers that are installed with Windows PowerShell do not support the *Credential* parameter.

### Example 2: Store a credential in a variable to use with another command
```
PS C:\> $C = Get-Credential
PS C:\> Get-WmiObject Win32_DiskDrive -ComputerName "Server01" -Credential $C
```

These commands use a **PSCredential** object that the **Get-Credential** cmdlet returns to authenticate a user on a remote computer so they can use Windows Management Instrumentation (WMI) to manage the computer.

The first command gets a **PSCredential** object and saves it in the $C variable.
The second command uses the credential object in a Get-WmiObject command.
This command gets information about the disk drives on the Server01 computer.

### Example 3: Get a credential to use for Windows Management Instrumentation
```
PS C:\> Get-WmiObject Win32_BIOS -ComputerName "Server01" -Credential (Get-Credential -Credential Domain01\User01)
```

This command shows how to include a **Get-Credential** command in a **Get-WmiObject** command.

This command uses the Get-WmiObject cmdlet to get information about the BIOS on the Server01 computer.
It uses the *Credential* parameter to authenticate the user, Domain01\User01, and a **Get-Credential** command as the value of the *Credential* parameter.

### Example 4: Get a credential by name
```
PS C:\> $C = Get-Credential -Credential User01
PS C:\> $C.Username
\User01
```

This example creates a credential that includes a user name without a domain name.
It demonstrates that **Get-Credential** inserts a backslash before the user name.

The first command gets a credential with the user name User01 and stores it in the $C variable.

The second command displays the value of the Username property of the resulting **PSCredential** object.

### Example 5: Use the PromptForCredential method to get a credential
```
PS C:\> $Credential = $Host.ui.PromptForCredential("Need credentials", "Please enter your user name and password.", "", "NetBiosUserName")
```

This command uses the PromptForCredential method to prompt the user for their user name and password.
The command saves the resulting credentials in the $Credential variable.

The PromptForCredential method is an alternative to using the **Get-Credential** cmdlet.
When you use PromptForCredential, you can specify the caption, messages, and user name that appear in the message box.

### Example 6: Set the ConsolePrompting registry entry to prompt for credentials
```
PS C:\> Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds" -Name "ConsolePrompting" -Value $True
```

This example shows how to modify the registry so that the user is prompted at the command line instead of using a dialog box.

The command creates the **ConsolePrompting** registry entry and sets its value to $True.
To run this command, start Windows PowerShell with the "Run as administrator" option.

To use a dialog box for prompting, set the value of the ConsolePrompting registry entry to $False, or use the Remove-ItemProperty cmdlet to delete it.

The **ConsolePrompting** registry entry works in some host programs, such as the Windows PowerShell console.
It might not work in all host programs.

### Example 7: Create a credential without prompting the user
```
PS C:\> $User = "Domain01\User01"

The second command uses the ConvertTo-SecureString cmdlet to create a secure string from a plain text password. The command uses the *AsPlainText* parameter to indicate that the string is plain text and the *Force* parameter to confirm that you understand the risks of using plain text.
PS C:\> $PWord = ConvertTo-SecureString -String "P@sSwOrd" -AsPlainText -Force

The third command uses the New-Object cmdlet to create a **PSCredential** object from the values in the $User and $PWord variables.
PS C:\> $Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $User, $PWord
```

This example shows how to create a **PSCredential** object that is identical to the object that **Get-Credential** returns without prompting the user.
This method requires a plain text password, which might violate the security standards in some enterprises.

The first command saves the user account name in the $User variable.
The value must have the Domain\User or ComputerName\User format.

### Example 8: Get a credential from a shared script or function
```
PS C:\> Get-Credential -Message "Credentials are required for access to the \\Server1\Scripts file share." -UserName "Server01\PowerUsers"
Windows PowerShell

Credentials are required for access to the \\Server1\Scripts file share.

Password for user ntdev\pattif:
```

This command uses the *Message* and *UserName* parameters of the **Get-Credential** cmdlet.
This command format is designed for shared scripts and functions.
In this case, the message tells the user why credentials are needed and gives them confidence that the request is legitimate.

### Example 9: Get a credential for a user on a remote computer
```
PS C:\> Invoke-Command -ComputerName "Server01" {Get-Credential Domain01\User02}
Windows PowerShell Credential Request : Windows PowerShell Credential Request
Warning: This credential is being requested by a script or application on the SERVER01 remote computer. Enter your credentials only if you
trust the remote computer and the application or script requesting it.


Enter your credentials.

Password for user Domain01\User02: ***************


PSComputerName     : Server01
RunspaceId         : 422bdf52-9886-4ada-ab2f-130497c6777f
PSShowComputerName : True
UserName           : Domain01\User01
Password           : System.Security.SecureString
```

This command gets a credential from the Server01 remote computer.
The command uses the Invoke-Command cmdlet to run a **Get-Credential** command on the remote computer.
The output shows the remote security message that **Get-Credential** includes in the authentication prompt.

## PARAMETERS

### -Credential
Specifies a user name for the credential, such as User01 or Domain01\User01.
If you specify a value for this parameter, it is not necessary to type `-Credential` at the command line.

When you submit the command, you are prompted for a password.

Starting in Windows PowerShell 3.0, if you enter a user name without a domain, **Get-Credential** no longer inserts a backslash before the name.

If you omit this parameter, you are prompted for a user name and a password.

```yaml
Type: PSCredential
Parameter Sets: CredentialSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Specifies a message that appears in the authentication prompt.

This parameter is designed for use in a function or script.
You can use the message to explain to the user why you are requesting credentials and how they will be used.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: MessageSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
Specifies a user name.
The authentication prompt requests a password for the user name.
By default, the user name is blank and the authentication prompt requests both a user name and password.

When the authentication prompt appears in a dialog box, the user can edit the specified user name.
However, the user cannot change the user name when the prompt appears at the command line.
When using this parameter in a shared function or script, consider all possible presentations.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: MessageSet
Aliases:

Required: False
Position: 0
Default value: None (blank)
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSCredential
**Get-Credential** returns a credential object.

## NOTES
* You can use the **PSCredential** object that **Get-Credential** creates in cmdlets that request user authentication, such as those with a *Credential* parameter.
* By default, the authentication prompt appears in a dialog box. To display the authentication prompt at the command line, add the **ConsolePrompting** registry entry (HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\ConsolePrompting) and set its value to $True. If the **ConsolePrompting** registry entry does not exist or if its value is $False, the authentication prompt appears in a dialog box. For instructions, see the examples.

  The **ConsolePrompting** registry entry works in the Windows PowerShell console, but it does not work in all host programs.
For example, it has no effect in the Windows PowerShell Integrated Scripting Environment (ISE).
For information about the effect of the **ConsolePrompting** registry entry, see the help topics for the host program.

* The *Credential* parameter is not supported by all providers that are installed with Windows PowerShell. Beginning in Windows PowerShell 3.0, it is supported on selected cmdlets, such as Get-WmiObject and New-PSDrive.

## RELATED LINKS