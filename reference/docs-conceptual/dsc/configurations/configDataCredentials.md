---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Credentials Options in Configuration Data
description: DSC allows you to provide credentials so that configuration settings can be applied the in the context of a specific user account rather than the Local System account.
---
# Credentials Options in Configuration Data

> Applies To: Windows PowerShell 5.0

## Plain Text Passwords and Domain Users

DSC configurations containing a credential without encryption will generate an error message about
plain text passwords. Also, DSC will generate a warning when using domain credentials. To suppress
these error and warning messages use the DSC configuration data keywords:

- **PsDscAllowPlainTextPassword**
- **PsDscAllowDomainUser**

> [!NOTE]
> Storing/transmitting plaintext passwords unencrypted is generally not secure. Securing credentials
> by using the techniques covered later in this topic is recommended. The Azure Automation DSC
> service allows you to centrally manage credentials to be compiled in configurations and stored
> securely. For information, see:
> [Compiling DSC Configurations / Credential Assets](/azure/automation/automation-dsc-compile#credential-assets)

## Handling Credentials in DSC

DSC configuration resources run as `Local System` by default. However, some resources need a
credential, for example when the `Package` resource needs to install software under a specific user
account.

Earlier resources used a hard-coded `Credential` property name to handle this. WMF 5.0 added an
automatic `PsDscRunAsCredential` property for all resources. For information about using
`PsDscRunAsCredential`, see [Running DSC with user credentials](runAsUser.md). Newer resources and
custom resources can use this automatic property instead of creating their own property for
credentials.

> [!NOTE]
> The design of some resources are to use multiple credentials for a specific reason, and they will
> have their own credential properties.

To find the available credential properties on a resource use either
`Get-DscResource -Name ResourceName -Syntax` or the Intellisense in the ISE (`CTRL+SPACE`).

```powershell
Get-DscResource -Name Group -Syntax
```

```Output
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

This example uses a [Group](../resources/resources.md) resource from the
`PSDesiredStateConfiguration` built-in DSC resource module. It can create local groups and add or
remove members. It accepts both the `Credential` property and the automatic `PsDscRunAsCredential`
property. However, the resource only uses the `Credential` property.

For more information about the `PsDscRunAsCredential` property, see
[Running DSC with user credentials](runAsUser.md).

## Example: The Group resource Credential property

DSC runs under `Local System`, so it already has permissions to change local users and groups. If
the member added is a local account, then no credential is necessary. If the `Group` resource adds a
domain account to the local group, then a credential is necessary.

Anonymous queries to Active Directory are not allowed. The `Credential` property of the `Group`
resource is the domain account used to query Active Directory. For most purposes this could be a
generic user account, because by default users can *read* most of the objects in Active Directory.

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
ConvertTo-MOFInstance : System.InvalidOperationException error processing property 'Credential' OF
TYPE 'Group': Converting and storing encrypted passwords as plain text is not recommended.
For more information on securing credentials in MOF file, please refer to MSDN blog:
https://go.microsoft.com/fwlink/?LinkId=393729

At line:11 char:9
+   Group
At line:341 char:16
+     $aliasId = ConvertTo-MOFInstance $keywordName $canonicalizedValue
+                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Write-Error], InvalidOperationException
    + FullyQualifiedErrorId : FailToProcessProperty,ConvertTo-MOFInstance
WARNING: It is not recommended to use domain credential for node 'localhost'. In order to suppress
the warning, you can add a property named 'PSDscAllowDomainUser' with a value of $true to your DSC
configuration data for node 'localhost'.

Compilation errors occurred while processing configuration
'DomainCredentialExample'. Please review the errors reported in error stream and modify your
configuration code appropriately.
At C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\PSDesiredStateConfiguration\PSDesiredStateConfiguration.psm1:3917 char:5
+     throw $ErrorRecord
+     ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (DomainCredentialExample:String) [], InvalidOperationException
    + FullyQualifiedErrorId : FailToProcessConfiguration
```

This example has two issues:

1. An error explains that plain text passwords are not recommended
2. A warning advises against using a domain credential

The flags **PSDSCAllowPlainTextPassword** and **PSDSCAllowDomainUser** suppress the error and
warning informing the user of the risk involved.

## PSDSCAllowPlainTextPassword

The first error message has a URL with documentation. This link explains how to encrypt passwords
using a [ConfigurationData](./configData.md) structure and a certificate. For more information on
certificates and DSC [read this post](https://aka.ms/certs4dsc).

To force a plain text password, the resource requires the `PsDscAllowPlainTextPassword` keyword in
the configuration data section as follows:

```powershell
$password = "ThisIsAPlaintextPassword" | ConvertTo-SecureString -asPlainText -Force
$username = "contoso\Administrator"
[PSCredential] $credential = New-Object System.Management.Automation.PSCredential($username,$password)

Configuration DomainCredentialExample
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node localhost
    {
        Group DomainUserToLocalGroup
        {
            GroupName        = 'ApplicationAdmins'
            MembersToInclude = 'contoso\alice'
            Credential       = $credential
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

DomainCredentialExample -ConfigurationData $cd
```

### localhost.mof

The **PSDSCAllowPlainTextPassword** flag requires that the user acknowledge the risk of storing
plain text passwords in a MOF file. In the generated MOF file, even though a **PSCredential** object
containing a **SecureString** was used, the passwords still appear as plain text. This is the only
time the credentials are exposed. Gaining access to this MOF file gives anyone access to the
Administrator account.

```
/*
@TargetNode='localhost'
@GeneratedBy=Administrator
@GenerationDate=01/31/2019 06:43:13
@GenerationHost=Server01
*/

instance of MSFT_Credential as $MSFT_Credential1ref
{
Password = "ThisIsAPlaintextPassword";
 UserName = "Administrator";

};

instance of MSFT_GroupResource as $MSFT_GroupResource1ref
{
ResourceID = "[Group]DomainUserToLocalGroup";
 MembersToInclude = {
    "contoso\\alice"
};
 Credential = $MSFT_Credential1ref;
 SourceInfo = "::11::9::Group";
 GroupName = "ApplicationAdmins";
 ModuleName = "PSDesiredStateConfiguration";

ModuleVersion = "1.0";

 ConfigurationName = "DomainCredentialExample";

};
```

### Credentials in transit and at rest

- The **PSDscAllowPlainTextPassword** flag allows the compilation of MOF files that contain
  passwords in clear text. Take precautions when storing MOF files containing clear text passwords.
- When the MOF file is delivered to a Node in **Push** mode, WinRM encrypts the communication to
  protect the clear text password unless you override the default with the **AllowUnencrypted**
  parameter.
  - Encrypting the MOF with a certificate protects the MOF file at rest before it has been applied
    to a node.
- In **Pull** mode, you can configure Windows pull server to use HTTPS to encrypt traffic using the
  protocol specified in Internet Information Server. For more information, see the articles
  [Setting up a DSC pull client](../pull-server/pullclient.md) and
  [Securing MOF files with Certificates](../pull-server/secureMOF.md).
  - In the
    [Azure Automation State Configuration](/azure/automation/automation-dsc-overview)
    service, Pull traffic is always encrypted.
- On the Node, MOF files are encrypted at rest Beginning in PowerShell 5.0.
  - In PowerShell 4.0 MOF files are unencrypted at rest unless they are encrypted with a certificate
    when they pushed or pulled to the Node.

**Microsoft advises to avoid plain text passwords due to the significant security risk.**

## Domain Credentials

Running the example configuration script again (with or without encryption), still generates the
warning that using a domain account for a credential is not recommended. Using a local account
eliminates potential exposure of domain credentials that could be used on other servers.

**When using credentials with DSC resources, prefer a local account over a domain account when possible.**

If there is a '\\' or '\@' in the `Username` property of the credential, then DSC will treat it as a
domain account. There is an exception for "localhost", "127.0.0.1", and "::1" in the domain portion
of the user name.

## PSDscAllowDomainUser

In the DSC `Group` resource example above, querying an Active Directory domain *requires* a domain
account. In this case add the `PSDscAllowDomainUser` property to the `ConfigurationData` block as
follows:

```powershell
$password = "ThisIsAPlaintextPassword" | ConvertTo-SecureString -asPlainText -Force
$username = "contoso\Administrator"
[PSCredential] $credential = New-Object System.Management.Automation.PSCredential($username,$password)

Configuration DomainCredentialExample
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node localhost
    {
        Group DomainUserToLocalGroup
        {
            GroupName        = 'ApplicationAdmins'
            MembersToInclude = 'contoso\alice'
            Credential       = $credential
        }
    }
}

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowDomainUser = $true
            PSDscAllowPlainTextPassword = $true
        }
    )
}

DomainCredentialExample -ConfigurationData $cd
```

Now the configuration script will generate the MOF file with no errors or warnings.
