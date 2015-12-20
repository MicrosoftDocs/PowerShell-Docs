# Frequencies for RefreshMode and ConfigurationMode need not be multiple of each other

There have been some improvements to Windows PowerShell debugging after WMF 5.0 September Preview.

-   The Enter-PSHostProcess cmdlet has a new, optional **AppDomainName** parameter. If you specify this parameter, Enter-PSHostProcess tries to connect to the specified app domain in the target process. If you do not specify this parameter, Enter-PSHostProcess tries to connect to the default domain in the process.

-   Get-PSHostProcessInfo now returns AppDomain names along with processes to which you can connect by running the Enter-PSHostProcess cmdlet.

DSC RefreshFrequencyMins and ConfigurationModeFrequencyMins are no longer required to be multiple of each other
---------------------------------------------------------------------------------------------------------------

In the previous version of DSC, LCM would treat RefreshFrequencyMins and ConfigurationModeFrequencyMins as multiple of each other as explained in the blog [here](http://blogs.msdn.com/b/powershell/archive/2013/12/09/understanding-meta-configuration-in-windows-powershell-desired-state-configuration.aspx). In WMF 5.0 RTM RefreshFrequencyMins and ConfigurationModeFrequencyMins are processed independent of each other.

To illustrate this behavior in PULL mode, let us look at the table below:

|                                    | **Value in Meta Configuration** | **Value after Meta Configuration is applied** | **How often pull happens \[mins\]** | **How often configuration is applied \[mins\]** |
|------------------------------------|---------------------------------|-----------------------------------------------|-------------------------------------|-------------------------------------------------|
| **ConfigurationModeFrequencyMins** | 70                              | 70                                            | 40                                  | 70                                              |
| **RefreshFrequencyMins**           | 40                              | 40                                            |                                     |                                                 |

Behavior in PUSH mode in explained below:

|                                    | **Value in Meta Configuration** | **Value after Meta Configuration is applied** | **How often configuration is applied \[mins\]** |
|------------------------------------|---------------------------------|-----------------------------------------------|-------------------------------------------------|
| **ConfigurationModeFrequencyMins** | 70                              | 70                                            | 70                                              |
| **RefreshFrequencyMins**           | 40                              | 40                                            |                                                 |
