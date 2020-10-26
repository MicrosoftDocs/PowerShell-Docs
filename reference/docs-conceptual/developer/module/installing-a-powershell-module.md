---
ms.date: 09/13/2016
ms.topic: reference
title: Installing a PowerShell Module
description: Installing a PowerShell Module
---
# Installing a PowerShell Module

After you have created your PowerShell module, you will likely want to install the module on a
system, so that you or others may use it. Generally speaking, this consists of copying the module
files (ie, the .psm1, or the binary assembly, the module manifest, and any other associated files)
onto a directory on that computer. For a very small project, this may be as simple as copying and
pasting the files with Windows Explorer onto a single remote computer; however, for larger solutions
you may wish to use a more sophisticated installation process. Regardless of how you get your module
onto the system, PowerShell can use a number of techniques that will let users find and use your
modules. Therefore, the main issue for installation is ensuring that PowerShell will be able to find
your module. For more information, see [Importing a PowerShell Module](./importing-a-powershell-module.md).

## Rules for Installing Modules

The following information pertains to all modules, including modules that you create for your own
use, modules that you get from other parties, and modules that you distribute to others.

### Install Modules in PSModulePath

Whenever possible, install all modules in a path that is listed in the **PSModulePath** environment
variable or add the module path to the **PSModulePath** environment variable value.

The **PSModulePath** environment variable ($Env:PSModulePath) contains the locations of Windows
PowerShell modules. Cmdlets rely on the value of this environment variable to find modules.

By default, the **PSModulePath** environment variable value contains the following system and user
module directories, but you can add to and edit the value.

- `$PSHome\Modules` (%Windir%\System32\WindowsPowerShell\v1.0\Modules)

  > [!WARNING]
  > This location is reserved for modules that ship with Windows. Do not install modules to this
  > location.

- `$Home\Documents\WindowsPowerShell\Modules` (%UserProfile%\Documents\WindowsPowerShell\Modules)

- `$Env:ProgramFiles\WindowsPowerShell\Modules` (%ProgramFiles%\WindowsPowerShell\Modules)

  To get the value of the **PSModulePath** environment variable, use either of the following
  commands.

  ```powershell
  $Env:PSModulePath
  [Environment]::GetEnvironmentVariable("PSModulePath")
  ```

  To add a module path to value of the **PSModulePath** environment variable value, use the
  following command format. This format uses the **SetEnvironmentVariable** method of the
  **System.Environment** class to make a session-independent change to the **PSModulePath**
  environment variable.

  ```powershell
  #Save the current value in the $p variable.
  $p = [Environment]::GetEnvironmentVariable("PSModulePath")

  #Add the new path to the $p variable. Begin with a semi-colon separator.
  $p += ";C:\Program Files (x86)\MyCompany\Modules\"

  #Add the paths in $p to the PSModulePath value.
  [Environment]::SetEnvironmentVariable("PSModulePath",$p)

  ```

  > [!IMPORTANT]
  > Once you have added the path to **PSModulePath**, you should broadcast an environment message
  > about the change. Broadcasting the change allows other applications, such as the shell, to pick
  > up the change. To broadcast the change, have your product installation code send a
  > **WM_SETTINGCHANGE** message with `lParam` set to the string "Environment". Be sure to send the
  > message after your module installation code has updated **PSModulePath**.

### Use the Correct Module Directory Name

A well-formed module is a module that is stored in a directory that has the same name as the base
name of at least one file in the module directory. If a module is not well-formed, Windows
PowerShell does not recognize it as a module.

The "base name" of a file is the name without the file name extension. In a well-formed module, the
name of the directory that contains the module files must match the base name of at least one file
in the module.

For example, in the sample Fabrikam module, the directory that contains the module files is named
"Fabrikam" and at least one file has the "Fabrikam" base name. In this case, both Fabrikam.psd1 and
Fabrikam.dll have the "Fabrikam" base name.

```
C:\Program Files
  Fabrikam Technologies
    Fabrikam Manager
      Modules
        Fabrikam
          Fabrikam.psd1 (module manifest)
          Fabrikam.dll (module assembly)

```

### Effect of Incorrect Installation

If the module is not well-formed and its location is not included in the value of the
**PSModulePath** environment variable, basic discovery features of Windows PowerShell, such as the
following, do not work.

- The Module Auto-Loading feature cannot import the module automatically.

- The `ListAvailable` parameter of the [Get-Module](/powershell/module/Microsoft.PowerShell.Core/Get-Module)
  cmdlet cannot find the module.

- The [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) cmdlet cannot find
  the module. To import the module, you must provide the full path to the root module file or module
  manifest file.

  Additional features, such as the following, do not work unless the module is imported into the
  session. In well-formed modules in the **PSModulePath** environment variable, these features work
  even when the module is not imported into the session.

- The [Get-Command](/powershell/module/Microsoft.PowerShell.Core/Get-Command) cmdlet cannot find
  commands in the module.

- The [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) and [Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help)
  cmdlets cannot update or save help for the module.

- The [Show-Command](/powershell/module/Microsoft.PowerShell.Utility/Show-Command) cmdlet cannot
  find and display the commands in the module.

  The commands in the module are missing from the `Show-Command` window in Windows PowerShell
  Integrated Scripting Environment (ISE).

## Where to Install Modules

This section explains where in the file system to install Windows PowerShell modules. The location
depends on how the module is used.

### Installing Modules for a Specific User

If you create your own module or get a module from another party, such as a Windows PowerShell
community website, and you want the module to be available for your user account only, install the
module in your user-specific Modules directory.

`$home\Documents\WindowsPowerShell\Modules\<Module Folder>\<Module Files>`

The user-specific Modules directory is added to the value of the **PSModulePath** environment
variable by default.

### Installing Modules for all Users in Program Files

If you want a module to be available to all user accounts on the computer, install the module in the
Program Files location.

`$Env:ProgramFiles\WindowsPowerShell\Modules\<Module Folder>\<Module Files>`

> [!NOTE]
> The Program Files location is added to the value of the PSModulePath environment variable by
> default in Windows PowerShell 4.0 and later. For earlier versions of Windows PowerShell, you can
> manually create the Program Files location (%ProgramFiles%\WindowsPowerShell\Modules) and add
> this path to your PSModulePath environment variable as described above.

### Installing Modules in a Product Directory

If you are distributing the module to other parties, use the default Program Files location
described above, or create your own company-specific or product-specific subdirectory of the
%ProgramFiles% directory.

For example, Fabrikam Technologies, a fictitious company, is shipping a Windows PowerShell module
for their Fabrikam Manager product. Their module installer creates a Modules subdirectory in the
Fabrikam Manager product subdirectory.

```
C:\Program Files
  Fabrikam Technologies
    Fabrikam Manager
      Modules
        Fabrikam
          Fabrikam.psd1 (module manifest)
          Fabrikam.dll (module assembly)

```

To enable the Windows PowerShell module discovery features to find the Fabrikam module, the Fabrikam
module installer adds the module location to the value of the **PSModulePath** environment variable.

```powershell
$p = [Environment]::GetEnvironmentVariable("PSModulePath")
$p += ";C:\Program Files\Fabrikam Technologies\Fabrikam Manager\Modules\"
[Environment]::SetEnvironmentVariable("PSModulePath",$p)
```

### Installing Modules in the Common Files Directory

If a module is used by multiple components of a product or by multiple versions of a product,
install the module in a module-specific subdirectory of the %ProgramFiles%\Common Files\Modules
subdirectory.

In the following example, the Fabrikam module is installed in a Fabrikam subdirectory of the
`%ProgramFiles%\Common Files\Modules` subdirectory. Note that each module resides in its own
subdirectory in the Modules subdirectory.

```
C:\Program Files
  Common Files
    Modules
      Fabrikam
        Fabrikam.psd1 (module manifest)
        Fabrikam.dll (module assembly)
```

Then, the installer assures the value of the **PSModulePath** environment variable includes the path
of the common files modules subdirectory.

```powershell
$m = $env:ProgramFiles + '\Common Files\Modules'
$p = [Environment]::GetEnvironmentVariable("PSModulePath")
$q = $p -split ';'
if ($q -notContains $m) {
    $q += ";$m"
}
$p = $q -join ';'
[Environment]::SetEnvironmentVariable("PSModulePath", $p)
```

## Installing Multiple Versions of a Module

To install multiple versions of the same module, use the following procedure.

1. Create a directory for each version of the module. Include the version number in the directory
   name.
2. Create a module manifest for each version of the module. In the value of the **ModuleVersion**
   key in the manifest, enter the module version number. Save the manifest file (.psd1) in the
   version-specific directory for the module.
3. Add the module root folder path to the value of the **PSModulePath** environment variable, as
   shown in the following examples.

To import a particular version of the module, the end-user can use the `MinimumVersion` or
`RequiredVersion` parameters of the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
cmdlet.

For example, if the Fabrikam module is available in versions 8.0 and 9.0, the Fabrikam module
directory structure might resemble the following.

 ```
C:\Program Files
Fabrikam Manager
  Fabrikam8
    Fabrikam
      Fabrikam.psd1 (module manifest: ModuleVersion = "8.0")
      Fabrikam.dll (module assembly)
  Fabrikam9
    Fabrikam
      Fabrikam.psd1 (module manifest: ModuleVersion = "9.0")
      Fabrikam.dll (module assembly)
```

The installer adds both of the module paths to the **PSModulePath** environment variable value.

```powershell
$p = [Environment]::GetEnvironmentVariable("PSModulePath")
$p += ";C:\Program Files\Fabrikam\Fabrikam8;C:\Program Files\Fabrikam\Fabrikam9"
[Environment]::SetEnvironmentVariable("PSModulePath",$p)
```

When these steps are complete, the **ListAvailable** parameter of the [Get-Module](/powershell/module/Microsoft.PowerShell.Core/Get-Module)
cmdlet gets both of the Fabrikam modules. To import a particular module, use the `MinimumVersion` or
`RequiredVersion` parameters of the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
cmdlet.

If both modules are imported into the same session, and the modules contain cmdlets with the same
names, the cmdlets that are imported last are effective in the session.

## Handling Command Name Conflicts

Command name conflicts can occur when the commands that a module exports have the same name as
commands in the user's session.

When a session contains two commands that have the same name, Windows PowerShell runs the command
type that takes precedence. When a session contains two commands that have the same name and the
same type, Windows PowerShell runs the command that was added to the session most recently. To run a
command that is not run by default, users can qualify the command name with the module name.

For example, if the session contains a `Get-Date` function and the `Get-Date` cmdlet, Windows
PowerShell runs the function by default. To run the cmdlet, preface the command with the module
name, such as:

```powershell
Microsoft.PowerShell.Utility\Get-Date
```

To prevent name conflicts, module authors can use the **DefaultCommandPrefix** key in the module
manifest to specify a noun prefix for all commands exported from the module.

Users can use the **Prefix** parameter of the `Import-Module` cmdlet to use an alternate prefix. The
value of the **Prefix** parameter takes precedence over the value of the **DefaultCommandPrefix**
key.

## See Also

[about_Command_Precedence](/powershell/module/microsoft.powershell.core/about/about_command_precedence)

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
