# DSC Configurations #

DSC configurations are PowerShell scripts that define a special type of function. 
To define a configurations, you use the PowerShell keyword called **```powershell
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
```Configuration**.

The following configuration, when compiled and run, would ensure that the Windows features RSAT and BitLocker are present on a target computer named "TEST-PC1".

## Configuration sytax
A configuration script consists of the following parts:
- The **Configuration** block. This is the outermost script block. You define it by using the **Configuration** keyword and providing a name. In this case, the name of the configuration is "MyDscConfiguration".
- One or more **Node** blocks. These define the nodes (computers or VMs) that you are configuring. In the above configuration, there is one **Node** block that targets a computer named "TEST-PC1".
- One or more resource blocks. This is where the configuration sets the properties for the resources that it is configuring. In this case, there are two resource blocks, each of which call the "WindowsFeature" resource.

Within a **Configuration** block, you can do anything that you normally could in a PoweShell function. For example, in the previous example, if you didn't want to hard code the name of the target computer in the configuration, you could add a parameter for the node name:

```powershell
Configuration MyDscConfiguration {

	param(
        [string[]]$computerName="localhost"
    )


	Node $computerName {
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
```

In this example, you specify the name of the node by passing it as the $computerName parameter when you [compile the configuraton](# Compiling the configuration). The name defaults to "localhost".

