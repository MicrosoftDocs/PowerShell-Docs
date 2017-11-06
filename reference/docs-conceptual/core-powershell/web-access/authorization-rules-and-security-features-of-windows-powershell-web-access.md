---
ms.date:  2017-06-27
keywords:  powershell,cmdlet
title:  Authorization Rules and Security Features of Windows PowerShell Web Access
---

# Authorization Rules and Security Features of Windows PowerShell Web Access

Updated: June 24, 2013

Applies To: Windows Server 2012 R2, Windows Server 2012

Windows PowerShell Web Access in
Windows Server 2012 R2
and Windows Server 2012
has a restrictive security model.
Users must explicitly be granted access
before they can sign in to the Windows PowerShell Web Access gateway
and use the web-based Windows PowerShell console.

## Configuring authorization rules and site security

After Windows PowerShell Web Access is installed and the gateway is configured,
users can open the sign-in page in a browser,
but they cannot sign in until
the Windows PowerShell Web Access administrator grants users access explicitly.
'Windows PowerShell Web Access' access control is managed
by using the set of Windows PowerShell cmdlets described in the following table.
There is no comparable GUI for adding or managing authorization rules.
See [Windows PowerShell Web Access Cmdlets](cmdlets/web-access-cmdlets.md).

Administrators can define 0-*n* authentication rules
for Windows PowerShell Web Access.
The default security is restrictive rather than permissive;
zero authentication rules means no users have access to anything.

[Add-PswaAuthorizationRule](cmdlets/add-pswaauthorizationrule.md)
and [Test-PswaAuthorizationRule](cmdlets/test-pswaauthorizationrule.md)
in Windows Server 2012 R2 include a Credential parameter that allows you
to add and test Windows PowerShell Web Access authorization rules
from a remote computer, or from within an active Windows PowerShell Web Access session.
As with other Windows PowerShell cmdlets that have a Credential parameter,
you can specify a PSCredential object as the value of the parameter.
To create a PSCredential object that contains credentials
you want to pass to a remote computer,
run the [Get-Credential](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.security/Get-Credential) cmdlet.

Windows PowerShell Web Access authentication rules are whitelist rules.
Each rule is a definition of an allowed connection between
users, target computers, and particular Windows PowerShellÂ [session configurations](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_session_configurations)
(also referred to as endpoints or _runspaces_) on specified target computers.
For an explanation on **runspaces** see
[Beginning Use of PowerShell Runspaces](https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/26/beginning-use-of-powershell-runspaces-part-1/)

> **Security Note**
>
> A user needs only one rule to be true to get access.
If a user is given access to one computer with either full language access
or access only to Windows PowerShell remote management cmdlets,
from the web-based console,
the user can log on (or hop) to other computers
that are connected to the first target computer.
The most secure way to configure Windows PowerShell Web Access
is to allow users access only to constrained session configurations
that allow them to accomplish specific tasks
that they normally need to perform remotely.

The cmdlets referenced in [Windows PowerShell Web Access Cmdlets](cmdlets/web-access-cmdlets.md)
allow to create a set of access rules
which are used to authorize a user on the Windows PowerShell Web Access gateway.
The rules are different from the access control lists (ACLs) on the destination computer,
and provide an additional layer of security for web access.
More details about security are described in the following section.

If users cannot pass any of the preceding security layers,
they receive a generic 'access denied' message in their browser windows.
Although security details are logged on the gateway server,
end users are not shown information about how many security layers they passed,
or at which layer the sign-in or authentication failure occurred.

For more information about configuring authorization rules,
see [configuring authorization rules](#configuring-authorization-rules-and-site-security) in this topic.

### Security

The Windows PowerShell Web Access security model has four layers
between an end user of the web-based console, and a target computer.
Windows PowerShell Web Access administrators can add security layers
through additional configuration in the IIS Manager console.
For more information about securing websites in the IIS Manager console,
see [Configure Web Server Security (IIS 7)](https://technet.microsoft.com/library/cc731278).
For more information about IIS best practices and preventing denial-of-service attacks,
see [Best Practices for Preventing DoS/Denial of Service Attacks](https://technet.microsoft.com/library/cc750213).
An administrator can also buy and install additional
retail authentication software.

The following table describes the four layers of security
between end users and target computers.

|Level|Layer|
|-|-|
|1|[iis web server security features](#iis-web-server-security-features)|
|2|[windows powershell web access forms-based gateway authentication](#windows-powershell-web-access-forms-based-gateway-authentication)|
|3|[windows powershell web access authorization rules](#windows-powershell-web-access-authorization-rules)|
|4|[target authentication and authorization rules](#target-authentication-and-authorization-rules)|

Detailed information about each layer can be found under the following headings:

#### IIS Web Server security features

Windows PowerShell Web Access users must always provide a
user name and password to authenticate their accounts on the gateway.
However, Windows PowerShell Web Access administrators can
also turn optional client certificate authentication on or off,
see [install and use windows powershell web access](install-and-use-windows-powershell-web-access.md)
to enable a test certificate and, later, how to configure a genuine certificate).

The optional client certificate feature requires end users
to have a valid client certificate,
in addition to their user names and passwords,
and is part of Web Server (IIS) configuration.
When the client certificate layer is enabled,
the Windows PowerShell Web Access sign-in page
prompts users to provide valid certificates
before their sign-in credentials are evaluated.
Client certificate authentication automatically checks for the client certificate.
If a valid certificate is not found,
Windows PowerShell Web Access informs users,
so they can provide the certificate.
If a valid client certificate is found,
Windows PowerShell Web Access opens the sign-in page for users
to provide their user names and passwords.

This is one example of additional security settings that are offered by IIS Web Server.
For more information about other IIS security features,
see [Configure Web Server Security (IIS 7)](https://technet.microsoft.com/library/cc731278)

#### Windows PowerShell Web Access forms-based gateway authentication

The Windows PowerShell Web Access sign-in page requires
a set of credentials (user name and password)
and offers users the option of providing different credentials for the target computer.
If the user does not provide alternate credentials,
the primary user name and password that are used to connect to the gateway
are also used to connect to the target computer.

The required credentials are authenticated on the Windows PowerShell Web Access gateway.
These credentials must be valid user accounts on either
the local Windows PowerShell Web Access gateway server,
or in Active Directory.

#### Windows PowerShell Web Access authorization rules

After a user is authenticated at the gateway,
Windows PowerShell Web Access checks authorization rules
to verify if the user has access to the requested target computer.
After successful authorization,
the user's credentials are passed along to the target computer.

These rules are evaluated only after a user has been authenticated by the gateway,
and before a user can be authenticated on a target computer.

#### Target authentication and authorization rules

The final layer of security for Windows PowerShell Web Access
is the target computer's own security configuration.
Users must have the appropriate access rights configured on the target computer,
and also in the Windows PowerShell Web Access authorization rules,
to run a Windows PowerShell web-based console
that affects a target computer through Windows PowerShell Web Access.

This layer offers the same security mechanisms
that would evaluate connection attempts
if users tried to create a remote Windows PowerShell session to a target computer
from within Windows PowerShell
by running the [Enter-PSSession](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/Enter-PSSession) or [New-PSSession](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/new-pssession) cmdlets.

By default,
Windows PowerShell Web Access uses the primary user name and password
for authentication on both the gateway and the target computer.
The web-based sign-in page
, in a section titled **Optional connection settings**,
offers users the option of providing different credentials for the target computer
, if they are required.
If the user does not provide alternate credentials
, the primary user name and password that are used to connect to the gateway
are also used to connect to the target computer.

Authorization rules can be used
to allow users access to a particular session configuration.
You can create _restricted runspaces_ or session configurations
for Windows PowerShell Web Access
, and allow specific users to connect only to specific session configurations
when they sign in to Windows PowerShell Web Access.
You can use access control lists (ACLs)
to determine which users have access to specific endpoints
, and further restrict access to the endpoint
for a specific set of users by using authorization rules
described in this section.
For more information about restricted runspaces,
see [Creating a constrained runspace](https://msdn.microsoft.com/en-us/library/dn614668).

### Configuring authorization rules

Administrators likely want the same authorization rule
for Windows PowerShell Web Access users
that is already defined in their environment
for Windows PowerShell remote management.
The first procedure in this section describes
how to add a secure authorization rule that grants access to one user
, signing in to manage one computer
, and within a single session configuration.
The second procedure describes how
to remove an authorization rule that is no longer needed.

If you plan to use custom session configurations
to allow specific users to work only within restricted runspaces
in Windows PowerShell Web Access
, create your custom session configurations
before you add authorization rules that refer to them.
You cannot use the Windows PowerShell Web Access cmdlets
to create custom session configurations.
For more information about creating custom session configurations
, see [about_Session_Configuration_Files](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_session_configuration_files).

Windows PowerShell Web Access cmdlets support one wildcard character
, an asterisk ( \* ).
Wildcard characters within strings are not supported;
use a single asterisk per property (users, computers, or session configurations).

> **Note**
>
> For more ways you can use authorization rules to grant access to users
and help secure the Windows PowerShell Web Access environment
, see [other authorization rule scenario examples](#other-authorization-rule-scenario-examples)
in this topic.

#### To add a restrictive authorization rule

1. Do one of the following to open a Windows PowerShell session with elevated user rights.

    - On the Windows desktop, right-click **Windows PowerShell** on the taskbar
    , and then click **Run as Administrator**.

    - On the Windows **Start** screen, right-click **Windows PowerShell**
    , and then click **Run as Administrator**.

2. **Optional step** For restricting user access by using session configurations:

    Verify that the session configurations that you want to use
, already exist in your rules .
If they have not yet been created
, use instructions for creating session configurations in
[about_Session_Configuration_Files](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_session_configuration_files).

3. This authorization rule allows a specific user access to one computer on the network to which they typically have access, with access to a specific session configuration that is scoped to the user'™s typical scripting and cmdlet needs. Type the following, and then press **Enter**.

```powershell
Add-PswaAuthorizationRule -UserName <domain\user | computer\user> -ComputerName <computer_name> -ConfigurationName <session_configuration_name>
```

  - In the following example,
a user named _JSmith_ in the _Contoso_ domain is granted access
to manage the computer _Contoso_214_,
 and use a session configuration named _NewAdminsOnly_.

```powershell
Add-PswaAuthorizationRule -UserName 'Contoso\JSmith' -ComputerName Contoso_214 -ConfigurationName NewAdminsOnly
```

4. Verify that the rule has been created by running either the **Get-PswaAuthorizationRule** cmdlet, or **Test-PswaAuthorizationRule -UserName &lt;domain\\user | computer\\user&gt; -ComputerName** &lt;computer_name&gt;. For example, **Test-PswaAuthorizationRule -UserName Contoso\\JSmith -ComputerName Contoso_214**.

#### To remove an authorization rule

1. If a Windows PowerShell session is not already open, see step 1 of [to add a restrictive authorization rule](#to-add-a-restrictive-authorization-rule) in this section.

2. Type the following, and then press **Enter**,
where *rule ID* represents the unique ID number of the rule that you
want to remove.

```powershell
Remove-PswaAuthorizationRule -ID <rule ID>
```

Alternatively, if you do not know the ID number,
but know the friendly name of the rule you want to remove,
you can get the name of the rule,
and pipe it to the `Remove-PswaAuthorizationRule` cmdlet to remove the rule,
as shown in the following example:
`Get-PswaAuthorizationRule -RuleName <rule-name> | Remove-PswaAuthorizationRule`.

>**Note**:
>
>You are not prompted to confirm whether you want to delete
>the specified authorization rule; the rule is deleted when you press
>**Enter**. Be sure that you want to remove the authorization rule before
>running the `Remove-PswaAuthorizationRule` cmdlet.

#### Other authorization rule scenario examples

Every Windows PowerShell session uses a session configuration; if one is
not specified for a session, Windows PowerShell uses the default, built-in
Windows PowerShell session configuration, called Microsoft.PowerShell. The
default session configuration includes all cmdlets that are available on a
computer. Administrators can restrict access to all computers by defining a
session configuration with a restricted runspace (a limited range of
cmdlets and tasks that their end users could perform). A user who is
granted access to one computer with either full language access or only the
Windows PowerShell remote management cmdlets can connect to other computers
that are connected to the first computer. Defining a restricted runspace
can prevent users from accessing other computers from their allowed Windows
PowerShell runspace, and improves the security of your Windows PowerShell
Web Access environment. The session configuration can be distributed (by
using Group Policy) to all computers that administrators want to make
accessible through Windows PowerShell Web Access. For more information
about session configurations, see
[about_Session_Configurations](https://technet.microsoft.com/library/dd819508.aspx).
The following are some examples of this scenario.

- An administrator creates an endpoint, called **PswaEndpoint**, with a restricted runspace. Then, the administrator creates a rule, **\*,\*,PswaEndpoint**, and distributes the endpoint to other computers. The rule allows all users to access all computers with the endpoint **PswaEndpoint**. If this is the only authorization rule defined in the rule set, computers without that endpoint would not be accessible.

- The administrator created an endpoint with a restricted runspace called **PswaEndpoint**,and wants to restrict access to specific users. The administrator creates a group of users called **Level1Support**, and defines the following rule: **Level1Support,\*,PswaEndpoint**. The rule grants any users in the group **Level1Support** access to all computers with the **PswaEndpoint** configuration. Similarly, access can be restricted to a specific set of computers.

- Some administrators provide certain users more access than others. For example, an administrator creates two user groups, **Admins** and **BasicSupport**. The administrator also creates an endpoint with a restricted runspace called **PswaEndpoint**, and defines the following two rules: **Admins,\*,\*** and **BasicSupport,\*,PswaEndpoint**. The first rule provides all users in the **Admin** group access to all computers, and the second rule provides all users in the **BasicSupport** group access only to those computers with **PswaEndpoint**.

- An administrator has set up a private test environment, and wants to allow all authorized network users access to all computers on the network to which they typically have access, with access to all session configurations to which they typically have access. Because this is a private test environment, the administrator creates an authorization rule that is not secure.
  - The administrator runs the cmdlet `Add-PswaAuthorizationRule * * *`, which uses the wildcard character **\*** to represent all users, all computers, and all configurations.
  - This rule is the equivalent of the following: `Add-PswaAuthorizationRule -UserName * -ComputerName * -ConfigurationName *`.

  >**Note**:
  >
  >This rule is not recommended in a secure environment,
  >and bypasses the authorization rule layer of security provided
  >by Windows PowerShell Web Access.

- An administrator must allow users to connect to target computers in an
environment that includes both workgroups and domains, where workgroup
computers are occasionally used to connect to target computers in domains,
and computers in domains are occasionally used to connect to target
computers in workgroups. The administrator has a gateway server,
*PswaServer*, in a workgroup; and target computer *srv1.contoso.com* is in
a domain. User *Chris* is an authorized local user on both the workgroup
gateway server and the target computer. His user name on the workgroup
server is *chrisLocal*; and his user name on the target computer is
*contoso\\chris*. To authorize access to srv1.contoso.com for Chris, the
administrator adds the following rule.

```powershell
Add-PswaAuthorizationRule -userName PswaServer\chrisLocal -computerName srv1.contoso.com -configurationName Microsoft.PowerShell
```

The preceding rule example authenticates Chris on the gateway server, and
then authorizes his access to *srv1*. On the sign-in page, Chris must
provide a second set of credentials in the **Optional connection settings**
area (*contoso\\chris*). The gateway server uses the additional set of
credentials to authenticate him on the target computer, *srv1.contoso.com*.

In the preceding scenario, Windows PowerShell Web Access establishes a
successful connection to the target computer only after the following have
been successful, and allowed by at least one authorization rule.

1. Authentication on the workgroup gateway server by adding a user name in the format *server_name*\\*user_name* to the authorization rule

2. Authentication on the target computer by using alternate credentials provided on the sign-in page, in the **Optional connection settings** area

  >**Note**:
  >
  >If gateway and target computers are in different workgroups or domains, a
trust relationship must be established between the two workgroup computers,
the two domains, or between the workgroup and the domain. This relationship
cannot be configured by using Windows PowerShell Web Access authorization
rule cmdlets. Authorization rules do not define a trust relationship
between computers; they can only authorize users to connect to specific
target computers and session configurations. For more information about how
to configure a trust relationship between different domains, see [Creating Domain
and Forest Trusts](https://technet.microsoft.com/library/cc794775.aspx"). For more information about how to add workgroup
computers to a trusted hosts list, see [Remote Management with Server Manager](https://technet.microsoft.com/library/dd759202.aspx)

### Using a single set of authorization rules for multiple sites

Authorization rules are stored in an XML file. By default, the path name of
the XML file is
_%windir%\\Web\\PowershellWebAccess\\data\\AuthorizationRules.xml_.

The path to the authorization rules XML file is stored in the
**powwa.config** file, which is found in
_%windir%\\Web\\PowershellWebAccess\\data_. The administrator has the
flexibility to change the reference to the default path in **powwa.config**
to suit preferences or requirements. Allowing the administrator to change
the location of the file lets multiple Windows PowerShell Web Access
gateways use the same authorization rules, if such a configuration is
desired.

## Session management

By default, Windows PowerShell Web Access limits a user to three sessions
at one time. You can edit the web application's **web.config** file in IIS
Manager to support a different number of sessions per user.
The path to the **web.config** file is
_$Env:Windir\\Web\\PowerShellWebAccess\\wwwroot\\Web.config_.

By default, IIS Web Server is configured to restart the application pool if
any settings are edited. For example, the application pool is restarted if
changes are made to the **web.config** file.
>Because **Windows PowerShell Web Access** uses in-memory session states,
>users signed in to **Windows PowerShell Web Access** sessions
lose their sessions when the application pool is restarted.

### Setting default parameters on the sign-in page

If your Windows PowerShell Web Access gateway is running on Windows Server
2012 R2, you can configure default values for the settings that are
displayed on the Windows PowerShell Web Access sign-in page. You can
configure values in the **web.config** file that is described in the
preceding paragraph. Default values for the sign-in page settings are found
in the **appSettings** section of the web.config file; the following is an
example of the **appSettings** section. Valid values for many of these
settings are the same as those for the corresponding parameters of the
[New-PSSession](https://technet.microsoft.com/library/hh849717.aspx) cmdlet
in Windows PowerShell.
For example, the `defaultApplicationName` key, as shown in the following
code block, is the value of the **$PSSessionApplicationName** preference
variable on the target computer.

```xml
    <appSettings>
            <add key="maxSessionsAllowedPerUser" value="3"/>
            <add key="defaultPortNumber" value="5985"/>
            <add key="defaultSSLPortNumber" value="5986"/>
            <add key="defaultApplicationName" value="WSMAN"/>
            <add key="defaultUseSslSelection" value="0"/>
            <add key="defaultAuthenticationType" value="0"/>
            <add key="defaultAllowRedirection" value="0"/>
            <add key="defaultConfigurationName" value="Microsoft.PowerShell"/>
    </appSettings>
```

### Time-outs and unplanned disconnections

Windows PowerShell Web Access sessions time out. In Windows PowerShell Web
Access running on Windows Server 2012, A time-out message is displayed to
signed-in users after 15 minutes of session inactivity. If the user does
not respond within five minutes after the time-out message is displayed,
the session is ended, and the user is signed out. You can change time-out
periods for sessions in the website settings in IIS Manager.

In Windows PowerShell Web Access running on Windows Server 2012 R2,
sessions time out, by default, after 20 minutes of inactivity. If users are
disconnected from sessions in the web-based console because of network
errors or other unplanned shutdowns or failures, and not because they have
closed the sessions themselves, the Windows PowerShell Web Access sessions
continue to run, connected to target computers, until the time-out period
on the client side lapses. The session is disconnected after either the
default 20 minutes, or after the time-out period specified by the gateway
administrator, whichever is shorter.

If the gateway server is running Windows Server 2012 R2, Windows PowerShell
Web Access lets users reconnect to saved sessions at a later time, but when
network errors, unplanned shutdowns, or other failures disconnect sessions,
users cannot see or reconnect to saved sessions until after the time-out
period specified by the gateway administrator has lapsed.

## See Also

- [Install and Use Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/hh831611(v=ws.11).aspx)
- [about_Session_Configurations](https://technet.microsoft.com/library/dd819508.aspx)
- [Windows PowerShell Web Access Cmdlets](cmdlets/web-access-cmdlets.md)
