---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/28/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/remove-wmiobject?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-WmiObject
---

# Remove-WmiObject

## SYNOPSIS
Deletes an instance of an existing Windows Management Instrumentation (WMI) class.

## SYNTAX

### class (Default)

```
Remove-WmiObject [-Class] <String> [-AsJob] [-Impersonation <ImpersonationLevel>]
 [-Authentication <AuthenticationLevel>] [-Locale <String>] [-EnableAllPrivileges] [-Authority <String>]
 [-Credential <PSCredential>] [-ThrottleLimit <Int32>] [-ComputerName <String[]>] [-Namespace <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### object

```
Remove-WmiObject -InputObject <ManagementObject> [-AsJob] [-ThrottleLimit <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### path

```
Remove-WmiObject -Path <String> [-AsJob] [-Impersonation <ImpersonationLevel>]
 [-Authentication <AuthenticationLevel>] [-Locale <String>] [-EnableAllPrivileges] [-Authority <String>]
 [-Credential <PSCredential>] [-ThrottleLimit <Int32>] [-ComputerName <String[]>] [-Namespace <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### WQLQuery

```
Remove-WmiObject [-AsJob] [-Impersonation <ImpersonationLevel>] [-Authentication <AuthenticationLevel>]
 [-Locale <String>] [-EnableAllPrivileges] [-Authority <String>] [-Credential <PSCredential>]
 [-ThrottleLimit <Int32>] [-ComputerName <String[]>] [-Namespace <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### query

```
Remove-WmiObject [-AsJob] [-Impersonation <ImpersonationLevel>] [-Authentication <AuthenticationLevel>]
 [-Locale <String>] [-EnableAllPrivileges] [-Authority <String>] [-Credential <PSCredential>]
 [-ThrottleLimit <Int32>] [-ComputerName <String[]>] [-Namespace <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### list

```
Remove-WmiObject [-AsJob] [-Impersonation <ImpersonationLevel>] [-Authentication <AuthenticationLevel>]
 [-Locale <String>] [-EnableAllPrivileges] [-Authority <String>] [-Credential <PSCredential>]
 [-ThrottleLimit <Int32>] [-ComputerName <String[]>] [-Namespace <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-WmiObject` cmdlet deletes an instance of an existing Windows Management Instrumentation (WMI)class.

## EXAMPLES

### Example 1: Close all instances of a Win32 process

```powershell
notepad
$np = Get-WmiObject -Query "select * from win32_process where name='notepad.exe'"
$np | Remove-WmiObject
```

This example closes all the instances of Notepad.exe.

The first command starts an instance of Notepad.

The second command uses the Get-WmiObject cmdlet to retrieve the instances of the Win32_Process that
correspond to Notepad.exe, and then stores them in the `$np` variable.

The third command passes the object in the $np variable to `Remove-WmiObject`, which deletes all the
instances of Notepad.exe.

### Example 2: Delete a folder

This command deletes the C:\Test folder.

```powershell
$a = Get-WMIObject -Query "Select * From Win32_Directory Where Name ='C:\\Test'"
$a | Remove-WMIObject
```

The first command uses `Get-WMIObject` to query for the `C:\Test` folder, and then stores the object
in the `$a` variable.

The second command pipes the `$a` variable to `Remove-WMIObject`, which deletes the folder.

## PARAMETERS

### -AsJob

Indicates that this cmdlet run as a background job. Use this parameter to run commands that take a
long time to finish.

New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets. The
CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM)
standard, which enables the cmdlets to use the same techniques to manage computers that run the
Windows operating system and those running other operating systems. Instead of using
`Remove-WmiObject`, consider using the Remove-CimInstance cmdlet.

When you use the **AsJob** parameter, the command returns an object that represents the background
job and then displays the command prompt. You can continue to work in the session while the job
finishes. If `Remove-WmiObject` is used against a remote computer, the job is created on the local
computer, and the results from remote computers are automatically returned to the local computer. To
manage the job, use the cmdlets that contain the **Job** noun (the **Job** cmdlets). To get the job
results, use the `Receive-Job` cmdlet.

To use this parameter for remote computers, the local and remote computers must be configured for
remoting. Start Windows PowerShell by using the Run as administrator option. For more information,
see [about_Remote_Requirements](../Microsoft.PowerShell.Core/About/about_Remote_Requirements.md).

For more information about Windows PowerShell background jobs, see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md)
and about_Remote_Jobs.

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

### -Authentication

Specifies the authentication level to use for the WMI connection. The acceptable values for this
parameter are:

- `-1`: Unchanged.
- `0`: Default.
- `1`: None.
  No authentication in performed.
- `2`: Connect.
  Authentication is performed only when the client establishes a relationship with the application.
- `3`: Call.
  Authentication is performed only at the start of each call when the application receives the request.
- `4`: Packet.
  Authentication is performed on all the data that is received from the client.
- `5`: PacketIntegrity.
  All the data that is transferred between the client and the application is authenticated and verified.
- `6`: PacketPrivacy.
  The properties of the other authentication levels are used, and all the data is encrypted.

```yaml
Type: System.Management.AuthenticationLevel
Parameter Sets: class, path, WQLQuery, query, list
Aliases:
Accepted values: Default, None, Connect, Call, Packet, PacketIntegrity, PacketPrivacy, Unchanged

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authority

Specifies the authority to use to authenticate the WMI connection. You can specify standard NTLM or
Kerberos authentication. To use NTLM, set the authority setting to ntlmdomain:\<DomainName\>, where
\<DomainName\> identifies a valid NTLM domain name. To use Kerberos, specify
kerberos:\<DomainName\>\\\<ServerName\>. You cannot include the authority setting when you connect
to the local computer.

```yaml
Type: System.String
Parameter Sets: class, path, WQLQuery, query, list
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Class

Specifies the name of a WMI class that this cmdlet deletes.

```yaml
Type: System.String
Parameter Sets: class
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName

Specifies the name of the computer on which this cmdlet runs. The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more computers. To
specify the local computer, type the computer name, a dot (`.`), or localhost.

This parameter does not rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter even if your computer is not configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: class, path, WQLQuery, query, list
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action. The default is the current
user.

Type a user name, such as User01 or Domain01\User01, or enter a **PSCredential** object, such as one
generated by the `Get-Credential` cmdlet. If you type a user name, this cmdlet prompts you for a
password.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: class, path, WQLQuery, query, list
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableAllPrivileges

Indicates that this cmdlet enables all the permissions of the current user before the command it
makes the WMI call.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: class, path, WQLQuery, query, list
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impersonation

Specifies the impersonation level to use. The acceptable values for this parameter are:

- `0`: Default.
  Reads the local registry for the default impersonation level, which is usually set to 3: Impersonate.
- `1`: Anonymous.
  Hides the credentials of the caller.
- `2`: Identify.
  Allows objects to query the credentials of the caller.
- `3`: Impersonate.
  Allows objects to use the credentials of the caller.
- `4`: Delegate.
  Allows objects to permit other objects to use the credentials of the caller.

```yaml
Type: System.Management.ImpersonationLevel
Parameter Sets: class, path, WQLQuery, query, list
Aliases:
Accepted values: Default, Anonymous, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a **ManagementObject** object to use as input. When this parameter is used, all other
parameters are ignored.

```yaml
Type: System.Management.ManagementObject
Parameter Sets: object
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Locale

Specifies the preferred locale for WMI objects. The **Locale** parameter is specified as an array in
the MS_\<LCID\> format in the preferred order.

```yaml
Type: System.String
Parameter Sets: class, path, WQLQuery, query, list
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace

Specifies the WMI repository namespace where the referenced WMI class is located when it is used
with the **Class** parameter.

```yaml
Type: System.String
Parameter Sets: class, path, WQLQuery, query, list
Aliases: NS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the WMI object path of a WMI class, or specifies the WMI object path of an instance of a
WMI class to delete.

```yaml
Type: System.String
Parameter Sets: path
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the maximum number of concurrent connections that can be established to run this command.
This parameter is used together with the **AsJob** parameter. The throttle limit applies only to the
current command, not to the session or to the computer.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.ManagementObject

You can pipe a management object to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.RemotingJob

This cmdlet returns a job object, if you specify the **AsJob** parameter. Otherwise, it does not
generate any output.

## NOTES

Windows PowerShell includes the following aliases for `Remove-WmiObject`:

- `rwmi`

## RELATED LINKS

[Get-WmiObject](Get-WmiObject.md)

[Invoke-WmiMethod](Invoke-WmiMethod.md)

[Set-WmiInstance](Set-WmiInstance.md)
