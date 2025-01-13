# Test-Checklist

## Synopsis

Inspects Markdown to find checklist items and their status

## Syntax

### __AllParameterSets (Default)

```Syntax
.\Test-Checklist.ps1
    [-Body] <string>
    [[-ReferenceUrl] <string>]
    [<CommonParameters>]
```

## Description

This script inspects the Markdown body of a Pull Request or GitHub comment to find mandatory
checklist items and determine if they are checked or not. It writes console messages and a GitHub
summary annotating the findings. If any mandatory checklist items are discovered and not checked,
the script throws an exception, failing both the script and associated GitHub Action.

To discover mandatory checklist items, it looks for checklist entries that are bolded with
double-asterisks and a colon suffix. For example:

```markdown
- Not a checklist item
- [ ] Not a _mandatory_ checklist item
- [ ] **Foo:** a mandatory checklist item that _is not_ checked
- [x] **Bar:** a mandatory checklist item that _is_ checked.
```

## Examples

### Example 1

```powershell
$PullRequest = gh pr view --repo 'foo/bar' 123 --json body --json url | ConvertFrom-Json
./Test-Checklist.ps1 -Body $PullRequest.Body -ReferenceUrl $PullRequest.Url
```

This example gets pull request 123 from the `bar` repository owned by `foo`, retrieving the body and
URL of that pull request. It then passes those values to the script, which then inspects the body
for mandatory checklist items and report their status.

## Parameters

### `Body`

A block of Markdown text to inspect. This can come from a pull request or comment or you can pass an
arbitrary block of Markdown to verify what mandatory checklist items exist and what their status is
while developing a checklist.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `ReferenceUrl`

The URL to the pull request, comment, or other source of the Markdown passed in the **Body**. This
is only used for the error generation/reporting if the checklist is not fully filled out.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
