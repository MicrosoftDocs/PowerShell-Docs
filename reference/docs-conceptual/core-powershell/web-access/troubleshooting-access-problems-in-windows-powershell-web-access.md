---
ms.date:  2017-08-23
keywords:  powershell,cmdlet
title:  troubleshooting access problems in windows powershell web access
---

# Troubleshooting Access Problems in Windows PowerShell Web Access

Updated: June 24, 2013 (revised August 23, 2017)

Applies To: Windows Server 2012 R2, Windows Server 2012

The following sections identify some common problems when
attempting to connect to a remote computer
by using Windows PowerShell Web Access,
and includes suggestions for resolving the problems.

## Sign-in failure

Failure could occur because of any of the following.

- An authorization rule that allows the user access to the computer, or a specific session configuration on the remote computer, does not exist.

  Windows PowerShell Web Access security is restrictive; users must be granted explicit access to remote computers by using authorization rules.

  For more information about creating authorization rules, see [Authorization Rules and Security Features of Windows PowerShell Web Access](authorization-rules-and-security-features-of-windows-powershell-web-access.md).

- The user does not have authorized access to the destination computer. This is determined by access control lists (ACLs).

  For more information, see [Signing in to Windows PowerShell Web Access](use-the-web-based-windows-powershell-console.md#signing-in-to-windows-powershell-web-access), or the Windows PowerShell Team Blog.

- Windows PowerShell remote management might not be enabled on the destination computer.

  Verify remote management is enabled on the computer to which the user is trying to connect.

  For more information, see [How to Configure Your Computer for Remoting](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_requirements#how-to-configure-your-computer-for-remoting).

## Internal Server Error

When users try to sign in to Windows PowerShell Web Access in an Internet 
Explorer window, they are shown an **Internal Server Error** page,
or *Internet Explorer* stops responding.

This issue is specific to Internet Explorer.

### Possible cause

This can occur for users who have signed in with a domain name that contains
Chinese characters, or if one or more Chinese characters are part of the
gateway server name.

#### Workaround

1. [Install and run Internet Explorer 10](http://ie.microsoft.com/testdrive/info/downloads/Default.html)
1. Change Internet Explorer **Document Mode** setting to *IE10* standards.
   1. Press **F12** to open the Developer Tools console
   1. In Internet Explorer 10, click **Browser Mode**, and then select *Internet Explorer 10*.
   1. Click **Document Mode**, and then click *IE10* standards.
   1. Press **F12** again to close the Developer Tools console.
1. Disable automatic proxy configuration in Internet Explorer 10.
   1. Click **Tools**, and then click **Internet Options**.
   1. In the **Internet Options** dialog box, on the **Connections** tab, click **LAN settings**.
   1. Clear the **Automatically detect settings** check box. Click **OK**, and then click **OK** again to close the *Internet Options* dialog box.

## Cannot connect to a remote workgroup computer

If the destination computer is a member of a workgroup, use the following syntax to provide your user name and sign in to the computer: `<workgroup_name>\<user_name>`

## Cannot find Web Server (IIS) management tools, even though the role was installed

If you installed Windows PowerShell Web Access by using the
`Install-WindowsFeature` cmdlet,
management tools are not installed unless the `-IncludeManagementTools`
parameter is added to the cmdlet.

For an example, see [To install Windows PowerShell Web Access by using Windows PowerShell cmdlets](install-and-use-windows-powershell-web-access.md#to-install-windows-powershell-web-access-by-using-windows-powershell-cmdlets).

You can add the IIS Manager console, 
and other IIS management tools that you need, 
by selecting the tools in an **Add Roles and Features Wizard** session that
is targeted at the gateway server.
The Add Roles and Features Wizard is opened from within Server Manager.

## Windows PowerShell Web Access website is not accessible

If Enhanced Security Configuration is enabled in Internet Explorer (IE ESC),
you can add the Windows PowerShell Web Access website to the list of trusted
sites.

A less recommended approach, due to security risks, is to disable IE ESC.
You can disable IE ESC in the Properties tile on the Local Server page in 
Server Manager.

## An authorization failure occurred. Verify that you are authorized to connect to the destination computer.

The above error message is displayed while trying to connect when the
gateway server is the destination computer, and is also in a workgroup.

When the gateway server is also the destination server,
and it is in a workgroup, specify the user name, computer name,
and user group name.
Do not use a dot (.) by itself to represent the computer name.

### Scenarios and proper values

#### All cases

Parameter | Value
-- | --
UserName | Server\_name\\user\_name<br/>Localhost\\user\_name<br/>.\\user\_name
UserGroup | Server\_name\\user\_group<br/>Localhost\\user\_group<br/>.\\user\_group
ComputerGroup | Server\_name\\computer\_group<br/>Localhost\\computer\_group<br/>.\\computer\_group

#### Gateway server is in a domain

Parameter | Value
-- | --
ComputerName | Fully qualified name of gateway server, or Localhost

#### Gateway server is in a workgroup

Parameter | Value
-- | --
ComputerName | Server name

### Gateway credentials

Sign in to a gateway server as target computer by using credentials
formatted as one of the following.

- Server\_name\\user\_name
- Localhost\\user\_name
- .\\user\_name

## A security identifier (SID) is displayed in an authorization rule

A security identifier (SID) is displayed in an authorization rule instead
of the syntax user\_name/computer\_name.

Either the rule is no longer valid, or the Active Directory Domain Services
query failed.
An authorization rule is usually not valid in scenarios where the gateway
server was at one time in a workgroup, but was later joined to a domain

## Cannot sign in with rule as an IPv6 address with a domain

Cannot sign in to a target computer that has been specified in authorization
rules as an IPv6 address with a domain.

Authorization rules do not support an IPv6 address in form of a domain name.

To specify a destination computer by using an IPv6 address,
use the original IPv6 address (that contains colons) in the authorization
rule.
Both domain and numerical (with colons) IPv6 addresses are supported as the
target computer name on the Windows PowerShell Web Access sign-in page,
but not in authorization rules. 

For more information about IPv6 addresses, see [How IPv6 Works](https://technet.microsoft.com/en-us/library/cc781672(v=ws.10).aspx).

## See Also

- [Authorization Rules and Security Features of Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/dn282394(v=ws.11).aspx)
- [Use the Web-based Windows PowerShell Console](https://technet.microsoft.com/en-us/library/hh831417(v=ws.11).aspx)
- [about_Remote_Requirements](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_requirements)
