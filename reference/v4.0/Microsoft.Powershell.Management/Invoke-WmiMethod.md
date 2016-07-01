---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Invoke WmiMethod
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=290507
schema:  2.0.0
---


# Invoke-WmiMethod
## SYNOPSIS
Calls Windows Management Instrumentation (WMI) methods.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Invoke-WmiMethod [-Class] <String> [-Name] <String> [[-ArgumentList] <Object[]>] [-AsJob] [-Authentication]
 [-Authority <String>] [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges]
 [-Impersonation] [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Invoke-WmiMethod [-Name] <String> [[-ArgumentList] <Object[]>] [-AsJob] [-ThrottleLimit <Int32>]
 -InputObject <ManagementObject> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Invoke-WmiMethod [-Name] <String> [[-ArgumentList] <Object[]>] [-AsJob] [-Authentication] [-Authority <String>]
 [-ComputerName <String[]>] [-Credential <PSCredential>] [-EnableAllPrivileges] [-Impersonation]
 [-Locale <String>] [-Namespace <String>] [-ThrottleLimit <Int32>] -Path <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_4
```
Invoke-WmiMethod [-Name] <String> [-AsJob] [-Authentication] [-Authority <String>] [-ComputerName <String[]>]
 [-Credential <PSCredential>] [-EnableAllPrivileges] [-Impersonation] [-Locale <String>] [-Namespace <String>]
 [-ThrottleLimit <Int32>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_5
```
Invoke-WmiMethod [-Name] <String> [-AsJob] [-Authentication] [-Authority <String>] [-ComputerName <String[]>]
 [-Credential <PSCredential>] [-EnableAllPrivileges] [-Impersonation] [-Locale <String>] [-Namespace <String>]
 [-ThrottleLimit <Int32>] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_6
```
Invoke-WmiMethod [-Name] <String> [-AsJob] [-Authentication] [-Authority <String>] [-ComputerName <String[]>]
 [-Credential <PSCredential>] [-EnableAllPrivileges] [-Impersonation] [-Locale <String>] [-Namespace <String>]
 [-ThrottleLimit <Int32>] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Invoke-WmiMethod cmdlet calls the methods of WMI objects.

New CIM cmdlets, introduced Windows PowerShell 3.0, perform the same tasks as the WMI cmdlets.
The CIM cmdlets comply with WS-Management (WSMan) standards and with the Common Information Model (CIM) standard, which enables the cmdlets to use the same techniques to manage Windows computers and those running other operating systems.
Instead of using Invoke-WmiMethod, consider using Invoke-CimMethodhttp://go.microsoft.com/fwlink/?LinkId=227965.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>([wmiclass]'Win32_Volume').GetMethodParameters('Format')
__GENUS           : 2
__CLASS           : __PARAMETERS
__SUPERCLASS      :
__DYNASTY         : __PARAMETERS
__RELPATH         :
__PROPERTY_COUNT  : 6
__DERIVATION      : {}
__SERVER          :
__NAMESPACE       :
__PATH            :
ClusterSize       : 0
EnableCompression : False
FileSystem        : NTFS
Label             :
QuickFormat       : False
Version           : 0
PSComputerName    :
```

To invoke WMI in PowerShell 3.0 differs from alternate methods, and requires that object values are entered in a specific order.
This command lists the required order of the objects.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>([Wmiclass]'Win32_Process').GetMethodParameters('Create')
__GENUS                   : 2
__CLASS                   : __PARAMETERS
__SUPERCLASS              : 
__DYNASTY                 : __PARAMETERS
__RELPATH                 : 
__PROPERTY_COUNT          : 3
__DERIVATION              : {}
__SERVER                  : 
__NAMESPACE               : 
__PATH                    : 
CommandLine               : 
CurrentDirectory          : 
ProcessStartupInformation : 
PSComputerName            : PS C:\>invoke-wmimethod -path win32_process -name create -argumentlist notepad.exe
__GENUS          : 2
__CLASS          : __PARAMETERS
__SUPERCLASS     : 
__DYNASTY        : __PARAMETERS
__RELPATH        : 
__PROPERTY_COUNT : 2
__DERIVATION     : {}
__SERVER         : 
__NAMESPACE      : 
__PATH           : 
ProcessId        : 11312
ReturnValue      : 0
PSComputerName   :
```

The following two commands start an instance of Notepad by calling the Create method of the Win32_Process class.

Note: The ReturnValue property is populated with a 0, and the ProcessId property is populated with an integer (the next process ID number) if the command is completed.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>invoke-wmimethod -path "CIM_DataFile.Name='C:\scripts\test.txt'" -Name Rename -ArgumentList "C:\scripts\test_bu.txt"
__GENUS          : 2
__CLASS          : __PARAMETERS
__SUPERCLASS     : 
__DYNASTY        : __PARAMETERS
__RELPATH        : 
__PROPERTY_COUNT : 1
__DERIVATION     : {}
__SERVER         : 
__NAMESPACE      : 
__PATH           : 
ReturnValue      : 0
```

This command renames a file.
It uses the Path parameter to reference an instance of the CIM_DataFile class.
Then, it applies the Rename method to that particular instance.

Note: The ReturnValue property is populated with a 0 if the command is completed.

## PARAMETERS

### -ArgumentList
Specifies the parameters to pass to the called method.
The value of this parameter must be an array of objects, and they must appear in the order required by the called method (note that new Invoke-CimCommand does not have these limitations).

To determine the order in which to list those objects, run the GetMethodParameters() method on the WMI class, as illustrated in Example 1, near the end of this topic.

Important: If the first value is an array that contains more than one element, a second value of $null is required.
Otherwise, the command generates an error, such as "Unable to cast object of type 'System.Byte' to type 'System.Array'.".

An example using an array of objects ($binSD) followed by a null value ($null) follows:

PS C:\\\>$acl = get-acl test.txt

PS C:\\\>$binSD = $acl.GetSecurityDescriptorBinaryForm()

PS C:\\\>invoke-wmimethod -class Win32_SecurityDescriptorHelper -Name BinarySDToSDDL -argumentlist $binSD, $null

```yaml
Type: Object[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: Args

Required: False
Position: 3
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJob
Runs the command as a background job.
Use this parameter to run commands that take a long time to finish.

When you use the AsJob parameter, the command returns an object that represents the background job and then displays the command prompt.
You can continue to work in the session while the job finishes.
If Invoke-WmiMethod is used against a remote computer, the job is created on the local computer, and the results from remote computers are automatically returned to the local computer.
To manage the job, use the cmdlets that contain the Job noun (the Job cmdlets).
To get the job results, use the Receive-Job cmdlet.

Note: To use this parameter with remote computers, the local and remote computers must be configured for remoting.
Additionally, you must start Windows PowerShell by using the "Run as administrator" option in Windows Vista and later versions of Windows.
For more information, see about_Remote_Requirements.

For more information about Windows PowerShell background jobs, see about_Jobs and about_Remote_Jobs.

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
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: 
Accepted values: Default, None, Connect, Call, Packet, PacketIntegrity, PacketPrivacy, Unchanged

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Authority
Specifies the authority to use to authenticate the WMI connection.
You can specify standard NTLM or Kerberos authentication.
To use NTLM, set the authority setting to ntlmdomain:\<DomainName\>, where \<DomainName\> identifies a valid NTLM domain name.
To use Kerberos, specify kerberos:\<DomainName\ServerName\>.
You cannot include the authority setting when you connect to the local computer.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Class
Specifies the WMI class that contains a static method to call.

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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: Cn

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
Type a user name, such as "User01", "Domain01\User01", or User@Contoso.com.
Or, enter a PSCredential object, such as an object that is returned by the Get-Credential cmdlet.
When you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
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
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: 
Accepted values: Default, Anonymous, Identify, Impersonate, Delegate

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a ManagementObject object to use as input.
When this parameter is used, all other parameters except the Flag and Argument parameters are ignored.

```yaml
Type: ManagementObject
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Locale
Specifies the preferred locale for WMI objects.
Specify the value of the Locale parameter as an array in the MS_\<LCID\> format in the preferred order.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the method to be invoked.
This parameter is mandatory and cannot be null or empty.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace
When used with the Class parameter, this parameter specifies the WMI repository namespace where the referenced WMI class or object is located.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4, UNNAMED_PARAMETER_SET_5, UNNAMED_PARAMETER_SET_6
Aliases: NS

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the WMI object path of a WMI class, or specifies the WMI object path of an instance of a WMI class.
The class or the instance that you specify must contain the method that is specified in the Name parameter.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
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

### None
This cmdlet does not accept any input.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Get-WSManInstance](http://technet.microsoft.com/library/hh849864.aspx)

[Invoke-WSManAction](http://technet.microsoft.com/library/hh849865.aspx)

[New-WSManInstance](http://technet.microsoft.com/library/hh849866.aspx)

[Remove-WSManInstance](http://technet.microsoft.com/library/hh849870.aspx)

[Get-WmiObject](Get-WmiObject.md)

[Remove-WmiObject](Remove-WmiObject.md)

[Set-WmiInstance](Set-WmiInstance.md)

