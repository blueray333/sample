# sample

1 - Analysis:
Please go through publicly available AWS documentation and give a high-level overview of how much bandwidth we can expect for different instance types, and how region and availability zones of the instances can affect EC2 to EC2 bandwidth and latency. What would you recommend to minimize EC2 to EC2 latency? Please limit this overview to 2 or 3 paragraphs. You can include this in the readme file in section 4 below.

Answer:
    At a high level, I understand there are 5 EC2 instances: General Purpose, Compute Optimized, Memory Optimized, Accelerated Computing and Storage Optimized.  And each of these instances have different instance categories such as A1, T4g and T3 to name a few under General Purpose. And under those categories have different sizing instances like A1.medium and A1.large, mostly depends on vCPU and Memory. However, in average, the bandwidth for most of these instances is around 10 Gbps. This increases when instance sizing goes into the xlarge or higher.  

   Physical location is always a consideration when dealing with EC2 instances within Amazon VPC.  To minimize latency between EC2 instances is to have instances located in the same Availability Zone.  As it spreads out, so does latency can increase. From Availability Zone, to Regions and to Continents. Another way is to up size the instance to have a higher bandwidth which can go up to 25 Gbps. In addition to this, if instance is in a Linux box, Enhanced Networking can be enabled. And lastly is to consider instances that supports Jumbo frames. Most EC2 instance supports jumbo frames, however, i believe there are scenarios that does not. 

   My recommendation to minimize latency is to have each instance be in the same zone.  However, it's not always possible since the service provided is global. So for those that are not in the same zone, increasing the instance size will increase the bandwidth, improving latency. All this in addition to having jumbo frames and enabling Enhanced Networking.
    
    
2 - IaC Coding:
Create a terraform script which creates 1 VPC, 1 subnet, and 2 virtual machines with public IPs running the latest Ubuntu image.
- Choice of AWS or GCP
- your choice of instance size - use free-tier if available
- the 2 VMs should be in the same subnet

Answer:
    Refer to the Terraform folder. Run the files together in Terraform.  As Terraform is new to me, most of the code are typical entries except for a few as per specs, such as making the subnet public and having to VM's in the same subnet. 
    
    
3 - Scripting:
Create a bash or python script to run iperf3 to measure TCP and UDP throughput between the host (ubuntu) and another ubuntu machine.  The intention is we can SSH into one of the machines created in 2 above and run this script.
- script should install iperf3 if not already installed
- assume the remote server is running iperf3 in server mode
- the script should take remote server ip and port as parameters
- output result to either stdout or file
 
Answer:
    Refer to "Trial" folder.  I setup my Python in eclipse as my IDE.  Also installed iPerf3 in Windows and pyInstaller.  The code runs but I'm having issues with a library that I could go around with.  it's looking for libiperf.so.0 which I believe is there when installing iPerf3 via pip. My research points me this has something to do with OS that i'm using (eg. windows). Given more time, I can find a solution to this issue.  
    In regards to the code, it's pretty basic as long as the library required is added to the path of the project.  I used pyinstaller to create an executable file called Script.pyc. it's under dist/Script folder.  The eclipse workspace is also included incase there is a need to load the code in eclipse.
    
4 - Documentation:
Please include a readme.md file with the code that explains how to use 2 and 3 above, what the requirements are if any, and how to use it. Explain any design decisions you made.

Answer:
    I have made comments above how to use #2 and #3.  
