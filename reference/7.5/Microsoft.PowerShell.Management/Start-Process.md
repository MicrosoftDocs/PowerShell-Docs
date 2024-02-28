---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 11/01/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-Process
---

# Start-Process

## SYNOPSIS
Starts one or more processes on the local computer.

## SYNTAX

```
Start-Process [-FilePath] <string> [[-ArgumentList] <string[]>] [-Credential <pscredential>]
 [-WorkingDirectory <string>] [-LoadUserProfile] [-NoNewWindow] [-PassThru]
 [-RedirectStandardError <string>] [-RedirectStandardInput <string>]
 [-RedirectStandardOutput <string>] [-WindowStyle <ProcessWindowStyle>] [-Wait]
 [-UseNewEnvironment] [-Environment <hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### UseShellExecute

```
Start-Process [-FilePath] <string> [[-ArgumentList] <string[]>] [-WorkingDirectory <string>]
 [-PassThru] [-Verb <string>] [-WindowStyle <ProcessWindowStyle>] [-Wait]
 [-Environment <hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Start-Process` cmdlet starts one or more processes on the local computer. By default,
`Start-Process` creates a new process that inherits all the environment variables that are defined
in the current process.

To specify the program that runs in the process, enter an executable file or script file, or a file
that can be opened using a program on the computer. If you specify a non-executable file,
`Start-Process` starts the program that's associated with the file, similar to the `Invoke-Item`
cmdlet.

You can use the parameters of `Start-Process` to specify options, such as loading a user profile,
starting the process in a new window, or using alternate credentials.

## EXAMPLES

### Example 1: Start a process that uses default values

This example starts a process that uses the `Sort.exe` file in the current folder. The command uses
all the default values, including the default window style, working folder, and credentials.

```powershell
Start-Process -FilePath "sort.exe"
```

### Example 2: Print a text file

This example starts a process that prints the `C:\PS-Test\MyFile.txt` file.

```powershell
Start-Process -FilePath "myfile.txt" -WorkingDirectory "C:\PS-Test" -Verb Print
```

### Example 3: Start a process to sort items to a new file

This example starts a process that sorts items in the `TestSort.txt` file and returns the sorted
items in the `Sorted.txt` files. Any errors are written to the `SortError.txt` file. The
**UseNewEnvironment** parameter specifies that the process runs with its own environment variables.

```powershell
$processOptions = @{
    FilePath = "sort.exe"
    RedirectStandardInput = "TestSort.txt"
    RedirectStandardOutput = "Sorted.txt"
    RedirectStandardError = "SortError.txt"
    UseNewEnvironment = $true
}
Start-Process @processOptions
```

This example uses splatting to pass parameters to the cmdlet. For more information, see
[about_Splatting](../microsoft.powershell.core/about/about_splatting.md).

### Example 4: Start a process in a maximized window

This example starts the `Notepad.exe` process. It maximizes the window and retains the window until
the process completes.

```powershell
Start-Process -FilePath "notepad" -Wait -WindowStyle Maximized
```

### Example 5: Start PowerShell as an administrator

This example starts PowerShell using the **Run as administrator** option.

```powershell
Start-Process -FilePath "powershell" -Verb RunAs
```

### Example 6: Using different verbs to start a process

This example shows how to find the verbs that can be used when starting a process. The available
verbs are determined by the filename extension of the file that runs in the process.

```powershell
$startExe = New-Object System.Diagnostics.ProcessStartInfo -Args powershell.exe
$startExe.verbs
```

```Output
open
runas
runasuser
```

The example uses `New-Object` to create a **System.Diagnostics.ProcessStartInfo** object for
`powershell.exe`, the file that runs in the PowerShell process. The **Verbs** property of the
**ProcessStartInfo** object shows that you can use the **Open** and `RunAs` verbs with
`powershell.exe`, or with any process that runs a `.exe` file.

### Example 7: Specifying arguments to the process

Both commands start the Windows command interpreter, issuing a `dir` command on the `Program Files`
folder. Because this foldername contains a space, the value needs surrounded with escaped quotes.
Note that the first command specifies a string as **ArgumentList**. The second command is a string
array.

```powershell
Start-Process -FilePath "$env:comspec" -ArgumentList "/c dir `"%SystemDrive%\Program Files`""
Start-Process -FilePath "$env:comspec" -ArgumentList "/c","dir","`"%SystemDrive%\Program Files`""
```

### Example 8: Create a detached process on Linux

On Windows, `Start-Process` creates an independent process that remains running independently of the
launching shell. On non-Windows platforms, the newly started process is attached to the shell that
launched. If the launching shell is closed, the child process is terminated.

To avoid terminating the child process on Unix-like platforms, you can combine `Start-Process` with
`nohup`. The following example launches a background instance of PowerShell on Linux that stays
alive even after you close the launching session. The `nohup` command collects output in file
`nohup.out` in the current directory.

```powershell
# Runs for 2 minutes and appends output to ./nohup.out
Start-Process nohup 'pwsh -noprofile -c "1..120 | % { Write-Host . -NoNewline; sleep 1 }"'
```

In this example, `Start-Process` is running the Linux `nohup` command, which launches `pwsh` as a
detached process. For more information, see the [nohup](https://wikipedia.org/wiki/Nohup) article on
Wikipedia.

### Example 9: Overriding an environment variable for a process

By default, when you use `Start-Process`, the new process is created with the same environment
variables as the current session. You can use the **Environment** parameter to override the values
of those variables.

In this example, the environment variable `FOO` is added to the session with `foo` as the value.

The example runs `Start-Process` three times, returning the value of `FOO` each time. The first
command doesn't override the environment variable. In the second command, `FOO` is set to `bar`. In
the third command, `FOO` is set to `$null`, which removes it.

```powershell
$env:FOO = 'foo'
Start-Process pwsh -NoNewWindow -ArgumentList '-c', '$env:FOO'
Start-Process pwsh -NoNewWindow -ArgumentList '-c', '$env:FOO' -Environment @{
    FOO  = 'bar'
}
Start-Process pwsh -NoNewWindow -ArgumentList '-c', '$env:FOO' -Environment @{
    FOO  = $null
}
```

```Output
foo
bar

```

## PARAMETERS

### -ArgumentList

Specifies parameters or parameter values to use when this cmdlet starts the process. Arguments can
be accepted as a single string with the arguments separated by spaces, or as an array of strings
separated by commas. The cmdlet joins the array into a single string with each element of the array
separated by a single space.

The outer quotes of the PowerShell strings aren't included when the **ArgumentList** values are
passed to the new process. If parameters or parameter values contain a space or quotes, they need to
be surrounded with escaped double quotes. For more information, see
[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md).

For the best results, use a single **ArgumentList** value containing all the arguments and any
needed quote characters.

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

### -Environment

Specifies one or more environment variables to override for the process as a hash table. Specify
the name of an environment variable as a key in the hash table and the desired value. To unset an
environment variable, specify its value as `$null`.

The specified variables are replaced in the process. When you specify the `PATH` environment
variable it's replaced with the value of `$PSHOME` followed by the specified value from this
parameter. On Windows, the command appends the values for `PATH` in the Machine and User scopes
after the new value.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies the optional path and filename of the program that runs in the process. Enter the name of
an executable file or of a document, such as a `.txt` or `.doc` file, that's associated with a
program on the computer. This parameter is required.

If you specify only a filename that does not correspond to a system command, use the
**WorkingDirectory** parameter to specify the path.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PSPath, Path

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoadUserProfile

Indicates that this cmdlet loads the Windows user profile stored in the `HKEY_USERS` registry key
for the current user. The parameter doesn't apply to non-Windows systems.

This parameter doesn't affect the PowerShell profiles. For more information, see
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

Start the new process in the current console window. By default on Windows, PowerShell opens a new
window. On non-Windows systems, you never get a new window.

You can't use the **NoNewWindow** and **WindowStyle** parameters in the same command.

The parameter doesn't apply to non-Windows systems.

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

Returns a process object for each process that the cmdlet started. By default, this cmdlet doesn't
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

On Windows, when you use **UseNewEnvironment**, the new process starts only containing the default
environment variables defined for the **Machine** scope. This has the side effect that the
`$env:USERNAME` is set to **SYSTEM**. None of the variables from the **User** scope are included.

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

| File type |                     Verbs                     |
| --------- | --------------------------------------------- |
| .cmd      | `Edit`, `Open`, `Print`, `RunAs`, `RunAsUser` |
| .exe      | `Open`, `RunAs`, `RunAsUser`                  |
| .txt      | `Open`, `Print`, `PrintTo`                    |
| .wav      | `Open`, `Play`                                |

To find the verbs that can be used with the file that runs in a process, use the `New-Object` cmdlet
to create a **System.Diagnostics.ProcessStartInfo** object for the file. The available verbs are in
the **Verbs** property of the **ProcessStartInfo** object. For details, see the examples.

The parameter doesn't apply to non-Windows systems.

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

Specifies the state of the window that's used for the new process. The default value is `Normal`.
The acceptable values for this parameter are:

- `Normal`
- `Hidden`
- `Minimized`
- `Maximized`

You can't use the **WindowStyle** and **NoNewWindow** parameters in the same command.

The parameter doesn't apply to non-Windows systems. When using on non-Windows systems, you never
get a new window.

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

Specifies the location that the new process should start in.

When not specified, the cmdlet defaults to the fully-qualified location specified in the
**FilePath** parameter. If the value of the **FilePath** parameter is not fully-qualified, it
defaults to the current working directory of the calling process.

Wildcards aren't supported. The path must not contain characters that would be interpreted as
wildcards.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.Diagnostics.Process

When you use the **PassThru** parameter, this cmdlet returns a **Process** object.

## NOTES

PowerShell includes the following aliases for `Start-Process`:

- All platforms
  - `saps`
- Windows
  - `start`

Native commands are executable files installed in the operating system. These executables can be run
from any command-line shell, like PowerShell. Usually you run the command exactly as you would in
`bash` or `cmd.exe`. The `Start-Process` cmdlet can be used to run any native commands, but should
only be used when you need to control how the command is executed.

`Start-Process` is useful for running GUI programs on non-Windows platforms. For example, run
`Start-Process gedit` to launch the graphical text editor common the GNOME Desktop environments.

By default, `Start-Process` launches a process _asynchronously_. Control is instantly returned to
PowerShell even if the new process is still running.

- On the local system, the launched process lives on independent from the calling process.
- On a remote system, the new process is terminated when the remote session ends, immediately
  following the `Start-Process` command. Therefore, you can't use `Start-Process` in a remote
  session expecting the launched process to outlive the session.

If you do need to use `Start-Process` in a remote session, invoke it with the **Wait** parameter. Or
you could use other methods to create a new process on the remote system.

When using the **Wait** parameter, `Start-Process` waits for the process tree (the process and all
its descendants) to exit before returning control. This is different than the behavior of the
`Wait-Process` cmdlet, which only waits for the specified processes to exit.

On Windows, the most common use case for `Start-Process` is to use the **Wait** parameter to block
progress until the new process exits. On non-Windows system, this is rarely needed since the default
behavior for command-line applications is equivalent to `Start-Process -Wait`.

This cmdlet is implemented using the **Start** method of the **System.Diagnostics.Process**
class. For more information about this method, see
[Process.Start Method](/dotnet/api/system.diagnostics.process.start#overloads).

## RELATED LINKS

[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md)

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Service](Start-Service.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)
