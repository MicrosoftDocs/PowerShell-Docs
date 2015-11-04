# Windows PowerShell Desired State Configuration Overview 

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

This topic describes the Windows PowerShell Desired State Configuration (DSC) feature in Windows PowerShell. You can use this topic to get an overview of DSC and to find the documentation resources you need to understand and use DSC.

## Feature description
DSC is a new management platform in Windows PowerShell that enables deploying and managing configuration data for software services and managing the environment in which these services run.

DSC provides a set of Windows PowerShell language extensions, new Windows PowerShell cmdlets, and resources that you can use to declaratively specify how you want your software environment to be configured. It also provides a means to maintain and manage existing configurations.

## Practical applications
Following are some example scenarios where you can use built-in DSC resources to configure and manage a set of computers (also known as target nodes) in an automated way:

* Enabling or disabling server roles and features
* Managing registry settings
* Managing files and directories
* Starting, stopping, and managing processes and services
* Managing groups and user accounts
* Deploying new software
* Managing environment variables
* Running Windows PowerShell scripts
* Fixing a configuration that has drifted away from the desired state
* Discovering the actual configuration state on a given node

## Key Concepts
DSC is a declarative platform used for configuration, deployment, and management of systems. It consists of three primary components:

* [Configurations](configurations.md) are declarative PowerShell scripts which define and configure instances of resources. Upon running the configuration, DSC (and the resources being called by the configuration) will simply “make it so”, ensuring that the system exists in the state laid out by the configuration. DSC configurations are also idempotent: the Local Configuration Manager (LCM) will continue to ensure that machines are configured in whatever state the configuration declares.
* Resources are the imperative building blocks of DSC which are written to model the various components of a sub-system and implement the control flow of their changing states. They reside within PowerShell modules and can be written to model something as generic as a file or a Windows process or as specific as an IIS server or a VM running in Azure.
* The Local Configuration Manager (LCM) is the engine by which DSC facilitates the interaction between resources and configurations. The LCM regularly polls the system using the control flow implemented by resources to ensure that the state laid out by a Configuration is maintained. If the system is out of state, the LCM uses more logic inside of the resources to “make it so” according to the Configuration declaration. 

DSC also includes a number of new language keywords, cmdlets and tools that allow creation of configurations, help build DSC resources, invoke configurations, and manage the LCM. Many of these cmdlets can be found in Windows 8.1 as part of the PsDesiredStateConfig module (including `Start-DscConfiguration`, `Set-DscLocalConfigurationManager`, and `Get-DscResource`). The xDscResourceDesigner (found in the [PowerShell Gallery](https://www.powershellgallery.com/packages/xDSCResourceDesigner/)) is a collection of cmdlets that simplify the development of DSC resources.

## See Also
* [DSC Configurations](configurations.md)
* [DSC Resources](resources.md)
* [Configuring The Local Configuration Manager](metaconfig.md)

