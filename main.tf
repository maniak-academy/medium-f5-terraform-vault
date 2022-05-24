terraform {
  required_providers {
    bigip = {
      source  = "F5Networks/bigip"
      version = "1.13.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.5.0"
    }
  }
}

module "app" {
  source       = "./app"
  tenant       = "local-demo"
  vip_address  = "10.99.99.10"
  common_name  = "test.example.com"
  pki_name     = "example-dot-com"
  pool_members = ["10.10.0.1", "10.10.0.2"]
}

provider "vault" {
  address = var.vaultaddress
  token   = var.vault_token
}

provider "bigip" {
  address  = var.bigipmgmt
  username = var.bigipmgmtuser
  password = var.bigippass
}

