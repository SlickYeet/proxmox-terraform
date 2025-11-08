terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

provider "proxmox" {
  pm_debug        = true
  pm_tls_insecure = true
  pm_api_url      = "https://192.168.0.123:8006/api2/json"
}

resource "proxmox_vm_qemu" "test" {
  name        = "tf-vm-test"
  target_node = "pve01"
  clone       = "vm-xs-ubuntu-24.04"
  full_clone  = true
  memory      = 2048
  cpu {
    cores = 2
  }
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }
}
