# Microsoft Open Source Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

[live-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=live
[staging-badge]: https://powershell.visualstudio.com/PowerShell-Docs/_apis/build/status/PowerShell-Docs-CI?branchName=staging

## Build Status

| Live Branch | Staging Branch |
|:------------|:---------------|
| [![live-badge][]][live-badge] | [![staging-badge][]][staging-badge]

## PowerShell Documentation

Welcome to the PowerShell-Docs repository, housing the official PowerShell documentation.

## Repository Structure

Each of the following top-level folders in this repo contain a DocSet that is published to [Microsoft Docs](https://docs.microsoft.com/powershell).

- [/developer/](https://docs.microsoft.com/powershell/developer/) is the future home of the PowerShell SDK documentation
  - We are in the process of migrating this content from MSDN
- [/dsc/](https://docs.microsoft.com/powershell/dsc/) is for the Desired State Configuration feature
- [/gallery/](https://docs.microsoft.com/powershell/gallery) is for the [PowerShell Gallery](https://www.powershellgallery.com/)
- [/jea/](https://docs.microsoft.com/powershell/jea/) is for the Just Enough Administration feature
- [/reference/](https://docs.microsoft.com/powershell/scripting/) is for PowerShell conceptual
  topics and module reference across versions 3.0, 4.0, 5.0, 5.1, and 6.0
  - This content is also the source of help content retrieved by the `Get-Help` cmdlet
- [/wmf](https://docs.microsoft.com/powershell/wmf/readme) contains release notes for the Windows
  Management Framework, the package used to distribute new versions of PowerShell to previous versions of Windows.

## Contributing

We actively merge contributions into this repository via [pull request](https://help.github.com/articles/using-pull-requests/)
into the *staging* branch.
Please note that before you submit a pull request you must [sign a Contribution License Agreement](https://cla.microsoft.com/)
to ensure that the community is free to use your submissions.

For more information on contributing, read our [contributor's guide](CONTRIBUTING.md).
The contributor's guide contains detail information about how to contribute documentation,
suggested tools, and style and formatting requirements.
Please use the Issue and Pull Request templates to help keep documentation consistent across versions.

## Licenses

There are two license files for this project.
The MIT License applies to the code contained in this repo.
The Creative Commons license applies to the documentation.