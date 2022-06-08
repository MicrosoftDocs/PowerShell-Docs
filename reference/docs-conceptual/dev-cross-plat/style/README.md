## The PowerShell Best Practices and Style Guide

[Table Of Contents](#table-of-contents)

<p align="center">
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/" style="display: inline-block; float: left; vertical-align: middle; margin: 10px;">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a></p>

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/),
please attribute to Don Jones, Matt Penny, Carlos Perez, Joel Bennett and the PowerShell Community.

###### You are free to:

**Share** — copy and redistribute the material in any medium or format

**Adapt** — remix, transform, and build upon the material

The authors encourage you to redistribute this content as widely as possible, but require that you
give credit to the primary authors below, and that you notify us on GitHub of any improvements you
make.

### What are Best Practices

_PowerShell Best Practices_ are what you should usually do as a starting point. They are ways of
writing, thinking, and designing which make it _harder_ to get into trouble. The point of a _Best
Practice_ is to help the reader to fall into the pit of success:

> **The Pit of Success:** in stark contrast to a summit, a peak, or a journey across a desert to
> find victory through many trials and surprises, we want our customers to simply fall into winning
> practices by using our platform and frameworks. To the extent that we make it easy to get into
> trouble we fail.
>
> -- Rico Mariani, MS Research MindSwap Oct 2003.

Like English spelling and grammar rules, PowerShell programming best practices and style rules
nearly always have exceptions, but we are documenting a baseline for code structure, command design,
programming, formatting, and even style which will help you to avoid common problems, and help you
write more reusable, readable code -- because reusable code doesn't have to be rewritten, and
readable code can be maintained.

Having said that, remember: the points in the Best Practices documents and the Style Guide are
referred to as _practices_ and _guidelines_, not rules. If you're having trouble getting something
done because you're trying to avoid _breaking_ a style or best practice rule, you've misunderstood
the point: this document is pragmatic, rather than dogmatic. We'll leave dogmatism to teams and
projects that require you to meet their specific guidelines.

### Table of Contents

The guidelines are divided into these sections:

* [Style Guide (Introduction)](Style-Guide/Introduction.md)
  * [Code Layout and Formatting](Style-Guide/Code-Layout-and-Formatting.md)
  * [Function Structure](Style-Guide/Function-Structure.md)
  * [Documentation and Comments](Style-Guide/Documentation-and-Comments.md)
  * [Readability](Style-Guide/Readability.md)
  * [Naming Conventions](Style-Guide/Naming-Conventions.md)
* [Best Practices (Introduction)](Best-Practices/Introduction.md)
  * [Naming Conventions](Best-Practices/Naming-Conventions.md)
  * [Building Reusable Tools](Best-Practices/Building-Reusable-Tools.md)
  * [Output and Formatting](Best-Practices/Output-and-Formatting.md)
  * [Error Handling](Best-Practices/Error-Handling.md)
  * [Performance](Best-Practices/Performance.md)
  * [Security](Best-Practices/Security.md)
  * [Language, Interop and .Net](Best-Practices/Language-Interop-and-.Net.md)
  * [Metadata, Versioning, and Packaging](Best-Practices/Metadata-Versioning-and-Packaging.md)


#### Credits

_The Community Book of PowerShell Practices_ was originally compiled and edited by Don Jones and
Matt Penny with input from the Windows PowerShell community on PowerShell.org.

Portions copyright (c) Don Jones, Matt Penny, 2014-2015

_The PowerShell Style Guide_ was originally created by Carlos Perez, for his students, and all the
good parts were written by him.

Portions copyright (c) Carlos Perez, 2015

Any mistakes in either of these documents are there because Joel Bennett got involved. Please submit
[issues](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues) and help us correct them.

Portions copyright (c) Joel Bennett, 2015
