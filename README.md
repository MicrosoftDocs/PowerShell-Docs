# PowerShell Documentation
Note: right now, this repo is only intended for DSC content. In the future, it may be expanded to include a greater set of PowerShell documentation. 

## Gold Standard
* Any public release
    - ICan overview (brief)
    - Class/Parameter definitions
    - System requirements
    - Examples/demo.txt
* At RTM
    - Scenario overview
    - Scenario examples
    - Scenario training
    - Video content
    - Cmdlet help
    - API documentation
    - Setup and install considerations
    - Security guidance
    - Expanded system requirements
* Post-RTM
    - Architecture docs
    - Compete/support/release info
    - (?) Getting Started
    - Use cases
    - Troubleshooting
    - (?) Tool/expandability docs
    - Deployment guides
    - Scaling/HA guidance
    - End-to-end whitepapers
    - App compat

## DSC TechNet Documentation

Current goals:
* Build a filesystem with separate docs for whatever we want to be a separate doc
* Backfill the current TechNet content and outlines into those docs so that we have a plan of record for what we want to do.


* [Overview/Intro](dsc/overview.md) (1% - outlined)
    - Why do I care about DSC? Value add?
    - Basics of concepts
        + [Configurations](dsc/enactingConfigurations.md)
        + Resources
        + Packaged as PS modules
        + Discovery of resources
                - On-box (Get-DscResource)
                - Gallery (Find/Install-DscResource)
        + Platforms/Availability
            * Windows/Linux
            * Versions 
    - Review initial blog post for reference
* Configuration Topics
    - Authoring
        + Compilation into MOF
        + Advanced authoring
            * Param block with PS runtime-y stuff
            * Change static variables to runtime dynamic variables (right-hand side of config properties)
    - Enacting
        + Push
        + Pull defers to a set of articles on the pull model/server/protocol/etc
    - Status
        + Get-DscConfiguration
        + Get-DscConfigurationStatus
    - Don't call it rollback: Restore-DscConfiguration
    - Troubleshooting
        + ETW logs
        + -Wait -Verbose
        + Get-DscConfigurationStatus
        + LCM: Get-DscLocalConfigurationManager
    - [Configuration Data](dsc/configData.md) (?% - poor condition)
    - Partial configs
    - Consuming composite resources
* Resource Topics
    - Built-in resources
    - [Authoring custom resources](dsc/authoringResource.md)
        + [MOF-based](dsc/authoringResourceMOF.md)
        + [Class-based](dsc/authoringResourceClass.md)
        + [Composite resources](dsc/authoringResourceComposite.md)
        + Debugging DSC resources
    - Linux resources
* [MetaConfiguration (LCM)](dsc/metaConfig.md)
* [Pull server](dsc/pullServer.md)
* Error reporting/logging
* Scenario (end-to-end) examples
    - Configurations
        + File Copy
    - Config Data
        + Wordpress
    - Complex, multi-node, dev -> prod
        + HA SQL deployment

## External
* Azure Automation
* Azure Extension Handler

## Later
* DSC resource best practices

