terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "nexvion_config" {
  filename = "${path.module}/nexvion-infrastructure.txt"

  content = <<EOT
Nexvion DevOps Capstone
========================
Application: Nexvion
Environment: Kubernetes
Namespace: nexvion
Replicas: 2
Container Port: 80
Service Type: NodePort
NodePort: 30080
Docker Image: meghanas12345/nexvion:4
Managed By: Terraform
EOT
}
