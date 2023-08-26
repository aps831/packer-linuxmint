packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
  }
}

variable "_comment" {
  type    = string
  default = "Variables below should be overridden in template"
}

variable "boot_command_prefix" {
  type    = string
  default = "TBD"
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

variable "vagrantfile_template" {
  type    = string
  default = "TBD"
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

source "virtualbox-iso" "iso" {
  boot_command         = ["${var.boot_command_prefix}", "set gfxpayload=keep<enter>", "linux /casper/vmlinuz ", "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed} ", "boot=casper ", "initrd=/casper/initrd.lz ", "debug-ubiquity ", "automatic-ubiquity ", "noprompt ", "-- <enter>", "initrd /casper/initrd.lz<enter>", "boot<enter>"]
  cpus                 = "4"
  disk_size            = "${var.disk_size}"
  gfx_controller       = "vmsvga"
  gfx_vram_size        = "32"
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu22_LTS_64"
  hard_drive_interface = "sata"
  headless             = "${var.headless}"
  http_directory       = "http"
  iso_checksum         = "${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "8192"
  post_shutdown_delay  = "30s"
  shutdown_command     = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password         = "${var.ssh_password}"
  ssh_username         = "${var.ssh_username}"
  ssh_wait_timeout     = "10000s"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]]
  vm_name              = "${var.vm_name}"
}

build {
  sources = ["source.virtualbox-iso.iso"]

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

  post-processor "vagrant" {
    keep_input_artifact  = false
    compression_level    = "9"
    output               = "box/{{ .Provider }}/${var.vm_name}-${var.version}.box"
    vagrantfile_template = "${var.vagrantfile_template}"
  }
}
