---
title:   Building a CI-CD pipeline with DSC, Pester, and Visual Studio Team Services
ms.date:  2017-03-03
keywords:  powershell,DSC
description:  
ms.topic:  article
author:  eslesar
manager:  carmonm
ms.prod:  powershell
---

# Building a CI-CD pipeline with DSC, Pester, and Visual Studio Team Services

This example demonstrates how to build a Continuous Integration-Continuous Deployment (CI-CD) pipeline by using PowerShell,
DSC, Pester, and Visual Studio Team Foundation Server (TFS).

After the pipeline is built and configured, you can use it to fully deploy, configure and test a DNS server and associated host records. 
This process simulates the first part of a pipeline that would be used in a development environment.

## Prerequisites

To use this example, you should be familiar with the following: 

- CI-CD concepts. A good reference can be found at [The Release Pipeline Model](http://aka.ms/thereleasepipelinemodelpdf).
- [Git](https://git-scm.com/) source control
- The [Pester](https://github.com/pester/Pester) testing framework
- [Team Foundation Server](https://www.visualstudio.com/tfs/)

## What you will need

To build and run this example, you will need an environment with several computers and/or virtual machines. 

>**Note:** The client computer, TFS server, and build agent can all be the same computer.

### Client computer 

This is the computer where you'll do all of the work setting up and running the example.

The client computer must be a Windows computer with the following installed:
- [Git](https://git-scm.com/)
- a local git repo cloned from https://github.com/PowerShell/Demo_CI
- a text editor, such as [Visual Studio Code](https://code.visualstudio.com/)  

###  TFS server

The computer that hosts the TFS server where you will define your build and release.
This computer must have [Team Foundation Server 2017](https://www.visualstudio.com/tfs/) installed.

### Build agent

The computer that runs the Windows build agent that builds the project.
This computer must have a Windows build agent installed and running. 
See [Deploy an agent on Windows](https://www.visualstudio.com/en-us/docs/build/actions/agents/v2-windows)
for instructions on how to install and run a Windows build agent.

### Test node

This is the computer that is conifigured as a DNS server by the DSC configuration in this example.
The computer must be running [Windows Server 2016](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016).

## Add the code to TFS

We'll start out by creating a Git repository in TFS, and importing the code from your local repository on the client computer.
If you have not already cloned the Demo_CI repository to your client computer, do so now by running the following git command:

`git clone https://github.com/PowerShell/Demo_CI`

1. On your client computer, navigate to your TFS server in a web browser.
1. In TFS, [Create a new team project](https://www.visualstudio.com/en-us/docs/setup-admin/create-team-project) named Demo_CI.

    Make sure that **Version control** is set to **Git**.
1. On your client computer, add a remote to the repository you just created in TFS with the following command:

    `git remote add tfs <YourTFSRepoURL>`

    Where `<YourTFSRepoURL>` is the clone URL to the TFS repository you created in the previous step.

    If you don't know where to find this URL, see [Clone an existing Git repo](https://www.visualstudio.com/en-us/docs/git/tutorial/clone).
1. Push the code from your local repository to your TFS repository with the following command:

    `git push tfs --all`
1. The TFS repository will be populated with the Demo_CI code.

## Understanding the code

Before we create the build and deployment pipelins, let's look at some of the code to understand what is going on.
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

This finds any nodes that were defined as having a role of `DNSServer` in the [configuration data](configData.md),
which is created by the `DevEnv.ps1` script.

Using configuration data to define nodes is important when doing CI because node information will likely change between environments,
and using configuration data allows you to easily make changes to node information without changing the configuration code.

In the first resource block, the configuration calls the [WindowsFeature](windowsFeatureResource.md) to ensure that the DNS feature is enabled. 
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

The `New-DscConfigurationDataDocument` function programatically creates a configuration data document from the hashtable (node data)
and array (non-node data) that are passed as the `RawEnvData` and `OtherEnvData` parameters.

In our case, only the `RawEnvData` parameter is used.

Here is the `DscPipelineTools.psm` file:

```powershell
# Generate PowerShell Document file(s)
function New-DscConfigurationDataDocument
{
    param(
        [parameter(Mandatory)]
        [hashtable]
        $RawEnvData, 
        
        [array]
        $OtherEnvData,
        
        [string]
        $OutputPath = '.\', 
        
        [string]
        $FileName
        
    )
    
    [System.Array]$AllNodesData
    [System.Array]$NetworkData

    #First validate that the path passed in is not a file
    if(!(Test-Path $outPutPath -IsValid) -or (Test-Path $outPutPath -PathType Leaf))
    {
        Throw "The OutPutPath parameter must be a valid path and must not be an existing file." 
    }

    if ($FileName.length -eq 0)
    {
        $FileName = $RawEnvData.Name
    }
    $OutFile = join-path $outputpath "$FileName.psd1"
    
    ## Loop through $RawEnvData and generate Configuration Document
    # Create AllNodes array based on input
    foreach ($Role in $RawEnvData.Roles)
    {
        $NumberOfServers = 0
        if($Role.VMQuantity -gt 0)
        {
            $NumberOfServers = $Role.VMQuantity
        }
        else
        {
            $NumberOfServers = $Role.VMName.Count
        }

        for($i = 1; $i -le $NumberOfServers; $i++)
        {
            $j = if($Role.VMQuantity -gt 0){$i}
            [hashtable]$NodeData =  @{    NodeName                = "$($Role.VMName)$j"
                                Role                    = $Role.Role
                            }
            # Remove Role and VMName from HT
            $role.remove("Role")
            $role.remove("VMName")

            # Add Lability properties to ConfigurationData if they are included in the raw hashtable
            if($Role.ContainsKey('VMProcessorCount')){ $NodeData  +=  @{Lability_ProcessorCount = $Role.VMProcessorCount}}
            if($Role.ContainsKey('VMStartupMemory')){$NodeData  +=  @{Lability_StartupMemory  = $Role.VMStartupMemory}}
            if($Role.ContainsKey('NetworkName')){    $NodeData  +=  @{Lability_SwitchName     = $Role.NetworkName}}
            if($Role.ContainsKey('VMMedia')){        $NodeData  +=  @{Lability_Media          = $Role.VMMedia}}
            
            # Add all other properties
            $Role.keys | % {$NodeData += @{$_ = $Role.$_}}

            # Generate networking data for static networks 
            Foreach ($Network in $OtherEnvData)
            {
                if($Network.NetworkName -eq $Role.NetworkName -and $network.IPv4AddressAssignment -eq 'Static')
                {
                    # logic to add networking information
                }
            }
            
            [System.Array]$AllNodesData += $NodeData
        }
    }
    
    # Create NonNodeData hashtable based on input            
    foreach ($Network in $OtherEnvData )
    {
        [hashtable]$NetworkHash += @{
                            Name   = $Network.NetworkName;
                            Type   = $Network.SwitchType;
        }
        
        if ($Network.ContainsKey('ExternalAdapterName'))
        {
            $NetworkHash += @{
                            NetAdapterName      = $Network.ExternalAdapterName;
                            AllowManagementOS   = $true;
            }
        }
        
        $NetworkData += $NetworkHash
    }
    
    $NonNodeData = if($NetworkData){ @{Lability=@{Network = $NetworkData}}}
    $ConfigData = @{AllNodes = $AllNodesData; NonNodeData = $NonNodeData}
    

    if(!(Test-path $OutputPath))
    {
        New-Item $OutputPath -ItemType Directory
    }
    
    import-module $PSScriptRoot\Visualization.psm1
    $ConfigData | convertto-ScriptBlock | Out-File $OutFile
    $FullFileName = dir $OutFile
    
    Return "Successfully created file $FullFileName"
}

# Get list of resources required by a configuration script
function Get-DscRequiredResources ()
{
    param(
        [Parameter(Mandatory)]
        [string[]]
        $Path
    )
    
    
}
```

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

The `Default` task has no implementation itself, but has a dependency on the `UnitTests` task. 
The `UnitTests` task depends on the `ScriptAnalysis` task, which depends on `InstallModules`.
`InstallModules` depends on `GenerateEnvironmentFiles`, which depends on `Clean`.
When the `Default` task is invoked, psake ensures that all of these tasks run.

Here is the psake script in its entirety:

```powershell

Import-Module psake

function Invoke-TestFailure
{
    param(
        [parameter(Mandatory=$true)]
        [validateSet('Unit','Integration','Acceptance')]
        [string]$TestType,

        [parameter(Mandatory=$true)]
        $PesterResults
    )

    $errorID = if($TestType -eq 'Unit'){'UnitTestFailure'}elseif($TestType -eq 'Integration'){'InetegrationTestFailure'}else{'AcceptanceTestFailure'}
    $errorCategory = [System.Management.Automation.ErrorCategory]::LimitsExceeded
    $errorMessage = "$TestType Test Failed: $($PesterResults.FailedCount) tests failed out of $($PesterResults.TotalCount) total test."
    $exception = New-Object -TypeName System.SystemException -ArgumentList $errorMessage
    $errorRecord = New-Object -TypeName System.Management.Automation.ErrorRecord -ArgumentList $exception,$errorID, $errorCategory, $null

    Write-Output "##vso[task.logissue type=error]$errorMessage"
    Throw $errorRecord
}

FormatTaskName "--------------- {0} ---------------"

Properties {
    $TestsPath = "$PSScriptRoot\Tests"
    $TestResultsPath = "$TestsPath\Results"
    $ArtifactPath = "$Env:BUILD_ARTIFACTSTAGINGDIRECTORY"
    $ModuleArtifactPath = "$ArtifactPath\Modules"
    $MOFArtifactPath = "$ArtifactPath\MOF"
    $ConfigPath = "$PSScriptRoot\Configs"
    $RequiredModules = @(@{Name='xDnsServer';Version='1.7.0.0'}, @{Name='xNetworking';Version='2.9.0.0'}) 
}

Task Default -depends UnitTests

Task GenerateEnvironmentFiles -Depends Clean {
     Exec {& $PSScriptRoot\DevEnv.ps1 -OutputPath $ConfigPath}
}

Task InstallModules -Depends GenerateEnvironmentFiles {
    # Install resources on build agent
    "Installing required resources..."

    #Workaround for bug in Install-Module cmdlet
    if(!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction Ignore))
    {
        Install-PackageProvider -Name NuGet -Force
    }
    
    if (!(Get-PSRepository -Name PSGallery -ErrorAction Ignore))
    {
        Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2/ -InstallationPolicy Trusted -PackageManagementProvider NuGet
    }
    
    #End Workaround
    
    foreach ($Resource in $RequiredModules)
    {
        Install-Module -Name $Resource.Name -RequiredVersion $Resource.Version -Repository 'PSGallery' -Force
        Save-Module -Name $Resource.Name -RequiredVersion $Resource.Version -Repository 'PSGallery' -Path $ModuleArtifactPath -Force
    }
}

Task ScriptAnalysis -Depends InstallModules {
    # Run Script Analyzer
    "Starting static analysis..."
    Invoke-ScriptAnalyzer -Path $ConfigPath

}

Task UnitTests -Depends ScriptAnalysis {
    # Run Unit Tests with Code Coverage
    "Starting unit tests..."

    $PesterResults = Invoke-Pester -path "$TestsPath/Unit/"  -CodeCoverage "$ConfigPath/*.ps1" -OutputFile "$TestResultsPath/UnitTest.xml" -OutputFormat NUnitXml -PassThru
    
    if($PesterResults.FailedCount) #If Pester fails any tests fail this task
    {
        Invoke-TestFailure -TestType Unit -PesterResults $PesterResults
    }
    
}

Task CompileConfigs -Depends UnitTests, ScriptAnalysis {
    # Compile Configurations...
    "Starting to compile configuration..."
    . "$ConfigPath\DNSServer.ps1"

    DNSServer -ConfigurationData "$ConfigPath\DevEnv.psd1" -OutputPath "$MOFArtifactPath\DevEnv\"
    # Build steps for other environments can follow here.
}

Task Clean {
    "Starting Cleaning enviroment..."
    #Make sure output path exist for MOF and Module artifiacts
    New-Item $ModuleArtifactPath -ItemType Directory -Force 
    New-Item $MOFArtifactPath -ItemType Directory -Force 

    # No need to delete Artifacts as VS does it automatically for each build

    #Remove Test Results from previous runs
    New-Item $TestResultsPath -ItemType Directory -Force
    Remove-Item "$TestResultsPath\*.xml" -Verbose 

    #Remove ConfigData generated from previous runs
    Remove-Item "$ConfigPath\*.psd1" -Verbose

    #Remove modules that were installed on build Agent
    foreach ($Resource in $RequiredModules)
    {
        $Module = Get-Module -Name $Resource.Name
        if($Module  -And $Module.Version.ToString() -eq  $Resource.Version)
        {
            Uninstall-Module -Name $Resource.Name -RequiredVersion $Resource.Version
        }
    }

    $Error.Clear()
}
```
 
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
see [Create and queue a build definition](https://www.visualstudio.com/en-us/docs/build/define/create).

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
and stores the results in the 

### Copy Files

1.  Add each of the following lines to **Contents**:

    ```
    initiate.ps1
    **\deploy.ps1
    **\Acceptance\**
    **\Integration\**
    ```

1. Set **TargetFolder** to `$(BuildArtifactStagingDirectory)\`

This step copies the build and test scripts to the staging directory so that the can be published as build artifacts by the next step.

### Publish Artifact

1. Set **Path to Publish** to `$(Build.ArtifactStagingDirectory)\`
1. Set **Artifact Name** to `Deploy`
1. Set **Artifact Type** to `Server`
1. Select `Enabled` in **Control Options**

## Enable continuous integration

Now we'll set up a trigger that causes the project to build any time a change is checked in to the `master` branch of the git repository. 

1. In TFS, click the **Build & Release** tab
1. Select the `DNS Infra` build definition, and click **Edit**
1. Click the **Triggers** tab
1. Select **Continuous integration (CI)**, and select `refs/heads/ci-cd-example` in the branch drop-down list
1. Click **Save**

Now any change in the TFS git repository triggers an automated build.

## Trigger a build







