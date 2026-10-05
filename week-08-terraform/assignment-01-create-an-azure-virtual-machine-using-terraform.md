# Assignment 1 — Create an Azure Virtual Machine using Terraform

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will use Terraform to provision a complete Azure Virtual Machine environment, including a resource group, virtual network, subnet, public IP, network interface, and a Linux-based virtual machine. You will set up and verify the required local tools, define the infrastructure in Terraform, initialize the project, review and apply the plan, verify the running VM through Azure CLI, capture the public IP output, and destroy the resources after testing.

---

# Task 0 — Set Up and Verify the Terraform and Azure CLI Environment

## Goal

Prepare your local environment for Terraform deployment by installing Terraform, Azure CLI, and the HashiCorp Terraform extension in VS Code, signing in to your Azure account, and confirming that all required tools are working correctly.

### Evidence

#### Screenshot 1 — Terminal showing successful `terraform version` output

<img width="959" height="305" alt="01-terraform-version" src="https://github.com/user-attachments/assets/8e7d5873-99e0-4444-92ca-fe257608d03b" />

---

#### Screenshot 2 — Terminal showing successful `az version` output

<img width="959" height="313" alt="02-azure-cli-version" src="https://github.com/user-attachments/assets/2d845ea5-a1db-4c7b-ab70-a4220452e94a" />

---

#### Screenshot 3 — VS Code Extensions panel showing the HashiCorp Terraform extension installed and enabled

<img width="959" height="464" alt="03-hashicorp-terraform-extension" src="https://github.com/user-attachments/assets/7d40c231-23bb-4207-a3af-406bf07afc77" />

---

# Task 1 — Create a New Terraform Project and Define the Infrastructure

## Goal

Create a new Terraform project and define the complete Azure Virtual Machine environment in `main.tf` by using the official Terraform Registry documentation.

### Evidence

#### Screenshot 4 — VS Code showing the AzureRM provider configuration and resource group configuration in `main.tf`

<img width="731" height="503" alt="04-terraform-provider-resource-group" src="https://github.com/user-attachments/assets/b03a9bf4-cec8-4ab2-a8b9-2333f4ce225d" />

---

#### Screenshot 5 — VS Code showing the Linux virtual machine configuration and public IP `output` block in `main.tf`. Ensure that the VM password is hidden or redacted

<img width="734" height="490" alt="05-linux-vm-public-ip-output" src="https://github.com/user-attachments/assets/7ccc29e1-53e1-43f1-b8a9-ca4e4fb1810c" />

---

# Task 2 — Initialize Terraform

## Goal

Initialize the Terraform working directory and download the required provider components.

### Evidence

#### Screenshot 6 — Terminal showing the successful `terraform init` output

<img width="894" height="434" alt="06-terraform-init-success" src="https://github.com/user-attachments/assets/db6acfd9-d09f-47e7-9214-5828f4e8be16" />

---

# Task 3 — Plan and Apply the Configuration

## Goal

Review the Terraform execution plan and provision the Azure resources.

### Evidence

#### Screenshot 7 — Terraform plan summary showing the proposed resources

<img width="956" height="520" alt="07-terraform-plan" src="https://github.com/user-attachments/assets/2ec4e664-af21-462e-9b26-78ec756209ec" />

---

#### Screenshot 8 — Terraform apply output showing successful completion

<img width="956" height="521" alt="08-terraform-apply-success" src="https://github.com/user-attachments/assets/d4666b4c-c604-4159-8016-b52cd4069f19" />

---

#### Screenshot 9 — Terraform output showing the public IP address of the VM

<img width="959" height="249" alt="09-terraform-public-ip" src="https://github.com/user-attachments/assets/f2e5b155-f095-4cf0-bad4-0e649ff2be04" />

### Question

VM Public IP Address: [Enter the public IP shown by terraform output]

---

# Task 4 — Verify the Deployment

## Goal

Confirm through Azure CLI that the virtual machine was created successfully and is currently running.

### Evidence

#### Screenshot 10 — Azure CLI output showing the deployed VM name and `VM running` status

<img width="919" height="202" alt="10-azure-vm-running" src="https://github.com/user-attachments/assets/ea4fe303-0a51-4d74-94bc-5fc3e8c0b1e2" />

---

# Task 5 — Destroy the Resources

## Goal

Remove all Azure resources created by Terraform after completing the deployment and verification.

### Evidence

#### Screenshot 11 — Terminal showing successful `terraform destroy` completion

<img width="959" height="502" alt="11-terraform-destroy-success" src="https://github.com/user-attachments/assets/b565085a-b4d6-47aa-be5c-80e2546fee3b" />

---

# Task 6 — Share Your Terraform Progress on WhatsApp

## Goal

Share your Terraform deployment progress on WhatsApp by using Screenshot 8, the provided Terraform caption, and your generated DMI Leaderboard progress link.

### Evidence

#### Screenshot 12 — Published WhatsApp Status showing your Terraform deployment progress and DMI Leaderboard progress link

<img width="620" height="329" alt="12-whatsapp-terraform-progress" src="https://github.com/user-attachments/assets/aec82c90-e176-42f2-be42-f2d8b0b1f22b" />

> Ensure that no passwords, account IDs, subscription IDs, private phone numbers, or personal messages are visible.

---

# Submission Instructions

- Complete all tasks in sequence and include all required screenshots specified in Tasks 0–6.
- Do not expose passwords, keys, account IDs, or other sensitive information in screenshots.

---

# Completion Checklist

- Installed Terraform and verified it using `terraform version`
- Installed Azure CLI and verified it using `az version`
- Signed in to Azure using `az login`
- Confirmed the correct Azure subscription
- Installed and enabled the HashiCorp Terraform extension in VS Code
- Created the `terraform-azure-vm` project directory and `main.tf`
- Added the Terraform and AzureRM provider configuration
- Defined the resource group, virtual network, subnet, public IP, and network interface
- Defined the Linux virtual machine with username and password-based authentication
- Added the Terraform output for the VM public IP address
- Completed `terraform init` successfully
- Reviewed the Terraform execution plan using `terraform plan`
- Completed `terraform apply` successfully
- Captured and recorded the VM public IP using `terraform output`
- Verified that the VM is running using Azure CLI
- Completed `terraform destroy` successfully
- Shared Terraform deployment progress on WhatsApp by following Task 6
- Captured a screenshot of the published WhatsApp Status
- Captured all required screenshots
- Checked that no passwords, keys, account IDs, or other sensitive information are visible in the screenshots

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

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*
