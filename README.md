---
ms.date: 04/05/2023
---
# PowerShell Documentation

Welcome to the PowerShell-Docs repository, the home of the official PowerShell documentation.

## Microsoft Open Source Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct][04]. For more information see
the [Code of Conduct FAQ][05] or contact [opencode@microsoft.com][06] with any additional questions
or comments.

[live-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=live
[main-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=main

## Build Status

|          live branch          |          main branch          |
| :---------------------------- | :---------------------------- |
| [![live-badge][]][live-badge] | [![main-badge][]][main-badge] |

## PowerShell Updatable Help (CabGen) CI Build Status

[![Build Status](https://apidrop.visualstudio.com/Content%20CI/_apis/build/status/PROD/CabGen(PowerShell_Updatable_Help)/GitHub_MicrosoftDocs_PowerShell-Docs/6ff7e8c3-dfc6-3ebd-da5a-d5e2ff43de8f_cabgen_Publish-Updatable-Help?repoName=MicrosoftDocs%2FPowerShell-Docs&branchName=live)](https://apidrop.visualstudio.com/Content%20CI/_build/latest?definitionId=5076&repoName=MicrosoftDocs%2FPowerShell-Docs&branchName=live)

## Repository Structure

The following list describes the main folders in this repository.

- `.github` - contains configuration settings used by GitHub for this repository
- `.vscode` - contains configuration settings and recommended extensions for Visual Studio Code (VS
  Code)
- `assets` - contains downloadable files linked in the documentation
- `reference` - contains the documentation published to
  [learn.microsoft.com][01]. This includes both
  reference and conceptual content.
  - `5.1` - contains the cmdlet reference and about topics for PowerShell 5.1
  - `7.2` - contains the cmdlet reference and about topics for PowerShell 7.2
  - `7.3` - contains the cmdlet reference and about topics for PowerShell 7.3
  - `7.4` - contains the cmdlet reference and about topics for PowerShell 7.4
  - `bread` - contains the TOC used for breadcrumb navigation
  - `docs-conceptual` - contains the conceptual articles that are published to the Docs site. In
    general, the folder structure mirrors the Table of Contents (TOC).
  - `includes` - contains markdown include files
  - `mapping` - contains the version mapping configuration used by the build system
  - `media` - contains image files used in documentation. There are media folders throughout the
    `docs-conceptual` content. See the Contributor Guide for information on using images in
    documentation.
  - `module` - contains the markdown source for the Module Browser page
- `tests` - contains the Pester tests used by the build system
- `tools` - contains other tools used by the build system

> NOTE: The reference content (in the numbered folders) is used to create the webpages on the Docs
> site as well as the updateable help used by PowerShell. The articles in the `docs-conceptual`
> folder are only published to the Docs website.

## Contributing

We welcome public contributions into this repository via pull requests into the _main_ branch.
Please note that before we can accept your pull request you must sign our
[Contribution License Agreement][03]. This is a one-time requirement.

For more information on contributing, read our [contributor's guide][02]. The contributor's guide
contains detailed information about how to contribute documentation, suggested tools, and style and
formatting requirements. Please use the Issue and Pull Request templates to help keep documentation
consistent across versions.

## Licenses

There are two license files for this project. The MIT License applies to the code contained in this
repo. The Creative Commons license applies to the documentation.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/scripting/
[02]: https://aka.ms/PSDocsContributor
[03]: https://cla.microsoft.com/
[04]: https://opensource.microsoft.com/codeofconduct/
[05]: https://opensource.microsoft.com/codeofconduct/faq/
[06]: mailto:opencode@microsoft.com
