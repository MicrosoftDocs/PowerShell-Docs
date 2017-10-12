# [Overview](overview.md)

## [Desired State Configuration Overview for Decision Makers](decisionMaker.md)

## [Desired State Configuration Overview for Engineers](DscForEngineers.md)

## [DSC quick start](quickStart.md)

# [Configurations](configurations.md)

## [Enacting configurations](enactingConfigurations.md)

## [Separating configuration and environment data](separatingEnvData.md)

## [Using resources with multiple versions](sxsResource.md)

## [Running DSC with user credentials](runAsUser.md)

## [Specifying cross-node dependencies](crossNodeDependencies.md)

## [Configuration data](configData.md)

### [Credential options in configuration data](configDataCredentials.md)

## [Nesting configurations](compositeConfigs.md)

## [Securing the configuration MOF file](secureMOF.md)

## [Partial Configurations](partialConfigs.md)

## [Writing help for DSC configurations](configHelp.md)

## [Configure a virtual machine at initial boot-up by using DSC](bootstrapDsc.md)

### [DSCAutomationHostEnabled registry key](DSCAutomationHostEnabled.md)

# [Resources](resources.md)

## [Built-in resources](builtInResource.md)

### [Archive Resource](archiveResource.md)

### [Environment Resource](environmentResource.md)

### [File Resource](fileResource.md)

### [Group Resource](groupResource.md)

### [GroupSet Resource](groupSetResource.md)

### [Log Resource](logResource.md)

### [Package Resource](packageResource.md)

### [ProcessSet Resource](processSetResource.md)

### [Registry Resource](registryResource.md)

### [Script Resource](scriptResource.md)

### [Service Resource](serviceResource.md)

### [ServiceSet Resource](serviceSetResource.md)

### [User Resource](userResource.md)

### [WaitForAllResource](waitForAllResource.md)

### [WaitForAnyResource](waitForAnyResource.md)

### [WaitForSomeResource](waitForSomeResource.md)

### [WindowsFeature Resource](windowsfeatureResource.md)

### [WindowsFeatureSet Resource](windowsFeatureSetResource.md)

### [WindowsOptionalFeature Resource](windowsOptionalFeatureResource.md)

### [WindowsOptionalFeatureSet Resource](windowsOptionalFeatureSetResource.md)

### [WindowsPackageCab Resource](windowsPackageCabResource.md)

### [WindowsProcess Resource](windowsProcessResource.md)

## [Authoring custom resources](authoringResource.md) 

### [MOF-based custom resources](authoringResourceMOF.md)

#### [MOF-based resource in C#](authoringResourceMofCS.md)

### [Class-based custom resouces](authoringResourceClass.md)

### [Composite resources](authoringResourceComposite.md)

### [Writing a single-instance DSC resource (best practice)](singleInstance.md)

### [Resource authoring checklist](resourceAuthoringChecklist.md)

## [Debugging DSC resources](debugResource.md)

## [Calling DSC resource methods directly](directCallResource.md)

# Local Configuration Manager

## [Configuring the Local Configuration Manager (LCM)](metaConfig.md)

## [Configuring the LCM in PowerShell 4.0](metaConfig4.md)

# The DSC pull model

## [Setting up a web pull server](pullServer.md)

## [Setting up a DSC SMB pull server](pullServerSMB.md)

## [Setting up a pull client](pullClient.md)

### [Setting up a pull client using configuration names](pullClientConfigNames.md)

### [Setting up a pull client using configuration ID](pullClientConfigID.md)

## [Using a DSC report server](reportServer.md)

## [Pull server best practices](secureServer.md)

# [DSC examples](dscExamples.md)

## [Building a CI/CD pipeline with DSC, Pester, and Visual Studio Team Services](dscCiCd.md)

## [Separating configuration and environment data](separatingEnvData.md)

# [Troubleshooting DSC](troubleshooting.md)

# [Using DSC on Nano Server](nanoDsc.md)

# DSC on Linux

## [Getting started with DSC for Linux](lnxGettingStarted.md)

## [Built-in resources for Linux](lnxBuiltInResources.md)

### [nxArchive Resource](lnxArchiveResource.md)

### [nxEnvironment Resource](lnxEnvironmentResource.md)

### [nxFile Resource](lnxFileResource.md)

### [nxFileLine Resource](lnxFileLineResource.md)

### [nxGroup Resource](lnxGroupResource.md)

### [nxPackage Resource](lnxPackageResource.md)

### [nxService Resource](lnxServiceResource.md)

### [nxSshAuthorizedKeys Resource](lnxSshAuthorizedKeysResource.md)

### [nxUser Resource](lnxUserResource.md)

# [Using DSC on Microsoft Azure](azureDsc.md)

# DSC MOF Reference

## [MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager.md)

### [ApplyConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-applyconfiguration.md)

### [DisableDebugConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-disabledebugconfiguration.md)

### [EnableDebugConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-enabledebugconfiguration.md)

### [GetConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-getconfiguration.md)

### [GetConfigurationResultOutput method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-getconfigurationresultoutput.md)

### [GetConfigurationStatus method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-getconfigurationstatus.md)

### [GetMetaConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-getmetaconfiguration.md)

### [PerformRequiredConfigurationChecks method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-performrequiredconfigurationchecks.md)

### [RemoveConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-removeconfiguration.md)

### [ResourceGet method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-resourceget.md)

### [ResourceSet method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-resourceset.md)

### [ResourceTest method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-resourcetest.md)

### [RollBack method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-rollback.md)

### [SendConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-sendconfiguration.md)

### [SendConfigurationApply method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-sendconfigurationapply.md)

### [SendConfigurationApplyAsync method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-sendconfigurationapplyasync.md)

### [SendMetaConfigurationApply method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-sendmetaconfigurationapply.md)

### [StopConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-stopconfiguration.md)

### [TestConfiguration method of the MSFT_DSCLocalConfigurationManager class](msft-dsclocalconfigurationmanager-testconfiguration.md)

# More Resources

## [Whitepapers](whitepapers.md)
