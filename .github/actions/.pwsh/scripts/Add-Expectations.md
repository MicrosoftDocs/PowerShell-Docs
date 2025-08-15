# Add-Expectations

## Synopsis

Ensures all open community PRs have an expectations comment.

## Syntax

### __AllParameterSets (default)

```Syntax
.\Add-Expectations.ps1
    [-Owner] <string>
    [-Repo] <string>
    [-Message] <string>
    [<CommonParameters>]
```

## Description

This script ensures all open community PRs have an expectations comment. It searches the repository
for open pull requests without the comment (identified by an HTML comment with a special ID in it)
and then checks each open pull request to see if the author is a maintainer or a community member.
If the author is a maintainer, the script skips that PR. If the author is a community member, it
writes the contents of the message rendered as HTML from Markdown as a comment on the PR.

## Examples

### Example 1

```powershell
$Message = Get-Content -Raw ./messages/expectations.md
./Add-Expectations.ps1 -Owner Foo -Repo Bar -Message $Message
```

The script searches `https://github.com/foo/bar` for open pull requests targeting the `main` branch
which do not already have an expectations comment. If the PR author is not a maintainer, it adds the
text from the `expectations.md` file rendered as HTML as a comment on the PR.

## Parameters

### `Owner`

The owner of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the
owner is `foo`.

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

### `Repo`

The name of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the repo
is `bar`.

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

### `Message`

The message to write on uncommented PRs. Must be a single string and should be written as markdown
for best results. The message should include somewhere in it the following HTML comment:

```html
<!-- GHA.Comment.Id.Community.Expectations -->
```

Failure to include that comment in the message causes the script to add the comment to PRs it
already commented on, as it uses the presence of that annotation to find the expectations comment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: [Markdown, Text]

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
