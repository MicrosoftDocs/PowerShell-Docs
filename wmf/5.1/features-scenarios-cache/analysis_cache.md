# Module Analysis Cache #

Starting with version 5.1, PowerShell provides the following control
over the file that is used to cache data about a module like the commands it exports.

By default, this cache is stored in the file `${env:LOCALAPPDATA}\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
The cache is typically read at startup while searching for a command
and is written on a background thread sometime after a module is imported.

To change the default location of the cache, set the environment variable PSModuleAnalysisCachePath
before starting PowerShell. Changes to this environment variable will only affect children processes.
The value should name a full path (including filename) that PowerShell has permission to create and write files.
To disable the file cache - this value can be set to an invalid location, for example

```PowerShell
$env:PSModuleAnalysisCachePath = 'nul'
```

This sets the path to an invalid device. No error if PowerShell can't write to the path, though you can see
an error reporting via a tracer:

```PowerShell
Trace-Command -PSHost -Name Modules -Expression { Import-Module Microsoft.PowerShell.Management -Force }
```

When writing out the cache, PowerShell will check for modules that no longer exist
to avoid an unnecessarily large cache.
Sometimes these checks are not desirable, in which case you can turn them off by setting

```PowerShell
$env:PSDisableModuleAnalysisCacheCleanup = 1
```

Setting this environment variable will take effect immediately in the current process.