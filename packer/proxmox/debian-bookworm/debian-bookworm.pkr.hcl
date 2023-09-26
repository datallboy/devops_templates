# Debian Bookworm Template
# ---
# Packer Template to create a Debian Bookworm server on Proxmox

# Variables
variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "proxmox_skip_tls_verify" {
    type = string
}

variable "proxmox_node" {
    type = string
}

variable "proxmox_network_adapter_bridge" {
    type = string
}

variable "proxmox_storage" {
    type = string
    default = "local"
}

# Resource Definition for the VM template
source "proxmox-iso" "debian-bookworm" {
    
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    # (Optional) Skip TLS Verification
    insecure_skip_tls_verify = "${var.proxmox_skip_tls_verify}"

    # VM General Settings
    node = "${var.proxmox_node}"
    vm_id = "1001"
    vm_name = "debian-bookworm"
    template_description = "Debian Bookworm Image"

    # ISO Settings
    iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.1.0-amd64-netinst.iso"
    iso_checksum = "9da6ae5b63a72161d0fd4480d0f090b250c4f6bf421474e4776e82eea5cb3143bf8936bf43244e438e74d581797fe87c7193bbefff19414e33932fe787b1400f"
    iso_storage_pool = "local"
    unmount_iso = true

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size = "20G"
        format = "raw"
        storage_pool = "${var.proxmox_storage}"
        type = "virtio"
    }

    # VM CPU Setings
    cores = "1"

    # VM Memory Settings
    memory = "2048"

    # VM Network Settings
    network_adapters {
        model = "virtio"
        bridge = "${var.proxmox_network_adapter_bridge}"
        firewall = "false"
    }

    # VM Cloud-init Settings
    cloud_init = true
    cloud_init_storage_pool = "${var.proxmox_storage}"

    # Packer Boot Commands
    boot_command = ["<esc><wait>auto url=http://10.65.66.2:{{ .HTTPPort }}/preseed.cfg<enter>"]
    boot_wait = "10s"

    # Packer Autoinstall Settings
    http_directory = "http"
    http_bind_address = "0.0.0.0"

    # SSH Settings
    ssh_username = "packer"
    ssh_password = "packer"
    ssh_timeout = "60m"
} 

# Build Definition to create the VM template
build {
    
    name = "debian-bookworm"
    sources = ["source.proxmox-iso.debian-bookworm"]

    # Provisioning the VM template for Cloud-init Integration in Proxmox
    provisioner "shell" {
        execute_command = "echo 'packer'|{{.Vars}} sudo -S -E bash '{{.Path}}'"
        inline = [
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo apt install -y cloud-init",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo sync"
        ]
    }

    provisioner "file" {
        source = "files/99-pve.cfg"
        destination = "/tmp/99-pve.cfg"
    }

    provisioner "shell" {
        execute_command = "echo 'packer'|{{.Vars}} sudo -S -E bash '{{.Path}}'"
        inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
    }
}