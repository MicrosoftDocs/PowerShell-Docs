# Contributing to PowerShell Documentation

## Sign a CLA

Before you can contribute to any PowerShell repositories, you must [sign a Microsoft Contribution Licensing Agreement (CLA)](https://cla.microsoft.com/). 
If you've already contributed to PowerShell repostories in the past, congratulations! You've already completed this step.

## Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation. 
All of our documentation hosted on GitHub is written using [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/).

To [edit an existing file](https://help.github.com/articles/editing-files-in-another-user-s-repository/), simply navigate to it and click the "Edit" button. 
GitHub will automatically create your own fork of our repository where you can make your changes. 
Once you're finished, save your edits and submit a pull request to get your changes merged upstream. 
After your pull request is created, 

If you want to contribute new documentation, first check for [issues tagged as "in progress"](https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress) to make sure you're not duplicating efforts.
If no one seems to be working on what you have planned:
* Open a new issue and label it as "in progress" (if you are a member of the PowerShell organization) or add "in progress" as a comment to tell others what you're working on
* Create a fork of our repository and start adding new Markdown-based documentation to it
* When you're ready to contribute your documentation, submit a pull request to the *staging* branch

#### GitHub Flavored Markdown (GFM)

All of the articles in this repository use [GitHub Flavored Markdown (GFM)](https://help.github.com/articles/github-flavored-markdown/).

If you are looking for a good editor, try [Visual Studio Code](https://code.visualstudio.com), 
[Markdown Pad](http://markdownpad.com/) or 
GitHub also provides a web interface for Markdown editing with syntax highlighting and the ability to preview changes. 

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
Links can also have references, which will be discussed in the "Link and Image References" section below.
