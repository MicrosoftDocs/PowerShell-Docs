---
description: This article explains how to secure a restricted PowerShell session that is used for secure remote access.
ms.date: 10/10/2023
title: Securing a restricted PowerShell remoting session
---
# Securing a restricted PowerShell remoting session

There are scenarios where you want to host a PowerShell session that, for security reasons, has been
limited to a subset of PowerShell commands.

By definition, a restricted session is one where `Import-Module` isn't allowed to be used. There may
be other limitations, but this is the primary requirement. If the user can import a module, then
they can run anything they want.

Examples of restricted sessions include:

- Just-Enough-Administration (JEA)
- Custom restricted remoting implementations such as the Exchange and Teams modules

For most system administrators, JEA provides the best experience for creating restricted sessions
and should be your first choice. For more information about JEA, see the [JEA Overview][01].

## Recommendations for custom session implementations

If your scenario requires a custom implementation, then you should follow these recommendations.

### Limit the use and capabilities of PowerShell providers

Review how the allowed providers are used to ensure that you don't create vulnerabilities in your
restricted session implementation.

> [!WARNING]
> Don't allow the **FileSystem** provider. If users can write to any part of the file system, it's
> possible to completely bypass security.
>
> Don't allow the **Certificate** provider. With the provider enabled, a user could gain access to
> stored private keys.

### Don't allow commands that can create new runspaces

> [!WARNING]
> The `*-Job` cmdlets can create new runspaces without the restrictions.

### Don't allow the `Trace-Command` cmdlet.

> [!WARNING]
> Using `Trace-Command` brings all traced commands into the session.

### Don't create your own proxy implementations for the restricted commands

PowerShell has a set of proxy commands for restricted command scenarios. These proxy commands
ensure that input parameters can't compromise the security of the session. The following commands
have restricted proxies:

- `Exit-PSSession`
- `Get-Command`
- `Get-FormatData`
- `Get-Help`
- `Measure-Object`
- `Out-Default`
- `Select-Object`

If you create your own implementation of these commands, you may inadvertently allow users to run
code prohibited by the JEA proxy commands.

You can run the following command to get a list of restricted commands:

```powershell
$commands = [System.Management.Automation.CommandMetadata]::GetRestrictedCommands(
    [System.Management.Automation.SessionCapabilities]::RemoteServer
)
```

You can examine the restricted proxy commands by using the following command:

```powershell
$commands = [System.Management.Automation.CommandMetadata]::GetRestrictedCommands(
    [System.Management.Automation.SessionCapabilities]::RemoteServer
)
$getHelpProxyBlock = [System.Management.Automation.ProxyCommand]::Create($commands['Get-Help'])
```

### Configure the session to use NoLanguage mode

PowerShell `NoLanguage` mode disables the PowerShell scripting language completely. You can't run
scripts or use variables. You can only run native commands and cmdlets.

For more information about language modes, see [about_Language_Modes][03].

### Don't allow the debugger to be used in the session

By default, the PowerShell debugger runs code in `FullLanguage` mode. Set the
**UseFullLanguageModeInDebugger** property in the **SessionState** to false.

For more information, see [UseFullLanguageModeInDebugger][02].

<!-- link references -->
[01]: remoting/jea/overview.md
[02]: /dotnet/api/system.management.automation.sessionstate.usefulllanguagemodeindebugger?#system-management-automation-sessionstate-usefulllanguagemodeindebugger
[03]: /powershell/module/microsoft.powershell.core/about/about_language_modes
