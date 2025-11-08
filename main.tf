terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

provider "proxmox" {
  pm_debug            = true
  pm_tls_insecure     = true
  pm_api_url          = local.envs["PM_API_URL"]
  pm_api_token_id     = local.envs["PM_API_TOKEN_ID"]
  pm_api_token_secret = local.envs["PM_API_TOKEN_SECRET"]
}

variable "vm_name" {}
variable "cpu" {}
variable "memory" {}

resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  target_node = "pve01"
  clone       = "vm-xs-ubuntu-24.04"
  full_clone  = true
  memory      = var.memory
  cpu {
    cores = var.cpu
  }
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }
}
