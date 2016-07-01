---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Start Process
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=293918
schema:  2.0.0
---


# Start-Process
## SYNOPSIS
Starts one or more processes on the local computer.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Start-Process [-FilePath] <String> [[-ArgumentList] <String[]>] [-Credential <PSCredential>] [-LoadUserProfile]
 [-NoNewWindow] [-PassThru] [-RedirectStandardError <String>] [-RedirectStandardInput <String>]
 [-RedirectStandardOutput <String>] [-UseNewEnvironment] [-Wait] [-WindowStyle <ProcessWindowStyle>]
 [-WorkingDirectory <String>]
```

### UNNAMED_PARAMETER_SET_2
```
Start-Process [-FilePath] <String> [[-ArgumentList] <String[]>] [-PassThru] [-Verb <String>] [-Wait]
 [-WindowStyle <ProcessWindowStyle>] [-WorkingDirectory <String>]
```

## DESCRIPTION
Starts one or more processes on the local computer. 
To specify the program that runs in the process, enter an executable file or script file, or a file that can be opened by using a program on the computer.
If you specify a non-executable file, Start-Process starts the program that is associated with the file, much like the Invoke-Item cmdlet.

You can use the parameters of Start-Process to specify options, such as loading a user profile, starting the process in a new window, or using alternate credentials.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>start-process sort.exe
```

This command starts a process that uses the Sort.exe file in the current directory.
The command uses all of the default values, including the default window style, working directory, and credentials.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>start-process myfile.txt -workingdirectory "C:\PS-Test" -verb Print
```

This command starts a process that prints the C:\PS-Test\MyFile.txt file.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>start-process Sort.exe -RedirectStandardInput Testsort.txt -RedirectStandardOutput Sorted.txt -RedirectStandardError SortError.txt -UseNewEnvironment
```

This command starts a process that sorts items in the Testsort.txt file and returns the sorted items in the Sorted.txt files.
Any errors are written to the SortError.txt file.

The UseNewEnvironment parameter specifies that the process runs with its own environment variables.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>start-process notepad -wait -windowstyle Maximized
```

This command starts the Notepad process.
It maximizes the window and retains the window until the process completes.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>start-process powershell -verb runAs
```

This command starts Windows PowerShell with the "Run as administrator" option.

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>$startExe = new-object System.Diagnostics.ProcessStartInfo -args PowerShell.exe
PS C:\>$startExe.verbs
open
runas

# Starts a PowerShell process in a new console window.

PS C:\>start-process powershell.exe -verb open

# Starts a PowerShell process with "Run as Administrator" permissions.

PS C:\>start-process powershell.exe -verb runas
```

These commands show how to find the verbs that can be used when starting a process, and the effect of using the verbs to start the process.

The available verbs are determined by the file name extension of the file that runs in the process.
To find the verbs for a process, create a System.Diagnostics.ProcessStartInfo object for the process file and look in the Verbs property of the object.
In this example, we'll use the PowerShell.exe file that runs in the PowerShell process.

The first command uses the New-Object cmdlet to create a System.Diagnostics.ProcessStartInfo object for PowerShell.exe, the file that runs in the PowerShell process.
The command saves the ProcessStartInfo object in the $startExe variable.

The second command displays the values in the Verbs property of the ProcessStartInfo object in the $startExe variable.
The results show that you can use the Open and Runas verbs with PowerShell.exe, or with any process that runs a .exe file.

The third command starts a PowerShell process with the Open verb.
The Open verb starts the process in a new console window.

The fourth command starts a PowerShell process with the RunAs verb.
The RunAs verb starts the process with permissions of a member of the Administrators group on the computer.
This is the same as starting Windows PowerShell with the "Run as administrator" option.

## PARAMETERS

### -ArgumentList
Specifies parameters or parameter values to use when starting the process. 
The parameter name ("ArgumentList") is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
Type a user-name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one from the Get-Credential cmdlet.
By default, the cmdlet uses the credentials of the current user.

```yaml
Type: PSCredential
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Specifies the path (optional) and file name of the program that runs in the process.
Enter the name of an executable file or of a document, such as a .txt or .doc file, that is associated with a program on the computer.
This parameter is required.

If you specify only a file name, use the WorkingDirectory parameter to specify the path.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoadUserProfile
Loads the Windows user profile stored in the HKEY_USERS registry key for the current user.
The default value is FALSE.

This parameter does not affect the Windows PowerShell profiles.
(See about_Profiles.)

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewWindow
Start the new process in the current console window.
By default Windows PowerShell opens a new window.

You cannot use the NoNewWindow and WindowStyle parameters in the same command.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns a process object for each process that the cmdlet started.
By default, this cmdlet does not generate any output.

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

### -RedirectStandardError
Sends any errors generated by the process to a file that you specify.
Enter the path and file name.
By default, the errors are displayed in the console.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: Errors are displayed in the console
Accept pipeline input: False
Accept wildcard characters: False
```

### -RedirectStandardInput
Reads input from the specified file.
Enter the path and file name of the input file.
By default, the process gets its input from the keyboard.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: Keyboard
Accept pipeline input: False
Accept wildcard characters: False
```

### -RedirectStandardOutput
Sends the output generated by the process to a file that you specify.
Enter the path and file name.
By default, the output is displayed in the console.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: FALSE
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNewEnvironment
Use new environment variables specified for the process.
By default, the started process runs with the environment variables specified for the computer and user.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Verb
Specifies a verb to use when starting the process.
The verbs that are available are determined by the file name extension of the file that runs in the process.

The following table shows the verbs for some common process file types.

File type      Verbs
---------      -------
.cmd------Edit, Open, Print, Runas
.exe------Open, RunAs
.txt------Open, Print, PrintTo
.wav------Open, Play

To find the verbs that can be used with the file that runs in a process, use the New-Object cmdlet to create a System.Diagnostics.ProcessStartInfo object for the file.
The available verbs are in the Verbs property of the ProcessStartInfo object.
For details, see the examples.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Waits for the specified process to complete before accepting more input.
This parameter suppresses the command prompt or retains the window until the process completes.

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

### -WindowStyle
Specifies the state of the window that is used for the new process.
Valid values are Normal, Hidden, Minimized, and Maximized.
The default value is Normal.

You cannot use the WindowStyle and NoNewWindow parameters in the same command.

```yaml
Type: ProcessWindowStyle
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Normal
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkingDirectory
Specifies the location of the executable file or document that runs in the process. 
The default is the current directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Current directory
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to Start-Process.

## OUTPUTS

### None or System.Diagnostics.Process
When you use the PassThru parameter, Start-Process generates a System.Diagnostics.Process.
Otherwise, this cmdlet does not return any output.

## NOTES
* This cmdlet is implemented by using the Start method of the System.Diagnostics.Process class. For more information about this method, see "Process.Start Method" in the MSDN libraryhttp://go.microsoft.com/fwlink/?LinkId=143602 at http://go.microsoft.com/fwlink/?LinkId=143602.

*

## RELATED LINKS

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Service](Start-Service.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)

