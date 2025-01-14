# Action Scripts

This folder contains the scripts used by the GitHub Actions (GHA). Each script is used by a
different action:

|                   Script                   |                       Action                       |
| :----------------------------------------- | :------------------------------------------------- |
| [Add-Expectations][expectations-script]    | [commenting/expectations][expectations-action]     |
| [Test-Authorization][authorization-script] | [verification/authorization][authorization-action] |
| [Test-Checklist][checklist-script]         | [verification/checklist][checklist-action]         |

## Add-Expectations

This script ensures all open community PRs have an expectations comment. It searches the repository
for open pull requests without the comment (identified by an HTML comment with a special ID in it)
and then checks each open pull request to see if the author is a maintainer or a community member.
If the author is a maintainer, the script skips that PR. If the author is a community member, it
writes the contents of the message rendered as HTML from Markdown as a comment on the PR.

For more information, see [the reference document][expectations-doc].

## Test-Authorization

Checks if a user may perform an action. An author is authorized if they have one or more of the
specified permissions. If the author is not authorized, the script (and any GHA workflow calling it)
fails.

For more information, see [the reference document][authorization-doc].

## Test-Checklist

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

For more information, see [the reference document][checklist-doc].

<!-- reference links -->
[authorization-action]: ../../verification/authorization/v1/readme.md
[authorization-doc]:    ./Test-Authorization.md
[authorization-script]: ./Test-Authorization.ps1
[checklist-action]:     ../../verification/checklist/v1/readme.md
[checklist-doc]:        ./Add-Expectations.md
[checklist-script]:     ./Add-Expectations.ps1
[expectations-action]:  ../../commenting/expectations/v1/readme.md
[expectations-doc]:     ./Add-Expectations.md
[expectations-script]:  ./Add-Expectations.ps1
