---
external help file: PSITPro4_WSMan.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294036
schema: 2.0.0
---

# Disconnect-WSMan
## SYNOPSIS
Disconnects the client from the WinRM service on a remote computer.

## SYNTAX

```
Disconnect-WSMan [[-ComputerName] <String>]
```

## DESCRIPTION
The Disconnect-WSMan cmdlet disconnects the client from the WinRM service on a remote computer.
If you saved the WS-Management session in a variable, the session object remains in the variable, but the state of the WS-Management session is "Closed".
You can use this cmdlet within the context of the WSMan provider to disconnect the client from the WinRM service on a remote computer.
However, you can also use this cmdlet to disconnect from the WinRM service on remote computers before you change to the WSMan provider.

For more information about how to connect to the WinRM service on a remote computer, see Connect-WSMan.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Disconnect-WSMan -computer server01
PS C:\>cd WSMan:
PS WSMan:\>
PS WSMan:\> dir
WSManConfig: Microsoft.WSMan.Management\WSMan::WSMan
ComputerName                                  Type
------------                                  ----
localhost                                     Container
```

This command deletes the connection to the remote server01 computer.

This cmdlet is generally used within the context of the WSMan provider to disconnect from a remote computer, in this case the server01 computer.
However, you can also use the Disconnect-WSMan cmdlet to remove connections to remote computers before you  change to the WSMan provider.
Those connections will not appear in the ComputerName list.

## PARAMETERS

### -ComputerName
Specifies the computer from which you want to disconnect.
The value can be a fully qualified domain name, a NetBIOS name, or an IP address.
Use the local computer name, use localhost, or use a dot (.) to specify the local computer.
The local computer is the default.
When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.
You can pipe a value for this parameter to the cmdlet.

Note: You cannot disconnect from the local host (the default connection to the local computer).
However, if a separate connection is made to the local computer (for example, by using the computer name), you can remove that connection by using the Disconnect-WSMan cmdlet .

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Connect-WSMan](74e46714-497f-4306-be84-109ab5b654cc)

[Disable-WSManCredSSP](01c110d4-056e-48d2-b9a0-ea62c85a2c0e)

[Enable-WSManCredSSP](affb7d94-edf1-41a4-9257-5e0e1b736add)

[Get-WSManCredSSP](985673c4-eb15-47be-a2a2-22f2080d3242)

[Get-WSManInstance](06dae292-bd46-4f6a-a246-c7c7c057db90)

[Invoke-WSManAction](2b565381-48a7-4b3e-b0a5-61a53d320a9a)

[New-WSManInstance](3b68a31e-0b27-41e5-ad6f-83f243655651)

[New-WSManSessionOption](b8d84d86-a913-4aa6-8c72-80fe7938d782)

[Remove-WSManInstance](8061efbd-5747-4e33-952b-ec3e2d07f20f)

[Set-WSManInstance](c7af8b30-3ca0-4330-8f24-60e2bf94053a)

[Set-WSManQuickConfig](6a0e74db-94a7-445a-8485-f64ca1a4948a)

[Test-WSMan](b8c6fb53-48fb-411b-a989-618a74a68067)

