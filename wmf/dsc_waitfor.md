# Specifying Cross Node Dependencies

By using the built-in WaitFor\* resources (WaitForAll, WaitForAny, and WaitForSome), you can now specify dependencies across computers during configuration runs, without external orchestration. The behavior or each WaitFor\* resource is:

* **WaitForAll** Waits for the specified resource to be in the desired state on *All* target nodes defined in the NodeName property.
* **WaitForAny** Waits for the specified resource to be in the desired state on *Any* target node defined in the NodeName property.
* **WaitForSome** Waits for the specified resource to be in the desired state on specific number, defined by the property NodeCount, of target nodes defined in the NodeName property.

These resources provide node-to-node synchronization by using CIM connections over the WS-Man protocol. By using these resources, a configuration can wait for another computer’s specific resource state to change before it continues with its own configuration. 

For example, in the following configuration, the target node is waiting for the **xADDomain** resource to finish on the **MyDC** node with a few retries, before the target node can join the domain.

```PowerShell
Configuration JoinDomain

{
	Import-DscResource -Module xComputerManagement

	WaitForAll DC
	{
		ResourceName      = '[xADDomain]NewDomain'
		NodeName          = 'MyDC'
		RetryIntervalSec  = 15
		RetryCount        = 30
	}

	xComputer JoinDomain
	{
		Name             = 'MyPC'
		DomainName       = 'Contoso.com'
		Credential       = (get-credential)
		DependsOn        ='[WaitForAll]DC'
	}
}
```
**Hint:** By default the WaitFor\* resources try one time and then fail so although it is not required, you will typically want to specify a retry interval and count.
