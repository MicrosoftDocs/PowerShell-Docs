# Configuring the Local Configuration Manager #
Applies To: Windows PowerShell 5.0
The Local Configuration Manager (LCM) is the engine of Windows PowerShell Desired State Configuration (DSC). The LCM runs on every target node, and is responsible for parsing and enacting configurations that are sent to the node. It is also responsible for a number of other aspects of DSC, including the following:

 - Determining refresh mode (push or pull).
 - Specifying how often a node pulls and enacts configurations.
 - Associating the node with pull servers.
 - Specifying partial configurations.
You use a special type of configuration to configure the LCM to specify each of these behaviors. The following sections describe how to configure the LCM.

**NOTE:** This topic applies to the LCM introduced in Windows PowerShell 5.0. For information about configuring the LCM in Windows PowerShell 4.0, see Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager.
## Writing and enacting an LCM configuration ##
To configure the LCM, you create and run a special type of configuration. To specify an LCM configuration, you use the **DscLocalConfigurationManager** attribute. The following shows a simple configuration that sets the LCM to push mode.
```powershell
[DSCLocalConfigurationManager()]
configuration LCMConfig
{
	    Node localhost
	    {
	        Settings
	        {
	            RefreshMode = 'Push'
		}
	}
} 
```

