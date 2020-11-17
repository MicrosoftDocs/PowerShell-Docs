---
external help file: Microsoft.WSMan.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.WSMan.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.wsman.management/disconnect-wsman?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disconnect-WSMan
---

# Disconnect-WSMan

## SYNOPSIS
Disconnects the client from the WinRM service on a remote computer.

## SYNTAX

```
Disconnect-WSMan [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Disconnect-WSMan** cmdlet disconnects the client from the WinRM service on a remote computer.
If you saved the WS-Management session in a variable, the session object remains in the variable, but the state of the WS-Management session is Closed.
You can use this cmdlet within the context of the WSMan provider to disconnect the client from the WinRM service on a remote computer.
However, you can also use this cmdlet to disconnect from the WinRM service on remote computers before you change to the WSMan provider.

For more information about how to connect to the WinRM service on a remote computer, see Connect-WSMan.

## EXAMPLES

### Example 1: Delete a connection to a remote computer

```
PS C:\> Disconnect-WSMan -computer server01
PS C:\> cd WSMan:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan
ComputerName                                  Type
------------                                  ----
localhost                                     Container
```

This command deletes the connection to the remote computer named server01.

This cmdlet is generally used within the context of the WSMan provider to disconnect from a remote computer, in this case the server01 computer.
However, you can also use **Disconnect-WSMan** to remove connections to remote computers before you change to the WSMan provider.
Those connections do not appear in the ComputerName list.

## PARAMETERS

### -ComputerName
Specifies the computer against which to run the management operation.
The value can be a fully qualified domain name, a NetBIOS name, or an IP address.
Use the local computer name, use localhost, or use a dot (.) to specify the local computer.
The local computer is the default.
When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.
You can pipe a value for this parameter to the cmdlet.

You cannot disconnect from the local host.
That is, you cannot disconnect the default connection to the local computer.
However, if you create a separate connection to the local computer, for example, by using the computer name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Connect-WSMan](Connect-WSMan.md)

[Disable-WSManCredSSP](Disable-WSManCredSSP.md)

[Enable-WSManCredSSP](Enable-WSManCredSSP.md)

[Get-WSManCredSSP](Get-WSManCredSSP.md)

[Get-WSManInstance](Get-WSManInstance.md)

[Invoke-WSManAction](Invoke-WSManAction.md)

[New-WSManInstance](New-WSManInstance.md)

[New-WSManSessionOption](New-WSManSessionOption.md)

[Remove-WSManInstance](Remove-WSManInstance.md)

[Set-WSManInstance](Set-WSManInstance.md)

[Set-WSManQuickConfig](Set-WSManQuickConfig.md)

[Test-WSMan](Test-WSMan.md)

