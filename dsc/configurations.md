# DSC Configurations #

DSC configurations are declarative PowerShell scripts which define and configure instances of resources. Upon running the configuration, DSC (and the resources being called by the configuration) will simply “make it so”, ensuring that the system exists in the state laid out by the configuration. DSC configurations are also idempotent: the Local Configuration Manager (LCM) will continue to ensure that machines are configured in whatever state the configuration declares.
To define these configurations, DSC introduces a new PowerShell keyword called **Configuration**. To use DSC resources to configure your environment, first define a PowerShell script block using the Configuration keyword, followed by an identifier and curly braces **{}** to delimit the block. This creates a function that, when executed, generates a MOF file that can be passed to the LCM. You may have other PowerShell commands and variable definitions outside of this Configuration script block, but it should contain the entirety of your DSC configuration. 

Inside the configuration block you can define **Node** blocks that specify the desired configuration for each node (computer or VM) within your environment. A node block starts with the **Node** keyword, followed by an identifier for the target computer. This identifier can be a hostname, computer name, or IP address, and it may be represented as a variable. After the computer name, delimit the node block as follows:

```powershell
Configuration MyDscConfiguration {
	Node “TEST-PC1” {
		WindowsFeature MyFeatureInstance {
			Ensure = “Present”
			Name =	“RSAT”
		}
		WindowsFeature My2ndFeatureInstance {
			Ensure = “Present”
			Name = “Bitlocker”
		}
	}
}

# Running the configuration function here will generate a MOF file for the LCM
MyDscConfiguration
