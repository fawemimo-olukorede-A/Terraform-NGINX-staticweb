# Terraform Linux & Windows VM Deployment with Networking

## Project Overview
This project provisions **Azure Linux and Windows Virtual Machines** using **Terraform** and sets up networking components like Virtual Network (VNet), Network Security Groups (NSG), Network Interfaces (NIC), and Public IPs. The Linux VM is configured to install **Nginx** and serve a static website with a simple form.

## Features
- **Automated Infrastructure Deployment**: Uses Terraform modules for modular and reusable code.
- **Linux VM with Nginx**: Installs Nginx and deploys a static website.
- **Windows VM Support**: Deploys a Windows virtual machine.
- **Secure Networking**: Configures NSG, VNet, NIC, and Public IP.
- **User-Friendly UI**: The static website includes a form with fields for Name, Email, and Phone Number.

## Technologies Used
- **Terraform** (Infrastructure as Code)
- **Azure Virtual Machines** (Compute)
- **Azure Networking** (VNet, NSG, NIC, Public IP)
- **Nginx** (Web Server for Linux VM)
- **HTML, CSS, JavaScript** (Frontend for Static Website)

## File Structure
```
├── modules
│   ├── linux
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── install_nginx.sh  # Shell script for Nginx setup
│   ├── windows
│   │   ├── main.tf
│   │   ├── variables.tf
│   ├── networking
│   │   ├── vnet
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   ├── nsg
│   │   │   ├── nsg.tf
│   │   │   ├── variables.tf
│   │   ├── nic
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   ├── publicip
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
├── backend.tf
├── env.yaml
├── locals.tf
├── modules.tf
├── provider.tf
├── variables.tf
├── README.md
```

## Deployment Steps
### **1. Prerequisites**
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An active **Azure Subscription**

### **2. Clone the Repository**
```bash
git clone https://github.com/your-repo-name.git
cd your-repo-name
```

### **3. Configure Terraform Variables**
Edit the `terraform.tfvars` file (if applicable) to match your Azure environment.

### **4. Initialize Terraform**
```bash
terraform init
```

### **5. Validate Terraform Configuration**
```bash
terraform validate
```

### **6. Deploy Infrastructure**
```bash
terraform apply -auto-approve
```

### **7. Access the Website (Linux VM)**
Once deployment is complete, retrieve the **public IP address**:
```bash
echo "http://$(terraform output public_ip)"
```
Open the link in a browser to view the static form.

## Cleanup
To destroy all resources:
```bash
terraform destroy -auto-approve
```

## Author
Olukorede Fawemimo
