# Updates to FileInfo object
File version information can be misleading, particularly in cases where the file was patched. This release of WMF Production Preview adds new **FileVersionRaw** and **ProductVersionRaw** script properties to FileInfo objects. Here are the properties as displayed for powershell.exe:

PS C:\\&gt; Get-Process -Id $pid -FileVersionInfo | fl \*version\* -Force

FileVersionRaw : 10.0.10055.0

ProductVersionRaw : 10.0.10055.0

FileVersion : 10.0.10055.0 (fbl\_srv2.150402-1826)

ProductVersion : 10.0.10055.0
