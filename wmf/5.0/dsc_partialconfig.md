# Configure Node with multiple configuration fragments (partial configurations)

WMF 5.0 helps you deliver configuration documents to a node in fragments. For a node to receive multiple fragments of a configuration document, its Local Configuration Manager (LCM) must be set to specify the expected fragments, as shown in this example.

```powershell
[DSCLocalConfigurationManager()]
configuration SQLServerDSCSettings
{
    Node localhost
    {
        Settings
        {
            ConfigurationModeFrequencyMins = 30
        }

        ConfigurationRepositoryWeb OSConfigServer
        {
            ServerURL = "https://corp.contoso.com/OSConfigServer/PSDSCPullServer.svc"
        }

        ConfigurationRepositoryWeb SQLConfigServer
        {
            ServerURL = "https://corp.contoso.com/SQLConfigServer/PSDSCPullServer.svc"
        }

        PartialConfiguration OSConfig
        {
            Description = 'Configuration for the Base OS'
            ExclusiveResources = 'PSDesiredStateConfiguration\*'
            ConfigurationSource = '[ConfigurationRepositoryWeb]OSConfigServer'
        }

        PartialConfiguration SQLConfig
        {
            Description = 'Configuration for the SQL Server'
            ConfigurationSource = '[ConfigurationRepositoryWeb]SQLConfigServer'
            DependsOn = '[PartialConfiguration]OSConfig'
        }
    }
}
```

In a partial configuration, the configuration name must match what is defined in the LCM. In the above example, the configurations should be named `OSConfig` and `SQLConfig`.

Setting the LCM for partial configurations enables configuration coordination, but does NOT provide security functionality.