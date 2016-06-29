# Separation of Configuration, Resource and Report Repositories

In this release we allow you all of the flexibility that you need to pull and report to one or more DSC Pull Servers. Each endpoint can be defined separately so that you can pull configurations from one location, resources from another and report to yet another location. The following meta-configuration does just this.

```PowerShell
[DscLocalConfigurationManager()]
Configuration SampleMetaConfig
{
	Settings
	{
		RefreshMode = "PULL";
		AllowModuleOverwrite = $true;
		RebootNodeIfNeeded = $true;
	}

	ConfigurationRepositoryWeb Configurations
	{
		ServerURL = “https://PullServerMachine:8080/psdscpullserver.svc”
		RegistrationKey = "140a952b-b9d6-406b-b416-e0f759c9c0e4"
	}

    ResourceRepositoryWeb Resources
    {
        ServerURL = “https://ResourceServer:8080/psdscpullserver.svc”
		RegistrationKey = "aaaf952b-b9d6-406b-b416-e0f759c6e000"
    }

    ReportServerWeb Reports
    {
        ServerURL = “https://ReportServer:8080/psdscpullserver.svc”
		RegistrationKey = "fefe592b-b9d6-046b-b146-e0f759c0c0c0"
    }
}
```

Additionally you can use any combination of these. The following meta-configuration configures a target node in push mode but the node will pull resources that it does not have installed from a 'DSC Pull server' and report its status to another 'DSC Pull Server.


```PowerShell
[DscLocalConfigurationManager()]
Configuration SampleMetaConfig
{
	Settings
	{
		RefreshMode = "Push";
		RebootNodeIfNeeded = $true;
	}

    ResourceRepositoryWeb Resources
    {
        ServerURL = “https://ResourceServer:8080/psdscpullserver.svc”
		RegistrationKey = "aaaf952b-b9d6-406b-b416-e0f759c6e000"
    }

    ReportServerWeb Reports
    {
        ServerURL = “https://ReportServer:8080/psdscpullserver.svc”
		RegistrationKey = "fefe592b-b9d6-046b-b146-e0f759c0c0c0"
    }
}
```