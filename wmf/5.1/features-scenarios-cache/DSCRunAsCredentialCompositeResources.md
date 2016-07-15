---
title: PsDscRunAsCredential with DSC Composite Resources
author:  jaimeo
contributor: ?
---
# Using PsDscRunAsCredential with DSC Composite Resources   

We have added a support to use [*PsDscRunAsCredential*](https://msdn.microsoft.com/cs-cz/powershell/dsc/runasuser) with DSC [Composite](https://msdn.microsoft.com/en-us/powershell/dsc/authoringresourcecomposite) resources.    

User can now specify value for PsDscRunAsCredential when using composite resources inside configurations. If it is specified, we run all resources inside composite resource as RunAs user. If composite resource calls another composite resource, it’s all resources are executed as RunAs user as well.  RunAs credentials are propagated to any level of composite resource hierarchy. If any resource inside composite resource specify its own value for PsDscRunAsCredential we give merge error during configuration compilation.

Here is how to use it with [WindowsFeatureSet](https://msdn.microsoft.com/en-us/powershell/wmf/dsc_newresources) Composite resource included in PSDesiredStateConfiguration module. 



```powershell

Configuration InstallWindowsFeature     
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.NodeName
	{
        WindowsFeatureSet features 
        {  
            Name = @("Telnet-Client","SNMP-Service")  
            Ensure = "Present"  
            IncludeAllSubFeature = $true  
			PsDscRunAsCredential = Get-Credential   
        }  
    }

}

$configData = @{
    AllNodes = @(
        @{
            NodeName             = 'localhost';
            PSDscAllowDomainUser = $true
            CertificateFile      = 'C:\publicKeys\targetNode.cer'
            Thumbprint           = '7ee7f09d-4be0-41aa-a47f-96b9e3bdec25'
        }
    )
}


InstallWindowsFeature -ConfigurationData $configData 

```