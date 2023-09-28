variable "proxmox_target_node" {
    type = string
}

variable "cloudinit_username" {
    type = string
}

variable "cloudinit_password" {
    type = string
    sensitive = true
}

variable "ssh_keys" {
    type = string
}

variable "vm_name" {
    default = "k3s"
}

variable "vm_count" {
    default = 5
}

variable "vm_cpu_cores" {
    default = 2
}

variable "vm_cpu_sockets" {
    default = 1
}

variable "vm_cpu" {
    default = "host"
}

variable "vm_memory" {
    default = 4096
}

variable "vm_network_bridge" {
    default = "vmbr1"
}

variable "vm_network_tag" {
    default = 20
}

variable "clone" {
    default = "debian-bookworm"
}

resource "proxmox_vm_qemu" "k3s-cluster" {
    
    # VM General Settings
    count = var.vm_count
    name = "${var.vm_name}-0${count.index + 1}"
    target_node = var.proxmox_target_node

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = var.clone

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = var.vm_cpu_cores
    sockets = var.vm_cpu_sockets
    cpu = var.vm_cpu  
    
    # VM Memory Settings
    memory = var.vm_memory

    # VM Network Settings
    network {
        bridge = var.vm_network_bridge
        model  = "virtio"
        tag = var.vm_network_tag
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    ipconfig0 = "ip=10.100.20.${count.index + 10}/24,gw=10.100.20.1"
    
    # (Optional) Default User
    ciuser = var.cloudinit_username
    cipassword = var.cloudinit_password
    
    # (Optional) Add your SSH KEY
    sshkeys = <<EOF
    ${var.ssh_keys}
    EOF
}