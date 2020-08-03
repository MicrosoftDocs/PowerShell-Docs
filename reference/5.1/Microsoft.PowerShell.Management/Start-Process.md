---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/03/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/start-process?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-Process
---
# Start-Process

## SYNOPSIS
Starts one or more processes on the local computer.

## SYNTAX

### Default (Default)

```
Start-Process [-FilePath] <String> [[-ArgumentList] <String[]>] [-Credential <PSCredential>]
 [-WorkingDirectory <String>] [-LoadUserProfile] [-NoNewWindow] [-PassThru]
 [-RedirectStandardError <String>] [-RedirectStandardInput <String>]
 [-RedirectStandardOutput <String>] [-WindowStyle <ProcessWindowStyle>] [-Wait] [-UseNewEnvironment]
 [<CommonParameters>]
```

### UseShellExecute

```
Start-Process [-FilePath] <String> [[-ArgumentList] <String[]>] [-WorkingDirectory <String>]
 [-PassThru] [-Verb <String>] [-WindowStyle <ProcessWindowStyle>] [-Wait] [<CommonParameters>]
```

## DESCRIPTION

The `Start-Process` cmdlet starts one or more processes on the local computer. By default,
`Start-Process` creates a new process that inherits all the environment variables that are defined
in the current process.

To specify the program that runs in the process, enter an executable file or script file, or a file
that can be opened by using a program on the computer. If you specify a non-executable file,
`Start-Process` starts the program that is associated with the file, similar to the `Invoke-Item`
cmdlet.

You can use the parameters of `Start-Process` to specify options, such as loading a user profile,
starting the process in a new window, or using alternate credentials.

## EXAMPLES

### Example 1: Start a process that uses default values

This example starts a process that uses the `Sort.exe` file in the current folder. The command uses
all of the default values, including the default window style, working folder, and credentials.

```powershell
Start-Process -FilePath "sort.exe"
```

### Example 2: Print a text file

This example starts a process that prints the `C:\PS-Test\MyFile.txt` file.

```powershell
Start-Process -FilePath "myfile.txt" -WorkingDirectory "C:\PS-Test" -Verb Print
```

### Example 3: Start a process to sort items to a new file

This example starts a process that sorts items in the `Testsort.txt` file and returns the sorted
items in the `Sorted.txt` files. Any errors are written to the `SortError.txt` file.

```powershell
Start-Process -FilePath "Sort.exe" -RedirectStandardInput "Testsort.txt" -RedirectStandardOutput "Sorted.txt" -RedirectStandardError "SortError.txt" -UseNewEnvironment
```

The **UseNewEnvironment** parameter specifies that the process runs with its own environment
variables.

### Example 4: Start a process in a maximized window

This example starts the `Notepad.exe` process. It maximizes the window and retains the window until
the process completes.

```powershell
Start-Process -FilePath "notepad" -Wait -WindowStyle Maximized
```

### Example 5: Start PowerShell as an administrator

This example starts PowerShell by using the **Run as administrator** option.

```powershell
Start-Process -FilePath "powershell" -Verb RunAs
```

### Example 6: Using different verbs to start a process

This example shows how to find the verbs that can be used when starting a process. The available
verbs are determined by the filename extension of the file that runs in the process.

```powershell
$startExe = New-Object System.Diagnostics.ProcessStartInfo -Args PowerShell.exe
$startExe.verbs
```

```Output
open
runas
runasuser
```

The example uses `New-Object` to create a **System.Diagnostics.ProcessStartInfo** object for
**PowerShell.exe**, the file that runs in the PowerShell process. The **Verbs** property of the
**ProcessStartInfo** object shows that you can use the **Open** and **RunAs** verbs with
`PowerShell.exe`, or with any process that runs a `.exe` file.

### Example 7: Specifying arguments to the process

Both commands start the Windows command interpreter, issuing a `dir` command on the `Program Files`
folder. Because this foldername contains a space, the value needs surrounded with escaped quotes.
Note that the first command specifies a string as **ArgumentList**. The second command is a string
array.

```powershell
Start-Process -FilePath "$env:comspec" -ArgumentList "/c dir `"%systemdrive%\program files`""
Start-Process -FilePath "$env:comspec" -ArgumentList "/c","dir","`"%systemdrive%\program files`""
```

## PARAMETERS

### -ArgumentList

Specifies parameters or parameter values to use when this cmdlet starts the process. Arguments can
be accepted as a single string with the arguments separated by spaces, or as an array of strings
separated by commas.

If parameters or parameter values contain a space, they need to be surrounded with escaped double
quotes. For more information, see [about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to perform this action. By default, the cmdlet uses the
credentials of the current user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet. If you type a user name, you're prompted to enter the
password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Default
Aliases: RunAs

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies the optional path and filename of the program that runs in the process. Enter the name of
an executable file or of a document, such as a `.txt` or `.doc` file, that is associated with a
program on the computer. This parameter is required.

If you specify only a filename, use the **WorkingDirectory** parameter to specify the path.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PSPath

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoadUserProfile

Indicates that this cmdlet loads the Windows user profile stored in the `HKEY_USERS` registry key
for the current user.

This parameter does not affect the PowerShell profiles. For more information, see
[about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Default
Aliases: Lup

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewWindow

Start the new process in the current console window. By default PowerShell opens a new window.

You cannot use the **NoNewWindow** and **WindowStyle** parameters in the same command.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Default
Aliases: nnw

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns a process object for each process that the cmdlet started. By default, this cmdlet does not
generate any output.

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

### -RedirectStandardError

Specifies a file. This cmdlet sends any errors generated by the process to a file that you specify.
Enter the path and filename. By default, the errors are displayed in the console.

```yaml
Type: System.String
Parameter Sets: Default
Aliases: RSE

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RedirectStandardInput

Specifies a file. This cmdlet reads input from the specified file. Enter the path and filename of
the input file. By default, the process gets its input from the keyboard.

```yaml
Type: System.String
Parameter Sets: Default
Aliases: RSI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RedirectStandardOutput

Specifies a file. This cmdlet sends the output generated by the process to a file that you specify.
Enter the path and filename. By default, the output is displayed in the console.

```yaml
Type: System.String
Parameter Sets: Default
Aliases: RSO

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNewEnvironment

Indicates that this cmdlet uses new environment variables specified for the process. By default, the
started process runs with the environment variables inherited from the parent process.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Verb

Specifies a verb to use when this cmdlet starts the process. The verbs that are available are
determined by the filename extension of the file that runs in the process.

The following table shows the verbs for some common process file types.

| File type |                Verbs                |
| --------- | ----------------------------------- |
| .cmd      | Edit, Open, Print, RunAs, RunAsUser |
| .exe      | Open, RunAs, RunAsUser              |
| .txt      | Open, Print, PrintTo                |
| .wav      | Open, Play                          |

To find the verbs that can be used with the file that runs in a process, use the `New-Object` cmdlet
to create a **System.Diagnostics.ProcessStartInfo** object for the file. The available verbs are in
the **Verbs** property of the **ProcessStartInfo** object. For details, see the examples.

```yaml
Type: System.String
Parameter Sets: UseShellExecute
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait

Indicates that this cmdlet waits for the specified process and its descendants to complete before
accepting more input. This parameter suppresses the command prompt or retains the window until the
processes finish.

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

### -WindowStyle

Specifies the state of the window that is used for the new process. The acceptable values for this
parameter are: **Normal**, **Hidden**, **Minimized**, and **Maximized**. The default value is
**Normal**.

You cannot use the **WindowStyle** and **NoNewWindow** parameters in the same command.

```yaml
Type: System.Diagnostics.ProcessWindowStyle
Parameter Sets: (All)
Aliases:
Accepted values: Normal, Hidden, Minimized, Maximized

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkingDirectory

Specifies the location that the new process should start in. The default is the location of the
executable file or document being started. Wildcards are not supported. The path name must not
contain characters that would be interpreted as wildcards.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None, System.Diagnostics.Process

This cmdlet generates a **System.Diagnostics.Process** object, if you specify the **PassThru**
parameter. Otherwise, this cmdlet does not return any output.

## NOTES

- This cmdlet is implemented by using the **Start** method of the **System.Diagnostics.Process**
  class. For more information about this method, see
  [Process.Start Method](/dotnet/api/system.diagnostics.process.start#overloads).

- On Windows, when you use **UseNewEnvironment**, the new process starts only containing the default
  environment variables defined for the **Machine** scope. This has the side affect that the
  `$env:USERNAME` is set to **SYSTEM**. None of the variables from the **User** scope are included.

## RELATED LINKS

[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md)

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Service](Start-Service.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)
