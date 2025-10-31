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
