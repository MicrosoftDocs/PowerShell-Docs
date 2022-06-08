## Contributing

Are you interested in helping create the style guide, or do you just want to change a specific rule?
You may use the issues system or Github pull requests freely to suggests corrections and simple
changes to rules. However, if you want to add a completely new rule, or totally change a rule,
please open an issue and let us discuss it!

### Tone

The points in the Best Practices documents and the Style Guide are referred to as _practices_ and
_guidelines_, not rules.

One of the goals as we rewrite these documents is to make it easy to agree with them. Toward that
goal, we try to avoid _absolute_ language, and prefer _proactive_ and _positive_ guidelines over
negative ones. Specifically, try to avoid words like "always" and "never", or "must" and "forbid" in
favor of words like "usually", "normally", "should" and "avoid".

That said, we try not to shy away from making recommendations whenever they will make it easier to
be successful and harder to fail, or when they will make it easier for someone else to pick up the
code later, but we also try to explain the rationale, particularly when the reason is readability
and maintainability, performance, or security, rather than just being a smoother path.

Also, knowing that there are cases where other patterns may be acceptable or even necessary is not
sufficient reason to exclude a practice that is correct most of the time. Rather, each practice or
guideline should include the rationale, an example case, and when appropriate, counter examples and
notable exceptions.

### Current State:

The *PowerShell Best Practices* are always evolving, and continue to be edited and updated as the
language and tools (and our community understanding of them) evolve. Currently they're very new, and
they don't really match the guidelines in this _Contributing_ guide, so we are most happy to take
edits that either help us to match our own guidelines, or fulfill the agreed-upon outcome of a
discussion in the GitHub issues.

### Organization

To repeat from the ReadMe, the guidelines are divided into these sections:

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

Markdown documents on GitHub support linking within a document, but only to headers, so when
editing, in addition to keeping practices and guidelines in the documents where they make sense,
please use headlines for each guideline, and lower level headlines for rationale, examples, counter
examples, and exceptions.

If you can't figure out where something should go, open an issue and we'll discuss it. If there are
enough points which don't fit well in the current sections, we may need to open a new section.

In general, practices and guidelines should be at least a header with an explanatory paragraph.

Style guidelines in particular should be phrased as a prescriptive guideline telling people what to
do rather than a proscriptive or prohibiting rule, and should have both examples and counter
examples.

When you absolutely must write a negative rule, you should start with the phrase "avoid" and end
with an "instead" sentence, like:

> ###### Avoid the use of `~` to represent the home folder.
> The meaning of ~ is unfortunately dependent on the "current" provider at the time of execution.
> This isn't really a style issue, but it's an important rule for code you intend to share anyway.
> **Instead**, use `${Env:UserProfile}` or `(Get-PSProvider FileSystem).Home`
