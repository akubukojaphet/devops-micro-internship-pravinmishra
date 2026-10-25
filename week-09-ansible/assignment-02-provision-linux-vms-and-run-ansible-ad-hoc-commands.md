# Assignment 02 — Provision Linux VMs with Terraform and Run Ansible Ad-Hoc Commands

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will use Terraform to provision three or four Ubuntu Linux Virtual Machines on either Microsoft Azure or Amazon Web Services.

You will configure SSH key-based authentication, organize the servers using a custom Ansible inventory, and run Ansible ad-hoc commands across individual hosts and inventory groups.

---

# Task 1 — Create the Multi-Host Lab Structure

## Goal

Create a separate project directory for the multi-host lab and prepare the Terraform, Ansible, and documentation files.

This project will use the Git repository and Ansible controller prepared in Assignment 01.

### Evidence

#### Screenshot 1 — Terminal showing the complete `ansible-adhoc-lab` project structure

<img width="958" height="438" alt="Screenshot_01_Project_Structure" src="https://github.com/user-attachments/assets/61baaaa5-cb4b-4322-aa4f-2e62ece9aeff" />

---

#### Screenshot 2 — Terminal showing `git status --short` with the new project files and updated `.gitignore`

<img width="956" height="425" alt="Screenshot_02_Git_Status_Gitignore" src="https://github.com/user-attachments/assets/1be90112-436a-4ae7-bded-e8a2b96ae8f9" />

---

### Notes

I created the `ansible-adhoc-lab` project inside my existing Assignment 01 workstation. I separated the Terraform configuration, Ansible inventory, and project documentation into their respective directories. I also updated `.gitignore` to prevent Terraform state files and temporary working files from being committed to Git.

---

# Task 2 — Create the Terraform Configuration

## Goal

Create the Terraform configuration required to provision three or four Ubuntu Linux VMs on your selected cloud platform.

Complete only one option:

- Option A — Microsoft Azure
- Option B — Amazon Web Services

Do not configure both providers for this assignment.

### Evidence

#### Screenshot 3 — Terraform configuration showing the three or four server roles and the `for_each` or `count` implementation

<img width="956" height="515" alt="Screenshot_03_Terraform_Roles_ForEach" src="https://github.com/user-attachments/assets/dd0abac9-c92c-4eab-a6c8-af165ddd2989" />

---

#### Screenshot 4 — Terraform configuration showing SSH restricted to the controller IP and HTTP allowed only for web hosts

<img width="958" height="517" alt="Screenshot_04_SSH_HTTP_Security_Rules" src="https://github.com/user-attachments/assets/14ba148b-3005-4d99-adcf-63a347db30fc" />

---

#### Screenshot 5 — Terraform output configuration showing how public IP addresses are associated with the server roles

<img width="945" height="479" alt="Screenshot_05_Terraform_Public_IP_Outputs" src="https://github.com/user-attachments/assets/d2265a1e-dd5a-4cfd-b055-db0ceb14a310" />

---

### Notes

Defined the infrastructure modular Terraform configuration for a three-VM fleet (web1, app1, db1) on AWS. Leveraged the for_each meta-argument across a role map to provision identical Ubuntu 22.04 LTS instances cleanly without repeating resource blocks, attaching the ED25519 public SSH key from Assignment 01. Hardened network security by restricting inbound SSH (port 22) strictly to the controller's /32 public IP CIDR, while configuring HTTP (port 80) access for the public-facing web tier.

---

# Task 3 — Provision the Infrastructure with Terraform

## Goal

Initialize and validate the Terraform configuration, review the execution plan, provision the selected three or four VMs, and retrieve their public IP addresses.

### Evidence

#### Screenshot 6 — Final `terraform apply` output showing `Apply complete`

<img width="959" height="515" alt="Screenshot_06_Terraform_Apply_Complete" src="https://github.com/user-attachments/assets/2a919810-f999-4e86-a8ee-c15d178bc5c2" />

---

#### Screenshot 7 — `terraform output public_ips` showing the role-to-IP mapping for all three or four VMs

<img width="938" height="413" alt="- Screenshot_07_Terraform_Public_IPs" src="https://github.com/user-attachments/assets/f7c1a2ff-b99b-45bf-87af-dbdf32e1d4f3" />

---

#### Screenshot 8 — Azure Portal or AWS Management Console showing all three or four VMs in the `Running` state, with their role-based names visible

<img width="959" height="473" alt="Screenshot_08_Cloud_VMs_Running" src="https://github.com/user-attachments/assets/28225a06-9d29-49d4-87e7-f37a69d0ac25" />

---

### Notes

Initialized the AWS provider, confirmed syntax integrity via terraform validate, and executed terraform apply to provision all 11 network and compute resources. Diagnosed and resolved a regional VpcLimitExceeded error by cleaning up stale VPCs in us-east-1, successfully spinning up the custom VPC, public subnet, internet gateway, route table, security group, and three active EC2 instances while exporting structured public and private IP map outputs for inventory consumption.

---

# Task 4 — Verify SSH Key-Based Access

## Goal

Verify that each managed VM can be accessed from the Ansible controller using SSH key-based authentication.

### Evidence

#### Screenshot 9 — Terminal showing successful SSH hostname output from all VMs

<img width="954" height="482" alt="Screenshot_09_SSH_Hostname_Verification" src="https://github.com/user-attachments/assets/4e71215b-8571-4ebf-a298-fd9bc23b22fa" />

---

### Notes

Verified end-to-end passwordless SSH authentication across the entire three-node fleet using the active ED25519 key loaded into ssh-agent. Connected directly to the internet-facing web1 instance via its public IP, and successfully reached private backend nodes app1 (10.0.1.123) and db1 (10.0.1.72) through web1 using SSH ProxyJump (-J) with agent forwarding (-A), confirming that internal VPC routing and firewall rules operate correctly without exposing backend nodes publicly

---

# Task 5 — Create the Custom Ansible Inventory

## Goal

Create an Ansible inventory file that groups the managed VMs by role.

The inventory allows Ansible to run commands against all servers, or only specific groups such as `web`, `app`, or `db`.

### Evidence

#### Screenshot 10 — `inventory.ini` showing the `web`, `app`, and `db` groups

<img width="942" height="446" alt="Screenshot_10_Ansible_Inventory" src="https://github.com/user-attachments/assets/365a05fc-ead7-4a70-902a-ce8725b868e0" />

---

#### Screenshot 11 — Output of `ansible-inventory -i inventory.ini --graph`

<img width="956" height="443" alt="Screenshot_11_Ansible_Inventory_Graph" src="https://github.com/user-attachments/assets/577d8b5c-59a1-471a-9445-e8c95c645e19" />

---

### Notes

Constructed a custom INI inventory file dividing the infrastructure into functional tiers (web, app, and db). Assigned the public IP to web1 for direct ingress and mapped internal VPC IPs to app1 and db1. Implemented ansible_ssh_common_args with ProxyJump and agent forwarding under group variables so Ansible seamlessly routes commands to private nodes via the public bastion host without storing SSH keys on remote instances.

---

# Task 6 — Run Ansible Ad-Hoc Commands

## Goal

Run Ansible ad-hoc commands from the controller to verify connectivity, check server information, and manage packages and services across inventory groups.

This task proves that the inventory is working and that Ansible can control multiple managed VMs without writing a playbook.

### Evidence

#### Screenshot 12 — Output of `ansible all -i inventory.ini -m ping`

<img width="956" height="503" alt="Screenshot_12_Ansible_Ping_All_Hosts" src="https://github.com/user-attachments/assets/812026e3-b008-4a7a-886c-61060b0df31f" />

---

#### Screenshot 13 — Output of `ansible all -i inventory.ini -m command -a "uptime"`

<img width="949" height="425" alt="Screenshot_13_Ansible_Uptime_All_Hosts" src="https://github.com/user-attachments/assets/a12f180f-f255-4d9e-9b9d-e350f8495eb2" />

---

#### Screenshot 14 — Output of `ansible web -i inventory.ini -m apt -a "name=nginx state=present update_cache=yes" --become`

<img width="958" height="512" alt="Screenshot_14_Ansible_Install_Nginx" src="https://github.com/user-attachments/assets/72db1dab-d3c5-4a9e-9fba-2877ccb8ee73" />

---

#### Screenshot 15 — Output of `ansible web -i inventory.ini -m service -a "name=nginx state=started enabled=yes" --become`

<img width="955" height="511" alt="Screenshot_15_Ansible_Start_Enable_Nginx" src="https://github.com/user-attachments/assets/af49ccfb-fdb7-4fcb-a695-ac85f5d3620e" />

---

#### Screenshot 16 — Output of `ansible all -i inventory.ini -m apt -a "name=htop state=present update_cache=yes" --become`

<img width="946" height="517" alt="Screenshot_16_Ansible_Install_Htop" src="https://github.com/user-attachments/assets/9d952622-5fe7-4a30-bb81-f53a419b7a82" />

---

#### Screenshot 17 — Output of `ansible web -i inventory.ini -m command -a "systemctl is-active nginx"`

<img width="959" height="437" alt="Screenshot_17_Ansible_Nginx_Active" src="https://github.com/user-attachments/assets/e0afebde-d51e-48ed-9f1a-3148910b309b" />

---

### Notes

Executed Ansible ad-hoc commands across target inventory tiers to validate connectivity, retrieve telemetry, and orchestrate package lifecycles without playbooks. Leveraged the ping module to verify controller-to-host execution environments, gathered fleet health via the command module, and applied privilege escalation (--become) with the apt and service modules to install, start, and verify Nginx exclusively on the web tier while deploying administrative monitoring tooling (htop) fleet-wide.

---

# LinkedIn Post Required

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://lnkd.in/p/eCkaHihK

---

#### Screenshot — Published LinkedIn post

<img width="959" height="562" alt="LinkedIn_Post_DMI_Assignment_02_Terraform_Ansible" src="https://github.com/user-attachments/assets/e8e3dcff-4dab-444e-bd33-177290261402" />

---

# Assignment Questions

Answer the following in your own words:

**1. What is the purpose of an Ansible inventory file?**

An Ansible inventory file identifies the servers that Ansible manages. It contains their IP addresses or hostnames, organizes them into groups based on their roles, and defines connection details such as the SSH username and private key location. This makes it easier to run commands on individual servers or multiple servers at once.

---

**2. What is the difference between the `web`, `app`, and `db` groups in your inventory?**

The groups organize the three virtual machines according to their intended roles. The web group contains the web server, which is configured to allow HTTP traffic. The app group represents the application server, while the db group represents the database server. Separating the servers into groups allows Ansible commands to target the appropriate machines.

In my AWS setup, all three VMs have public IP addresses for administration, but SSH access is restricted to my workstation's public IP address. HTTP access is allowed only for the web server. The application and database servers are not configured to accept public HTTP traffic.

---

**3. What does the Ansible `ping` module verify?**

The Ansible ping module checks whether Ansible can connect to a managed server over SSH, execute its test module, and receive a response. It also requires a suitable Python environment on the remote server. A successful result returns "ping": "pong". Unlike a normal network ping, it does not simply test ICMP connectivity.

---

**4. Why do package installation commands require `--become`?**

Package installation and service management usually require administrator privileges. The --become option allows Ansible to elevate privileges, normally through sudo, when performing these tasks. I used it when installing Nginx and htop and when starting and enabling the Nginx service.

---

**5. When would you use an ad-hoc command instead of a playbook?**

I would use an ad-hoc command for a quick, one-time task, such as checking server uptime, testing connectivity, installing a package, or checking whether a service is running. I would use a playbook for more complex or repeatable tasks that involve multiple steps, because playbooks are easier to maintain, reuse, and manage through version control.

---

**6. What is one challenge you faced while setting up SSH or inventory, and how did you fix it?**

One important part of setting up SSH access was ensuring that the AWS security group allowed connections from my workstation's current public IP address. I checked my public IP address and used it in the Terraform configuration with a /32 CIDR range, which restricts SSH access to that single IP address. I also needed to ensure that the correct public IP addresses and SSH private key path were entered in the Ansible inventory.

This helped me understand how SSH keys, AWS security groups, Terraform configuration, and Ansible inventory work together to enable secure server administration.

---

# Required Files

Confirm that the following files are included in your assignment workspace:

- [ ] `ansible-adhoc-lab/README.md`
- [ ] `ansible-adhoc-lab/terraform/providers.tf`
- [ ] `ansible-adhoc-lab/terraform/main.tf`
- [ ] `ansible-adhoc-lab/terraform/variables.tf`
- [ ] `ansible-adhoc-lab/terraform/outputs.tf`
- [ ] `ansible-adhoc-lab/ansible/inventory.ini`
- [ ] Updated `.gitignore`

---

# Submission Instructions

- Add all required screenshots from the tasks.
- Full Name must be visible in required screenshots.
- Mention whether you used Azure or AWS.
- Mention whether you used the three-VM option or four-VM option.
- Add the public IP addresses of the VMs, redacted if preferred.
- Add your `inventory.ini` proof.
- Add a short explanation of what you learned.
- Answer all assignment questions clearly in your own words.
- Add your LinkedIn post URL.
- Do not expose SSH private keys, Terraform state files, cloud credentials, passwords, access keys, secret keys, account IDs, or subscription IDs.

---

# Completion Checklist

- [ ] Task 1: `ansible-adhoc-lab` project structure created
- [ ] Task 1: `.gitignore` updated for Terraform files
- [ ] Task 2: Terraform configuration created
- [ ] Task 2: Server roles defined for either three or four VMs
- [ ] Task 2: `count` or `for_each` used
- [ ] Task 2: SSH restricted to the controller public IP
- [ ] Task 2: HTTP allowed only for web hosts
- [ ] Task 2: Terraform output maps roles to public IPs
- [ ] Task 3: Terraform initialized successfully
- [ ] Task 3: Terraform configuration validated
- [ ] Task 3: Terraform apply completed successfully
- [ ] Task 3: All selected VMs are running
- [ ] Task 4: SSH key-based access works for every VM
- [ ] Task 5: `inventory.ini` contains `web`, `app`, and `db` groups
- [ ] Task 5: `ansible-inventory -i inventory.ini --graph` shows the correct groups
- [ ] Task 6: `ansible all -i inventory.ini -m ping` returns `SUCCESS`
- [ ] Task 6: Ad-hoc commands run successfully
- [ ] Task 6: `--become` was used for package and service tasks
- [ ] Task 6: Nginx is active on the `web` group
- [ ] Screenshots 1–17 are included
- [ ] Assignment questions are answered
- [ ] LinkedIn post published
- [ ] LinkedIn post URL added
- [ ] No sensitive information is exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra and The CloudAdvisory, focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## Resources

- DMI Official Website: [https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme](https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme)
- University: [https://university.pravinmishra.com?utm_source=github&utm_medium=readme](https://university.pravinmishra.com?utm_source=github&utm_medium=readme)
- Discord Community: [https://discord.pravinmishra.com?utm_source=github&utm_medium=readme](https://discord.pravinmishra.com?utm_source=github&utm_medium=readme)
- Blog: [https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme](https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*
