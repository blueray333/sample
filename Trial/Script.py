'''
Created on Nov 30, 2020

@author: Arnold
'''


import platform
import subprocess
import iperf3
import sys



def check_iperf()-> None:
    cmd = "where" if platform.system() == "Windows" else "which"
    try: 
        subprocess.call([cmd, './iperf3.exe'])
    except:
        #install perf3.  
        print('installing')
        install("iperf3")
        
def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

def run_test(ip_address,port_num)->None:
    client = iperf3.Client()
    client.duration = 1
    client.server_hostname = ip_address
    client.port = port_num
    client.protocol = "udp"
    
    print('UDP Test.  Connecting to {0}:{1}'.format(client.server_hostname, client.port))
    result = client.run()

    if result.error:
        print(result.error)
    else:
        print('')
        print('Test completed:')
        print('  started at         {0}'.format(result.time))
        print('  bytes transmitted  {0}'.format(result.bytes))
        print('  jitter (ms)        {0}'.format(result.jitter_ms))
        print('  avg cpu load       {0}%\n'.format(result.local_cpu_total))

        print('Average transmitted data in all sorts of networky formats:')
        print('  bits per second      (bps)   {0}'.format(result.bps))
        print('  Kilobits per second  (kbps)  {0}'.format(result.kbps))
        print('  Megabits per second  (Mbps)  {0}'.format(result.Mbps))
        print('  KiloBytes per second (kB/s)  {0}'.format(result.kB_s))
        print('  MegaBytes per second (MB/s)  {0}'.format(result.MB_s))
    
    client.protocol = "tcp"
    
    print('TCP Test.  Connecting to {0}:{1}'.format(client.server_hostname, client.port))
    result = client.run()

    if result.error:
        print(result.error)
    else:
        print('')
        print('Test completed:')
        print('  started at         {0}'.format(result.time))
        print('  bytes transmitted  {0}'.format(result.bytes))
        print('  jitter (ms)        {0}'.format(result.jitter_ms))
        print('  avg cpu load       {0}%\n'.format(result.local_cpu_total))

        print('Average transmitted data in all sorts of networky formats:')
        print('  bits per second      (bps)   {0}'.format(result.bps))
        print('  Kilobits per second  (kbps)  {0}'.format(result.kbps))
        print('  Megabits per second  (Mbps)  {0}'.format(result.Mbps))
        print('  KiloBytes per second (kB/s)  {0}'.format(result.kB_s))
        print('  MegaBytes per second (MB/s)  {0}'.format(result.MB_s))

check_iperf()
print("Hello")
ip_address = input("What's the IP Address: ")   
port_num = input ("What's the Port Number: ")
run_test(ip_address, port_num)
