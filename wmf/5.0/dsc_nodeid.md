# Separation of Node and Configuration IDs

## Overview

In order to provide a more flexible and streamlined experience when using DSC in Pull mode, we have added a number of features in this release. These features are intended to allow you 
to have the flexibility to easily setup and deploy configurations across multiple nodes, while still tracking status and reporting information for each node individually. 
These features are as follows:

* A configuration name which identifies the configuration for a computer. This name can be shared by multiple target nodes 
* An agent ID which uniquely identifies a single node
* A registration step which only occurs the first time a target node connects to a pull server

**Note:** These features and functionality have been added and do not replace the existing pull features and concepts. You can use these new features or the older ones with the new pull 
server shipping in this release.

For more information, see [Setting up a pull client using configuration names](../dsc/pullClientConfigNames.md)

