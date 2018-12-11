resource "ibm_resource_instance" "instance" {
  name     = "${var.logdna_name}"
  service  = "logdna"
  plan     = "${var.logdna_plan}"
  location = "us-south"
}

resource "ibm_compute_ssh_key" "ssh_public_key_for_logdna" {
  label      = "${var.ssh_label}"
  notes      = "${var.notes}"
  public_key = "${file("${var.public_key}")}"
}

resource "ibm_compute_vm_instance" "logdna_rhel" {
  hostname                 = "${var.hostname_rhel}"
  os_reference_code        = "${var.osref_rhel}"
  domain                   = "${var.domain}"
  datacenter               = "${var.datacenter}"
  network_speed            = "10"
  hourly_billing           = true
  private_network_only     = false
  cores                    = "1"
  memory                   = "1024"
  disks                    = ["25"]
  dedicated_acct_host_only = true
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.ssh_public_key_for_logdna.id}"]

  provisioner "remote-exec" {
    inline = [
      "sudo rpm --import https://repo.logdna.com/logdna.gpg",
      "echo -e \"[logdna]\nname=LogDNA packages\nbaseurl=https://repo.logdna.com/el6/\nenabled=1\ngpgcheck=1\ngpgkey=https://repo.logdna.com/logdna.gpg\" | sudo tee /etc/yum.repos.d/logdna.repo",
      "sudo yum -y install logdna-agent",
      "sudo logdna-agent -k ${var.rhel_ingestion}",
      "logdna-agent -s LOGDNA_APIHOST=${var.rhel_api_host}",
      "logdna-agent -s LOGDNA_LOGHOST=${var.rhel_log_host}",
      "sudo logdna-agent -d ${var.rhel_log_path}",
      "sudo logdna-agent -t ${var.rhel_tag}",
      "sudo chkconfig logdna-agent on",
      "sudo service logdna-agent start",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_private_key}")}"
    }
  }
}

resource "ibm_compute_vm_instance" "logdna_ubuntu" {
  hostname                 = "${var.hostname_ubuntu}"
  os_reference_code        = "${var.osref_ubuntu}"
  domain                   = "${var.domain}"
  datacenter               = "${var.datacenter}"
  network_speed            = "10"
  hourly_billing           = true
  private_network_only     = false
  cores                    = "1"
  memory                   = "1024"
  disks                    = ["25"]
  dedicated_acct_host_only = true
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.ssh_public_key_for_logdna.id}"]

  provisioner "remote-exec" {
    inline = [
      "echo \"deb https://repo.logdna.com stable main\" | sudo tee /etc/apt/sources.list.d/logdna.list",
      "wget -O- https://repo.logdna.com/logdna.gpg | sudo apt-key add - ",
      "sudo apt-get update",
      "sudo apt-get install logdna-agent < \"/dev/null\"",
      "sudo logdna-agent -k ${var.ubuntu_ingestion}",
      "logdna-agent -s LOGDNA_APIHOST=${var.ubuntu_api_host}",
      "logdna-agent -s LOGDNA_LOGHOST=${var.ubuntu_log_host}",
      "sudo logdna-agent -d ${var.ubuntu_log_path}",
      "sudo logdna-agent -t ${var.ubuntu_tag}",
      "sudo update-rc.d logdna-agent defaults",
      "sudo /etc/init.d/logdna-agent start",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_private_key}")}"
    }
  }
}

output "rhel_ip" {
  value = "${ibm_compute_vm_instance.logdna_rhel.ipv4_address}"
}

output "ubuntu_ip" {
  value = "${ibm_compute_vm_instance.logdna_ubuntu.ipv4_address}"
}
