---
title: Create XML-based help using PlatyPS
description: Using PlatyPS is the fast and efficient way to create XML-based help.
ms.date: 07/21/2020
---
# Create XML-based help using PlatyPS

When creating a PowerShell module, it is always recommended that you include detailed help for the
cmdlets you create. If your cmdlets are implemented in compiled code, you must use the XML-based
help. This XML format is known as the Microsoft Assistance Markup Language (MAML).

The legacy PowerShell SDK documentation covers the details of creating help for PowerShell
cmdlets packaged into modules. However, PowerShell does not provide any tools for creating the
XML-based help. The SDK documentation explains the structure of MAML help, but leaves you the
task of creating the complex, and deeply nested, MAML content by hand.

This is where the [PlatyPS][] module can help.

## What is PlatyPS?

PlatyPS is an [open-source][platyps-repo] tool that started as a _hackathon_ project to make the
creation and maintenance of MAML easier. PlatyPS documents the syntax of parameter sets and the
individual parameters for each cmdlet in your module. PlatyPS creates structured [Markdown][]
files that contain the syntax information. It can't create descriptions or provide examples.

PlatyPS creates placeholders for you to fill in descriptions and examples. After adding the required
information, PlatyPS compiles the Markdown files into MAML files. PowerShell's help system also
allows for plain-text conceptual help files (about topics). PlatyPS has a cmdlet to create a
structured Markdown template for a new _about_ file, but these `about_*.help.txt` files must be
maintained manually.

You can include the MAML and Text help files with your module. You can also use PlatyPS to compile
the help files into a CAB package that can be hosted for updateable help.

## Get started using PlatyPS

First you must install PlatyPS from the PowerShell Gallery.

```powershell
Install-Module platyps -Force
Import-Module platyps
```

The following flowchart outlines the process for creating or updating PowerShell reference content.

:::image type="content" source="./media/create-help-using-platyps/cmdlet-ref-flow-v2.png" alt-text="The workflow for creating XML-based help using PlatyPS":::

##  Create Markdown content for a PowerShell module

1. Import your new module into the session. Repeat this step for each module you need to document.

   Run the following command to import your modules:

   ```powershell
   Import-Module <your module name>
   ```

1. Use PlatyPS to generate Markdown files for your module page and all associated cmdlets within the
   module. Repeat this step for each module you need to document.

   ```powershell
   $OutputFolder = <output path>
   $parameters = @{
       Module = <ModuleName>
       OutputFolder = $OutputFolder
       AlphabeticParamsOrder = $true
       WithModulePage = $true
       ExcludeDontShow = $true
       Encoding = 'UTF8BOM'
   }
   New-MarkdownHelp @parameters

   New-MarkdownAboutHelp -OutputFolder $OutputFolder -AboutName "topic_name"
   ```

   If the output folder does not exist, `New-MarkdownHelp` creates it. In this example,
   `New-MarkdownHelp` creates a Markdown file for each cmdlet in the module. It also creates the
   _module page_ in a file named `<ModuleName>.md`. This module page contains a list of the cmdlets
   contained in the module and placeholders for the **Synopsis** description. The metadata in the
   module page comes from the module manifest and is used by PlatyPS to create the HelpInfo XML file
   (as explained [below](#creating-an-updateable-help-package)).

   `New-MarkdownAboutHelp` creates a new _about_ file named `about_topic_name.md`.

   For more information, see [New-MarkdownHelp][] and [New-MarkdownAboutHelp][].

### Update existing Markdown content when the module changes

PlatyPS can also update existing Markdown files for a module. Use this step to update existing
modules that have new cmdlets, new parameters, or parameters that have changed.

1. Import your new module into the session. Repeat this step for each module you need to document.

   Run the following command to import your modules:

   ```powershell
   Import-Module <your module name>
   ```

1. Use PlatyPS to update Markdown files for your module landing page and all associated cmdlets
   within the module. Repeat this step for each module you need to document.

   ```powershell
   $parameters = @{
       Path = <folder with Markdown>
       RefreshModulePage = $true
       AlphabeticParamsOrder = $true
       UpdateInputOutput = $true
       ExcludeDontShow = $true
       LogPath = <path to store log file>
       Encoding = 'UTF8BOM'
   }
   Update-MarkdownHelpModule @parameters
   ```

   `Update-MarkdownHelpModule` updates the cmdlet and module Markdown files in the specified folder.
   It does not update the `about_*.md` files. The module file (`ModuleName.md`) receives any new
   **Synopsis** text that has been added to the cmdlet files. Updates to cmdlet files include the
   following change:

   - New parameter sets
   - New parameters
   - Updated parameter metadata
   - Updated input and output type information

   For more information, see [Update-MarkdownHelpModule][].

## Edit the new or updated Markdown files

PlatyPS documents the syntax of the parameter sets and the individual parameters. It can't create
descriptions or provide examples. The specific areas where content is needed are contained in curly
braces. For example: `{{ Fill in the Description }}`

:::image type="content" source="./media/create-help-using-platyps/placeholders-example.png" alt-text="Markdown template showing the placeholders in VS Code":::

You need to add a synopsis, a description of the cmdlet, descriptions for each parameter, and
at least one example.

For detailed information about writing PowerShell content, see the following articles:

- [PowerShell style guide](/powershell/scripting/community/contributing/powershell-style-guide)
- [Editing reference articles](/powershell/scripting/community/contributing/editing-cmdlet-ref)

> [!NOTE]
> PlatyPS has a specific schema that is uses for cmdlet reference. That schema only allows certain
> Markdown blocks in specific sections of the document. If you put content in the wrong location,
> the PlatyPS build step fails. For more information, see the [schema][] documentation in the
> PlatyPS repository. For a complete example of well-formed cmdlet reference, see [Get-Item][].

After providing the required content for each of your cmdlets, you need to make sure that you update
the module landing page. Verify your module has the correct `Module Guid` and `Download Help Link`
values in the YAML metadata of the `<module-name>.md` file. Add any missing metadata.

Also, you may notice that some cmdlets may be missing a **Synopsis** (_short description_). The
following command updates the module landing page with your **Synopsis** description text. Open the
module landing page to verify the descriptions.

```powershell
Update-MarkdownHelpModule –Path <full path output folder> -RefreshModulePage
```

Now that you have entered all the content, you can create the MAML help files that are displayed by
`Get-Help` in the PowerShell console.

## Create the external help files

This step creates the MAML help files that are displayed by `Get-Help` in the PowerShell console.

To build the MAML files, run the following command:

```powershell
New-ExternalHelp –Path <folder with MDs> -OutputPath <output help folder>
```

`New-ExternalHelp` converts all of the cmdlet Markdown files into one (or more) MAML files. About
files are converted to plain-text files with the following name format: `about_topic_name.help.txt`.
The Markdown content must meet the requirement of the PlatyPS schema. `New-ExternalHelp` will exits
with errors when the content does not follow the schema. You must edit the files to fix the schema
violations.

> [!CAUTION]
> PlatyPS does a poor job converting the `about_*.md` files to plain text. You must use very simple
> Markdown to get acceptable results. You may want to maintain the files in plain-text
> `about_topic_name.help.txt` format, rather than allowing PlatyPS to convert them.

Once this step is complete, you will see `*-help.xml` and `about_*.help.txt` files in the target
output folder.

For more information, see [New-ExternalHelp][]

### Test the compiled help files

You can verify the content with the [Get-HelpPreview][] cmdlet:

```powershell
Get-HelpPreview -Path "<ModuleName>-Help.xml"
```

The cmdlet reads the compiled MAML file and outputs the content in the same format you would receive
from `Get-Help`. This allows you to inspect the results to verify that the Markdown files compiled
correctly and produce the desired results. If you find an error, re-edit the Markdown files and
recompile the MAML.

Now you are ready to publish your help files.

## Publishing your help

Now that you have compiled the Markdown files into PowerShell help files, you are ready to make the
files available to users. There are two options for providing help in the PowerShell console.

- Package the help files with the module
- Create an updateable help package that users install with the `Update-Help` cmdlet

### Packaging help with the module

The help files can be packaged with your module. See [Writing Help for Modules][] for details of the
folder structure. You should include the list of Help files in the value of the **FileList** key in
the module manifest.

### Creating an updateable help package

At a high level, the steps to create updateable help include:

1. Find an internet site to host your help files
1. Add a **HelpInfoURI** key to your module manifest
1. Create a HelpInfo XML file
1. Create CAB files
1. Upload your files

For more information, see [Supporting Updateable Help: Step-by-step][step-by-step].

PlatyPS assists you with  some of these steps.

The **HelpInfoURI** is a URL that points to location where your help files are hosted on the
internet. This value is configured in the module manifest. `Update-Help` reads the module manifest
to get this URL and download the updateable help content. This URL should only point to the folder
location and not to individual files. `Update-Help` constructs the filenames to download based on
other information from the module manifest and the HelpInfo XML file.

> [!IMPORTANT]
> The **HelpInfoURI** must end with a forward-slash character (`/`). Without that character,
> `Update-Help` cannot construct the correct file paths to download the content. Also, most
> HTTP-based file services are case-sensitive. It is important that the module metadata in the
> HelpInfo XML file contains the proper letter case.

The `New-ExternalHelp` cmdlet creates the HelpInfo XML file in the output folder. The HelpInfo XML
file is built using YAML metadata contained in the module Markdown files (`ModuleName.md`).

The `New-ExternalHelpCab` cmdlet creates ZIP and CAB files containing the MAML and
`about_*.help.txt` files you compiled. CAB files are compatible with all versions of PowerShell.
PowerShell 6 and higher can use ZIP files.

```powershell
$helpCabParameters = @{
    CabFilesFolder = $MamlOutputFolder
    LandingPagePath = $LandingPage
    OutputFolder = $CabOutputFolder
}
New-ExternalHelpCab @helpCabParameters
```

After creating the ZIP and CAB files, upload the ZIP, CAB, and HelpInfo XML files to your HTTP file
server. Put the files in the location indicated by the **HelpInfoURI**.

For more information, see [New-ExternalHelpCab][].

### Other publishing options

Markdown is a versatile format that is easy to transform to other formats for publishing. Using a
tool like [Pandoc][], you can convert your Markdown help files to many different document formats,
including plain text, HTML, PDF, and Office document formats.

Also, the cmdlets [ConvertFrom-Markdown][] and [Show-Markdown][] in PowerShell 6 and higher can be
used to convert Markdown to HTML or create a colorful display in the PowerShell console.

## Known issues

PlatyPS is very sensitive to the [schema][] for the structure of the Markdown files it creates and
compiles. It is very easy write valid Markdown that violates this schema. For more information,
consult the [PowerShell style guide][] and [Editing reference articles][].

<!-- link references -->
[platyps-repo]: https://github.com/PowerShell/platyps
[PlatyPS]: https://www.powershellgallery.com/packages/platyPS/
[Markdown]: https://commonmark.org
[markdig]: https://github.com/lunet-io/markdig
[schema]: https://github.com/PowerShell/platyPS/blob/master/platyPS.schema.md
[Get-Item]: https://github.com/MicrosoftDocs/PowerShell-Docs/blob/staging/reference/7.0/Microsoft.PowerShell.Management/Get-Item.md
[New-MarkdownHelp]: https://github.com/PowerShell/platyPS/blob/master/docs/New-MarkdownHelp.md
[Update-MarkdownHelpModule]: https://github.com/PowerShell/platyPS/blob/master/docs/Update-MarkdownHelpModule.md
[New-MarkdownAboutHelp]: https://github.com/PowerShell/platyPS/blob/master/docs/New-MarkdownAboutHelp.md
[New-ExternalHelp]: https://github.com/PowerShell/platyPS/blob/master/docs/New-ExternalHelp.md
[Get-HelpPreview]: https://github.com/PowerShell/platyPS/blob/master/docs/Get-HelpPreview.md
[New-ExternalHelpCab]: https://github.com/PowerShell/platyPS/blob/master/docs/New-ExternalHelpCab.md
[PowerShell style guide]: /powershell/scripting/community/contributing/powershell-style-guide
[Editing reference articles]: /powershell/scripting/community/contributing/editing-cmdlet-ref
[Writing Help for Modules]: /powershell/scripting/developer/help/writing-help-for-windows-powershell-modules
[step-by-step]: /powershell/scripting/developer/help/updatable-help-authoring-step-by-step
[Pandoc]: https://pandoc.org
[ConvertFrom-Markdown]: /powershell/module/microsoft.powershell.utility/convertfrom-markdown
[Show-Markdown]: /powershell/module/microsoft.powershell.utility/show-markdown
