---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Building a Continuous Integration and Continuous Deployment pipeline with DSC
---

# Building a Continuous Integration and Continuous Deployment pipeline with DSC

This example demonstrates how to build a Continuous Integration/Continuous Deployment (CI/CD) pipeline by using PowerShell,
DSC, Pester, and Visual Studio Team Foundation Server (TFS).

After the pipeline is built and configured, you can use it to fully deploy, configure and test a DNS server and associated host records.
This process simulates the first part of a pipeline that would be used in a development environment.

An automated CI/CD pipeline helps you update software faster and more reliably, ensuring that all code is tested,
and that a current build of your code is available at all times.

## Prerequisites

To use this example, you should be familiar with the following:

- CI-CD concepts. A good reference can be found at [The Release Pipeline Model](http://aka.ms/thereleasepipelinemodelpdf).
- [Git](https://git-scm.com/) source control
- The [Pester](https://github.com/pester/Pester) testing framework
- [Team Foundation Server](https://www.visualstudio.com/tfs/)

## What you will need

To build and run this example, you will need an environment with several computers and/or virtual machines.

### Client

This is the computer where you'll do all of the work setting up and running the example.

The client computer must be a Windows computer with the following installed:

- [Git](https://git-scm.com/)
- a local git repo cloned from https://github.com/PowerShell/Demo_CI
- a text editor, such as [Visual Studio Code](https://code.visualstudio.com/)

### TFSSrv1

The computer that hosts the TFS server where you will define your build and release.
This computer must have [Team Foundation Server 2017](https://www.visualstudio.com/tfs/) installed.

### BuildAgent

The computer that runs the Windows build agent that builds the project.
This computer must have a Windows build agent installed and running.
See [Deploy an agent on Windows](/azure/devops/pipelines/agents/v2-windows)
for instructions on how to install and run a Windows build agent.

You also need to install both the `xDnsServer` and `xNetworking` DSC modules on this computer.

### TestAgent1

This is the computer that is configured as a DNS server by the DSC configuration in this example.
The computer must be running [Windows Server 2016](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016).

### TestAgent2

This is the computer that hosts the website this example configures.
The computer must be running [Windows Server 2016](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016).

## Add the code to TFS

We'll start out by creating a Git repository in TFS, and importing the code from your local repository on the client computer.
If you have not already cloned the Demo_CI repository to your client computer, do so now by running the following git command:

`git clone https://github.com/PowerShell/Demo_CI`

1. On your client computer, navigate to your TFS server in a web browser.
1. In TFS, [Create a new team project](/azure/devops/organizations/projects/create-project) named Demo_CI.

   Make sure that **Version control** is set to **Git**.
1. On your client computer, add a remote to the repository you just created in TFS with the following command:

   `git remote add tfs <YourTFSRepoURL>`

   Where `<YourTFSRepoURL>` is the clone URL to the TFS repository you created in the previous step.

   If you don't know where to find this URL, see [Clone an existing Git repo](/azure/devops/repos/git/clone).
1. Push the code from your local repository to your TFS repository with the following command:

   `git push tfs --all`
1. The TFS repository will be populated with the Demo_CI code.

> [!NOTE]
> This example uses the code in the `ci-cd-example` branch of the Git repo.
> Be sure to specify this branch as the default branch in your TFS project,
> and for the CI/CD triggers you create.

## Understanding the code

Before we create the build and deployment pipelines, let's look at some of the code to understand what is going on.
On your client computer, open your favorite text editor and navigate to the root of your Demo_CI Git repository.

### The DSC configuration

Open the file `DNSServer.ps1` (from the root of the local Demo_CI repository, `./InfraDNS/Configs/DNSServer.ps1`).

This file contains the DSC configuration that sets up the DNS server. Here it is in its entirety:

```powershell
configuration DNSServer
{
    Import-DscResource -module 'xDnsServer','xNetworking', 'PSDesiredStateConfiguration'

    Node $AllNodes.Where{$_.Role -eq 'DNSServer'}.NodeName
    {
        WindowsFeature DNS
        {
            Ensure  = 'Present'
            Name    = 'DNS'
        }

        xDnsServerPrimaryZone $Node.zone
        {
            Ensure    = 'Present'
            Name      = $Node.Zone
            DependsOn = '[WindowsFeature]DNS'
        }

        foreach ($ARec in $Node.ARecords.keys) {
            xDnsRecord $ARec
            {
                Ensure    = 'Present'
                Name      = $ARec
                Zone      = $Node.Zone
                Type      = 'ARecord'
                Target    = $Node.ARecords[$ARec]
                DependsOn = '[WindowsFeature]DNS'
            }
        }

        foreach ($CName in $Node.CNameRecords.keys) {
            xDnsRecord $CName
            {
                Ensure    = 'Present'
                Name      = $CName
                Zone      = $Node.Zone
                Type      = 'CName'
                Target    = $Node.CNameRecords[$CName]
                DependsOn = '[WindowsFeature]DNS'
            }
        }
    }
}
```

Notice the `Node` statement:

```powershell
Node $AllNodes.Where{$_.Role -eq 'DNSServer'}.NodeName
```

This finds any nodes that were defined as having a role of `DNSServer` in the [configuration data](../configurations/configData.md),
which is created by the `DevEnv.ps1` script.

You can read more about the `Where` method in [about_arrays](/powershell/reference/3.0/Microsoft.PowerShell.Core/About/about_Arrays.md)

Using configuration data to define nodes is important when doing CI because node information will likely change between environments,
and using configuration data allows you to easily make changes to node information without changing the configuration code.

In the first resource block, the configuration calls the **WindowsFeature** to ensure that the DNS feature is enabled.
The resource blocks that follow call resources from the [xDnsServer](https://github.com/PowerShell/xDnsServer) module to configure the primary zone
and DNS records.

Notice that the two `xDnsRecord` blocks are wrapped in `foreach` loops that iterate through arrays in the configuration data.
Again, the configuration data is created by the `DevEnv.ps1` script, which we'll look at next.

### Configuration data

The `DevEnv.ps1` file (from the root of the local Demo_CI repository, `./InfraDNS/DevEnv.ps1`) specifies the environment-specific configuration data
in a hashtable, and then passes that hashtable to a call to the `New-DscConfigurationDataDocument` function,
which is defined in `DscPipelineTools.psm` (`./Assets/DscPipelineTools/DscPipelineTools.psm1`).

The `DevEnv.ps1` file:

```powershell
param(
    [parameter(Mandatory=$true)]
    [string]
    $OutputPath
)

Import-Module $PSScriptRoot\..\Assets\DscPipelineTools\DscPipelineTools.psd1 -Force

# Define Unit Test Environment
$DevEnvironment = @{
    Name                        = 'DevEnv';
    Roles = @(
        @{  Role                = 'DNSServer';
            VMName              = 'TestAgent1';
            Zone                = 'Contoso.com';
            ARecords            = @{'TFSSrv1'= '10.0.0.10';'Client'='10.0.0.15';'BuildAgent'='10.0.0.30';'TestAgent1'='10.0.0.40';'TestAgent2'='10.0.0.50'};
            CNameRecords        = @{'DNS' = 'TestAgent1.contoso.com'};
        }
    )
}

Return New-DscConfigurationDataDocument -RawEnvData $DevEnvironment -OutputPath $OutputPath
```

The `New-DscConfigurationDataDocument` function (defined in `\Assets\DscPipelineTools\DscPipelineTools.psm1`)
programmatically creates a configuration data document from the hashtable (node data) and array (non-node data)
that are passed as the `RawEnvData` and `OtherEnvData` parameters.

In our case, only the `RawEnvData` parameter is used.

### The psake build script

The [psake](https://github.com/psake/psake) build script defined in `Build.ps1` (from the root of the Demo_CI repository, `./InfraDNS/Build.ps1`)
defines tasks that are part of the build.
It also defines which other tasks each task depends on.
When invoked, the psake script ensures that the specified task (or the task named `Default` if none is specified) runs,
and that all dependencies also run (this is recursive, so that dependencies of dependencies run, and so on).

In this example, the `Default` task is defined as:

```powershell
Task Default -depends UnitTests
```

The `Default` task has no implementation itself, but has a dependency on the `CompileConfigs` task.
The resulting chain of task dependencies ensures that all tasks in the build script are run.

In this example, the psake script is invoked by a call to `Invoke-PSake` in the `Initiate.ps1` file
(located at the root of the Demo_CI repository):

```powershell
param(
    [parameter()]
    [ValidateSet('Build','Deploy')]
    [string]
    $fileName
)

#$Error.Clear()

Invoke-PSake $PSScriptRoot\InfraDNS\$fileName.ps1

<#if($Error.count)
{
    Throw "$fileName script failed. Check logs for failure details."
}
#>
```

When we create the build definition for our example in TFS, we will supply our psake script file as the `fileName` parameter for this script.

The build script defines the following tasks:

#### GenerateEnvironmentFiles

Runs `DevEnv.ps1`, which generates the configuration data file.

#### InstallModules

Installs the modules required by the configuration `DNSServer.ps1`.

#### ScriptAnalysis

Calls the [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer).

#### UnitTests

Runs the [Pester](https://github.com/pester/Pester/wiki) unit tests.

#### CompileConfigs

Compiles the configuration (`DNSServer.ps1`) into a MOF file, using the configuration data generated by the `GenerateEnvironmentFiles` task.

#### Clean

Creates the folders used for the example,
and removes any test results, configuration data files, and modules from previous runs.

### The psake deploy script

The [psake](https://github.com/psake/psake) deployment script defined in `Deploy.ps1` (from the root of the Demo_CI repository, `./InfraDNS/Deploy.ps1`)
defines tasks that deploy and run the configuration.

`Deploy.ps1` defines the following tasks:

#### DeployModules

Starts a PowerShell session on `TestAgent1` and installs the modules containing the DSC resources required for the configuration.

#### DeployConfigs

Calls the [Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration) cmdlet to run the configuration on `TestAgent1`.

#### IntegrationTests

Runs the [Pester](https://github.com/pester/Pester/wiki) integration tests.

#### AcceptanceTests

Runs the [Pester](https://github.com/pester/Pester/wiki) acceptance tests.

#### Clean

Removes any modules installed in previous runs, and ensures that the test result folder exists.

### Test scripts

Acceptance, Integration, and Unit tests are defined in scripts in the `Tests` folder (from the root of the Demo_CI repository, `./InfraDNS/Tests`),
each in files named `DNSServer.tests.ps1` in their respective folders.

The test scripts use [Pester](https://github.com/pester/Pester/wiki) and
[PoshSpec](https://github.com/Ticketmaster/poshspec/wiki/Introduction) syntax.

#### Unit tests

The unit tests test the DSC configurations themselves to ensure that the configurations will do what is expected when they run.
The unit test script uses [Pester](https://github.com/pester/Pester/wiki).

#### Integration tests

The integration tests test the configuration of the system to ensure that when integrated with other components,
the system is configured as expected. These tests run on the target node after it has been configured with DSC.
The integration test script uses a mixture of [Pester](https://github.com/pester/Pester/wiki) and
[PoshSpec](https://github.com/Ticketmaster/poshspec/wiki/Introduction) syntax.

#### Acceptance tests

Acceptance tests test the system to ensure that it behaves as expected.
For example, it tests to ensure a web page returns the right information when queried.
These tests run remotely from the target node in order to test real world scenarios.
The integration test script uses a mixture of [Pester](https://github.com/pester/Pester/wiki) and
[PoshSpec](https://github.com/Ticketmaster/poshspec/wiki/Introduction) syntax.

## Define the build

Now that we've uploaded our code to TFS and looked at what it does, let's define our build.

Here, we'll cover only the build steps that you'll add to the build. For instructions on how to create a build definition in TFS,
see [Create and queue a build definition](/azure/devops/pipelines/get-started-designer).

Create a new build definition (select the **Empty** template) named "InfraDNS".
Add the following steps to you build definition:

- PowerShell Script
- Publish Test Results
- Copy Files
- Publish Artifact

After adding these build steps, edit the properties of each step as follows:

### PowerShell Script

1. Set the **Type** property to `File Path`.
1. Set the **Script Path** property to `initiate.ps1`.
1. Add `-fileName build` to the **Arguments** property.

This build step runs the `initiate.ps1` file, which calls the psake build script.

### Publish Test Results

1. Set **Test Result Format** to `NUnit`
1. Set **Test Results Files** to `InfraDNS/Tests/Results/*.xml`
1. Set **Test Run Title** to `Unit`.
1. Make sure **Control Options** **Enabled** and **Always run** are both selected.

This build step runs the unit tests in the Pester script we looked at earlier,
and stores the results in the `InfraDNS/Tests/Results/*.xml` folder.

### Copy Files

1. Add each of the following lines to **Contents**:

   ```
   initiate.ps1
   **\deploy.ps1
   **\Acceptance\**
   **\Integration\**
   ```

1. Set **TargetFolder** to `$(Build.ArtifactStagingDirectory)\`

This step copies the build and test scripts to the staging directory so that the can be published as build artifacts by the next step.

### Publish Artifact

1. Set **Path to Publish** to `$(Build.ArtifactStagingDirectory)\`
1. Set **Artifact Name** to `Deploy`
1. Set **Artifact Type** to `Server`
1. Select `Enabled` in **Control Options**

## Enable continuous integration

Now we'll set up a trigger that causes the project to build any time a change is checked in to the `ci-cd-example` branch of the git repository.

1. In TFS, click the **Build & Release** tab
1. Select the `DNS Infra` build definition, and click **Edit**
1. Click the **Triggers** tab
1. Select **Continuous integration (CI)**, and select `refs/heads/ci-cd-example` in the branch drop-down list
1. Click **Save** and then **OK**

Now any change in the TFS git repository triggers an automated build.

## Create the release definition

Let's create a release definition so that the project is deployed to the development environment with every code check-in.

To do this, add a new release definition associated with the `InfraDNS` build definition you created previously.
Be sure to select **Continuous deployment** so that a new release will be triggered any time a new build is completed.
([What are release pipelines?](/azure/devops/pipelines/release/what-is-release-management))
and configure it as follows:

Add the following steps to the release definition:

- PowerShell Script
- Publish Test Results
- Publish Test Results

Edit the steps as follows:

### PowerShell Script

1. Set the **Script Path** field to `$(Build.DefinitionName)\Deploy\initiate.ps1"`
1. Set the **Arguments** field to `-fileName Deploy`

### First Publish Test Results

1. Select `NUnit` for the **Test Result Format** field
1. Set the **Test Result Files** field to `$(Build.DefinitionName)\Deploy\InfraDNS\Tests\Results\Integration*.xml`
1. Set the **Test Run Title** to `Integration`
1. Under **Control Options**, check **Always run**

### Second Publish Test Results

1. Select `NUnit` for the **Test Result Format** field
1. Set the **Test Result Files** field to `$(Build.DefinitionName)\Deploy\InfraDNS\Tests\Results\Acceptance*.xml`
1. Set the **Test Run Title** to `Acceptance`
1. Under **Control Options**, check **Always run**

## Verify your results

Now, any time you push changes in the `ci-cd-example` branch to TFS, a new build will start.
If the build completes successfully, a new deployment is triggered.

You can check the result of the deployment by opening a browser on the client machine and navigating to `www.contoso.com`.

## Next steps

This example configures the DNS server `TestAgent1` so that the URL `www.contoso.com` resolves to `TestAgent2`,
but it does not actually deploy a website.
The skeleton for doing so is provided in the repo under the `WebApp` folder.
You can use the stubs provided to create psake scripts, Pester tests, and DSC configurations to deploy your own website.
