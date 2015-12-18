# Credentials Options in Configuration Data
>Applies To: Windows PowerShell 5.0

## Plain Text Passwords and Domain Users

DSC configurations containing a credential without encryption will generate an error messages about plain text passwords.
Also, DSC will generate a warning when using domain credentials.
These error and warning messages can be silenced using the DSC configuration data keywords:
* **PsDscAllowPlainTextPassword**
* **PsDscAllowDomainUser**

## Handling Credentials in DSC

DSC configuration resources run as `Local System` by default.
However, some resources require a credential, like when the `Package` resource needs to install software under a specific user account.

Earlier resources used a hard-coded `Credential` property name to handle this.
WMF 5.0 added an automatic `PsDscRunAsCredential` property for all resources.
Newer resources and custom resources can use this automatic property instead of creating their own property for credentials.

*Note that some resources are designed to use multiple credentials for a specific reason, and they will have their own credential properties.*

To identify the available credential properties on a resource use either `Get-DscResource -Name ResourceName -Syntax` or the Intellisense in the ISE (`CTRL+SPACE`).

```PowerShell
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

This example uses a [Group](https://msdn.microsoft.com/en-us/powershell/dsc/groupresource) resource from the `PSDesiredStateConfiguration` built-in DSC resource module.
It can create local groups and add or remove members.
It accepts both the `Credential` property and the automatic `PsDscRunAsCredential` property.
However, it is coded to only use the `Credential` property.
Read more about `PsDscRunAsCredential` in the [WMF Release Notes](https://msdn.microsoft.com/en-us/powershell/wmf/dsc_runas).

## Example: The Group resource Credential property

DSC runs under `Local System`, so it already has permissions to modify local users and groups.
If the member to be added is a local account, then no credential is required.
If the `Group` resource adds a domain account to the local group, then a credential is required.

Anonymous queries to Active Directory are not allowed.
The `Credential` property of the `Group` resource is the domain account used to query Active Directory.
For most purposes this can be a generic user account, because by default users can *read* most of the objects in Active Directory.

## Example Configuration

The following example code uses DSC to populate a local group with a domain user:

```PowerShell
Configuration DomainCredentialExample
{
param(
    [PSCredential]$DomainCredential
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
1.  An error explains that plain text passwords are not recommended
2.  A warning advises against using a domain credential

## PsDscAllowPlainTextPassword

The first error message has a URL with documentation.
This link explains how to encrypt passwords using a [ConfigurationData](https://msdn.microsoft.com/en-us/powershell/dsc/configdata) structure and a certificate.
For more information on certificates and DSC [read this post](http://aka.ms/certs4dsc).

To force a plain text password, the `PsDscAllowPlainTextPassword` keyword is required in the configuration data section as follows:

```PowerShell
Configuration DomainCredentialExample
{
param(
    [PSCredential]$DomainCredential
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

*Note that `NodeName` cannot equal asterisk. It must be a specific node name.*

**Microsoft advises to avoid plain text passwords due to the significant security risk.**

## Domain Credentials

Running the example configuration script again (with or without encryption), still generates the warning that using a domain account for a credential is not recommended.
Using a local account eliminates potential exposure of domain credentials that can be used on other servers.

**When using credentials with DSC resources, prefer a local account over a domain account when possible.**

If there is a '\' or '@' in the `Username` property of the credential, then DSC will treat it as a domain account.
An exception is made for "localhost", "127.0.0.1", and "::1" in the domain portion of the user name.

## PSDscAllowDomainUser

In the DSC `Group` resource example above, querying an Active Directory domain *requires* the use of a domain account.
In this case add the `PSDscAllowDomainUser` property to the `ConfigurationData` block as follows:

```PowerShell
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
