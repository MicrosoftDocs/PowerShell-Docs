---
ms.date:  2017-06-12
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,cmdlet,psgallery
description:  Guidelines for Publishers
title:  PowerShell Gallery Publishing Guidelines and Best Practices
---

# PowerShellGallery Publishing Guidelines and Best Practices

This topic describes recommended steps used by Microsoft teams to ensure the items published to
the PowerShell Gallery will be widely adopted and provide high value to users, based on how the
PowerShell Gallery handles manifest data and on feedback from large numbers of PowerShell Gallery users.
Items that are published following these guidelines will be more likely to be installed, trusted, and attract more users.

Included below are guidelines for what makes a good PowerShell Gallery item, what optional Manifest settings are most important,
improving your code with feedback from initial reviewers and [Powershell Script Analyzer](https://aka.ms/psscriptanalyzer),
versioning your module, documentation, tests & examples for how to use what you have shared.
Much of this documentation follows the guidelines for publishing [High Quality DSC Resource Modules](https://github.com/PowerShell/DscResources/blob/master/HighQualityModuleGuidelines.md).

For the mechanics of publishing an item to the PowerShell Gallery, see [Creating and Publishing an Item](https://msdn.microsoft.com/en-us/powershell/gallery/psgallery/creating-and-publishing-an-item).

Feedback on these guidelines is welcomed. If you do have feedback, please open issues in our [Github documentation repository](https://github.com/powershell/powershell-docs/).

## Best practices for publishing items

The following best practices are what the users of PowerShell Gallery items say is important, and are listed in nominal priority order.
Items that follow these guidelines are far more likely to be downloaded and adopted by others.

* Use PSScriptAnalyzer
* Include documentation and examples
* Be responsive to feedback
* Provide modules rather than scripts
* Provide links to a project site
* Include tests with your modules
* Include and/or link to license terms
* Sign your code
* Follow [SemVer](http://semver.org/) guidelines for versioning
* Use common tags, as documented in Common PowerShell Gallery tags
* Test publishing using a local repository

Each of these is covered briefly in the sections below.

## Use PSScriptAnalyzer

[PSScriptAnalyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer) is a free static code analysis tool that works on PowerShell code.
PSScriptAnalyzer will identify the most common issues seen in PowerShell code, and often a recommendation for how to fix the issue.
The tool is easy to use, and categorizes the issues as Errors (severe, must be addressed), Warning (need to be reviewed & should be addressed), and Information (worth checking out for best practices).
All items item published to the PowerShell Gallery will be scanned using PSScriptAnalyzer, and any errors will be reported back to the owner and must be addressed.

The best practice is to run `Invoke-ScriptAnalyzer` with `-Recurse` and `-Severity` Warning.

Review the results, and ensure that:

* All Errors are corrected or addressed in your documentation
* All Warnings are reviewed, and addressed where applicable

Users who acquire items from the PowerShell Gallery are strongly encouraged to run PSScriptAnalyzer and evaluate all Errors and Warnings.
Users are very likely to contact item owners if they see that there is an error reported by PSScriptAnalyzer.
If there is a compelling reason for your item to keep code that is flagged as an error, add that information to your documentation to avoid having to answer the same question many times.

## Include documentation and examples

Documentation and examples are the best way to ensure users can take advantage of any shared code.

Documentation is the most helpful thing to include in items published to the PowerShell Gallery.
Users will generally bypass items without documentation, as the alternative is to read the code to understand what the item is and how to use it.
There are several articles available in MSDN on how to provide documentation with PowerShell items, including:

* Guidelines for providing help are in [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415)
* Creating cmdlet help, which is the best approach for any PowerShell script, function, or cmdlet.
  For information about how to create cmdlet help, start with [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.
  To add help within a script, see [About Comment Based Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_comment_based_help).
* Many modules also include documentation in text format, such as MarkDown files.
  This can be particularly helpful when there is a project site in Github, where Markdown is a heavily used format.
  The best practice is to use [Github-flavored Markdown](https://help.github.com/categories/writing-on-github/)

Examples show users how the item is intended to be used.
Many developers will say that they look at examples before documentation to understand how to use something.
The best type of examples show basic use, plus a simulated realistic use case, and the code is well-commented.
Examples for modules published to the PowerShell Gallery should be in an Examples folder under the module root.

A good pattern for examples can be found in the [PSDscResource module](https://www.powershellgallery.com/packages/PSDscResources) under the Examples\RegistryResource folder.
There are four sample use cases with a brief description at the top of each file that documents what is being demonstrated.

## Respond to feedback

Item owners who respond properly to feedback are highly valued by the community.
Users who provide constructive feedback are important to respond to, as they are interested enough in the item to try to help improve it.

There are two feedback methods available in the PowerShell Gallery:

* Contact Owner: This allows a user to send an email to the item owner(s). As an item owner, is important to monitor the email address used with the PowerShell Gallery items, and respond to issues that are raised. The one disadvantage to this method is that only the user and owner will ever see the communication, so the owner may have to answer the same question many times.
* Comments: At the bottom of the item page is a Comment field.
  The advantage to this system is that other users can see the comments and responses, which reduces the number of times any single question must be answered.
  As an item owner, it is strongly recommended that you Follow the comments made for each item.
See [Providing Feedback via Social Media or Comments](https://msdn.microsoft.com/en-us/powershell/gallery/psgallery/psgallery-SocialMediaFeedback) for details on how to do that.

Owners who respond to feedback constructively are appreciated by the community.
Use the opportunity in the report to request more information if needed, provide a workaround, or identify if an update fixes a problem.

If there is inappropriate behavior observed from either of these communication channels, use the Report Abuse feature of the PowerShell Gallery to contact the Gallery Administrators.

## Modules Versus Scripts

Sharing a script with other users is great, and provides others with examples of how to solve problems they may have.
The issue is that scripts in the PowerShell Gallery are single files without separate documentation, examples, and tests.

PowerShell Modules have a folder structure that allows multiple folders and files to be included with the package.
The module structure enables including the other items we list as best practices: cmdlet help, documentation, examples, and tests.
The biggest disadvantage is that a script inside a module must be exposed and used as a function.
For information on how to create a module, see [Writing a Windows PowerShell Module](http://go.microsoft.com/fwlink/?LinkId=144916).

There are situations where a script provides a better experience for the user, particularly with DSC configurations.
The best practice for DSC configurations is to publish the configuration as a script with an accompanying module that contains the docs, examples, and tests.
The script lists the accompanying module using RequiredModules = @(Name of the Module).
This approach can be used with any script.

Standalone scripts that follow the other best practices provide real value to other users.
Providing comment-based documentation and a link to a Project Site are highly recommended when publishing a script to the PowerShell Gallery.

## Provide a link to a project site

A Project Site is where a publisher can interact directly with the users of their PowerShell Gallery items.
Users prefer items that provide this, as it allows them to get information about the item more easily.
Many items in the PowerShell Gallery are developed in GitHub, others are provided by organizations with a dedicated web presence.
Each of these can be considered a project site.

Adding a link is done by including ProjectURI in the PSData section of the manifest as follows:

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/powershell/powershell'

When a ProjectURI is provided, the PowerShell Gallery will include a link to the Project Site on the left side of the item page.

## Include tests

Including tests with open-source code is important to users, as it gives them assurance about what you validate, and provides information on how your code works. It also allows users to ensure they do not break your original functionality if they modify your code to fit their environment.

It is strongly recommended that tests be written to take advantage of the Pester test framework, which has been designed specifically for PowerShell.
Pester is available in [GitHub](https://github.com/Pester/Pester), the [PowerShell Gallery](https://www.powershellgallery.com/packages/Pester/), and ships in Windows 10, Windows Server 2016, WMF 5.0 and WMF 5.1.

The [Pester project site in GitHub](https://github.com/Pester/Pester) includes good documentation on writing Pester tests, from getting started to best practices.

The targets for test coverage are called out in the [High Quality Resource Module documentation](https://github.com/PowerShell/DscResources/blob/master/HighQualityModuleGuidelines.md), with 70% unit test code coverage recommended.

## Include and/or link to license terms

All items published to the PowerShell Gallery must specify the license terms, or
be bound by the license included in the [Terms of Use](https://www.powershellgallery.com/policies/Terms) under "Exhibit A".
The best approach to specifying a different license is to provide a link to the license using the LicenseURI in PSData.
You can find an example in the Recommended Manifest Fields topic.

```powershell
PrivateData = @{
    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('.net','acl','active-directory')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'
```

## Sign your code

Code signing provides users with the highest level of assurance for who published the item, and that the copy of the code they acquire is exactly what the publisher released.
To learn more about code signing generally, see [Introduction to Code Signing](http://go.microsoft.com/fwlink/?LinkId=106296).
PowerShell supports validation of code signing through two primary approaches:

* Signing script files
* Catalog signing a module

Signing PowerShell files is a well-established approach to ensuring that the code being executed was produced by a reliable source, and has not been modified.
Details on how to sign PowerShell script files is covered in the [About Signing](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_signing) topic.
In overview, a signature can be added to any .PS1 file that PowerShell validates when the script is loaded.
PowerShell can be constrained using the [Execution Policy](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_execution_policies) cmdlets to ensure use of signed scripts.

Catalog signing modules is a feature added to PowerShell in version 5.1.
How to sign a module is covered in the [Catalog Cmdlets](https://msdn.microsoft.com/en-us/powershell/wmf/5.1/catalog-cmdlets) topic.
In overview, catalog signing is done by creating a catalog file, which contains a hash value for every file in the module, and then signing that file.
The PowerShellGet publish-module, install-module, save-module, and update-module cmdlets will check the signature to ensure it is valid, then confirm that the hash value for each item matches what is in the catalog.
If a previous version of the module is installed on the system, install-module will confirm that the signing authority for the new version matches what was previously installed.
Catalog signing works with, but does not replace signing script files. PowerShell does not validate catalog signatures at module load time.

## Follow SemVer guidelines for versioning

[SemVer](http://semver.org/) is a public convention that describes how to structure and change a version to allow easy intepretation of changes.
The version for your item must be included in the manifest data.

* The version should be structured as 3 numeric blocks separated by periods, as in 0.1.1 or 4.11.192
* Versions starting with "0" indicate that the item is not yet production ready, and the first number should only begin with "0" if that is the only number used
* Changes in the first number (1.9.9999 to 2.0.0) indicate major and breaking changes between the versions
* Changes to the second number (1.01 to 1.02) indicate feature-level changes, such as adding new cmdlets to a module
* Changes to the third number indicate non-breaking changes, such as new parameters, updated samples, or new tests
* When listing versions, PowerShell will sort the versions as strings, so 1.01.0 will be treated as greater than 1.001.0

PowerShell was created before SemVer was published, so it provides support for most but not all elements of SemVer, specifically:

* It does not support prerelease strings in version numbers. This is useful when a publisher wishes to deliver a preview release of a new major version after providing a version 1.0.0. This will be supported in a future release of the PowerShell Gallery and PowerShellGet cmdlets.
* PowerShell and the PowerShell Gallery allow version strings with 1, 2, and 4 segments. Many early modules did not follow the guidelines, and product releases from Microsoft include build information as a 4th block of numbers (for example 5.1.14393.1066). From a versioning standpoint, these differences are ignored.

## Test using a local repository

The PowerShell Gallery is not designed to be a target for testing the publishing process.
The best way to test out the end-to-end process of publishing to the PowerShell Gallery is to set up and use your own local repository.
This can be done in a few ways, including:

* Set up a local PowerShell Gallery instance, using the [PS Private Gallery project](https://github.com/PowerShell/PSPrivateGallery) in Github. This preview project will help you set up an instance of the PowerShell Gallery that you can control, and use for your tests.
* Set up an [internal Nuget repository](https://blogs.msdn.microsoft.com/powershell/2014/05/20/setting-up-an-internal-powershellget-repository/). This will require more work to set up, but will have the advantage of validating a few more of the requirements, notably validating use of an API key, and whether or not dependencies are present in the target when you publish.
* Set up a file share as the test “repository”. This is easy to set up, but since it is a file share, the validations noted above will not take place. One potential advantage in this case is that the file share does not check the (required) API key, so you can use the same key you would to publish to the PowerShell Gallery.

With any of these solutions, use Register-PSRepository to define a new "repository", which you use in the -Repository property for Publish-Module.

One additional point about test publishing: any item you publish to the PowerShell Gallery cannot be deleted without help from the operations team, who will confirm that nothing is dependent upon the item you wish to publish.
For that reason, we do not support the PowerShell Gallery as a testing target, and will contact any publisher who does so.

## Recommended workflow

The most successful approach we have found for items published to the PowerShell Gallery is this:

* Do initial development in a an open-source project site. The PowerShell Team uses Github.
* Use feedback from reviewers and [Powershell Script Analyzer](https://aka.ms/psscriptanalyzer) to get the code to stable state
* Include documentation, so others know how to use your work
* Test out the publishing action using a local repository.
* Publish a stable or Alpha release to the PowerShell Gallery, making sure to include the documentation and link to your project site
* Gather feedback and iterate on the code in your project site, then publish stable updates to the PowerShell Gallery
* Add examples and Pester tests in your project and your module
* Decide if you want to code sign your item
* When you feel the project is ready to use in a production environment, publish a 1.0.0 version to the PowerShell Gallery
* Continue to gather feedback and iterate on your code based on user input
