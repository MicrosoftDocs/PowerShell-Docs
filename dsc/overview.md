* Why do I care about DSC? Value add?
    - Fits into PS ecosystem
    - Uses cmdlet coverage
    - Simpler to read/use
    - Separates config from implementation
* Basics of concepts
    - Configs
        + Basics
            * 4 line PUSH config
    - Resources
    - Packaged as PS modules
    - Discovery of resources
            * On-box (Get-DscResource)
            * Gallery (Find/Install-DscResource)
    - Platforms/Availability
        + Windows/Linux
        + Versions 
* Review initial blog post for reference

# Windows PowerShell Desired State Configuration Overview 
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

In addition, you can create custom resources to configure the state of any application or system setting.

## Important functionality
The following list will help you navigate the documentation for DSC.
 
* Get Started with Windows PowerShell Desired State Configuration: Explains how to use Windows PowerShell extensions that are part of DSC to automate an example configuration.
* Windows PowerShell Desired State Configuration Resources: Explains how to create custom resources for if your environment requires a type of configuration that is not provided by the built-in resources that come in DSC for performing basic configuration work.
* Separating Configuration and Environment Data: Demonstrates a structured way to separate the data used in configuration from the configuration logic. This provides modularity, which enables you reuse the data and the logic independently. It also makes it easier to update the data and logic when necessary.
* Windows PowerShell Desired State Configuration Local Configuration Manager: Explains the DSC engine, which is available on all nodes (computers) and coordinates the reception and application of configuration data for each node.
* Windows PowerShell Desired State Configuration Pull Servers: Explains the DSC Service, which includes the options to push configuration information to target nodes, or to have an environment where the nodes retrieve the information from a server that is set up for that purpose. The nodes can continue to update and maintain their state, based on the configuration information on that server. It is also possible to use such a server to distribute custom resources to the target nodes.
* Troubleshooting DSC: Provides several techniques you can use to troubleshoot your DSC configuration or to track the progress of its operations.