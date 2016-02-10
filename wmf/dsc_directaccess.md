# Direct Access to DSC Resource Methods

This cmdlet has been added to allow direct access to DSC resources and there methods (Get, Set or Test). It can be used by third-parties that want to take advantage of DSC Resources. This cmdlet is typically used in combination with the refreshMode = ‘Disabled’ but can be used no matter what refreshMode is set to. Below are some examples of how to use the new cmdlet.

### Ensure a File is present

```powershell
$result = Invoke-DscResource -Name File -Verbose -Method Set -Property @{
							DestinationPath = "$env:SystemDrive\\DirectAccess.txt";
							Contents = 'This file is create by Invoke-DscResource'}
$result | fl
```

### Test a File is present

```powershell
$result = Invoke-DscResource -Name File -Verbose -Method Test -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'} 
$result | fl
```

### Get the contents of File

```powershell
$result = Invoke-DscResource -Name File -Verbose -Method Get -Property @{
							DestinationPath="$env:SystemDrive\\DirectAccess.txt";
							Contents='This file is create by Invoke-DscResource'}
$result.ItemValue | fl
```
