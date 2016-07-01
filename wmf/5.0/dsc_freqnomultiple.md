# Frequencies for RefreshMode and ConfigurationMode don't need to be multiples of each other

In the previous version of DSC, the LCM would treat `RefreshFrequencyMins` and `ConfigurationModeFrequencyMins` as multiples of each other. In WMF 5.0 RTM, these properties are processed 
independent of each other. 

For more information, see [Configuring the Local Configuration Manager](../dsc/metaConfig.md).