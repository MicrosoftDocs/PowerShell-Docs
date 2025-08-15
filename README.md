---
ms.date: 01/17/2025
---
# PowerShell Documentation

Welcome to the PowerShell-Docs repository, the home of the official PowerShell documentation.

## Microsoft Open Source Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct][04].

## PowerShell Updatable Help (CabGen) CI Build Status

[![Build Status][cabgen-status]][cabgen-log]

[cabgen-status]: https://apidrop.visualstudio.com/Content%20CI/_apis/build/status/PROD/CabGen(PowerShell_Updatable_Help)/GitHub_MicrosoftDocs_PowerShell-Docs/6ff7e8c3-dfc6-3ebd-da5a-d5e2ff43de8f_cabgen_Publish-Updatable-Help?repoName=MicrosoftDocs%2FPowerShell-Docs&branchName=live
[cabgen-log]: https://apidrop.visualstudio.com/Content%20CI/_build/latest?definitionId=5076&repoName=MicrosoftDocs%2FPowerShell-Docs&branchName=live

## Repository Structure

The following list describes the main folders in this repository.

- `.devcontainer` - configuration files for the VS Code Remote - Containers extension
- `.github` - contains configuration settings used by GitHub for this repository
- `.vscode` - contains configuration settings and recommended extensions for VS Code
- `assets` - contains downloadable files linked in the documentation
- `redir` - contain redirection mapping files
- `reference` - contains the documentation published to [learn.microsoft.com][01]. This includes
  both reference and conceptual content.
  - `5.1` - contains the cmdlet reference and about topics for PowerShell 5.1
  - `7.4` - contains the cmdlet reference and about topics for PowerShell 7.4
  - `7.5` - contains the cmdlet reference and about topics for PowerShell 7.5
  - `7.6` - contains the cmdlet reference and about topics for PowerShell 7.6
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

> [!NOTE]
> The reference content (in the numbered folders) is used to create the webpages on the Docs site as
> well as the updateable help used by PowerShell. The articles in the `docs-conceptual` folder are
> only published to the Docs website.

## Contributing

We welcome public contributions into this repository via pull requests into the _main_ branch.
Please note that before we can accept your pull request you must sign our
[Contribution License Agreement][03]. This is a one-time requirement.

For more information on contributing, read our [contributor's guide][02]. The contributor's guide
contains detailed information about how to contribute documentation, suggested tools, and style and
formatting requirements. Please use the Issue and Pull Request templates to help keep documentation
consistent across versions.

## Licenses

There are two license files for this project. The [MIT License][05] applies to the code contained in
this repo. The [Creative Commons license][06] applies to the documentation.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/scripting/
[02]: https://aka.ms/PSDocsContributor
[03]: https://cla.microsoft.com/
[04]: CODE_OF_CONDUCT.md
[05]: LICENSE-CODE.md
[06]: LICENSE.md
