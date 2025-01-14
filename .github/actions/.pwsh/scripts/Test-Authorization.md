# Test-Authorization

## Synopsis

Checks if a user may perform an action.

## Syntax

### Branch (Default)

```syntax
.\Test-Authorization.ps1
    -Owner <string>
    -Repo <string>
    -User <string>
    -TargetBranch <string>
    [-ValidPermissions <string[]>]
    [<CommonParameters>]
```

### Path

```syntax
.\Test-Authorization.ps1
    -Owner <string>
    -Repo <string>
    -User <string>
    -TargetPath <string[]>
    [-ValidPermissions <string[]>]
    [<CommonParameters>]
```

## Description

Checks if a user may perform an action. A user is authorized if they have one or more of the
specified permissions. If the user is not authorized, the script (and any GHA workflow calling it)
fails.

## Examples

### Example 1

```powershell
  ./Test-Authorization.ps1 -Owner foo -Repo bar -Author baz -TargetBranch live
```

The script checks the permissions of the `baz` user for `https://github.com/foo/bar`. If `baz` has
maintainer or admin permissions, the script exits without error. If they do not, the script throws
an error declaring the `baz` does not have enough permissions to target the `live` branch.

### Example 2

```powershell
$Paths = @(
  '.github/pwsh'
  '.github/workflows'
)
./Test-Authorization.ps1 -Owner foo -Repo bar -Author baz -TargetPath $Paths
```

The script checks the permissions of the `baz` user for `https://github.com/foo/bar`. If `baz` has
maintainer or admin permissions, the script exits without error. If they do not, the script throws
an error declaring the `baz` does not have enough permissions to target either the `pwsh` or
`workflows` folder.

## Parameters

### `Owner`

The owner of the repository to check the user's permissions in. For `https://github.com/foo/bar` the
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

The name of the repository to check the user's permissions in. For `https://github.com/foo/bar` the
name is `bar`.

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

### `User`

The GitHub login to retrieve permissions for.

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

### `TargetBranch`

Specifies the name of a branch requiring permissions to target.

```yaml
Type: System.String
Parameter Sets: (Branch)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `TargetPath`

Specifies the path to one or more files requiring permissions to modify.

```yaml
Type: System.String[]
Parameter Sets: (Path)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `ValidPermissions`

One or more GitHub permissions the user must have. If the user has any of the specified permissions,
they are authorized for the action. By default, a user must have the `Admin` or `Maintain`
permission.

GitHub permissions include:

- `Admin`
- `Maintain`
- `Pull`
- `Push`
- `Triage`

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### Notes

The **TargetBranch** and **TargetPath** parameters are for convenience; GitHub repositories do not
have a built-in way to define permissions for branches or folders except for branch protection,
which isn't enough for this purpose. To ensure this script is effective, use the **branches**
and **paths** settings in the workflow when defining a **pull_request_target** job trigger.
