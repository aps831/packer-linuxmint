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
