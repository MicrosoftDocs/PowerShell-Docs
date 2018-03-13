---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Credentials Options in Configuration Data
---

# Credentials Options in Configuration Data
>Applies To: Windows PowerShell 5.0

## Plain Text Passwords and Domain Users

DSC configurations containing a credential without encryption
will generate an error message about plain text passwords.
Also, DSC will generate a warning when using domain credentials.
To suppress these error and warning messages use the DSC configuration data keywords:
* **PsDscAllowPlainTextPassword**
* **PsDscAllowDomainUser**

> [!NOTE]
> Storing/transmitting plaintext passwords unencrypted is generally not secure. Securing credentials by using the techniques covered later in this topic is recommended.
> The Azure Automation DSC service allows you to centrally manage credentials to be compiled in configurations and stored securely.
> For information, see: [Compiling DSC Configurations / Credential Assets](/azure/automation/automation-dsc-compile#credential-assets)

The following is an example of passing plain text credentials:

```powershell
#Prompt user for their credentials
#credentials will be unencrypted in the MOF
$promptedCreds = get-credential -Message "Please enter your credentials to generate a DSC MOF:"

# Store passwords in plaintext, in the document itself
# will also be stored in plaintext in the mof
$password = "ThisIsAPlaintextPassword" | ConvertTo-SecureString -asPlainText -Force
$username = "User1"
[PSCredential] $credential = New-Object System.Management.Automation.PSCredential($username,$password)

# DSC requires explicit confirmation before storing passwords insecurely
$ConfigurationData = @{
    AllNodes = @(
        @{
            # The "*" means "all nodes named in ConfigData" so we don't have to repeat ourselves
            NodeName="*"
            PSDscAllowPlainTextPassword = $true
        },
        #however, each node still needs to be explicitly defined for "*" to have meaning
        @{
            NodeName = "TestMachine1"
        },
        #we can also use a property to define node-specific passwords, although this is no more secure
        @{
            NodeName = "TestMachine2";
            UserName = "User2"
            LocalPassword = "ThisIsYetAnotherPlaintextPassword"
        }
        )
}
configuration unencryptedPasswordDemo
{
    Node "TestMachine1"
    {
        # We use the plaintext password to generate a new account
        User User1
        {
            UserName = $username
            Password = $credential
            Description = "local account"
            Ensure = "Present"
            Disabled = $false
            PasswordNeverExpires = $true
            PasswordChangeRequired = $false
        }
        # We use the prompted password to add this account to the local admins group
        Group addToAdmin
        {
            # Ensure the user exists before we add the user to a group
            DependsOn = "[User]User1"
            Credential = $promptedCreds
            GroupName = "Administrators"
            Ensure = "Present"
            MembersToInclude = "User1"
        }
    }

    Node "TestMachine2"
    {
        # Now we'll use a node-specific password to this machine
        $password = $Node.LocalPass | ConvertTo-SecureString -asPlainText -Force
        $username = $node.UserName
        [PSCredential] $nodeCred = New-Object System.Management.Automation.PSCredential($username,$password)

        User User2
        {
            UserName = $username
            Password = $nodeCred
            Description = "local account"
            Ensure = "Present"
            Disabled = $false
            PasswordNeverExpires = $true
            PasswordChangeRequired = $false
        }

        Group addToAdmin
        {
            Credential = $domain
            GroupName = "Administrators"
            DependsOn = "[User]User2"
            Ensure = "Present"
            MembersToInclude = "User2"
        }
    }

}
# We declared the ConfigurationData in a local variable, but we need to pass it in to our configuration function
# We need to invoke the configuration function we created to generate a MOF
unencryptedPasswordDemo -ConfigurationData $ConfigurationData
# We need to pass the MOF to the machines we named.
#-wait: doesn't use jobs so we get blocked at the prompt until the configuration is done
#-verbose: so we can see what's going on and catch any errors
#-force: for testing purposes, I run start-dscconfiguration frequently + want to make sure i'm
#        not blocked by previous configurations that are still running
Start-DscConfiguration ./unencryptedPasswordDemo -verbose -wait -force
```

## Handling Credentials in DSC

DSC configuration resources run as `Local System` by default.
However, some resources need a credential,
for example when the `Package` resource needs to install software under a specific user account.

Earlier resources used a hard-coded `Credential` property name to handle this.
WMF 5.0 added an automatic `PsDscRunAsCredential` property for all resources.
For information about using `PsDscRunAsCredential`,
see [Running DSC with user credentials](runAsUser.md).
Newer resources and custom resources can use this automatic property
instead of creating their own property for credentials.

> [!NOTE]
> The design of some resources are to use multiple credentials for a specific reason, and they will have their own credential properties.

To find the available credential properties on a resource
use either `Get-DscResource -Name ResourceName -Syntax`
or the Intellisense in the ISE (`CTRL+SPACE`).

```powershell
PS C:\> Get-DscResource -Name Group -Syntax
Group [String] #ResourceName
{
    GroupName = [string]
    [Credential = [PSCredential]]
    [DependsOn = [string[]]]
    [Description = [string]]
    [Ensure = [string]{ Absent | Present }]
    [Members = [string[]]]
    [MembersToExclude = [string[]]]
    [MembersToInclude = [string[]]]
    [PsDscRunAsCredential = [PSCredential]]
}
```

This example uses a [Group](https://msdn.microsoft.com/powershell/dsc/groupresource) resource
from the `PSDesiredStateConfiguration` built-in DSC resource module.
It can create local groups and add or remove members.
It accepts both the `Credential` property and the automatic `PsDscRunAsCredential` property.
However, the resource only uses the `Credential` property.

For more information about the `PsDscRunAsCredential` property,
see [Running DSC with user credentials](runAsUser.md).

## Example: The Group resource Credential property

DSC runs under `Local System`, so it already has permissions to change local users and groups.
If the member added is a local account, then no credential is necessary.
If the `Group` resource adds a domain account to the local group, then a credential is necessary.

Anonymous queries to Active Directory are not allowed.
The `Credential` property of the `Group` resource is the domain account
used to query Active Directory.
For most purposes this could be a generic user account,
because by default users can *read* most of the objects in Active Directory.

## Example Configuration

The following example code uses DSC to populate a local group with a domain user:

```powershell
Configuration DomainCredentialExample
{
    param
    (
        [PSCredential] $DomainCredential
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node localhost
    {
        Group DomainUserToLocalGroup
        {
            GroupName        = 'ApplicationAdmins'
            MembersToInclude = 'contoso\alice'
            Credential       = $DomainCredential
        }
    }
}

$cred = Get-Credential -UserName contoso\genericuser -Message "Password please"
DomainCredentialExample -DomainCredential $cred
```

This code generates both an error and warning message:

```
ConvertTo-MOFInstance : System.InvalidOperationException error processing
property 'Credential' OF TYPE 'Group': Converting and storing encrypted
passwords as plain text is not recommended. For more information on securing
credentials in MOF file, please refer to MSDN blog:
http://go.microsoft.com/fwlink/?LinkId=393729

At line:11 char:9
+   Group
At line:297 char:16
+     $aliasId = ConvertTo-MOFInstance $keywordName $canonicalizedValue
+                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Write-Error], InvalidOperationException
    + FullyQualifiedErrorId : FailToProcessProperty,ConvertTo-MOFInstance

WARNING: It is not recommended to use domain credential for node 'localhost'.
In order to suppress the warning, you can add a property named
'PSDscAllowDomainUser' with a value of $true to your DSC configuration data
for node 'localhost'.
```

This example has two issues:
1. An error explains that plain text passwords are not recommended
2. A warning advises against using a domain credential

## PsDscAllowPlainTextPassword

The first error message has a URL with documentation.
This link explains how to encrypt passwords
using a [ConfigurationData](https://msdn.microsoft.com/powershell/dsc/configdata)
structure and a certificate.
For more information on certificates and DSC [read this post](http://aka.ms/certs4dsc).

To force a plain text password,
the resource requires the `PsDscAllowPlainTextPassword` keyword in the configuration data section
as follows:

```powershell
Configuration DomainCredentialExample
{
    param
    (
        [PSCredential] $DomainCredential
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node localhost
    {
        Group DomainUserToLocalGroup
        {
            GroupName        = 'ApplicationAdmins'
            MembersToInclude = 'contoso\alice'
            Credential       = $DomainCredential
        }
    }
}

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
        }
    )
}

$cred = Get-Credential -UserName contoso\genericuser -Message "Password please"
DomainCredentialExample -DomainCredential $cred -ConfigurationData $cd
```

> [!NOTE]
> `NodeName` cannot equal asterisk, a specific node name is mandatory.

**Microsoft advises to avoid plain text passwords due to the significant security risk.**

An exception would be when using the Azure Automation DSC service,
only because the data is always stored encrypted
(in transit, at rest in the service, and at rest on the node).

## Domain Credentials

Running the example configuration script again (with or without encryption),
still generates the warning that using a domain account for a credential is not recommended.
Using a local account eliminates potential exposure of domain credentials
that could be used on other servers.

**When using credentials with DSC resources, prefer a local account over a domain account when possible.**

If there is a '\' or '@' in the `Username` property of the credential,
then DSC will treat it as a domain account.
There is an exception for "localhost",
"127.0.0.1", and "::1" in the domain portion of the user name.

## PSDscAllowDomainUser

In the DSC `Group` resource example above,
querying an Active Directory domain *requires* a domain account.
In this case add the `PSDscAllowDomainUser` property to the `ConfigurationData` block as follows:

```powershell
$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowDomainUser = $true
            # PSDscAllowPlainTextPassword = $true
            CertificateFile = "C:\PublicKeys\server1.cer"
        }
    )
}
```

Now the configuration script will generate the MOF file with no errors or warnings.
