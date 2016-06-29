# Support for mixed RefreshMode

When you use partial configurations, you can now define each individual partial configuration with a `RefreshMode`. Valid values are `PUSH` or `PULL`.

```powershell
[DscLocalConfigurationManager()]
Configuration partialMeta
{
    Settings
    {
        RefreshMode = "PULL"
        RefreshFrequencyMins = 30
        ConfigurationModeFrequencyMins = 15
        ConfigurationMode = "ApplyAndAutoCorrect"
        RebootNodeIfNeeded = $false
        ConfigurationId = "922A3987-6647-4665-B770-0FD008436CE3"
    }

    PartialConfiguration Partial1
    {
        RefreshMode = "PUSH"
        Description = "Partial1"
    }

    PartialConfiguration Partial2
    {
        RefreshMode = "PULL"
        Description = "Partial1"
        ConfigurationSource = "[ConfigurationRepositoryShare]FileShare"
        DependsOn = "[PartialConfiguration]Partial1"
    }

    PartialConfiguration Partial3
    {
        RefreshMode = "PUSH"
        Description = "Partial3"
        ConfigurationSource = "[ConfigurationRepositoryWeb]PullServerWeb1"
        DependsOn = "[PartialConfiguration]Partial2"
    }

    ConfigurationRepositoryShare FileShare
    {
        SourcePath = "\\testserver\pullserver"
    }

}
```
