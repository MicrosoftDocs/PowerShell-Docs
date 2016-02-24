# New built-in DSC resources

WMF 5.0 RTM has 4 new DSC resources: 
* WindowsFeatureSet
* WindowsOptionalFeatureSet
* ServiceSet
* ProcessSet 

These resources provide an easy way to configure multiple instances using a single resource call.

## WindowsFeatureSet

```powershell
# Get the syntax of WindowsFeatureSet resource
Get-DscResource -Module psdesiredstateconfiguration -Name WindowsFeatureSet -Syntax

WindowsFeatureSet [String] #ResourceName
{
	[DependsOn = [String[]]]
	Name = [String[]]
	[Ensure = [String]]
	[Source = [String]]
	[IncludeAllSubFeature = [Boolean]]
	[Credential = [PSCredential]]
	[LogPath = [String]]
}
```

## WindowsOptionalFeatureSet 

```powershell
# Get the syntax of WindowsOptionalFeatureSet resource
Get-DscResource -Module psdesiredstateconfiguration -Name WindowsOptionalFeatureSet -Syntax

WindowsOptionalFeatureSet [String] #ResourceName
{
	[DependsOn = [String[]]]
	Name = [String[]]
	Ensure = [String]
	[Source = [String[]]]
	[RemoveFilesOnDisable = [Boolean]]
	[LogPath = [String]]
	[NoWindowsUpdateCheck = [Boolean]]
	[LogLevel = [String]]
}
```

## ServiceSet 

```powershell
# Get the syntax of ServiceSet resource
Get-DscResource -Module psdesiredstateconfiguration -Name ServiceSet -Syntax

ServiceSet [String] #ResourceName
{
	[DependsOn = [String[]]]
	Name = [String[]]
	[StartupType = [String]]
	[BuiltInAccount = [String]]
	[State = [String]]
	[Ensure = [String]]
	[Credential = [PSCredential]]
}
```

## ProcessSet 

```powershell
# Get the syntax of ProcessSet resource
Get-DscResource -Module psdesiredstateconfiguration -Name ProcessSet -Syntax

ProcessSet [String] #ResourceName
{
    [DependsOn = [String[]]]
    Path = [String[]]
    [Credential = [PSCredential]]
    [Ensure = [String]]
    [StandardOutputPath = [String]]
    [StandardErrorPath = [String]]
    [StandardInputPath = [String]]
    [WorkingDirectory = [String]]
}
```
