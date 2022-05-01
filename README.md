## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Panda ELK Network](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Diagrams/New%20Panda-Network-Map.drawio.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above. Alternatively, select portions of the [install_elk.yml](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/install-elk.yml) file may be used to install only certain pieces of it, such as Filebeat.

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

- Load balancers focus mainly on the Availability portion of the CIA triad, being able to divert traffic if loads are too high or if one machine goes down. Also, using a jumpbox to access the containers adds a layer of security because rules are setup to only allow the private IP of the jumpbox to make changes to the other Web VMs. 

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

- 71.203.227.158 :warning: **(This may have to be updated occasionally due to VPN)** :warning:

Machines within the network can only be accessed by the jumpbox once the Ansible container is attached to.

- The jumpbox is able to SSH into the Web VMs and the Elk VM once it has connected to the zen_dewdney container. The private IP of the jump box is 10.1.0.4 which is allowed through the Security rule. 

- `sudo docker start zen_dewdney`
- `sudo docker attach zen_dewdney`

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes (via SSH on port 22)                | 71.203.227.158       |
| Elk VM   | Yes (Kibana access via port 5601) | 71.203.227.158       |
| Web VMs  | Yes (jumpbox access via SSH and through http through Load Balancer public IP) | 10.1.0.4 & 10.1.0.5             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...

- Creating a playbook allows you to run a set of specified tasks and do it on multiple containers at once, saving time, and being able to do this quickly on multiple machines. 

The [ELK Yaml Playbook](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/install-elk.yml) implements the following tasks:

- Install Docker & create container
- Installs python3
- Increases virtual memory and then sets a command to run anytime the VM is restarted to keep the virtual memory at that set value.
- Creates the Elk container
- Runs command to make sure docker is running every time the VM is restarted.

The following output displays the result of running `docker ps` after successfully configuring the ELK instance.

```
panda-admin@Elk-Panda-VM:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED      STATUS      PORTS                                                                              NAMES
2d7392382f2b   sebp/elk:761   "/usr/local/bin/star…"   8 days ago   Up 3 days   0.0.0.0:5044->5044/tcp, 0.0.0.0:5601->5601/tcp, 0.0.0.0:9200->9200/tcp, 9300/tcp   elk
```

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
- Run the playbook, and navigate to [https://public-ip-Elk:5601/app/kibana](https://public-ip-Elk:5601/app/kibana) to check that the installation worked as expected.

- [FileBeat PlayBook](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/Ansible/filebeat-playbook.yml)
- Copy this playbook to your /etc/ansible/roles directory. 
- You will want to update your Hosts file inside /etc/ansible/hosts with your Host groups. We have set them up as [webservers] and [elk]. When you are editing your yaml files, you will specify in the host section which one to install the playbook to. 
- [https://public-ip-Elk:5601/app/kibana](https://public-ip-Elk:5601/app/kibana) will take you to the Kibana dashboard. You may need to change the IP if your host machines IP has changed or if the public IP of your Elk machine has changed at all.

### Running the Playbook

- `sudo nano /etc/ansible/hosts` - Update your hosts file to reflect the proper groups and their IPs. 
- Example:
```
[webservers]
10.1.0.5 ansible_python_interpreter=/usr/bin/python3
10.1.0.6 ansible_python_interpreter=/usr/bin/python3

[elk]
10.2.0.4 ansible_python_interpreter=/usr/bin/python3
```
- `sudo nano /etc/ansible/roles/filebeat-playbook.yml` - Update the hosts section here to reflect the groups setup in the hosts file in the provious step. 
- Example:
```
---
- name: installing and launching filebeat
  hosts: webservers <------ Make sure this matches the target machine group.
  become: yes
  tasks:
```

- `ansible-playbook filbeat-playbook.yml` - This should either give all OKs or Changed after it's done. If you receive any fatal errors, check your playbook for corrections needed. 
- If all goes through, you should be able to go to the address [https://public-ip-Elk:5601/app/kibana](https://public-ip-Elk:5601/app/kibana) and see your dashboard and look at logs being collected. 
- Kiaban Dashboard Example:

![Kibana](https://github.com/TeaLeafMedia/TeaLeaf_CyberSec/blob/main/README/Images/Kibana%20Logs.png)