---
description: Describes automatic members in all PowerShell objects
Locale: en-US
ms.date: 05/18/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Inrinsic_Members?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Intrinsic_Members
---

# About Intrinsic members

## Short Description

Provides information about PowerShell's intrinsic members that are available to
all PowerShell objects.

## Detailed Description

When PowerShell objects are created, some properties and methods are built into the
object regardless of type. These are called intrinsic members.

## About PSAdapted

The members defined in the PowerShell Extended Type System

## About PSBase

The base properties of the object without extension or adaptation

## About PSExtended

The members that were added in the Types.ps1xml files or using the `Add-Member`
cmdlet.

## About PSObject

The base type of all PowerShell objects.

Also, intrinsic member that provides access to a member set that only allows
access to the PsObject instance wrapping the object.

## About PSTypeNames

A list of object types that describe the object in order of specificity
