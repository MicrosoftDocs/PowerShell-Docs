---
ms.date:  06/12/2017
title:  Creating and publishing an item
description: This article covers the mechanics and important steps for preparing a script or module, and publishing it to the PowerShell Gallery
---
# Creating and publishing an item

The PowerShell Gallery is the place to publish and share stable PowerShell modules, scripts, and
Desired State Configuration (DSC) resources with the broader PowerShell user community.

This article covers the mechanics and important steps for preparing a script or module, and
publishing it to the PowerShell Gallery. We strongly encourage that you review the
[Publishing Guidelines](../../concepts/publishing-guidelines.md) to understand how to ensure that
the items you publish will be more widely accepted by PowerShell Gallery users.

The minimum requirements to publish an item to the PowerShell Gallery are:

- Have a PowerShell Gallery account, and the API Key associated with it
- Ensure Required Metadata is in your item
- Use the pre-validation tools to ensure your item is ready to publish
- Publish the item to the PowerShell Gallery using the Publish-Module and Publish-Script commands
- Respond to questions or concerns about your item

The PowerShell Gallery accepts PowerShell modules and PowerShell scripts. When we refer to scripts,
we mean a PowerShell script that is a single file, and not part of a larger module.

## PowerShell Gallery Account and API Key

See [Creating a PowerShell Gallery Account](creating-an-account.md) for how to set up your
PowerShell Gallery account.

Once you have created an account, you can get the API Key needed to publish an item. After you sign
in with the account, your username will be displayed at the top of the PowerShell Gallery pages
instead of Register. Clicking on your username will take you to the My Account page, where you will
find the API Key.

> [!IMPORTANT]
> The API Key must be treated as securely as your login and password. With this key you, or anyone
> else, can update any item you own in the PowerShell Gallery. We recommend updating the key
> regularly, which can be done using Reset Key on your My Account page.

## Required Metadata for Items Published to the PowerShell Gallery

The PowerShell Gallery provides information to gallery users drawn from metadata fields that are
included in the script or module manifest. Creating or modifying items for publication to the
PowerShell Gallery has a small set of requirements for information supplied in the item manifest. We
strongly encourage that you review the Item Metadata section of the
[Publishing Guidelines](../../concepts/publishing-guidelines.md) to learn how to provide the best
information to users with your items.

The [New-ModuleManifest](/powershell/module/microsoft.powershell.core/new-modulemanifest) and
[New-ScriptFileInfo](/powershell/module/PowerShellGet/New-ScriptFileInfo) cmdlets will create the
manifest template for you, with placeholders for all the manifest elements.

Both manifests have two sections that are important for publishing, the Primary Key Data and PSData
area of PrivateData. The primary key data in a PowerShell module manifest is everything outside of
the PrivateData section. The set of primary keys is tied to the version of PowerShell in use, and
undefined are not supported. PrivateData supports adding new keys, so the elements specific to the
PowerShell Gallery are in PSData.

Manifest elements that are most important to fill in for item you publish to the PowerShell Gallery
are:

- Script or Module Name - Those are drawn from the names of the .PS1 for a script, or the .PSD1 for
  a module.
- Version - this is a required primary key, format should follow SemVer guidelines. See Best
  Practices for details.
- Author - this is a required primary key, and contains the name to be associated with the item. See
  Authors and Owners below.
- Description - this is a required primary key, used to briefly explain what this item does and any
  requirements for using it
- ProjectURI - this is a strongly recommended URI field in PSData that provides a link to a Github
  repo or similar location where you do development on the item
- Tags - it is a strong recommendation to tag your package based on its compatibility with
  PSEditions and platforms. For details, see the
  [Publishing Guidelines](../../concepts/publishing-guidelines.md#tag-your-package-with-the-compatible-pseditions-and-platforms).

Authors and Owners of PowerShell Gallery items are related concepts, but do not always match. Item
Owners are users with PowerShell Gallery accounts that have permission to maintain the item. There
may be many Owners who can update any item. The Owner is only available from the PowerShell Gallery,
and is lost if the item is copied from one system to another. Author is a string that is built into
the manifest data, so it is always part of the item. The recommendations for items from Microsoft
products are:

- Have multiple owners, with at least one being the name of the team that produces the item
- Have the Author be a well-known team name (such as Azure SDK Team), or Microsoft Corporation

## Pre-Validate Your Item

There are a few tools you need to run against your code before publishing your item to the
PowerShell Gallery:

- [PowerShell Script Analyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer/), which
  is in the PowerShell Gallery
- For modules, Test-ModuleManifest which is part of PowerShell
- For scripts, Test-ScriptFileInfo which comes with PowerShell Get

[PowerShell Script Analyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer/) is a
static code analysis tool that will scan your code to ensure it meets basic PowerShell coding
guidelines. This tool will identify common and critical issues in your code, and should be run
regularly during development to help you get your item ready to publish. PowerShell Script Analyzer
will provide list of issues identified as Errors, Warning, and Information. All errors must be
addressed before you publish to the PowerShell Gallery. Warnings need to be reviewed, and most
should be addressed. PowerShell Script Analyzer is run every time an item is published or updated in
the PowerShell Gallery. The Gallery Operations team will contact item owners to address errors that
are found.

If the manifest information in your item cannot be read by the PowerShell Gallery infrastructure,
you will not be able to publish.
[Test-ModuleManifest](/powershell/module/microsoft.powershell.core/test-modulemanifest) will catch
common problems that would cause the module to not be usable when it is installed. It must be run
for every module prior to publishing it to the PowerShell Gallery.

Likewise, [Test-ScriptFileInfo](/powershell/module/PowerShellGet/test-scriptfileinfo) validates the
metadata in a script, and must be run on every script (published separate from a module) prior to
publishing it to the PowerShell Gallery.

## Publishing Items

You must use the [Publish-Script](/powershell/module/PowerShellGet/publish-script) or
[Publish-Module](/powershell/module/PowerShellGet/publish-module) to publish items to the PowerShell
Gallery. These commands both require:

- The path to the item you will publish. For a module, use the folder named for your module. If you
  specify a folder that contains multiple versions of the same module, you must specify
  RequiredVersion.
- A Nuget API key. This is the API key found in the My Account page on the PowerShell Gallery.

Most of the other options in the command line should be in the manifest data for the item you are
publishing, so you should not need to specify them in the command.

To avoid errors, it is strongly recommended that you try the commands using -WhatIf -Verbose,
before publishing. This will save considerable time, since every time you publish to the PowerShell
Gallery, you must update the version number in the manifest section of the item.

Examples would be:

* `Publish-Module -Path ".\MyModule" -NugetAPIKey "GUID" -WhatIf -Verbose`
* `Publish-Script -Path ".\MyScriptFile.PS1" -NugetAPIKey "GUID" -WhatIf -Verbose`

Review the output carefully, and if you see no errors or warnings, repeat the command without
-WhatIf.

All items that are published to the PowerShell Gallery will be scanned for viruses, and will be
analyzed using the PowerShell Script Analyzer. Any issues that arise at that time will be sent back
to the publisher for resolution.

Once you have published an item to the PowerShell Gallery, you will need to watch for feedback on
your item.

- Ensure you monitor the email address associated with the account used to publish. Users, and the
  PowerShell Gallery Operations team will provide feedback via that account, including issues from
  the PSSA or antivirus scans. If the email account is invalid, or if serious issues are reported to
  the account and left unresolved for a long time, items can be considered abandoned and will be
  removed from the PowerShell Gallery as described in our
  [Terms of Use](https://www.powershellgallery.com/policies/Terms).
