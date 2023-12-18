---
description: >
  This article shows how to run commands in PowerShell.
title: Running commands in the shell
ms.date: 08/22/2022
---
# Running commands in the shell

PowerShell is a command-line shell and a scripting language used for automation. Similar to other
shells, like `bash` on Linux or the Windows Command Shell (`cmd.exe`), PowerShell lets you to run
any command available on your system, not just PowerShell commands.

## Types of commands

For any shell in any operating system there are three types of commands:

- **Shell language keywords** are part of the shell's scripting language.

  - Examples of `bash` keywords include: `if`, `then`, `else`, `elif`, and `fi`.
  - Examples of `cmd.exe` keywords include: `dir`, `copy`, `move`, `if`, and `echo`.
  - Examples of PowerShell keywords include: `for`, `foreach`, `try`, `catch`, and `trap`.

  Shell language keywords can only be used within the runtime environment of the shell. There is no
  executable file, external to the shell, that provides the keyword's functionality.

- **OS-native commands** are executable files installed in the operating system. The executables can
  be run from any command-line shell, like PowerShell. This includes script files that may require
  other shells to work properly. For example, if you run a Windows batch script (`.cmd` file) in
  PowerShell, PowerShell runs `cmd.exe` and passes in the batch file for execution.

- **Shell environment-specific commands** are commands defined in external files that can only be
  used within the runtime environment of the shell. These include scripts and functions, or they can
  be specially compiled modules that add commands to the shell runtime. In PowerShell, these
  commands are known as _cmdlets_ (pronounced "command-lets").

## Running native commands

Any native command can be run from the PowerShell command line. Usually you run the command exactly
as you would in `bash` or `cmd.exe`. The following example shows running the `grep` command in
`bash` on Ubuntu Linux.

```bash
sdwheeler@circumflex:~$ grep sdwheeler /etc/passwd
sdwheeler:x:1000:1000:,,,:/home/sdwheeler:/bin/bash
sdwheeler@circumflex:~$ pwsh
PowerShell 7.2.6
Copyright (c) Microsoft Corporation.

https://aka.ms/powershell
Type 'help' to get help.
```

After starting PowerShell on Ubuntu, you can run the same command from the PowerShell command line:

```powershell
PS /home/sdwheeler> grep sdwheeler /etc/passwd
sdwheeler:x:1000:1000:,,,:/home/sdwheeler:/bin/bash
```

### Passing arguments to native commands

Most shells include features for using variables, evaluating expressions, and handling strings. But
each shell does these things differently. In PowerShell, all parameters start with a hyphen (`-`)
character. In `cmd.exe`, most parameters use a slash (`/`) character. Other command-line tools may
not have a special character for parameters.

Each shell has its own way of handling and evaluating strings on the command line. When running
native commands in PowerShell that expect strings to be quoted in a specific way, you may need
adjust how you pass those strings.

For more information, see the following articles:

- [about_Parsing][1]
- [about_Quoting_Rules][2]

PowerShell 7.2 introduced a new experimental feature `PSnativeCommandArgumentPassing` that improved
native command handling. For more information, see [PSnativeCommandArgumentPassing][3].

### Handling output and errors

PowerShell also has several more output streams than other shells. The `bash` and `cmd.exe` shells
have **stdout** and **stderr**. PowerShell has six output streams. For more information, see
[about_Redirection][4] and [about_Output_Streams][5].

In general, the output sent to **stdout** by a native command is sent to the **Success** stream in
PowerShell. Output sent to **stderr** by a native command is sent to the **Error** stream in
PowerShell.

When a native command has a non-zero exit code, `$?` is set to `$false`. If the exit code is zero,
`$?` is set to `$true`.

However, this changed in PowerShell 7.2. Error records redirected from native commands, like when
using redirection operators (`2>&1`), aren't written to PowerShell's `$Error` variable and the
preference variable `$ErrorActionPreference` doesn't affect the redirected output.

Many native commands write to **stderr** as an alternative stream for additional information. This
behavior can cause confusion in PowerShell when looking through errors and the additional output
information can be lost if `$ErrorActionPreference` is set to a state that mutes the output.

PowerShell 7.3 added a new experimental feature `PSnativeCommandErrorActionPreference` that allows
you to control whether output to `stderr` is treated as an error. For more information, see
[PSnativeCommandErrorActionPreference][6].

## Running PowerShell commands

As previously noted, PowerShell commands are known as cmdlets. Cmdlets are collected into PowerShell
modules that can be loaded on demand. Cmdlets can be written in any compiled .NET language or using
the PowerShell scripting language itself.

### PowerShell commands that run other commands

The PowerShell **call operator** (`&`) lets you run commands that are stored in variables and
represented by strings or script blocks. You can use this to run any native command or PowerShell
command. This is useful in a script when you need to dynamically construct the command-line
parameters for a native command. For more information, see the [call operator][7].

The `Start-Process` cmdlet can be used to run native commands, but should only be used when you need
to control how the command is executed. The cmdlet has parameters to support the following
scenarios:

- Run a command using different credentials
- Hide the console window created by the new process
- Redirect **stdin**, **stdout**, and **stderr** streams
- Use a different working directory for the command

The following example runs the native command `sort.exe` with redirected input and output streams.

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

For more information, see [Start-Process][8].

On Windows, the `Invoke-Item` cmdlet performs the default action for the specified item. For
example, it runs an executable file or opens a document file using the application associated with
the document file type. The default action depends on the type of item and is resolved by the
PowerShell provider that provides access to the item.

The following example opens the PowerShell source code repository in your default web browser.

```powershell
Invoke-Item https://github.com/PowerShell/PowerShell
```

For more information, see [Invoke-Item][9].

<!-- link references -->
[1]: /powershell/module/microsoft.powershell.core/about/about_parsing#passing-arguments-to-native
[2]: /powershell/module/microsoft.powershell.core/about/about_quoting_rules
[3]: ../experimental-features.md#psnativecommandargumentpassing
[4]: /powershell/module/microsoft.powershell.core/about/about_redirection
[5]: /powershell/module/microsoft.powershell.core/about/about_output_streams
[6]: ../experimental-features.md#psnativecommanderroractionpreference
[7]: /powershell/module/microsoft.powershell.core/about/about_operators#call-operator-
[8]: /powershell/module/microsoft.powershell.management/start-process
[9]: /powershell/module/microsoft.powershell.management/invoke-item
