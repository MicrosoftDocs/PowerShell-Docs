# Contributing to PowerShell Documentation

Thank you for your interest in PowerShell documentation! See below for details on how you can contribute to our technical documentation.

>For general information about getting started with git and GitHub, see [GitHub Help](https://help.github.com/). 

## Sign a CLA

Before you can contribute to any PowerShell repositories, you must [sign a Microsoft Contribution Licensing Agreement (CLA)](https://cla.microsoft.com/). 
If you've already contributed to PowerShell repostories in the past, congratulations! You've already completed this step.

## Providing feedback on PowerShell documentation

You can point out errors, suggest changes, or request new topics by [creating an issue](https://help.github.com/articles/creating-an-issue/) on the 
[PowerShell-Docs repository issues page](https://github.com/PowerShell/PowerShell-Docs/issues).

Issues are reviewed regularly by members of the PowerShell documentation team, and are triaged, assigned, and addressed accordingly.

## Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation. 
All of our documentation hosted on GitHub is written using [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/).

## Making minor edits to existing topics

To [edit an existing file](https://help.github.com/articles/editing-files-in-another-user-s-repository/), simply navigate to it and click the "Edit" button. 
GitHub will automatically create your own fork of our repository where you can make your changes. 
Once you're finished, save your edits and submit a [pull request](https://help.github.com/articles/creating-a-pull-request/) to the *staging* branch of 
the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository. 
After your pull request is created, someone on the PowerShell documentation team will review your changes before merging them into the *staging* branch.

## Making major edits to existing topics

If you are making substantial changes to an existing article, adding or changing images, or contributing a new article, you will need to manually create your GitHub fork, 
then clone the fork down to your local computer. A fork is a GitHub-based replica of the main repository, under your GitHub account, which provides you with a working copy which you can use 
in isolation. It is from your fork that you will create pull requests. Similarly, a clone is a local based replica of the repository which, in this case, will be a clone of your fork. 
The clone allows you to work on Git repositories offline, and using more powerful native software/tools.

Here is the workflow for making major edits to existing documentation:

1. [Create a fork](https://help.github.com/articles/fork-a-repo/) of the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository.
2. [Create a clone of your fork](https://help.github.com/articles/cloning-a-repository/) on your local computer.
3. Create a new local branch in your cloned repository.
4. Make changes to the file(s) you want to update in a Markdown editor. See below for commonly used Markdown editors.
5. [Push your local branch](https://help.github.com/articles/pushing-to-a-remote/) to your fork.
6. [Create a pull request](https://help.github.com/articles/creating-a-pull-request/) to the *staging* branch of the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository.

## Creating new topics

If you want to contribute new documentation, first check for [issues tagged as "in progress"](https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress) to make sure you're not 
duplicating efforts.
If no one seems to be working on what you have planned:

* Open a new issue and label it as "in progress" (if you are a member of the PowerShell organization) or add "in progress" as a comment to tell others what you're working on
* Follow the same workflow as described above for making major edits to existing topics.
* Edit the `TOC.md` topic (located in the top-level folder for each documentation set) to add your new topics to the table of contents. Determine where your new topic belongs in the table of contents, and add a heading of the appropriate level, with a link
    to your topic (`[My topic title](relative path to my topic)`).

## Markdown editors

Here are some Markdown editors you can try out:

* [Visual Studio Code](https://code.visualstudio.com)
* [Markdown Pad](http://markdownpad.com/)
* [Atom](https://atom.io/)
* [Sublime Text](http://www.sublimetext.com/)


## GitHub Flavored Markdown (GFM)

All of the articles in this repository use [GitHub Flavored Markdown (GFM)](https://help.github.com/articles/github-flavored-markdown/).

Some of the more basic GFM syntax includes:

* **Line breaks vs. paragraphs:** In Markdown there is no HTML `<br />` or `<p />` element. 
Instead, a new paragraph is designated by an empty line between two blocks of text.

> **Note**: Please add a single newline after each sentence to simplify the command-line output of diffs and history.
This is not currently adopted across all of PowerShell-Docs, but we will be working towards it over time. Feel free to help out. 

* **Italics:** The HTML `<em>some text</em>` is written as `*some text*`
* **Bold:** The HTML `<strong>some text</strong>` element is written as `**some text**`
* **Headings:** HTML headings are designated using `#` characters at the start of the line. 
The number of `#` characters corresponds to the hierarchical level of the heading (for example, `#` = `<h1>` and `###` = ```<h3>```).
* **Numbered lists:** To make a numbered (ordered) list start the line with `1. `.  
If you want multiple elements within a single list element, format your list as follows:
```        
1.  For the first element (like this one), insert a tab stop after the 1. 

    To include a second element (like this one), insert a line break after the first and align indentations.
```
to get this output:

1.  For the first element (like this one), insert a tab stop after the 1. 

    To include a second element (like this one), insert a line break after the first and align indentations.

* **Bulleted lists:** Bulleted (unordered) lists are almost identical to ordered lists except that the `1. ` is replaced with either `* `, `- `, or `+ `. 
Multiple element lists work the same way as with ordered lists.
* **Links:** The syntax for a hyperlink is `[visible link text](link url)`.
* **Link to another topic within the same docset:** A docset is a top-level folder in this repository 
    (for example, "dsc", "scripting")The syntax for a hyperlink to a topic within the same docset is 
    `[topic title](relative path to topic)`. For more information, see [Relative links in READMEs](https://help.github.com/articles/relative-links-in-readmes/). To link to a topic in a different top-level folder,
    use the URL of the published page, as described above.
