# Authorization

Checks to see whether a user may perform a certain action. For example, to target the `live` branch
of a repository or to submit a PR editing repository configuration.

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

- **metadata:** `read` to inspect the repository and determine the permissions of a user for that
  repository.

Unfortunately, GitHub Actions does not allow a workflow author to specify **metadata** in the list
of permissions for a job or step. It does however allow you to specify **contents**, which seems to
enable the same behavior while minimizing the risk.

Note that the `pull_request` trigger will not be able to retrieve the permissions of users if the
Pull Request comes from a fork of the repository. If you want to use this action on Pull Requests,
you must use the `pull_request_target` trigger, which runs in the context of the base branch the
Pull Request is targeting and allows the GitHub token to retrieve those permissions.

## Examples

### Verifying authorization to target a branch

```yaml
name: Authorization
on:
  pull_request_target:
    branches:
      - live
permissions:
  contents: read
jobs:
  Test:
    name: Check Branch Permissions
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Authorized to Target Live Branch?
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/verification/authorization/v1@main
        with:
          token: ${{ github.token }}
```

This workflow uses the `pull_request_target` trigger to check whether a Pull Request author is
permitted to submit their Pull Request to the `live` branch. It only runs on Pull Requests which
target the `live` branch, so other Pull Requests don't get a skipped message for this check.

It passes the GitHub token to the action but does not specify a target, relying on the default for
that input, which is the `live` branch.

### Verifying authorization to change sensitive files

```yaml
name: Authorization
on:
  pull_request_target:
    branches:
      - main
    paths:
      - .github/workflows/**
permissions:
  contents: read
jobs:
  Test:
    name: Check Repo File Permissions
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Authorized to Modify Repo Files?
        uses: ./.github/actions/verification/authorization/v1
        with:
          token: ${{ github.token }}
          permissions: Maintain,Admin
          target: path:.github/workflows/
```

This workflow uses the `pull_request_target` trigger to checker whether a Pull Request author is
permitted to submit a Pull Request that modifies files in the `.github/workflows` or `.config`
folders. It only runs on Pull Requests which modify files in those folders, so other Pull Requests
don't get a skipped message for this check.

It passes the GitHub token to the action and specifies that it requires the user to have the
`Maintain` or `Admin` permissions. Because GitHub Actions cannot have arrays as input, the input
needed to be specified as a comma-separated string. Finally, it specifies the **target** as
`path:.github/workflows/,.config/`. The `path:` prefix tells the action to write a message about
authorization to change files in those paths.

## Inputs

### `permissions`

The permissions a user requires to perform a given task. Must be a comma-separated string of valid
permissions. Valid permissions are (case-insensitive):

- `Admin`
- `Maintain`
- `Pull`
- `Push`
- `Triage`

If a user has _any_ of the specified permissions, they are authorized.

```yaml
required: true
type: string
default: Admin,Maintain
```

### `repository`

The full name of a repository; to target `https://github.com/MicrosoftDocs/PowerShell-Docs`, the
value should be `MicrosoftDocs/PowerShell-Docs`.

By default, the value is the repository the _workflow_ is defined in. Unless you are running this
action against another repository, you should not need to specify this value.

### `target`

The branches or globbed file paths to verify authorization to target for changes. To specify
a branch, type a string like `branch:live`. This value determines the messaging for this
action but does not limit the authorization status check. To ensure your authorization
workflow only runs when a branch is targeted, use the **branches** setting for the
`pull_request` or `pull_request_target` trigger. To ensure your authorization workflow only
runs when a Pull Request modifies particular files, use the **paths** setting for the
`pull_request` or `pull_request_target` trigger. You can use those settings together. For
more information, see the documentation for the [branches][syntax-docs-branches] and
[paths][syntax-docs-paths] settings for workflows in GitHub's documentation.

To specify multiple branches, separate each branch
by a comma and/or newline, like `branch: live, production`. To specify a filepath, specify one
or more path separated by a comma and/or a newline, like `path: foo/**/*.md, bar/*.json`.

If you do not specify a prefix like `branch:` or `path:` or specify an invalid prefix, it will
be interpreted as branch. The default is `branch:live`.

When using multiple values, it can be easier to type them in a multiline string block in yaml,
like this:

```yaml
name: Authorized to Modify Repo Files?
uses: MicrosoftDocs/PowerShell-Docs/.github/actions/verification/authorization/v1@main
with:
  target: |
    path:
      *.config.json
      first/folder/path
      another/path
      final/path/entry/*.jsonc
```

```yaml
required: true
type: string
default: branch:live
```

### `token`

The GITHUB_TOKEN to use to authenticate API calls to verify the user's permissions for the
repository. This **must** be passed to the action.

```yaml
required: true
type: string
default: no
```

### `user`

The GitHub login ID to check permissions for.

By default, the value is the author of the Pull Request when the workflow uses the `pull_request` or
`pull_request_target` trigger. For any other trigger, you will need to specify this value.

```yaml
required: true
type: string
default: ${{ github.event.pull_request.user.login }}
```

[syntax-docs-branches]: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onpull_requestpull_request_targetbranchesbranches-ignore
[syntax-docs-paths]:    https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onpushpull_requestpull_request_targetpathspaths-ignore
