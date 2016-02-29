# Known Issues and Limitations

PowerShell Shortcuts are broken when used for the first time
------------------------------------------------------------

**Resolution:** Perform one of the following actions:

1.  Right click on the PowerShell shortcut. Select “Windows PowerShell” to launch in a non-elevated mode.
2.  Right click on the PowerShell shortcut. Right click on “Windows PowerShell” and select “Run As Administrator” to launch in an elevated mode.

Once you have performed either of the above actions, the PowerShell shortcuts will work. These actions need to be performed only once.


PowerShell Modules and DSC Resources report errors about ExecutionPolicy on Windows 7
-------------------------------------------------------------------------------------
On Windows 7, the use of PowerShell modules and DSC resources may result in errors reported about ExecutionPolicy.

**Resolution:** Set the ExecutionPolicy to RemoteSigned by running the following command in an elevated PowerShell session (Run as Administrator):

```powershell
Set-ExecutionPolicy RemoteSigned
```

Connecting to an old remote Exchange endpoint causes a crash
------------------------------------------------------------

The old Exchange endpoint redirects to a new endpoint. There is a bug in the redirection logic that results in a crash.

**Resolution:** Connect directly to the new endpoint.


Software Inventory Logging feature is erroneously stopped after WMF 5.0 installation on Windows Server 2012 R2
-------------------------------------------------------------------------------------------------------------

When installing WMF 5.0 on a Windows Server 2012 R2 that is already running SIL, the Software Inventory Logging feature is erroneously stopped after installation.

**Resolution:** Run the Start-SilLogging cmdlet once after the WMF installation, as the installation process will errantly stop the Software Inventory Logging feature.

Get-ChildItem does not work if -LiteralPath and -Recurse are used together
--------------------------------------------------------------------------

If a directory name contains an invalid wildcard character, then Get-ChildItem will not produce expected results when both
-LiteralPath and -Recurse are used together.

**Resolution:** Not ideal, but current workaround is to implement recursion in the script rather than rely on the cmdlet.
