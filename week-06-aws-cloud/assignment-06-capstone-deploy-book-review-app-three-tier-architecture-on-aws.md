# Assignment 6 — Capstone Assignment — Deploy Book Review App (Three-Tier Architecture) on AWS

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

This is the most important assignment of the course. You will deploy the Book Review App in a fully production-style three-tier architecture on AWS: a Next.js Web Tier behind Nginx and a public ALB, a private Node.js/Express App Tier behind an internal ALB, and a private Multi-AZ MySQL RDS database with a read replica. You are expected to design, deploy, isolate, debug, and document the result independently.

---

# Task 1 — Architecture Diagram

## Goal

Create an architecture diagram showing the custom VPC (10.0.0.0/16), the six subnets across two Availability Zones (two public Web Tier, two private App Tier, two private Database Tier), the public ALB, Web Tier EC2/Nginx, internal ALB, private App Tier EC2, private Multi-AZ RDS with its read replica, and the permitted traffic flow.

### Evidence

#### Diagram image or link

<img width="1536" height="1024" alt="ass06-architecture-diagram" src="https://github.com/user-attachments/assets/e2fb615d-2c54-42f1-bbf4-3ea82075973a" />

---

# Task 2 — AWS Region & Services Used

## Goal

Record the AWS Region used and list every AWS service used across networking, compute, load balancing, security, and the database.

### Notes

**Region:**

AWS Region: US East (N. Virginia), us-east-1

---

**Services:**

* Amazon VPC, networking and subnet isolation
* Internet Gateway, internet connectivity for public subnets
* NAT Gateway, outbound internet access for private application resources
* Amazon EC2, Web and Application Tier compute
* Application Load Balancer, public and internal traffic distribution
* Elastic IP, public address assigned to the NAT Gateway
* Amazon RDS for MySQL, managed relational database
* RDS Multi-AZ, database high availability
* RDS Read Replica, read scaling
* Security Groups, network-level access control
* Route Tables, subnet traffic routing
* Amazon CloudWatch, monitoring and troubleshooting where applicable
* Nginx, reverse proxy on the Web Tier
* Node.js/Express, backend application runtime
* Next.js, frontend application framework
* PM2, Node.js process management
* Git/GitHub, application source-code management


---

# Task 3 — Public Entry Point

## Goal

Confirm the Book Review App loads through the public ALB DNS name.

### Evidence

#### Public ALB DNS

Paste your public ALB DNS name here:

Book-Review-Web-ALB-1702590363.us-east-1.elb.amazonaws.com


---

# Task 4 — Evidence Screenshots

## Goal

Capture visual proof of every tier and load balancer.

### Evidence

#### Web EC2

<img width="959" height="430" alt="09-web-ec2-public-subnet" src="https://github.com/user-attachments/assets/1f53801e-8175-46e9-9b64-d6c7695792fe" />


---

#### App EC2

<img width="959" height="432" alt="10-app-ec2-private-subnet" src="https://github.com/user-attachments/assets/89c429bc-a5c5-42e5-9824-91477f84263b" />
<img width="959" height="434" alt="HEALTH CHECK SREENSHOT" src="https://github.com/user-attachments/assets/4d9e80e9-6aa5-431a-be5c-0b79e5f12f67" />


---

#### Public ALB

<img width="959" height="440" alt="Public ALB SCREENSHOT" src="https://github.com/user-attachments/assets/61fed820-4fb3-448e-b8e7-f3211997f85a" />



---

#### Internal ALB

<img width="959" height="434" alt="HEALTH CHECK SREENSHOT" src="https://github.com/user-attachments/assets/40a1b451-1dbc-4013-a038-38ffba53c5b6" />


---

#### RDS + Replica

<img width="959" height="434" alt="RDS REPLICA SREENSHOT" src="https://github.com/user-attachments/assets/04b03eaa-dc0f-4b16-a692-0bb717773f6a" />


---

#### App UI proof

<img width="938" height="464" alt="ui-book design" src="https://github.com/user-attachments/assets/ba5083d1-54cc-4882-8203-74a4d70491f9" />


---

# Task 5 — Summary

## Goal

Summarize what worked in the final deployment, the issues encountered and how each was fixed, and the tools or sources used to research and debug.

### Notes

**What worked:**

### What Worked

The Book Review App was successfully deployed using a three-tier AWS architecture. The Web Tier was deployed in public subnets behind an internet-facing Application Load Balancer, while the Application Tier was deployed in private subnets behind an internal Application Load Balancer.

The Node.js/Express backend successfully communicated with the private Amazon RDS MySQL database. The database was configured for Multi-AZ high availability and a read replica was created for read scaling.

Nginx successfully acted as a reverse proxy between the public Web Tier and the internal Application Tier. PM2 was used to keep the frontend and backend processes running independently of the SSH sessions.

End-to-end testing confirmed that the application could be accessed through the Public ALB and that the major application functions worked correctly.


---

**Issues + fixes:**

1. **Target Group Health Check Failures on App Tier:**
   * *Issue:* The target group for the App Tier initially failed health checks due to inspecting the default root path (`/`) instead of the active API route, and registering on port 80 alongside port 3001.
   * *Fix:* Deregistered port 80 from `Book-Review-App-TG`, registered the App EC2 strictly on port 3001, and updated the health check path to `/api/books`, returning an immediate 200 OK.

2. **504 Gateway Timeout on API Proxy Routing:**
   * *Issue:* Requests from the Web EC2 to the backend initially timed out due to restrictive internal security group inbound rules and DNS latency over the internal proxy.
   * *Fix:* Updated the Nginx reverse proxy configuration on the Web EC2 to forward `/api/` traffic directly to the App Tier private IP (`10.0.11.196:3001`), and aligned security group rules to allow inbound HTTP traffic on port 3001 from the Web tier security group (`Book-Review-Web-SG`).

3. **Frontend 404 on `/api/api/books`:**
   * *Issue:* Setting `NEXT_PUBLIC_API_URL=/api` caused the client fetch requests to double-nest the URL path to `/api/api/books`.
   * *Fix:* Updated `.env.local` and `.env.production` to use an empty base origin (`NEXT_PUBLIC_API_URL=`), cleared `.next` build caches, recompiled the Next.js bundle via `npm run build`, and restarted the service with PM2.

---

**Tools/sources used:**

### Tools/Sources Used

* AWS Management Console
* Amazon VPC documentation and console
* Amazon EC2
* Elastic Load Balancing
* Amazon RDS for MySQL
* Ubuntu Linux
* Git and GitHub
* Node.js and npm
* Nginx
* PM2
* Linux SSH
* curl
* MySQL client
* Browser Developer Tools
* CloudWatch where applicable
* DMI Cohort 3 Assignment 06 solution walkthrough


---

# LinkedIn Post (Required)

## Goal

Publish a LinkedIn post sharing the capstone deployment, including the public ALB DNS (or a redacted screenshot), three to five lines on what you built and why it is production-style, and one proof screenshot.

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://lnkd.in/p/ecNQAt3Z

---

#### Screenshot of LinkedIn post

<img width="1898" height="1020" alt="LINKEDLN POST" src="https://github.com/user-attachments/assets/b98ce704-ee03-4cd9-9b90-df36f681121e" />


---

# Submission Instructions

- Add all required screenshots and links in your submission
- Do not expose passwords, RDS credentials, connection strings, private keys, or account IDs

---

# Completion Checklist

- [ ] Task 1: Architecture diagram completed
- [ ] Task 2: AWS Region and services documented
- [ ] Task 3: Public ALB DNS confirmed working
- [ ] Task 4: All six evidence screenshots captured (Web Tier, App Tier, both ALBs, RDS + replica, app UI)
- [ ] Task 5: Deployment summary completed (what worked, issues/fixes, tools/sources)
- [ ] LinkedIn post published and URL submitted
- [ ] App Tier and Database Tier confirmed not publicly accessible
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
