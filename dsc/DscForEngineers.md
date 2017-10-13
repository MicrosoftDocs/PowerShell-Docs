---
ms.date:  2017-10-13
author:  eslesar;mgreenegit
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Desired State Configuration Overview for Decision Makers
---

# Desired State Configuration Overview for Engineers

This document is intended for developer and operations teams
to understand the benefits of PowerShell Desired State Configuration (DSC).
For a higher level view of the value DSC provides,
please see [Desired State Configuration Overview for Decision Makers](decisionMaker.md)

## Benefits of Desired State Configuration

DSC exists to:

- Decrease the complexity of scripting in Windows
- Increase the speed of iteration

The concept of "continuous deployment" is becoming more important.
Continuous deployment means the ability to deploy frequently, potentially many times per day.
The purpose of these deployments are not to fix something but to get something published quickly.
By getting new features through development into operation as smoothly and reliably as possible,
you reduce time-to-value of new business logic.

The move towards cloud computing
implies a deployment solution that utilizes a "declarative" template model,
where an end state environment is declared as text and published to a deployment engine.
This deployment technique allows for rapid change, at scale,
with resilience against threat of failure because
at any time the deployment can be consistently repeated to guarantee an end state.
The creation of tools and services
that support this style of operations through automation
is a response to these changes.

DSC is a platform
that provides declarative and idempotent (repeatable) deployment, configuration and conformance.
The DSC platform enables you
to ensure that the components of your data center have the correct configuration,
which avoids errors and prevents costly deployment failures.
By treating DSC configurations as part of application code,
DSC enables continuous deployment.
The DSC configuration should be updated as a part of the application,
ensuring that the knowledge needed to deploy the application
is always up-to-date and ready to be used.

## "I have PowerShell, why do I need Desired State Configuration?"

DSC configurations separate intent, or "what I want to do",
from execution, or "how I want to do it."
This means the logic of execution is contained within the resources.
Users do not have to know how to implement or deploy a feature
when a DSC resource for that feature is available.
This allows the user to focus on the structure of their deployment.

As an example, PowerShell scripts should look like this:
```powershell
# Create a share in Windows Server 8
New-SmbShare -Name MyShare -Path C:\Demo\Temp -FullAccess Alice -ReadAccess Bob
```
This script is simple, comprehensible, and straightforward.
However, if you try putting that script into production, you will run into several issues.
What happens if that script is run twice in a row?
What happens if Bob previously had Full Access to the share?

To compensate for these issues, a "real" version of the script will look closer to something like:
```powershell
# But actually creating a share in an idempotent way would be

$shareExists = $false
$smbShare = Get-SmbShare -Name $Name -ErrorAction SilentlyContinue
if($smbShare -ne $null)
{
    Write-Verbose -Message "Share with name $Name exists"
    $shareExists = $true
}

if ($shareExists -eq $false)
{
    Write-Verbose "Creating share $Name to ensure it is Present"
    New-SmbShare @psboundparameters
}
else
{
    # Need to call either Set-SmbShare or *ShareAccess cmdlets
    if ($psboundparameters.ContainsKey("ChangeAccess"))
    {
       #...etc, etc, etc
    }
}
```

This script is more complex, with plenty of logic and error handling.
The script is more complex because you are no longer stating what you want done, but *how to do it*.

DSC allows you to say what you want done, and the underlying logic is abstracted away.

```powershell
# A configuration is a special kind of PowerShell function
Configuration Sample_Share
{
   Import-DscResource -Module xSmbShare
   # Nodes are the endpoint we wish to configure
   # A Configuration block can have zero or more Node blocks
   Node $NodeName
   {
      # Next, specify one or more resource blocks
	  # Resources are simply PowerShell modules that
      # implement the logic of "how" to execute a task
      xSmbShare MySMBShare
      {
          Ensure      = "Present" 
          Name        = "MyShare"
          Path        = "C:\Demo\Temp"  
          ReadAccess  = "Alice"
          FullAccess  = "Bob"
          Description = "This is an updated description for this share"
      }
   }
} 
#Run the function to compile the configuration
Sample_Share
#Pass the configuration to the nodes we defined and configure them
Start-DscConfiguration Sample_Share
```

This script is cleanly formatted and straightforward to read.
The logic paths and error handling are still present in the [resource](resources.md) implementation,
but invisible to the script author.

## Separating Environment from Structure

A common pattern in DevOps is to have multiple environments for deployment.
For example, there might be a "dev" environment used to quickly prototype new code.
The code from the "dev" environment goes into a "test" environment,
where other people verify the new functionality.
Finally, the code goes into "prod", or the live site production environment.

DSC configurations accommodate this dev-test-prod pipeline
through the use of [configuration data](configData.md).
This further abstracts the difference between the structure of the configuration
from the nodes that are managed.
For example, you can define a configuration
that requires a SQL server, an IIS server, and a middle-tier server.
Regardless of what nodes receive the different pieces of this configuration,
those three elements will always be present.
You can use configuration data to point all three elements
towards the same machine for a dev environment,
separate out the three elements to three different machines for a test environment,
and finally towards all your production servers for the prod environment.
To deploy to the different environments, you can invoke **Start-DscConfiguration**
with the correct configuration data for the environment you want to target.

## See Also

[Configurations](configurations.md)

[Configuration Data](configData.md)

[Resources](resources.md)
