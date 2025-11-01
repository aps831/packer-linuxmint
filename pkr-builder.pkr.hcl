locals {
  nix_environment_vars = ["HOME_DIR=/home/vagrant"]
  nix_execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
}

# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.qemu.vm"]

  # Linux Shell scripts
  # Install updates and reboot
  provisioner "shell" {
    environment_vars  = local.nix_environment_vars
    execute_command   = local.nix_execute_command
    expect_disconnect = true
    pause_before      = "10s"
    scripts           = ["${path.root}/scripts/update_packages.sh", ]
    valid_exit_codes  = [0, 143]
  }
  provisioner "shell" {
    inline = [
      "echo 'After reboot'"
    ]
    pause_after = "10s"
  }
  # Run common scripts and guest tools installation
  provisioner "shell" {
    environment_vars  = local.nix_environment_vars
    execute_command   = local.nix_execute_command
    expect_disconnect = true
    pause_before      = "10s"
    scripts           = [
      "${path.root}/scripts/vagrant.sh",
      "${path.root}/scripts/sshd.sh"
    ]
  }
  provisioner "shell" {
    inline = [
      "echo 'After reboot'"
    ]
    pause_after = "10s"
  }
  # Run OS specific scripts
  provisioner "shell" {
    environment_vars  = local.nix_environment_vars
    execute_command   = local.nix_execute_command
    expect_disconnect = true
    pause_before      = "10s"
    scripts           = [
      "${path.root}/scripts/networking.sh",
      "${path.root}/scripts/sudoers.sh",
      "${path.root}/scripts/systemd.sh",
      "${path.root}/scripts/cleanup.sh"
    ]
  }
  post-processors {

    post-processor "vagrant" {
      keep_input_artifact  = false
      vagrantfile_template =  null
      compression_level    = "9"
      output               = "box/{{ .Provider }}/${var.os_name}-${var.os_version}-${var.os_arch}.{{ .Provider }}.box"
    }

    post-processor "vagrant-cloud" {
      box_tag             = "${var.box_tag}"
      access_token        = "${var.cloud_token}"
      version             = "${var.box_version}"
      version_description = "${var.os_version_description}"
    }

  }
}
