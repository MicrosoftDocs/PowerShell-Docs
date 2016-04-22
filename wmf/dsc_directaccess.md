# Direct access to DSC resource methods


The `Invoke-DscResource` cmdlet has been added to allow direct access to DSC resources and their methods (Get, Set or Test). It can be used by third-parties that want to take advantage of DSC resources. This cmdlet is typically used in combination with `refreshMode = ‘Disabled’` but can be used no matter what refreshMode is set to. Below are some examples of how to use the new cmdlet:

## Ensure a file is present

```powershell
$result = Invoke-DscResource -Name File -Method Set -Property @{
							DestinationPath = "$env:SystemDrive\\DirectAccess.txt";
							Contents = 'This file is create by Invoke-DscResource'} -Verbose
$result | fl
```

## Test that a file is present

```powershell
$result = Invoke-DscResource -Name File -Method Test -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'} -Verbose
$result | fl
```

## Get the contents of file

```powershell
$result = Invoke-DscResource -Name File -Method Get -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'} -Verbose
$result.ItemValue | fl
```
