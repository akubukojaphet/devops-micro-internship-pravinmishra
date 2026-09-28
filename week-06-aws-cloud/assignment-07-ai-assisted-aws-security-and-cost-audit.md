# Assignment 7 — AI-Assisted AWS Security and Cost Audit

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build a read-only Bash script that audits the AWS resources you deployed earlier this week — your S3 static site, EC2 instance(s), security groups, RDS database, and EBS volumes — for common security and cost misconfigurations.

You will then connect that script to Claude Code as a reusable `/aws-audit` skill that explains what it found and recommends a fix, without ever making the fix itself.

Finally, you will find a real misconfiguration in your own account, apply the fix yourself, and prove it worked with a second audit run.

---

# Task 1 — Confirm Your AWS Resources and Set Up Your Workspace

## Goal

Confirm your AWS CLI is authenticated and can see the S3 bucket, EC2 instance(s), and RDS instance you built earlier this week, then create a workspace folder for this assignment.

### Evidence

#### Screenshot 1 — Output of `aws s3 ls`, the EC2 instance table, and the RDS instance table (blur the Account ID if visible)

<img width="959" height="335" alt="01-task-1-aws-resources" src="https://github.com/user-attachments/assets/e0954358-1b3a-4fac-8e9e-673225ab69a2" />

---

#### Screenshot 2 — Output of `pwd` and `find . -maxdepth 4 -type d | sort`

<img width="959" height="247" alt="02-task-1-workspace-structure" src="https://github.com/user-attachments/assets/c848da4f-bc11-438a-99b9-c6761699ab0a" />

---

### Notes You Must Write (Very Important)

**1. Which resources from this week's earlier assignments did you see in the listings?**

I confirmed that AWS CLI could see resources created during my earlier Week 6 assignments, including my S3 static website bucket, EC2 instances, and Amazon RDS database. For the Book Review capstone, the EC2 resources included instances used for the Web and App tiers, while the RDS listing confirmed the MySQL database used by the application.

**2. Why must you confirm your resources exist before writing an audit script against them?**

I must confirm that the AWS resources exist and that my CLI can access them before writing the audit script because the script depends on querying real resources from my AWS account. This also verifies that my AWS authentication, Region, and permissions are correct. Without this validation, an empty or failed audit could be mistaken for a secure environment when the script may simply be querying the wrong Region, account, or unavailable resources.

---

# Task 2 — Define Safety Rules in CLAUDE.md

## Goal

Create a `CLAUDE.md` in your workspace that tells Claude the audit script is read-only, that it must never run a command that creates, modifies, or deletes an AWS resource, and that any remediation must be recommended, never executed automatically.

### Evidence

#### Screenshot 3 — `CLAUDE.md` open in VS Code showing all four sections

<img width="919" height="513" alt="03-task-2-claude-md" src="https://github.com/user-attachments/assets/37919335-f2b6-46f3-a204-56d88d6da7b4" />

---

### Notes You Must Write (Very Important)

**1. Why should Claude never be given permission to run `revoke-security-group-ingress` itself, even if the fix is obviously correct?**

Claude should not execute revoke-security-group-ingress because the command changes a live AWS security group. Even when the recommended fix appears correct, an automated action could affect the wrong security group, rule, port, or production resource. Keeping the remediation manual ensures that I review the evidence and approve the change before it is applied.

**2. Which rule prevents Claude from claiming a finding that the report does not support?**

The rule that prevents this is: "Do not claim a finding unless the report contains supporting evidence." This ensures that Claude bases its analysis on the evidence collected by the audit script rather than making unsupported assumptions.

---

# Task 3 — Plan the Audit with Claude Code

## Goal

Ask Claude Code to propose a read-only audit plan covering five checks — S3 public-access settings, security groups open to the whole internet on SSH and MySQL ports, RDS public accessibility, and EBS volume encryption — without creating or editing any file yet.

### Evidence

#### Screenshot 4 — Claude Code showing the five-check plan

<img width="958" height="514" alt="CLAUDE 1 PIC" src="https://github.com/user-attachments/assets/df68a5a8-b175-43d3-be49-ba39a80fe068" />
<img width="957" height="513" alt="CLAUDE 2 PIC" src="https://github.com/user-attachments/assets/ff41631e-52b2-4dc4-9db9-5251b65488ac" />
<img width="959" height="512" alt="CLAUDE 3" src="https://github.com/user-attachments/assets/ec3e5b51-0fbd-4857-a64c-9b79b9324cd7" />
<img width="959" height="514" alt="CLAUDE 4" src="https://github.com/user-attachments/assets/98f2c35a-37d6-4e8e-baa1-f603ff75052b" />
<img width="959" height="522" alt="CLAUDE 5" src="https://github.com/user-attachments/assets/16ec4216-104b-43bc-a054-ec6f6f0b07fa" />

---

### Notes You Must Write (Very Important)

**1. Which part of this task represents the Gather phase?**

The Gather phase is represented by the read-only AWS CLI commands that inspect the current AWS resources and collect evidence. Commands such as describe, get, and list retrieve information without changing the infrastructure.

**2. Did every proposed command start with `describe-`, `get-`, or `list-`? Why does that matter?**

The proposed commands should use read-only inspection operations such as describe, get, or list. This matters because the purpose of the audit is to collect evidence without changing the AWS account. Using read-only commands reduces the risk of accidentally modifying or deleting infrastructure during the audit.

---

# Task 4 — Build the AWS Audit Script

## Goal

Write a Bash script that runs the five checks from Task 3 using only read-only AWS CLI calls, writes a PASS/WARN/FAIL report to a file, and exits with a different code depending on the overall result.

Make it executable and confirm it has no syntax errors.

### Evidence

#### Screenshot 5 — Top section of `aws-audit.sh` showing the variables and the checks array

<img width="950" height="515" alt="FFFFF" src="https://github.com/user-attachments/assets/c7ffe335-4295-490b-9283-e4b1a0487be0" />

---

#### Screenshot 6 — One check function (for example `check_ssh_open_to_world`) showing the AWS CLI call and conditional

<img width="936" height="478" alt="week 06-assignment 07-screenshot h" src="https://github.com/user-attachments/assets/30364eae-4350-42a7-a2ba-1e8bb8233bc4" />

---

#### Screenshot 7 — Output of `bash -n scripts/aws-audit.sh` and `ls -l scripts/aws-audit.sh`

<img width="955" height="173" alt="HDHJH" src="https://github.com/user-attachments/assets/0bed3207-9964-4571-8806-1baa6c917b96" />

---

### Notes You Must Write (Very Important)

**1. What is stored in the checks array, and how does the loop use it?**

The checks array stores the names of the five Bash functions that perform the AWS audit checks. The for loop iterates through each function name and invokes it, allowing all five audit checks to run in a consistent sequence without repeating the function calls manually.

**2. Why does every AWS CLI call in this script use `--query` and `--output text` instead of parsing raw JSON?**

--query limits the AWS CLI output to only the fields required by each audit check, while --output text converts those values into simple shell-friendly output. This makes the Bash conditionals easier to evaluate and avoids adding a separate JSON parsing dependency such as --jq.

**3. Why does the script use different exit codes for HEALTHY, WARN, and FAIL?**
Different exit codes allow users and automation tools to distinguish the overall audit result without parsing the report text. Exit code 0 represents HEALTHY, 1 represents WARN, and 2 represents FAIL. This makes the script easier to integrate into CI/CD pipelines or other automation while still remaining read-only.

---

# Task 5 — Run the Baseline Audit

## Goal

Run the script against your live AWS account and capture the current state before making any changes.

### Evidence

#### Screenshot 8 — Output of `./scripts/aws-audit.sh` showing your Full Name and all five checks

<img width="959" height="357" alt="GDHD" src="https://github.com/user-attachments/assets/ee36406f-263c-4b5a-8750-f8a63f60df0f" />

---

#### Screenshot 9 — Output showing the captured exit code and final summary

<img width="956" height="456" alt="09-task-5-baseline-summary" src="https://github.com/user-attachments/assets/631a3e31-41b3-416b-9221-888325995a5f" />

---

### Notes You Must Write (Very Important)

**1. What is the overall status of your baseline audit?**

My baseline audit status was FAIL. The audit returned 2 as the script exit code, which corresponds to FAIL.

The audit recorded 3 FAIL findings, 1 WARN finding, and 1 PASS finding.

**2. Did any check return FAIL or WARN? If so, which one, and what evidence did it show?**

Yes. The audit returned **FAIL** for three checks and **WARN** for one check.

**S3 public access check - FAIL**

The evidence in the report showed:

> `[FAIL] S3 bucket 'japhtech-portfolio-2026' does not fully block public ACLs (BlockPublicAcls=False, IgnorePublicAcls=False) — public access should only ever come through the scoped bucket policy, never through ACLs`

This means the bucket's `BlockPublicAcls` and `IgnorePublicAcls` settings were both set to `False`.

**SSH open to the world - FAIL**

The evidence showed:

> `[FAIL] 6 security group(s) allow SSH (port 22) from 0.0.0.0/0`

This means the audit found six security groups allowing SSH access from any IPv4 address.

**MySQL open to the world - FAIL**

The evidence showed:

> `[FAIL] 2 security group(s) allow MySQL (port 3306) from 0.0.0.0/0`

This means the audit found two security groups allowing MySQL traffic from any IPv4 address.

**RDS public access check - PASS**

The audit showed:

> `[PASS] RDS instance 'book-review-db' is not publicly accessible`

This indicates that the `book-review-db` RDS instance was not configured for public accessibility.

**EBS encryption check - WARN**

The evidence showed:

> `[WARN] 1 EBS volume(s) are not encrypted`

This means the audit detected one EBS volume that was not encrypted.

**3. If every check passed, what does that tell you about the security posture of your account so far?**

Not all checks passed in my baseline audit, so this condition does not apply to my current results.

My baseline audit identified specific security and configuration issues that require attention, including public ACL settings on the S3 bucket, unrestricted SSH access, unrestricted MySQL access, and an unencrypted EBS volume.

At the same time, the audit confirmed that the `book-review-db` RDS instance was not publicly accessible.

The baseline therefore provides a starting point for identifying and addressing these findings before running the audit again to determine whether the security posture has improved.

---

# Task 6 — Build and Run the /aws-audit Skill

## Goal

Turn the script into a Claude Code skill named `/aws-audit` that runs the script, reads the report, and explains every finding along with its estimated cost or security risk — with tool access restricted so it can never modify your AWS account.

### Evidence

#### Screenshot 10 — `SKILL.md` showing the frontmatter, tool restrictions, and safety rules

<img width="958" height="508" alt="HBD" src="https://github.com/user-attachments/assets/0ade1aff-1946-4609-80c0-f95789f5e3b8" />

---

#### Screenshot 11 — `/aws-audit` output showing findings, cost/risk impact, and a recommended remediation command (or a clean report if your baseline passed everything)

<img width="959" height="518" alt="UC 1" src="https://github.com/user-attachments/assets/91b48110-cd49-410e-a0aa-688a9420c399" />
<img width="959" height="521" alt="UC 2" src="https://github.com/user-attachments/assets/56aee9b5-df44-4e8d-a470-3d0472ded473" />
<img width="958" height="521" alt="UC 3" src="https://github.com/user-attachments/assets/5e8703b0-17be-434e-82ea-40c5585bcf0a" />

---

### Notes You Must Write (Very Important)

**1. Why does this skill have Bash, Read, and Grep, but not Write?**

The skill has Bash, Read, and Grep because it needs to execute the read-only audit script, read the resulting report, and search or inspect information from the report. It does not have Write permission because the skill should not modify files or infrastructure as part of the audit workflow.

**2. What part is performed by Bash, and what part is performed by Claude?**

Bash performs the evidence-gathering part. It runs the read-only AWS CLI commands, evaluates the results, produces PASS, WARN, or FAIL statuses, and saves the audit report. Claude reads that evidence and provides the analysis, explains the security or cost impact, and recommends a remediation command without executing it.

**3. Why is estimating cost/risk impact something the AI adds on top of a plain PASS/FAIL script?**

A PASS or FAIL result tells me whether a specific condition was detected, but it does not fully explain why the finding matters. Claude can add context by explaining the possible security exposure, compliance implications, or potential cost impact and by connecting the technical finding to a practical remediation.

---

# Task 7 — Fix a Real Finding and Re-Verify

## Goal

Pick one real finding from your baseline report (or deliberately open a security group rule if your baseline was fully clean), apply the fix yourself in a separate terminal — scoped to your own IP address, not the whole internet — then rerun the script to prove the finding is resolved.

### Evidence

#### Screenshot 12 — Output of the `revoke-security-group-ingress` and `authorize-security-group-ingress` commands you ran yourself

<img width="959" height="515" alt="GGG" src="https://github.com/user-attachments/assets/e6a5f36f-94a0-4160-84bf-3a90f190cad5" />
<img width="925" height="404" alt="GGGI" src="https://github.com/user-attachments/assets/f46b9142-1bf8-4226-ac12-aa225ed5b171" />

---

#### Screenshot 13 — Rerun of `./scripts/aws-audit.sh` showing the finding is now PASS

<img width="958" height="344" alt="GEDD" src="https://github.com/user-attachments/assets/8e5e0973-0079-4618-bcfc-b22a850f03df" />

---

### Notes You Must Write (Very Important)

**1. Which exact finding did you fix, and what command did you run?**

I fixed the **SSH access from anywhere** finding for security group `sg-009fdf808fb5d7b83`. The baseline audit reported that security groups were allowing SSH (port 22) from `0.0.0.0/0`.

First, I removed the unrestricted SSH rule by running:

```bash
aws ec2 revoke-security-group-ingress \
  --group-id sg-009fdf808fb5d7b83 \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

I then allowed SSH only from my current public IP by running:

```bash
MY_IP=$(curl -4 -s ifconfig.me)

aws ec2 authorize-security-group-ingress \
  --group-id sg-009fdf808fb5d7b83 \
  --protocol tcp \
  --port 22 \
  --cidr "$MY_IP/32"
```

**2. Why did you scope the new rule to your own IP address instead of leaving it open to `0.0.0.0/0`?**

I scoped the SSH rule to my own public IP because SSH should not be accessible from every IP address on the internet.

`0.0.0.0/0` means that any IPv4 address can attempt to connect to port 22. Restricting the rule to my IP with `/32` allows SSH access only from my current public IPv4 address, which reduces the attack surface and follows the principle of least privilege.

**3. Did Claude execute the remediation command, or did you? Why does that matter?**

I executed the remediation commands myself in my AWS CLI terminal. Claude provided the explanation and the commands, but I reviewed them and manually ran them.

This matters because the remediation changes an actual AWS security group. The human remains responsible for reviewing and approving the proposed change before it is applied. The AI assisted with the reasoning and command generation, while I made the actual change to the AWS environment.

**4. Which phase of the Agentic Loop does the Bash script represent? Which phase does Claude's explanation represent? Which phase is you running the fix?**

The Bash audit script represents the **Observe/Inspect** phase of the Agentic Loop because it examined my AWS resources and identified security findings.

Claude's explanation represents the **Reason/Plan** phase because it interpreted the audit result, explained the risk, and provided a remediation approach.

Me running the AWS CLI remediation command represents the **Act/Execute** phase because I manually applied the approved security change to the AWS environment.

The process can therefore be summarized as:

**Bash audit → Observe → Claude explains and plans → Reason → I review and execute the fix → Act**

---

# LinkedIn Post (Required)

## Goal

Create a LinkedIn post including:

- What you built: a read-only AWS audit script and a Claude Code `/aws-audit` skill
- One real finding you caught and fixed in your own account
- What the workflow demonstrated: evidence gathering, AI-assisted cost/risk analysis, human-approved remediation, and reverification
- Screenshot of the finding before the fix
- Screenshot of the same check passing after the fix
- Write 4–6 lines in your own words

Suggested tags:

`#DMIByPravinMishra #AWS #AgenticAI #ClaudeCode #DevOps`

### Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://lnkd.in/p/evnNTStz

---

#### Screenshot of Published LinkedIn Post

<img width="959" height="560" alt="HS" src="https://github.com/user-attachments/assets/5a3403f9-f386-40a3-9c29-d845b818d203" />

---

# Submission Instructions

Complete all tasks in sequence.

Your submission must include:

- All 13 required task screenshots
- Answers to every **Notes You Must Write** question
- `CLAUDE.md`
- `scripts/aws-audit.sh`
- `.claude/skills/aws-audit/SKILL.md`
- `reports/aws-audit-report.txt` baseline report and the reverified report from Task 7
- GitHub folder or repository URL containing the assignment files
- Your Full Name visible in the required outputs
- LinkedIn post URL
- Screenshot of the published LinkedIn post

Submit only a Google Doc link.

Add the GitHub URL inside the Google Doc.

Follow the Assignment Submission Guidelines.

---

# Completion Checklist

- [ ] Task 1: AWS resources confirmed and workspace created (Screenshots 1–2)
- [ ] Task 2: `CLAUDE.md` created with project context and safety rules (Screenshot 3)
- [ ] Task 3: Claude produced a read-only five-check audit plan before any script existed (Screenshot 4)
- [ ] Task 4: `aws-audit.sh` built, executable, and passes `bash -n` (Screenshots 5–7)
- [ ] Task 5: Baseline audit captured and saved with Full Name visible (Screenshots 8–9)
- [ ] Task 6: `/aws-audit` skill loads and runs successfully with no Write permission (Screenshots 10–11)
- [ ] Task 7: A real finding was fixed by you and reverified as PASS (Screenshots 12–13)
- [ ] Skill never executed a remediation command
- [ ] New security group rule is scoped to your own IP, not `0.0.0.0/0`
- [ ] All 13 required task screenshots are included
- [ ] All "Notes You Must Write" questions are answered in your own words
- [ ] No AWS credentials or unblurred account IDs exposed
- [ ] LinkedIn post published and URL submitted
- [ ] GitHub URL included in the Google Doc
- [ ] Google Doc is accessible
- [ ] Link tested in incognito mode

---

# Final Submission

Submit only your Google Doc link.

### Question

Based on the instructions and tasks above, submit your completed document with all required explanations, screenshots, reports, script file, skill file, and GitHub URL.

`Add your Google Doc link here`

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
