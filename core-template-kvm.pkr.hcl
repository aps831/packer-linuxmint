packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

variable "_comment" {
  type    = string
  default = "Variables below should be overridden in template"
}

variable "box_tag" {
  type    = string
  default = "TBD"
}

variable "cloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "disk_size" {
  type    = string
  default = "TBD"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "TBD"
}

variable "iso_url" {
  type    = string
  default = "TBD"
}

variable "preseed" {
  type    = string
  default = "TBD"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "version" {
  type    = string
  default = "TBD"
}

variable "version_description" {
  type    = string
  default = "TBD"
}

variable "vm_name" {
  type    = string
  default = "TBD"
}

source "qemu" "iso" {
  boot_command = [
    "<tab>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "/casper/vmlinuz ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed} ",
    "boot=casper ",
    "initrd=/casper/initrd.lz ",
    "debug-ubiquity ",
    "automatic-ubiquity ",
    "noprompt ",
    "-- <enter>",
    "initrd /casper/initrd.lz<enter>",
    "boot<enter>"
  ]
  cpus             = "4"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  accelerator      = "kvm"
  net_device       = "virtio-net"
  disk_interface   = "virtio"
  headless         = "${var.headless}"
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  memory           = "8192"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_username     = "${var.ssh_username}"
  ssh_timeout      = "10000s"
  vm_name          = "${var.vm_name}"
  boot_wait        = "5s"
}

build {
  sources = ["source.qemu.iso"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts         = ["script/rc_local.sh", "script/apt.sh", "script/sshd.sh"]
  }

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["script/update.sh", "script/reboot.sh"]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    pause_before    = "1m0s"
    scripts         = ["script/vagrant.sh", "script/motd.sh", "script/cleanup.sh"]
  }

  post-processors {

    post-processor "vagrant" {
      keep_input_artifact  = false
      compression_level    = "9"
      output               = "box/{{ .Provider }}/${var.vm_name}-${var.version}.box"
    }

    post-processor "vagrant-cloud" {
      box_tag             = "${var.box_tag}"
      access_token        = "${var.cloud_token}"
      version             = "${var.version}"
      version_description = "${var.version_description}"
    }

  }

}
