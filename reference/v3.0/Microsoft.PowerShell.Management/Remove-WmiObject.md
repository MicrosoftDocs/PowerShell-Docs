---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Remove WmiObject
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113381
schema:  2.0.0
---


# Remove-WmiObject
## SYNOPSIS
Deletes an instance of an existing Windows Management Instrumentation (WMI) class.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-WmiObject [-Class] <String> [-AsJob] [-Authentication <AuthenticationLevel>] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation <ImpersonationLevel>] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-WmiObject [-AsJob] [-Authentication <AuthenticationLevel>] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation <ImpersonationLevel>] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Remove-WmiObject [-AsJob] [-Authentication <AuthenticationLevel>] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation <ImpersonationLevel>] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Remove-WmiObject [-AsJob] [-Authentication <AuthenticationLevel>] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation <ImpersonationLevel>] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>]
 -Path <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Remove-WmiObject [-AsJob] [-Authentication <AuthenticationLevel>] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation <ImpersonationLevel>] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_6
```
Remove-WmiObject [-AsJob] [-ThrottleLimit <Int32>] -InputObject <ManagementObject> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-WmiObject cmdlet deletes an instance of an existing WMI class.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>notepad
PS C:\>$np = get-wmiobject -query "select * from win32_process where name='notepad.exe'"
PS C:\>$np | remove-wmiobject
```

This command closes all the instances of Notepad.exe.

The first command starts an instance of Notepad.

The second command uses the Get-WmiObject cmdlet to retrieve the instances of the Win32_Process that correspond to Notepad.exe and stores them in the $np variable.

The third command passes the object in the $np variable to the Remove-WmiObject cmdlet, which deletes all the instances of Notepad.exe.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$a = Get-WMIObject -query "Select * From Win32_Directory Where Name ='C:\\Test'"
PS C:\>$a | Remove-WMIObject
```

This command deletes the C:\Test directory.

The first command uses the Get-WMIObject cmdlet to query for the C:\Test directory and then stores the object in the $a variable.

The second command pipes the $a variable to the Remove-WMIObject, which deletes the directory.

## PARAMETERS

### -AsJob
Runs the command as a background job. 
Use this parameter to run commands that take an extensive time to complete.

Runs the command as a background job.
Use this parameter to run commands that take a long time to finish.

New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets.
The CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM) standard, which enables the cmdlets to use the same techniques to manage Windows computers and those running other operating systems.
Instead of using Remove-WmiObject, consider using the Remove-CimInstancehttp://go.microsoft.com/fwlink/?LinkId=227964 cmdlet.

When you use the AsJob parameter, the command returns an object that represents the background job and then displays the command prompt.
You can continue to work in the session while the job finishes.
If Remove-WmiObject is used against a remote computer, the job is created on the local computer, and the results from remote computers are automatically returned to the local computer.
To manage the job, use the cmdlets that contain the Job noun (the Job cmdlets).
To get the job results, use the Receive-Job cmdlet.

Note: To use this parameter with remote computers, the local and remote computers must be configured for remoting.
Start Windows PowerShell by using the "Run as administrator" option.
For more information, see about_Remote_Requirements.

For more information about Windows PowerShell background jobs, see  about_Jobs and about_Remote_Jobs.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authentication
Specifies the authentication level to be used with the WMI connection.
Valid values are:

-1: Unchanged

0: Default

1: None (No authentication in performed.)

2: Connect (Authentication is performed only when the client establishes a relationship with the application.)

3: Call (Authentication is performed only at the beginning of each call when the application receives the request.)

4: Packet (Authentication is performed on all the data that is received from the client.)

5: PacketIntegrity (All the data that is transferred between the client  and the application is authenticated and verified.)

6: PacketPrivacy (The properties of the other authentication levels are used, and all the data is encrypted.)

```yaml
Type: AuthenticationLevel
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authority
Specifies the authority to use to authenticate the WMI connection.
You can specify standard NTLM or Kerberos authentication.
To use NTLM, set the authority setting to "ntlmdomain:\<DomainName\>", where \<DomainName\> identifies a valid NTLM domain name.
To use Kerberos, specify "kerberos:\<DomainName\>\\\<ServerName\>".
You cannot include the authority setting when you connect to the local computer.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Class
Specifies the name of a WMI class that you want to delete.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Runs the command on the specified computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of one or more computers.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as "User01", "Domain01\User01", or "User@Contoso.com".
Or, enter a PSCredential object, such as an object that is returned by the Get-Credential cmdlet.
When you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableAllPrivileges
Enables all the privileges of the current user before the command makes the WMI call.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Impersonation
Specifies the impersonation level to use.
Valid values are:

0: Default (Reads the local registry for the default impersonation level, which is usually set to "3: Impersonate".)

1: Anonymous (Hides the credentials of the caller.)

2: Identify (Allows objects to query the credentials of the caller.)

3: Impersonate (Allows objects to use the credentials of the caller.)

4: Delegate (Allows objects to permit other objects to use the credentials of the caller.)

```yaml
Type: ImpersonationLevel
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a ManagementObject object to use as input.
When this parameter is used, all other parameters are ignored.

```yaml
Type: ManagementObject
Parameter Sets: UNNAMED_PARAMETER_SET_6
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Locale
Specifies the preferred locale for WMI objects.
The Locale parameter is specified as an array in the MS_\<LCID\> format in the preferred order.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace
When used with the Class parameter, this parameter specifies the WMI repository namespace where the referenced WMI class is located.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the WMI object path of a WMI class, or specifies the WMI object path of an instance of a WMI class to delete.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit
Allows the user to specify a throttling value for the number of WMI operations that can be executed simultaneously.
This parameter is used together with the AsJob parameter.
The throttle limit applies only to the current command, not to the session or to the computer.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Management.ManagementObject
You can pipe a management object to Remove-WmiObject.

## OUTPUTS

### None or System.Management.Automation.RemotingJob
When you use the AsJob parameter, this cmdlet returns a job object.
Otherwise, it does not generate any output.

## NOTES

## RELATED LINKS

[Get-WmiObject](Get-WmiObject.md)

[Invoke-WmiMethod](Invoke-WmiMethod.md)

[Set-WmiInstance](Set-WmiInstance.md)

[Get-WSManInstance](../Microsoft.WsMan.Management/Get-WSManInstance.md)

[Invoke-WSManAction](../Microsoft.WsMan.Management/Invoke-WSManAction.md)

[New-WSManInstance](../Microsoft.WsMan.Management/New-WSManInstance.md)

[Remove-WSManInstance](../Microsoft.WsMan.Management/Remove-WSManInstance.md)

