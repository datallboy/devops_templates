terraform {
    required_version = ">= 0.13.0"

    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.3"
        }
    }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type        = string
    sensitive   = true
}

variable "proxmox_api_token_secret" {
    type        = string
    sensitive   = true
}

variable "pm_parallel" {
    type        = number
    description = "The number of simultaneous Proxmox process. E.g: creating resources"
    default     = 2
}

variable "pm_timeout" {
    type        = number
    description = "Timeout value (seconds) for Proxmox API calls."
    default     = 600
}

provider "proxmox" {
    pm_api_url          = var.proxmox_api_url
    pm_api_token_id     = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
    pm_parallel         = var.pm_parallel
    pm_timeout          = var.pm_timeout

    # (Optional) Skip TLS Verification
    pm_tls_insecure = true
}