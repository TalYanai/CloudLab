**CloudLab DevOps Project**
**Overview**

CloudLab is a hands-on DevOps learning project that demonstrates the full workflow of containerizing a Python CLI application, deploying it in Azure, and automating the entire process using GitHub Actions (CI/CD).

**Technologies used:**
  Python 3 (CLI-based phonebook app)
  
  Docker
  
  Azure Container Registry (ACR)
  
  GitHub Actions (CI/CD)
  
  Terraform (Infrastructure as Code)

**DevOps Pipeline Flow**

Local Code  →  GitHub Push  →  GitHub Actions
                            →  Docker Build
                            →  Push to ACR (Azure Container Registry)
                            →  (Future: Deploy to ACI or App Service)

**Getting Started (Run Locally with Docker)
**
  git clone https://github.com/TalYanai/CloudLab.git
  cd CloudLab/Contacts
  
  docker build -t phonebook-app .
  docker run -it phonebook-app

**Project Structure**

CloudLab/
├── .github/workflows/             # GitHub Actions workflow
│   └── docker-build-push.yml
├── Contacts/                      # Python CLI phonebook app
│   ├── Dockerfile
│   ├── main.py
│   ├── phonebook.py
│   ├── contacts.py
│   └── contacts.json
├── main.tf                        # Terraform: main infrastructure config
├── variables.tf                   # Terraform: input variables
├── outputs.tf                     # Terraform: outputs
├── dev.tfvars / prod.tfvars       # Environment-specific configs
├── README.md                      # This file

**GitHub Actions CI/CD**
On each push to the main branch:

  Checkout code
  
  Log in to ACR using secrets
  
  Build Docker image from Contacts/Dockerfile
  
  Push image to ACR: cloudlabacr11103.azurecr.io/phonebook-app
  
  YAML File: .github/workflows/docker-build-push.yml

**Azure Resources
Created and managed using Terraform*:**

  Resource Group
  
  Virtual Network + Subnet
  
  Network Security Group (ports 22, 8080)
  
  Public IP
  
  Linux VM (Ubuntu)
  זז
  Azure Container Registry (ACR)


Tal Yanai – GitHub

Project created as part of a self-learning DevOps path and portfolio development.

