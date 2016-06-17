---
title:   Specifying cross-node dependencies
ms.date:  2016-05-16
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# Specifying cross-node dependencies

> Applies To: Windows PowerShell 5.0

DSC provides special resources, **WaitForAll**, **WaitForAny**, and **WaitForSome** that can be used in configurations to specify dependencies on configurations on other nodes. The
behavior of these resources is as follows:

* **WaitForAll**: Succeeds if the specified resource is in the desired state on all target nodes defined in the **NodeName** property.
* **WaitForAny**: Succeeds if the specified resource is in the desired state on at least one of the target nodes defined in the **NodeName** property.
* **WaitForSome**: Specifies a **NodeCount** property in addition to a **NodeName** property. The resource succeeds if the resource is in the desired state on a minimum number of nodes 
(specified by **NodeCount**) defined by the **NodeName** property. 

## Using WaitForXXXX resources

To use the **WaitForXXXX** resources, you create a resource block of that resource type that specifies the DSC resource and node(s) to wait for. You then use the **DependsOn** property
in any other resource blocks in your configuration to wait for the conditions specified in the **WaitForXXXX** node to succeed.

For example, in the following configuration, the target node is waiting for the **xADDomain** resource to finish on the **MyDC** node with maximum number of 30 retries, at 15-second intervals, before the target node 
can join the domain.

```PowerShell
Configuration JoinDomain

{
	Import-DscResource -Module xComputerManagement

    Node myDomainJoinedServer
    {

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
		    Credential       = (Get-Credential)
		    DependsOn        ='[WaitForAll]DC'
	    }
    }
}
```

>**Note:** By default the WaitForXXX resources try one time and then fail. Although it is not required, you will typically want to specify a retry interval and count.

## See Also
* [DSC Configurations](configurations.md)
* [DSC Resources](resources.md)
* [Configuring The Local Configuration Manager](metaConfig.md)

