# Style guide for PowerShell-Docs


## Titles/Headings

* Titles/headings (anything preprended by \#) should be followed with a newline
* Only the first letter of a title and any proper nouns in that title should be capitalized
* Only 1 H1 per document
* When editing reference content, the H2s are prescribed by platyPS and should not be added or removed as it will cause a build break
* Only use \# style headers (as opposed to = or \- style headers)

### Correct

```
# Header 1

## Header 2

### Header 3

```

### Incorrect

```
Header 1
========

Header 2
--------

### Header 3
```

## Terminology

There are several variants of PowerShell. 
This table defines some of the different terms used to discuss PowerShell.

| Terminology | Definition |
| ----- | -----|
| PowerShell |	This is the default. We are shipping PowerShell. The term PowerShell can be legitimately used to indicate any of the particular editions. This can be used to refer to the language, framework and default cmdlets, etc. |
| PowerShell Core (PSCore) |	PowerShell built on .NET Core Common Language Runtime (CoreCLR) for any of the platforms. | 
| Windows PowerShell	| PowerShell built on .NET Common Language Runtime (CLR). Windows PowerShell ships only on Windows and requires the complete CLR. |

In general, references to "Windows PowerShell" in documentation can be changed to "PowerShell".
"Windows PowerShell" should **not** be changed when Windows-specific technology is being discussed. 

## About_ Files
We are changing the way we process about_ files.
For details, see [issue #1806](https://github.com/PowerShell/PowerShell-Docs/issues/1806). 
Until this issue is completed, about_ files will not be properly formatted Markdown issues.
Please do not alter the formatting of about_ files without checking in with a repo maintainer.

## Syntax

* When talking about a cmdlet in paragraph, use \` to highlight cmdlet names
  * Correct Example:
  This `Write-Host` Cmdlet can ...
  * Incorrect Example:
  This **Write-Host** Cmdlet can ... and pipeline to out-file Cmdlet to ...
* When writing an article (as opposed to reference content), the first instance of a cmdlet name should be a link to the cmdlet documentation
* All PowerShell syntax blocks should use &#96;&#96;&#96;powershell
* Do not start PowerShell commands with "`PS C:\>`"
  * Correct Example:
  ```powershell
  Get-Process
  ```
  * Incorrect Example:
  ```powershell
  PS C:\> Get-Process
  ```
* Output emitted by PowerShell commands should be commented to prevent it from recieving syntax highlighting
* Property names and parameter names should be in **bold**
* PowerShell cmdlets are "[Pascal Cased](https://en.wikipedia.org/wiki/PascalCase)". Verbs are seperated from nouns by a hyphen.

## Lists

* Do not end list items with a period (unless they contain multiple sentences)
* If your list contains multiple sentences, consider using a header 3/4/5 (as applicable) underneath your primary idea

## Links

* Links are always marked up using MarkDown syntax `[friendlyname](url)`
* Links should have a a friendly name when applicable, most likely the title of the linked page
  * **Exception**: Links going towards non-Microsoft sites should only have a URL
* All items in the "related links" section at the bottom should be hyperlinked. 

## Line breaks

* You must include semantic line breaks
* You should limit lines to 100char (Open item: tooling to help us validate this)
* You CAN remove additional line breaks for PS4+, NOT ps3 (needs validation)
