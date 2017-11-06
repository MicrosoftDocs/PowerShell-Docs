---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Using Variables to Store Objects
ms.assetid:  b1688d73-c173-491e-9ba6-6d0c1cc852de
---

# Using Variables to Store Objects
PowerShell works with objects. PowerShell lets you create variables, essentially named objects, to preserve output for later use. If you are used to working with variables in other shells remember that PowerShell variables are objects, not text.

Variables are always specified with the initial character $, and can include any alphanumeric characters or the underscore in their names.

### Creating a Variable
You can create a variable by typing a valid variable name:

```
PS> $loc
PS>
```

This returns no result because **$loc** does not have a value. You can create a variable and assign it a value in the same step. PowerShell only creates the variable if it does not exist; otherwise, it assigns the specified value to the existing variable. To store your current location in the variable **$loc**, type:

```
$loc = Get-Location
```

There is no output displayed when you type this command because the output is sent to $loc. In PowerShell, displayed output is a side effect of the fact that data, which is not otherwise directed, always gets sent to the screen. Typing $loc will show your current location:

```
PS> $loc

Path
----
C:\temp
```

You can use **Get-Member** to display information about the contents of variables. Piping $loc to Get-Member will show you that it is a **PathInfo** object, just like the output from Get-Location:

```
PS> $loc | Get-Member -MemberType Property

   TypeName: System.Management.Automation.PathInfo

Name         MemberType Definition
----         ---------- ----------
Drive        Property   System.Management.Automation.PSDriveInfo Drive {get;}
Path         Property   System.String Path {get;}
Provider     Property   System.Management.Automation.ProviderInfo Provider {...
ProviderPath Property   System.String ProviderPath {get;}
```

### Manipulating Variables
PowerShell provides several commands to manipulate variables. You can see a complete listing in a readable form by typing:

```
Get-Command -Noun Variable | Format-Table -Property Name,Definition -AutoSize -Wrap
```

In addition to the variables you create in your current PowerShell session, there are several system-defined variables. You can use the **Remove-Variable** cmdlet to clear out all of the variables which are not controlled by PowerShell. Type the following command to clear all variables:

```
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
```

This will produce the confirmation prompt you see below.

```
Confirm
Are you sure you want to perform this action?
Performing operation "Remove Variable" on Target "Name: Error".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):A
```

If you then run the **Get-Variable** cmdlet, you will see the remaining PowerShell variables. Since there is also a variable PowerShell drive, you can also display all PowerShell variables by typing:

```
Get-ChildItem variable:
```

### Using Cmd.exe Variables
Although PowerShell is not Cmd.exe, it runs in a command shell environment and can use the same variables available in any environment in Windows. These variables are exposed through a drive named **env**:. You can view these variables by typing:

```
Get-ChildItem env:
```

Although the standard variable cmdlets are not designed to work with **env:** variables, you can still use them by specifying the **env:** prefix. For example, to see the operating system root directory, you can use the command-shell **%SystemRoot%** variable from within PowerShell by typing:

```
PS> $env:SystemRoot
C:\WINDOWS
```

You can also create and modify environment variables from within PowerShell. Environment variables accessed from Windows PowerShell conform to the normal rules for environment variables elsewhere in Windows.

