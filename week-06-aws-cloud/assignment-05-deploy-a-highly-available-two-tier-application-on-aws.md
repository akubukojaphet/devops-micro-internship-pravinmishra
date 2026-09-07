# Assignment 5 — Deploy a Highly Available Two-Tier Application on AWS (VPC + ALB + ASG + Multi-AZ RDS)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will design and deploy a highly available two-tier web application on AWS: highly available networking across two Availability Zones, an Application Load Balancer, an Auto Scaling Group for the web tier, and a private Multi-AZ RDS database. You must prove high availability with real failure tests.

---

# Task 1 — Create HA Networking (VPC + 4 Subnets + IGW + NAT + Route Tables)

## Goal

Build a VPC (10.0.0.0/16) with two public and two private subnets across two Availability Zones, an Internet Gateway, a NAT Gateway, and the matching public/private route tables.

### Evidence

#### Screenshot 1 — VPC details showing CIDR 10.0.0.0/16

![VPC details](screenshots/01-vpc-details-10.0.0.0-16.png)


---

#### Screenshot 2 — Subnets list showing four subnets and their Availability Zones

![Four subnets across two Availability Zones](screenshots/02-four-subnets-two-availability-zones.png)


---

#### Screenshot 3 — Public route table showing the Internet Gateway route and both public-subnet associations

![Public route table](screenshots/03-public-route-table-igw-two-subnets.png)


---

#### Screenshot 4 — Private route table showing the NAT Gateway route and both private-subnet associations

![Private route table](screenshots/04-private-route-table-nat-two-subnets.png)


---

#### Screenshot 5 — NAT Gateway status showing Available and the Elastic IP

![NAT Gateway available](screenshots/05-nat-gateway-available-elastic-ip.png)


---

# Task 2 — Create Security Groups (ALB, EC2, RDS) with Least Privilege

## Goal

Create `ha-alb-sg` (HTTP public), `ha-web-sg` (HTTP only from `ha-alb-sg`, SSH from your IP), and `ha-db-sg` (database port only from `ha-web-sg`).

### Evidence

#### Screenshot 6 — ALB Security Group inbound rules

![ALB Security Group](screenshots/06-alb-security-group-inbound-http.png)


---

#### Screenshot 7 — EC2 Security Group inbound rules showing the ALB Security Group reference and SSH from your IP

![Web Security Group](screenshots/07-web-security-group-alb-and-ssh.png)


---

#### Screenshot 8 — RDS Security Group inbound rule showing the database port allowed only from the EC2 Security Group

![RDS Security Group](screenshots/08-rds-security-group-mysql-from-web-sg.png)


---

# Task 3 — Deploy Database Tier (RDS Multi-AZ in Private Subnets)

## Goal

Launch a private, Multi-AZ RDS database (MySQL or PostgreSQL) using the private DB Subnet Group and `ha-db-sg`.

### Evidence

#### Screenshot 9 — RDS summary showing Multi-AZ = Yes and Publicly accessible = No

![RDS Multi-AZ and private access](screenshots/09a-rds-multi-az-public-access-no.png)


---

#### Screenshot 10 — RDS connectivity section showing the DB Subnet Group and Security Group

![RDS connectivity](screenshots/10-rds-connectivity-private-subnet-security-group.png)


---

# Task 4 — Build a Launch Template (User Data Installs App + Connects to DB)

## Goal

Create a Launch Template whose user data installs the web-server runtime, deploys the application, configures the database connection, and starts the required services.

### Evidence

#### Screenshot 11 — Launch Template details showing that user data exists, including a visible snippet

![Launch Template User Data](screenshots/11-launch-template-user-data.png)

---

#### Screenshot 12 — A running instance created from the template showing that the application responds on port 80 through a local test or browser using its public IP

![Test EC2 application](screenshots/12-test-ec2-working.png)

---

# Task 5 — Create an Application Load Balancer (ALB) Across 2 Public Subnets

## Goal

Create an internet-facing ALB across both public subnets with an HTTP listener and a healthy instance target group.

### Evidence

#### Screenshot 13 — ALB details showing two public subnets in two Availability Zones

![ALB across two public subnets](screenshots/13-alb-two-public-subnets.png)

---

#### Screenshot 14 — Target group showing at least one healthy target

![Healthy target group](screenshots/14-target-group-healthy.png)

---

# Task 6 — Create Auto Scaling Group (ASG) in 2 Public Subnets

## Goal

Create an Auto Scaling Group from the Launch Template across both public subnets, with desired capacity 2, minimum 2, and maximum 4, registered to the ALB target group.

### Evidence

#### Screenshot 15 — Auto Scaling Group showing desired, minimum, and maximum capacity and the selected subnet Availability Zones

![Auto Scaling Group configuration](screenshots/15-auto-scaling-group-config.png)

---

#### Screenshot 16 — EC2 instances list showing two running instances in different Availability Zones

![Two EC2 instances across two Availability Zones](screenshots/16-two-ec2-instances-two-azs.png)

---

# Task 7 — Configure App to Use RDS + Validate Read/Write

## Goal

Confirm the application communicates with the RDS database through the ALB DNS name with at least one read and one write operation.

### Evidence

#### Screenshot 17 — Browser showing the application loaded through the ALB DNS name with the URL visible

![WordPress application through ALB](screenshots/17-wordpress-through-alb.png)

---

#### Screenshot 18 — Proof of a database write through a UI message or database query output

![Database write proof](screenshots/18-database-write-proof.png)

---

# Task 8 — High Availability Tests (Must Do Both)

## Goal

Test A: terminate one web instance and confirm the Auto Scaling Group replaces it automatically without interrupting the ALB.

Test B: simulate an Availability Zone impact (stop, detach, or reduce desired capacity in one AZ) and confirm the application stays available.

### Evidence

#### Screenshot 19 — EC2 showing the terminated instance and the newly launched instance; timestamps are helpful

![Auto Scaling Group instance replacement](screenshots/19-asg-instance-replacement.png)

---

#### Screenshot 20 — Target group showing healthy targets after replacement

![Healthy targets after replacement](screenshots/20-target-group-healthy-after-replacement.png)

---

#### Screenshot 21 — Evidence that an instance was removed, detached, placed in Standby, or stopped in one Availability Zone

![Availability Zone impact](screenshots/21-az-impact-instance-stopped.png)

---

#### Screenshot 22 — Browser showing that the ALB DNS endpoint still works during the change

![ALB working during Availability Zone impact](screenshots/22-alb-working-during-az-impact.png)

---

# Task 9 — Architecture and Test-Results Summary

## Goal

Summarize the VPC/subnet layout, the ALB and Auto Scaling Group setup, the private Multi-AZ RDS setup, and the results of both high-availability tests.

### Evidence

#### Screenshot 23 — A simple architecture diagram, which may be hand-drawn, or an AWS console overview showing the components

![AWS high availability architecture](screenshots/23-aws-ha-architecture.png)

---

### Notes

Summarize the VPC and subnets across the two Availability Zones.

I created the `ha-vpc` VPC using CIDR `10.0.0.0/16` and distributed the network across two Availability Zones. The web tier uses two public subnets, `10.0.1.0/24` and `10.0.2.0/24`, while the database tier uses two private subnets, `10.0.11.0/24` and `10.0.12.0/24`. The public subnets use an Internet Gateway route, while the private subnets use a NAT Gateway route for outbound connectivity. This design provides network redundancy across two Availability Zones.


Summarize the ALB and Auto Scaling Group setup.

I deployed an internet-facing Application Load Balancer across two public subnets in separate Availability Zones. The ALB listens on HTTP port 80 and forwards requests to the `ha-web-tg` target group. I created an Auto Scaling Group using the web Launch Template with a desired capacity of 2, minimum capacity of 2, and maximum capacity of 4. The instances are distributed across two Availability Zones and registered with the ALB target group. ELB health checks are enabled so unhealthy instances can be replaced automatically.


Summarize the private Multi-AZ RDS setup.

I deployed a MySQL RDS database using a DB Subnet Group containing the two private subnets. Multi-AZ was enabled to provide a standby database in a separate Availability Zone, while Public access was disabled. The database is protected by `ha-db-sg`, which permits MySQL traffic on port 3306 only from the `ha-web-sg` security group. This keeps the database private and accessible only from the web tier.


Summarize the results of both high-availability tests.

For Test A, I terminated one web-tier EC2 instance and confirmed that the Auto Scaling Group automatically launched a replacement using the Launch Template. After the replacement completed its startup configuration and passed the ALB health check, the target group returned to a healthy state and the application remained accessible through the ALB.

For Test B, I simulated an Availability Zone impact by stopping one web-tier instance in one Availability Zone. The remaining healthy instance in the other Availability Zone continued serving the application through the ALB DNS endpoint. These tests demonstrated that the web tier can recover from an instance failure and continue serving traffic during an Availability Zone impact.


---

# LinkedIn Post (Required)

## Goal

Publish a LinkedIn post about the high-availability build, including the ALB URL (or a redacted screenshot), three to five lines on what you built and how you tested high availability, and one proof screenshot.

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://lnkd.in/p/eHetFXav

---

#### Screenshot of LinkedIn post

![LinkedIn Post](screenshots/13-linkedin-post.png)

---

# Submission Instructions

- Add all required screenshots in your submission
- Do not expose passwords, connection strings, private keys, or account IDs

---

# Completion Checklist

- [ ] Task 1: VPC, four subnets, IGW, NAT Gateway, and route tables created (Screenshots 1–5)
- [ ] Task 2: Least-privilege ALB, EC2, and RDS security groups created (Screenshots 6–8)
- [ ] Task 3: Private Multi-AZ RDS created (Screenshots 9–10)
- [ ] Task 4: Self-configuring Launch Template created and tested (Screenshots 11–12)
- [ ] Task 5: ALB created across both public subnets (Screenshots 13–14)
- [ ] Task 6: Auto Scaling Group running two instances across two AZs (Screenshots 15–16)
- [ ] Task 7: Application verified through the ALB with a database read and write (Screenshots 17–18)
- [ ] Task 8: Both high-availability tests completed (Screenshots 19–22)
- [ ] Task 9: Architecture and test-results summary completed (Screenshot 23 & Notes)
- [ ] LinkedIn post published and URL submitted
- [ ] No sensitive data exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme  
- 🎓 University: https://university.pravinmishra.com?utm_source=github&utm_medium=readme  
- 💬 Discord Community: https://discord.pravinmishra.com?utm_source=github&utm_medium=readme  
- 📝 Blog: https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
