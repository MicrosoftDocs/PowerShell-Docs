# Detailed information about LCM state

We have made improvements in exposing details about the LCM state. The LCMState that is returned by Get-DscLocalConfigurationManager can now contain the following values:

* **Idle**
* **Busy**
* **PendingReboot**
* **PendingConfiguration**

We have also added an LCMStateDetail property that contains more information about the state.
