---
description: >-
  Deploy PowerShell 7 across enterprise environments using MSI, SCCM, Intune,
  winget, and Group Policy, including air-gapped network considerations.
ms.date: 04/15/2026
title: Deploy PowerShell 7 in enterprise environments
---

# Deploy PowerShell 7 in enterprise environments

This article covers deployment methods, network considerations, Group Policy
configuration, and coexistence planning for organizations migrating from
Windows PowerShell 5.1 to PowerShell 7.

## Deployment methods

### MSI package

The MSI package is the recommended method for enterprise deployment. It
supports silent installation, Group Policy Software Installation, Microsoft
Configuration Manager (SCCM), and Microsoft Intune.

```powershell
msiexec.exe /i PowerShell-7.5.4-win-x64.msi /quiet /norestart `
    ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 `
    ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 `
    ENABLE_PSREMOTING=1 `
    REGISTER_MANIFEST=1 `
    USE_MU=1 `
    ENABLE_MU=1 `
    ADD_PATH=1
```

Key MSI properties:

| Property | Effect |
| -------- | ------ |
| `ENABLE_PSREMOTING=1` | Enable WinRM remoting during install |
| `REGISTER_MANIFEST=1` | Register Windows Event Logging manifest |
| `USE_MU=1` | Enable checking for updates via Microsoft Update |
| `ENABLE_MU=1` | Opt in to Microsoft Update |
| `ADD_PATH=1` | Add PowerShell 7 to the system `PATH` |

> [!NOTE]
> Download MSI packages from the
> [PowerShell GitHub Releases page][gh-releases]. Choose the `-win-x64.msi`
> package for 64-bit Windows or `-win-x86.msi` for 32-bit environments.

### Microsoft Configuration Manager (SCCM)

Deploy the MSI as an application in SCCM:

1. Create a new application with the MSI as the deployment type
1. Set the install command to the silent install string shown above
1. Create a detection rule for `$Env:ProgramFiles\PowerShell\7\pwsh.exe`
1. Deploy to the target device collection

### Microsoft Intune

For Intune-managed devices:

1. Upload the MSI as a **Line-of-business app** in the Intune portal
1. Set command-line arguments for silent install
1. Configure the detection rule to check for `pwsh.exe` in the install
   directory
1. Assign the app to device groups

### winget

For developer workstations and environments where winget is available:

```powershell
winget install --id Microsoft.PowerShell --source winget --silent
```

> [!NOTE]
> winget is available on Windows 10 1809 and later, Windows 11, and Windows
> Server 2025 (Desktop Experience). For Server Core or earlier Windows Server
> versions, use the MSI package.

### ZIP package

The ZIP package doesn't require administrator privileges and is useful for:

- Testing before committing to a full installation
- Environments where MSI deployment is restricted
- Running multiple PowerShell 7 versions side by side
- Nano Server and IoT deployments

Extract the ZIP to a directory and add it to `PATH` manually or run
`pwsh.exe` from the extracted location.

## Network considerations

### Air-gapped and restricted networks

PowerShell 7 makes network calls during startup for update checks and
certificate revocation list (CRL) validation. On air-gapped or restricted
networks, these calls time out and can delay startup by 6 to 10 seconds.

To resolve startup delays on isolated networks:

1. **Disable update notifications** by setting an environment variable:

   ```powershell
   [Environment]::SetEnvironmentVariable(
       'POWERSHELL_UPDATECHECK', 'Off', 'Machine'
   )
   ```

1. **Disable telemetry** if not needed:

   ```powershell
   [Environment]::SetEnvironmentVariable(
       'POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine'
   )
   ```

1. **Configure CRL caching** to avoid repeated timeout delays. If your
   environment blocks `ctldl.windowsupdate.com`, configure a local CRL
   distribution point or disable CRL checking for the PowerShell certificate
   chain through Group Policy.

For more background on this issue, see
[PowerShell/PowerShell#10983][issue-10983].

### Proxy configuration

If your network requires a proxy for internet access, configure the proxy
for PowerShell module management:

```powershell
[System.Net.WebRequest]::DefaultWebProxy = New-Object `
    System.Net.WebProxy('http://proxy.corp:8080')
[System.Net.WebRequest]::DefaultWebProxy.Credentials = `
    [System.Net.CredentialCache]::DefaultCredentials
```

For persistent configuration, add the proxy settings to the AllUsers profile
or set the `HTTP_PROXY` and `HTTPS_PROXY` environment variables.

### Microsoft Update integration

PowerShell 7.2 and later supports updates through Microsoft Update and
Windows Server Update Services (WSUS). Enable this during install with the
`USE_MU=1` and `ENABLE_MU=1` MSI properties, or configure it after
installation through Windows Update settings.

## Group Policy configuration

PowerShell 7 ships its own Group Policy templates, separate from Windows
PowerShell 5.1. If you use Group Policy to manage PowerShell settings, you
must configure policies for both editions during the migration period.

### Install policy templates

PowerShell 7 includes `.admx` and `.adml` files in `$PSHOME`. Copy them to
the Group Policy central store or install locally:

```powershell
& "$PSHOME\InstallPSCorePolicyDefinitions.ps1"
```

### Supported policy settings

| Setting | Description |
| ------- | ----------- |
| Console session configuration | Set the configuration endpoint for PowerShell sessions |
| Module Logging | Log pipeline execution details for specified modules |
| Script Block Logging | Log the content of all script blocks that are processed |
| Script Execution | Set the execution policy |
| Transcription | Capture input and output to text-based transcripts |
| Default source path for `Update-Help` | Redirect help updates to a local share |

> [!IMPORTANT]
> Group Policy settings for PowerShell 7 are stored in a different registry
> path than Windows PowerShell 5.1. Existing GPOs for Windows PowerShell
> don't apply to PowerShell 7 automatically. You must create separate GPOs
> or duplicate settings in both policy templates.

For more information, see [about_Group_Policy_Settings][about-gpo].

## Coexistence planning

### Timeline

Plan for a parallel-run period where both editions handle production
workloads. A typical migration timeline:

1. **Weeks 1-2**: Install PowerShell 7, test scripts and modules
1. **Weeks 3-4**: Migrate non-critical automation (dev/test environments)
1. **Weeks 5-8**: Migrate production automation with monitoring
1. **Ongoing**: Maintain both editions until all workloads are validated

### Default shell selection

PowerShell 7 can be set as the default shell in several contexts:

- **Windows Terminal**: Set the default profile to PowerShell 7 in
  Terminal settings
- **OpenSSH**: Set `pwsh.exe` as the default shell for SSH connections:

  ```powershell
  New-ItemProperty -Path 'HKLM:\SOFTWARE\OpenSSH' `
      -Name DefaultShell `
      -Value "$Env:ProgramFiles\PowerShell\7\pwsh.exe" `
      -PropertyType String -Force
  ```

- **WinRM remoting**: Run `Enable-PSRemoting` in PowerShell 7 to register
  the `PowerShell.7` endpoint. Remote sessions still default to the Windows
  PowerShell endpoint unless the caller specifies
  `-ConfigurationName PowerShell.7`.

### PATH order

When both editions are installed, the system `PATH` determines which
`powershell.exe` or `pwsh.exe` is found first. The MSI installer adds
PowerShell 7 to `PATH` automatically. Verify the order:

```powershell
$Env:PATH -split ';' | Where-Object { $_ -match 'PowerShell' }
```

## CI/CD pipeline updates

Update your CI/CD pipelines to use PowerShell 7:

### Azure DevOps

In Azure Pipelines, use the `pwsh` task instead of `powershell`:

```yaml
- pwsh: |
    Write-Host "Running in PowerShell 7"
  displayName: 'Run PowerShell 7 script'
```

### GitHub Actions

GitHub-hosted runners include PowerShell 7. Specify the shell:

```yaml
- name: Run script
  shell: pwsh
  run: |
    Write-Host "Running in PowerShell 7"
```

## Next steps

- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Migrate scheduled tasks and automation][scheduled-tasks]
- [Test and validate your PowerShell 7 migration][testing-rollback]
- [Installing PowerShell on Windows][install-windows]

<!-- link references -->
[about-gpo]: /powershell/module/microsoft.powershell.core/about/about_group_policy_settings
[gh-releases]: https://github.com/PowerShell/PowerShell/releases
[install-windows]: ../../install/installing-powershell-on-windows.md
[issue-10983]: https://github.com/PowerShell/PowerShell/issues/10983
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[scheduled-tasks]: ./scheduled-tasks-automation.md
[testing-rollback]: ./testing-and-rollback.md
