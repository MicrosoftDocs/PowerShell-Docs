# Details about Configuration Status

The `Get-DscConfigurationStatus` cmdlet gets information about configuration status from a target node. A rich object is returned that includes high-level information about whether or not the configuration run was successful or not. You can dig into the object to discover details about the configuration run such as:

* All of the resources that failed
* Any resource that requested a reboot
* Meta-Configuration settings at time of configuration run
* Etc.

The following parameter set returns the status information for the last configuration run:

```powershell
Get-DscConfigurationStatus 	[-CimSession <CimSession[]>] 
							[-ThrottleLimit <int>] 
							[-AsJob] 
							[<CommonParameters>]
```
The following parameter set returns the status information for all previous configuration runs:

```powershell
Get-DscConfigurationStatus 	-All 
							[-CimSession <CimSession[]>] 
							[-ThrottleLimit <int>] 
							[-AsJob] 
							[<CommonParameters>]
```

## Example

```powershell
PS C:\> $Status = Get-DscConfigurationStatus 

PS C:\> $Status

Status 		StartDate				Type			Mode	RebootRequested		NumberOfResources
------		---------				----			----	---------------		-----------------
Failure		11/24/2015  3:44:56 	Consistency		Push	True				36

PS C:\> $Status.ResourcesNotInDesiredState

ConfigurationName		:	MyService
DependsOn				:	
ModuleName				:	PSDesiredStateConfiguration
ModuleVersion			:	1.1
PsDscRunAsCredential	:	
ResourceID 				:	[File]ServiceDll
SourceInfo				:	c:\git\CustomerService\Configs\MyCustomService.ps1::5::34::File
DurationInSeconds		:	0.19
Error					:	SourcePath must be accessible for current configuration. The related file/directory is:
							\\Server93\Shared\contosoApp.dll. The related ResourceID is [File]ServiceDll
FinalState				:	
InDesiredState 			:	False
InitialState 			:	
InstanceName			:	ServiceDll
RebootRequested			:	False
ReosurceName			:	File
StartDate				:	11/24/2015  3:44:56
PSComputerName			:
```