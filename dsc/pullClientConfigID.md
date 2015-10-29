1. **Deploy the MOF and checksum files to the pull server**
  Now that the pull server exists, copy the MOF and checksum files you created in overview Steps 2 and 3 to **$env:SystemDrive\Program Files\WindowsPowershell\DscService\Configuration** on the pull server.
1. **Configure the target node to use the new pull server**
  Each target node has to be told to use pull mode and given the URL where it can contact the pull server to get configurations. To do this, create a configuration script that includes the DownloadManagerCustomData key/value pair. For example:
  ```powershell
  Configuration SimpleMetaConfigurationForPull 
        { 
                 LocalConfigurationManager 
                 { 
                    ConfigurationID = "1C707B86-EF8E-4C29-B7C1-34DA2190AE24";
                    RefreshMode = "PULL";
                    DownloadManagerName = "WebDownloadManager";
                    RebootNodeIfNeeded = $true;
                    RefreshFrequencyMins = 15;
                    ConfigurationModeFrequencyMins = 30; 
                    ConfigurationMode = "ApplyAndAutoCorrect";
                    DownloadManagerCustomData = @{ServerUrl =                      "http://PullServer:8080/PSDSCPullServer/PSDSCPullServer.svc"; AllowUnsecureConnection = “TRUE”}
                 } 
              } 
     SimpleMetaConfigurationForPull -Output "."
  ```

Note how DownloadManagerCustomData passes the URL of the pull server and (for this example) allows an unsecured connection. The script also sets the __ConfigurationID__ property of LCM to match the value of the configuration MOF file created in overview Step 1.

When this script runs, it creates a new output folder called **SimpleMetaConfigurationForPull** and puts a metaconfiguration MOF file there.

Finally, on each target node that will use the pull server, use **Set-DscLocalConfigurationManager** with parameters for ComputerName (use “localhost”) and Path (the path to the location of the target node’s localhost.meta.mof file). For example: ```Set-DSCLocalConfigurationManager –ComputerName localhost –Path . –Verbose.```
