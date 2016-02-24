# Frequencies for RefreshMode and ConfigurationMode don't need to be multiples of each other

In the previous version of DSC, the LCM would treat `RefreshFrequencyMins` and `ConfigurationModeFrequencyMins` as multiples of each other as explained in the blog [here](http://blogs.msdn.com/b/powershell/archive/2013/12/09/understanding-meta-configuration-in-windows-powershell-desired-state-configuration.aspx). In WMF 5.0 RTM, these properties are processed independent of each other. The tables below illustrate this behavior:

Behaviour in **PULL** mode: 

|                                  |**Value in Meta Configuration**|**Value after Meta Configuration is applied**|**How often pull happens (in mins)**|**How often configuration is applied (in mins)**|
|----------------------------------|-------------------------------|---------------------------------------------|------------------------------------|------------------------------------------------|
|**ConfigurationModeFrequencyMins**|70							   |70											 |									  |70											   |
|**RefreshFrequencyMins**          |40							   |40											 |40								  |											  	   |

Behavior in **PUSH** mode:

|								   |**Value in Meta Configuration**|**Value after Meta Configuration is applied**|**How often configuration is applied (in mins)**|
|----------------------------------|-------------------------------|---------------------------------------------|------------------------------------------------|
|**ConfigurationModeFrequencyMins**|70							   |70											 |70											  |
|**RefreshFrequencyMins**		   |40							   |40											 |												  |
