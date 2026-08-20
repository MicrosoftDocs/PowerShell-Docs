---
description: >-
  Strategies for testing and resolving module compatibility issues when
  migrating from Windows PowerShell 5.1 to PowerShell 7.
ms.date: 04/15/2026
title: Module compatibility strategy for PowerShell 7
---

# Module compatibility strategy for PowerShell 7

Most Windows PowerShell 5.1 modules work in PowerShell 7 due to .NET
Standard 2.0 compatibility and the Windows PowerShell compatibility
layer. This article helps you test your module inventory, resolve
compatibility issues, and choose the right strategy for each module.

## How module loading works across editions

PowerShell 7 includes the Windows PowerShell module paths in
`$Env:PSModulePath`, so modules installed for Windows PowerShell 5.1 are
visible in PowerShell 7 sessions.

How PowerShell 7 decides whether to load a module:

- **Script modules** (`.psm1`): Load if they don't use removed cmdlets,
  snap-ins, or .NET Framework-only types.
- **Binary modules** (`.dll`): Load if they target .NET Standard 2.0,
  .NET Core, or .NET 5+. Modules targeting .NET Framework 4.x may fail
  with type-load exceptions.
- **CompatiblePSEditions** in the module manifest: If the manifest
  declares `CompatiblePSEditions = @('Desktop')` only, PowerShell 7 skips
  the module during auto-loading. You can still force-load it with
  `Import-Module -SkipEditionCheck` or use the compatibility layer.
- **Missing CompatiblePSEditions**: PowerShell 7 assumes compatibility
  and attempts to load the module.

For more information, see [about_PSModulePath][about-psmodulepath].

## Test your module inventory

Run the following script in PowerShell 7 to test which of your installed
modules load successfully:

```powershell
$results = Get-Module -ListAvailable |
    Sort-Object Name -Unique |
    ForEach-Object {
        $status = 'Compatible'
        $errorMsg = ''
        try {
            Import-Module $_.Name -ErrorAction Stop -Force
        }
        catch {
            $status = 'Incompatible'
            $errorMsg = $_.Exception.Message
        }
        [PSCustomObject]@{
            Name    = $_.Name
            Version = $_.Version
            Status  = $status
            Error   = $errorMsg
        }
    }

$results | Sort-Object Status, Name |
    Format-Table Name, Version, Status -AutoSize
```

Review the `Incompatible` entries and decide on a strategy for each one.

## The Windows PowerShell compatibility layer

### How it works

The `Import-Module -UseWindowsPowerShell` switch (available in
PowerShell 7 on Windows) creates a hidden WinRM loopback session to
Windows PowerShell 5.1 and generates proxy functions for the module's
exported commands. When you call a proxy function, the command runs in
the Windows PowerShell session and the results are serialized back to
your PowerShell 7 session.

```powershell
Import-Module ActiveDirectory -UseWindowsPowerShell
Get-ADUser -Filter * -ResultSetSize 10
```

For more information, see
[about_Windows_PowerShell_Compatibility][about-compat].

### When to use it

Use the compatibility layer when:

- The module has no PowerShell 7-native equivalent
- The module loads .NET Framework-only assemblies
- The module uses WMI provider interfaces (such as the DISM module)
- You need a temporary bridge while planning a full migration

### Known limitations

The compatibility layer has several known issues that affect long-running
sessions and specific scenarios:

- **Performance overhead**: Every command call goes through WinRM
  serialization and deserialization, which is slower than a native call.
- **Object fidelity loss**: Objects cross a remoting boundary. Rich .NET
  objects become deserialized `PSObject` instances with limited methods
  and no live .NET type information.
- **Memory accumulation**: In long-running sessions, the hidden session
  accumulates memory that isn't freed on `Remove-Module`. For details,
  see [PowerShell/PowerShell#21097][issue-21097].
- **Temp file accumulation**: The proxy generates `remoteIpMoProxy_*`
  files in `$Env:TEMP`. In scheduled tasks or long-running services,
  these files can grow to millions. For details, see
  [PowerShell/PowerShell#13198][issue-13198].
- **Bracket characters in paths**: After loading a compatibility module,
  `Set-Content -LiteralPath` with `[` or `]` characters may fail. For
  details, see [PowerShell/PowerShell#24541][issue-24541].
- **WinRM must be enabled**: The compatibility layer uses a local WinRM
  loopback session. Run `Enable-PSRemoting` if WinRM isn't already
  configured.

### Clean up temp files

If you use the compatibility layer in scheduled tasks or services, clean
up proxy files periodically:

```powershell
Get-ChildItem -Path $Env:TEMP -Filter 'remoteIpMoProxy_*' |
    Where-Object {
        $_.LastWriteTime -lt (Get-Date).AddDays(-1)
    } |
    Remove-Item -Force
```

## PSModulePath conflicts

### OneDrive document redirection

On Windows 10 and 11, the Documents folder is often redirected to
OneDrive. This means your user module path
(`$HOME\Documents\PowerShell\Modules`) is synced to the cloud. Large
module folders (Az PowerShell: 53 MB+, AWS Tools: 81 MB+) consume
OneDrive storage quota and sync bandwidth.

For more background, see
[PowerShell/PowerShell#15552][issue-15552].

**Workaround:** Redirect the user module path to local storage in your
PowerShell 7 profile:

```powershell
$localModules = "$Env:LOCALAPPDATA\PowerShell\Modules"
if (-not (Test-Path $localModules)) {
    New-Item -Path $localModules -ItemType Directory -Force
}
$Env:PSModulePath = $localModules + ';' + $Env:PSModulePath
```

### Corporate folder redirection

Group Policy-based folder redirection to a network share causes the same
issue, with the additional risk of slow module loading over the network.
Use the same workaround pattern to redirect the user module path to a
local directory.

## Strategies by module type

### Microsoft-published modules

The following Microsoft modules have native PowerShell 7 support:

| Module | Minimum PowerShell version |
| ------ | ------------------------- |
| Az (Azure PowerShell) | 7.0.6 LTS |
| Microsoft.Graph | 7.0 |
| ExchangeOnlineManagement (V3) | 7.0.3 |
| SqlServer | 5.0 (works in both editions) |

For the full list, see [PowerShell 7 module compatibility][module-compat].

### Windows management modules

Windows ships management modules for system features. Their PowerShell 7
compatibility varies:

| Module | PowerShell 7 status |
| ------ | ------------------- |
| ActiveDirectory | Works natively (RSAT required) |
| GroupPolicy | Partial (some cmdlets fail); use compatibility layer |
| DISM | Fails natively ("Class not registered"); use compatibility layer |
| ScheduledTasks | Works natively |
| Hyper-V | Works natively |
| NetAdapter | Works natively |
| Storage | Works natively |
| Defender | Works natively |

> [!NOTE]
> The DISM module is the most common compatibility issue. The
> `Get-WindowsCapability` and `Get-WindowsOptionalFeature` cmdlets
> require .NET Framework COM interop that isn't available in .NET Core.
> Use `Import-Module DISM -UseWindowsPowerShell` or run these cmdlets
> in Windows PowerShell 5.1 directly.

### Third-party and custom modules

For modules not listed above:

1. **Try importing** the module in PowerShell 7 and test its commands.
1. **Check the module manifest** for `CompatiblePSEditions`. If it lists
   only `Desktop`, the module was designed for Windows PowerShell.
1. **Check binary module targets**: If the module includes a `.dll`, use
   `[Reflection.AssemblyName]::GetAssemblyName($dllPath)` to check the
   target framework. Assemblies targeting `.NETFramework` may not load.
1. **Use the compatibility layer** as a fallback.
1. **Contact the module author** or check for a newer version that
   supports PowerShell 7.

## Create cross-edition modules

If you maintain your own modules and need them to work in both Windows
PowerShell 5.1 and PowerShell 7:

### Set CompatiblePSEditions

Declare both editions in the module manifest:

```powershell
@{
    RootModule           = 'MyModule.psm1'
    ModuleVersion        = '1.0.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    PowerShellVersion    = '5.1'
}
```

### Target .NET Standard 2.0 for binary modules

If the module includes compiled C# code, target .NET Standard 2.0
in the project file:

```xml
<TargetFramework>netstandard2.0</TargetFramework>
```

.NET Standard 2.0 assemblies load in both .NET Framework 4.6.1+ and
.NET Core 2.0+.

### Use conditional logic for edition differences

Use the `$PSEdition` automatic variable to handle edition-specific logic
in script modules:

```powershell
if ($PSEdition -eq 'Core') {
    # PowerShell 7 code path
}
else {
    # Windows PowerShell 5.1 code path
}
```

## Next steps

- [Audit scripts for PowerShell 7 compatibility][script-audit]
- [Encoding changes in PowerShell 7][encoding-changes]
- [PowerShell 7 module compatibility][module-compat]
- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]

<!-- link references -->
[about-compat]: /powershell/module/Microsoft.PowerShell.Core/About/about_windows_powershell_compatibility
[about-psmodulepath]: /powershell/module/microsoft.powershell.core/about/about_psmodulepath
[encoding-changes]: ./encoding-changes.md
[issue-13198]: https://github.com/PowerShell/PowerShell/issues/13198
[issue-15552]: https://github.com/PowerShell/PowerShell/issues/15552
[issue-21097]: https://github.com/PowerShell/PowerShell/issues/21097
[issue-24541]: https://github.com/PowerShell/PowerShell/issues/24541
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[module-compat]: ../module-compatibility.md
[script-audit]: ./script-compatibility-audit.md
