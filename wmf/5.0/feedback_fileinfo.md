# Updates to FileInfo object
File version information can be misleading, particularly in cases where the file was patched. This release of WMF 5.0 adds new **FileVersionRaw** and **ProductVersionRaw** 
script properties to FileInfo objects. Here are the properties as displayed for powershell.exe (assuming $pid is the ID of the PowerShell process):

```powershell
PS C:\> Get-Process -Id $pid -FileVersionInfo | fl *version* -Force


FileVersionRaw    : 10.0.10586.117
ProductVersionRaw : 10.0.10586.117
FileVersion       : 10.0.10586.117 (th2_release.160212-2359)
ProductVersion    : 10.0.10586.117
