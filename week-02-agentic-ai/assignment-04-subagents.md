# Assignment 4 — Building Your AI Team

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build and configure a set of specialized AI subagents inside your project. You will learn how different models and tool permissions define agent behavior, and you will trigger two real agent delegations to analyze security and cost aspects of your Terraform infrastructure.

---

# Task 1 — Create the Agents Folder and Add Files

## Goal

Create the `.claude/agents/` directory and add all required agent files.

### Evidence

#### Screenshot 1 — VS Code sidebar showing `.claude/agents/` with all 3 files

![ss1](./screenshots/ss1-agents-folder-structure.png)

---

# Task 2 — Compare the Agent Configurations

## Goal

Analyze the configuration differences between the three agents and demonstrate understanding of model and tool selection.

### Written Answers

#### 1. Why does the cost optimizer use Haiku instead of Sonnet?

The cost-optimizer agent is mainly reviewing Terraform resources to identify places where infrastructure costs can be reduced or used more efficiently. Since this kind of task does not usually require deep reasoning or complex analysis, Haiku is a better fit because it is faster and more cost-effective while still being capable of producing useful recommendations.

---

#### 2. Why does the security auditor NOT have Write in its tools list?

The security-auditor agent is designed to inspect Terraform files and report security findings, not to make changes to the infrastructure code. Excluding the Write tool keeps the agent read-only, which helps prevent accidental modifications and ensures it stays focused on analysis only. This also follows the principle of least privilege.

---

#### 3. Why does the tf-writer use `inherit` instead of a specific model?

The tf-writer agent is responsible for creating or updating Terraform code, so it makes sense for it to use the project’s default Claude model configuration rather than being tied to one fixed model. Using inherit gives it flexibility to work with whatever model is already active in the current Claude Code session.

---

### Evidence

#### Screenshot 2 — `security-auditor.md` frontmatter showing model and tools configuration

![ss2](./screenshots/ss2-security-auditor-frontmatter.png)

---

#### Screenshot 3 — `cost-optimizer.md` frontmatter showing the model and tools configuration

![ss3](./screenshots/ss3-cost-optimizer-frontmatter.png)

---

# Task 3 — Run the Security Auditor

## Goal

Trigger the security auditor agent and analyze the generated security report for your Terraform infrastructure.

### Evidence

#### Screenshot 4 — The delegation message showing Claude launched the security-auditor

![ss4](./screenshots/ss4-security-audit-report.png)

---

#### Screenshot 5 — Security audit report output

![ss5a](./screenshots/ss5a-security-audit-report.png)

![ss5b](./screenshots/ss5b-security-audit-report.png)

![ss5c](./screenshots/ss5c-security-audit-report.png)

---

# Task 4 — Run the Cost Optimizer

## Goal

Trigger the cost optimizer agent and review the generated cost optimization report.

### Evidence

#### Screenshot 6 — The full cost optimization report

![ss6a](./screenshots/ss6a-cost-optimizer-report.png)

![ss6b](./screenshots/ss6b-cost-optimizer-report.png)

---

# Submission Instructions

- Ensure all agent files are committed in `.claude/agents/`
- Complete all written answers in your GitHub Repo
- Push final changes to your forked GitHub repository

---

## GitHub Repository URL

https://github.com/akubukojaphet/devops-micro-internship-pravinmishra/blob/main/week-02-agentic-ai/solution-assignment-04-subagents.md

`__________________________`

---

# Completion Checklist

- [ ] `.claude/agents/` folder contains all 3 agent files
- [ ] Screenshot 2 shows correct `security-auditor.md` configuration
- [ ] Screenshot 3 shows correct `cost-optimizer.md` configuration
- [ ] All 3 written answers completed 
- [ ] Security auditor executed successfully
- [ ] Cost optimizer executed successfully
- [ ] Security report is visible with findings
- [ ] Cost report is visible with recommendations
- [ ] All required screenshots added
- [ ] GitHub repo updated with agents

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://pravinmishra.com/dmi  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
