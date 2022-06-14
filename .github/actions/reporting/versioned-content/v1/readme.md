# Versioned Content

Writes a report on the changes to versioned content in a repository by Pull Request. The report
summarizes how many changes in the Pull Request were to versioned content and writes tables
enumerating every changed file by folder and how, if at all, the Pull Request modified each file by
version.

## Versioning

This action uses a simplified versioning that only tracks major versions. This is the documentation
for `v1`. Any _backwards-compatible_ improvements to this action will update this version. If and
when the maintainers decide to make a backwards-incompatible change - one that will require manual
updates on the part of anyone using this action - we will create a new folder for the next major
version, `v2`.

We do not have any plans to delete prior versions, but once we move onto a new major version we will
not be investing time and effort into updating the older versions.

## Permissions

This action requires the following permissions:

- **contents:** `read` to retrieve information about the changed files to report on.

## Examples

```yml
name: Reporting
on:
  pull_request:
    branches:
      - main
    paths:
      - reference
permissions:
  contents: read
jobs:
  Report:
    name: Versioned Content
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Write Report
        id: versioned_content_report
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/versioned-content/v1@main
        with:
          token: ${{ github.token }}
          include_path_pattern: |
            ^reference
          exclude_path_pattern: |
            archive\/
```

This workflow uses the `pull_request` trigger to report on changes to versioned content in the Pull
Request. It only runs on Pull Requests targeting the `main` branch which change at least one file in
the `reference` folder.

When the Pull Request meets those criteria, this action is called. It retrieves the list of changes
for the Pull Request. Before it does anything else, it filters the changed files because of the use
of the **include_path_pattern** and **exclude_path_pattern** inputs.

First, it filters the list of files to only include those whose path starts with `reference`. After
the list is filtered by the include pattern, it is filtered again to exclude any files with a folder
segment ending in `archive`.

After the list of changes is filtered, it searches those changes to find ones to versioned content,
as identified by the inclusion of a version for a folder name. It then processes the versioned
content and the rest of the files to correlate every version of an identically-named file together
and write a report for every folder with modified versioned content, enumerating how the file was
modified (if at all) across the versions.

The output below is an example of how it renders the changeset for files by folder and version.

> ### Change Sets for `Microsoft.PowerShell.Archive`
>
> | Version-Relative Path             | 5.1        | 7.0        | 7.1     | 7.2        | 7.3       |
> |:----------------------------------|:----------:|:----------:|:-------:|:----------:|:---------:|
> | `Compress-Archive.md`             | Unchanged  | Unchanged  | Removed | Unchanged  | Unchanged |
> | `Expand-Archive.md`               | Unchanged  | Unchanged  | Removed | Unchanged  | Unchanged |
> | `Microsoft.PowerShell.Archive.md` | Unchanged  | Unchanged  | Removed | Unchanged  | Unchanged |

## Inputs

### `exclude_path_pattern`

Regular expression patterns to compare to the changed content file paths. Only changes whose path
matches _none_ of the specified patterns are included in the report.

To specify multiple patterns, separate each branch by a newline in a multiline string block in yaml,
like this:

```yaml
name: Versioned Content Report
uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/versioned-content/v1@main
with:
  exclude_path_pattern: |
    ^reference\/
    AlwaysReport
```

Any changes to file paths matching `^reference\/` (anything under the `reference` folder in the
repository's root folder) or `AlwaysReport` (any file in the repository with that text in its path)
is excluded from the report.

```yaml
required: false
type: string
default: no
```

### `include_path_pattern`

Regular expression patterns to compare to the changed content file paths. Only changes whose path
matches one or more of the specified patterns are included in the report.

To specify multiple patterns, separate each branch by a newline in a multiline string block in yaml,
like this:

```yaml
name: Versioned Content Report
uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/versioned-content/v1@main
with:
  include_path_pattern: |
    ^reference\/
    AlwaysReport
```

Only changes to file paths matching `^reference\/` (anything under the `reference` folder in
the repository's root folder) and `AlwaysReport` (any file in the repository with that text in
its path) is included in the report.

```yaml
required: false
type: string
default: no
```

### `number`

The numerical ID of the PR to check for versioned content. By default, this action uses the number
for the current Pull Request if the calling workflow is triggered by the `pull_request` or
`pull_request_target` event.

```yaml
required: true
type: int
default: ${{ github.event.pull_request.number }}
```

### `repository`

The full name of a repository; to target `https://github.com/MicrosoftDocs/PowerShell-Docs`, the
value should be `MicrosoftDocs/PowerShell-Docs`.

By default, the value is the repository the _workflow_ is defined in. Unless you are running this
action against another repository, you should not need to specify this value.

```yaml
required: true
type: string
default: ${{ github.repository }}
```

### `token`

The GITHUB_TOKEN to use to authenticate API calls to retrieve the changes a Pull Request makes. This
**must** be passed to the action.

```yaml
required: true
type: string
default: no
```
