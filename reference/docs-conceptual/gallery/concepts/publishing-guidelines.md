---
ms.date:  06/12/2017
description:  This article describes recommended steps to ensure the packages published to the PowerShell Gallery are widely adopted and provide high value to users.
title:  PowerShell Gallery Publishing Guidelines and Best Practices
---
# PowerShellGallery Publishing Guidelines and Best Practices

This article describes recommended steps used by Microsoft teams to ensure the packages published to
the PowerShell Gallery will be widely adopted and provide high value to users, based on how the
PowerShell Gallery handles manifest data and on feedback from large numbers of PowerShell Gallery
users. Packages that are published following these guidelines will be more likely to be installed,
trusted, and attract more users.

Included below are guidelines for what makes a good PowerShell Gallery package, what optional
Manifest settings are most important, improving your code with feedback from initial reviewers and
[Powershell Script Analyzer](https://aka.ms/psscriptanalyzer), versioning your module,
documentation, tests and examples for how to use what you have shared. Much of this documentation
follows the guidelines for publishing
[High Quality DSC Resource Modules](https://github.com/PowerShell/DscResources/blob/master/HighQualityModuleGuidelines.md).

For the mechanics of publishing a package to the PowerShell Gallery, see
[Creating and Publishing a Package](../how-to/publishing-packages/publishing-a-package.md).

Feedback on these guidelines is welcomed. If you do have feedback, please open issues in our
[GitHub documentation repository](https://github.com/powershell/powershell-docs/issues).

## Best practices for publishing packages

The following best practices are what the users of PowerShell Gallery items say is important, and
are listed in nominal priority order. Packages that follow these guidelines are far more likely to
be downloaded and adopted by others.

- Use PSScriptAnalyzer
- Include documentation and examples
- Be responsive to feedback
- Provide modules rather than scripts
- Provide links to a project site
- Tag your package with the compatible PSEdition(s) and platforms
- Include tests with your modules
- Include and/or link to license terms
- Sign your code
- Follow [SemVer](https://semver.org/) guidelines for versioning
- Use common tags, as documented in Common PowerShell Gallery tags
- Test publishing using a local repository
- Use PowerShellGet to publish

Each of these is covered briefly in the sections below.

## Use PSScriptAnalyzer

[PSScriptAnalyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer) is a free static
code analysis tool that works on PowerShell code. **PSScriptAnalyzer** will identify the most common
issues seen in PowerShell code, and often a recommendation for how to fix the issue. The tool is
easy to use, and categorizes the issues as Errors (severe, must be addressed), Warning (need to be
reviewed and should be addressed), and Information (worth checking out for best practices). All
packages published to the PowerShell Gallery will be scanned using **PSScriptAnalyzer**, and any
errors will be reported back to the owner and must be addressed.

The best practice is to run `Invoke-ScriptAnalyzer` with `-Recurse` and `-Severity` Warning.

Review the results, and ensure that:

- All Errors are corrected or addressed in your documentation.
- All Warnings are reviewed, and addressed where applicable.

Users who download packages from the PowerShell Gallery are strongly encouraged to run
**PSScriptAnalyzer** and evaluate all Errors and Warnings. Users are very likely to contact package
owners if they see that there's an error reported by **PSScriptAnalyzer**. If there's a compelling
reason for your package to keep code that is flagged as an error, add that information to your
documentation to avoid having to answer the same question many times.

## Include documentation and examples

Documentation and examples are the best way to ensure users can take advantage of any shared code.

Documentation is the most helpful thing to include in packages published to the PowerShell Gallery.
Users will generally bypass packages without documentation, as the alternative is to read the code
to understand what the package is and how to use it. There are several articles available about how
to provide documentation with PowerShell packages, including:

- Guidelines for providing help are in [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415).
- Creating cmdlet help, which is the best approach for any PowerShell script, function, or cmdlet.
  For information about how to create cmdlet help, start with [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415).
  To add help within a script, see
  [About Comment Based Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help).
- Many modules also include documentation in text format, such as MarkDown files. This can be
  particularly helpful when there's a project site in GitHub, where Markdown is a heavily used
  format. The best practice is to use [GitHub-flavored Markdown](https://help.github.com/categories/writing-on-github/).

Examples show users how the package is intended to be used. Many developers will say that they look
at examples before documentation to understand how to use something. The best types of examples show
basic use, plus a simulated realistic use case, and the code is well-commented. Examples for modules
published to the PowerShell Gallery should be in an Examples folder under the module root.

A good pattern for examples can be found in the [PSDscResource module](https://www.powershellgallery.com/packages/PSDscResources)
under the `Examples\RegistryResource` folder. There are four sample use cases with a brief
description at the top of each file that documents what is being demonstrated.

## Manage Dependencies

It's important to specify modules that your module is dependent on in the Module Manifest. This
allows the end user to not have to worry about installing the proper versions of modules that yours
take a dependency on. To specify dependent modules, you should use the required module field in the
module manifest. This will load any listed modules into the global environment prior to importing
your module unless they've already been loaded. For example, some modules may already be loaded by a
different module. It's also possible to specify a specific version to load using the
**RequiredVersion** field rather than the **ModuleVersion** field. When using **ModuleVersion**, it
will load the newest version available with a minimum of the version specified. When not using the
**RequiredVersion** field, to specify a specific version it's important to monitor version updates
to the required module. It's especially important to be aware of any breaking changes that could
affect the user experience with your module.

```powershell
Example: RequiredModules = @(@{ModuleName="myDependentModule"; ModuleVersion="2.0"; Guid="cfc45206-1e49-459d-a8ad-5b571ef94857"})

Example: RequiredModules = @(@{ModuleName="myDependentModule"; RequiredVersion="1.5"; Guid="cfc45206-1e49-459d-a8ad-5b571ef94857"})
```

## Respond to feedback

Package owners who respond properly to feedback are highly valued by the community. Users who
provide constructive feedback are important to respond to, as they're interested enough in the
package to try to help improve it.

There is one feedback method available in the PowerShell Gallery:

- Contact Owner: This allows a user to send an email to the package owner. As a package owner, is
  important to monitor the email address used with the PowerShell Gallery packages, and respond to
  issues that are raised. The one disadvantage to this method is that only the user and owner will
  ever see the communication, so the owner may have to answer the same question many times.

Owners who respond to feedback constructively are appreciated by the community. Use the opportunity
in the report to request more information. If needed, provide a workaround, or identify if an update
fixes a problem.

If there's inappropriate behavior observed from either of these communication channels, use the
Report Abuse feature of the PowerShell Gallery to contact the Gallery Administrators.

## Modules Versus Scripts

Sharing a script with other users is great, and provides others with examples of how to solve
problems they may have. The issue is that scripts in the PowerShell Gallery are single files without
separate documentation, examples, and tests.

PowerShell Modules have a folder structure that allows multiple folders and files to be included
with the package. The module structure enables including the other packages we list as best
practices: cmdlet help, documentation, examples, and tests. The biggest disadvantage is that a
script inside a module must be exposed and used as a function. For information on how to create a
module, see
[Writing a Windows PowerShell Module](/powershell/scripting/developer/module/writing-a-windows-powershell-module).

There are situations where a script provides a better experience for the user, particularly with DSC
configurations. The best practice for DSC configurations is to publish the configuration as a script
with an accompanying module that contains the docs, examples, and tests. The script lists the
accompanying module using `RequiredModules = @(Name of the Module)`. This approach can be used with
any script.

Standalone scripts that follow the other best practices provide real value to other users. Providing
comment-based documentation and a link to a Project Site are highly recommended when publishing a
script to the PowerShell Gallery.

## Provide a link to a project site

A Project Site is where a publisher can interact directly with the users of their PowerShell Gallery
packages. Users prefer packages that provide this, as it allows them to get information about the
package more easily. Many packages in the PowerShell Gallery are developed in GitHub, others are
provided by organizations with a dedicated web presence. Each of these can be considered a project
site.

Adding a link is done by including ProjectURI in the PSData section of the manifest as follows:

```
  # A URL to the main website for this project.
  ProjectUri = 'https://github.com/powershell/powershell'
```

When a ProjectURI is provided, the PowerShell Gallery will include a link to the Project Site on the
left side of the package page.

## Tag your package with the compatible PSEdition(s) and platforms

Use the following tags to demonstrate to users which packages will work well with their environment:

- PSEdition_Desktop: Packages that are compatible with Windows PowerShell
- PSEdition_Core: Packages that are compatible with PowerShell Core
- Windows: Packages that are compatible with the Windows Operating System
- Linux: Packages that are compatible with Linux Operating Systems
- MacOS: Packages that are compatible with the Mac Operating System

By tagging your package with the compatible platform(s) it will be included in the Gallery search
filters on the left pane of the search results. If you host your package on GitHub, when you tag
your package, you can also take advantage of our
[PowerShell Gallery compatibility shields](https://img.shields.io/powershellgallery/p/:packageName.svg)
![compatibility shield example](media/publishing-guidelines/CosmosDB.svg).

## Include tests

Including tests with open-source code is important to users, as it gives them assurance about what
you validate, and provides information on how your code works. It also allows users to ensure they
don't break your original functionality if they modify your code to fit their environment.

It's strongly recommended that tests be written to take advantage of the Pester test framework,
which has been designed specifically for PowerShell. Pester is available in [GitHub](https://github.com/Pester/Pester),
the [PowerShell Gallery](https://www.powershellgallery.com/packages/Pester/), and ships in Windows
10, Windows Server 2016, WMF 5.0 and WMF 5.1.

The [Pester project site in GitHub](https://github.com/Pester/Pester) includes good documentation on
writing Pester tests, from getting started to best practices.

The targets for test coverage are called out in the
[High Quality Resource Module documentation](https://github.com/PowerShell/DscResources/blob/master/HighQualityModuleGuidelines.md),
with 70% unit test code coverage recommended.

## Include and/or link to license terms

All packages published to the PowerShell Gallery must specify the license terms, or be bound by the
license included in the [Terms of Use](https://www.powershellgallery.com/policies/Terms) under
**Exhibit A**. The best approach to specifying a different license is to provide a link to the
license using the **LicenseURI** in **PSData**. For more information, see [Packages manifest and Gallery UI](package-manifest-affecting-ui.md).

```powershell
PrivateData = @{
    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('.net','acl','active-directory')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'
```

## Sign your code

Code signing provides users with the highest level of assurance for who published the package, and
that the copy of the code they acquire is exactly what the publisher released. To learn more about
code signing generally, see
[Introduction to Code Signing](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537361(v=vs.85)).
PowerShell supports validation of code signing through two primary approaches:

- Signing script files
- Catalog signing a module

Signing PowerShell files is a well-established approach to ensuring that the code being executed was
produced by a reliable source, and hasn't been modified. Details on how to sign PowerShell script
files is covered in the [About Signing](/powershell/module/microsoft.powershell.core/about/about_signing)
article. In overview, a signature can be added to any `.PS1` file that PowerShell validates when the
script is loaded. PowerShell can be constrained using the [Execution Policy](/powershell/module/microsoft.powershell.core/about/about_execution_policies)
cmdlets to ensure use of signed scripts.

Catalog signing modules is a feature added to PowerShell in version 5.1. How to sign a module is
covered in the
[Catalog Cmdlets](/powershell/scripting/wmf/whats-new/new-updated-cmdlets#catalog-cmdlets) article.
In overview, catalog signing is done by creating a catalog file, which contains a hash value for
every file in the module, and then signing that file.

The **PowerShellGet** `Publish-Module`, `Install-Module`, and `Update-Module` cmdlets will check the
signature to ensure it's valid, then confirm that the hash value for each package matches what is in
the catalog. `Save-Module` doesn't validate a signature. If a previous version of the module is
installed on the system, `Install-Module` will confirm that the signing authority for the new
version matches what was previously installed. `Install-Module` and `Update-Module` will use the
signature on a `.PSD1` file if the package isn't catalog signed. Catalog signing works with, but
doesn't replace signing script files. PowerShell doesn't validate catalog signatures at module load
time.

## Follow SemVer guidelines for versioning

[SemVer](https://semver.org/) is a public convention that describes how to structure and change a
version to allow easy interpretation of changes. The version for your package must be included in
the manifest data.

- The version should be structured as three numeric blocks separated by periods, as in `0.1.1` or
  `4.11.192`.
- Versions starting with `0` indicate that the package isn't yet production ready, and the first
  number should only begin with `0` if that's the only number used.
- Changes in the first number (`1.9.9999` to `2.0.0`) indicate major and breaking changes between
  the versions.
- Changes to the second number (`1.1` to `1.2`) indicate feature-level changes, such as adding new
  cmdlets to a module.
- Changes to the third number indicate non-breaking changes, such as new parameters, updated
  samples, or new tests.
- When listing versions, PowerShell will sort the versions as strings, so `1.01.0` will be treated
  as greater than `1.001.0`.

PowerShell was created before SemVer was published, so it provides support for most but not all
elements of SemVer, specifically:

- It doesn't support prerelease strings in version numbers. This is useful when a publisher wishes
  to deliver a preview release of a new major version after providing a version `1.0.0`. This will
  be supported in a future release of the PowerShell Gallery and **PowerShellGet** cmdlets.
- PowerShell and the PowerShell Gallery allow version strings with 1, 2, and 4 segments. Many early
  modules did not follow the guidelines, and product releases from Microsoft include build
  information as a 4th block of numbers (for example `5.1.14393.1066`). From a versioning standpoint,
  these differences are ignored.

## Test using a local repository

The PowerShell Gallery isn't designed to be a target for testing the publishing process. The best
way to test out the end-to-end process of publishing to the PowerShell Gallery is to set up and use
your own local repository. This can be done in a few ways, including:

- Set up a local PowerShell Gallery instance, using the
  [PS Private Gallery project](https://github.com/PowerShell/PSPrivateGallery) in GitHub. This
  preview project will help you set up an instance of the PowerShell Gallery that you can control,
  and use for your tests.
- Set up an [internal Nuget repository](https://devblogs.microsoft.com/powershell/setting-up-an-internal-powershellget-repository/).
  This will require more work to set up, but will have the advantage of validating a few more of the
  requirements, notably validating use of an API key, and whether or not dependencies are present in
  the target when you publish.
- Set up a file share as the test **repository**. This is easy to set up, but since it's a file
  share, the validations noted above will not take place. One potential advantage in this case is
  that the file share doesn't check the required API key, so you can use the same key you would use
  to publish to the PowerShell Gallery.

With any of these solutions, use `Register-PSRepository` to define a new **repository**, which you
use in the `-Repository` parameter for `Publish-Module`.

One additional point about test publishing: any package you publish to the PowerShell Gallery can't
be deleted without help from the operations team, who will confirm that nothing is dependent upon
the package you wish to publish. For that reason, we don't support the PowerShell Gallery as a
testing target, and will contact any publisher who does so.

## Use PowerShellGet to publish

It's strongly recommended that publishers use the `Publish-Module` and `Publish-Script` cmdlets when
working with the PowerShell Gallery. **PowerShellGet** was created to help you avoid remembering
important details about installing from and publishing to the PowerShell Gallery. On occasion,
publishers have chosen to skip **PowerShellGet** and use the **NuGet** client, or
**PackageManagement** cmdlets, instead of `Publish-Module`. There are a number of details that are
easily missed, which results in a variety of support requests.

If there's a reason that you can't use `Publish-Module` or `Publish-Script`, please let us know.
File an issue in the **PowerShellGet** GitHub repo, and provide the details that cause you to choose
**NuGet** or **PackageManagement**.

## Recommended workflow

The most successful approach we have found for packages published to the PowerShell Gallery is this:

- Do initial development in an open-source project site. The PowerShell Team uses GitHub.
- Use feedback from reviewers and [Powershell Script Analyzer](https://aka.ms/psscriptanalyzer) to
  get the code to stable state.
- Include documentation, so others know how to use your work.
- Test out the publishing action using a local repository.
- Publish a stable or Alpha release to the PowerShell Gallery, making sure to include the
  documentation and link to your project site.
- Gather feedback and iterate on the code in your project site, then publish stable updates to the
  PowerShell Gallery.
- Add examples and Pester tests in your project and your module.
- Decide if you want to code sign your package.
- When you feel the project is ready to use in a production environment, publish a `1.0.0` version to
  the PowerShell Gallery.
- Continue to gather feedback and iterate on your code based on user input.
