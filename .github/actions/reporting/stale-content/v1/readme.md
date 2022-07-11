# Stale Content

Writes a report enumerating stale content in one or more folders of a repository. The report notes
the folder, path, and when the document was last updated by folder and subfolder.

To determine whether a document is stale, it inspects the `ms.date` key in the document's
frontmatter and compares that to a specified date (by default, 330 days before the action runs).

By default, this action writes the report in the action's console logs and job summary. You can use
the **UploadArtifact** parameter to automatically upload the report as a CSV file as an
[artifact][artifacts] automatically, write the report as a CSV to the runner for use in a future
step, or use the output data as a variable for a future step in your own workflow.

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
  schedule:
    # midnight UTC on the first of every month
    - cron: 0 0 1 * *
permissions:
  contents: read
jobs:
  Report:
    name: Stale Content
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Checkout Repository
        id: checkout_repo
        uses: actions/checkout@v3
      - name: Write Report
        id: stale_content_report
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/stale-content/v1@main
        with:
          relative_folder_path: |
            reference
          exclude_folder_segment: |
            lang-spec
            media
            samples
          upload_artifact: true
```

This example workflow uses the `schedule` trigger to run at midnight on the first of every month. It
specifies the minimum permissions needed for this action. For inputs, it specifies that the action
should:

- only search the `reference` folder in the project root for stale documents
- ignore any files whose parent path includes a folder named `lang-spec`, `media`, or `samples`
- export the report as a comma-separated-values (CSV) file and upload it as an action artifact

It searches every file in the `reference` folder (except for those excluded) for any files where the
`ms.date` metadata key's value is a date older than 330 days from the time the action runs. It then
writes a report by folder and subfolder in the action's console logs and Markdown summary before
exporting the data as a CSV and uploading it as a GitHub Action artifact named `StaleContentReport`.

The output below is an example of how it renders the stale document report in Markdown.

> ### Stale Content Report
>
> Documents in this report are stale since 8/15/2021 12:00:00 AM
>
> | Relative Root Folder Path | Stale Articles |
> | :------------------------ | :------------: |
> | reference/docs-conceptual | 39             |
>
> #### reference/docs-conceptual
>
> ##### community
>
> | File Name            | Last Updated On |
> | :--------            | :-------------: |
> | community-support.md | 04/29/2020      |

## Inputs

### `relative_folder_path`

Specify the path to the folder or folders to recursively search for stale documents, relative to the
root of the repository. If not specified, the default value is the repository's root folder.

To specify multiple folders, separate each folder by a newline in a multiline string block in yaml,
like this:

```yaml
name: Stale Content Report
uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/stale-content/v1@main
with:
  relative_folder_path: |
    reference/conceptual
    reference/contribution
```

In this example, only the `reference/conceptual` and `reference/contribution` folders in the root
folder for the repository are inspected for stale documentation.

```yaml
required: false
type: string
default: no
```

### `exclude_folder_segment`

Specify one or more complete folder segments as strings to exclude from the list of files to report
on. Any file whose path case-insensitively matches an excluded segment are discarded from the list
before inspection.

To specify multiple folders, separate each folder by a newline in a multiline string block in yaml,
like this:

```yaml
name: Stale Content Report
uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/stale-content/v1@main
with:
  exclude_folder_segment: |
    archived
    release-notes
```

In this example, any documents in folders named `archived` and `release-notes` are ignored
during inspection, regardless of the rest of their root path or how nested they are. So the files in
the folders `reference/archived/v1/`, `reference/foo/release-notes/`, and
'reference/bar/release-notes' would be ignored, but not files in `reference/baz/release/notes` or
the `reference/archived.md` file.

```yaml
required: false
type: string
default: no
```

### `days_until_stale`

Specify an integer representing how many days can pass before a document is considered stale. If any
document's `ms.date` key is older than this value, it is returned as a stale document.

If used with the **stale_since_date** parameter, this value is ignored and the action emits a
warning.If neither this parameter nor **stale_since_date** are specified, the action treats files
with an `ms.date` value older than 330 days from when the action is run as stale.

```yaml
required: false
type: int
default: no
```

### `stale_since_date`

Specify an [ISO 8601][iso-8601] date-time string representing the point at which any older documents
are considered stale. If any document's `ms.date` key is older than this value, it is returned as a
stale document.

If used with the **days_until_stale** parameter, this value is used and the action emits a warning.
If neither this parameter nor **days_until_stale** are specified, the action treats files with an
`ms.date` value older than 330 days from when the action is run as stale.

```yaml
required: false
type: string
default: no
```

### `upload_artifact`

Specify as `true` to upload the CSV of the report as an [action artifact][artifacts]. If this
parameter is not specified or is specified as anything other than `true` (case-insensitive), the
action does not automatically upload the report as an artifact. This parameter implies the use of
**export_as_csv**, you do not need to specify them together.

If this action is used to upload the report as an artifact, it does so with the name of the artifact
set to the same value as the path to the CSV file (see the **export_path** parameter) with the
default retention period.

For more control over how reports are uploaded, consider using the
[actions/upload-artifact][artifact-action] action directly, like so:

```yaml
- name: Stale Content Report
  uses: MicrosoftDocs/PowerShell-Docs/.github/actions/reporting/stale-content/v1@main
  with:
    export_as_csv: true
    export_path: report.csv
- name: Upload Stale Content Report
  uses: actions/upload-artifact@v3
  with:
    name: stale-report
    path: report.csv
    retention-days: 30
```

This example uses this action to generate a stale content report CSV file and then uses the
`actions/upload-artifact` action separately to upload the artifact with workflow-defined name
(`stale-report`) and retention period (`30` days).

```yaml
required: false
type: boolean
default: no
```

### `export_as_csv`

Specify as `true` to export the stale content report as a comma-separated values (CSV) file.
If this parameter is not specified or is specified as anything other than `true`
(case-insensitive), the action does not export the report. It still writes the report in
the console logs and Markdown summary for the workflow. Using the **upload_artifact**
parameter implies this parameter. You do not need to specify them together.

By default, the report is exported to the project root as `StaleContentReport.<%Y-%m-%d>.csv`,
where `<%Y-%m-%d>` is the date the action is run. For example, if run on July 12 2022, the
filename is `StaleContentReport.2022-07-12.csv`. Use the **export_path** parameter to set a
different path or name for the report.

```yaml
required: false
type: boolean
default: no
```

### `export_path`

Specify the path to where the CSV file should be written. This parameter is only valid with the
**UploadArtifact** or **ExportAsCsv** parameters. If used without them, the value is ignored.

```yaml
required: false
type: string
default: no
```

[artifact-action]: https://github.com/actions/upload-artifact
[artifacts]: https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts
[iso-8601]: https://www.iso.org/iso-8601-date-and-time-format.html
