---
description: List of changes to the PowerShell documentation for 2022
ms.date: 06/28/2023
title: What's New in PowerShell-Docs for 2022
---
# What's new in PowerShell Docs for 2022

This article lists notable changes made to docs each month and celebrates the contributions from the
community.

Help us make the documentation better for you. Read the [Contributor's Guide][contrib] to learn how
to get started.

## 2022-December

New Content

- [about_PSItem](/powershell/module/microsoft.powershell.core/about/about_psitem)
- [Configuring a light colored theme](/powershell/scripting/learn/shell/using-light-theme)
- [What's new in Crescendo 1.1](/powershell/utility-modules/crescendo/whats-new/whats-new-in-crescendo-11)
- [Export-CrescendoCommand](/powershell/module/microsoft.powershell.crescendo/export-crescendocommand)
- PowerShell 7.4 (preview) cmdlet reference - a direct copy of the 7.3 content in preparation for
  the preview release of PowerShell 7.4

More Quality project updates

- Added alias information to 83 cmdlet articles (Thanks @ehmiiz!)
- Added alias information to 8 cmdlet articles (Thanks @szabolevo!)

GitHub stats

- 51 PRs merged (14 from Community)
- 50 issues opened (28 from Community)
- 46 issues closed (23 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|  GitHub Id  | PRs merged | Issues opened |
| ----------- | :--------: | :-----------: |
| ehmiiz      |     8      |       7       |
| changeworld |     3      |               |
| szabolevo   |     1      |               |
| amkhrjee    |     1      |               |
| xtqqczze    |     1      |       3       |
| ALiwoto     |     1      |       2       |
| mklement0   |            |       3       |

## 2022-November

New Content

- [Contributing quality improvements](contributing/quality-improvements.md)
  - See examples under [Quality project updates](#quality-nov)
- [Product terminology and branding guidelines](contributing/product-terminology.md)
- [Labelling in GitHub](contributing/labelling-in-github.md)

Content updates

- Updated release notes for the PowerShell 7.3 GA release
- Updated [about_Telemetry](/powershell/module/microsoft.powershell.core/about/about_telemetry)
- Improved the description of delay-binding in
  [about_Script_Blocks](/powershell/module/Microsoft.PowerShell.Core/About/about_Script_Blocks)
- Added a best practice recommendation to
  [about_Functions_Advanced_Parameters](/powershell/module/Microsoft.PowerShell.Core/About/about_Functions_Advanced_Parameters)

<span id='quality-nov'>Quality project updates</span>

- Added alias information to 129 cmdlet articles (Thanks @ehmiiz!)
- Added links to PRs in the PowerShell 7.3 release notes (Thanks @skycommand!)
- Converted hyperlinks to link references in 5 articles (Thanks @chadmando!)

GitHub stats

- 52 PRs merged (12 from Community)
- 41 issues opened (27 from Community)
- 42 issues closed (28 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|   GitHub Id    | PRs merged | Issues opened |
| -------------- | :--------: | :-----------: |
| ehmiiz         |     9      |       8       |
| chadmando      |     1      |               |
| baardhermansen |     1      |               |
| skycommand     |     1      |               |
| mklement0      |            |       3       |
| peetrike       |            |       2       |

## 2022-October

New Content

- [Create a class-based DSC Resource](/powershell/dsc/tutorials/create-class-based-resource?view=dsc-2.0&preserve-view=true)
- [Hacktoberfest and other hack-a-thon events](/powershell/scripting/community/contributing/hackathons?)

Content updates

- [Hacktoberfest 2022](https://github.com/MicrosoftDocs/PowerShell-Docs/pulls?q=is%3Apr+is%3Aclosed+label%3Ahacktoberfest-accepted)
  cleanup efforts
  - Thank you to @ehmiiz, @TSanzo-BLE, and @chadmando for their Hacktoberfest PRs! Their 11 PRs
    touched 114 articles.
- Published PowerShell SDK .NET API content for
  [PowerShell 7.2](/dotnet/api/?view=powershellsdk-7.2.0&preserve-view=true) and
  [7.3-preview](/dotnet/api/?view=powershellsdk-7.3.0&preserve-view=true)
  - The first updates since PowerShell 7.1 released in November 2020
  - Removed the unsupported versions 6.0 and 7.1
- Added a list of aliases not available on Linux and macOS to
  [PowerShell differences on non-Windows platforms](/powershell/scripting/whats-new/unix-support)

GitHub stats

- 65 PRs merged (21 from Community)
- 42 issues opened (28 from Community)
- 34 issues closed (23 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|      GitHub Id      | PRs merged | Issues opened |
| ------------------- | :--------: | :-----------: |
| ehmiiz              |     5      |       5       |
| TSanzo-BLE          |     4      |               |
| yecril71pl          |     2      |               |
| chadmando           |     2      |               |
| GigaScratch         |     1      |       1       |
| rbleattler          |     1      |               |
| spjeff              |     1      |               |
| adamdriscoll        |     1      |               |
| manuelcarriernunes  |     1      |               |
| michelangelobottura |     1      |               |
| dmpe                |     1      |               |
| KamilPacanek        |     1      |               |
| SetTrend            |            |       2       |

## 2022-September

No new content this month.

Content updates

- [PSScriptAnalyzer 1.21](/powershell/utility-modules/psscriptanalyzer/overview) update release
- Release notes for [7.3-preview.8](/powershell/scripting/whats-new/what-s-new-in-powershell-73)

GitHub stats

- 31 PRs merged (8 from Community)
- 18 issues opened (9 from Community)
- 16 issues closed (8 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|   GitHub Id    | PRs merged | Issues opened |
| -------------- | :--------: | :-----------: |
| DonaldDWebster |     1      |               |
| emerconghaile  |     1      |               |
| floojah        |     1      |               |
| imere          |     1      |               |
| mcdonaldjc     |     1      |               |
| rayden84       |     1      |               |
| sirsql         |     1      |               |
| tig            |     1      |               |
| b-long         |            |       2       |

## 2022-August

New content

- New [landing page](/powershell/scripting/whats-new/overview) for What's new content

- Shell experience docs
  - [Running commands in the shell](/powershell/scripting/learn/shell/running-commands)

- DSC 2.0 docs
  - [Conceptual](/powershell/dsc/overview?view=dsc-2.0&preserve-view=true)
    content - 15 new articles
  - [PSDscResources](/powershell/dsc/reference/psdscresources/overview?view=dsc-2.0&preserve-view=true)
    module reference - 58 new articles

Content updates

- [PowerShell VS Code docs](https://code.visualstudio.com/docs/languages/powershell)
- Release notes for [7.3-preview.7](/powershell/scripting/whats-new/what-s-new-in-powershell-73)
- Cleaned up markdown tables in About topics for better accessibility and localization

Other Projects

- [Get-WhatsNew](https://devblogs.microsoft.com/powershell/announcing-the-release-of-get-whatsnew/)
  cmdlet released - This cmdlet displays release notes for all versions of PowerShell so you can see
  what's new for a particular version.

GitHub stats

- 57 PRs merged (16 from Community)
- 24 issues opened (12 from Community)
- 26 issues closed (15 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|         GitHub Id         | PRs merged | Issues opened |
| ------------------------- | :--------: | :-----------: |
| sethvs                    |     4      |               |
| BEEDELLROKEJULIANLOCKHART |     1      |               |
| Chemerevsky               |     1      |               |
| ClaudioESSilva            |     1      |               |
| davidhaymond              |     1      |               |
| DavidMetcalfe             |     1      |               |
| dharmatech                |     1      |               |
| kozhemyak                 |     1      |               |
| mcawai                    |     1      |               |
| NaridaL                   |     1      |               |
| Nicicalu                  |     1      |               |
| sdarwin                   |     1      |               |
| seansaleh                 |     1      |               |

## 2022-July

New content

- [Optimizing your shell experience](/powershell/scripting/learn/shell/optimize-shell)
- [Using tab completion](/powershell/scripting/learn/shell/tab-completion)
- [Using command predictors](/powershell/scripting/learn/shell/using-predictors)
- [Getting dynamic help](/powershell/scripting/learn/shell/dynamic-help)
- [Using aliases](/powershell/scripting/learn/shell/using-aliases)
- [Customizing your shell environment](/powershell/scripting/learn/shell/creating-profiles)

Content updates

- Updated PowerShell 7.3-preview.6 [release notes](/powershell/scripting/whats-new/what-s-new-in-powershell-73)
- Started reviewing and testing PowerShellGet v3 cmdlet reference (currently in beta) to ensure
  accuracy and release readiness.
- Refresh of our Community [Contributor Guide](https://aka.ms/PSDocsContributor)

### Top Community Contributors

GitHub stats

- 50 PRs merged (6 from Community)
- 22 issues opened (14 from Community)
- 29 issues closed (19 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|  GitHub Id   | PRs merged | Issues opened |
| ------------ | :--------: | :-----------: |
| Alvynskio    |     1      |               |
| bergmeister  |     1      |               |
| BusHero      |     1      |               |
| lewis-yeung  |     1      |               |
| sethvs       |     1      |               |
| tommymaynard |     1      |               |

## 2022-June

New content migrated from GitHub wiki

- [Limitations of PowerShell transcripts](/powershell/scripting/learn/deep-dives/output-missing-from-transcript)
- [Avoid using Invoke-Expression](/powershell/scripting/learn/deep-dives/avoid-using-invoke-expression)
- [Avoid assigning variables in expressions](/powershell/scripting/learn/deep-dives/avoid-assigning-variables-in-expressions)
- [about_Case-Sensitivity](/powershell/module/microsoft.powershell.core/about/about_case-sensitivity)
- Updated [about_Arrays](/powershell/module/microsoft.powershell.core/about/about_arrays)

New SecretManagement content

- [Understanding the security features of SecretManagement and SecretStore](/powershell/utility-modules/secretmanagement/security-concepts)
- [Using the SecretStore in automation](/powershell/utility-modules/secretmanagement/how-to/using-secrets-in-automation)
- [Using Azure Key Vault in automation](/powershell/utility-modules/secretmanagement/how-to/using-azure-keyvault)

Content updates

- Updated release notes for 7.3-preview.5 and PSReadLine 2.2.6

### Top Community Contributors

GitHub stats

- 44 PRs merged (8 from Community)
- 23 issues opened (14 from Community)
- 23 issues closed (13 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

| GitHub Id  | PRs merged | Issues opened |
| ---------- | :--------: | :-----------: |
| mcdonaldjc |     2      |       1       |
| radrow     |     1      |               |
| yecril71pl |     1      |               |
| muhahaaa   |     1      |               |
| windin7cc  |     1      |               |
| fabiod89   |     1      |               |
| NaridaL    |     1      |               |

## 2022-May

New content

- [Create a Crescendo configuration using the Crescendo cmdlets](/powershell/utility-modules/crescendo/advanced/using-crescendo-cmdlets)
- [Overview of the SecretManagement and SecretStore modules](/powershell/utility-modules/secretmanagement/overview)
- [Get started with the SecretStore module](/powershell/utility-modules/secretmanagement/get-started/using-secretstore)
- [Understanding the SecretManagement module](/powershell/utility-modules/secretmanagement/get-started/understanding-secretmanagement)
- [Managing a SecretStore vault](/powershell/utility-modules/secretmanagement/how-to/manage-secretstore)

Content updates

- Renamed the `staging` branch to `main`
- Updated the Table of Contents for easier discovery
  - Moved Support Lifecycle to the top level
  - Moved Contributor Guide to the top level
- 7.3-preview.4 release notes
- Bulk formatting cleanup for many docs
  - PowerShell-Docs content - 272 files
  - Secrets management - 17 files
- Updated the PSScriptAnalyzer README and deleted docs that were migrated to Microsoft Learn
- Removed CentOS and Fedora from docs - no longer supported
- Retired 7.1 content - no longer supported
  - Collapse release notes into diff article
  - Delete or move content to archive repo

### Top Community Contributors

GitHub stats

- 53 PRs merged (12 from Community)
- 38 issues opened (21 from Community)
- 39 issues closed (26 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|    GitHub Id     | PRs merged | Issues opened |
| ---------------- | :--------: | :-----------: |
| tommymaynard     |     5      |               |
| naveensrinivasan |     2      |               |
| rikurauhala      |     1      |               |
| joshua6point0    |     1      |               |
| rhorber          |     1      |               |
| Raton-Laveur     |     1      |               |
| StephenRoille    |     1      |               |
| krlinus          |            |       2       |

## 2022-April

New content

- No new content this month

Content updates

- Rewrote the install instructions for [PowerShellGet](/powershell/gallery/powershellget/install-powershellget)
- Created separate article for
  [Installing PowerShellGet on older Windows systems](/powershell/gallery/powershellget/install-on-older-systems)

Other projects

- PowerShell + DevOps Summit April 25-28
  - Gave presentation about contributing to Docs
  - Lightning demo about argument completers
  - Interview for the [PowerShell Podcast](https://powershellpodcast.podbean.com/e/contributing-to-powershell-made-easy-with-sean-wheeler/)

### Top Community Contributors

GitHub stats

- 24 PRs merged (3 from Community)
- 22 issues opened (17 from Community)
- 21 issues closed (15 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|   GitHub Id    | PRs merged | Issues opened |
| -------------- | :--------: | :-----------: |
| Hrxn           |     1      |               |
| kevinholtkamp  |     1      |               |
| MikeyBronowski |     1      |               |
| tommymaynard   |            |       4       |

## 2022-March

New Content

- New PowerShell docs
  - [about_Member-Access_Enumeration](/powershell/module/microsoft.powershell.core/about/about_member-access_enumeration)
  - [about_Module_Manifests](/powershell/module/microsoft.powershell.core/about/about_module_manifests)
  - [How to create a command-line predictor](/powershell/scripting/dev-cross-plat/create-cmdline-predictor)
- Utility modules updates
  - New docs for Crescendo release
    - [Install Crescendo](/powershell/utility-modules/crescendo/get-started/install-crescendo)
    - [Choose a command-line tool](/powershell/utility-modules/crescendo/get-started/choose-command-line-tool)
    - [Decide which features to amplify](/powershell/utility-modules/crescendo/get-started/research-tool)
    - [Create a Crescendo cmdlet](/powershell/utility-modules/crescendo/get-started/create-new-cmdlet)
    - [Generate and test a Crescendo module](/powershell/utility-modules/crescendo/get-started/generate-module)
  - Moved PlatyPS article from PowerShell docs to the PlatyPS documentation
    - [Moved PlatyPS article](/powershell/utility-modules/platyps/create-help-using-platyps)
  - Migrated more PSScriptAnalyzer documentation from the source code repository
    - [Using PSScriptAnalyzer](/powershell/utility-modules/psscriptanalyzer/using-scriptanalyzer)
    - [Rules and recommendations](/powershell/utility-modules/psscriptanalyzer/rules-recommendations)
    - [Creating custom rules](/powershell/utility-modules/psscriptanalyzer/create-custom-rule)

Content updates

- Bulk cleanup of related links in About_ topics
- Added issue and PR templates to all docs repos
- Updates for 7.3 preview content
  - New tab completions
  - Support for SSH options on remoting cmdlets
  - New experimental feature `PSAMSIMethodInvocationLogging`

Other projects

- Created a prototype cmdlet `Get-WhatsNew` based on the
  [draft RFC](https://github.com/PowerShell/PowerShell-RFC/pull/317)
  - Check out the RFC and provide feedback

New team member

- Welcome [Mikey Lombardi](https://github.com/michaeltlombardi) to the docs team

### Top Community Contributors

GitHub stats

- 49 PRs merged (8 from Community)
- 26 issues opened (14 from Community)
- 33 issues closed (18 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|   GitHub Id    | PRs merged | Issues opened |
| -------------- | :--------: | :-----------: |
| AspenForester  |     1      |               |
| codaamok       |     1      |               |
| DianaKuzmenko  |     1      |               |
| MikeyBronowski |     1      |               |
| poshdude       |     1      |               |
| robcmo         |     1      |               |
| sertdfyguhi    |     1      |               |
| stampycode     |     1      |               |

## 2022-February

New Content

- [about_Calling_Generic_Methods](/powershell/module/microsoft.powershell.core/about/about_calling_generic_methods?view=powershell-7.3&preserve-view=true)

Content updates

- Catching up on issues
- Updates for 7.3 preview content

### Top Community Contributors

GitHub stats

- 22 PRs merged (3 from Community)
- 24 issues opened (19 from Community)
- 18 issues closed (16 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|    GitHub Id    | PRs merged | Issues opened |
| --------------- | :--------: | :-----------: |
| sethvs          |     2      |               |
| guilhermgonzaga |     1      |               |

## 2022-January

New Content

- No new content. We're down to one writer for PowerShell. I was out of the office for half of
  December for vacation then half of January for COVID.

Content updates

- Catching up on issues
- Updates for 7.3 preview content

### Top Community Contributors

GitHub stats

- 51 PRs merged (10 from Community)
- 29 issues opened (26 from Community)
- 46 issues closed (39 Community issues closed)

The following people have contributed to PowerShell docs by submitting pull requests or filing
issues. Thank you!

|    GitHub Id    | PRs merged | Issues opened |
| --------------- | :--------: | :-----------: |
| sethvs          |     3      |               |
| UberKluger      |     1      |               |
| MiguelDomingues |     1      |               |
| reZach          |     1      |               |
| Hertz-Hu        |     1      |               |
| julian-hansen   |     1      |               |
| Hrxn            |     1      |               |
| peteraritchie   |     1      |               |

<!-- Link references -->
[contrib]: contributing/overview.md
