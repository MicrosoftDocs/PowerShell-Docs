---
ms.date:  06/12/2017
title:  DSC Improvements in WMF 5.1
description: This article lists the improvements in Desired State Configuration (DSC) that are included in WMF 5.1
---
# Improvements in Desired State Configuration (DSC) in WMF 5.1

## DSC class resource improvements

In WMF 5.1, we have fixed the following known issues:

- Get-DscConfiguration may return empty values (null) or errors if a complex/hash table type is
  returned by Get() function of a class-based DSC resource.
- Get-DscConfiguration returns error if RunAs credential is used in DSC configuration.
- Class-based resource cannot be used in a composite configuration.
- Start-DscConfiguration hangs if class-based resource has a property of its own type.
- Class-based resource cannot be used as an exclusive resource.

## DSC resource debugging improvements

In WMF 5.0, the PowerShell debugger did not stop at the class-based resource method (Get/Set/Test)
directly. In WMF 5.1, the debugger stops at the class-based resource method in the same way as for
MOF-based resources methods.

## DSC pull client supports TLS 1.1 and TLS 1.2

Previously, the DSC pull client only supported SSL3.0 and TLS1.0 over HTTPS connections. When forced
to use more secure protocols, the pull client would stop functioning. In WMF 5.1, the DSC pull
client no longer supports SSL 3.0 and adds support for the more secure TLS 1.1 and TLS 1.2
protocols.

## Improved pull server registration

In the earlier versions of WMF, simultaneous registrations/reporting requests to a DSC pull server
while using the ESENT database would lead to LCM failing to register and/or report. In such cases,
the event logs on the pull server has the error "Instance Name already in use." This was caused by
an incorrect pattern being used to access the ESENT database in a multi-threaded scenario. In WMF
5.1, this issue has been fixed. Concurrent registrations or reporting (involving ESENT database)
works fine in WMF 5.1. This issue is applicable only to the ESENT database and does not apply to the
OLEDB database.

## Enable Circular log on ESENT database instance

In eariler version of DSC-PullServer, the ESENT database log files were filling up the disk space of
the pullserver because the database instance was being created without circular logging. In this
release, you have the option to control the circular logging behavior of the instance using the
web.config of the pullserver. By default CircularLogging is set to TRUE.

```xml
<appSettings>
    <add key="dbprovider" value="ESENT" />
    <add key="dbconnectionstr" value="C:\Program Files\WindowsPowerShell\DscService\Devices.edb" />
    <add key="CheckpointDepthMaxKB" value="512" />
    <add key="UseCircularESENTLogs" value="TRUE" />
  </appSettings>
```

## WOW64 support for Configuration Keyword

The `Configuration` keyword is now supported in WOW64 on a 64-bit computer. This means that a DSC
configuration can be defined and compiled within a 32-bit process such as Windows PowerShell ISE
(x86) running on a 64-bit computer.

## Pull partial configuration naming convention

In the previous release, the naming convention for a partial configuration was that the MOF file
name in the pull server/service should match the partial configuration name specified in the local
configuration manager settings that in turn must match the configuration name embedded in the MOF
file.

See the snapshots below:

- Local configuration settings which defines a partial configuration that a node is allowed to
  receive.

  ![Sample metaconfiguration](media/DSC-improvements/MetaConfigPartialOne.png)

- Sample partial configuration definition

  ```powershell
  Configuration PartialOne
  {
      Node('localhost')
      {
          File test
          {
              DestinationPath = "$env:TEMP\partialconfigexample.txt"
              Contents = 'Partial Config Example'
          }
      }
  }
  PartialOne
  ```

- 'ConfigurationName' embedded in the generated MOF file.

  ![Sample generated MOF file](media/DSC-improvements/PartialGeneratedMof.png)

- FileName in the pull configuration repository

  ![FileName in Configuration Repository](media/DSC-improvements/PartialInConfigRepository.png)

  Azure Automation service name generated MOF files as `<ConfigurationName>.<NodeName>.mof`. So the
  configuration below compiles to PartialOne.localhost.mof.

  This made it impossible to pull one of your partial configuration from Azure Automation service.

  ```powershell
  Configuration PartialOne
  {
      Node('localhost')
      {
          File test
          {
              DestinationPath = "$env:TEMP\partialconfigexample.txt"
              Contents = 'Partial Config Example'
          }
      }
  }
  PartialOne
  ```

  In WMF 5.1, a partial configuration in the pull server/service can be named as
  `<ConfigurationName>.<NodeName>.mof`. Moreover, if a machine is pulling a single configuration
  from a pull server/service then the configuration file on the pull server configuration repository
  can have any file name. This naming flexibility allows you to manage your nodes partially by Azure
  Automation service, where some configuration for your node is coming from Azure Automation DSC and
  with a partial configuration that you manage locally.

  The metaconfiguration below sets up a node to be managed both locally as well as by Azure
  Automation service.

  ```powershell
  [DscLocalConfigurationManager()]
  Configuration RegistrationMetaConfig
  {
      Settings
      {
          RefreshFrequencyMins = 30
          RefreshMode = "PULL"
      }

      ConfigurationRepositoryWeb web
      {
          ServerURL =  $endPoint
          RegistrationKey = $registrationKey
          ConfigurationNames = $configurationName
      }

      # Partial configuration managed by Azure Automation service.
      PartialConfiguration PartialConfigurationManagedByAzureAutomation
      {
          ConfigurationSource = "[ConfigurationRepositoryWeb]Web"
      }

      # This partial configuration is managed locally.
      PartialConfiguration OnPremisesConfig
      {
          RefreshMode = "PUSH"
          ExclusiveResources = @("Script")
      }

  }

  RegistrationMetaConfig
  Set-DscLocalConfigurationManager -Path .\RegistrationMetaConfig -Verbose
  ```

## Using PsDscRunAsCredential with DSC composite resources

We have added support for using [PsDscRunAsCredential](/powershell/scripting/dsc/configurations/runAsUser)
with DSC [Composite](/powershell/scripting/dsc/resources/authoringresourcecomposite)
resources.

You can now specify a value for **PsDscRunAsCredential** when using composite resources inside
configurations. When specified, all resources run inside a composite resource as a RunAs user. If a
composite resource calls another composite resource, all those resources are also executed as RunAs
user. RunAs credentials are propagated to any level of the composite resource hierarchy. If any
resource inside a composite resource specifies its own value for **PsDscRunAsCredential**, a merge
error results during configuration compilation.

This example shows usage with the [WindowsFeatureSet](/powershell/scripting/dsc/reference/resources/windows/windowsfeaturesetresource)
composite resource included in PSDesiredStateConfiguration module.

```powershell
Configuration InstallWindowsFeature
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.NodeName
    {
        WindowsFeatureSet features
        {
            Name = @("Telnet-Client","SNMP-Service")
            Ensure = "Present"
            IncludeAllSubFeature = $true
            PsDscRunAsCredential = Get-Credential
        }
    }
}

$configData = @{
    AllNodes = @(
        @{
            NodeName             = 'localhost'
            PSDscAllowDomainUser = $true
            CertificateFile      = 'C:\publicKeys\targetNode.cer'
            Thumbprint           = '7ee7f09d-4be0-41aa-a47f-96b9e3bdec25'
        }
    )
}

InstallWindowsFeature -ConfigurationData $configData
```

## Allowing for Identical Duplicate Resources in a Configuration

DSC does not allow or handle conflicting resource definitions within a configuration. Instead of
trying to resolve the conflict, it simply fails. As configuration reuse becomes more utilized
through composite resources, etc. conflicts will occur more often. When conflicting resource
definitions are identical, DSC should be smart and allow this. With this release, we support having
multiple resource instances that have identical definitions:

```powershell
Configuration IIS_FrontEnd
{
    WindowsFeature FE_IIS         #Identical resource
    {
        Ensure = 'Present'
        Name = 'Web-Server'
    }

    WindowsFeature FTP
    {
        Ensure = 'Present'
        Name = 'Web-FTP-Server'
    }
}

Configuration IIS_Worker
{
    WindowsFeature Worker_IIS      #Identical resource
    {
        Ensure = 'Present'
        Name = 'Web-Server'
    }

    WindowsFeature ASP
    {
        Ensure = 'Present'
        Name = 'Web-ASP-Net45'
    }
}

Configuration WebApplication
{
    IIS_Frontend Web {}

    IIS_Worker ASP {}
}
```

In previous releases, the result would be a failed compilation due to a conflict between the
WindowsFeature FE_IIS and WindowsFeature Worker_IIS instances trying to ensure the 'Web-Server' role
is installed. Notice that *all* of the properties that are being configured are identical in these
two configurations. Since *all* of the properties in these two resources are identical, this will
result in a successful compilation now.

If any of the properties are different between the two resources, they will not be considered
identical and compilation will fail.

## DSC module and configuration signing validations

In DSC, configurations and modules are distributed to managed computers from the pull server. If the
pull server is compromised, an attacker can potentially modify the configurations and modules on the
pull server and have it distributed to all managed nodes.

In WMF 5.1, DSC supports validating the digital signatures on catalog and configuration (.MOF)
files. This feature prevents nodes from executing configurations or module files which are not
signed by a trusted signer or which have been tampered with after they have been signed by trusted
signer.

### How to sign configuration and module

- Configuration Files (.MOFs): The existing PowerShell cmdlet [Set-AuthenticodeSignature](/powershell/module/Microsoft.PowerShell.Security/Set-AuthenticodeSignature)
  is extended to support signing of MOF files.
- Modules: Signing of modules is done by signing the corresponding module catalog using the
  following steps:
  1. Create a catalog file: A catalog file contains a collection of cryptographic hashes or
     thumbprints. Each thumbprint corresponds to a file that is included in the module. The new
     cmdlet [New-FileCatalog](/powershell/module/microsoft.powershell.security/new-filecatalog), has been added
     to enable users to create a catalog file for their module.
  2. Sign the catalog file: Use [Set-AuthenticodeSignature](/powershell/module/Microsoft.PowerShell.Security/Set-AuthenticodeSignature)
     to sign the catalog file.
  3. Place the catalog file inside the module folder. By convention, module catalog file should be
     placed under the module folder with the same name as the module.

### LocalConfigurationManager settings to enable signing validations

#### Pull

The LocalConfigurationManager of a node performs signing validation of modules and configurations
based on its current settings. By default, signature validation is disabled. Signature validation
can enabled by adding the 'SignatureValidation' block to the meta-configuration definition of the
node as shown below:

```powershell
[DSCLocalConfigurationManager()]
Configuration EnableSignatureValidation
{
    Settings
    {
        RefreshMode = 'PULL'
    }

    ConfigurationRepositoryWeb pullserver{
      ConfigurationNames = 'sql'
      ServerURL = 'http://localhost:8080/PSDSCPullServer/PSDSCPullServer.svc'
      AllowUnsecureConnection = $true
      RegistrationKey = 'd6750ff1-d8dd-49f7-8caf-7471ea9793fc' # Replace this with correct registration key.
    }
    SignatureValidation validations{
        # If the TrustedStorePath property is provided then LCM will use the custom path. Otherwise, the LCM will use default trusted store path (Cert:\LocalMachine\DSCStore) to find the signing certificate.
        TrustedStorePath = 'Cert:\LocalMachine\DSCStore'
        SignedItemType = 'Configuration','Module'         # This is a list of DSC artifacts, for which LCM need to verify their digital signature before executing them on the node.
    }

}
EnableSignatureValidation
Set-DscLocalConfigurationManager -Path .\EnableSignatureValidation -Verbose
```

Setting the above metaconfiguration on a node enables signature validation on downloaded
configurations and modules. The Local Configuration Manager performs the following steps to verify
the digital signatures.

1. Verify the signature on a configuration file (.MOF) is valid using the
   `Get-AuthenticodeSignature` cmdlet.
2. Verify the certificate authority that authorized the signer is trusted.
3. Download module/resource dependencies of the configuration to a temp location.
4. Verify the signature of the catalog included inside the module.
   - Find a `<moduleName>.cat` file and verify its signature using `Get-AuthenticodeSignature`.
   - Verify the certification authority that authenticated the signer is trusted.
   - Verify the content of the modules has not been tampered using the new cmdlet `Test-FileCatalog`.
5. `Install-Module` to `$env:ProgramFiles\WindowsPowerShell\Modules\`
6. Process configuration

> [!NOTE]
> Signature validation on module-catalog and configuration is only performed when the configuration
> is applied to the system for the first time or when the module is downloaded and installed.
> Consistency runs do not validate the signature of Current.mof or its module dependencies. If
> verification has failed at any stage, for instance, if the configuration pulled from the pull
> server is unsigned, then processing of the configuration terminates with the error shown below and
> all temporary files are deleted.

![Sample Error Output Configuration](media/DSC-improvements/PullUnsignedConfigFail.png)

Similarly, pulling a module whose catalog is not signed results in the following error:

![Sample Error Output Module](media/DSC-improvements/PullUnisgnedCatalog.png)

#### Push

A configuration delivered by using push might be tampered with at its source before it delivered to
the node. The Local Configuration Manager performs similar signature validation steps for pushed or
published configuration(s). Below is a complete example of signature validation for push.

- Enable signature validation on the node.

  ```powershell
  [DSCLocalConfigurationManager()]
  Configuration EnableSignatureValidation
  {
      Settings
      {
          RefreshMode = 'PUSH'
      }
      SignatureValidation validations{
          TrustedStorePath = 'Cert:\LocalMachine\DSCStore'
          SignedItemType =  'Configuration','Module'
      }

  }
  EnableSignatureValidation
  Set-DscLocalConfigurationManager -Path .\EnableSignatureValidation -Verbose
  ```

- Create a sample configuration file.

  ```powershell
  # Sample configuration
  Configuration Test
  {

      File foo
      {
          DestinationPath =  "$env:TEMP\signingTest.txt"
          Contents = "ABC"
      }
  }
  Test
  ```

- Try pushing the unsigned configuration file in to the node.

  ```powershell
  Start-DscConfiguration -Path .\Test -Wait -Verbose -Force
  ```

  ![Error - Unsigned MOF file pushed](media/DSC-improvements/PushUnsignedMof.png)

- Sign the configuration file using code-signing certificate.

  ![Sign the MOF file](media/DSC-improvements/SignMofFile.png)

- Try pushing the signed MOF file.

  ![Push the signed MOF file](media/DSC-improvements/PushSignedMof.png)
