---
description: >-
  How to migrate PowerShell profiles from Windows PowerShell 5.1 to
  PowerShell 7, including shared profile strategies and common pitfalls.
ms.date: 04/15/2026
title: Migrate PowerShell profiles from Windows PowerShell 5.1 to PowerShell 7
---

# Migrate PowerShell profiles from Windows PowerShell 5.1 to PowerShell 7

A PowerShell profile is a script that runs when a session starts. It sets up
your environment with aliases, functions, variables, and module imports.
Windows PowerShell 5.1 and PowerShell 7 use different profile paths, so your
existing profile doesn't carry over automatically.

This article explains the path differences and describes three strategies for
sharing or migrating your profile content.

## Profile path differences

Each PowerShell edition maintains separate profile files. The `$PROFILE`
automatic variable points to the **CurrentUser, CurrentHost** profile for the
running edition.

| Scope | Windows PowerShell 5.1 | PowerShell 7 |
| ----- | ---------------------- | ------------ |
| CurrentUser, CurrentHost | `$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` | `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` |
| CurrentUser, AllHosts | `$HOME\Documents\WindowsPowerShell\profile.ps1` | `$HOME\Documents\PowerShell\profile.ps1` |
| AllUsers, CurrentHost | `$PSHOME\Microsoft.PowerShell_profile.ps1` | `$Env:ProgramFiles\PowerShell\7\Microsoft.PowerShell_profile.ps1` |
| AllUsers, AllHosts | `$PSHOME\profile.ps1` | `$Env:ProgramFiles\PowerShell\7\profile.ps1` |

To see all profile paths for the current session:

```powershell
$PROFILE | Select-Object *Host* | Format-List
```

> [!NOTE]
> PowerShell 7 doesn't create the profile directory or file by default. You
> may need to create the directory before saving a profile:
>
> ```powershell
> New-Item -Path (Split-Path $PROFILE) -ItemType Directory -Force
> New-Item -Path $PROFILE -ItemType File -Force
> ```

## Option 1: Shared profile with edition detection

Create a single profile file and dot-source it from both Windows PowerShell
and PowerShell 7 profiles. Use the `$PSEdition` automatic variable to run
edition-specific code conditionally.

1. Create a shared profile at a location both editions can reach:

   ```powershell
   $sharedProfile = "$HOME\.powershell\shared-profile.ps1"
   New-Item -Path (Split-Path $sharedProfile) -ItemType Directory -Force
   ```

1. Add your common configuration to the shared profile. Use `$PSEdition` to
   guard edition-specific code:

   ```powershell
   # Common configuration
   Set-PSReadLineOption -PredictionSource History

   if ($PSEdition -eq 'Core') {
       # PowerShell 7 only
       Set-PSReadLineOption -PredictionViewStyle ListView
   }

   if ($PSEdition -eq 'Desktop') {
       # Windows PowerShell 5.1 only
       Import-Module PSReadLine
   }
   ```

1. Dot-source the shared profile from each edition's profile. Add this line
   to both `$PROFILE` paths:

   ```powershell
   . "$HOME\.powershell\shared-profile.ps1"
   ```

This approach keeps all profile logic in one place while allowing
edition-specific behavior.

## Option 2: Separate profiles with a shared module

Instead of sharing a profile script, put shared functions and aliases into
a PowerShell module that both editions can import.

1. Create a module directory in a path shared by both editions:

   ```powershell
   $modulePath = "$HOME\Documents\PowerShell\Modules\MyProfile"
   New-Item -Path $modulePath -ItemType Directory -Force
   ```

1. Create `MyProfile.psm1` with your shared functions:

   ```powershell
   function prompt {
       "$($executionContext.SessionState.Path.CurrentLocation)> "
   }

   Set-Alias -Name ll -Value Get-ChildItem
   ```

1. Import the module from each edition's profile:

   ```powershell
   Import-Module MyProfile
   ```

> [!NOTE]
> PowerShell 7 includes the Windows PowerShell module paths in
> `$Env:PSModulePath`, so a module installed in the PowerShell 7 user path
> is reachable from both editions. However, if the module uses features
> specific to one edition, set `CompatiblePSEditions` in the module manifest.

## Option 3: Symbolic links

Create a symbolic link from the PowerShell 7 profile path to the Windows
PowerShell profile so both editions read the same file. This requires
administrator privileges.

```powershell
$source = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$target = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

New-Item -Path (Split-Path $target) -ItemType Directory -Force
New-Item -ItemType SymbolicLink -Path $target -Target $source
```

> [!IMPORTANT]
> Symbolic links share the exact same file. If your profile contains code
> that only works in one edition (such as ISE-specific commands or snap-in
> loading), you must add `$PSEdition` guards or the profile will produce
> errors in the other edition.

## Common profile migration issues

### ISE-specific code

If your Windows PowerShell profile references `$psISE`, `$Host.Name` checks
for `Windows PowerShell ISE Host`, or ISE add-ons, those references fail in
PowerShell 7. Guard ISE-specific code:

```powershell
if ($Host.Name -eq 'Windows PowerShell ISE Host') {
    # ISE-only customization
    $psISE.Options.FontSize = 14
}
```

### Snap-in loading

PowerShell snap-ins (`Add-PSSnapin`) were removed in PowerShell 7. If your
profile loads snap-ins, replace them with module equivalents or guard with an
edition check:

```powershell
if ($PSEdition -eq 'Desktop') {
    Add-PSSnapin Microsoft.Exchange.Management.SnapIn
}
```

### PSReadLine version differences

PowerShell 7 ships a newer version of PSReadLine than Windows PowerShell
5.1. Some options and key bindings behave differently. If you set PSReadLine
options in your profile, test them in both editions. Use `Get-PSReadLineOption`
to verify available settings.

### Oh My Posh and prompt customization

[Oh My Posh][oh-my-posh] works in both editions. If you use it, the profile
initialization is the same:

```powershell
oh-my-posh init pwsh --config "$HOME/.mytheme.omp.json" | Invoke-Expression
```

### Module import errors

A profile that imports a module unavailable in PowerShell 7 causes startup
errors. Use `Get-Module -ListAvailable` to check before importing, or
wrap the import in a `try`/`catch`:

```powershell
try {
    Import-Module SomeModule -ErrorAction Stop
}
catch {
    Write-Warning "SomeModule not available in this edition."
}
```

## OneDrive and folder redirection

When your Documents folder is redirected to OneDrive (common on Windows 10
and 11), both profile paths point to cloud-synced storage. This causes:

- Sync conflicts if you edit profiles on multiple machines
- Unnecessary bandwidth for module folders inside Documents
- Slow profile loading on metered connections

To avoid these issues, store your profile or shared module outside the
OneDrive-synced path (for example, `$HOME\.powershell\`) and dot-source
from the cloud-synced profile location.

## Measure profile load time

A slow profile delays every new session. Measure load time to identify
bottlenecks:

```powershell
Measure-Command { pwsh -NoProfile -Command ". $PROFILE" }
```

Compare against a session with no profile:

```powershell
Measure-Command { pwsh -NoProfile -Command "exit" }
```

If the difference is large, review your profile for slow operations such as
unconditional module imports, network calls, or heavy initialization scripts.

## Next steps

- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Audit scripts for PowerShell 7 compatibility][script-audit]
- [Encoding changes in PowerShell 7][encoding-changes]
- [about_Profiles][about-profiles]

<!-- link references -->
[about-profiles]: /powershell/module/microsoft.powershell.core/about/about_profiles
[encoding-changes]: ./encoding-changes.md
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[oh-my-posh]: https://ohmyposh.dev/
[script-audit]: ./script-compatibility-audit.md
