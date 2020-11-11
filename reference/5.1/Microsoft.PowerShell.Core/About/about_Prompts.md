---
description: Describes the `Prompt` function and demonstrates how to create a custom `Prompt` function. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 04/15/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_prompts?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Prompts
---
# About Prompts

## Short description
Describes the `Prompt` function and demonstrates how to create a custom
`Prompt` function.

## Long description

The PowerShell command prompt indicates that PowerShell is ready to run a
command:

```
PS C:\>
```

The PowerShell prompt is determined by the built-in `Prompt` function. You can
customize the prompt by creating your own `Prompt` function and saving it in
your PowerShell profile.

## About the Prompt function

The `Prompt` function determines the appearance of the PowerShell prompt.
PowerShell comes with a built-in `Prompt` function, but you can override it by
defining your own `Prompt` function.

The `Prompt` function has the following syntax:

```powershell
function Prompt { <function-body> }
```

The `Prompt` function must return an object. As a best practice, return a
string or an object that is formatted as a string. The maximum recommended
length is 80 characters.

For example, the following `Prompt` function returns a "Hello, World" string
followed by a  right angle bracket (`>`).

```powershell
PS C:\> function prompt {"Hello, World > "}
Hello, World >
```

### Getting the Prompt function

To get the `Prompt` function, use the `Get-Command` cmdlet or use the
`Get-Item` cmdlet in the Function drive.

For example:

```powershell
PS C:\> Get-Command Prompt

CommandType     Name      ModuleName
-----------     ----      ----------
Function        prompt
```

To get the script that sets the value of the prompt, use the dot method to get
the **ScriptBlock** property of the `Prompt` function.

For example:

```powershell
(Get-Command Prompt).ScriptBlock
```

```Output
"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
# .Link
# https://go.microsoft.com/fwlink/?LinkID=225750
# .ExternalHelp System.Management.Automation.dll-help.xml
```

Like all functions, the `Prompt` function is stored in the `Function:` drive.
To display the script that creates the current `Prompt` function, type:

```powershell
(Get-Item function:prompt).ScriptBlock
```

### The default prompt

The default prompt appears only when the `Prompt` function generates an error
or does not return an object.

The default PowerShell prompt is:

```
PS>
```

For example, the following command sets the `Prompt` function to `$null`, which
is invalid. As a result, the default prompt appears.

```powershell
PS C:\> function prompt {$null}
PS>
```

Because PowerShell comes with a built-in prompt, you usually do not see the
default prompt.

### Built-in prompt

PowerShell includes a built-in `Prompt` function.

```powershell
function prompt {
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
      else { '' }) + 'PS ' + $(Get-Location) +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}
```

The function uses the `Test-Path` cmdlet to determine whether the
`$PSDebugContext` automatic variable is populated. If `$PSDebugContext` is
populated, you are in debugging mode, and `[DBG]:` is added to the prompt, as
follows:

```Output
[DBG]: PS C:\ps-test>
```

If `$PSDebugContext` is not populated, the function adds `PS` to the prompt.
And, the function uses the `Get-Location` cmdlet to get the current file system
directory location. Then, it adds a right angle bracket (`>`).

For example:

```Output
PS C:\ps-test>
```

If you are in a nested prompt, the function adds two angle brackets (`>>`) to
the prompt. (You are in a nested prompt if the value of the
`$NestedPromptLevel` automatic variable is greater than 1.)

For example, when you are debugging in a nested prompt, the prompt resembles
the following prompt:

```Output
[DBG] PS C:\ps-test>>>
```

### Changes to the prompt

The `Enter-PSSession` cmdlet prepends the name of the remote computer to the
current `Prompt` function. When you use the `Enter-PSSession` cmdlet to start a
session with a remote computer, the command prompt changes to include the name
of the remote computer. For example:

```Output
PS Hello, World> Enter-PSSession Server01
[Server01]: PS Hello, World>
```

Other PowerShell host applications and alternate shells might have their own
custom command prompts.

For more information about the `$PSDebugContext` and `$NestedPromptLevel`
automatic variables, see [about_Automatic_Variables](about_Automatic_Variables.md).

### How to customize the prompt

To customize the prompt, write a new `Prompt` function. The function is not
protected, so you can overwrite it.

To write a `Prompt` function, type the following:

```powershell
function prompt { }
```

Then, between the braces, enter the commands or the string that creates your
prompt.

For example, the following prompt includes your computer name:

```powershell
function prompt {"PS [$env:COMPUTERNAME]> "}
```

On the Server01 computer, the prompt resembles the following prompt:

```Output
PS [Server01] >
```

The following `Prompt` function includes the current date and time:

```powershell
function prompt {"$(Get-Date)> "}
```

The prompt resembles the following prompt:

```Output
03/15/2012 17:49:47>
```

You can also change the default `Prompt` function:

For example, the following modified `Prompt` function adds `[ADMIN]:` to the
built-in PowerShell prompt when PowerShell is opened by using the
**Run as administrator** option:

```powershell
function prompt {
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal] $identity
  $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

  $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
    elseif($principal.IsInRole($adminRole)) { "[ADMIN]: " }
    else { '' }
  ) + 'PS ' + $(Get-Location) +
    $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}
```

When you start PowerShell by using the **Run as administrator** option, a
prompt that resembles the following prompt appears:

```Output
[ADMIN]: PS C:\ps-test>
```

The following `Prompt` function displays the history ID of the next command. To
view the command history, use the `Get-History` cmdlet.

```powershell
function prompt {
   # The at sign creates an array in case only one history item exists.
   $history = @(Get-History)
   if($history.Count -gt 0)
   {
      $lastItem = $history[$history.Count - 1]
      $lastId = $lastItem.Id
   }

   $nextCommand = $lastId + 1
   $currentDirectory = Get-Location
   "PS: $nextCommand $currentDirectory >"
}
```

The following prompt uses the `Write-Host` and `Get-Random` cmdlets to create a
prompt that changes color randomly. Because `Write-Host` writes to the current
host application but does not return an object, this function includes a
`Return` statement. Without it, PowerShell uses the default prompt, `PS>`.

```powershell
function prompt {
    $color = Get-Random -Min 1 -Max 16
    Write-Host ("PS " + $(Get-Location) +">") -NoNewLine `
     -ForegroundColor $Color
    return " "
}
```

### Saving the Prompt function

Like any function, the `Prompt` function exists only in the current session. To
save the `Prompt` function for future sessions, add it to your PowerShell
profiles. For more information about profiles, see [about_Profiles](about_Profiles.md).

## See also

[Get-Location](xref:Microsoft.PowerShell.Management.Get-Location)

[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)

[Get-History](xref:Microsoft.PowerShell.Core.Get-History)

[Get-Random](xref:Microsoft.PowerShell.Utility.Get-Random)

[Write-Host](xref:Microsoft.PowerShell.Utility.Write-Host)

[about_Profiles](about_Profiles.md)

[about_Functions](about_Functions.md)

[about_Scopes](about_Scopes.md)

[about_Debuggers](about_Debuggers.md)

[about_Automatic_Variables](about_Automatic_Variables.md)
