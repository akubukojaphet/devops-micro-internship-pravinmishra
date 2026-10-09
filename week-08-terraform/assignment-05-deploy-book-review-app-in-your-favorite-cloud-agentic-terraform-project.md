# Capstone Assignment — Deploy the Book Review App Using Terraform and Claude Code Agentic AI

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Student Details

**Full Name:** AKUBUKO JAPHET UCHENNA
**Cloud Platform:** AWS 
**GitHub Repository URL:** https://github.com/akubukojaphet/devops-micro-internship-pravinmishra
**Public Application URL / Load-Balancer DNS:** http://book-review-dev-pub-alb-1827438317.us-east-1.elb.amazonaws.com/

---

## Purpose

Deploy the Book Review App using Terraform on AWS or Azure in a secure, highly available, production-style three-tier architecture. Use Claude Code, specialized subagents, Terraform MCP, and validation hooks to support the engineering workflow while keeping all infrastructure-changing operations under human control.

---

# Task 0 — Prepare the Project and Agentic AI Environment

## Goal

Prepare the Book Review App project and configure the provided Claude Code Agentic AI starter kit with project context, specialized subagents, Terraform MCP, validation hooks, and safety guardrails.

## Evidence

### Screenshot 1 — Project `CLAUDE.md`

Add a screenshot of the project `CLAUDE.md` showing the three-tier architecture, security boundaries, Terraform requirements, and human-approval rules.

![CLAUDE.md - part 1](screenshots/Screenshot-01a-CLAUDE-md.png)
![CLAUDE.md - part 2](screenshots/Screenshot-01b-CLAUDE-md.png)
![CLAUDE.md - part 3](screenshots/Screenshot-01c-CLAUDE-md.png)
![CLAUDE.md - part 4](screenshots/Screenshot-01d-CLAUDE-md.png)

---

### Screenshot 2 — Terraform Engineer Subagent

Add a screenshot showing the Terraform Engineer subagent configuration.

![Terraform engineer subagent](screenshots/02-terraform-engineer-subagent.png)

---

### Screenshot 3 — Architecture and Security Reviewer Subagent

Add a screenshot showing the Architecture and Security Reviewer subagent configuration.

![Architecture and security reviewer](screenshots/03-architecture-security-reviewer.png)

---

### Screenshot 4 — Terraform MCP Connection

Add a screenshot showing Terraform MCP connected and available.

![Terraform MCP connection](screenshots/04-terraform-mcp-connection.png)

---

### Screenshot 5 — Validation Hooks

Add a screenshot showing the configured Claude Code validation hooks.

![Validation hooks](screenshots/05-validation-hooks.png)

---

# Task 1 — Design the Three-Tier Architecture

## Goal

Design the required secure, highly available three-tier architecture and create an architecture diagram before building the infrastructure.

The diagram must show:

- VPC or VNet
- Availability Zones or equivalent availability locations
- Six subnets
- Internet connectivity
- NAT or outbound design
- Public load balancer
- Web Tier
- Internal load balancer
- Application Tier
- Managed MySQL
- Read replica
- Main traffic flow

## Architecture Diagram

![Three-tier architecture diagram](screenshots/three_tier_architecture_vpc_two_az.png)

---

# Task 2 — Build the Terraform Networking and Security Layers

## Goal

Create the modular Terraform project and implement the network and security layers across the required public and private subnets.

## Evidence

### Screenshot 6 — Modular Terraform Project Structure

Add a screenshot showing the modular Terraform project structure.

![Modular Terraform structure](screenshots/06-modular-terraform-structure.png)

---

### Screenshot 7 — Six-Subnet Architecture

Add a screenshot showing the six-subnet architecture across two availability locations.

![Six-subnet architecture](screenshots/07-six-subnet-architecture.png)

---

### Screenshot 8 — Public and Private Tier Separation

Add a screenshot showing the public and private tier separation, including routing and security boundaries.

![Tier separation, routing and security](screenshots/08-tier-separation-routing-security.png)

---

# Task 3 — Build the Load-Balancing and Compute Layers

## Goal

Deploy the public and internal load balancers and the Web and Application compute resources required by the Book Review App.

## Evidence

### Screenshot 9 — Web and Application Compute

Add a screenshot showing the Web and Application compute resources in their required subnets.

![Web and app compute](screenshots/09-web-and-app-compute.png)

---

### Screenshot 10 — Public Load Balancer

Add a screenshot showing the internet-facing public load balancer.

![Public load balancer](screenshots/10-public-load-balancer.png)

---

### Screenshot 11 — Internal Load Balancer

Add a screenshot showing the private internal load balancer.

![Internal load balancer](screenshots/11-internal-load-balancer.png)

---

### Screenshot 12 — Healthy Targets

Add a screenshot showing healthy target groups or backend pools.

![Healthy ALB targets](screenshots/12-healthy-alb-targets.png)

---

# Task 4 — Build the Managed MySQL Database Layer

## Goal

Deploy a private, highly available managed MySQL database with a read replica and restrict database connectivity to the Application Tier.

## Evidence

### Screenshot 13 — Managed MySQL Database

Add a screenshot showing the managed MySQL database deployment.

![Managed MySQL database](screenshots/13-managed-mysql-database.png)

---

### Screenshot 14 — High Availability

Add a screenshot showing the Multi-AZ or high-availability configuration.

![RDS Multi-AZ](screenshots/14-rds-multi-az.png)

---

### Screenshot 15 — Read Replica

Add a screenshot showing the read replica configuration.

![RDS read replica](screenshots/15-rds-read-replica.png)

---

### Screenshot 16 — Private Database Access

Add a screenshot showing that the database is private and accepts MySQL traffic only from the Application Tier.

![Private database access](screenshots/16-private-database-access.png)

---

# Task 5 — Validate, Review, and Apply the Terraform Configuration

## Goal

Validate the Terraform configuration, review the execution plan using both Agentic AI and human judgment, and apply the infrastructure changes only after all required checks pass.

## Evidence

### Screenshot 17 — Terraform Validation

Add a screenshot showing successful `terraform validate` output.

![Terraform validate](screenshots/17-terraform-validate.png)

---

### Screenshot 18 — Terraform Plan

Add a screenshot showing the Terraform plan output.

![Terraform plan](screenshots/18-terraform-plan.png)

---

### Screenshot 19 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

![Terraform apply](screenshots/19-terraform-apply.png)

---

# Task 6 — Deploy and Configure the Book Review Application

## Goal

Deploy and configure the Book Review App across the Web, Application, and Database tiers and verify the complete application functionality.

## Evidence

### Screenshot 20 — Homepage

Add a screenshot showing the Book Review App homepage through the public endpoint.

![Book Review homepage](screenshots/20-book-review-homepage.png)

---

### Screenshot 21 — Login or Authentication

Add a screenshot showing successful login or authentication.

![Book Review login](screenshots/21-book-review-login.png)
![Book Review login - result](screenshots/21b-book-review-login.png)

---

### Screenshot 22 — Book Data

Add a screenshot showing the book listing or book details.

![Book data](screenshots/22-book-data.png)

---

### Screenshot 23 — Review Functionality

Add a screenshot showing the review functionality working successfully.

![Review functionality](screenshots/23-review-functionality.png)
![Review functionality - result](screenshots/23b-review-functionality.png)

---

### Screenshot 24 — Backend or API Evidence

Add a screenshot showing that the backend or API is working successfully.

![Backend API test](screenshots/24-backend-api.png)

---

### Screenshot 25 — Database Reads and Writes

Add a screenshot showing successful database reads and writes.

![Database reads and writes](screenshots/25-database-reads-writes.png)

## Public Application URL

**Public Application URL / DNS:** http://book-review-dev-pub-alb-1827438317.us-east-1.elb.amazonaws.com/

---

# Task 7 — Demonstrate the Agentic AI Workflow

## Goal

Demonstrate how Claude Code assisted with Terraform generation, architecture and security review, and evidence-based troubleshooting while infrastructure-changing decisions remained under human control.

You do not need to submit your complete Claude Code conversation history. Include only focused evidence.

## Evidence

### Screenshot 26 — AI-Assisted Terraform Generation

Add a screenshot showing one useful example of AI-assisted Terraform generation or improvement.

![AI-assisted Terraform generation](screenshots/26-ai-assisted-terraform-generation.png)

---

### Screenshot 27 — Architecture or Security Review

Add a screenshot showing one structured architecture or security review result.

![AI architecture and security review](screenshots/27-ai-architecture-security-review.png)

---

### Screenshot 28 — AI-Assisted Troubleshooting

Add a screenshot showing one AI-assisted troubleshooting interaction based on collected evidence.

![Troubleshooting the CORS issue](screenshots/28-troubleshooting.png)

---

# Task 8 — Complete the Final Architecture Review

## Goal

Review the completed infrastructure against the original capstone requirements and resolve significant architecture, security, reliability, and cost issues.

Confirm that the final review covers:

- Tier separation
- Availability
- Public exposure
- Routing
- Security rules
- Load balancing
- Database privacy
- Secrets
- Terraform quality
- Module structure
- Reliability
- Obvious cost risks

Use Screenshot 27 as the focused evidence for the structured architecture or security review.

---

# Task 9 — Answer the Reflection Questions

## Goal

Reflect on the architecture, Terraform implementation, and Agentic AI workflow. Answer each question briefly in your own words.

## Architecture

### 1. Why did you separate the Web, Application, and Database tiers?

I separated the architecture into Web, Application, and Database tiers to improve security, scalability, maintainability, and fault isolation. The Web tier handles user requests through the public Application Load Balancer and web servers. The Application tier processes business logic through private Node.js/Express backend servers behind an internal load balancer. The Database tier stores books, users, and reviews in RDS MySQL. This separation allows each tier to be managed, secured, and scaled independently.

### 2. Why is the Application Tier private?

The Application tier is private because backend servers should not be directly accessible from the internet. Requests reach them through the internal Application Load Balancer, which reduces the attack surface and allows access to be controlled through security groups. This design ensures that only authorized components can communicate with the backend services.

### 3. Why is MySQL private?

MySQL is deployed in private database subnets because it stores sensitive application data, including user information and reviews. It does not need direct public internet access. The database security group restricts connections to authorized application-tier resources, while encrypted connections protect data in transit. This reduces the risk of unauthorized access.

### 4. Why are multiple Availability Zones used?

I used multiple Availability Zones to improve availability and reduce the impact of an individual zone failure. Distributing resources across two Availability Zones allows the architecture to support redundancy and continued service when a component or zone becomes unavailable, provided the remaining resources are healthy and correctly configured. Multi-AZ database deployment also supports database availability during infrastructure failures and maintenance.

### 5. What is the difference between Multi-AZ/high availability and a read replica?

Multi-AZ deployment primarily improves availability by maintaining a standby database in another Availability Zone and supporting failover when necessary. A read replica primarily improves read scalability by allowing read queries to be served by a separate database copy. Read replicas may also support disaster recovery, but they are not a substitute for Multi-AZ high availability. The main difference is that Multi-AZ focuses on availability, while read replicas focus on distributing read workloads.

## Terraform

### 6. How did you divide your Terraform into modules?

I organized the Terraform implementation into reusable modules so that related AWS resources could be managed separately. The design separates core networking, security groups, load balancing, compute resources, and the database into logical components. This makes the configuration easier to understand, maintain, reuse, and troubleshoot than keeping every resource in one large file. The root configuration coordinates the modules to build the complete Book Review App infrastructure.

### 7. How do the modules communicate through variables and outputs?

Modules receive configuration through input variables and expose important resource information through outputs. For example, the networking module provides VPC and subnet IDs, which other modules use to place resources in the correct subnets. Load-balancing and compute components use the relevant security group IDs and network details, while the database module provides connection information such as its endpoint and database name. This allows modules to work together without unnecessarily hardcoding resource identifiers.

### 8. What did you specifically check in `terraform plan`?

I checked the proposed resource additions, modifications, and deletions before applying the configuration. I paid particular attention to subnet placement, security group rules, public accessibility, load balancer configuration, EC2 resources, RDS settings, and dependencies between modules. I also checked that the plan matched the intended architecture and that it did not unexpectedly replace or destroy existing resources. Reviewing the plan before applying helped reduce the risk of unintended infrastructure changes.

## Agentic AI

### 9. What was the purpose of `CLAUDE.md`?

The purpose of CLAUDE.md was to provide Claude Code with persistent project instructions and context. It documented the project objectives, architecture, coding conventions, security expectations, and important restrictions. This helped keep AI-assisted work consistent with the capstone requirements and encouraged Claude Code to inspect existing files, avoid unnecessary changes, and follow the intended workflow.

### 10. What work did the Terraform Engineer subagent perform?

The Terraform Engineer subagent was intended to focus on infrastructure-as-code tasks, including reviewing the existing Terraform structure, helping develop or improve reusable modules, checking variables and outputs, and identifying configuration issues. Separating this responsibility from the architecture and security review helped organize the work into more focused tasks. The resulting changes still needed to be reviewed and validated before deployment.

### 11. What did the Architecture and Security Reviewer identify?

The Architecture and Security Reviewer focused on whether the proposed infrastructure followed the intended three-tier design and AWS security best practices. The review areas included public and private subnet placement, least-privilege security group rules, database isolation, secrets handling, encryption, and availability. The purpose was to identify potential weaknesses and recommend improvements before deployment rather than assuming that generated Terraform was automatically secure.

### 12. Why did you use Terraform MCP instead of relying only on Claude's existing Terraform knowledge?

Terraform MCP can provide Claude Code with more direct, tool-assisted access to relevant Terraform information and validation capabilities, depending on the server and tools configured. This can help ground recommendations in the actual Terraform environment rather than relying only on the model's general knowledge. I still needed to review the generated configuration, inspect the plan, and validate the results because tool-assisted suggestions are not a guarantee of correctness or security.

### 13. What was the purpose of your validation hooks?

Validation hooks were intended to enforce checks at appropriate points in the AI-assisted workflow, such as checking generated changes or running formatting and validation before proceeding. They help catch mistakes early, maintain consistent code quality, and reduce the chance of unsafe or invalid Terraform changes reaching deployment. They complement manual review rather than replacing it.

### 14. Describe one real issue Claude helped you troubleshoot.

One real issue was that user registration through the public frontend was failing because the backend's ALLOWED_ORIGINS configuration did not match the public Application Load Balancer origin. I corrected the configuration in /opt/book-review/backend/.env on both backend EC2 instances and restarted the backend PM2 processes. Registration subsequently worked in the browser. This experience showed me how an application can be deployed successfully at the infrastructure level but still fail because of an application configuration issue.

### 15. Describe one recommendation you reviewed, modified, or rejected instead of accepting blindly.

During troubleshooting, I did not assume that the problem required rebuilding the infrastructure. I used the observed registration failure to focus on the backend CORS configuration, corrected the allowed origin, and restarted the affected application processes. I then verified that registration worked. This reinforced the importance of investigating the root cause and validating a proposed fix instead of making unnecessary infrastructure changes. I also treated AI-generated recommendations as suggestions that required technical review.

---

# Task 10 — Publish the Mandatory LinkedIn Post

## Goal

Publish a LinkedIn post describing the capstone, the technical work completed, the Agentic AI workflow, and the lessons learned.

Write the post in your own words, include at least one project image or other proof, and ensure that it can be viewed by the submission reviewer.

## LinkedIn Post URL

**LinkedIn Post URL:** https://lnkd.in/p/e4WaKhw5

---

# Submission Instructions

- Complete Tasks 0–10 in sequence.
- Include all Screenshots 1–28 exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Include the selected cloud platform.
- Include the completed architecture diagram.
- Include the modular Terraform project structure.
- Include the working public application URL or public load-balancer DNS.
- Include all required Agentic AI workflow evidence.
- Answer all 15 reflection questions briefly in your own words.
- Include the published LinkedIn post URL.
- Do not expose cloud credentials, database passwords, SSH private keys, JWT secrets, access tokens, account IDs, Terraform state containing sensitive values, or other confidential information.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [ ] Selected AWS or Azure
- [ ] Added and reviewed the Agentic AI starter files
- [ ] Configured `CLAUDE.md`
- [ ] Configured the Terraform Engineer subagent
- [ ] Configured the Architecture and Security Reviewer subagent
- [ ] Connected Terraform MCP
- [ ] Configured validation hooks and safety guardrails
- [ ] Created the architecture diagram
- [ ] Created the six-subnet design
- [ ] Configured public Web Tier routing
- [ ] Kept the Application Tier private
- [ ] Kept the Database Tier private
- [ ] Configured tier-specific Security Groups or NSGs
- [ ] Restricted backend port `3001`
- [ ] Restricted MySQL port `3306` to the Application Tier
- [ ] Created the public load balancer
- [ ] Created the internal load balancer
- [ ] Configured listeners and health checks
- [ ] Deployed the Web Tier compute resources
- [ ] Deployed the private Application Tier compute resources
- [ ] Provisioned private managed MySQL
- [ ] Configured Multi-AZ or high availability
- [ ] Configured a read replica
- [ ] Created the modular Terraform project
- [ ] Used variables, outputs, and module dependencies
- [ ] Used current Terraform documentation through MCP
- [ ] Used hooks for deterministic validation
- [ ] Completed `terraform fmt`
- [ ] Completed `terraform validate`
- [ ] Reviewed `terraform plan`
- [ ] Completed the Terraform Engineer review
- [ ] Completed the Architecture and Security review
- [ ] Applied the infrastructure only after human approval
- [ ] Deployed and configured the backend
- [ ] Deployed and configured the frontend
- [ ] Configured Nginx where required
- [ ] Configured the internal backend endpoint
- [ ] Configured the public frontend endpoint
- [ ] Verified the homepage
- [ ] Verified login or authentication
- [ ] Verified book data
- [ ] Verified review functionality
- [ ] Verified the backend API
- [ ] Verified database reads and writes
- [ ] Verified healthy load-balancer targets
- [ ] Included AI-assisted Terraform generation evidence
- [ ] Included one architecture or security review
- [ ] Included one AI-assisted troubleshooting example
- [ ] Completed the final architecture review
- [ ] Answered all 15 reflection questions
- [ ] Published the mandatory LinkedIn post
- [ ] Added the LinkedIn post URL
- [ ] Captured all 28 required screenshots
- [ ] Confirmed that my full name is visible in the required screenshots
- [ ] Checked that no secrets or sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- Book Review App Repository: [https://github.com/pravinmishraaws/book-review-app](https://github.com/pravinmishraaws/book-review-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
