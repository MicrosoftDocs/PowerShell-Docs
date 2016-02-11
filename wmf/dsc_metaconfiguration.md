# Configure DSC LCM with new meta-configuration attribute

The `DscLocalConfigurationManager` attribute designates a configuration block as a meta-configuration, which is used to configure the DSC Local Configuration Manager. This attribute restricts a configuration to containing only items which configure the DSC Local Configuration Manager. During processing, this configuration generates a `*.meta.mof` file that is then sent to the appropriate target nodes by using the `Set-DscLocalConfigurationManager` cmdlet.

```powershell
[DscLocalConfigurationManager()]
configuration meta
{
    Node localhost
    {
        Settings
        {
            ConfigurationMode = "ApplyAndAutocorrect"
            ConfigurationID = "5603f952-d6c6-4971-88c4-948636bf5c3f"
            RefreshMode = "Pull"
        }
        ConfigurationRepositoryWeb PullServer
        {
            ServerURL = "https://corp.contoso.com/PSDSCPullServer/PSDSCPullServer.svc"
        }
    }
}
```

The above example configures the refresh mode for LCM to use pull mode, changes the configuration mode to ApplyAndAutocorrect, and defines the type and location of the pull server.

This new configuration attribute replaces and extends the functionality of the LocalConfigurationManager resource from PowerShell 4.0. This LocalConfigurationManager is still supported in configurations without this attribute for backwards compatibility.

Meta-resources:

| **Resource Name**            | **Description**                                |
|------------------------------|------------------------------------------------|
| LocalConfigurationManager    | Various settings for DSC engine execution      |
| PartialConfiguration         | Partial configuration settings                 |
| ConfigurationRepositoryWeb   | Web-based configuration repository             |
| ConfigurationRepositoryShare | File share-based configuration repository      |
| ResourceRepositoryWeb        | Web-based resource repository                  |
| ResourceRepositoryShare      | File-based resource repository                 |
| ReportServerWeb              | Web-based reporting endpoint for pull scenario |
