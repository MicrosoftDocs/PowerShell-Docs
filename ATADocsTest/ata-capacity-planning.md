---
# required metadata

title: Planning your ATA Deployment | Microsoft ATA
description: Helps you plan your deployment and decide how many ATA servers will be needed to support your network
keywords:
author: rkarlin
manager: mbaldwin
ms.date: 08/24/2016
ms.topic: get-started-article
ms.service: advanced-threat-analytics
ms.prod:
ms.assetid: 279d79f2-962c-4c6f-9702-29744a5d50e2

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: bennyl
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

*Applies to: Advanced Threat Analytics version 1.7*



# ATA Capacity Planning
This topic helps you determine how many ATA servers will be needed to monitor your network, including understanding how many ATA Gateways and/or ATA Lightweight Gateways you need and the server capacity for your ATA Center and ATA Gateways.

##Using the sizing tool
The recommended and simplest way to determine capacity for your ATA deployment is to use the [ATA Sizing Tool](http://aka.ms/atasizingtool). Run the ATA Sizing Tool and from the Excel file results, use the following fields to determine the ATA capacity you need:

- ATA Center CPU and Memory: Match the **Busy Packets/sec** field in the ATA Center table in the results file to the **PACKETS PER SECOND** field in the [ATA Center table](#ata-center-sizing).

- ATA Center Storage: Match the **Avg Packets/sec** field in the ATA Center table in the results file to the **PACKETS PER SECOND** field in the [ATA Center table](#ata-center-sizing).
- ATA Gateway: Match the **Busy Packets/sec** field in the ATA Gateway table in the results file to the **PACKETS PER SECOND** field in the [ATA Gateway table](#ata-gateway-sizing) or the [ATA Lightweight Gateway table](#ata-lightweight-gateway-sizing), depending on the [gateway type you choose](#choosing-the-right-gateway-type-for-your-deployment).


![Sample capacity planning tool](media/capacity tool.png)



If for some reason you cannot use the ATA Sizing Tool, you need to manually gather the packet/sec counter information from all your Domain Controllers for a period of 24 hours with a very low collection interval (approximately 5 seconds). Then, for each Domain Controller, you  must calculate the daily average and the busiest period (15 minutes) average.
The following sections present the instruction for how to collect the packets/sec counter from one Domain Controller.



### ATA Center Sizing
The ATA Center requires a recommended minimum of 30 days of data for user behavioral analytics. The required disk space for the ATA database on a per domain controller basis is defined below. If you have multiple domain controllers, sum up the required disk space per domain controller to calculate the full amount of space required for the ATA database.
 

|Packets per second&#42;|CPU (cores&#42;&#42;)|Memory (GB)|Database storage per day (GB)|Database storage per month (GB)|IOPS&#42;&#42;&#42;|
|---------------------------|-------------------------|-------------------|---------------------------------|-----------------------------------|-----------------------------------|
|1,000|2|32|0.3|9|30 (100)
|10,000|4|48|3|90|200 (300)
|40,000|8|64|12|360|500 (1,000)
|100,000|12|96|30|900|1,000 (1,500)
|400,000|40|128|120|1,800|2,000 (2,500)
&#42;Total daily average number of packets-per-second from all domain controllers being monitored by all ATA Gateways.

&#42;&#42;This includes physical cores, not hyper-threaded cores.

&#42;&#42;&#42;Average numbers (Peak numbers)
> [!NOTE]
> -   The ATA Center can handle an aggregated maximum of 400,000 frames per second (FPS) from all the monitored domain controllers.
> -   The amounts of storage dictated here are net values, you should always account for future growth and to make sure that the disk the database resides on has at least 20% of free space.
> -   If your free space reaches a minimum of either 20% or 100 GB, the oldest collection of data will be deleted. This will continue to occur until 5% or 50 GB of free space remains at which point data collection will stop working.
> -   The storage latency for read and write activities should be below 10 ms.
> -   The ratio between read and write activities is approximately 1:3 below 100,000 packets-per-second and 1:6 above 100,000 packets-per-second.
> -   When running as a virtual machine dynamic memory or any other memory ballooning feature is not supported.
> -   For optimal performance, set the **Power Option** of the ATA Center to **High Performance**.<br>
> -   When working on a physical server, the ATA database necessitates that you **disable** Non-uniform memory access (NUMA) in the BIOS. Your system may refer to NUMA as Node Interleaving, in which case you will have to **enable** Node Interleaving in order to disable NUMA. See your BIOS documentation for more information. Note that this is not relevant when the ATA Center is running on a virtual server.


## Choosing the right gateway type for your deployment
In an ATA deployment any combination of the ATA Gateway types is supported:

- Only ATA Gateway(s)
- Only ATA Lightweight Gateway(s)
- A combination of both

When deciding the Gateway deployment type, consider the following:

|Gateway type|Benefits|Cost|Deployment topology|Domain controller use|
|----|----|----|----|-----|
|ATA Gateway|The Out of band deployment makes it harder for attackers to discover ATA is present|Higher|Installed alongside the domain controller (out of band)|Supports up to 50,000 packets per second|
|ATA Lightweight Gateway|Doesn't require a dedicated server and port-mirroring configuration|Lower|Installed on the domain controller|Supports up to 10,000 packets per second|

The following are examples of scenarios in which domain controllers should be covered by the ATA Lightweight Gateway:


- Branch sites

- Virtual domain controllers deployed in the cloud (IaaS)


The following are examples of scenarios in which domain controllers should be covered by the ATA Gateway:


- Headquarter data centers (having domain controllers with more than 10,000 packets per seconds)


### ATA Lightweight Gateway Sizing

An ATA Lightweight Gateway can support the monitoring of one domain controller based on the amount of network traffic the domain controller generates. 


|Packets per second&#42;|CPU (cores&#42;&#42;)|Memory (GB)&#42;&#42;&#42;|
|---------------------------|-------------------------|---------------|
|1,000|2|6|
|5,000|6|16|
	|10,000|10|24|

&#42;Total number of packets-per-second on the domain controller being monitored by the specific ATA Lightweight Gateway.

&#42;&#42;Total amount of non-hyper threaded cores that this domain controller has installed.<br>While hyper threading is acceptable for the ATA Lightweight Gateway, when planning for capacity, you should count actual cores and not hyper threaded cores.

&#42;&#42;&#42;Total amount of memory that this domain controller has installed.

> [!NOTE]	
> -   If the domain controller does not have the necessary amount of resources required by the ATA Lightweight Gateway, the domain controller performance will not be effected, but the ATA Lightweight Gateway might not operate as expected.
> -   When running as a virtual machine dynamic memory or any other memory ballooning feature is not supported.
> -   For optimal performance, set the **Power Option** of the ATA Lightweight Gateway to **High Performance**.


### ATA Gateway Sizing

Consider the following when deciding how many ATA Gateways to deploy.

-	**Active Directory forests and domains**<br>
	ATA can monitor traffic from multiple domains from a single Active Directory forest. Monitoring multiple Active Directory forests requires separate ATA deployments. A single ATA deployment should not be configured to monitor network traffic of domain controllers from different forests.

-	**Port Mirroring**<br>
Port mirroring considerations might require you to deploy multiple ATA Gateways per data center or branch site.

-	**Capacity**<br>
	An ATA Gateway can support monitoring multiple domain controllers, depending on the amount of network traffic of the domain controllers being monitored. 
<br>



|Packets per second&#42;|CPU (cores&#42;&#42;)|Memory (GB)|
|---------------------------|-------------------------|---------------|
|1,000|1|6|
|5,000|2|10|
|10,000|3|12|
|20,000|6|24|
|50,000|16|48|
&#42;Total average number of packets-per-second from all domain controllers being monitored by the specific ATA Gateway during their busiest hour of the day.

&#42;The total amount of domain controller port-mirrored traffic cannot exceed the capacity of the capture NIC on the ATA Gateway.

&#42;&#42;Hyper-threading must be disabled.

> [!NOTE] 
> -   Dynamic memory is not supported.
> -   For optimal performance, set the **Power Option** of the ATA Gateway to **High Performance**.


## Domain controller traffic estimation
There are various tools that you can use to discover the average packets per second of your domain controllers. If you do not have any tools that track this counter, you can use Performance Monitor to gather the required information.

To determine packets per second, perform the following on each domain controller:

1.  Open Performance Monitor.

    ![Performance monitor image](media/ATA-traffic-estimation-1.png)

2.  Expand **Data Collector Sets**.

    ![Data collector sets image](media/ATA-traffic-estimation-2.png)

3.  Right click **User Defined** and select **New** &gt; **Data Collector Set**.

    ![New data collector set image](media/ATA-traffic-estimation-3.png)

4.  Enter a name for the collector set and select **Create Manually (Advanced)**.

5.  Under **What type of data do you want to include?**, select  **Create data logs and Performance counter**.

    ![Type of data for new data collector set image](media/ATA-traffic-estimation-5.png)

6.  Under **Which performance counters would you like to log** click **Add**.

7.  Expand **Network Adapter** and select **Packets/sec** and select the proper instance. If you are not sure, you can select **&lt;All instances&gt;** and click **Add** and **OK**.

    > [!NOTE]
    > To do this, in a command line, run `ipconfig /all` to see the name of the adapter and configuration.

    ![Add performance counters image](media/ATA-traffic-estimation-7.png)

8.  Change the **Sample interval** to **1 second**.

9. Set the location where you want the data to be saved.

10. Under **Create the data collector set**  select **Start this data collector set now** and click **Finish**.

    You should now see the data collector set you just created with a green triangle indicating that it is working.

11. After 24 hours, stop the data collector set, by right clicking the data collector set and selecting **Stop**.

    ![Stop data collector set image](media/ATA-traffic-estimation-12.png)

12. In File Explorer, browse to the folder where the .blg file was saved and double click it to open it in Performance Monitor.

13. Select the Packets/sec counter, and record the average and maximum values.

    ![Packets per second counter image](media/ATA-traffic-estimation-14.png)

## See Also
- [ATA prerequisites](ata-prerequisites.md)
- [ATA architecture](ata-architecture.md)
- [Check out the ATA forum!](https://social.technet.microsoft.com/Forums/security/home?forum=mata)
