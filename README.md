# sample

1 - Analysis:

Please go through publicly available AWS documentation and give a high-level overview of how much bandwidth we can expect for different instance types, and how region and availability zones of the instances can affect EC2 to EC2 bandwidth and latency. What would you recommend to minimize EC2 to EC2 latency? Please limit this overview to 2 or 3 paragraphs. You can include this in the readme file in section 4 below.

Answer:
    At a high level, I understand there are 5 EC2 instances: General Purpose, Compute Optimized, Memory Optimized, Accelerated Computing and Storage Optimized.  And each of these instances have different instance categories such as A1, T4g and T3 to name a few under General Purpose. And under those categories have different sizing instances like A1.medium and A1.large, mostly depends on vCPU and Memory. However, in average, the bandwidth for most of these instances is around 10 Gbps. This increases when instance sizing goes into the xlarge or higher.  

    Physical location is always a consideration when dealing with EC2 instances within Amazon VPC.  To minimize latency between EC2 instances is to have instances located in the same Availability Zone.  As it spreads out, so does latency can increase. From Availability Zone, to Regions and to Continents. Another way is to up size the instance to have a higher bandwidth which can go up to 25 Gbps. In addition to this, if instance is in a Linux box, Enhanced Networking can be enabled. And lastly is to consider instances that supports Jumbo frames. Most EC2 instance supports jumbo frames, however, i believe there are scenarios that does not. 

    My recommendation to minimize latency is to have each instance be in the same zone.  However, it's not always possible since the service provided is global. So for those that are not in the same zone, increasing the instance size will increase the bandwidth, improving latency. All this in addition to having jumbo frames and enabling Enhanced Networking.
 
