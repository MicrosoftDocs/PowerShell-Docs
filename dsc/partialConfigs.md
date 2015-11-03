# PowerShell Desired State Configuration partial configurations

>Applies To: Windows PowerShell 5.0

In PowerShell 5.0, Desired State Configuration (DSC) allows configurations to be delivered in fragments and from multiple sources. The Local Configuration Manager (LCM) on the target node puts the fragments together before applying them as a single configuration. This capability allows sharing control of configuration between teams or individuals. For example, if two or more teams of developers are collaborating on a service, they might each want to create configurations to manage their part of the service. Each of these configurations could be pulled from different pull servers, and they could be added at different stages of development. Partial configurations also allow different individuals or teams to control different aspects of configuring nodes without having to coordinate the editing of a single configuration document. For example, one team might be responsible for deploying a VM and operating system, while another team might deploy other applications and services on that VM. With partial configurations, each team can create its own configuration, without either of them being unnecessarily complicated.

You can use partial configurations in push mode, pull mode, or a combination of the two.

## Partial configurations in push mode
To use partial configurations in push mode, you configure the LCM on the target node to receive the partial configurations. Each partial configuration must be pushed to the target by using the Publish-DSCConfiguration cmdlet. The target node then combines the partial configuration into a single configuration, and you can apply the configuration by calling the [Start-DscConfigurationxt](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet.

### Configuring the LCM for push-mode partial configurations
To configure the LCM for partial configurations in push mode, you create a **DSCLocalConfigurationManager** configuration with one **PartialConfiguration** block for each partial configuration. For more information about configuring the LCM, see [Windows Configuring the Local Configuration Manager](https://technet.microsoft.com/en-us/library/mt421188.aspx). The following example shows an LCM configuration that expects two partial configurations—one that deploys the OS, and one that deploys and configures SharePoint.

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemo
{
    Node localhost
    {
        
           PartialConfiguration OSInstall
        {
            Description = 'Configuration for the Base OS'
            RefreshMode = 'Push'
        }
           PartialConfiguration SharePointConfig
        {
            Description = 'Configuration for the SharePoint server'
            RefreshMode = 'Push'
        }
    }
}
PartialConfigDemo 
```

The **RefreshMode** for each partial configuration is set to "Push". The names of the **PartialConfiguration** blocks (in this case, "OSInstall" and "SharePointConfig") must match exactly the names of the configurations that are pushed to the target node.

### Publishing and starting push-mode partial configurations
![PartialConfig folder structure](./images/PartialConfig1.jpg)

You then call **Publish-DSCConfiguration** for each configuration, passing the folders that contain the configuration documents as the Path parameters. After publishing both configurations, you can call `Start-DSCConfiguration –UseExisting` on the target node.

## Partial configurations in pull mode

Partial configurations can be pulled from one or more pull servers (for more information about pull servers, see [Windows PowerShell Desired State Configuration Pull Servers](pullServer.md). To do this, you have to configure the LCM on the target node to pull the partial configurations, and name and locate the configuration documents properly on the pull servers.

### Configuring the LCM for pull node configurations

To configure the LCM to pull partial configurations from a pull server, you define the pull server in either a **ConfigurationRepositoryWeb** (for an HTTP pull server) or **ConfigurationRepositoryShare** (for an SMB pull server) block. You then create **PartialConfiguration** blocks that refer to the pull server by using the **ConfigurationSource** property. You also need to create a Settings block to specify that the LCM uses pull mode, and to specify the ConfigurationID that the pull server and target node use to identify the configurations. The following meta-configuration defines an HTTP pull server named CONTOSO-PullSrv and two partial configurations that use that pull server.

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemo
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            
        }
        
           PartialConfiguration OSInstall
        {
            Description = 'Configuration for the Base OS'
            ConfigurationSource = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            RefreshMode = 'Pull'
        }
           PartialConfiguration SharePointConfig
        {
            Description = 'Configuration for the Sharepoint Server'
            ConfigurationSource = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            DependsOn = [PartialConfiguration]OSInstall
            RefreshMode = 'Pull'
        }
    }
}
PartialConfigDemo 
```

You can pull partial configurations from more than one pull server—you would just need to define each pull server, and then refer to the appropriate pull server in each PartialConfiguration block.

After creating the meta-configuration, you must run it to create a configuration document (a MOF file), and then call [Set-DscLocalConfigurationManager](https://technet.microsoft.com/en-us/library/dn521621(v=wps.630).aspx) to configure the LCM.

### Naming and placing the configuration documents on the pull server

The partial configuration documents must be placed in the folder specified as the **ConfigurationPath** in the `web.config` file for the pull server (typically `C:\Program Files\WindowsPowerShell\DscService\Configuration`). The configuration documents must be named as follows: _ConfigurationName_. _ConfigurationID_`.mof`, where _ConfigurationName_ is the name of the partial configuration and _ConfigurationID_ is the configuration ID defined in the LCM on the target node. For our example, the configuration documents should be names as follows.
![PartialConfig names on pull server](images/PartialConfigPullServer.jpg)

### Running partial configurations from a pull server

After the LCM on the target node has been configured, and the configuration documents have been created and properly named on the pull server, the target node will pull the partial configurations, combine them, and apply the resulting configuration at regular intervals as specified by the **RefreshFrequencyMins** property of the LCM. If you want to force a refresh, you can call the Update-DscConfiguration cmdlet, to pull the configurations, and then `Start-DSCConfiguration –UseExisting` to apply them.

## Partial configurations in mixed push and pull modes

You can also mix push and pull modes for partial configurations. That is, you could have one partial configuration that is pulled from a pull server, while another partial configuration is pushed. Treat each partial configuration as you would, depending on its refresh mode as described in the previous sections. For example, the following meta-configuration describes the same example, with the operating system partial configuration in pull mode and the SharePoint partial configuration in push mode.

```powershell
[DSCLocalConfigurationManager()]
configuration PartialConfigDemo
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            ConfigurationID = '1d545e3b-60c3-47a0-bf65-5afc05182fd0'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv
        {
            ServerURL = 'https://CONTOSO-PullSrv:8080/PSDSCPullServer.svc'
            
        }
        
           PartialConfiguration OSInstall
        {
            Description = 'Configuration for the Base OS'
            ConfigurationSource = '[ConfigurationRepositoryWeb]CONTOSO-PullSrv'
            RefreshMode = 'Pull'
        }
           PartialConfiguration SharePointConfig
        {
            Description = 'Configuration for the Sharepoint Server'
            DependsOn = [PartialConfiguration]OSInstall
            RefreshMode = 'Push'
        }
    }
}
PartialConfigDemo 
```

Note that the **RefreshMode** specified in the Settings block is "Pull", but the **RefreshMode** for the OSInstall partial configuration is "Push".

You would name and locate the configuration documents as described above for their respective refresh modes. You would call **Publish-DSCConfiguration** to publish the SharePointInstall partial configuration, and either wait for the OSInstall configuration to be pulled from the pull server, or force a refresh by calling [Update-DscConfiguration](https://technet.microsoft.com/en-us/library/mt143541(v=wps.630).aspx).

##See Also 

**Concepts**
[Windows PowerShell Desired State Configuration Pull Servers](pullServer.md) 
[Windows Configuring the Local Configuration Manager](https://technet.microsoft.com/en-us/library/mt421188.aspx) 
