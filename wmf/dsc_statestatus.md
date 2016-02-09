# Unified and Consistent State and Status Representation

A series of enhancements have been made in this release for automations built LCM state and DSC status. These include unified and consistent state and status representations, manageable datetime property of status objects returned by Get-DscConfigurationStatus cmdlet and enhanced LCM state details property returned by Get-DscLocalConfigurationManager cmdlet.

The representation of LCM state and DSC operation status are revisited and unified according to following rules:
1.  Notprocessed resource does not impact LCM state and DSC status.
2.  LCM stop processing further resources once it encounters a resource that requests reboot.
3.  A resource that requests reboot is not in desired state until reboot actually happens.
4.  After encountering a resource that fails, LCM keeps processing further resources as long as they are not dependent on the failure one.
5.  The overall status returned by Get-DscConfigurationStatus cmdlet is the super set of all resources’ status.
6.  The PendingReboot state is a superset of PendingConfiguration state.

The table below illustrates the resultant state and status related properties under a few typical scenarios.

| **Scenario**                    | **LCMState\***       | **Status** | **Reboot Requested**  | **ResourcesInDesiredState**  | **ResourcesNotInDesiredState** |
|---------------------------------|----------------------|------------|---------------|------------------------------|--------------------------------|
| S**^**                          | Idle                 | Success    | $false        | S                            | $null                          |
| F**^**                          | PendingConfiguration | Failure    | $false        | $null                        | F                              |
| S,F                             | PendingConfiguration | Failure    | $false        | S                            | F                              |
| F,S                             | PendingConfiguration | Failure    | $false        | S                            | F                              |
| S<sub>1</sub>, F, S<sub>2</sub> | PendingConfiguration | Failure    | $false        | S<sub>1</sub>, S<sub>2</sub> | F                              |
| F<sub>1</sub>, S, F<sub>2</sub> | PendingConfiguration | Failure    | $false        | S                            | F<sub>1</sub>, F<sub>2</sub>   |
| S, r                            | PendingReboot        | Success    | $true         | S                            | r                              |
| F, r                            | PendingReboot        | Failure    | $true         | $null                        | F, r                           |
| r, S                            | PendingReboot        | Success    | $true         | $null                        | r                              |
| r, F                            | PendingReboot        | Success    | $true         | $null                        | r                              |

^
S<sub>i</sub>: A series of resources that applied successfully
F<sub>i</sub>: A series of resources that applied unsuccessfully
r: A resource that requires reboot
\*

```powershell
$LCMState = (Get-DscLocalConfigurationManager).LCMState
$Status = (Get-DscConfigurationStatus).Status

$RebootRequested = (Get-DscConfigurationStatus).RebootRequested

$ResourcesInDesiredState = (Get-DscConfigurationStatus).ResourcesInDesiredState

$ResourcesNotInDesiredState = (Get-DscConfigurationStatus).ResourcesNotInDesiredState
```
## Enhancement in Get-DscConfigurationStatus cmdlet

A few enhancements have been made to Get-DscConfigurationStatus cmdlet in this release. Previously, the StartDate property of objects returned by the cmdlet is of String type. Now, it is of Datetime type, which enables complex selecting and filtering easier based on the intrinsic properties of a Datetime object.
```powershell
(Get-DscConfigurationStatus).StartDate | fl \*
DateTime : Friday, November 13, 2015 1:39:44 PM
Date : 11/13/2015 12:00:00 AM
Day : 13
DayOfWeek : Friday
DayOfYear : 317
Hour : 13
Kind : Local
Millisecond : 886
Minute : 39
Month : 11
Second : 44
Ticks : 635830187848860000
TimeOfDay : 13:39:44.8860000
Year : 2015
```

Following is an example that returns all DSC operation records happened on the same day of week as today.
```powershell
(Get-DscConfigurationStatus –All) | where { $\_.startdate.dayofweek -eq (Get-Date).DayOfWeek }
```

Records of operations that do not make changes to node’s configuration (i.e. read only operations) are eliminated. Therefore, Test-DscConfiguration, Get-DscConfiguration operations are no longer adulterated in returned objects from Get-DscConfigurationStatus cmdlet.
Records of meta configuration setting operation is added to the return of Get-DscConfigurationStatus cmdlet.

Following is an example of result returned from Get-DscConfigurationStatus –All cmdlet.
```powershell
All configuration operations:

Status StartDate Type RebootRequested
------ --------- ---- ---------------
Success 11/13/2015 11:38:16 AM Consistency False
Success 11/13/2015 11:23:16 AM Reboot False
Success 11/13/2015 11:21:43 AM Reboot True
Success 11/13/2015 11:20:44 AM Initial True
Success 11/13/2015 11:20:44 AM LocalConfigurationManager False
```

## Enhancement in Get-DscLocalConfigurationManager cmdlet
A new field of LCMStateDetail is added to the object returned from Get-DscLocalConfigurationManager cmdlet. This field is populated when LCMState is “Busy”. It can be retrieved by following cmdlet:
```powershell
(Get-DscLocalConfigurationManager).LCMStateDetail
```

Following is an example output of a continuous monitoring on a configuration that requires two reboots on a remote node.
```powershell
Start a configuration that requires two reboots

Monitor LCM State:
LCM State: Busy, LCM is applying a new configuration.
LCM State: PendingReboot,
Machine is rebooting...
LCM State: Busy, LCM is continuing applying configuration after last reboot.
LCM State: PendingReboot,
Machine is rebooting...
LCM State: Busy, LCM is continuing applying configuration after last reboot.
LCM State: Idle,
LCM State: Busy, LCM is performing a consistency check.
LCM State: Idle,
```
