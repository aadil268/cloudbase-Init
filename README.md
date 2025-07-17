# Terraform: Azure Windows VM with Cloudbase-Init

This project provisions a Windows Virtual Machine in Azure using Terraform, and configures it to run a PowerShell script at first boot via **Cloudbase-Init**.

---

## 📁 Project Structure

```

.
├── main.tf                     # Terraform configuration
├── variables.tf                # Input variables
├── terraform.tfvars            # Sensitive values (ignored by git)
├── cloudinit.ps1               # PowerShell test script to run post-deployment
├── install-cloudbase-init.ps1  # PowerShell script to download CloudBase-Init and PowerShell test script
├── cloudbase-init-unattend.xml # Cloudbase-Init configuration for FirstLogon
├── README.md                   # Readme File
└── .gitignore                  # Git ignore rules

````

---

## 🚀 Features

- Provision Windows Server 2022 VM on Azure
- Download and Install Cloudbase-Init on VM
- Install and execute a PowerShell script at first boot using Cloudbase-Init
- Secure configuration via `terraform.tfvars`
- Storage account, virtual network, subnet, and NIC auto-created

---

## 🔧 Usage

### 1. Configure your variables

Update `terraform.tfvars` with your Azure subscription ID and desired settings:

```hcl
subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
````

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the plan

```bash
terraform plan
```

### 4. Apply the configuration

```bash
terraform apply
```

---

## 📜 Requirements

* Terraform CLI ≥ 1.0
* Azure CLI authenticated (`az login`)

---

## 🔒 Security

Ensure `terraform.tfvars` is excluded from version control:

```
terraform.tfvars
```

---

## 📄 License

MIT License