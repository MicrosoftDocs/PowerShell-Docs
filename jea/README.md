# Just Enough Administration
Just Enough Administration (JEA) is security technology that enables delegated administration for anything that can be managed with PowerShell.
With JEA, you can:
- **Reduce the number of administrators on your machines** by leveraging virtual accounts that perform privileged actions on behalf of regular users.
- **Limit what users can do** by specifying which cmdlets, functions, and external commands they can run.
- **Better understand what your users are doing** with "over the shoulder" transcriptions that show you exactly what commands a user executed during a session.

Why is this important?
Consider the common scenario where your DNS servers are co-located with your Active Directory Domain Controllers.
Your DNS administrators need to have local administrator privileges to fix issues with the DNS server, but in order to do so you have to make them members of the highly privileged "Domain Admins" security group.
This effectively gives them control over your whole domain and access to all resources on that machine.

With JEA in place, you can configure a role for your DNS admins that gives them access to all the commands they need to get their job done, but nothing more.
This means they can easily repair a poisoned DNS cache without having rights to Active Directory, browse the file system, or run potentially dangerous scripts.
Better yet, when the JEA session is configured to use one-time privileged virtual accounts, your DNS admins can connect to the server using *unprivileged* credentials and still be able to run privileged commands.

## Getting Started

### Installation
JEA is being developed alongside the upcoming Windows Server 2016 release, and is available on older versions of Windows through Windows Management Framework updates.
The current release of JEA is available on the following platforms:

**Windows Server**
- Windows Server 2016 Technical Preview 4 and higher
- Windows Server 2012 R2, 2012, and 2008 R2\* with [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed

**Windows Client**
- Windows 10 with the November Update (1511) installed
- Windows 8.1, 8, and 7\* with [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed

\* Support for virtual accounts in JEA sessions is currently not available on Windows Server 2008 R2 or Windows 7.


### Core concepts
**What exactly is JEA?**

JEA is an extension of PowerShell [constrained endpoints](http://blogs.technet.com/b/heyscriptingguy/archive/2014/03/31/introduction-to-powershell-endpoints.aspx) that adds in role definitions, virtual accounts, and several other improvements to make it even easier to lock down your management endpoints.
A JEA endpoint consists of a PowerShell Session Configuration file and one or more Role Capability files.

**What are Session Configuration and Role Capability files?**

PowerShell Session Configuration files (.pssc) define *who* can connect to a PowerShell endpoint and *how* it is configured.
This is where you would map users and security groups to specific management roles and configure global settings like virtual accounts and transcription policies.
Session configuration files are specific to each machine, which allows you to control access on a per-machine basis if desired.

PowerShell Role Capability files (.psrc) define *what* users belonging to a role are able to do on the system.
Here, you can restrict which cmdlets, functions, providers, and external programs a user may use in their JEA session.
Role Capability files are often generic for the role being served (DNS admin, level 1 helpdesk, read-only inventory auditing, etc.) and belong to PowerShell modules, making it easy to share them across your environment and with others.

**How does JEA leverage virtual accounts?**

In the PowerShell Session Configuration file, you can configure JEA sessions to use virtual "run as" accounts.
Virtual accounts are one-time privileged accounts spun up for the specific connecting user in that specific session under which context the user's commands are executed.
Virtual accounts belong to the local "Administrators" security group by default, but can optionally be configured to only belong to security groups you specify.

### Explore the experience guide
Ready to create your first JEA endpoint?
Check out the [JEA Experience Guide](jea-uide.md) to learn how to author, deploy, and use your own JEA endpoint.
The guide gets you started quickly with a pre-built JEA endpoint to get an idea of how the end-user experience feels, then walks you through recreating the endpoint from scratch to help explain session configurations and Role Capabilities.

### Start authoring your own JEA endpoints
It's easy to author a JEA endpoint -- all you need is a JEA-enabled system and a text editor (like PowerShell ISE).
One helpful tip to get started is to create skeleton files using `New-PSRoleCapabilityFile -Path <path>` and `New-PSSessionCapabilityFile -Path <Path>` without any other arguments.
These skeleton files contain all of the applicable configuration fields along with helpful comments to explain what each field can be used for.

To make authoring JEA endpoints even easier, check out the [JEA Toolkit Helper](http://blogs.technet.com/b/privatecloud/archive/2015/12/20/introducing-the-updated-jea-helper-tool.aspx) which provides a GUI with which you can author Session Configuration and Role Capability files.
It even supports generating Role Capabilities based on PowerShell logs to start you off with the commands your users regularly run to get their jobs done.
