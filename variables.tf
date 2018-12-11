variable "public_key" {
  default     = "~/.ssh/id_rsa.pub"
  description = "public SSH key to use in keypair"
}

variable "ssh_label" {
  default = "ssh_logdna"
}

variable notes {
  default = "for logdna test"
}

variable osref_ubuntu {
  default = "UBUNTU_16_64"
}

variable osref_rhel {
  default = "REDHAT_7_64"
}

variable domain {
  default = "ibm.com"
}

variable datacenter {
  default = "dal10"
}

variable hostname_ubuntu {
  default = "logdna-ubuntu"
}

variable hostname_rhel {
  default = "logdna-rhel"
}

variable logdna_name {
  default = "my-logdna"
}

variable logdna_plan {
  default = "lite"
}

variable rhel_ingestion {}

variable ubuntu_ingestion {}

variable rhel_api_host {}

variable rhel_log_host {}

variable rhel_log_path {}

variable rhel_tag {}

variable ubuntu_api_host {}

variable ubuntu_log_host {}

variable ubuntu_log_path {}

variable ubuntu_tag {}

variable ssh_private_key {
  default = "~/.ssh/id_rsa"
}
