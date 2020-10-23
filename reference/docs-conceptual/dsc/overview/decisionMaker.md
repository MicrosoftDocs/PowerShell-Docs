---
ms.date:  10/11/2019
keywords:  dsc,powershell,configuration,setup
title:  Desired State Configuration Overview for Decision Makers
description: This document describes the business benefits of using PowerShell Desired State Configuration (DSC), and isn't a technical guide.
---

# Desired State Configuration overview for decision makers

This document describes the business benefits of using PowerShell Desired State Configuration (DSC),
and isn't a technical guide.

## What Is DSC?

PowerShell DSC is a configuration management platform built into Windows that is based on open
standards. DSC is flexible enough to function reliably and consistently in each stage of the
deployment lifecycle (development, test, pre-production, production), and during scale-out.

DSC centers around [configurations](../configurations/configurations.md). A configuration is
PowerShell script that describes an environment made up of computers, or nodes, with specific
characteristics. These characteristics can be as simple as ensuring a specific Windows feature is
enabled or as complex as deploying SharePoint.

DSC has monitoring and reporting built-in. If a system is no longer compliant, DSC can raise an
alert and act to correct the system.

## Benefits of using DSC

The configuration's design simplifies how they're read, stored, and updated. Configurations declare
the state of target devices, rather than writing instructions for how to place devices in that
state. These factors reduce the costs to learn, adopt, implement, and maintain configuration through
DSC.

Creating configurations means that complex deployment steps are captured as a **single source of
truth** in a single location. Configurations make repeated deployments of a specific set of machines
less error-prone. And, deployments are faster and more reliable, which enables a quick turnaround on
complex deployments.

Configurations are shareable via the [PowerShell Gallery](https://powershellgallery.com). It's
possible that common scenarios and best practices might already exist for the work you need to do.

## DSC and DevOps

DSC was designed with
[DevOps](/archive/blogs/ashleymcglone/devops-for-n00bs-ie-windows-people-like-me) in mind. A
combination of people, processes, and tools that allow for rapid deployment and iteration focused on
delivering value to end users whether internal or external. A single configuration that defines an
environment means that developers can encode their requirements into a configuration and check that
configuration into source control. Operations teams can then deploy code without going through
error-prone manual processes.

Configurations are [data-driven](../configurations/configData.md). The defined data makes it easier
for operations to identify and change environments without developer intervention.

## DSC on-premises and off-premises

DSC can manage on-premises and off-premises deployments. For on-premises solutions, DSC has a
[Pull Server](../pull-server/pullServer.md) that's used to centralize management of machines and
report on their status. For off-premises cloud solutions, DSC is usable any place Windows is usable.
There are specific offerings from Azure built on DSC, such as
[Azure Automation](/azure/automation), that centralizes DSC reporting.

## DSC and compatibility

DSC was introduced in Windows Server 2012 R2, but it's available for down-level operating systems
via the Windows Management Framework (WMF). For more information about WMF, see
[Windows Management Framework](/powershell/scripting/wmf/overview).

DSC can be used to manage Linux. For more information, see
[Getting Started with DSC for Linux](../getting-started/lnxGettingStarted.md).
