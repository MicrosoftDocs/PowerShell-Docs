---
title: Pull Partial Configuration Naming Convention
author:  jaimeo
contributor: berheabrha
---

##Pull Partial Configuration Naming Convention
In the previous releases, the naming convention for a partial configuration was the mof file name in the pull server /service should match the partial configuration name specified in the local configuration manger settings that in turn has to match the configuration name embedded in the MOF file. 
See the snapshots below:-
•	Local configuration settings which defines a partial configuration that a node is allowed to receive.

![Sample metaconfiguration](../../images/MetaConfigPartialOne.png)

•	Sample partial configuration definition 

```Powershell
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

•	‘ConfigurationName’ embedded in the generated MOF file.

![Sample generated mof file](../../images/PartialGeneratedMof.png)

•	FileName in the pull configuration repository 

![FileName in Configuration Repository](../../images/PartialInConfigRepository.png)

Azure Automation service name generated mof files as ``<ConfigurationName>.<NodeName>.mof``. So the configuration below will compile to PartialOne.Localhost.mof.  
This made it impossible to pull a partial configuration from Azure automation service.

```Powershell
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

In WMF 5.1, partial configuration in the pull server/service can be named as ``<ConfigurationName>.<NodeName>.mof``. Moreover, if a machine is pulling a single configuration from a pull server/service then the configuration document on the pull server configuration repository can have any name. This naming flexibility enables managing partial configuration of a node using both onprem and Azure Automation pull service. For example, you can have 'base' partial configuration that gets pushed locally and another partial configuration that gets pulled from Azure Automation Service.

The metaconfiguration below will setup a node to be managed both locally as well as by Azure Automation Service.

```Powershell
  [DscLocalConfigurationManager()]
   Configuration RegistrationMetaConfig
   {
        Settings
        {
            RefreshFrequencyMins = 30;
            RefreshMode = "PULL";            
        }

        ConfigurationRepositoryWeb web
        {
            ServerURL =  $endPoint
            RegistrationKey = $registrationKey
            ConfigurationNames = $configurationName
        }

        # Partial configuration managed by Azure Automation Service.
        PartialConfiguration PartialCOnfigurationManagedByAzureAutomation
        {
            ConfigurationSource = "[ConfigurationRepositoryWeb]Web"   
        }
    
        # This partial configuration is managed locally.
        PartialConfiguration OnPremConfig
        {
            RefreshMode = "PUSH"
            ExclusiveResources = @("Script")
        }

   }

   RegistrationMetaConfig
   slcm -Path .\RegistrationMetaConfig -Verbose
 ```


