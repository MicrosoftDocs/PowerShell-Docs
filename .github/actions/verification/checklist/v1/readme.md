# Checklist

Inspects the checklist items on a pull request to see if they have all been filled out. It only
looks for mandatory checklist items. If any mandatory checklist items are not checked, the action
fails. It writes a summary and console logs indicating which mandatory checklist items were not
checked.

To be interpreted by this action as mandatory checklist items, they must be formatted in Markdown to
follow a specific syntax:

```markdown
- [ ] **Item Name:** Explanation of the item`
```

To be recognized as a mandatory checklist item by this action, the item must:

- use valid syntax for checklists on GitHub (i.e. `- [ ]` for an unchecked item and `- [x]` for a
  checked item)
- immediately follow the checklist syntax with a single space and then two asterisks (`**`)
- include one or more characters, specifying the name of the mandatory checklist item
- close the name of the item with a colon followed by two asterisks (`:**`)

Including explanatory text after the mandatory checklist item declaration is strictly optional but
strongly encouraged.

This example code block illustrates how this action parses Markdown and what is interpreted as a
valid mandatory checklist item for this action to verify:

```markdown
A paragraph is not a checklist item

- This is a list item, but not a checklist item.
- [ ] This is a checklist item, but not mandatory.
- [ ] Not Bold: This is a checklist item, but not recognized as mandatory.
- [ ] **Colon Outside**: This is a checklist item, but not recognized as mandatory.
- [ ] **Foo:** This is a mandatory checklist item named `Foo`. It is not checked.
- [x] **Bar:** This is a mandatory checklist item named `Bar`. It is checked.
```

## Versioning

This action uses a simplified versioning that only tracks major versions. This is the documentation
for `v1`. Any _backwards-compatible_ improvements to this action will update this version. If and
when the maintainers decide to make a backwards-incompatible change - one that will require manual
updates on the part of anyone using this action - we will create a new folder for the next major
version, `v2`.

We do not have any plans to delete prior versions, but once we move onto a new major version we will
not be investing time and effort into updating the older versions.

## Permissions

This action requires no read or write permissions as long as it is used with the `pull_request` or
`pull_request_target` trigger because the necessary information is included in the event payload for
those triggers.

## Examples

```yml
name: Checklist
on:
  pull_request:
    branches:
      - main
    types:
      - opened
      - reopened
      - ready_for_review
      - edited
      - synchronize
permissions:
  contents: read
jobs:
  Test:
    name: Verify Status
    runs-on: windows-latest
    if: |
      !contains(github.event.pull_request.title, 'WIP') &&
      !github.event.pull_request.draft
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Verify Checklist
        id: verify_checklist
        uses: MicrosoftDocs/PowerShell-Docs/.github/actions/verification/checklist/v1@main
```

This workflow uses the `pull_request` trigger to verify whether the checklist included in the Pull
Request template has been filled out. It only runs on Pull Requests targeting the `main` branch when
they are opened, reopened, specifically request a review, the body is edited, or the author updates
their Pull Request (as with a force push).

The job only runs if the title of the Pull Request does not include `WIP` anywhere in it and the
Pull Request is not marked as a draft - if it's WIP or a draft, there's no reason to verify the
checklist because the Pull Request is not ready for final review or merge.

When the Pull Request meets those criteria, this action is called and it inspects the body of the
Pull Request to discover any mandatory checklist items. It then reports whether those items are
checked or not. If any mandatory checklist items are not checked, the action fails with an error,
reporting which mandatory items have not yet been checked.

## Inputs

### `body`

The body of the GitHub Pull Request to inspect for checklist completion. If using this action on a
`pull_request` or `pull_request_target` event, this is handled automatically. Otherwise, it must be
specified.

```yaml
required: true
type: string
default: ${{ github.event.pull_request.body }}
```

### `pull_request_url`

The URL of the GitHub Pull Request, issue, discussion, or comment to inspect for checklist
completion. If using this action on a `pull_request` or `pull_request_target` event, this is handled
automatically. Otherwise, it must be specified.

```yaml
required: true
type: string
default: ${{ github.event.pull_request.url }}
```
