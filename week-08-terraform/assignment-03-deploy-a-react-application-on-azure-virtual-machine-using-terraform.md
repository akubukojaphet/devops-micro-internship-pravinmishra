# Assignment 3 — Deploy a React Application on Azure Using Terraform

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will use Terraform to provision the required Azure infrastructure and automatically deploy the `my-react-app` React application on an Azure Linux virtual machine using a `cloud-init.sh` deployment script passed to the VM through `custom_data`.

You will verify the automated deployment through SSH, confirm that Nginx is running, access the React application through the VM public IP, and destroy the Terraform-managed resources after testing.

---

# Task 0 — Set Up and Verify the Terraform and Azure CLI Environment

## Goal

Prepare your local environment for Terraform deployment by installing Terraform, Azure CLI, and the HashiCorp Terraform extension in VS Code, signing in to your Azure account, and confirming that all required tools are working correctly.

## Evidence

### Screenshot 1 — Terraform Version

Add a screenshot of the terminal showing successful `terraform version` output.

<img width="959" height="305" alt="01-terraform-version" src="https://github.com/user-attachments/assets/5300b389-2203-421c-9182-b7a7bba85250" />

---

### Screenshot 2 — Azure CLI Version

Add a screenshot of the terminal showing successful `az version` output.

<img width="1917" height="625" alt="image" src="https://github.com/user-attachments/assets/f2953bc5-e24e-4b9f-b1d6-8d0705d4230f" />

---

### Screenshot 3 — HashiCorp Terraform Extension

Add a screenshot of the VS Code Extensions panel showing the HashiCorp Terraform extension installed and enabled.

<img width="1918" height="927" alt="image" src="https://github.com/user-attachments/assets/cd7fabd1-253d-4b67-aeee-eb338b24fa1a" />

---

# Task 1 — Create a New Terraform Project and Define the Infrastructure

## Goal

Create a new Terraform project and define the complete Azure infrastructure required to host the React application using the official Terraform Registry documentation.

The `terraform-react-azure` project must contain:

```text
terraform-react-azure/
├── main.tf
└── cloud-init.sh
```

The Terraform configuration must include:

- Terraform and AzureRM provider configuration
- Resource group
- Virtual network and subnet
- Network Security Group
- SSH rule for TCP port `22`
- HTTP rule for TCP port `80`
- Public IP address
- Network interface
- Linux virtual machine
- `custom_data` configuration referencing `cloud-init.sh`
- Public IP output

The `cloud-init.sh` file must contain the complete automated React application deployment workflow based on the repository instructions.

## Evidence

### Screenshot 4 — Provider, Resource Group, and Network Security Group

Add a screenshot of VS Code showing the AzureRM provider, resource group, and Network Security Group configuration in `main.tf`.

<img width="959" height="506" alt="Screenshot 4 — Provider, Resource Group, and Network Security Group" src="https://github.com/user-attachments/assets/a2c4d661-0036-4b28-90d3-527ae850304c" />

---

### Screenshot 5 — Linux Virtual Machine and `custom_data`

Add a screenshot of VS Code showing the Linux virtual machine configuration, including the `custom_data` configuration, in `main.tf`.

Ensure that passwords, private keys, account IDs, access tokens, and other sensitive information are hidden.

<img width="958" height="505" alt="05-linux-vm-custom-data" src="https://github.com/user-attachments/assets/40b45f02-ef3e-484d-b7af-a81a51d606fc" />

---

### Screenshot 6 — Completed `cloud-init.sh`

Add a screenshot of VS Code showing the completed `cloud-init.sh` deployment script.

Ensure that no passwords, Azure credentials, access tokens, SSH private keys, or other sensitive information are visible.

<img width="957" height="464" alt="Screenshot 2026-10-06 010025" src="https://github.com/user-attachments/assets/eb19ef35-d852-43ba-9a77-a017ab8b987c" />

---

### Screenshot 7 — Public IP Output Block

Add a screenshot of VS Code showing the public IP `output` block in `main.tf`.

<img width="955" height="463" alt="07-public-ip-output" src="https://github.com/user-attachments/assets/04123db4-632d-4490-8f79-c8cf9e1c3076" />

---

# Task 2 — Initialize Terraform

## Goal

Initialize the Terraform working directory and download the required provider components.

## Evidence

### Screenshot 8 — Terraform Initialization

Add a screenshot of the terminal showing successful `terraform init` output.

<img width="956" height="482" alt="08-terraform-init" src="https://github.com/user-attachments/assets/de99babb-6d5c-46f9-9d8a-8755042c69e8" />

---

# Task 3 — Plan and Apply the Configuration

## Goal

Review the Terraform execution plan and provision the Azure infrastructure.

## Evidence

### Screenshot 9 — Terraform Plan

Add a screenshot showing the Terraform plan summary and the proposed resources.

<img width="957" height="519" alt="09-terraform-plan" src="https://github.com/user-attachments/assets/98cab848-92a8-40f8-8c05-797c4c05793c" />

---

### Screenshot 10 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

<img width="958" height="505" alt="10-terraform-apply" src="https://github.com/user-attachments/assets/fed639d0-8b43-405e-ac03-c0e4e40f6c1c" />

---

### Screenshot 11 — VM Public IP Output

Add a screenshot showing the VM public IP address returned by `terraform output`.

<img width="1902" height="571" alt="image" src="https://github.com/user-attachments/assets/001ae732-3ae7-4537-bf86-3fd69323adbb" />

## VM Public IP Address

Record the public IP address displayed by `terraform output`.

**VM Public IP Address:** Add the VM public IP address here

---

# Task 4 — Verify the Automated Deployment

## Goal

Connect to the Azure Linux virtual machine and confirm that the cloud-init/user data deployment script completed successfully.

## Evidence

### Screenshot 12 — SSH Connection and Completed React Deployment

Add a screenshot of SSH terminal showing successful connection to the Azure VM and evidence that the React application deployment completed such as the deployed files in `/var/www/html` or successful cloud-init output.

<img width="1900" height="1007" alt="image" src="https://github.com/user-attachments/assets/162e19ca-11eb-437a-80a1-3e17085abe6a" />

---

### Screenshot 13 — Nginx Service Status

Add a screenshot of the terminal showing that the Nginx service is running successfully.

<img width="1915" height="757" alt="image" src="https://github.com/user-attachments/assets/e26dbd3e-53b5-4f8b-ac76-d3164c4a1ca0" />

---

# Task 5 — Verify the React Application Deployment

## Goal

Confirm that the automatically deployed React application is publicly accessible and functioning correctly.

## Evidence

### Screenshot 14 — React Application in the Browser

Add a screenshot of the browser showing the deployed React application successfully loaded using the Azure VM public IP.

Ensure that the Azure VM public IP is visible in the browser address bar.

<img width="1918" height="864" alt="image" src="https://github.com/user-attachments/assets/6d0d537b-5ae5-4499-84f4-2a4786e06a22" />

---

# Task 6 — Destroy the Resources

## Goal

Remove all Azure resources created by Terraform after completing the application deployment and verification.

## Evidence

### Screenshot 15 — Terraform Destroy

Add a screenshot of the terminal showing successful `terraform destroy` completion.

<img width="1911" height="1027" alt="image" src="https://github.com/user-attachments/assets/6a31949b-0692-45bd-82da-7d7dbf3885a5" />

---

# Task 7 — Share Your Deployment Progress on LinkedIn

## Goal

Share your React application deployment progress and DMI Leaderboard link on LinkedIn.

## Steps

1. Open the DMI Leaderboard and find your name.
2. Select **Share your progress**.
3. Select the **LinkedIn** option.
4. Use the generated message containing your leaderboard rank and personal progress link.
5. Attach **Screenshot 14** showing your React application running in the browser.
6. Add this caption:

```text
Just deployed a React application on an Azure Virtual Machine using Terraform! ☁️

I provisioned the Azure infrastructure with Terraform and automated the React application deployment using cloud-init Custom Data and Nginx.

Check my DMI learning progress below. 🚀
```

7. Publish the post on LinkedIn.

## Evidence

### Screenshot 16 — LinkedIn Post

Add a screenshot of your published LinkedIn post showing:

- The React application deployment screenshot
- The generated DMI Leaderboard message
- Your personal DMI progress link

Ensure that no passwords, private keys, account IDs, access tokens, or other sensitive information are visible.

<img width="1918" height="1123" alt="image" src="https://github.com/user-attachments/assets/0f703999-4bf1-4e6d-99cd-b500f1012bbf" />

---

# Submission Instructions

- Complete Tasks 0–7 in sequence.
- Include all 16 required screenshots exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Record the VM public IP address under Task 3.
- Ensure that the submitted evidence clearly matches the required task outputs.
- Include `main.tf` and `cloud-init.sh` in your GitHub submission.
- Do not expose passwords, SSH private keys, account IDs, access tokens, Azure credentials, or other sensitive information.
- Do not store secrets inside `cloud-init.sh`.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [ ] Installed Terraform and verified it using `terraform version`
- [ ] Installed Azure CLI and verified it using `az version`
- [ ] Signed in to Azure and confirmed the correct subscription
- [ ] Installed and enabled the HashiCorp Terraform extension in VS Code
- [ ] Created the `terraform-react-azure` project
- [ ] Created `main.tf`
- [ ] Defined the Terraform and AzureRM provider configuration
- [ ] Defined the resource group
- [ ] Defined the virtual network and subnet
- [ ] Defined the Network Security Group
- [ ] Configured SSH and HTTP rules
- [ ] Defined the public IP and network interface
- [ ] Created `cloud-init.sh`
- [ ] Reviewed the React application repository instructions
- [ ] Created the complete deployment workflow inside `cloud-init.sh`
- [ ] Defined the Linux virtual machine
- [ ] Connected `cloud-init.sh` to the VM using `custom_data`
- [ ] Used `file()` and `base64encode()` correctly
- [ ] Added the Terraform public IP output
- [ ] Completed `terraform init` successfully
- [ ] Reviewed the Terraform execution plan
- [ ] Completed `terraform apply` successfully
- [ ] Recorded the VM public IP
- [ ] Connected to the VM through SSH
- [ ] Verified that the automated deployment completed successfully
- [ ] Verified that Nginx is running
- [ ] Verified the React application through the browser
- [ ] Completed `terraform destroy` successfully
- [ ] Shared the React application deployment progress on LinkedIn by following Task 7
- [ ] Captured all 16 required screenshots
- [ ] Confirmed that my full name is visible in the required screenshots
- [ ] Checked that no passwords, keys, account IDs, access tokens, or other sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- React Application Repository: [https://github.com/pravinmishraaws/my-react-app](https://github.com/pravinmishraaws/my-react-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
