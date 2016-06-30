# Separation of Node and Configuration IDs

## Overview

In order to provide a more flexible and streamlined experience when using DSC in Pull mode, we have added a number of features in this release. These features are intended to allow you to have the flexibility to easily setup and deploy configurations across multiple nodes, while still tracking status and reporting information for each node individually. These features are as follows:

* A configuration name which identifies the configuration for a computer. This name can be shared by multiple target nodes 
* An agent ID which uniquely identifies a single node
* A registration step which only occurs the first time a target node connects to a pull server

**Note:** These features and functionality have been added and do not replace the existing pull features and concepts. You can use these new features or the older ones with the new pull server shipping in this release.

## Agent ID

This feature is for users who do not want to setup and manage unique identifiers for each target node. Now, there is no more bookkeeping of GUIDs required. DSC automatically generates an agent ID that it uses when communicating with the pull server. This ID is used by the pull server to uniquely identify all information with a given node. It also means that you do not need to set up each target node with a unique meta-configuation containing a unique ID so a single meta-configuation can be used by many target nodes while still retaining each node's unique identity. 

## Configuration name

The configuration name is a friendly name that defines that name of the configuration that a target node will apply. The changes associated to this are as follows:  

### Friendly naming

This can be any string! It does not need to be in the format of a GUID so a configuration that sets up SQL server can simply be named 'SQL_Server'. This makes it much easier to identify what a given configuration does.

### Assignment

The configuration that a target node is assigned is centrally managed on the pull server. This can be bootstrapped by defining the ConfigrationName property in the meta-configuration but this is only used during registration. After registration, the server tells the target node what configuration it will get. For the on-premises pull server this mapping between configurations and target nodes can only be done during registration, but in Azure Automation these changes can be made easily in the UI or through their cmdlets. To change the configuration assigned to a target node for the on-premises pull server you can re-run registration.

### Multiple/Partial configurations

If multiple configuration names are assigned to a target node, they will be treated like partial configurations. In order for this to work, the meta-configuration on the target node must be configured to accept the partial configurations. **Note:** This is only supported on the on-premises pull server. Azure Automation does not support partial configurations.

## Registration

Because configuration names are no longer GUIDs (they are now friendly names), anyone can guess them. To mitigate the inherent security issue with this, we added a registration step before a node can start requesting configurations from a server. A node registers itself with the pull server with a shared secret (which the node and the server both know already), and, optionally, the name of the configuration it will request. This shared secret doesn't have to be unique for each computer. Assumption: the shared secret is a hard-to-guess identifier, like a GUID. This shared secret is defined by the **RegistrationKey** property in the target node's meta-configuration.

### Example meta-configuration

```powershell
[DscLocalConfigurationManager()]
Configuration SampleMetaConfig
{
	Settings
	{
		RefreshMode = "PULL";
		AllowModuleOverwrite = $true;
		RebootNodeIfNeeded = $true;
		ConfigurationModeFrequencyMins = 60;
	}

	ConfigurationRepositoryWeb ConfigurationManager
	{
		ServerURL = “https://PullServerMachine:8080/psdscpullserver.svc”
		RegistrationKey = "140a952b-b9d6-406b-b416-e0f759c9c0e4"
		ConfigurationNames = @(“WebRole”)
	}
}

SampleMetaConfig
```

The RegistrationKey value must be defined by on the pull server. In order to do this while setting up the pull server, create a text file with the name **RegistrationKeys.txt** in a specific location, and then set this location in the web.config of the pull server, as shown below.  

```XML
<add key="ConfigurationPath" value="C:\Program Files\WindowsPowerShell\DscService\Configuration">

<add key="ModulePath" value="C:\Program Files\WindowsPowerShell\DscService\Modules">

<add key="RegistrationKeyPath" value="C:\Program Files\WindowsPowerShell\DscService">
```

Use the latest version of the xDSCWebService DSC resource to fully deploy an on-premises pull server for use with this. See [Example Configuration](https://github.com/grayzu/PSSummitEU2015/blob/master/PullServer/02%20-%20PullServer%20Config.ps1) for a complete configuration.

**Note:** This feature is not supported when the pull server is set up to be a file share. It is only supported for the web-based pull server.