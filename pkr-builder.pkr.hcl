build {
  sources = ["source.qemu.iso"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts         = ["scripts/rc_local.sh", "scripts/apt.sh", "scripts/sshd.sh"]
  }

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["scripts/update.sh", "scripts/reboot.sh"]
  }

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    pause_before    = "1m0s"
    scripts         = ["scripts/vagrant.sh", "scripts/motd.sh", "scripts/cleanup.sh"]
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
