# Expectations

Writes a comment on newly opened PRs by community members to set their expectations for how the PR
review process will proceed. You can specify either a message body in Markdown as input with the
**message_body** parameter or specify the path to a Markdown file containing the message body in
your repository.

In either case, the message _must_ include the following HTML comment somewhere in it:

```html
<!-- GHA.Comment.Id.Community.Expectations -->
```

If this comment annotation is not included in the message, the action will not be able to determine
whether the comment (or another version of it) has already been added.

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

- **contents:** `read` to inspect the repository and determine whether the Pull Request author is
  a member of the community or the maintainer team. Anyone who does not have the **Admin** or
  **Maintain** permission is considered a community member by this action.
- **pull-requests:** `write` to add a comment to open Pull Requests by community members.

Because this action requires a `write` permission, the `pull_request` trigger will not be able to
write any comments if the Pull Request comes from a fork of the repository. If you want to use
this action on Pull Requests, you will need to use the `pull_request_target` trigger, which runs
in the context of the base branch the Pull Request is targeting and allows the GitHub token to
have `write` permissions.

Since this action does not use or inspect any of the source files a pull request might change, it
does not need to have access to those changes and the `pull_request_target` trigger will be
functional for this purpose.

Also be aware that whether this action runs on the `pull_request` or `pull_request_target`
trigger, the action gets added to the list of checks for that Pull Request. There is currently no
way in GitHub to mark an action on those triggers as not being a check of the Pull Request itself.

Instead, we suggest that you use this action with the `schedule` trigger to inspect the open Pull
Requests in your repository regularly and comment when needed. This means that there will be a delay
between when a Pull Request is filed and the comment is added, no additional care needs to be taken
with the action and contributors will not see the action in the list of checks on their Pull
Request.

## Examples

### Using a Markdown file

```yaml
name: Commenting
on:
  schedule:
    - cron: 0/15 * * * * # run every 15 minutes
permissions:
  contents: read
  pull-requests: write
jobs:
  Expectations:
    name: Share Expectations on Community PRs
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Checkout Repository
        id: checkout_repo
        uses: actions/checkout@v3
      - name: Comment on Community PRs
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/commenting/expectations/v1@main
        with:
          message_path: .github/messages/expectations.md
          token: ${{ github.token }}
```

This example workflow uses the `schedule` trigger to run every fifteen minutes. It specifies the
minimum permissions needed for this action. For inputs, it specifies the default GitHub token and
the path to a Markdown document in the repository which holds the body text to be written as a
comment on community Pull Requests.

Because it is specifying the path to a document, this workflow also uses the `checkout` action to
clone a copy of the repository. This step _must_ happen before the `expectations` action or it will
not be able to find the file containing the Markdown.

### Using inline Markdown

```yaml
name: Commenting
on:
  schedule:
    - cron: 0 * * * *
permissions:
  contents: read
  pull-requests: write
jobs:
  Expectations:
    name: Share Expectations on Community PRs
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Comment on Community PRs
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/commenting/expectations/v1@main
        with:
          token: ${{ github.token }}
          message_body: |
            <!-- GHA.Comment.Id.Community.Expectations -->
            # Expectations

            Thank you for submitting this contribution! Please make sure
            to read our [style guide][style-guide], fill out the PR
            checklist, and make sure all tests are passing.

            If you have any questions or need any help, please ping the
            maintainers team! We're happy to help.

            If your work isn't ready for review or merge, please make
            sure your PR is in draft mode or the title has a `WIP`
            prefix.

            [style-guide]: https://docs.contoso.com/project/guide/style
```

This example workflow uses the `schedule` trigger to run at the top of every hour. It specifies the
minimum permissions needed for this action. For inputs, it specifies the default GitHub token and
the Markdown content to be written as a comment on community Pull Requests.

## Inputs

### `message_body`

The message in Markdown to write as the comment body. This input should not be used with
**message_path**; if it is, the action will write a warning in the logs and use the **message_body**
when commenting on community Pull Requests.

### `message_path`

The path to the Markdown file to write as the comment body. This input should not be used with
**message_body**; if it is, the action will write a warning in the logs and use the **message_body**
when commenting on community Pull Requests.

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

The `GITHUB_TOKEN` to use to authenticate API calls to verify whether a Pull Request's author is a
maintainer or community member and to comment on open community Pull Requests.

This **must** be passed to the action.

```yaml
required: true
type: string
default: No
```
