## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Panda ELK Network](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Diagrams/New%20Panda-Network-Map.drawio.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the install_elk.yml file may be used to install only certain pieces of it, such as Filebeat.

  - [ELK Yaml Playbook](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/install-elk.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly stable, in addition to restricting access to the network.
- Load balancers focus mainly on the Availability portion of the CIA triad, being able to divert traffic if loads are too high or if one maching goes down. Also, using a jumpbox to access the containers adds a layer of security because rules are setup to only allow the private IP of the jumpbox to make changes to the other Web VMs. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the metrics and system logs.
- Filebeat gathers information on system logs.
- Metricbeat collects data on system metrics like CPU usage or RAM.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.1.0.4   | Linux            |
| Elk VM   | Kibana   | 10.2.0.4   | Linux            |
| PandaVM1 | Elk Host | 10.1.0.5   | Linux            |
| PandaVM2 | Elk Host | 10.1.0.6   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 71.203.227.158 (This may have to be updated occasionally due to VPN)

Machines within the network can only be accessed by the jumpbox once the Ansible container is attached to.
- The jumpbox is able to SSH into the Elk VM once it has connected to the zen_dewdney container. It's IP is 10.1.0.4.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 71.203.227.158       |
| Elk VM   | Yes (Kibana access via port 5601) | 71.203.227.158       |
| Web VMs  | No (jumpbox access) | 10.1.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Creating a playbook allows you to run a set of specified tasks and do it on multiple containers at once, saving time, and being able to do this quickly on multiple machines. 

The playbook implements the following tasks:

- Install Docker & create container
- Create YAML playbook to install proper packages and set system settings
- Test external access to container via Kibana to check connections

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker ps Output](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/README/Images/docker_ps.png)

### Target Machines & Beats

This ELK server is configured to monitor the following machines:
- Panda-WEB-VM-1: 10.1.0.5
- Panda-WEB-VM-2: 10.1.0.6

We have installed the following Beats on these machines:
- FileBeat 7.6.1 & MetricBeat 7.6.1

These Beats allow us to collect the following information from each machine:
- FileBeat collects log data. For example, you could have it gather info on WiFi networks joined to check if a WiFi network not on a whitelist was connected to.
- MetricBeat collects system metrics. For example, you can set it to collect information on CPU information of your Web VMs to check for unusual CPU usage. 

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the [FileBeat PlayBook](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/filebeat-playbook.yml) file to /atc/ansible/roles.
- Update the hosts file to include the host group you want to install the playbook on. Be sure to include the IPs as well. 
- Run the playbook, and navigate to public-ip-Elk:5601/app/kibana to check that the installation worked as expected.

- [FileBeat PlayBook](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/filebeat-playbook.yml)
- Copy this playbook to your /etc/ansible/roles directory. 
- You will want to update your Hosts file inside /etc/ansible/hosts with your Host groups. We have set them up as [webservers] and [elk]. When you are editing your yaml files, you will specify in the host section which one to install the playbook to. 
- 'public-ip-ELK:5601/app/kibana' will take you to the Kibana dashboard. You may need to change the IP depending on if your host machines IP has changed or if the public IP of your Elk machine has changed at all. 

### Running the Playbook

- `sudo nano /etc/ansible/hosts` - Update your hosts file to reflect the proper groups and their IPs. 
- Example:
![Hosts Example](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/README/Images/Ansible%20Hosts.png)
- `sudo nano /etc/ansible/roles/filebeat-playbook.yml` - Update the hosts section here to reflect the groups setup in the hosts file in the provious step. 
- `ansible-playbook filbeat-playbook.yml` - This should either give all OKs or Changed after it's done. If you receive any fatal errors, check your playbook for corrections needed. 
- If all goes through, you should be able to go to the address public-ELK-ip:5601/app/kibana and see your dashboard and look at logs being collected. 
- Kiaban Dashboard Example:
![Kibana](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/README/Images/Kibana%20Logs.png)
