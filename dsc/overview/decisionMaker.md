---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Desired State Configuration Overview for Decision Makers
---

# Desired State Configuration Overview for Decision Makers

This document describes the business benefits of using Windows PowerShell Desired State Configuration (DSC). It is not a technical guide.

## What Is Desired State Configuration?

PowerShell Desired State Configuration is a configuration management platform built into Windows that is based on open standards. DSC is flexible enough to function reliably and consistently in each stage of the deployment lifecycle (development, test, pre-production, production), as well as during scale-out.

DSC centers around [configurations](../configurations/configurations.md).
A configuration is an easy-to-read document that describes an environment made up of computers ("nodes") with specific characteristics.
These characteristics can be as simple as ensuring a specific Windows feature is enabled or as complex as deploying SharePoint.

DSC also has monitoring and reporting built in.
If a system is no longer compliant, DSC can raise an alert and act to correct the system.

## Benefits of Using Desired State Configuration

Configurations are designed to be easily read, stored, and updated.
Configurations declare the state target devices should be in, instead of writing instructions for how to put them in that state.
This makes it much less costly to learn, adopt, implement, and maintain configuration through DSC.

Creating configurations means that complex deployment steps are captured as a "single source of truth" in a single location.
This makes repeated deployments of a specific set of machines much less error-prone.
In turn, making deployments faster and more reliable which enables a quick turnaround on complex deployments.

Configurations are also shareable via the [PowerShell Gallery](https://powershellgallery.com) meaning common scenarios and best practices might already exist for the work that needs to be done.


## Desired State Configuration and DevOps

DSC was designed with [DevOps](http://blogs.technet.com/b/ashleymcglone/archive/2015/11/20/devops-for-n00bs-ie-windows-people.aspx) in mind, a combination of people, processes, and tools that allow for rapid deployment and iteration focused on delivering value to end users whether internal or external.
Having a single configuration define an environment means that developers can encode their requirements into a configuration,
check that configuration into source control, and operation teams can easily deploy code without having to go through error-prone manual processes.

Configurations are also [data-driven](../configurations/configData.md),
which makes it easier for ops to identify and change environments without developer intervention.

## Desired State Configuration On-Premises and Off-Premises
DSC can be used to manage both on-premise and off-premise deployments.
For on-premise solutions, DSC has a [pull server](../pull-server/pullServer.md)
that can be used to centralize management of machines and report on their status.
For cloud solutions, DSC is usable wherever Windows is usable.
There are also specific offerings from Azure built on Desired State Configuration,
such as [Azure Automation](https://azure.microsoft.com/en-us/documentation/services/automation/), which centralizes reporting of DSC.

## DSC and Compatibility

Although DSC was introduced in Windows Server 2012 R2, it is available for down-level operating systems via the Windows Management Framework (WMF) package.
More information about the WMF can be found on the [PowerShell homepage](/powershell/).

DSC can also be used to manage Linux. For more information, see [Getting Started with DSC for Linux](../getting-started/lnxGettingStarted.md).
