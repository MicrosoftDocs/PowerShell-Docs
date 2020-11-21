# Microsoft Open Source Code of Conduct

> Updated: 11/02/2020

This project has adopted the
[Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more
information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or
comments.

[live-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=live
[staging-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=staging

## Build Status

|          Live Branch          |           Staging Branch            |
| :---------------------------- | :---------------------------------- |
| [![live-badge][]][live-badge] | [![staging-badge][]][staging-badge] |

## PowerShell Documentation

Welcome to the PowerShell-Docs repository, the home of the official PowerShell documentation.

## Repository Structure

The following list describes the main folders in this repository.

- `.github` - contains configuration settings used by GitHub for this repository
- `.vscode` - contains configuration settings and recommended extensions for Visual Studio Code (VS
  Code)
- `assets` - contains downloadable files linked in the documentation
- `reference` - contains the documentation published to
  [docs.microsoft.com]([https://docs.microsoft.com/powershell/scripting/). This includes both
  reference and conceptual content.
  - `5.1` - contains the cmdlet reference and about topics for PowerShell 5.1
  - `7.0` - contains the cmdlet reference and about topics for PowerShell 7.0
  - `7.1` - contains the cmdlet reference and about topics for PowerShell 7.1
  - `7.2` - contains the cmdlet reference and about topics for PowerShell 7.2 (preview)
  - `bread` - contains the TOC used for breadcrumb navigation
  - `docs-conceptual` - contains the conceptual articles that are published to the Docs site. In
    general, the folder structure mirrors the Table of Contents (TOC).
  - `mapping` - contains the version mapping configuration used by the build system
  - `media` - contains image files used in documentation. There are media folders throughout the
    `docs-conceptual` content. See the Contributor Guide for information on using images in
    documentation.
  - `module` - contains the markdown source for the Module Browser page
- `tests` - contains the Pester tests used by the build system
- `tools` - contains other tools used by the build system

> NOTE: The reference content (in the numbered folders) is used to create the
> webpages on the Docs site as well as the updateable help used by PowerShell.
> The articles in the `docs-conceptual` folder are only published to the Docs
> website.

## Contributing

We welcome public contributions into this repository via
[pull requests](https://help.github.com/articles/using-pull-requests/) into the _staging_ branch.
Please note that before we can accept your pull request you must sign our
[Contribution License Agreement](https://cla.microsoft.com/). This is a one-time requirement.

For more information on contributing, read our
[contributor's guide](https://aka.ms/PSDocsContributor). The contributor's guide contains detail
information about how to contribute documentation, suggested tools, and style and formatting
requirements. Please use the Issue and Pull Request templates to help keep documentation consistent
across versions.

## Licenses

There are two license files for this project. The MIT License applies to the code contained in this
repo. The Creative Commons license applies to the documentation.
